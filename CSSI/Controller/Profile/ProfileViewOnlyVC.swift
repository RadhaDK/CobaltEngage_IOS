//
//  ProfileViewOnlyVC.swift
//  CSSI
//  Created by apple on 4/4/19.
//  Copyright © 2019 yujdesigns. All rights reserved.


import UIKit
import FLAnimatedImage

class ProfileViewOnlyVC: UIViewController {
    @IBOutlet weak var viewProfileTopView: UIView!
    @IBOutlet weak var imgProfilePic: FLAnimatedImageView!
    @IBOutlet weak var lblDisplayUserName: UILabel!
    @IBOutlet weak var lblMemberId: UILabel!
    @IBOutlet weak var lblSettings: UILabel!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var viewLogout: UIView!
    
    @IBOutlet weak var lblLogout: UILabel!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var viewSettings: UIView!
    
    
    @IBOutlet weak var isHiddenBirthday: UILabel!
    @IBOutlet weak var isHiddenVillage: UILabel!
    @IBOutlet weak var isHiddenBocawestAddress: UILabel!
    @IBOutlet weak var isHiddenNussinessAdd: UILabel!
    @IBOutlet weak var isHiddenOther: UILabel!
    @IBOutlet weak var isHiddenHomePhone: UILabel!
    @IBOutlet weak var isHiddenSecMail: UILabel!
    @IBOutlet weak var isHiddenPrimaryMail: UILabel!
    @IBOutlet weak var isHiddenOtherPhone: UILabel!
    @IBOutlet weak var isHiddenCellPhone: UILabel!
    @IBOutlet weak var lblBirthday: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgBdayIcon: UIImageView!
    
    @IBOutlet weak var lblVillageName: UILabel!
    @IBOutlet weak var lblVillageValue: UILabel!
    
    @IBOutlet weak var imgAnniverseryIcon: UIImageView!
    @IBOutlet weak var lblAnniversary: UILabel!
    @IBOutlet weak var lblAnnDate: UILabel!
    
    @IBOutlet weak var imgHomePhone: UIImageView!
    @IBOutlet weak var lblHome: UILabel!
    @IBOutlet weak var lblHomePhoneNumber: UILabel!
    
    @IBOutlet weak var imgCellNumber: UIImageView!
    @IBOutlet weak var lblCellNumber: UILabel!
    @IBOutlet weak var lblCellNumberNo: UILabel!
    
    @IBOutlet weak var imgOtherNumber: UIImageView!
    @IBOutlet weak var lblOtherTest: UILabel!
    @IBOutlet weak var lblOtherNumber: UILabel!
    
    @IBOutlet weak var imgPrimaryIcon: UIImageView!
    @IBOutlet weak var lblPrimaryText: UILabel!
    @IBOutlet weak var lblPrimaryEmail: UILabel!
    
    
    @IBOutlet weak var lblSecondryText: UILabel!
    @IBOutlet weak var lblSecondaryEmail: UILabel!
    
    @IBOutlet weak var lblSendStatements: UILabel!
    @IBOutlet weak var lblSendMagazine: UILabel!
    @IBOutlet weak var txtSendStatement: UILabel!
    @IBOutlet weak var txtSendMagazine: UILabel!
    
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblAddressDetails: UILabel!
    @IBOutlet weak var lblAddressType2: UILabel!
    
    
    @IBOutlet weak var lblAddressOther: UILabel!
    @IBOutlet weak var lblAddressOtherDetail: UILabel!
    @IBOutlet weak var lblAddressOtherType2: UILabel!
    
    @IBOutlet weak var lblAddressBussiness: UILabel!
    @IBOutlet weak var lblAddressBussinessDetail: UILabel!
    @IBOutlet weak var lblAddressBussinessType2: UILabel!
    
    @IBOutlet weak var lblIntresetList: UILabel!
    @IBOutlet weak var lblMyIntrest: UILabel!
    
    @IBOutlet weak var lblTargetting: UILabel!
    @IBOutlet weak var lblTargettingON: UILabel!
    
    @IBOutlet weak var lblMemberIDAndName: UILabel!
    @IBOutlet weak var lblVersion: UILabel!
    @IBOutlet weak var uiScrollView: UIScrollView!

    @IBOutlet weak var profileViewHeight: NSLayoutConstraint!

    @IBOutlet weak var btnPrivacyPolicy: UIButton!
    
    @IBOutlet weak var btnTermsOfUse: UIButton!
    
    @IBOutlet weak var viewDivider: UIView!
    var arrMarketOptions :[String] = []
    var arrSelectedMarketOptions  = [TargetedMarketingOption]()


    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var dictmemberInfo = GetMemberInfo()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnTermsOfUse.setTitleColor(APPColor.MainColours.primary2, for: .normal)
        self.btnPrivacyPolicy.setTitleColor(APPColor.MainColours.primary2, for: .normal)
        self.viewDivider.backgroundColor = APPColor.MainColours.primary2
        // Do any additional setup after loading the view.
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
        
        //Added by kiran V1.3 -- PROD0000036 -- removing place holder image set in storyboard
        //PROD0000036 -- Start
        self.imgProfilePic.image = nil
        //PROD0000036 -- End
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        
            self.profileViewHeight.constant = 1790 + lblTargettingON.frame.height + lblIntresetList.frame.height
            uiScrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: self.profileViewHeight.constant)
            
        }
    override func viewWillAppear(_ animated: Bool) {
        self.getMemberInfoApi()
        self.arrSelectedMarketOptions.removeAll()
        self.arrMarketOptions.removeAll()
        
        lblLogout.text = (self.appDelegate.masterLabeling.lOGOUT ?? "")
        
        
        
        self.imgProfilePic.layer.cornerRadius = self.imgProfilePic.frame.size.width / 2
        self.imgProfilePic.layer.masksToBounds = true
        self.imgProfilePic.layer.borderColor = UIColor.white.cgColor
        self.imgProfilePic.layer.borderWidth = 1.0

       // let opacity:CGFloat =  0.4
       // let borderColor = UIColor.white
       // self.imgProfilePic.layer.borderColor = borderColor.withAlphaComponent(opacity).cgColor
        
        
        self.btnEdit.backgroundColor = .clear
        self.btnEdit.layer.cornerRadius = 17
        self.btnEdit.layer.borderWidth = 1
        self.btnEdit.layer.borderColor = hexStringToUIColor(hex: "67aac9").cgColor
        
        
        self.btnEdit.setTitleColor(hexStringToUIColor(hex: "67aac9"), for: .normal)
        
        
        let logOutgesture = UITapGestureRecognizer(target: self, action:  #selector(logout(sender:)))
        self.viewLogout.addGestureRecognizer(logOutgesture)
        
        let settingsgesture = UITapGestureRecognizer(target: self, action:  #selector(settings(sender:)))
        self.viewSettings.addGestureRecognizer(settingsgesture)
        
        
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = true
        
        self.navigationItem.title = self.appDelegate.masterLabeling.tT_PROFILE
        
        self.btnPrivacyPolicy.setTitle(self.appDelegate.masterLabeling.PRIVACY_POLICY ?? CommonString.kprivacypolicy, for: .normal)
        self.btnTermsOfUse.setTitle(self.appDelegate.masterLabeling.TERMS_of_Use ?? CommonString.kTerms, for: .normal)
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
    }
        
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
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

    @IBAction func editClicked(_ sender: Any) {
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)

        
        if let profileDetails = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ProfileViewsController") as? ProfileViewsController {

            self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor
            self.navigationController?.pushViewController(profileDetails, animated: true)

        }
    }
    
    @IBAction func privacyPolicyClicked(_ sender: UIButton) {
        
        
        if let url = URL.init(string: self.appDelegate.privacyPolicyLink ?? CommonURL.privacyPolicy)
        {
            self.openUrl(url: url)
        }
    }
    
    @IBAction func termsofUseClicked(_ sender: UIButton)
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
    
    
    @objc func logout(sender : UITapGestureRecognizer) {
        self.userLogOut()

        
        let prefs = UserDefaults.standard
        
        //            let keyValue = prefs.string(forKey:UserDefaultsKeys.userID)
        //            print(keyValue!)
        prefs.removeObject(forKey:"userID")
        prefs.removeObject(forKey:"getTabbar")
        prefs.removeObject(forKey: "parentID")
        prefs.removeObject(forKey: "id")
        prefs.removeObject(forKey: "username")
        prefs.removeObject(forKey: "masterList")
        
        UserDefaults.standard.synchronize()
        
        
        self.resetDefaults()
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let initialLoginVC = mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        //Modified by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
        //ENGAGE0012667 -- Start
        let navigationController = CustomNavigationController(rootViewController: initialLoginVC)//UINavigationController(rootViewController: initialLoginVC)
        //ENGAGE0012667 -- End
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
        
        let viewControllers = self.navigationController!.viewControllers as [UIViewController];
        print("viewControllers:",viewControllers)
    }
    
    //MARK:- Logout Api

    func userLogOut(){
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? ""
              
            ]
            
            APIHandler.sharedInstance.getUserLogout(paramaterDict: paramaterDict , onSuccess: { eventList in
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
    }
    
    @objc func settings(sender : UITapGestureRecognizer) {
        if let settingsVC = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController {
            
            self.navigationController?.pushViewController(settingsVC, animated: true)
            
        }
    }
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            
        }
    }
    //MARK:- Member Info  Api

    func getMemberInfoApi() -> Void {
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
//            let deviceInfo:[String: Any] = [
//                APIKeys.kDeviceType: DeviceInfo.iosType,
//                APIKeys.kOSVersion:  DeviceInfo.iosVersion,
//                APIKeys.kOriginatingIP : "192.168.1.15",
//                ]
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
                
                
                self.lblMemberId.text =  (self.appDelegate.masterLabeling.hASH ?? "") + (arrgetMemberInfo.memberMasterID ?? "" )
              //  self.lblMemberactive.text = arrgetMemberInfo.status
                
                self.txtUserName.text = String(format: "%@: %@", self.appDelegate.masterLabeling.username ?? "", arrgetMemberInfo.username ?? "")
                
                // self.txtUserName.text =  (self.appDelegate.masterLabeling.uSER_NAME) + (arrgetMemberInfo.username ?? "")
                // self.txtNewPassword.text = arrgetMemberInfo.password ?? ""
                
                if arrgetMemberInfo.showBirthday == 1{
                    self.isHiddenBirthday.isHidden = true
                }
                else{
                    self.isHiddenBirthday.isHidden = false
                    self.isHiddenBirthday.textColor = APPColor.profileColor.dividercolor
                    self.isHiddenBirthday.text = "(" + self.appDelegate.masterLabeling.hIDDEN! + ")"
                    self.isHiddenBirthday.font = UIFont.italicSystemFont(ofSize: 16)
                }
              
                if arrgetMemberInfo.showVillageName == 1{
                    self.isHiddenVillage.isHidden = true
                    
                }
                else{
                    self.isHiddenVillage.isHidden = false
                    self.isHiddenVillage.textColor = APPColor.profileColor.dividercolor
                    self.isHiddenVillage.text = "(" + self.appDelegate.masterLabeling.hIDDEN! + ")"
                    self.isHiddenVillage.font = UIFont.italicSystemFont(ofSize: 16)
                }
                
               
                if arrgetMemberInfo.showHomePhone == 1{
                    self.isHiddenHomePhone.isHidden = true

                }
                else{
                    self.isHiddenHomePhone.isHidden = false
                    self.isHiddenHomePhone.textColor = APPColor.profileColor.dividercolor
                    self.isHiddenHomePhone.text = "(" + self.appDelegate.masterLabeling.hIDDEN! + ")"
                    self.isHiddenHomePhone.font = UIFont.italicSystemFont(ofSize: 16)
                }
                if arrgetMemberInfo.showCellPhone == 1{
                    self.isHiddenCellPhone.isHidden = true

                }
                else{
                    self.isHiddenCellPhone.isHidden = false

                    self.isHiddenCellPhone.textColor = APPColor.profileColor.dividercolor
                    self.isHiddenCellPhone.text = "(" + self.appDelegate.masterLabeling.hIDDEN! + ")"
                    self.isHiddenCellPhone.font = UIFont.italicSystemFont(ofSize: 16)
                }
                if arrgetMemberInfo.showOtherPhone == 1{
                    self.isHiddenOtherPhone.isHidden = true

                }
                else{
                    self.isHiddenOtherPhone.isHidden = false

                    self.isHiddenOtherPhone.textColor = APPColor.profileColor.dividercolor
                    self.isHiddenOtherPhone.text = "(" + self.appDelegate.masterLabeling.hIDDEN! + ")"
                    self.isHiddenOtherPhone.font = UIFont.italicSystemFont(ofSize: 16)
                }
                if arrgetMemberInfo.showPrimaryEmail == 1{
                    self.isHiddenPrimaryMail.isHidden = true

                }
                else{
                    self.isHiddenPrimaryMail.isHidden = false

                    self.isHiddenPrimaryMail.textColor = APPColor.profileColor.dividercolor
                    self.isHiddenPrimaryMail.text = "(" + self.appDelegate.masterLabeling.hIDDEN! + ")"
                    self.isHiddenPrimaryMail.font = UIFont.italicSystemFont(ofSize: 16)
                }
                if arrgetMemberInfo.showSecondaryEmail == 1{
                    self.isHiddenSecMail.isHidden = true

                }
                else{
                    self.isHiddenSecMail.isHidden = false

                    self.isHiddenSecMail.textColor = APPColor.profileColor.dividercolor
                    self.isHiddenSecMail.text = "(" + self.appDelegate.masterLabeling.hIDDEN! + ")"
                    self.isHiddenSecMail.font = UIFont.italicSystemFont(ofSize: 16)
                }
                if arrgetMemberInfo.addressBussiness == 1{
                    self.isHiddenNussinessAdd.isHidden = true

                }
                else{
                    self.isHiddenNussinessAdd.isHidden = false
                    self.isHiddenNussinessAdd.textColor = APPColor.profileColor.dividercolor
                    self.isHiddenNussinessAdd.text = "(" + self.appDelegate.masterLabeling.hIDDEN! + ")"
                    self.isHiddenNussinessAdd.font = UIFont.italicSystemFont(ofSize: 16)
                }
                if arrgetMemberInfo.addressOther == 1{
                    self.isHiddenOther.isHidden = true

                }
                else{
                    self.isHiddenOther.isHidden = false
                    self.isHiddenOther.textColor = APPColor.profileColor.dividercolor
                    self.isHiddenOther.text = "(" + self.appDelegate.masterLabeling.hIDDEN! + ")"
                    self.isHiddenOther.font = UIFont.italicSystemFont(ofSize: 16)
                }
                if arrgetMemberInfo.showBocaAddress == 1{
                    self.isHiddenBocawestAddress.isHidden = true
                    
                }
                else{
                    self.isHiddenBocawestAddress.isHidden = false
                    self.isHiddenBocawestAddress.textColor = UIColor.white
                    self.isHiddenBocawestAddress.text = "(" + self.appDelegate.masterLabeling.hIDDEN! + ")"
                    self.isHiddenBocawestAddress.font = UIFont.italicSystemFont(ofSize: 16)
                }
                
                self.lblDate.text = arrgetMemberInfo.dateOfBirth ?? ""
                self.lblBirthday.text = self.appDelegate.masterLabeling.bIRTHDAY ?? ""
                
                self.lblVillageName.text = self.appDelegate.masterLabeling.vILLAGENAME ?? ""
                self.lblVillageValue.text = arrgetMemberInfo.village ?? ""
                
                self.lblHome.text = self.appDelegate.masterLabeling.hOME_PHONE ?? ""
                self.lblHomePhoneNumber.text = arrgetMemberInfo.primaryPhone ?? ""
                
                self.lblAnniversary.text = self.appDelegate.masterLabeling.aNNIVERSARY ?? ""
                self.lblAnnDate.text = arrgetMemberInfo.anniversaryDate ?? ""
                
                self.lblCellNumber.text = self.appDelegate.masterLabeling.cELL_PHONE ?? ""
                self.lblCellNumberNo.text = arrgetMemberInfo.secondaryPhone ?? ""
                
                self.lblOtherTest.text = self.appDelegate.masterLabeling.other_phone ?? ""
                self.lblOtherNumber.text = arrgetMemberInfo.alternatePhone ?? ""
                
                self.lblPrimaryText.text = self.appDelegate.masterLabeling.pRIMARY_EMAIL ?? ""
                self.lblPrimaryEmail.text = arrgetMemberInfo.primaryEmail ?? ""
                
                self.lblSecondryText.text = self.appDelegate.masterLabeling.sECONDARY_EMAIL ?? ""
                self.lblSecondaryEmail.text = arrgetMemberInfo.secondaryEmail ?? ""
                
                self.txtSendStatement.text = arrgetMemberInfo.sendSatements ?? ""
                self.txtSendMagazine.text = arrgetMemberInfo.sendmagazine ?? ""
                
                // if (s)
                self.lblAddress.text = self.appDelegate.masterLabeling.address_bocawest
                self.lblAddressBussiness.text = self.appDelegate.masterLabeling.address_bussiness
                self.lblAddressOther.text = self.appDelegate.masterLabeling.address_other



                if (arrgetMemberInfo.address?.count)! > 0 {
                self.lblAddressDetails.text = arrgetMemberInfo.address![0].street1 ?? ""
                self.lblAddressType2.text = arrgetMemberInfo.address![0].fullBWAddress ?? ""
                }
                if (arrgetMemberInfo.address?.count)! > 2 {
                self.lblAddressBussinessDetail.text = arrgetMemberInfo.address![2].street1 ?? ""
                self.lblAddressBussinessType2.text = arrgetMemberInfo.address![2].fullBWAddress ?? ""
                }
                if (arrgetMemberInfo.address?.count)! > 1 {
                self.lblAddressOtherDetail.text = arrgetMemberInfo.address![1].street1 ?? ""
                self.lblAddressOtherType2.text = arrgetMemberInfo.address![1].fullBWAddress ?? ""
                }
                
//                self.lblAddressBussinessType2.text = String(format: "%@ %@ %@,%@ %@" ,arrgetMemberInfo.address![2].street2 ?? "", arrgetMemberInfo.address![2].city ?? "",arrgetMemberInfo.address![2].stateCode ?? "",arrgetMemberInfo.address![2].country ?? "",arrgetMemberInfo.address![2].zip ?? "")
//                if self.lblAddressBussinessType2.text!.contains("  ,"){
//                    let replaced = self.lblAddressBussinessType2.text!.replacingOccurrences(of: ",", with: "")
//
//                    self.lblAddressBussinessType2.text = replaced
//
//
//                }
                
               
                
                
//                self.lblAddressOtherType2.text = String(format: "%@ %@ %@,%@ %@" ,arrgetMemberInfo.address![1].street2 ?? "", arrgetMemberInfo.address![1].city ?? "",arrgetMemberInfo.address![1].stateCode ?? "",arrgetMemberInfo.address![1].country ?? "",arrgetMemberInfo.address![1].zip ?? "")
//                if(self.lblAddressOtherType2.text == "  , "){
//                    self.lblAddressOtherType2.text = ""
//                }
               
                
                
                self.lblMyIntrest.text = self.appDelegate.masterLabeling.my_Interest
                self.lblTargetting.text = self.appDelegate.masterLabeling.targetting_market_option
                self.lblSendStatements.text = self.appDelegate.masterLabeling.send_statements_to_colon
                self.lblSendMagazine.text = self.appDelegate.masterLabeling.send_magazine_to_colon
                self.lblSettings.text = self.appDelegate.masterLabeling.tT_PREFERENCES

                
                self.lblIntresetList.text = arrgetMemberInfo.interest?.joined(separator:", ")
                
                for i in 0 ..< self.dictmemberInfo.targetedMarketOption!.count {
                    let targetedMarketOption = self.dictmemberInfo.targetedMarketOption![i]
                    self.arrSelectedMarketOptions.append(targetedMarketOption)

                    if self.arrSelectedMarketOptions[i].isChecked == 1{
                        self.arrMarketOptions.append(self.arrSelectedMarketOptions[i].groupName!)

                    }
                    
                }
                
                self.lblTargettingON.text = self.arrMarketOptions.joined(separator: ", ")
                
                self.lblDisplayUserName.text = arrgetMemberInfo.displayName ?? ""

               
                self.lblVersion.text = String(format: "Version %@", (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String)!)
                                
                self.lblMemberIDAndName.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + (UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? ""))
                
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
                        //Old logic
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
                
                self.view.layoutIfNeeded()

                self.profileViewHeight.constant = 1790 + self.lblTargettingON.frame.height + self.lblIntresetList.frame.height
                self.uiScrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: self.profileViewHeight.constant)
                
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
    
    
}
