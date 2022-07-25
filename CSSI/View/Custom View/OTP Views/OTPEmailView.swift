//
//  OTPEmailView.swift
//  CSSI
//
//  Created by Kiran on 07/07/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

import UIKit

//Added by kiran V1.3 -- PROD0000019 -- Added 2 step verification
//PROD0000019 -- Start
class OTPEmailView: UIView
{
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var contentCardView: UIView!
    
    @IBOutlet weak var NavBarView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    ///This view is used for reference to aligh the Email content in center below the nav option.
    @IBOutlet weak var emailContentView: UIView!
    ///This view is used to aligh the content at center of emial content view
    @IBOutlet weak var emailContainerView: UIView!
    
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var emailHeaderView: UIView!
    @IBOutlet weak var lblEmailHeader: UILabel!
    @IBOutlet weak var viewEmailHeaderLine: UIView!
    @IBOutlet weak var EmailTxtField: UITextField!
    @IBOutlet weak var viewNote: UIView!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var verificationStatus : ((Bool)->())?
    var closeBtnClicked : (()->())?
    var backBtnClicked : (()->())?
    
    var memberID : String?
    var ID : String?
    var parentID : String?
    
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
   
    @IBAction func closeClicked(_ sender: UIButton)
    {
        self.closeBtnClicked?()
        self.removeFromSuperview()
    }
    
    @IBAction func backClicked(_ sender: UIButton)
    {
        self.backBtnClicked?()
        self.removeFromSuperview()
    }
    
    @IBAction func submitClicked(_ sender: UIButton)
    {
        self.endEditing(true)
        self.generateOTP()
    }
    
}

//MARK:- Custom Functions
extension OTPEmailView
{
    private func setupContentView()
    {
        Bundle.main.loadNibNamed("OTPEmailView", owner: self, options: nil)
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
        
        self.EmailTxtField.layer.borderWidth = 0.5
        self.EmailTxtField.layer.cornerRadius = 5
        self.EmailTxtField.layer.masksToBounds = true
        self.EmailTxtField.keyboardType = .emailAddress
        self.btnSubmit.setStyle(style: .contained, type: .primary)
        
        self.applyColor()
        self.applyFont()
    }

    private func applyColor()
    {
        self.lblEmailHeader.textColor = APPColor.textColor.primary
        self.viewEmailHeaderLine.backgroundColor = APPColor.OtherColors.lineColor
        self.EmailTxtField.textColor = APPColor.textColor.primary
        self.lblNote.textColor = APPColor.textColor.primary
        self.btnBack.imageView?.tintColor = APPColor.ButtonColors.secondary
        self.btnClose.imageView?.tintColor = APPColor.textColor.primary
        self.EmailTxtField.layer.borderColor = APPColor.OtherColors.lineColor.cgColor
        self.EmailTxtField.tintColor = APPColor.MainColours.primary2
        self.lblWelcome.textColor = APPColor.textColor.primary
    }
    
    private func applyFont()
    {
        self.lblEmailHeader.font = AppFonts.regular22
        self.EmailTxtField.font = AppFonts.regular20
        self.lblNote.font = AppFonts.regular14
        self.btnSubmit.titleLabel?.font = AppFonts.semibold22
        self.lblWelcome.font = AppFonts.semibold26
    }
    
    func setupScreendata(_ parentMemberInfo : ParentMemberInfo)
    {
        self.lblEmailHeader.text = parentMemberInfo.enter_WorkEmail ?? ""
        self.EmailTxtField.placeholder = parentMemberInfo.enter_Email ?? ""
        self.lblNote.text = parentMemberInfo.email_Note ?? ""
        self.btnSubmit.setTitle(parentMemberInfo.proceed ?? "", for: .normal)
        self.lblWelcome.text = parentMemberInfo.Welcome ?? ""
    }
    
}

//MARK:- API'S
extension OTPEmailView
{
    
    private func generateOTP()
    {
        let paramaterDict : [String : Any] = [
            APIKeys.kMemberId : self.memberID ?? "",
            APIKeys.kID : self.ID ?? "",
            APIKeys.kParentId : self.parentID ?? "",
            APIKeys.kemailid : self.EmailTxtField.text ?? "",
            APIKeys.kdeviceID : UserDefaults.standard.string(forKey: UserDefaultsKeys.FCMToken.rawValue) ?? "",
            APIKeys.kdeviceInfo : [APIHandler.devicedict]
        ]
        CustomFunctions.shared.showActivityIndicator(withTitle: "", intoView: self.superview!)
        APIHandler.sharedInstance.generateOTP(paramaterDict: paramaterDict) { details in
            
            CustomFunctions.shared.hideActivityIndicator()
            
            if (details?.responseCode ?? "").caseInsensitiveCompare("Success") == .orderedSame
            {
                var OTPView : OTPView? = OTPView.init(frame: self.superview!.bounds)
                OTPView?.memberID = self.memberID
                OTPView?.ID = self.ID
                OTPView?.parentID = self.parentID
                OTPView?.emailID = self.EmailTxtField.text ?? ""
                OTPView?.setupScreendata(details)
                OTPView?.closeBtnClicked = ({ [unowned self] in
                    OTPView?.removeFromSuperview()
                    OTPView = nil
                    self.closeBtnClicked?()
                })

                OTPView?.verificationStatus = ({ [unowned self] status in
                    
                    if status
                    {
//                        OTPView?.removeFromSuperview()
//                        OTPView = nil
                    }
                    self.verificationStatus?(status)
                })
                
                OTPView?.backBtnClicked = ({
                    OTPView?.removeFromSuperview()
                    OTPView = nil
                })

                if let OTPView = OTPView
                {
                    self.superview!.addSubview(OTPView)
                }
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
