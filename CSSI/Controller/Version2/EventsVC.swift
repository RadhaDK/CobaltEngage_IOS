//
//  EventsVC.swift
//  CSSI
//
//  Created by apple on 4/17/19.
//  Copyright © 2019 yujdesigns. All rights reserved.

import UIKit
import MessageUI

class EventsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, EventsCellDelegate, MFMailComposeViewControllerDelegate {
  
    @IBOutlet weak var evntstableview: UITableView!
    @IBOutlet weak var viewLoadMore: UIView!
    @IBOutlet weak var btnLoadMore: UIButton!
    
    private var isLoadMoreClicked = false
    var monthCount : Int = 0
    var isSortFilterApplied : Int = 0
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrEventList = [ListEvents]()
    var strSearchText : String?
    var arrselectedEmails = [String]()
    var emailSubject : String?

    //Added on 4th July 2020
    private let accessManager = AccessManager.shared
    
    //Added by kiran V1.3 -- PROD0000071 -- Support to request events from flier image on click of news
    //PROD0000071 -- Start
    private var isRedirectToEventsDetail : Int?
    //PROD0000071 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
                self.FitnessEventListApi(search: strSearchText)
            }
            else{
                self.myGolfEventApi(strSearch: strSearchText)
            }
        }
        else{
            self.eventApi(strSearch: strSearchText)
        }
        
        /*
        btnLoadMore.backgroundColor = .clear
        btnLoadMore.layer.cornerRadius = 18
        btnLoadMore.layer.borderWidth = 1
        btnLoadMore.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
         */
        btnLoadMore.setTitle(self.appDelegate.masterLabeling.SHOW_MORE ?? "" , for: .normal)
        
        self.btnLoadMore.setStyle(style: .outlined, type: .primary)
        
       NotificationCenter.default.addObserver(self, selector:#selector(self.notificationRecevied(notification:)) , name:Notification.Name("eventsData") , object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

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
            else if self.appDelegate.typeOfCalendar == "FitnessSpa"
            {
                self.FitnessEventListApi(search: strSearchText)
            }
            else{
                self.myGolfEventApi(strSearch: strSearchText)
            }
            
        }
        else{
            if notification.userInfo?["resetMonth"] as? String == "1"
            {
                self.monthCount = 0
            }
            self.eventApi(strSearch: strSearchText as? String)
        }
    }
   
    
    //Mark- Get Event List Api
    func eventApi(strSearch :String?, filter: GuestCardFilter? = nil) {
        
         self.viewLoadMore.isHidden = true
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
                "EventEndDate" : self.appDelegate.dateSortFromDate,
                APIKeys.kmonthCount : self.monthCount,
                APIKeys.kIsSortFilterApplied : self.isSortFilterApplied
            ]
            self.isSortFilterApplied = 0
            APIHandler.sharedInstance.getEventsList(paramaterDict: paramaterDict, onSuccess: { eventList in
                self.appDelegate.hideIndicator()
               // self.isFrom = ""
                
                //Added by kiran V1.3 -- PROD0000071 -- Support to request events from club news on click of news
                //PROD0000071 -- Start
                self.isRedirectToEventsDetail = eventList.isRedirectToEventsDetail
                //PROD0000071 -- End
                
                if(eventList.responseCode == InternetMessge.kSuccess)
                {
                    if(eventList.eventsList == nil){
                        if self.isLoadMoreClicked
                        {
                            
                        }
                        else{
                            self.arrEventList.removeAll()
                            self.evntstableview.setEmptyMessage(InternetMessge.kNoData)
                            self.evntstableview.reloadData()

                        }
                        self.appDelegate.hideIndicator()
                    }
                    else{
                        
                        if(eventList.eventsList?.count == 0)
                        {
                            if self.isLoadMoreClicked
                            {
                                
                            }
                            else
                            {
                                self.arrEventList.removeAll()
                                self.evntstableview.setEmptyMessage(InternetMessge.kNoData)
                                self.evntstableview.reloadData()
                                
                            }
                            
                            self.appDelegate.hideIndicator()
                            
                        }else{
                            self.evntstableview.restore()
                            
                            if self.isLoadMoreClicked
                            {
                                self.arrEventList.append(contentsOf: eventList.eventsList!)
                            }
                            else
                            {
                                 self.arrEventList = eventList.eventsList!  //eventList.listevents!
                            }
                            self.viewLoadMore.isHidden = eventList.isLoadMore == 0
                            self.evntstableview.reloadData()
                        }
                        
                    }
                    
                    if(!(self.arrEventList.count == 0 ) && !self.isLoadMoreClicked){
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.evntstableview.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    
                    self.isLoadMoreClicked = false
                    self.monthCount = eventList.monthCount ?? 0
                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((eventList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: eventList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.evntstableview.setEmptyMessage(eventList.responseMessage ?? "")
                    
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
                        self.evntstableview.setEmptyMessage(InternetMessge.kNoData)
                        self.evntstableview.reloadData()
                        self.appDelegate.hideIndicator()
                    }
                    else{
                        
                        if(eventList.golfEventsList?.count == 0)
                        {
                            self.arrEventList.removeAll()
                            self.evntstableview.setEmptyMessage(InternetMessge.kNoData)
                            self.evntstableview.reloadData()
                            
                            
                            self.appDelegate.hideIndicator()
                            
                        }else{
                            self.evntstableview.restore()
                            self.arrEventList = eventList.golfEventsList!  //eventList.listevents!
                            self.evntstableview.reloadData()
                        }
                        
                    }
                    
                    if(!(self.arrEventList.count == 0)){
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.evntstableview.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((eventList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: eventList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.evntstableview.setEmptyMessage(eventList.responseMessage ?? "")
                    
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
                        self.evntstableview.setEmptyMessage(InternetMessge.kNoData)
                        self.evntstableview.reloadData()
                        self.appDelegate.hideIndicator()
                    }
                    else{
                        
                        if(eventList.tennisEventsList?.count == 0)
                        {
                            self.arrEventList.removeAll()
                            self.evntstableview.setEmptyMessage(InternetMessge.kNoData)
                            self.evntstableview.reloadData()
                            
                            
                            self.appDelegate.hideIndicator()
                            
                        }else{
                            self.evntstableview.restore()
                            self.arrEventList = eventList.tennisEventsList!  //eventList.listevents!
                            self.evntstableview.reloadData()
                        }
                        
                    }
                    
                    if(!(self.arrEventList.count == 0)){
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.evntstableview.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((eventList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: eventList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.evntstableview.setEmptyMessage(eventList.responseMessage ?? "")
                    
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
                        self.evntstableview.setEmptyMessage(InternetMessge.kNoData)
                        self.evntstableview.reloadData()
                        self.appDelegate.hideIndicator()
                    }
                    else{
                        
                        if(eventList.diningEventsList?.count == 0)
                        {
                            self.arrEventList.removeAll()
                            self.evntstableview.setEmptyMessage(InternetMessge.kNoData)
                            self.evntstableview.reloadData()
                            
                            
                            self.appDelegate.hideIndicator()
                            
                        }else{
                            self.evntstableview.restore()
                            self.arrEventList = eventList.diningEventsList!  //eventList.listevents!
                            self.evntstableview.reloadData()
                        }
                        
                    }
                    
                    if(!(self.arrEventList.count == 0)){
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.evntstableview.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((eventList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: eventList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.evntstableview.setEmptyMessage(eventList.responseMessage ?? "")
                    
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
    
    
    private func FitnessEventListApi(search : String? , filter : GuestCardFilter? = nil)
    {
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
            
            APIHandler.sharedInstance.getFitnessAndSpaDetails(paramaterDict: paramaterDict, onSuccess: { (eventList) in
                
                self.appDelegate.hideIndicator()
                
                if(eventList.responseCode == InternetMessge.kSuccess)
                {
                    if(eventList.fitnessEventsList == nil)
                    {
                        self.arrEventList.removeAll()
                        self.evntstableview.setEmptyMessage(InternetMessge.kNoData)
                        self.evntstableview.reloadData()
                        self.appDelegate.hideIndicator()
                        
                    }
                    else
                    {
                        if(eventList.fitnessEventsList?.count == 0)
                        {
                            self.arrEventList.removeAll()
                            self.evntstableview.setEmptyMessage(InternetMessge.kNoData)
                            self.evntstableview.reloadData()
                                               
                                               
                            self.appDelegate.hideIndicator()
                                               
                        }
                        else
                        {
                            self.evntstableview.restore()
                            self.arrEventList = eventList.fitnessEventsList!  //eventList.listevents!
                            self.evntstableview.reloadData()
                            
                        }
                        
                    }
                    
                    if(!(self.arrEventList.count == 0))
                    {
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.evntstableview.scrollToRow(at: indexPath, at: .top, animated: true)
                        
                    }
                    
                }
                else
                {
                    self.appDelegate.hideIndicator()
                    if(((eventList.responseMessage?.count) ?? 0)>0)
                    {
                        SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: eventList.responseMessage, withDuration: Duration.kMediumDuration)
                        
                    }
                    
                    self.evntstableview.setEmptyMessage(eventList.responseMessage ?? "")
                    
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
    
    @IBAction func loadMoreClicked(_ sender: UIButton) {
        
        self.monthCount += 1
        self.isLoadMoreClicked = true
        self.eventApi(strSearch: strSearchText)
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
        let indexPath = self.evntstableview.indexPath(for: cell)
        
        var events =  ListEvents()
        events = arrEventList[indexPath!.row]
        
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
        }else{
            if let shareDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "GolfShareVC") as? GolfShareVC{
                
                shareDetails.requestID = events.eventID
                shareDetails.arrEventDetails = [arrEventList[indexPath!.row]]
                self.navigationController?.pushViewController(shareDetails, animated: true)
            }
        }
       
        
    }
  
    
    func synchButtonClicked(cell: EventCustomTableViewCell) {
        
        let indexPath = self.evntstableview.indexPath(for: cell)
        
        var events =  ListEvents()
        events = arrEventList[indexPath!.row]
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
        else{
            if let synchDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "GolfSyncCalendarVC") as? GolfSyncCalendarVC{
                
                synchDetails.requestID = events.eventID
                synchDetails.arrEventDetails = [arrEventList[indexPath!.row]]
                synchDetails.isFrom = events.eventCategory!
                self.navigationController?.pushViewController(synchDetails, animated: true)
            }
        }
    }
    
    func registrationButtonClicked(cell: EventCustomTableViewCell) {
        self.appDelegate.monthCount = self.monthCount
        let indexPath = self.evntstableview.indexPath(for: cell)
        var eventobj =  ListEvents()
        eventobj = arrEventList[indexPath!.row]
        
        //Added on 4th July 2020 V2.2
        //Added roles and privilages changes
        //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments. Added department name for BMS sub category(eg. fitness , spa ,salon, etc..) permissions.
        switch self.accessManager.accessPermission(eventCategory: eventobj.eventCategory!, type: eventobj.requestType!, departmentName: eventobj.DepartmentName ?? "") {
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
        
        
        guard eventobj.isMemberTgaEventNotAllowed != 1 && eventobj.type == "1" else {
                           SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.TGAMEMBERVALIDATION, withDuration: Duration.kMediumDuration)
                           return
                       }
              
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
                        if eventobj.buttontextvalue == "5"{
                            guard let url = URL(string: eventobj.externalURL ?? "") else { return }
                            UIApplication.shared.open(url)
                        }else if eventobj.buttontextvalue == "6"{
                            
                            let stremail = eventobj.externalURL ?? ""
                            emailSubject = eventobj.eventName ?? ""

                            if(stremail == "")
                            {
                                
                            }else{
                                self.arrselectedEmails.removeAll()
                                self.arrselectedEmails.append(stremail)
                                
                                let mailComposeViewController = configuredMailComposeViewController()
                                if MFMailComposeViewController.canSendMail() {
                                    self.present(mailComposeViewController, animated: true, completion: nil)
                                } else {
                                    self.showSendMailErrorAlert()
                                }
                            }
                        }else{
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
                    }
                }else{
                    
               
                if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "RegisterEventVC") as? RegisterEventVC {
                    
                    registerVC.isFrom = "EventRequest"
                    
                    var events =  ListEvents()
                    events = arrEventList[indexPath!.row]
                    
                    if eventobj.buttontextvalue == "5"{
                        guard let url = URL(string: events.externalURL ?? "") else { return }
                        UIApplication.shared.open(url)
                    }else if eventobj.buttontextvalue == "6"{
                        
                        let stremail = events.externalURL ?? ""
                        emailSubject = events.eventName ?? ""
                        if(stremail == "")
                        {
                            
                        }else{
                            self.arrselectedEmails.removeAll()
                            self.arrselectedEmails.append(stremail)
                            
                            let mailComposeViewController = configuredMailComposeViewController()
                            if MFMailComposeViewController.canSendMail() {
                                self.present(mailComposeViewController, animated: true, completion: nil)
                            } else {
                                self.showSendMailErrorAlert()
                            }
                        }
                    }else{
                    registerVC.eventID = events.eventID
                    registerVC.eventCategory = events.eventCategory
                    registerVC.eventType = events.isMemberCalendar
                    registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                    self.navigationController?.pushViewController(registerVC, animated: true)
                    }
                }
                }
            }
            
        }
        else{
            if(cell.btnRegister.titleLabel?.text == "Cancel"){
                
                if let cancelViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController {
                    cancelViewController.isFrom = "CancelRequest"
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
                }//TODO:- Add fitness and spa logic for reservations
                else if self.appDelegate.typeOfCalendar == "FitnessSpa"
                {
                    
                }
                else{
                    let golfRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "GolfRequestTeeTimeVC") as! GolfRequestTeeTimeVC
                    golfRequest.isFrom = "Modify"
                    golfRequest.requestID = eventobj.eventID
                    
                    self.navigationController?.pushViewController(golfRequest, animated: true)
                }
            }
        }

    
    }
    
    //Added on 18th June 2020 BMS
    func cancelClicked(cell: EventCustomTableViewCell) {
        
    }
    
    //Added on 15th October 2020 V2.3
    func nameClicked(cell: EventCustomTableViewCell)
    {
        let indexPath = self.evntstableview.indexPath(for: cell)
        
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
    
    //MARK:- View only delegate
    //This works same as when modify works except all the actions are disabled
    func viewOnlyClickedClicked(cell: EventCustomTableViewCell)
    {
        self.appDelegate.monthCount = self.monthCount
        let indexPath = self.evntstableview.indexPath(for: cell)
        var eventobj =  ListEvents()
        eventobj = arrEventList[indexPath!.row]
        
        //Added on 4th July 2020 V2.2
        //Added roles and privilages changes
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
        
//        guard eventobj.isMemberTgaEventNotAllowed != 1 && eventobj.type == "1" else {
//        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.TGAMEMBERVALIDATION, withDuration: Duration.kMediumDuration)
//        return
//        
//        }
        
        if eventobj.type == "1"
        {
            if eventobj.eventCategory?.lowercased() == "dining"
            {
                if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningEventRegistrationVC") as? DiningEventRegistrationVC
                {
                    registerVC.eventID = eventobj.eventID
                    registerVC.eventCategory = eventobj.eventCategory
                    if eventobj.buttontextvalue == "4"
                    {
                        registerVC.eventType = 2
                        
                    }
                    else
                    {
                        registerVC.eventType = eventobj.isMemberCalendar
                        
                    }
                    registerVC.isViewOnly = true
                    registerVC.requestID = eventobj.requestID
                    registerVC.isFrom = "RequestEvents"
                    registerVC.segmentIndex = 1
                    registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                    self.navigationController?.pushViewController(registerVC, animated: true)
                    
                }
                
            }
            else
            {
                if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "RegisterEventVC") as? RegisterEventVC
                {
                    registerVC.isFrom = "RequestEvents"
                    registerVC.eventID = eventobj.eventID
                    registerVC.isViewOnly = true
                    registerVC.eventCategory = eventobj.eventCategory
                    registerVC.eventType = eventobj.isMemberCalendar
                    registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""

                                
                    self.navigationController?.pushViewController(registerVC, animated: true)
                    
                }
                
            }
            
        }
        else
        {
            if(self.appDelegate.typeOfCalendar == "Tennis")
            {
                let courtRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "CourtRequestVC") as! CourtRequestVC
                        courtRequest.isFrom = "Modify"
                        courtRequest.requestID = eventobj.eventID
                        courtRequest.isViewOnly = true
                        self.navigationController?.pushViewController(courtRequest, animated: true)
                
            }
            else if(self.appDelegate.typeOfCalendar == "Dining")
            {
                let diningRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "DiningRequestVC") as! DiningRequestVC
                
                if eventobj.buttontextvalue == "4"
                {
                    diningRequest.isFrom = "View"
                    
                }
                else
                {
                    diningRequest.isFrom = "Modify"
                    
                }
                diningRequest.requestID = eventobj.eventID
                diningRequest.isViewOnly = true
                diningRequest.reservationRequestDate = eventobj.eventstartdate
                self.navigationController?.pushViewController(diningRequest, animated: true)
                
            }//TODO:- Add fitness and spa logic for resrvations
            else if self.appDelegate.typeOfCalendar == "FitnessSpa"
            {
                
            }
            else
            {
                let golfRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "GolfRequestTeeTimeVC") as! GolfRequestTeeTimeVC
                        
                golfRequest.isFrom = "Modify"
                golfRequest.requestID = eventobj.eventID
                golfRequest.isViewOnly = true
                self.navigationController?.pushViewController(golfRequest, animated: true)
                
            }
            
        }

    }
    
    func externalLinkClicked(cell: EventCustomTableViewCell) {
        let indexPath = self.evntstableview.indexPath(for: cell)
        
        var events =  ListEvents()
        events = arrEventList[indexPath!.row]
        
        guard let url = URL(string: events.externalURL ?? "") else { return }
        UIApplication.shared.open(url)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:EventCustomTableViewCell = self.evntstableview.dequeueReusableCell(withIdentifier: "eventsIdentifier") as! EventCustomTableViewCell
        var eventobj =  ListEvents()
        eventobj = arrEventList[indexPath.row]
        cell.delegate = self
        cell.btnViewOnly.setTitle("", for: .normal)
        cell.btnExternallink.setTitleColor(APPColor.MainColours.primary2, for: .normal)
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
        
                let date = EventDate
        
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = "dd-MM-yyyy"
        
                dateFormat.dateFormat = "dd"
                let weekDay: String = dateFormat.string(from: date!)
        
                dateFormat.dateFormat = "MMM"
                let dateAndMonth: String = dateFormat.string(from: date!)
                if eventobj.buttontextvalue == "5" || eventobj.buttontextvalue == "6" {
                    cell.lblExternalRegText.isHidden = true
                    cell.btnExternallink.isHidden = true
                }else{
                if(eventobj.externalURL == ""){
                    cell.lblExternalRegText.isHidden = true
                    cell.btnExternallink.isHidden = true
                }
                else{
                    cell.lblExternalRegText.isHidden = false
                    cell.btnExternallink.isHidden = false
        
                    cell.lblExternalRegText.text = self.appDelegate.masterLabeling.external_reg ?? "" as String
                    cell.btnExternallink.setTitle(eventobj.externalURL, for: UIControlState.normal)
                }
                }
        
                if eventobj.eventstatus == "" && eventobj.colorCode == "" {
                    cell.lblStatus.isHidden = true
                    cell.lblStatusColor.isHidden = true
                   // cell.btnEventStatus.isHidden = true
                    cell.regStatus.isHidden = true

                    cell.statusHeight.constant = 0
                    
                }else{
                    cell.lblStatus.isHidden = false
                    cell.lblStatusColor.isHidden = false
                    //cell.btnEventStatus.isHidden = false
                    cell.regStatus.isHidden = false

                    cell.statusHeight.constant = 20
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
                   // cell.statusWidth.constant = 20
                }
                else if(eventobj.buttontextvalue == "1") || (eventobj.buttontextvalue == "5") || eventobj.buttontextvalue == "6" {
                    cell.btnRegister.isHidden = false
                    //cell.statusWidth.constant = 128

                    cell.btnRegister .setTitle(self.appDelegate.masterLabeling.event_request, for: UIControlState.normal)
        
                }
                else if(eventobj.buttontextvalue == "2"){
                    cell.btnRegister.isHidden = false
                    //cell.statusWidth.constant = 128

                    cell.btnRegister .setTitle(self.appDelegate.masterLabeling.event_modify, for: UIControlState.normal)
        
                }
                else if(eventobj.buttontextvalue == "3"){
                    cell.btnRegister.isHidden = false
                    //cell.statusWidth.constant = 128

                    cell.btnRegister .setTitle(self.appDelegate.masterLabeling.event_cancel, for: UIControlState.normal)
        
                }
                else if(eventobj.buttontextvalue == "4"){
                    cell.btnRegister.isHidden = false
                    //cell.statusWidth.constant = 128

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
        
        
        let placeHolderImage = UIImage(named: "Icon-App-40x40")
        cell.imgEventImage.image = placeHolderImage
        
        //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
        //ENGAGE0011419 -- Start
        let imageURLString = eventobj.imageThumb ?? ""
        
        if imageURLString.isValidURL()
        {
            let url = URL.init(string:imageURLString)
            cell.imgEventImage.sd_setImage(with: url , placeholderImage: placeHolderImage)
        }
        
        /*
        if(imageURLString.count>0)
        {
            let validUrl = self.verifyUrl(urlString: imageURLString)
            if(validUrl == true)
            {
                let url = URL.init(string:imageURLString)
                cell.imgEventImage.sd_setImage(with: url , placeholderImage: placeHolderImage)
                
            }
        }
        */
        //ENGAGE0011419 -- End
        cell.delegate = self
        if (self.appDelegate.selectedSegment == "0") || eventobj.eventCategory?.lowercased() == "dining"{
            cell.lblEventID.isHidden = false
            cell.lblEventID.text = eventobj.confirmationNumber ?? ""
        }
        else{
            cell.lblEventID.isHidden = true

        }
                cell.imgEventImage.layer.cornerRadius = 16
                cell.imgEventImage.layer.masksToBounds = true
                cell.imgEventImage.layer.borderColor = hexStringToUIColor(hex: "F5F5F5").cgColor
                cell.imgEventImage.layer.borderWidth = 1.0

        cell.btnViewOnly.isHidden = !(eventobj.buttontextvalue == "2")
        cell.btnViewOnly.setTitle(self.appDelegate.masterLabeling.VIEW, for: .normal)
        cell.viewBttns.isHidden = (cell.btnViewOnly.isHidden && cell.btnRegister.isHidden)
        
        cell.lblDay.textColor = APPColor.MainColours.primary2
        return cell
    }
   
    
    //  MARK:- Email button tapped
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(arrselectedEmails)
        mailComposerVC.setSubject(String(format: "%@ %@", self.emailSubject ?? "",UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!))
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
   
    func imgDetailViewClicked(cell: EventCustomTableViewCell)
    {
        let indexPath = self.evntstableview.indexPath(for: cell)

        var eventobj = ListEvents()
        eventobj = arrEventList[(indexPath?.row)!]
        
        //Added by kiran V1.3 -- PROD0000071 -- Support to request events from club news on click of news
        //PROD0000071 -- Start
        if self.isRedirectToEventsDetail == 1 && eventobj.type == "1"
        {
            
            switch self.accessManager.accessPermission(eventCategory: eventobj.eventCategory!, type: eventobj.requestType!, departmentName: eventobj.DepartmentName ?? "")
            {
            case .view:
                break
            case .notAllowed:
                if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
                {
                    SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                }
                return
            case .allowed:
                break
            }
            
            guard eventobj.isMemberTgaEventNotAllowed != 1 && eventobj.type == "1" else
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.TGAMEMBERVALIDATION, withDuration: Duration.kMediumDuration)
                return
            }
            
            //Added by kiran V1.4 -- PROD0000071 -- Modified the logic to show event details when event is registration closed, Not open yet, no registerations and Confirmed.
            //PROD0000071 -- Start
            if eventobj.eventCategory?.lowercased() == "dining"
            {
                guard let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningEventRegistrationVC") as? DiningEventRegistrationVC else{return}
                
                switch eventobj.buttontextvalue ?? ""
                {
                case "0":
                    
                    if let externalUrl = eventobj.externalURL, !externalUrl.isEmpty
                    {
                        guard let url = URL(string: externalUrl) else { return }
                        UIApplication.shared.open(url)
                    }
                    else
                    {
                        registerVC.eventID = eventobj.eventID
                        registerVC.eventCategory = eventobj.eventCategory
                        registerVC.isViewOnly = true
                        registerVC.eventType = eventobj.isMemberCalendar
                        registerVC.requestID = eventobj.requestID
                        registerVC.isFrom = "RequestEvents"
                        registerVC.segmentIndex = 1
                        registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                        registerVC.showStatus = true
                        registerVC.strStatus = eventobj.eventstatus ?? ""
                        registerVC.strStatusColor = eventobj.colorCode ?? "#FFFFFF"
                        self.navigationController?.pushViewController(registerVC, animated: true)
                    }
                    
                case "3","4":
                    
                    registerVC.eventID = eventobj.eventID
                    registerVC.eventCategory = eventobj.eventCategory
                    registerVC.isViewOnly = true
                    registerVC.eventType = eventobj.isMemberCalendar
                    registerVC.requestID = eventobj.requestID
                    registerVC.isFrom = "RequestEvents"
                    registerVC.segmentIndex = 1
                    registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                    registerVC.showStatus = true
                    registerVC.strStatus = eventobj.eventstatus ?? ""
                    registerVC.strStatusColor = eventobj.colorCode ?? "#FFFFFF"
                    self.navigationController?.pushViewController(registerVC, animated: true)
                    
                case "1","2":
                    
                    registerVC.eventID = eventobj.eventID
                    registerVC.eventCategory = eventobj.eventCategory
                    registerVC.eventType = eventobj.isMemberCalendar
                    registerVC.requestID = eventobj.requestID
                    registerVC.isFrom = ((eventobj.buttontextvalue ?? "") == "1") ? "EventRequest" : "RequestEvents"
                    registerVC.segmentIndex = 1
                    registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                    self.navigationController?.pushViewController(registerVC, animated: true)
                    
                case "5":
                    guard let url = URL(string: eventobj.externalURL ?? "") else { return }
                    UIApplication.shared.open(url)
                    
                case "6":
                    
                    let stremail = eventobj.externalURL ?? ""
                    emailSubject = eventobj.eventName ?? ""
                    if(stremail == "")
                    {
                        
                    }
                    else
                    {
                        self.arrselectedEmails.removeAll()
                        self.arrselectedEmails.append(stremail)
                        
                        let mailComposeViewController = configuredMailComposeViewController()
                        if MFMailComposeViewController.canSendMail()
                        {
                            self.present(mailComposeViewController, animated: true, completion: nil)
                        }
                        else
                        {
                            self.showSendMailErrorAlert()
                        }
                    }
                    
                default :
                    break
                }
                
            }
            else
            {
                guard let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "RegisterEventVC") as? RegisterEventVC else{return}
                
                switch eventobj.buttontextvalue ?? ""
                {
                case "0":
                    
                    if let externalUrl = eventobj.externalURL, !externalUrl.isEmpty
                    {
                        guard let url = URL(string: externalUrl) else { return }
                        UIApplication.shared.open(url)
                    }
                    else
                    {
                        registerVC.eventID = eventobj.eventID
                        registerVC.eventCategory = eventobj.eventCategory
                        registerVC.eventType = eventobj.isMemberCalendar
                        registerVC.isViewOnly = true
                        registerVC.isFrom = "RequestEvents"
                        registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                        registerVC.showStatus = true
                        registerVC.strStatus = eventobj.eventstatus ?? ""
                        registerVC.strStatusColor = eventobj.colorCode ?? "#FFFFFF"
                        registerVC.segmentIndex = 1
                        self.navigationController?.pushViewController(registerVC, animated: true)
                    }
                    
                case "3","4":
                    
                    registerVC.eventID = eventobj.eventID
                    registerVC.eventCategory = eventobj.eventCategory
                    registerVC.eventType = eventobj.isMemberCalendar
                    registerVC.isViewOnly = true
                    registerVC.isFrom = "RequestEvents"
                    registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                    registerVC.showStatus = true
                    registerVC.strStatus = eventobj.eventstatus ?? ""
                    registerVC.strStatusColor = eventobj.colorCode ?? "#FFFFFF"
                    registerVC.segmentIndex = 1
                    self.navigationController?.pushViewController(registerVC, animated: true)
                    
                case "1","2":
                    
                    registerVC.eventID = eventobj.eventID
                    registerVC.eventCategory = eventobj.eventCategory
                    registerVC.eventType = eventobj.isMemberCalendar
                    registerVC.isFrom = "RequestEvents"
                    registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                    registerVC.segmentIndex = 1
                    self.navigationController?.pushViewController(registerVC, animated: true)
                    
                case "5":
                    guard let url = URL(string: eventobj.externalURL ?? "") else { return }
                    UIApplication.shared.open(url)
                    
                case "6":
                    
                    let stremail = eventobj.externalURL ?? ""
                    emailSubject = eventobj.eventName ?? ""
                    if(stremail == "")
                    {
                        
                    }
                    else
                    {
                        self.arrselectedEmails.removeAll()
                        self.arrselectedEmails.append(stremail)
                        
                        let mailComposeViewController = configuredMailComposeViewController()
                        if MFMailComposeViewController.canSendMail()
                        {
                            self.present(mailComposeViewController, animated: true, completion: nil)
                        }
                        else
                        {
                            self.showSendMailErrorAlert()
                        }
                    }
                    
                default :
                    break
                }
                
            }
            
            
            /*
            if eventobj.buttontextvalue == "2"
            {
                if eventobj.eventCategory?.lowercased() == "dining"
                {
                    if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningEventRegistrationVC") as? DiningEventRegistrationVC
                    {
                        registerVC.eventID = eventobj.eventID
                        registerVC.eventCategory = eventobj.eventCategory
                        if eventobj.buttontextvalue == "4"
                        {
                            registerVC.eventType = 2
                        }
                        else
                        {
                            registerVC.eventType = eventobj.isMemberCalendar
                        }
                        registerVC.requestID = eventobj.requestID
                        registerVC.isFrom = "RequestEvents"
                        registerVC.segmentIndex = 1
                        registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                        self.navigationController?.pushViewController(registerVC, animated: true)
                        
                    }
                }
                else
                {
                    if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "RegisterEventVC") as? RegisterEventVC
                    {
                        registerVC.isFrom = "RequestEvents"
                        registerVC.eventID = eventobj.eventID
                        registerVC.eventCategory = eventobj.eventCategory
                        registerVC.eventType = eventobj.isMemberCalendar
                        registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                        self.navigationController?.pushViewController(registerVC, animated: true)
                        
                    }
                }
                
            }
            else
            {
                if eventobj.eventCategory?.lowercased() == "dining"
                {
                    if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningEventRegistrationVC") as? DiningEventRegistrationVC
                    {
                        if eventobj.buttontextvalue == "5"
                        {
                            guard let url = URL(string: eventobj.externalURL ?? "") else { return }
                            UIApplication.shared.open(url)
                        }
                        else if eventobj.buttontextvalue == "6"
                        {
                            let stremail = eventobj.externalURL ?? ""
                            emailSubject = eventobj.eventName ?? ""
                            
                            if(stremail == "")
                            {
                                
                            }
                            else
                            {
                                self.arrselectedEmails.removeAll()
                                self.arrselectedEmails.append(stremail)
                                
                                let mailComposeViewController = configuredMailComposeViewController()
                                if MFMailComposeViewController.canSendMail()
                                {
                                    self.present(mailComposeViewController, animated: true, completion: nil)
                                }
                                else
                                {
                                    self.showSendMailErrorAlert()
                                }
                            }
                            
                        }
                        else
                        {
                            registerVC.eventID = eventobj.eventID
                            registerVC.eventCategory = eventobj.eventCategory
                            if eventobj.buttontextvalue == "4"
                            {
                                registerVC.eventType = 2
                            }
                            else
                            {
                                registerVC.eventType = eventobj.isMemberCalendar
                            }
                            registerVC.requestID = eventobj.requestID
                            registerVC.isFrom = "EventRequest"
                            registerVC.segmentIndex = 1
                            registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                            self.navigationController?.pushViewController(registerVC, animated: true)
                        }
                    }
                    
                }
                else
                {
                    if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "RegisterEventVC") as? RegisterEventVC
                    {
                        registerVC.isFrom = "EventRequest"
                        var events =  ListEvents()
                        events = arrEventList[indexPath!.row]
                        
                        if eventobj.buttontextvalue == "5"
                        {
                            guard let url = URL(string: events.externalURL ?? "") else { return }
                            UIApplication.shared.open(url)
                            
                        }
                        else if eventobj.buttontextvalue == "6"
                        {
                            let stremail = events.externalURL ?? ""
                            emailSubject = events.eventName ?? ""
                            if(stremail == "")
                            {
                            
                            }
                            else
                            {
                                self.arrselectedEmails.removeAll()
                                self.arrselectedEmails.append(stremail)
                            
                                let mailComposeViewController = configuredMailComposeViewController()
                                if MFMailComposeViewController.canSendMail()
                                {
                                    self.present(mailComposeViewController, animated: true, completion: nil)
                                }
                                else
                                {
                                    self.showSendMailErrorAlert()
                                }
                                
                            }
                            
                        }
                        else
                        {
                            registerVC.eventID = events.eventID
                            registerVC.eventCategory = events.eventCategory
                            registerVC.eventType = events.isMemberCalendar
                            registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                            self.navigationController?.pushViewController(registerVC, animated: true)
                            
                        }
                        
                    }
                    
                }
                
            }
         
            */
            //PROD0000071 -- End
        }
        else
        {
            if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ViewNewsViewController") as? ViewNewsViewController
            {
                clubNews.modalTransitionStyle   = .crossDissolve;
                clubNews.modalPresentationStyle = .overCurrentContext
                //clubNews.imgURl = eventobj.imageThumb
                //Added on 14th May 2020 v2.1
                let mediaDetails = MediaDetails()
                mediaDetails.type = .image
                mediaDetails.newsImage = eventobj.imageLarge ?? ""
                clubNews.arrMediaDetails = [mediaDetails]
                //Old logic
                //clubNews.arrImgURl = [["NewsImage" : eventobj.imageLarge ?? ""]]
                clubNews.isFrom = "Events"
                //Added on 19th May 2020 v2.1
                clubNews.contentType = .image
                
                self.present(clubNews, animated: true, completion: nil)
            }
        }
        //PROD0000071 -- End
        
    }
    

}

