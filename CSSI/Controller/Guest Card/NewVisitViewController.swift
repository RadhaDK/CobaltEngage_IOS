//
//  NewVisitViewController.swift
//  CSSI
//
//  Created by Apple on 27/09/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class NewVisitViewController: UIViewController,  UITextFieldDelegate,closeUpdateSuccesPopup{
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

    
    @IBOutlet weak var btnSwitchSelection: UIButton!
    @IBOutlet weak var lblUpcomingVisit: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblAccompanyingGuest: UILabel!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var lblGuestPolicy: UIButton!
    
    @IBOutlet weak var txtUpcomingEvent: UITextField!
    @IBOutlet weak var txtSelectGuest: UITextField!
    @IBOutlet weak var txtDuration: UITextField!
    
    @IBOutlet var lblBottm: UILabel!
    @IBOutlet weak var lblSelectGuestErrorMessage: UILabel!
    @IBOutlet weak var lblDurationErrorMessage: UILabel!
    @IBOutlet weak var lblUpcomingVisitErrorMessage: UILabel!
    
    fileprivate let dateFormator = DateFormatter()
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate
    fileprivate var dob:Date? = nil
    fileprivate var durationPicker : UIPickerView? = nil;
    fileprivate var selectedGuest: Guest? = nil
    fileprivate var selectedWeek: Week? = nil
    fileprivate var guestsTableView: UITableView? = nil
    fileprivate var selectedGuests: [GuestDropDown] = [GuestDropDown]()
    var buttonTitle: NSString!

    var guests: [GuestDropDown]? = nil

    //Added on 4th July 2020 V2.2
    private let accessManager = AccessManager.shared
    
    //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
    //ENGAGE0011898 -- Start
    var policyURL : String?
    var PDFTitle : String?
    //ENGAGE0011898 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Added on 4th July 2020 V2.2
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
        
        
        
        
        // Do any additional setup after loading the view.
        lblSelectGuestErrorMessage.text = self.appDelegate.masterLabeling.select_Guest_Is_Required ?? "" as String
        lblDurationErrorMessage.text = self.appDelegate.masterLabeling.duration_Is_Required ?? "" as String
        lblUpcomingVisitErrorMessage.text = self.appDelegate.masterLabeling.upcoming_Visit_Is_Required ?? "" as String
        lblDuration.text = self.appDelegate.masterLabeling.duration ?? "" as String
        lblAccompanyingGuest.text = self.appDelegate.masterLabeling.accompanying_Guest_During_Check_in ?? "" as String
        lblNo.text = self.appDelegate.masterLabeling.No ?? "" as String
        lblYes.text = self.appDelegate.masterLabeling.Yes ?? "" as String
        btnSave .setTitle(self.appDelegate.masterLabeling.sAVE, for: .normal)
        lblGuestPolicy .setTitle(self.appDelegate.masterLabeling.guest_Card_Policy_Title, for: .normal)
        txtSelectGuest.placeholder = self.appDelegate.masterLabeling.sELECT_GUEST_ASTERISK ?? "" as String
        lblUpcomingVisit.text = self.appDelegate.masterLabeling.upcoming_Visit ?? "" as String

        
        txtUpcomingEvent.setRightIcon(imageName:"Icon_Calendar")
        txtSelectGuest.setRightIcon(imageName: "Path 1847")
        txtDuration.setRightIcon(imageName: "Path 1847")
       // txtUpcomingEvent.setRightIcon(#imageLiteral(resourceName: "icon_calendar_event"))
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
        txtUpcomingEvent.inputView = datePicker

        guestsTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 250))
        guestsTableView?.register(UINib(nibName: "GuestSelectionTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "GuestSelectionTableViewCell")
        guestsTableView?.delegate = self
        guestsTableView?.dataSource = self
        guestsTableView?.allowsMultipleSelection = true
        txtSelectGuest.inputView = guestsTableView
        
        durationPicker = UIPickerView()
        durationPicker?.delegate = self
        durationPicker?.dataSource = self
        txtDuration.inputView = durationPicker
        
        //Commented by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        //self.navigationItem.title = self.appDelegate.masterLabeling.add_Visit ?? "" as String
        //ENGAGE0011898 -- End
        
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
        //ENGAGE0011297 -- Start
//        let backButton = UIBarButtonItem()
//        backButton.title = self.appDelegate.masterLabeling.bACK ?? "" as String
//        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
        //ENGAGE0011297 -- End
        self.lblBottm.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)
        
        

        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
        self.btnSwitchSelection.tag = 1
        
        self.mandatoryfileds()
        self.btnSave.setStyle(style: .contained,type: .primary)
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
        
    }
    func mandatoryfileds(){
        let selectGuest: NSMutableAttributedString = NSMutableAttributedString(string: self.txtSelectGuest.placeholder!)
        selectGuest.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.txtSelectGuest.attributedPlaceholder = selectGuest

        let duration: NSMutableAttributedString = NSMutableAttributedString(string: self.lblDuration.text!)
        duration.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblDuration.attributedText = duration
        
        let upcomingVisit: NSMutableAttributedString = NSMutableAttributedString(string: self.lblUpcomingVisit.text!)
        upcomingVisit.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblUpcomingVisit.attributedText = upcomingVisit
        
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
        
       // self.txtSelectGuest.placeholder = self.appDelegate.masterLabeling.select_Guest
        
        if textField == txtDuration{
            self.durationPicker?.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(durationPicker!, didSelectRow: 0, inComponent: 0)
        }
        if  textField == txtUpcomingEvent {
            if txtUpcomingEvent.text == ""{
                dob = Date()
                txtUpcomingEvent.text = SharedUtlity.sharedHelper().dateFormatter.string(from: Date())

            }
            else{
                
            }
    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SwitchSelectionClicked(_ sender: Any) {
        if btnSwitchSelection.tag == 1 {
            btnSwitchSelection.tag = 0
            btnSwitchSelection.setBackgroundImage(UIImage(named : "Group 1714"), for: UIControlState.normal)
        }else {
            btnSwitchSelection.tag = 1
            btnSwitchSelection.setBackgroundImage(UIImage(named : "Group 1712-1"), for: UIControlState.normal)
            
        }
    }
    
    @objc func didDOBDateChange(datePicker:UIDatePicker) {
        dob = datePicker.date
        txtUpcomingEvent.text = dateFormator.string(from: datePicker.date)
        updateVisitDate()
    }
    
    func updateSelectedMembersField() {
        let names = selectedGuests.map { "\($0.guestName)" }
        txtSelectGuest.text = names.joined(separator: ", ")
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        self.navigationItem.title = self.appDelegate.masterLabeling.add_Visit ?? "" as String
        //ENGAGE0011898 -- End
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End

    }
    fileprivate func updateVisitDate() {
        if let date = dob {
            var numberOfDaysToAdd = 0
            if selectedWeek?.weak == "1 week" {
                        numberOfDaysToAdd = 6
                        } else if selectedWeek?.weak == "2 weeks" {
                              numberOfDaysToAdd = 13
                        }
        
                    if let dateFormatter = SharedUtlity.sharedHelper().dateFormatter,
                        let toDate = Calendar.current.date(byAdding: .day , value: numberOfDaysToAdd, to: date, wrappingComponents: false),
                        numberOfDaysToAdd != 0 {
                            txtUpcomingEvent.text = "\(dateFormatter.string(from: date)) - \(dateFormatter.string(from: toDate))"
                        }
                }
           }
 
    
    
    @IBAction func switchClicked(_ sender: Any) {
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
//        var selectedNumbers : [[String : String]] = []
//        for guestID in selectedGuests {
//            let selectedNumber = [
//                APIKeys.kID: "",
//                APIKeys.kTransactionID: "",
//                APIKeys.kLinkedMemberID : guestID.guestID
//            ]
//            selectedNumbers.append(selectedNumber)
//        }
//
//        if (selectedNumbers.count == 0) {
//            lblSelectGuestErrorMessage.isHidden = false
//        } else {
//            lblSelectGuestErrorMessage.isHidden = true
//        }
//        if (txtDuration.text == "") {
//            lblDurationErrorMessage.isHidden = false
//        } else {
//            lblDurationErrorMessage.isHidden = true
//        }
//
//        if (txtUpcomingEvent.text == "") {
//            lblUpcomingVisitErrorMessage.isHidden = false
//        } else {
//            lblUpcomingVisitErrorMessage.isHidden = true
//        }
//
//    }
    @IBAction func saveClicked(_ sender: Any) {
        
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
        
        
        
        
//        buttonTitle = btnSave.titleLabel?.text as NSString?

        var selectedNumbers : [[String : String]] = []
        for guestID in selectedGuests {
            let selectedNumber = [
                APIKeys.kID: "",
                APIKeys.kTransactionID: "",
                APIKeys.kLinkedMemberID : guestID.guestID
            ]
            selectedNumbers.append(selectedNumber)
        }
        
      //  textFiledsValidation()

//        if (txtUpcomingEvent.text == "") || (txtDuration.text == "") || (selectedNumbers.count == 0){
//            
//            return
//        }

        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)

        let params: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            APIKeys.kFromDate : (txtUpcomingEvent.text?.prefix(10))!,
            APIKeys.kDuration : txtDuration.text ?? "",
            "AccompanyWithMainMember": btnSwitchSelection.tag,
            "SelectedNumbers": selectedNumbers,
            "GuestID": "",
            "ReceiptNumber": "",
            "ExtendBy": "",
            "LinkedMemberIds": "",
            "Action": "NewVisit"
        ]
        
       
        
        APIHandler.sharedInstance.addOrModifyGuestCard(paramater: params, onSuccess: {
            // self.navigationController?.popViewController(animated: true)
//            if let newVisitGuestViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "ThanksUPdateViewController") as? ThanksUPdateViewController {
//                self.appDelegate.hideIndicator()
//                newVisitGuestViewController.isFrom = "New"
//                newVisitGuestViewController.isSwitch = self.btnSwitchSelection.isSelected ? 0 : 1
//                self.navigationController?.pushViewController(newVisitGuestViewController, animated: true)
//            }
            
            if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView {
                self.appDelegate.hideIndicator()
                succesView.delegate = self
                succesView.isFrom = "New"
                succesView.isSwitch = self.btnSwitchSelection.tag
                for guestID in self.selectedGuests {
                    
                    //Added by kiran V3.0 -- ENGAGE0011843 -- Removed hardCoded value and using valus from lang file instead.
                    //ENGAGE0011843 -- Start
                    if guestID.relationDrop == self.appDelegate.masterLabeling.guestCard_OF
                    {
                        succesView.isSwitch = 0
                    }
                    
                    //Old Logic
                    /*
                     if guestID.relationDrop == "OF"
                     {
                         succesView.isSwitch = 0
                     }
                     */
                    
                    //ENGAGE0011843 -- End
                }
                succesView.modalTransitionStyle   = .crossDissolve;
                succesView.modalPresentationStyle = .overCurrentContext
                self.present(succesView, animated: true, completion: nil)
            }
            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            self.appDelegate.hideIndicator()
        }
        
    }
    
    
    @IBAction func guestPolicyClicked(_ sender: Any)
    {
        //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        CustomFunctions.shared.showPDFWith(url: self.policyURL ?? "", title: self.PDFTitle ?? "", navigationController: self.navigationController)
       
        //Old logic
        /*
        if let guestPolicy = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "GuestCardPolicyVC") as? GuestCardPolicyVC {
            self.appDelegate.hideIndicator()
            self.present(guestPolicy, animated: true, completion: nil)
        }*/
        
        //ENGAGE0011898 -- End
    }
    
}

extension NewVisitViewController : UIPickerViewDataSource {
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

extension NewVisitViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedWeek = appDelegate.arrWeeks[row]
        txtDuration.text = selectedWeek?.weak
        updateVisitDate()
    }
}

extension NewVisitViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guests?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GuestSelectionTableViewCell") as? GuestSelectionTableViewCell {
            let guest = guests![indexPath.row]
            cell.titleLabel.text = guest.guestName
            return cell
        }
        return UITableViewCell()
    }
}

extension NewVisitViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let guest = guests![indexPath.row]
        selectedGuests.append(guest)
        updateSelectedMembersField()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let guest = guests![indexPath.row]
        
        if let index = selectedGuests.index(where: { (g) -> Bool in
            return g.guestID == guest.guestID
        }) {
            selectedGuests.remove(at: index)
        }
        updateSelectedMembersField()
    }
}


