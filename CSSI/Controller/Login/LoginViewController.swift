
import UIKit
import LocalAuthentication
import BiometricAuthentication
import ObjectMapper
import Popover
import Gimbal

class LoginViewController: UIViewController , UITextFieldDelegate{
   
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var txt_clubid: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var btnUserID: UIButton!
    @IBOutlet weak var lblForgotPassword: UIButton!
    @IBOutlet weak var lblLoginText: UILabel!
    @IBOutlet weak var btnForgotPassword: UIButton!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var imgBiomatric: UIImageView!
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var viewRemember: UIView!
    @IBOutlet weak var imgRemember: UIImageView!
    @IBOutlet weak var btnRememberMeText: UIButton!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var btnRememberMe: UIButton!
    @IBOutlet weak var lblPoweredBy: UILabel!
    @IBOutlet weak var btnPassword: UIButton!
    @IBOutlet weak var btnPrivacyPolicy: UIButton!
    @IBOutlet weak var btnTerms: UIButton!
    //Added by kiran V1.4 -- PROD0000118 -- Added login note in login screen
    //PROD0000118 -- Start
    @IBOutlet weak var lblLoginNote: UILabel!
    //PROD0000118 -- End
    
    var isRememberMeOn : String?
    var arrMemberList = [BrokenRulesModel]()
    //Commented by kiran V2.5 -- ENGAGE0011395
    //var settingsvalues = Settings()
    var isFrom : String?
    var notifyTitle : String?
    var notifyText : String?
    var addNewPopover: Popover? = nil
    var addNewLabel: UILabel? = nil
    
    //Added on 21st October 2020 V2.4
    var notificationID : String?

    //Mark- the method that is called once the MainView of a ViewController has been loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initController()
        self.setFontForView()
        self.ForgotPassword()
       // self.lblText.text = "This is test App"
        txt_password.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        //Added by kiran V2.8 -- ENGAGE0011688 -- Load language file data
        //ENGAGE0011688 -- Start
        DataManager.shared.loadMultiLangData()
        //ENGAGE0011688 -- End
    }
    @IBAction func rememberMeClicked(_ sender: Any) {
//        let rememberMe = UserDefaults.standard.string(forKey: UserDefaultsKeys.rememberMe.rawValue)
//
//        if (rememberMe == "Yes") {
//            btnRememberMe.isSelected = false
//        }
//        else{
//            btnRememberMe.isSelected = true
//        }
//
       self.rememberMe()
    }
    @IBAction func rememberMeTextClicked(_ sender: Any) {
//        let rememberMe = UserDefaults.standard.string(forKey: UserDefaultsKeys.rememberMe.rawValue)
//
//        if (rememberMe == "Yes") {
//
//            btnRememberMe.isSelected = false
//        }
//        else{
//             btnRememberMe.isSelected = true
//
//        }
        
        self.rememberMe()
    }
    @IBAction func showPasswordClicked(_ sender: Any) {
        let btn : UIButton = sender as! UIButton
        
        if btn.tag == 0{
            btn.tag = 1
            self.txt_password.isSecureTextEntry = false
            self.btnPassword.setImage(UIImage(named: "Password Visible"), for: UIControlState.normal)
        }
        else{
            btn.tag = 0
            self.txt_password.isSecureTextEntry = true
            self.btnPassword.setImage(UIImage(named: "Password not visible"), for: UIControlState.normal)
        }
    }
    func rememberMe(){
        if btnRememberMe.isSelected == false {
            
            
            btnRememberMe.isSelected = true
            isRememberMeOn = "No"
            UserDefaults.standard.set(isRememberMeOn, forKey: UserDefaultsKeys.rememberMe.rawValue)
            
            btnRememberMe.setBackgroundImage(UIImage(named : "Rectangle 1597"), for: UIControlState.normal)
            
        }else {
            btnRememberMe.isSelected = false
            
            if txt_clubid.text == "" || txt_password.text == "" {
                isRememberMeOn = "No"
            }
            else{
                isRememberMeOn = "Yes"
            }
            UserDefaults.standard.set(isRememberMeOn, forKey: UserDefaultsKeys.rememberMe.rawValue)
            UserDefaults.standard.set(txt_clubid.text, forKey: UserDefaultsKeys.txtUserName.rawValue)
            UserDefaults.standard.set(txt_password.text, forKey: UserDefaultsKeys.txtPassword.rawValue)
            
            btnRememberMe.setBackgroundImage(UIImage(named : "Group 1178"), for: UIControlState.normal)
            
        }
    }
    
    //Mark- Initial Method of LoginViewcontroller
    func initController()
    {
      //  self.txt_clubid.becomeFirstResponder()
        self.txt_clubid.delegate = self

        self.txt_password.delegate = self
        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg
        
        self.txt_clubid.addBorderBottom(height: 1.0, color: APPColor.placeHolderColor.tint)
        self.txt_password.addBorderBottom(height: 1.0, color: APPColor.placeHolderColor.tint)
        
        self.btn_login.backgroundColor = APPColor.backGroundColor.tint
        
        self.txt_password.textColor = APPColor.placeHolderColor.tint
        self.txt_clubid.textColor = APPColor.placeHolderColor.tint
        
        txt_clubid.attributedPlaceholder = NSAttributedString(string: CommonString.kmemberID,
                                                              attributes: [NSAttributedStringKey.foregroundColor: APPColor.placeHolderColor.tint ])
        txt_password.attributedPlaceholder = NSAttributedString(string: CommonString.kpassword,
                                                                attributes: [NSAttributedStringKey.foregroundColor: APPColor.placeHolderColor.tint ])
        
        

        btn_login.layer.cornerRadius = 20
        self.navigationController?.navigationBar.isHidden = true
                
//        UserDefaults.standard.set(txt_clubid, forKey: UserDefaultsKeys.txtUserName.rawValue)
//        UserDefaults.standard.set(txt_password, forKey: UserDefaultsKeys.txtPassword.rawValue)
        
        let memberid = UserDefaults.standard.string(forKey: UserDefaultsKeys.txtUserName.rawValue)
        let password = UserDefaults.standard.string(forKey: UserDefaultsKeys.txtPassword.rawValue)
        let rememberMe = UserDefaults.standard.string(forKey: UserDefaultsKeys.rememberMe.rawValue)
        
        if (rememberMe == "Yes") {
            txt_clubid.text = memberid
            txt_password.text = password
            btnRememberMe.setBackgroundImage(UIImage(named : "Group 1178"), for: UIControlState.normal)
            //btnRememberMe.isSelected = false

        }
        else{
            txt_clubid.text = ""
            txt_password.text = ""
            btnRememberMe.setBackgroundImage(UIImage(named : "Rectangle 1597"), for: UIControlState.normal)
           // btnRememberMe.isSelected = true

        }
        
       
        
//
        
//        else{
        
            if (password != nil && memberid != nil)  {
               // self.authBiomatric()
                self.imgBiomatric.isHidden = false
            }
            else{

            }
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction(tapGestureRecognizer:)))
            self.imgBiomatric.isUserInteractionEnabled = true
            self.imgBiomatric.addGestureRecognizer(tapGestureRecognizer)
//        }
    
        
//        if  ((device == "iPhone10,3" ) || (device == "iPhone10,6") || (device == "iPhone11,2" ) || (device == "iPhone11,4") || (device == "iPhone11,6" ) || (device == "iPhone11,8")){
//            self.imgBiomatric.isHidden = false
//        }
//        else{
//            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction(tapGestureRecognizer:)))
            self.imgBiomatric.isUserInteractionEnabled = true
            self.imgBiomatric.addGestureRecognizer(tapGestureRecognizer)
        
        //Modified by kiran V2.9 -- ENGAGE0011569 -- Showing bioemtric image based on device capability and if those are setup in device
        //ENGAGE0011569 -- Start
        
        if BioMetricAuthenticator.shared.faceIDAvailable()
        {
            if (UserDefaults.standard.string(forKey: UserDefaultsKeys.faceID.rawValue) == "1")
            {
                self.imgBiomatric.isHidden = false
                self.imgBiomatric.image = UIImage(named: "Face Id")
            }
            else
            {
                self.imgBiomatric.isHidden = true
            }
        }
        else if BioMetricAuthenticator.shared.touchIDAvailable()
        {
            if (UserDefaults.standard.string(forKey: UserDefaultsKeys.fingerPrint.rawValue) == "1")
            {
               self.imgBiomatric.isHidden = false
               self.imgBiomatric.image = UIImage(named: "Thumbprint")
            }
            else
            {
               self.imgBiomatric.isHidden = true
            }
            
        }
        else
        {
            self.imgBiomatric.isHidden = true
        }
        
        //Old logic
        /*
         let device = DeviceInfo.modelName
        
        if  ((device == "iPhone XR" ) || (device == "iPhone XS Max") || (device == "iPhone XS" ) || (device == "iPhone X") || (device == "Simulator iPhone XR") ){
            if (UserDefaults.standard.string(forKey: UserDefaultsKeys.faceID.rawValue) == "1"){
                self.imgBiomatric.isHidden = false
                self.imgBiomatric.image = UIImage(named: "Face Id")
            }
            else{
                self.imgBiomatric.isHidden = true

            }
        }
        else{
             if (UserDefaults.standard.string(forKey: UserDefaultsKeys.fingerPrint.rawValue) == "1"){
                self.imgBiomatric.isHidden = false
                self.imgBiomatric.image = UIImage(named: "Thumbprint")

            }
             else{
                self.imgBiomatric.isHidden = true

            }
        }
         */
        //ENGAGE0011569 -- End
        
        
//
//        if (UserDefaults.standard.string(forKey: UserDefaultsKeys.fingerPrint.rawValue) == "1"){
//
//
//            self.imgBiomatric.isHidden = false
//
//
//            if (UserDefaults.standard.string(forKey: UserDefaultsKeys.faceID.rawValue) == "1"){
//                self.imgBiomatric.isHidden = false
//
//            }
//            else{
//
//                if  ((device == "iPhone10,3" ) || (device == "iPhone10,6") || (device == "iPhone11,2" ) || (device == "iPhone11,4") || (device == "iPhone11,6" ) || (device == "iPhone11,8")){
//                    self.imgBiomatric.isHidden = true
//                }
//                else{
//                self.imgBiomatric.isHidden = false
//
//                }}
//            }
//            else{
//
//            if  ((device == "iPhone10,3" ) || (device == "iPhone10,6") || (device == "iPhone11,2" ) || (device == "iPhone11,4") || (device == "iPhone11,6" ) || (device == "iPhone11,8")){
//                self.imgBiomatric.isHidden = false
//            }
//            else{
//                self.imgBiomatric.isHidden = true
//            }
//            if (UserDefaults.standard.string(forKey: UserDefaultsKeys.faceID.rawValue) == "1"){
//                self.imgBiomatric.isHidden = false
//
//            }
//            else{
//                self.imgBiomatric.isHidden = true
//
//            }
//
//            }

        self.txt_password.clearsOnBeginEditing = false
        self.txt_password.clearsOnInsertion = false
        
        self.btnPrivacyPolicy.setTitle(self.appDelegate.masterLabeling.PRIVACY_POLICY ?? CommonString.kprivacypolicy, for: .normal)
        self.btnTerms.setTitle(self.appDelegate.masterLabeling.TERMS_of_Use ?? CommonString.kTerms, for: .normal)
        
        self.btn_login.setStyle(style: .contained, type: .primary)
        self.btn_login.backgroundColor = .white
        self.btn_login.setTitleColor(APPColor.MainColours.primary1, for: .normal)
        
        self.setLocalizedString()
        
    }
    
    
    //MARK:- Keyboard events
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    //MARK:- Button Login Pressed
    @IBAction func btnLogin(_ sender: Any) {
       // self.rememberMe()
        loginApi()
        
    }
    
    
    @IBAction func privacyPolicyClicked(_ sender: UIButton)
    {
        
        if let url = URL.init(string: self.appDelegate.privacyPolicyLink ?? CommonURL.privacyPolicy)
        {
            self.openUrl(url: url)
        }
        
    }
    
    @IBAction func termsclicked(_ sender: UIButton)
    {
        if let url = URL.init(string: self.appDelegate.termsOfUsageLink ?? CommonURL.termsOfUse)
        {
             self.openUrl(url: url)
        }
    }
    
    
    private func openUrl(url : URL)
    {
        //Modified by kiran V2.5 -- ENGAGE0011419 --
        //ENGAGE0011419 -- Start
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        if UIApplication.shared.canOpenURL(url)
//        {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        }
        //ENGAGE0011419 -- End
    }
    
    //MARK:- setFonts for Views
    func setFontForView()
    {
        self.txt_password.font = SFont.SourceSansPro_Semibold18
        self.txt_clubid.font = SFont.SourceSansPro_Semibold18
        
        self.btn_login.titleLabel?.minimumScaleFactor = 0.5;
        self.btn_login.titleLabel?.adjustsFontSizeToFitWidth = true;
        //Added by kiran V1.4 -- PROD0000118 -- Added login note in login screen
        //PROD0000118 -- Start
        self.lblLoginNote.font = AppFonts.semibold14
        self.lblLoginNote.textColor = .white
        //PROD0000118 -- End
    }
    
    
    //MARK:- Fingerprint method called
    func authBiomatric()  {
        if BioMetricAuthenticator.canAuthenticate() {
            BioMetricAuthenticator.authenticateWithBioMetrics(reason: "", success: {
                // authentication success
                self.loginApiThroughBiomatric()
            }) { (error) in
                
                // error
                print(error.message())
            }
        }
    }
    
    func ForgotPassword() {
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        let params: [String : Any] = [
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            "EmailID" :  ""
            
        ]
        
        APIHandler.sharedInstance.postForgotPasswordApi(paramaterDict: params, onSuccess: { (response) in
            
            self.lblText.text = response.loginText
            //Added on 14th October 2020 V2.3
            self.lblPoweredBy.text = response.poweredByText
            
            //Added by kiran V1.4 -- PROD0000118 -- Added login note in login screen.
            //PROD0000118 -- Start
            self.lblLoginNote.text = response.loginNote
            //PROD0000118 -- End
            self.appDelegate.hideIndicator()
            
        }) { (error) in
            self.appDelegate.hideIndicator()
        }
        
    }

    //MARK:- Login API called
    func loginApiThroughBiomatric() -> Void {
        let parameter:[String:Any] = [
            APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userIDFingerPrint.rawValue) ?? "",
            APIKeys.kpassword: UserDefaults.standard.string(forKey: UserDefaultsKeys.passwordFingerPrint.rawValue) ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kdeviceID: UserDefaults.standard.string(forKey: UserDefaultsKeys.FCMToken.rawValue) ?? ""
        ]
        
        if (Network.reachability?.isReachable) == true
        {
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            APIHandler.sharedInstance.postAuthenticateUserApi(paramaterDict:parameter, onSuccess: { parentMemberinfo in
                
                if(parentMemberinfo.memberID != nil && parentMemberinfo.responseCode == InternetMessge.kSuccess)
                {
                    
                    //Modified by kiran V1.3 -- PROD0000019 -- Added 2 step verification
                    //PROD0000019 -- Start
                    if parentMemberinfo.authenticationEnable == 1
                    {
                        var emailView : OTPEmailView? = OTPEmailView.init(frame: self.view.bounds)
                        emailView?.memberID = parentMemberinfo.memberID
                        emailView?.ID = parentMemberinfo.id
                        emailView?.parentID = parentMemberinfo.parentId
                        emailView?.setupScreendata(parentMemberinfo)
                        
                        emailView?.verificationStatus = ({ status in
                            if status
                            {
//                                emailView?.removeFromSuperview()
//                                emailView = nil
                                self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
                                self.performBiometricLogin(parentMemberinfo: parentMemberinfo)
                            }
                        })
                        
                        emailView?.backBtnClicked = ({
                            emailView?.removeFromSuperview()
                            emailView = nil
                        })
                        
                        emailView?.closeBtnClicked = ({
                            emailView?.removeFromSuperview()
                            emailView = nil
                        })

                        if let emailView = emailView
                        {
                            self.view.addSubview(emailView)
                        }
                        
                        self.appDelegate.hideIndicator()
                    }
                    else
                    {
                        self.performBiometricLogin(parentMemberinfo: parentMemberinfo)
                    }
                    
                    //   print(JSON)
                    /*
                    let memberid = parentMemberinfo.memberID
                    let membername = parentMemberinfo.memberName
                    let memberprofilepic = parentMemberinfo.profilePic
                    let parentID = parentMemberinfo.parentId
                    let id = parentMemberinfo.id
                    let prefix = parentMemberinfo.prefix
                    let culturecode = parentMemberinfo.culturecode
                    let firstName  = parentMemberinfo.firstName
                    let lastName = parentMemberinfo.lastName
                    let isAdmin = parentMemberinfo.isAdminvalue
                    let role = parentMemberinfo.role
                    let userName = parentMemberinfo.userName
                    let displayname = parentMemberinfo.displayName
                    let fullName = parentMemberinfo.fullName
                    let memberNameDisplay = parentMemberinfo.memberNameDisplay
                    let isFirstTime = parentMemberinfo.isFirstTime
                    let memberUserName = parentMemberinfo.memberUserName

                    UserDefaults.standard.set(isFirstTime, forKey: UserDefaultsKeys.isFirstTime.rawValue)

                    UserDefaults.standard.set(memberid, forKey: UserDefaultsKeys.userIDFingerPrint.rawValue)
                    UserDefaults.standard.set(memberid, forKey: UserDefaultsKeys.userID.rawValue)
                    UserDefaults.standard.set(membername, forKey: UserDefaultsKeys.username.rawValue)
                    UserDefaults.standard.set(memberprofilepic, forKey: UserDefaultsKeys.userProfilepic.rawValue)
                    UserDefaults.standard.set(parentID, forKey: UserDefaultsKeys.parentID.rawValue)
                    UserDefaults.standard.set(id, forKey: UserDefaultsKeys.id.rawValue)
                    UserDefaults.standard.set(prefix, forKey: UserDefaultsKeys.prefix.rawValue)
                    UserDefaults.standard.set(culturecode, forKey: UserDefaultsKeys.culturecode.rawValue)
                    UserDefaults.standard.set(firstName, forKey: UserDefaultsKeys.firstName.rawValue)
                    UserDefaults.standard.set(lastName, forKey: UserDefaultsKeys.lastName.rawValue)

                    UserDefaults.standard.set(role, forKey: UserDefaultsKeys.role.rawValue)
                    UserDefaults.standard.set(isAdmin, forKey: UserDefaultsKeys.isAdmin.rawValue)
                    UserDefaults.standard.set(userName, forKey: UserDefaultsKeys.username.rawValue)
                    UserDefaults.standard.set(displayname, forKey: UserDefaultsKeys.displayName.rawValue)
                    UserDefaults.standard.set(fullName, forKey: UserDefaultsKeys.fullName.rawValue)
                    UserDefaults.standard.set(memberNameDisplay, forKey: UserDefaultsKeys.memberNameDisplay.rawValue)
                    UserDefaults.standard.set(memberUserName, forKey: UserDefaultsKeys.memberUserName.rawValue)

                    UserDefaults.standard.synchronize()

//                    self.getTokenApi()
                    self.getMultiLingualApi()
                    self.getSettingsApi()
                     */
                    
                    //PROD0000019 -- End
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((parentMemberinfo.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: parentMemberinfo.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    
                    // print(parentMemberinfo.message)
                    
                }
            },onFailure: { error, responseCode  in
                switch(responseCode.statusCode)
                {
                case 401:
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: ApiErrorMessages.kUnauthorized, withDuration: Duration.kMediumDuration)
                    break;
                case 400:
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: ApiErrorMessages.kInvalidInput, withDuration: Duration.kMediumDuration)
                    break;
                case 404:
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: ApiErrorMessages.kResourceNotFound, withDuration: Duration.kMediumDuration)
                    break;
                case 408:
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: ApiErrorMessages.kRequestTimeout, withDuration: Duration.kMediumDuration)
                    break;
                case 405:
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: ApiErrorMessages.kMethodNotAllowed, withDuration: Duration.kMediumDuration)
                    break;
                case 500:
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: ApiErrorMessages.kInternalServerError, withDuration: Duration.kMediumDuration)
                    break;
                case 505:
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: ApiErrorMessages.kHttpversionnotsupported, withDuration: Duration.kMediumDuration)
                    break;
                default:
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: ApiErrorMessages.kInternalServerError, withDuration: Duration.kMediumDuration)
                }
                self.appDelegate.hideIndicator()
            })
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
    
    
    
    //MARK: - Controlling the Keyboard for textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txt_clubid {
            textField.resignFirstResponder()
            self.txt_password.becomeFirstResponder()
        } else if textField == self.txt_password {
            textField.resignFirstResponder()
            self.txt_clubid.becomeFirstResponder()
            
             self.view.endEditing(true)

        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let rememberMe = UserDefaults.standard.string(forKey: UserDefaultsKeys.rememberMe.rawValue)
        
        if (rememberMe == "Yes") {
            btnRememberMe.isSelected = true
            
        }
        else{
            btnRememberMe.isSelected = false
        }
        self.rememberMe()
    }
    
    //Added by kiran V1.3 -- PROD0000019 -- Added 2 step verification
    //PROD0000019 -- Start
    private func performLogin(parentMemberinfo : ParentMemberInfo)
    {
        let memberid = parentMemberinfo.memberID
        let membername = parentMemberinfo.memberName
        let memberprofilepic = parentMemberinfo.profilePic
        let parentID = parentMemberinfo.parentId
        let id = parentMemberinfo.id
        let prefix = parentMemberinfo.prefix
        let culturecode = parentMemberinfo.culturecode
        let status = parentMemberinfo.status
        let firstName  = parentMemberinfo.firstName
        let lastName = parentMemberinfo.lastName
        let isFirstTime = parentMemberinfo.isFirstTime
        
        let isAdmin = parentMemberinfo.isAdminvalue
        let role = parentMemberinfo.role
        let userName = parentMemberinfo.userName
        let displayname = parentMemberinfo.displayName
        let fullName = parentMemberinfo.fullName
        let memberNameDisplay = parentMemberinfo.memberNameDisplay
        let memberUserName = parentMemberinfo.memberUserName

        let password = self.txt_password.text?.trimmingCharacters(in: .whitespaces)
        
        if password != nil{
            UserDefaults.standard.set(password, forKey: UserDefaultsKeys.passwordFingerPrint.rawValue)
        }
        UserDefaults.standard.set(isFirstTime, forKey: UserDefaultsKeys.isFirstTime.rawValue)

        UserDefaults.standard.set(memberid, forKey: UserDefaultsKeys.userIDFingerPrint.rawValue)
        UserDefaults.standard.set("false", forKey: UserDefaultsKeys.changePassword.rawValue)

        UserDefaults.standard.set(memberid, forKey: UserDefaultsKeys.userID.rawValue)
        UserDefaults.standard.set(membername, forKey: UserDefaultsKeys.username.rawValue)
        UserDefaults.standard.set(memberprofilepic, forKey: UserDefaultsKeys.userProfilepic.rawValue)
        UserDefaults.standard.set(parentID, forKey: UserDefaultsKeys.parentID.rawValue)
        UserDefaults.standard.set(id, forKey: UserDefaultsKeys.id.rawValue)
        UserDefaults.standard.set(prefix, forKey: UserDefaultsKeys.prefix.rawValue)
        UserDefaults.standard.set(culturecode, forKey: UserDefaultsKeys.culturecode.rawValue)
        UserDefaults.standard.set(status, forKey: UserDefaultsKeys.status.rawValue)
        UserDefaults.standard.set(firstName, forKey: UserDefaultsKeys.firstName.rawValue)
        UserDefaults.standard.set(lastName, forKey: UserDefaultsKeys.lastName.rawValue)

        UserDefaults.standard.set(role, forKey: UserDefaultsKeys.role.rawValue)
        UserDefaults.standard.set(isAdmin, forKey: UserDefaultsKeys.isAdmin.rawValue)
        UserDefaults.standard.set(userName, forKey: UserDefaultsKeys.username.rawValue)
        UserDefaults.standard.set(displayname, forKey: UserDefaultsKeys.displayName.rawValue)
        UserDefaults.standard.set(fullName, forKey: UserDefaultsKeys.fullName.rawValue)
        UserDefaults.standard.set(memberNameDisplay, forKey: UserDefaultsKeys.memberNameDisplay.rawValue)
        UserDefaults.standard.set(memberUserName, forKey: UserDefaultsKeys.memberUserName.rawValue)

        UserDefaults.standard.synchronize()
        
        self.getSettingsApi()
//                    self.getTokenApi()
        self.getMultiLingualApi()
    }
    
    private func performBiometricLogin(parentMemberinfo : ParentMemberInfo)
    {
        let memberid = parentMemberinfo.memberID
        let membername = parentMemberinfo.memberName
        let memberprofilepic = parentMemberinfo.profilePic
        let parentID = parentMemberinfo.parentId
        let id = parentMemberinfo.id
        let prefix = parentMemberinfo.prefix
        let culturecode = parentMemberinfo.culturecode
        let firstName  = parentMemberinfo.firstName
        let lastName = parentMemberinfo.lastName
        let isAdmin = parentMemberinfo.isAdminvalue
        let role = parentMemberinfo.role
        let userName = parentMemberinfo.userName
        let displayname = parentMemberinfo.displayName
        let fullName = parentMemberinfo.fullName
        let memberNameDisplay = parentMemberinfo.memberNameDisplay
        let isFirstTime = parentMemberinfo.isFirstTime
        let memberUserName = parentMemberinfo.memberUserName

        UserDefaults.standard.set(isFirstTime, forKey: UserDefaultsKeys.isFirstTime.rawValue)

        UserDefaults.standard.set(memberid, forKey: UserDefaultsKeys.userIDFingerPrint.rawValue)
        UserDefaults.standard.set(memberid, forKey: UserDefaultsKeys.userID.rawValue)
        UserDefaults.standard.set(membername, forKey: UserDefaultsKeys.username.rawValue)
        UserDefaults.standard.set(memberprofilepic, forKey: UserDefaultsKeys.userProfilepic.rawValue)
        UserDefaults.standard.set(parentID, forKey: UserDefaultsKeys.parentID.rawValue)
        UserDefaults.standard.set(id, forKey: UserDefaultsKeys.id.rawValue)
        UserDefaults.standard.set(prefix, forKey: UserDefaultsKeys.prefix.rawValue)
        UserDefaults.standard.set(culturecode, forKey: UserDefaultsKeys.culturecode.rawValue)
        UserDefaults.standard.set(firstName, forKey: UserDefaultsKeys.firstName.rawValue)
        UserDefaults.standard.set(lastName, forKey: UserDefaultsKeys.lastName.rawValue)

        UserDefaults.standard.set(role, forKey: UserDefaultsKeys.role.rawValue)
        UserDefaults.standard.set(isAdmin, forKey: UserDefaultsKeys.isAdmin.rawValue)
        UserDefaults.standard.set(userName, forKey: UserDefaultsKeys.username.rawValue)
        UserDefaults.standard.set(displayname, forKey: UserDefaultsKeys.displayName.rawValue)
        UserDefaults.standard.set(fullName, forKey: UserDefaultsKeys.fullName.rawValue)
        UserDefaults.standard.set(memberNameDisplay, forKey: UserDefaultsKeys.memberNameDisplay.rawValue)
        UserDefaults.standard.set(memberUserName, forKey: UserDefaultsKeys.memberUserName.rawValue)

        UserDefaults.standard.synchronize()

//                    self.getTokenApi()
        self.getMultiLingualApi()
        self.getSettingsApi()
    }
    //PROD0000019 -- End
    
    //MARK:- Login API called
    func loginApi() -> Void {
        let parameter:[String:Any] = [
            APIKeys.kMemberId: self.txt_clubid.text ?? "",
            APIKeys.kpassword: self.txt_password.text ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kdeviceID: UserDefaults.standard.string(forKey: UserDefaultsKeys.FCMToken.rawValue) ?? ""
        ]
        
        
        if (Network.reachability?.isReachable) == true
        {
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            APIHandler.sharedInstance.postAuthenticateUserApi(paramaterDict:parameter, onSuccess: { parentMemberinfo in
                
                if(parentMemberinfo.memberID != nil && parentMemberinfo.responseCode == InternetMessge.kSuccess)
                {
                    //Modified by kiran V1.3 -- PROD0000019 -- Added 2 step verification
                    //PROD0000019 -- Start
                    if parentMemberinfo.authenticationEnable == 1
                    {
                        var emailView : OTPEmailView? = OTPEmailView.init(frame: self.view.bounds)
                        emailView?.memberID = parentMemberinfo.memberID
                        emailView?.ID = parentMemberinfo.id
                        emailView?.parentID = parentMemberinfo.parentId
                        emailView?.setupScreendata(parentMemberinfo)
                        
                        emailView?.verificationStatus = ({ status in
                            if status
                            {
//                                emailView?.removeFromSuperview()
//                                emailView = nil
                                self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
                                self.performLogin(parentMemberinfo: parentMemberinfo)
                            }
                        })
                        
                        emailView?.backBtnClicked = ({
                            emailView?.removeFromSuperview()
                            emailView = nil
                        })
                        
                        emailView?.closeBtnClicked = ({
                            emailView?.removeFromSuperview()
                            emailView = nil
                        })

                        if let emailView = emailView
                        {
                            self.view.addSubview(emailView)
                        }
                        
                        self.appDelegate.hideIndicator()
                    }
                    else
                    {
                        self.performLogin(parentMemberinfo: parentMemberinfo)
                    }
                    
                    //   print(JSON)
                    /*
                    let memberid = parentMemberinfo.memberID
                    let membername = parentMemberinfo.memberName
                    let memberprofilepic = parentMemberinfo.profilePic
                    let parentID = parentMemberinfo.parentId
                    let id = parentMemberinfo.id
                    let prefix = parentMemberinfo.prefix
                    let culturecode = parentMemberinfo.culturecode
                    let status = parentMemberinfo.status
                    let firstName  = parentMemberinfo.firstName
                    let lastName = parentMemberinfo.lastName
                    let isFirstTime = parentMemberinfo.isFirstTime
                    
                    let isAdmin = parentMemberinfo.isAdminvalue
                    let role = parentMemberinfo.role
                    let userName = parentMemberinfo.userName
                    let displayname = parentMemberinfo.displayName
                    let fullName = parentMemberinfo.fullName
                    let memberNameDisplay = parentMemberinfo.memberNameDisplay
                    let memberUserName = parentMemberinfo.memberUserName

                    let password = self.txt_password.text?.trimmingCharacters(in: .whitespaces)
                    
                    if password != nil{
                        UserDefaults.standard.set(password, forKey: UserDefaultsKeys.passwordFingerPrint.rawValue)
                    }
                    UserDefaults.standard.set(isFirstTime, forKey: UserDefaultsKeys.isFirstTime.rawValue)

                    UserDefaults.standard.set(memberid, forKey: UserDefaultsKeys.userIDFingerPrint.rawValue)
                    UserDefaults.standard.set("false", forKey: UserDefaultsKeys.changePassword.rawValue)

                    UserDefaults.standard.set(memberid, forKey: UserDefaultsKeys.userID.rawValue)
                    UserDefaults.standard.set(membername, forKey: UserDefaultsKeys.username.rawValue)
                    UserDefaults.standard.set(memberprofilepic, forKey: UserDefaultsKeys.userProfilepic.rawValue)
                    UserDefaults.standard.set(parentID, forKey: UserDefaultsKeys.parentID.rawValue)
                    UserDefaults.standard.set(id, forKey: UserDefaultsKeys.id.rawValue)
                    UserDefaults.standard.set(prefix, forKey: UserDefaultsKeys.prefix.rawValue)
                    UserDefaults.standard.set(culturecode, forKey: UserDefaultsKeys.culturecode.rawValue)
                    UserDefaults.standard.set(status, forKey: UserDefaultsKeys.status.rawValue)
                    UserDefaults.standard.set(firstName, forKey: UserDefaultsKeys.firstName.rawValue)
                    UserDefaults.standard.set(lastName, forKey: UserDefaultsKeys.lastName.rawValue)

                    UserDefaults.standard.set(role, forKey: UserDefaultsKeys.role.rawValue)
                    UserDefaults.standard.set(isAdmin, forKey: UserDefaultsKeys.isAdmin.rawValue)
                    UserDefaults.standard.set(userName, forKey: UserDefaultsKeys.username.rawValue)
                    UserDefaults.standard.set(displayname, forKey: UserDefaultsKeys.displayName.rawValue)
                    UserDefaults.standard.set(fullName, forKey: UserDefaultsKeys.fullName.rawValue)
                    UserDefaults.standard.set(memberNameDisplay, forKey: UserDefaultsKeys.memberNameDisplay.rawValue)
                    UserDefaults.standard.set(memberUserName, forKey: UserDefaultsKeys.memberUserName.rawValue)

                    UserDefaults.standard.synchronize()
                    
                    self.getSettingsApi()
//                    self.getTokenApi()
                    self.getMultiLingualApi()
                    */
                    //PROD0000019 -- End
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((parentMemberinfo.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: parentMemberinfo.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    if parentMemberinfo.responseCode == InternetMessge.kFail{
                        if self.txt_clubid.text == "" || self.txt_password.text == "" {
                            SharedUtlity.sharedHelper().showToast(on:
                                self.view, withMeassge: "Please enter Username & Password", withDuration: Duration.kMediumDuration)

                        }
                        else{
                            SharedUtlity.sharedHelper().showToast(on:
                                self.view, withMeassge: parentMemberinfo.responseMessage, withDuration: Duration.kMediumDuration)

                        }
 
                    }
                    
                    
                }
            },onFailure: { error, responseCode  in
                switch(responseCode.statusCode)
                {
                case 401:
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: ApiErrorMessages.kUnauthorized, withDuration: Duration.kMediumDuration)
                    break;
                case 400:
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: ApiErrorMessages.kInvalidInput, withDuration: Duration.kMediumDuration)
                    break;
                case 404:
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: ApiErrorMessages.kResourceNotFound, withDuration: Duration.kMediumDuration)
                    break;
                case 408:
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: ApiErrorMessages.kRequestTimeout, withDuration: Duration.kMediumDuration)
                    break;
                case 405:
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: ApiErrorMessages.kMethodNotAllowed, withDuration: Duration.kMediumDuration)
                    break;
                case 500:
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: ApiErrorMessages.kInternalServerError, withDuration: Duration.kMediumDuration)
                    break;
                case 505:
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: ApiErrorMessages.kHttpversionnotsupported, withDuration: Duration.kMediumDuration)
                    break;
                default:
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: ApiErrorMessages.kInternalServerError, withDuration: Duration.kMediumDuration)
                }
                self.appDelegate.hideIndicator()
            })
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
    //Mark- Reset password Api
    func getSettingsApi() -> Void {
        
        
        let parameter:[String:Any] = [
            APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict]
        ]
        
        if (Network.reachability?.isReachable) == true
        {
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.getSettingsApi(paramaterDict:parameter, onSuccess: { resetPwdinfo in
                
                
                if(resetPwdinfo.responseCode == InternetMessge.kSuccess)
                {
                    if(resetPwdinfo.getSettings == nil)
                    {
                        
                    }
                    else
                    {
                        //Added by kiran V2.5 -- ENGAGE0011395
                        //ENGAGE0011395 -- Start
                        for setting in resetPwdinfo.getSettings!
                        {
                            
                            let isSettingEnabled = (setting.settingValue == 1)
                            
                            switch SettingsKeys.init(rawValue: setting.optionCode!)
                            {
                            case .fingerPrint:
                                UserDefaults.standard.set(isSettingEnabled, forKey: UserDefaultsKeys.fingerPrint.rawValue)
                            case .faceID:
                                UserDefaults.standard.set(isSettingEnabled, forKey: UserDefaultsKeys.faceID.rawValue)
                            case .appNotifications:
                                UserDefaults.standard.set(isSettingEnabled, forKey: UserDefaultsKeys.notification.rawValue)
                            case .contactsToPhone:
                                UserDefaults.standard.set(isSettingEnabled, forKey: UserDefaultsKeys.addToContact.rawValue)
                            case .syncCalendar:
                                UserDefaults.standard.set(isSettingEnabled, forKey: UserDefaultsKeys.synchCalendar.rawValue)
                            case .shareImage:
                                UserDefaults.standard.set(isSettingEnabled, forKey: UserDefaultsKeys.shareUrl.rawValue)
                            case .gimbalService:
                                //Added by kiran V2.7 -- ENGAGE0011628 -- add the logic to start/Stop the gimbal service based on the setting.
                                //ENGAGE0011628 -- Start
                                //Turn service on
                                if isSettingEnabled
                                {
                                    //Checks if the gimbal service is off. if its turned off then we start the service.
                                    if !Gimbal.isStarted()
                                    {
                                        Gimbal.start()
                                    }
                                }//Turn service off
                                else
                                {
                                    //Checks if the gimbal service is turned on. if turned off then we stop the service.
                                    if Gimbal.isStarted()
                                    {
                                        Gimbal.stop()
                                    }
                                }
                                //ENGAGE0011628 -- End
                            case .none:
                                break
                            }
                        }
                        //ENGAGE0011395 -- End
                        
                        //Commented by kiran V2.5 -- ENGAGE0011395
                        //ENGAGE0011395 -- Start
//                        self.settingsvalues = resetPwdinfo.getSettings!
//                        UserDefaults.standard.set(self.settingsvalues.fingerPrintRecognition, forKey: UserDefaultsKeys.fingerPrint.rawValue)
//                        UserDefaults.standard.set(self.settingsvalues.faceIDRecognition, forKey: UserDefaultsKeys.fingerPrint.rawValue)
//                        UserDefaults.standard.set(self.settingsvalues.allowAppNotifications, forKey: UserDefaultsKeys.notification.rawValue)
//                        UserDefaults.standard.set(self.settingsvalues.addContactstoPhone, forKey: UserDefaultsKeys.addToContact.rawValue)
//                        UserDefaults.standard.set(self.settingsvalues.syncCalendar, forKey: UserDefaultsKeys.synchCalendar.rawValue)
//                        UserDefaults.standard.set(self.settingsvalues.shareImage , forKey: UserDefaultsKeys.shareUrl.rawValue)
                        //Added by kiran -- ENGAGE0011230
                       // UserDefaults.standard.set(self.settingsvalues.allowSmsNotifications , forKey: UserDefaultsKeys.smsNotifications.rawValue)
                        //ENGAGE0011395 -- End
                    }
                    self.appDelegate.hideIndicator()
                }
                else
                {
                    self.appDelegate.hideIndicator()
                    if(((resetPwdinfo.responseMessage?.count) ?? 0)>0)
                    {
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: resetPwdinfo.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    
                }
                
                
                self.appDelegate.hideIndicator()
                
                
            },onFailure: { error  in
                
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
                
            })
        }
        else
        {
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
    //MARK:- Dynamic Tab bar/drawer API
    func getIcon() -> Void {
        
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            APIHandler.sharedInstance.getTabbar(paramater:nil, onSuccess: { (tabbarmodelinfo, responseString) in
                
                
                
                if(tabbarmodelinfo.responseCode == InternetMessge.kSuccess){
                    
                    self.appDelegate.hideIndicator()
                    self.appDelegate.tabbarControllerInit = tabbarmodelinfo
                    
                    
                    
                    if (self.isFrom == "Notification"){
                        self.isFrom = ""
                        
                        let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
                        UIApplication.shared.keyWindow?.rootViewController = tabBarVC

                        let appDelegate = UIApplication.shared.delegate as? AppDelegate

                        if  let controller = appDelegate?.window?.rootViewController as? UITabBarController
                        {
                            //Modified by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
                            //ENGAGE0012667 -- Start
                            let nav: CustomNavigationController = CustomNavigationController()//UINavigationController = UINavigationController()
                            //ENGAGE0012667 -- End
                            
                            appDelegate?.window?.rootViewController = nav
                            
                            if let notificationDetail = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "NotificationDetailsVC") as? NotificationDetailVC {
                                
                                
                                notificationDetail.notificationSubject = self.notifyTitle
                                notificationDetail.notificationText = self.notifyText
                                //Added on 21st October 2020 V2.4
                                notificationDetail.shouldUseAPi = true
                                notificationDetail.notificationID = self.notificationID
                                //Added by Kiran V2.5 --GATHER0000441-- Notifications not removing from system tray when opened from app
                                notificationDetail.isRead = false
                                
                                //Commented by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
                                //ENGAGE0012667 -- Start
                                /*
                                 nav.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
                                 nav.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
                                 nav.navigationBar.tintColor = APPColor.viewNews.backButtonColor
                                 */
                                //ENGAGE0012667 -- End
                                nav.setViewControllers([controller,notificationDetail], animated: true)
                                
                            }
                            
                        }
                    }
                    else{
                    let appDelegate = UIApplication.shared.delegate as? AppDelegate
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeController =  mainStoryboard.instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
                    appDelegate?.window?.rootViewController = homeController
                    }
                    
                    
                    let defaults = UserDefaults.standard
                    let responseString = String(describing: defaults.object(forKey: "getTabbar") ?? "")
                    if((responseString.count <= 0)){
                        self.appDelegate.hideIndicator()
                    }
                    
                    
                    self.appDelegate.hideIndicator()
                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    
                    if(((tabbarmodelinfo.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: tabbarmodelinfo.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                }
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                
                self.appDelegate.hideIndicator()
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
//    //MARK:- Token Api
//    func getTokenApi() -> Void {
//        if (Network.reachability?.isReachable) == true{
//            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
//            APIHandler.sharedInstance.getTokenApi(paramater: nil , onSuccess: { tokenList in
//                self.appDelegate.hideIndicator()
//                let access_token = tokenList.access_token
//                let expires_in = tokenList.expires_in
//                let token_type = tokenList.token_type
//                let jointToken = (token_type ?? "") + " " + (access_token ?? "")
//
//                print(jointToken)
//
//                UserDefaults.standard.set(access_token, forKey: UserDefaultsKeys.access_token.rawValue)
//                UserDefaults.standard.set(expires_in, forKey: UserDefaultsKeys.expires_in.rawValue)
//                UserDefaults.standard.set(token_type, forKey: UserDefaultsKeys.token_type.rawValue)
//                UserDefaults.standard.set(jointToken, forKey: UserDefaultsKeys.apiauthtoken.rawValue)
//                UserDefaults.standard.synchronize()
//
//                print(UserDefaults.standard.string(forKey: UserDefaultsKeys.apiauthtoken.rawValue) ?? "")
//                self.getMultiLingualApi()
//
//
//            },onFailure: { error  in
//
//                print(error)
//                SharedUtlity.sharedHelper().showToast(on:
//                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
//            })
//
//
//        }else{
//
//            SharedUtlity.sharedHelper().showToast(on:
//                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
//        }
//    }
    
    
    @IBAction func btnAuthenticatePressed(_ sender: UIButton) {
        self.authBiomatric()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        
    }
    
    //MARK:- tap recognizer
    @objc func tapFunction(tapGestureRecognizer: UITapGestureRecognizer)
    {
        // Safe Push VC
        
        //Modified by kiran V2.9 -- ENGAGE0011569 -- Showing bioemtric image based on device capability and if those are setup in device
        //ENGAGE0011569 -- Start
        
        if BioMetricAuthenticator.shared.faceIDAvailable() || BioMetricAuthenticator.shared.touchIDAvailable()
        {
            if UserDefaults.standard.string(forKey: UserDefaultsKeys.changePassword.rawValue) == "true"
            {
                var message = ""
                if BioMetricAuthenticator.shared.faceIDAvailable()
                {
                    message = "Please login to authenticate your Face ID."
                }
                else if BioMetricAuthenticator.shared.touchIDAvailable()
                {
                    message = "Please login to authenticate your Fingerprint."
                }
                
                let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
                
            }
            else
            {
                self.authBiomatric()
            }
        }
        else
        {
            
        }
        
        
        //Old Logic
        /*
        let device = DeviceInfo.modelName
        
        if  ((device == "iPhone XR" ) || (device == "iPhone XS Max") || (device == "iPhone XS" ) || (device == "iPhone X") || (device == "Simulator iPhone XR") )
        {
            if UserDefaults.standard.string(forKey: UserDefaultsKeys.changePassword.rawValue) == "true"
            {
                let alert = UIAlertController(title: "Alert", message: "Please login to authenticate your Face ID.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                }))
                self.present(alert, animated: true, completion: nil)
                
            }
            else
            {
                self.authBiomatric()
                
            }
        }
        else
        {
            if UserDefaults.standard.string(forKey: UserDefaultsKeys.changePassword.rawValue) == "true"
            {
                let alert = UIAlertController(title: "Alert", message: "Please login to authenticate your Fingerprint.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                }))
                self.present(alert, animated: true, completion: nil)
                
            }
            else
            {
                self.authBiomatric()
                
            }
        }
         */
        //ENGAGE0011569 -- End
    }
    
    //MARK:- Set Label Localization
    func setLocalizedString()
    {
        
        self.btn_login.setTitle(CommonString.kbtnLogin, for: .normal)
        
        
        self.btnForgotPassword.setTitle(CommonString.kforgotPassword, for: .normal)
//        self.imgBackground.image = UIImage(named: CommonImages.login_bg)
        
//        self.imgLogo.image = UIImage(named: CommonImages.login_applogo)
        
        
        txt_clubid.attributedPlaceholder = NSAttributedString(string: CommonString.kmemberID,
                                                              attributes: [NSAttributedStringKey.foregroundColor: APPColor.placeHolderColor.tint ])
        txt_password.attributedPlaceholder = NSAttributedString(string: CommonString.kpassword,
                                                                attributes: [NSAttributedStringKey.foregroundColor: APPColor.placeHolderColor.tint ])
        
    }
    @IBAction func userIdClicked(_ sender: Any) {
        
            let addNewView = UIView(frame: CGRect(x: 0, y: 0, width: 330, height: 40))
        
            addNewLabel = UILabel(frame: CGRect(x: 8, y: 0, width: 330, height: 40))
            addNewLabel?.text = "If using Member ID, then use it in the format: 0####-##"
            addNewLabel?.textColor = hexStringToUIColor(hex: "695B5E")
            addNewLabel?.font = SFont.SourceSansPro_Regular14
            addNewLabel?.numberOfLines = 1
            addNewView.addSubview(addNewLabel!)
        
            addNewPopover = Popover()
            addNewPopover?.arrowSize = CGSize(width: 28.0, height: 13.0)
        
            //let pointt = self.btnUserID.convert(self.btnUserID.center , to: appDelegate.window)
            let btnUserIDCenter = self.view.convert(self.btnUserID.center , to: appDelegate.window)
            addNewPopover?.popoverType = .up

            //let point = CGPoint(x: (self.view.bounds.width - 255)/2 + 230, y: self.view.bounds.height - 400)
            let point = CGPoint(x: btnUserIDCenter.x , y: (btnUserIDCenter.y - self.btnUserID.frame.height/2) + 3)
            addNewPopover?.show(addNewView, point: point)
        
    }
    
    @IBAction func forgotClicked(_ sender: Any) {
        
        
        if let forgot = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ForgotVC") as? ForgotVC {
            forgot.modalTransitionStyle   = .crossDissolve;
            forgot.modalPresentationStyle = .overCurrentContext
            self.present(forgot, animated: true, completion: nil)
        }
    }
    
    
    /**
     This method will present an UIAlertViewController to inform the user that the device has not a TouchID sensor.
     */
    func showAlertViewIfNoBiometricSensorHasBeenDetected(){
        
        showAlertWithTitle(title: CommonString.kerror, message: CommonString.knobiometric)
        
    }
    
    /**
     This method will present an UIAlertViewController to inform the user that there was a problem with the TouchID sensor.
     
     - parameter error: the error message
     
     */
    func showAlertViewAfterEvaluatingPolicyWithMessage( message:String ){
        
        showAlertWithTitle(title: CommonString.kerror, message: message)
        
    }
    
    /**
     This method presents an UIAlertViewController to the user.
     
     - parameter title:  The title for the UIAlertViewController.
     - parameter message:The message for the UIAlertViewController.
     
     */
    func showAlertWithTitle( title:String, message:String ) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: CommonString.kok, style: .default, handler: nil)
        alertVC.addAction(okAction)
        
    }
    
    /**
     This method will return an error message string for the provided error code.
     The method check the error code against all cases described in the `LAError` enum.
     If the error code can't be found, a default message is returned.
     
     - parameter errorCode: the error code
     - returns: the error message
     */
    func errorMessageForLAErrorCode( errorCode:Int ) -> String{
        
        var message = ""
        
        switch errorCode {
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.touchIDLockout.rawValue:
            message = "Too many failed attempts."
            
        case LAError.touchIDNotAvailable.rawValue:
            message = "TouchID is not available on the device"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = "Did not find error code on LAError object"
            
        }
        
        return message
        
    }
    
    /**
     This method will push the authenticated view controller onto the UINavigationController stack
     */
    func navigateToAuthenticatedViewController(){
        //pushview controller after success
        
        
    }
    
    //Mark - Hide Status Bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK:- getMultiLingual Api
    func getMultiLingualApi() -> Void{
        
        if (Network.reachability?.isReachable) == true{
            let paramaterDict:[String: Any] = [
                APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? ""
            ]
            
            APIHandler.sharedInstance.getLocalizationData(paramater: paramaterDict, onSuccess: { (localizeinfo, responseString, localizeinfoDict) in
                if(localizeinfo.responseCode == InternetMessge.kSuccess){
                    //                    self.masterLabeling = localizeinfo
                    let cultureCode = UserDefaults.standard.string(forKey: UserDefaultsKeys.culturecode.rawValue) ?? ""
                    
                    for dictData in localizeinfoDict{
                        print(dictData.key)
                        if(dictData.key == cultureCode){
                            print(dictData.value)
                            let masterData = Mapper<MainLangauage>().map(JSONObject: dictData.value)!
                            //                            let masterData = Mapper<MainLangauage>().map(JSONObject: dictData.value)!
                            self.appDelegate.masterLabeling = masterData.label!
                            print(masterData.label?.aDD_GUEST ?? "")
                            self.getIcon()
                            break;
                        }
                    }
                    
                    UserDefaults.standard.set(responseString, forKey: UserDefaultsKeys.getMultiLingualData.rawValue)
                    UserDefaults.standard.synchronize()
                    
                }
            },onFailure: { error  in
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == self.txt_password){
            let nsString:NSString? = textField.text as NSString?
            let updatedString = nsString?.replacingCharacters(in:range, with:string);
            
            textField.text = updatedString;
            
            //Setting the cursor at the right place
            let selectedRange = NSMakeRange(range.location + string.count, 0)
            let from = textField.position(from: textField.beginningOfDocument, offset:selectedRange.location)
            let to = textField.position(from: from!, offset:selectedRange.length)
            textField.selectedTextRange = textField.textRange(from: from!, to: to!)
            
            //Sending an action
            textField.sendActions(for: UIControlEvents.editingChanged)
            
            return false;
        }
        else
        {
            return true;
        }
        
    }
}

//MARK:- Focus for Password textfield
class PasswordTextField: UITextField {
    
    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                _ = becomeFirstResponder()
            }
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        
        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            self.text?.removeAll()
            insertText(text)
        }
        return success
    }
    
}

extension UITextField {
    func addBorderBottom(height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height - height, width: self.frame.width, height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

class LeftPaddedTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
}
