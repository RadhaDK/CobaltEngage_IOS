//
//  CancelMembershipRequestPopUpVC.swift
//  CSSI
//
//  Created by Vishal Pandey on 06/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class CancelMembershipRequestPopUpVC: UIViewController {
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var btnRemovePopUp: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!

    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        btnNo.layer.cornerRadius = 15
        btnYes.layer.cornerRadius = 15
        btnNo.layer.borderWidth = 1
        btnYes.layer.borderWidth = 1
        btnYes.layer.borderColor = UIColor.darkGray.cgColor
        btnNo.layer.borderColor = UIColor.darkGray.cgColor
     

        // Do any additional setup after loading the view.
    }
    
  
    
    @IBAction func removePopUpBtnTapped(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func yesBtnTapped(sender:UIButton){
        btnYes.layer.borderColor = UIColor(red: 27/255, green: 202/255, blue: 255/255, alpha: 1).cgColor
        SavemembershipTypeList()
        //self.dismiss(animated: true, completion: nil)
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
                APIKeys.kCategory: "MemberShipType"
            ] as [String : Any]
            APIHandler.sharedInstance.saveMembershipListing(paramater: paramaterDict, onSuccess: { membershipSavedData in
                self.appDelegate.hideIndicator()
                
                if membershipSavedData.IsMTAutoApproved == 0{
                    if let thankyouMembershipViewController = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ThankYouMemberShipVC") as? ThankYouMemberShipVC {
                            thankyouMembershipViewController.thankYouDesc = "Your request has been cancelled"
                            self.present(thankyouMembershipViewController, animated: true, completion: nil)
                    }
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
