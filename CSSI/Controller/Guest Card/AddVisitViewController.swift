//
//  AddVisitViewController.swift
//  CSSI
//
//  Created by Apple on 28/09/18.
//  Copyright © 2018 yujdesigns. All rights reserved.

import UIKit

class AddVisitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  UITextFieldDelegate,closeSuccesPopup,closeUpdateSuccesPopup{
    func closeUpdateSuccessView() {
        self.dismiss(animated: true, completion: nil)
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for popToViewController in viewControllers {
            if popToViewController is GuestCardsViewController {
                self.navigationController?.navigationBar.isHidden = false
                self.navigationController!.popToViewController(popToViewController, animated: true)
                
            }
        }
    }
    func closeSuccessView() {
        self.dismiss(animated: true, completion: nil)
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for popToViewController in viewControllers {
            if popToViewController is GuestCardsViewController {
                self.navigationController?.navigationBar.isHidden = false
                self.navigationController!.popToViewController(popToViewController, animated: true)
                
            }
        }
        
    }
    
    
    @IBOutlet weak var lblVisit: UILabel!
    @IBOutlet weak var btnSwitchSelection: UIButton!
    
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblAccompanyingGuest: UILabel!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var lblChangesWillNotAppear: UILabel!
    
    @IBOutlet weak var lblGuestPolicy: UIButton!
    
    @IBOutlet var lblBottom: UILabel!
    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet weak var txtExtendBy: UITextField!
    @IBOutlet weak var txtVisit: UITextField!
    @IBOutlet weak var singleSelectionTableView: UITableView!
    @IBOutlet weak var lblDurationErrorMessage: UILabel!
    @IBOutlet weak var lblVisitErrorMessage: UILabel!
    var buttonTitle: NSString!

    let cellReuseIdentifier = "MutlipleSelectionID"
    var guests : [Guest]? = nil
    var isFrom : NSString!
    var isFromSelection : NSString!

    var ReceiptNumber : String?
    fileprivate let dateFormator = DateFormatter()
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate
    fileprivate var dob:Date? = nil
    fileprivate var durationPicker : UIPickerView? = nil;
    fileprivate var selectedWeek: Week? = nil

    //Added on 4th July 2020
    private let accessManager = AccessManager.shared
    
    //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
    //ENGAGE0011898 -- Start
    var policyURL : String?
    var PDFTitle : String?
    //ENGAGE0011898 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // txtVisit.setRightIcon(#imageLiteral(resourceName: "icon_calendar_event"))
        //Added on 4th July 2020
        //Added roles and privilages changes
        switch self.accessManager.accessPermision(for: .guestCard) {
        case .view:
            
            if let message = self.appDelegate.masterLabeling.role_Validation2 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            
            break
        default:
            break
        }
        
        
        txtVisit.setRightIcon(imageName: "Icon_Calendar")
        txtExtendBy.setRightIcon(imageName: "Path 1847")

        dateFormator.dateFormat = "MM/dd/yyyy"
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.setDate(Date(), animated: true)
        datePicker.minimumDate = Date()
        datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: self.appDelegate.guestNumberOfday, to: Date())

        //Added on 14th October 2020 V2.3
        //Added for iOS 14 date picker change
        if #available(iOS 14.0,*)
        {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        datePicker.addTarget(self, action: #selector(didDOBDateChange(datePicker:)), for: .valueChanged)
        txtVisit.inputView = datePicker
        //datePicker
        
        lblVisitErrorMessage.text = self.appDelegate.masterLabeling.visit_Is_Required ?? "" as String
        lblDurationErrorMessage.text = self.appDelegate.masterLabeling.duration_Is_Required ?? "" as String
        lblDuration.text = self.appDelegate.masterLabeling.duration ?? "" as String
        lblVisit.text = self.appDelegate.masterLabeling.visit ?? "" as String
        lblAccompanyingGuest.text = self.appDelegate.masterLabeling.accompanying_Guest_During_Check_in ?? "" as String
        lblNo.text = self.appDelegate.masterLabeling.No ?? "" as String
        lblYes.text = self.appDelegate.masterLabeling.Yes ?? "" as String
        btnSave .setTitle(self.appDelegate.masterLabeling.sAVE, for: .normal)
        lblGuestPolicy .setTitle(self.appDelegate.masterLabeling.guest_Card_Policy_Title, for: .normal)
        lblChangesWillNotAppear.text = self.appDelegate.masterLabeling.charges_Will_Not_Appear ?? "" as String

        
        if isFromSelection .isEqual(to: "Single") {
            if isFrom .isEqual(to: "Modify") {
                txtVisit.text = String(format: "%@ - %@", (guests?.first?.fromDate)!, (guests?.first?.toDate)!)
                let previousDate = SharedUtlity.sharedHelper().dateFormatter.date(from: (guests?.first?.toDate)!)
                let now = SharedUtlity.sharedHelper().dateFormatter.date(from: (guests?.first?.fromDate)!)
                
                let components = Calendar.current.dateComponents([.weekday, .month], from: now!, to: previousDate!)
                
                let weeks = components.weekday ?? 0
                
                
                if weeks == 6  {
                    txtExtendBy.text = "1 week"
                }
                else if weeks == 13 {
                    txtExtendBy.text = "2 weeks"
                }
                else{
                    txtExtendBy.text = ""
                    
                }
                if guests?.first?.accompanyWithMainMember == 1{
                    btnSwitchSelection.setBackgroundImage(UIImage(named : "Group 1712-1"), for: UIControlState.normal)
                    btnSwitchSelection.tag = 1
                    
                }
                else{
                    btnSwitchSelection.setBackgroundImage(UIImage(named : "Group 1714"), for: UIControlState.normal)
                    btnSwitchSelection.tag = 0
                    
                }
               
            }
            else{
                self.btnSwitchSelection.isEnabled = true
                txtVisit.text = ""
                btnSwitchSelection.tag = 1
            }

            
        }
        else{
            if isFrom .isEqual(to: "Modify") {
                
                var fromDatesArray = [String]()
                for date in guests! {
                    fromDatesArray.append(date.fromDate)
                }
                var toDatesArray = [String]()
                for date in guests! {
                    toDatesArray.append(date.toDate)
                }
                let allFromDatesEqual = fromDatesArray.dropLast().allSatisfy { $0 == fromDatesArray.last }
                let allToDatesEqual = toDatesArray.dropLast().allSatisfy { $0 == toDatesArray.last }
                
                
                
                if allFromDatesEqual == true && allToDatesEqual == true {
                    txtVisit.text = String(format: "%@ - %@", (guests?.first?.fromDate)!, (guests?.first?.toDate)!)
                    let previousDate = SharedUtlity.sharedHelper().dateFormatter.date(from: (guests?.first?.toDate)!)
                   let now = SharedUtlity.sharedHelper().dateFormatter.date(from: (guests?.first?.fromDate)!)

                    let components = Calendar.current.dateComponents([.weekday, .month], from: now!, to: previousDate!)

                    let weeks = components.weekday ?? 0

                    
                    if weeks == 6  {
                        
                        txtExtendBy.text = "1 week"
                    }
                    else if weeks == 13 {
                        
                        txtExtendBy.text = "2 weeks"
                    }
                    else{
                        txtExtendBy.text = ""

                    }
                }
                else{
                    txtVisit.text = ""
                    txtExtendBy.text = ""

                }
                if guests?.first?.accompanyWithMainMember == 1{
                    btnSwitchSelection.setBackgroundImage(UIImage(named : "Group 1712-1"), for: UIControlState.normal)
                    btnSwitchSelection.tag = 1
                    
                }
                else{
                    btnSwitchSelection.setBackgroundImage(UIImage(named : "Group 1714"), for: UIControlState.normal)
                    btnSwitchSelection.tag = 0
                    
                }
            }
            else{
                txtVisit.text = ""
                self.btnSwitchSelection.isEnabled = true
                btnSwitchSelection.tag = 1
            }
            
        }
        
       
        durationPicker = UIPickerView()
        durationPicker?.delegate = self
        durationPicker?.dataSource = self
        txtExtendBy.inputView = durationPicker
        
        //Commented by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        //self.navigationItem.title = self.appDelegate.masterLabeling.tITLE_GUEST_CARD ?? "" as String
        //ENGAGE0011898 -- End
        
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
        //ENGAGE0011297 -- Start
//        let backButton = UIBarButtonItem()
//        backButton.title = self.appDelegate.masterLabeling.bACK ?? "" as String
//        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
        //ENGAGE0011297 -- End
        self.lblBottom.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)
        
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
        self.mandatoryfileds()
        
        self.btnSave.setStyle(style: .contained, type: .primary)
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    func mandatoryfileds(){
        
        let visitDate: NSMutableAttributedString = NSMutableAttributedString(string: self.lblVisit.text!)
        visitDate.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblVisit.attributedText = visitDate
        
        let duration: NSMutableAttributedString = NSMutableAttributedString(string: self.lblDuration.text!)
        duration.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblDuration.attributedText = duration
        
        
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        super.viewWillAppear(animated)
        
        self.navigationItem.title = self.appDelegate.masterLabeling.tITLE_GUEST_CARD ?? "" as String
        //ENGAGE0011898 -- End
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End

    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
    
        if textField == txtExtendBy{
            self.durationPicker?.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(durationPicker!, didSelectRow: 0, inComponent: 0)
            if isFrom == "Modify" {
            if txtVisit.text == ""{
            }
            else{
               // dob = SharedUtlity.sharedHelper()?.dateFormatter.date(from: (guests?.first?.fromDate)!)
                dob = dateFormator.date(from: (String(txtVisit.text!.prefix(10))))
               // dateFormator.string
                updateVisitDate()

            }
            }
            else{
                
            }
        }
        if  textField == txtVisit {
//            if txtVisit.text == ""{
                dob = Date()
                txtVisit.text = SharedUtlity.sharedHelper().dateFormatter.string(from: Date())
//            }
//            else{
                updateVisitDate()
//            }
        }

    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if  textField == txtVisit {
//            if txtVisit.text == ""{
//
//            }
//            else{
//                updateVisitDate()
//            }
//        }}
    
    @objc func didDOBDateChange(datePicker:UIDatePicker) {
        dob = datePicker.date
        txtVisit.text = dateFormator.string(from: datePicker.date)
        
        updateVisitDate()

    }
    
    fileprivate func updateVisitDate() {
        if let date = dob {
            var numberOfDaysToAdd = 0
//            if selectedWeek?.weak == nil{
//                selectedWeek?.weak = txtExtendBy.text
//            }
            if let datePicker = self.txtVisit.inputView as? UIDatePicker
            {
                datePicker.setDate(date, animated: false)
            }
            if selectedWeek?.weak == "1 week" || txtExtendBy.text == "1 week"{
                numberOfDaysToAdd = 6
            } else if selectedWeek?.weak == "2 weeks" || txtExtendBy.text == "2 weeks"{
                numberOfDaysToAdd = 13
            }
            
            if let dateFormatter = SharedUtlity.sharedHelper().dateFormatter,
                let toDate = Calendar.current.date(byAdding: .day , value: numberOfDaysToAdd, to: date, wrappingComponents: false),
                numberOfDaysToAdd != 0 {
                txtVisit.text = "\(dateFormatter.string(from: date)) - \(dateFormatter.string(from: toDate))"
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchSelection(_ sender: Any) {
        if btnSwitchSelection.tag == 1 {
            btnSwitchSelection.tag = 0
            btnSwitchSelection.setBackgroundImage(UIImage(named : "Group 1714"), for: UIControlState.normal)
        }else {
            btnSwitchSelection.tag = 1
            btnSwitchSelection.setBackgroundImage(UIImage(named : "Group 1712-1"), for: UIControlState.normal)
            
        }
//        if btnSwitchOnOFF.tag == 1 {
//            btnSwitchOnOFF.tag = 0
//            btnSwitchOnOFF.setBackgroundImage(UIImage(named : "Group 1714"), for: UIControlState.normal)
//        }else {
//            btnSwitchOnOFF.tag = 1
//            btnSwitchOnOFF.setBackgroundImage(UIImage(named : "Group 1712-1"), for: UIControlState.normal)
//            
//        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return guests?.count ?? 0
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CustomMultipleSelectionCell = self.singleSelectionTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CustomMultipleSelectionCell
        if let guest = guests?[indexPath.row] {
            cell.lblId.text = guest.guestMemberID
            cell.lblName.text = guest.memberName
        }
        return cell
    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if buttonTitle == "Save"{
//            textFiledsValidation()
//        }
//        else{
//            
//        }    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if buttonTitle == "Save"{
//            textFiledsValidation()
//        }
//        else{
//            
//        }
//        return true
//    }
    
//    func textFiledsValidation(){
//
//        if (txtVisit.text == "") {
//            lblVisitErrorMessage.isHidden = false
//        } else {
//            lblVisitErrorMessage.isHidden = true
//        }
//        if (txtExtendBy.text == "") {
//            lblDurationErrorMessage.isHidden = false
//        } else {
//            lblDurationErrorMessage.isHidden = true
//        }
//
//    }
    @IBAction func SwitchClicked(_ sender: Any) {
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        
        
        
        //Added on 4th July 2020 V2.2
        //Added roles adn privilages changes
        switch self.accessManager.accessPermision(for: .guestCard) {
        case .view:
            
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            
            return
        default:
            break
        }
        
        
        
        
//        buttonTitle = btnSave.titleLabel?.text as NSString?

        
//        textFiledsValidation()

        
//        if (txtVisit.text == "") || (txtExtendBy.text == ""){
//
//            return
//        }
//        guard let _ = txtVisit.text  else {
//            SharedUtlity.sharedHelper().showToast(on: view, withMeassge: "Please select Visit date.", withDuration: Duration.kShortDuration)
//            return
//        }
//
//        guard let _ = selectedWeek else {
//            SharedUtlity.sharedHelper().showToast(on: view, withMeassge: "Please select Duration.", withDuration: Duration.kShortDuration)
//            return
//        }
        
        var selectedNumbers : [[String : String]] = []
        if let guests = guests {
            for guest in guests {
                let selectedNumber = [
                    APIKeys.kID: guest.guestCardID,
                    APIKeys.kTransactionID: guest.transactionID,
                    APIKeys.kLinkedMemberID : guest.linkedMemberID
                ]
                selectedNumbers.append(selectedNumber)
            }
        }
        if isFrom .isEqual(to: "Modify") {
            if let guests = guests {
                for i in 0..<Int(guests.count) {
                    
                    ReceiptNumber = guests[i].receiptNumber
                    if ReceiptNumber == "" {
                        
                    }else{
                        break
                    }
                }
                
            }
        }
        else{
            ReceiptNumber = ""
        }
     

        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)

        let params: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            APIKeys.kFromDate : (txtVisit.text?.prefix(10))!,
            APIKeys.kExtendBy : "",
            APIKeys.kDuration : txtExtendBy.text ?? "",
            "AccompanyWithMainMember": btnSwitchSelection.tag,
            "SelectedNumbers": selectedNumbers,
            "GuestID": guests?.first?.guestID ?? "" ,
            "ReceiptNumber": ReceiptNumber ?? "",
            "LinkedMemberIds": guests?.first?.transactionDetailID ?? "",
             "Action": "AddVisit"
        ]
        
        APIHandler.sharedInstance.addOrModifyGuestCard(paramater: params, onSuccess: {
            // self.navigationController?.popViewController(animated: true)
            if self.isFrom .isEqual(to: "Modify") {

                if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessPopupView") as? NewSuccessPopupView {
                    self.appDelegate.hideIndicator()
                    succesView.isSwitch = self.btnSwitchSelection.tag

                    //Added by kiran V3.0 -- ENGAGE0011843 -- Changed the data type to string and replaced hardcoded string with Lang file.
                    //ENGAGE0011843 -- Start
                    if self.guests?.first?.relation == self.appDelegate.masterLabeling.guestCard_OF
                    {
                        succesView.isSwitch = 0
                    }
                    /*
                    if (self.guests?.first?.relation)!.rawValue == "OF"{
                        succesView.isSwitch = 0
                    }
                     */
                    //ENGAGE0011843 -- End
                    succesView.delegate = self
                    succesView.modalTransitionStyle   = .crossDissolve;
                    succesView.modalPresentationStyle = .overCurrentContext
                    self.present(succesView, animated: true, completion: nil)
                }
            }
            else{

                if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView {
                    self.appDelegate.hideIndicator()
                    succesView.delegate = self
                    succesView.isFrom = "Update"
                    succesView.isSwitch = self.btnSwitchSelection.tag
                    //Added by kiran V3.0 -- ENGAGE0011843 -- Changed the data type to string and replaced hardcoded string with Lang file.
                    //ENGAGE0011843 -- Start
                    if self.guests?.first?.relation == self.appDelegate.masterLabeling.guestCard_OF
                    {
                        succesView.isSwitch = 0
                    }
                    /*
                    if (self.guests?.first?.relation)!.rawValue == "OF"{
                        succesView.isSwitch = 0
                    }*/
                    //ENGAGE0011843 -- End

                    succesView.modalTransitionStyle   = .crossDissolve;
                    succesView.modalPresentationStyle = .overCurrentContext
                    self.present(succesView, animated: true, completion: nil)
                }
            }
            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            self.appDelegate.hideIndicator()
            
        }
    }
    @IBAction func guestCardClicked(_ sender: Any)
    {
        //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        CustomFunctions.shared.showPDFWith(url: self.policyURL ?? "", title: self.PDFTitle ?? "", navigationController: self.navigationController)
        //Old Logic
        /*
        if let guestPolicy = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "GuestCardPolicyVC") as? GuestCardPolicyVC {
            self.appDelegate.hideIndicator()
            
            self.present(guestPolicy, animated: true, completion: nil)
        }
         */
        //ENGAGE0011898 -- End
    }
}
extension AddVisitViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return appDelegate.arrWeeks.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return appDelegate.arrWeeks[row].weak
    }
    
}

extension AddVisitViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        
        selectedWeek = appDelegate.arrWeeks[row]
        txtExtendBy.text = selectedWeek?.weak
        updateVisitDate()

        
    }
}
