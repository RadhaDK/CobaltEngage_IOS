//
//  CancelPopUpViewController.swift
//  CSSI
//
//  Created by Apple on 28/09/18.
//  Copyright © 2018 yujdesigns. All rights reserved.

import UIKit


protocol CancelPopUpViewControllerDelegate : NSObject {
    func didCancel(status : Bool)
}

class CancelPopUpViewController: UIViewController, closeModalView
{
    
    func addMemberDelegate() {
        self.dismiss(animated: true, completion: nil)
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for popToViewController in viewControllers {
            if popToViewController is DiningReservationViewController {
                self.navigationController?.navigationBar.isHidden = false
                self.navigationController!.popToViewController(popToViewController, animated: true)
                
            }
        }
        
    }
   
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var lblDoYouWantToCancel: UILabel!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var imgBackGround: UIImageView!
    
    var memberID : String?
    var ID : String?
    var parentID : String?

    var isFrom : String?
    var isOnlyFrom: String?
    var message: String?
    var eventID : String?
    var myGroupID : String?
    var guestID: String?
    var requestID: String?
    var eventType: Int?
    var eventRegID: String?
    
    var paramater:[String: Any] = [:]
    var reservationReqDate : String?
    var reservationRemindDate: String?
    var guests: [Guest] = []
    var diningSettings : DinningSettings?
    
    var cancelFor : CancelCategory?

    var numberOfTickets : String = ""
    
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Added on 8th July 2020 V2.2
    
    ///Names of the fitness and spa departments. used for bgImage only
    var departmentName : String = ""
    
    weak var delegate : CancelPopUpViewControllerDelegate?
    
    
    //Added by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
    //ENGAGE0012667 -- Start
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    //ENGAGE0012667 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        btnNo.backgroundColor = .clear
        btnNo.layer.cornerRadius = 18
        btnNo.layer.borderWidth = 2
        btnNo.layer.borderColor = UIColor.white.cgColor
        
        btnYes.backgroundColor = hexStringToUIColor(hex: "F06C42")
        btnYes.layer.cornerRadius = 18
        btnYes.layer.borderWidth = 2
        btnYes.layer.borderColor = hexStringToUIColor(hex: "F06C42").cgColor
        self.btnYes.setStyle(style: .contained, type: .primary)
        
        //Added by kiran V2.9 -- GATHER0001167 -- added corner radius
        //GATHER0001167 -- Start
        self.imgBackGround.layer.cornerRadius = 10
        self.imgBackGround.clipsToBounds = true
        //GATHER0001167 -- End
        
        // Back ground images loading
        
        //Golf Reservation
        
        self.loadBGImage(category: self.cancelFor == .DiningSpecialEvent ? .DiningEvent : self.cancelFor)
        
      
        if (isFrom == "CancelEvent") || isFrom == "CancelEventFromReservation"{
           
            lblDoYouWantToCancel.text = self.appDelegate.masterLabeling.DO_YOU_WANT_CANCEL ?? "" as String
            
        }
        else if (isFrom == "Buddy") || isFrom == "MemberRemoveBuddy"{
            
            lblDoYouWantToCancel.text = self.appDelegate.masterLabeling.removeBuddy_confirmation ?? "" as String
            
        }
        else if (isFrom == "Groups"){
            
            
            lblDoYouWantToCancel.text = self.appDelegate.masterLabeling.removeGroup_confirmation ?? "" as String
            
        }
        else if (isFrom == "CancelRequest"){
            lblDoYouWantToCancel.text = self.appDelegate.masterLabeling.rESERVATION_CANCEL_CONFIRMATION_MESSAGE

        }else if ((isFrom == "DiningCancel") && (isOnlyFrom == "DiningEvent")) || isFrom == "EventDiningCancelRequestReservation" {
            
            
            
            lblDoYouWantToCancel.text = self.appDelegate.masterLabeling.DO_YOU_WANT_CANCEL

        }
        else if isFrom == "DiningCancel"{
            lblDoYouWantToCancel.text = self.appDelegate.masterLabeling.rESERVATION_CANCEL_CONFIRMATION_MESSAGE
        }
        else if isFrom == "GolfCancel" || isFrom == "EventGolfCancelRequest" || isFrom == "EventTennisCancelRequest" || isFrom == "EventDiningCancelRequest" {
            lblDoYouWantToCancel.text = self.appDelegate.masterLabeling.rESERVATION_CANCEL_CONFIRMATION_MESSAGE
        }
        else if isFrom == "SpecialEvent" || isFrom == "ModifySpecialEvent" {
             lblDoYouWantToCancel.text = message
        }
        else{
            lblDoYouWantToCancel.text = self.appDelegate.masterLabeling.cancel_guest_card ?? "" as String
        }
        
        btnYes .setTitle(self.appDelegate.masterLabeling.Yes, for: .normal)
        btnNo .setTitle(self.appDelegate.masterLabeling.No, for: .normal)
        
        self.loadcancelMessage(category : self.cancelFor)

    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
        
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    @IBAction func yesButtonClicked(_ sender: Any) {
        
      //  paramater["SpecialEvent"] = 1
        self.navigationController?.navigationBar.isHidden = false

        btnNo.backgroundColor = .clear
        btnNo.layer.cornerRadius = 18
        btnNo.layer.borderWidth = 2
        btnNo.layer.borderColor = UIColor.white.cgColor
        
        btnYes.backgroundColor = hexStringToUIColor(hex: "F06C42")
       
        if (isFrom == "CancelEvent") || isFrom == "CancelEventFromReservation"{
            
            self.cancelEvent()
            
        }
        else if (isFrom == "Buddy") || isFrom == "MemberRemoveBuddy"{
            self.removeFromBuddyList()
        }
        else if  (isFrom == "Groups"){
            self.removeMyGroup()
        }
        else if  isFrom == "CancelRequest"  || isFrom == "EventGolfCancelRequest" || isFrom == "EventTennisCancelRequest" || isFrom == "EventDiningCancelRequest" || isFrom == "EventDiningCancelRequestReservation"{
            self.cancelReservationRequest()
        }
         else if isFrom == "DiningCancel" || isFrom == "GolfCancel"{
            self.cancelReservationRequest()
        }
        else if isFrom == "SpecialEvent" || isFrom == "ModifySpecialEvent"{
//            diningRequest()
            
            if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningEventRegistrationVC") as? DiningEventRegistrationVC {
           
                    registerVC.eventID = eventID
                    registerVC.eventType = eventType
                    registerVC.requestID = requestID
                    registerVC.isFrom = "SpecialRequest"
                    registerVC.eventCategory = "Dining"
                if isFrom == "ModifySpecialEvent"{
                    registerVC.isOnlyFrom = "ModifySpecialEvent"
                }
                   // registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
                    //registerVC.eventRegistrationDetailID = requestID ?? ""
                    registerVC.diningSettings = self.diningSettings
                    registerVC.reservationRemindDate = self.reservationRemindDate
                    registerVC.reservationReqDate = self.reservationReqDate
                    self.navigationController?.pushViewController(registerVC, animated: true)
        
            }
        }//Added on 8th July 2020 V2.2
        //Modified by kiran V2.9 -- GATHER0001167 -- Added Golf/Tennis BAL support
        //GATHER0001167 -- Start
        else if self.cancelFor == .fitnessSpa || self.cancelFor == .BMS || cancelFor == .golfBookALesson || self.cancelFor == .tennisBookALesson
        {//GATHER0001167 -- End
            self.cancelAppointment()
        }
        else{
        cancelGuestCards(guests: guests)
        }
        
        self.btnYes.setStyle(style: .contained, type: .primary)
    }
    
    @IBAction func canvelClicked(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false

      self.appDelegate.specialCloseFrom = "SpecialNo"
        self.navigationController?.popViewController(animated: true)
        
    }
    func diningRequest(){
        if (Network.reachability?.isReachable) == true{
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
          
            APIHandler.sharedInstance.saveDiningReservationRequest(paramaterDict: paramater, onSuccess: { memberLists in
                self.appDelegate.hideIndicator()
               
                
                if(memberLists.responseCode == InternetMessge.kSuccess)
                {
                    self.appDelegate.hideIndicator()
                    
                    if self.isFrom == "ModifySpecialEvent"{
//                        if let updateGuestViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "ThanksUPdateViewController") as? ThanksUPdateViewController {
//                            self.appDelegate.hideIndicator()
//                            self.navigationController?.navigationBar.isHidden = false
//                            self.navigationController?.setNavigationBarHidden(false, animated: true)
//                            updateGuestViewController.isOnlyFrom = self.isOnlyFrom
//                            updateGuestViewController.isFrom = "DiningUpdate"
//
//                            self.navigationController?.pushViewController(updateGuestViewController, animated: true)
//                        }
                        
                        if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView {
                            self.appDelegate.hideIndicator()
                            succesView.delegate = self
                            succesView.isOnlyFrom = self.isOnlyFrom
                            succesView.isFrom = "DiningUpdate"
                            succesView.imgUrl = memberLists.imagePath ?? ""
                            succesView.modalTransitionStyle   = .crossDissolve;
                            succesView.modalPresentationStyle = .overCurrentContext
                            self.present(succesView, animated: true, completion: nil)
                        }
                        
                    }else{
                        if let share = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ThanksVC") as? ThanksVC {
                            share.delegate = self
                            self.appDelegate.requestFrom = "Dining"
                            let dateFormatterToSend = DateFormatter()
                            dateFormatterToSend.dateFormat = "MM/dd/yyyy"
                            
                            let isoDate = self.reservationRemindDate
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                            let date = dateFormatter.date(from:isoDate!)!
                            
                            share.remindDate = dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: -(self.diningSettings?.minDaysInAdvance)!, to: date)!)
                            share.palyDate = self.reservationReqDate
                            share.modalTransitionStyle   = .crossDissolve;
                            share.modalPresentationStyle = .overCurrentContext
                            self.present(share, animated: true, completion: nil)
                        }
                        
                    }
                }else{
                    self.appDelegate.hideIndicator()
                    if(((memberLists.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: memberLists.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                }
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
            
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            
        }
    }
    
    func removeFromBuddyList(){
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
           
            let buddy:[String: Any] = [
                
                APIKeys.kMemberId : memberID ?? "",
                APIKeys.kid: ID ?? "",
                APIKeys.kParentId: parentID ?? "",
                "Category": self.appDelegate.typeOfCalendar,
                "BuddyListID": guestID ?? ""
            ]
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "RemoveBuddy": [buddy],
                "RemoveMyGroup": ""
                
            ]
            print(paramaterDict)
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.removeBuddyFromList(paramater: paramaterDict , onSuccess: { response in
                self.appDelegate.hideIndicator()
                if(response.responseCode == InternetMessge.kSuccess){
                    self.appDelegate.hideIndicator()
                    
//                    if let cancelGuestViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "ThanksUPdateViewController") as? ThanksUPdateViewController {
//                        self.appDelegate.hideIndicator()
//                        cancelGuestViewController.isFrom = self.isFrom
//
//                        self.navigationController?.pushViewController(cancelGuestViewController, animated: true)
//                    }
                    if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView {
                        self.appDelegate.hideIndicator()
                        succesView.delegate = self
                        succesView.isFrom = self.isFrom
                        
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
                    
//                    if let cancelGuestViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "ThanksUPdateViewController") as? ThanksUPdateViewController {
//                        self.appDelegate.hideIndicator()
//                        cancelGuestViewController.isFrom = self.isFrom
//
//                        self.navigationController?.pushViewController(cancelGuestViewController, animated: true)
//                    }
                    if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView {
                        self.appDelegate.hideIndicator()
                        succesView.delegate = self
                        succesView.isFrom = self.isFrom
                        succesView.isOnlyFrom = self.isOnlyFrom
                        succesView.imgUrl = response.imagePath ?? ""
                        //Added by Kiran v2.7 -- ENGAGE0011631 -- Added the cancel Category to identify the where cancel is clicked from.
                        //ENGAGE0011631 -- Start
                        succesView.cancelFor = self.cancelFor
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
    
    func cancelEvent(){
                if (Network.reachability?.isReachable) == true{
        
                    self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
                    let eventRequestInfo = [
                        APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                        APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                        "TableNo" : ""
                        
                    ]
        
        
                    let paramaterDict:[String: Any] = [
                        "Content-Type":"application/json",
                        APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                        APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                        APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                        APIKeys.kdeviceInfo: [APIHandler.devicedict],
                        "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                        "Role": UserDefaults.standard.string(forKey: UserDefaultsKeys.role.rawValue)!,
                        "EventID": eventID ?? "",
                        "ActionType": "Multiple",
                        "Action": "Cancel",
                        "EventRegistrationID": self.eventRegID ?? "",
                        "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!,
                        "EventRequests": [eventRequestInfo]
        
                    ]
                    print(paramaterDict)
        
                    self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
                    APIHandler.sharedInstance.getEventCancelReservation(paramater: paramaterDict , onSuccess: { response in
                        self.appDelegate.hideIndicator()
                        if(response.responseCode == InternetMessge.kSuccess){
                            self.appDelegate.hideIndicator()
                            
//                            if let cancelGuestViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "ThanksUPdateViewController") as? ThanksUPdateViewController {
//                                self.appDelegate.hideIndicator()
//                                cancelGuestViewController.isFrom = self.isFrom
//                             //   cancelGuestViewController.isFrom = "CancelEventFromReservation"
//
//                                self.navigationController?.pushViewController(cancelGuestViewController, animated: true)
//                            }
                            if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView {
                                self.appDelegate.hideIndicator()
                                succesView.delegate = self
                                if self.isFrom == "CancelEvent" {
                                    succesView.isFrom = self.isFrom
                                }else{
                                succesView.isFrom = "CancelEventFromReservation"
                                }
                                 succesView.imgUrl = response.imagePath ?? ""
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
    
    func cancelGuestCards(guests: [Guest]) {
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let linkedIds = guests.map { $0.transactionDetailID }
            
            let params: [String : Any] = [
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kguestid : guests.first?.guestCardID as Any,
                APIKeys.klinkedmemberid : linkedIds.joined(separator: ",")
            ]
            
            print(params)
            APIHandler.sharedInstance.cancelGuestCards(paramater: params, onSuccess: {
                self.appDelegate.hideIndicator()
                
//                if let cancelGuestViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "ThanksUPdateViewController") as? ThanksUPdateViewController {
//                    self.appDelegate.hideIndicator()
//                    cancelGuestViewController.isFrom = "Cancel"
//
//                    self.navigationController?.pushViewController(cancelGuestViewController, animated: true)
//                }
                if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView {
                    self.appDelegate.hideIndicator()
                    succesView.delegate = self
                    succesView.isFrom = "Cancel"
                    succesView.modalTransitionStyle   = .crossDissolve;
                    succesView.modalPresentationStyle = .overCurrentContext
                    self.present(succesView, animated: true, completion: nil)
                }
                //    self.navigationController!.popToRootViewController(animated: true)
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            
            //  self.tblGuestListViews.setEmptyMessage(InternetMessge.kInternet_not_available)
        }
    }
    
    
    func removeMyGroup(){
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                "MyGroupID": myGroupID ?? "",
                "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!
                
            ]
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.removeMyGroup(paramater: paramaterDict , onSuccess: { response in
                self.appDelegate.hideIndicator()
                if(response.responseCode == InternetMessge.kSuccess){
                    self.appDelegate.hideIndicator()
                    
//                    if let cancelGuestViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "ThanksUPdateViewController") as? ThanksUPdateViewController {
//                        self.appDelegate.hideIndicator()
//                        cancelGuestViewController.isFrom = "Group"
//
//                        self.navigationController?.pushViewController(cancelGuestViewController, animated: true)
//                    }
                    if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView {
                        self.appDelegate.hideIndicator()
                        succesView.delegate = self
                        succesView.isFrom = "Group"
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
    
    
    //Added on 8th July 2020 V2.2
    //Fitness and spa cancel Request
    private func cancelAppointment()
    {
        guard Network.reachability?.isReachable == true else {
            SharedUtlity.sharedHelper().showToast(on:
            self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            return
        }
        
        
        if let appointmentDetailID = self.eventID
        {
            let paramaterDict : [String : Any] = [
            APIHeader.kContentType : "application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kAppointmentDetailID : appointmentDetailID,
            APIKeys.kCancelReason : "",
            APIKeys.kComments : ""
            ]
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            APIHandler.sharedInstance.cancelAppointment(paramater: paramaterDict, onSuccess: { (imgPath) in
                self.appDelegate.hideIndicator()
               
                if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView {
                    self.appDelegate.hideIndicator()
                    succesView.delegate = self
                    succesView.imgUrl = imgPath
                    //Added by kiran V2.9 -- GATHER0001167 -- Used cancel for instead of isFrom for better handling of Golf/Tennis BAL and Fitness/Spa/Salon requests
                    //GATHER0001167 -- Start
                    //succesView.isFrom = self.cancelFor?.rawValue
                    succesView.cancelFor = self.cancelFor
                    succesView.departmentName = self.departmentName
                    //GATHER0001167 -- End
                    succesView.modalTransitionStyle   = .crossDissolve;
                    succesView.modalPresentationStyle = .overCurrentContext
                    self.present(succesView, animated: true, completion: nil)
                }
                
            }) { (error) in
                self.appDelegate.hideIndicator()
                 SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            }
        }

    }
    
}

//MARK:- custom methods
extension CancelPopUpViewController
{
    private func loadBGImage(category : CancelCategory?)
    {
        //Modified on 8th July 2020 V2.2
        //Modified to include Fitness and spa background image
        if let imageUrl = self.appDelegate.arrCancelPopImageList.filter({(category == .fitnessSpa ? $0.value?.caseInsensitiveCompare(self.departmentName) == .orderedSame  : $0.value == category?.rawValue ?? "")}).first?.imageURL , let URL = URL.init(string: imageUrl)
        {
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            DispatchQueue.global(qos: .userInitiated).async {
                do{
                    let data = try Data.init(contentsOf: URL)
                    DispatchQueue.main.async {
                        self.imgBackGround.image = UIImage.init(data: data)
                        self.appDelegate.hideIndicator()
                    }
                }
                catch let error
                {
                    print(error)
                    DispatchQueue.main.async {
                        self.appDelegate.hideIndicator()
                        
                    }
                }
                
            }
            
        }
        
    }
    
    private func loadcancelMessage(category : CancelCategory?)
    {
        //Added by kiran V2.9 -- GATHER0001167 -- Added safe unwraping for better switch case hadnling
        //GATHER0001167 -- Start
        guard let category = category else{
            return
        }
        //GATHER0001167 -- End
        
        switch category
        {
        case .DiningEvent:
            self.lblDoYouWantToCancel.text = nil
            self.lblDoYouWantToCancel.attributedText = self.generateStringFrom(message: self.appDelegate.masterLabeling.DININGEVENT_CANCEL_MESSAGE, count: self.numberOfTickets)
        case .DiningReservation:
            self.lblDoYouWantToCancel.text = nil
            self.lblDoYouWantToCancel.attributedText = self.generateStringFrom(message: self.appDelegate.masterLabeling.DINING_CANCEL_MESSAGE, count: self.numberOfTickets)
        case .GolfReservation , .TennisReservation:
            self.lblDoYouWantToCancel.text = nil
            self.lblDoYouWantToCancel.attributedText = self.generateStringFrom(message: self.appDelegate.masterLabeling.GOLFTENNIS_CANCEL_MESSAGE, count: self.numberOfTickets)
        case .Events:
            self.lblDoYouWantToCancel.text = nil
            self.lblDoYouWantToCancel.attributedText = self.generateStringFrom(message: self.appDelegate.masterLabeling.EVENT_CANCEL_MESSAGE, count: self.numberOfTickets)
        case .fitnessSpa:
            self.lblDoYouWantToCancel.text = nil
            //Added by kiran V2.9 -- GATHER0001167 -- Added support for Golf/Tennis BAL and addes cases to handle switch better. Update string to department type.
            //GATHER0001167 -- Start
            //self.lblDoYouWantToCancel.attributedText = self.generateStringFrom(message: self.appDelegate.masterLabeling.BMS_Cancel_Message_IOS, count: self.numberOfTickets)
            
            var cancelMessage = ""
            if self.departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Fitness!) == .orderedSame
            {
                cancelMessage = self.appDelegate.masterLabeling.BMS_Cancel_Message_IOS_Fitness ?? ""
            }
            else if self.departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Spa!) == .orderedSame
            {
                cancelMessage = self.appDelegate.masterLabeling.BMS_Cancel_Message_IOS_Spa ?? ""
            }
            else if self.departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Salon!) == .orderedSame
            {
                cancelMessage = self.appDelegate.masterLabeling.BMS_Cancel_Message_IOS_Salon ?? ""
            }

            self.lblDoYouWantToCancel.attributedText = self.generateStringFrom(message: cancelMessage, count: self.numberOfTickets)
        
        case .DiningSpecialEvent:
            break
        case .GuestCard:
            break
        case .RemoveBuddy:
            break
        case .RemoveGroup:
            break
        case .tennisBookALesson:
            self.lblDoYouWantToCancel.text = nil
            self.lblDoYouWantToCancel.attributedText = self.generateStringFrom(message: self.appDelegate.masterLabeling.BMS_Cancel_Message_IOS_TennisLesson, count: self.numberOfTickets)
        case .golfBookALesson:
            self.lblDoYouWantToCancel.text = nil
            self.lblDoYouWantToCancel.attributedText = self.generateStringFrom(message: self.appDelegate.masterLabeling.BMS_Cancel_Message_IOS_GolfLesson, count: self.numberOfTickets)
        case .BMS:
            break
        }
        //GATHER0001167 -- End
        
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

//Modified on 8th July 2020 V2.2
//MARK:- closeUpdateSuccesPopup Delegate
extension CancelPopUpViewController : closeUpdateSuccesPopup
{
    func closeUpdateSuccessView()
    {
        //Modified by kiran V2.9 -- GATHER0001167 -- Added support for Golf/Tennis BAL
        //GATHER0001167 -- Start
        if self.cancelFor == .fitnessSpa || self.cancelFor == .BMS || self.cancelFor == .tennisBookALesson || self.cancelFor == .golfBookALesson
        {//GATHER0001167 -- End
            self.navigationController?.popViewController(animated: true)
            self.delegate?.didCancel(status: true)
        }
        else
        {
            
            self.dismiss(animated: true, completion: nil)
            //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
            //PROD0000069 -- Start
            self.delegate?.didCancel(status: true)
            //PROD0000069 -- End
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for popToViewController in viewControllers
            {
                if self.appDelegate.closeFrom == "DiningUpdate" || self.appDelegate.closeFrom == "Calendar" || self.appDelegate.closeFrom == "Cancel"  || self.appDelegate.closeFrom == "Buddy" || self.appDelegate.closeFrom == "DiningReservation" || self.appDelegate.closeFrom == "DiningReservationReq"
                {
                    if self.appDelegate.closeFrom == "DiningReservationReq"
                    {
                        if popToViewController is GolfCalendarVC
                        {
                            self.navigationController?.navigationBar.isHidden = false
                            self.navigationController!.popToViewController(popToViewController, animated: true)
                            
                        }
                        //Added by kiran -- ENGAGE0011298 -- V2.5 -- This fixed a issue where when coming from calendar of events modify and special request is selected and cancelled then not navigating to calendar of events of screen.
                        //ENGAGE0011298 -- Start
                        else if popToViewController is CalendarOfEventsViewController
                        {
                            self.navigationController!.popToViewController(popToViewController, animated: true)
                        }
                        //ENGAGE0011298 -- End
                    }
                    else
                    {
                        if popToViewController is GolfCalendarVC
                        {
                            self.navigationController?.navigationBar.isHidden = false
                            self.navigationController!.popToViewController(popToViewController, animated: true)
                            
                        }
                        
                    }
                }
                else if self.appDelegate.closeFrom == "EventTennisUpdate" || self.appDelegate.closeFrom == "CancelReservation" || self.appDelegate.closeFrom == "CancelEventFromReservation" || self.appDelegate.closeFrom == "DiningEvent"
                {
                    if popToViewController is CalendarOfEventsViewController
                    {
                        self.navigationController?.navigationBar.isHidden = true
                        self.navigationController!.popToViewController(popToViewController, animated: true)
                        
                    }
                }
                else if self.appDelegate.closeFrom == "MB"
                {
                    if popToViewController is MemberDirectoryViewController
                    {
                        self.navigationController?.navigationBar.isHidden = false
                        self.navigationController!.popToViewController(popToViewController, animated: true)
                        
                    }
                }
                else if self.appDelegate.closeFrom == "Guest"
                {
                    if popToViewController is GuestCardsViewController
                    {
                        self.navigationController?.navigationBar.isHidden = false
                        self.navigationController!.popToViewController(popToViewController, animated: true)
                        
                    }
                }
               
            }

        }
        
    }
    
}
