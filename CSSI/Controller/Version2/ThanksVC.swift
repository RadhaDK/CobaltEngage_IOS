//
//  ThanksVC.swift
//  CSSI
//
//  Created by apple on 5/11/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

protocol closeModalView
{
    func addMemberDelegate()
    
}

class ThanksVC: UIViewController {
    @IBOutlet weak var lblText1: UILabel!
    @IBOutlet weak var imgType: UIImageView!
    
    @IBOutlet weak var lbltext2: UILabel!
    @IBOutlet weak var lblThankYou: UILabel!
    
    var palyDate: String?
    var type: String?
    var remindDate: String?
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var delegate: closeModalView?
    var segmentIndex: Int?
    var isFrom: String?

    //Added by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
    //ENGAGE0012667 -- Start
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    //ENGAGE0012667 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dateAsStringMin = palyDate
        let dateAsStringMax = remindDate
        
        let dateFormatterMin = DateFormatter()
        dateFormatterMin.dateFormat = "MM/dd/yyy"
        
        let dateMin = dateFormatterMin.date(from: dateAsStringMin!)
        let dateMin2 = dateFormatterMin.date(from: dateAsStringMax!)

        dateFormatterMin.dateFormat = "EEEE, MMMM dd"
    
        
        let DateMin = dateFormatterMin.string(from: dateMin!)
        let DateMin2 = dateFormatterMin.string(from: dateMin2!)
        
        if self.appDelegate.requestFrom == "Golf" {
            if isFrom == "FCFS" {
                self.lblText1.text = self.appDelegate.masterLabeling.gOLF_REQUEST_SUCCESS_MESSAGE_FCFS
                self.lbltext2.text = ""
            } else {
                self.lbltext2.text = self.appDelegate.masterLabeling.gOLF_REQUEST_SUCCESS_MESSAGE2
                self.lblText1.text = self.appDelegate.masterLabeling.gOLF_REQUEST_SUCCESS_MESSAGE1
                self.lbltext2.text =   self.lbltext2.text!.replacingOccurrences(of: "{DaysBefore_PlayDate}", with: DateMin2, options: NSString.CompareOptions.literal, range:nil)
            }
            self.lblText1.text =   self.lblText1.text!.replacingOccurrences(of: "{PlayDay}", with: DateMin, options: NSString.CompareOptions.literal, range:nil)

            self.imgType.image = UIImage(named: "Group 2127")
            
            
        }else if self.isFrom == "DiningEventReservation" || self.isFrom == "EventRequest" || self.isFrom == "SpecialDiningEvent"{
            self.lbltext2.text = self.appDelegate.masterLabeling.dINING_EVENT_REQUEST_SUCCESS_MESSAGE2
            self.lblText1.text = self.appDelegate.masterLabeling.dINING_EVENT_REQUEST_SUCCESS_MESSAGE1
            self.lblText1.text =   self.lblText1.text!.replacingOccurrences(of: "{RequestDate}", with: DateMin, options: NSString.CompareOptions.literal, range:nil)
            self.lbltext2.text =   self.lbltext2.text!.replacingOccurrences(of: "{DaysBefore_RequestedDate}", with: DateMin2, options: NSString.CompareOptions.literal, range:nil)
            
            self.imgType.image = UIImage(named: "Group 918")
            
            
        }
        else if self.appDelegate.requestFrom == "Tennis" {
            if type == "Multi"{
                self.lbltext2.text = self.appDelegate.masterLabeling.cOURT_REQUEST_MULTIDAY_SUCCESS_MESSAGE2
                self.lblText1.text = self.appDelegate.masterLabeling.cOURT_REQUEST_MULTIDAY_SUCCESS_MESSAGE1
            }else{
            self.lbltext2.text = self.appDelegate.masterLabeling.cOURT_REQUEST_SUCCESS_MESSAGE2
            self.lblText1.text = self.appDelegate.masterLabeling.cOURT_REQUEST_SUCCESS_MESSAGE1
            self.lblText1.text = self.lblText1.text!.replacingOccurrences(of: "{PlayDay}", with: DateMin, options: NSString.CompareOptions.literal, range:nil)
            self.lbltext2.text = self.lbltext2.text!.replacingOccurrences(of: "{DaysBefore_PlayDate}", with: DateMin2, options: NSString.CompareOptions.literal, range:nil)
            }

            self.imgType.image = UIImage(named: "Group 2125")
        }else{
            self.lbltext2.text = self.appDelegate.masterLabeling.dINING_REQUEST_SUCCESS_MESSAGE2
            self.lblText1.text = self.appDelegate.masterLabeling.dINING_REQUEST_SUCCESS_MESSAGE1
            self.lblText1.text =   self.lblText1.text!.replacingOccurrences(of: "{RequestDate}", with: DateMin, options: NSString.CompareOptions.literal, range:nil)
            self.lbltext2.text =   self.lbltext2.text!.replacingOccurrences(of: "{DaysBefore_RequestedDate}", with: DateMin2, options: NSString.CompareOptions.literal, range:nil)

            self.imgType.image = UIImage(named: "Group 918")
        }
        
        self.lblThankYou.textColor = APPColor.textColor.secondary
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
   
    @IBAction func closeClicked(_ sender: Any) {
        if self.isFrom == "DiningEventReservation" {
            self.appDelegate.requestFrom = "DiningEventReservation"
            self.appDelegate.segmentIndex = self.segmentIndex ?? 0
            //Added by kiran V2.5 -- ENGAGE0011298 -- in calendar of event screen when registered for dining event and close thank you popup Events listing is not refreshing
            //ENGAGE0011298 -- Start
            self.appDelegate.closeFrom = "DiningEvent"
            //ENGAGE0011298 -- End
        }
        else if self.isFrom == "EventRequest"{
            self.appDelegate.segmentIndex = self.segmentIndex ?? 0
            self.appDelegate.requestFrom = "DiningReservationFromRes"
            self.appDelegate.eventsCloseFrom = "Calendar"
        }

            self.navigationController?.setNavigationBarHidden(false, animated: true)
        
            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
            self.delegate?.addMemberDelegate()
        

        
    }
    
}
