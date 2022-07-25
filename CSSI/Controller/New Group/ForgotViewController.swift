

import UIKit


class ForgotViewController: UIViewController {
    @IBOutlet weak var btnSend: UIButton!
    
    @IBOutlet weak var lblemailmsg: UILabel!
    
    @IBOutlet weak var txfemailaddress: UITextField!
    
    @IBOutlet weak var imgLogo: UIImageView!

    @IBOutlet weak var imgBg: UIImageView!
    
    @IBOutlet weak var lblgotologin: UIButton!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func sendEmail(_ sender: Any) {
 
        forgotPasswordApi()
        
        
    }
    
    //Mark - Forgotpassword Api
    func forgotPasswordApi() -> Void {
        
//        let parameter:[String:Any] = [
//            APIKeys.kemailid: self.txfemailaddress.text ?? "",
//            APIKeys.kdeviceInfo: APIHandler.devicedict
//            
//        ]
//        
//        
//       // print(parameter)
//        
//        if (Network.reachability?.isReachable) == true{
//            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
//            
//            APIHandler.sharedInstance.postForgotPasswordApi(paramaterDict:parameter, onSuccess: { parentMemberinfo in
//                
//               // print(parentMemberinfo.memberID)
//                
//                
//                
//                if(parentMemberinfo.memberID != nil && parentMemberinfo.responseCode == InternetMessge.kSuccess){
//                    
//                    //   print(JSON)
////                    let memberid = parentMemberinfo.memberID
//                  
//                
//                    self.btnSend.isHidden = true
//                    
//                    self.txfemailaddress.isHidden = true
//                    
//                    self.lblemailmsg.text = parentMemberinfo.responseMessage
//                    self.lblemailmsg.font = SFont.SFProText_Regular16
//                    
//                    self.imgLogo.image = UIImage(named: CommonImages.imgfgpwdsuccess)
//    
//                    
//                    
//                    self.appDelegate.hideIndicator()
//                }
//                    
//                    
//                
//                else{
//                    self.appDelegate.hideIndicator()
//                     if(((parentMemberinfo.responseMessage?.count) ?? 0)>0){
//                    SharedUtlity.sharedHelper().showToast(on:
//                        self.view, withMeassge: parentMemberinfo.responseMessage, withDuration: Duration.kMediumDuration)
//                    }
//                }
//                
//                
//             
//                
//            },onFailure: { error, responseCode  in
//                
//               // print()
//                switch(responseCode.statusCode)
//                {
//                case 401:
//                    SharedUtlity.sharedHelper().showToast(on:
//                        self.view, withMeassge: ApiErrorMessages.kUnauthorized, withDuration: Duration.kMediumDuration)
//                    break;
//                case 400:
//                    SharedUtlity.sharedHelper().showToast(on:
//                        self.view, withMeassge: ApiErrorMessages.kInvalidInput, withDuration: Duration.kMediumDuration)
//                    break;
//                case 404:
//                    SharedUtlity.sharedHelper().showToast(on:
//                        self.view, withMeassge: ApiErrorMessages.kResourceNotFound, withDuration: Duration.kMediumDuration)
//                    break;
//                case 408:
//                    SharedUtlity.sharedHelper().showToast(on:
//                        self.view, withMeassge: ApiErrorMessages.kRequestTimeout, withDuration: Duration.kMediumDuration)
//                    break;
//                case 405:
//                    SharedUtlity.sharedHelper().showToast(on:
//                        self.view, withMeassge: ApiErrorMessages.kMethodNotAllowed, withDuration: Duration.kMediumDuration)
//                    break;
//                case 500:
//                    SharedUtlity.sharedHelper().showToast(on:
//                        self.view, withMeassge: ApiErrorMessages.kInternalServerError, withDuration: Duration.kMediumDuration)
//                    break;
//                case 505:
//                    SharedUtlity.sharedHelper().showToast(on:
//                        self.view, withMeassge: ApiErrorMessages.kHttpversionnotsupported, withDuration: Duration.kMediumDuration)
//                    break;
//                default:
//                    SharedUtlity.sharedHelper().showToast(on:
//                        self.view, withMeassge: ApiErrorMessages.kInternalServerError, withDuration: Duration.kMediumDuration)
//                    
//                    
//                }
//                
//                
//                self.appDelegate.hideIndicator()
//                print(error)
//                
//            })
//        }else{
//            
//            SharedUtlity.sharedHelper().showToast(on:
//                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
//        }
        
        
        
    }
    
    
    
    //Mark- Common Color Code
    func setColorCode()
    {
     
         self.lblemailmsg.textColor = APPColor.viewBgColor.viewbg
         self.lblgotologin.titleLabel?.textColor = APPColor.tintColor.tint
         self.btnSend.titleLabel?.textColor = APPColor.viewBgColor.viewbg
         self.btnSend.backgroundColor = APPColor.tintColor.tint
        
    }
    
    //Mark- Common String
   func commonString()
    {
        self.lblemailmsg.text = CommonString.kenteremailmessage
        self.btnSend.titleLabel?.text = CommonString.ksend
        self.lblgotologin.setTitle(CommonString.kgotologin, for: .normal)
        self.imgBg.image = UIImage(named: CommonImages.fg_bg)
        self.imgLogo.image = UIImage(named: CommonImages.login_applogo)
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.commonString()
        self.setColorCode()
        self.initController()

        
    }
    
    func initController()
    {
        self.navigationController?.navigationBar.isHidden = true
        
        btnSend.layer.cornerRadius = 20
        
        txfemailaddress.addBorderBottom(height: 1.0, color: APPColor.tintColor.tint )
        
        
        txfemailaddress.attributedPlaceholder = NSAttributedString(string: CommonString.kemail,
                                                                   attributes: [NSAttributedStringKey.foregroundColor: APPColor.tintColor.tint ])
        
        let iconWidth = 15;
        let iconHeight = 15;
        let imageViewuse = UIImageView(image: UIImage(named:CommonImages.textfieldEmail)!.withRenderingMode(UIImageRenderingMode.alwaysTemplate))
        // var imageusername = UIImage(named: "img_email.png");
        // imageViewuse.image = imageusername
        imageViewuse.tintColor = APPColor.tintColor.tint
        
        // set frame on image before adding it to the uitextfield
        imageViewuse.frame = CGRect(x:10, y: iconHeight, width: iconWidth, height: iconHeight)
        
        txfemailaddress.leftViewMode = UITextFieldViewMode.always
        txfemailaddress.addSubview(imageViewuse)
        txfemailaddress.setLeftPaddingPoints(35)
        self.navigationController?.navigationBar.isHidden = false
        
        
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        //navigation item labelcolor
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = CommonString.kforgotPassword
        let backButton = UIBarButtonItem()
        backButton.title =  CommonString.kNavigationBack
        self.navigationController?.navigationBar.topItem?.title =  CommonString.kNavigationBack
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initFontForViews()
    {
        self.btnSend.titleLabel?.font = SFont.SourceSansPro_Semibold18
        self.txfemailaddress.font = SFont.SourceSansPro_Regular16
        self.lblemailmsg.font = SFont.SourceSansPro_Regular14
        self.lblgotologin.titleLabel?.font = SFont.SourceSansPro_Regular14

        
    }
 
}
