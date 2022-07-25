

import UIKit
import Alamofire
import AlamofireImage
import Contacts
import AddressBook
import MessageUI
import ContactsUI
import FLAnimatedImage


class MemberDirectoryDetailsViewController: UIViewController,MFMailComposeViewControllerDelegate,CNContactViewControllerDelegate{
    

    var contactStore = CNContactStore()
    
    var memberInfo =  GetMemberInfo()
    
    @IBOutlet weak var lblHtmlText: UILabel!
    @IBOutlet weak var heightAddress: NSLayoutConstraint!
    @IBOutlet weak var lblMemberID: UILabel!
    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var lblRelativeMember: UILabel!
    //    @IBOutlet weak var imgMemberProfilePic: UIImageView!
    @IBOutlet weak var viewRelatives: UIView!
    @IBOutlet weak var lblRelatedMembers: UILabel!
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var heightRelativesView: NSLayoutConstraint!
    @IBOutlet weak var lblAdd: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblEdit: UILabel!
    @IBOutlet weak var lblMyBuddyList: UILabel!
    @IBOutlet weak var viewAdd: UIView!
    @IBOutlet weak var viewEdit: UIView!
    @IBOutlet weak var imgMemberProfilePic: FLAnimatedImageView!
    
    
   
    @IBOutlet weak var btnAddToPhone: UIButton!
    
    
    
    @IBOutlet weak var scrollMember: UIScrollView!
    
    
    @IBOutlet weak var lblMemberHomePhNo: UILabel!
    
    @IBOutlet weak var lblMemberHomePhNoValue: UILabel!
    
    @IBOutlet weak var lblMemberCellPhNo: UILabel!
    
    @IBOutlet weak var lblMemberCellPhNoValue: UILabel!
    
    @IBOutlet weak var lblMemberOther: UILabel!
    
    @IBOutlet weak var lblMemberOtherValue: UILabel!
    
    @IBOutlet weak var lblPrimaryEmail: UILabel!
    
    @IBOutlet weak var lblPrimaryEmailValue: UILabel!
    
    @IBOutlet weak var lblSecEmail: UILabel!
    
    @IBOutlet weak var lblSecEmailValue: UILabel!
    
    @IBOutlet weak var uiView: UIView!
    
    
    @IBOutlet weak var btnRightHomeImgCall: UIButton!
    @IBOutlet weak var btnRightCellImgMessage: UIButton!
    @IBOutlet weak var btnRightotherImgMessage: UIButton!
    @IBOutlet weak var btnRightPrEmailImgMessage: UIButton!
    @IBOutlet weak var btnRightScEmailImgMessage: UIButton!
    
    
    
    var memberFirstName = String()
    var memberLastName = String()
    var memberEmail = String()
    var memberphone = String()
    var membersec = String()
    var memberother = String()
    var memberprofile = String()
    var memberSecEmail = String()
    
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrinterest = [IndividualMemberInterest]()
    var selectedMemberId = String()
    var iD = String()
    var parentId = String()
    var linkedMemberID : String?
    var arrselectedEmails = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commonString()
        self.setColorCode()
        
        
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
        
        
        let relatives = UITapGestureRecognizer(target: self, action:  #selector(self.relativesClicked(sender:)))
        self.viewRelatives.addGestureRecognizer(relatives)
        
        let addBuddy = UITapGestureRecognizer(target: self, action:  #selector(self.addBuddyClicked(sender:)))
        self.viewAdd.addGestureRecognizer(addBuddy)
        
        let removeBuddy = UITapGestureRecognizer(target: self, action:  #selector(self.removeBuddyClicked(sender:)))
        self.viewEdit.addGestureRecognizer(removeBuddy)
        
        self.lblEdit.text = self.appDelegate.masterLabeling.rEMOVE
        self.btnAdd.setTitle(self.appDelegate.masterLabeling.aDD, for: UIControlState.normal)
        
        self.lblRelatedMembers.text = self.appDelegate.masterLabeling.rELATED_MEMBERS_COLON
        
        let profileClickGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.profilePicClicked(sender:)))
        self.imgMemberProfilePic.addGestureRecognizer(profileClickGesture)
        
       // self.view.bringSubview(toFront: self.imgMemberProfilePic)
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }

    
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    @objc func relativesClicked(sender : UITapGestureRecognizer) {
        scrollMember.setContentOffset(.zero, animated: true)

        if self.memberInfo.relatedMember?.linkedMemberName == nil {
            
        }else{
        
        self.selectedMemberId = self.memberInfo.relatedMember?.memberID ?? ""
        self.iD = self.memberInfo.relatedMember?.id ?? ""
        self.parentId = self.memberInfo.relatedMember?.parentID ?? ""
        
        self.commonString()
        self.setColorCode()
        initFontForViews()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.mainViewHeight.constant = self.lblHtmlText.frame.height + 800
    }
    
    @objc func addBuddyClicked(sender : UITapGestureRecognizer) {
        
        if let profile = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "AddBuddyViewController") as? AddBuddyViewController {
            profile.modalTransitionStyle   = .crossDissolve;
            profile.modalPresentationStyle = .overCurrentContext
            profile.linkedMemberID = self.linkedMemberID
            profile.memberID = self.selectedMemberId
            profile.iD = self.iD
            profile.parentId = self.parentId
            profile.buttonType = "Add"
            self.present(profile, animated: true, completion: nil)
        }
        
    }
    
    @objc func removeBuddyClicked(sender : UITapGestureRecognizer) {
        if let profile = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "AddBuddyViewController") as? AddBuddyViewController {
            profile.modalTransitionStyle   = .crossDissolve;
            profile.modalPresentationStyle = .overCurrentContext
            profile.linkedMemberID = self.linkedMemberID
            profile.memberID = self.selectedMemberId
            profile.iD = self.iD
            profile.parentId = self.parentId
            profile.buttonType = "Delete"
            self.present(profile, animated: true, completion: nil)
        }
        
        
    }
    
    ///Profile pic click action
    @objc func profilePicClicked(sender : UITapGestureRecognizer)
    {
       
        if let profileImageView = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ViewNewsViewController") as? ViewNewsViewController {
            profileImageView.modalTransitionStyle   = .crossDissolve;
            profileImageView.modalPresentationStyle = .overCurrentContext
            
            profileImageView.isFrom = "MemberDirectoryDetails"
            profileImageView.padding = 16
            profileImageView.enableZooming = false
            if (self.imgMemberProfilePic.image?.size.width ?? 0 >= (self.view.frame.width * 0.92)) || (self.imgMemberProfilePic.image?.size.height ?? 0 >= (self.view.frame.height * 0.71))
            {
                profileImageView.imageContentMode = .scaleAspectFit
               
            }
            else
            {
                 profileImageView.imageContentMode = .center
            }
            
    
            profileImageView.shouldClearBackgroundImgColor = false
            //Added on 14th May 2020 v2.1
            let mediaDetails = MediaDetails()
            mediaDetails.type = .image
            mediaDetails.newsImage = self.memberInfo.profilePic ?? ""
            
            profileImageView.arrMediaDetails = [mediaDetails]
            //Old logic
            //profileImageView.arrImgURl = [[ "NewsImage" :  self.memberInfo.profilePic ?? ""]]
            
            //Added on 19th May 2020 v2.1
            profileImageView.contentType = .image
            self.present(profileImageView, animated: true, completion: nil)
        }
        
    }
    
    func initFontForViews()
    {
        self.lblMemberCellPhNo.font = SFont.SourceSansPro_Regular16
        self.lblMemberCellPhNoValue.font = SFont.SourceSansPro_Semibold17
        
        self.lblMemberHomePhNo.font = SFont.SourceSansPro_Regular16
        self.lblMemberHomePhNoValue.font = SFont.SourceSansPro_Semibold17
        
        self.lblMemberHomePhNo.font = SFont.SourceSansPro_Regular16
        self.lblMemberHomePhNoValue.font = SFont.SourceSansPro_Semibold17
        
        self.lblMemberOther.font = SFont.SourceSansPro_Regular16
        self.lblMemberOtherValue.font = SFont.SourceSansPro_Semibold17
        
        self.lblPrimaryEmail.font = SFont.SourceSansPro_Regular16
        self.lblPrimaryEmailValue.font = SFont.SourceSansPro_Semibold17
        
        self.lblSecEmail.font = SFont.SourceSansPro_Regular16
        self.lblSecEmailValue.font = SFont.SourceSansPro_Semibold17
        
        self.lblMemberName.font = SFont.SourceSansPro_Semibold18
        
        self.btnAddToPhone.setTitleColor(APPColor.loginBackgroundButtonColor.loginBtnBGColor, for: .normal)
        self.btnAddToPhone.backgroundColor = APPColor.viewBgColor.viewbg
        self.btnAddToPhone.layer.borderColor = APPColor.loginBackgroundButtonColor.loginBtnBGColor.cgColor
        self.btnAddToPhone.layer.borderWidth = 1
        
        self.btnAddToPhone.layer.cornerRadius = 20
        self.btnAddToPhone.layer.masksToBounds = true
        self.btnAddToPhone.setStyle(style: .outlined, type: .primary)
        
        
        self.btnAddToPhone.addTarget(self, action: #selector(btnCreateContact), for: .touchUpInside)
        
        self.btnRightHomeImgCall.accessibilityHint = lblMemberHomePhNoValue.text
        self.btnRightHomeImgCall.addTarget(self, action: #selector(btnCallButtonTapped(phonnumber:)), for: .touchUpInside)
        
        self.btnRightPrEmailImgMessage.accessibilityHint = lblPrimaryEmailValue.text
        self.btnRightPrEmailImgMessage.addTarget(self, action: #selector(btnEmailButtonTapped(email:)), for: .touchUpInside)
        
        self.btnRightCellImgMessage.accessibilityHint = lblMemberCellPhNoValue.text
        self.btnRightCellImgMessage.addTarget(self, action: #selector(btnCallButtonTapped(phonnumber:)), for: .touchUpInside)
        
        
        self.btnRightotherImgMessage.accessibilityHint = lblMemberOtherValue.text
        self.btnRightotherImgMessage.addTarget(self, action: #selector(btnCallButtonTapped(phonnumber:)), for: .touchUpInside)
        
        self.btnRightScEmailImgMessage.accessibilityHint = lblSecEmailValue.text
        self.btnRightScEmailImgMessage.addTarget(self, action: #selector(btnEmailButtonTapped(email:)), for: .touchUpInside)
        
        
        
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.getMemberDirectoryDetails()
        
    }
    
    //Mark- Common Color Code
    func setColorCode()
    {
        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg
        self.uiView.backgroundColor = APPColor.viewBgColor.viewbg
        self.scrollMember.backgroundColor = APPColor.viewBackgroundColor.viewbg
        
        self.lblMemberName.textColor = APPColor.textColor.textNewColor
        self.lblMemberHomePhNo.textColor = APPColor.textColor.textNewColor
        self.lblMemberHomePhNoValue.textColor = APPColor.textColor.textNewColor
        self.lblMemberCellPhNo.textColor = APPColor.textColor.textNewColor
        self.lblMemberCellPhNoValue.textColor = APPColor.textColor.textNewColor
        self.lblMemberOther.textColor = APPColor.textColor.textNewColor
        self.lblMemberOtherValue.textColor = APPColor.textColor.textNewColor
        
        self.lblPrimaryEmail.textColor = APPColor.textColor.textNewColor
        self.lblPrimaryEmailValue.textColor = APPColor.textColor.textNewColor
        
        self.lblSecEmail.textColor = APPColor.textColor.textNewColor
        self.lblSecEmailValue.textColor = APPColor.textColor.textNewColor
        
     
        if (UserDefaults.standard.string(forKey: UserDefaultsKeys.addToContact.rawValue) == "0"){
            self.btnAddToPhone.isHidden = true
            
        }
        else{
            self.btnAddToPhone.isHidden = false
        }
    }
    func commonString()
    {
        self.btnAddToPhone.titleLabel?.text = self.appDelegate.masterLabeling.aDD_TO_PHONE
        //        self.btnAddToBuddyList.titleLabel?.text = self.appDelegate.masterLabeling.aDD_TO_BUDDY_LIST
        self.lblMemberHomePhNo.text = self.appDelegate.masterLabeling.hOME_PHONE
        self.lblMemberCellPhNo.text = self.appDelegate.masterLabeling.cELL_PHONE
        self.lblMemberOther.text = self.appDelegate.masterLabeling.other_phone
        self.lblPrimaryEmail.text = self.appDelegate.masterLabeling.pRIMARY_EMAIL
        self.lblSecEmail.text = self.appDelegate.masterLabeling.sECONDARY_EMAIL
   
    }
    
    
  
    //Mark - Get Member Info Api
    func getMemberDirectoryDetails() -> Void {
        
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            
            let dict:[String: Any] = [
                APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kParentId: self.parentId ,
                APIKeys.kid: self.iD,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "From" : "MB",
                "AddressKey": "MB"
            ]
            
            APIHandler.sharedInstance.getMemberInfoApi(paramater: dict, onSuccess: { arrgetMemberInfo in
                
               
                
                if(arrgetMemberInfo.responseCode == InternetMessge.kSuccess){
                    if(arrgetMemberInfo == nil){
                        self.appDelegate.hideIndicator()
                        
                    }
                    else{
                        
                        self.memberInfo = arrgetMemberInfo
                        self.lblMemberName.text = arrgetMemberInfo.memberName ?? ""
                        
                        self.btnRightHomeImgCall.accessibilityHint = arrgetMemberInfo.primaryPhone ?? ""
                        self.btnRightCellImgMessage.accessibilityHint = arrgetMemberInfo.secondaryPhone ?? ""
                        self.btnRightotherImgMessage.accessibilityHint = arrgetMemberInfo.alternatePhone ?? ""
                        
                        self.btnRightPrEmailImgMessage.accessibilityHint = arrgetMemberInfo.primaryEmail ?? ""
                        
                        self.btnRightScEmailImgMessage.accessibilityHint = arrgetMemberInfo.secondaryEmail ?? ""
                        
                        self.btnRightPrEmailImgMessage.accessibilityHint = arrgetMemberInfo.primaryEmail ?? ""
                        self.btnRightScEmailImgMessage.accessibilityHint = arrgetMemberInfo.secondaryEmail ?? ""
                        
                        
                        self.memberFirstName = arrgetMemberInfo.firstName ?? ""
                        self.memberLastName = arrgetMemberInfo.lastName ?? ""
                        self.memberphone = arrgetMemberInfo.primaryPhone ?? ""
                        self.memberEmail = arrgetMemberInfo.primaryEmail ?? ""
                        self.memberSecEmail = arrgetMemberInfo.secondaryEmail ?? ""
                        
                        self.lblHtmlText.attributedText = arrgetMemberInfo.addressText?.html2AttributedString
                        self.lblHtmlText.backgroundColor = hexStringToUIColor(hex: arrgetMemberInfo.addressBackgroundColor ?? "FFFFFF")
                        
                        self.lblRelativeMember.text = String(format: "%@ %@", arrgetMemberInfo.relatedMember?.linkedMemberNumber ?? "", arrgetMemberInfo.relatedMember?.linkedMemberName ?? "")
                        self.linkedMemberID = arrgetMemberInfo.id ?? ""
                        
                        self.lblMemberID.text = String(format: "#%@", arrgetMemberInfo.memberMasterID ?? "") 
                        
                        self.selectedMemberId = arrgetMemberInfo.memberMasterID ?? ""
                        self.iD = arrgetMemberInfo.id ?? ""
                        self.parentId = arrgetMemberInfo.parentId ?? ""
                        self.memberprofile = arrgetMemberInfo.profilePic ?? ""
                        
                        
                        if (arrgetMemberInfo.showPrimaryEmail == 1) || (arrgetMemberInfo.showLogin == 1)
                        {
                            self.memberEmail = arrgetMemberInfo.primaryEmail ?? ""
                            self.lblPrimaryEmailValue.text = arrgetMemberInfo.primaryEmail ?? ""
                            self.btnRightPrEmailImgMessage.isHidden = false
                            self.lblPrimaryEmailValue.isHidden = false

                            
                        }else{
                            self.lblPrimaryEmailValue.textColor = APPColor.profileColor.dividercolor
                            self.lblPrimaryEmailValue.text = self.appDelegate.masterLabeling.hIDDEN
                            self.memberEmail = ""
                            self.lblPrimaryEmailValue.font = UIFont.italicSystemFont(ofSize: 16)
                            self.lblPrimaryEmailValue.isHidden = true
                            self.btnRightPrEmailImgMessage.isHidden = true
                            
                        }
                        
                        if(arrgetMemberInfo.showSecondaryEmail == 1) || (arrgetMemberInfo.showLogin == 1)
                        {
                            self.memberSecEmail = arrgetMemberInfo.secondaryEmail ?? ""
                            self.lblSecEmailValue.text = arrgetMemberInfo.secondaryEmail ?? ""
                            self.btnRightScEmailImgMessage.isHidden = false
                            self.lblSecEmailValue.isHidden = false

                            
                        }else{
                            self.lblSecEmailValue.textColor = APPColor.profileColor.dividercolor
                            self.lblSecEmailValue.text = self.appDelegate.masterLabeling.hIDDEN
                            self.memberSecEmail = ""
                            self.lblSecEmailValue.font = UIFont.italicSystemFont(ofSize: 16)
                            self.lblSecEmailValue.isHidden = true
                            self.btnRightScEmailImgMessage.isHidden = true
                            
                        }
                        if(arrgetMemberInfo.showprimaryPhone == 1) || (arrgetMemberInfo.showLogin == 1)
                        {
                            
                            self.memberphone = arrgetMemberInfo.primaryPhone ?? ""
                            self.lblMemberHomePhNoValue.text = arrgetMemberInfo.primaryPhone ?? ""
                            self.btnRightHomeImgCall.isHidden = false
                            self.lblMemberHomePhNoValue.isHidden = false

                            
                        }else{
                            self.lblMemberHomePhNoValue.textColor = APPColor.profileColor.dividercolor
                            self.lblMemberHomePhNoValue.text = self.appDelegate.masterLabeling.hIDDEN
                            self.memberphone = ""
                            self.lblMemberHomePhNoValue.font = UIFont.italicSystemFont(ofSize: 16)
                            self.lblMemberHomePhNoValue.isHidden = true
                            self.btnRightHomeImgCall.isHidden = true
                            
                            
                        }
                        if(arrgetMemberInfo.showSecondaryPhone == 1) || (arrgetMemberInfo.showLogin == 1)
                        {
                            self.membersec = arrgetMemberInfo.secondaryPhone ?? ""
                            self.lblMemberCellPhNoValue.text = arrgetMemberInfo.secondaryPhone ?? ""
                            self.btnRightCellImgMessage.isHidden = false
                            self.lblMemberCellPhNoValue.isHidden = false

                        }else{
                            self.lblMemberCellPhNoValue.textColor = APPColor.profileColor.dividercolor
                            self.lblMemberCellPhNoValue.text = self.appDelegate.masterLabeling.hIDDEN
                            self.lblMemberCellPhNoValue.font = UIFont.italicSystemFont(ofSize: 16)
                            self.lblMemberCellPhNoValue.isHidden = true
                            self.btnRightCellImgMessage.isHidden = true
                            
                            self.membersec = ""
                        }
                        
                        
                        if(arrgetMemberInfo.showAlternatePhone == 1) || (arrgetMemberInfo.showLogin == 1)
                        {
                            self.memberother = arrgetMemberInfo.alternatePhone!
                            self.lblMemberOtherValue.text = arrgetMemberInfo.alternatePhone!
                            self.btnRightotherImgMessage.isHidden = false
                            self.lblMemberOtherValue.isHidden = false

                            
                        }else{
                            self.lblMemberOtherValue.textColor = APPColor.profileColor.dividercolor
                            self.lblMemberOtherValue.text = self.appDelegate.masterLabeling.hIDDEN
                            self.lblMemberOtherValue.font = UIFont.italicSystemFont(ofSize: 16)
                             self.lblMemberOtherValue.isHidden = true
                        
                            self.btnRightotherImgMessage.isHidden = true
                            
                            self.memberother = ""
                        }
                       
                     
                        let placeholder:UIImage = UIImage(named: "avtar")!
                        self.imgMemberProfilePic.image = placeholder
                        //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
                        //ENGAGE0011419 -- Start
                        let imageURLString = arrgetMemberInfo.profilePic ?? ""
                        
                        if imageURLString.isValidURL()
                        {
                            DispatchQueue.global(qos: .background).async {
                                
                                do{
                                    let data = try Data.init(contentsOf: URL.init(string:imageURLString)!)
                                    DispatchQueue.main.async {
                                        let image = UIImage(data: data as Data)
                                        self.imgMemberProfilePic.image = image
                                    }
                                }
                                catch {}
                            }

                        }
                        /*
                        if(imageURLString.count>0){
                            let validUrl = self.verifyUrl(urlString: imageURLString)
                            if(validUrl == true){
                            
                            DispatchQueue.global(qos: .background).async {
                                do
                                {
                                    let data = try Data.init(contentsOf: URL.init(string:imageURLString)!)
                                    DispatchQueue.main.async {
                                        let image = UIImage(data: data as Data)
                                        self.imgMemberProfilePic.image = image
                                    }
                                }
                                catch {
                                }
                            }
                                
                            }
                        }
                        */
                        //ENGAGE0011419 -- End
                        
                        //Enable/DIsable profile pic tap
                        if arrgetMemberInfo.profilePic == nil || arrgetMemberInfo.profilePic == ""
                        {
                            self.imgMemberProfilePic.isUserInteractionEnabled = false
                        }
                        else
                        {
                            self.imgMemberProfilePic.isUserInteractionEnabled = true
                        }
                        
                        let delay = 1 // seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
                            self.view.setNeedsLayout()
                            self.appDelegate.hideIndicator()
                        }
                        
                        self.imgMemberProfilePic.layer.cornerRadius = self.imgMemberProfilePic.frame.size.width / 2
                        self.imgMemberProfilePic.layer.masksToBounds = true
                    }
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((arrgetMemberInfo.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: arrgetMemberInfo.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                }
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
    //MARK:- Call button tapped
    @objc func btnCallButtonTapped(phonnumber: UIButton) {
        
        //        let strPhoneNumber = phonnumber.accessibilityHint
        
        let strPhoneNumber = phonnumber.accessibilityHint ?? ""
        if(strPhoneNumber == "")
        {
            
        }else{
            if let phoneCallURL:URL = URL(string: "tel:\(strPhoneNumber)") {
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.openURL(phoneCallURL)
                }
            }
        }
        
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
    
    //MARK:- Email button tapped
    @objc func btnEmailButtonTapped(email: UIButton) {
        
        let stremail = email.accessibilityHint
        if(stremail == "")
        {
            
        }else{
            self.arrselectedEmails.removeAll()
            self.arrselectedEmails.append(stremail!)
            
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        }
     
    }
    
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(arrselectedEmails)
        mailComposerVC.setSubject("")
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backItem?.title = self.appDelegate.masterLabeling.bACK
        self.navigationController?.navigationBar.topItem?.title = self.appDelegate.masterLabeling.bACK
//        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = true
        
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = self.appDelegate.masterLabeling.tT_MEMBER_DIRECTORY
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
        
        initFontForViews()
    }
    
    
    
    func requestForAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        switch authorizationStatus {
        case .authorized:
            completionHandler(true)
            
        case .denied, .notDetermined:
            
            self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
                if access {
                    completionHandler(access)
                }
                else {
                    if authorizationStatus == CNAuthorizationStatus.denied {
                     
                    }
                }
            })
            
        default:
            completionHandler(false)
        }
    }
    

    
    func requestForAccess32(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        switch authorizationStatus {
        case .authorized:
            completionHandler(true)
            
        case .denied, .notDetermined:
            self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
                if access {
                    completionHandler(access)
                }
                else {
                    if authorizationStatus == CNAuthorizationStatus.denied {
                        //                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        //                            let message = "\(accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
                        //                            self.showMessage(message: message)
                        //                        })
                    }
                }
            })
            
        default:
            completionHandler(false)
        }
    }
    
    func showMessage(message: String) {
        let alert = UIAlertController(title: nil, message: "This app requires access to Contacts to proceed. Would you like to open settings and grant permission to contacts?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { action in
            //            completionHandler(false)
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { action in
            //            completionHandler(false)
        })
        present(alert, animated: true)
    }
    
    lazy var contacts: [CNContact] = {
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey,
            CNContactImageDataAvailableKey,
            CNContactThumbnailImageDataKey,] as [Any]
        
        // Get all the containers
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }
        
        var results: [CNContact] = []
        
        // Iterate all containers and append their contacts to our results array
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                //                results.appendContentsOf(containerResults)
            } catch {
                print("Error fetching results for container")
            }
        }
        
        return results
    }()
    
    
    
    
    func searchForContactUsingPhoneNumber(phoneNumber: String) -> String {
        
        var result: [CNContact] = []
        var stringData = String()
        
        for contact in self.contacts {
            if (!contact.phoneNumbers.isEmpty) {
                let phoneNumberToCompareAgainst =  phoneNumber.digits //phoneNumber.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).joinWithSeparator("")
                for phoneNumber in contact.phoneNumbers {
                    if let phoneNumberStruct = phoneNumber.value as? CNPhoneNumber {
                        let phoneNumberString = phoneNumberStruct.stringValue
                        let phoneNumberToCompare = phoneNumberString.digits //phoneNumberString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).joinWithSeparator("")
                        if phoneNumberToCompare == phoneNumberToCompareAgainst {
                            //                            result.append(contact)
                            stringData =  phoneNumberString.digits
                        }
                    }
                }
            }
        }
        
        return stringData
    }
    
    
    @IBAction func btnCreateContact(_ sender: UIButton) {
        
        if memberphone == "" && memberother == "" && membersec == "" && memberEmail == "" && memberSecEmail == "" {
             SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: self.appDelegate.masterLabeling.nO_CONTACT_DETAILS_TOADD, withDuration: Duration.kMediumDuration)
        }else{

            // Added by Zeeshan 04262022 Multiple contacts edit issue
            let matchedName = getContacts(predicate: CNContact.predicateForContacts(matchingName: "\(self.memberFirstName) \(self.memberLastName)"))
            let matchedPhoneNumber = getContacts(predicate: CNContact.predicateForContacts(matching: CNPhoneNumber(stringValue: self.memberphone)))
            let matchedSecondNumber = getContacts(predicate: CNContact.predicateForContacts(matching: CNPhoneNumber(stringValue: self.membersec)))
            let matchedOtherNumber = getContacts(predicate: CNContact.predicateForContacts(matching: CNPhoneNumber(stringValue: self.memberother)))
            var availableNumbersCount = 0
            if self.memberphone != "" {
                availableNumbersCount += 1
            }
            if self.membersec != "" {
                availableNumbersCount += 1
            }
            if self.memberother != "" {
                availableNumbersCount += 1
            }
            if availableNumbersCount > 1 {
                var availableContactCount = 0
                var contactToMatch = CNContact()
                if matchedPhoneNumber != nil {
                    availableContactCount += 1
                    contactToMatch = matchedPhoneNumber!
                }
                if matchedSecondNumber != nil {
                    availableContactCount += 1
                    contactToMatch = matchedSecondNumber!
                }
                if matchedOtherNumber != nil {
                    availableContactCount += 1
                    contactToMatch = matchedOtherNumber!
                }
                
                if availableNumbersCount == availableContactCount {
                    self.contactAlreadyExist(matchedContact: contactToMatch)
                } else if availableContactCount == 0 {
                    self.createNewContact()
                } else {
                    self.nameAlreadyExist(matchedName: contactToMatch, message: "\(self.appDelegate.masterLabeling.cONTACT_NUMBER_ALREADY_EXISTS ?? "") \"\(contactToMatch.givenName) \(contactToMatch.familyName)\"")
                }
            } else if matchedPhoneNumber != nil {
                contactAlreadyExist(matchedContact: matchedPhoneNumber!)
            } else if matchedSecondNumber != nil {
                contactAlreadyExist(matchedContact: matchedSecondNumber!)
            } else if matchedOtherNumber != nil {
                contactAlreadyExist(matchedContact: matchedOtherNumber!)
            } else if matchedName != nil {
                if self.memberFirstName == matchedName?.givenName && self.memberLastName == matchedName?.familyName {
                    nameAlreadyExist(matchedName: matchedName!, message: "\"\(matchedName!.givenName) \(matchedName!.familyName)\" \(self.appDelegate.masterLabeling.cONTACT_NAME_ALREADY_EXISTS ?? "")")
                } else {
                    createNewContact()
                }
            } else {
                createNewContact()
            }
        }
    }
        
// Commented by Zeeshan May 11 2022
        
//        if lblMemberCellPhNoValue.text == "" && lblPrimaryEmailValue.text == "" && lblMemberHomePhNoValue.text == "" && lblMemberOtherValue.text == "" && lblPrimaryEmailValue.text == ""{
//             SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: self.appDelegate.masterLabeling.nO_CONTACT_DETAILS_TOADD, withDuration: Duration.kMediumDuration)
//        }else{
//
//        let store = CNContactStore()
//
//        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey] as [Any]
//        let request = CNContactFetchRequest(keysToFetch: keysToFetch as! [CNKeyDescriptor])
//        var cnContacts = [CNContact]()
//
//        do {
//            try store.enumerateContacts(with: request){
//                (contact, cursor) -> Void in
//                cnContacts.append(contact)
//            }
//        } catch let error {
//            NSLog("Fetch contact error: \(error)")
//        }
//
//        NSLog(">>>> Contact list:")
//
//        var isFind = false
//        var isAlreadyExist = false
//
//        for contact in cnContacts {
//
//
//            for number: CNLabeledValue in contact.phoneNumbers {
//                if let phone = number.value as? CNPhoneNumber {
//
//                    let number = phone.stringValue
//                    let replacedStringData = number.replacingOccurrences(of: "-", with: "", options: .literal, range: nil)
//                    print(replacedStringData)
//
//                    let replacedStringOriganl = self.memberphone.replacingOccurrences(of: "-", with: "", options: .literal, range: nil)
//                    let replacedStringOriganl1 = self.memberother.replacingOccurrences(of: "-", with: "", options: .literal, range: nil)
//                    let replacedStringOriganl2 = self.membersec.replacingOccurrences(of: "-", with: "", options: .literal, range: nil)
//
//                    if(replacedStringData == replacedStringOriganl) || (replacedStringData == replacedStringOriganl1) || (replacedStringData == replacedStringOriganl2){
//                        print("replacedStringOriganl:\(replacedStringOriganl)")
//                        if replacedStringData == "" {
//
//                        }else{
//                        isAlreadyExist = true
//                        isFind = true
//                        break;
//
//                        }
//                    }
//
//
//                } else {
//                    print("number.value not of type CNPhoneNumber")
//                }
//
//                if(isFind == true){
//                    break;
//                }
//
//            }
//            if (isAlreadyExist == true){
//              //  isAlreadyExist = false
//                let con = contact.mutableCopy() as! CNMutableContact
//                if con.phoneNumbers[0].value.stringValue == memberphone && con.phoneNumbers[1].value.stringValue == membersec && con.phoneNumbers[2].value.stringValue == memberother{
//                    SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: self.appDelegate.masterLabeling.cONACT_ALREADY_ADDED, withDuration: Duration.kMediumDuration)
//                }else{
//                con.givenName = memberFirstName
//                con.familyName = memberLastName
//
//                let homePhone = CNLabeledValue(label: CNLabelHome,value: CNPhoneNumber(stringValue: memberphone))
//                let workPhone = CNLabeledValue(label: CNLabelWork, value: CNPhoneNumber(stringValue: membersec))
//                let otherphone = CNLabeledValue(label: CNLabelOther, value: CNPhoneNumber(stringValue: memberother))
//
//                con.phoneNumbers = [homePhone, workPhone,otherphone]
//
//                do {
//                    let contact = try store.unifiedContact(withIdentifier: contact.identifier, keysToFetch:keysToFetch as! [CNKeyDescriptor])
//                    let contactToUpdate = contact.mutableCopy() as! CNMutableContact
//
//                    contactToUpdate.phoneNumbers = [homePhone, workPhone,otherphone]
//
//
//                    let saveRequest = CNSaveRequest()
//                    saveRequest.update(contactToUpdate)
//                    try store.execute(saveRequest)
//                    print("----------------- Contact changed ----------------")
//                    SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: self.appDelegate.masterLabeling.cONTACT_ADDED, withDuration: Duration.kMediumDuration)
//
////                    break;
//
//                } catch let error{
//                    print(error)}
//                }
//
//            }
//
//        }
//
//
//        if(isFind == false){
//            let con = CNMutableContact()
//            con.givenName = memberFirstName
//            con.familyName = memberLastName
//
//            let homePhone = CNLabeledValue(label: CNLabelHome,value: CNPhoneNumber(stringValue: memberphone))
//            let workPhone = CNLabeledValue(label: CNLabelWork, value: CNPhoneNumber(stringValue: membersec))
//            let otherphone = CNLabeledValue(label: CNLabelOther, value: CNPhoneNumber(stringValue: memberother))
//            let email = CNLabeledValue(label:CNLabelHome, value: memberEmail as NSString)
//            let emailWork = CNLabeledValue(label:CNLabelWork, value: memberSecEmail as NSString)
//
//
//
//            con.phoneNumbers = [homePhone, workPhone,otherphone]
//            con.emailAddresses = [email, emailWork]
//
//            do {
//                let newContactRequest = CNSaveRequest()
//                newContactRequest.add(con, toContainerWithIdentifier: nil)
//
//                try CNContactStore().execute(newContactRequest)
//                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: self.appDelegate.masterLabeling.cONTACT_ADDED, withDuration: Duration.kMediumDuration)
//
//            } catch {
//                print("error")
//            }
//        }else if (isAlreadyExist == true){
//
//        }
//        else{
////            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: self.appDelegate.masterLabeling.cONACT_ALREADY_ADDED, withDuration: Duration.kMediumDuration)
//        }


//        }

//    }
    
 
    
    @objc func dismissContactdialog()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Added by Zeeshan 04262022 Multiple contacts edit issue
    func contactAlreadyExist(matchedContact: CNContact) {
        
        if self.memberFirstName == matchedContact.givenName && self.memberLastName == matchedContact.familyName {
            
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: self.appDelegate.masterLabeling.cONACT_ALREADY_ADDED, withDuration: Duration.kMediumDuration)
        
        } else {
            
            let refreshAlert = UIAlertController(title: "\(self.appDelegate.masterLabeling.cONTACT_NUMBER_ALREADY_EXISTS ?? "") \"\(matchedContact.givenName) \(matchedContact.familyName)\"", message: self.appDelegate.masterLabeling.cONTACT_NUMBER_ALREADY_EXISTS_UPDATE, preferredStyle: UIAlertControllerStyle.alert)

            refreshAlert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action: UIAlertAction!) in
                self.createNewContact()
            }))

            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                  print("---- Handle Cancel Logic here ----")
            }))

            present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    // Added by Zeeshan 04262022 Multiple contacts edit issue
    func nameAlreadyExist(matchedName: CNContact, message: String) {
        
        let refreshAlert = UIAlertController(title: message, message: self.appDelegate.masterLabeling.cONTACT_NAME_ALREADY_EXISTS_UPDATE, preferredStyle: UIAlertControllerStyle.alert)

        refreshAlert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (action: UIAlertAction!) in
            self.updateContact(contact: matchedName)
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              print("---- Handle Cancel Logic here ----")
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
    // Added by Zeeshan 04262022 Multiple contacts edit issue
    func updateContact(contact: CNContact) {
        
        do {
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey] as [Any]
            let contact = try CNContactStore().unifiedContact(withIdentifier: contact.identifier, keysToFetch:keysToFetch as! [CNKeyDescriptor])
            let contactToUpdate = contact.mutableCopy() as! CNMutableContact
            
            if !checkNumber(number: memberphone, phoneNumbers: contactToUpdate.phoneNumbers) {
                contactToUpdate.phoneNumbers.append(CNLabeledValue(label: CNLabelHome,value: CNPhoneNumber(stringValue: memberphone)))
            }
            if !checkNumber(number: membersec, phoneNumbers: contactToUpdate.phoneNumbers) {
                contactToUpdate.phoneNumbers.append(CNLabeledValue(label: CNLabelWork,value: CNPhoneNumber(stringValue: membersec)))
            }
            if !checkNumber(number: memberother, phoneNumbers: contactToUpdate.phoneNumbers) {
                contactToUpdate.phoneNumbers.append(CNLabeledValue(label: CNLabelOther,value: CNPhoneNumber(stringValue: memberother)))
            }
            let saveRequest = CNSaveRequest()
            saveRequest.update(contactToUpdate)
            try CNContactStore().execute(saveRequest)
            print("----------------- Contact Updated ----------------")
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: self.appDelegate.masterLabeling.cONTACT_UPDATE_SUCCESS, withDuration: Duration.kMediumDuration)

        } catch let error{
            print(error)
        }
    }
    
    // Added by Zeeshan 04262022 Multiple contacts edit issue
    func createNewContact() {
        
        let homePhone = CNLabeledValue(label: CNLabelHome,value: CNPhoneNumber(stringValue: memberphone))
        let workPhone = CNLabeledValue(label: CNLabelWork, value: CNPhoneNumber(stringValue: membersec))
        let otherphone = CNLabeledValue(label: CNLabelOther, value: CNPhoneNumber(stringValue: memberother))
        let email = CNLabeledValue(label:CNLabelHome, value: memberEmail as NSString)
        let emailWork = CNLabeledValue(label:CNLabelWork, value: memberSecEmail as NSString)

        let con = CNMutableContact()
        con.givenName = memberFirstName
        con.familyName = memberLastName
        con.phoneNumbers = [homePhone, workPhone,otherphone]
        con.emailAddresses = [email, emailWork]

        do {
            let newContactRequest = CNSaveRequest()
            newContactRequest.add(con, toContainerWithIdentifier: nil)

            try CNContactStore().execute(newContactRequest)
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: self.appDelegate.masterLabeling.cONTACT_ADDED, withDuration: Duration.kMediumDuration)

        } catch {
            print("error")
        }
    }
    
    // Added by Zeeshan 04262022 Multiple contacts edit issue
    func checkLabel(label: String, numbers: [CNLabeledValue<CNPhoneNumber>]) -> Int? {
        if numbers.count > 0 {
            for n in 0...numbers.count-1 {
                if numbers[n].label == label {
                    return n
                }
            }
        }
        return nil
    }
    
    // Added by Zeeshan 04262022 Multiple contacts edit issue
    func checkNumber(number: String, phoneNumbers: [CNLabeledValue<CNPhoneNumber>]) -> Bool {
        if phoneNumbers.count > 0 {
            for n in phoneNumbers {
                let numberString = n.value.stringValue
                let phoneNumberToCompare = numberString.digits
                if phoneNumberToCompare == number.digits {
                    return true
                }
            }
        }
        return false
    }
    
    // Added by Zeeshan 04262022 Multiple contacts edit issue
    func getContacts(predicate: NSPredicate) -> CNContact? {
        
        let store = CNContactStore()
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keysToFetch as! [CNKeyDescriptor])
        request.predicate = predicate
        var cnContacts: CNContact?

        do {
            try store.enumerateContacts(with: request){
                (contact, cursor) -> Void in
                cnContacts = contact
            }
        } catch let error {
            NSLog("Fetch contact error: \(error)")
        }
        
        return cnContacts
    }
    
    //MARK: CNContactViewControllerDelegate methods
    // Dismisses the new-person view controller.
    func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
        //
        self.dismiss(animated: true, completion: nil)
    }
    
    func contactViewController(_ viewController: CNContactViewController, shouldPerformDefaultActionFor property: CNContactProperty) -> Bool {
        return true
    }
    
    @objc func createCNContactWithFirstName(firstName: String, lastName: String, email: String?, phone: String?) {
        // create contact with mandatory values: first and last name
        // print("creating contact")
        
        
        
        let con = CNMutableContact()
        con.givenName = memberFirstName
        con.familyName = memberLastName
        
        for ContctNumVar: CNLabeledValue in con.phoneNumbers
        {
            let MobNumVar  = (ContctNumVar.value as! CNPhoneNumber).value(forKey: CNLabelHome)
            print(MobNumVar!)
        }
        
        let homePhone = CNLabeledValue(label: CNLabelHome,value: CNPhoneNumber(stringValue: memberphone))
        let workPhone = CNLabeledValue(label: CNLabelWork, value: CNPhoneNumber(stringValue: membersec))
        let otherphone = CNLabeledValue(label: CNLabelOther, value: CNPhoneNumber(stringValue: memberother))
        let email = CNLabeledValue(label:CNLabelHome, value: memberEmail as NSString)
        let emailWork = CNLabeledValue(label:CNLabelWork, value: memberSecEmail as NSString)

        con.phoneNumbers = [homePhone, workPhone,otherphone]
        con.emailAddresses = [email, emailWork]
        
        
        for ContctNumVar: CNLabeledValue in con.phoneNumbers
        {
            let MobNumVar  = (ContctNumVar.value as! CNPhoneNumber).value(forKey: "digits") as? String
            print(MobNumVar!)
        }
  
        do {
            let newContactRequest = CNSaveRequest()
            newContactRequest.add(con, toContainerWithIdentifier: nil)
            try CNContactStore().execute(newContactRequest)
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: "Contact Stored Successfully", withDuration: Duration.kMediumDuration)
            //  self.presentingViewController?.dismiss(animated: true, completion: nil)
        } catch {
            print("error")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension String {
    var withoutSpecialCharacters: String {
        return self.components(separatedBy: CharacterSet.symbols).joined(separator: "")
    }
    
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
}



