import UIKit
import Alamofire
import AlamofireImage
import Popover
import PINRemoteImage
import IQKeyboardManagerSwift
import FLAnimatedImage

class ProfileViewsController: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var switchBocawestAdd: UISwitch!
    @IBOutlet weak var lblShowHideProfilePhoto: UILabel!
    @IBOutlet weak var lblBocawestAdd: UILabel!
    @IBOutlet weak var lblBocawestAdd1: UILabel!
    @IBOutlet weak var lblBocawestAdd2: UILabel!
    @IBOutlet weak var switchVillage: UISwitch!
    @IBOutlet weak var lblVillageName: UILabel!
    @IBOutlet weak var txtVillageNameValue: UITextField!
    @IBOutlet weak var viewProfileTopView: UIView!
    @IBOutlet weak var heightMarketOptionsCollectionView: NSLayoutConstraint!
    @IBOutlet weak var heightMyInterestCollection: NSLayoutConstraint!
    @IBOutlet weak var myInterestCollectionView: UICollectionView!
    @IBOutlet weak var editProfileViewHeight: NSLayoutConstraint!
    @IBOutlet weak var marketOptionsCollectionView: UICollectionView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var imgProfilePic: FLAnimatedImageView!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnChangePassword: UIButton!
    @IBOutlet weak var lblShowHideMyProfile: UILabel!
    
    @IBOutlet weak var lblSuffix: UILabel!
    @IBOutlet weak var txtSuffix: UITextField!
    
    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var lblPrefix: UILabel!
    @IBOutlet weak var lblEditFirstName: UILabel!
    @IBOutlet weak var txtFirstName: UITextField!
    
    @IBOutlet weak var lblMiddleName: UILabel!
    
    @IBOutlet weak var txtMiddelname: UITextField!
    
    @IBOutlet weak var lblLastName: UILabel!
    
    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var lblDisplayName: UILabel!
    
    @IBOutlet weak var txtDisplayName: UITextField!
    
    @IBOutlet weak var lblHomePhone: UILabel!
    
    @IBOutlet weak var txtHomePhone: UITextField!
    
    @IBOutlet weak var switchHomePhone: UISwitch!
    
    @IBOutlet weak var lblCellPhone: UILabel!
    
    @IBOutlet weak var txtCellPhone: UITextField!
    
    @IBOutlet weak var switchCellPhone: UISwitch!
    
    @IBOutlet weak var lblOtherPhone: UILabel!
    @IBOutlet weak var txtOtherPhone: UITextField!
    
    @IBOutlet weak var switchOtherPhone: UISwitch!
    
    @IBOutlet weak var lblEditPrimaryEmail: UILabel!
    
    @IBOutlet weak var txtEditPrimaryEmail: UITextField!
    
    @IBOutlet weak var switchPrimaryEmail: UISwitch!
    
    @IBOutlet weak var lblEditSecondaryEmail: UILabel!
    
    @IBOutlet weak var txtEditSecondaryEmail: UITextField!
    
    @IBOutlet weak var switchSecondaryEmail: UISwitch!
    
    @IBOutlet weak var lblTurnNotification: UILabel!
    
    
    @IBOutlet weak var lblNotificationPrimaryEamil: UILabel!
    
    @IBOutlet weak var switchPrimaryEmailNotification: UISwitch!
    
    @IBOutlet weak var lblSecondaryEmailNotification: UILabel!
    
    @IBOutlet weak var switchSecondaryNotification: UISwitch!
    
    
    @IBOutlet weak var lblSendStatementTo: UILabel!
    
    @IBOutlet weak var txtEditSendStatementsTo: UITextField!
    
    @IBOutlet weak var lblEditSendMagazineTo: UILabel!
    
    @IBOutlet weak var txtEditSendMagazineTo: UITextField!
    
    @IBOutlet weak var lblEditAddressOther: UILabel!
    
    @IBOutlet weak var lblEditStreetAdd1: UILabel!
    
    @IBOutlet weak var txtEditStreetAdd1: UITextField!
    
    @IBOutlet weak var lblEDitStreetAdd2: UILabel!
    
    @IBOutlet weak var txtEditStreetAdd2: UITextField!
    
    @IBOutlet weak var lblEditOtherCityAdd: UILabel!
    
    @IBOutlet weak var txtEditOtherCityAdd: UITextField!
    
    @IBOutlet weak var lblEditOtherState: UILabel!
    
    @IBOutlet weak var txtEditOtherState: UITextField!
    
    @IBOutlet weak var lblEditPostalCodeOther: UILabel!
    
    @IBOutlet weak var txtEditPostalCodeOther: UITextField!
    
    @IBOutlet weak var lblEditCountryOther: UILabel!
    
    @IBOutlet weak var txtEDitCountryOther: UITextField!
    @IBOutlet weak var switchAddressOther: UISwitch!
    
    
    @IBOutlet weak var lblEditAddressBussiness: UILabel!
    
    @IBOutlet weak var switchAddressBussiness: UISwitch!
    
    @IBOutlet weak var lblEditStreetAdd1Buss: UILabel!
    @IBOutlet weak var txtEditStreetAdd1Buss: UITextField!
    
    @IBOutlet weak var lblEditStreetAdd2Buss: UILabel!
    
    @IBOutlet weak var txtEditStreetAdd2Buss: UITextField!
    
    @IBOutlet weak var lblEditCityBuss: UILabel!
    
    @IBOutlet weak var txtEditCityBuss: UITextField!
    
    
    @IBOutlet weak var lblEditStateBuss: UILabel!
    
    @IBOutlet weak var txtEditStateBuss: UITextField!
    
    @IBOutlet weak var lblPostalCode: UILabel!
    
    @IBOutlet weak var txtEditPostalCodeBuss: UITextField!
    
    @IBOutlet weak var lblEditCountryBuss: UILabel!
    
    @IBOutlet weak var txtEditCountryNuss: UITextField!
    
    @IBOutlet weak var btnOutsideUSOther: UIButton!
    @IBOutlet weak var btnOutsideUSBussiness: UIButton!
    
    
    
    @IBOutlet weak var lblEditMyInterest: UILabel!
    
    @IBOutlet weak var lblEditTargetedMarketting: UILabel!
    
    @IBOutlet weak var btnSend: UIButton!

    
    @IBOutlet weak var switchMyProfilePhoto: UISwitch!
    @IBOutlet weak var switchMyprofile: UISwitch!
    @IBOutlet weak var lblUserNameEdit: UILabel!
    
    @IBOutlet weak var txtEditUserID: UITextField!
    @IBOutlet weak var lblEditVersion: UILabel!
    @IBOutlet weak var lblEditBottomIDAndName: UILabel!
    
    @IBOutlet weak var lblBirthday: UILabel!
    @IBOutlet weak var textBirthday: UITextField!
    @IBOutlet weak var switchBirthday: UISwitch!
    
    //Added by kiran V2.7 -- ENGAGE0011559 -- International number change
    //ENGAGE0011559 -- Start
    @IBOutlet weak var ViewInternationalNumber: UIView!
    @IBOutlet weak var lblInternationalNumber: UILabel!
    @IBOutlet weak var chkBoxInternationalNumber: UIButton!
    //Button placed on lblInternational number.
    @IBOutlet weak var btnLblInternationalNumber: UIButton!
    
    @IBOutlet weak var lblInternationalNumberNote: UILabel!
    //ENGAGE0011559 -- End
    
    
    
    
    fileprivate var sufixPicker: UIPickerView? = nil;
    fileprivate var prefixPicker : UIPickerView? = nil;
    fileprivate var statesPickerOther : UIPickerView? = nil;
    fileprivate var statesPickerBussiness : UIPickerView? = nil;

    
    fileprivate var sendSatetmentsTo: UIPickerView? = nil;
    fileprivate var sendMagazineTo: UIPickerView? = nil;

    fileprivate var selectedSufix: Suffix? = nil
    fileprivate var selectedPrefix: Prefix? = nil
    
    fileprivate var selectedsendSatetmentsTo: AddressTypes? = nil
    fileprivate var selectedMagazineTo: AddressTypes? = nil
    fileprivate var selectedStatesOther: States? = nil
    fileprivate var selectedStatesBussiness: States? = nil

    
    
    var allMarkettingOptions = [[AllMarkettingOtions]]()
    var arrNewMarketOptions = [TargetedMarketingOption]()

    var arrBrokenRules = [BrokenRulesModel]()

    var localPath: String?
    var arrInterest :[String] = []
    var arrMarketOptions  = [TargetedMarketingOption]()
    var isOutsideUSOther : Int?
    var isOutsideUSBussiness : Int?
    var selectedStatement : String?
    var selectedMagazine : String?
    var isFrom : String?
    
    var selectedMarketOptions = [Dictionary<String, Any>]()

    @IBAction func saveBtnTapped(_ sender: UIButton) {
        


 
        
    }
    
    func setCardView(view : UIView){
        
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = 1;
        view.layer.shadowRadius = 2;
        view.layer.shadowOpacity = 0.5;
        
    }
    
    var btnUploadPic: UIButton!
    var libraryEnabled: Bool = true
    var croppingEnabled: Bool = false
    var allowResizing: Bool = true
    var allowMoving: Bool = true
    var minimumSize: CGSize = CGSize(width: 60, height: 60)
    var tmpHTMLimage: String!
    var cameraIcon: UIImage!
    
    @IBOutlet weak var uiScrollView: UIScrollView!
    @IBOutlet weak var uiViewbgprofilepic: UIView!
    @IBOutlet weak var lblMembername: UILabel!
    //@IBOutlet weak var lblMemberactive: UILabel!
    @IBOutlet weak var lblMemberId: UILabel!
    
    var imagePicker = UIImagePickerController()
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    //    var arrgetMemberInfo = [GetMemberInfo]()
    
    var dictmemberInfo = GetMemberInfo()
    
    //Added on 4th July 2020 V2.2
    private let accessManager = AccessManager.shared
    
    //Commented by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead
    //ENGAGE0011419 -- Start
//    func verifyUrl(urlString: String?) -> Bool {
//        if let urlString = urlString {
//            if let url = URL(string: urlString) {
//                return UIApplication.shared.canOpenURL(url)
//            }
//        }
//        return false
//    }
    //ENGAGE0011419 -- End
    
    func initFontForViews()
    {
       
        self.lblMembername.font = SFont.SourceSansPro_Regular18
        self.lblMemberId.font = SFont.SourceSansPro_Regular18
     //   self.lblMemberactive.font = SFont.SourceSansPro_Regular18
        
        //Added by kiran V2.7 -- ENGAGE0011559 -- International number change
        //ENGAGE0011559 -- Start
        self.lblInternationalNumber.font = AppFonts.regular16
        self.lblInternationalNumberNote.font = AppFonts.regular16
        //ENGAGE0011559 -- End
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Added on 4th July 2020 V2.2
        //Added roles adn preferences chanegs
        switch self.accessManager.accessPermision(for: .profile){
        case .view:
            if let message = self.appDelegate.masterLabeling.role_Validation2 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
        default:
            break
        }
        
        self.initFontForViews()
        
        self.initController()
        
       
    
        sufixPicker = UIPickerView()
        sufixPicker?.dataSource = self
        sufixPicker?.delegate = self
        txtSuffix.inputView = sufixPicker
        txtSuffix.delegate = self
        
        prefixPicker = UIPickerView()
        prefixPicker?.dataSource = self
        prefixPicker?.delegate = self
        txtTitle.inputView = prefixPicker
        txtTitle.delegate = self
        
        statesPickerOther = UIPickerView()
        statesPickerOther?.dataSource = self
        statesPickerOther?.delegate = self
        
        txtEditOtherState.inputView = statesPickerOther

        statesPickerBussiness = UIPickerView()
        statesPickerBussiness?.dataSource = self
        statesPickerBussiness?.delegate = self
        
        txtEditStateBuss.inputView = statesPickerBussiness
        

        sendSatetmentsTo = UIPickerView()
        sendMagazineTo = UIPickerView()
        sendMagazineTo?.dataSource = self
        sendMagazineTo?.delegate = self

        sendSatetmentsTo?.dataSource = self
        sendSatetmentsTo?.delegate = self
        txtEditSendStatementsTo.inputView = sendSatetmentsTo
        txtEditSendMagazineTo.inputView = sendMagazineTo
        txtEditSendStatementsTo.delegate = self
        txtEditSendMagazineTo.delegate = self
        txtEditStateBuss.delegate = self
        txtEditOtherState.delegate = self
        
        txtTitle.setRightIcon(imageName: "Path 1847")
        txtSuffix.setRightIcon(imageName: "Path 1847")
        txtEditSendMagazineTo.setRightIcon(imageName: "Path 1847")
        txtEditSendStatementsTo.setRightIcon(imageName: "Path 1847")
        txtEditOtherState.setRightIcon(imageName: "Path 1847")
       
        txtEditStateBuss.setRightIcon(imageName: "Path 1847")
        isOutsideUSBussiness = 0
        isOutsideUSOther = 0
        self.txtCellPhone.delegate = self
        self.txtHomePhone.delegate = self
        self.txtOtherPhone.delegate = self
        self.txtEditPostalCodeBuss.delegate = self
        self.txtEditPostalCodeOther.delegate = self
        
        

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = true
        
       

        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
        
        //Added by kiran V1.3 -- PROD0000036 -- removing place holder image set in storyboard
        //PROD0000036 -- Start
        self.imgProfilePic.image = nil
        //PROD0000036 -- End

    }
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        txtFirstName.resignFirstResponder()
        txtSuffix.resignFirstResponder()
        txtTitle.resignFirstResponder()
        txtMiddelname.resignFirstResponder()
        txtLastName.resignFirstResponder()
        txtDisplayName.resignFirstResponder()
        txtHomePhone.resignFirstResponder()
        txtCellPhone.resignFirstResponder()
        txtOtherPhone.resignFirstResponder()
        txtEditPrimaryEmail.resignFirstResponder()
        txtEditSecondaryEmail.resignFirstResponder()
        txtEditSendStatementsTo.resignFirstResponder()
        txtEditSendMagazineTo.resignFirstResponder()
        txtEditStreetAdd1.resignFirstResponder()
        txtEditStreetAdd2.resignFirstResponder()
        txtEditCityBuss.resignFirstResponder()
        txtEditOtherState.resignFirstResponder()
        txtEDitCountryOther.resignFirstResponder()
        txtEditPostalCodeOther.resignFirstResponder()
        txtEditStreetAdd1Buss.resignFirstResponder()
        txtEditStreetAdd2Buss.resignFirstResponder()
        txtEditOtherCityAdd.resignFirstResponder()
        txtEditStateBuss.resignFirstResponder()
        txtEditCountryNuss.resignFirstResponder()
        txtEditPostalCodeBuss.resignFirstResponder()
        
    }
    

    func initController()
    {
        switchBirthday.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        switchVillage.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        switchMyprofile.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        switchMyProfilePhoto.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        switchHomePhone.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        switchCellPhone.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        switchOtherPhone.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        switchPrimaryEmail.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        switchSecondaryEmail.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        switchPrimaryEmailNotification.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        switchSecondaryNotification.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        switchAddressBussiness.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        switchAddressOther.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        switchBocawestAdd.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
        
        //Added by kiran V2.7 -- ENGAGE0011559 -- International number change
        //ENGAGE0011559 -- Start
        self.chkBoxInternationalNumber.setImage(UIImage.init(named: "CheckBox_uncheck"), for: .normal)
        self.lblInternationalNumber.textColor = APPColor.textColor.profileScreenTextLbl
        self.lblInternationalNumberNote.textColor = APPColor.textColor.profileScreenTextLbl
        
        self.lblInternationalNumber.text = self.appDelegate.masterLabeling.outside_US_Contact
        self.lblInternationalNumberNote.text = self.appDelegate.masterLabeling.outside_US_Contact_Text
        //ENGAGE0011559 -- End
        
        //navigation item label color
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = self.appDelegate.masterLabeling.tT_PROFILE
        self.navigationController?.navigationBar.backItem?.title = self.appDelegate.masterLabeling.bACK
        
        self.lblVillageName.text = self.appDelegate.masterLabeling.vILLAGENAME ?? ""
        self.lblBirthday.text = self.appDelegate.masterLabeling.bIRTHDAY ?? ""
        self.lblUserNameEdit.text = self.appDelegate.masterLabeling.username
        self.lblShowHideMyProfile.text = self.appDelegate.masterLabeling.show_or_hide_myprofile
        self.lblPrefix.text = self.appDelegate.masterLabeling.prefix

        self.lblSuffix.text = self.appDelegate.masterLabeling.suffix
        self.lblEditFirstName.text = self.appDelegate.masterLabeling.first_Name
        self.lblMiddleName.text = self.appDelegate.masterLabeling.middle_name
        self.lblLastName.text = self.appDelegate.masterLabeling.last_Name
        self.lblDisplayName.text = self.appDelegate.masterLabeling.dISPLAY_NAME
        self.lblHomePhone.text = self.appDelegate.masterLabeling.hOME_PHONE
        self.lblCellPhone.text = self.appDelegate.masterLabeling.cELL_PHONE
        self.lblEditPrimaryEmail.text = self.appDelegate.masterLabeling.pRIMARY_EMAIL_ASTERISK
        self.lblEditSecondaryEmail.text = self.appDelegate.masterLabeling.sECONDARY_EMAIL
        self.lblTurnNotification.text = self.appDelegate.masterLabeling.turn_email_notification
        self.lblNotificationPrimaryEamil.text = self.appDelegate.masterLabeling.pRIMARY_EMAIL
        self.lblSecondaryEmailNotification.text = self.appDelegate.masterLabeling.sECONDARY_EMAIL
        self.lblSendStatementTo.text = self.appDelegate.masterLabeling.send_statements_to
        self.lblEditSendMagazineTo.text = self.appDelegate.masterLabeling.send_magazines_to
        
        self.lblEditAddressOther.text = self.appDelegate.masterLabeling.address_other
        self.lblEditStreetAdd1.text = self.appDelegate.masterLabeling.street_address_1
        self.lblEDitStreetAdd2.text = self.appDelegate.masterLabeling.street_address_2
        self.lblEditOtherCityAdd.text = self.appDelegate.masterLabeling.cITY
        self.lblOtherPhone.text = self.appDelegate.masterLabeling.other_phone
        self.lblEditOtherState.text = self.appDelegate.masterLabeling.state_or_Province
        self.lblEditPostalCodeOther.text = self.appDelegate.masterLabeling.postal_code
        self.lblEditCountryOther.text = self.appDelegate.masterLabeling.cOUNTY
        self.btnOutsideUSOther .setTitle(self.appDelegate.masterLabeling.outside_us, for: UIControlState.normal)
        self.lblEditMyInterest.text = self.appDelegate.masterLabeling.my_Interest
        self.lblEditAddressBussiness.text = self.appDelegate.masterLabeling.address_bussiness
        self.lblEditStreetAdd1Buss.text = self.appDelegate.masterLabeling.street_address_1
        self.lblEditStreetAdd2Buss.text = self.appDelegate.masterLabeling.street_address_2
        self.lblEditCityBuss.text = self.appDelegate.masterLabeling.cITY
        self.lblEditStateBuss.text = self.appDelegate.masterLabeling.state_or_Province
        self.lblPostalCode.text = self.appDelegate.masterLabeling.postal_code
        self.lblEditCountryBuss.text = self.appDelegate.masterLabeling.cOUNTY
        self.btnOutsideUSBussiness .setTitle(self.appDelegate.masterLabeling.outside_us, for: UIControlState.normal)
        self.lblEditTargetedMarketting.text = self.appDelegate.masterLabeling.targetting_market_option
        self.btnSend .setTitle(self.appDelegate.masterLabeling.Save, for: UIControlState.normal)
        self.btnCancel .setTitle(self.appDelegate.masterLabeling.cANCEL, for: UIControlState.normal)
        self.lblShowHideProfilePhoto.text = self.appDelegate.masterLabeling.sHOWHIDE_PROFILEPHOTO
        

        self.getMemberInfoApi()
        self.memeberInterestApi()

        
        self.uiViewbgprofilepic.backgroundColor = APPColor.navigationColor.barbackgroundcolor
        self.imgProfilePic.layer.cornerRadius = self.imgProfilePic.frame.size.width / 2
        self.imgProfilePic.layer.masksToBounds = true
        self.imgProfilePic.layer.borderColor = UIColor.white.cgColor
        self.imgProfilePic.layer.borderWidth = 1.0

        self.btnUploadPic = UIButton.init(frame: CGRect(x: self.imgProfilePic.frame.size.width - 17, y:self.imgProfilePic.frame.size.height - 8 , width: 44, height: 44))
       
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction(tapGestureRecognizer:)))
        self.imgProfilePic.isUserInteractionEnabled = true
        cameraIcon = UIImage(named: "icon_camera_profile")
        self.btnUploadPic .setBackgroundImage(cameraIcon, for: .normal)
        self.view.addSubview(btnUploadPic)
        self.btnUploadPic.addTarget(self, action:#selector(tapFunction(tapGestureRecognizer:)), for: .touchUpInside)
        
        

        self.imgProfilePic.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        self.btnCancel.layer.cornerRadius = 20
        self.btnCancel.layer.masksToBounds = true
        self.btnCancel.layer.borderColor =  APPColor.tintColor.tintNew.cgColor
        self.btnCancel.layer.borderWidth = 1

        
        self.btnChangePassword.layer.cornerRadius = 17
        self.btnChangePassword.layer.masksToBounds = true
        self.btnChangePassword.layer.borderColor =  APPColor.tintColor.changePassword.cgColor
        self.btnChangePassword.layer.borderWidth = 1
        self.btnChangePassword.setTitle(self.appDelegate.masterLabeling.change_password, for: UIControlState.normal)


        viewProfileTopView.layer.shadowColor = UIColor.black.cgColor
        viewProfileTopView.layer.shadowOpacity = 0.16
        viewProfileTopView.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewProfileTopView.layer.shadowRadius = 2
        
        self.btnCancel.setStyle(style: .outlined, type: .primary)
        self.btnSend.setStyle(style: .contained, type: .primary)

        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
        self.mandatoryfileds()
        
        
    }
    func mandatoryfileds(){
        
        let cellPhoneLabel: NSMutableAttributedString = NSMutableAttributedString(string: self.lblCellPhone.text!)
        cellPhoneLabel.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblCellPhone.attributedText = cellPhoneLabel
        
        let othelPhoneLabel: NSMutableAttributedString = NSMutableAttributedString(string: self.lblOtherPhone.text!)
        othelPhoneLabel.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblOtherPhone.attributedText = othelPhoneLabel
        
        let primaryEmail: NSMutableAttributedString = NSMutableAttributedString(string: self.lblEditPrimaryEmail.text!)
        primaryEmail.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblEditPrimaryEmail.attributedText = primaryEmail
        
        let secEmailLabel: NSMutableAttributedString = NSMutableAttributedString(string: self.lblEditSecondaryEmail.text!)
        secEmailLabel.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblEditSecondaryEmail.attributedText = secEmailLabel
        
    }
    
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        heightMarketOptionsCollectionView.constant = marketOptionsCollectionView.contentSize.height
        heightMyInterestCollection.constant = myInterestCollectionView.contentSize.height

        //Modified by kiran V2.7 -- ENGAGE0011559 -- Added international number view height. added 80 height as version number is not visible in the screen.
        //ENGAGE0011559 -- Start
        self.editProfileViewHeight.constant = 2800 + heightMarketOptionsCollectionView.constant + heightMyInterestCollection.constant + (self.ViewInternationalNumber.isHidden ? 0 : self.ViewInternationalNumber.frame.height) + 80
        //ENGAGE0011559 -- End
        uiScrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height:self.editProfileViewHeight.constant)
        
    }
  
    @objc func tapFunction(tapGestureRecognizer: UITapGestureRecognizer) {
        
        //Added on 4th July 2020 V2.2
        //Added roles and privilages changes
        
        switch self.accessManager.accessPermision(for: .profile){
        case .view:
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        default:
            break
        }
        
        let alertController = UIAlertController(title:
            "Cobalt Engage", message: "Wants to use your", preferredStyle: .actionSheet)
        let actionCamera = UIAlertAction(title: self.appDelegate.masterLabeling.cAMERA, style: .default, handler: { (action:UIAlertAction) in
            self.imagePicker = UIImagePickerController()
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing  = true
            self.imagePicker.sourceType = .camera
            self.imagePicker.modalPresentationStyle = .overCurrentContext
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        let actionPhoto = UIAlertAction(title: self.appDelegate.masterLabeling.gALLERY, style: .default) { (action:UIAlertAction) in
            self.imagePicker = UIImagePickerController()
            self.imagePicker.allowsEditing  = true
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.modalPresentationStyle = .overCurrentContext
            
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: self.appDelegate.masterLabeling.cANCEL, style: .cancel) { (action:UIAlertAction) in
            //            self.dismiss(animated: true, completion: nil)
            self.imagePicker.parent?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(actionCamera)
        alertController.addAction(actionPhoto)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
        //        imagePicker.parent?.dismiss(animated: true, completion: nil)
        
    }
    
    //Added by kiran V2.7 -- ENGAGE0011559 -- International number change
    //ENGAGE0011559 -- Start
    //This is used for the both check box button and for the button place on the text.
    @IBAction func InternationalNumberClicked(_ sender: UIButton)
    {
        self.dismissKeyboard(UITapGestureRecognizer())
        
        self.chkBoxInternationalNumber.isSelected = !self.chkBoxInternationalNumber.isSelected
        self.setInternationalNumberChkBoxImage(sender: self.chkBoxInternationalNumber)
        self.customisePhoneNumberKeyboard(outsideUS: self.chkBoxInternationalNumber.isSelected,updateNumbers: true)
    }
    //ENGAGE0011559 -- End
    //Mark- Upload image Api
    func uploadImage(img: UIImage){
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        let imageopicked: UIImage = img
       
        
        
        // insert this into your HTML code
        //        let tmpHTMLimage  = "<img class=\"no-show\" src=\"data:image/png;base64," + imageStr + "\" alt=\"Image\"  height=\"80\" width=\"80\"/>"
        
        //        let base64Image =
       // let imhgg =
        
        if let imageData = imageopicked.jpeg(.lowest) {
           // let imageDataa: NSData = UIImagePNGRepresentation(imageData)! as NSData
            let imageStr = imageData.base64EncodedString(options:.endLineWithCarriageReturn)
            tmpHTMLimage  = "data:image/jpeg;base64," + imageStr

        }
        
        let parameters:[String: Any] = [
            "FilePath": "",
            "FromWhere":"UploadControl",
            "ID":UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            "Image":tmpHTMLimage,
            "MemberID":UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            "DeviceInfo":[APIHandler.devicedict]
        ]
        
      //  print(parameters)
        APIHandler.sharedInstance.uploadProfilePicture(paramater: parameters, onSuccess: { (ProfileictureData) in
            let memberprofilepic = ProfileictureData.filePath
            
            
            let prefs = UserDefaults.standard
            
            prefs.removeObject(forKey:"userProfilepic")
            
            UserDefaults.standard.set(memberprofilepic, forKey: UserDefaultsKeys.userProfilepic.rawValue)
            //Added by kiran V2.5 -- ENGAGE0011378 -- Fix for member image not updating in change password screen when navigation to change password screen after uploading the image.
            //Start -- ENGAGE0011378
            self.dictmemberInfo.profilePic = memberprofilepic
            //End -- ENGAGE0011378
            self.appDelegate.hideIndicator()
            
            SharedUtlity.sharedHelper().showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.pROFILE_UPDATED_SUCCESSFULLY ?? " ", withDuration: Duration.kShortDuration)
            
            
        }, onFailure: { error  in
            self.appDelegate.hideIndicator()
            print(error)
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
        })
        
    }
    
    
    
   
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtTitle{
            self.prefixPicker?.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(prefixPicker!, didSelectRow: 0, inComponent: 0)
        }
        if textField == txtSuffix{
            self.sufixPicker?.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(sufixPicker!, didSelectRow: 0, inComponent: 0)
        }
        if textField == txtEditSendStatementsTo{
            self.sendSatetmentsTo?.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(sendSatetmentsTo!, didSelectRow: 0, inComponent: 0)
        }
        if textField == txtEditSendMagazineTo{
            self.sendMagazineTo?.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(sendMagazineTo!, didSelectRow: 0, inComponent: 0)
        }
        if textField == txtEditOtherState{
            if (isOutsideUSOther == 0) {
            self.statesPickerOther?.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(statesPickerOther!, didSelectRow: 0, inComponent: 0)
            }
        }
        if textField == txtEditStateBuss{
            
            if(isOutsideUSBussiness == 0){
            self.statesPickerBussiness?.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(statesPickerBussiness!, didSelectRow: 0, inComponent: 0)
           }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == txtTitle) || (textField == txtSuffix) || (textField == txtEditSendStatementsTo){
            return false
        }
        else if textField == self.txtCellPhone || textField == self.txtOtherPhone || textField == self.txtHomePhone || textField == self.txtEditPostalCodeBuss || textField == self.txtEditPostalCodeOther
        {
            //Added by kiran V2.7 -- ENGAGE0011559 -- international Number change
            //ENGAGE0011559 -- Start
            if (textField == self.txtCellPhone || textField == self.txtOtherPhone || textField == self.txtHomePhone) && self.chkBoxInternationalNumber.isSelected
            {
                //backspace
                if string == ""
                {
                    return true
                }
                return (textField.text?.count ?? 0 < (self.appDelegate.masterLabeling.outside_US_Contact_Limit ?? 0))
            }
            //ENGAGE0011559 -- End
            let str = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            
            if textField == txtCellPhone{
                
                return checkCellPhoneNumberFormat(string: string, str: str)
                
            }else if textField == txtHomePhone{
                
                return checkHomePhoneNumberFormat(string: string, str: str)
                
            }else if textField == txtOtherPhone{
                
                return checkOtherPhoneNumberFormat(string: string, str: str)
                
            }else if textField == txtEditPostalCodeBuss{
                if isOutsideUSBussiness == 1{
                    return checkPostalCodeForOutsideUSAFormat(string: string, str: str)
                }else{
                    return checkPostalCodeFormat(string: string, str: str)

                }


            }
            else if textField == txtEditPostalCodeOther{
                if isOutsideUSOther == 1{
                    return checkPostalCodeForOutsideUSAFormat(string: string, str: str)
                }else{
                    return checkPostalCodeOtherFormat(string: string, str: str)
                    
                }
                
                
            }
            return true
        }
        else{
            return true
        }
    
    }
    func checkPostalCodeFormat(string: String?, str: String?) -> Bool{
        
        if string == ""{ //BackSpace
            
            return true
            
        }else if str!.characters.count  == 6{
            
            txtEditPostalCodeBuss.text = txtEditPostalCodeBuss.text! + "-"
        }else if str!.characters.count > 10{
            
            return false
        }
        return true
    }
    func checkPostalCodeOtherFormat(string: String?, str: String?) -> Bool{
        
        if string == ""{ //BackSpace
            
            return true
            
        }else if str!.characters.count  == 6{
            
            txtEditPostalCodeOther.text = txtEditPostalCodeOther.text! + "-"
        }else if str!.characters.count > 10{
            
            return false
        }
        return true
    }
    func checkPostalCodeForOutsideUSAFormat(string: String?, str: String?) -> Bool{
        
        if string == ""{ //BackSpace
            
            return true
            
        }else if str!.characters.count > 7{
            
            return false
        }
        return true
    }
    
    func checkCellPhoneNumberFormat(string: String?, str: String?) -> Bool{
        
        if string == ""{ //BackSpace
            
            return true
            
        }else if str!.characters.count  == 4{
            
            txtCellPhone.text = txtCellPhone.text! + "-"
        }else if str!.characters.count == 8{
            txtCellPhone.text = txtCellPhone.text! + "-"
            
        }else if str!.characters.count > 12{
            
            return false
        }
        return true
    }
    
    func checkHomePhoneNumberFormat(string: String?, str: String?) -> Bool{
        
        if string == ""{ //BackSpace
            
            return true
            
        }else if str!.characters.count  == 4{
            
            txtHomePhone.text = txtHomePhone.text! + "-"
        }else if str!.characters.count == 8{
            txtHomePhone.text = txtHomePhone.text! + "-"
            
        }else if str!.characters.count > 12{
            
            return false
        }
        return true
    }
    func checkOtherPhoneNumberFormat(string: String?, str: String?) -> Bool{
        
        if string == ""{ //BackSpace
            
            return true
            
        }else if str!.characters.count  == 4{
            
            txtOtherPhone.text = txtOtherPhone.text! + "-"
        }else if str!.characters.count == 8{
            txtOtherPhone.text = txtOtherPhone.text! + "-"
            
        }else if str!.characters.count > 12{
            
            return false
        }
        return true
    }
    //MARK:- Imagepicker controller delegate methods
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imgTemp = info[UIImagePickerControllerEditedImage] as? UIImage// get image from imagePickerViewController
        self.imgProfilePic.image = imgTemp
        self.uploadImage(img: imgTemp!)
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:- Member Info  Api
    func getMemberInfoApi() -> Void {
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)

            let dict:[String: Any] = [
                APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "From" : "PF"
            ]
            
            
            APIHandler.sharedInstance.getMemberInfoApi(paramater: dict, onSuccess: { arrgetMemberInfo in
                self.appDelegate.hideIndicator()
                print(arrgetMemberInfo)
                self.dictmemberInfo = arrgetMemberInfo
                self.lblMembername.text = arrgetMemberInfo.displayName ?? ""
                
                
                self.lblMemberId.text =  (self.appDelegate.masterLabeling.hASH ?? "") + (arrgetMemberInfo.memberMasterID ?? "" )
                self.txtEditUserID.text = arrgetMemberInfo.username ?? ""
                self.txtTitle.text = arrgetMemberInfo.prefix ?? ""
                self.txtSuffix.text = arrgetMemberInfo.suffix ?? ""
                self.txtFirstName.text = arrgetMemberInfo.firstName ?? ""
                self.txtMiddelname.text = arrgetMemberInfo.middleName ?? ""
                self.txtLastName.text = arrgetMemberInfo.lastName ?? ""
                self.txtDisplayName.text = arrgetMemberInfo.displayName ?? ""
                self.txtHomePhone.text = arrgetMemberInfo.primaryPhone ?? ""
                self.txtCellPhone.text = arrgetMemberInfo.secondaryPhone ?? ""
                self.txtOtherPhone.text = arrgetMemberInfo.alternatePhone ?? ""
                self.txtEditPrimaryEmail.text = arrgetMemberInfo.primaryEmail ?? ""
                self.txtEditSecondaryEmail.text = arrgetMemberInfo.secondaryEmail ?? ""
                self.txtEditSendStatementsTo.text = arrgetMemberInfo.sendSatements ?? ""
                self.txtEditSendMagazineTo.text = arrgetMemberInfo.sendmagazine ?? ""
                self.txtEditStreetAdd1.text = arrgetMemberInfo.address![1].street1 ?? ""
                self.txtEditStreetAdd2.text = arrgetMemberInfo.address![1].street2 ?? ""
                self.txtEditOtherCityAdd.text = arrgetMemberInfo.address![1].city ?? ""
                self.txtEditOtherState.text = arrgetMemberInfo.address![1].state ?? ""
                self.txtEditPostalCodeOther.text = arrgetMemberInfo.address![1].zip ?? ""
                self.txtEDitCountryOther.text = arrgetMemberInfo.address![1].country ?? ""
                self.txtEditStreetAdd1Buss.text = arrgetMemberInfo.address![2].street1 ?? ""
                self.txtEditStreetAdd2Buss.text = arrgetMemberInfo.address![2].street2 ?? ""
                self.txtEditCityBuss.text = arrgetMemberInfo.address![2].city ?? ""
                self.txtEditStateBuss.text = arrgetMemberInfo.address![2].state ?? ""
                self.txtEditPostalCodeBuss.text = arrgetMemberInfo.address![2].zip ?? ""
                self.txtEditCountryNuss.text = arrgetMemberInfo.address![2].country ?? ""
                self.txtVillageNameValue.text = arrgetMemberInfo.village ?? ""
                self.textBirthday.text = arrgetMemberInfo.dateOfBirth ?? ""
                
                self.lblBocawestAdd.text = self.appDelegate.masterLabeling.address_bocawest
                self.lblBocawestAdd1.text = arrgetMemberInfo.address![0].street1 ?? ""
                
                
                self.lblBocawestAdd2.text = arrgetMemberInfo.address![0].fullBWAddress ?? ""
                if(self.lblBocawestAdd2.text == "  , "){
                    self.lblBocawestAdd2.text = ""
                }
                
                if arrgetMemberInfo.showBocaAddress == 1{
                    self.switchBocawestAdd.isOn = true
                }
                else{
                    self.switchBocawestAdd.isOn = false
                }
                
                if arrgetMemberInfo.showBirthday == 1{
                    self.switchBirthday.isOn = true
                }
                else
                {
                    self.switchBirthday.isOn = false
                }
                
                if arrgetMemberInfo.showVillageName == 1{
                    self.switchVillage.isOn = true
                }
                else{
                    self.switchVillage.isOn = false
                }
                
                if arrgetMemberInfo.showHomePhone == 1{
                self.switchHomePhone.isOn = true
                }
                else{
                    self.switchHomePhone.isOn = false
                }
                if arrgetMemberInfo.showCellPhone == 1{
                    self.switchCellPhone.isOn = true
                }
                else{
                    self.switchCellPhone.isOn = false
                }
                if arrgetMemberInfo.showOtherPhone == 1{
                    self.switchOtherPhone.isOn = true
                }
                else{
                    self.switchOtherPhone.isOn = false
                }
                if arrgetMemberInfo.showMyProfile == 1{
                    self.switchMyprofile.isOn = true
                }
                else{
                    self.switchMyprofile.isOn = false
                }
                if arrgetMemberInfo.showProfilePhoto == 1{
                    self.switchMyProfilePhoto.isOn = true
                }
                else{
                    self.switchMyProfilePhoto.isOn = false
                }
                
                
                if arrgetMemberInfo.showPrimaryEmail == 1{
                    self.switchPrimaryEmail.isOn = true
                }
                else{
                    self.switchPrimaryEmail.isOn = false
                }
                if arrgetMemberInfo.showSecondaryEmail == 1{
                    self.switchSecondaryEmail.isOn = true
                }
                else{
                    self.switchSecondaryEmail.isOn = false
                }
                if arrgetMemberInfo.showSecondaryEmailNotification == 1{
                    self.switchSecondaryNotification.isOn = true
                }
                else{
                    self.switchSecondaryNotification.isOn = false
                }
                if arrgetMemberInfo.showprimaryEmailNotification == 1{
                    self.switchPrimaryEmailNotification.isOn = true
                }
                else{
                    self.switchPrimaryEmailNotification.isOn = false
                }

                if arrgetMemberInfo.addressBussiness == 1{
                    self.switchAddressBussiness.isOn = true
                }
                else{
                    self.switchAddressBussiness.isOn = false
                }
                if arrgetMemberInfo.addressOther == 1{
                    self.switchAddressOther.isOn = true
                }
                else{
                    self.switchAddressOther.isOn = false
                }
                if arrgetMemberInfo.address![1].showOutsideUS == 1{
                    self.btnOutsideUSOther.setImage(UIImage(named:"Group 2130"), for: UIControlState.normal)
                    self.btnOutsideUSOther.isSelected = false
                    self.isOutsideUSOther = 1
                    self.txtEDitCountryOther.isEnabled = true
                    self.txtEditOtherState.setRightIcon(imageName: "")
                    self.txtEditOtherState.inputView = nil
                    self.txtEditOtherState.tintColor = hexStringToUIColor(hex: "695B5E")
                    self.txtEditPostalCodeOther.keyboardType = .default

                }
                else{
                    self.btnOutsideUSOther.setImage(UIImage(named:"CheckBox_uncheck"), for: UIControlState.normal)
                    self.btnOutsideUSOther.isSelected = true
                    self.isOutsideUSOther = 0
                    self.txtEDitCountryOther.isEnabled = false
                    self.txtEditOtherState.tintColor = UIColor.white
                    self.txtEditOtherState.setRightIcon(imageName: "Path 1847")
                    self.txtEditOtherState.inputView = self.statesPickerOther
                    self.txtEditPostalCodeOther.keyboardType = .numberPad
                    self.txtEDitCountryOther.text = "USA"


                }

                if arrgetMemberInfo.address![2].showOutsideUS == 1{
                    self.btnOutsideUSBussiness.setImage(UIImage(named:"Group 2130"), for: UIControlState.normal)
                    self.btnOutsideUSBussiness.isSelected = false
                    self.isOutsideUSBussiness = 1
                    self.txtEditCountryNuss.isEnabled = true
                    self.txtEditStateBuss.setRightIcon(imageName: "")
                    self.txtEditStateBuss.inputView = nil
                    self.txtEditStateBuss.tintColor = hexStringToUIColor(hex: "695B5E")
                    self.txtEditPostalCodeBuss.keyboardType = .default

                }
                else{
                    self.btnOutsideUSBussiness.setImage(UIImage(named:"CheckBox_uncheck"), for: UIControlState.normal)
                    self.btnOutsideUSBussiness.isSelected = true
                    self.isOutsideUSBussiness = 0
                    self.txtEditCountryNuss.isEnabled = false
                    self.txtEditStateBuss.tintColor = UIColor.white
                    self.txtEditStateBuss.setRightIcon(imageName: "Path 1847")
                    self.txtEditStateBuss.inputView = self.statesPickerBussiness
                    self.txtEditPostalCodeBuss.keyboardType = .numberPad
                    self.txtEditCountryNuss.text = "USA"


                }
                
                self.myInterestCollectionView.reloadData()
                self.marketOptionsCollectionView.reloadData()

             
                self.lblEditVersion.text = String(format: "Version %@", (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String)!)
                
                
                self.lblEditBottomIDAndName.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)

                
                
                if self.arrInterest.count == 0 {
                
                for intersts in self.dictmemberInfo.interest!{
                    self.arrInterest.append(intersts)
                }
                }
                if self.arrMarketOptions.count == 0 {
                    
                    for i in 0 ..< self.dictmemberInfo.targetedMarketOption!.count {
                        let targetedMarketOption = self.dictmemberInfo.targetedMarketOption![i]
                        self.arrMarketOptions.append(targetedMarketOption)
                       if self.arrMarketOptions[i].isChecked == 1{
 
                            self.arrNewMarketOptions.append(self.arrMarketOptions[i])
                        }
                    }
                }
                
                self.memeberInterestApi()
                
                //Commented by kiran V1.3 -- PROD0000036 -- removing place holder image from app
                //PROD0000036 -- Start
                /*
                let placeholder:UIImage = UIImage(named: "avtar")!
                self.imgProfilePic.image = placeholder
                */
                //PROD0000036 -- End
                
                if(arrgetMemberInfo.profilePic == nil)
                {
                    
                }
                else
                {
                    //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
                    //ENGAGE0011419 -- Start
                    let imageURLString = arrgetMemberInfo.profilePic ?? ""
                    
                    if imageURLString.isValidURL()
                    {
                        //Added by kiran V1.3 -- PROD0000036 -- Showing place holder images based on gender which are fetched from URL
                        //PROD0000036 -- Start
                        self.imgProfilePic.setImage(imageURL: imageURLString,shouldCache: true)
                        //Old Logic
                        /*
                        let url = URL.init(string:imageURLString)
                        self.imgProfilePic.sd_setImage(with: url , placeholderImage: placeholder)
                        */
                        //PROD0000036 -- End
                    }
                    /*
                    print("imageURLString:\(imageURLString)")
                    if(imageURLString.count>0){
                        let validUrl = self.verifyUrl(urlString: imageURLString)
                        if(validUrl == true){
                            let url = URL.init(string:imageURLString)
                            self.imgProfilePic.sd_setImage(with: url , placeholderImage: placeholder)
                        }
                    }
                    */
                    //ENGAGE0011419 -- End
                }
                
                
                
                //Added by kiran V2.7 -- ENGAGE0011559 -- international Number change
                //ENGAGE0011559 -- Start
                
                self.chkBoxInternationalNumber.isSelected = arrgetMemberInfo.isOutSideUSPhone == 1
                self.setInternationalNumberChkBoxImage(sender: self.chkBoxInternationalNumber)
                self.customisePhoneNumberKeyboard(outsideUS: arrgetMemberInfo.isOutSideUSPhone == 1)
                //ENGAGE0011559 -- End
                self.view.layoutIfNeeded()
               
                self.marketOptionsCollectionView.reloadData()

                //
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
    }
    
    //MARK:- Member Interest  Api
    
    func memeberInterestApi()
    {
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.getInterest(paramater: paramaterDict , onSuccess: { interestList in
                self.appDelegate.hideIndicator()
                    if(interestList.responseCode == InternetMessge.kSuccess){
                        
                        self.appDelegate.arrAllInterest = interestList.interest!
                        self.myInterestCollectionView.reloadData()
                        self.marketOptionsCollectionView.reloadData()
                        self.appDelegate.hideIndicator()
//                    }
                }else{

                }
//
                self.appDelegate.hideIndicator()
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
     
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getMemberInfoApi()
        self.memeberInterestApi()
        //  self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        //navigation item labelcolor
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = self.appDelegate.masterLabeling.tT_PROFILE
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow

        self.isFrom = ""
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End


    }
   

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        if self.isMovingFromParentViewController{
            print("yes")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func interestButtonClicked(sender: UIButton){
        
        
        if let buttonTitle = sender.title(for: .normal) {
        
        if sender.currentImage == UIImage(named: "CheckBox_uncheck"){
            
            sender.setImage(UIImage(named: "Group 2130"), for: .normal)
            print(buttonTitle)
            self.arrInterest.append(buttonTitle)


            
        }else{
            
            sender.setImage(UIImage(named: "CheckBox_uncheck"), for: .normal)
            self.arrInterest = self.arrInterest.filter(){$0 != buttonTitle}
        }
            
        }
        print(self.arrInterest)

    }
    
    @objc func marketOptionsButtonClicked(sender: UIButton){
        
        if let buttonTitle = sender.title(for: .normal) {
            
            if sender.currentImage == UIImage(named: "CheckBox_uncheck"){
                
                sender.setImage(UIImage(named: "Group 2130"), for: .normal)
                self.arrNewMarketOptions.append(self.arrMarketOptions[sender.tag])
                
            }else{
                
                sender.setImage(UIImage(named: "CheckBox_uncheck"), for: .normal)
                
                self.arrNewMarketOptions = self.arrNewMarketOptions.filter(){$0 != self.arrMarketOptions[sender.tag]}
            }
            
        }
        
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == marketOptionsCollectionView{
        return self.arrMarketOptions.count
        }
        else{
            return appDelegate.arrAllInterest.count

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckboxCell", for: indexPath as IndexPath) as! CheckBoxCustomCell
        
        if collectionView == marketOptionsCollectionView{
           
            if ((self.dictmemberInfo.targetedMarketOption?.count) == nil){
                
                
            }
            else{

                  if  self.arrMarketOptions[indexPath.row].isChecked == 1{
                    cell.btnMarketCheckBox.setImage(UIImage(named: "Group 2130"), for: UIControlState.normal)
                    }
                else{
                    cell.btnMarketCheckBox.setImage(UIImage(named: "CheckBox_uncheck"), for: UIControlState.normal)

                    
                }
            }
            cell.btnMarketCheckBox.tag = indexPath.row
            cell.btnMarketCheckBox .setTitle(self.arrMarketOptions[indexPath.row].groupName, for: UIControlState.normal)
            cell.btnMarketCheckBox.titleEdgeInsets = UIEdgeInsetsMake(0, 9, 0, 0)
            cell.btnMarketCheckBox.addTarget(self, action:#selector(marketOptionsButtonClicked), for: .touchUpInside)
        }
        else{
            
            if ((self.dictmemberInfo.allInterests?.count) == nil){
                
                
            }
            else{
                if (self.dictmemberInfo.interest?.contains(appDelegate.arrAllInterest[indexPath.row].interest!) ==  true){
                    
                    cell.btnCheckBox.setImage(UIImage(named: "Group 2130"), for: UIControlState.normal)
                }
                else{
                    cell.btnCheckBox.setImage(UIImage(named: "CheckBox_uncheck"), for: UIControlState.normal)
                    
                }
            }
            cell.btnCheckBox.tag = indexPath.row
            cell.btnCheckBox .setTitle(appDelegate.arrAllInterest[indexPath.row].interest, for: UIControlState.normal)
            cell.btnCheckBox.titleEdgeInsets = UIEdgeInsetsMake(0, 9, 0, 0)
            cell.btnCheckBox.addTarget(self, action:#selector(interestButtonClicked), for: .touchUpInside)

        }
        return cell
    }
    
    
    @IBAction func outSideUSOtherClciked(_ sender: Any) {
           if let button = sender as? UIButton {
            
            if button.isSelected {
                button.isSelected = false
                btnOutsideUSOther.setImage(UIImage(named:"Group 2130"), for: UIControlState.normal)
                isOutsideUSOther = 1
                txtEDitCountryOther.isEnabled = true
                txtEditOtherState.inputView = nil
                txtEditOtherState.reloadInputViews()
                txtEditOtherState.setRightIcon(imageName: "")
                txtEditOtherState.text = ""
                txtEditOtherState.tintColor = hexStringToUIColor(hex: "695B5E")
                txtEDitCountryOther.text = ""
                txtEditStreetAdd1.text = ""
                txtEditStreetAdd2.text = ""
                txtEditOtherCityAdd.text = ""
                txtEditPostalCodeOther.text = ""
                txtEditPostalCodeOther.keyboardType = .default

                
            } else {
                
                btnOutsideUSOther.setImage(UIImage(named:"CheckBox_uncheck"), for: UIControlState.normal)
                isOutsideUSOther = 0
                txtEDitCountryOther.isEnabled = false
                txtEDitCountryOther.text = self.appDelegate.masterLabeling.usa

                button.isSelected = true
                txtEditPostalCodeOther.keyboardType = .numberPad

                txtEditOtherState.text = ""
                txtEditStreetAdd1.text = ""
                txtEditStreetAdd2.text = ""
                txtEditOtherCityAdd.text = ""
                txtEditPostalCodeOther.text = ""
                txtEditOtherState.tintColor = UIColor.white
                txtEditOtherState.setRightIcon(imageName: "Path 1847")
                txtEditOtherState.inputView = statesPickerOther
            }
        }
    }
    @IBAction func OutSideUSBussClicked(_ sender: Any) {
        if let button = sender as? UIButton {
            if button.isSelected {
                button.isSelected = false
                btnOutsideUSBussiness.setImage(UIImage(named:"Group 2130"), for: UIControlState.normal)
                isOutsideUSBussiness = 1
                txtEditCountryNuss.isEnabled = true
                txtEditStateBuss.inputView = nil
                txtEditStateBuss.reloadInputViews()
                txtEditStateBuss.setRightIcon(imageName: "")
                txtEditStateBuss.text = ""
                txtEditCountryNuss.text = ""
                txtEditStreetAdd1Buss.text = ""
                txtEditStreetAdd2Buss.text = ""
                txtEditCityBuss.text = ""
                txtEditPostalCodeBuss.text = ""
                txtEditPostalCodeBuss.keyboardType = .default

                txtEditStateBuss.tintColor = hexStringToUIColor(hex: "695B5E")

            } else {
                btnOutsideUSBussiness.setImage(UIImage(named:"CheckBox_uncheck"), for: UIControlState.normal)
                isOutsideUSBussiness = 0
                txtEditCountryNuss.isEnabled = false
                txtEditCountryNuss.text = self.appDelegate.masterLabeling.usa
                txtEditStateBuss.text = ""
                txtEditStreetAdd1Buss.text = ""
                txtEditStreetAdd2Buss.text = ""
                txtEditCityBuss.text = ""
                txtEditPostalCodeBuss.text = ""
                button.isSelected = true
                txtEditPostalCodeBuss.keyboardType = .numberPad
                txtEditStateBuss.tintColor = UIColor.white
                txtEditStateBuss.setRightIcon(imageName: "Path 1847")
                txtEditStateBuss.inputView = statesPickerBussiness
            }
        }
    }

    @IBAction func changePasswordClicked(_ sender: Any) {
        
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                "PageUrl": "api/Member/GetCampaignList",
                "PageName": "Change Password",
                "ScreenCode": "TST_CHAP"
            ]
            
            APIHandler.sharedInstance.getUserActivity(paramaterDict: paramaterDict , onSuccess: { eventList in
                if(eventList.responseCode == InternetMessge.kSuccess)
                {
                    
                    self.appDelegate.hideIndicator()
                }else{
                    self.appDelegate.hideIndicator()
                    if(((eventList.responseMessage?.count) ?? 0)>0){
                        //                        SharedUtlity.sharedHelper().showToast(on:
                        //                            self.view, withMeassge: eventList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                }
                
                self.appDelegate.hideIndicator()
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                //                SharedUtlity.sharedHelper().showToast(on:
                //                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
        
        if let changePW = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ChangePWViewController") as? ChangePWViewController {
//            notificationList.arrNotifications = self.arrNotifications
            
            changePW.memberID = self.dictmemberInfo.memberMasterID ?? ""
            changePW.memberActive = self.dictmemberInfo.status
            changePW.displayName = self.dictmemberInfo.displayName
            changePW.profilePic = self.dictmemberInfo.profilePic
            changePW.UserID = self.dictmemberInfo.username
            
            self.navigationController?.pushViewController(changePW, animated: true)
        }
        

    }
    
    
    @IBAction func btnIgnorePressed(_ sender: UIButton) {
        
    }
    
    @IBAction func saveProfileClicked(_ sender: Any) {
        
        //Added on 4th July 2020 V2.2
        //Added roles and privilages chages
        switch self.accessManager.accessPermision(for: .profile)
        {
        case .view:
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        default:
            break
        }
        
        if txtEditSendStatementsTo.text == "" {
            
        }
        else{
            for i in 0 ..< self.appDelegate.arrAddressTypes.count {
                let statementData = self.appDelegate.arrAddressTypes[i]
                if statementData.text == txtEditSendStatementsTo.text {
                    selectedStatement = statementData.addressTypeID
                }
            }
        }
        if txtEditSendMagazineTo.text == "" {
            
        }
        else{
            for i in 0 ..< self.appDelegate.arrAddressTypes.count {
                let statementData = self.appDelegate.arrAddressTypes[i]
                if statementData.text == txtEditSendMagazineTo.text {
                    selectedMagazine = statementData.addressTypeID
                }
            }
        }
        for i in 0 ..< self.arrNewMarketOptions.count {
            let marketOptions:[String: Any] = [

            "GroupID": self.arrNewMarketOptions[i].groupID ?? "",
            "GroupName": self.arrNewMarketOptions[i].groupName ?? "",
            "IsChecked": 1
            ]
            selectedMarketOptions.append(marketOptions)
        }
        let otherAddress:[String: Any] = [
            APIKeys.kaddressType: self.dictmemberInfo.address![1].adddresstype ?? "",
            APIKeys.kaddressLine1:  txtEditStreetAdd1.text ?? "",
            APIKeys.kaddressLine2 : txtEditStreetAdd2.text ?? "",
            APIKeys.kcity: txtEditOtherCityAdd.text ?? "",
            APIKeys.kzipCode: txtEditPostalCodeOther.text ?? "",
            APIKeys.kstate : txtEditOtherState.text ?? "",
            APIKeys.kisOutsideUnitedState: isOutsideUSOther!,
            APIKeys.kaddressID:  self.dictmemberInfo.address![1].addressid ?? "",
            APIKeys.kaddressTypeID : self.dictmemberInfo.address![1].addresstypeid ?? "",
            APIKeys.kcountry: txtEDitCountryOther.text ?? "",
           ]
        let bussinessAddress:[String: Any] = [
            APIKeys.kaddressType: self.dictmemberInfo.address![2].adddresstype ?? "",
            APIKeys.kaddressLine1:  txtEditStreetAdd1Buss.text ?? "",
            APIKeys.kaddressLine2 : txtEditStreetAdd2Buss.text ?? "",
            APIKeys.kcity: txtEditCityBuss.text ?? "",
            APIKeys.kzipCode: txtEditPostalCodeBuss.text ?? "",
            APIKeys.kstate : txtEditStateBuss.text ?? "",
            APIKeys.kisOutsideUnitedState: isOutsideUSBussiness!,
            APIKeys.kaddressID:  self.dictmemberInfo.address![2].addressid ?? "",
            APIKeys.kaddressTypeID : self.dictmemberInfo.address![2].addresstypeid ?? "",
            APIKeys.kcountry: txtEditCountryNuss.text ?? "",
        ]
        
        let parameter:[String:Any] = [
            APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kisVisibleInDirectory: switchMyprofile.isOn ? 1 : 0,
            APIKeys.kshowProfilePhoto: switchMyProfilePhoto.isOn ? 1: 0,
            APIKeys.kdisplayName: txtDisplayName.text ?? "",
            APIKeys.kfirstName: txtFirstName.text ?? "",
            APIKeys.klastName: txtLastName.text ?? "",
            APIKeys.kmiddleName: txtMiddelname.text ?? "",
            APIKeys.ksuffix: txtSuffix.text ?? "",
            APIKeys.kprefix: txtTitle.text ?? "",
            APIKeys.kprimaryphone: txtHomePhone.text ?? "",
            APIKeys.ksecondaryPhone: txtCellPhone.text ?? "",
            APIKeys.kalternatePhone: txtOtherPhone.text ?? "",
            APIKeys.kprimaryEmail: txtEditPrimaryEmail.text ?? "",
            APIKeys.ksecondaryEmail: txtEditSecondaryEmail.text ?? "",
            APIKeys.kshowPrimaryPhone: switchHomePhone.isOn ? 1 : 0,
            APIKeys.kshowBirthday : switchBirthday.isOn ? 1 : 0,
            APIKeys.kshowVillage: switchVillage.isOn ? 1: 0,
            APIKeys.kshowSecondaryPhone: switchCellPhone.isOn ? 1 : 0,
            APIKeys.kshowAlternatePhone: switchOtherPhone.isOn ? 1 : 0,
            APIKeys.kshowPrimaryEmail: switchPrimaryEmail.isOn ? 1 : 0,
            APIKeys.kshowSecondaryEmail: switchSecondaryEmail.isOn ? 1 : 0,
            APIKeys.kprimaryEmailNotification: switchPrimaryEmailNotification.isOn ? 1 : 0,
            APIKeys.ksecondaryEmailNotification: switchSecondaryNotification.isOn ? 1 : 0,
            
            APIKeys.ksendMagazineTo: selectedMagazine ?? "",
            APIKeys.ksendStatementTo: selectedStatement ?? "",
            APIKeys.kshowBocaAddress: switchBocawestAdd.isOn ? 1 : 0,
            APIKeys.kshowOtherAddress: switchAddressOther.isOn ? 1 : 0,
            APIKeys.kshowBusinessAddress: switchAddressBussiness.isOn ? 1 : 0,
            
            APIKeys.kaddress: [otherAddress, bussinessAddress],
            APIKeys.kinterest: arrInterest.joined(separator:","),
            APIKeys.ktargetedNarketingoptions: selectedMarketOptions,
            
            //Added by kiran V2.7 -- ENGAGE0011559 -- international Number change
            //ENGAGE0011559 -- Start
            APIKeys.kIsOutSideUSPhone : self.chkBoxInternationalNumber.isSelected ? 1 : 0
            //ENGAGE0011559 -- End
        ]
        
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.saveMemberInfo(paramaterDict:parameter, onSuccess: { parentMemberinfo in
                
                if(parentMemberinfo.responseCode == InternetMessge.kSuccess){
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: self.appDelegate.masterLabeling.memberProfile_succss , withDuration: Duration.kMediumDuration)
                    self.appDelegate.hideIndicator()

                    self.navigationController?.popViewController(animated: true)
                    

                }
                else{
                    self.appDelegate.hideIndicator()
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: parentMemberinfo.responseMessage, withDuration: Duration.kMediumDuration)
                }
                
                
                self.appDelegate.hideIndicator()
                
                
            },onFailure: { error  in
                
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
                
            })
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
    }

    
    
    @IBAction func cancelClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)

    }
   
}

extension ProfileViewsController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sufixPicker {
            return appDelegate.arrSufix.count
        }
        else if pickerView == sendSatetmentsTo {
            return appDelegate.arrAddressTypes.count

        }
        else if pickerView == sendMagazineTo {
            return appDelegate.arrAddressTypes.count
            
        }
        else if pickerView == statesPickerOther {
            return appDelegate.arrStates.count
            
        }
        else if pickerView == statesPickerBussiness {
            return appDelegate.arrStates.count
            
        }
        else{
        return appDelegate.arrPrefix.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == sufixPicker {
            return appDelegate.arrSufix[row].sufix
        }
        else if pickerView == sendSatetmentsTo {
            return appDelegate.arrAddressTypes[row].text
        }
        else if pickerView == sendMagazineTo {
            return appDelegate.arrAddressTypes[row].text
        }
        else if pickerView == statesPickerOther {
            return appDelegate.arrStates[row].stateName
        }
        else if pickerView == statesPickerBussiness {
            return appDelegate.arrStates[row].stateName
        }
        else{
        return appDelegate.arrPrefix[row].prefix
        }
    }
}

extension ProfileViewsController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == sufixPicker, appDelegate.arrSufix.count > row {
            selectedSufix = appDelegate.arrSufix[row]
            txtSuffix.text = selectedSufix?.sufix
        }
        else if pickerView == sendSatetmentsTo, appDelegate.arrAddressTypes.count > row {
            selectedsendSatetmentsTo = appDelegate.arrAddressTypes[row]
            txtEditSendStatementsTo.text = selectedsendSatetmentsTo?.text
            selectedStatement = selectedsendSatetmentsTo?.addressTypeID

        }
        else if pickerView == sendMagazineTo, appDelegate.arrAddressTypes.count > row {
            selectedMagazineTo = appDelegate.arrAddressTypes[row]
            txtEditSendMagazineTo.text = selectedMagazineTo?.text
            selectedMagazine = selectedMagazineTo?.addressTypeID
            
        }
            
        else if pickerView == statesPickerOther, appDelegate.arrStates.count > row {
            selectedStatesOther = appDelegate.arrStates[row]
            txtEditOtherState.text = selectedStatesOther?.stateName
        }
        else if pickerView == statesPickerBussiness, appDelegate.arrStates.count > row {
            selectedStatesBussiness = appDelegate.arrStates[row]
            txtEditStateBuss.text = selectedStatesBussiness?.stateName
        }
        else if appDelegate.arrPrefix.count > row {
            selectedPrefix = appDelegate.arrPrefix[row]
            txtTitle.text = selectedPrefix?.prefix
        }
    }
}


//Added by kiran V2.7 -- ENGAGE0011559 -- international Number change
//ENGAGE0011559 -- Start
//MARK:- Custom methods
extension ProfileViewsController
{
    
    private func setInternationalNumberChkBoxImage(sender : UIButton)
    {
        self.chkBoxInternationalNumber.setImage(sender.isSelected ? UIImage.init(named: "CheckBox_check") : UIImage.init(named: "CheckBox_uncheck"), for: .normal)
    }
    
    
    ///Customises the cell phone and other phone text fields and their data according to outside us flag, and update numbers flag
    ///
    ///Note:- outsideUS is the outside US contact flag and updateNumbers flag when true modified the data in fields. home phone is not included in this implementation as its is not editable in App.
    private func customisePhoneNumberKeyboard(outsideUS : Bool,updateNumbers : Bool = false)
    {
        if outsideUS
        {
            self.txtCellPhone.keyboardType = .default
            self.txtOtherPhone.keyboardType = .default
            
            //If any formatting of values is required when outside US contact switch is on. do it here
            if updateNumbers
            {
                
            }
        }
        else
        {
            self.txtCellPhone.keyboardType = .numberPad
            self.txtOtherPhone.keyboardType = .numberPad
            
            //Phone numbers are formatted to format xxx-xxx-xxxx. if any special characters or spaces,etc.. are entered when outside us contact switch is on they are stripped and if an alphabet is entered the we remove the entry and replace with empty string.
            if updateNumbers
            {
                self.txtCellPhone.text = self.generateFormattedPhoneNumber(number: self.txtCellPhone.text)
                self.txtOtherPhone.text = self.generateFormattedPhoneNumber(number: self.txtOtherPhone.text)
            }
            
        }
        
    }
    
    
    ///Generated a phone number with format xxx-xxx-xxxx
    ///
    ///If the number string has any special characters and alphabets those are stripped.
    private func generateFormattedPhoneNumber(number : String?) -> String
    {
        guard var tempNumberString : String = number , tempNumberString.count > 0 else{
            return ""
        }
        
        let characterSet = NSCharacterSet.letters
        
        //If the string contains any alphabets then empty string is passed
        while let specialRange = tempNumberString.rangeOfCharacter(from: characterSet,options: .caseInsensitive)
        {
            tempNumberString.replaceSubrange(specialRange, with: "")
        }
        
        let specialCharactersSet = NSCharacterSet.alphanumerics.inverted
        
        //Replaces all the characters which are not alphanumeric with empty string
        while let specialRange = tempNumberString.rangeOfCharacter(from: specialCharactersSet)
        {
            tempNumberString.replaceSubrange(specialRange, with: "")
        }
        
        //If count is more that 10. trims the string to have only 10 characters
        if tempNumberString.count > 10
        {
            tempNumberString = String(tempNumberString.prefix(10))
        }
       
        //Inserts - at 4th position to format the phone number
        if tempNumberString.count >= 4
        {
            tempNumberString.insert("-", at: tempNumberString.index(tempNumberString.startIndex, offsetBy: 3))
        }
        
        //Inserts - at 8th position to format the phone number
        if tempNumberString.count >= 8
        {
            tempNumberString.insert("-", at: tempNumberString.index(tempNumberString.startIndex, offsetBy: 7))
        }
        
        return tempNumberString
        
    }
    
}

//ENGAGE0011559 -- End
