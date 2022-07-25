//
//  MutipleGuestViewController.swift
//  CSSI
//
//  Created by Apple on 27/09/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
class ModifyRunningCardsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,closeSuccesPopup{
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
    @IBOutlet weak var lblExtendBy: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var lblChangewillnotAppearonYour: UILabel!
    @IBOutlet weak var lblGuestPolicy: UIButton!
    
    @IBOutlet weak var lblAccompainingText: UILabel!
    @IBOutlet weak var lblNO: UILabel!
    @IBOutlet weak var lblYES: UILabel!
    @IBOutlet weak var btnSwitch: UISwitch!
    
    @IBOutlet weak var lblUpcomingVisit: UILabel!
    
    @IBOutlet weak var txtUpComingVisit: UITextField!
    @IBOutlet var lblBottom: UILabel!
    @IBOutlet weak var txtVisit: UITextField!
    @IBOutlet weak var txtExtendBy: UITextField!
    @IBOutlet weak var multipleSecetionTableview: UITableView!
    
    @IBOutlet weak var lblVisitErrorMessage: UILabel!
    @IBOutlet weak var lblExtendByErrorMessage: UILabel!
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate
    fileprivate var dob:Date? = nil
    fileprivate var durationPicker : UIPickerView? = nil;
    fileprivate var selectedDay: Day? = nil
    var buttonTitle: NSString!
    var visitToDate: String?
    
    // These are the colors of the square views in our table view cells.
    // In a real project you might use UIImages.
    
    // Don't forget to enter this in IB also
    let cellReuseIdentifier = "MutlipleSelectionID"
    var guests : [Guest]? = nil
    
    //Added on 4th July 2020
    private let accessManager = AccessManager.shared
    
    //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
    //ENGAGE0011898 -- Start
    var policyURL : String?
    var PDFTitle : String?
    //ENGAGE0011898 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Added on 4th July 2020 V2.2
        //Added roles and privilages chages
        
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
        
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.setDate(Date(), animated: true)
        datePicker.minimumDate = Date()
        //Added on 14th October 2020 V2.3
        //Added for iOS 14 date picker change
        if #available(iOS 14.0,*)
        {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.addTarget(self, action: #selector(didDOBDateChange(datePicker:)), for: .valueChanged)
        txtVisit.inputView = datePicker
        txtVisit.text = "\(guests![0].fromDate) - \(guests![0].toDate)"
        
        let previousDate = SharedUtlity.sharedHelper().dateFormatter.date(from: (guests?.first?.toDate)!)
        let now = SharedUtlity.sharedHelper().dateFormatter.date(from: (guests?.first?.fromDate)!)
        
        let components = Calendar.current.dateComponents([.weekday, .month], from: now!, to: previousDate!)
        
//        let weeks = components.weekday ?? 0
        
        
//        if weeks >= 6 && weeks <= 12 {
//            txtUpComingVisit.text = "1 week"
//        }
//        else if weeks >= 13 && weeks <= 22{
//            txtUpComingVisit.text = "2 weeks"
//        }
//        else{
//            txtUpComingVisit.text = ""
//
//        }
        txtUpComingVisit.text = guests![0].durationPeriod
//        if weeks == 6 || weeks == 13{
////            visitToDate = guests![0].toDate
//
//            UserDefaults.standard.set(guests![0].toDate, forKey: UserDefaultsKeys.visitToDate.rawValue)
//
//        }
        
        durationPicker = UIPickerView()
        durationPicker?.delegate = self
        durationPicker?.dataSource = self
        txtExtendBy.inputView = durationPicker
        txtExtendBy.text = self.guests![0].extendedBy
        
        lblUpcomingVisit.text = self.appDelegate.masterLabeling.duration ?? "" as String

        lblVisitErrorMessage.text = self.appDelegate.masterLabeling.visit_Is_Required ?? "" as String
        lblExtendByErrorMessage.text = self.appDelegate.masterLabeling.Extend_Is_Required ?? "" as String
        lblExtendBy.text = self.appDelegate.masterLabeling.extended_By ?? "" as String
        lblVisit.text = self.appDelegate.masterLabeling.visit ?? "" as String
        btnSave .setTitle(self.appDelegate.masterLabeling.sAVE, for: .normal)
        lblGuestPolicy .setTitle(self.appDelegate.masterLabeling.guest_Card_Policy_Title, for: .normal)
        lblChangewillnotAppearonYour.text = self.appDelegate.masterLabeling.charges_Will_Not_Appear ?? "" as String
        
        lblAccompainingText.text = self.appDelegate.masterLabeling.accompanying_Guest_During_Check_in ?? "" as String
        lblNO.text = self.appDelegate.masterLabeling.No ?? "" as String
        lblYES.text = self.appDelegate.masterLabeling.Yes ?? "" as String

        txtVisit.setRightIcon(imageName: "Icon_Calendar")
        txtExtendBy.setRightIcon(imageName: "Path 1847")
        
        //Comments by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        //self.navigationItem.title = self.appDelegate.masterLabeling.tITLE_GUEST_CARD ?? "" as String
        //ENGAGE0011898 -- End
        
        let backButton = UIBarButtonItem()
        
        backButton.title = self.appDelegate.masterLabeling.bACK ?? "" as String
        
        self.lblBottom.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)
        
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton


        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
        
//        if guests?.first?.accompanyWithMainMember == 1{
//            btnSwitchSelection.setBackgroundImage(UIImage(named : "Group 1712-1"), for: UIControlState.normal)
//
//        }
//        else{
//            btnSwitchSelection.setBackgroundImage(UIImage(named : "Group 1714"), for: UIControlState.normal)
//
//        }
        if guests?.first?.accompanyWithMainMember == 1{
            btnSwitchSelection.setBackgroundImage(UIImage(named : "Group 1712-1"), for: UIControlState.normal)
            btnSwitchSelection.tag = 1
            
        }
        else{
            btnSwitchSelection.setBackgroundImage(UIImage(named : "Group 1714"), for: UIControlState.normal)
            btnSwitchSelection.tag = 0
            
        }
        
        self.mandatoryfileds()
        self.btnSave.setStyle(style: .contained,type: .primary)
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
        
    }
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
    //ENGAGE0011297 -- Start
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        self.navigationItem.title = self.appDelegate.masterLabeling.tITLE_GUEST_CARD ?? "" as String
        //ENGAGE0011898 -- End
        
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
    }
    //ENGAGE0011297 -- End
    
    func mandatoryfileds(){
        
        let visitDate: NSMutableAttributedString = NSMutableAttributedString(string: self.lblVisit.text!)
        visitDate.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblVisit.attributedText = visitDate
        
        let extendLabel: NSMutableAttributedString = NSMutableAttributedString(string: self.lblExtendBy.text!)
        extendLabel.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblExtendBy.attributedText = extendLabel
        
        
        let duration: NSMutableAttributedString = NSMutableAttributedString(string: self.lblUpcomingVisit.text!)
        duration.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblUpcomingVisit.attributedText = duration
        
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    @objc func didDOBDateChange(datePicker:UIDatePicker) {
        dob = datePicker.date
        txtVisit.text = SharedUtlity.sharedHelper().dateFormatter.string(from: datePicker.date)
        updateVisitDate()

    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txtExtendBy{
            self.durationPicker?.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(durationPicker!, didSelectRow: 0, inComponent: 0)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guests?.count ?? 0
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CustomMultipleSelectionCell = self.multipleSecetionTableview.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CustomMultipleSelectionCell
        if let guest = guests?[indexPath.row] {
            cell.lblId.text = guest.guestMemberID
            cell.lblName.text = guest.memberName
        }
        return cell
    }
    @IBAction func switchSelectionClicked(_ sender: Any) {
        if btnSwitchSelection.tag == 1 {
            btnSwitchSelection.tag = 0
            btnSwitchSelection.setBackgroundImage(UIImage(named : "Group 1712-1"), for: UIControlState.normal)
        }else {
            btnSwitchSelection.tag = 1
            btnSwitchSelection.setBackgroundImage(UIImage(named : "Group 1714"), for: UIControlState.normal)
            
        }
    }
    
    fileprivate func updateVisitDate() {
        if let date = SharedUtlity.sharedHelper().dateFormatter.date(from: guests![0].previousToDate){
            let fromdate = SharedUtlity.sharedHelper().dateFormatter.date(from: guests![0].fromDate)
            var numberOfDaysToAdd = 0
            if selectedDay?.day == "1 day" {
                numberOfDaysToAdd = 1
            } else if selectedDay?.day == "2 days" {
                numberOfDaysToAdd = 2
            }else if selectedDay?.day == "3 days" {
                numberOfDaysToAdd = 3
            }else if selectedDay?.day == "4 days" {
                numberOfDaysToAdd = 4
            }else if selectedDay?.day == "5 days" {
                numberOfDaysToAdd = 5
            }else if selectedDay?.day == "6 days" {
                numberOfDaysToAdd = 6
            }else if selectedDay?.day == "7 days" {
                numberOfDaysToAdd = 7
            }
            
            let dateNew = SharedUtlity.sharedHelper().dateFormatter.date(from: (UserDefaultsKeys.visitToDate.rawValue))
            
            if let dateFormatter = SharedUtlity.sharedHelper().dateFormatter,
                let toDate = Calendar.current.date(byAdding: .day , value: numberOfDaysToAdd, to: date, wrappingComponents: false),
                numberOfDaysToAdd != 0 {
                txtVisit.text = "\(dateFormatter.string(from: fromdate!)) - \(dateFormatter.string(from: toDate))"
            }
        }
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
//
//    func textFiledsValidation(){
//
//        if (txtVisit.text == "") {
//            lblVisitErrorMessage.isHidden = false
//        } else {
//            lblVisitErrorMessage.isHidden = true
//        }
//        if (txtExtendBy.text == "") {
//            lblExtendByErrorMessage.isHidden = false
//        } else {
//            lblExtendByErrorMessage.isHidden = true
//        }
//
//    }
    
    @IBAction func SaveButtonClicked(_ sender: Any)
    {
        
        //Added on 4th July 2020 V2.2
        //Added roles and privilages changes
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

        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)

        let params: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            APIKeys.kFromDate : guests![0].fromDate,
            APIKeys.kToDate : guests![0].previousToDate,
            APIKeys.kExtendBy : txtExtendBy.text ?? "",
            "AccompanyWithMainMember": btnSwitchSelection.tag,
            "SelectedNumbers":selectedNumbers,
            "GuestID": guests?.first?.guestID ?? "" ,
            "ReceiptNumber": guests?.first?.receiptNumber ?? "",
            APIKeys.kDuration : self.txtUpComingVisit.text ?? "",
            "LinkedMemberIds": guests?.first?.transactionDetailID ?? "",
            "Action": "CurrentVisit"

        ]
        print(params)
        APIHandler.sharedInstance.addOrModifyGuestCard(paramater: params, onSuccess: {
            
            if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessPopupView") as? NewSuccessPopupView {
                self.appDelegate.hideIndicator()
                succesView.delegate = self
                succesView.modalTransitionStyle   = .crossDissolve;
                succesView.modalPresentationStyle = .overCurrentContext
                self.present(succesView, animated: true, completion: nil)
            }
            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            self.appDelegate.hideIndicator()
            
        }
        
    }
    
    @IBAction func guestpolicyClicked(_ sender: Any)
    {
        //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        CustomFunctions.shared.showPDFWith(url: self.policyURL ?? "", title: self.PDFTitle ?? "", navigationController: self.navigationController)
        //Old Logic
        /*
        if let guestPolicy = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "GuestCardPolicyVC") as? GuestCardPolicyVC {
            
            self.appDelegate.hideIndicator()
            self.present(guestPolicy, animated: true, completion: nil)
            
            }*/
        //ENGAGE0011898 -- End
    }
    
}

extension ModifyRunningCardsViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return appDelegate.arrDays.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return appDelegate.arrDays[row].day
    }
    
}

extension ModifyRunningCardsViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        selectedDay = appDelegate.arrDays[row]
        txtExtendBy.text = selectedDay?.day
        updateVisitDate()

        
    }
}
