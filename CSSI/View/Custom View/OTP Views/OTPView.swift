//
//  OTPView.swift
//  CSSI
//
//  Created by Kiran on 07/07/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

import UIKit

//Added by kiran V1.3 -- PROD0000019 -- Added 2 step verification
//PROD0000019 -- Start
class OTPView: UIView
{
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var contentCardView: UIView!
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var OTPHolderView: UIView!
    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var lblVerificationHeader: UILabel!
    @IBOutlet weak var verificationHeaderLine: UIView!
    
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var OTPFields: OTPStack!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var verifyBtnView: UIView!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var resendBtnView: UIView!
    @IBOutlet weak var btnResend: UIButton!
    
    var verificationStatus : ((Bool)->())?
    var closeBtnClicked : (()->())?
    var backBtnClicked : (()->())?
    
    var memberID : String?
    var ID : String?
    var parentID : String?
    var emailID : String?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setupContentView()
    }
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        self.setupContentView()
    }
    
    @IBAction func backClicked(_ sender: UIButton)
    {
        self.backBtnClicked?()
        self.removeFromSuperview()
    }
    
    @IBAction func cancelClicked(_ sender: UIButton)
    {
        self.closeBtnClicked?()
        self.removeFromSuperview()
    }
    
    @IBAction func verifiedClicked(_ sender: UIButton)
    {
        self.validateOTP()
    }
    
    @IBAction func resendClicked(_ sender: UIButton)
    {
        self.generateOTP()
    }

}

//MARK:- Custom Functions
extension OTPView
{
    private func setupContentView()
    {
        Bundle.main.loadNibNamed("OTPView", owner: self, options: nil)
        self.contentView.frame = self.bounds
        self.addSubview(self.contentView)
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let topLayout = NSLayoutConstraint.init(item: self.contentView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        let rightLayout = NSLayoutConstraint.init(item: self.contentView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        let bottomLayout = NSLayoutConstraint.init(item: self.contentView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        let leftLayout = NSLayoutConstraint.init(item: self.contentView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([topLayout,rightLayout,bottomLayout,leftLayout])
        self.layoutIfNeeded()
        
        self.initialSetup()
    }
    
    private func initialSetup()
    {
        let imageClose = UIImage.init(named: "ic_cross")?.withRenderingMode(.alwaysTemplate)
        self.btnClose.setImage(imageClose, for: .normal)
        
        let imageBack = UIImage.init(named: "back_btn")?.withRenderingMode(.alwaysTemplate)
        self.btnBack.setImage(imageBack, for: .normal)
        
        self.contentCardView.layer.cornerRadius = 10
        self.contentCardView.clipsToBounds = true
        
        self.btnVerify.setStyle(style: .outlined, type: .primary)
        self.btnResend.setStyle(style: .outlined, type: .primary)
        
        self.configureOTPView()
        self.applyColor()
        self.applyFont()
    }
    
    private func configureOTPView()
    {
        self.OTPFields.fieldsCount = 4
        self.OTPFields.fieldSpacing = 13
        self.OTPFields.fieldBorderHeight = 1
        self.OTPFields.fieldFont = AppFonts.regular20
        self.OTPFields.fieldTextColor = APPColor.textColor.primary
        self.OTPFields.fieldBorderColor = APPColor.OtherColors.lineColor
        self.OTPFields.fieldTextTintColor = APPColor.MainColours.primary2
        self.OTPFields.fieldBackgroundColor = .clear
        self.OTPFields.updateUI()
    }
    
    private func applyColor()
    {
        self.lblVerificationHeader.textColor = APPColor.textColor.primary
        self.lblEmailAddress.textColor = APPColor.textColor.primary
        self.lblDuration.textColor = APPColor.textColor.primary
        self.btnBack.imageView?.tintColor = APPColor.ButtonColors.secondary
        self.btnClose.imageView?.tintColor = APPColor.textColor.primary
        
        self.verificationHeaderLine.backgroundColor = APPColor.OtherColors.lineColor
    }
    
    private func applyFont()
    {
        self.lblVerificationHeader.font = AppFonts.regular22
        self.lblEmailAddress.font = AppFonts.semibold18
        self.lblDuration.font = AppFonts.regular14
        self.btnVerify.titleLabel?.font = AppFonts.semibold22
        self.btnResend.titleLabel?.font = AppFonts.semibold22
    }
    
    func setupScreendata(_ generateOTP : GenerateOTP?)
    {
        self.lblVerificationHeader.text = generateOTP?.account_Verification ?? ""
        self.lblEmailAddress.text = generateOTP?.codeSent_Email ?? ""
        self.lblDuration.text = generateOTP?.OTPExpire_INFO ?? ""
        self.btnVerify.setTitle(generateOTP?.verify ?? "", for: .normal)
        self.btnResend.setTitle(generateOTP?.resend_OTP ?? "", for: .normal)
    }
    
}

//MARK:- API'S
extension OTPView
{
    private func generateOTP()
    {
        let paramaterDict : [String : Any] = [
            APIKeys.kMemberId : self.memberID ?? "",
            APIKeys.kID : self.ID ?? "",
            APIKeys.kParentId : self.parentID ?? "",
            APIKeys.kemailid : self.emailID ?? "",
            APIKeys.kdeviceID : UserDefaults.standard.string(forKey: UserDefaultsKeys.FCMToken.rawValue) ?? "",
            APIKeys.kdeviceInfo : [APIHandler.devicedict]
        ]
        CustomFunctions.shared.showActivityIndicator(withTitle: "", intoView: self.superview!)
        APIHandler.sharedInstance.generateOTP(paramaterDict: paramaterDict) { details in
            
            CustomFunctions.shared.hideActivityIndicator()
            CustomFunctions.shared.showToast(WithMessage: details?.responseMessage, on: self.superview!)
            
        } onFailure: { error in
            CustomFunctions.shared.hideActivityIndicator()
            CustomFunctions.shared.showToast(WithMessage: error.localizedDescription, on: self.superview!)
        }
        
    }
    
    private func validateOTP()
    {
        let paramaterDict : [String : Any] = [
            APIKeys.kMemberId : self.memberID ?? "",
            APIKeys.kID : self.ID ?? "",
            APIKeys.kParentId : self.parentID ?? "",
            APIKeys.kOTP : self.OTPFields.getOTP(),
            APIKeys.kdeviceInfo : [APIHandler.devicedict]
        ]

        CustomFunctions.shared.showActivityIndicator(withTitle: "", intoView: self.superview!)
        APIHandler.sharedInstance.validateLoginOTP(paramaterDict: paramaterDict) { details in
            
            CustomFunctions.shared.hideActivityIndicator()
            
            if (details?.responseCode ?? "").caseInsensitiveCompare("Success") == .orderedSame
            {
                self.verificationStatus?(true)
            }
            else
            {
                if let message = details?.responseMessage, message.count > 0
                {
                    CustomFunctions.shared.showToast(WithMessage: message, on: self.superview!)
                }
                
            }
            
        } onFailure: { error in
            CustomFunctions.shared.hideActivityIndicator()
            CustomFunctions.shared.showToast(WithMessage: error.localizedDescription, on: self.superview!)
        }

    }
    
}
//PROD0000019 -- End
