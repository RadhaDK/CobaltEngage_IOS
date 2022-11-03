//
//  CancelDinningReservationPopupVC.swift
//  CSSI
//
//  Created by Aks on 03/11/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class CancelDinningReservationPopupVC: UIViewController {
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var btnRemovePopUp: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var eventID : String?

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
        btnYes.setTitle(self.appDelegate.masterLabeling.Yes ?? "", for: .normal)
        btnNo.setTitle(self.appDelegate.masterLabeling.No ?? "", for: .normal)
    }
    

    @IBAction func removePopUpBtnTapped(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func yesBtnTapped(sender:UIButton){
        btnYes.layer.borderColor = UIColor(red: 27/255, green: 202/255, blue: 255/255, alpha: 1).cgColor
        cancelReservationRequest()
    }
    @IBAction func noBtnTapped(sender:UIButton){
        btnNo.layer.borderColor = UIColor(red: 27/255, green: 202/255, blue: 255/255, alpha: 1).cgColor
        self.dismiss(animated: true, completion: nil)
    }

}
extension CancelDinningReservationPopupVC{
    func cancelReservationRequest(){
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                "ReservationRequestId": eventID ?? "",
                "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!,
            ]
            print(paramaterDict)
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.getRequestCancel(paramater: paramaterDict , onSuccess: { response in
                self.appDelegate.hideIndicator()
                if(response.responseCode == InternetMessge.kSuccess){
                    self.appDelegate.hideIndicator()

                    if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView {
                        self.appDelegate.hideIndicator()
                       // succesView.delegate = self
                        //succesView.isFrom = self.isFrom
                        //succesView.isOnlyFrom = self.isOnlyFrom
                        succesView.imgUrl = response.imagePath ?? ""
                        //Added by Kiran v2.7 -- ENGAGE0011631 -- Added the cancel Category to identify the where cancel is clicked from.
                        //ENGAGE0011631 -- Start
                   //     succesView.cancelFor = self.cancelFor
                        //ENGAGE0011631 -- End
                        succesView.modalTransitionStyle   = .crossDissolve;
                        succesView.modalPresentationStyle = .overCurrentContext
                        self.present(succesView, animated: true, completion: nil)
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
    
}
