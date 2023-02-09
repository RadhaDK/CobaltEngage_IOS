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

protocol cancelReservationBlockedPopup{
    func cancelBlockedReservationPopup(value : String)
}

class CancelDinningReservationPopupVC: UIViewController {
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var btnRemovePopUp: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var centerIcon: UIImageView!

    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var eventID : String?
    var delegateCancelReservation : cancelDinningPopup?
   // var diningCancelPopupMode : diningCancelPopupMode?
    var partySize = 1
    var cancelReservationClosure:(()->())?
    var diningPopupMode : diningPopup?
    var desribtionText : String?
    var delegateBlockTimer : cancelReservationBlockedPopup?
    var isFrom: dinningMode = .create

    override func viewDidLoad() {
        super.viewDidLoad()

        btnYes.layer.cornerRadius = btnYes.bounds.size.height / 2
        btnYes.layer.borderWidth = 1.0
        btnYes.layer.backgroundColor = hexStringToUIColor(hex: "F47D4C").cgColor
        self.btnYes.setStyle(style: .contained, type: .primary)
        btnNo.layer.cornerRadius = btnNo.bounds.size.height / 2
        btnNo.layer.borderWidth = 1.0
        btnNo.layer.backgroundColor = hexStringToUIColor(hex: "F47D4C").cgColor
        self.btnNo.setStyle(style: .contained, type: .primary)
        btnYes.setTitle(self.appDelegate.masterLabeling.Yes ?? "", for: .normal)
        btnNo.setTitle(self.appDelegate.masterLabeling.No ?? "", for: .normal)
        self.descriptionLbl.text = nil
        self.descriptionLbl.attributedText = self.generateStringFrom(message: self.appDelegate.masterLabeling.DINING_CANCEL_MESSAGE, count: "\(self.partySize)")
        self.descriptionLbl.textColor = .darkGray
        self.descriptionLbl.font = .systemFont(ofSize: 24.0, weight: .semibold)
        if diningPopupMode == .timeslot{
            centerIcon.image = UIImage(named: "Group 918")
            self.descriptionLbl.font = .systemFont(ofSize: 18.0, weight: .regular)
            descriptionLbl.text = desribtionText
        }
    }
    
    
    

    @IBAction func removePopUpBtnTapped(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func yesBtnTapped(sender:UIButton){
        if diningPopupMode == .timeslot{
            self.dismiss(animated: true, completion: nil)
            delegateBlockTimer?.cancelBlockedReservationPopup(value: "Yes")
            
        }
        else{
            btnYes.layer.borderColor = UIColor(red: 27/255, green: 202/255, blue: 255/255, alpha: 1).cgColor
            //        self.cancelReservationClosure?()
            //        self.dismiss(animated: true, completion: nil)
            deleteMyReservation()
        }
    }
    @IBAction func noBtnTapped(sender:UIButton){
        if diningPopupMode == .timeslot{
            self.dismiss(animated: true, completion: nil)
            delegateBlockTimer?.cancelBlockedReservationPopup(value: "No")
        }
        else{
            btnNo.layer.borderColor = UIColor(red: 27/255, green: 202/255, blue: 255/255, alpha: 1).cgColor
            self.dismiss(animated: true, completion: nil)
        }
    }

    
    private func generateStringFrom(message : String? , count : String) -> NSAttributedString?
    {
        var strMessage : NSAttributedString?
        
        var tempString = String()
        
        tempString = (message ?? "").replacingOccurrences(of: "{#Ticket}", with: count)
        
        if tempString.contains("<html>")
        {
            strMessage = tempString.htmlToAttributedString
        }
        else
        {
            strMessage = NSAttributedString.init(string: tempString)
        }
        
        return strMessage
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
                    SharedUtlity.sharedHelper().showToast(on:
                                                            self.view, withMeassge: reservationDinningListing.responseMessage, withDuration: Duration.kMediumDuration)
//                    self.dismiss(animated: true, completion: nil)
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


