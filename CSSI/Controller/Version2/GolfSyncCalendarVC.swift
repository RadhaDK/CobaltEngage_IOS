//
//  GolfSyncCalendarVC.swift
//  CSSI
//
//  Created by apple on 4/25/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit
import EventKit

class GolfSyncCalendarVC: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var commentsWidth: NSLayoutConstraint!
    @IBOutlet weak var groupsTableView: UITableView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventDay: UILabel!
    @IBOutlet weak var lblEventtime: UILabel!
    @IBOutlet weak var lblFromTime: UILabel!
    @IBOutlet weak var lblToTime: UILabel!
    @IBOutlet weak var lblEventTitle: UILabel!
    @IBOutlet weak var lblAlert: UILabel!
    @IBOutlet weak var lblAdditionalEventDetails: UILabel!
    @IBOutlet weak var btnAddToCalendar: UIButton!
    @IBOutlet weak var txtAlertDropDown: UITextField!
    //commented on 3rd August 2020 V2.3
    //@IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewCalendar: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblRoundlength: UILabel!
    @IBOutlet weak var lblPreferredteetime: UILabel!
    @IBOutlet weak var lblPreferredTeetimevalue: UILabel!
    @IBOutlet weak var lblRoundLengthvalue: UILabel!
    @IBOutlet weak var lblEarlierTeeTime: UILabel!
    @IBOutlet weak var lblEarlierTeeTimeValue: UILabel!
    @IBOutlet weak var lblLinkGroup: UILabel!
    @IBOutlet weak var lblLinkGroupvalue: UILabel!
    @IBOutlet weak var lblMoreinfo: UILabel!
    @IBOutlet weak var lblPrefferedCource: UILabel!
    @IBOutlet weak var lblPrefferedCourcevalue: UILabel!
    @IBOutlet weak var lblNotPreferred: UILabel!
    @IBOutlet weak var lblNotPrefferedValue: UILabel!
    @IBOutlet weak var lblUrl: UILabel!

    @IBOutlet weak var lblConfirmedTime: UILabel!
    
    //Added on 3rd August 2020 V2.3
    @IBOutlet weak var viewPreferredCourse: UIView!
    @IBOutlet weak var viewNotPreferredCource: UIView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var syncScrollView: UIScrollView!
    
    var captainName: String?
    var arrEventDetails = [ListEvents]()
    var arrTeeTimeDetails = [RequestTeeTimeDetail]()
    var requestID : String?
    var eventRegistrationDetailID : String?
    var isFrom: String?
    var shareTextGolf: String?
    var partyList = [String]()
    var textToShare =  [String]()
    var notes : String?
    fileprivate var selectedRemainder: ReminderTime? = nil
    fileprivate var reminderPicker: UIPickerView? = nil;

    
    
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var eventName : String?
    var eventDay : String!
    var eventID : String?
    var eventCategory : String!
    var startDate = Date()
    var endDate = Date()
    var timeInterval : TimeInterval!
    var url : String!
    
    var myMutableString = NSMutableAttributedString()
    
    //Added on 22nd June 2020
    private var arrAppointmentDetails = [Appointment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblPreferredteetime.text = self.appDelegate.masterLabeling.preferred_tee_time
        self.lblEarlierTeeTime.text = self.appDelegate.masterLabeling.earliest_tee_time
        self.lblConfirmedTime.font = SFont.SourceSansPro_Regular16
        // Do any additional setup after loading the view.
        
        arrTeeTimeDetails.removeAll()
        self.lblPrefferedCource.text = self.appDelegate.masterLabeling.preferred_course_colon
        self.lblNotPreferred.text = self.appDelegate.masterLabeling.eXCLUDE_COURSE_COLON

        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Added comparioson for BMS. beacuse tennis book a leasson and Tennis reservations have same isFrom.
        //GATHER0000700 - Start
        if(self.appDelegate.typeOfCalendar == "Tennis" || ((isFrom?.caseInsensitiveCompare("Tennis")) == ComparisonResult.orderedSame)) && self.arrEventDetails.first?.requestType != .BMS
        {//GATHER0000700 - End
            lblLinkGroup.isHidden = true
            lblLinkGroupvalue.isHidden = true
            self.getTennisEventDetailsApi()
            self.lblEarlierTeeTime.text = self.appDelegate.masterLabeling.match_colon
            self.lblPreferredteetime.text = self.appDelegate.masterLabeling.duration_colon
            self.lblRoundlength.text = self.appDelegate.masterLabeling.court_time
            self.lblPreferredTeetimevalue.isHidden = false
            
            //Modified on 3rd August 2020 V2.3
            //lblPrefferedCource.isHidden = true
            //lblPrefferedCourcevalue.isHidden = true
            //lblNotPreferred.isHidden = true
            //lblNotPrefferedValue.isHidden = true
            self.viewPreferredCourse.isHidden = true
            self.viewNotPreferredCource.isHidden = true
            
            self.lblConfirmedTime.text = String(format: "%@  %@", self.arrEventDetails[0].eventTime ?? "",self.arrEventDetails[0].eventName ?? "")

            lblRoundlength.font = SFont.SFProText_Regular17
            lblPreferredteetime.font = SFont.SFProText_Regular17
            
            for i in 0 ..< appDelegate.arrShareUrlList.count {
               if  appDelegate.arrShareUrlList[i].name == "TennisReservations"{
                    lblUrl.text = String(format: "%@%@/%@", appDelegate.arrShareUrlList[i].url!,arrEventDetails[0].eventID ?? "",arrEventDetails[0].eventCategory ?? "")
                    
                }else{
                    
                }
            }
            self.navigationItem.title = self.appDelegate.masterLabeling.court_time_details

        }
        else if(self.appDelegate.typeOfCalendar == "Dining" || ((isFrom?.caseInsensitiveCompare("Dining")) == ComparisonResult.orderedSame)){
//            lblLinkGroup.isHidden = true
//            lblLinkGroupvalue.isHidden = true
            self.getDiningEventDetailsApi()
            
            self.lblEarlierTeeTime.text = self.appDelegate.masterLabeling.special_request
            self.lblPreferredteetime.text = self.appDelegate.masterLabeling.time_colon
            self.lblRoundlength.text = self.appDelegate.masterLabeling.rESTAURTENT_NAME_COLON
            self.lblLinkGroup.text = self.appDelegate.masterLabeling.cOMMENTS_COLON
            //Commented on 25th June 2020 BMS
            //self.commentsWidth.constant = 86

            self.lblEarlierTeeTimeValue.text = " "
            self.lblRoundLengthvalue.text = " "
            self.lblPreferredTeetimevalue.text = " "
            self.lblLinkGroupvalue.text = " "
            //Modified on 3rd August 2020 V2.3
//            lblPrefferedCource.isHidden = true
//            lblPrefferedCourcevalue.isHidden = true
//            lblNotPreferred.isHidden = true
//            lblNotPrefferedValue.isHidden = true
            self.viewPreferredCourse.isHidden = true
            self.viewNotPreferredCource.isHidden = true
            
            self.lblConfirmedTime.text = String(format: "%@  %@", self.arrEventDetails[0].eventTime ?? "",self.arrEventDetails[0].eventName!)
            lblRoundlength.font = SFont.SourceSansPro_Semibold18
            lblPreferredteetime.font = SFont.SourceSansPro_Semibold18
            for i in 0 ..< appDelegate.arrShareUrlList.count {
                if  appDelegate.arrShareUrlList[i].name == "DiningReservations"{
                    lblUrl.text = String(format: "%@%@/%@", appDelegate.arrShareUrlList[i].url!,arrEventDetails[0].eventID ?? "",arrEventDetails[0].eventCategory ?? "")
                    
                }else{
                    
                }
            }
            self.navigationItem.title = self.appDelegate.masterLabeling.dining_reservation_details

        }//Added on 22nd June 2020 BMS
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Add BMS comparision as fitness & spa and tennis book a lession should work the same way and both are of BMS type.
        //GATHER0000700 - Start
        //Replace fitness & spa with only BMS when possible.
        else if self.appDelegate.typeOfCalendar == "FitnessSpa" || ((isFrom?.caseInsensitiveCompare("FitnessSpa")) == ComparisonResult.orderedSame) || self.arrEventDetails.first?.requestType == .BMS
        {//GATHER0000700 - End
            self.getFitnessAndSpaDetails()
            lblLinkGroup.isHidden = true
            lblLinkGroupvalue.isHidden = true
            self.lblEarlierTeeTimeValue.isHidden = true
           
            self.lblPreferredteetime.isHidden = true
            //Modified on 3rd August 2020 V2.3
//            lblPrefferedCource.isHidden = true
//            lblPrefferedCourcevalue.isHidden = true
//            lblNotPreferred.isHidden = true
//            lblNotPrefferedValue.isHidden = true
            self.viewPreferredCourse.isHidden = true
            self.viewNotPreferredCource.isHidden = true
            
            self.lblRoundlength.isHidden = true
            self.lblEarlierTeeTime.isHidden = true
            self.lblToTime.isHidden = false
            //Used for sync text
            self.lblRoundLengthvalue.text = ""
            self.groupsTableView.estimatedSectionHeaderHeight = 20
            self.lblConfirmedTime.text = String(format: "%@  %@", self.arrEventDetails[0].eventTime ?? "",self.arrEventDetails[0].eventName ?? "")

            lblRoundlength.font = SFont.SFProText_Regular17
            lblPreferredteetime.font = SFont.SFProText_Regular17
            
            for i in 0 ..< appDelegate.arrShareUrlList.count {
               if  appDelegate.arrShareUrlList[i].name == "BMS_FitnessSpa"{
                    lblUrl.text = String(format: "%@%@/%@", appDelegate.arrShareUrlList[i].url!,arrEventDetails[0].eventID ?? "",arrEventDetails[0].eventCategory ?? "")
                    
                }else{
                    
                }
            }
            
            let title = "\(self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "") \(self.appDelegate.masterLabeling.BMS_REQUESTDETAILS ?? "")"
            self.navigationItem.title = title


        }
        else{
            lblLinkGroup.isHidden = false
            lblLinkGroupvalue.isHidden = false
            self.getEventDetailsApi()

            self.lblPreferredTeetimevalue.isHidden = false

            self.lblEarlierTeeTime.text = self.appDelegate.masterLabeling.earliest_tee_time
            self.lblPreferredteetime.text = self.appDelegate.masterLabeling.preferred_tee_time
            self.lblRoundlength.text = self.appDelegate.masterLabeling.round_length
            //commented on 25th June 2020 BMS
            //self.commentsWidth.constant = 230
            self.lblLinkGroup.text = self.appDelegate.masterLabeling.gROUPS_LINK_COLON
           // self.lblLinkGroup.text = "Link Groups regardless of time"
            
            //Modified on 3rd August 2020 V2.3
//            lblPrefferedCource.isHidden = false
//            lblPrefferedCourcevalue.isHidden = false
//            lblNotPreferred.isHidden = false
//            lblNotPrefferedValue.isHidden = false
            self.viewPreferredCourse.isHidden = false
            self.viewNotPreferredCource.isHidden = false
            
            self.lblConfirmedTime.text = String(format: "%@  %@", self.arrEventDetails[0].eventTime ?? "",self.arrEventDetails[0].eventName!)
            lblRoundlength.font = SFont.SFProText_Regular17
            lblPreferredteetime.font = SFont.SFProText_Regular17
            for i in 0 ..< appDelegate.arrShareUrlList.count {
                if(appDelegate.arrShareUrlList[i].name == "GolfReservations"){
                    lblUrl.text = String(format: "%@%@/%@", appDelegate.arrShareUrlList[i].url!,arrEventDetails[0].eventID ?? "",arrEventDetails[0].eventCategory ?? "")
                }else{
                    
                }
            }
            self.navigationItem.title = self.appDelegate.masterLabeling.tee_time_details

        }
        
        //Modified on 26th June 2020 BMS
        var range = NSMakeRange(0, 7)
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Add BMS comparision as fitness & spa and tennis book a lession should work the same way and both are of BMS type.
        //GATHER0000700 - Start
        //Replace fitness & spa with only BMS when possible.
        if self.appDelegate.typeOfCalendar == "FitnessSpa" || ((isFrom?.caseInsensitiveCompare("FitnessSpa")) == ComparisonResult.orderedSame) || self.arrEventDetails.first?.requestType == .BMS
        {//GATHER0000700 - End
            range = NSMakeRange(0, 8)
        }
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.lblConfirmedTime.text!)
        attributeString.addAttribute(NSAttributedStringKey.underlineStyle, value: 1, range: range)
        
        self.lblConfirmedTime.attributedText = attributeString
        
        reminderPicker = UIPickerView()
        reminderPicker?.dataSource = self
        reminderPicker?.delegate = self
        txtAlertDropDown.inputView = reminderPicker
        txtAlertDropDown.delegate = self
        
        self.lblAdditionalEventDetails.text = self.appDelegate.masterLabeling.aDDITIONAL_DETAILS_COLON
        self.lblAlert.text = self.appDelegate.masterLabeling.alert
        txtAlertDropDown.delegate = self
        txtAlertDropDown.setRightIcon(imageName: "Icon_ArrowRightActive")
        
        lblEventName.font = SFont.SFProText_Semibold20
        lblFromTime.font = SFont.SFProText_Regular14
        lblToTime.font = SFont.SFProText_Regular14
        lblEventTitle.font = SFont.SFProText_Regular12
        lblAlert.font = SFont.SFProText_Semibold18
        lblAdditionalEventDetails.font = SFont.SFProText_Semibold18
        
        
        btnAddToCalendar.backgroundColor = .clear
        btnAddToCalendar.layer.cornerRadius = 15
        btnAddToCalendar.layer.borderWidth = 1
        btnAddToCalendar.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        self.btnAddToCalendar.setStyle(style: .outlined, type: .primary)
        
        viewCalendar.layer.cornerRadius = 5
        viewCalendar.layer.borderWidth = 0.1
        viewCalendar.layer.borderColor = hexStringToUIColor(hex: "707070").cgColor
        
       // lblEventName.text = arrEventDetails[0].eventName
        lblEventTitle.text = arrEventDetails[0].eventName
        lblFromTime.text = arrEventDetails[0].eventTime
        lblToTime.text = arrEventDetails[0].eventendtime

        lblMoreinfo.text = self.appDelegate.masterLabeling.moreInfo

        
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
        
        //Added on 3rd August 2020 V2.3
        self.scrollContentView.layoutIfNeeded()
        
        self.lblEventName.textColor = APPColor.textColor.secondary
        
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
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Added comparioson for BMS. beacuse tennis book a leasson and Tennis reservations have same isFrom.
        //GATHER0000700 - Start
        if(self.appDelegate.typeOfCalendar == "Tennis" || ((isFrom?.caseInsensitiveCompare("Tennis")) == ComparisonResult.orderedSame)) && self.arrEventDetails.first?.requestType != .BMS
        {//GATHER0000700 - End
            tableViewHeight.constant = groupsTableView.contentSize.height
            //Commented on 3rd August 2020 V2.3
           // viewHeight.constant =  800 + tableViewHeight.constant
            
        }
        else if(self.appDelegate.typeOfCalendar == "Dining" || ((isFrom?.caseInsensitiveCompare("Dining")) == ComparisonResult.orderedSame))
        {
            tableViewHeight.constant = groupsTableView.contentSize.height + 60
            //Commented on 3rd August 2020 V2.3
            //viewHeight.constant =  800 + tableViewHeight.constant
            
        }
        //Added on 22nd June 2020 BMS
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Add BMS comparision as fitness & spa and tennis book a lession should work the same way and both are of BMS type.
        //GATHER0000700 - Start
        //Replace fitness & spa with only BMS when possible.
        else if self.appDelegate.typeOfCalendar == "FitnessSpa" || ((isFrom?.caseInsensitiveCompare("FitnessSpa")) == ComparisonResult.orderedSame) || self.arrEventDetails.first?.requestType == .BMS
        { //GATHER0000700 - End
            tableViewHeight.constant = groupsTableView.contentSize.height
            //Commented on 3rd August 2020 V2.3
            //viewHeight.constant = 800 + tableViewHeight.constant
            
        }
         else{
            tableViewHeight.constant = groupsTableView.contentSize.height
            //Commented on 3rd August 2020 V2.3
            //viewHeight.constant =  850 + tableViewHeight.constant
            
        }
        
        //Added on 3rd August 2020 V2.3
        self.syncScrollView.contentSize.height = self.scrollContentView.frame.height
        
    }
    @IBAction func addToCalendarClicked(_ sender: Any) {
        partyList.removeAll()
        if self.appDelegate.typeOfCalendar == "Dining" || ((isFrom?.caseInsensitiveCompare("Dining")) == ComparisonResult.orderedSame){
         
            let shareText = String(format: "Additional Details \n \n\nRestaurant Name: %@ \nTime: %@ \nSpecial Request: %@ \nComments: %@ \n \n%@\nMore Info: %@ \n \nCaptain: %@ \n%@\nParty Size (%d)",self.lblRoundLengthvalue.text ?? "",self.lblPreferredTeetimevalue.text ?? "",self.lblEarlierTeeTimeValue.text ?? "",self.lblLinkGroupvalue.text ?? "",self.lblConfirmedTime.text ?? "",lblUrl.text ?? "",captainName ?? "",self.arrTeeTimeDetails[0].confirmationNumber ?? "",self.arrTeeTimeDetails[0].partySize ?? 0)

            
            for i in 0 ..< (arrTeeTimeDetails[0].diningDetails?.count)! {
                if self.arrTeeTimeDetails[0].diningDetails?[i].name == "" {
                    let memberInfo = String(format: "\n%@", (self.arrTeeTimeDetails[0].diningDetails?[i].guestName)!)
                    partyList.append(memberInfo)

                }else{
                    let memberInfo = String(format: "\n%@", (self.arrTeeTimeDetails[0].diningDetails?[i].name)!)
                    partyList.append(memberInfo)
                }
            }
            textToShare = [ shareText,partyList.joined(separator: "")]
        }
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Added comparioson for BMS. beacuse tennis book a leasson and Tennis reservations have same isFrom.
        //GATHER0000700 - Start
        else if (self.appDelegate.typeOfCalendar == "Tennis" || ((isFrom?.caseInsensitiveCompare("Tennis")) == ComparisonResult.orderedSame)) && self.arrEventDetails.first?.requestType != .BMS
        {//GATHER0000700 - End
            let shareText = String(format: "Additional Details \n\nCourt Time: %@ \nDurtion: %@ \nMatch: %@ \n  \n%@\nMore Info: %@\n\nCaptain: %@ \n%@ ", self.lblRoundLengthvalue.text ?? "",self.lblPreferredTeetimevalue.text ?? "",self.lblEarlierTeeTimeValue.text ?? "",self.lblConfirmedTime.text ?? "",lblUrl.text ?? "",captainName ?? "",self.arrTeeTimeDetails[0].confirmationNumber ?? "")


            for i in 0 ..< (arrTeeTimeDetails[0].tennisDetails?.count)! {
                if self.arrTeeTimeDetails[0].tennisDetails?[i].name == "" {
                    let memberInfo = String(format: "\n%@", (self.arrTeeTimeDetails[0].tennisDetails?[i].guestName)!)
                    partyList.append(memberInfo)

                }else{
                    let memberInfo = String(format: "\n%@", (self.arrTeeTimeDetails[0].tennisDetails?[i].name)!)
                    partyList.append(memberInfo)
                }
            }
            textToShare = [ shareText,partyList.joined(separator: "")]

        }//Added on 22nd June 2020 BMS
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Add BMS comparision as fitness & spa and tennis book a lession should work the same way and both are of BMS type.
        //GATHER0000700 - Start
        //Replace fitness & spa with only BMS when possible.
        else if self.appDelegate.typeOfCalendar == "FitnessSpa" || ((isFrom?.caseInsensitiveCompare("FitnessSpa")) == ComparisonResult.orderedSame) || self.arrEventDetails.first?.requestType == .BMS
        {//GATHER0000700 - End
            let shareText = String(format: "Additional Details \n\n%@ \n%@ \n  \n%@\nMore Info: %@\n\n%@      %@", self.lblRoundLengthvalue.text ?? "",self.lblPreferredTeetimevalue.text ?? "",self.lblConfirmedTime.text ?? "",lblUrl.text ?? "",captainName ?? "",self.arrAppointmentDetails[0].confirmationNumber ?? "")


            for i in 1 ..< (self.arrAppointmentDetails[0].details?.count)! {
                if self.arrAppointmentDetails[0].details?[i].name == "" {
                    let memberInfo = String(format: "\n %@", (self.arrAppointmentDetails[0].details?[i].guestName)!)
                    partyList.append(memberInfo)

                }else{
                    let memberInfo = String(format: "\n %@", (self.arrAppointmentDetails[0].details?[i].name)!)
                    partyList.append(memberInfo)
                }
            }
            textToShare = [ shareText,partyList.joined(separator: "")]
        }
        else{
            
            if self.arrTeeTimeDetails[0].groupDetails?.count == 1{
                 shareTextGolf = String(format: "Additional Details \n\nRound Length: %@ \nPreferred Tee Time: %@ \nEarliest Tee Time: %@ \n\n%@ \nMore Info: %@", self.lblRoundLengthvalue.text ?? "",self.lblPreferredTeetimevalue.text ?? "",self.lblEarlierTeeTimeValue.text!,self.lblConfirmedTime.text ?? "",lblUrl.text ?? "")
            }else{
                 shareTextGolf = String(format: "Additional Details \n\nRound Length: %@ \nPreferred Tee Time: %@ \nEarliest Tee Time: %@ \nLink Groups regardless of time?: %@  \n\n%@ \nMore Info: %@", self.lblRoundLengthvalue.text ?? "",self.lblPreferredTeetimevalue.text ?? "",self.lblEarlierTeeTimeValue.text!,self.lblLinkGroupvalue.text ?? "",self.lblConfirmedTime.text ?? "",lblUrl.text ?? "")
            }
           
            let shareText2 =  String(format: "\n\nPreferred Course: %@\nExclude this Course: %@", self.arrTeeTimeDetails[0].preferredCourse ?? "", self.arrTeeTimeDetails[0].excludedCourse ?? "")

            for i in 0 ..< (arrTeeTimeDetails[0].groupDetails?.count)! {

                let memberInfo = String(format: "\n\nCaptain: %@ \n%@ \n%@ \n%@ \n%@ \n%@ ", (self.arrTeeTimeDetails[0].groupDetails?[i].captainName)!,(self.arrTeeTimeDetails[0].groupDetails?[i].group)!,(self.arrTeeTimeDetails[0].groupDetails?[i].confirmationNumber)!, String(format: "%@ %@", self.appDelegate.masterLabeling.course_time_colon ?? "" ,self.arrTeeTimeDetails[0].groupDetails?[i].allocatedCourse ?? ""), String(format: "%@ %@", self.appDelegate.masterLabeling.tee_time_colon ?? "" ,self.arrTeeTimeDetails[0].groupDetails?[i].allocatedTime ?? ""), String(format: "%@ %@", self.appDelegate.masterLabeling.status ?? "" ,self.arrTeeTimeDetails[0].groupDetails?[i].status ?? ""))
               
                partyList.append(memberInfo)
                for j in 0 ..< (arrTeeTimeDetails[0].groupDetails?[i].details?.count)! {
                    if self.arrTeeTimeDetails[0].groupDetails![i].details?[j].name == "" {
                        let groupInfo = String(format: "\n%@", (self.arrTeeTimeDetails[0].groupDetails?[i].details![j].guestName)!)
                        partyList.append(groupInfo)
                    }else{
                        let groupInfo = String(format: "\n%@", (self.arrTeeTimeDetails[0].groupDetails?[i].details![j].name)!)
                        partyList.append(groupInfo)

                    }
                }

            }
            textToShare = [shareTextGolf ?? "",partyList.joined(separator: ""),shareText2]

        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
        startDate = dateFormatter.date(from: String(format: "%@ %@", self.arrEventDetails[0].eventstartdate ?? "",self.arrEventDetails[0].eventTime ?? ""))!
        //Modified on 26th June 2020 BMS
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Add BMS comparision as fitness & spa and tennis book a lession should work the same way and both are of BMS type.
        //GATHER0000700 - Start
        //Replace fitness & spa with only BMS when possible.
        if self.appDelegate.typeOfCalendar == "FitnessSpa" || ((isFrom?.caseInsensitiveCompare("FitnessSpa")) == ComparisonResult.orderedSame) || self.arrEventDetails.first?.requestType == .BMS
        {//GATHER0000700 - End
            endDate = dateFormatter.date(from: String(format: "%@ %@", self.arrEventDetails[0].eventstartdate ?? "",self.arrEventDetails[0].eventendtime ?? ""))!
        }
        else
        {
            endDate = dateFormatter.date(from: String(format: "%@ %@", self.arrEventDetails[0].eventstartdate ?? "",self.arrEventDetails[0].eventTime ?? ""))!

            endDate = endDate.addingTimeInterval(1.0 * 60.0)
        }

        
        if (UserDefaults.standard.string(forKey: UserDefaultsKeys.synchCalendar.rawValue) == "0"){
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: self.appDelegate.masterLabeling.add_TO_DEVICE_CALENDAR, withDuration: Duration.kMediumDuration)
        }
        else{
            if(txtAlertDropDown.text == "5 minutes"){
                timeInterval = -5 * 60
            }else if(txtAlertDropDown.text == "10 minutes"){
                timeInterval = -10 * 60
            }else if(txtAlertDropDown.text == "15 minutes"){
                timeInterval = -15 * 60
            }else if(txtAlertDropDown.text == "30 minutes"){
                timeInterval = -30 * 60
            }else if(txtAlertDropDown.text == "1 hour"){
                timeInterval = -60 * 60
            }else if(txtAlertDropDown.text == "2 hours"){
                timeInterval = -2 * 60 * 60
            }else if(txtAlertDropDown.text == "4 hours"){
                timeInterval = -4 * 60 * 60
            }else if(txtAlertDropDown.text == "8 hours"){
                timeInterval = -8 * 60 * 60
            }else if(txtAlertDropDown.text == "1 day"){
                timeInterval = -24 * 60 * 60
            }else if(txtAlertDropDown.text == "2 days"){
                timeInterval = -2 * 24 * 60 * 60
            }else if(txtAlertDropDown.text == "3 days"){
                timeInterval = -3 * 24 * 60 * 60
            }else if(txtAlertDropDown.text == "4 days"){
                timeInterval = -4 * 24 * 60 * 60
            }else if(txtAlertDropDown.text == "1 week"){
                timeInterval = -7 * 24 * 60 * 60
            }else if(txtAlertDropDown.text == "2 weeks"){
                timeInterval = -14 * 24 * 60 * 60
            }else {
                timeInterval = nil
            }
            let eventStore:EKEventStore = EKEventStore()
            eventStore.requestAccess(to: .event) { (granted, error) in
                if(granted) && (error == nil){
                    
                    let event:EKEvent = EKEvent(eventStore: eventStore)
                    
                    let predicate = eventStore.predicateForEvents(withStart: self.startDate, end: self.endDate,  calendars: nil)
                    
                    let existingEvents = eventStore.events(matching: predicate)
                    if (existingEvents.count == 0){
                        //Modified on 22nd June 2020 BMS
                        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Add BMS comparision as fitness & spa and tennis book a lession should work the same way and both are of BMS type.
                        //GATHER0000700 - Start
                        //Replace fitness & spa with only BMS when possible.
                        event.title = (self.appDelegate.typeOfCalendar == "FitnessSpa" || ((self.isFrom?.caseInsensitiveCompare("FitnessSpa")) == ComparisonResult.orderedSame) || self.arrEventDetails.first?.requestType == .BMS) ? self.arrAppointmentDetails[0].syncCalendarTitle! : self.arrTeeTimeDetails[0].syncCalendarTitle!
                        //GATHER0000700 - End
                        event.startDate = self.startDate
                        event.endDate = self.endDate

                        if self.textToShare.count == 3{
                        event.notes = String(format: "%@ %@ %@", self.textToShare[0],self.textToShare[1],self.textToShare[2])
                        }else{
                            event.notes = String(format: "%@ %@", self.textToShare[0],self.textToShare[1])

                        }
                        event.calendar = eventStore.defaultCalendarForNewEvents
                        
                        if(self.timeInterval == nil){
                            
                        }
                        else{
                            let alarm1hour = EKAlarm(relativeOffset: self.timeInterval)
                            event.addAlarm(alarm1hour)
                        }
                        do {
                            try eventStore.save(event, span: .thisEvent)
                            
                            DispatchQueue.main.async {
                                SharedUtlity.sharedHelper().showToast(on:
                                    self.view, withMeassge: self.appDelegate.masterLabeling.add_TO_DEVICE_CALENDAR, withDuration: Duration.kMediumDuration)
                            }
                        }catch let error as NSError{
                            //print(error.userInfo["NSLocalizedDescription"])
                            DispatchQueue.main.async {
                                SharedUtlity.sharedHelper().showToast(on:
                                    self.view, withMeassge: error.userInfo["NSLocalizedDescription"] as? String, withDuration: Duration.kMediumDuration)
                            }
                        }
                        
                        
                    }
                    else{
                        
                        for singleEvent in existingEvents {
                            
                            //Modified on 22nd June 2020 BMS
                            //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Add BMS comparision as fitness & spa and tennis book a lession should work the same way and both are of BMS type.
                            //GATHER0000700 - Start
                            //Replace fitness & spa with only BMS when possible.
                            let syncCalendarTitle = (self.appDelegate.typeOfCalendar == "FitnessSpa" || ((self.isFrom?.caseInsensitiveCompare("FitnessSpa")) == ComparisonResult.orderedSame) || self.arrEventDetails.first?.requestType == .BMS) ? self.arrAppointmentDetails[0].syncCalendarTitle : self.arrTeeTimeDetails[0].syncCalendarTitle
                            //GATHER0000700 - End
                            if singleEvent.title == syncCalendarTitle && singleEvent.startDate == self.startDate || existingEvents[existingEvents.count - 1].title == syncCalendarTitle && existingEvents[existingEvents.count - 1].startDate == self.startDate {
                                if let calendarEvent_toDelete = eventStore.event(withIdentifier: singleEvent.eventIdentifier){
                                    
                                    do {
                                        
                                        try eventStore.remove(calendarEvent_toDelete, span: .thisEvent)
                                        
                                        event.title = syncCalendarTitle
                                        event.startDate = self.startDate
                                        event.endDate = self.endDate

                                        if self.textToShare.count == 3{
                                            event.notes = String(format: "%@ %@ %@", self.textToShare[0],self.textToShare[1],self.textToShare[2])
                                        }else{
                                            event.notes = String(format: "%@ %@", self.textToShare[0],self.textToShare[1])
                                            
                                        }
                                        event.calendar = eventStore.defaultCalendarForNewEvents
                                        
                                        if(self.timeInterval == nil){
                                            
                                        }
                                        else{
                                            let alarm1hour = EKAlarm(relativeOffset: self.timeInterval)
                                            event.addAlarm(alarm1hour)
                                        }
                                        do {
                                            try eventStore.save(event, span: .thisEvent)
                                        }catch let error as NSError{
                                            print(error)
                                            
                                        }
                                        DispatchQueue.main.async {
                                            SharedUtlity.sharedHelper().showToast(on:
                                                self.view, withMeassge: self.appDelegate.masterLabeling.add_TO_DEVICE_CALENDAR, withDuration: Duration.kMediumDuration)
                                        }
                                        
                                    }catch let error as NSError{
                                        print(error)
                                        
                                    }
                                }
                            }
                            else{
                                //Modified on 22nd June 2020 BMS
                                //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Add BMS comparision as fitness & spa and tennis book a lession should work the same way and both are of BMS type.
                                //GATHER0000700 - Start
                                //Replace fitness & spa with only BMS when possible.
                                let syncCalendarTitle = (self.appDelegate.typeOfCalendar == "FitnessSpa" || ((self.isFrom?.caseInsensitiveCompare("FitnessSpa")) == ComparisonResult.orderedSame) || self.arrEventDetails.first?.requestType == .BMS) ? self.arrAppointmentDetails[0].syncCalendarTitle : self.arrTeeTimeDetails[0].syncCalendarTitle
                                //GATHER0000700 - End
                                event.title = syncCalendarTitle
                                event.startDate = self.startDate
                                event.endDate = self.endDate

                                if self.textToShare.count == 3{
                                    event.notes = String(format: "%@ %@ %@", self.textToShare[0],self.textToShare[1],self.textToShare[2])
                                }else{
                                    event.notes = String(format: "%@ %@", self.textToShare[0],self.textToShare[1])
                                    
                                }
                                event.calendar = eventStore.defaultCalendarForNewEvents
                                
                                if(self.timeInterval == nil){
                                    
                                }
                                else{
                                    let alarm1hour = EKAlarm(relativeOffset: self.timeInterval)
                                    event.addAlarm(alarm1hour)
                                }
                                do {
                                    try eventStore.save(event, span: .thisEvent)
                                }catch let error as NSError{
                                    print(error)
                                    
                                }
                                DispatchQueue.main.async {
                                    SharedUtlity.sharedHelper().showToast(on:
                                        self.view, withMeassge: self.appDelegate.masterLabeling.add_TO_DEVICE_CALENDAR, withDuration: Duration.kMediumDuration)
                                }
                            }
                        }
                    }
                    
                }
                else{
                    print("error \(String(describing: error))")
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Added comparioson for BMS. beacuse tennis book a leasson and Tennis reservations have same isFrom.
        //GATHER0000700 - Start
        if (self.appDelegate.typeOfCalendar == "Tennis" || ((isFrom?.caseInsensitiveCompare("Tennis")) == ComparisonResult.orderedSame)) && self.arrEventDetails.first?.requestType != .BMS
        {//GATHER0000700 - End
            return 1
        }else if(self.appDelegate.typeOfCalendar == "Dining" || ((isFrom?.caseInsensitiveCompare("Dining")) == ComparisonResult.orderedSame)){
            return 1
        }//Added on 22nd JUne 2020 BMS
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Add BMS comparision as fitness & spa and tennis book a lession should work the same way and both are of BMS type.
        //GATHER0000700 - Start
        //Replace fitness & spa with only BMS when possible.
        else if self.appDelegate.typeOfCalendar == "FitnessSpa" || ((isFrom?.caseInsensitiveCompare("FitnessSpa")) == ComparisonResult.orderedSame) || self.arrEventDetails.first?.requestType == .BMS
        {//GATHER0000700 - End
            return 1
            
        }
        else{
            if self.arrTeeTimeDetails.count == 0 {
                return 0
            }
            else{
                return self.arrTeeTimeDetails[0].groupDetails?.count ?? 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        //Added on 22nd June 2020 BMS
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Add BMS comparision as fitness & spa and tennis book a lession should work the same way and both are of BMS type.
        //GATHER0000700 - Start
        //Replace fitness & spa with only BMS when possible.
        if self.appDelegate.typeOfCalendar == "FitnessSpa" || ((isFrom?.caseInsensitiveCompare("FitnessSpa")) == ComparisonResult.orderedSame) || self.arrEventDetails.first?.requestType == .BMS
        {//GATHER0000700 - End
            var count = self.arrAppointmentDetails.first?.details?.count ?? 0
            
            //reducing count because first member is displayed as captain in header
            if count > 0
            {
                count -= 1
            }
            
            return count
        }
        else
        {
            if self.arrTeeTimeDetails.count == 0
            {
                return 0
            }
            else
            {
                //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Added comparioson for BMS. beacuse tennis book a leasson and Tennis reservations have same isFrom.
                //GATHER0000700 - Start
                if (self.appDelegate.typeOfCalendar == "Tennis" || ((isFrom?.caseInsensitiveCompare("Tennis")) == ComparisonResult.orderedSame)) && self.arrEventDetails.first?.requestType != .BMS
                {//GATHER0000700 - End
                    return self.arrTeeTimeDetails[0].tennisDetails?.count ?? 0
                }
                else if(self.appDelegate.typeOfCalendar == "Dining" || ((isFrom?.caseInsensitiveCompare("Dining")) == ComparisonResult.orderedSame))
                {
                    return self.arrTeeTimeDetails[0].diningDetails?.count ?? 0
                }
                else
                {
                    return self.arrTeeTimeDetails[0].groupDetails?[section].details?.count ?? 0
                }
            }
            
        }


    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:playHistoryDetailCustomCell = self.groupsTableView.dequeueReusableCell(withIdentifier: "SynchCellID") as! playHistoryDetailCustomCell
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Added comparioson for BMS. beacuse tennis book a leasson and Tennis reservations have same isFrom.
        //GATHER0000700 - Start
        if(self.appDelegate.typeOfCalendar == "Tennis" || ((isFrom?.caseInsensitiveCompare("Tennis")) == ComparisonResult.orderedSame)) && self.arrEventDetails.first?.requestType != .BMS
        {//GATHER0000700 - End
            if self.arrTeeTimeDetails[0].tennisDetails?[indexPath.row].name == "" {
                cell.lblGroupMemberName.text = self.arrTeeTimeDetails[0].tennisDetails?[indexPath.row].guestName
            }else{
                cell.lblGroupMemberName.text = self.arrTeeTimeDetails[0].tennisDetails?[indexPath.row].name
            }
        }else if(self.appDelegate.typeOfCalendar == "Dining" || ((isFrom?.caseInsensitiveCompare("Dining")) == ComparisonResult.orderedSame)){
            if self.arrTeeTimeDetails[0].diningDetails?[indexPath.row].name == "" {
                cell.lblGroupMemberName.text = self.arrTeeTimeDetails[0].diningDetails?[indexPath.row].guestName
            }else{
                cell.lblGroupMemberName.text = self.arrTeeTimeDetails[0].diningDetails?[indexPath.row].name
            }
            
        }//Added on 22nd June 2020 BMS
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Add BMS comparision as fitness & spa and tennis book a lession should work the same way and both are of BMS type.
        //GATHER0000700 - Start
        //Replace fitness & spa with only BMS when possible.
        else if self.appDelegate.typeOfCalendar == "FitnessSpa" || ((isFrom?.caseInsensitiveCompare("FitnessSpa")) == ComparisonResult.orderedSame) || self.arrEventDetails.first?.requestType == .BMS
        {//GATHER0000700 - End
            if self.arrAppointmentDetails[0].details?[indexPath.row + 1].name == "" {
                    cell.lblGroupMemberName.text = self.arrAppointmentDetails[0].details?[indexPath.row + 1].guestName
                }else{
                    cell.lblGroupMemberName.text = self.arrAppointmentDetails[0].details?[indexPath.row + 1].name
                }
            
        }
        else{
            if self.arrTeeTimeDetails[0].groupDetails![indexPath.section].details?[indexPath.row].name == "" {
                cell.lblGroupMemberName.text = self.arrTeeTimeDetails[0].groupDetails![indexPath.section].details?[indexPath.row].guestName
            }else{
                cell.lblGroupMemberName.text = self.arrTeeTimeDetails[0].groupDetails![indexPath.section].details?[indexPath.row].name
            }
        }
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none

        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HeaderViewEventDetails", owner: self, options: nil)?.first as! HeaderViewEventDetails
        headerView.lblCaptainName.text = self.appDelegate.masterLabeling.captain

        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Added comparioson for BMS. beacuse tennis book a leasson and Tennis reservations have same isFrom.
        //GATHER0000700 - Start
        if(self.appDelegate.typeOfCalendar == "Tennis" || ((isFrom?.caseInsensitiveCompare("Tennis")) == ComparisonResult.orderedSame)) && self.arrEventDetails.first?.requestType != .BMS
        {//GATHER0000700 - End
            if(self.arrTeeTimeDetails.count == 0){
                
            }
            else{
                if self.arrTeeTimeDetails[0].tennisDetails?[0].name == "" {
                    headerView.lblCaptainNameText.text = String(format: " %@", self.arrTeeTimeDetails[0].tennisDetails?[0].guestName ?? "")
                    captainName = String(format: " %@", self.arrTeeTimeDetails[0].tennisDetails?[0].guestName ?? "")
                }else{
                    headerView.lblCaptainNameText.text = String(format: " %@", self.arrTeeTimeDetails[0].tennisDetails?[0].name ?? "")
                    captainName = String(format: " %@", self.arrTeeTimeDetails[0].tennisDetails?[0].name ?? "")

                }
            
            headerView.lblGroup.text = self.arrTeeTimeDetails[0].confirmationNumber
            headerView.lblConfirmationNumber.text = ""
            headerView.lblGroup.textColor = hexStringToUIColor(hex: "695B5E")
            }
        }else if(self.appDelegate.typeOfCalendar == "Dining" || ((isFrom?.caseInsensitiveCompare("Dining")) == ComparisonResult.orderedSame)){
            if(self.arrTeeTimeDetails.count == 0){
                
            }
            else{
            headerView.lblGroup.isHidden = false

            if self.arrTeeTimeDetails[0].diningDetails?[0].name == "" {
                headerView.lblCaptainNameText.text = String(format: " %@", self.arrTeeTimeDetails[0].diningDetails?[0].guestName ?? "")
                captainName = String(format: " %@", self.arrTeeTimeDetails[0].diningDetails?[0].guestName ?? "")

            }else{
                headerView.lblCaptainNameText.text = String(format: " %@", self.arrTeeTimeDetails[0].diningDetails?[0].name ?? "")
                captainName = String(format: " %@", self.arrTeeTimeDetails[0].diningDetails?[0].name ?? "")

            }
            headerView.lblConfirmationNumber.text = self.arrTeeTimeDetails[0].confirmationNumber
            headerView.lblGroup.text = String(format: "%@ (%d)",self.appDelegate.masterLabeling.party_size ?? "", self.arrTeeTimeDetails[0].partySize!)
            headerView.lblGroup.textColor = hexStringToUIColor(hex: "EB7A49")
           
                
            }
            headerView.lblGroup.textColor = APPColor.textColor.secondary
        }//Added on 22nd June 2020 BMS
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Add BMS comparision as fitness & spa and tennis book a lession should work the same way and both are of BMS type.
        //GATHER0000700 - Start
        //Replace fitness & spa with only BMS when possible.
        else if self.appDelegate.typeOfCalendar == "FitnessSpa" || ((isFrom?.caseInsensitiveCompare("FitnessSpa")) == ComparisonResult.orderedSame) || self.arrEventDetails.first?.requestType == .BMS
        {//GATHER0000700 - End
            let BMSHeaderView = Bundle.main.loadNibNamed("BMSHeaderCalendarViewSyncTVC", owner: self, options: nil)?.first as! BMSHeaderCalendarViewSyncTVC
            if(self.arrAppointmentDetails.count == 0){
                
            }
            else
            {
                if self.arrAppointmentDetails[0].details?[0].name == ""
                {
                    BMSHeaderView.lblName.text = String(format: " %@", self.arrAppointmentDetails[0].details?[0].guestName ?? "")
                    captainName = String(format: " %@", self.arrAppointmentDetails[0].details?[0].guestName ?? "")
                }
                else
                {
                    BMSHeaderView.lblName.text = String(format: " %@", self.arrAppointmentDetails[0].details?[0].name ?? "")
                    captainName = String(format: " %@", self.arrAppointmentDetails[0].details?[0].name ?? "")

                }
                
                BMSHeaderView.lblConfirmationNumber.text = self.arrAppointmentDetails[0].confirmationNumber
            }
            
            return BMSHeaderView.contentView
        }
        else{
            headerView.lblGroup.isHidden = false
            if  self.arrTeeTimeDetails[0].groupDetails?[section].details?[0].name  == "" {
                headerView.lblCaptainNameText.text =  String(format: " %@", self.arrTeeTimeDetails[0].groupDetails?[section].details?[0].guestName ?? "")
                captainName = String(format: " %@", self.arrTeeTimeDetails[0].groupDetails?[section].details?[0].guestName ?? "")

            }else{
                headerView.lblCaptainNameText.text = String(format: " %@", self.arrTeeTimeDetails[0].groupDetails?[section].details?[0].name ?? "")
                captainName = String(format: " %@", self.arrTeeTimeDetails[0].groupDetails?[section].details?[0].name ?? "")

            }
          

            headerView.lblGroup.text = self.arrTeeTimeDetails[0].groupDetails?[section].group ?? ""
            headerView.lblConfirmationNumber.text = self.arrTeeTimeDetails[0].groupDetails?[section].confirmationNumber
            headerView.lblGroup.textColor = hexStringToUIColor(hex: "EB7A49")
            
            headerView.lblStatusText.isHidden = false
            headerView.lblCourse.isHidden = false
            headerView.lblTeeTime.isHidden = false
            headerView.btnStatus.isHidden = false
            
            headerView.btnStatus.layer.cornerRadius = 13
            headerView.lblCourse.text = String(format: "%@ %@", self.appDelegate.masterLabeling.course_time_colon ?? "" ,self.arrTeeTimeDetails[0].groupDetails?[section].allocatedCourse ?? "")
            headerView.lblTeeTime.text = String(format: "%@ %@", self.appDelegate.masterLabeling.tee_time_colon ?? "" ,self.arrTeeTimeDetails[0].groupDetails?[section].allocatedTime ?? "")
            headerView.lblStatusText.text = self.appDelegate.masterLabeling.status
            headerView.btnStatus.backgroundColor = hexStringToUIColor(hex: self.arrTeeTimeDetails[0].groupDetails?[section].color ?? "")
            headerView.btnStatus.setTitle(self.arrTeeTimeDetails[0].groupDetails?[section].status ?? "", for: UIControlState.normal)
            headerView.lblGroup.textColor = APPColor.textColor.secondary
        }
     
        return headerView
        
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Added comparioson for BMS. beacuse tennis book a leasson and Tennis reservations have same isFrom.
        //GATHER0000700 - Start
       if((self.appDelegate.typeOfCalendar == "Tennis" || ((isFrom?.caseInsensitiveCompare("Tennis")) == ComparisonResult.orderedSame)) && self.arrEventDetails.first?.requestType != .BMS) || (self.appDelegate.typeOfCalendar == "Dining" || ((isFrom?.caseInsensitiveCompare("Dining")) == ComparisonResult.orderedSame))
       {//GATHER0000700 - End
        return 83
       }//Added on 22nd JUne 2020 BMS
       //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Add BMS comparision as fitness & spa and tennis book a lession should work the same way and both are of BMS type.
       //GATHER0000700 - Start
       //Replace fitness & spa with only BMS when possible.
       else if self.appDelegate.typeOfCalendar == "FitnessSpa" || ((isFrom?.caseInsensitiveCompare("FitnessSpa")) == ComparisonResult.orderedSame) || self.arrEventDetails.first?.requestType == .BMS
       {//GATHER0000700 - End
         return UITableViewAutomaticDimension
       }
       else{
            return 168
        }
    }
    
    
    //Mark- Get Golf Event Details Api
    func getEventDetailsApi() {
        
        if (Network.reachability?.isReachable) == true{
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "IsAdmin": "1",
                APIKeys.kusername: UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                "Role": "Admin",
                "RequestID": requestID ?? "",
                "EventRegistrationDetailID": eventRegistrationDetailID ?? ""
            ]
            
            APIHandler.sharedInstance.getRequestTeeTimeDetails(paramaterDict: paramaterDict, onSuccess: { response in
                self.appDelegate.hideIndicator()
                
                if(response.responseCode == InternetMessge.kSuccess)
                {
                    if(response.requestTeeTimeDetails == nil){
                        self.arrTeeTimeDetails.removeAll()
                        self.groupsTableView.setEmptyMessage(InternetMessge.kNoData)
                        self.groupsTableView.reloadData()
                    }
                    else{
                        
                        if(response.requestTeeTimeDetails?.count == 0)
                        {
                            self.arrTeeTimeDetails.removeAll()
                            self.groupsTableView.setEmptyMessage(InternetMessge.kNoData)
                            self.groupsTableView.reloadData()
                            
                        }else{
                            self.groupsTableView.restore()
                            self.arrTeeTimeDetails = response.requestTeeTimeDetails! //eventList.listevents!
                            self.groupsTableView.reloadData()
                            
                            self.lblEventName.text = self.arrTeeTimeDetails[0].syncCalendarTitle ?? " "
                            self.lblPrefferedCourcevalue.text = self.arrTeeTimeDetails[0].preferredCourse ?? ""
                            self.lblNotPrefferedValue.text = self.arrTeeTimeDetails[0].excludedCourse ?? ""
                            self.lblEarlierTeeTimeValue.text = self.arrTeeTimeDetails[0].earliest ?? ""
                            self.lblPreferredTeetimevalue.text = self.arrTeeTimeDetails[0].reservationRequestTime ?? ""
                            self.lblRoundLengthvalue.text = "\(self.arrTeeTimeDetails[0].gameTypeTitle ?? "")"
                            //Commented on 25th June 2020 BMS
                            //self.commentsWidth.constant = 230
                            self.lblLinkGroup.text = self.appDelegate.masterLabeling.gROUPS_LINK_COLON
                            if(self.arrTeeTimeDetails[0].reservationRequestTime == ""){
                                self.lblConfirmedTime.text = self.arrEventDetails[0].eventName!
                            }
                            else{
                            self.lblConfirmedTime.text = String(format: "%@   %@", self.arrTeeTimeDetails[0].reservationRequestTime ?? "",self.arrEventDetails[0].eventName!)
 
                            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.lblConfirmedTime.text!)
                            attributeString.addAttribute(NSAttributedStringKey.underlineStyle, value: 1, range: NSMakeRange(0, 7))
                            
                            self.lblConfirmedTime.attributedText = attributeString
                            }
                            if self.arrTeeTimeDetails[0].groupDetails?.count == 1{
                            self.lblLinkGroup.isHidden = true
                            self.lblLinkGroupvalue.isHidden = true

                            }
                            else{
                                if(self.arrTeeTimeDetails[0].linkGroup == "0"){
                                    self.lblLinkGroupvalue.text = "No"
                                }
                                else{
                                    self.lblLinkGroupvalue.text = "Yes"
                                }
                            }
                        }
                    }
                    
                
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((response.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: response.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.groupsTableView.setEmptyMessage(response.responseMessage ?? "")
                    
                }
                
                self.appDelegate.hideIndicator()
                
            },onFailure: { error  in
                
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
            
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            //  self.tableViewHeroes.setEmptyMessage(InternetMessge.kInternet_not_available)
            
        }
        
    }
    
    
    //Mark- Get Court Event Details Api
    func getTennisEventDetailsApi() {
        
        if (Network.reachability?.isReachable) == true{
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "IsAdmin": "1",
                APIKeys.kusername: UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                "Role": "Admin",
                "RequestID": requestID ?? "",
                "EventRegistrationDetailID": eventRegistrationDetailID ?? ""

            ]
            
            APIHandler.sharedInstance.getRequestTennisDetails(paramaterDict: paramaterDict, onSuccess: { response in
                self.appDelegate.hideIndicator()
                
                if(response.responseCode == InternetMessge.kSuccess)
                {
                    if(response.requestTennisDetails == nil){
                        self.arrTeeTimeDetails.removeAll()
                        self.groupsTableView.setEmptyMessage(InternetMessge.kNoData)
                        self.groupsTableView.reloadData()
                    }
                    else{
                        
                        if(response.requestTennisDetails?.count == 0)
                        {
                            self.arrTeeTimeDetails.removeAll()
                            self.groupsTableView.setEmptyMessage(InternetMessge.kNoData)
                            self.groupsTableView.reloadData()
                            
                            
                        }else{
                            self.groupsTableView.restore()
                            self.arrTeeTimeDetails = response.requestTennisDetails! //eventList.listevents!
                            self.groupsTableView.reloadData()
                            self.lblEventName.text = self.arrTeeTimeDetails[0].syncCalendarTitle ?? " "
                            self.lblEarlierTeeTimeValue.text = self.arrTeeTimeDetails[0].playType ?? ""
                            self.lblPreferredTeetimevalue.text = self.arrTeeTimeDetails[0].durationText ?? ""
                            self.lblRoundLengthvalue.text = self.arrTeeTimeDetails[0].reservationRequestTime
                            self.lblConfirmedTime.text = String(format: "%@  %@", self.arrTeeTimeDetails[0].reservationRequestTime ?? "",self.arrEventDetails[0].eventName!)
                            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.lblConfirmedTime.text!)
                            attributeString.addAttribute(NSAttributedStringKey.underlineStyle, value: 1, range: NSMakeRange(0, 7))
                            
                            self.lblConfirmedTime.attributedText = attributeString
                        }
                        
                    }
                    
                    if(!(self.arrTeeTimeDetails.count == 0)){
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.groupsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((response.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: response.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.groupsTableView.setEmptyMessage(response.responseMessage ?? "")
                    
                }
                
                self.appDelegate.hideIndicator()
                
            },onFailure: { error  in
                
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
            
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            //  self.tableViewHeroes.setEmptyMessage(InternetMessge.kInternet_not_available)
            
        }
        
    }
    
    
    //Mark- Get Dining Event Details Api
    func getDiningEventDetailsApi() {
        
        if (Network.reachability?.isReachable) == true{
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "IsAdmin": "1",
                APIKeys.kusername: UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                "Role": "Admin",
                "RequestID": requestID ?? "",
                "EventRegistrationDetailID": eventRegistrationDetailID ?? ""

            ]
            
            APIHandler.sharedInstance.getRequestDiningDetails(paramaterDict: paramaterDict, onSuccess: { response in
                self.appDelegate.hideIndicator()
                
                if(response.responseCode == InternetMessge.kSuccess)
                {
                    if(response.requestDiningDetails == nil){
                        self.arrTeeTimeDetails.removeAll()
                        self.groupsTableView.setEmptyMessage(InternetMessge.kNoData)
                        self.groupsTableView.reloadData()
                    }
                    else{
                        
                        if(response.requestDiningDetails?.count == 0)
                        {
                            self.arrTeeTimeDetails.removeAll()
                            self.groupsTableView.setEmptyMessage(InternetMessge.kNoData)
                            self.groupsTableView.reloadData()
                            
                            
                        }else{
                            self.groupsTableView.restore()
                            self.arrTeeTimeDetails = response.requestDiningDetails! //eventList.listevents!
                            self.groupsTableView.reloadData()
                            self.lblEventName.text = self.arrTeeTimeDetails[0].syncCalendarTitle ?? " "
                            self.lblEarlierTeeTimeValue.text = self.arrTeeTimeDetails[0].comments ?? ""

                            self.lblEarlierTeeTimeValue.text = self.arrTeeTimeDetails[0].tablePreferenceName ?? ""
                            self.lblPreferredTeetimevalue.text = self.arrTeeTimeDetails[0].reservationRequestTime ?? ""
                            self.lblRoundLengthvalue.text = self.arrTeeTimeDetails[0].location ?? ""
                            self.lblLinkGroupvalue.text = self.arrTeeTimeDetails[0].comments ?? ""
                            if self.lblLinkGroupvalue.text == "" {
                                self.lblLinkGroupvalue.text = " "
                            }
                            self.lblConfirmedTime.text = String(format: "%@  %@", self.arrTeeTimeDetails[0].reservationRequestTime ?? "",self.arrEventDetails[0].eventName!)
                            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.lblConfirmedTime.text!)
                            attributeString.addAttribute(NSAttributedStringKey.underlineStyle, value: 1, range: NSMakeRange(0, 7))
                            
                            self.lblConfirmedTime.attributedText = attributeString
                            
                            //Added on 4th September 2020 V2.3
                            self.scrollContentView.layoutIfNeeded()
                        }
                        
                    }
                    
                    if(!(self.arrTeeTimeDetails.count == 0)){
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.groupsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((response.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: response.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.groupsTableView.setEmptyMessage(response.responseMessage ?? "")
                    
                }
                
                self.appDelegate.hideIndicator()
                
            },onFailure: { error  in
                
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
            
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            //  self.tableViewHeroes.setEmptyMessage(InternetMessge.kInternet_not_available)
            
        }
        
    }
    
    //Added on 22nd June 2020 BMS
    private func getFitnessAndSpaDetails()
    {
        guard Network.reachability?.isReachable == true else {
            SharedUtlity.sharedHelper().showToast(on:
            self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            return
        }
        
        let paramaterDict : [String : Any] = [
        APIHeader.kContentType : "application/json",
        APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
        APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
        APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
        APIKeys.kdeviceInfo: [APIHandler.devicedict],
        APIKeys.kAppointmentID : self.arrEventDetails[0].eventID!]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        APIHandler.sharedInstance.getAppointment(paramater: paramaterDict, onSuccess: { (appointment) in
            self.appDelegate.hideIndicator()
            
            if(appointment.appointmentDetails == nil){
                self.arrAppointmentDetails.removeAll()
                self.groupsTableView.setEmptyMessage(InternetMessge.kNoData)
                self.groupsTableView.reloadData()
            }
            else{
                
                if(appointment.appointmentDetails?.count == 0)
                {
                    self.arrAppointmentDetails.removeAll()
                    self.groupsTableView.setEmptyMessage(InternetMessge.kNoData)
                    self.groupsTableView.reloadData()
                    
                    
                }else{
                    self.groupsTableView.restore()
                    self.arrAppointmentDetails = appointment.appointmentDetails!
                    self.groupsTableView.reloadData()
                    self.lblEventName.text = self.arrAppointmentDetails[0].syncCalendarTitle ?? " "
                    //self.lblEarlierTeeTimeValue.text = self.arrAppointmentDetails[0].comments ?? ""

                    self.lblRoundLengthvalue.text = self.arrAppointmentDetails.first?.syncText
                    
                    //Commnets
                    let comments = " \(self.arrAppointmentDetails[0].comments ?? "")"
                    
                    let font = UIFont.init(name: "SourceSansPro-Regular", size: 17.0)!

                    //Added by kiran V2.8 -- GATHER0001149
                    //GATHER0001149 -- Start
                    var commentsHeaderText : String = self.appDelegate.masterLabeling.cOMMENTS_COLON ?? ""
                    if self.arrEventDetails.first?.requestType == .BMS
                    {
                        
                        switch CustomFunctions.shared.BMSDepartmentType(departmentType: self.arrEventDetails.first?.departmentType)
                        {
                        case .fitnessAndSpa:
                            
                            if let departmentName = appointment.appointmentDetails?.first?.departmentName
                            {
                                if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Fitness!) == .orderedSame
                                {
                                    commentsHeaderText = self.appDelegate.masterLabeling.BMS_Fitness_Comments_Colon ?? ""
                                }
                                else if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Spa!) == .orderedSame
                                {
                                    commentsHeaderText = self.appDelegate.masterLabeling.BMS_Spa_Comments_Colon ?? ""
                                }
                                else if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Salon!) == .orderedSame
                                {
                                    commentsHeaderText = self.appDelegate.masterLabeling.BMS_Salon_Comments_Colon ?? ""
                                }
                                
                            }
                            
                        case .tennisBookALesson:
                            commentsHeaderText = self.appDelegate.masterLabeling.BMS_Tennis_Comments_Colon ?? ""
                            //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL Comments text
                            //GATHER0001167 -- Start
                        case .golfBookALesson:
                            commentsHeaderText = self.appDelegate.masterLabeling.BMS_Golf_Comments_Colon ?? ""
                            //GATHER0001167 -- End
                        case .none:
                            break
                        }
                        
                    }
                    
                    let attributedComments = NSMutableAttributedString.init(string: commentsHeaderText, attributes: [NSAttributedStringKey.font : font])
                    //let attributedComments = NSMutableAttributedString.init(string: self.appDelegate.masterLabeling.cOMMENTS_COLON ?? "", attributes: [NSAttributedStringKey.font : font])
                    //GATHER0001149 -- End
                    attributedComments.append(NSAttributedString.init(string: comments))
                    self.lblPreferredTeetimevalue.attributedText =  attributedComments
                    
                    if self.lblLinkGroupvalue.text == "" {
                        self.lblLinkGroupvalue.text = " "
                    }
                    
                    self.lblConfirmedTime.text = String(format: "%@  %@", self.arrAppointmentDetails[0].appointmentTime ?? "" ,self.arrEventDetails[0].eventName!)
                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.lblConfirmedTime.text!)
                    attributeString.addAttribute(NSAttributedStringKey.underlineStyle, value: 1, range: NSMakeRange(0, 7))
                    
                    self.lblConfirmedTime.attributedText = attributeString
                    
                }
                
            }
            
            if(!(self.arrAppointmentDetails.count == 0)){
                //let indexPath = IndexPath(row: 0, section: 0)
                //self.groupsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }

            
            
        }) { (error) in
            self.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper().showToast(on:
            self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
        }

    }
    
}

extension GolfSyncCalendarVC : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return appDelegate.arrReminderTime.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return appDelegate.arrReminderTime[row].name
    }
}

extension GolfSyncCalendarVC : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRemainder = appDelegate.arrReminderTime[row]
        txtAlertDropDown.text = selectedRemainder?.name
    }
}
