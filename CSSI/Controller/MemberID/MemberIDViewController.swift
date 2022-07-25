

import UIKit
import Alamofire
import AlamofireImage
import FLAnimatedImage
import PassKit

extension UIImageView {
    public func maskCircle(anyImage: UIImage) {
        self.contentMode = UIViewContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        
        self.image = anyImage
    }
}

class MemberIDViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblmemberName: UILabel!
    @IBOutlet weak var lblmemberID: UILabel!
    
    @IBOutlet weak var imgProfilePic: FLAnimatedImageView!
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var uiView: UIView!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var viewQRBorder: UIView!
    
    
    //Added by kiran V2.9 -- ENGAGE0011722 -- Apple wallet functionality
    //ENGAGE0011722 -- Start
    @IBOutlet var viewAddToWallet: UIView!
    //ENGAGE0011722 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setColorCode()
        self.initController()

    }
    
    
    func initController()
    {
        
        iniFont()
        let placeholder:UIImage = UIImage(named: "avtar")!
        self.imgProfilePic.image = placeholder
        //self.setCardView(view: self.uiView)
        self.imgProfilePic.maskCircle(anyImage: placeholder)
        
        self.viewQRBorder.layer.borderWidth = 0.25
        self.viewQRBorder.layer.borderColor = hexStringToUIColor(hex: "7E7E7E").cgColor
        self.viewQRBorder.layer.cornerRadius = 11
        self.viewQRBorder.clipsToBounds = true
        
        
        
        DataRequest.addAcceptableImageContentTypes(["image/jpg"])
        Alamofire.request(UserDefaults.standard.string(forKey: UserDefaultsKeys.userProfilepic.rawValue) ?? "").responseImage { response in
            debugPrint(response)
            if let image = response.result.value {
                self.imgProfilePic.image = image
            }
        }
//        self.lblmemberName.text = String(format: "%@, %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.lastName.rawValue)!,UserDefaults.standard.string(forKey: UserDefaultsKeys.firstName.rawValue)!)
     //   UserDefaults.memberNameDisplay.rawValue
        self.lblmemberName.text = UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)
        self.lblmemberID.text = self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!
        
        
        //self.lblmemberName.textColor = APPColor.textColor.text
      //  self.lblmemberID.textColor = APPColor.textColor.text
        self.uiView.backgroundColor = APPColor.viewBgColor.viewbg
        
        
        let image = generateQRCode(from: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)
        self.imgQRCode.contentMode = .scaleAspectFit
        imgQRCode.image = image
        self.imgLogo.isHidden = false
//        if(self.view.frame.size.height<580){
//            self.imgLogo.isHidden = true
//        }
        
        //Added by kiran V2.9 -- ENGAGE0011722 -- Apple wallet functionality
        //ENGAGE0011722 -- Start
        let appleWalletBtn = PKAddPassButton.init(addPassButtonStyle: .black)
        appleWalletBtn.translatesAutoresizingMaskIntoConstraints = false
        self.viewAddToWallet.addSubview(appleWalletBtn)
        
        let topConstraint = NSLayoutConstraint.init(item: appleWalletBtn, attribute: .top, relatedBy: .equal, toItem: self.viewAddToWallet, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint.init(item: appleWalletBtn, attribute: .bottom, relatedBy: .equal, toItem: self.viewAddToWallet, attribute: .bottom, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint.init(item: appleWalletBtn, attribute: .left, relatedBy: .equal, toItem: self.viewAddToWallet, attribute: .left, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint.init(item: appleWalletBtn, attribute: .right, relatedBy: .equal, toItem: self.viewAddToWallet, attribute: .right, multiplier: 1, constant: 0)
        
        self.viewAddToWallet.addConstraints([topConstraint,bottomConstraint,leftConstraint,rightConstraint])
        self.viewAddToWallet.clipsToBounds = true
        appleWalletBtn.addTarget(self, action: #selector(self.addToWalletClicked(_:)), for: .touchUpInside)
        //ENGAGE0011722 -- End
        
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    //Commented by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead
    //ENGAGE0011419 -- Start
    //Mark- Verify url exist
//    func verifyUrl(urlString: String?) -> Bool {
//        if let urlString = urlString {
//            if let url = URL(string: urlString) {
//                return UIApplication.shared.canOpenURL(url)
//            }
//        }
//        return false
//    }
    //ENGAGE0011419 -- End
    
    //Mark- generate QRCode
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //setting value for navigation controller
        self.navigationController?.navigationBar.isHidden = false
        //navigation item labelcolor
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = self.appDelegate.masterLabeling.tT_MEMBER_ID
        self.navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#949B9F")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backItem?.title = self.appDelegate.masterLabeling.bACK
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        let backBtn = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        backBtn.image?.withRenderingMode(.alwaysTemplate)
        backBtn.tintColor = APPColor.NavigationControllerColors.memberIDBackBtnColor
        self.navigationItem.leftBarButtonItem = backBtn
        //ENGAGE0011297 -- End

        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        //Modified by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
        //ENGAGE0012667 -- Start
        (self.navigationController as? CustomNavigationController)?.setNavBarColorFor(MemberID: true)
        //ENGAGE0012667 -- End

    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = APPColor.navigationColor.barbackgroundcolor
        self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    //Mark- Common Color Code
    func setColorCode()
    {
        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg
        
    }
    
    //Mark- Set Cardview
    func setCardView(view : UIView){
        
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = 1;
        view.layer.shadowRadius = 2;
        view.layer.shadowOpacity = 0.5;
        
    }
    
    
    func iniFont()
    {
        self.lblmemberName.font = SFont.SourceSansPro_Regular24
        self.lblmemberID.font = SFont.SourceSansPro_Semibold36
    }
    
    //Added by kiran V2.9 -- ENGAGE0011722 -- Apple wallet functionality
    //ENGAGE0011722 -- Start
    @objc private func addToWalletClicked(_ sender: UIButton)
    {
        self.addPassToWallet()
    }
    //ENGAGE0011722 -- End
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//Added by kiran V2.9 -- ENGAGE0011722 -- Apple wallet functionality
//ENGAGE0011722 -- Start
//MARK:- API methods
extension MemberIDViewController
{
    private func getMemberIDPassData(success : @escaping((WalletPassData?)->()),failure : @escaping((Error)->()))
    {
        guard Network.reachability?.isReachable == true else {
            CustomFunctions.shared.showToast(WithMessage: InternetMessge.kInternet_not_available, on: self.view)
            return
        }
        
        CustomFunctions.shared.showActivityIndicator(withTitle: "", intoView: self.view)
        let paramaterDict:[String: Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "" ,
            APIKeys.kdeviceInfo: [APIHandler.devicedict]
        ]
        
        APIHandler.sharedInstance.getWalletPass(paramaterDict: paramaterDict) { passDetails in
            success(passDetails)
            CustomFunctions.shared.hideActivityIndicator()
        } onFailure: { error in
            CustomFunctions.shared.hideActivityIndicator()
            failure(error)
        }

    }
    
}



//MARK:- Custom Functions
extension MemberIDViewController
{
    
    private func addPassToWallet()
    {
        let canAddPass = PassManager.shared.canAddPass()
        
        if canAddPass.value
        {

            self.getMemberIDPassData { passDetails in
                
                if let strPassData = passDetails?.passData , let passData = NSData.init(base64Encoded: strPassData, options: .ignoreUnknownCharacters) as Data?
                {
                    if PassManager.shared.containsPass(data: passData)
                    {
                        
                        PassManager.shared.replacePassWith(pass: passData, alertMessage:  self.appDelegate.masterLabeling.wallet_Replace_Text ?? "", parentView: self) { (status,error) in
                            
                            if status
                            {
                                
                            }
                            else if let error = error
                            {
                                switch error
                                {
                                case .errorGeneratingPass:
                                    CustomFunctions.shared.showToast(WithMessage: self.appDelegate.masterLabeling.wallet_ErrorMessage, on: self.view)
                                case .errorReplacingFile:
                                    CustomFunctions.shared.showToast(WithMessage: self.appDelegate.masterLabeling.wallet_ErrorMessage, on: self.view)
                                case .passDoesntExist:
                                    CustomFunctions.shared.showToast(WithMessage: self.appDelegate.masterLabeling.wallet_ErrorMessage, on: self.view)
                                case .userDenied:
                                    break
                                }
                                
                            }
                            
                        }
                         
                    }
                    else
                    {
                        PassManager.shared.addPass(data: passData, parentView: self) { passError in
                            
                            if passError == .errorGeneratingPass
                            {
                                CustomFunctions.shared.showToast(WithMessage: self.appDelegate.masterLabeling.wallet_ErrorMessage, on: self.view)
                            }
                        }
                    }

                }
                else
                {
                    //This is called because of conversion error or app didnt receive the data string from API.
                    CustomFunctions.shared.showToast(WithMessage: self.appDelegate.masterLabeling.wallet_ErrorMessage, on: self.view)
                }
                
            } failure: { error in
                //Added by kiran V3.0 -- ENGAGE0011722 -- Logs the pass error to firebase
                //ENGAGE0011722 -- Start
                let passError = NSError.init(domain: "PassManager", code: PassErrorCodes.addingError.rawValue, userInfo: [NSLocalizedDescriptionKey : error.localizedDescription])
                CustomFunctions.shared.logError(error: passError)
                //ENGAGE0011722 -- End
                CustomFunctions.shared.showToast(WithMessage: error.localizedDescription, on: self.view)
            }
            
        }
        else
        {
            var message = ""
            
            if canAddPass.error == .libraryNotAvailable
            {
                //Added by kiran V3.0 -- ENGAGE0011722 -- Logs the pass error to firebase
                //ENGAGE0011722 -- Start
                let passError = NSError.init(domain: "PassManager", code: PassErrorCodes.addingError.rawValue, userInfo: [NSLocalizedDescriptionKey : PassErrorMessage.libNotAvailable])
                CustomFunctions.shared.logError(error: passError)
                //ENGAGE0011722 -- End
                message = self.appDelegate.masterLabeling.wallet_LibraryNot ?? ""
            }
            else if canAddPass.error == .deviceCantAdd
            {
                //Added by kiran V3.0 -- ENGAGE0011722 -- Logs the pass error to firebase
                //ENGAGE0011722 -- Start
                let passError = NSError.init(domain: "PassManager", code: PassErrorCodes.addingError.rawValue, userInfo: [NSLocalizedDescriptionKey : PassErrorMessage.deviceNotCapable])
                CustomFunctions.shared.logError(error: passError)
                //ENGAGE0011722 -- End
                message = self.appDelegate.masterLabeling.wallet_Device_Wallet ?? ""
            }
            
            CustomFunctions.shared.showToast(WithMessage: message, on: self.view)
            
        }
        
    }
    
}
//ENGAGE0011722 -- End
