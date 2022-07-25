//
//  GolfCalendarMYTabVC.swift
//  CSSI
//
//  Created by apple on 4/29/19.
//  Copyright © 2019 yujdesigns. All rights reserved.


import UIKit

class GolfCalendarMYTabVC: UIViewController, UITableViewDataSource, UITableViewDelegate, EventsCellDelegate {
    func imgDetailViewClicked(cell: EventCustomTableViewCell) {
        
    }
    

    @IBOutlet weak var myTableView: UITableView!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrEventList = [ListEvents]()
    var category : NSString!
    
    var strSearchText : String?


    var isFrom : NSString!
    
    //Added on 4th July 2020
    private let accessManager = AccessManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     
    }
    
    
//    @objc func notificationRecevied(notification: Notification) {
//        let strSearchText = notification.userInfo?["searchText"] ?? ""
//
//        self.eventApi(strSearch: strSearchText as? String)
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        // Do any additional setup after loading the view.
        strSearchText = self.appDelegate.golfEventsSearchText
        
        if (self.appDelegate.selectedSegment == "0") {
            
            if(self.appDelegate.typeOfCalendar == "Tennis"){
                self.myTennisEventApi(strSearch: strSearchText)
            }
            else if(self.appDelegate.typeOfCalendar == "Dining"){
                self.myDiningEventApi(strSearch: strSearchText)
            }
            else if self.appDelegate.typeOfCalendar == "FitnessSpa"
            {
                self.getFitnessAndSpaEventsAPI(search: strSearchText)
            }
            else{
                self.myGolfEventApi(strSearch: strSearchText)
            }
        }
        
        
        
        
        //        self.eventApi(strSearch: self.appDelegate.golfEventsSearchText)
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.notificationRecevied(notification:)) , name:Notification.Name("eventsData") , object: nil)
        
    }
    
    @objc func notificationRecevied(notification: Notification) {
        strSearchText = notification.userInfo?["searchText"] as? String
        
        
        if (self.appDelegate.selectedSegment == "0") {
            if(self.appDelegate.typeOfCalendar == "Tennis"){
                self.myTennisEventApi(strSearch: strSearchText)
            }
            else if(self.appDelegate.typeOfCalendar == "Dining"){
                self.myDiningEventApi(strSearch: strSearchText)
            }
            else if self.appDelegate.typeOfCalendar == "FitnessSpa"{
                self.getFitnessAndSpaEventsAPI(search: strSearchText)
            }
            else{
                self.myGolfEventApi(strSearch: strSearchText)
            }
            
        }
        else{
            self.eventApi(strSearch: strSearchText as? String)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //  IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    //Mark- Get Golf Event List Api

    //Mark- Get Event List Api
    func eventApi(strSearch :String?, filter: GuestCardFilter? = nil) {
        
        if (Network.reachability?.isReachable) == true{
            
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.ksearchby: strSearch ?? "",
                APIKeys.kDeviceType: "App",
                APIKeys.keventCategory: self.appDelegate.typeOfCalendar,
                
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "DateSort" : "",
                "EventStartDate" : self.appDelegate.dateSortToDate,
                "EventEndDate" : self.appDelegate.dateSortFromDate
            ]
            
            APIHandler.sharedInstance.getEventsList(paramaterDict: paramaterDict, onSuccess: { eventList in
                self.appDelegate.hideIndicator()
                // self.isFrom = ""
                
                if(eventList.responseCode == InternetMessge.kSuccess)
                {
                    if(eventList.eventsList == nil){
                        self.arrEventList.removeAll()
                        self.myTableView.setEmptyMessage(InternetMessge.kNoData)
                        self.myTableView.reloadData()
                        self.appDelegate.hideIndicator()
                    }
                    else{
                        
                        if(eventList.eventsList?.count == 0)
                        {
                            self.arrEventList.removeAll()
                            self.myTableView.setEmptyMessage(InternetMessge.kNoData)
                            self.myTableView.reloadData()
                            
                            
                            self.appDelegate.hideIndicator()
                            
                        }else{
                            self.myTableView.restore()
                            self.arrEventList = eventList.eventsList!  //eventList.listevents!
                            self.myTableView.reloadData()
                        }
                        
                    }
                    
                    if(!(self.arrEventList.count == 0)){
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.myTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((eventList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: eventList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.myTableView.setEmptyMessage(eventList.responseMessage ?? "")
                    
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
    
    //Mark- Get Golf Event List Api
    func myGolfEventApi(strSearch :String?, filter: GuestCardFilter? = nil) {
        
        if (Network.reachability?.isReachable) == true{
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.ksearchby: strSearch ?? "",
                APIKeys.kDeviceType: "",
                APIKeys.kCategory: self.appDelegate.typeOfCalendar,
                
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "DateSort" : "",
                "EventStartDate" : self.appDelegate.dateSortToDate,
                "EventEndDate" : self.appDelegate.dateSortFromDate
            ]
            
            APIHandler.sharedInstance.getGolfCalendarList(paramaterDict: paramaterDict, onSuccess: { eventList in
                self.appDelegate.hideIndicator()
                
                
                if(eventList.responseCode == InternetMessge.kSuccess)
                {
                    if(eventList.golfEventsList == nil){
                        self.arrEventList.removeAll()
                        self.myTableView.setEmptyMessage(InternetMessge.kNoData)
                        self.myTableView.reloadData()
                        self.appDelegate.hideIndicator()
                    }
                    else{
                        
                        if(eventList.golfEventsList?.count == 0)
                        {
                            self.arrEventList.removeAll()
                            self.myTableView.setEmptyMessage(InternetMessge.kNoData)
                            self.myTableView.reloadData()
                            
                            
                            self.appDelegate.hideIndicator()
                            
                        }else{
                            self.myTableView.restore()
                            self.arrEventList = eventList.golfEventsList!  //eventList.listevents!
                            self.myTableView.reloadData()
                        }
                        
                    }
                    
                    if(!(self.arrEventList.count == 0)){
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.myTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((eventList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: eventList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.myTableView.setEmptyMessage(eventList.responseMessage ?? "")
                    
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
    
    //Mark- Get Court Event List Api
    func myTennisEventApi(strSearch :String?, filter: GuestCardFilter? = nil) {
        
        if (Network.reachability?.isReachable) == true{
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.ksearchby: strSearch ?? "",
                APIKeys.kDeviceType: "",
                APIKeys.kCategory: self.appDelegate.typeOfCalendar,
                
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "DateSort" : "",
                "EventStartDate" : self.appDelegate.dateSortToDate,
                "EventEndDate" : self.appDelegate.dateSortFromDate
                
            ]
            
            APIHandler.sharedInstance.getTennisCalendarList(paramaterDict: paramaterDict, onSuccess: { eventList in
                self.appDelegate.hideIndicator()
                
                
                if(eventList.responseCode == InternetMessge.kSuccess)
                {
                    if(eventList.tennisEventsList == nil){
                        self.arrEventList.removeAll()
                        self.myTableView.setEmptyMessage(InternetMessge.kNoData)
                        self.myTableView.reloadData()
                        self.appDelegate.hideIndicator()
                    }
                    else{
                        
                        if(eventList.tennisEventsList?.count == 0)
                        {
                            self.arrEventList.removeAll()
                            self.myTableView.setEmptyMessage(InternetMessge.kNoData)
                            self.myTableView.reloadData()
                            
                            
                            self.appDelegate.hideIndicator()
                            
                        }else{
                            self.myTableView.restore()
                            self.arrEventList = eventList.tennisEventsList!  //eventList.listevents!
                            self.myTableView.reloadData()
                        }
                        
                    }
                    
                    if(!(self.arrEventList.count == 0)){
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.myTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((eventList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: eventList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.myTableView.setEmptyMessage(eventList.responseMessage ?? "")
                    
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
    
    //Mark- Get Dining Event List Api
    func myDiningEventApi(strSearch :String?, filter: GuestCardFilter? = nil) {
        
        if (Network.reachability?.isReachable) == true{
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.ksearchby: strSearch ?? "",
                APIKeys.kDeviceType: "",
                APIKeys.kCategory: self.appDelegate.typeOfCalendar,
                
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "DateSort" : "",
                "EventStartDate" : self.appDelegate.dateSortToDate,
                "EventEndDate" : self.appDelegate.dateSortFromDate
                
            ]
            
            APIHandler.sharedInstance.getDiningCalendarList(paramaterDict: paramaterDict, onSuccess: { eventList in
                self.appDelegate.hideIndicator()
                
                
                if(eventList.responseCode == InternetMessge.kSuccess)
                {
                    if(eventList.diningEventsList == nil){
                        self.arrEventList.removeAll()
                        self.myTableView.setEmptyMessage(InternetMessge.kNoData)
                        self.myTableView.reloadData()
                        self.appDelegate.hideIndicator()
                    }
                    else{
                        
                        if(eventList.diningEventsList?.count == 0)
                        {
                            self.arrEventList.removeAll()
                            self.myTableView.setEmptyMessage(InternetMessge.kNoData)
                            self.myTableView.reloadData()
                            
                            
                            self.appDelegate.hideIndicator()
                            
                        }else{
                            self.myTableView.restore()
                            self.arrEventList = eventList.diningEventsList!  //eventList.listevents!
                            self.myTableView.reloadData()
                        }
                        
                    }
                    
                    if(!(self.arrEventList.count == 0)){
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.myTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((eventList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: eventList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.myTableView.setEmptyMessage(eventList.responseMessage ?? "")
                    
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
    
    private func getFitnessAndSpaEventsAPI(search : String? , filter : GuestCardFilter? = nil)
    {
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        if Network.reachability?.isReachable == true
        {
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.ksearchby: search ?? "",
                APIKeys.kDeviceType: "",
                APIKeys.kCategory: self.appDelegate.typeOfCalendar,
                
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "DateSort" : "",
                "EventStartDate" : self.appDelegate.dateSortToDate,
                "EventEndDate" : self.appDelegate.dateSortFromDate
                
            ]
            
            APIHandler.sharedInstance.getFitnessAndSpaDetails(paramaterDict: paramaterDict, onSuccess: {(eventList) in
                
                self.appDelegate.hideIndicator()
                
                if(eventList.responseCode == InternetMessge.kSuccess)
                {
                    
                    if(eventList.fitnessEventsList == nil)
                    {
                        self.arrEventList.removeAll()
                        self.myTableView.setEmptyMessage(InternetMessge.kNoData)
                        self.myTableView.reloadData()
                        self.appDelegate.hideIndicator()
                        
                    }
                    else
                    {
                        if(eventList.fitnessEventsList?.count == 0)
                        {
                            self.arrEventList.removeAll()
                            self.myTableView.setEmptyMessage(InternetMessge.kNoData)
                            self.myTableView.reloadData()
                            
                            
                            self.appDelegate.hideIndicator()
                            
                        }
                        else
                        {
                            self.myTableView.restore()
                            self.arrEventList = eventList.fitnessEventsList!  //eventList.listevents!
                            self.myTableView.reloadData()
                            
                        }
                        
                    }
                    
                    if(!(self.arrEventList.count == 0))
                    {
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.myTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                        
                    }
                    
                    //Added on 18th June 2020 BMS
                    self.appDelegate.hideIndicator()
                    
                }
                else
                {
                    self.appDelegate.hideIndicator()
                    
                    if(((eventList.responseMessage?.count) ?? 0)>0)
                    {
                        SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: eventList.responseMessage, withDuration: Duration.kMediumDuration)
                        
                    }
                    
                    self.myTableView.setEmptyMessage(eventList.responseMessage ?? "")
                    
                }
                
                self.appDelegate.hideIndicator()
                
            },onFailure: { error  in
                
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
                
            })
            
        }
        else
        {
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            //  self.tableViewHeroes.setEmptyMessage(InternetMessge.kInternet_not_available)
            
        }
        
    }
    
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
    
    func shareButtonClicked(cell: EventCustomTableViewCell) {
        let indexPath = self.myTableView.indexPath(for: cell)
        
        var events =  ListEvents()
        events = arrEventList[indexPath!.row]
        //type 1 is event
        if events.type == "1"{
            if let share = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ShareViewController") as? ShareViewController {
                share.modalTransitionStyle   = .crossDissolve;
                share.modalPresentationStyle = .overCurrentContext
                //Old logic
                
                //share.imgURl = events.eventID
                //share.isFrom = "Events"
                
                //Added on 19th May 2020 v2.1
                share.contentType = .events
                share.contentDetails = ContentDetails.init(id: events.eventID, date: nil, name: nil, link: nil)
                self.present(share, animated: true, completion: nil)
            }
        }
        else
        {//
            if events.requestType == .BMS
            {
                self.getDepartmentSettings(eventObj: events) { (departments) in
                    
                    if let departmentDetails = departments?.first(where: {$0.locationID == events.locationID})
                    {
                        self.appDelegate.bookingAppointmentDetails = BMSAppointmentDetails()
                        self.appDelegate.bookingAppointmentDetails.department = departmentDetails
                    }
                    self.golfShareScreen(eventObjt: events)
                }
            }
            else
            {
                self.golfShareScreen(eventObjt: events)
            }
            
//            if let shareDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "GolfShareVC") as? GolfShareVC
//            {
//
//                //Added on 1st July 2020 BMS
//                let eventobj = self.arrEventList[indexPath!.row]
//                if eventobj.requestType == .BMS , let departmentDetails = self.arrDepartments?.first(where: {$0.locationID == eventobj.locationID})
//                {
//                    self.appDelegate.bookingAppointmentDetails = BMSAppointmentDetails()
//                    self.appDelegate.bookingAppointmentDetails.department = departmentDetails
//                }
//
//                shareDetails.requestID = events.eventID
//                shareDetails.arrEventDetails = [arrEventList[indexPath!.row]]
//                self.navigationController?.pushViewController(shareDetails, animated: true)
//            }
        }
    }
    
    func synchButtonClicked(cell: EventCustomTableViewCell) {
        
        let indexPath = self.myTableView.indexPath(for: cell)
        
        var events =  ListEvents()
        events = arrEventList[indexPath!.row]
        //type 1 is event
        if events.type == "1"{
            
            
            if let eventDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "EventDetailsVC") as? EventDetailsVC{
                
                if events.eventCategory?.lowercased() == "dining" {
                    if (self.appDelegate.selectedSegment == "0"){
                        eventDetails.isFrom = "DiningRes"
                    }
                }
                
                eventDetails.arrEventDetails = [arrEventList[indexPath!.row]]
                eventDetails.arrSyncData = arrEventList[indexPath!.row].eventDateList ?? [EventSyncData]()
                self.navigationController?.pushViewController(eventDetails, animated: true)
            }
        }
        else
        {   //Modified on 15th JUne 2020 V2.2
            //Modifeid to get deaprtment secctings when click on button
            
            if events.requestType == .BMS
            {
                self.getDepartmentSettings(eventObj: events) { [weak self] (departments) in
                    
                    if  let departmentDetails = departments?.first(where: {$0.locationID == events.locationID})
                    {
                        self?.appDelegate.bookingAppointmentDetails = BMSAppointmentDetails()
                        self?.appDelegate.bookingAppointmentDetails.department = departmentDetails
                    }
                    
                    self?.golfSyncScreen(eventObj: events)
                }
            }
            else
            {
                self.golfSyncScreen(eventObj: events)
            }
            
//            if let synchDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "GolfSyncCalendarVC") as? GolfSyncCalendarVC
//            {
//
//                //Added on 1st July 2020 BMS
//                let eventobj = self.arrEventList[indexPath!.row]
//                if eventobj.requestType == .BMS , let departmentDetails = self.arrDepartments?.first(where: {$0.locationID == eventobj.locationID})
//                {
//                    self.appDelegate.bookingAppointmentDetails = BMSAppointmentDetails()
//                    self.appDelegate.bookingAppointmentDetails.department = departmentDetails
//                }
//
//                synchDetails.requestID = events.eventID
//                synchDetails.arrEventDetails = [arrEventList[indexPath!.row]]
//                synchDetails.isFrom = events.eventCategory!
//                self.navigationController?.pushViewController(synchDetails, animated: true)
//            }
        }
        
    }
    
    //Added on 15th October 2020 V2.3
    func nameClicked(cell: EventCustomTableViewCell)
    {
        let indexPath = self.myTableView.indexPath(for: cell)
        
        var events =  ListEvents()
        events = arrEventList[indexPath!.row]
        if events.type == "1"{
            
            
            if let eventDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "EventDetailsVC") as? EventDetailsVC{
                
                if events.eventCategory?.lowercased() == "dining" {
                    if (self.appDelegate.selectedSegment == "0"){
                        eventDetails.isFrom = "DiningRes"
                    }
                }
                eventDetails.screenType = .details
                eventDetails.arrEventDetails = [arrEventList[indexPath!.row]]
                eventDetails.arrSyncData = arrEventList[indexPath!.row].eventDateList ?? [EventSyncData]()
                self.navigationController?.pushViewController(eventDetails, animated: true)
            }
        }
    }
    
    
    
    func registrationButtonClicked(cell: EventCustomTableViewCell) {
        let indexPath = self.myTableView.indexPath(for: cell)
        var eventobj =  ListEvents()
        eventobj = arrEventList[indexPath!.row]
        
        //Added on 4th July 2020 V2.2
        //Added roles and privilages Chanegs
        //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments. Added department name for BMS sub category(eg. fitness , spa ,salon, etc..) permissions.
        switch self.accessManager.accessPermission(eventCategory: eventobj.eventCategory!, type: eventobj.requestType!, departmentName: eventobj.DepartmentName ?? "")
        {
        case .view:
            
            if cell.btnRegister.titleLabel?.text == "Cancel"
            {
                if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
                {
                    SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                }
                return
            }
            
        case .notAllowed:
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        case .allowed:
            break
        }
        
        
        //type 1 is event
        if eventobj.type == "1"{
            
            if cell.btnRegister.titleLabel?.text == "Cancel" {
                
                if eventobj.eventCategory?.lowercased() == "dining"{
                    if let cancelViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController {
                        cancelViewController.isFrom = "EventDiningCancelRequestReservation"
                        cancelViewController.eventID = eventobj.requestID
                        cancelViewController.cancelFor = .DiningEvent
                        cancelViewController.numberOfTickets = eventobj.partySize ?? ""
                        self.navigationController?.pushViewController(cancelViewController, animated: true)
                    }
                }else{
                    if let cancelViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController {
                        cancelViewController.isFrom = "CancelEventFromReservation"
                        cancelViewController.cancelFor = .Events
                        cancelViewController.eventID = eventobj.eventID
                        cancelViewController.eventRegID = eventobj.eventRegistrationDetailID
                        cancelViewController.numberOfTickets = eventobj.partySize ?? ""
                        
                        self.navigationController?.pushViewController(cancelViewController, animated: true)
                    }
                }
            }else if cell.btnRegister.titleLabel?.text == "Modify" {
                
                if eventobj.eventCategory?.lowercased() == "dining"{
                    if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningEventRegistrationVC") as? DiningEventRegistrationVC {
                        
                        registerVC.eventID = eventobj.eventID
                        registerVC.eventCategory = eventobj.eventCategory
                        if eventobj.buttontextvalue == "4"{
                            registerVC.eventType = 2
                            
                        }else{
                            registerVC.eventType = eventobj.isMemberCalendar
                        }
                        registerVC.requestID = eventobj.requestID
                        registerVC.isFrom = "RequestEvents"
                        registerVC.segmentIndex = 1
                        registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                        self.navigationController?.pushViewController(registerVC, animated: true)
                        
                    }
                }else{
                    if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "RegisterEventVC") as? RegisterEventVC {
                        
                        registerVC.isFrom = "RequestEvents"
                        registerVC.eventID = eventobj.eventID
                        registerVC.eventCategory = eventobj.eventCategory
                        registerVC.eventType = eventobj.isMemberCalendar
                        registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                        
                        
                        self.navigationController?.pushViewController(registerVC, animated: true)
                    }
                }
            }else{
                if eventobj.eventCategory?.lowercased() == "dining"{
                    if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningEventRegistrationVC") as? DiningEventRegistrationVC {
                     
                            registerVC.eventID = eventobj.eventID
                            registerVC.eventCategory = eventobj.eventCategory
                            if eventobj.buttontextvalue == "4"{
                                registerVC.eventType = 2
                                
                            }else{
                                registerVC.eventType = eventobj.isMemberCalendar
                            }
                            registerVC.requestID = eventobj.requestID
                            registerVC.isFrom = "EventRequest"
                            registerVC.segmentIndex = 1
                            registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                            self.navigationController?.pushViewController(registerVC, animated: true)
                        
                    }
                }else{
                    if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "RegisterEventVC") as? RegisterEventVC {
                        
                        registerVC.isFrom = "EventRequest"
                        
                        var events =  ListEvents()
                        events = arrEventList[indexPath!.row]
                      
                            registerVC.eventID = events.eventID
                            registerVC.eventCategory = events.eventCategory
                            registerVC.eventType = events.isMemberCalendar
                            registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                            self.navigationController?.pushViewController(registerVC, animated: true)
                        
                    }
                }
            }
            
        }//Type 2 is Reservation
        else if eventobj.type == "2"
        {
            if(cell.btnRegister.titleLabel?.text == "Cancel"){
                
                if let cancelViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController {
                    cancelViewController.isFrom = "CancelRequest"
                    cancelViewController.isOnlyFrom = (self.appDelegate.typeOfCalendar == "Tennis" ? "Tennis" : (self.appDelegate.typeOfCalendar == "Dining") ? "DiningCancel" : "GolfCancel")
                    cancelViewController.cancelFor =  (self.appDelegate.typeOfCalendar == "Tennis" ? .TennisReservation : (self.appDelegate.typeOfCalendar == "Dining") ? .DiningReservation : .GolfReservation)
                    cancelViewController.eventID = eventobj.eventID
                    cancelViewController.numberOfTickets = eventobj.partySize ?? ""
                    self.navigationController?.pushViewController(cancelViewController, animated: true)
                }
            }else{
                
                if(self.appDelegate.typeOfCalendar == "Tennis"){
                    let courtRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "CourtRequestVC") as! CourtRequestVC
                    courtRequest.isFrom = "Modify"
                    courtRequest.requestID = eventobj.eventID
                    
                    self.navigationController?.pushViewController(courtRequest, animated: true)
                }
                else if(self.appDelegate.typeOfCalendar == "Dining"){
                    
                    let diningRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "DiningRequestVC") as! DiningRequestVC
                    if eventobj.buttontextvalue == "4"{
                        diningRequest.isFrom = "View"
                        
                    }else{
                        diningRequest.isFrom = "Modify"
                        
                    }
                    diningRequest.requestID = eventobj.eventID
                    diningRequest.reservationRequestDate = eventobj.eventstartdate
                    self.navigationController?.pushViewController(diningRequest, animated: true)
                }
                else{
                    let golfRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "GolfRequestTeeTimeVC") as! GolfRequestTeeTimeVC
                    if eventobj.buttontextvalue == "4"{
                        golfRequest.isFrom = "View"
                        
                    }else{
                        golfRequest.isFrom = "Modify"
                        
                    }
                    golfRequest.requestID = eventobj.eventID
                    
                    self.navigationController?.pushViewController(golfRequest, animated: true)
                }
            }
        }
        //Added on 18th June 2020
        //Type 3 if for BMS
        //Request Type is an enum for type.
        else if eventobj.requestType == .BMS
        {
            self.getDepartmentSettings(eventObj: eventobj) { [weak self] (departments) in
                if let departmentDetails = departments?.first(where: {$0.locationID == eventobj.locationID})
                {
                    self?.assignBMSDetails(BMSObject: eventobj, departmentDetails: departmentDetails, reqeustScreenType: .modify)
                    //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Added the BMS department paramater to the function
                    //GATHER0000700 - Start
                    self?.startBMSFlow(BMSDepartment: CustomFunctions.shared.BMSDepartmentType(departmentType: eventobj.departmentType))
                    //GATHER0000700 - End
                }
            }
            
        }
    }
    
    //MARK:- View only clicked delegate
    func viewOnlyClickedClicked(cell: EventCustomTableViewCell) {
        
        let indexPath = self.myTableView.indexPath(for: cell)
        var eventobj =  ListEvents()
        eventobj = arrEventList[indexPath!.row]
        
        
        //Added on 4th July 2020 V2.2
        //Added roles and privilages Chanegs
        //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments. Added department name for BMS sub category(eg. fitness , spa ,salon, etc..) permissions.
        switch self.accessManager.accessPermission(eventCategory: eventobj.eventCategory!, type: eventobj.requestType!, departmentName: eventobj.DepartmentName ?? "") {
            
        case .notAllowed:
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        case .allowed,.view:
            break
        }
        
        
        //type 1 is event
        if eventobj.type == "1"{
            
            if eventobj.eventCategory?.lowercased() == "dining"{
                if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningEventRegistrationVC") as? DiningEventRegistrationVC {
                    
                    registerVC.eventID = eventobj.eventID
                    registerVC.eventCategory = eventobj.eventCategory
                    if eventobj.buttontextvalue == "4"{
                        registerVC.eventType = 2
                        
                    }else{
                        registerVC.eventType = eventobj.isMemberCalendar
                    }
                    registerVC.requestID = eventobj.requestID
                    registerVC.isFrom = "RequestEvents"
                    registerVC.segmentIndex = 1
                    registerVC.isViewOnly = true
                    registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                    self.navigationController?.pushViewController(registerVC, animated: true)
                    
                }
            }else{
                if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "RegisterEventVC") as? RegisterEventVC {
                    
                    registerVC.isFrom = "RequestEvents"
                    registerVC.eventID = eventobj.eventID
                    registerVC.eventCategory = eventobj.eventCategory
                    registerVC.eventType = eventobj.isMemberCalendar
                    registerVC.isViewOnly = true
                    registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                    
                    
                    self.navigationController?.pushViewController(registerVC, animated: true)
                }
            }

        }//Type 2 requests
        else if eventobj.type == "2"
        {
            if(self.appDelegate.typeOfCalendar == "Tennis"){
                let courtRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "CourtRequestVC") as! CourtRequestVC
                courtRequest.isFrom = "Modify"
                courtRequest.requestID = eventobj.eventID
                courtRequest.isViewOnly = true
                self.navigationController?.pushViewController(courtRequest, animated: true)
            }
            else if(self.appDelegate.typeOfCalendar == "Dining"){
                
                let diningRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "DiningRequestVC") as! DiningRequestVC
                if eventobj.buttontextvalue == "4"{
                    diningRequest.isFrom = "View"
                    
                }else{
                    diningRequest.isFrom = "Modify"
                }
                diningRequest.requestID = eventobj.eventID
                diningRequest.reservationRequestDate = eventobj.eventstartdate
                diningRequest.isViewOnly = true
                self.navigationController?.pushViewController(diningRequest, animated: true)
            }
            else{
                let golfRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "GolfRequestTeeTimeVC") as! GolfRequestTeeTimeVC
//                if eventobj.buttontextvalue == "4"{
//                    golfRequest.isFrom = "View"
//                    
//                }else{
//                    golfRequest.isFrom = "Modify"
//                    
//                }
                golfRequest.isFrom = "View"
                golfRequest.requestID = eventobj.eventID
                golfRequest.isViewOnly = true
                self.navigationController?.pushViewController(golfRequest, animated: true)
            }
        }
        //Added on 18th June 2020
        //Type 3 if for BMS
        //Request Type is an enum for type.
        else if eventobj.requestType == .BMS
        {
            self.getDepartmentSettings(eventObj: eventobj) { [weak self] (departments) in
                
                 if let departmentDetails = departments?.first(where: {$0.locationID == eventobj.locationID})
                 {
                    self?.assignBMSDetails(BMSObject: eventobj, departmentDetails: departmentDetails, reqeustScreenType: .view)
                    //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Added the BMS department paramater to the function
                    //GATHER0000700 - Start
                    self?.startBMSFlow(BMSDepartment: CustomFunctions.shared.BMSDepartmentType(departmentType: eventobj.departmentType))
                    //GATHER0000700 - End
                    
                }
                
            }
           
        }

    }
    
    //MARK:- Cancel Button callback
    //Added on 18th June 2020 BMS
    func cancelClicked(cell: EventCustomTableViewCell)
    {
        
        if let indexPath = self.myTableView.indexPath(for: cell)
        {
            let eventObject = self.arrEventList[indexPath.row]
            
            //Added on 4th July 2020 V2.2
            //Added roles and privilages Chanegs
            //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments. Added department name for BMS sub category(eg. fitness , spa ,salon, etc..) permissions.
            switch self.accessManager.accessPermission(eventCategory: eventObject.eventCategory!, type: eventObject.requestType!, departmentName: eventObject.DepartmentName ?? "") {
            case .view,.notAllowed:
                
                if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
                {
                    SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                }
                return
            case .allowed:
                break
            }
            
            
            self.getAppointmentdetails(id: eventObject.eventID) { [unowned self] in
                
                //Modified on 8th July 2020 V2.2
                //Added cancel succes popup and cancelation reason settigs
                
                self.getDepartmentSettings(eventObj: eventObject) { [unowned self] (departments) in
                    
                    guard let departmentDetails = departments?.first(where: {$0.locationID == eventObject.locationID}) else{
                        return
                    }
                    
                    if departmentDetails.settings?.first?.app_CaptureCacellationReason == "1"
                    {
                        let cancelView = BMSCancelView.init(frame: self.appDelegate.window!.bounds)
                        cancelView.appointmentDetailID = self.arrEventList[indexPath.row].eventID
                        cancelView.success = { [unowned self] (imgPath) in
                            
                            if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView {
                                self.appDelegate.hideIndicator()
                                succesView.delegate = self
                                succesView.imgUrl = imgPath
                                //Added by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
                                //GATHER0001167 -- Start
                                
                                var department : CancelCategory?
                                switch eventObject.requestType
                                {
                                case .BMS:
                                    
                                    if (eventObject.eventCategory ?? "").caseInsensitiveCompare(AppIdentifiers.tennis) == .orderedSame
                                    {
                                        department = .tennisBookALesson
                                    }
                                    else if (eventObject.eventCategory ?? "").caseInsensitiveCompare(AppIdentifiers.golf) == .orderedSame
                                    {
                                        department = .golfBookALesson
                                    }
                                    else if (eventObject.eventCategory ?? "").caseInsensitiveCompare(AppIdentifiers.fitnessSpa) == .orderedSame
                                    {
                                        department = .fitnessSpa
                                    }
                                        
                                default:
                                    break
                                }
                                succesView.cancelFor = department
                                succesView.departmentName = eventObject.DepartmentName ?? ""
                                //succesView.isFrom = CancelCategory.fitnessSpa.rawValue
                                //GATHER0001167 -- End
                                succesView.modalTransitionStyle   = .crossDissolve;
                                succesView.modalPresentationStyle = .overCurrentContext
                                self.present(succesView, animated: true, completion: nil)
                            }
                            
                        }
                        self.appDelegate.window?.rootViewController?.view.addSubview(cancelView)
                    }
                    else if departmentDetails.settings?.first?.app_CaptureCacellationReason == "0"
                    {
                        if let cancelViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController {
                            cancelViewController.delegate = self
                            cancelViewController.eventID = eventObject.eventID
                            //Added by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
                            //GATHER0001167 -- Start
                            //cancelViewController.departmentName = departmentDetails.departmentName ?? ""
                            cancelViewController.departmentName = eventObject.DepartmentName ?? ""
                            var department : CancelCategory?
                            switch eventObject.requestType
                            {
                            case .BMS:
                                
                                if (eventObject.eventCategory ?? "").caseInsensitiveCompare(AppIdentifiers.tennis) == .orderedSame
                                {
                                    department = .tennisBookALesson
                                }
                                else if (eventObject.eventCategory ?? "").caseInsensitiveCompare(AppIdentifiers.golf) == .orderedSame
                                {
                                    department = .golfBookALesson
                                }
                                else if (eventObject.eventCategory ?? "").caseInsensitiveCompare(AppIdentifiers.fitnessSpa) == .orderedSame
                                {
                                    department = .fitnessSpa
                                }
                                    
                            default:
                                break
                            }
                            cancelViewController.cancelFor = department
                            //cancelViewController.cancelFor = .fitnessSpa
                            //GATHER0001167 -- End
                            cancelViewController.numberOfTickets = ""
                            self.navigationController?.pushViewController(cancelViewController, animated: true)
                        }
                    }

                    
                }
                
            }
            
        }
                
        
    }
    
    func externalLinkClicked(cell: EventCustomTableViewCell) {
        let indexPath = self.myTableView.indexPath(for: cell)
        
        var events =  ListEvents()
        events = arrEventList[indexPath!.row]
        
        guard let url = URL(string: events.externalURL ?? "") else { return }
        UIApplication.shared.open(url)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:EventCustomTableViewCell = self.myTableView.dequeueReusableCell(withIdentifier: "eventsIdentifier") as! EventCustomTableViewCell
        var eventobj =  ListEvents()
        eventobj = arrEventList[indexPath.row]
        cell.delegate = self
        
        cell.btnViewOnly.setTitle("", for: .normal)
        
        
        if (eventobj.type == "2") {
            cell.lblEventTime.text = String(format: "%@", eventobj.eventTime ?? "")
            if eventobj.eventCategory?.lowercased() == "golf" || eventobj.eventCategory?.lowercased() == "dining"{
                cell.lblLocation.text = eventobj.location ?? ""
                
            }else{
                cell.lblLocation.text = ""
            }
        }else{
            
            if (self.appDelegate.selectedSegment == "0") && eventobj.eventCategory?.lowercased() == "dining"{
                cell.lblEventTime.text = String(format: "%@", eventobj.eventTime ?? "")
                
            }else{
                //                    cell.lblEventTime.text = String(format: "%@ - %@", eventobj.eventTime ?? "", eventobj.eventendtime ?? "")
                if eventobj.eventendtime == "" {
                    cell.lblEventTime.text = String(format: "%@", eventobj.eventTime ?? "")
                }
                else if eventobj.eventTime == "" {
                    cell.lblEventTime.text = String(format: "%@", eventobj.eventendtime ?? "")
                }
                else if eventobj.eventendtime == "" && eventobj.eventTime == "" {
                    cell.lblEventTime.text = ""
                }
                else{
                    cell.lblEventTime.text = String(format: "%@ - %@", eventobj.eventTime ?? "", eventobj.eventendtime ?? "")
                }
            }
            cell.lblLocation.text = eventobj.eventVenue ?? ""
            
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let EventDate = dateFormatter.date(from: eventobj.eventstartdate ?? "")
        
        var weekDay = ""
        var dateAndMonth = ""
        
        if EventDate != nil {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd-MM-yyyy"
            
            dateFormat.dateFormat = "dd"
            weekDay = dateFormat.string(from: EventDate!)
            
            dateFormat.dateFormat = "MMM"
            dateAndMonth = dateFormat.string(from: EventDate!)
        }
        
        if eventobj.eventstatus == "" && eventobj.colorCode == "" {
            cell.lblStatus.isHidden = true
            cell.lblStatusColor.isHidden = true
            // cell.btnEventStatus.isHidden = true
            cell.regStatus.isHidden = true
            
            cell.statusHeight.constant = 0
            cell.heightTopView.constant = 100
            
        }else{
            cell.lblStatus.isHidden = false
            cell.lblStatusColor.isHidden = false
            //cell.btnEventStatus.isHidden = false
            cell.regStatus.isHidden = false
            
            cell.statusHeight.constant = 20
            cell.heightTopView.constant = 130
        }
        
        if(self.appDelegate.typeOfCalendar == "Dining") && eventobj.type == "2"{
            cell.lblPartySize.text = String(format: "%@ %@", self.appDelegate.masterLabeling.party_size_colon ?? "",eventobj.partySize ?? "")
            cell.lblEventName.text = eventobj.eventName
            cell.heightPartySize.constant = 18
            
        }else{
            cell.lblPartySize.text = ""
            cell.lblEventName.text = eventobj.eventName
            cell.heightPartySize.constant = 10
        }
        
        cell.lblStatus.text = self.appDelegate.masterLabeling.status
        cell.lblDate.text = weekDay
        cell.lblDay.text = dateAndMonth
        cell.lblWeekDay.text = eventobj.eventDayName
        
        if(eventobj.buttontextvalue == "0"){
            cell.btnRegister.isHidden = true
        }
        else if(eventobj.buttontextvalue == "1"){
            cell.btnRegister.isHidden = false
            
            cell.btnRegister .setTitle(self.appDelegate.masterLabeling.event_request, for: UIControlState.normal)
            
        }
        else if(eventobj.buttontextvalue == "2"){
            cell.btnRegister.isHidden = false
            
            cell.btnRegister .setTitle(self.appDelegate.masterLabeling.event_modify, for: UIControlState.normal)
            
        }
        else if(eventobj.buttontextvalue == "3"){
            cell.btnRegister.isHidden = false
            
            cell.btnRegister .setTitle(self.appDelegate.masterLabeling.event_cancel, for: UIControlState.normal)
            
        }
        else if(eventobj.buttontextvalue == "4"){
            cell.btnRegister.isHidden = false
            
            cell.btnRegister .setTitle(self.appDelegate.masterLabeling.VIEW, for: UIControlState.normal)
            
        }
        cell.lblStatusColor.backgroundColor = hexStringToUIColor(hex: eventobj.colorCode ?? "")
        
        
        if self.appDelegate.selectedSegment == "0"{
            //  cell.btnEventStatus .setTitle(eventobj.memberEventStatus, for: UIControlState.normal)
            cell.regStatus.text = eventobj.memberEventStatus
            
        }else{
            //   cell.btnEventStatus .setTitle(eventobj.eventstatus, for: UIControlState.normal)
            cell.regStatus.text = eventobj.eventstatus
            
        }
        cell.delegate = self
        if (self.appDelegate.selectedSegment == "0") || eventobj.eventCategory?.lowercased() == "dining"{
            cell.lblEventID.isHidden = false
            cell.lblEventID.text = eventobj.confirmationNumber ?? ""
        }
        else{
            cell.lblEventID.isHidden = true
            
        }
        
        cell.btnViewOnly.isHidden = !(eventobj.buttontextvalue == "2")
        cell.btnViewOnly.setTitle(self.appDelegate.masterLabeling.VIEW, for: .normal)
        
        //Added on 18th June 2020 BMS
        
        cell.btnCancel.isHidden = !(eventobj.showCancelButton ?? false)
        //Type 3 is BMS
        if eventobj.requestType == .BMS
        {
            cell.btnViewOnly.isHidden = !(eventobj.showViewButton ?? false)
        }
        
        cell.btnCancel.BMSCancelBthViewSetup()
        cell.btnCancel.setTitle(self.appDelegate.masterLabeling.cANCEL ?? "", for: .normal)
        cell.lblDay.textColor = APPColor.MainColours.primary2
        cell.btnCancel.setStyle(style: .outlined, type: .secondary)
        return cell
    }
    
    
}

//Added in BMS
//MARK:- Custom Methods
extension GolfCalendarMYTabVC
{
    private func golfSyncScreen(eventObj : ListEvents)
    {
        if let synchDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "GolfSyncCalendarVC") as? GolfSyncCalendarVC
        {
            synchDetails.requestID = eventObj.eventID
            synchDetails.arrEventDetails = [eventObj]
            synchDetails.isFrom = eventObj.eventCategory!
            self.navigationController?.pushViewController(synchDetails, animated: true)
        }
        
    }
    
    private func golfShareScreen(eventObjt : ListEvents)
    {
        if let shareDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "GolfShareVC") as? GolfShareVC
        {
            shareDetails.requestID = eventObjt.eventID
            shareDetails.arrEventDetails = [eventObjt]
            self.navigationController?.pushViewController(shareDetails, animated: true)
        }
    }
    
    
    ///Assigns the BMS details required to the BMS flow to the shared BMSAppointmentDetails object.
    ///
    ///BMSObject is ListEvent Object and reqeustScreenType indicates if the reqeust screen is view/Modify or request
    private func assignBMSDetails(BMSObject : ListEvents ,departmentDetails : DepartmentDetails, reqeustScreenType : RequestScreenType)
    {
        self.appDelegate.BMSOrder = BMSObject.appointmentFlow!
        self.appDelegate.bookingAppointmentDetails = BMSAppointmentDetails()
        self.appDelegate.bookingAppointmentDetails.requestScreenType = reqeustScreenType
        
        self.appDelegate.bookingAppointmentDetails.appointmentID = BMSObject.eventID
        //Note:- All the deatails of Department/ServiceType/Provider/Service may not be available here assign them when navigatin to the respective screen.Other wise flow will not work porperly
        
        self.appDelegate.bookingAppointmentDetails.department = departmentDetails
        self.appDelegate.bookingAppointmentDetails.department?.appointmentFlow = BMSObject.appointmentFlow
        
        
        let serviceType = ProductionClass()
        serviceType.productClassID = BMSObject.productClassID
        serviceType.locationID = BMSObject.locationID
        serviceType.productClass = BMSObject.eventName
        self.appDelegate.bookingAppointmentDetails.serviceType = serviceType
        
        let provider = Provider()
        provider.providerID = BMSObject.providerID
        //Added name on 11th August 2020 V2.3
        provider.name = BMSObject.providerName
        self.appDelegate.bookingAppointmentDetails.provider = provider
        
        let service = Service()
        service.serviceID = BMSObject.serviceID
        self.appDelegate.bookingAppointmentDetails.service = service
    }
    
    ///Navigates to the first BMS screen.
    private func startBMSFlow(BMSDepartment : BMSDepartment)
    {
        switch self.appDelegate.bookingAppointmentDetails.requestScreenType
        {
        case .request:
            break
        case .modify:
            
            switch self.appDelegate.BMSOrder.first?.contentType ?? .none
            {
            case .services , .providers , .departments:
                
                guard let vc = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "FitnessRequestListingViewController") as? FitnessRequestListingViewController else {
                    return
                }
                
                vc.contentType = self.appDelegate.BMSOrder.first!.contentType!
                //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
                //GATHER0000700 - Start
                vc.BMSBookingDepartment = BMSDepartment
                //GATHER0000700 - End
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc, animated: true)
                
            case .serviceType:
                
                 guard let serviceTypeVC = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "ServiceTypeViewController") as? ServiceTypeViewController else{return}
                
                //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
                //GATHER0000700 - Start
                serviceTypeVC.BMSBookingDepartment = BMSDepartment
                //GATHER0000700 - End
                serviceTypeVC.modalPresentationStyle = .fullScreen
                           
                self.navigationController?.pushViewController(serviceTypeVC, animated: true)
                
            case .requestScreen:
                
                guard let requestVC = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "SpaAndFitnessRequestVC") as? SpaAndFitnessRequestVC else {
                    return
                    
                }
                
                requestVC.requestType = self.appDelegate.bookingAppointmentDetails.requestScreenType
                //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
                //GATHER0000700 - Start
                requestVC.BMSBookingDepartment = BMSDepartment
                //GATHER0000700 - End
                requestVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(requestVC, animated: true)
                
            case .none:
                break
                
            }
        case .view:
            
            guard let requestVC = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "SpaAndFitnessRequestVC") as? SpaAndFitnessRequestVC else {
                return
                
            }
            
            requestVC.requestType = self.appDelegate.bookingAppointmentDetails.requestScreenType
            //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
            //GATHER0000700 - Start
            requestVC.BMSBookingDepartment = BMSDepartment
            //GATHER0000700 - End
            requestVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(requestVC, animated: true)
            
        case .none:
            break
        }
    }
    
    
    private func handleRequestError(error : Error)
    {
        self.appDelegate.hideIndicator()
        SharedUtlity.sharedHelper().showToast(on:
        self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
    }
    
}

//MARK:- APIS
extension GolfCalendarMYTabVC
{
    //Modified on 15th JUly 2020 V2.2
    //changed the function to include a callback.
    private func getDepartmentSettings(eventObj: ListEvents, completion : @escaping ([DepartmentDetails]?) -> ())
    {
        guard Network.reachability?.isReachable == true else {
            SharedUtlity.sharedHelper().showToast(on:
            self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            return
            
        }
        
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
        //GATHER0000700 - Start
        var departmentType = ""
        
        switch CustomFunctions.shared.BMSDepartmentType(departmentType: eventObj.departmentType)
        {
        case .fitnessAndSpa:
            departmentType = BMSDepartment.fitnessAndSpa.rawValue
        case .tennisBookALesson:
            departmentType = BMSDepartment.tennisBookALesson.rawValue
            //Added by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
            //GATHER0001167 -- Start
        case .golfBookALesson:
            departmentType = BMSDepartment.golfBookALesson.rawValue
            //GATHER0001167 -- End
        case .none:
            break
        }
        //GATHER0000700 - End
        
        let paramaterDict:[String: Any] = [
            "Content-Type":"application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kAppointmentDetailID : eventObj.eventID ?? "",
            //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
            //GATHER0000700 - Start
            APIKeys.kDepartment : departmentType
            //GATHER0000700 - End
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        APIHandler.sharedInstance.getDepartmentDetails(paramater: paramaterDict, onSuccess: { [weak self] (departments) in
            
            completion(departments.departmentsDetails)
            self?.appDelegate.hideIndicator()
        }) { [weak self] (error) in
            self?.handleRequestError(error: error)
        }
        
    }
    
    private func getAppointmentdetails(id : String? , success : (() -> ())?)
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
        APIKeys.kAppointmentID : id!]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        APIHandler.sharedInstance.getAppointment(paramater: paramaterDict, onSuccess: { (appointment) in
            self.appDelegate.hideIndicator()
            self.appDelegate.BMS_cancelReasons = (appointment.appointmentDetails?.first?.cancelReasonList) ?? [CancelReason]()
            success?()
        }) { (error) in
            self.appDelegate.hideIndicator()
            self.handleRequestError(error: error)
        }
    }
}

//Added on 8th July 2020 V2.2
//MARK:- CancelPopUpViewController Delegate
extension GolfCalendarMYTabVC : CancelPopUpViewControllerDelegate
{
    func didCancel(status: Bool)
    {
        if (self.appDelegate.selectedSegment == "0")
        {
            if(self.appDelegate.typeOfCalendar == "Tennis")
            {
                self.myTennisEventApi(strSearch: self.strSearchText)
            }
            else if(self.appDelegate.typeOfCalendar == "Dining")
            {
                self.myDiningEventApi(strSearch: self.strSearchText)
            }
            else if self.appDelegate.typeOfCalendar == "FitnessSpa"
            {
                self.getFitnessAndSpaEventsAPI(search: self.strSearchText)
            }
            else
            {
                self.myGolfEventApi(strSearch: self.strSearchText)
            }
                
        }
        
    }
    
}

//Added on 8th July 2020 V2.2
//MARK:- closeUpdateSuccesPopup Delegate
extension GolfCalendarMYTabVC : closeUpdateSuccesPopup
{
    func closeUpdateSuccessView()
    {
        if (self.appDelegate.selectedSegment == "0")
        {
            if(self.appDelegate.typeOfCalendar == "Tennis")
            {
                self.myTennisEventApi(strSearch: self.strSearchText)
            }
            else if(self.appDelegate.typeOfCalendar == "Dining")
            {
                self.myDiningEventApi(strSearch: self.strSearchText)
            }
            else if self.appDelegate.typeOfCalendar == "FitnessSpa"
            {
                self.getFitnessAndSpaEventsAPI(search: self.strSearchText)
            }
            else
            {
                self.myGolfEventApi(strSearch: self.strSearchText)
            }
                
        }
        
    }
    
    
}
