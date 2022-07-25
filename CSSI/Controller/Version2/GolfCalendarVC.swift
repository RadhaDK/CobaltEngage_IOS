//
//  GolfCalendarVC.swift
//  CSSI
//
//  Created by apple on 4/17/19.
//  Copyright © 2019 yujdesigns. All rights reserved.


import UIKit
import ScrollableSegmentedControl
import Alamofire
import Popover
import EventKit
import DTCalendarView
import ObjectMapper

class GolfCalendarVC: UIViewController ,UISearchBarDelegate, DTCalendarViewDelegate {
   
    fileprivate var now = Date()
    
    fileprivate var currentDate = Date()

    fileprivate let calendar = Calendar.current

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var uiMainView: UIView!
    @IBOutlet weak var uiSegmentView: UIView!
    @IBOutlet weak var reservationsearchBar: UISearchBar!
    @IBOutlet weak var uiScrollView: UIScrollView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var lblBottomDispalyName: UILabel!
    
    @IBOutlet weak var topLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var lblUpcomingEvent: UILabel!
    
    @IBOutlet weak var calanderView: UIView!
    @IBOutlet weak var lblyear: UILabel!
    @IBOutlet weak var lblMonthName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var viewCalander: UIView!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var heightBottomMemberNameView: NSLayoutConstraint!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var calendarRangeStartDate : String?
    var calendarRangeEndDate : String?
    
    /// Hold the previous selection start date of calendar
    private var calendarPreviousStartDate : String!
    
    /// Holds the previous selection end date of calendar
    private var calendarPreviousEndDate : String!
    
    /// Indicates if the user selection of date
    ///
    /// This is true when the user selects the date by clicking or draging
    var calendarDidSelectDate: Bool = false
    private var shouldRestoreData = false
    private var isResetClicked = false
    
    
    fileprivate let newFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    //Added on 17th JUly 2020 V2.2
    //Added to remeber the selected state.so that it can be restored back
    private var currentSegmentIndex : Int?
    //Added on 17th July 2020 V2.2
    //Added for toles and privilaegs chages
    private let accessManager = AccessManager.shared
    //Added on 17th July 2020 V2.2
    //Added for roles and privilaegs chages. when member is not allowed to view buddies this is used to stop refresh of data
    private var shouldRefreshScreen = true
    
    @IBOutlet weak var eventsRangeView: DTCalendarView!{
        
        didSet {
            eventsRangeView.delegate = self as? DTCalendarViewDelegate 
            
            eventsRangeView.displayEndDate = Date(timeIntervalSinceNow: 60 * 60 * 24 * 30 * 12 * 40)
            eventsRangeView.previewDaysInPreviousAndMonth = false

            let lastYear = Calendar.current.date(byAdding: .year, value: -20, to: Date())

            let currentTimeStamp = lastYear!.toMillis()
            now = lastYear!
            
            let intValue = NSNumber(value: currentTimeStamp!).intValue
            
            eventsRangeView.displayStartDate =  Date(timeIntervalSince1970: TimeInterval(intValue))
        }
    }
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
    var arrEventCategory = [ListEventCategory]()
    var isFrom : NSString!

    var segmentedController = ScrollableSegmentedControl()
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        self.appDelegate.golfEventsSearchText = ""
        
        self.getGolfCategoriesApi(strSearch : "")
        
       
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        lblDate.text = String(format: "%d",components.day!)
        lblyear.text = String(format: "%d",components.year!)
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM"
        
        let dateAndMonth: String = dateFormat.string(from: date)
        
        lblMonthName.text = dateAndMonth
        
        viewCalander.layer.masksToBounds = true
        viewCalander.layer.cornerRadius = 8
        viewCalander.layer.borderWidth = 0.6
        viewCalander.layer.borderColor = hexStringToUIColor(hex: "A9A9A9").cgColor
        
        reservationsearchBar.searchBarStyle = .default
        
        reservationsearchBar.layer.borderWidth = 1
        reservationsearchBar.layer.borderColor = hexStringToUIColor(hex: "F5F5F5").cgColor
        
        let calandergesture = UITapGestureRecognizer(target: self, action:  #selector(self.calander(sender:)))
        self.calanderView.addGestureRecognizer(calandergesture)
        eventsRangeView.isHidden = true
        uiMainView.isHidden = false
        btnClose.isHidden = true
        btnReset.isHidden = true
        btnSubmit.isHidden = true
        
        self.lblBottomDispalyName.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)

        self.btnSubmit.calendarBttnViewSetup()
        self.btnSubmit.setTitle(self.appDelegate.masterLabeling.CALENDER_FILTER ?? "", for: .normal)
        self.btnClose.calendarBttnViewSetup()
        self.btnClose.setTitle(self.appDelegate.masterLabeling.CALENDER_CLOSE ?? "", for: .normal)
        self.btnReset.calendarBttnViewSetup()
        self.btnReset.setTitle(self.appDelegate.masterLabeling.CALENDER_CLEAR ?? "", for: .normal)
        
        self.lblMonthName.backgroundColor = APPColor.MainColours.primary3
        self.eventsRangeView.setDisplayAttributes(DisplayAttributes.init(font: UIFont.systemFont(ofSize: 15), textColor: .white, backgroundColor: APPColor.MainColours.primary2, textAlignment: .center), forState: .selected)
        self.eventsRangeView.setDisplayAttributes(DisplayAttributes.init(font: UIFont.systemFont(ofSize: 15), textColor: .white, backgroundColor: APPColor.MainColours.primary2, textAlignment: .center), forState: .highlighted)
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
       if(self.appDelegate.buddyType == ""){
        self.getGolfCategoriesApi(strSearch : "")
       }else if self.appDelegate.buddyType == "My" || self.appDelegate.eventsCloseFrom == "My" || self.appDelegate.eventsCloseFrom == "Calendar" {
        self.shouldRestoreData = true
        self.getGolfCategoriesApi(strSearch : "")
        }
        
        // Do any additional setup after loading the view.
        reservationsearchBar.searchBarStyle = .default
        
        reservationsearchBar.layer.borderWidth = 1
        reservationsearchBar.layer.borderColor = hexStringToUIColor(hex: "F5F5F5").cgColor
        
        reservationsearchBar.placeholder = self.appDelegate.masterLabeling.search ?? "" as String
        uiScrollView.isScrollEnabled = false
        
        
        if(self.appDelegate.typeOfCalendar == "Tennis"){
            self.navigationItem.title = self.appDelegate.masterLabeling.tennis_calendar
            self.lblUpcomingEvent.text = self.appDelegate.masterLabeling.upcoming_tennis_events
        }
        else if(self.appDelegate.typeOfCalendar == "Dining"){
            self.navigationItem.title = self.appDelegate.masterLabeling.dining_calendar
            self.lblUpcomingEvent.text = self.appDelegate.masterLabeling.upcoming_dining_times

        }
        else if self.appDelegate.typeOfCalendar == "FitnessSpa"
        {
            self.navigationItem.title = self.appDelegate.masterLabeling.fITNESSANDSPA_CALENDAR
            self.lblUpcomingEvent.text = self.appDelegate.masterLabeling.uPCOMING_FITNESSEVENTS
        }
        else{
            self.lblUpcomingEvent.text = self.appDelegate.masterLabeling.up_coming_golf_events
            self.navigationItem.title = self.appDelegate.masterLabeling.golf_calendar
        }
        
        let now = Date()
        if eventsRangeView.selectionStartDate == nil && eventsRangeView.selectionEndDate == nil{
            eventsRangeView.selectionStartDate = now

        }else{
            
        }
        eventsRangeView.scrollTo(month: currentDate, animated: false)

        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
       
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End

        self.navigationController?.navigationBar.isHidden = false
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

    //MARK:- Calender btn clicked
    @objc func calander(sender : UITapGestureRecognizer)
    {
        
        self.calendarPreviousStartDate = self.calendarRangeStartDate
        self.calendarPreviousEndDate = self.calendarRangeEndDate
        
        
        if self.calendarRangeStartDate != ""
        {
            if let strDate = self.calendarRangeStartDate , let date = SharedUtlity.sharedHelper()?.dateFormatter.date(from: strDate)
            {
                self.eventsRangeView.selectionStartDate =  date
            }
            else
            {
                self.eventsRangeView.selectionStartDate = Date()
            }
            
        }
        else
        {
            self.eventsRangeView.selectionStartDate = Date()
        }
        
        
        if self.calendarRangeEndDate != "" , self.calendarRangeEndDate != nil
        {
            if let strDate = self.calendarRangeEndDate, let date = SharedUtlity.sharedHelper()?.dateFormatter.date(from: strDate)
            {
                self.eventsRangeView.selectionEndDate =  date
            }
            
        }
        
        
        if let startDatestr = calendarRangeStartDate , let endDatestr = calendarRangeEndDate , let startDate = SharedUtlity.sharedHelper()?.dateFormatter.date(from: startDatestr) , let endDate = SharedUtlity.sharedHelper()?.dateFormatter.date(from: endDatestr)
        {
            if startDate == endDate
            {
                self.eventsRangeView.selectionEndDate = nil
            }
        }
        
        //Old Logic
       /*
         if self.eventsRangeView.selectionStartDate == nil || self.calendarRangeStartDate == ""
        {
            if let strDate = self.calendarRangeStartDate as? String, let date = SharedUtlity.sharedHelper()?.dateFormatter.date(from: strDate),self.currentDate(matchesMonthAndYearOf: date)
            {
                self.eventsRangeView.selectionStartDate =  date
            }
            else
            {
                self.eventsRangeView.selectionStartDate = Date()
            }
            
        }
         */

        
        if let date = self.eventsRangeView.selectionStartDate
        {
             self.eventsRangeView.scrollTo(month: date, animated: true)
        }
        
        eventsRangeView.isHidden = false
        uiMainView.isHidden = true
        btnClose.isHidden = false
        calanderView.isHidden = true
        btnReset.isHidden = false
        btnSubmit.isHidden = false
        reservationsearchBar.isHidden = true
        stackView.isHidden = true
        self.lblBottomDispalyName.isHidden = true

    }

    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onTapHome() {
    
    self.navigationController?.popToRootViewController(animated: true)
    
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    @IBAction func previousClicked(_ sender: UIButton)
    {
        if self.arrEventCategory.count == 0
        {
            
        }
        else
        {
            var selectedSegment =  self.segmentedController.selectedSegmentIndex  - 1
            if selectedSegment <= 0
            {
                selectedSegment = 0
            }
        
            self.appDelegate.selectedEventsCategory = self.arrEventCategory[selectedSegment]
            self.segmentedController.selectedSegmentIndex = selectedSegment
        }
        
    }
    
    @IBAction func nextClicked(_ sender: UIButton)
    {
        if self.arrEventCategory.count == 0
        {
                       
        }
        else
        {
            var selectedSegment =  self.segmentedController.selectedSegmentIndex  + 1
            if selectedSegment >= self.segmentedController.numberOfSegments
            {
                selectedSegment = self.segmentedController.numberOfSegments - 1
            }
                   
            self.appDelegate.selectedEventsCategory = self.arrEventCategory[selectedSegment]
            self.segmentedController.selectedSegmentIndex = selectedSegment
        }
        
    }
    
    
    //MARK:- Segment Controller Selected
    @objc func segmentSelected(sender:ScrollableSegmentedControl)
    {
        //Added on 17th July 2020 V2.2
        //Added for roles and privilages
        if sender.selectedSegmentIndex == 3
        {
            
            switch self.accessManager.accessPermision(for: .memberDirectory)
            {
            case .notAllowed:
                
               self.shouldRefreshScreen = false
               
               if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
               {
                   SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                   
               }
               
               self.segmentedController.selectedSegmentIndex = self.currentSegmentIndex!
                return
            default:
                 self.currentSegmentIndex = sender.selectedSegmentIndex
            }
        }
        else
        {
            self.currentSegmentIndex = sender.selectedSegmentIndex
        }
        
        
        guard self.shouldRefreshScreen else{
            //Note:- Selected segment underline is not shown.to force this we are adding the tint color same as in setup to force reload of the segment view.
            self.segmentedController.tintColor = APPColor.loginBackgroundButtonColor.loginBtnBGColor
            self.shouldRefreshScreen = true
            return
        }
        
        
        if(sender.selectedSegmentIndex == 3)
        {
            self.calanderView.isHidden = true
            self.heightBottomMemberNameView.constant = 0
            self.lblBottomDispalyName.isHidden = true
            
            let previousStatementVC = storyboard!.instantiateViewController(withIdentifier: "MyBuddiesViewController")
            previousStatementVC.title =  self.appDelegate.masterLabeling.tAB_PREVIOUS
            lblUpcomingEvent.isHidden = true
            topLabelHeight.constant = -58
            configureChildViewControllerForstatenents(childController: previousStatementVC, onView: self.baseView)
                   
        }
        else if(sender.selectedSegmentIndex == 2)
        {
            self.calanderView.isHidden = true
            self.heightBottomMemberNameView.constant = 0
            self.lblBottomDispalyName.isHidden = true
            
            let previousStatementVC = storyboard!.instantiateViewController(withIdentifier: "PlayHistoryVC")
            previousStatementVC.title =  self.appDelegate.masterLabeling.tAB_PREVIOUS
            lblUpcomingEvent.isHidden = true
            topLabelHeight.constant = -58
            configureChildViewControllerForstatenents(childController: previousStatementVC, onView: self.baseView)
            
        }
        else if(sender.selectedSegmentIndex == 0)
        {
            self.heightBottomMemberNameView.constant = 28
            self.lblBottomDispalyName.isHidden = false
            
            self.calanderView.isHidden = false
            let previousStatementVC = storyboard!.instantiateViewController(withIdentifier: "GolfCalendarMYTabVC")
            previousStatementVC.title =  self.appDelegate.masterLabeling.tAB_PREVIOUS
            lblUpcomingEvent.isHidden = true
            topLabelHeight.constant = -58
            self.appDelegate.selectedSegment = "0"
            configureChildViewControllerForstatenents(childController: previousStatementVC, onView: self.baseView)
        }
        else if(sender.selectedSegmentIndex == 1)
        {
            self.heightBottomMemberNameView.constant = 0
            self.lblBottomDispalyName.isHidden = true
            
            self.calanderView.isHidden = false
                   
            let previousStatementVC = storyboard!.instantiateViewController(withIdentifier: "EventsVC") as! EventsVC
            previousStatementVC.title =  self.appDelegate.masterLabeling.tAB_PREVIOUS
            lblUpcomingEvent.isHidden = false
            topLabelHeight.constant = 58
            self.appDelegate.selectedSegment = "1"
            if self.shouldRestoreData
            {
                previousStatementVC.isSortFilterApplied = 1
                previousStatementVC.monthCount = self.appDelegate.monthCount
                self.appDelegate.monthCount = 0
            }
            configureChildViewControllerForstatenents(childController: previousStatementVC, onView: self.baseView)
            
        }
        self.appDelegate.selectedEventsCategory = self.arrEventCategory[sender.selectedSegmentIndex]
       
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
                self.segmentedController.insertSegment(withTitle: statementData.categoryName!, image: nil, at: i)
            }
            else{
                self.segmentedController.insertSegment(withTitle: String(format: "%@     ", statementData.categoryName!), image: #imageLiteral(resourceName: "Group 1635"), at: i)
                
            }
        }
        
        if(self.appDelegate.buddyType == ""){
            self.segmentedController.selectedSegmentIndex = 3

        }
            
        else if(self.appDelegate.buddyType == "My")  {
            self.segmentedController.selectedSegmentIndex = 0
            
        }else if  self.appDelegate.eventsCloseFrom == "My" {
            
            self.appDelegate.eventsCloseFrom = ""
            self.segmentedController.selectedSegmentIndex = 0
            
        }else if self.appDelegate.eventsCloseFrom == "Calendar"{
            
            self.appDelegate.eventsCloseFrom = ""
            if self.appDelegate.selectedSegment == "0"{
                self.segmentedController.selectedSegmentIndex = 0

            }else{
                self.segmentedController.selectedSegmentIndex = 1

            }
        }
        else{
            self.segmentedController.selectedSegmentIndex = 1

        }
        self.appDelegate.buddyType = "First"
    }
    //MARK:- Get Golf Calendar Categories
    func getGolfCategoriesApi(strSearch :String) -> Void {
        
        
        if (Network.reachability?.isReachable) == true{
            
            arrEventCategory = [ListEventCategory]()
            self.arrEventCategory.removeAll()
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kusername: UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                "IsAdmin": "1",
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.getGolfCalendarCategory(paramater: paramaterDict, onSuccess: { categoriesList in
                self.appDelegate.hideIndicator()
                if(categoriesList.responseCode == InternetMessge.kSuccess){
                    self.arrEventCategory.removeAll()
                    
                    if(categoriesList.golfCategories == nil){
                        self.arrEventCategory.removeAll()
                        
                        // self.appDelegate.hideIndicator()
                    }
                    else{
                        self.arrEventCategory.removeAll()
                        
                        if(self.appDelegate.typeOfCalendar == "Tennis"){
                            self.arrEventCategory = categoriesList.tennisCategories!

                        }
                        else if(self.appDelegate.typeOfCalendar == "Dining"){
                            self.arrEventCategory = categoriesList.diningCategory!

                        }
                        else if self.appDelegate.typeOfCalendar == "FitnessSpa"
                        {
                            self.arrEventCategory =  categoriesList.fitnessSpaCategory!
                        }
                        else{
                            
                            self.arrEventCategory = categoriesList.golfCategories!
                        }
                        
                        
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchText = searchBar.text {
            print(searchText)
           
            self.appDelegate.golfEventsSearchText = searchText
            let userInfo = [ "searchText" : searchText , "resetMonth" : "1"]
            NotificationCenter.default.post(name: NSNotification.Name("eventsData"), object: nil, userInfo: userInfo)
        }
        
        searchBar.resignFirstResponder()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count == 0 {
            self.appDelegate.golfEventsSearchText = searchText
            let userInfo = [ "searchText" : searchText ,"resetMonth" : "1"]
            NotificationCenter.default.post(name: NSNotification.Name("eventsData"), object: nil, userInfo: userInfo)
            
        }
    }
    
    //MARK:- Calendar sumit,reset , close fuctions
    
    @IBAction func submitClicked(_ sender: UIButton)
    {
        
        if self.calendarDidSelectDate || self.isResetClicked
        {
            if self.calendarDidSelectDate
            {
                calendarDidSelectDate = false
                self.calendarRangeStartDate = ""
                self.calendarRangeEndDate = ""
                if let date = self.eventsRangeView.selectionStartDate
                {
                    self.calendarRangeStartDate = SharedUtlity.sharedHelper()?.dateFormatter.string(from: date)
                }
                
                if let date = self.eventsRangeView.selectionEndDate
                {
                    self.calendarRangeEndDate = SharedUtlity.sharedHelper()?.dateFormatter.string(from: date)
                }
                
            }
            else if isResetClicked
            {
                self.eventsRangeView.selectionStartDate = nil
                self.eventsRangeView.selectionEndDate = nil
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
        }else{
            
            if isResetClicked
            {
                self.isResetClicked = false
                calendarRangeStartDate = SharedUtlity.sharedHelper().dateFormatter.string(from: Date())  as String
                calendarRangeEndDate = SharedUtlity.sharedHelper().dateFormatter.string(from: Date()) as String
            }
            
        } */
              
        
        if self.appDelegate.selectedSegment == "0"
        {
            self.lblBottomDispalyName.isHidden = false

        }
              
        calanderView.isHidden = false
        btnClose.isHidden = true
        eventsRangeView.isHidden = true
        uiMainView.isHidden = false
        btnReset.isHidden = true
        btnSubmit.isHidden = true
        // self.eventApi(strSearch: eventSearchBar.text!)
        reservationsearchBar.isHidden = false
        segmentView.isHidden = false
        stackView.isHidden = false
              
        if calendarRangeEndDate == "" {
            calendarRangeEndDate = calendarRangeStartDate
        }
        
        //Holds the strings to pass to the respective controller
        self.appDelegate.dateSortToDate = self.calendarRangeStartDate ?? ""
        self.appDelegate.dateSortFromDate = self.calendarRangeEndDate ?? ""
          
        let userInfo = [ "searchText" : "" , "resetMonth" : "1"]
        NotificationCenter.default.post(name: NSNotification.Name("eventsData"), object: nil, userInfo: userInfo)
        
    }
    
    @IBAction func closeClicked(_ sender: Any)
    {
        
        self.calendarDidSelectDate = false
        self.eventsRangeView.selectionStartDate = nil
        self.eventsRangeView.selectionEndDate = nil
        calendarRangeStartDate = self.calendarPreviousStartDate
        calendarRangeEndDate = self.calendarPreviousEndDate
        
        //Old Logic
        
        /*
//        if calendarDidSelectDate == true{
//
//        }else{
//            calendarRangeStartDate = SharedUtlity.sharedHelper().dateFormatter.string(from: Date())  as String
//            calendarRangeEndDate = SharedUtlity.sharedHelper().dateFormatter.string(from: Date()) as String
//        }
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
        
        if self.appDelegate.selectedSegment == "0" {
            self.lblBottomDispalyName.isHidden = false

        }
        
        calanderView.isHidden = false
        btnClose.isHidden = true
        eventsRangeView.isHidden = true
        uiMainView.isHidden = false
        btnReset.isHidden = true
        btnSubmit.isHidden = true
      
        reservationsearchBar.isHidden = false
        segmentView.isHidden = false
        stackView.isHidden = false
        
        if self.isResetClicked
        {
            let userInfo = [ "searchText" : "","resetMonth" : "1"  ]
            NotificationCenter.default.post(name: NSNotification.Name("eventsData"), object: nil, userInfo: userInfo)
            self.isResetClicked = false
        }
        
        // Old Logic
        /*
        if calendarRangeEndDate == "" {
            calendarRangeEndDate = calendarRangeStartDate
        }
        self.appDelegate.dateSortToDate = self.calendarRangeStartDate ?? ""
        self.appDelegate.dateSortFromDate = self.calendarRangeEndDate ?? ""
    
        
        let userInfo = [ "searchText" : "" ]
        NotificationCenter.default.post(name: NSNotification.Name("eventsData"), object: nil, userInfo: userInfo)
         */

    }
    
    @IBAction func resetClicked(_ sender: Any)
    {
        calendarDidSelectDate = false
        self.isResetClicked = true
        eventsRangeView.selectionStartDate = nil
        eventsRangeView.selectionEndDate = nil
        
        calendarRangeStartDate = ""
        calendarRangeEndDate = ""
        
        self.calendarPreviousStartDate = ""
        self.calendarPreviousEndDate = ""
        
        self.appDelegate.dateSortToDate = ""
        self.appDelegate.dateSortFromDate = ""
    }
    
    
    //MARK:- DTCalendar View Delegates
    
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
                    //calendarRangeEndDate = SharedUtlity.sharedHelper().dateFormatter.string(from: calendarView.selectionEndDate!)
                }
            }
        } else {
            calendarView.selectionStartDate = date
            calendarView.selectionEndDate = nil
            
        }
        //calendarRangeStartDate = SharedUtlity.sharedHelper().dateFormatter.string(from: calendarView.selectionStartDate!)
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

extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970)
    }
}


