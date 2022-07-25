//
//  RegisterYourDeviceVC.swift
//  CSSI
//
//  Created by Apple on 29/09/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import FLAnimatedImage
extension UIImageView {
    public func maskCircleImage(anyImage: UIImage) {
        self.contentMode = UIViewContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        self.clipsToBounds = true

        self.image = anyImage
    }
}
class RegisterYourDeviceVC: UIViewController {
    var reg: [RegisterYourDeviceResponse]? = nil

    var ActionType : NSString = NSString()
    @IBOutlet weak var btnRegisterYourDevice: UIButton!
    @IBOutlet weak var imgProfile: FLAnimatedImageView!
    @IBOutlet var middleView: UIView!
    
    @IBOutlet var lblStatusMessage: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblMacAddress: UILabel!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ActionType = "SlideMenu"
        loadRegisterYourDevice()
        self.initController()
        
    }
    
    
    func initController()
    {
        
        iniFont()
        let placeholder:UIImage = UIImage(named: "avtar")!
        self.imgProfile.image = placeholder
        self.setCardView(view: self.middleView)
        self.imgProfile.maskCircleImage(anyImage: placeholder)
        
        self.imgProfile.maskCircleImage(anyImage: placeholder)
        DataRequest.addAcceptableImageContentTypes(["image/jpg"])
        Alamofire.request(UserDefaults.standard.string(forKey: UserDefaultsKeys.userProfilepic.rawValue) ?? "").responseImage { response in
            debugPrint(response)
            if let image = response.result.value {
                self.imgProfile.image = image
                
            }
        }
        self.lblName.text = UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!
        self.lblID.text = self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!
        
        self.lblName.textColor = APPColor.textColor.text
        self.lblID.textColor = APPColor.textColor.text
        self.middleView.backgroundColor = APPColor.viewBgColor.viewbg
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        //setting value for navigation controller
        self.navigationController?.navigationBar.isHidden = false
        //navigation item labelcolor
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
//        self.navigationItem.title = "Register Your Device"
        self.navigationController?.navigationBar.backItem?.title = self.appDelegate.masterLabeling.bACK
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = true
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isTranslucent = false
        
    }
    
    func loadRegisterYourDevice() {
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        let params: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            "UniqueDeviceID" : UIDevice.current.identifierForVendor!.uuidString,
            "ActionType" : ActionType
            
        ]
        
        APIHandler.sharedInstance.registerYourDevice(paramater: params, onSuccess: { (response) in
            
            self.lblMacAddress.text = String(format: "UniqueDeviceID: %@",UIDevice.current.identifierForVendor!.uuidString)
            for registerDeviceInfo in response.registerDeviceInfo {
            
                if (registerDeviceInfo.status == "" || registerDeviceInfo.status == "Register"){
                    self.btnRegisterYourDevice.setTitle("Forgot this device!", for: .normal)
                }
                else{
                    self.btnRegisterYourDevice.setTitle("Register your device!", for: .normal)
                }
                self.lblStatusMessage.text = registerDeviceInfo.statusMessage

            }
            self.appDelegate.hideIndicator()
            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            self.appDelegate.hideIndicator()
            
        }
        
        
    }

@IBAction func registerYourDeviceClicked(_ sender: Any) {
    let buttonTitle = (sender as AnyObject).title(for: .normal)
    if buttonTitle == "Forgot this device!" {
        ActionType = "Forget"

    }
    else{
        ActionType = "Register"
    }
    
    loadRegisterYourDevice()
   
    }
    
    func setCardView(view : UIView){
        
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = 1;
        view.layer.shadowRadius = 2;
        view.layer.shadowOpacity = 0.5;
        
    }
    func iniFont()
    {
        self.lblName.font = SFont.SourceSansPro_Semibold18
        self.lblID.font = SFont.SourceSansPro_Semibold36
        
    }
}

