//
//  EventDetailsVC.swift
//  CSSI
//
//  Created by apple on 2/27/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit
import EventKit

class EventDetailsVC: UIViewController,UITextFieldDelegate {

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
    //@IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewCalendar: UIView!
    var arrEventDetails = [ListEvents]()
    fileprivate var selectedRemainder: ReminderTime? = nil
    fileprivate var reminderPicker: UIPickerView? = nil;

    
    @IBOutlet weak var txtViewAdditionalDetailsText: UITextView!
    
    @IBOutlet weak var lblMoreInfo: UILabel!
    @IBOutlet weak var lblUrl: UILabel!
    
    //Added on 14th October 2020 V2.3
    @IBOutlet weak var viewAlert: UIView!
    @IBOutlet weak var viewAddToCalendar: UIView!
    @IBOutlet weak var viewMoreInfo: UIView!
    @IBOutlet weak var viewCalendarSync: UIView!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var eventName : String?
    var eventDay : String!
    var eventID : String?
    var eventCategory : String!
   // var startDate = Date()
   // var endDate = Date()
    var timeInterval : TimeInterval!
    var url : String!
    var isFrom: String?
    var myMutableString = NSMutableAttributedString()
    /// Conatins the details with which events have to by synced
    var arrSyncData = [EventSyncData]()
    
    ///Used to track the position in arrSyncData
    ///
    /// Maual iteration is used instead of Loops because events use call backs
    private var arrSyncDataCurrentPosition = 0
    
    //Added on 15th October 2020 V2.3
    ///Indicates the screentype.default is Sync to calendar
    var screenType : SyncScreenType = .syncToCalendar
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        reminderPicker = UIPickerView()
        reminderPicker?.dataSource = self
        reminderPicker?.delegate = self
        txtAlertDropDown.inputView = reminderPicker
        txtAlertDropDown.delegate = self
        
        self.navigationItem.title = self.appDelegate.masterLabeling.event_details
        self.lblAdditionalEventDetails.text = self.appDelegate.masterLabeling.additionalEventDetails
        self.lblAlert.text = self.appDelegate.masterLabeling.alert
        txtAlertDropDown.delegate = self
        txtAlertDropDown.setRightIcon(imageName: "Icon_ArrowRightActive")

        lblEventName.font = SFont.SFProText_Semibold20
        lblEventDay.font = SFont.SFProText_Regular17
        lblEventtime.font = SFont.SFProText_Regular17
        lblFromTime.font = SFont.SFProText_Regular14
        lblToTime.font = SFont.SFProText_Regular14
        lblEventTitle.font = SFont.SFProText_Regular12
        lblAlert.font = SFont.SFProText_Semibold18
        lblAdditionalEventDetails.font = SFont.SFProText_Semibold18
        txtViewAdditionalDetailsText.font = SFont.SFProText_Regular17
        
        btnAddToCalendar.backgroundColor = .clear
        btnAddToCalendar.layer.cornerRadius = 15
        btnAddToCalendar.layer.borderWidth = 1
        btnAddToCalendar.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        self.btnAddToCalendar.setStyle(style: .outlined, type: .primary)
        
        viewCalendar.layer.cornerRadius = 5
        viewCalendar.layer.borderWidth = 0.1
        viewCalendar.layer.borderColor = hexStringToUIColor(hex: "707070").cgColor
        
        lblEventName.text = arrEventDetails[0].eventName
        lblEventTitle.text = arrEventDetails[0].eventName
        lblFromTime.text = arrEventDetails[0].eventTime
        lblToTime.text = arrEventDetails[0].eventendtime
        
        lblEventtime.text =  arrEventDetails[0].eventTime
        
        //Modified on 28th September 2020 V2.3
        //Added support for HTML text
        //txtViewAdditionalDetailsText.text = String(format: "%@", arrEventDetails[0].eventDescription ?? "")

        let additionalDetailsAttrString : NSMutableAttributedString = NSMutableAttributedString.init(attributedString: String(format: "%@", arrEventDetails[0].eventDescription ?? "").generateAttributedString(isHtml: true) ?? NSAttributedString.init(string: ""))
        
        let font : UIFont = UIFont.init(name: "Helvetica Neue", size: 17.0)!
        
        let textColor : UIColor = hexStringToUIColor(hex: "#695B5E")
        
        additionalDetailsAttrString.addAttributes([.foregroundColor : textColor,.font : font], range: NSMakeRange(0, additionalDetailsAttrString.length))
        txtViewAdditionalDetailsText.attributedText = additionalDetailsAttrString
        
        
        lblUrl.text = String(format: "%@%@", appDelegate.arrShareUrlList[3].url!,arrEventDetails[0].eventID ?? "")
        lblMoreInfo.text = self.appDelegate.masterLabeling.moreInfo
        self.lblEventDay.text = arrEventDetails[0].eventDate

        
        if isFrom == "DiningRes"{
            self.lblEventtime.text = arrEventDetails[0].eventTime ?? ""
        }else{
            if arrEventDetails[0].eventendtime == "" {
              self.lblEventtime.text = arrEventDetails[0].eventTime ?? ""
            }else if arrEventDetails[0].eventTime == "" {
                self.lblEventtime.text = arrEventDetails[0].eventendtime ?? ""
            }else if arrEventDetails[0].eventTime == "" &&  arrEventDetails[0].eventendtime == ""{
                self.lblEventtime.text = ""
            }else{
            self.lblEventtime.text = String(format: "%@ - %@", arrEventDetails[0].eventTime ?? "", arrEventDetails[0].eventendtime ?? "")
            }
        }
        
        if arrEventDetails[0].isScheduleEvent == 1
        {
            self.lblEventtime.text = ""
            self.lblEventDay.text = arrEventDetails[0].scheduleText
        }
        
        
        //Added on 15th October 2020 V2.3
        switch self.screenType {
        case .syncToCalendar:
            break
        case .details:
            
            self.viewMoreInfo.isHidden = true
            self.viewAlert.isHidden = true
            self.viewAddToCalendar.isHidden = true
        }
        
        self.lblEventName.textColor = APPColor.textColor.secondary
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    //Added on 16th October 2020 V2.3
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        let homeBtn = UIBarButtonItem.init(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(self.homeClicked(sender:)))
        self.navigationItem.rightBarButtonItem = homeBtn
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //Added on 16th October 2020 V2.3
    @objc func homeClicked(sender: UIBarButtonItem)
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func calendarSyncClicked(_ sender: Any)
    {
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //Modified on 14th October 2020 V2.3
        //viewHeight.constant = txtViewAdditionalDetailsText.frame.height + 600
        
    }
    
    @IBAction func addToCalendarClicked(_ sender: Any)
    {
        if (UserDefaults.standard.string(forKey: UserDefaultsKeys.synchCalendar.rawValue) == "0"){
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: self.appDelegate.masterLabeling.calendar_synch_success, withDuration: Duration.kMediumDuration)
            return
        }
        
        self.startSync()
        
        //Previous logic to sync event on one day only
       /*
        let shareText = String(format: "%@\nMore Info:\n%@ ",self.arrEventDetails[0].eventDescription ?? "",self.lblUrl.text ?? "")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
        if self.arrEventDetails[0].eventTime == ""  || self.arrEventDetails[0].eventendtime == ""{
            startDate = dateFormatter.date(from: String(format: "%@ %@", self.arrEventDetails[0].eventstartdate ?? "","12:00 AM"))!
            endDate = dateFormatter.date(from: String(format: "%@ %@", self.arrEventDetails[0].eventstartdate ?? "","12:01 AM"))!
        }else{
            startDate = dateFormatter.date(from: String(format: "%@ %@", self.arrEventDetails[0].eventstartdate ?? "",self.arrEventDetails[0].eventTime ?? "12:00 AM"))!
            endDate = dateFormatter.date(from: String(format: "%@ %@", self.arrEventDetails[0].eventstartdate ?? "",self.arrEventDetails[0].eventendtime ?? "12:01 AM"))!
        }
        if (UserDefaults.standard.string(forKey: UserDefaultsKeys.synchCalendar.rawValue) == "0"){
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: self.appDelegate.masterLabeling.calendar_synch_success, withDuration: Duration.kMediumDuration)
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
                        event.title = self.arrEventDetails[0].eventName
                        event.startDate = self.startDate
                        event.endDate = self.endDate
                         event.notes = shareText
                        
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
                                    self.view, withMeassge: self.appDelegate.masterLabeling.calendar_synch_success, withDuration: Duration.kMediumDuration)
                            }
                        }catch let error as NSError{
                            //print(error.userInfo["NSLocalizedDescription"])
                            DispatchQueue.main.async {
                                SharedUtlity.sharedHelper().showToast(on:
                                    self.view, withMeassge: error.userInfo["NSLocalizedDescription"] as! String, withDuration: Duration.kMediumDuration)
                            }
                        }
                        
                       
                    }
                    else{
                    
                    for singleEvent in existingEvents {
                        if singleEvent.title == self.arrEventDetails[0].eventName && singleEvent.startDate == self.startDate {
                            if let calendarEvent_toDelete = eventStore.event(withIdentifier: singleEvent.eventIdentifier){
                                
                                do {
                                    
                                    try eventStore.remove(calendarEvent_toDelete, span: .thisEvent)
                                    
                                    event.title = self.arrEventDetails[0].eventName
                                    event.startDate = self.startDate
                                    event.endDate = self.endDate
                                    event.notes = shareText

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
                                            self.view, withMeassge: self.appDelegate.masterLabeling.calendar_synch_success, withDuration: Duration.kMediumDuration)
                                    }
                                    
                                }catch let error as NSError{
                                    print(error)
                                    
                                }
                            }
                        }
                        else{
                            event.title = self.arrEventDetails[0].eventName
                            event.startDate = self.startDate
                            event.endDate = self.endDate
                            event.notes = shareText

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
                                    self.view, withMeassge: self.appDelegate.masterLabeling.calendar_synch_success, withDuration: Duration.kMediumDuration)
                            }
                        }
                    }
                    }
                    
                }
                else{
                    print("error \(String(describing: error))")
                }
            }
        }*/
        
    }
    
    ///Syncs event to calender based on index count
    private func startSync()
    {
        
        if self.arrSyncDataCurrentPosition >= 0 && self.arrSyncDataCurrentPosition < self.arrSyncData.count
        {
            self.syncEvent(details: self.arrSyncData[self.arrSyncDataCurrentPosition])
        }
        else
        {
            //Invalid index
            if !(self.arrSyncDataCurrentPosition >= 0)
            {
                print("Invalid Index value during event sync")
            }
            
            //Completed syncing of events
            if self.arrSyncDataCurrentPosition >= self.arrSyncData.count
            {
                SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: self.appDelegate.masterLabeling.calendar_synch_success, withDuration: Duration.kMediumDuration)
            }
        }
        
        
    }
    
    ///Syncs event to calendar
    private func syncEvent(details : EventSyncData)
    {
        var startDate = Date()
        var endDate = Date()
        
        //Modified on 12th October 2020 V2.3
        let additionalDetailsAttrString : NSMutableAttributedString = NSMutableAttributedString.init(attributedString: String(format: "%@", arrEventDetails[0].eventDescription ?? "").generateAttributedString(isHtml: true) ?? NSAttributedString.init(string: ""))

        let font : UIFont = UIFont.init(name: "Helvetica Neue", size: 17.0)!

        let textColor : UIColor = hexStringToUIColor(hex: "#695B5E")

        additionalDetailsAttrString.addAttributes([.foregroundColor : textColor,.font : font], range: NSMakeRange(0, additionalDetailsAttrString.length))
        
        
        let shareText = String(format: "%@\nMore Info:\n%@ ",additionalDetailsAttrString.string,self.lblUrl.text ?? "")
        //let shareText = String(format: "%@\nMore Info:\n%@ ",self.arrEventDetails[0].eventDescription ?? "",self.lblUrl.text ?? "")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
        if details.startTime == ""  || details.endTime == ""{
            
            let startTime = details.startTime == "" ? "12:00 AM" : details.startTime ?? "12:00 AM"
            let endTime = details.endTime == "" ? "11:59 PM" : details.endTime ?? "11:59 PM"
            
            startDate = dateFormatter.date(from: String(format: "%@ %@", details.startDate ?? "",  startTime))!
            endDate = dateFormatter.date(from: String(format: "%@ %@", details.endDate ?? "",endTime))!
            
        }else{
            startDate = dateFormatter.date(from: String(format: "%@ %@", details.startDate ?? "",details.startTime ?? "12:00 AM"))!
            endDate = dateFormatter.date(from: String(format: "%@ %@", details.endDate ?? "",details.endTime ?? "11:59 PM"))!
        }
        
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
                
                
                let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate,  calendars: nil)
                
                let existingEvents = eventStore.events(matching: predicate)
                if (existingEvents.count == 0){
                    event.title = self.arrEventDetails[0].eventName
                    event.startDate = startDate
                    event.endDate = endDate
                     event.notes = shareText
                    
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
                        //print(error.userInfo["NSLocalizedDescription"])
                        DispatchQueue.main.async {
                            SharedUtlity.sharedHelper().showToast(on:
                                self.view, withMeassge: error.userInfo["NSLocalizedDescription"] as! String, withDuration: Duration.kMediumDuration)
                        }
                    }
                    
                   
                }
                else
                {
                    for singleEvent in existingEvents
                    {
                        if singleEvent.title == self.arrEventDetails[0].eventName && singleEvent.startDate == startDate
                        {
                            if let calendarEvent_toDelete = eventStore.event(withIdentifier: singleEvent.eventIdentifier)
                            {
                                
                                do {
                                    
                                    try eventStore.remove(calendarEvent_toDelete, span: .thisEvent)
                                    
                                    event.title = self.arrEventDetails[0].eventName
                                    event.startDate = startDate
                                    event.endDate = endDate
                                    event.notes = shareText

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
                                    
                                }catch let error as NSError{
                                    print(error)
                                    
                                }
                            }
                        }
                        else
                        {
                            event.title = self.arrEventDetails[0].eventName
                            event.startDate = startDate
                            event.endDate = endDate
                            event.notes = shareText

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
                            
                        }
                        
                    }

                }
                
            }
            else{
                print("error \(String(describing: error))")
            }
            
            DispatchQueue.main.async {
                self.arrSyncDataCurrentPosition += 1
                self.startSync()
            }
            
        }


    }
        
    
}

extension EventDetailsVC : UIPickerViewDataSource {
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

extension EventDetailsVC : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectedRemainder = appDelegate.arrReminderTime[row]
            txtAlertDropDown.text = selectedRemainder?.name
        
        
        
    }
}



