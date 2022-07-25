
//  ThanksUPdateViewController.swift
//  CSSI
//
//  Created by Apple on 29/09/18.
//  Copyright © 2018 yujdesigns. All rights reserved.

import UIKit

class ThanksUPdateViewController: UIViewController {
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
    var segmentIndex: Int?
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            
        }
        else if isFrom == "Update" {
            // Do any additional setup after loading the view.
            self.lblCancelMessage.isHidden = true
            self.lblUpdateMessage.isHidden = false
            self.lblApprovedMessage.isHidden = true
            self.lblMessageForAll.isHidden = false
            
        }
        else if isFrom == "Cancel" {
            // Do any additional setup after loading the view.
            self.lblCancelMessage.isHidden = false
            self.lblUpdateMessage.isHidden = true
            self.lblApprovedMessage.isHidden = true
            self.lblMessageForAll.isHidden = true
            
        }
        else if isFrom == "EventUpdate"  || isFrom  == "EventRequest" {
            self.lblCancelMessage.isHidden = true
            self.lblUpdateMessage.isHidden = false
            self.viewHeight.constant = 80
            if (eventType == 1){
            lblUpdateMessage.text = self.appDelegate.masterLabeling.YOUR_EVENT_UPDATE ?? "" as String
            }
            else{
                lblUpdateMessage.text = self.appDelegate.masterLabeling.YOUR_EVENT_REQUEST ?? "" as String

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
        else if isFrom == "CancelRequest" || isFrom == "EventTennisCancelRequest" {
            // Do any additional setup after loading the view.
            self.lblCancelMessage.isHidden = true
            self.lblUpdateMessage.isHidden = false
            self.viewHeight.constant = 80
            
            lblUpdateMessage.text = self.appDelegate.masterLabeling.cOURT_CANCEL_SUCCESS_MESSAGE ?? "" as String

            
            self.lblApprovedMessage.isHidden = true
            self.lblMessageForAll.isHidden = true
            
        }
        else if isFrom == "DiningCancel" || isFrom == "EventDiningCancelRequest"{
            // Do any additional setup after loading the view.
            self.lblCancelMessage.isHidden = true
            self.lblUpdateMessage.isHidden = false
            self.viewHeight.constant = 80
            
             lblUpdateMessage.text = self.appDelegate.masterLabeling.dINING_CANCEL_SUCCESS_MESSAGE ?? "" as String
            
            
            self.lblApprovedMessage.isHidden = true
            self.lblMessageForAll.isHidden = true
            
        }
        else if isFrom == "GolfCancel" || isFrom == "EventGolfCancelRequest" {
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
        
        
        
        if isSwitch == 1{
            self.lblSwitchCaseText.isHidden = false
        }
        else{
            self.lblSwitchCaseText.isHidden = true
        }
    }
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
            
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for popToViewController in viewControllers {
                if popToViewController is CalendarOfEventsViewController {
                    self.appDelegate.segmentIndex = self.segmentIndex ?? 0
                    self.navigationController!.popToViewController(popToViewController, animated: true)
                    
                }
            }
        }
         
         else if (isFrom == "Buddy") {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for popToViewController in viewControllers {
            if popToViewController is GolfCalendarVC {
                self.appDelegate.buddyType = ""
                self.navigationController!.popToViewController(popToViewController, animated: true)
                
            }
        }
        }
            
         else if (isFrom == "MemberRemoveBuddy") {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for popToViewController in viewControllers {
                if popToViewController is MemberDirectoryViewController {
                    self.appDelegate.buddyType = ""
                    self.navigationController!.popToViewController(popToViewController, animated: true)
                    
                }
            }
         }
         else if (isFrom == "CancelRequest") || (isFrom == "DiningCancel") || (isFrom == "GolfCancel"){
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for popToViewController in viewControllers {
                if popToViewController is GolfCalendarVC {
                    self.appDelegate.buddyType = "My"

                    self.navigationController!.popToViewController(popToViewController, animated: true)
                    
                }
            }
         }
            
         else if isFrom == "EventTennisCancelRequest" || isFrom == "EventGolfCancelRequest" || isFrom == "EventDiningCancelRequest" || isOnlyFrom == "EventSPecialDiningUpdate" {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for popToViewController in viewControllers {
                if popToViewController is CalendarOfEventsViewController {
                   self.appDelegate.eventsCloseFrom = "My"
                    
                    self.navigationController!.popToViewController(popToViewController, animated: true)
                    
                }
            }
         }
            
         else if (isFrom == "Group") {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for popToViewController in viewControllers {
                if popToViewController is MemberDirectoryViewController {
                    self.appDelegate.buddyType = ""
                    self.navigationController!.popToViewController(popToViewController, animated: true)
                    
                }
            }
         }
         else if isFrom == "GolfUpdate"{
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for popToViewController in viewControllers {
                if popToViewController is GolfCalendarVC {
                     self.appDelegate.eventsCloseFrom = "My"
                    self.navigationController!.popToViewController(popToViewController, animated: true)
                    
                }
            }
         }
         else if isFrom == "TennisUpdate"{
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for popToViewController in viewControllers {
                if popToViewController is GolfCalendarVC {
                     self.appDelegate.eventsCloseFrom = "My"
                    self.navigationController!.popToViewController(popToViewController, animated: true)
                    
                }
            }
         }else if isFrom == "EventTennisUpdate" {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for popToViewController in viewControllers {
                if popToViewController is CalendarOfEventsViewController {
                     self.appDelegate.eventsCloseFrom = "My"
                    self.navigationController!.popToViewController(popToViewController, animated: true)
                    
                }
            }
        }
         else if isFrom == "RequestEvents" || isFrom == "CancelEventFromReservation" || isFrom  == "EventRequest"{
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for popToViewController in viewControllers {
                if popToViewController is GolfCalendarVC {
                    self.appDelegate.eventsCloseFrom = "Calendar"
                    self.navigationController!.popToViewController(popToViewController, animated: true)
                    
                }
            }
            
         }
        
         else if isFrom == "DiningUpdate"  {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for popToViewController in viewControllers {
                if popToViewController is GolfCalendarVC {
                    self.appDelegate.eventsCloseFrom = "My"
                    self.navigationController!.popToViewController(popToViewController, animated: true)
                    
                }
            }
         }
            
         else{
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for popToViewController in viewControllers {
            if popToViewController is GuestCardsViewController {
                self.navigationController?.navigationBar.isHidden = false
                self.navigationController!.popToViewController(popToViewController, animated: true)

            }
        }
    }
    }
    
}
