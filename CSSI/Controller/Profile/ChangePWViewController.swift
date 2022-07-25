//
//  ChangePWViewController.swift
//  CSSI
//
//  Created by apple on 4/4/19.
//  Copyright © 2019 yujdesigns. All rights reserved.

import UIKit
import FLAnimatedImage
import Alamofire
import IQKeyboardManagerSwift
import ObjectMapper

class ChangePWViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var viewProfileTopView: UIView!
    @IBOutlet weak var imgProfilePic: FLAnimatedImageView!
    @IBOutlet weak var lblPasswordPolicyTitle: UILabel!
    @IBOutlet weak var lblPasswordRules1: UILabel!
    @IBOutlet weak var lblUserIdPassword: UILabel!
    @IBOutlet weak var lblCurrentPasswordText: UILabel!
    @IBOutlet weak var lblConfirmPasswordText: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblDisplayUserName: UILabel!
    @IBOutlet weak var lblPasswordRule2: UILabel!
    @IBOutlet weak var lblPasswordRule3: UILabel!
    @IBOutlet weak var lblPasswordRul4: UILabel!
    @IBOutlet weak var btnSaveFirstTime: UIButton!
    
    @IBOutlet weak var saveButtonWidth: NSLayoutConstraint!
    
    @IBOutlet weak var btnCurrentPass: UIButton!
    @IBOutlet weak var btnNewPass: UIButton!
    @IBOutlet weak var btnConfirmpass: UIButton!
    @IBOutlet weak var txtUserID: UITextField!
    @IBOutlet weak var txtCurrentPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtconfirmPassword: UITextField!
    @IBOutlet weak var lblVersion: UILabel!
    
    @IBOutlet weak var lblMemberactive: UILabel!
    @IBOutlet weak var lblMemberId: UILabel!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnIgnore: UIButton!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var memberActive : String!
    var memberID : String!
    var displayName : String!
    var profilePic : String!
    var UserID : String!
    var isFrom: String?
    override func viewDidLoad() {
        super.viewDidLoad()
 
        if UserDefaults.standard.string(forKey: UserDefaultsKeys.isFirstTime.rawValue)  == "1" {
            self.btnSave.isHidden = true
            self.btnIgnore.isHidden = true
            self.btnSaveFirstTime.isHidden = false
        self.getMultiLingualApi()
        }else{
            self.btnSave.isHidden = false
            self.btnIgnore.isHidden = false
            self.btnSaveFirstTime.isHidden = true
            self.initViewController()
        }
        
        // Do any additional setup after loading the view.
        
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
       
 
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
        
    }
    func initViewController(){
        self.lblVersion.text = String(format: "Version %@", (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String)!)
        self.lblPassword.text = self.appDelegate.masterLabeling.new_password
        self.lblPasswordPolicyTitle.text = self.appDelegate.masterLabeling.passwordRulsTitle
        self.lblPasswordRules1.text = self.appDelegate.masterLabeling.passwordRuls1
        self.lblPasswordRule2.text = self.appDelegate.masterLabeling.passwordRuls2
        self.lblPasswordRule3.text = self.appDelegate.masterLabeling.passwordRuls3
        self.lblPasswordRul4.text = self.appDelegate.masterLabeling.passwordRuls4
        
        self.lblUserIdPassword.text = self.appDelegate.masterLabeling.uSER_NAME_ASTERISK ?? ""
        self.lblCurrentPasswordText.text = self.appDelegate.masterLabeling.current_password ?? ""
        
        self.txtUserID.text = UserID
        
        txtNewPassword.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        txtCurrentPassword.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        txtconfirmPassword.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        
        //        self.txtUserID.placeholder = self.appDelegate.masterLabeling.username
        //
        //        self.txtNewPassword.placeholder = self.appDelegate.masterLabeling.new_password
        //        self.txtCurrentPassword.placeholder = self.appDelegate.masterLabeling.current_password
        //        self.txtconfirmPassword.placeholder = self.appDelegate.masterLabeling.cONFIRM_PASSWORD
        
        self.lblConfirmPasswordText.text = self.appDelegate.masterLabeling.confirm_password
        self.lblMemberId.font = SFont.SourceSansPro_Regular18
        self.lblMemberactive.font = SFont.SourceSansPro_Regular18
        self.lblDisplayUserName.font = SFont.SourceSansPro_Regular18
        
        self.lblMemberId.text =  (self.appDelegate.masterLabeling.hASH ?? "") + memberID
        self.lblMemberactive.text = memberActive
        self.lblDisplayUserName.text = displayName
        
        
        self.btnIgnore.layer.cornerRadius = 20
        self.btnIgnore.layer.masksToBounds = true
        self.btnIgnore.layer.borderColor = UIColor.red.cgColor
        self.btnIgnore.layer.borderWidth = 1
        
        self.btnSave.layer.cornerRadius = 20
        self.btnSave.layer.masksToBounds = true
        self.btnSave.layer.borderColor = UIColor.red.cgColor
        self.btnSave.layer.borderWidth = 1
        
        self.btnSaveFirstTime.layer.cornerRadius = 20
        self.btnSaveFirstTime.layer.masksToBounds = true
        self.btnSaveFirstTime.layer.borderColor = UIColor.red.cgColor
        self.btnSaveFirstTime.layer.borderWidth = 1
        
        viewProfileTopView.layer.shadowColor = UIColor.black.cgColor
        viewProfileTopView.layer.shadowOpacity = 0.16
        viewProfileTopView.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewProfileTopView.layer.shadowRadius = 2
        
        
        self.btnSave.backgroundColor = APPColor.tintColor.tintNew
        self.btnSave.layer.borderColor = APPColor.tintColor.tintNew.cgColor
        
        self.btnSaveFirstTime.backgroundColor = APPColor.tintColor.tintNew
        self.btnSaveFirstTime.layer.borderColor = APPColor.tintColor.tintNew.cgColor

        self.btnIgnore.backgroundColor = APPColor.viewBgColor.viewbg
        self.btnIgnore.layer.borderColor = APPColor.tintColor.tintNew.cgColor
        
        self.btnSaveFirstTime.setTitleColor(APPColor.viewBgColor.viewbg, for: .normal)

        
        self.btnSave.setTitleColor(APPColor.viewBgColor.viewbg, for: .normal)
        self.btnIgnore.setTitleColor(APPColor.tintColor.tintNew, for: .normal)
        
        self.btnSaveFirstTime .setTitle(self.appDelegate.masterLabeling.sAVE, for: .normal)

        self.btnSave .setTitle(self.appDelegate.masterLabeling.sAVE, for: .normal)
        self.btnIgnore .setTitle(self.appDelegate.masterLabeling.iGNORE, for: .normal)
        
        self.imgProfilePic.layer.cornerRadius = self.imgProfilePic.frame.size.width / 2
        self.imgProfilePic.layer.masksToBounds = true
        self.txtUserID.delegate = self
        self.imgProfilePic.layer.borderColor = UIColor.white.cgColor
        self.imgProfilePic.layer.borderWidth = 1.0
        //  self.txtUserID.delegate = self
        //        let opacity:CGFloat =  0.4
        //        let borderColor = UIColor.white
        //        self.self.imgProfilePic.layer.borderColor = borderColor.withAlphaComponent(opacity).cgColor
        
        //Commented by kiran V1.3 -- PROD0000036 -- removing place holder image from app
        //PROD0000036 -- Start
        self.imgProfilePic.image = nil
        /*
        let placeholder:UIImage = UIImage(named: "avtar")!
        self.imgProfilePic.image = placeholder
        */
        //PROD0000036 -- End
        
        if(profilePic == nil)
        {
            
        }
        else{
            
            //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead
            //ENGAGE0011419 -- Start
            let imageURLString = profilePic ?? ""
            
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
            if(imageURLString!.count>0){
                let validUrl = self.verifyUrl(urlString: imageURLString)
                if(validUrl == true){
                    let url = URL.init(string:imageURLString ?? "")
                    self.imgProfilePic.sd_setImage(with: url , placeholderImage: placeholder)
                }
            }
            */
            //ENGAGE0011419 -- End
            
        }
        
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = true
        
        self.navigationItem.title = self.appDelegate.masterLabeling.tT_PROFILE
        
        if UserDefaults.standard.string(forKey: UserDefaultsKeys.isFirstTime.rawValue)  == "1" {
            self.btnIgnore.isEnabled = false
        }else{
            let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
            navigationItem.rightBarButtonItem = homeBarButton
            //  self.btnIgnore.isEnabled = false
            //            self.btnIgnore.isHidden = true
        }
        
        self.btnSave.setStyle(style: .contained, type: .primary)
        self.btnIgnore.setStyle(style: .outlined, type: .primary)
        self.btnSaveFirstTime.setStyle(style: .outlined, type: .primary)
        self.mandatoryfileds()
    }
    func mandatoryfileds(){
        
        let current: NSMutableAttributedString = NSMutableAttributedString(string: self.lblCurrentPasswordText.text!)
        current.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblCurrentPasswordText.attributedText = current

        let newPassword: NSMutableAttributedString = NSMutableAttributedString(string: self.lblPassword.text!)
        newPassword.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblPassword.attributedText = newPassword

        let confirmPassword: NSMutableAttributedString = NSMutableAttributedString(string: self.lblConfirmPasswordText.text!)
        confirmPassword.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblConfirmPasswordText.attributedText = confirmPassword

        
        let userName: NSMutableAttributedString = NSMutableAttributedString(string: self.lblUserIdPassword.text!)
        userName.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
        self.lblUserIdPassword.attributedText = userName
    }
    
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
    
    //MARK:- Language File  Api

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
                           
                            self.initViewController()
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
    
    
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow

        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
    }

    @IBAction func saveBtnTapped(_ sender: UIButton) {
        
       
        self.changePasswordApi()
        
    }
    
    @IBAction func btnIgnorePressed(_ sender: UIButton) {
        
        self.IgnoreClicked()
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }

    func IgnoreClicked()
    {

        self.navigationController?.popViewController(animated: true)
    }
    
    //Mark- Reset password Api
    func changePasswordApi() -> Void {
        
        
        let parameter:[String:Any] = [
            APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kusername: (self.txtUserID.text ?? "").replacingOccurrences(of: "'", with: "\\''\\'"),
            APIKeys.kcurrentPassword: self.txtCurrentPassword.text ?? "",
            APIKeys.knewPassword: self.txtNewPassword.text ?? "",
            APIKeys.kconfirmpassword: self.txtconfirmPassword.text ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict]
        ]
        print(parameter)
        
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.changePasswordApi(paramaterDict:parameter, onSuccess: { resetPwdinfo in
                
                
                if(resetPwdinfo.responseCode == InternetMessge.kSuccess){
                    
                    
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: self.appDelegate.masterLabeling.rESET_SUCCESSFUL, withDuration: Duration.kMediumDuration)
                    
                    UserDefaults.standard.set("true", forKey: UserDefaultsKeys.changePassword.rawValue)

                    self.txtconfirmPassword.text = ""
                    self.txtNewPassword.text = ""
                    self.txtCurrentPassword.text = ""
                    let delay = 2 // seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
                        if UserDefaults.standard.string(forKey: UserDefaultsKeys.isFirstTime.rawValue)  == "1" {
                            
                            UserDefaults.standard.set("0", forKey: UserDefaultsKeys.isFirstTime.rawValue)
                            let appDelegate = UIApplication.shared.delegate as? AppDelegate
                            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let homeController =  mainStoryboard.instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
                            appDelegate?.window?.rootViewController = homeController


                        }else{
                        self.IgnoreClicked()
                        }
                        
                    }
                    
                    
                    self.appDelegate.hideIndicator()
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((resetPwdinfo.responseMessage?.count) ?? 0)>0){
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
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
        
        
    }
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            
        }
    }
    
    func userLogOut(){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            APIHandler.sharedInstance.getTabbar(paramater:nil, onSuccess: { (tabbarmodelinfo, responseString) in
                
                
                
                if(tabbarmodelinfo.responseCode == InternetMessge.kSuccess){
                    
                    self.appDelegate.hideIndicator()
                    self.appDelegate.tabbarControllerInit = tabbarmodelinfo
                    
                    
                    
//                    if (self.isFrom == "Notification"){
//                        self.isFrom = ""
//
//                        let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
//                        UIApplication.shared.keyWindow?.rootViewController = tabBarVC
//
//                        let appDelegate = UIApplication.shared.delegate as? AppDelegate
                    
//                        if  let controller = appDelegate?.window?.rootViewController as? UITabBarController
//                        {
//                            let nav: UINavigationController = UINavigationController()
//
//                            appDelegate?.window?.rootViewController = nav
//
//                            if let notificationDetail = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "NotificationDetailsVC") as? NotificationDetailVC {
//
//
//                                notificationDetail.notificationSubject = self.notifyTitle
//                                notificationDetail.notificationText = self.notifyText
//
//
//                                nav.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
//                                nav.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
//                                nav.navigationBar.tintColor = APPColor.viewNews.backButtonColor
//                                nav.setViewControllers([controller,notificationDetail], animated: true)
//                            }
//
//                        }
//                    }
//                    else{
                        let appDelegate = UIApplication.shared.delegate as? AppDelegate
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let homeController =  mainStoryboard.instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
                        appDelegate?.window?.rootViewController = homeController
//                    }
                    
                    
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
    
    
    @IBAction func confirmPassClicked(_ sender: Any) {
        let btn : UIButton = sender as! UIButton
        
        if btn.tag == 0{
            btn.tag = 1
            self.txtconfirmPassword.isSecureTextEntry = false
            self.btnConfirmpass.setImage(UIImage(named: "Password not visible_Create New Password"), for: UIControlState.normal)
        }
        else{
            btn.tag = 0
            self.txtconfirmPassword.isSecureTextEntry = true
            self.btnConfirmpass.setImage(UIImage(named: "Password not visible-Create New Password"), for: UIControlState.normal)
        }
    }
    
    @IBAction func newPassClicked(_ sender: Any) {
        let btn : UIButton = sender as! UIButton
        
        if btn.tag == 0{
            btn.tag = 1
            self.txtNewPassword.isSecureTextEntry = false
            self.btnNewPass.setImage(UIImage(named: "Password not visible_Create New Password"), for: UIControlState.normal)
        }
        else{
            btn.tag = 0
            self.txtNewPassword.isSecureTextEntry = true
            self.btnNewPass.setImage(UIImage(named: "Password not visible-Create New Password"), for: UIControlState.normal)
        }
    }
    
    @IBAction func currentPassClicked(_ sender: Any) {
        let btn : UIButton = sender as! UIButton
        
        if btn.tag == 0{
            btn.tag = 1
            self.txtCurrentPassword.isSecureTextEntry = false
            self.btnCurrentPass.setImage(UIImage(named: "Password not visible_Create New Password"), for: UIControlState.normal)
        }
        else{
            btn.tag = 0
            self.txtCurrentPassword.isSecureTextEntry = true
            self.btnCurrentPass.setImage(UIImage(named: "Password not visible-Create New Password"), for: UIControlState.normal)
        }
    }
    
}
