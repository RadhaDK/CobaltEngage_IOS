//
//  CancelMembershipRequestPopUpVC.swift
//  CSSI
//
//  Created by Vishal Pandey on 06/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
enum canceltypeRequestBillOrMember{
    case Membership,Billing
}
class CancelMembershipRequestPopUpVC: UIViewController {
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var btnRemovePopUp: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!

    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var typeCancelPoppupfrombillormember : canceltypeRequestBillOrMember?
    var CategoryType : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnYes.layer.cornerRadius = btnYes.bounds.size.height / 2
        btnYes.layer.borderWidth = 1.0
        btnYes.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
        self.btnYes.setStyle(style: .outlined, type: .primary)
        btnNo.layer.cornerRadius = btnNo.bounds.size.height / 2
        btnNo.layer.borderWidth = 1.0
        btnNo.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
        self.btnNo.setStyle(style: .outlined, type: .primary)
        descriptionLbl.text = self.appDelegate.masterLabeling.DUES_RENEWAL_CANCEL_PENDING_REQUEST_MESSAGE ?? ""
        btnYes.setTitle(self.appDelegate.masterLabeling.Yes ?? "", for: .normal)
        btnNo.setTitle(self.appDelegate.masterLabeling.No ?? "", for: .normal)
        
        if typeCancelPoppupfrombillormember == .Membership{
            CategoryType = "MemberShipType"
        }
        else{
            CategoryType = "BillingFrequncy"
        }
    }
    
    
    @IBAction func removePopUpBtnTapped(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func yesBtnTapped(sender:UIButton){
        btnYes.layer.borderColor = UIColor(red: 27/255, green: 202/255, blue: 255/255, alpha: 1).cgColor
        SavemembershipTypeList()
    }
    @IBAction func noBtnTapped(sender:UIButton){
        btnNo.layer.borderColor = UIColor(red: 27/255, green: 202/255, blue: 255/255, alpha: 1).cgColor
        self.dismiss(animated: true, completion: nil)
    }
}

extension CancelMembershipRequestPopUpVC{
    func SavemembershipTypeList(){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            var paramaterDict:[String: Any]?
            paramaterDict = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kIsAdmin: "0",
                APIKeys.kUserID: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kusername: UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                APIKeys.kRole: "Full Access",
                APIKeys.kCategory: CategoryType ?? ""
            ] as [String : Any]
            APIHandler.sharedInstance.saveMembershipListing(paramater: paramaterDict, onSuccess: { membershipSavedData in
                self.appDelegate.hideIndicator()
                if let thankyouMembershipViewController = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ThankYouMemberShipVC") as? ThankYouMemberShipVC{
                    if self.typeCancelPoppupfrombillormember == .Membership{
                        if membershipSavedData.IsMTAutoApproved == 0{
                            thankyouMembershipViewController.thankYouDesc = self.appDelegate.masterLabeling.DUES_RENEWAL_BILLING_FREQUENCY_CANCELLED_MESSAGE ?? ""
                        }
                        else{
                            thankyouMembershipViewController.thankYouDesc = self.appDelegate.masterLabeling.AUTO_APPROVED_MESSAGE ?? ""
                        }
                    }
                    else{
                        if membershipSavedData.IsBFAutoApproved == 0{
                            thankyouMembershipViewController.thankYouDesc = self.appDelegate.masterLabeling.DUES_RENEWAL_BILLING_FREQUENCY_CANCELLED_MESSAGE ?? ""
                        }
                        else{
                            thankyouMembershipViewController.thankYouDesc = self.appDelegate.masterLabeling.AUTO_APPROVED_MESSAGE ?? ""
                        }
                    }
                    self.present(thankyouMembershipViewController, animated: true, completion: nil)
                }
                
            },onFailure: { error  in
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
}
