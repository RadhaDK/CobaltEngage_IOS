//
//  GolfShareVC.swift
//  CSSI
//
//  Created by apple on 4/25/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class GolfShareVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var commentsWidth: NSLayoutConstraint!
    @IBOutlet weak var lblPreferresCourse: UILabel!
    @IBOutlet weak var lblPreferredCourseValue: UILabel!
    @IBOutlet weak var lblNPC: UILabel!
    @IBOutlet weak var lblNPCValue: UILabel!
    @IBOutlet weak var lblEventTtle: UILabel!
    @IBOutlet weak var lblRoundLength: UILabel!
    @IBOutlet weak var lblRoundLengthValue: UILabel!
    @IBOutlet weak var lblPreferredTeetime: UILabel!
    @IBOutlet weak var lblPreferredTeetimeValue: UILabel!
    @IBOutlet weak var lblEarliestTeeTime: UILabel!
    @IBOutlet weak var lblEarliestTeetimeValue: UILabel!
    @IBOutlet weak var lblLinkGroups: UILabel!
    @IBOutlet weak var lblLinkGroupsValue: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var groupsTableView: UITableView!
    //@IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    //Added on 26th June 2020 BMS
     @IBOutlet weak var viewPreferredCourse: UIView!
    
    //Added on 3rd August 2020 V2.3
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var shareScrollView: UIScrollView!
    
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    var arrEventDetails = [ListEvents]()
    var arrTeeTimeDetails = [RequestTeeTimeDetail]()
    var requestID : String?
    var partyList = [String]()
    var isFrom: String?
    var shareTextGolf: String?
    var eventRegistrationDetailID : String?
    
    //Added on 26th June 2020 BMS
    var arrAppointmentDetails = [Appointment]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if arrTeeTimeDetails.count == 0{
            btnShare.isEnabled = true
        }else{
            btnShare.isEnabled = false
        }
        
        btnShare.backgroundColor = .clear
        btnShare.layer.cornerRadius = 15
        btnShare.layer.borderWidth = 1
        btnShare.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        self.btnShare.setStyle(style: .outlined, type: .primary)

        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Added comparioson for BMS. beacuse tennis book a leasson and Tennis reservations have same isFrom.
        //GATHER0000700 - Start
        if(self.appDelegate.typeOfCalendar == "Tennis" || ((isFrom?.caseInsensitiveCompare("Tennis")) == ComparisonResult.orderedSame)) && self.arrEventDetails.first?.requestType != .BMS
        {//GATHER0000700 - End
           
            self.getTennisEventDetailsApi()
            self.lblEarliestTeeTime.text = self.appDelegate.masterLabeling.match_colon
            self.lblPreferredTeetime.text = self.appDelegate.masterLabeling.duration_colon
            self.lblRoundLength.text = self.appDelegate.masterLabeling.court_time
            
            lblEventTtle.font = SFont.SFProText_Semibold20

            self.lblRoundLengthValue.text = ""
            self.lblLinkGroups.text = ""
            self.lblLinkGroupsValue.text = ""
            lblRoundLength.font = SFont.SFProText_Regular17
            lblPreferredTeetime.font = SFont.SFProText_Regular17
            
            //Added on 26th June 2020 BMS
            self.viewPreferredCourse.isHidden = true
            
            lblPreferresCourse.isHidden = true
            lblPreferredCourseValue.isHidden = true
            lblNPC.isHidden = true
            lblNPCValue.isHidden = true
            
            self.navigationItem.title = self.appDelegate.masterLabeling.tennis_calendar
            
        }
        else if(self.appDelegate.typeOfCalendar == "Dining") || ((isFrom?.caseInsensitiveCompare("Dining")) == ComparisonResult.orderedSame){
            
            self.getDiningEventDetailsApi()
            self.commentsWidth.constant = 86
            self.lblEarliestTeeTime.text = ""
            self.lblEarliestTeetimeValue.text = ""

            self.lblPreferredTeetime.text = self.appDelegate.masterLabeling.tT_RESTAURANTS
            self.lblPreferredTeetimeValue.text = " "

            self.lblRoundLength.text = ""
            self.lblRoundLengthValue.text = ""

            self.lblLinkGroups.text = self.appDelegate.masterLabeling.time_colon
            self.lblLinkGroupsValue.text = " "
            lblEventTtle.font = SFont.SFProText_Semibold20
            //Added on 26th June 2020 BMS
            self.viewPreferredCourse.isHidden = true
            
            lblPreferresCourse.isHidden = true
            lblPreferredCourseValue.isHidden = true
            lblNPC.isHidden = true
            lblNPCValue.isHidden = true

           
            lblRoundLength.font = SFont.SourceSansPro_Semibold18
            lblPreferredTeetime.font = SFont.SourceSansPro_Semibold18
            self.navigationItem.title = self.appDelegate.masterLabeling.dining_calendar
            
        }//Added on 22nd June 2020 BMS
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Add BMS comparision as fitness & spa and tennis book a lession should work the same way and both are of BMS type.
        //GATHER0000700 - Start
        //Replace fitness & spa with only BMS when possible.
        else if self.appDelegate.typeOfCalendar == "FitnessSpa" || ((isFrom?.caseInsensitiveCompare("FitnessSpa")) == ComparisonResult.orderedSame) || self.arrEventDetails.first?.requestType == .BMS
        {//GATHER0000700 - End
            self.groupsTableView.estimatedSectionHeaderHeight = 20
            self.getFitnessAndSpaDetails()
            self.lblPreferredTeetimeValue.text = ""
            self.lblRoundLengthValue.text = ""
            
            lblEventTtle.font = SFont.SFProText_Semibold20
            self.lblPreferredTeetime.isHidden = true
            self.lblRoundLength.isHidden = true
            self.lblLinkGroups.isHidden = true
            self.lblLinkGroupsValue.isHidden = true
            lblRoundLength.font = SFont.SFProText_Regular17
            lblPreferredTeetime.font = SFont.SFProText_Regular17

            self.viewPreferredCourse.isHidden = true
            
            lblPreferresCourse.isHidden = true
            lblPreferredCourseValue.isHidden = true
            lblNPC.isHidden = true
            lblNPCValue.isHidden = true
            
            let title = "\(self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "") \(self.appDelegate.masterLabeling.BMS_CALENDAR ?? "")"
            self.navigationItem.title = title
        }
        else
        {
            
            
            self.getEventDetailsApi()
            
            self.lblPreferredTeetime.text = self.appDelegate.masterLabeling.preferred_tee_time
            self.lblEarliestTeeTime.text = self.appDelegate.masterLabeling.earliest_tee_time
            self.lblLinkGroups.text = self.appDelegate.masterLabeling.gROUPS_LINK_COLON
            self.lblRoundLength.text = self.appDelegate.masterLabeling.round_length
            self.commentsWidth.constant = 230
            lblEventTtle.font = SFont.SFProText_Semibold20
            
            //Added on 26th June 2020 BMS
            self.viewPreferredCourse.isHidden = false
            
            lblPreferresCourse.isHidden = false
            lblPreferredCourseValue.isHidden = false
            lblNPC.isHidden = false
            lblNPCValue.isHidden = false
            
            self.lblNPC.text = self.appDelegate.masterLabeling.eXCLUDE_COURSE_COLON
            self.lblPreferresCourse.text = self.appDelegate.masterLabeling.preferred_course_colon
          
            self.navigationItem.title = self.appDelegate.masterLabeling.golf_calendar
            
        }
        
        self.lblEventTtle.textColor = APPColor.textColor.secondary
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableViewHeight.constant = groupsTableView.contentSize.height + 20
        //Modified on 3rd August 2020 V2.3
        //viewHeight.constant =  470 + tableViewHeight.constant
        self.shareScrollView.contentSize.height = self.scrollContentView.frame.height
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
       // self.navigationItem.title = self.appDelegate.masterLabeling.golf_calendar
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
        
        //Added by Kiran V2.7 -- GATHER0000767 -- Added home button
        //GATHER0000767 -- Start
        self.navigationItem.rightBarButtonItem = self.navHomeBtnItem(target: self, action: #selector(self.homeBtnAction(sender:)))
        //GATHER0000767 -- End
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //Added by Kiran V2.7 -- GATHER0000767 -- Added home button
    //GATHER0000767 -- Start
    @objc private func homeBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    //GATHER0000767 -- End
    
    @IBAction func shareClicked(_ sender: Any) {
        partyList.removeAll()
    if(self.appDelegate.typeOfCalendar == "Dining") || ((isFrom?.caseInsensitiveCompare("Dining")) == ComparisonResult.orderedSame){

        let shareText = String(format: "%@ \n\nRestaurant Name: %@ \nTime: %@ \nSpecial Request: %@ \nComments: %@ \n\nCaptain: %@ \n%@\nParty Size (%d)",self.arrTeeTimeDetails[0].syncCalendarTitle!, self.lblRoundLengthValue.text!,self.lblPreferredTeetimeValue.text!,self.lblEarliestTeetimeValue.text!,self.lblLinkGroupsValue.text!,(self.arrTeeTimeDetails[0].diningDetails?[0].name)!,self.arrTeeTimeDetails[0].confirmationNumber!,self.arrTeeTimeDetails[0].partySize ?? 1)
        

        for i in 0 ..< (arrTeeTimeDetails[0].diningDetails?.count)! {
            if self.arrTeeTimeDetails[0].diningDetails?[i].name == "" {
                let memberInfo = String(format: "\n%@", (self.arrTeeTimeDetails[0].diningDetails?[i].guestName)!)
                partyList.append(memberInfo)

            }else{
                let memberInfo = String(format: "\n%@", (self.arrTeeTimeDetails[0].diningDetails?[i].name)!)
                partyList.append(memberInfo)
            }
        }
            var textToShare = [ shareText,partyList.joined(separator: "")] as [Any]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
             textToShare.removeAll()
            self.present(activityViewController, animated: true, completion: nil)
        }
    //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Added comparioson for BMS. beacuse tennis book a leasson and Tennis reservations have same isFrom.
    //GATHER0000700 - Start
    else if (self.appDelegate.typeOfCalendar == "Tennis" || ((isFrom?.caseInsensitiveCompare("Tennis")) == ComparisonResult.orderedSame)) && self.arrEventDetails.first?.requestType != .BMS
    {//GATHER0000700 - End
            let shareText = String(format: "%@\n\nCourt Time: %@ \nDurtion: %@ \nMatch: %@ \n\nCaptain: %@ \n%@",self.arrTeeTimeDetails[0].syncCalendarTitle!, self.lblRoundLengthValue.text!,self.lblPreferredTeetimeValue.text!,self.lblEarliestTeetimeValue.text!,(self.arrTeeTimeDetails[0].tennisDetails?[0].name)!,self.arrTeeTimeDetails[0].confirmationNumber!)
            
            
            for i in 0 ..< (arrTeeTimeDetails[0].tennisDetails?.count)! {
                if self.arrTeeTimeDetails[0].tennisDetails?[i].name == "" {
                    let memberInfo = String(format: "\n%@", (self.arrTeeTimeDetails[0].tennisDetails?[i].guestName)!)
                    partyList.append(memberInfo)
                    
                }else{
                    let memberInfo = String(format: "\n%@", (self.arrTeeTimeDetails[0].tennisDetails?[i].name)!)
                    partyList.append(memberInfo)
                }
            }
            var textToShare = [ shareText,partyList.joined(separator: "")] as [Any]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
             textToShare.removeAll()
            self.present(activityViewController, animated: true, completion: nil)
        }//Added on 22nd June 2020 BMS
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Add BMS comparision as fitness & spa and tennis book a lession should work the same way and both are of BMS type.
        //GATHER0000700 - Start
        //Replace fitness & spa with only BMS when possible.
        else if self.appDelegate.typeOfCalendar == "FitnessSpa" || ((isFrom?.caseInsensitiveCompare("FitnessSpa")) == ComparisonResult.orderedSame) || self.arrEventDetails.first?.requestType == .BMS
        {//GATHER0000700 - End
            //Modified on 7th August 2020 V2.3
            //Added captain name assigning to fix issue with shairng guest name
            var captainName = ""
            
            if (self.arrAppointmentDetails.first?.details?.first?.name?.count ?? 0) > 0
            {
                captainName = (self.arrAppointmentDetails.first?.details?.first?.name)!
            }
            else
            {
                captainName = (self.arrAppointmentDetails.first?.details?.first?.guestName)!
            }
            
            let shareText = String(format: "%@\n\n%@ \n%@ \n\n%@      %@",self.arrAppointmentDetails[0].syncCalendarTitle!, self.lblRoundLengthValue.text!,self.lblPreferredTeetimeValue.text!,captainName,self.arrAppointmentDetails[0].confirmationNumber!)
            
            
            for i in 1 ..< (arrAppointmentDetails[0].details?.count)! {
                if self.arrAppointmentDetails[0].details?[i].name == "" {
                    let memberInfo = String(format: "\n%@", (self.arrAppointmentDetails[0].details?[i].guestName)!)
                    partyList.append(memberInfo)
                    
                }else{
                    let memberInfo = String(format: "\n%@", (self.arrAppointmentDetails[0].details?[i].name)!)
                    partyList.append(memberInfo)
                }
            }
            
            var textToShare = [shareText,partyList.joined(separator: "")] as [Any]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
             textToShare.removeAll()
            self.present(activityViewController, animated: true, completion: nil)
        }
        else{
            if self.arrTeeTimeDetails[0].groupDetails?.count == 1{
                shareTextGolf = String(format: "%@\n\nRound Length: %@ \nPreferred Tee Time: %@ \nEarliest Tee Time: %@",self.arrTeeTimeDetails[0].syncCalendarTitle!, self.lblRoundLengthValue.text ?? "",self.lblPreferredTeetimeValue.text ?? "",self.lblEarliestTeetimeValue.text ?? "")
            }else{
                shareTextGolf = String(format: "%@\n\nRound Length: %@ \nPreferred Tee Time: %@ \nEarliest Tee Time: %@ \nLink Groups regardless of time?: %@",self.arrTeeTimeDetails[0].syncCalendarTitle!, self.lblRoundLengthValue.text!,self.lblPreferredTeetimeValue.text!,self.lblEarliestTeetimeValue.text!,self.lblLinkGroupsValue.text!)
            }
            
            
            let shareText2 =  String(format: "\n\nPreferred Course: %@\nExclude this Course: %@", self.arrTeeTimeDetails[0].preferredCourse ?? "", self.arrTeeTimeDetails[0].excludedCourse ?? "")

            for i in 0 ..< (arrTeeTimeDetails[0].groupDetails?.count)! {
                
//                let memberInfo = String(format: "\n\nCaptain: %@ \n%@ \n%@ ", (self.arrTeeTimeDetails[0].groupDetails?[i].captainName)!,(self.arrTeeTimeDetails[0].groupDetails?[i].group)!,(self.arrTeeTimeDetails[0].groupDetails?[i].confirmationNumber)!)
                
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
            let textToShare = [ shareTextGolf ?? "",partyList.joined(separator: ""), shareText2] as [Any]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
            self.present(activityViewController, animated: true, completion: nil)
        }

       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Added comparioson for BMS. beacuse tennis book a leasson and Tennis reservations have same isFrom.
        //GATHER0000700 - Start
         if (self.appDelegate.typeOfCalendar == "Tennis" || ((isFrom?.caseInsensitiveCompare("Tennis")) == ComparisonResult.orderedSame)) && self.arrEventDetails.first?.requestType != .BMS
         {//GATHER0000700 - End
            return 1
        }else if(self.appDelegate.typeOfCalendar == "Dining") || ((isFrom?.caseInsensitiveCompare("Dining")) == ComparisonResult.orderedSame) {
            return 1
        }//Added on 22nd June 2020 BMS
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
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
                else if(self.appDelegate.typeOfCalendar == "Dining") || ((isFrom?.caseInsensitiveCompare("Dining")) == ComparisonResult.orderedSame)
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
        if (self.appDelegate.typeOfCalendar == "Tennis" || ((isFrom?.caseInsensitiveCompare("Tennis")) == ComparisonResult.orderedSame)) && self.arrEventDetails.first?.requestType != .BMS
        {//GATHER0000700 - End
            if self.arrTeeTimeDetails[0].tennisDetails?[indexPath.row].name == "" {
                cell.lblGroupMemberName.text = self.arrTeeTimeDetails[0].tennisDetails?[indexPath.row].guestName
            }else{
                cell.lblGroupMemberName.text = self.arrTeeTimeDetails[0].tennisDetails?[indexPath.row].name
            }
            
        }else if(self.appDelegate.typeOfCalendar == "Dining") || ((isFrom?.caseInsensitiveCompare("Dining")) == ComparisonResult.orderedSame) {
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
            if self.arrAppointmentDetails[0].details?[indexPath.row + 1].name == ""
            {
                cell.lblGroupMemberName.text = self.arrAppointmentDetails[0].details?[indexPath.row + 1].guestName
            }
            else
            {
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = Bundle.main.loadNibNamed("HeaderViewEventDetails", owner: self, options: nil)?.first as! HeaderViewEventDetails
        //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL Comments text
        //GATHER0001167 -- Start
        if (self.appDelegate.typeOfCalendar == "Golf" || ((isFrom?.caseInsensitiveCompare("Golf")) == ComparisonResult.orderedSame)) && self.arrEventDetails.first?.requestType != .BMS
        { //GATHER0001167 -- End
            if(self.arrTeeTimeDetails.count == 0)
            {
                
            }
            else{
            headerView.lblCaptainName.text = self.appDelegate.masterLabeling.captain
            if  self.arrTeeTimeDetails[0].groupDetails?[section].details?[0].name  == "" {
                headerView.lblCaptainNameText.text =  String(format: " %@", self.arrTeeTimeDetails[0].groupDetails?[section].details?[0].guestName ?? "")
            }else{
                headerView.lblCaptainNameText.text = String(format: " %@", self.arrTeeTimeDetails[0].groupDetails?[section].details?[0].name ?? "")
                
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
            }
            headerView.lblGroup.textColor = APPColor.textColor.secondary
          }else if(self.appDelegate.typeOfCalendar == "Dining" || ((isFrom?.caseInsensitiveCompare("Dining")) == ComparisonResult.orderedSame)) {
            if(self.arrTeeTimeDetails.count == 0){
                
            }
            else{
                headerView.lblCaptainName.text = self.appDelegate.masterLabeling.captain
                if self.arrTeeTimeDetails[0].diningDetails?[0].name == "" {
                    headerView.lblCaptainNameText.text = String(format: " %@", self.arrTeeTimeDetails[0].diningDetails?[0].guestName ?? "")
                }else{
                    headerView.lblCaptainNameText.text = String(format: " %@", self.arrTeeTimeDetails[0].diningDetails?[0].name ?? "")
                }

                headerView.lblGroup.text = String(format: "%@(%d)", self.appDelegate.masterLabeling.party_size!,self.arrTeeTimeDetails[0].partySize ?? 0)
                headerView.lblConfirmationNumber.text = self.arrTeeTimeDetails[0].confirmationNumber
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
                else{
                if self.arrAppointmentDetails[0].details?[0].name == ""
                {
                    BMSHeaderView.lblName.text = String(format: " %@", self.arrAppointmentDetails[0].details?[0].guestName ?? "")
                }
                else
                {
                    BMSHeaderView.lblName.text = String(format: " %@", self.arrAppointmentDetails[0].details?[0].name ?? "")
                }
                    
                    BMSHeaderView.lblConfirmationNumber.text = self.arrAppointmentDetails[0].confirmationNumber
                    
                }
                
                return BMSHeaderView.contentView
            }
        
        else{
            if(self.arrTeeTimeDetails.count == 0){
                
            }
            else{
            if self.arrTeeTimeDetails[0].tennisDetails?[0].name == "" {
                headerView.lblCaptainNameText.text = String(format: " %@", self.arrTeeTimeDetails[0].tennisDetails?[0].guestName ?? "")
            }else{
                headerView.lblCaptainNameText.text = String(format: " %@", self.arrTeeTimeDetails[0].tennisDetails?[0].name ?? "")
            }
            headerView.lblCaptainName.text = self.appDelegate.masterLabeling.captain
            headerView.lblGroup.text = self.arrTeeTimeDetails[0].confirmationNumber
            headerView.lblConfirmationNumber.text = ""
            headerView.lblGroup.textColor = hexStringToUIColor(hex: "695B5E")
            }
            
        }
        return headerView
        
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         if self.appDelegate.typeOfCalendar == "Golf" || ((isFrom?.caseInsensitiveCompare("Golf")) == ComparisonResult.orderedSame){
        return 168
         }//Added in BMS
         //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Add BMS comparision as fitness & spa and tennis book a lession should work the same way and both are of BMS type.
         //GATHER0000700 - Start
         //Replace fitness & spa with only BMS when possible.
         else if self.appDelegate.typeOfCalendar == "FitnessSpa" || ((isFrom?.caseInsensitiveCompare("FitnessSpa")) == ComparisonResult.orderedSame) || self.arrEventDetails.first?.requestType == .BMS
         {//GATHER0000700 - End
             return UITableViewAutomaticDimension
         }
         else{
            return 83
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
                            
                            self.lblEventTtle.text = self.arrTeeTimeDetails[0].syncCalendarTitle ?? " "
                            self.lblPreferredTeetimeValue.text = self.arrTeeTimeDetails[0].reservationRequestTime ?? ""
                            self.lblEarliestTeetimeValue.text = self.arrTeeTimeDetails[0].earliest ?? ""
                            self.lblRoundLengthValue.text = "\(self.arrTeeTimeDetails[0].gameTypeTitle ?? "")"
                            self.lblNPCValue.text = self.arrTeeTimeDetails[0].excludedCourse ?? ""
                            self.lblPreferredCourseValue.text = self.arrTeeTimeDetails[0].preferredCourse ?? ""

                            
                            if self.arrTeeTimeDetails[0].groupDetails?.count == 1{
                                self.lblLinkGroups.isHidden = true
                                self.lblLinkGroupsValue.isHidden = true
                                
                            }
                            else{
                                if(self.arrTeeTimeDetails[0].linkGroup == "0"){
                                    self.lblLinkGroupsValue.text = self.appDelegate.masterLabeling.No
                                }
                                else{
                                    self.lblLinkGroupsValue.text = self.appDelegate.masterLabeling.Yes
                                }
                            }
                            
//                            if(self.arrTeeTimeDetails[0].linkGroup == "0"){
//                                self.lblLinkGroupsValue.text = self.appDelegate.masterLabeling.No
//                            }
//                            else{
//                                self.lblLinkGroupsValue.text = self.appDelegate.masterLabeling.Yes
//                            }
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
                            
                          
                            
                            self.lblEventTtle.text = self.arrTeeTimeDetails[0].syncCalendarTitle ?? " "
                            self.lblEarliestTeetimeValue.text = self.arrTeeTimeDetails[0].playType ?? ""
                            self.lblPreferredTeetimeValue.text = self.arrTeeTimeDetails[0].durationText ?? ""
                            self.lblRoundLengthValue.text = self.arrTeeTimeDetails[0].reservationRequestTime
                            
//                            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.lblConfirmedTime.text!)
//                            attributeString.addAttribute(NSAttributedStringKey.underlineStyle, value: 1, range: NSMakeRange(0, 7))
                            
//                            self.lblConfirmedTime.attributedText = attributeString
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
                            
                            
                            self.lblEarliestTeeTime.text = self.appDelegate.masterLabeling.special_request
                            
                            self.lblPreferredTeetime.text = self.appDelegate.masterLabeling.time_colon
                            
                            self.lblRoundLength.text = self.appDelegate.masterLabeling.rESTAURTENT_NAME_COLON
                            
                            self.lblLinkGroups.text = self.appDelegate.masterLabeling.cOMMENTS_COLON
                            
                            self.lblEventTtle.text = self.arrTeeTimeDetails[0].syncCalendarTitle ?? " "
                            
                            self.lblLinkGroupsValue.text = (self.arrTeeTimeDetails[0].comments ?? "")
                            if self.lblLinkGroupsValue.text == "" {
                                self.lblLinkGroupsValue.text = " "
                            }
                            
                            self.lblRoundLengthValue.text = self.arrTeeTimeDetails[0].location ?? ""

                            self.lblPreferredTeetimeValue.text = self.arrTeeTimeDetails[0].reservationRequestTime ?? ""
                            self.lblEarliestTeetimeValue.text = self.arrTeeTimeDetails[0].tablePreferenceName ?? ""
                            
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
            
            if(appointment.appointmentDetails == nil)
            {
                self.arrAppointmentDetails.removeAll()
                self.groupsTableView.setEmptyMessage(InternetMessge.kNoData)
                self.groupsTableView.reloadData()
                
            }
            else
            {
                if(appointment.appointmentDetails?.count == 0)
                {
                    self.arrAppointmentDetails.removeAll()
                    self.groupsTableView.setEmptyMessage(InternetMessge.kNoData)
                    self.groupsTableView.reloadData()
                    
                }
                else
                {
                    self.groupsTableView.restore()
                    self.arrAppointmentDetails = appointment.appointmentDetails!
                    self.groupsTableView.reloadData()
                    
                    self.lblRoundLengthValue.text = appointment.appointmentDetails?.first?.syncText
                    
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
                            //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL comments text
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
                    self.lblPreferredTeetimeValue.attributedText =  attributedComments
                    
                    self.lblEventTtle.text = self.arrAppointmentDetails[0].syncCalendarTitle ?? ""
                    
                }
                
            }
            
            if(!(self.arrAppointmentDetails.count == 0))
            {
                let indexPath = IndexPath(row: 0, section: 0)
                //self.groupsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
            
            self.appDelegate.hideIndicator()
            
        }) { (error) in
            self.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper().showToast(on:
            self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
        }

    }
    

}
