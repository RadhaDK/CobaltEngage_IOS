//
//  CancelDinningReservationPopupVC.swift
//  CSSI
//
//  Created by Aks on 03/11/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

protocol cancelDinningPopup{
    func cancelDinningReservation(value : Bool)
}

class CancelDinningReservationPopupVC: UIViewController {
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var btnRemovePopUp: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var eventID : String?
    var delegateCancelReservation : cancelDinningPopup?
    var diningCancelPopupMode : diningCancelPopupMode?
    
    var cancelReservationClosure:(()->())?
    
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
        deleteMyReservation()
    }
    @IBAction func noBtnTapped(sender:UIButton){
        btnNo.layer.borderColor = UIColor(red: 27/255, green: 202/255, blue: 255/255, alpha: 1).cgColor
        self.dismiss(animated: true, completion: nil)
    }

}
extension CancelDinningReservationPopupVC{
    func deleteMyReservation(){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            var paramaterDict:[String: Any]?
             paramaterDict = [
                "Content-Type":"application/json",
                APIKeys.kRequestID : self.eventID ?? ""
             ]
            
            APIHandler.sharedInstance.deleteMyDinningReservation(paramater: paramaterDict, onSuccess: { reservationDinningListing in
                self.appDelegate.hideIndicator()
                if reservationDinningListing.Responsecode == InternetMessge.ksuccess{
                   // if self.diningCancelPopupMode == .listing{
                    self.delegateCancelReservation?.cancelDinningReservation(value: true)
                    self.cancelReservationClosure?()
                    self.dismiss(animated: true, completion: nil)
                    //}
//                    else{
//
//                    }

                }
                else{
                    self.appDelegate.hideIndicator()
                    self.dismiss(animated: true, completion: nil)
                }
               
            },onFailure: { error  in
                print(error)
                self.appDelegate.hideIndicator()
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }else{
            self.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
    
}


