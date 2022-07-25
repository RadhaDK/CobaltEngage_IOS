//  ForgotVC.swift
//  CSSI
//  Created by apple on 11/29/18.
//  Copyright © 2018 yujdesigns. All rights reserved.

import UIKit

class ForgotVC: UIViewController {

    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var lblEnterEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblPleaseCheckEmail: UILabel!
    @IBOutlet weak var lblPaddwordRule4: UILabel!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var lblNewPassword: UILabel!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var lblConfirmPassword: UILabel!
    @IBOutlet weak var lblPasswordBeingCreated: UILabel!
    @IBOutlet weak var lblPasswordConditions: UILabel!
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var lblForgotEmailText: UILabel!
    @IBOutlet weak var btnresendSecurityCode: UIButton!
    @IBOutlet weak var lblPassPolicyRule: UILabel!
    @IBOutlet weak var btnConfirmPass: UIButton!
    @IBOutlet weak var btnNewPass: UIButton!
    
    //Added on 26th June 2020 V2.2
    @IBOutlet weak var viewResentButton: UIView!
    @IBOutlet weak var viewEnterEmail: UIView!
    
    
    var Email : NSString!
    var resendString : NSString!
    
    //Added on 24th June 2020 v2.2
    private var shouldSendLinkInEmail = false
    
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.lblPleaseCheckEmail.isHidden = true
        //Modified on 26th June 2020 V2.2
        self.viewResentButton.isHidden = true
        //self.btnresendSecurityCode.isHidden = true
        self.lblPleaseCheckEmail.text = self.appDelegate.masterLabeling.please_chek_your_email ?? "Please check your email for a message with your 6-digit security code."
        self.lblEnterEmail.text = self.appDelegate.masterLabeling.enter_your_email ?? "Enter your username*"
        self.lblNewPassword.text = self.appDelegate.masterLabeling.new_password ?? "New Password*"
        self.lblConfirmPassword.text = self.appDelegate.masterLabeling.confirm_password ?? "Confirm Password*"
        
        let cellPhoneLabel: NSMutableAttributedString = NSMutableAttributedString(string: self.lblEnterEmail.text!)
        cellPhoneLabel.setColor(color: UIColor.red, forText: "*")   // or use direct value for text "red"
        self.lblEnterEmail.attributedText = cellPhoneLabel
        
        let newPasswordLabel: NSMutableAttributedString = NSMutableAttributedString(string: self.lblNewPassword.text!)
        newPasswordLabel.setColor(color: UIColor.red, forText: "*")   // or use direct value for text "red"
        self.lblNewPassword.attributedText = newPasswordLabel
        
        let confirmPasswordLabel: NSMutableAttributedString = NSMutableAttributedString(string: self.lblConfirmPassword.text!)
        confirmPasswordLabel.setColor(color: UIColor.red, forText: "*")   // or use direct value for text "red"
        self.lblConfirmPassword.attributedText = confirmPasswordLabel

        self.btnSend.layer.borderWidth = 1
        self.btnSend.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
        
        self.btnOK.layer.borderWidth = 1
        self.btnOK.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
        
        self.btnresendSecurityCode.layer.borderWidth = 1
        self.btnresendSecurityCode.layer.borderColor = hexStringToUIColor(hex: "007AFF").cgColor

        txtNewPassword.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        txtConfirmPassword.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

        //Added by kiran V2.8 -- ENGAGE0011688 -- Updated the email id kkohlhepp@bocawestcc.org to communications@bocawestcc.org.
        //ENGAGE0011688 -- Start
        self.lblForgotEmailText.text = self.appDelegate.masterLabeling.if_you_donot_remember_your_email ?? "If you do not remember which username you registered with our system, please contact info@mycobaltsoftware.com."
        //ENGAGE0011688 -- End
        self.btnOK.setTitle(self.appDelegate.masterLabeling.OK ?? "OK", for: UIControlState.normal)
        self.btnSend.setTitle(self.appDelegate.masterLabeling.sEND ?? "Send", for: UIControlState.normal)
        self.btnresendSecurityCode.setTitle(self.appDelegate.masterLabeling.resend_security_code ?? "Resend Security Code", for: UIControlState.normal)
        
        self.lblPassPolicyRule.text = self.appDelegate.masterLabeling.passwordRuls1 ?? "Must be a minimum length of seven (7) characters."

        self.btnSend.setStyle(style: .outlined, type: .primary)
        self.btnOK.setStyle(style: .outlined, type: .primary)
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
//    func passwordValidation(testStr:String) -> Bool {
//        print("validate emilId: \(testStr)")
//        let emailRegEx = "^(?=.*[a-z])(?=.*\\d)(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{7,}"
//
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        let result = emailTest.evaluate(with: testStr)
//        return result
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func closeClicked(_ sender: Any) {
        
        //Added on 25th JUly 2020 V2.2
        //Note:- Dont remove this.if removed will cause force logout issue on login screen.
        UserDefaults.standard.set("", forKey: UserDefaultsKeys.userID.rawValue)
        
        if lblEnterEmail.text == self.appDelegate.masterLabeling.enter_your_email ?? "Enter your username*"{
            self.dismiss(animated: true, completion: nil)

        }else if self.lblPassword.text == "Create New Password" {
            self.dismiss(animated: true, completion: nil)

        }
        else{
        
        let alertController = UIAlertController(title: "", message: self.appDelegate.masterLabeling.yOUWILL_NEED_THIS_POPUP ?? "You will need this popup to enter your security code. Are you sure, you still want to close it?" , preferredStyle: .alert)
        
        // Create the actions
        let yesAction = UIAlertAction(title: self.appDelegate.masterLabeling.Yes ?? "Yes", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.dismiss(animated: true, completion: nil)
            
        }
        let noAction = UIAlertAction(title: self.appDelegate.masterLabeling.No ?? "No", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            
        }
        // Add the actions
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        //
        }
    }
    
    @IBAction func sendClicked(_ sender: Any) {
        
        //MOdified on 24th June 2020 V2.2
        if self.shouldSendLinkInEmail
        {
            self.dismiss(animated: true, completion: nil)
        }
        else
        {
            if lblEnterEmail.text == self.appDelegate.masterLabeling.enter_your_email ?? "Enter your username*"{
                self.ForgotPassword()
            }
            else
            {
                self.validateOTP()
            }
        }
        
    }
    
    func ForgotPassword() {
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        let params: [String : Any] = [
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            "EmailID" : txtEmail.text ?? ""
            
        ]
        
        APIHandler.sharedInstance.postForgotPasswordApi(paramaterDict: params, onSuccess: { (response) in
            self.Email = self.txtEmail.text as NSString?
            if response.responseCode == "Success"
            {
                //Modified on 24th June 2020 V2.2
                self.shouldSendLinkInEmail = response.sendLinkInEmail == 0
                self.showEmailView(bool: self.shouldSendLinkInEmail)
                
                if self.shouldSendLinkInEmail
                {
                    let message = response.sendLinkInEmailText?.replacingOccurrences(of: "{rp}", with: " \n")
                    self.lblPleaseCheckEmail.text = message
                }
                
                if self.shouldSendLinkInEmail
                {
                    self.lblPleaseCheckEmail.isHidden = false
                    self.btnSend.setTitle("OK", for: .normal)
                }
                else
                {
                    
                    self.txtEmail.text = ""
                    SharedUtlity.sharedHelper().showToast(on: self.view, withMeassge: response.responseMessage, withDuration: Duration.kShortDuration)
                    if self.lblEnterEmail.text == self.appDelegate.masterLabeling.enter_your_security_code ?? "Enter your Security code*" && self.resendString == "" {
                      //  self.lblPassword.text = "    New Password?"
                        self.emailView.isHidden = true
                        self.passwordView.isHidden = false
                        
                        
                        
                    }
                    else{
                        
                        self.lblPleaseCheckEmail.isHidden = false
                        self.lblEnterEmail.text = self.appDelegate.masterLabeling.enter_your_security_code ?? "Enter your Security code*"

                        let cellPhoneLabel: NSMutableAttributedString = NSMutableAttributedString(string: self.lblEnterEmail.text!)
                        cellPhoneLabel.setColor(color: UIColor.red, forText: "*")   // or use direct value for text "red"
                        self.lblEnterEmail.attributedText = cellPhoneLabel
                        
                        //Modified on 26th June 2020 V2.2
                        self.viewResentButton.isHidden = false
                        //self.btnresendSecurityCode.isHidden = false
                        self.btnSend .setTitle("OK", for: .normal)
                        self.lblForgotEmailText.isHidden = true

                    }
                }
                
            }
            else
            {
                SharedUtlity.sharedHelper().showToast(on: self.view, withMeassge: response.responseMessage, withDuration: Duration.kShortDuration)

            }
            self.appDelegate.hideIndicator()
            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            
        }
    }
    
    func validateOTP() {
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        let params: [String : Any] = [
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            "EmailID": self.Email,
            "OTP": txtEmail.text ?? ""
        ]
        
        APIHandler.sharedInstance.validateOTPApi(paramaterDict: params, onSuccess: { (response) in
            
            if response.responseCode == "Success"{
                
                let userName = response.userName
                let userID = response.ID
                let memberID = response.memberID
                let parentID = response.parentID

                //Modified on 25th July 2020 V2.2
                UserDefaults.standard.set(memberID, forKey: UserDefaultsKeys.userID.rawValue)
                //UserDefaults.standard.set(userID, forKey: UserDefaultsKeys.userID.rawValue)
                UserDefaults.standard.set(userName, forKey: UserDefaultsKeys.username.rawValue)
                UserDefaults.standard.set(memberID, forKey: UserDefaultsKeys.memberID.rawValue)
                UserDefaults.standard.set(parentID, forKey: UserDefaultsKeys.parentID.rawValue)
                
                //added on 25th July 2020 V2.2
                 UserDefaults.standard.set(userID, forKey: UserDefaultsKeys.id.rawValue)
                
                if self.lblEnterEmail.text == self.appDelegate.masterLabeling.enter_your_security_code ?? "Enter your Security code*" {
                    self.lblPassword.text = self.appDelegate.masterLabeling.enter_new_password ?? "Create New Password"
                    self.emailView.isHidden = true
                    self.passwordView.isHidden = false
                    
                }
                else{
                    
                    self.lblPleaseCheckEmail.isHidden = false
                    self.lblEnterEmail.text = self.appDelegate.masterLabeling.enter_your_security_code ?? "Enter your Security code*"
                    
                    let cellPhoneLabel: NSMutableAttributedString = NSMutableAttributedString(string: self.lblEnterEmail.text!)
                    cellPhoneLabel.setColor(color: UIColor.red, forText: "*")   // or use direct value for text "red"
                    self.lblEnterEmail.attributedText = cellPhoneLabel
                    
                }
//               self.getAuthToken()
            }
            else{
                SharedUtlity.sharedHelper().showToast(on: self.view, withMeassge: response.responseMessage, withDuration: Duration.kShortDuration)
                
            }
            self.appDelegate.hideIndicator()
            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            
        }
    }
    
    //MARK:- Token API called
//    func getAuthToken(){
//
//        if (Network.reachability?.isReachable) == true{
//            APIHandler.sharedInstance.getTokenApi(paramater: nil , onSuccess: { tokenList in
//                let access_token = tokenList.access_token
//                let expires_in = tokenList.expires_in
//                let token_type = tokenList.token_type
//                let jointToken = (token_type ?? "") + " " + (access_token ?? "")
//
//
//                UserDefaults.standard.set(access_token, forKey: UserDefaultsKeys.access_token.rawValue)
//                UserDefaults.standard.set(expires_in, forKey: UserDefaultsKeys.expires_in.rawValue)
//                UserDefaults.standard.set(token_type, forKey: UserDefaultsKeys.token_type.rawValue)
//                UserDefaults.standard.set(jointToken, forKey: UserDefaultsKeys.apiauthtoken.rawValue)
//                UserDefaults.standard.synchronize()
//                print(UserDefaults.standard.string(forKey: UserDefaultsKeys.apiauthtoken.rawValue) ?? "")
//
//
//            },onFailure: { error  in
//
//                print(error)
//                SharedUtlity.sharedHelper().showToast(on:
//                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
//            })
//        }
//    }
//
    
    func resetPassword() {
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        let params: [String : Any] = [
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            //Modified on 25th July 2020 V2.2
            APIKeys.kID:  UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? ""/*UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? ""*/,
            APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.memberID.rawValue) ?? "",
            APIKeys.kusername: UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue) ?? "",
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            "Password": txtNewPassword.text ?? "",
            "ConfirmPassword":  txtConfirmPassword.text ?? ""
        ]
        
        APIHandler.sharedInstance.resetPasswordApi(paramaterDict: params, onSuccess: { (response) in
            
            //Added on 25th JUly 2020 V2.2
            //Note:- Dont remove this.if removed will cause force logout issue on login screen.
            UserDefaults.standard.set("", forKey: UserDefaultsKeys.userID.rawValue)
            
            if response.responseCode == "Success"{
                UserDefaults.standard.set("true", forKey: UserDefaultsKeys.changePassword.rawValue)

                SharedUtlity.sharedHelper().showToast(on:
                    self.passwordView, withMeassge: response.responseMessage, withDuration: Duration.kMediumDuration)
                let delay = 2 // seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
                    
                    self.dismiss(animated: true, completion: nil)

                }
               

            }
            
            
            self.appDelegate.hideIndicator()
            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            
        }
    }
    @IBAction func okClicked(_ sender: Any) {
        
        
//        if (self.txtNewPassword.text?.count)!<=0 {
//            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: "New password must not be empty", withDuration: Duration.kMediumDuration)
//        }
//        else if (self.txtConfirmPassword.text?.count)!<=0 {
//            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: "confirm password must not be empty", withDuration: Duration.kMediumDuration)
//        }
//        else if (self.txtNewPassword.text != txtConfirmPassword.text) {
//            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: "New Password is not matching with the confirm password", withDuration: Duration.kMediumDuration)
//        }
//        else{
//
//         //   if passwordValidation(testStr: txtNewPassword.text!){
                self.resetPassword()

////            }
////            else{
////                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: "Please provide valid New Password", withDuration: Duration.kMediumDuration)
////            }
//        }

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
    @IBAction func confirmPassClicked(_ sender: Any) {
        let btn : UIButton = sender as! UIButton
        
        if btn.tag == 0{
            btn.tag = 1
            self.txtConfirmPassword.isSecureTextEntry = false
            self.btnConfirmPass.setImage(UIImage(named: "Password not visible_Create New Password"), for: UIControlState.normal)
        }
        else{
            btn.tag = 0
            self.txtConfirmPassword.isSecureTextEntry = true
            self.btnConfirmPass.setImage(UIImage(named: "Password not visible-Create New Password"), for: UIControlState.normal)
        }
    }
    
    @IBAction func resendClicked(_ sender: Any) {
        
        resendString = (sender as AnyObject).title(for: .normal)! as NSString
        self.txtEmail.text = self.Email! as String
        self.ForgotPassword()

    }
    
}

//MARK:- Custon Methods
extension ForgotVC
{
    //Modified on 24th June 2020 V2.2
    private func showEmailView(bool : Bool)
    {
        self.viewResentButton.isHidden = bool
        self.txtEmail.isHidden = bool
        self.lblForgotEmailText.isHidden = bool
        self.viewEnterEmail.isHidden = bool
        self.lblPleaseCheckEmail.text = bool ? "" : (self.appDelegate.masterLabeling.please_chek_your_email ?? "Please check your email for a message with your 6-digit security code.")
       
    }
}
