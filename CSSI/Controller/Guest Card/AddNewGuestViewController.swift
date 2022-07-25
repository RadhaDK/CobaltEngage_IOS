//
//  AddNewGuestViewController.swift
//  CSSI
//
//  Created by Apple on 27/09/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

enum PhotoTyoe : Int {
    case PhotoID = 0
    case GuestPhoto = 1
}
class AddNewGuestViewController: UIViewController,closeUpdateSuccesPopup{
    
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
    
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    
    @IBOutlet weak var lblRelation: UILabel!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblVisit: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblAccompanyingGuest: UILabel!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var lblAddPhotoID: UILabel!
    @IBOutlet weak var lblDLorPassport: UILabel!
    @IBOutlet weak var lblAddGuestPhoto: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var lblGuestPolicy: UIButton!
    @IBOutlet weak var btnSwitchOnOFF: UIButton!
    
    
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtRelation: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtVisit: UITextField!
    @IBOutlet weak var txtDuration: UITextField!
    @IBOutlet weak var photoIDContainerView: UIView!
    @IBOutlet weak var guestPhotoContainerView: UIView!
    @IBOutlet weak var photoIDImageView: UIImageView!
    @IBOutlet weak var guestPhotoImageView: UIImageView!
    
    @IBOutlet var lblBottom: UILabel!
    @IBOutlet weak var lblFirstNameErrorMessage: UILabel!
    @IBOutlet weak var lblLastNameErrorMessage: UILabel!
    
    @IBOutlet weak var lblRelationErrorMessage: UILabel!
    @IBOutlet weak var lblDOBErrorMessage: UILabel!
    
    @IBOutlet weak var lblPhoneErrorMessage: UILabel!
    
    @IBOutlet weak var lblVisitErrorMessage: UILabel!
    @IBOutlet weak var lblEmailErrorMessage: UILabel!
    
    @IBOutlet weak var lblDurationErrorMessage: UILabel!
    @IBOutlet weak var lblAddPhotoErrorMessage: UILabel!
    @IBOutlet weak var lblGuestPhotoerrorMessage: UILabel!
    
    fileprivate var calenderNavigationController:UINavigationController? = nil
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate
    fileprivate var dob:Date? = nil
    fileprivate var visitFromDate: Date? = nil
    fileprivate var selectedRelation: GuestRelation? = nil
    fileprivate var relationPicker: UIPickerView? = nil;
    fileprivate var durationPicker : UIPickerView? = nil;
    fileprivate var selectedWeek: Week? = nil
    fileprivate var imagePicker: UIImagePickerController = UIImagePickerController()
    fileprivate var params: [String : Any] = [:]
    var buttonTitle: NSString!
    var fromDate: String?
    
    var tmpHTMLimage: String!
    var tmpHTMLimage2: String!
    
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
//        txtDOB.setRightIcon(#imageLiteral(resourceName: "icon_calendar_event"))
//        txtVisit.setRightIcon(#imageLiteral(resourceName: "icon_calendar_event"))
        
        txtVisit.setRightIcon(imageName: "Icon_Calendar")
        txtDOB.setRightIcon(imageName: "Icon_Calendar")
        txtRelation.setRightIcon(imageName: "Path 1847")
        txtDuration.setRightIcon(imageName: "Path 1847")

        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.setDate(Date(), animated: true)
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(didDOBDateChange(datePicker:)), for: .valueChanged)

        txtDOB.inputView = datePicker
        
        let visitDatePicker = UIDatePicker()
        visitDatePicker.datePickerMode = .date
        visitDatePicker.setDate(Date(), animated: true)
        visitDatePicker.addTarget(self, action: #selector(didVisitDateChanged(datePicker:)), for: .valueChanged)
        txtVisit.inputView = visitDatePicker
        visitDatePicker.minimumDate = Date()
        visitDatePicker.maximumDate = Calendar.current.date(byAdding: .day, value: self.appDelegate.guestNumberOfday, to: Date())
        //Added on 14th October 2020 V2.3
        //Added for iOS 14 date picker change
        if #available(iOS 14.0,*)
        {
            datePicker.preferredDatePickerStyle = .wheels
            visitDatePicker.preferredDatePickerStyle = .wheels
        }

        
        relationPicker = UIPickerView()
        relationPicker?.dataSource = self
        relationPicker?.delegate = self
        txtRelation.inputView = relationPicker
        txtRelation.delegate = self
        
        durationPicker = UIPickerView()
        durationPicker?.delegate = self
        durationPicker?.dataSource = self
        txtDuration.inputView = durationPicker
        
        
        lblFirstNameErrorMessage.text = self.appDelegate.masterLabeling.First_Name_is_required ?? "" as String
        lblLastNameErrorMessage.text = self.appDelegate.masterLabeling.Last_Name_is_required ?? "" as String
        lblPhoneErrorMessage.text = self.appDelegate.masterLabeling.phone_Is_Required ?? "" as String
        lblEmailErrorMessage.text = self.appDelegate.masterLabeling.email_Is_Required ?? "" as String
        lblRelationErrorMessage.text = self.appDelegate.masterLabeling.Relation_is_required ?? "" as String
        lblDOBErrorMessage.text = self.appDelegate.masterLabeling.Date_Of_Birth_is_required ?? "" as String
        lblDurationErrorMessage.text = self.appDelegate.masterLabeling.duration_Is_Required ?? "" as String
        lblVisitErrorMessage.text = self.appDelegate.masterLabeling.visit_Is_Required ?? "" as String
        lblAddPhotoErrorMessage.text = self.appDelegate.masterLabeling.photo_ID_Is_Required ?? "" as String
        lblGuestPhotoerrorMessage.text = self.appDelegate.masterLabeling.guest_Photo_Is_Required ?? "" as String
        
        lblFirstName.text = self.appDelegate.masterLabeling.first_Name ?? "" as String
        lblLastName.text = self.appDelegate.masterLabeling.last_Name ?? "" as String
        lblPhone.text = self.appDelegate.masterLabeling.Phone ?? "" as String
        lblEmail.text = self.appDelegate.masterLabeling.email ?? "" as String
        lblRelation.text = self.appDelegate.masterLabeling.rELATION_ASTERISK!
        lblDOB.text = self.appDelegate.masterLabeling.date_Of_Birth ?? "" as String
        lblDuration.text = self.appDelegate.masterLabeling.duration ?? "" as String
        lblVisit.text = self.appDelegate.masterLabeling.visit ?? "" as String
        lblAccompanyingGuest.text = self.appDelegate.masterLabeling.accompanying_Guest_During_Check_in ?? "" as String
        lblNo.text = self.appDelegate.masterLabeling.No ?? "" as String
        lblYes.text = self.appDelegate.masterLabeling.Yes ?? "" as String
        btnSave .setTitle(self.appDelegate.masterLabeling.sAVE, for: .normal)
        lblGuestPolicy .setTitle(self.appDelegate.masterLabeling.guest_Card_Policy_Title, for: .normal)
        lblAddGuestPhoto.text = self.appDelegate.masterLabeling.Add_Guest_Photo ?? "" as String
        lblAddPhotoID.text = self.appDelegate.masterLabeling.add_Photo_ID ?? "" as String
        lblDLorPassport.text = self.appDelegate.masterLabeling.dlOrPassport ?? "" as String

        //Commented by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        //self.navigationItem.title = self.appDelegate.masterLabeling.aDD_GUEST ?? "" as String
        //ENGAGE0011898 -- End
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
        //ENGAGE0011297 -- Start
//        let backButton = UIBarButtonItem()
//
//        backButton.title = self.appDelegate.masterLabeling.bACK ?? "" as String
//        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
        //ENGAGE0011297 -- End
        self.lblBottom.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)

        btnSwitchOnOFF.tag = 1
        
        imagePicker.delegate = self
        
        let photoIDTapGuesture = UITapGestureRecognizer(target: self, action: #selector(onTapPhotoID))
        photoIDImageView.addGestureRecognizer(photoIDTapGuesture)
        
        let guestPhotoTapGuesture = UITapGestureRecognizer(target: self, action: #selector(onTapGuestPhoto))
        guestPhotoImageView.addGestureRecognizer(guestPhotoTapGuesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)

        
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
        let firstName: NSMutableAttributedString = NSMutableAttributedString(string: self.lblFirstName.text!)
        firstName.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblFirstName.attributedText = firstName
        
        let lastName: NSMutableAttributedString = NSMutableAttributedString(string: self.lblLastName.text!)
        lastName.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblLastName.attributedText = lastName
        
        let relation: NSMutableAttributedString = NSMutableAttributedString(string: self.lblRelation.text!)
        relation.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblRelation.attributedText = relation
        
        let dobLabel: NSMutableAttributedString = NSMutableAttributedString(string: self.lblDOB.text!)
        dobLabel.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblDOB.attributedText = dobLabel
        
        let phoneLabel: NSMutableAttributedString = NSMutableAttributedString(string: self.lblPhone.text!)
        phoneLabel.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblPhone.attributedText = phoneLabel
        
        let emailLabel: NSMutableAttributedString = NSMutableAttributedString(string: self.lblEmail.text!)
        emailLabel.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblEmail.attributedText = emailLabel

        let visitLabel: NSMutableAttributedString = NSMutableAttributedString(string: self.lblVisit.text!)
        visitLabel.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblVisit.attributedText = visitLabel

        let durationLabel: NSMutableAttributedString = NSMutableAttributedString(string: self.lblDuration.text!)
        durationLabel.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblDuration.attributedText = durationLabel

        let addGuestPhotoLabel: NSMutableAttributedString = NSMutableAttributedString(string: self.lblAddGuestPhoto.text!)
        addGuestPhotoLabel.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblAddGuestPhoto.attributedText = addGuestPhotoLabel
        
        let addPhoto: NSMutableAttributedString = NSMutableAttributedString(string: self.lblAddPhotoID.text!)
        addPhoto.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblAddPhotoID.attributedText = addPhoto

    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        txtFirstName.resignFirstResponder()
        txtLastName.resignFirstResponder()
        txtPhone.resignFirstResponder()
        txtEmail.resignFirstResponder()

    }
    
    fileprivate func updateVisitDate() {
        if let date = visitFromDate {
            var numberOfDaysToAdd = 0
            if selectedWeek?.weak == "1 week" {
                numberOfDaysToAdd = 6
            } else if selectedWeek?.weak == "2 weeks" {
                numberOfDaysToAdd = 13
            }
            
            if let dateFormatter = SharedUtlity.sharedHelper().dateFormatter,
                let toDate = Calendar.current.date(byAdding: .day , value: numberOfDaysToAdd, to: date, wrappingComponents: false),
                numberOfDaysToAdd != 0 {
                fromDate = dateFormatter.string(from: date)
                txtVisit.text = "\(dateFormatter.string(from: date)) - \(dateFormatter.string(from: toDate))"
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtRelation{
            self.relationPicker?.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(relationPicker!, didSelectRow: 0, inComponent: 0)
        }
        if textField == txtDuration{
            self.durationPicker?.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(durationPicker!, didSelectRow: 0, inComponent: 0)
        }
        if textField == txtDOB {
            if txtDOB.text == ""{

            dob = Date()
            txtDOB.text = SharedUtlity.sharedHelper().dateFormatter.string(from: Date())
        }
            else{
                
            }
        }
        if  textField == txtVisit {
            if txtVisit.text == ""{
                visitFromDate = Date()
                txtVisit.text = SharedUtlity.sharedHelper().dateFormatter.string(from: Date())

            }
            else{

        }
    }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated) // No need for semicolon
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
        
        //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        self.navigationItem.title = self.appDelegate.masterLabeling.aDD_GUEST ?? "" as String
        //ENGAGE0011898 -- End
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
    }
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        
    }
    @IBAction func switchAction(_ sender: Any) {
        
     
    }
    @IBAction func switchSelection(_ sender: Any) {
        
        if btnSwitchOnOFF.tag == 1 {
            btnSwitchOnOFF.tag = 0
            btnSwitchOnOFF.setBackgroundImage(UIImage(named : "Group 1714"), for: UIControlState.normal)
        }else {
            btnSwitchOnOFF.tag = 1
            btnSwitchOnOFF.setBackgroundImage(UIImage(named : "Group 1712-1"), for: UIControlState.normal)

        }
        
        
    }
//    func isValidEmail(testStr:String) -> Bool {
//        print("validate emilId: \(testStr)")
//        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        let result = emailTest.evaluate(with: testStr)
//        return result
//    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if buttonTitle == "Save"{
//            textFiledsValidation()
//        }
//        else{
//
//        }
//    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if buttonTitle == "Save"{
//        textFiledsValidation()
//
//        }
        if textField == self.txtPhone{
            let str = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            
            if textField == txtPhone{
                
                return checkCellPhoneNumberFormat(string: string, str: str)
                
            }
        }
        else{
            
        }
        return true
    }
    func checkCellPhoneNumberFormat(string: String?, str: String?) -> Bool{
        
        if string == ""{ //BackSpace
            
            return true
            
        }else if str!.characters.count  == 4{
            
            txtPhone.text = txtPhone.text! + "-"
        }else if str!.characters.count == 8{
            txtPhone.text = txtPhone.text! + "-"
            
        }else if str!.characters.count > 12{
            
            return false
        }
        return true
    }
//    func textFiledsValidation(){
//        let photoID = photoIDImageView.image
//
//        if (txtFirstName.text == "") {
//            lblFirstNameErrorMessage.isHidden = false
//        } else {
//            lblFirstNameErrorMessage.isHidden = true
//        }
//        if (txtLastName.text == "") {
//            lblLastNameErrorMessage.isHidden = false
//        } else {
//            lblLastNameErrorMessage.isHidden = true
//        }
//        if (txtEmail.text == "") {
//            lblEmailErrorMessage.isHidden = false
//        } else {
//            if isValidEmail(testStr: txtEmail.text!){
//                lblEmailErrorMessage.isHidden = true
//
//            }
//            else{
//                lblEmailErrorMessage.isHidden = false
//                lblEmailErrorMessage.text = self.appDelegate.masterLabeling.email_Validation ?? "Please enter valid Email ID" as String
//            }
//        }
//        if (txtPhone.text == "") {
//            lblPhoneErrorMessage.isHidden = false
//        } else {
//            lblPhoneErrorMessage.isHidden = true
//
//
//        }
//        if (txtDOB.text == "") {
//            lblDOBErrorMessage.isHidden = false
//            lblAddPhotoErrorMessage.isHidden = false
//
//        } else {
//
//            let dob = self.dob
//            let age = Calendar.current.dateComponents([.year], from: dob!, to: Date()).year ?? 0
//
//
//
//
//
//            if age >= 12 {
//                if age >= 17 {
//                    if photoID == nil {
//                        lblAddPhotoErrorMessage.isHidden = false
//                        lblDOBErrorMessage.isHidden = true
//
//                    }
//                    else{
//                        lblAddPhotoErrorMessage.isHidden = true
//                    }
//                }
//                else{
//
//                lblDOBErrorMessage.isHidden = true
//                lblAddPhotoErrorMessage.isHidden = true
//
//                }}
//            else{
//
//                lblDOBErrorMessage.isHidden = true
//                lblAddPhotoErrorMessage.isHidden = true
//
//                }
//
//        }
//
//        if (txtRelation.text == "") {
//            lblRelationErrorMessage.isHidden = false
//        } else {
//            lblRelationErrorMessage.isHidden = true
//
//
//        }
//        if (txtDuration.text == "") {
//            lblDurationErrorMessage.isHidden = false
//        } else {
//            lblDurationErrorMessage.isHidden = true
//
//
//        }
//        if (txtVisit.text == "") {
//            lblVisitErrorMessage.isHidden = false
//        } else {
//            lblVisitErrorMessage.isHidden = true
//
//
//        }
//
//        let guestPhoto = guestPhotoImageView.image
//        if (guestPhoto == nil) {
//            lblGuestPhotoerrorMessage.isHidden = false
//        } else {
//            lblGuestPhotoerrorMessage.isHidden = true
//
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
        
        
        
      //  buttonTitle = btnSave.titleLabel?.text as NSString?

        if photoIDImageView.image == nil {
            
        }else{
        if let imageData = photoIDImageView.image!.jpeg(.lowest) {
            // let imageDataa: NSData = UIImagePNGRepresentation(imageData)! as NSData
            let imageStr = imageData.base64EncodedString(options:.endLineWithCarriageReturn)
            tmpHTMLimage  = "data:image/jpeg;base64," + imageStr
            
        }
        }
        if guestPhotoImageView.image == nil {
            
        }else{
        if let imageData = guestPhotoImageView.image!.jpeg(.lowest) {
            // let imageDataa: NSData = UIImagePNGRepresentation(imageData)! as NSData
            let imageStr = imageData.base64EncodedString(options:.endLineWithCarriageReturn)
            tmpHTMLimage2  = "data:image/jpeg;base64," + imageStr
            
        }
        }
        
        
//        let photoID = photoIDImageView.image
//        let guestPhoto = guestPhotoImageView.image
      //  textFiledsValidation()

//        if (txtDOB.text == "") {
//        }
//        else{
//
//        let dob = self.dob
//        let age = Calendar.current.dateComponents([.year], from: dob!, to: Date()).year ?? 0
//
//        guard age >= 12 else {
//            SharedUtlity.sharedHelper().showToast(on: view, withMeassge: self.appDelegate.masterLabeling.dob_min ?? "" as String, withDuration: Duration.kShortDuration)
//            return
//        }
//        }
//        if (txtFirstName.text == "") || (txtEmail.text == "") || (txtLastName.text == "") || (txtRelation.text == "") || (txtDOB.text == "") || (txtPhone.text == "") || (txtDuration.text == "") || (txtVisit.text == "") || (guestPhoto == nil) {
//
//           return
//        }
//        else{
//            if (photoID == nil){
//                let dob = self.dob
//                let age = Calendar.current.dateComponents([.year], from: dob!, to: Date()).year ?? 0
//
//
//                if (age >= 13 && age <= 17) {
//
//                }
//                else{
//
//                    return
//
//                }
//            }
//        }
//
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)


         params = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            APIKeys.krelation : selectedRelation?.relation ?? "",
            APIKeys.kfirstName : txtFirstName.text ?? "",
            APIKeys.klastName : txtLastName.text ?? "",
            APIKeys.kPhone : txtPhone.text ?? "",
            APIKeys.kemailid : txtEmail.text ?? "",
            APIKeys.kDOB : txtDOB.text ?? "",
            APIKeys.kFromDate : fromDate ?? "",
            APIKeys.kDuration : txtDuration.text ?? "",
            "PhotoId": tmpHTMLimage ?? "",
            "GuestPhoto": tmpHTMLimage2 ?? "",
            "AccompanyWithMainMember": btnSwitchOnOFF.tag,
            "GuestID": "",
            "ReceiptNumber": "",
            "SelectedNumbers": [
                APIKeys.kID: "",
                APIKeys.kTransactionID: "",
                APIKeys.kLinkedMemberID : ""
            ]
        ]
        
        APIHandler.sharedInstance.requestGuestCard(paramater: params, onSuccess: {_ in
//            if let updateGuestViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "ThanksUPdateViewController") as? ThanksUPdateViewController {
//                self.appDelegate.hideIndicator()
//                updateGuestViewController.isFrom = "New"
//                updateGuestViewController.isSwitch = self.btnSwitchOnOFF.isSelected ? 0 : 1
//                
//                self.navigationController?.pushViewController(updateGuestViewController, animated: true)
//            }
            
            if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView {
                self.appDelegate.hideIndicator()
                succesView.delegate = self
                succesView.isFrom = "New"
                succesView.isSwitch = self.btnSwitchOnOFF.tag
                //Added by kiran V3.0 -- ENGAGE0011843 -- Removed hardCoded value and using valus from lang file instead.
                //ENGAGE0011843 -- Start
                if self.selectedRelation?.relation == self.appDelegate.masterLabeling.guestCard_OF
                {
                    succesView.isSwitch = 0
                }
                
                //Old Logic
                /*
                if self.selectedRelation?.relation == "OF"{
                 succesView.isSwitch = 0
                }
                 */
                //ENGAGE0011843 -- End
                succesView.modalTransitionStyle   = .crossDissolve;
                succesView.modalPresentationStyle = .overCurrentContext
                self.present(succesView, animated: true, completion: nil)
            }
            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            self.appDelegate.hideIndicator()
            
        }
        
    }
    
    @objc func didDOBDateChange(datePicker:UIDatePicker) {
        dob = datePicker.date
        txtDOB.text = SharedUtlity.sharedHelper().dateFormatter.string(from: datePicker.date)

    }
    
    @objc func didVisitDateChanged(datePicker: UIDatePicker) {
        visitFromDate = datePicker.date
        txtVisit.text = SharedUtlity.sharedHelper().dateFormatter.string(from: visitFromDate!)
        updateVisitDate()

    }
    

    @IBAction func guestPolicyClicked(_ sender: Any)
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
    @objc func onTapPhotoID() {
        openOptions(type: .PhotoID)
    }
    
    @objc func onTapGuestPhoto() {
        openOptions(type: .GuestPhoto)
    }
    
//    fileprivate func updateVisitDate() {
//        if let date = visitFromDate {
//            var numberOfDaysToAdd = 0
//            if selectedWeek?.weak == "1 week" {
//                numberOfDaysToAdd = 7
//            } else if selectedWeek?.weak == "2 weeks" {
//                numberOfDaysToAdd = 14
//            }
//
//            if let dateFormatter = SharedUtlity.sharedHelper().dateFormatter,
//                let toDate = Calendar.current.date(byAdding: .day , value: numberOfDaysToAdd, to: date, wrappingComponents: false),
//                numberOfDaysToAdd != 0 {
//                txtVisit.text = "\(dateFormatter.string(from: date)) - \(dateFormatter.string(from: toDate))"
//            }
//        }
//    }
    func openOptions(type: PhotoTyoe )
    {
        
        //Added on 11th July 2020 V2.2
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
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera(type: type)
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary(type: type)
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(type: PhotoTyoe )
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.view.tag = type.rawValue
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary(type: PhotoTyoe )
    {
        imagePicker.view.tag = type.rawValue
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.videoQuality = .typeLow
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    fileprivate func base64EncodedString(image: UIImage?) -> String {
        guard let image = image,
            let imageData = UIImagePNGRepresentation(image) else {
                return ""
        }
        let str = imageData.base64EncodedString(options: .endLineWithCarriageReturn)
        
        return "data:image/png;base64," + str

    }
}

extension AddNewGuestViewController : UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField == txtVisit {
//            //            let calender = CalendarDateRangePickerViewController(collectionViewLayout: UICollectionViewFlowLayout())
//            //            calender.delegate = self
//            //            calenderNavigationController = UINavigationController(rootViewController: calender)
//            //            self.navigationController?.present(calenderNavigationController!, animated: true, completion: nil)
//        }
//    }
}

extension AddNewGuestViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == relationPicker {
            return appDelegate.arrReleationList.count
        }
        return appDelegate.arrWeeks.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == relationPicker {
            return appDelegate.arrReleationList[row].relationname
        }
        return appDelegate.arrWeeks[row].weak
    }
}

extension AddNewGuestViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == relationPicker, appDelegate.arrReleationList.count > row {
            selectedRelation = appDelegate.arrReleationList[row]
            txtRelation.text = selectedRelation?.relationname
        } else if appDelegate.arrWeeks.count > row {
            selectedWeek = appDelegate.arrWeeks[row]
            txtDuration.text = selectedWeek?.weak
            updateVisitDate()
        }
    }
}

extension AddNewGuestViewController : UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerEditedImage] as? UIImage
        if picker.view.tag == PhotoTyoe.PhotoID.rawValue {
            photoIDImageView.image = originalImage
        } else if (picker.view.tag == PhotoTyoe.GuestPhoto.rawValue) {
            guestPhotoImageView.image = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AddNewGuestViewController : UINavigationControllerDelegate {
    
}
