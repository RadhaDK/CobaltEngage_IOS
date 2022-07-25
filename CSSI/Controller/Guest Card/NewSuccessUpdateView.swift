//
//  NewSuccessUpdateView.swift
//  CSSI
//
//  Created by apple on 8/22/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit
protocol closeUpdateSuccesPopup
{
    func closeUpdateSuccessView()
    
}
class NewSuccessUpdateView: UIViewController {
    var isFrom : String?
    var isSwitch : NSInteger!
    var eventType : Int?
    var isOnlyFrom: String?
    
    @IBOutlet var lblUpdateMessage: UILabel!
    @IBOutlet weak var lblSwitchCaseText: UILabel!
    @IBOutlet weak var lblCancelMessage: UILabel!
    @IBOutlet weak var lblMessageForAll: UILabel!
    @IBOutlet weak var lblThanksMessage: UILabel!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblApprovedMessage: UILabel!
    @IBOutlet weak var lblIcon: UIImageView!
    
    
    var isTGAEvent: Int?
    var tgaMessage: String?
    var imgUrl: String?
    var segmentIndex: Int?
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var delegate: closeUpdateSuccesPopup?
    
    //Commented by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead
    //ENGAGE0011419 -- Start
    //Mark- Verify url exist
//    func verifyUrl(urlString: String?) -> Bool {
//        if let urlString = urlString {
//            if let url = URL(string: urlString) {
//                return UIApplication.shared.canOpenURL(url)
//            }
//        }
//        return false
//    }
    //ENGAGE0011419 -- End
    
    //Added by Kiran v2.7 -- ENGAGE0011631 -- Added the cancel Category to fix the issue. Issue:- When user Cancel Tee time request from "My Calendar" listing screen in the success pop up text is displayed as "Your court time request has been cancelled" instead of displaying as "Your Tee time request has been cancelled".
    //ENGAGE0011631 -- Start
    var cancelFor : CancelCategory?
    //ENGAGE0011631 -- End
    
    //Added by kiran V2.9 -- GATHER0001167 -- Added department name to identify department in fintess&Spa
    //GATHER0001167 -- Start
    var departmentName = ""
    //GATHER0001167 -- End
    
    //Added by kiran V1.4 -- PROD0000148 -- Success mesage popup message change
    //PROD0000148 -- Start
    var isFromModule : AppModules?
    var successMessage : String = ""
    //PROD0000148 -- End
    
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
        
        
        let placeHolderImage = UIImage(named: "Icon-App-40x40")
        lblIcon.image = placeHolderImage
        //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
        //ENGAGE0011419 -- Start
        let imageURLString = imgUrl ?? ""
        
        if imageURLString.isValidURL()
        {
            let url = URL.init(string:imageURLString)
            lblIcon.sd_setImage(with: url , placeholderImage: placeHolderImage)
        }
        /*
        if(imageURLString.count>0){
            let validUrl = self.verifyUrl(urlString: imageURLString)
            if(validUrl == true){
                
                let url = URL.init(string:imageURLString)
                lblIcon.sd_setImage(with: url , placeholderImage: placeHolderImage)
                
            }
        }
        */
        //ENGAGE0011419 -- End
        
        lblThanksMessage.text = self.appDelegate.masterLabeling.thank_You ?? "" as String
        lblUpdateMessage.text = self.appDelegate.masterLabeling.guest_modify_validation ?? "" as String
        lblSwitchCaseText.text = self.appDelegate.masterLabeling.guest_save_validation3 ?? "" as String
        lblCancelMessage.text = self.appDelegate.masterLabeling.guest_card_has_been_cancelled ?? "" as String
        lblMessageForAll.text = self.appDelegate.masterLabeling.guest_save_validation2 ?? "" as String
        lblApprovedMessage.text = self.appDelegate.masterLabeling.guest_save_validation1 ?? "" as String
        
        if isFrom == "New"{
            // Do any additional setup after loading the view.
            self.lblCancelMessage.isHidden = true
            self.lblUpdateMessage.isHidden = true
            self.lblApprovedMessage.isHidden = false
            self.lblMessageForAll.isHidden = false
            self.viewHeight.constant = 320
            lblIcon.image = UIImage(named: "Guest Card_Icon-1")
        }
        else if isFrom == "Update" {
            // Do any additional setup after loading the view.
            self.lblCancelMessage.isHidden = true
            self.lblUpdateMessage.isHidden = false
            self.lblApprovedMessage.isHidden = true
            self.lblMessageForAll.isHidden = false
            self.viewHeight.constant = 320
            lblIcon.image = UIImage(named: "Guest Card_Icon-1")

        }
        else if isFrom == "Cancel" {
            // Do any additional setup after loading the view.
            self.lblCancelMessage.isHidden = false
            self.lblUpdateMessage.isHidden = true
            self.lblApprovedMessage.isHidden = true
            self.lblMessageForAll.isHidden = true
            self.viewHeight.constant = 150
            lblIcon.image = UIImage(named: "Guest Card_Icon-1")

        }
        else if isFrom == "EventUpdate"  || isFrom  == "EventRequest"
        {
            self.lblCancelMessage.isHidden = true
            self.lblUpdateMessage.isHidden = false
            self.viewHeight.constant = 80
            if (eventType == 1)
            {
                //Added by kiran V1.4 -- PROD0000148 -- Success mesage popup message change
                //PROD0000148 -- Start
                if self.isFromModule == .events
                {
                    lblUpdateMessage.text = self.successMessage
                }
                else
                {//Moved old ogic to else part
                    lblUpdateMessage.text = self.appDelegate.masterLabeling.YOUR_EVENT_UPDATE ?? "" as String
                }
                //PROD0000148 -- End
            }
            else
            {
                if isTGAEvent == 1
                {
                    lblUpdateMessage.text = tgaMessage

                }
                else
                {
                    //Added by kiran V1.4 -- PROD0000148 -- Success mesage popup message change
                    //PROD0000148 -- Start
                    if self.isFromModule == .events
                    {
                        lblUpdateMessage.text = self.successMessage
                    }
                    else
                    {//Moved old logic to else part
                        lblUpdateMessage.text = self.appDelegate.masterLabeling.YOUR_EVENT_REQUEST ?? "" as String
                    }
                    //PROD0000148 -- End
                }
                
            }
            
            self.lblApprovedMessage.isHidden = true
            self.lblMessageForAll.isHidden = true
            
        }
        else if isFrom == "RequestEvents"{
            self.lblCancelMessage.isHidden = true
            self.lblUpdateMessage.isHidden = false
            self.viewHeight.constant = 80
            lblUpdateMessage.text = self.appDelegate.masterLabeling.YOUR_EVENT_UPDATE ?? "" as String
            self.lblApprovedMessage.isHidden = true
            self.lblMessageForAll.isHidden = true
            
        }
        else if isFrom == "CancelEvent" || isFrom == "CancelEventFromReservation"  {
            // Do any additional setup after loading the view.
            self.lblCancelMessage.isHidden = true
            self.lblUpdateMessage.isHidden = false
            self.viewHeight.constant = 80
            
            lblUpdateMessage.text = self.appDelegate.masterLabeling.YOUR_EVENT_CANCEL ?? "" as String
            
            self.lblApprovedMessage.isHidden = true
            self.lblMessageForAll.isHidden = true
            
        }
        //Added by Kiran v2.7 -- ENGAGE0011631 -- Added the cancel Category to fix the issue. to identify the reservation type
        //ENGAGE0011631 -- Start
        //old
        //else if isFrom == "CancelRequest" || isFrom == "EventTennisCancelRequest"
        
        else if (isFrom == "CancelRequest" && self.cancelFor == .TennisReservation) || isFrom == "EventTennisCancelRequest"
        {//ENGAGE0011631 -- End
            // Do any additional setup after loading the view.
            self.lblCancelMessage.isHidden = true
            self.lblUpdateMessage.isHidden = false
            self.viewHeight.constant = 80
            
            lblUpdateMessage.text = self.appDelegate.masterLabeling.cOURT_CANCEL_SUCCESS_MESSAGE ?? "" as String
            
            
            self.lblApprovedMessage.isHidden = true
            self.lblMessageForAll.isHidden = true
            
        }
        else if ((isFrom == "DiningCancel") && (isOnlyFrom == "DiningEvent")) || isFrom == "EventDiningCancelRequestReservation" {
            
            self.lblCancelMessage.isHidden = true
            self.lblUpdateMessage.isHidden = false
            self.viewHeight.constant = 80
            //Added by kiran V1.4 -- PROD0000148 -- Cancel popup message change to dining specific key
            //PROD0000148 -- Start
            self.lblUpdateMessage.text = self.appDelegate.masterLabeling.your_Dining_Event_Cancel ?? "" as String
            //Old logic
            //lblUpdateMessage.text = self.appDelegate.masterLabeling.YOUR_EVENT_CANCEL ?? "" as String
            //PROD0000148 -- End
            
            self.lblApprovedMessage.isHidden = true
            self.lblMessageForAll.isHidden = true
        }
        
        else if isFrom == "DiningCancel" || isFrom == "EventDiningCancelRequest" || isFrom == "EventDiningCancelRequestReservation"{
            // Do any additional setup after loading the view.
            self.lblCancelMessage.isHidden = true
            self.lblUpdateMessage.isHidden = false
            self.viewHeight.constant = 80
            
            lblUpdateMessage.text = self.appDelegate.masterLabeling.dINING_CANCEL_SUCCESS_MESSAGE ?? "" as String
            
            
            self.lblApprovedMessage.isHidden = true
            self.lblMessageForAll.isHidden = true
            
        }
        //Added by Kiran v2.7 -- ENGAGE0011631 -- Added the cancel Category to identify the reservation type.
        //ENGAGE0011631 -- Start
        //OLD
        //else if isFrom == "GolfCancel" || isFrom == "EventGolfCancelRequest"
        else if isFrom == "GolfCancel" || isFrom == "EventGolfCancelRequest" || (isFrom == "CancelRequest" && self.cancelFor == .GolfReservation)
        {//ENGAGE0011631 -- End
            // Do any additional setup after loading the view.
            self.lblCancelMessage.isHidden = true
            self.lblUpdateMessage.isHidden = false
            self.viewHeight.constant = 80
            
            lblUpdateMessage.text = self.appDelegate.masterLabeling.gOLF_CANCEL_SUCCESS_MESSAGE ?? "" as String
            //   lblUpdateMessage.text = "Your Golf Request has been Cancelled."
            
            
            self.lblApprovedMessage.isHidden = true
            self.lblMessageForAll.isHidden = true
            
        }
        else if isFrom == "Buddy"  || isFrom == "MemberRemoveBuddy"{
            // Do any additional setup after loading the view.
            self.lblCancelMessage.isHidden = true
            self.lblUpdateMessage.isHidden = false
            self.viewHeight.constant = 80
            
            lblUpdateMessage.text = self.appDelegate.masterLabeling.removeBuddy_succes ?? "" as String
            
            
            self.lblApprovedMessage.isHidden = true
            self.lblMessageForAll.isHidden = true
            
        }
        else if isFrom == "Group" {
            // Do any additional setup after loading the view.
            self.lblCancelMessage.isHidden = true
            self.lblUpdateMessage.isHidden = false
            self.viewHeight.constant = 80
            
            lblUpdateMessage.text = self.appDelegate.masterLabeling.removeGroup_succes ?? "" as String
            
            
            self.lblApprovedMessage.isHidden = true
            self.lblMessageForAll.isHidden = true
            
        }
            
        else if isFrom == "GolfUpdate" || isFrom == "TennisUpdate" || isFrom == "DiningUpdate" || isFrom == "EventTennisUpdate" {
            // Do any additional setup after loading the view.
            self.lblCancelMessage.isHidden = true
            self.lblUpdateMessage.isHidden = false
            self.viewHeight.constant = 80
            
            lblUpdateMessage.text = self.appDelegate.masterLabeling.uPDATE_SUCCESS_MESSAGE ?? "" as String
            
            
            self.lblApprovedMessage.isHidden = true
            self.lblMessageForAll.isHidden = true
            
        }
        else if isFrom == "SpecialRequest"{
            self.lblCancelMessage.isHidden = true
            self.lblUpdateMessage.isHidden = false
            self.viewHeight.constant = 80
            lblUpdateMessage.text = self.appDelegate.masterLabeling.YOUR_EVENT_UPDATE ?? "" as String
            self.lblApprovedMessage.isHidden = true
            self.lblMessageForAll.isHidden = true
        }
        //Added on 8th July 2020 V2.2
        else if isFrom == CancelCategory.fitnessSpa.rawValue
        {
            //This wont be executed because of the change in V2.9 Golf BAL - GATHER0001167. Comment of remove later on
            self.lblCancelMessage.isHidden = true
            self.lblUpdateMessage.isHidden = false
            self.viewHeight.constant = 80
            
            
            lblUpdateMessage.text = self.appDelegate.masterLabeling.BMS_CancelledMessage ?? ""
            
            
            self.lblApprovedMessage.isHidden = true
            self.lblMessageForAll.isHidden = true
        }
        
        //Added by kiran V2.9 -- GATHER0001167 -- Added switch to better handle Golf/Tennis BAL and Fitness/Spa/Salon requets
        //GATHER0001167 -- Start
        //This only Applicable for BMS.
        if let cancelFor = self.cancelFor
        {
           
            switch cancelFor
            {
            case .DiningEvent:
                break
            case .GolfReservation:
                break
            case .TennisReservation:
                break
            case .DiningReservation:
                break
            case .DiningSpecialEvent:
                break
            case .Events:
                break
            case .GuestCard:
                break
            case .RemoveBuddy:
                break
            case .RemoveGroup:
                break
            case .fitnessSpa:
                self.lblCancelMessage.isHidden = true
                self.lblUpdateMessage.isHidden = false
                self.viewHeight.constant = 80
                
                var cancelMessage = ""
                if self.departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Fitness!) == .orderedSame
                {
                    cancelMessage = self.appDelegate.masterLabeling.BMS_CancelledMessage_Fitness ?? ""
                }
                else if self.departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Spa!) == .orderedSame
                {
                    cancelMessage = self.appDelegate.masterLabeling.BMS_CancelledMessage_Spa ?? ""
                }
                else if self.departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Salon!) == .orderedSame
                {
                    cancelMessage = self.appDelegate.masterLabeling.BMS_CancelledMessage_Salon ?? ""
                }

                self.lblUpdateMessage.text = cancelMessage
                //self.lblUpdateMessage.text = self.appDelegate.masterLabeling.BMS_CancelledMessage ?? ""
                self.lblApprovedMessage.isHidden = true
                self.lblMessageForAll.isHidden = true
                
            case .tennisBookALesson:
                
                self.lblCancelMessage.isHidden = true
                self.lblUpdateMessage.isHidden = false
                self.viewHeight.constant = 80
                self.lblUpdateMessage.text = self.appDelegate.masterLabeling.BMS_CancelledMessage_TennisLesson ?? ""
                self.lblApprovedMessage.isHidden = true
                self.lblMessageForAll.isHidden = true
                
            case .golfBookALesson:
                self.lblCancelMessage.isHidden = true
                self.lblUpdateMessage.isHidden = false
                self.viewHeight.constant = 80
                self.lblUpdateMessage.text = self.appDelegate.masterLabeling.BMS_CancelledMessage_GolfLesson ?? ""
                self.lblApprovedMessage.isHidden = true
                self.lblMessageForAll.isHidden = true
            case .BMS:
                self.lblCancelMessage.isHidden = true
                self.lblUpdateMessage.isHidden = false
                self.viewHeight.constant = 80
                self.lblUpdateMessage.text = ""
                self.lblApprovedMessage.isHidden = true
                self.lblMessageForAll.isHidden = true
            }
            
        }
        //GATHER0001167 -- End
        
        
        if isSwitch == 1{
            self.lblSwitchCaseText.isHidden = false
        }
        else{
            self.lblSwitchCaseText.isHidden = true
        }
        
        self.lblThanksMessage.textColor = APPColor.textColor.secondary
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
        // Hide the navigation bar on the this view controller
        self.tabBarController?.tabBar.isHidden = true
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
       
        self.navigationController?.navigationBar.isHidden = false
        
    }
    @IBAction func closeClicked(_ sender: Any) {


        if (isFrom == "EventUpdate") || (isFrom == "CancelEvent")  {
            self.appDelegate.closeFrom = "EventTennisUpdate"
             self.appDelegate.segmentIndex = self.segmentIndex ?? 0
            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.closeUpdateSuccessView()


        }

        else if (isFrom == "Buddy") {
            self.appDelegate.buddyType = ""
            self.appDelegate.closeFrom = "Buddy"

            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.closeUpdateSuccessView()

        }

        else if (isFrom == "MemberRemoveBuddy") {
            self.appDelegate.buddyType = ""
            self.appDelegate.closeFrom = "MB"

            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.closeUpdateSuccessView()

        }
        else if (isFrom == "DiningCancel") && (isOnlyFrom == "DiningEvent") {
            
            self.appDelegate.segmentIndex = 1
            self.appDelegate.closeFrom = "DiningEvent"
            
            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.closeUpdateSuccessView()
           
        }
        else if (isFrom == "CancelRequest") || (isFrom == "DiningCancel") || (isFrom == "GolfCancel"){
            self.appDelegate.buddyType = "My"
            self.appDelegate.closeFrom = "Cancel"

            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.closeUpdateSuccessView()

        }

        else if isFrom == "EventTennisCancelRequest" || isFrom == "EventGolfCancelRequest" || isFrom == "EventDiningCancelRequest" || isOnlyFrom == "EventSPecialDiningUpdate" {
            self.appDelegate.eventsCloseFrom = "My"
            self.appDelegate.closeFrom = "CancelReservation"
            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.closeUpdateSuccessView()

        }
        else if isFrom == "EventDiningCancelRequestReservation"{
            
            if isOnlyFrom == "EventDiningCancelRequestRes"{
                self.appDelegate.eventsCloseFrom = "My"
                self.appDelegate.closeFrom = "DiningReservationReq"
                presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                self.delegate?.closeUpdateSuccessView()
            }else{
            self.appDelegate.eventsCloseFrom = "My"
            self.appDelegate.closeFrom = "DiningReservation"
            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.closeUpdateSuccessView()
            }
        }

        else if (isFrom == "Group") {
            self.appDelegate.closeFrom = "MB"

            self.appDelegate.buddyType = ""
            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.closeUpdateSuccessView()

        }
        else if isFrom == "GolfUpdate"{
            self.appDelegate.closeFrom = "GolfUpdate"

            self.appDelegate.eventsCloseFrom = "My"
            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.closeUpdateSuccessView()
            

        }
        else if isFrom == "TennisUpdate"{
            self.appDelegate.closeFrom = "TennisUpdate"

            
            self.appDelegate.eventsCloseFrom = "My"
            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.closeUpdateSuccessView()

        }else if isFrom == "EventTennisUpdate" {
            self.appDelegate.closeFrom = "EventTennisUpdate"

            self.appDelegate.eventsCloseFrom = "My"
            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.closeUpdateSuccessView()
            

        }
        else if isFrom == "RequestEvents" || isFrom == "CancelEventFromReservation" || isFrom  == "EventRequest"{
            self.appDelegate.eventsCloseFrom = "Calendar"
            self.appDelegate.closeFrom = "Calendar"
            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.closeUpdateSuccessView()
            

        }

        else if isFrom == "DiningUpdate"  {
            self.appDelegate.closeFrom = "DiningUpdate"
            self.appDelegate.eventsCloseFrom = "My"
            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.closeUpdateSuccessView()
            

        }
        else if isFrom == "SpecialRequest"{
            
            self.appDelegate.closeFrom = "SpecialRequest"
            self.appDelegate.eventsCloseFrom = "My"
            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.closeUpdateSuccessView()
        }
        //Added on 8th JUly 2020 V2.2
        //Fitness and spa
        else if isFrom == CancelCategory.fitnessSpa.rawValue
        {//Note:- This will no longer be used because of change in V2.9 -- GATHER0001167. Comment later
            self.dismiss(animated: true, completion: nil)
            self.delegate?.closeUpdateSuccessView()
        }
        else
        {
            //Added by kiran V2.9 -- GATHER0001167 -- Added switch to better handle Golf/Tennis BAL and Fitness/Spa/Salon reqeusts
            //GATHER0001167 -- Start
            //This only Applicable for BMS as of V2.9. and future changes to any department should be done here and above nested if else operator should be gradually removed
            if let cancelFor = self.cancelFor
            {
               
                switch cancelFor
                {
                case .DiningEvent:
                    break
                case .GolfReservation:
                    break
                case .TennisReservation:
                    break
                case .DiningReservation:
                    break
                case .DiningSpecialEvent:
                    break
                case .Events:
                    break
                case .GuestCard:
                    break
                case .RemoveBuddy:
                    break
                case .RemoveGroup:
                    break
                case .fitnessSpa,.tennisBookALesson,.golfBookALesson,.BMS:

                    self.dismiss(animated: true, completion: nil)
                    self.delegate?.closeUpdateSuccessView()
                    return
                }
                
            }
            //GATHER0001167 -- End

            self.appDelegate.buddyType = ""
            self.appDelegate.closeFrom = "Guest"
            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate?.closeUpdateSuccessView()
        }
        
       
    }
    
}
