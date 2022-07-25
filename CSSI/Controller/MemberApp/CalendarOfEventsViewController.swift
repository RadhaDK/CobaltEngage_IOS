//  CalendarOfEventsViewController.swift
//  CSSI
//  Created by apple on 11/2/18.
//  Copyright © 2018 yujdesigns. All rights reserved.

import UIKit
import ScrollableSegmentedControl
import Alamofire
import Popover
import DTCalendarView
import EventKit
import MessageUI

class CalendarOfEventsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIGestureRecognizerDelegate, MFMailComposeViewControllerDelegate, EventsCellDelegate {
    
    
    fileprivate var now = Date()
    fileprivate var currentDate = Date()

    
    var isFrom : NSString!
    /// Indicates if the user selection of date
    ///
    /// This is true when the user selects the date by clicking or draging
    var calendarDidSelectDate: Bool = false
    var isResetClicked = false
    fileprivate let calendar = Calendar.current

    @IBOutlet weak var eventDateRangeView: DTCalendarView!{
        
        didSet {
            eventDateRangeView.delegate = self
            
            eventDateRangeView.displayEndDate = Date(timeIntervalSinceNow: 60 * 60 * 24 * 30 * 12 * 40)
            eventDateRangeView.previewDaysInPreviousAndMonth = false
            
            let lastYear = Calendar.current.date(byAdding: .year, value: -20, to: Date())
            
            let currentTimeStamp = lastYear!.toMillis()
            now = lastYear!
            
            let intValue = NSNumber(value: currentTimeStamp!).intValue
            
            eventDateRangeView.displayStartDate =  Date(timeIntervalSince1970: TimeInterval(intValue))
        }
    }
    
    
    @IBOutlet weak var segmenMainView: UIView!
    fileprivate let monthYearFormatter: DateFormatter = {
    
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        
        formatter.dateFormat = "MMMM"
        
        return formatter
    }()
    fileprivate let YearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        
        formatter.dateFormat = "YYYY"
        
        return formatter
    }()

    @IBOutlet weak var lblNameAndID: UILabel!
    @IBOutlet weak var eventSearchBar: UISearchBar!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var uiSegmentView: UIView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var eventsTableview: UITableView!
    @IBOutlet weak var calanderView: UIView!
    @IBOutlet weak var lblyear: UILabel!
    @IBOutlet weak var lblMonthName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    ///Calender close
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var viewCalander: UIView!
    ///Calendar date rest
    @IBOutlet weak var btnReset: UIButton!
    ///Calendar submit
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var viewLoadMore: UIView!
    @IBOutlet weak var btnLoadMore: UIButton!
    
    
    
    var arrselectedEmails = [String]()
    var emailSubject : String?
    var arrEventCategory = [ListEventCategory]()
    var calendarRangeStartDate : String!
    var calendarRangeEndDate : String!

    var segmentedController = ScrollableSegmentedControl()
    var filterPopover: Popover? = nil
    var eventCategory: NSString!
    var filterByDepartment : String!
    var filterByDate : String!
    var id : String!
    var filterBarButtonItem: UIBarButtonItem!

    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrEventList = [ListEvents]()

    var refreshControl = UIRefreshControl()
    var filterBy : String = "OldToNew"
    
    var filterByEventStatus : EventStatusFilter?
    
    /**used to identify load more button tap*/
    //Note:- using this variable to identify when to append the api response to arrEvents, becasue when trying to scrollng the tableview to the last index of the arrEvents(last Index before appening the api response to arrEvents) after appending the response to arrEvents the app crashes. This way user dosent have to scroll from first again with out programatically scrollig to the index.
    private var isLoadMoreClicked = false
    
    /**Month Count sent in the request*/
    private lazy var monthCount : Int = 0
    
    private var isSortFilterApplied : Int = 0
    
    /// Hold the previous selection start date of calendar
    private var calendarPreviousStartDate : String!
    
    /// Holds the previous selection end date of calendar
    private var calendarPreviousEndDate : String!
    
    //Added on 4th July 2020 V2.2
    private let accessManager = AccessManager.shared
    
    //Added by kiran V1.3 -- PROD0000071 -- Support to request events from club news on click of news
    //PROD0000071 -- Start
    private var isRedirectToEventsDetail : Int?
    //PROD0000071 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        self.getEventCategoriesApi(strSearch : "")
         //self.monthCount = self.initialMonthCount
        viewCalander.layer.masksToBounds = true
        viewCalander.layer.cornerRadius = 8
        viewCalander.layer.borderWidth = 0.6
        viewCalander.layer.borderColor = hexStringToUIColor(hex: "A9A9A9").cgColor

        eventSearchBar.searchBarStyle = .default
        
        eventSearchBar.layer.borderWidth = 1
        eventSearchBar.layer.borderColor = hexStringToUIColor(hex: "F5F5F5").cgColor
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        lblDate.text = String(format: "%d",components.day!)
        lblyear.text = String(format: "%d",components.year!)
       
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM"
        
        let dateAndMonth: String = dateFormat.string(from: date)
        
        lblMonthName.text = dateAndMonth
        self.lblNameAndID.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)

        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
       // self.navigationController?.navigationBar.isHidden = false
        
        let calandergesture = UITapGestureRecognizer(target: self, action:  #selector(self.calander(sender:)))
        self.calanderView.addGestureRecognizer(calandergesture)

        
        filterBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Filter"), style: .plain, target: self, action: #selector(onTapFilter))
        navigationItem.rightBarButtonItem = filterBarButtonItem
        
        btnLoadMore.backgroundColor = .clear
        btnLoadMore.layer.cornerRadius = 18
        btnLoadMore.layer.borderWidth = 1
        btnLoadMore.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        btnLoadMore.setTitle(self.appDelegate.masterLabeling.SHOW_MORE ?? "", for: .normal)
        
        viewCalander.layer.shadowColor = UIColor.white.cgColor
        viewCalander.layer.shadowOpacity = 1
        viewCalander.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewCalander.layer.shadowRadius = 6
        
        
        segmenMainView.layer.shadowColor = UIColor.lightGray.cgColor
        segmenMainView.layer.shadowOpacity = 1.0
        segmenMainView.layer.shadowOffset = CGSize(width: 2, height: 2)
        segmenMainView.layer.shadowRadius = 4

        self.eventsTableview.separatorColor = UIColor.clear

        self.eventsTableview.register(UINib(nibName: "MyCalendarXib", bundle: nil), forCellReuseIdentifier: "MyCalendarXib")
        
      
        self.btnSubmit.calendarBttnViewSetup()
        self.btnSubmit.setTitle(self.appDelegate.masterLabeling.CALENDER_FILTER ?? "", for: .normal)
        self.btnClose.calendarBttnViewSetup()
        self.btnClose.setTitle(self.appDelegate.masterLabeling.CALENDER_CLOSE ?? "", for: .normal)
        self.btnReset.calendarBttnViewSetup()
        self.btnReset.setTitle(self.appDelegate.masterLabeling.CALENDER_CLEAR ?? "", for: .normal)
        
        
        self.lblMonthName.backgroundColor = APPColor.MainColours.primary3
        self.eventDateRangeView.setDisplayAttributes(DisplayAttributes.init(font: UIFont.systemFont(ofSize: 15), textColor: .white, backgroundColor: APPColor.MainColours.primary2, textAlignment: .center), forState: .selected)
        self.eventDateRangeView.setDisplayAttributes(DisplayAttributes.init(font: UIFont.systemFont(ofSize: 15), textColor: .white, backgroundColor: APPColor.MainColours.primary2, textAlignment: .center), forState: .highlighted)
      
        
        self.btnLoadMore.setStyle(style: .outlined, type: .primary)
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    
    //MARK:- Calendar button clicked
    @objc func calander(sender : UITapGestureRecognizer)
    {
        self.calendarPreviousStartDate = self.calendarRangeStartDate
        self.calendarPreviousEndDate = self.calendarRangeEndDate
        
        
        if self.calendarRangeStartDate != ""
        {
            if let strDate = self.calendarRangeStartDate, let date = SharedUtlity.sharedHelper()?.dateFormatter.date(from: strDate)
            {
                self.eventDateRangeView.selectionStartDate =  date
            }
            else
            {
                self.eventDateRangeView.selectionStartDate = Date()
            }
            
        }
        else
        {
            self.eventDateRangeView.selectionStartDate = Date()
        }
        
        
        if self.calendarRangeEndDate != "" , self.calendarRangeEndDate != nil
        {
            if let strDate = self.calendarRangeEndDate , let date = SharedUtlity.sharedHelper()?.dateFormatter.date(from: strDate)
            {
                self.eventDateRangeView.selectionEndDate =  date
            }
            
        }
        
        
        if let startDatestr = calendarRangeStartDate , let endDatestr = calendarRangeEndDate , let startDate = SharedUtlity.sharedHelper()?.dateFormatter.date(from: startDatestr) , let endDate = SharedUtlity.sharedHelper()?.dateFormatter.date(from: endDatestr)
        {
            if startDate == endDate
            {
                self.eventDateRangeView.selectionEndDate = nil
            }
        }
        
        //OLd logic
        /*
         if self.eventDateRangeView.selectionStartDate == nil || self.calendarRangeStartDate == ""
         {
             if let strDate = self.calendarRangeStartDate as? String, let date = SharedUtlity.sharedHelper()?.dateFormatter.date(from: strDate),self.currentDate(matchesMonthAndYearOf: date)
             {
                 self.eventDateRangeView.selectionStartDate =  date
             }
             else
             {
                 self.eventDateRangeView.selectionStartDate = Date()
             }
             
         }
         */
        
        
        if let date = self.eventDateRangeView.selectionStartDate
        {
             self.eventDateRangeView.scrollTo(month: date, animated: true)
        }
       
        eventDateRangeView.isHidden = false
        eventsTableview.isHidden = true
        btnClose.isHidden = false
        calanderView.isHidden = true
        btnReset.isHidden = false
        btnSubmit.isHidden = false
        lblNameAndID.isHidden = true
        eventSearchBar.isHidden = true
        self.navigationItem.rightBarButtonItem = nil;

    }
    
    
    @IBAction func loadMoreClicked(_ sender: UIButton) {
        self.monthCount += 1
        self.isLoadMoreClicked = true
        self.eventApi(strSearch: "")
    }
    
    
    //MARK:- Calendar submit,close,reset actions
    @IBAction func submitClicked(_ sender: UIButton)
    {
        if self.calendarDidSelectDate || self.isResetClicked
        {
            if self.calendarDidSelectDate
            {
                calendarDidSelectDate = false
                self.calendarRangeStartDate = ""
                self.calendarRangeEndDate = ""
                if let date = self.eventDateRangeView.selectionStartDate
                {
                    self.calendarRangeStartDate = SharedUtlity.sharedHelper()?.dateFormatter.string(from: date)
                }
                
                if let date = self.eventDateRangeView.selectionEndDate
                {
                    self.calendarRangeEndDate = SharedUtlity.sharedHelper()?.dateFormatter.string(from: date)
                }
                else
                {
                    self.calendarRangeEndDate = self.calendarRangeStartDate
                }
                
            }
            else if isResetClicked
            {
                self.eventDateRangeView.selectionStartDate = nil
                self.eventDateRangeView.selectionEndDate = nil
                isResetClicked = false
            }
            
        }
        else
        {
            
            if calendarRangeStartDate == "" || calendarRangeStartDate == nil
            {
                calendarRangeStartDate = SharedUtlity.sharedHelper().dateFormatter.string(from: Date())
            }
            
            if calendarRangeEndDate == "" || calendarRangeEndDate == nil
            {
                calendarRangeEndDate = SharedUtlity.sharedHelper().dateFormatter.string(from: Date())
            }
            
        }
        
        //Old Logic
        /*
         if calendarDidSelectDate == true{
             calendarDidSelectDate = false
         }else
         {
             if self.isResetClicked
             {
                 self.isResetClicked = false
                 calendarRangeStartDate = SharedUtlity.sharedHelper().dateFormatter.string(from: Date()) as NSString
                 calendarRangeEndDate = SharedUtlity.sharedHelper().dateFormatter.string(from: Date()) as NSString
             }
            
         }
         */
        
        calanderView.isHidden = false
        btnClose.isHidden = true
        eventDateRangeView.isHidden = true
        eventsTableview.isHidden = false
        btnReset.isHidden = true
        btnSubmit.isHidden = true
        lblNameAndID.isHidden = false
        self.monthCount = 0
        self.eventApi(strSearch: eventSearchBar.text!)
        eventSearchBar.isHidden = false
        self.navigationItem.rightBarButtonItem = filterBarButtonItem;
        
        
    }
    
    @IBAction func closeClicked(_ sender: Any)
    {
        self.calendarDidSelectDate = false
        self.eventDateRangeView.selectionStartDate = nil
        self.eventDateRangeView.selectionEndDate = nil
        calendarRangeStartDate = self.calendarPreviousStartDate
        calendarRangeEndDate = self.calendarPreviousEndDate
        
//        if self.calendarDidSelectDate
//        {
//            self.calendarDidSelectDate = false
//            self.eventDateRangeView.selectionStartDate = nil
//            self.eventDateRangeView.selectionEndDate = nil
//            calendarRangeStartDate = self.calendarPreviousStartDate
//            calendarRangeEndDate = self.calendarPreviousEndDate
//        }
//        else
//        {
//            if calendarRangeStartDate == "" || calendarRangeStartDate == nil
//            {
//                calendarRangeStartDate = SharedUtlity.sharedHelper().dateFormatter.string(from: Date()) as NSString
//
//            }
//            if calendarRangeEndDate == "" || calendarRangeEndDate == nil
//            {
//                calendarRangeEndDate = SharedUtlity.sharedHelper().dateFormatter.string(from: Date()) as NSString
//            }
//        }
        
        //old logic
        /*
         if calendarDidSelectDate
         {
             calendarDidSelectDate = false
             if self.isResetClicked
             {
                 calendarRangeStartDate = ""
                 calendarRangeEndDate = ""
             }
         }
         */
        
        calanderView.isHidden = false
        btnClose.isHidden = true
        eventDateRangeView.isHidden = true
        eventsTableview.isHidden = false
        btnReset.isHidden = true
        btnSubmit.isHidden = true
        lblNameAndID.isHidden = false
        eventSearchBar.isHidden = false
        self.navigationItem.rightBarButtonItem = filterBarButtonItem;
        
        if self.isResetClicked
        {
            self.eventApi(strSearch: eventSearchBar.text!)
            self.isResetClicked = false
        }

    }
    
    @IBAction func resetClicked(_ sender: Any)
    {
        calendarDidSelectDate = false
        self.isResetClicked = true
        eventDateRangeView.selectionStartDate = nil
        eventDateRangeView.selectionEndDate = nil
        self.monthCount = 0
        calendarRangeStartDate = ""
        calendarRangeEndDate = ""
        
        self.calendarPreviousStartDate = ""
        self.calendarPreviousEndDate = ""

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if(self.navigationController?.navigationBar.isHidden == true) || self.appDelegate.closeFrom == "EventTennisUpdate" || self.appDelegate.closeFrom == "DiningEvent" || self.appDelegate.eventsCloseFrom == "My" || self.appDelegate.closeFrom == "BMSFlow"{
            self.appDelegate.closeFrom = ""
            
            self.isSortFilterApplied = 1
//          self.getEventCategoriesApi(strSearch : "")
            self.eventApi(strSearch: self.eventSearchBar.text ?? "")
           
        }
        
        self.navigationController?.navigationBar.isHidden = false
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        // self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
       

        //Added on 17th October 2020 V2.3
        self.navigationController?.navigationBar.setNeedsLayout()

        
        eventDateRangeView.isHidden = true
        eventsTableview.isHidden = false
        btnClose.isHidden = true
        btnReset.isHidden = true
        btnSubmit.isHidden = true
        lblNameAndID.isHidden = false

        let now = Date()
        if eventDateRangeView.selectionStartDate == nil && eventDateRangeView.selectionEndDate == nil{
            eventDateRangeView.selectionStartDate = now
            
        }else{
            
        }
        
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = self.appDelegate.masterLabeling.calendar_of_events ?? "" as String
        eventSearchBar.placeholder = self.appDelegate.masterLabeling.search_events ?? "" as String
        
        
       // eventDateRangeView.scrollTo(month: eventDateRangeView.displayStartDate, animated: false)
        eventDateRangeView.scrollTo(month: currentDate, animated: false)

        self.isAppAlreadyLaunchedOnce()

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //  IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
  
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnceCalendar"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnceCalendar")
            if let impVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "PopUpForCategoryVC") as? PopUpForCategoryVC {
                impVC.isFrom = "Events"
                impVC.modalTransitionStyle   = .crossDissolve;
                impVC.modalPresentationStyle = .overCurrentContext
                self.present(impVC, animated: true, completion: nil)
            }
            print("App launched first time")
            return false
        }
    }
    fileprivate func currentDate(matchesMonthAndYearOf date: Date) -> Bool {
        let nowMonth = calendar.component(.month, from: now)
        let nowYear = calendar.component(.year, from: now)
        
        let askMonth = calendar.component(.month, from: date)
        let askYear = calendar.component(.year, from: date)
        
        if nowMonth == askMonth && nowYear == askYear {
            return true
        }
        
        return false
    }


    
  
    @IBAction func nextClicked(_ sender: Any) {
        self.monthCount = 0
        if self.arrEventCategory.count == 0 {
            
        }else{
        var selectedSegment =  self.segmentedController.selectedSegmentIndex  + 1
        
        
        if selectedSegment >= self.segmentedController.numberOfSegments  {
            selectedSegment = self.segmentedController.numberOfSegments - 1
        }
        
        
        self.appDelegate.selectedEventsCategory = self.arrEventCategory[selectedSegment]
        
        
        self.segmentedController.selectedSegmentIndex = selectedSegment
        }}
    
    @IBAction func previousClicked(_ sender: Any) {
        self.monthCount = 0
        if self.arrEventCategory.count == 0 {
            
        }else{
        var selectedSegment =  self.segmentedController.selectedSegmentIndex  - 1
        if selectedSegment <= 0  {
            selectedSegment = 0
        }
        self.appDelegate.selectedEventsCategory = self.arrEventCategory[selectedSegment]
        self.segmentedController.selectedSegmentIndex = selectedSegment
        
        }
    }
    
    //MARK:- Segment Controller Selected
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        // print("Segment at index \(sender.selectedSegmentIndex)  selected")
        self.arrEventList.removeAll()
        
        self.eventsTableview.reloadData()
        
        
        self.appDelegate.selectedEventsCategory = self.arrEventCategory[sender.selectedSegmentIndex]

        if(sender.selectedSegmentIndex == 0) {
//            self.calanderView.isHidden = false
//            self.appDelegate.selectedSegment = "0"

        }else{
            
        }
        
       // print()
        eventCategory = self.appDelegate.selectedEventsCategory.categoryName! as NSString
        
        self.monthCount = 0
        self.eventApi(strSearch: eventSearchBar.text!)

    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onTapFilter() {

        
        if let filterView = UINib(nibName: "GuestListFilterView", bundle: Bundle.main).instantiate(withOwner: GuestListFilterView.self, options: nil).first as? GuestListFilterView{
            filterPopover = Popover()
            filterView.filterWithDepartment = filterByDepartment
            filterView.filterWithDate = filterByDate
            filterView.isFromGuest = 0
            filterView.filterWithEventStatus = self.filterByEventStatus ?? EventStatusFilter()
            let screenSize = UIScreen.main.bounds
            filterView.showStatusFilter = !(self.appDelegate.selectedEventsCategory.categoryName! as NSString == "My Calendar")
            filterView.frame = CGRect(x:4, y: 88, width:Int(screenSize.width - 8), height: ((self.appDelegate.arrCalenderSortFilter.count * 38) + 180))

            filterPopover?.arrowSize = CGSize(width: 28.0, height: 13.0)
            filterPopover?.sideEdge = 4.0
            filterView.delegate = self
            filterView.eventsArrayFilter = self.arrEventCategory
            let point = CGPoint(x: self.view.bounds.width - 35, y: 70)
            filterPopover?.show(filterView, point: point)
        }
    }
  
    //MARK:- Get Event Categories
    func getEventCategoriesApi(strSearch :String) -> Void {
        

        if (Network.reachability?.isReachable) == true{
            
            arrEventCategory = [ListEventCategory]()
            self.arrEventCategory.removeAll()
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.getEventCategory(paramater: paramaterDict, onSuccess: { categoriesList in
                self.appDelegate.hideIndicator()
                if(categoriesList.responseCode == InternetMessge.kSuccess){
                    self.arrEventCategory.removeAll()
                    
                    if(categoriesList.listcategories == nil){
                        self.arrEventCategory.removeAll()
                        
                        // self.appDelegate.hideIndicator()
                    }
                    else{
                        self.arrEventCategory.removeAll()
                        
                        self.arrEventCategory = categoriesList.listcategories!
                        
                        self.appDelegate.selectedEventsCategory = self.arrEventCategory[0]
                        
                        self.loadsegmentController()
                    }
                }else{
                    if(((categoriesList.responseMessage!.count) )>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: categoriesList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                }
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
        }else{
            
            //self.tableViewStatement.setEmptyMessage(InternetMessge.kInternet_not_available)
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
    }
    
    //Mark- Get Event List Api
    func eventApi(strSearch :String?, filter: GuestCardFilter? = nil) {
        
        self.viewLoadMore.isHidden = true

        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            if isFrom == "TeeTimes"{
                eventCategory = "Golf"
                
            for i in 0 ..< self.arrEventCategory.count {
                let statementData = self.arrEventCategory[i]
                if statementData.categoryName == "Golf" {
                    self.segmentedController.selectedSegmentIndex = i
                }
            }

            }
            if isFrom == "CourtTimes"{
                eventCategory = "Tennis"
                for i in 0 ..< self.arrEventCategory.count {
                    let statementData = self.arrEventCategory[i]
                    if statementData.categoryName == "Tennis" {
                        self.segmentedController.selectedSegmentIndex = i
                    }
                }
            }
            if isFrom == "DiningReservation"{
                eventCategory = "Dining"
                for i in 0 ..< self.arrEventCategory.count {
                    let statementData = self.arrEventCategory[i]
                    if statementData.categoryName == "Dining" {
                        self.segmentedController.selectedSegmentIndex = i
                    }
                }
            }
            
            
            if calendarRangeEndDate == "" {
                calendarRangeEndDate = calendarRangeStartDate
            }
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.ksearchby: strSearch ?? "",
                APIKeys.kDeviceType: "App",
                APIKeys.keventCategory: eventCategory ?? "",
                
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "DateSort" : filterBy,
                "EventStartDate" : calendarRangeStartDate ?? "",
                "EventEndDate" : calendarRangeEndDate ?? "",
                APIKeys.kmonthCount : self.eventCategory != "My Calendar" ? self.monthCount : 0,
                APIKeys.kIsSortFilterApplied : self.eventCategory != "My Calendar" ? self.isSortFilterApplied : 0,
                APIKeys.kEventStatusSort : self.filterByEventStatus?.id ?? ""
                
            ]
            
            print(paramaterDict)
            APIHandler.sharedInstance.getEventsList(paramaterDict: paramaterDict, onSuccess: { eventList in
                self.appDelegate.hideIndicator()
                self.isFrom = ""

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
                        else
                        {
                            self.arrEventList.removeAll()
                            self.eventsTableview.setEmptyMessage(InternetMessge.kNoData)
                            self.eventsTableview.reloadData()
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
                                self.eventsTableview.setEmptyMessage(InternetMessge.kNoData)
                                self.eventsTableview.reloadData()
                            }
                            
                            self.appDelegate.hideIndicator()
                            
                        }else{
                            self.eventsTableview.restore()
                            
                            if self.isLoadMoreClicked && self.isSortFilterApplied != 1
                            {
                                 self.arrEventList.append(contentsOf: eventList.eventsList!)
                            }
                            else
                            {
                                self.arrEventList = eventList.eventsList!
                            }
                            self.viewLoadMore.isHidden = eventList.isLoadMore == 0
                            self.eventsTableview.reloadData()
                            
                        }
                        
                    }
                    
                    if(!(self.arrEventList.count == 0) && (!self.isLoadMoreClicked || self.isSortFilterApplied == 1))
                    {
                        self.isLoadMoreClicked = false
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.eventsTableview.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    
                    }
                    
                    self.isLoadMoreClicked = false
                    self.monthCount = eventList.monthCount ?? 0
                    self.isSortFilterApplied =  self.filterBy == "OldToNew" ? 0 : 1
                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((eventList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: eventList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.eventsTableview.setEmptyMessage(eventList.responseMessage ?? "")
                    
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
    
    
    //Added on 1st July 2020 BMS
    //Gets the department Settings for BMS
    private func getDepartmentSettings(eventObj : ListEvents , completed : @escaping ([DepartmentDetails]?)->())
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
        //Added by kiran V2.9 -- GATHER0001167 -- Added support for Golf Bal
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
            self?.appDelegate.hideIndicator()
            completed(departments.departmentsDetails)
            
        }) { [weak self] (error) in
            self?.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper().showToast(on:
                           self?.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
    }
    
    //Added on 1st July 2020 BMS
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
            SharedUtlity.sharedHelper().showToast(on:
                           self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
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
    
    //Mark- Tableview Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if eventCategory == "My Calendar"{
            
            let cell = self.eventsTableview.dequeueReusableCell(withIdentifier: "MyCalendarXib") as! MyCalendarXib
            
            
            var eventobj =  ListEvents()
            eventobj = arrEventList[indexPath.row]
            cell.lblEventName.text = eventobj.eventName
            
            cell.btnViewOnly.setTitle("", for: .normal)
            
            self.eventsTableview.allowsSelection = false
            if eventobj.type == "2" {
                cell.lblTime.text = String(format: "%@", eventobj.eventTime ?? "")
                cell.lblConfirmationID.isHidden = false
                cell.lblConfirmationID.text = eventobj.confirmationNumber ?? ""
                cell.lblLocation.text = eventobj.location
                
            }else if eventobj.eventCategory?.lowercased() == "dining" {
                    cell.lblTime.text = String(format: "%@", eventobj.eventTime ?? "")
                
                cell.lblConfirmationID.isHidden = false
                cell.lblConfirmationID.text = eventobj.confirmationNumber ?? ""
                cell.lblLocation.text = eventobj.eventVenue
            }//Added on 1st July 2020 BMS
            //type 3 is BMS
            else if eventobj.requestType == .BMS || eventobj.type == "3"
            {
                //Modified on 6th July 2020 v2.3
                cell.lblTime.text = String(format: "%@ - %@", eventobj.eventTime ?? "",eventobj.eventendtime ?? "")
                cell.lblConfirmationID.isHidden = false
                cell.lblConfirmationID.text = eventobj.confirmationNumber ?? ""
                cell.lblLocation.text = eventobj.location
            }
            else{
                if eventobj.eventendtime == "" {
                    cell.lblTime.text = String(format: "%@", eventobj.eventTime ?? "")
                }else{
                    cell.lblTime.text = String(format: "%@ - %@", eventobj.eventTime ?? "", eventobj.eventendtime ?? "")
                }
                cell.lblConfirmationID.isHidden = true
                cell.lblLocation.text = eventobj.eventVenue
                
            }
            
            
            if(eventobj.eventCategory?.lowercased() == "dining") && eventobj.type == "2"{
                cell.lblPartySize.text = String(format: "%@ %@", self.appDelegate.masterLabeling.party_size_colon ?? "",eventobj.partySize ?? "")
                
            }else{
                cell.lblPartySize.text = ""
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
           
            
            if eventobj.eventstatus == "" && eventobj.colorCode == "" {
                cell.lblStatus.isHidden = true
                cell.lblStatusColor.isHidden = true
                cell.lblStatusValue.isHidden = true
                
            }else{
                cell.lblStatus.isHidden = false
                cell.lblStatusColor.isHidden = false
                cell.lblStatusValue.isHidden = false
                
            }
            cell.lblStatus.text = self.appDelegate.masterLabeling.status
            
            cell.lblStatusColor.backgroundColor = hexStringToUIColor(hex: eventobj.colorCode ?? "")
            
            cell.lblDate.text = weekDay
            cell.lblMonth.text = dateAndMonth
            cell.lblWeekDay.text = eventobj.eventDayName
            
            if(eventobj.buttontextvalue == "0"){
                cell.btnRegister.isHidden = true
                cell.btnRegister .setTitle("", for: UIControlState.normal)
                
            }
            else if(eventobj.buttontextvalue == "1") {
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
            
            cell.btnViewOnly.setTitle(self.appDelegate.masterLabeling.VIEW, for: .normal)
            cell.btnViewOnly.isHidden = !(eventobj.buttontextvalue == "2")
            
            cell.lblStatusValue.text = eventobj.memberEventStatus ?? ""
            
            cell.delegate = self
            
            //Added on 1st July 2020 BMS
            
            cell.btnCancel.isHidden = !(eventobj.showCancelButton ?? false)
            
            if eventobj.requestType == .BMS
            {
                cell.btnViewOnly.isHidden = !(eventobj.showViewButton ?? false)
            }
            
            cell.btnCancel.BMSCancelBthViewSetup()
            cell.btnCancel.setTitle(self.appDelegate.masterLabeling.cANCEL ?? "", for: .normal)
            cell.lblMonth.textColor = APPColor.MainColours.primary2
            cell.btnCancel.setStyle(style: .outlined, type: .secondary)
            return cell
        }
        else
        {
        let cell:EventCustomTableViewCell = self.eventsTableview.dequeueReusableCell(withIdentifier: "eventsIdentifier") as! EventCustomTableViewCell
        var eventobj =  ListEvents()
        eventobj = arrEventList[indexPath.row]
        cell.lblEventName.text = eventobj.eventName
        
        cell.btnViewOnly.setTitle("", for: .normal)
        cell.btnExternallink.setTitleColor(APPColor.MainColours.primary2, for: .normal)
            
        if eventobj.type == "2" {
            cell.lblEventTime.text = String(format: "%@", eventobj.eventTime ?? "")
            cell.lblMyConfirmationNo.isHidden = false
            cell.lblMyConfirmationNo.text = eventobj.confirmationNumber ?? ""
            cell.lblEventPlace.text = eventobj.location

        }else if eventobj.eventCategory?.lowercased() == "dining" {
             if(eventCategory == "My Calendar"){
                cell.lblEventTime.text = String(format: "%@", eventobj.eventTime ?? "")
             }else{
                if eventobj.eventendtime == "" {
                    cell.lblEventTime.text = String(format: "%@", eventobj.eventTime ?? "")
                }else{
                    cell.lblEventTime.text = String(format: "%@ - %@", eventobj.eventTime ?? "", eventobj.eventendtime ?? "")
                }
            }
            cell.lblMyConfirmationNo.isHidden = false
            cell.lblMyConfirmationNo.text = eventobj.confirmationNumber ?? ""
            cell.lblEventPlace.text = eventobj.eventVenue
        }else{
            if eventobj.eventendtime == "" {
                cell.lblEventTime.text = String(format: "%@", eventobj.eventTime ?? "")
            }else{
                cell.lblEventTime.text = String(format: "%@ - %@", eventobj.eventTime ?? "", eventobj.eventendtime ?? "")
            }
        cell.lblMyConfirmationNo.isHidden = true
        cell.lblEventPlace.text = eventobj.eventVenue

        }
        
        
        if(eventobj.eventCategory?.lowercased() == "dining") && eventobj.type == "2"{
            cell.lblPartySize.text = String(format: "%@ %@", self.appDelegate.masterLabeling.party_size_colon ?? "",eventobj.partySize ?? "")

        }else{
            cell.lblPartySize.text = ""
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
            cell.regStatus.isHidden = true
            cell.statusHeight.constant = 0

        }else{
            cell.lblStatus.isHidden = false
            cell.lblStatusColor.isHidden = false
            cell.regStatus.isHidden = false
            cell.statusHeight.constant = 20
            
        }
        cell.lblStatus.text = self.appDelegate.masterLabeling.status
        
        cell.lblStatusColor.backgroundColor = hexStringToUIColor(hex: eventobj.colorCode ?? "")
        cell.lblDate.text = weekDay
        cell.lblDay.text = dateAndMonth
        cell.lblWeekDay.text = eventobj.eventDayName
        
        
        if(eventobj.buttontextvalue == "0"){
            //cell.statusWidth.constant = 20

            cell.btnRegister.isHidden = true
            cell.btnRegister .setTitle("", for: UIControlState.normal)

        }
        else if(eventobj.buttontextvalue == "1") || (eventobj.buttontextvalue == "5") || (eventobj.buttontextvalue == "6"){
            cell.btnRegister.isHidden = false
            //cell.statusWidth.constant = 128

            cell.btnRegister .setTitle(self.appDelegate.masterLabeling.event_request, for: UIControlState.normal)
            
        }
        else if(eventobj.buttontextvalue == "2"){
            cell.btnRegister.isHidden = false
            //cell.statusWidth.constant = 128

            cell.btnRegister .setTitle(self.appDelegate.masterLabeling.event_modify, for: UIControlState.normal)
            cell.btnViewOnly.setTitle(self.appDelegate.masterLabeling.VIEW, for: .normal)
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
        
        //Shown in modify case only
            
        cell.btnViewOnly.isHidden = !(eventobj.buttontextvalue == "2")

        if(eventCategory == "My Calendar"){
            cell.regStatus.text = eventobj.memberEventStatus ?? ""
        }
        else{
            cell.regStatus.text = eventobj.eventstatus ?? ""
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
        if(imageURLString.count>0){
            let validUrl = self.verifyUrl(urlString: imageURLString)
            if(validUrl == true){
                
                let url = URL.init(string:imageURLString)
                cell.imgEventImage.sd_setImage(with: url , placeholderImage: placeHolderImage)

            }
        }
        */
        //ENGAGE0011419 -- End
        cell.delegate = self
        
        cell.imgEventImage.layer.cornerRadius = 16
        cell.imgEventImage.layer.masksToBounds = true
        cell.imgEventImage.layer.borderColor = hexStringToUIColor(hex: "F5F5F5").cgColor
        cell.imgEventImage.layer.borderWidth = 1.0
            
        cell.viewBttns.isHidden = cell.btnRegister.isHidden && cell.btnViewOnly.isHidden
            cell.lblDay.textColor = APPColor.MainColours.primary2
            return cell
        }
        
    }
    
    func synchButtonClicked(cell: EventCustomTableViewCell) {
        
        let indexPath = self.eventsTableview.indexPath(for: cell)
        self.syncCalender(indexPath: indexPath)
//        var events =  ListEvents()
//        events = arrEventList[indexPath!.row]
//        if events.type == "1"{
//
//
//        if let eventDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "EventDetailsVC") as? EventDetailsVC{
//            if events.eventCategory?.lowercased() == "dining" {
//                if(eventCategory == "My Calendar"){
//                    eventDetails.isFrom = "DiningRes"
//                }
//            }
//
//            eventDetails.arrEventDetails = [arrEventList[indexPath!.row]]
//            self.navigationController?.pushViewController(eventDetails, animated: true)
//        }
//        }
//        else{
//            if let synchDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "GolfSyncCalendarVC") as? GolfSyncCalendarVC{
//
//                synchDetails.requestID = events.eventID
//                synchDetails.arrEventDetails = [arrEventList[indexPath!.row]]
//                synchDetails.isFrom = events.eventCategory!
//                synchDetails.eventRegistrationDetailID = events.eventRegistrationDetailID ?? ""
//                self.navigationController?.pushViewController(synchDetails, animated: true)
//            }
//        }
    
    }
    
    func syncCalender(indexPath : IndexPath?)
    {
        var events =  ListEvents()
        events = arrEventList[indexPath!.row]
        // type 1 is Event
        if events.type == "1"{
            
            
            if let eventDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "EventDetailsVC") as? EventDetailsVC{
                if events.eventCategory?.lowercased() == "dining" {
                    if(eventCategory == "My Calendar"){
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
                synchDetails.eventRegistrationDetailID = events.eventRegistrationDetailID ?? ""
                self.navigationController?.pushViewController(synchDetails, animated: true)
            }
        }
        
    }
    
    func externalLinkClicked(cell: EventCustomTableViewCell)
    {
        let indexPath = self.eventsTableview.indexPath(for: cell)
        
        var events =  ListEvents()
        events = arrEventList[indexPath!.row]
        
        guard let url = URL(string: events.externalURL ?? "") else { return }
        UIApplication.shared.open(url)


    }
    
    
    func registrationButtonClicked(cell: EventCustomTableViewCell) {
        
        
        let indexPath = self.eventsTableview.indexPath(for: cell)
        self.requestClicked(indexPath: indexPath , bttnTitle: cell.btnRegister.titleLabel?.text)
        
       
    }
    
    //Added on 18th June 2020 BMS
    //This will not be displayed here. as it was ment for my calendar from fitness&spa screen or other reservation screeens
    func cancelClicked(cell: EventCustomTableViewCell)
    {
        
        
    }
    
    func requestClicked(indexPath: IndexPath? , bttnTitle : String?){
        var eventobj =  ListEvents()
        eventobj = arrEventList[indexPath!.row]
        
        //Added on 4th July 2020 V2.2
        //Added roles and privilages changes
        //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments. Added department name for BMS sub category(eg. fitness , spa ,salon, etc..) permissions.
        switch self.accessManager.accessPermission(eventCategory: eventobj.eventCategory!, type: eventobj.requestType!, departmentName: eventobj.DepartmentName ?? "") {
        case .view:
            if bttnTitle == "Cancel"
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
        
        //This scenario wont happen for fitness and spa or BMS as we have a sepearte cancel button for them
        if(bttnTitle == "Cancel"){
            
            var eventobj =  ListEvents()
            eventobj = arrEventList[indexPath!.row]
            //type 2 is Reservation
            if eventobj.type == "2"{
                if(eventobj.eventCategory?.lowercased() == "tennis"){
                    if let cancelViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController {
                        cancelViewController.isFrom = "EventTennisCancelRequest"
                        cancelViewController.eventID = eventobj.eventID
                        cancelViewController.cancelFor = .TennisReservation
                        cancelViewController.numberOfTickets = eventobj.partySize ?? ""
                        cancelViewController.eventRegID = eventobj.eventRegistrationDetailID
                        self.navigationController?.pushViewController(cancelViewController, animated: true)
                    }
                    
                }else if(eventobj.eventCategory?.lowercased() == "dining"){
                    if let cancelViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController {
                        cancelViewController.isFrom = "EventDiningCancelRequest"
                        cancelViewController.cancelFor = .DiningReservation
                        cancelViewController.numberOfTickets = eventobj.partySize ?? ""
                        cancelViewController.eventID = eventobj.eventID
                        self.navigationController?.pushViewController(cancelViewController, animated: true)
                    }
                }else{
                    if let cancelViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController {
                        cancelViewController.isFrom = "EventGolfCancelRequest"
                        cancelViewController.cancelFor = .GolfReservation
                        cancelViewController.numberOfTickets = eventobj.partySize ?? ""
                        cancelViewController.eventID = eventobj.eventID
                        cancelViewController.eventRegID = eventobj.eventRegistrationDetailID
                        
                        self.navigationController?.pushViewController(cancelViewController, animated: true)
                    }
                }
                
            }else{
                if(eventobj.eventCategory?.lowercased() == "dining"){
                    
                    if let cancelViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController {
                        cancelViewController.cancelFor = .DiningEvent
                        cancelViewController.isOnlyFrom = "DiningEvent"
                        cancelViewController.isFrom = "DiningCancel"
                        cancelViewController.numberOfTickets = eventobj.partySize ?? ""
                        
                        cancelViewController.eventID = eventobj.requestID
                        self.navigationController?.pushViewController(cancelViewController, animated: true)
                    }
                    
                }else{
                    
                    if let cancelViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController {
                        cancelViewController.isFrom = "CancelEvent"
                        cancelViewController.cancelFor = .Events
                        cancelViewController.eventID = eventobj.eventID
                        cancelViewController.eventRegID = eventobj.eventRegistrationDetailID
                        cancelViewController.numberOfTickets = eventobj.partySize ?? ""
                        
                        self.navigationController?.pushViewController(cancelViewController, animated: true)
                    }}
                
            }
        }
        else{
            
            guard eventobj.isMemberTgaEventNotAllowed != 1 else {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.TGAMEMBERVALIDATION, withDuration: Duration.kMediumDuration)
                return
            }
            
            //type 2 is reseration
            if eventobj.type == "2"{
                if(eventobj.eventCategory?.lowercased() == "tennis"){
                    let courtRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "CourtRequestVC") as! CourtRequestVC
                    //  golfRequest.golfSettings = self.golfSettings
                    courtRequest.isFrom = "Modify"
                    courtRequest.isOnlyFrom = "EventsModify"
                    var eventobj =  ListEvents()
                    eventobj = arrEventList[indexPath!.row]
                    courtRequest.requestID = eventobj.eventID
                    courtRequest.requestType = .reservation
                    self.navigationController?.pushViewController(courtRequest, animated: true)
                }
                else if(eventobj.eventCategory?.lowercased() == "dining"){
                    
                    let diningRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "DiningRequestVC") as! DiningRequestVC
                    //  golfRequest.golfSettings = self.golfSettings
                    if eventobj.buttontextvalue == "4"{
                        diningRequest.isFrom = "View"
                        
                    }else{
                        diningRequest.isFrom = "Modify"
                        
                    }
                    diningRequest.isOnlyFrom = "EventsModify"
                    var eventobj =  ListEvents()
                    eventobj = arrEventList[indexPath!.row]
                    diningRequest.requestID = eventobj.eventID
                    diningRequest.reservationRequestDate = eventobj.eventstartdate
                    diningRequest.requestType = .reservation
                    
                    self.navigationController?.pushViewController(diningRequest, animated: true)
                }
                else{
                    let golfRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "GolfRequestTeeTimeVC") as! GolfRequestTeeTimeVC
                    if eventobj.buttontextvalue == "4"{
                        golfRequest.isFrom = "View"
                        
                    }else{
                        golfRequest.isFrom = "Modify"
                        
                    }
                    golfRequest.isOnlyFrom = "EventsModify"
                    golfRequest.requestType = .reservation
                    var eventobj =  ListEvents()
                    eventobj = arrEventList[indexPath!.row]
                    golfRequest.requestID = eventobj.eventID
                    
                    self.navigationController?.pushViewController(golfRequest, animated: true)
                }
                
            }//Added condotion on 1st July 2020 BMS
            //type 1 is events
            else if eventobj.type == "1"
            {
                //let indexPath = self.eventsTableview.indexPath(for: cell)
                
                var events =  ListEvents()
                events = arrEventList[indexPath!.row]
                if events.eventCategory?.lowercased() == "dining"{
                    if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningEventRegistrationVC") as? DiningEventRegistrationVC {
                        
                        
                        
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
                        }
                        else{
                            registerVC.eventID = events.eventID
                            registerVC.eventCategory = events.eventCategory
                            if eventobj.buttontextvalue == "4"{
                                registerVC.eventType = 2
                                
                            }else{
                                registerVC.eventType = events.isMemberCalendar
                                
                            }
                            
                            registerVC.requestID = events.requestID
                            registerVC.isFrom = "EventUpdate"
                            registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
                            registerVC.eventRegistrationDetailID = events.eventRegistrationDetailID ?? ""
                            self.navigationController?.pushViewController(registerVC, animated: true)
                        }
                        
                    }
                }else{
                    if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "RegisterEventVC") as? RegisterEventVC {
                        
                        
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
                            registerVC.isFrom = "EventUpdate"
                            registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
                            registerVC.eventRegistrationDetailID = events.eventRegistrationDetailID ?? ""
                            self.navigationController?.pushViewController(registerVC, animated: true)
                        }
                        
                    }
                }
                
            }
            //Added on 1st July 2020 BMS
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
        
    }
    
    //MARK:- Events VIew only clicked
    func viewOnlyClickedClicked(cell: EventCustomTableViewCell)
    {
        let index = self.eventsTableview.indexPath(for: cell)
        var eventobj =  ListEvents()
        eventobj = arrEventList[index!.row]
        
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
        
//        guard eventobj.isMemberTgaEventNotAllowed != 1 else {
//            SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.TGAMEMBERVALIDATION, withDuration: Duration.kMediumDuration)
//            return
//        }
        
        
        if eventobj.type == "2"{
            if(eventobj.eventCategory?.lowercased() == "tennis"){
                let courtRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "CourtRequestVC") as! CourtRequestVC
                //  golfRequest.golfSettings = self.golfSettings
                courtRequest.isFrom = "Modify"
                courtRequest.isOnlyFrom = "EventsModify"
                var eventobj =  ListEvents()
                eventobj = arrEventList[index!.row]
                courtRequest.requestID = eventobj.eventID
                courtRequest.requestType = .reservation
                courtRequest.isViewOnly = true
                self.navigationController?.pushViewController(courtRequest, animated: true)
            }
            else if(eventobj.eventCategory?.lowercased() == "dining"){
                
                let diningRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "DiningRequestVC") as! DiningRequestVC
                //  golfRequest.golfSettings = self.golfSettings
                if eventobj.buttontextvalue == "4"{
                    diningRequest.isFrom = "View"
                    
                }else{
                    diningRequest.isFrom = "Modify"
                    
                }
                diningRequest.isOnlyFrom = "EventsModify"
                diningRequest.isViewOnly = true
                var eventobj =  ListEvents()
                eventobj = arrEventList[index!.row]
                diningRequest.requestID = eventobj.eventID
                diningRequest.reservationRequestDate = eventobj.eventstartdate
                diningRequest.requestType = .reservation
                
                self.navigationController?.pushViewController(diningRequest, animated: true)
            }
            else{
                let golfRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "GolfRequestTeeTimeVC") as! GolfRequestTeeTimeVC
                if eventobj.buttontextvalue == "4"{
                    golfRequest.isFrom = "View"
                    
                }else{
                    golfRequest.isFrom = "Modify"
                    
                }
                golfRequest.isOnlyFrom = "EventsModify"
                golfRequest.requestType = .reservation
                var eventobj =  ListEvents()
                eventobj = arrEventList[index!.row]
                golfRequest.requestID = eventobj.eventID
                golfRequest.isViewOnly = true
                self.navigationController?.pushViewController(golfRequest, animated: true)
            }
            
        }else{
            //let indexPath = self.eventsTableview.indexPath(for: cell)
            
            var events =  ListEvents()
            events = arrEventList[index!.row]
            if events.eventCategory?.lowercased() == "dining"{
                if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningEventRegistrationVC") as? DiningEventRegistrationVC {
                    
                    
                    
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
                    }
                    else{
                        registerVC.eventID = events.eventID
                        registerVC.eventCategory = events.eventCategory
                        if eventobj.buttontextvalue == "4"{
                            registerVC.eventType = 2
                            
                        }else{
                            registerVC.eventType = events.isMemberCalendar
                            
                        }
                        
                        registerVC.requestID = events.requestID
                        registerVC.isFrom = "EventUpdate"
                        registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
                        registerVC.eventRegistrationDetailID = events.eventRegistrationDetailID ?? ""
                        registerVC.isViewOnly = true
                        self.navigationController?.pushViewController(registerVC, animated: true)
                    }
                    
                }
            }else{
                if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "RegisterEventVC") as? RegisterEventVC {
                    
                    
                    
                    
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
                        registerVC.isFrom = "EventUpdate"
                        registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
                        registerVC.eventRegistrationDetailID = events.eventRegistrationDetailID ?? ""
                        registerVC.isViewOnly = true
                        self.navigationController?.pushViewController(registerVC, animated: true)
                    }
                    
                }
            }
            
        }


    }
    
    //Added 15th October 2020 V2.3
    func nameClicked(cell: EventCustomTableViewCell)
    {
        let indexPath = self.eventsTableview.indexPath(for: cell)
        var events =  ListEvents()
        events = arrEventList[indexPath!.row]
        // type 1 is Event
        if events.type == "1"
        {
            
            if let eventDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "EventDetailsVC") as? EventDetailsVC
            {
                if events.eventCategory?.lowercased() == "dining"
                {
                    if(eventCategory == "My Calendar")
                    {
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
    
    
    
    func shareButtonClicked(cell: EventCustomTableViewCell) {
        

        
        let indexPath = self.eventsTableview.indexPath(for: cell)

        self.shareDetails(indexPath: indexPath)
        
 
    }
    
    func shareDetails(indexPath: IndexPath?){
        var events =  ListEvents()
        events = arrEventList[indexPath!.row]
        // type 1 is Event
        if events.type == "1"{
            
            if let share = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ShareViewController") as? ShareViewController {
                share.modalTransitionStyle   = .crossDissolve;
                share.modalPresentationStyle = .overCurrentContext
                //old logic
               // share.imgURl = events.eventID
                
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
                shareDetails.isFrom = events.eventCategory!
                shareDetails.eventRegistrationDetailID = events.eventRegistrationDetailID ?? ""
                self.navigationController?.pushViewController(shareDetails, animated: true)
            }
        }
    }

    func imgDetailViewClicked(cell: EventCustomTableViewCell)
    {
        let indexPath = self.eventsTableview.indexPath(for: cell)
        
        var eventobj =  ListEvents()
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
            
            guard eventobj.isMemberTgaEventNotAllowed != 1 else {
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
                        registerVC.isFrom = "EventUpdate"
                        registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
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
                    registerVC.isFrom = "EventUpdate"
                    registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
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
                    registerVC.isFrom = "EventUpdate"
                    registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
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
                        registerVC.isFrom = "EventUpdate"
                        registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
                        registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                        registerVC.showStatus = true
                        registerVC.strStatus = eventobj.eventstatus ?? ""
                        registerVC.strStatusColor = eventobj.colorCode ?? "#FFFFFF"
                        self.navigationController?.pushViewController(registerVC, animated: true)
                    }
                    
                case "3","4":
                    
                    registerVC.eventID = eventobj.eventID
                    registerVC.eventCategory = eventobj.eventCategory
                    registerVC.eventType = eventobj.isMemberCalendar
                    registerVC.isViewOnly = true
                    registerVC.isFrom = "EventUpdate"
                    registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
                    registerVC.eventRegistrationDetailID = eventobj.eventRegistrationDetailID ?? ""
                    registerVC.showStatus = true
                    registerVC.strStatus = eventobj.eventstatus ?? ""
                    registerVC.strStatusColor = eventobj.colorCode ?? "#FFFFFF"
                    self.navigationController?.pushViewController(registerVC, animated: true)
                    
                case "1","2":
                    
                    registerVC.eventID = eventobj.eventID
                    registerVC.eventCategory = eventobj.eventCategory
                    registerVC.eventType = eventobj.isMemberCalendar
                    registerVC.isFrom = "EventUpdate"
                    registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
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
            //PROD0000071 -- End
        }
        else
        {
            if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ViewNewsViewController") as? ViewNewsViewController
            {
                clubNews.modalTransitionStyle   = .crossDissolve;
                clubNews.modalPresentationStyle = .overCurrentContext
                //clubNews.imgURl = eventobj.imageLarge
                
                //Added on on 14th May 202 v2.1
                let mediaDetail = MediaDetails.init()
                mediaDetail.newsImage = eventobj.imageLarge ?? ""
                mediaDetail.type = .image
                clubNews.arrMediaDetails = [mediaDetail]
                
                //OLd logic
                //clubNews.arrImgURl = [["NewsImage" : eventobj.imageLarge ?? ""]]
                clubNews.isFrom = "Events"
                //Added on on 19th May 202 v2.1
                clubNews.contentType = .image
                self.present(clubNews, animated: true, completion: nil)
            }
        }
        //PROD0000071 -- End
        
    }
    
    
    func loadsegmentController()  {
    
        self.segmentedController = ScrollableSegmentedControl.init(frame: self.uiSegmentView.bounds)
        self.uiSegmentView.addSubview(self.segmentedController)
        self.segmentedController.segmentStyle = .textOnly
        
        self.segmentedController.segmentStyle = .imageOnLeft

        self.segmentedController.underlineSelected = true
        self.segmentedController.backgroundColor = hexStringToUIColor(hex: "F5F5F5")
        
        self.segmentedController.tintColor = APPColor.loginBackgroundButtonColor.loginBtnBGColor
        
        self.segmentedController.addTarget(self, action: #selector(CalendarOfEventsViewController.segmentSelected(sender:)), for: .valueChanged)
        
        // self.segmentedController.removeFromSuperview()
        for i in 0 ..< self.arrEventCategory.count {
            let statementData = self.arrEventCategory[i]
            
            if(!(i == 0)){
              //  self.segmentedController.segmentStyle = .textOnly
                self.segmentedController.insertSegment(withTitle: statementData.categoryText, image: nil, at: i)
//                self.segmentedController.segmentStyle = .imageOnLeft
            }
            else{
                //self.segmentedController.segmentStyle = .textOnly
             //   self.segmentedController.segmentStyle = .imageOnLeft
                self.segmentedController.insertSegment(withTitle: String(format: "%@     ", statementData.categoryText!), image: #imageLiteral(resourceName: "Group 1635"), at: i)
                
            }
        }
        if  self.appDelegate.eventsCloseFrom == "My"{
            self.appDelegate.eventsCloseFrom = ""
            self.segmentedController.selectedSegmentIndex = 0

        }else{
            if self.appDelegate.segmentIndex == 0 {
                self.segmentedController.selectedSegmentIndex = 1
            }else{
                self.segmentedController.selectedSegmentIndex = self.appDelegate.segmentIndex
                self.appDelegate.segmentIndex = 0
            }
        
        }

}
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        eventSearchBar.resignFirstResponder()
        self.monthCount = 0
        self.eventApi(strSearch: eventSearchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.monthCount = 0
            self.eventApi(strSearch: eventSearchBar.text!)

        }
        
    }
   
    
}

extension CalendarOfEventsViewController : GuestListFilterViewDelegate {
    
    func guestCardFilterApply(filter: GuestCardFilter) {
        
        if !(filter.department.value() == -1) {
            self.segmentedController.selectedSegmentIndex = filter.department.value() as Int
            eventCategory = filter.department.displayName() as NSString

        }
        filterBy = filter.date.value()
        filterByDepartment = eventCategory! as String
        filterByDate = filter.date.displayName()
        filterByEventStatus = filter.status
        
        self.isSortFilterApplied = 1
        eventApi(strSearch: eventSearchBar.text, filter: filter)
        filterPopover?.dismiss()
    }
    
    func guestCardFilterClose() {
        filterPopover?.dismiss()
    }
    
    
}

//MARK:- DTCalendar Delegates
extension CalendarOfEventsViewController: DTCalendarViewDelegate {

    func calendarView(_ calendarView: DTCalendarView, dragFromDate fromDate: Date, toDate: Date)
    {
        self.calendarDidSelectDate = true
        
        if let nowDayOfYear = calendar.ordinality(of: .day, in: .year, for: now),
            let selectDayOfYear = calendar.ordinality(of :.day, in: .year, for: toDate),
            selectDayOfYear < nowDayOfYear {
            return
        }
        
        if let startDate = calendarView.selectionStartDate,
            fromDate == startDate {
            
            if let endDate = calendarView.selectionEndDate {
                if toDate < endDate {
                    calendarView.selectionStartDate = toDate
                }
            } else {
                calendarView.selectionStartDate = toDate
            }
            
        } else if let endDate = calendarView.selectionEndDate,
            fromDate == endDate {
            
            if let startDate = calendarView.selectionStartDate {
                if toDate > startDate {
                    calendarView.selectionEndDate = toDate
                }
            } else {
                calendarView.selectionEndDate = toDate
            }
        }
    }
    
    func calendarView(_ calendarView: DTCalendarView, viewForMonth month: Date) -> UIView {
        
        
        
        let myview = UIView()
        let label = UILabel(frame: CGRect(x: 0, y: 40, width: 200, height: 28))
        
        label.text = monthYearFormatter.string(from: month)
        label.textColor = UIColor(red: 61.0/255.0, green: 61.0/255.0, blue: 61.0/255.0, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.backgroundColor = UIColor.white
        myview.addSubview(label)
        
        let label2 = UILabel(frame: CGRect(x: 0, y: 10, width: 200, height: 22))
        label2.text = YearFormatter.string(from: month)
        label2.textColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        label2.font = UIFont.boldSystemFont(ofSize: 28)
        label2.backgroundColor = UIColor.white
        myview.addSubview(label2)
        
        
        return myview
    }
    
    func calendarView(_ calendarView: DTCalendarView, disabledDaysInMonth month: Date) -> [Int]? {
        
        if currentDate(matchesMonthAndYearOf: month) {
            var disabledDays = [Int]()
            
            let nowDay = calendar.component(.day, from: now)
            
            for day in 1 ... nowDay {
                disabledDays.append(day)
            }
            
            return disabledDays
        }
        
        return nil
    }
    
    func calendarView(_ calendarView: DTCalendarView, didSelectDate date: Date) {
        calendarDidSelectDate = true
        //calendarRangeStartDate = ""
        //calendarRangeEndDate = ""

        
        if let nowDayOfYear = calendar.ordinality(of: .day, in: .year, for: now),
            let selectDayOfYear = calendar.ordinality(of :.day, in: .year, for: date),
            calendar.component(.year, from: now) == calendar.component(.year, from: date),
            selectDayOfYear < nowDayOfYear {
            return
        }
        
        if calendarView.selectionStartDate == nil {
            calendarView.selectionStartDate = date

        } else if calendarView.selectionEndDate == nil {
            if let startDateValue = calendarView.selectionStartDate {
                if date <= startDateValue {
                    calendarView.selectionStartDate = date
                } else {
                    calendarView.selectionEndDate = date
                    //calendarRangeEndDate = SharedUtlity.sharedHelper().dateFormatter.string(from: calendarView.selectionEndDate!) as NSString
                }
            }
        } else {
            calendarView.selectionStartDate = date
            calendarView.selectionEndDate = nil

        }
       // calendarRangeStartDate = SharedUtlity.sharedHelper().dateFormatter.string(from: calendarView.selectionStartDate!) as NSString
    }
    
    func calendarViewHeightForWeekRows(_ calendarView: DTCalendarView) -> CGFloat {
        return 60
    }
    
    func calendarViewHeightForWeekdayLabelRow(_ calendarView: DTCalendarView) -> CGFloat {
        return 50
    }
    
    func calendarViewHeightForMonthView(_ calendarView: DTCalendarView) -> CGFloat {
        return 80
    }
}

//MARK:- My calendar cell delegates
extension CalendarOfEventsViewController : MyCalendarCellDelegate
{
    
    func shareButtonClicked(cell: MyCalendarXib)
    {
        
        let indexPath = self.eventsTableview.indexPath(for: cell)
        //Added on 1st July 2020 BMS
        let eventobj = self.arrEventList[indexPath!.row]
        
        if eventobj.requestType == .BMS
        {
            self.getDepartmentSettings(eventObj: eventobj) { (departments) in
                
                if let departmentDetails = departments?.first(where: {$0.locationID == eventobj.locationID})
                {
                    self.appDelegate.bookingAppointmentDetails = BMSAppointmentDetails()
                    self.appDelegate.bookingAppointmentDetails.department = departmentDetails
                }
                self.shareDetails(indexPath: indexPath)
            }
        }
        else
        {
            self.shareDetails(indexPath: indexPath)
        }
        
        
    }
    
    func synchButtonClicked(cell: MyCalendarXib)
    {
        let indexPath = self.eventsTableview.indexPath(for: cell)
        //Added on 1st July 2020 BMS
        let eventobj = self.arrEventList[indexPath!.row]
        
        if eventobj.requestType == .BMS
        {
            self.getDepartmentSettings(eventObj: eventobj) { (departments) in
                
                
                if let departmentDetails = departments?.first(where: {$0.locationID == eventobj.locationID})
                {
                    self.appDelegate.bookingAppointmentDetails = BMSAppointmentDetails()
                    self.appDelegate.bookingAppointmentDetails.department = departmentDetails
                }
                self.syncCalender(indexPath: indexPath)
            }
        }
        else
        {
             self.syncCalender(indexPath: indexPath)
        }
       

    }
    
    func registrationButtonClicked(cell: MyCalendarXib) {
        
        let indexPath = self.eventsTableview.indexPath(for: cell)
        self.requestClicked(indexPath: indexPath, bttnTitle: cell.btnRegister.titleLabel?.text )
        
    }
    
    func viewOnlyClicked(cell: MyCalendarXib)
    {
        let index = self.eventsTableview.indexPath(for: cell)
        var eventobj =  ListEvents()
        eventobj = arrEventList[index!.row]
        
        //Added on 4th July 202 V2.2
        //Added roles and privilages chanegs
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
        
        
        
//        guard eventobj.isMemberTgaEventNotAllowed != 1 else {
//            SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.TGAMEMBERVALIDATION, withDuration: Duration.kMediumDuration)
//            return
//        }
        
        
        if eventobj.type == "2"{
            if(eventobj.eventCategory?.lowercased() == "tennis"){
                let courtRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "CourtRequestVC") as! CourtRequestVC
                //  golfRequest.golfSettings = self.golfSettings
                courtRequest.isFrom = "Modify"
                courtRequest.isOnlyFrom = "EventsModify"
                var eventobj =  ListEvents()
                eventobj = arrEventList[index!.row]
                courtRequest.requestID = eventobj.eventID
                courtRequest.requestType = .reservation
                courtRequest.isViewOnly = true
                self.navigationController?.pushViewController(courtRequest, animated: true)
            }
            else if(eventobj.eventCategory?.lowercased() == "dining"){
                
                let diningRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "DiningRequestVC") as! DiningRequestVC
                //  golfRequest.golfSettings = self.golfSettings
                if eventobj.buttontextvalue == "4"{
                    diningRequest.isFrom = "View"
                    
                }else{
                    diningRequest.isFrom = "Modify"
                    
                }
                diningRequest.isOnlyFrom = "EventsModify"
                diningRequest.isViewOnly = true
                var eventobj =  ListEvents()
                eventobj = arrEventList[index!.row]
                diningRequest.requestID = eventobj.eventID
                diningRequest.reservationRequestDate = eventobj.eventstartdate
                diningRequest.requestType = .reservation
                
                self.navigationController?.pushViewController(diningRequest, animated: true)
            }
            else{
                let golfRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "GolfRequestTeeTimeVC") as! GolfRequestTeeTimeVC
                if eventobj.buttontextvalue == "4"{
                    golfRequest.isFrom = "View"
                    
                }else{
                    golfRequest.isFrom = "Modify"
                    
                }
                golfRequest.isOnlyFrom = "EventsModify"
                golfRequest.requestType = .reservation
                var eventobj =  ListEvents()
                eventobj = arrEventList[index!.row]
                golfRequest.requestID = eventobj.eventID
                golfRequest.isViewOnly = true
                self.navigationController?.pushViewController(golfRequest, animated: true)
            }
            
        }//Modified on 1st July 2020 BMS
            //Type 1 is events
        else if eventobj.type == "1"
        {
            //let indexPath = self.eventsTableview.indexPath(for: cell)
            
            var events =  ListEvents()
            events = arrEventList[index!.row]
            if events.eventCategory?.lowercased() == "dining"{
                if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningEventRegistrationVC") as? DiningEventRegistrationVC {
                    
                    
                    
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
                    }
                    else{
                        registerVC.eventID = events.eventID
                        registerVC.eventCategory = events.eventCategory
                        if eventobj.buttontextvalue == "4"{
                            registerVC.eventType = 2
                            
                        }else{
                            registerVC.eventType = events.isMemberCalendar
                            
                        }
                        
                        registerVC.requestID = events.requestID
                        registerVC.isFrom = "EventUpdate"
                        registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
                        registerVC.eventRegistrationDetailID = events.eventRegistrationDetailID ?? ""
                        registerVC.isViewOnly = true
                        self.navigationController?.pushViewController(registerVC, animated: true)
                    }
                    
                }
            }else{
                if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "RegisterEventVC") as? RegisterEventVC {
                    
                    
                    
                    
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
                        registerVC.isFrom = "EventUpdate"
                        registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
                        registerVC.eventRegistrationDetailID = events.eventRegistrationDetailID ?? ""
                        registerVC.isViewOnly = true
                        self.navigationController?.pushViewController(registerVC, animated: true)
                    }
                    
                }
            }
            
        }
        //Added on 1st July 2020 BMS
        //Type 3 if for BMS
        //Request Type is an enum for type.
        else if eventobj.requestType == .BMS
        {
            
            self.getDepartmentSettings(eventObj: eventobj) { (department) in
                
                if let departmentDetails = department?.first(where: {$0.locationID == eventobj.locationID})
                {
                    self.assignBMSDetails(BMSObject: eventobj, departmentDetails: departmentDetails, reqeustScreenType: .view)
                    
                    //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Added the BMS department paramater to the function
                    //GATHER0000700 - Start
                    self.startBMSFlow(BMSDepartment: CustomFunctions.shared.BMSDepartmentType(departmentType: eventobj.departmentType))
                    //GATHER0000700 - End
                }
            }
            
        }

    }
    
    //Added on 1st July 2020 BMS
    func cancelClicked(cell: MyCalendarXib)
    {
        
        if let indexPath = self.eventsTableview.indexPath(for: cell)
        {
            let eventObject = self.arrEventList[indexPath.row]
            
            //Added on 4th July 2020 V2.2
            //Added roles adn privilages changes
            //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments. Added department name for BMS sub category(eg. fitness , spa ,salon, etc..) permissions.
            switch self.accessManager.accessPermission(eventCategory: eventObject.eventCategory!, type: eventObject.requestType!, departmentName: eventObject.DepartmentName ?? "") {
            case .notAllowed,.view:
                
                if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
                {
                    SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                }
                return
            case .allowed:
                break
            }
            
            self.getAppointmentdetails(id: eventObject.eventID) { [unowned self] in
                
                //Added on 8th July 2020 V2.2
                //Added cancel succes popup and cancelation reason settigs
                
                self.getDepartmentSettings(eventObj: eventObject) { (departments) in
                    
                    guard let departmentDetails = departments?.first(where: {$0.locationID == eventObject.locationID}) else{
                        return
                    }
                    
                    if departmentDetails.settings?.first?.app_CaptureCacellationReason == "1"
                    {
                        let cancelView = BMSCancelView.init(frame: self.appDelegate.window!.bounds)
                        cancelView.appointmentDetailID = self.arrEventList[indexPath.row].eventID
                        cancelView.success = { [unowned self] (imgpath) in
                            
                            if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView {
                                self.appDelegate.hideIndicator()
                                succesView.delegate = self
                                succesView.imgUrl = imgpath
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
    
    //Added on 15th OCtober 2020 V2.3
    func nameClicked(cell: MyCalendarXib)
    {
        let indexPath = self.eventsTableview.indexPath(for: cell)
        var events =  ListEvents()
        events = arrEventList[indexPath!.row]
        // type 1 is Event
        if events.type == "1"
        {
            
            if let eventDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "EventDetailsVC") as? EventDetailsVC
            {
                if events.eventCategory?.lowercased() == "dining"
                {
                    if(eventCategory == "My Calendar")
                    {
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
    
}

//Added on 1st July 2020 BMS
//MARK:- Custom methods
extension CalendarOfEventsViewController
{
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
    //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Added BMSDepartment paramater to identify the BMS department the selected requested belongs to
    //GATHER0000700 - Start
    private func startBMSFlow(BMSDepartment : BMSDepartment)
    {//GATHER0000700 - end
        
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
}

//Added on 8th July 2020 V2.2
//MARK:- CancelPopUpViewControllerDelegate
extension CalendarOfEventsViewController : CancelPopUpViewControllerDelegate
{
    func didCancel(status: Bool)
    {
        self.eventApi(strSearch: self.eventSearchBar.text ?? "")
    }
}

//Added on 8th JUly 2020 V2.2
//MARK:- closeUpdateSuccesPopup delegate
extension CalendarOfEventsViewController : closeUpdateSuccesPopup
{
    func closeUpdateSuccessView()
    {
        self.eventApi(strSearch: self.eventSearchBar.text ?? "")
    }
    
}
