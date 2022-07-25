//
//  GolfRequestTeeTimeVC.swift
//  CSSI
//  Created by apple on 4/16/19.
//  Copyright © 2019 yujdesigns. All rights reserved.

import UIKit
import FSCalendar
import Popover
import PDFKit

class GolfRequestTeeTimeVC: UIViewController, UITableViewDelegate, UITableViewDataSource,  UICollectionViewDelegate, UICollectionViewDataSource, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, guestViewControllerDelegate, RequestCellDelegate,MemberViewControllerDelegate, RegistrationCell, ModifyRegistration, closeModalView, UIActionSheetDelegate, UITextFieldDelegate,closeUpdateSuccesPopup, FCFSCellDelegate {
    
    
    func AddGuestChildren(selecteArray: [RequestData]) {
        
    }
    
    
    func closeUpdateSuccessView() {
        self.dismiss(animated: true, completion: nil)
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for popToViewController in viewControllers {
            if self.appDelegate.closeFrom == "GolfUpdate" {
                if popToViewController is GolfCalendarVC {
                    //Modified by kiran -- ENGAGE0011177 -- V2.5 -- commented as its causing black bar issue on nav bar.
                    //self.navigationController?.navigationBar.isHidden = false
                    self.navigationController!.popToViewController(popToViewController, animated: true)
                    
                }
            }else if self.appDelegate.closeFrom == "EventTennisUpdate"{
                if popToViewController is CalendarOfEventsViewController {
                    //Modified by kiran -- ENGAGE0011177 -- V2.5 -- commented as its causing black bar issue on nav bar.
                    //self.navigationController?.navigationBar.isHidden = true
                    self.navigationController!.popToViewController(popToViewController, animated: true)
                    
                }
            }
        }
    }
    func imgViewClicked(cell: CustomDashBoardCell) {
        
    }
    
    func diningSpecialRequestCheckBoxClicked(cell: CustomDashBoardCell) {
        
    }
    
    func addMemberDelegate() {
            self.dismiss(animated: true, completion: nil)

        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for popToViewController in viewControllers {
            if popToViewController is TeeTimesViewController {
                //Modified by kiran -- ENGAGE0011177 -- V2.5 -- commented as its causing black bar issue on nav bar.
                //self.navigationController?.navigationBar.isHidden = false
                self.navigationController!.popToViewController(popToViewController, animated: true)

            }
        }
        
    }
    
    @IBOutlet weak var dummyHeight: NSLayoutConstraint!
    
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var heightTimeView: NSLayoutConstraint!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var heightCalendarView: NSLayoutConstraint!
    @IBOutlet weak var nineHolesView: UIView!
    @IBOutlet weak var eighteenHolesView: UIView!
    @IBOutlet weak var courseView: UIView!
    @IBOutlet weak var heightRules: NSLayoutConstraint!
    
    
    @IBOutlet weak var lblPreferredTeetime: UILabel!
    @IBOutlet weak var btnModifyTime: UIButton!

    @IBOutlet weak var btnModifyDate: UIButton!
    
    @IBOutlet weak var heightSelectRequestDate: NSLayoutConstraint!
    @IBOutlet weak var heightCancelRequest: NSLayoutConstraint!
    @IBOutlet weak var btnCancelRequest: UIButton!
    @IBOutlet weak var lblEarliestTeeTime: UILabel!
    @IBOutlet weak var btnGolfPolicy: UIButton!
    @IBOutlet weak var lblSelectRequstDate: UILabel!
    
    //Modified by kiran V1.5 -- PROD0000202 -- First come first serve change
    //PROD0000202 -- Start
    //@IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    //PROD0000202 -- End
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var groupsTableview: UITableView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var courceCollectionView: UICollectionView!
    @IBOutlet weak var btnRequest: UIButton!
    
    @IBOutlet weak var modifyTableview: UITableView!
    @IBOutlet weak var heightModifyTableview: NSLayoutConstraint!
    @IBOutlet weak var heightViewGroups: NSLayoutConstraint!
    @IBOutlet weak var txtPreferredTeeTime: UITextField!
    @IBOutlet weak var txtEarliestTeeTime: UITextField!
    @IBOutlet weak var viewGroups: UIView!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var myCalendar: FSCalendar!
    @IBOutlet weak var lblGroupNumber: UILabel!
    @IBOutlet weak var lblGroups: UILabel!
    @IBOutlet weak var lblLinkGroupsReg: UILabel!
    @IBOutlet weak var lblBottomUserName: UILabel!
    @IBOutlet weak var btnIncreaseTicket: UIButton!
    @IBOutlet weak var btnDecreaseTickets: UIButton!

    @IBOutlet weak var switchLinkGroup: UISwitch!
    @IBOutlet weak var btnNineHoles: UIButton!
    @IBOutlet weak var btnEighteenHoles: UIButton!
    @IBOutlet weak var btnMultiSelect: UIButton!
    @IBOutlet weak var instructionsTableView: SelfSizingTableView!
    
    @IBOutlet weak var instructionsTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewMultiSelection: UIView!
    
    //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
    //PROD0000202 -- Start
    @IBOutlet weak var viewFirstComeOption: UIView!
    @IBOutlet weak var btnFirstCome: UIButton!
    @IBOutlet weak var viewfirstComeFirstServce: UIView!
    @IBOutlet weak var tblViewfirstComeFirstServce: SelfSizingTableView!
    @IBOutlet weak var tblViewfirstComeFirstServceConstraint: NSLayoutConstraint!
    //PROD0000202 -- End
    
    // Modified by Zeeshan
    @IBOutlet weak var timeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var eighteennHolesViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblLegendInfo: UILabel!
    @IBOutlet weak var lblLegendInfoHeight: NSLayoutConstraint!
    @IBOutlet weak var viewGroupBottomSpacing: NSLayoutConstraint!
    
    ///Flag to check if multiple selection button is  clicked
    private var isMultiSelectionClicked = false
    
    var isFirstTime : Int?
    var nameOfMonth : String?
    var currentMonth: Date?

    var myInfo = MemberInfo()
    var arrTeeTimeDetails = [RequestTeeTimeDetail]()
    var arrGroupDetails = [GroupDetail]()
    
    //Gropus data which are waitlisted
    private var arrWaitlistGropus = [WatlistTeeTime]()
    //The group on which waitlist button is tapped. contains the tableview index
    private var waitlistGroup : Int?
    
    var addNewPopoverTableView: UITableView? = nil
    var addNewPopover: Popover? = nil

    var selectedIndex : Int?
    var selectedSection : Int?

    var selectedCellText : String?
    var selectedPreference : Int?
    var selectedExcludedCourse: Int?

    var gameType : Int?
    var golfSettings : GolfSettings?
    var arrGroupList = [RequestData]()
    var arrGroupMaxList1 = [String]()
    var arrGroupMaxList2 = [String]()
    var arrGroupMaxList3 = [String]()
    var arrGroupMaxList4 = [String]()


    var reservationRequestDate : String?
    var reservationRemindDate: String?
    var dateAndTimeDromServer = Date()
    var minTime: String?
    var maxTime: String?
    var memberFromTime: String?
    var memberToTime: String?

    var currentTime: String?
    var arrTotalList = [RequestData]()
    var arrGroup1 = [RequestData]()
    var arrGroup2 = [RequestData]()
    var arrGroup3 = [RequestData]()
    var arrGroup4 = [RequestData]()
    
    var arrTempGroup1 = [RequestData]()
    var arrTempGroup2 = [RequestData]()
    var arrTempGroup3 = [RequestData]()
    var arrTempGroup4 = [RequestData]()
    
    
    var arrGroupsData = [RequestData]()
    var moveToSelectedValue : RequestData?
    var values = [String]()
    var tempValues = [String]()
    var strMoveToValue : String?
    var isFrom : String?
    var isOnlyFrom: String?

    var requestID : String?

    var arrPreferredCource = [String]()
    var arrExcludCourse = [String]()
    var groupList = [Dictionary<String, Any>]()

    var group1List = [Dictionary<String, Any>]()
    var group2List = [Dictionary<String, Any>]()
    var group3List = [Dictionary<String, Any>]()
    var group4List = [Dictionary<String, Any>]()

    var preferenceList = [Dictionary<String, Any>]()
    var notPreferenceList = [Dictionary<String, Any>]()
    var arrRegReqID1 = [String]()
    var arrRegReqID2 = [String]()
    var arrRegReqID3 = [String]()
    var arrRegReqID4 = [String]()
    
    var datePicker2 = UIDatePicker()
    var datePicker1 = UIDatePicker()
    var imageURLString : String?
    var newPlayerGroup1 : Int?
    var newPlayerGroup2 : Int?
    var newPlayerGroup3 : Int?
    var newPlayerGroup4 : Int?
    var firstTime: Bool?
    var addNewMeber: Bool?

    var confirmedReservationID: String?
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var requestType : RequestType?
    
    //Added on 4th July 2020
    private let accessManager = AccessManager.shared
    
    var courseDetails = [CourseSettingsDetail]()
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    fileprivate let newFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    fileprivate let newFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz"
        return formatter
    }()
    
    fileprivate let formatterMonth: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        return formatter
    }()
    
    fileprivate var dob:Date? = nil

    
    private var arrInstructions = [Instruction]()
    ///Height of multiselect button view for layout
    ///
    /// Note : if the layout is changed make sure to change this accordngly
    private var viewMultiSelectionHeight : CGFloat = 37/*Top constraint */+ 31.13/*Height of button*/
    
    //TODO:- Review change
    //This variable only valid when view only button is clicked. when the reqeust button valie is chaned to view then isfrom variable should be used.Need replace isfrom with viewonly value for view functionaity.
    ///When True disables the tap actions
    ///
    /// Note: This will just disbale the user interactions and hides cancel and submit buttons and adds back button.everything else will work based on the other variables passed while initializing this controller.
    var isViewOnly = false
    
    private var partySize : Int = 0
    //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
    //PROD0000202 -- Start
    private var isFirstComeFirstServe = false
    private var transPopupTableView : UITableView?
    private let transOptions : [String] = ["WLK","MCT","CT"]
    //PROD0000202 -- End
    
    // Written by Zeeshan
    var courseDetailsResponse = GolfCourseTimeSlots()
    var selectedSlotsList: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Added on 4th July 2020 V2.2
        //added roles and privilages changes
        //since not allowed is handled before coming to this screen not need to check for it.
        switch self.accessManager.accessPermision(for: .golfReservation) {
        case .view:
            if !self.isViewOnly, self.isFrom != "View" , let message = self.appDelegate.masterLabeling.role_Validation2 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            break
        default:
            break
        }
        
        self.instructionsTableView.delegate = self
        self.instructionsTableView.dataSource = self
        self.instructionsTableView.allowsSelection = false
        self.instructionsTableView.separatorStyle = .none
        self.instructionsTableView.backgroundColor = .clear
        self.instructionsTableView.estimatedRowHeight = 40
        self.instructionsTableView.rowHeight = UITableViewAutomaticDimension
        
        self.instructionsTableView.register(UINib.init(nibName: "InstructionsTableViewCell", bundle: nil), forCellReuseIdentifier: "InstructionsTableViewCell")
        
        // Do any additional setup after loading the view.
        self.btnGolfPolicy.setTitle(self.appDelegate.masterLabeling.golf_policy, for: UIControlState.normal)
        self.lblSelectRequstDate.text = self.appDelegate.masterLabeling.select_request_date
        self.lblPreferredTeetime.text = self.appDelegate.masterLabeling.preferred_tee_time
        self.lblEarliestTeeTime.text = self.appDelegate.masterLabeling.earliest_tee_time
        self.lblGroupNumber.text = self.appDelegate.masterLabeling.group_count
        self.lblLinkGroupsReg.text = self.appDelegate.masterLabeling.groups_link
        self.lblLegendInfo.text = "\(self.appDelegate.masterLabeling.legendInfoTitle ?? "")      \(self.appDelegate.masterLabeling.legendInfoValue ?? "")"
        
       self.lblBottomUserName.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)
        btnNineHoles.tag = 1
        btnEighteenHoles.tag = 2
        selectedPreference = -1
        selectedExcludedCourse = -1
        let itemSize = UIScreen.main.bounds.width/2-1
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.itemSize = CGSize(width: itemSize + 0.25, height: itemSize)
        
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        courceCollectionView.collectionViewLayout = layout
        
        viewGroups.layer.cornerRadius = 18
     
        viewGroups.layer.shadowColor = UIColor.black.cgColor
        viewGroups.layer.shadowOpacity = 0.23
        viewGroups.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewGroups.layer.shadowRadius = 4
    
        
        btnCancelRequest.backgroundColor = .clear
        btnCancelRequest.layer.cornerRadius = 18
        btnCancelRequest.layer.borderWidth = 1
        btnCancelRequest.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        btnCancelRequest .setTitle(self.appDelegate.masterLabeling.cancel_reservation, for: UIControlState.normal)
        self.btnCancelRequest.setStyle(style: .outlined, type: .primary)
      
        self.myCalendar.allowsMultipleSelection = false
        self.myCalendar.weekdayHeight = 50
        self.myCalendar.delegate = self
        self.myCalendar.placeholderType = .none
        self.myCalendar.dataSource = self
        self.txtEarliestTeeTime.delegate = self
        
        txtPreferredTeeTime.delegate = self

        if self.appDelegate.arrGolfGame.count == 0 {
            
        }else{
        btnNineHoles.setTitle(self.appDelegate.arrGolfGame[0].name , for: UIControlState.normal)
        btnEighteenHoles.setTitle(self.appDelegate.arrGolfGame[1].name , for: UIControlState.normal)
        }
        
        btnNineHoles.setImage(UIImage(named : "Rectangle 2117"), for: UIControlState.normal)
        btnEighteenHoles.setImage(UIImage(named : "Group 2384"), for: UIControlState.normal)
        gameType = 18
        
        //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
        //PROD0000202 -- Start
        self.tblViewfirstComeFirstServce.delegate = self
        self.tblViewfirstComeFirstServce.dataSource = self
        self.tblViewfirstComeFirstServce.estimatedRowHeight = 50
        self.tblViewfirstComeFirstServce.estimatedSectionHeaderHeight = 50
        self.tblViewfirstComeFirstServce.register(UINib.init(nibName: "FirstComeFirstServeTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstComeFirstServeTableViewCell")
        self.tblViewfirstComeFirstServce.separatorStyle = .none
        let footerView = UIView()
        footerView.backgroundColor = .clear
        self.tblViewfirstComeFirstServce.tableFooterView = footerView
        if #available(iOS 15.0, *)
        {
            self.tblViewfirstComeFirstServce.sectionHeaderTopPadding = 0
        }
        
//        self.btnFirstCome.setStyle(style: .outlined, type: .primary, cornerRadius: nil)
        
        //PROD0000202 -- End
        
        self.addNewMeber = false
        
        if isFrom == "Modify" || isFrom == "View"{
            self.arrExcludCourse.append("")
            self.arrPreferredCource.append("")
            self.modifyTableview.isHidden = false
            self.groupsTableview.isHidden = true
            self.btnCancelRequest.isHidden = false
            self.heightCancelRequest.constant = 37
            isFirstTime = 1
            self.heightSelectRequestDate.constant = 84
            self.btnModifyDate.isHidden = false
            
            btnRequest.backgroundColor = .clear
            btnRequest.layer.cornerRadius = 18
            btnRequest.layer.borderWidth = 1
            btnRequest.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
            btnRequest .setTitle(self.appDelegate.masterLabeling.Save, for: UIControlState.normal)
            self.btnRequest.setStyle(style: .outlined, type: .primary)
        }
        
        else{
            btnDecreaseTickets.isEnabled = false
            self.modifyTableview.isHidden = true
            self.groupsTableview.isHidden = false
            self.btnCancelRequest.isHidden = true
            self.heightCancelRequest.constant = -20
            isFirstTime = 0
            self.heightSelectRequestDate.constant = 42
            self.btnModifyDate.isHidden = true
            btnRequest.backgroundColor = hexStringToUIColor(hex: "F37D4A")
            btnRequest.layer.cornerRadius = 18
            btnRequest.layer.borderWidth = 1
            btnRequest.layer.borderColor = UIColor.clear.cgColor
            btnRequest .setTitle(self.appDelegate.masterLabeling.rEQUEST, for: UIControlState.normal)
            btnRequest.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.btnRequest.setStyle(style: .contained, type: .primary)

        }

        groupsTableview.estimatedSectionHeaderHeight = 20
        
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton

        self.golfSettings  = self.appDelegate.arrGolfSettings

        requestReservationApi()
        
        
                
        
        //Multi Selection button hide/show
        //Modified by kiran V2.5 -- GATHER0000606 -- added hiding multiselect button when multi select options are empty.
        //GATHER0000606 -- Start
        //self.viewMultiSelection.isHidden = (isFrom == "Modify" || isFrom == "View")
        
        self.viewMultiSelection.isHidden = (isFrom == "Modify" || isFrom == "View" || self.appDelegate.addRequestOpt_Golf_MultiSelect.count == 0)
        //GATHER0000606 -- End
        
        
        self.btnMultiSelect.setTitle(self.appDelegate.masterLabeling.MULTI_SELECT ?? "", for: .normal)
        self.btnMultiSelect.multiSelectBtnViewSetup()
        
        self.arrInstructions = self.appDelegate.ReservationsInstruction
        
        
        self.disableActions()
        
        //Added on 14th October 2020 V2.3
        //Added for iOS 14 date picker change
        if #available(iOS 14.0,*)
        {
            self.datePicker1.preferredDatePickerStyle = .wheels
            self.datePicker2.preferredDatePickerStyle = .wheels
        }
        
        self.myCalendar.appearance.selectionColor = APPColor.MainColours.primary2
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
        
        
    }
    
    func getDateString(givenDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: givenDate)
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        
        let dateDiff = findDateDiff(time1Str: self.minTime ?? "", time2Str: currentTime ?? "")
        if self.golfSettings?.minDaysInAdvance == 0 {
            if dateDiff.first == "-"{
                self.myCalendar.appearance.titleTodayColor =  UIColor.black
            }else{
                self.myCalendar.appearance.titleTodayColor =  UIColor.lightGray
            }
        }else{
            self.myCalendar.appearance.titleTodayColor =  UIColor.lightGray
            
        }
        if dateDiff.first == "+"{
            return Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.minDaysInAdvance ?? 0) + 1, to: self.dateAndTimeDromServer)!

        }else{
            return Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.minDaysInAdvance ?? 0) , to: self.dateAndTimeDromServer)!
        }
    }
    func maximumDate(for calendar: FSCalendar) -> Date {
        
        let dateDiff = findDateDiff(time1Str: self.maxTime ?? "", time2Str: currentTime ?? "")
        if dateDiff.first == "+"{
            return Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.maxDaysInAdvance ?? 0) + 1, to: self.dateAndTimeDromServer)!

        }else{
            return Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.maxDaysInAdvance ?? 0), to: self.dateAndTimeDromServer)!

        }
    }
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationItem.title = self.appDelegate.masterLabeling.request_tee_time
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        //  IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didDOBDateChange(datePicker:UIDatePicker) {
        dob = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"

        txtPreferredTeeTime.text = dateFormatter.string(for: dob)
        
        self.PreferenceTimeChanged()
    }
    
    @objc func didEarliestDateChanged(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        txtEarliestTeeTime.text = dateFormatter.string(for: datePicker.date)
    }
    
    func PreferenceTimeChanged(){
        let dateAsStringMin = self.golfSettings?.fromTime
        let dateFormatterMin = DateFormatter()
        dateFormatterMin.dateFormat = "hh:mm a"
        
        let dateMin = dateFormatterMin.date(from: dateAsStringMin!)
        dateFormatterMin.dateFormat = "HH:mm"
        
        let DateMin = dateFormatterMin.string(from: dateMin!)
        
        let dateAsStringMax = self.txtPreferredTeeTime.text
        let dateFormatterMax = DateFormatter()
        dateFormatterMax.dateFormat = "hh:mm a"
        
        let dateMax = dateFormatterMax.date(from: dateAsStringMax!)
        dateFormatterMax.dateFormat = "HH:mm"
        
        let DateMax = dateFormatterMax.string(from: dateMax!)

        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat =  "HH:mm"
        let date1 = dateFormatter1.date(from: DateMin)
        
        
        self.datePicker2.datePickerMode = .time
        
        let min1 = dateFormatter1.date(from: DateMin)      //createing min time
        let max1 = dateFormatter1.date(from: DateMax)
        self.datePicker2.minimumDate = min1  //setting min time to picker
        self.datePicker2.maximumDate = max1
        self.datePicker2.minuteInterval = (self.golfSettings?.timeInterval)!
       // self.datePicker2.setDate(date1!, animated: true)
        self.datePicker2.addTarget(self, action: #selector(self.didEarliestDateChanged(datePicker:)), for: .valueChanged)
        self.txtEarliestTeeTime.inputView = self.datePicker2
    }
    
    //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
    //PROD0000202 -- Start
    @IBAction func firstComeFirstServeClicked(_ sender: UIButton)
    {
        self.enableFirstComeFirstServe(!self.isFirstComeFirstServe)
    }
    
    func timeSlotSelected(slotDetails: [String : Any]) -> [[String:Any]]! {
        if self.isFrom == "View" {
            return self.selectedSlotsList
        } else {
            var slotIndex = 99
            if self.selectedSlotsList.count > 0 {
                for i in 0...self.selectedSlotsList.count-1 {
                    if (self.selectedSlotsList[i]["CourseDetailId"] as! String == slotDetails["CourseDetailId"] as! String && self.selectedSlotsList[i]["Time"] as! String == slotDetails["Time"] as! String) && self.selectedSlotsList[i]["TeeBox"] as! String == slotDetails["TeeBox"] as! String{
                        slotIndex = i
                    }
                }
            }
            
            if slotIndex == 99 {
                if self.selectedSlotsList.count >= self.arrGroupList.count {
                    if let message = self.appDelegate.masterLabeling.fCFS_SELECTTIMEVALIDATION , message.count > 0
                    {
                        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kShortDuration)
                    }
                    return self.selectedSlotsList
                } else {
                    self.selectedSlotsList.append(slotDetails)
    //                print(selectedSlotsList)
                    self.modifyTableview.reloadData()
                    self.groupsTableview.reloadData()
                    return self.selectedSlotsList
                }
            } else {
                self.selectedSlotsList.remove(at: slotIndex)
                self.groupsTableview.reloadData()
                self.modifyTableview.reloadData()
                return self.selectedSlotsList
            }
        }
        
    }
    
    // Modified by Zeeshan
    private func enableFirstComeFirstServe(_ bool : Bool)
    {
        self.isFirstComeFirstServe = bool
    
        
            if self.isFrom == "Modify" || self.isFrom == "View"{
                if self.arrTeeTimeDetails[0].buttonTextValue == "3" || self.arrTeeTimeDetails[0].buttonTextValue == "4" || self.arrTeeTimeDetails[0].buttonTextValue == "5"{
                    
                } else {
                    let currentDateFormatter = DateFormatter()
                    currentDateFormatter.dateFormat = "MM dd,yyyy"
                    if let dateIs = currentDateFormatter.date(from: self.arrTeeTimeDetails[0].reservationRequestDate ?? "") {
                        let dateStringIs = self.getDateString(givenDate: dateIs)
                        self.getTimeSlotsForDate(dateString: dateStringIs)
                    }
                }
            } else {
                if let startDate = self.myCalendar.selectedDate {
                    let dateString = self.getDateString(givenDate: startDate)
                    self.getTimeSlotsForDate(dateString: dateString)
                }
                heightViewGroups.constant = 132
            }
        
        
        if self.isFirstComeFirstServe
        {
//            self.btnFirstCome.setTitle("Switch to Lottery Run Process", for: .normal)
            
            self.lblLinkGroupsReg.isHidden = true
            self.switchLinkGroup.isHidden = true
            self.switchLinkGroup.isOn = false
            self.courseView.isHidden = true
            self.viewfirstComeFirstServce.isHidden = false
            self.timeViewHeight.constant = 0
            self.eighteennHolesViewHeight.constant = 0
            self.lblLegendInfoHeight.constant = 40
            if self.isFrom == "Modify" || self.isFrom == "View"{
                if self.arrTeeTimeDetails[0].buttonTextValue == "3" || self.arrTeeTimeDetails[0].buttonTextValue == "4" || self.arrTeeTimeDetails[0].buttonTextValue == "5"{
                    
                } else {
                    if let selectedSlots = self.arrTeeTimeDetails[0].toJSON()["PreferredFCFSCoursesWithTime"] as? [[String : Any]] {
                        self.selectedSlotsList = selectedSlots
                    } else {
                        self.selectedSlotsList = []
                    }
                }
            }
            self.modifyTableview.reloadData()
            self.groupsTableview.reloadData()
            
        }
        else
        {
//            self.btnFirstCome.setTitle("Switch to First Come First Serve", for: .normal)
            self.courseView.isHidden = false
            self.viewfirstComeFirstServce.isHidden = true
            self.timeViewHeight.constant = 105
            self.eighteennHolesViewHeight.constant = 67
            self.lblLegendInfoHeight.constant = 0
            self.groupsTableview.reloadData()
            if self.lblGroupNumber.text == "01" {
                heightViewGroups.constant = 132
                self.lblLinkGroupsReg.isHidden = true
                self.switchLinkGroup.isHidden = true
                self.switchLinkGroup.isOn = false
            } else {
                heightViewGroups.constant = 268
                self.lblLinkGroupsReg.isHidden = false
                self.switchLinkGroup.isHidden = false
                self.switchLinkGroup.isOn = true
            }
        }
    }
    //PROD0000202 -- End

   
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        
       self.instructionsTableViewHeight.constant = self.instructionsTableView.contentSize.height
        //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
        //PROD0000202 -- Start
        self.tblViewfirstComeFirstServceConstraint.constant = self.tblViewfirstComeFirstServce.contentSize.height
        //PROD0000202 -- End
        let btnMultiSelectHeight = (self.viewMultiSelection.isHidden ? 0 : self.viewMultiSelectionHeight) + 5/*Gap between multi select and instructions*/
      if isFrom == "Modify" || isFrom == "View"{
            
            if self.arrTeeTimeDetails.count == 0 {
                
            }else{
                if self.arrTeeTimeDetails[0].buttonTextValue == "3" || self.arrTeeTimeDetails[0].buttonTextValue == "4" || self.arrTeeTimeDetails[0].buttonTextValue == "5"{
                    self.tableViewHeight?.constant = self.modifyTableview.contentSize.height
                    self.heightModifyTableview?.constant = self.modifyTableview.contentSize.height
                    //Modified by kiran V1.5 -- PROD0000202 -- First come first serve change
                    //PROD0000202 -- Start
                    //self.mainViewHeight.constant = 430 + tableViewHeight.constant + heightViewGroups.constant + btnMultiSelectHeight + self.instructionsTableViewHeight.constant
                    //PROD0000202 -- End
                }else{
                    self.tableViewHeight?.constant = self.modifyTableview.contentSize.height
                    self.heightModifyTableview?.constant = self.modifyTableview.contentSize.height
                    self.collectionViewHeight?.constant = self.courceCollectionView.contentSize.height
                    //Modified by kiran V1.5 -- PROD0000202 -- First come first serve change
                    //PROD0000202 -- Start
                    //self.mainViewHeight.constant = 900 + tableViewHeight.constant + collectionViewHeight.constant + heightViewGroups.constant + btnMultiSelectHeight + self.instructionsTableViewHeight.constant
                    //PROD0000202 -- End
                }
                
            }
        }
       
        else{
        self.tableViewHeight?.constant = self.groupsTableview.contentSize.height
        self.heightModifyTableview?.constant = self.groupsTableview.contentSize.height
        self.collectionViewHeight?.constant = self.courceCollectionView.contentSize.height
            //Modified by kiran V1.5 -- PROD0000202 -- First come first serve change
            //PROD0000202 -- Start
        //self.mainViewHeight.constant = 900 + tableViewHeight.constant + collectionViewHeight.constant + heightViewGroups.constant + btnMultiSelectHeight + self.instructionsTableViewHeight.constant
            //PROD0000202 -- End
        }
       
       
    }
    //Mark- Get Reservation Setting Details Api

    func requestReservationApi() {

    self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
    
    let paramaterDict: [String : Any] = [
        APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
        APIKeys.kdeviceInfo: [APIHandler.devicedict],
        APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
        APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
        "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
        "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!
    ]
    
    APIHandler.sharedInstance.getReservationSettings(paramater: paramaterDict , onSuccess: { response in
    
        self.golfSettings = response.golfSettings
        
        let dateAsStringMin = self.golfSettings?.fromTime
        let dateFormatterMin = DateFormatter()
        dateFormatterMin.dateFormat = "hh:mm a"
        
        let dateMin = dateFormatterMin.date(from: dateAsStringMin!)
        dateFormatterMin.dateFormat = "HH:mm"
        
        let DateMin = dateFormatterMin.string(from: dateMin!)
        
        let dateAsStringMax = self.golfSettings?.toTime
        let dateFormatterMax = DateFormatter()
        dateFormatterMax.dateFormat = "hh:mm a"
        
        let dateMax = dateFormatterMax.date(from: dateAsStringMax!)
        dateFormatterMax.dateFormat = "HH:mm"
        
        let DateMax = dateFormatterMax.string(from: dateMax!)
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        let date = dateFormatter.date(from: DateMin)
        
        self.datePicker1.datePickerMode = .time
        
        let min = dateFormatter.date(from: DateMin)      //createing min time
        let max = dateFormatter.date(from: DateMax) //creating max time
        self.datePicker1.minimumDate = min  //setting min time to picker
        self.datePicker1.maximumDate = max
        self.datePicker1.minuteInterval = (self.golfSettings?.timeInterval)!  // with interval of 30
        
    
        self.datePicker1.setDate(date!, animated: true)
        self.datePicker1.addTarget(self, action: #selector(self.didDOBDateChange(datePicker:)), for: .valueChanged)
        self.txtPreferredTeeTime.inputView = self.datePicker1
        self.txtPreferredTeeTime.text = self.golfSettings?.memberFromTime
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat =  "HH:mm"
        let date1 = dateFormatter1.date(from: DateMin)


        self.datePicker2.datePickerMode = .time

        let min1 = dateFormatter1.date(from: DateMin)      //createing min time
        let max1 = dateFormatter1.date(from: DateMax)
        self.datePicker2.minimumDate = min1  //setting min time to picker
        self.datePicker2.maximumDate = min1
        self.datePicker2.minuteInterval = (self.golfSettings?.timeInterval)!
        self.datePicker2.setDate(date1!, animated: true)
        self.datePicker2.addTarget(self, action: #selector(self.didEarliestDateChanged(datePicker:)), for: .valueChanged)
        self.txtEarliestTeeTime.inputView = self.datePicker2

        self.txtEarliestTeeTime.text = self.golfSettings?.memberFromTime
        
        let dateFormatterMinFromTime = DateFormatter()
        dateFormatterMinFromTime.dateFormat = "hh:mm a"
        
        let dateMinFromTime = dateFormatterMinFromTime.date(from: self.txtPreferredTeeTime.text ?? "")
        dateFormatterMinFromTime.dateFormat = "HH:mm"
        
        let DateMinFromTime = dateFormatterMinFromTime.string(from: dateMinFromTime!)
        
       
        let dateFromTime = dateFormatter.date(from: DateMinFromTime)
        
        self.datePicker1.setDate(dateFromTime!, animated: true)
        self.datePicker1.addTarget(self, action: #selector(self.didDOBDateChange(datePicker:)), for: .valueChanged)
        self.txtPreferredTeeTime.inputView = self.datePicker1
        
        
        let dateFormatterEarlierFromTime = DateFormatter()
        dateFormatterEarlierFromTime.dateFormat = "hh:mm a"

        let dateEarlierFromTime = dateFormatterEarlierFromTime.date(from: self.txtEarliestTeeTime.text ?? "")
        dateFormatterEarlierFromTime.dateFormat = "HH:mm"
        
        let DateEarlierFromTime = dateFormatterEarlierFromTime.string(from: dateEarlierFromTime!)
        
        
        let date2FromTime = dateFormatter.date(from: DateEarlierFromTime)
        self.datePicker2.setDate(date2FromTime!, animated: true)
        self.datePicker2.addTarget(self, action: #selector(self.didEarliestDateChanged(datePicker:)), for: .valueChanged)
        self.txtEarliestTeeTime.inputView = self.datePicker2
        
        self.PreferenceTimeChanged()

        let dateFormatterToSend = DateFormatter()
        dateFormatterToSend.dateFormat = "MM/dd/yyyy"
        self.reservationRequestDate = dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!)
        
        
        self.minTime = self.golfSettings?.minDaysInAdvanceTime
        self.maxTime = self.golfSettings?.maxDaysInAdvanceTime
        

        self.memberFromTime = self.golfSettings?.memberFromTime
        self.memberToTime = self.golfSettings?.memberFromTime
        
        let dateString = self.golfSettings?.gETDATETIME

        let dateFormatter6 = DateFormatter()
        dateFormatter6.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter6.locale = Locale(identifier: "en_US_POSIX")
        self.dateAndTimeDromServer = dateFormatter6.date(from:dateString!)!
        
        let currentDateFormatter = DateFormatter()
        currentDateFormatter.dateFormat = "hh:mm a"
        self.currentTime = currentDateFormatter.string(from:self.dateAndTimeDromServer)
        
        
     //   let dateTime = self.newFormatter.string(from:(self.golfSettings?.gETDATETIME))

      //  self.dateAndTimeDromServer = dateTime
        self.reservationRemindDate = self.newFormatter.string(from: Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!)

        if self.isFrom == "Modify" || self.isFrom == "View"{
            
        }
        else{
            
            let dateDiff = self.findDateDiff(time1Str: self.minTime ?? "", time2Str: self.currentTime ?? "")
            if dateDiff.first == "-"{
                self.myCalendar.select(Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer))
                self.reservationRequestDate = dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!)
                self.reservationRemindDate = self.newFormatter.string(from: Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!)

            }else{
                self.myCalendar.select(Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.minDaysInAdvance)! + 1, to: self.dateAndTimeDromServer))
                self.reservationRequestDate = dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.minDaysInAdvance)! + 1, to: self.dateAndTimeDromServer)!)
                self.reservationRemindDate = self.newFormatter.string(from: Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.minDaysInAdvance)! + 1, to: self.dateAndTimeDromServer)!)
            }

        }
      
        let dateFormatterYear = DateFormatter()
        dateFormatterYear.dateFormat = "LLLL"
        let dateDiff = self.findDateDiff(time1Str: self.maxTime ?? "", time2Str: self.currentTime ?? "")
        if dateDiff.first == "+"{
            self.nameOfMonth = dateFormatterYear.string(from: Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.minDaysInAdvance)! + 1, to: self.dateAndTimeDromServer)!)

            
        }else{
            self.nameOfMonth = dateFormatterYear.string(from: Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!)

        }
        
        let calendar = Calendar.current
        self.lblYear.text = "\(calendar.component(.year, from: self.dateAndTimeDromServer))"
        
        self.lblMonth.text = self.nameOfMonth
        
        self.myCalendar.reloadData()
        
      
        
        if(self.golfSettings?.minGroupReserv ==  1){
            self.heightViewGroups.constant = 132
            self.lblLinkGroupsReg.isHidden = true
            self.switchLinkGroup.isHidden = true
            self.switchLinkGroup.isOn = false
        }
        
        if (self.isFrom == "Modify" || self.isFrom == "View") && self.isFirstTime == 1{
            self.getTeeTimeRequestDetailsApi()
            self.isFirstTime = 0
        }else{
            // Modified by Zeeshan
            if let fcfsStatus = self.appDelegate.arrGolfSettings?.isFCFSGolfRequestEnable {
                self.enableFirstComeFirstServe(fcfsStatus)
            }
        }
        if self.isFrom == "Modify" || self.isFrom == "View" {
            
        }else{
        self.lblGroupNumber.text = String(format: "%02d", self.golfSettings?.minGroupReserv ?? 1)
        
        let value = self.golfSettings?.maxMultiGroupPlayers
        for _ in 0 ..< (self.golfSettings?.minGroupReserv ?? 0) {
            self.arrGroupList.append(RequestData())
            
        }
        for _ in 0 ..< (value ?? 0) {
            self.arrGroupMaxList1.append("")
//            self.arrGroupMaxList2.append("")
//            self.arrGroupMaxList3.append("")
//            self.arrGroupMaxList4.append("")

        }
        }
        if self.isFrom == "Modify" || self.isFrom == "View"{
            
        }else{
        let value = self.golfSettings?.maxMultiGroupPlayers
        for _ in 0 ..< (value ?? 0) {
            self.arrGroup1.append(RequestData())
            
        }
            
        //Removed this to prevent double records in groups when group count is increased
        /*for _ in 0 ..< (value ?? 0) {
            self.arrGroup2.append(RequestData())
            
        }
        for _ in 0 ..< (value ?? 0) {
            self.arrGroup3.append(RequestData())
            
        }
        for _ in 0 ..< (value ?? 0) {
            self.arrGroup4.append(RequestData())
            
        }*/
            let captainInfo = CaptaineInfo.init()
            captainInfo.setCaptainDetails(id: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "", name: UserDefaults.standard.string(forKey: UserDefaultsKeys.captainName.rawValue) ?? "", firstName: UserDefaults.standard.string(forKey: UserDefaultsKeys.firstName.rawValue) ?? "", order: 1, memberID: UserDefaults.standard.string(forKey: UserDefaultsKeys.memberID.rawValue) ?? "", parentID: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "", profilePic: UserDefaults.standard.string(forKey: UserDefaultsKeys.userProfilepic.rawValue) ?? "")
            
            
            let selectedObject = captainInfo
            selectedObject.isEmpty = false
            self.arrGroup1.remove(at: 0)
            self.arrGroup1.insert(selectedObject, at: 0)
            
            
            self.firstTime = true
            self.golfDuplicates()
            self.memberValidattionAPI({ (status) in
                
            })
            
            //Added by kiran v2.9 -- Cobalt Pha0010644 -- Updated the settings with selected date for request scenario
            //Cobalt Pha0010644 -- Start
            //TODO:- remove after V2.9 is approved in testing
            //self.updateSettings(success: {})
            //Cobalt Pha0010644 -- End
        }
        self.groupsTableview.reloadData()
        self.appDelegate.hideIndicator()
        
    }) { (error) in
    SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
    self.appDelegate.hideIndicator()
    
    }
}
    
    func getTimeSlotsForDate(dateString: String) {
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        let paramaterDict: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
            "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!,
            "RequestId": requestID ?? "",
            "ReservationRequestDate": dateString
        ]
        APIHandler.sharedInstance.GetFCFSCourcesAvailabilityTimeList(paramater: paramaterDict , onSuccess: { response in
            
            if(response.responseCode == InternetMessge.kSuccess) {
                self.courseDetailsResponse = response
                self.tblViewfirstComeFirstServce.reloadData()
                self.courceCollectionView.reloadData()
                self.groupsTableview.reloadData()
                self.courceCollectionView.reloadData()
                self.modifyTableview.reloadData()
            }
            self.appDelegate.hideIndicator()
            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            self.appDelegate.hideIndicator()
            
        }
    }
    
    //Added by kiran v2.9 -- Cobalt Pha0010644 -- Function to update the Hard & Soft message details of courses when date is changed
    //Cobalt Pha0010644 -- Start
    //Note:- Created a separate function to update settings instead of using a new function as the required changes will impact the old functionalty. To minimize impact we will use this new function to update the settings to show Hard & soft messages. This will only work if there is no change in settings except the alert details change.
    private func updateSettings(success: @escaping (()->()))
    {
        guard let reachable = Network.reachability?.isReachable, reachable else
        {
            CustomFunctions.shared.showToast(WithMessage: InternetMessge.kInternet_not_available, on: self.view)
            return
        }
        
        CustomFunctions.shared.showActivityIndicator(withTitle: "", intoView: self.view)
        let paramaterDict: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
            "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!,
            APIKeys.kRequestDate : self.reservationRequestDate ?? ""
        ]
        
        APIHandler.sharedInstance.getReservationSettings(paramater: paramaterDict) { response in
            
            self.golfSettings = response.golfSettings
            success()
            CustomFunctions.shared.hideActivityIndicator()
        } onFailure: { error in
            CustomFunctions.shared.hideActivityIndicator()
            CustomFunctions.shared.showToast(WithMessage: error.localizedDescription, on: self.view)
        }

    }
    //Cobalt Pha0010644 -- End
    
    //Mark- Get Golf Request Details Api
    func getTeeTimeRequestDetailsApi() {
        
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
                "DateSort": ""
            ]
            
            APIHandler.sharedInstance.getRequestTeeTimeDetails(paramaterDict: paramaterDict, onSuccess: { response in
                self.appDelegate.hideIndicator()
                
                if(response.responseCode == InternetMessge.kSuccess)
                {
                    if(response.requestTeeTimeDetails == nil){
                        self.arrTeeTimeDetails.removeAll()
                        self.modifyTableview.setEmptyMessage(InternetMessge.kNoData)
                        self.modifyTableview.reloadData()
                    }
                    else{
                        
                        if(response.requestTeeTimeDetails?.count == 0)
                        {
                            self.arrTeeTimeDetails.removeAll()
                            self.modifyTableview.setEmptyMessage(InternetMessge.kNoData)
                            self.modifyTableview.reloadData()
                            
                            
                        }else{
                            self.modifyTableview.restore()
                            self.arrTeeTimeDetails = response.requestTeeTimeDetails! //eventList.listevents!
                            self.arrGroupDetails = (response.requestTeeTimeDetails?[0].groupDetails)!
                            if self.arrTeeTimeDetails[0].buttonTextValue == "3" || self.arrTeeTimeDetails[0].buttonTextValue == "4" || self.arrTeeTimeDetails[0].buttonTextValue == "5"{
                                self.timeView.isHidden = true
                                self.heightTimeView.constant = 0
                                self.dummyHeight.constant = 0
                                self.calenderView.isHidden = true
                                self.heightCalendarView.constant = 0
                                self.nineHolesView.isUserInteractionEnabled = false
                                self.eighteenHolesView.isUserInteractionEnabled = false
                                self.courseView.isUserInteractionEnabled = false
                                self.collectionViewHeight.constant = 0
                                self.heightSelectRequestDate.constant = 62
                                self.lblSelectRequstDate.isHidden = true
                                self.txtEarliestTeeTime.isEnabled = false
                                self.txtPreferredTeeTime.isEnabled = false
                                self.viewGroups.isUserInteractionEnabled = false
                                self.arrPreferredCource.remove(at: 0)
                                self.arrExcludCourse.remove(at: 0)
                                self.arrPreferredCource.append(self.arrTeeTimeDetails[0].preferedDetailId ?? "")
                                self.arrExcludCourse.append(self.arrTeeTimeDetails[0].notPreferedSpaceDetailId ?? "")
                                self.btnModifyTime.isHidden = false
                                self.btnModifyTime.setTitle(self.arrTeeTimeDetails[0].reservationRequestTime, for: UIControlState.normal)
                                self.txtPreferredTeeTime.text = self.arrTeeTimeDetails[0].reservationRequestTime
                                self.txtEarliestTeeTime.text = self.arrTeeTimeDetails[0].earliest
                                // Modified by Zeeshan
//                                self.tblViewfirstComeFirstServceConstraint.constant = 0
//                                self.tblViewfirstComeFirstServce.isHidden = true
                                self.heightViewGroups.constant = 0
//                                self.heightViewGroups.constant = 0
                                self.viewGroupBottomSpacing.constant = 0

                                self.view.layoutIfNeeded()
                            }else{
                                
                                self.txtPreferredTeeTime.text = self.arrTeeTimeDetails[0].reservationRequestTime
                                self.txtEarliestTeeTime.text = self.arrTeeTimeDetails[0].earliest
                                self.PreferenceTimeChanged()
                                let dateFormatterMin = DateFormatter()
                                dateFormatterMin.dateFormat = "hh:mm a"
                                
                                let dateMin = dateFormatterMin.date(from: self.txtPreferredTeeTime.text!)
                                dateFormatterMin.dateFormat = "HH:mm"
                                
                                let DateMin = dateFormatterMin.string(from: dateMin!)
                                
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat =  "HH:mm"
                                let date = dateFormatter.date(from: DateMin)
                                
                                self.datePicker1.setDate(date!, animated: true)
                                self.datePicker1.addTarget(self, action: #selector(self.didDOBDateChange(datePicker:)), for: .valueChanged)
                                self.txtPreferredTeeTime.inputView = self.datePicker1
                                
                                
                                let dateFormatterEarlier = DateFormatter()
                                dateFormatterEarlier.dateFormat = "hh:mm a"
                                
                                if let dateEarlier = dateFormatterEarlier.date(from: self.txtEarliestTeeTime.text!) {
                                    dateFormatterEarlier.dateFormat = "HH:mm"
                                    
                                    let DateEarlier = dateFormatterMin.string(from: dateEarlier)
                                    
                                    
                                    let date2 = dateFormatter.date(from: DateEarlier)
                                    self.datePicker2.setDate(date2!, animated: true)
                                    self.datePicker2.addTarget(self, action: #selector(self.didEarliestDateChanged(datePicker:)), for: .valueChanged)
                                    self.txtEarliestTeeTime.inputView = self.datePicker2
                                }
                            }
                            self.btnModifyTime.isHidden = false
                            self.btnModifyTime.setTitle(self.arrTeeTimeDetails[0].reservationRequestTime, for: UIControlState.normal)
                                
//                            }
                            if self.arrTeeTimeDetails[0].isCancel == 1{
                                self.btnCancelRequest.isHidden = false
                                self.heightCancelRequest.constant = 37

                            }else{
                                self.btnCancelRequest.isHidden = true
                                self.heightCancelRequest.constant = -20
                            }

                            for i in 0..<self.arrTeeTimeDetails[0].groupDetails!.count {
                                if i == 0 {
                                    for _ in 0..<self.arrTeeTimeDetails[0].groupDetails![i].details!.count {
                                        self.arrGroup1.append(RequestData())
                                    }
                                }else if i == 1 {
                                    for _ in 0..<self.arrTeeTimeDetails[0].groupDetails![i].details!.count {
                                        self.arrGroup2.append(RequestData())
                                    }
                                }else if i == 2 {
                                    for _ in 0..<self.arrTeeTimeDetails[0].groupDetails![i].details!.count {
                                        self.arrGroup3.append(RequestData())
                                    }
                                }else{
                                    for _ in 0..<self.arrTeeTimeDetails[0].groupDetails![i].details!.count {
                                    self.arrGroup4.append(RequestData())
                                    }
                                }
                            }
                            
                            for i in 0..<self.arrTeeTimeDetails[0].groupDetails!.count {
                                if i == 0 {
                                    for j in 0..<self.arrTeeTimeDetails[0].groupDetails![i].details!.count {
                                        self.arrGroup1.remove(at: j)
                                        self.arrGroup1.insert(((self.arrTeeTimeDetails[0].groupDetails?[i].details![j])!), at: j)
                                        let playObj = self.arrGroup1[j] as! Detail
                                        self.arrRegReqID1.append(playObj.reservationRequestDetailID!)
                                    }
                                }else if i == 1 {
                                    for j in 0..<self.arrTeeTimeDetails[0].groupDetails![i].details!.count {
                                        self.arrGroup2.remove(at: j)
                                        self.arrGroup2.insert(((self.arrTeeTimeDetails[0].groupDetails?[i].details![j])!), at: j)
                                        let playObj = self.arrGroup2[j] as! Detail
                                        self.arrRegReqID2.append(playObj.reservationRequestDetailID!)
                                    }
                                }else if i == 2 {
                                    for j in 0..<self.arrTeeTimeDetails[0].groupDetails![i].details!.count {
                                        self.arrGroup3.remove(at: j)
                                        self.arrGroup3.insert(((self.arrTeeTimeDetails[0].groupDetails?[i].details![j])!), at: j)
                                        let playObj = self.arrGroup3[j] as! Detail
                                        self.arrRegReqID3.append(playObj.reservationRequestDetailID!)
                                    }
                                }else{
                                    for j in 0..<self.arrTeeTimeDetails[0].groupDetails![i].details!.count {
                                    self.arrGroup4.remove(at: j)
                                    self.arrGroup4.insert(((self.arrTeeTimeDetails[0].groupDetails?[i].details![j])!), at: j)
                                        let playObj = self.arrGroup4[j] as! Detail
                                        self.arrRegReqID4.append(playObj.reservationRequestDetailID!)
                                    }
                                }
                              
                                
                            }
                            if self.arrTeeTimeDetails[0].groupDetails?.count == 4 {
                                self.btnIncreaseTicket.isEnabled = false
                            }
                            if self.arrTeeTimeDetails[0].groupDetails?.count == 1 {
                                self.btnDecreaseTickets.isEnabled = false
                            }
                            self.btnModifyDate.setTitle(self.arrTeeTimeDetails[0].reservationRequestDate, for: UIControlState.normal)
                            self.reservationRequestDate = self.formatter.string(from: self.formatter.date(from: self.arrTeeTimeDetails[0].reservationRequestDate!)!)
                           
                            
                            self.modifyTableview.reloadData()

                            if(self.arrTeeTimeDetails[0].gameType == 9){
                                self.btnNineHoles.setImage(UIImage(named : "Group 2384"), for: UIControlState.normal)
                                self.btnEighteenHoles.setImage(UIImage(named : "Rectangle 2117"), for: UIControlState.normal)
                                self.gameType = 9
                            }
                            else{
                                self.btnEighteenHoles.setImage(UIImage(named : "Group 2384"), for: UIControlState.normal)
                                self.btnNineHoles.setImage(UIImage(named : "Rectangle 2117"), for: UIControlState.normal)
                                self.gameType = 18
                            }
                     
                            if(self.arrTeeTimeDetails[0].groupDetails?.count ==  1){
                                self.heightViewGroups.constant = 132
                                self.lblLinkGroupsReg.isHidden = true
                                self.switchLinkGroup.isHidden = true
                                self.switchLinkGroup.isOn = false
                            }
                            else{
                                
                                self.heightViewGroups.constant = 268
                                self.lblLinkGroupsReg.isHidden = false
                                self.switchLinkGroup.isHidden = false
                                
                                if self.arrTeeTimeDetails[0].linkGroup == "0"{
                                   
                                    self.switchLinkGroup.isOn = false
                                }else{
                                
                                self.switchLinkGroup.isOn = true
                                }}
                            
                            
                            self.lblGroupNumber.text = String(format: "%02d", self.arrTeeTimeDetails[0].groupDetails?.count ?? 1)
                            
                            if self.isFrom == "Modify" || self.isFrom == "View" {
                                
                                for _ in 0 ..< (self.arrTeeTimeDetails[0].groupDetails?.count ?? 0) {
                                    self.arrGroupList.append(RequestData())
                                    
                                }
                                
                            }else{
                                
                            }
                            if self.arrTeeTimeDetails[0].golfRequestType == "FCFS Request" {
                                self.enableFirstComeFirstServe(true)
                            } else {
                                self.enableFirstComeFirstServe(false)
                            }
                            if self.arrTeeTimeDetails[0].buttonTextValue == "3" || self.arrTeeTimeDetails[0].buttonTextValue == "4" || self.arrTeeTimeDetails[0].buttonTextValue == "5"{
                                self.heightViewGroups.constant = 0
                                self.lblLegendInfo.text = "\(self.appDelegate.masterLabeling.legendInfoTitle ?? "") \(self.appDelegate.masterLabeling.legendInfoTransValue ?? "")"
                            } else {
                                self.lblLegendInfo.text = "\(self.appDelegate.masterLabeling.legendInfoTitle ?? "")      \(self.appDelegate.masterLabeling.legendInfoValue ?? "")"
                            }
                          
                            
                        }
                        
                    
                    }
                    
                    if let partySize = response.requestTeeTimeDetails?[0].partySize
                    {
                        self.partySize = partySize
                    }
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((response.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: response.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.modifyTableview.setEmptyMessage(response.responseMessage ?? "")
                    
                }
                self.modifyTableview.reloadData()
                self.courceCollectionView.reloadData()
                self.groupsTableview.reloadData()
                
                self.appDelegate.hideIndicator()
                
                self.disableActions()
                
                //Added by kiran v2.9 -- Cobalt Pha0010644 -- Updated the settings with selected date for modify scenario
                //Cobalt Pha0010644 -- Start
                self.updateSettings(success: {
                    
                    //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
                    //PROD0000202 -- Start
                    self.tblViewfirstComeFirstServce.reloadData()
                    self.view.layoutIfNeeded()
                    //PROD0000202 -- End
                })
                //Cobalt Pha0010644 -- End
                
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
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//    if textField == txtPreferredTeeTime {
//
//    txtPreferredTeeTime.text = self.golfSettings?.memberFromTime
//
//    }
//    if textField == txtEarliestTeeTime {
//
//        txtEarliestTeeTime.text = self.golfSettings?.memberFromTime
//
//    }
//
//    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//        if textField == txtEarliestTeeTime {
//            let dateDiff = self.findDateDiff(time1Str: self.txtPreferredTeeTime.text ?? "", time2Str: txtEarliestTeeTime.text ?? "")
//            if dateDiff.first == "+"{
//                txtEarliestTeeTime.text = txtPreferredTeeTime.text
//            }
//        }
//    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtPreferredTeeTime {
            let dateDiff = self.findDateDiff(time1Str: self.txtPreferredTeeTime.text ?? "", time2Str: txtEarliestTeeTime.text ?? "")
            if dateDiff.first == "+"{
                txtEarliestTeeTime.text = txtPreferredTeeTime.text
            }

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "HH:mm"
            
            let dateFormatterEarlier = DateFormatter()
            dateFormatterEarlier.dateFormat = "hh:mm a"
            
            let dateEarlier = dateFormatterEarlier.date(from: self.txtEarliestTeeTime.text!)
            dateFormatterEarlier.dateFormat = "HH:mm"
            
            let DateEarlier = dateFormatter.string(from: dateEarlier!)
            
            let date2 = dateFormatter.date(from: DateEarlier)
            self.datePicker2.setDate(date2!, animated: true)
            self.datePicker2.addTarget(self, action: #selector(self.didEarliestDateChanged(datePicker:)), for: .valueChanged)
            self.txtEarliestTeeTime.inputView = self.datePicker2
            
            //Added by kiran v2.9 -- Cobalt Pha0010644 -- Function to show Hard & Soft message details of courses when date is changed
            //Cobalt Pha0010644 -- Start
            if self.arrPreferredCource.count > 0
            {
                self.showCourseAlert(preferredCourse: self.arrPreferredCource.last ?? "") { [unowned self] alertType in
                    
                    switch alertType
                    {
                    case .hard:
                        self.clearSelectedCoursePreference()
                    case .soft:
                        break
                    case .none:
                        break
                    }
                    
                } noAction: { [unowned self] alertType in
                    
                    switch alertType
                    {
                    case .hard:
                        break
                    case .soft:
                        self.clearSelectedCoursePreference()
                    case .none:
                        break
                    }
                }

            }
            //Cobalt Pha0010644 -- End
        }
       
    }
    func findDateDiff(time1Str: String, time2Str: String) -> String {
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "hh:mm a"
        
        guard let time1 = timeformatter.date(from: time1Str),
            let time2 = timeformatter.date(from: time2Str) else { return "" }
        
        //You can directly use from here if you have two dates
        
        let interval = time2.timeIntervalSince(time1)
        let hour = interval / 3600;
        let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
        let intervalInt = Int(interval)
        return "\(intervalInt < 0 ? "-" : "+") \(Int(hour)) Hours \(Int(minute)) Minutes"
    }
    
    // Added by Zeeshan
//    func get timeSlots(fromTime: String, toTime: String, hoursInterval: Int, minutesInterval: Int) -> [String] {
//
//        return [""]
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if tableView == addNewPopoverTableView || tableView == self.instructionsTableView
        {
            return 1
        }
        //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
        //PROD0000202 -- Start
        else if tableView == self.tblViewfirstComeFirstServce
        {
            return 1
        }
        //PROD0000202 -- End
        else
        {
            return arrGroupList.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == addNewPopoverTableView
        {
            //Modified by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
            //GATHER0000606 -- Start
            return self.isMultiSelectionClicked ? self.appDelegate.addRequestOpt_Golf_MultiSelect.count  : self.appDelegate.addRequestOpt_Golf.count
            //return self.isMultiSelectionClicked ? self.appDelegate.arrRegisterMultiMemberType.count  : self.appDelegate.arrEventRegType.count
            //GATHER0000606 -- End
        }
        else if(tableView == modifyTableview)
        {
            if section == 0 {
                return arrGroup1.count
            }else if section == 1 {
                return arrGroup2.count
            }else if section == 2 {
                return arrGroup3.count
            }else{
                return arrGroup4.count
            }
        }
        else if tableView == self.instructionsTableView
        {
            return self.arrInstructions.count
        }
        //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
        //PROD0000202 -- Start
        else if tableView == self.tblViewfirstComeFirstServce
        {
            if isFrom == "Modify" || isFrom == "View"{
                if self.arrTeeTimeDetails.count > 0 {
                    if self.arrTeeTimeDetails[0].buttonTextValue == "1" || self.arrTeeTimeDetails[0].buttonTextValue == "2" {
                        return self.arrTeeTimeDetails[0].courseDetails?.count ?? 0
                    } else {
                        return 0
                    }
                } else {
                    return 0
                }
            } else {
               return self.golfSettings?.courseDetails?.count ?? 0
            }
        }
        else if tableView == self.transPopupTableView
        {
            return self.transOptions.count
        }
        //PROD0000202 -- End
        else
        {
            if section == 0 {
                return self.arrGroupMaxList1.count
            }else if section == 1 {
                return self.arrGroupMaxList2.count
            }else if section == 2 {
                return self.arrGroupMaxList3.count
            }else{
                return self.arrGroupMaxList4.count
            }
            
        
        }
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if tableView == addNewPopoverTableView {
            
            let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 142, height: 34))
            cell.selectionStyle = .none
            
            //Modified by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
            //GATHER0000606 -- Start
            //cell.textLabel?.text = self.isMultiSelectionClicked ? self.appDelegate.arrRegisterMultiMemberType[indexPath.row].name : self.appDelegate.arrEventRegType[indexPath.row].name
            cell.textLabel?.text = self.isMultiSelectionClicked ? self.appDelegate.addRequestOpt_Golf_MultiSelect[indexPath.row].name : self.appDelegate.addRequestOpt_Golf[indexPath.row].name
            cell.textLabel?.font =  SFont.SourceSansPro_Semibold18
            cell.textLabel?.textColor = hexStringToUIColor(hex: "64575A")
            tableView.separatorStyle = .none
            
            //if indexPath.row < (self.isMultiSelectionClicked ? self.appDelegate.arrRegisterMultiMemberType.count : self.appDelegate.arrEventRegType.count) - 1
            if indexPath.row < (self.isMultiSelectionClicked ? self.appDelegate.addRequestOpt_Golf_MultiSelect.count : self.appDelegate.addRequestOpt_Golf.count) - 1
            //GATHER0000606 -- End
            {
                let shapeLayer:CAShapeLayer = CAShapeLayer()
                let frameSize = cell.frame.size
                let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: 0)
                
                shapeLayer.bounds = shapeRect
                
                shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height)
                shapeLayer.fillColor = hexStringToUIColor(hex: "AFAFAF").cgColor
                shapeLayer.strokeColor = UIColor.darkGray.cgColor
                shapeLayer.lineDashPhase = 3.0 // Add "lineDashPhase" property to CAShapeLayer
                shapeLayer.lineJoin = kCALineJoinRound
                shapeLayer.lineDashPattern = [1,4]
                
                shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 15, y: shapeRect.height + 4, width: 140, height: 0), cornerRadius: 0).cgPath
                
                cell.layer.addSublayer(shapeLayer)
            }
            
            return cell
        }
        else if (tableView == modifyTableview){
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyCell", for: indexPath) as? ModifyRegCustomCell {
                cell.delegate = self
                if(isFrom == "Modify" || isFrom == "View"){
                if(indexPath.section == 0){
                    if arrGroup1[indexPath.row] is Detail {
                        let playObj = arrGroup1[indexPath.row] as! Detail
                      
                        if playObj.name == "" {
                            cell.lblname.text = playObj.guestName
                            //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                            //ENGAGE0011843 -- Start
                            cell.lblID.text = CustomFunctions.shared.guestTypeDisplayName(id: playObj.guestType)
                            //cell.lblID.text = playObj.guestType
                            //ENGAGE0011843 -- End
                            
                            
                        }else{
                            cell.lblname.text = playObj.name
                            cell.lblID.text = playObj.memberId
                            
                        }
                        
                        if playObj.memberRequestHoles == "9 Holes" {
                            cell.btnNineHoles.isSelected = true
                        } else {
                            cell.btnNineHoles.isSelected = false
                        }
                        if playObj.memberTransType == TransportType.mct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[1]
                        } else if playObj.memberTransType == TransportType.ct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[2]
                        } else {
                            cell.textFieldTrans.text = self.transOptions[0]
                        }

                    }else if arrGroup1[indexPath.row] is MemberInfo {
                        let memberObj = arrGroup1[indexPath.row] as! MemberInfo
                        cell.lblname.text = String(format: "%@", memberObj.memberName!)
                        cell.lblID.text = memberObj.memberID
                    }
                    else if arrGroup1[indexPath.row] is GuestInfo {
                        let guestObj = arrGroup1[indexPath.row] as! GuestInfo
                        cell.lblname.text = guestObj.guestName
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        let memberType = CustomFunctions.shared.memberType(details: guestObj, For: .golf)
                        
                        if memberType == .existingGuest
                        {
                            cell.lblID.text = guestObj.guestMemberNo
                        }
                        else
                        {
                            //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                            //ENGAGE0011843 -- Start
                            cell.lblID.text = CustomFunctions.shared.guestTypeDisplayName(id: guestObj.guestType)
                            //cell.lblID.text = guestObj.guestType
                            //ENGAGE0011843 -- End
                        }
                       
                        //ENGAGE0011784 -- End
                    } else {
                        cell.lblname.text = ""
                        cell.lblID.text = ""

                    }

                }else if(indexPath.section == 1){
                    if arrGroup2[indexPath.row] is Detail {
                        let playObj = arrGroup2[indexPath.row] as! Detail
                        if playObj.name == "" {
                            cell.lblname.text = playObj.guestName
                            //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                            //ENGAGE0011843 -- Start
                            cell.lblID.text = CustomFunctions.shared.guestTypeDisplayName(id: playObj.guestType)
                            //cell.lblID.text = playObj.guestType
                            //ENGAGE0011843 -- End
                            
                            
                        }else{
                            cell.lblname.text = playObj.name
                            cell.lblID.text = playObj.memberId
                            
                        }
                        if playObj.memberRequestHoles == "9 Holes" {
                            cell.btnNineHoles.isSelected = true
                        } else {
                            cell.btnNineHoles.isSelected = false
                        }
                        if playObj.memberTransType == TransportType.mct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[1]
                        } else if playObj.memberTransType == TransportType.ct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[2]
                        } else {
                            cell.textFieldTrans.text = self.transOptions[0]
                        }
                    }else if arrGroup2[indexPath.row] is MemberInfo {
                        let memberObj = arrGroup2[indexPath.row] as! MemberInfo
                        cell.lblname.text = String(format: "%@", memberObj.memberName!)
                        cell.lblID.text = memberObj.memberID
                    }
                    else if arrGroup2[indexPath.row] is GuestInfo {
                        let guestObj = arrGroup2[indexPath.row] as! GuestInfo
                        cell.lblname.text = guestObj.guestName
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        let memberType = CustomFunctions.shared.memberType(details: guestObj, For: .golf)
                        
                        if memberType == .existingGuest
                        {
                            cell.lblID.text = guestObj.guestMemberNo
                        }
                        else
                        {
                            //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                            //ENGAGE0011843 -- Start
                            cell.lblID.text = CustomFunctions.shared.guestTypeDisplayName(id: guestObj.guestType)
                            //cell.lblID.text = guestObj.guestType
                            //ENGAGE0011843 -- End
                        }
                        //ENGAGE0011784 -- End
                    } else {
                        cell.lblname.text = ""
                        cell.lblID.text = ""

                    }

                }else if(indexPath.section == 2){
                    if arrGroup3[indexPath.row] is Detail {
                        let playObj = arrGroup3[indexPath.row] as! Detail
                        if playObj.name == "" {
                            cell.lblname.text = playObj.guestName
                            //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                            //ENGAGE0011843 -- Start
                            cell.lblID.text = CustomFunctions.shared.guestTypeDisplayName(id: playObj.guestType)
                            //cell.lblID.text = playObj.guestType
                            //ENGAGE0011843 -- End
                            
                            
                        }else{
                            cell.lblname.text = playObj.name
                            cell.lblID.text = playObj.memberId
                            
                        }
                        if playObj.memberRequestHoles == "9 Holes" {
                            cell.btnNineHoles.isSelected = true
                        } else {
                            cell.btnNineHoles.isSelected = false
                        }
                        if playObj.memberTransType == TransportType.mct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[1]
                        } else if playObj.memberTransType == TransportType.ct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[2]
                        } else {
                            cell.textFieldTrans.text = self.transOptions[0]
                        }

                    }else if arrGroup3[indexPath.row] is MemberInfo {
                        let memberObj = arrGroup3[indexPath.row] as! MemberInfo
                        cell.lblname.text = String(format: "%@", memberObj.memberName!)
                        cell.lblID.text = memberObj.memberID
                    }
                    else if arrGroup3[indexPath.row] is GuestInfo {
                        let guestObj = arrGroup3[indexPath.row] as! GuestInfo
                        cell.lblname.text = guestObj.guestName
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        let memberType = CustomFunctions.shared.memberType(details: guestObj, For: .golf)
                        
                        if memberType == .existingGuest
                        {
                            cell.lblID.text = guestObj.guestMemberNo
                        }
                        else
                        {
                            //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                            //ENGAGE0011843 -- Start
                            cell.lblID.text = CustomFunctions.shared.guestTypeDisplayName(id: guestObj.guestType)
                            //cell.lblID.text = guestObj.guestType
                            //ENGAGE0011843 -- End
                        }
                       
                        //ENGAGE0011784 -- End
                    } else {
                        cell.lblname.text = ""
                        cell.lblID.text = ""

                    }

                }else if(indexPath.section == 3){
                    if arrGroup4[indexPath.row] is Detail {
                        let playObj = arrGroup4[indexPath.row] as! Detail
                        if playObj.name == "" {
                            cell.lblname.text = playObj.guestName
                            //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                            //ENGAGE0011843 -- Start
                            cell.lblID.text = CustomFunctions.shared.guestTypeDisplayName(id: playObj.guestType)
                            //cell.lblID.text = playObj.guestType
                            //ENGAGE0011843 -- End
                            
                            
                        }else{
                            cell.lblname.text = playObj.name
                            cell.lblID.text = playObj.memberId
                            
                        }
                        if playObj.memberRequestHoles == "9 Holes" {
                            cell.btnNineHoles.isSelected = true
                        } else {
                            cell.btnNineHoles.isSelected = false
                        }
                        
                        if playObj.memberTransType == TransportType.mct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[1]
                        } else if playObj.memberTransType == TransportType.ct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[2]
                        } else {
                            cell.textFieldTrans.text = self.transOptions[0]
                        }

                    }else if arrGroup4[indexPath.row] is MemberInfo {
                        let memberObj = arrGroup4[indexPath.row] as! MemberInfo
                        cell.lblname.text = String(format: "%@", memberObj.memberName!)
                        cell.lblID.text = memberObj.memberID
                    }
                    else if arrGroup4[indexPath.row] is GuestInfo {
                        let guestObj = arrGroup4[indexPath.row] as! GuestInfo
                        cell.lblname.text = guestObj.guestName
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        let memberType = CustomFunctions.shared.memberType(details: guestObj, For: .golf)
                        
                        if memberType == .existingGuest
                        {
                            cell.lblID.text = guestObj.guestMemberNo
                        }
                        else
                        {
                            //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                            //ENGAGE0011843 -- Start
                            cell.lblID.text = CustomFunctions.shared.guestTypeDisplayName(id: guestObj.guestType)
                            //cell.lblID.text = guestObj.guestType
                            //ENGAGE0011843 -- End
                        }
                       
                        //ENGAGE0011784 -- End
                    } else {
                        cell.lblname.text = ""
                        cell.lblID.text = ""

                    }

                }
                else{

                }
                    
                }else{
                }
                if self.lblGroupNumber.text == "01"{
                    cell.btnThreeDots.isHidden = true
                }
                else{
                    cell.btnThreeDots.isHidden = false
                }
                if self.isFrom == "View" {
                    cell.btnThreeDots.isEnabled = false
                    cell.btnClose.isEnabled = false
                    self.btnRequest.isHidden = true
                    self.btnCancelRequest.isHidden = true
                    self.heightCancelRequest.constant = -20
                    self.heightRules.constant = -20
                    
                }
               
                //Added by kiran V2.5 -- GATHER0000606 -- Hiding clear button if options array is empty
                //GATHER0000606 -- Start
                let hideMemberOptions = self.shouldHideMemberAddOptions()
                cell.btnClose.isHidden = hideMemberOptions
                //GATHER0000606 -- End
                
                if self.isFrom == "View" || self.isFrom == "Modify" {
                    if self.isFirstComeFirstServe {
                        cell.viewTransDetailsWidth.constant = 110.0
                    } else {
                        cell.viewTransDetailsWidth.constant = 0.0
                    }
                }
                
                
                
            self.view.setNeedsLayout()
            return cell
            }
            return UITableViewCell()
            
            
        }
        else if tableView == self.instructionsTableView
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionsTableViewCell", for: indexPath) as? InstructionsTableViewCell
            {
                let instruction = self.arrInstructions[indexPath.row]
                if let imageLink = instruction.image , let url = URL.init(string: imageLink)
                {
                    cell.imageViewInstruction.isHidden = false
                    DispatchQueue.global(qos: .userInteractive).async {
                        guard let data = try? Data.init(contentsOf: url) else{
                            return
                        }
                        DispatchQueue.main.async {
                            cell.imageViewInstruction.image = UIImage.init(data: data)
                            
                        }
                    }
                }
                else
                {
                    cell.imageViewInstruction.isHidden = true
                }
                
                
                cell.lblInstruction.text = instruction.instruction
                cell.lblInstruction.sizeToFit()
                
                return cell
            }
            
            
            return UITableViewCell.init()
        }
        //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
        //PROD0000202 -- Start
        else if tableView == self.tblViewfirstComeFirstServce
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstComeFirstServeTableViewCell") as! FirstComeFirstServeTableViewCell
            
            let course = self.golfSettings?.courseDetails?[indexPath.row]
            
            cell.lblCourseName.text = course?.courseName ?? ""
            let placeHolderImage = UIImage(named: "Group 2124")
            imageURLString = course?.courseImage1
            
            if (self.imageURLString ?? "").isValidURL()
            {
                let url = URL.init(string:imageURLString ?? "")
                cell.imageViewCourse.sd_setImage(with: url , placeholderImage: placeHolderImage)
            }
            
            if let coursesDetails = self.courseDetailsResponse.courseDetails {
                cell.timeSlotsDetails = coursesDetails[indexPath.row]
                cell.scheduleType = coursesDetails[indexPath.row].scheduleType ?? "FCFS"
            }
            cell.arrAvailableTimes = ["10:00 AM","10:30 AM","11:00 AM", "11:30 AM", "12:00 PM", "12:30 PM", "01:00 PM","01:30 PM"]
            cell.selectionStyle = .none
            cell.btnCourseSelected.isHidden = true
            cell.imgCheckBox.isHidden = true
            cell.selectedSlots = self.selectedSlotsList
            
            cell.delegate = self
            cell.collectionViewCourseTimes.reloadData()
            return cell
        }
        else if tableView == self.transPopupTableView
        {
            
            let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 142, height: 34))
            cell.selectionStyle = .none
            cell.textLabel?.text = self.transOptions[indexPath.row]
            cell.textLabel?.font =  SFont.SourceSansPro_Semibold18
            cell.textLabel?.textColor = hexStringToUIColor(hex: "64575A")
            tableView.separatorStyle = .none
            
            if indexPath.row < (self.transOptions.count - 1)
            {
                let shapeLayer:CAShapeLayer = CAShapeLayer()
                let frameSize = cell.frame.size
                let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: 0)
                
                shapeLayer.bounds = shapeRect
                
                shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height)
                shapeLayer.fillColor = hexStringToUIColor(hex: "AFAFAF").cgColor
                shapeLayer.strokeColor = UIColor.darkGray.cgColor
                shapeLayer.lineDashPhase = 3.0 // Add "lineDashPhase" property to CAShapeLayer
                shapeLayer.lineJoin = kCALineJoinRound
                shapeLayer.lineDashPattern = [1,4]
                
                shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 15, y: shapeRect.height + 4, width: 140, height: 0), cornerRadius: 0).cgPath
                
                cell.layer.addSublayer(shapeLayer)
            }
            
            return cell
        }
        //PROD0000202 -- End
        else
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "RegCell", for: indexPath) as? CustomNewRegCell {
                
                cell.delegate = self
                cell.viewSearchField.layer.cornerRadius = 6
                cell.viewSearchField.layer.borderWidth = 0.25
                cell.viewSearchField.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
                // Added by Zeeshan
                if self.isFirstComeFirstServe {
                    cell.viewTransWidth.constant = 110.0
                    cell.textFieldTrans.isHidden = false
                } else {
                    cell.viewTransWidth.constant = 0.0
                    cell.textFieldTrans.isHidden = true
                }
                
                if(isFrom == "Modify" || isFrom == "View"){
                    
                }else{
                    
                if(indexPath.section == 0){
                        if arrGroup1[indexPath.row] is CaptaineInfo {
                            let memberObj = arrGroup1[indexPath.row] as! CaptaineInfo
                            cell.txtSearchField.text = String(format: "%@", memberObj.captainName!)
                            cell.btnThreeDots.isEnabled = true
                            if memberObj.memberRequestHoles == "9 Holes" {
                                cell.btnNineHoles.isSelected = true
                            } else {
                                cell.btnNineHoles.isSelected = false
                            }
                            
                            if memberObj.memberTransType == TransportType.mct.rawValue {
                                cell.textFieldTrans.text = self.transOptions[1]
                            } else if memberObj.memberTransType == TransportType.ct.rawValue {
                                cell.textFieldTrans.text = self.transOptions[2]
                            } else {
                                cell.textFieldTrans.text = self.transOptions[0]
                            }
                        }

                   else if arrGroup1[indexPath.row] is MemberInfo {
                        let memberObj = arrGroup1[indexPath.row] as! MemberInfo
                        cell.txtSearchField.text = String(format: "%@", memberObj.memberName!)
                            cell.btnThreeDots.isEnabled = true
                       if memberObj.memberRequestHoles == "9 Holes" {
                           cell.btnNineHoles.isSelected = true
                       } else {
                           cell.btnNineHoles.isSelected = false
                       }
                       
                       if memberObj.memberTransType == TransportType.mct.rawValue {
                           cell.textFieldTrans.text = self.transOptions[1]
                       } else if memberObj.memberTransType == TransportType.ct.rawValue {
                           cell.textFieldTrans.text = self.transOptions[2]
                       } else {
                           cell.textFieldTrans.text = self.transOptions[0]
                       }
                    }
                    else if arrGroup1[indexPath.row] is GuestInfo {
                        let guestObj = arrGroup1[indexPath.row] as! GuestInfo
                        cell.txtSearchField.text = guestObj.guestName
                            cell.btnThreeDots.isEnabled = true
                        if guestObj.memberRequestHoles == "9 Holes" {
                            cell.btnNineHoles.isSelected = true
                        } else {
                            cell.btnNineHoles.isSelected = false
                        }
                        
                        if guestObj.memberTransType == TransportType.mct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[1]
                        } else if guestObj.memberTransType == TransportType.ct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[2]
                        } else {
                            cell.textFieldTrans.text = self.transOptions[0]
                        }
                    } else {
                        cell.txtSearchField.text = ""
                        cell.btnThreeDots.isEnabled = false
                        cell.textFieldTrans.text = ""
                        cell.btnNineHoles.isSelected = false
                    }

                }else if(indexPath.section == 1){
                    if arrGroup2[indexPath.row] is CaptaineInfo {
                        let memberObj = arrGroup2[indexPath.row] as! CaptaineInfo
                        cell.txtSearchField.text = String(format: "%@", memberObj.captainName!)
                        cell.btnThreeDots.isEnabled = true
                        if memberObj.memberRequestHoles == "9 Holes" {
                            cell.btnNineHoles.isSelected = true
                        } else {
                            cell.btnNineHoles.isSelected = false
                        }
                        
                        if memberObj.memberTransType == TransportType.mct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[1]
                        } else if memberObj.memberTransType == TransportType.ct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[2]
                        } else {
                            cell.textFieldTrans.text = self.transOptions[0]
                        }
                    }
                        
                    else if arrGroup2[indexPath.row] is MemberInfo {
                        let memberObj = arrGroup2[indexPath.row] as! MemberInfo
                        cell.txtSearchField.text = String(format: "%@", memberObj.memberName!)
                        cell.btnThreeDots.isEnabled = true
                        if memberObj.memberRequestHoles == "9 Holes" {
                            cell.btnNineHoles.isSelected = true
                        } else {
                            cell.btnNineHoles.isSelected = false
                        }
                        
                        if memberObj.memberTransType == TransportType.mct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[1]
                        } else if memberObj.memberTransType == TransportType.ct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[2]
                        } else {
                            cell.textFieldTrans.text = self.transOptions[0]
                        }
                    }
                    else if arrGroup2[indexPath.row] is GuestInfo {
                        let guestObj = arrGroup2[indexPath.row] as! GuestInfo
                        cell.txtSearchField.text = guestObj.guestName
                        cell.btnThreeDots.isEnabled = true
                        if guestObj.memberRequestHoles == "9 Holes" {
                            cell.btnNineHoles.isSelected = true
                        } else {
                            cell.btnNineHoles.isSelected = false
                        }
                        
                        if guestObj.memberTransType == TransportType.mct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[1]
                        } else if guestObj.memberTransType == TransportType.ct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[2]
                        } else {
                            cell.textFieldTrans.text = self.transOptions[0]
                        }
                    } else {
                        cell.txtSearchField.text = ""
                        cell.btnThreeDots.isEnabled = false
                        cell.textFieldTrans.text = ""
                        cell.btnNineHoles.isSelected = false
                    }


                }else if(indexPath.section == 2){
                    if arrGroup3[indexPath.row] is CaptaineInfo {
                        let memberObj = arrGroup3[indexPath.row] as! CaptaineInfo
                        cell.txtSearchField.text = String(format: "%@", memberObj.captainName!)
                        cell.btnThreeDots.isEnabled = true
                        if memberObj.memberRequestHoles == "9 Holes" {
                            cell.btnNineHoles.isSelected = true
                        } else {
                            cell.btnNineHoles.isSelected = false
                        }
                        
                        if memberObj.memberTransType == TransportType.mct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[1]
                        } else if memberObj.memberTransType == TransportType.ct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[2]
                        } else {
                            cell.textFieldTrans.text = self.transOptions[0]
                        }
                    }
                        
                    else if arrGroup3[indexPath.row] is MemberInfo {
                        let memberObj = arrGroup3[indexPath.row] as! MemberInfo
                        cell.txtSearchField.text = String(format: "%@", memberObj.memberName!)
                        cell.btnThreeDots.isEnabled = true
                        if memberObj.memberRequestHoles == "9 Holes" {
                            cell.btnNineHoles.isSelected = true
                        } else {
                            cell.btnNineHoles.isSelected = false
                        }
                        
                        if memberObj.memberTransType == TransportType.mct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[1]
                        } else if memberObj.memberTransType == TransportType.ct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[2]
                        } else {
                            cell.textFieldTrans.text = self.transOptions[0]
                        }
                    }
                    else if arrGroup3[indexPath.row] is GuestInfo {
                        let guestObj = arrGroup3[indexPath.row] as! GuestInfo
                        cell.txtSearchField.text = guestObj.guestName
                        cell.btnThreeDots.isEnabled = true
                        if guestObj.memberRequestHoles == "9 Holes" {
                            cell.btnNineHoles.isSelected = true
                        } else {
                            cell.btnNineHoles.isSelected = false
                        }
                        
                        if guestObj.memberTransType == TransportType.mct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[1]
                        } else if guestObj.memberTransType == TransportType.ct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[2]
                        } else {
                            cell.textFieldTrans.text = self.transOptions[0]
                        }
                    } else {
                        cell.txtSearchField.text = ""
                        cell.btnThreeDots.isEnabled = false
                        cell.textFieldTrans.text = ""
                        cell.btnNineHoles.isSelected = false
                    }

                }else if(indexPath.section == 3){
                    if arrGroup4[indexPath.row] is CaptaineInfo {
                        let memberObj = arrGroup4[indexPath.row] as! CaptaineInfo
                        cell.txtSearchField.text = String(format: "%@", memberObj.captainName!)
                        cell.btnThreeDots.isEnabled = true
                        if memberObj.memberRequestHoles == "9 Holes" {
                            cell.btnNineHoles.isSelected = true
                        } else {
                            cell.btnNineHoles.isSelected = false
                        }
                        
                        if memberObj.memberTransType == TransportType.mct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[1]
                        } else if memberObj.memberTransType == TransportType.ct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[2]
                        } else {
                            cell.textFieldTrans.text = self.transOptions[0]
                        }
                    }
                        
                    else if arrGroup4[indexPath.row] is MemberInfo {
                        let memberObj = arrGroup4[indexPath.row] as! MemberInfo
                        cell.txtSearchField.text = String(format: "%@", memberObj.memberName!)
                        cell.btnThreeDots.isEnabled = true
                        if memberObj.memberRequestHoles == "9 Holes" {
                            cell.btnNineHoles.isSelected = true
                        } else {
                            cell.btnNineHoles.isSelected = false
                        }
                        
                        if memberObj.memberTransType == TransportType.mct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[1]
                        } else if memberObj.memberTransType == TransportType.ct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[2]
                        } else {
                            cell.textFieldTrans.text = self.transOptions[0]
                        }
                    }
                    else if arrGroup4[indexPath.row] is GuestInfo {
                        let guestObj = arrGroup4[indexPath.row] as! GuestInfo
                        cell.txtSearchField.text = guestObj.guestName
                        cell.btnThreeDots.isEnabled = true
                        if guestObj.memberRequestHoles == "9 Holes" {
                            cell.btnNineHoles.isSelected = true
                        } else {
                            cell.btnNineHoles.isSelected = false
                        }
                        
                        if guestObj.memberTransType == TransportType.mct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[1]
                        } else if guestObj.memberTransType == TransportType.ct.rawValue {
                            cell.textFieldTrans.text = self.transOptions[2]
                        } else {
                            cell.textFieldTrans.text = self.transOptions[0]
                        }
                    } else {
                        cell.txtSearchField.text = ""
                        cell.btnThreeDots.isEnabled = false
                        cell.textFieldTrans.text = ""
                        cell.btnNineHoles.isSelected = false
                    }


                }
                else{
                    
                }
                    
                    //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
                    //PROD0000202 -- Start
//                    cell.btnNineHoles.isSelected = false
//                    // Modified by Zeeshan
//                    cell.textFieldTrans.text = self.transOptions[0]
                    //PROD0000202 -- End
                }
                if self.lblGroupNumber.text == "01"{
                    cell.btnThreeDots.isHidden = true
                }
                else{
                    cell.btnThreeDots.isHidden = false
                }
                cell.txtSearchField.placeholder = String(format: "%@ %d", self.appDelegate.masterLabeling.player ?? "", indexPath.row + 1)

                
                //Added by kiran V2.5 -- GATHER0000606 -- Hiding add button and clear button if options array is empty
                //GATHER0000606 -- Start
                let hideMemberOptions = self.shouldHideMemberAddOptions()
                cell.btnAdd.isHidden = hideMemberOptions
                cell.viewClearBtn.isHidden = hideMemberOptions
                //GATHER0000606 -- End
                
                self.view.setNeedsLayout()
                return cell
            }

            return UITableViewCell()

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addNewPopover?.dismiss()
        if tableView == addNewPopoverTableView
        {
            
            let cell = self.addNewPopoverTableView?.cellForRow(at: indexPath)
            //Modified by kiran V2.5 -- GATHER0000606 -- replacing comparision with case insensetive compare with the value(id)
            //GATHER0000606 -- Start
            let selectedOption = self.isMultiSelectionClicked ? (self.appDelegate.addRequestOpt_Golf_MultiSelect[indexPath.row].Id ?? "")  : (self.appDelegate.addRequestOpt_Golf[indexPath.row].Id ?? "")
            //GATHER0000606 -- End
            
            //Modified by kiran V2.5 -- GATHER0000606 -- replacing comparision with case insensetive compare with the value(id)
            //GATHER0000606 -- Start
            //if /*indexPath.row == 0*/ cell?.textLabel?.text ?? "" == "Member"
            if selectedOption.caseInsensitiveCompare(AddRequestIDS.member.rawValue) == .orderedSame
            //GATHER0000606 -- End
            {
                
                //Added on 20th July 2020 V2.2
                //Added for roles and privilages
                switch self.accessManager.accessPermision(for: .memberDirectory)
                {
                case .notAllowed:
                    
                    if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
                    {
                        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                    }
                    return
                default:
                    break
                }
                
                if let memberDirectory = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MemberDirectoryViewController") as? MemberDirectoryViewController
                {
                    selectedCellText = cell?.textLabel?.text
                    memberDirectory.isFrom = "Registration"
                    memberDirectory.isOnlyFrom = "GolfCourt"
                    memberDirectory.categoryForBuddy = "Golf"
                    memberDirectory.isFor = "OnlyMembers"
                    memberDirectory.showSegmentController = true
                    memberDirectory.requestID = requestID
                    memberDirectory.selectedDate = self.reservationRequestDate
                    memberDirectory.selectedTime = self.txtPreferredTeeTime.text
                    
                    if self.isMultiSelectionClicked
                    {
                        memberDirectory.shouldEnableMultiSelect = true
                        memberDirectory.shouldEnableSkipping = true
                        
                        memberDirectory.arrMultiSelectedMembers.append(self.arrGroup1)
                        
                        if self.arrGroup2.count > 0
                        {
                            memberDirectory.arrMultiSelectedMembers.append(self.arrGroup2)
                        }
                        
                        if self.arrGroup3.count > 0
                        {
                            memberDirectory.arrMultiSelectedMembers.append(self.arrGroup3)
                        }
                        
                        if self.arrGroup4.count > 0
                        {
                            memberDirectory.arrMultiSelectedMembers.append(self.arrGroup4)
                        }
                        
                    }
                    else
                    {
                        memberDirectory.arrGroup1 = self.arrGroup1
                        memberDirectory.arrGroup2 = self.arrGroup2
                        memberDirectory.arrGroup3 = self.arrGroup3
                        memberDirectory.arrGroup4 = self.arrGroup4
                    }
                    
                    
                    // Previous logic for multi selection without master selection
                    /*
                    if(isFrom == "Modify" || isFrom == "View")
                    {
                        
                    }
                    else
                    {
                        //What to do when add is clicked on a row when Max members are already selected
                        memberDirectory.shouldEnableMultiSelect = true
                        
                        //Max number of tickets calculated by multiplying the number of groups with max group size
                        self.maxTickets = (Int(self.lblGroupNumber.text ?? "0") ?? 0) * (self.golfSettings?.maxGroupReserv ?? 0)
                                
                        //Removing the number of players already added to the groups from maxTickets for available tickets
                        self.availableTickets =  self.maxTickets - (self.arrGroup1.filter({$0.isEmpty == false}).count + self.arrGroup2.filter({$0.isEmpty == false}).count + self.arrGroup3.filter({$0.isEmpty == false}).count + self.arrGroup4.filter({$0.isEmpty == false}).count)
                                           
                        memberDirectory.totalNumberofTickets = self.availableTickets
                                            
                        // uncomment to enable the functionality where when max members are selected and then add is click on a row which has a member selected only that member is changed based on selection
                                                            
//                    //Max number of tickets calculated by multiplying the number of groups with max group size
//                    self.maxTickets = (Int(self.lblGroupNumber.text ?? "0") ?? 0) * (self.golfSettings?.maxGroupReserv ?? 0)
//
//
//                    let selectedTickets = (self.arrGroup1.filter({$0.isEmpty == false}).count + self.arrGroup2.filter({$0.isEmpty == false}).count + self.arrGroup3.filter({$0.isEmpty == false}).count + self.arrGroup4.filter({$0.isEmpty == false}).count)
//
//                    self.availableTickets = self.maxTickets - selectedTickets
//                    //What to do when add is clicked on a row where member is already selected
//                    if maxTickets == selectedTickets
//                    {
//
//                    }
//                    else
//                    {
//                        memberDirectory.shouldEnableMultiSelect = true
//                        //Removing the number of players already added to the groups from maxTickets for available tickets
//                        memberDirectory.totalNumberofTickets =  self.availableTickets
//                    }
                    }*/


                    memberDirectory.delegate = self

                    navigationController?.pushViewController(memberDirectory, animated: true)
                }
            }
            //Modified by kiran V2.5 -- GATHER0000606 -- replacing comparision with case insensetive compare with the value(id)
            //GATHER0000606 -- Start
            //else if /*indexPath.row == 1*/ cell?.textLabel?.text ?? "" == "Guest"
            else if selectedOption.caseInsensitiveCompare(AddRequestIDS.guest.rawValue) == .orderedSame
            //GATHER0000606 -- End
            {
               
                    if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddGuestRegVC") as? AddGuestRegVC
                    {
                        regGuest.memberDelegate = self
                        
                        //Added by kiran V2.8 -- ENGAGE0011784 -- showing the existing guest feature and showing guest dob and gender fields
                        //ENGAGE0011784 -- Start
                        //commented as these are replaced with screenType and usedForModule
//                        regGuest.isFrom = "Request"
//                        regGuest.isOnlyFor = "Golf"
                        
                        regGuest.usedForModule = .golf
                        regGuest.screenType = .add
                        regGuest.showExistingGuestsOption = true
                        regGuest.isDOBHidden = false
                        regGuest.isGenderHidden = false
                        regGuest.enableGuestNameSuggestions = false
                        regGuest.hideAddtoBuddy = true
                        regGuest.hideExistingGuestAddToBuddy = true
                        regGuest.requestDates = [self.reservationRequestDate ?? ""]
                        regGuest.requestTime = self.txtPreferredTeeTime.text ?? ""
                        regGuest.requestID = self.requestID ?? ""
                        
                        var arrMembers = [[RequestData]]()
                        
                        arrMembers.append(self.arrGroup1)
                        
                        if self.arrGroup2.count > 0
                        {
                            arrMembers.append(self.arrGroup2)
                        }
                        
                        if self.arrGroup3.count > 0
                        {
                            arrMembers.append(arrGroup3)
                        }
                        
                        if self.arrGroup4.count > 0
                        {
                            arrMembers.append(arrGroup4)
                        }
                        
                        regGuest.arrAddedMembers = arrMembers
                        //ENGAGE0011784 -- End
                        
                        selectedCellText = cell?.textLabel?.text
                        navigationController?.pushViewController(regGuest, animated: true)
                }
            }
            //Modified by kiran V2.5 -- GATHER0000606 -- replacing comparision with case insensetive compare with the value(id)
            //GATHER0000606 -- Start
            //else if cell?.textLabel?.text ?? "" == "My Buddies"
            else if selectedOption.caseInsensitiveCompare(AddRequestIDS.myBuddies.rawValue) == .orderedSame
            //GATHER0000606 -- End
            {
                
                //Added on 20th July 2020 V2.2
                //Added for roles and privilages
                switch self.accessManager.accessPermision(for: .memberDirectory)
                {
                case .notAllowed:
                    
                    if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
                    {
                        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                    }
                    return
                default:
                    break
                }
                
                if let memberDirectory = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MemberDirectoryViewController") as? MemberDirectoryViewController {
                    selectedCellText = cell?.textLabel?.text
                    memberDirectory.isFrom = "BuddyList"
                    memberDirectory.categoryForBuddy = "Golf"
                    memberDirectory.isOnlyFrom = "GolfCourt"
                    memberDirectory.isFor = "OnlyMembers"
                    memberDirectory.showSegmentController = true
                    memberDirectory.requestID = requestID
                    memberDirectory.selectedDate = self.reservationRequestDate
                    memberDirectory.selectedTime = self.txtPreferredTeeTime.text
                   
                    if self.isMultiSelectionClicked
                    {
                        
                        memberDirectory.shouldEnableMultiSelect = true
                        memberDirectory.shouldEnableSkipping = true
                        
                        memberDirectory.arrMultiSelectedMembers.append(self.arrGroup1)
                        
                        if self.arrGroup2.count > 0
                        {
                            memberDirectory.arrMultiSelectedMembers.append(self.arrGroup2)
                        }
                        
                        if self.arrGroup3.count > 0
                        {
                            memberDirectory.arrMultiSelectedMembers.append(self.arrGroup3)
                        }
                        
                        if self.arrGroup4.count > 0
                        {
                            memberDirectory.arrMultiSelectedMembers.append(self.arrGroup4)
                        }
                        
                    }
                    else
                    {
                        memberDirectory.arrGroup1 = self.arrGroup1
                        memberDirectory.arrGroup2 = self.arrGroup2
                        memberDirectory.arrGroup3 = self.arrGroup3
                        memberDirectory.arrGroup4 = self.arrGroup4
                    }
                    
                    //Logic for multi select
                    /*
                    if(isFrom == "Modify" || isFrom == "View")
                    {
                        
                    }
                    else
                    {
                        // What to do when add is clicked on a row where member is already selected
                        memberDirectory.shouldEnableMultiSelect = true
                        
                        //Max number of tickets calculated by multiplying the number of groups with max group size
                        self.maxTickets = (Int(self.lblGroupNumber.text ?? "0") ?? 0) * (self.golfSettings?.maxGroupReserv ?? 0)
                        
                        //Removing the number of players already added to the groups for available tickets
                        self.availableTickets = self.maxTickets - (self.arrGroup1.filter({$0.isEmpty == false}).count + self.arrGroup2.filter({$0.isEmpty == false}).count + self.arrGroup3.filter({$0.isEmpty == false}).count + self.arrGroup4.filter({$0.isEmpty == false}).count)
                        
                        memberDirectory.totalNumberofTickets = self.availableTickets
                    }*/

                    
                    memberDirectory.delegate = self

                    memberDirectory.delegate = self
                    navigationController?.pushViewController(memberDirectory, animated: true)
                }
            }
           self.isMultiSelectionClicked = false
        }
        else if tableView == self.instructionsTableView
        {
            
        }
        //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
        //PROD0000202 -- Start
        else if tableView == self.tblViewfirstComeFirstServce
        {
           
        }
        else if tableView == self.transPopupTableView
        {
            guard let selectedItemRow = self.selectedIndex , let selectedItemSection = self.selectedSection else{
                return
            }
            let selectedIndex = IndexPath.init(row: selectedItemRow, section: selectedItemSection)
            if isFrom == "Modify" {
                let cell = self.modifyTableview.cellForRow(at: selectedIndex) as? ModifyRegCustomCell
                cell?.textFieldTrans.text = self.transOptions[indexPath.row]
            } else {
                let cell = self.groupsTableview.cellForRow(at: selectedIndex) as? CustomNewRegCell
                cell?.textFieldTrans.text = self.transOptions[indexPath.row]
            }
            self.selectedTrans(index: selectedItemRow, section: selectedItemSection, trans: self.transOptions[indexPath.row])
        }
        //PROD0000202 -- End
        else{
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (tableView == modifyTableview){
            let headerView = Bundle.main.loadNibNamed("ModifyRequestHeaderView", owner: self, options: nil)?.first as! ModifyRequestHeaderView
            headerView.lblGroupNumber.isHidden = false
            
            headerView.delegate = self
           
            headerView.btnWaitlist.setTitle(self.appDelegate.masterLabeling.waitlist, for: .normal)
            
            //Waitlist button shown when value is 3
            if section < self.arrTeeTimeDetails[0].groupDetails?.count ?? 0,  self.arrTeeTimeDetails[0].groupDetails?[section].buttonTextValue == "3"
            {
                //headerView.btnWaitlist.isHidden = false
                headerView.viewWaitlist.isHidden = false
            }
            else
            {
                //headerView.btnWaitlist.isHidden = true
                headerView.viewWaitlist.isHidden = true
            }
            
            headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!, UserDefaults.standard.string(forKey: UserDefaultsKeys.captainName.rawValue)!)
            if arrTeeTimeDetails.count == 0{
                
            }else{
                if arrTeeTimeDetails[0].buttonTextValue == "3" || arrTeeTimeDetails[0].buttonTextValue == "4" || self.arrTeeTimeDetails[0].buttonTextValue == "5"{
                    headerView.heightBWGroup.constant = 114
                    headerView.lblCourseValue.text = String(format: "%@ %@", self.appDelegate.masterLabeling.course_time_colon ?? "", self.arrTeeTimeDetails[0].groupDetails?[section].allocatedCourse ?? "")
                    headerView.lblTimeValue.text = String(format: "%@ %@", self.appDelegate.masterLabeling.time_colon ?? "", self.arrTeeTimeDetails[0].groupDetails?[section].allocatedTime ?? "")
                    if let courses = self.arrTeeTimeDetails[0].courseDetails {
                        for i in courses {
                            if i.courseName == self.arrTeeTimeDetails[0].groupDetails?[section].allocatedCourse {
                                if i.playType == "Double Tee" {
                                    headerView.lblTimeValue.text = String(format: "%@ %@ (%@)", self.appDelegate.masterLabeling.time_colon ?? "", self.arrTeeTimeDetails[0].groupDetails?[section].allocatedTime ?? "", self.arrTeeTimeDetails[0].groupDetails?[section].teeBox ?? "")
                                }
                            }
                        }
                    }
                    
                    
                    headerView.lblRoundLength.text = String(format: "%@ %@", "Round Length:", self.arrTeeTimeDetails[0].groupDetails?[section].gameTypeTitle ?? "")
                    headerView.lblStatus.text = self.appDelegate.masterLabeling.status ?? ""
                    headerView.lblStatusValue.layer.cornerRadius = 12
                    headerView.lblStatusValue.layer.masksToBounds = true
                    headerView.btnDelete.isHidden = false
                    
                    if arrGroupList.count == 1 || self.isFrom == "View" {
                        headerView.btnDelete.isHidden = true
                    }else{
                        headerView.btnDelete.isHidden = false
                    }
                    
                    
                    headerView.lblStatusValue.setTitle(self.arrTeeTimeDetails[0].groupDetails?[section].status ?? "", for: UIControlState.normal)
                    headerView.lblStatusValue.backgroundColor = hexStringToUIColor(hex: self.arrTeeTimeDetails[0].groupDetails?[section].color ?? "")
                }else{
                    headerView.heightBWGroup.constant = 8
                    headerView.lblTimeValue.isHidden = true
                    headerView.lblCourseValue.isHidden = true
                    headerView.lblStatus.isHidden = true
                    headerView.lblStatusValue.isHidden = true
                    headerView.btnDelete.isHidden = true
                    headerView.lblRoundLength.isHidden = true

                }
                   
            }
            if(section == 0){
               
                if arrGroup1.count == 0 {
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
                    if self.arrTeeTimeDetails[0].groupDetails?.count == 1{
                        headerView.lblConfirmNumber.text = self.arrTeeTimeDetails[0].groupDetails?[0].confirmationNumber ?? ""
                    }else{
                        headerView.lblConfirmNumber.text = ""
                        
                    }
                }else{
                if arrGroup1[0] is Detail {
                    let memberObj = arrGroup1[section] as! Detail
                    if memberObj.name == ""{
                        headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.guestName!)

                    }else{
                        headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.name!)
                    }
                    headerView.lblConfirmNumber.text = self.arrTeeTimeDetails[0].groupDetails?[section].confirmationNumber ?? ""
                }
                else if arrGroup1[section] is MemberInfo {
                    let memberObj = arrGroup1[section] as! MemberInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!, memberObj.memberName!)
                }
                else if arrGroup1[section] is GuestInfo {
                    let guestObj = arrGroup1[section] as! GuestInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.guestName!)
                    }
                    
                    if arrGroup1.count >= 4 {
                        headerView.btnAddNew.isEnabled = false
                    }else{
                        headerView.btnAddNew.isEnabled = true
                    }
                   
                }
            }
                
            else if(section == 1){
                if arrGroup2.count == 0 {
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
                }else{
                if arrGroup2[0] is Detail {
                    let memberObj = arrGroup2[0] as! Detail
                    if memberObj.name == ""{
                        headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.guestName!)
                        
                    }else{
                        headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.name!)
                    }
                    if (self.arrTeeTimeDetails[0].groupDetails?.count)! >= 2{
                    headerView.lblConfirmNumber.text = self.arrTeeTimeDetails[0].groupDetails?[section].confirmationNumber ?? ""
                    }else{
                        headerView.lblConfirmNumber.text = ""

                    }
                }
                else if arrGroup2[0] is MemberInfo {
                    let memberObj = arrGroup2[0] as! MemberInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!, memberObj.memberName!)
                    
                }
                else if arrGroup2[0] is GuestInfo {
                    let guestObj = arrGroup2[0] as! GuestInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.guestName!)
                    }
                    if arrGroup2.count >= 4 {
                        headerView.btnAddNew.isEnabled = false
                    }else{
                        headerView.btnAddNew.isEnabled = true
                    }
                }
            }
            else if(section == 2){
                if arrGroup3.count == 0 {
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
                }else{
                if arrGroup3[0] is Detail {
                    let memberObj = arrGroup3[0] as! Detail
                    if memberObj.name == ""{
                        headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.guestName!)
                        
                    }else{
                        headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.name!)
                    }
                    if (self.arrTeeTimeDetails[0].groupDetails?.count)! >= 3{
                        headerView.lblConfirmNumber.text = self.arrTeeTimeDetails[0].groupDetails?[section].confirmationNumber ?? ""
                    }else{
                        headerView.lblConfirmNumber.text = ""
                        
                    }
                }
                else if arrGroup3[0] is MemberInfo {
                    let memberObj = arrGroup3[0] as! MemberInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!, memberObj.memberName!)
                    
                }
                else if arrGroup3[0] is GuestInfo {
                    let guestObj = arrGroup3[0] as! GuestInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.guestName!)
                    
                    }
                    if arrGroup3.count >= 4 {
                        headerView.btnAddNew.isEnabled = false
                    }else{
                        headerView.btnAddNew.isEnabled = true
                    }
                }
            }
            else if(section == 3){
                if arrGroup4.count == 0 {
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
                }else{
                if arrGroup4[0] is Detail {
                    let memberObj = arrGroup4[0] as! Detail
                    if memberObj.name == ""{
                        headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.guestName!)
                        
                    }else{
                        headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.name!)
                    }
                    if self.arrTeeTimeDetails[0].groupDetails?.count == 4{
                        headerView.lblConfirmNumber.text = self.arrTeeTimeDetails[0].groupDetails?[section].confirmationNumber ?? ""
                    }else{
                        headerView.lblConfirmNumber.text = ""
                        
                    }
                }
                else if arrGroup4[0] is MemberInfo {
                    let memberObj = arrGroup4[0] as! MemberInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!, memberObj.memberName!)
                    
                }
                else if arrGroup4[0] is GuestInfo {
                    let guestObj = arrGroup4[0] as! GuestInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.guestName!)
                    }
                    if arrGroup4.count >= 4 {
                        headerView.btnAddNew.isEnabled = false
                    }else{
                        headerView.btnAddNew.isEnabled = true
                    }
                }
            }
            else{
                headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
            }
            
            if self.isFrom == "View"{
                headerView.btnAddNew.isEnabled = false
            }
            if arrTeeTimeDetails[0].buttonTextValue == "3" || arrTeeTimeDetails[0].buttonTextValue == "4" || self.arrTeeTimeDetails[0].buttonTextValue == "5"{
            headerView.lblGroupNumber.text = String(format: "%@",self.arrTeeTimeDetails[0].groupDetails?[section].group ?? "")
            }else{
                headerView.lblGroupNumber.text = String(format: "%@ %d",self.appDelegate.masterLabeling.group ?? "",section + 1)

            }
            headerView.txtAddMemberOrGuest.text = self.appDelegate.masterLabeling.add_member_or_guest
            
            headerView.tag = section
            //Modified by kiran V2.5 -- GATHER0000606 -- Hiding add button when member selection option is empty
            //GATHER0000606 -- Start
            headerView.btnAddNew.isHidden = self.shouldHideMemberAddOptions()
            //GATHER0000606 -- End
            
            headerView.lblGroupNumber.textColor = APPColor.textColor.secondary
            if self.isFirstComeFirstServe {
//                headerView.lblGroupNumber.text = "\(self.arrTeeTimeDetails[0].groupDetails?[section].group ?? "")/ \(self.arrTeeTimeDetails[0].groupDetails?[section].allocatedCourse ?? "")/ \(self.arrTeeTimeDetails[0].groupDetails?[section].allocatedTime ?? "")"
//                let teeBoxValue = self.arrTeeTimeDetails[0].groupDetails?[section].teeBox ?? ""
//                if teeBoxValue as! String != "" {
//                    headerView.lblGroupNumber.text = headerView.lblGroupNumber.text! + "/ \(teeBoxValue)"
//                }
                let groupCount = String(format: "%@ %d", self.appDelegate.masterLabeling.group ?? "", section + 1)
                if self.selectedSlotsList.count-1 >= section {
                    headerView.lblGroupNumber.text = "\(groupCount)/ \(selectedSlotsList[section]["CourseName"] ?? "")/ \(selectedSlotsList[section]["Time"] ?? "")"
                    let teeBoxValue = selectedSlotsList[section]["TeeBox"] ?? ""
                    if teeBoxValue as! String != "" {
                        headerView.lblGroupNumber.text = headerView.lblGroupNumber.text! + "/ \(selectedSlotsList[section]["TeeBox"] ?? "")"
                    }
                } else {
                    headerView.lblGroupNumber.text = groupCount
                }
                
            } else {
                headerView.lblHolesHeader.isHidden = true
                headerView.lblTransHeader.isHidden = true
            }
            
            return headerView
            
        }
        else if tableView == self.instructionsTableView
        {
            return nil
        }
        //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
        //PROD0000202 -- Start
        else if tableView == self.tblViewfirstComeFirstServce
        {
            let view = FirstComeFirstServeHeaderView()
            view.lblCourses.text = "Courses:"
            view.lblAvailableTimes.text = "Available Tee Times:"
            if isFrom == "Modify" || isFrom == "View"{
                if self.arrTeeTimeDetails.count > 0 {
                    if self.arrTeeTimeDetails[0].buttonTextValue == "1" || self.arrTeeTimeDetails[0].buttonTextValue == "2" {
                        return view
                    } else {
                        return nil
                    }
                } else {
                    return nil
                }
            } else {
                return view
            }
        }
        else if tableView == self.transPopupTableView
        {
            return nil
        }
        //PROD0000202 -- End
        else
        {
            let headerView = Bundle.main.loadNibNamed("RequestHeaderView", owner: self, options: nil)?.first as! RequestHeaderView
            headerView.lblGroupNumber.isHidden = false
            
            if(section == 0){
                
                if arrGroup1.count == 0 {
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
                }else{
                if arrGroup1[section] is CaptaineInfo {
                    let memberObj = arrGroup1[section] as! CaptaineInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.captainName!)
                    
                }
                else if arrGroup1[section] is MemberInfo {
                        let memberObj = arrGroup1[section] as! MemberInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!, memberObj.memberName!)

                    }
                    else if arrGroup1[section] is GuestInfo {
                        let guestObj = arrGroup1[section] as! GuestInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.guestName!)

                    } else {
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")

                    }
                }}

            else if(section == 1){
                if arrGroup2.count == 0 {
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
                }else{

                if arrGroup2[0] is CaptaineInfo {
                    let memberObj = arrGroup2[0] as! CaptaineInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.captainName!)
                    
                }
                else if arrGroup2[0] is MemberInfo {
                    let memberObj = arrGroup2[0] as! MemberInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!, memberObj.memberName!)
                    
                }
                else if arrGroup2[0] is GuestInfo {
                    let guestObj = arrGroup2[0] as! GuestInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.guestName!)
                    
                } else {
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
                    
                }
                }}
            else if(section == 2){
                if arrGroup3.count == 0 {
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
                }else{
                if arrGroup3[0] is CaptaineInfo {
                    let memberObj = arrGroup3[0] as! CaptaineInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.captainName!)
                    
                }
                else if arrGroup3[0] is MemberInfo {
                    let memberObj = arrGroup3[0] as! MemberInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!, memberObj.memberName!)
                    
                }
                else if arrGroup3[0] is GuestInfo {
                    let guestObj = arrGroup3[0] as! GuestInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.guestName!)
                    
                } else {
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
                    
                }
                }}
            else if(section == 3){
                if arrGroup4.count == 0 {
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
                }else{
                if arrGroup4[0] is CaptaineInfo {
                    let memberObj = arrGroup4[0] as! CaptaineInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.captainName!)
                    
                }
                else if arrGroup4[0] is MemberInfo {
                    let memberObj = arrGroup4[0] as! MemberInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!, memberObj.memberName!)
                    
                }
                else if arrGroup4[0] is GuestInfo {
                    let guestObj = arrGroup4[0] as! GuestInfo
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.guestName!)
                    
                } else {
                    headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
                    
                }
                }}
            else{
                headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
            }
            
            // Added by Zeeshan
            let groupCount = String(format: "%@ %d", self.appDelegate.masterLabeling.group ?? "", section + 1)
            if self.selectedSlotsList.count-1 >= section {
                if self.isFirstComeFirstServe {
                    headerView.lblGroupNumber.text = "\(groupCount)/ \(selectedSlotsList[section]["CourseName"] ?? "")/ \(selectedSlotsList[section]["Time"] ?? "")"
                    let teeBoxValue = selectedSlotsList[section]["TeeBox"] ?? ""
                    if teeBoxValue as! String != "" {
                        headerView.lblGroupNumber.text = headerView.lblGroupNumber.text! + "/ \(selectedSlotsList[section]["TeeBox"] ?? "")"
                    }
                } else {
                    headerView.lblGroupNumber.text = "\(groupCount)"
                }
                
            } else {
                headerView.lblGroupNumber.text = groupCount
            }
            headerView.lblGroupNumber.textColor = APPColor.textColor.secondary
            if self.isFirstComeFirstServe {
                headerView.lblTrance.text = "Trans"
                headerView.lblNineHoles.text = "9 Holes"
            } else {
                headerView.lblTrance.text = ""
                headerView.lblNineHoles.text = ""
            }
            	
            //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
            //PROD0000202 -- Start
//            headerView.lblTrance.text = "Trans"
//            headerView.lblNineHoles.text = "9 Holes"
            //PROD0000202 -- End
        
            return headerView
            
        }

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == addNewPopoverTableView {
            return 0
        }else if (tableView == modifyTableview){
            if arrTeeTimeDetails.count == 0 {
                return 0 + (section < (self.arrTeeTimeDetails.first?.groupDetails?.count ?? 0) ? (self.arrTeeTimeDetails.first?.groupDetails?[section].buttonTextValue == "3" ? 38 : 0) : 0)
            }else{
                if arrTeeTimeDetails[0].buttonTextValue == "3" || arrTeeTimeDetails[0].buttonTextValue == "4" || self.arrTeeTimeDetails[0].buttonTextValue == "5"{
                    if self.isFirstComeFirstServe {
                        return 260 + 70 + (section < (self.arrTeeTimeDetails.first?.groupDetails?.count ?? 0) ? (self.arrTeeTimeDetails.first?.groupDetails?[section].buttonTextValue == "3" ? 38 : 0) : 0)
                    } else {
                        return 280 + (section < (self.arrTeeTimeDetails.first?.groupDetails?.count ?? 0) ? (self.arrTeeTimeDetails.first?.groupDetails?[section].buttonTextValue == "3" ? 38 : 0) : 0)
                    }
                }else{
                    if self.isFirstComeFirstServe {
                        return 172 + 70 + (section < (self.arrTeeTimeDetails.first?.groupDetails?.count ?? 0) ? (self.arrTeeTimeDetails.first?.groupDetails?[section].buttonTextValue == "3" ? 38 : 0) : 0)
                    } else {
                        return 172 + (section < (self.arrTeeTimeDetails.first?.groupDetails?.count ?? 0) ? (self.arrTeeTimeDetails.first?.groupDetails?[section].buttonTextValue == "3" ? 38 : 0) : 0)
                    }
                }
            }
        }
        else if tableView == self.instructionsTableView
        {
            return 0
        }
        //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
        //PROD0000202 -- Start
        else if tableView == self.tblViewfirstComeFirstServce
        {
            return UITableViewAutomaticDimension
        }
        else if tableView == self.transPopupTableView
        {
            return 0
        }
        //PROD0000202 -- End
        else
        {
            return UITableViewAutomaticDimension
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFrom == "Modify" || isFrom == "View"{
            if(arrTeeTimeDetails.count == 0){
                return 0

            }
            else{
                return self.arrTeeTimeDetails[0].courseDetails?.count ?? 0

            }
        }else{
            return self.golfSettings?.courseDetails?.count ?? 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCell", for: indexPath as IndexPath) as! CustomDashBoardCell
        
        
        
        if isFrom == "Modify" || isFrom == "View"{
            cell.lblCourse.layer.cornerRadius = 12
            cell.lblCourse.layer.masksToBounds = true

            if self.selectedPreference == indexPath.row{
                
                cell.btnCheckBox.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                self.arrPreferredCource.removeAll()
                cell.lblCourse.backgroundColor = hexStringToUIColor(hex: "22D457")
                cell.lblCourse.setTitle(self.appDelegate.masterLabeling.preffered_course, for: UIControlState.normal)
                cell.lblCourse.isHidden = false
                self.arrPreferredCource.append((self.golfSettings?.courseDetails?[indexPath.row].id)!)
            }
            else if self.selectedExcludedCourse == indexPath.row{
                
                cell.btnCheckBox.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                self.arrExcludCourse.removeAll()
                cell.lblCourse.backgroundColor = hexStringToUIColor(hex: "C90000")
                cell.lblCourse.setTitle(self.appDelegate.masterLabeling.exclude_course, for: UIControlState.normal)
                cell.lblCourse.isHidden = false
                self.arrExcludCourse.append((self.golfSettings?.courseDetails?[indexPath.row].id)!)
            }
            else{
                if self.arrTeeTimeDetails[0].preferredCourse == self.arrTeeTimeDetails[0].courseDetails?[indexPath.row].courseName! {
                    if selectedPreference == -1 && self.arrPreferredCource.count == 1{
                    cell.btnCheckBox.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    cell.lblCourse.backgroundColor = hexStringToUIColor(hex: "22D457")
                    cell.lblCourse.setTitle(self.appDelegate.masterLabeling.preffered_course, for: UIControlState.normal)
                    cell.lblCourse.isHidden = false
                    cell.btnCheckBox.isSelected = true
                    self.arrPreferredCource.removeAll()

                    self.arrPreferredCource.append(((self.arrTeeTimeDetails[0].courseDetails?[indexPath.row].id)!))
                    }
                    else{
                        cell.lblCourse.isHidden = true
                        cell.btnCheckBox.isSelected = false
                        cell.btnCheckBox.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)

                    }
                }else if self.arrTeeTimeDetails[0].excludedCourse == self.arrTeeTimeDetails[0].courseDetails?[indexPath.row].courseName!{
                    if selectedExcludedCourse == -1 && self.arrExcludCourse.count == 1{

                    cell.btnCheckBox.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    cell.lblCourse.backgroundColor = hexStringToUIColor(hex: "C90000")
                    cell.btnCheckBox.isSelected = true
                    cell.lblCourse.setTitle(self.appDelegate.masterLabeling.exclude_course, for: UIControlState.normal)
                    cell.lblCourse.isHidden = false
                        self.arrExcludCourse.removeAll()

                    self.arrExcludCourse.append((self.arrTeeTimeDetails[0].courseDetails?[indexPath.row].id)!)
                    }
                    else{
                        cell.lblCourse.isHidden = true
                        cell.btnCheckBox.isSelected = false
                        cell.btnCheckBox.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)

                    }
                }
                else{
                    cell.lblCourse.isHidden = true
                    cell.btnCheckBox.isSelected = false
                    cell.btnCheckBox.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)

                }
            }
            
            cell.lblPreferredCourseName.text = String(format: "%@", self.arrTeeTimeDetails[0].courseDetails?[indexPath.row].courseName ?? "")
            let placeHolderImage = UIImage(named: "Group 2124")
            
//            if UIScreen.main.scale == 2.0{
                 imageURLString = self.arrTeeTimeDetails[0].courseDetails?[indexPath.row].courseImage2 ?? ""

//            }else{
//                 imageURLString = self.arrTeeTimeDetails[0].courseDetails?[indexPath.row].courseImage3 ?? ""
//
//            }
            
            //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
            //ENGAGE0011419 -- Start
            
            if (self.imageURLString ?? "").isValidURL()
            {
                let url = URL.init(string:imageURLString ?? "")
                cell.preferImage.sd_setImage(with: url , placeholderImage: placeHolderImage)
            }
            /*
            if((imageURLString?.count)!>0){
                let validUrl = self.verifyUrl(urlString: imageURLString)
                if(validUrl == true){
                    
                    let url = URL.init(string:imageURLString ?? "")
                    cell.preferImage.sd_setImage(with: url , placeholderImage: placeHolderImage)
                    
                }
            }
            */
            //ENGAGE0011419 -- End
            
        }else{
            cell.lblPreferredCourseName.text = String(format: "%@", self.golfSettings?.courseDetails?[indexPath.row].courseName ?? "")
            let placeHolderImage = UIImage(named: "Group 2124")
            
            //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead
            //ENGAGE0011419 -- Start
            imageURLString = self.golfSettings?.courseDetails?[indexPath.row].courseImage1
            
            if (self.imageURLString ?? "").isValidURL()
            {
                let url = URL.init(string:imageURLString ?? "")
                cell.preferImage.sd_setImage(with: url , placeholderImage: placeHolderImage)
            }
            /*
            if(((imageURLString?.count) ?? 0) > 0){
                let validUrl = self.verifyUrl(urlString: imageURLString)
                if(validUrl == true){
                    
                    let url = URL.init(string:imageURLString ?? "")
                    cell.preferImage.sd_setImage(with: url , placeholderImage: placeHolderImage)
                    
                }
            }
            */
            //ENGAGE0011419 -- End
            cell.lblCourse.layer.cornerRadius = 12
            cell.lblCourse.layer.masksToBounds = true
            
            // Modified by Zeeshan
            
            if self.selectedPreference == indexPath.row{
                
                cell.btnCheckBox.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                self.arrPreferredCource.removeAll()
                cell.lblCourse.backgroundColor = hexStringToUIColor(hex: "22D457")
                cell.lblCourse.setTitle(self.appDelegate.masterLabeling.preffered_course, for: UIControlState.normal)
                cell.lblCourse.isHidden = false
                self.arrPreferredCource.append((self.golfSettings?.courseDetails?[indexPath.row].id)!)
            }
            else if self.selectedExcludedCourse == indexPath.row{
                
                cell.btnCheckBox.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                self.arrExcludCourse.removeAll()
                cell.lblCourse.backgroundColor = hexStringToUIColor(hex: "C90000")
                cell.lblCourse.setTitle(self.appDelegate.masterLabeling.exclude_course, for: UIControlState.normal)
                cell.lblCourse.isHidden = false
                self.arrExcludCourse.append((self.golfSettings?.courseDetails?[indexPath.row].id)!)
            }
            else{
                
                cell.lblCourse.isHidden = true
                cell.btnCheckBox.isSelected = false
                cell.btnCheckBox.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
            }
                
            
        }
        if let coursesDetails = self.courseDetailsResponse.courseDetails {
            if coursesDetails[indexPath.row].scheduleType == "FCFS" {
                cell.lblCourse.isHidden = true
                cell.btnCheckBox.isSelected = false
                cell.btnCheckBox.setImage(UIImage(named : "switchToFCFS"), for: UIControlState.normal)
            }
        }
        self.collectionViewHeight.constant = self.courceCollectionView.contentSize.height;
        cell.delegate = self
        heightOfColectionView()
        return cell
    }
    
    func heightOfColectionView() {
        
        collectionViewHeight.constant = courceCollectionView.collectionViewLayout.collectionViewContentSize.height
        
        
       
        self.view.setNeedsLayout()
    }
    
    //Mark- Verify url exist
    //Commented by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead
    //ENGAGE0011419 -- Start
//    func verifyUrl(urlString: String?) -> Bool {
//        if let urlString = urlString {
//            if let url = URL(string: urlString) {
//                return UIApplication.shared.canOpenURL(url)
//            }
//        }
//        return false
//    }
    //ENGAGE0011419 -- End
    
    /// Adds new pop over for registeration
    func addNewPopOverClicked(cell: CustomNewRegCell) {
        
//        guard cell.txtSearchField.text?.count ?? 0 < 1 else{
//            //Change message
//            let alertController = UIAlertController.init(title: "", message: "Remove the member to add.", preferredStyle: .alert)
//            let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//            return
//        }
        self.isMultiSelectionClicked = false
    
        if self.addNewMeber == true{
            let indexPath = self.groupsTableview.indexPath(for: cell)
            
            selectedIndex = indexPath?.row
            selectedSection = indexPath?.section
            
            
            let addNewView : UIView!
            //Modified by kiran V2.5 -- GATHER0000606 -- modified to change height based on no of options
            //GATHER0000606 -- Start
            let optionsHeight = self.appDelegate.addRequestOpt_Golf.count * 50
            
            addNewView = UIView(frame: CGRect(x: 100, y: 0, width: 180, height: optionsHeight/*146*/))
            
            addNewPopoverTableView = UITableView(frame: CGRect(x: 0, y: 5, width: 180, height: optionsHeight/*146*/))
            //GATHER0000606 -- End
            addNewView.addSubview(addNewPopoverTableView!)
            
            addNewPopoverTableView?.dataSource = self
            addNewPopoverTableView?.delegate = self
            addNewPopoverTableView?.bounces = true
            //Modified by kiran V3.2 -- ENGAGE0012667 -- tableview on popup list height fix
            //ENGAGE0012667 -- Start
            self.addNewPopoverTableView?.sectionHeaderHeight = 0
            //ENGAGE0012667 -- End
            addNewPopover = Popover()
            addNewPopover?.arrowSize = CGSize(width: 0.0, height: 0.0)
            
            let point = cell.btnAdd.convert(cell.btnAdd.center , to: appDelegate.window)
            addNewPopover?.sideEdge = 4.0
            let pointt = CGPoint(x: self.view.bounds.width - 31, y: point.y - 15)
            
            let bounds = UIScreen.main.bounds
            let height = bounds.size.height
            
            
            if point.y > height - 170{
                addNewPopover?.popoverType = .up
                addNewPopover?.show(addNewView, point: pointt)
                
            }else{
                addNewPopover?.show(addNewView, point: pointt)
                
            }
        }else{
            self.golfDuplicates()
            self.memberValidattionAPI({ [unowned self] (status) in
                if status == true{
                let indexPath = self.groupsTableview.indexPath(for: cell)
                
                self.selectedIndex = indexPath?.row
                self.selectedSection = indexPath?.section
                
                
                let addNewView : UIView!
                //Modified by kiran V2.5 -- GATHER0000606 -- modified to change height based on no of options
                //GATHER0000606 -- Start
                let optionsHeight = self.appDelegate.addRequestOpt_Golf.count * 50
                    
                addNewView = UIView(frame: CGRect(x: 100, y: 0, width: 180, height: optionsHeight/*146*/))
                
                self.addNewPopoverTableView = UITableView(frame: CGRect(x: 0, y: 5, width: 180, height: optionsHeight/*146*/))
                //GATHER0000606 -- End
                addNewView.addSubview(self.addNewPopoverTableView!)
                
                self.addNewPopoverTableView?.dataSource = self
                self.addNewPopoverTableView?.delegate = self
                self.addNewPopoverTableView?.bounces = true
                    //Modified by kiran V3.2 -- ENGAGE0012667 -- tableview on popup list height fix
                    //ENGAGE0012667 -- Start
                    self.addNewPopoverTableView?.sectionHeaderHeight = 0
                    //ENGAGE0012667 -- End
                self.addNewPopover = Popover()
                self.addNewPopover?.arrowSize = CGSize(width: 0.0, height: 0.0)
                
                let point = cell.btnAdd.convert(cell.btnAdd.center , to: self.appDelegate.window)
                self.addNewPopover?.sideEdge = 4.0
                let pointt = CGPoint(x: self.view.bounds.width - 31, y: point.y - 15)
                
                let bounds = UIScreen.main.bounds
                let height = bounds.size.height
                
                
                if point.y > height - 170{
                    self.addNewPopover?.popoverType = .up
                    self.addNewPopover?.show(addNewView, point: pointt)
                    
                }else{
                    self.addNewPopover?.show(addNewView, point: pointt)
                    
                }
                }
            })
        }
        
        
        
      
    }
    
    func ModifyClicked(cell: ModifyRegCustomCell) {
        let indexPath = self.modifyTableview.indexPath(for: cell)
        selectedIndex = indexPath?.row
        selectedSection = indexPath?.section

        if(selectedSection == 0){
            
            arrGroup1.remove(at: selectedIndex!)
            
        }else if(selectedSection == 1){
            
            arrGroup2.remove(at: selectedIndex!)

            
        }else if(selectedSection == 2){
            
            arrGroup3.remove(at: selectedIndex!)

            
        }else if(selectedSection == 3){
            
            arrGroup4.remove(at: selectedIndex!)

            
        }
        modifyTableview.reloadData()
        
    }

    func actionSheet(_ sheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {

        strMoveToValue = values[buttonIndex]
        if strMoveToValue == "Cancel"{
            
        }else{
        if selectedSection == 0{
            if isFrom == "Modify" || isFrom == "View"{
                self.arrGroup1.remove(at: selectedIndex!)

            }else{
                arrGroupMaxList1.remove(at: selectedIndex!)
                self.arrGroup1.remove(at: selectedIndex!)

            }
        }else if selectedSection == 1{
            if isFrom == "Modify" || isFrom == "View"{
                self.arrGroup2.remove(at: selectedIndex!)
                
            }else{
                arrGroupMaxList2.remove(at: selectedIndex!)
                self.arrGroup2.remove(at: selectedIndex!)
            }
        }else if selectedSection == 2{
            if isFrom == "Modify" || isFrom == "View"{
                self.arrGroup3.remove(at: selectedIndex!)
                
            }else{
                arrGroupMaxList3.remove(at: selectedIndex!)
                self.arrGroup3.remove(at: selectedIndex!)
            }

        }else if selectedSection == 3{
            if isFrom == "Modify" || isFrom == "View"{
                self.arrGroup4.remove(at: selectedIndex!)
                
            }else{
                arrGroupMaxList4.remove(at: selectedIndex!)
                self.arrGroup4.remove(at: selectedIndex!)

            }

        }
        self.moveToValue()
        self.groupsTableview.reloadData()
        self.modifyTableview.reloadData()
        }
    }
    
    func moveToValue(){
        if strMoveToValue == "Move to Group 1"{
            if isFrom == "Modify" || isFrom == "View"{
                self.arrGroup1.append(moveToSelectedValue!)

            }else{

                arrGroupMaxList1.append("")
                self.arrGroup1.append(RequestData())

            for i in 0 ..< arrGroup1.count {
                
            if arrGroup1[i] is CaptaineInfo {
            }
            else if arrGroup1[i] is MemberInfo {
            }
            else if arrGroup1[i] is GuestInfo {
            }else  {
                self.arrGroup1.remove(at: i)
                self.arrGroup1.insert(moveToSelectedValue!, at: i)

                break
            }
            }

            }

        }else if strMoveToValue == "Move to Group 2"{
            if isFrom == "Modify" || isFrom == "View"{
                self.arrGroup2.append(moveToSelectedValue!)
                
            }else{
            
                arrGroupMaxList2.append("")
                
                self.arrGroup2.append(RequestData())

                for i in 0 ..< arrGroup2.count {
                    
                    if arrGroup2[i] is CaptaineInfo {
                    }
                    else if arrGroup2[i] is MemberInfo {
                    }
                    else if arrGroup2[i] is GuestInfo {
                    }else  {
                        self.arrGroup2.remove(at: i)
                        self.arrGroup2.insert(moveToSelectedValue!, at: i)
                        
                        break
                    }
                }
            }

            
        }else if strMoveToValue == "Move to Group 3"{
            if isFrom == "Modify" || isFrom == "View"{
                self.arrGroup3.append(moveToSelectedValue!)
                
            }else{
                arrGroupMaxList3.append("")
                
                self.arrGroup3.append(RequestData())
                for i in 0 ..< arrGroup3.count {
                    
                    if arrGroup3[i] is CaptaineInfo {
                    }
                    else if arrGroup3[i] is MemberInfo {
                    }
                    else if arrGroup3[i] is GuestInfo {
                    }else  {
                        self.arrGroup3.remove(at: i)
                        self.arrGroup3.insert(moveToSelectedValue!, at: i)
                        
                        break
                    }
                }
            
            }
        }else if strMoveToValue == "Move to Group 4"{
            if isFrom == "Modify" || isFrom == "View"{
                self.arrGroup4.append(moveToSelectedValue!)
                
            }else{
                arrGroupMaxList4.append("")
                
                self.arrGroup4.append(RequestData())

                
                for i in 0 ..< arrGroup4.count {
                    
                    if arrGroup4[i] is CaptaineInfo {
                    }
                    else if arrGroup4[i] is MemberInfo {
                    }
                    else if arrGroup4[i] is GuestInfo {
                    }else  {
                        self.arrGroup4.remove(at: i)
                        self.arrGroup4.insert(moveToSelectedValue!, at: i)
                        
                        break
                    }
                }
            }
            }
    }
    func threeDotsClickedToMoveGroup(cell: CustomNewRegCell){

        
        let indexPath = self.groupsTableview.indexPath(for: cell)
    
        
        selectedIndex = indexPath?.row
        selectedSection = indexPath?.section
        
        if selectedSection == 0 {
            moveToSelectedValue = arrGroup1[selectedIndex!]
        }else if selectedSection == 1 {
            moveToSelectedValue = arrGroup2[selectedIndex!]
        }else if selectedSection == 2 {
            moveToSelectedValue = arrGroup3[selectedIndex!]
        }else if selectedSection == 3 {
            moveToSelectedValue = arrGroup4[selectedIndex!]
        }
        
        
        if self.lblGroupNumber.text == "04" {
            values = ["Move to Group 1", "Move to Group 2", "Move to Group 3", "Move to Group 4","Cancel"]
            
        }else if self.lblGroupNumber.text == "03" {
            values = ["Move to Group 1", "Move to Group 2", "Move to Group 3", "Cancel"]
            
        }else if self.lblGroupNumber.text == "02" {
            values = ["Move to Group 1", "Move to Group 2", "Cancel"]

        }else if self.lblGroupNumber.text == "01" {
            values = ["Move to Group 1", "Cancel"]
        }
        
        values.remove(at: selectedSection!)

        let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil)
        //for each value in array
        for value in values{
            //add a button
            actionSheet.addButton(withTitle: value as String)
        }
        //display action sheet
        actionSheet.cancelButtonIndex = values.count - 1
        actionSheet.show(in: self.view)
   
    }
    func ModifyThreeDotsClicked(cell: ModifyRegCustomCell){
        let indexPath = self.modifyTableview.indexPath(for: cell)
        
        selectedIndex = indexPath?.row
        selectedSection = indexPath?.section
        
        if selectedSection == 0 {
            moveToSelectedValue = arrGroup1[selectedIndex!]
        }else if selectedSection == 1 {
            moveToSelectedValue = arrGroup2[selectedIndex!]
        }else if selectedSection == 2 {
            moveToSelectedValue = arrGroup3[selectedIndex!]
        }else if selectedSection == 3 {
            moveToSelectedValue = arrGroup4[selectedIndex!]
        }
        
        
        if self.lblGroupNumber.text == "04" {
            values = ["Move to Group 1", "Move to Group 2", "Move to Group 3", "Move to Group 4","Cancel"]
            
        }else if self.lblGroupNumber.text == "03" {
            values = ["Move to Group 1", "Move to Group 2", "Move to Group 3", "Cancel"]
            
        }else if self.lblGroupNumber.text == "02" {
            values = ["Move to Group 1", "Move to Group 2", "Cancel"]
            
        }else if self.lblGroupNumber.text == "01" {
            values = ["Move to Group 1", "Cancel"]
        }
        values.remove(at: selectedSection!)
        if arrTeeTimeDetails[0].buttonTextValue == "3" || arrTeeTimeDetails[0].buttonTextValue == "4" || self.arrTeeTimeDetails[0].buttonTextValue == "5"{

            if self.lblGroupNumber.text == "04" {
                tempValues = [String(format: "Move to %@", self.arrTeeTimeDetails[0].groupDetails?[0].group ?? ""), String(format: "Move to %@", self.arrTeeTimeDetails[0].groupDetails?[1].group ?? ""), String(format: "Move to %@", self.arrTeeTimeDetails[0].groupDetails?[2].group ?? ""), String(format: "Move to %@", self.arrTeeTimeDetails[0].groupDetails?[3].group ?? ""), "Cancel"]
                
            }else if self.lblGroupNumber.text == "03" {
                tempValues = [String(format: "Move to %@", self.arrTeeTimeDetails[0].groupDetails?[0].group ?? ""), String(format: "Move to %@", self.arrTeeTimeDetails[0].groupDetails?[1].group ?? ""), String(format: "Move to %@", self.arrTeeTimeDetails[0].groupDetails?[2].group ?? ""),"Cancel"]
                
            }else if self.lblGroupNumber.text == "02" {
                tempValues = [String(format: "Move to %@", self.arrTeeTimeDetails[0].groupDetails?[0].group ?? ""), String(format: "Move to %@", self.arrTeeTimeDetails[0].groupDetails?[1].group ?? ""), "Cancel"]
                
            }else if self.lblGroupNumber.text == "01" {
                tempValues = [String(format: "Move to %@", self.arrTeeTimeDetails[0].groupDetails?[0].group ?? ""),"Cancel"]
            }
            tempValues.remove(at: selectedSection!)
            
            let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil)
            actionSheet.tintColor = UIColor.red
            
            //for each value in array
            for value in tempValues{
                //add a button
                actionSheet.addButton(withTitle: value as String)
            }
            //display action sheet
            actionSheet.cancelButtonIndex = tempValues.count - 1
            actionSheet.show(in: self.view)
        }else{
        
        
        let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil)
        actionSheet.tintColor = UIColor.red

        //for each value in array
        for value in values{
            //add a button
            actionSheet.addButton(withTitle: value as String)
        }
        //display action sheet
        actionSheet.cancelButtonIndex = values.count - 1
        actionSheet.show(in: self.view)
        }
    }

    func editClicked(cell: CustomNewRegCell) {
        
    }
    
    //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
    //PROD0000202 -- Start
    func transTextFieldSelected(textField : UITextField , cell : CustomNewRegCell)
    {
        self.showTransDropDown(cell: cell)
    }
    
    func selectedNineHoles(status : Bool , cell : CustomNewRegCell)
    {
        //TODO:- Need to save the status in array and reload tableview.
        self.selectHole(index: self.groupsTableview.indexPath(for: cell)!, status: status)
    }
    
    func transTextFieldSelected(textField : UITextField , cell : ModifyRegCustomCell)
    {
        if self.isFrom != "View" {
            self.showModifyTransDropDown(cell: cell)
        }
    }
    
    func selectedNineHoles(status : Bool , cell : ModifyRegCustomCell) -> Bool
    {
        //TODO:- Need to save the status in array and reload tableview.
        if self.isFrom != "View" {
            self.selectHole(index: self.modifyTableview.indexPath(for: cell)!, status: status)
            return true
        }
        return false
        
    }
    
    func selectHole(index: IndexPath, status: Bool) {
        var updateHolesValue = ""
        if status {
           updateHolesValue = "9 Holes"
        }
        switch index.section{
        case 0:
            self.updateHolesInGroupArr(arr: &arrGroup1, index: index.row, holes: updateHolesValue)
        case 1:
            self.updateHolesInGroupArr(arr: &arrGroup2, index: index.row, holes: updateHolesValue)
        case 2:
            self.updateHolesInGroupArr(arr: &arrGroup3, index: index.row, holes: updateHolesValue)
        default:
            self.updateHolesInGroupArr(arr: &arrGroup4, index: index.row, holes: updateHolesValue)
        }
        
    }
    
    func updateHolesInGroupArr(arr: inout [RequestData], index: Int, holes: String) {
        
        if let member = arr[index] as? CaptaineInfo {
            member.memberRequestHoles = holes
            arr[index] = member
        }
        if let member = arr[index] as? Detail {
            member.memberRequestHoles = holes
            arr[index] = member
        }
        if let member = arr[index] as? MemberInfo {
            member.memberRequestHoles = holes
            arr[index] = member
        }
        if let member = arr[index] as? GuestInfo {
            member.memberRequestHoles = holes
            arr[index] = member
        }
    }
    
    func selectedTrans(index: Int, section: Int, trans: String) {
        
        var transInt = 0
        if trans == self.transOptions[1] {
            transInt = TransportType.mct.rawValue
        } else if trans == self.transOptions[2] {
            transInt = TransportType.ct.rawValue
        } else {
            transInt = TransportType.wlk.rawValue
        }
        if section == 0 {
            self.updateValueInGroupArr(arr: &arrGroup1, index: index, trans: transInt)
        } else if section == 1 {
            self.updateValueInGroupArr(arr: &arrGroup2, index: index, trans: transInt)
        } else if section == 2 {
            self.updateValueInGroupArr(arr: &arrGroup3, index: index, trans: transInt)
        } else {
            self.updateValueInGroupArr(arr: &arrGroup4, index: index, trans: transInt)
        }
    }
    
    func updateValueInGroupArr(arr: inout [RequestData], index: Int, trans: Int) {
        
        if let member = arr[index] as? CaptaineInfo {
            member.memberTransType = trans
            arr[index] = member
        }
        if let member = arr[index] as? Detail {
            member.memberTransType = trans
            arr[index] = member
        }
        if let member = arr[index] as? MemberInfo {
            member.memberTransType = trans
            arr[index] = member
        }
        if let member = arr[index] as? GuestInfo {
            member.memberTransType = trans
            arr[index] = member
        }
    }
    
    private func showTransDropDown(cell : CustomNewRegCell)
    {
        let indexPath = self.groupsTableview.indexPath(for: cell)
        
        selectedIndex = indexPath?.row
        selectedSection = indexPath?.section
        
        let addNewView : UIView!
        //Modified by kiran V2.5 -- GATHER0000606 -- modified to change height based on no of options
        //GATHER0000606 -- Start
        let optionsHeight = self.appDelegate.addRequestOpt_Golf.count * 50
        
        addNewView = UIView(frame: CGRect(x: 0, y: 0, width: Int(cell.textFieldTrans.frame.size.width), height: optionsHeight/*146*/))
        
        self.transPopupTableView = UITableView(frame: CGRect(x: 0, y: 5, width: Int(cell.textFieldTrans.frame.size.width), height: optionsHeight/*146*/))
        //GATHER0000606 -- End
        addNewView.addSubview(self.transPopupTableView!)
        
        self.transPopupTableView?.dataSource = self
        self.transPopupTableView?.delegate = self
        self.transPopupTableView?.bounces = true
        self.transPopupTableView?.sectionHeaderHeight = 0
        addNewPopover = Popover()
        addNewPopover?.arrowSize = CGSize(width: 0.0, height: 0.0)
        
        let point = cell.textFieldTrans.convert(cell.textFieldTrans.center , to: appDelegate.window)
        addNewPopover?.sideEdge = 4.0
        let pointt = CGPoint(x: point.x, y: point.y + 15)
        
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        
        if point.y > height - 170{
            addNewPopover?.popoverType = .up
            addNewPopover?.show(addNewView, point: pointt)
            
        }else{
            addNewPopover?.show(addNewView, point: pointt)
            
        }

    }
    //PROD0000202 -- End
    
    private func showModifyTransDropDown(cell : ModifyRegCustomCell)
    {
        let indexPath = self.modifyTableview.indexPath(for: cell)
        
        selectedIndex = indexPath?.row
        selectedSection = indexPath?.section
        
        let addNewView : UIView!

        let optionsHeight = self.appDelegate.addRequestOpt_Golf.count * 50
        
        addNewView = UIView(frame: CGRect(x: 0, y: 0, width: Int(cell.textFieldTrans.frame.size.width), height: optionsHeight/*146*/))
        
        self.transPopupTableView = UITableView(frame: CGRect(x: 0, y: 5, width: Int(cell.textFieldTrans.frame.size.width), height: optionsHeight/*146*/))

        addNewView.addSubview(self.transPopupTableView!)
        
        self.transPopupTableView?.dataSource = self
        self.transPopupTableView?.delegate = self
        self.transPopupTableView?.bounces = true
        self.transPopupTableView?.sectionHeaderHeight = 0
        addNewPopover = Popover()
        addNewPopover?.arrowSize = CGSize(width: 0.0, height: 0.0)
        
        let point = cell.textFieldTrans.convert(cell.textFieldTrans.center , to: appDelegate.window)
        addNewPopover?.sideEdge = 4.0
        let pointt = CGPoint(x: point.x, y: point.y + 15)
        
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        
        if point.y > height - 170{
            addNewPopover?.popoverType = .up
            addNewPopover?.show(addNewView, point: pointt)
            
        }else{
            addNewPopover?.show(addNewView, point: pointt)
            
        }

    }
    
    //MARK:- Response from member directory for add member/my buddy
    func requestMemberViewControllerResponse(selecteArray: [RequestData])
    {
        
        if(isFrom == "Modify" || isFrom == "View")
        {
            
            if(selectedSection == 0){
                
                let selectedObject = selecteArray[0]
                selectedObject.isEmpty = false
                arrGroup1.insert(selectedObject, at:arrGroup1.count)
                
            }else if(selectedSection == 1){
                
                let selectedObject = selecteArray[0]
                selectedObject.isEmpty = false
                arrGroup2.insert(selectedObject, at: arrGroup2.count)
                
            }else if(selectedSection == 2){
                
                let selectedObject = selecteArray[0]
                selectedObject.isEmpty = false
                arrGroup3.insert(selectedObject, at: arrGroup3.count)
                
            }else if(selectedSection == 3){
                
                let selectedObject = selecteArray[0]
                selectedObject.isEmpty = false
                arrGroup4.insert(selectedObject, at: arrGroup4.count)
                
            }
            
            self.modifyTableview.reloadData()

        }else{
            
            if selecteArray.count < 1
            {
                return
            }
            
            
            if self.isMultiSelectionClicked
            {
                // This is not being used and its moved to multiSelectRequestMemberViewControllerResponse(selectedArray: [[RequestData]])
                
               /* self.isMasterSelectionClicked = false
                //replace arrGroups with the array which contains all the group arrays. Do this when individual group arrays use is replaced with an array of groups in this controller
                //creating an array of groups to make iteration easy
                var arrGroups = [self.arrGroup1 , self.arrGroup2 , self.arrGroup3 , self.arrGroup4]
                
                
                selecteArray.forEach { (newMember) in
                    
                    let tempArrGroups = arrGroups
                    
                    groupLoop :  for (groupIndex,group) in tempArrGroups.enumerated()
                    {
                        //checking if group has max tickets allocated
                        if group.filter({$0.isEmpty == false}).count < (self.golfSettings?.maxGroupReserv ?? 0)
                        {
                            for (memberIndex , member) in group.enumerated()
                            {
                                if member.isEmpty == true
                                {
                                    arrGroups[groupIndex].remove(at: memberIndex)
                                    newMember.isEmpty = false
                                    arrGroups[groupIndex].insert(newMember, at: memberIndex)
                                    
                                    break groupLoop
                                }
                            }
                            
                        }
                        
                    }
                    
                }
                
                //Assigning the groups form array back to the original group arrays
                for (index,group) in arrGroups.enumerated()
                {
                    switch index {
                    case 0:
                        self.arrGroup1 = group
                    case 1:
                        self.arrGroup2 = group
                    case 2:
                        self.arrGroup3 = group
                    case 3:
                       self.arrGroup4 = group
                    default:
                        continue
                    }
                }
                */
            }
            else
            {
                //Used to replace a single member
                
                //This is old logic without multiple selection. in case have to remove multiple slection for registeration use this logic only
                if(selectedSection == 0){
                    
                    let selectedObject = selecteArray[0]
                    selectedObject.isEmpty = false
                    arrGroup1.remove(at: selectedIndex!)
                    arrGroup1.insert(selectedObject, at: selectedIndex!)

                }else if(selectedSection == 1){
                   
                    let selectedObject = selecteArray[0]
                    selectedObject.isEmpty = false
                    arrGroup2.remove(at: selectedIndex!)
                    arrGroup2.insert(selectedObject, at: selectedIndex!)

                    
                }else if(selectedSection == 2){
                   
                    let selectedObject = selecteArray[0]
                    selectedObject.isEmpty = false
                    arrGroup3.remove(at: selectedIndex!)
                    arrGroup3.insert(selectedObject, at: selectedIndex!)

                    
                }else if(selectedSection == 3){
                    
                    let selectedObject = selecteArray[0]
                    selectedObject.isEmpty = false
                    arrGroup4.remove(at: selectedIndex!)
                    arrGroup4.insert(selectedObject, at: selectedIndex!)

                }
                
            }
            
            self.groupsTableview.reloadData()
        }
        
    }
    
    //MARK:- Response for multi selection from member directory for member/my buddy
    func multiSelectRequestMemberViewControllerResponse(selectedArray: [[RequestData]]) {
        
        let arrGroups = selectedArray
        
        //Assigning the groups form array back to the original group arrays
        for (index,group) in arrGroups.enumerated()
        {
            switch index {
            case 0:
                self.arrGroup1 = group
            case 1:
                self.arrGroup2 = group
            case 2:
                self.arrGroup3 = group
            case 3:
               self.arrGroup4 = group
            default:
                continue
            }
        }
        
        self.groupsTableview.reloadData()
        
    }
    
    func clearButtonClicked(cell: CustomNewRegCell) {
        
        let indexPath = self.groupsTableview.indexPath(for: cell)
        selectedIndex = indexPath?.row
        selectedSection = indexPath?.section

        if(selectedSection == 0){
            
            arrGroup1.remove(at: selectedIndex!)
            arrGroup1.insert(RequestData(), at: selectedIndex!)

            
        }else if(selectedSection == 1){
            
            arrGroup2.remove(at: selectedIndex!)
            arrGroup2.insert(RequestData(), at: selectedIndex!)

        }else if(selectedSection == 2){
            
            arrGroup3.remove(at: selectedIndex!)
            arrGroup3.insert(RequestData(), at: selectedIndex!)

        }else if(selectedSection == 3){
            
            arrGroup4.remove(at: selectedIndex!)
            arrGroup4.insert(RequestData(), at: selectedIndex!)
        }
        self.groupsTableview.reloadData()
    }
    func memberViewControllerResponse(selecteArray: [MemberInfo]) {

    }
    func buddiesViewControllerResponse(selectedBuddy: [MemberInfo]) {
        
    }
    func guestViewControllerResponse(guestName: String) {
        
    }
    @IBAction func decreaseNumberClicked(_ sender: Any) {
        
        // Added by Zeeshan
        if self.selectedSlotsList.count == self.arrGroupList.count {
            self.selectedSlotsList.removeLast()
            self.tblViewfirstComeFirstServce.reloadData()
        }
        
        btnIncreaseTicket.isEnabled = true
        if arrGroupList.count == 1 {
            btnDecreaseTickets.isEnabled = false
        }
        else{
            
          if  arrGroupList.count == 2 {
                arrGroup2.removeAll()
            self.arrGroupMaxList2.removeAll()
          }else if  arrGroupList.count == 3 {
                arrGroup3.removeAll()
            self.arrGroupMaxList3.removeAll()
            }else if  arrGroupList.count == 4 {
                arrGroup4.removeAll()
            self.arrGroupMaxList4.removeAll()
            }
            arrGroupList.removeLast()
            if arrGroupList.count == 1 {
                btnDecreaseTickets.isEnabled = false
            }
        }
        
        
        self.lblGroupNumber.text = String(format: "%02d", arrGroupList.count)
        
        if(self.lblGroupNumber.text == "01"){
            heightViewGroups.constant = 132
            self.lblLinkGroupsReg.isHidden = true
            self.switchLinkGroup.isHidden = true
            self.switchLinkGroup.isOn = false
        }
        
        if isFrom == "Modify" || isFrom == "View"{
            self.modifyTableview .reloadData()
        }else{
            self.groupsTableview.reloadData()
        }
    }
    @IBAction func increaseNumberclicked(_ sender: Any) {
        
       
        if arrGroupList.count >= self.golfSettings!.maxGroupReserv! {
            btnIncreaseTicket.isEnabled = false
        }
        else{
            btnDecreaseTickets.isEnabled = true
            arrGroupList.append(RequestData())
            if arrGroupList.count >= self.golfSettings!.maxGroupReserv! {
                btnIncreaseTicket.isEnabled = false
            }
            if self.isFrom == "Modify" || isFrom == "View"{
                
            }else{
                let value = self.golfSettings?.maxMultiGroupPlayers
                
                for _ in 0 ..< (value ?? 0) {
                    if arrGroupList.count == 2{
                        self.arrGroup2.append(RequestData())
                        self.arrGroupMaxList2.append("")

                    }else if arrGroupList.count == 3{
                        self.arrGroup3.append(RequestData())
                        self.arrGroupMaxList3.append("")

                    }else if arrGroupList.count == 4{
                        self.arrGroup4.append(RequestData())
                        self.arrGroupMaxList4.append("")

                    }
                }
            }
            
            self.lblGroupNumber.text = String(format: "%02d", arrGroupList.count)
            if(self.lblGroupNumber.text == "01"){
                heightViewGroups.constant = 132
                self.lblLinkGroupsReg.isHidden = true
                self.switchLinkGroup.isHidden = true
                self.switchLinkGroup.isOn = false
                
            }else if (self.lblGroupNumber.text == "02"){
                if !self.isFirstComeFirstServe {
                    heightViewGroups.constant = 268
                    self.lblLinkGroupsReg.isHidden = false
                    self.switchLinkGroup.isHidden = false
                    self.switchLinkGroup.isOn = true
                }
            }else{
                if !self.isFirstComeFirstServe {
                    heightViewGroups.constant = 268
                    self.lblLinkGroupsReg.isHidden = false
                    self.switchLinkGroup.isHidden = false
                    self.switchLinkGroup.isOn = true
                }
            }
        }
        if isFrom == "Modify" || isFrom == "View"{
            self.modifyTableview .reloadData()
        }else{
            self.groupsTableview.reloadData()
        }
        
        
    }

    @IBAction func linkGroupsCliked(_ sender: Any) {
    }
    
    @IBAction func nextTapped(_ sender:UIButton) {
        
        let dateDiff = findDateDiff(time1Str: self.maxTime ?? "", time2Str: currentTime ?? "")
        if dateDiff.first == "+"{
            let currentDate = Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.maxDaysInAdvance ?? 0) + 1, to: self.dateAndTimeDromServer)
            let nameFormatter = DateFormatter()
            nameFormatter.dateFormat = "MMMM YYYY"
            
            let name = nameFormatter.string(from: currentDate!)
            
            if  name == "\(self.lblMonth.text ?? "") \(self.lblYear.text ?? "")" {
                
            }else{
                myCalendar.setCurrentPage(getNextMonth(date: myCalendar.currentPage), animated: true)
            }
        }else{
            let currentDate = Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.maxDaysInAdvance  ?? 0), to: self.dateAndTimeDromServer)
            let nameFormatter = DateFormatter()
            nameFormatter.dateFormat = "MMMM YYYY"
            
            let name = nameFormatter.string(from: currentDate!)
            
            if  name == "\(self.lblMonth.text ?? "") \(self.lblYear.text ?? "")" {
                
            }else{
                myCalendar.setCurrentPage(getNextMonth(date: myCalendar.currentPage), animated: true)
            }
        }
    }
    
    @IBAction  func previousTapped(_ sender:UIButton) {
        
       
        
        let dateDiff = self.findDateDiff(time1Str: self.minTime ?? "", time2Str: self.currentTime ?? "")
        
        if dateDiff.first == "+"{
            currentMonth = Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.minDaysInAdvance ?? 0) + 1, to: self.dateAndTimeDromServer)
            
        }else{
            currentMonth = Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.minDaysInAdvance ?? 0), to: self.dateAndTimeDromServer)
            
        }
        let nameFormatter = DateFormatter()
        nameFormatter.dateFormat = "MMMM YYYY" // format January, February, March, ...
        
        let name = nameFormatter.string(from: currentMonth!)
        
        if  name == "\(self.lblMonth.text ?? "") \(self.lblYear.text ?? "")" {
            
        }else{
            myCalendar.setCurrentPage(getPreviousMonth(date: myCalendar.currentPage), animated: true)
        }
    }
    
    @IBAction func HolesClciked(_ sender: Any) {
        
        if (sender as AnyObject).tag == 1 {
            self.btnNineHoles.setImage(UIImage(named : "Group 2384"), for: UIControlState.normal)
            self.btnEighteenHoles.setImage(UIImage(named : "Rectangle 2117"), for: UIControlState.normal)
            gameType = 9
            
        }else {
            self.btnEighteenHoles.setImage(UIImage(named : "Group 2384"), for: UIControlState.normal)
            self.btnNineHoles.setImage(UIImage(named : "Rectangle 2117"), for: UIControlState.normal)
            gameType = 18
        }
    }
    
    //MARK:- Multi selection button Action
    @IBAction func multiSelectionClicked(_ sender: UIButton)
    {
        
        //Added on 20th July 2020 V2.2
        //Added for roles and privilages
        switch self.accessManager.accessPermision(for: .memberDirectory)
        {
        case .notAllowed:
            
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        default:
            break
        }
        
        self.isMultiSelectionClicked = true
        
        if self.addNewMeber == true
        {
            //Adds Popover for multi select button
            let addNewView : UIView!
            //Added by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
            //GATHER0000606 -- Start
            //let popoverHeight = self.appDelegate.arrRegisterMultiMemberType.count * 50
            let popoverHeight = self.appDelegate.addRequestOpt_Golf_MultiSelect.count * 50
            //GATHER0000606 -- End
            addNewView = UIView(frame: CGRect(x: 100, y: 0, width: 180, height: popoverHeight/*146*/))
            
            addNewPopoverTableView = UITableView(frame: CGRect(x: 0, y: 5, width: 180, height: popoverHeight/*146*/))
            
            addNewView.addSubview(addNewPopoverTableView!)
            
            addNewPopoverTableView?.dataSource = self
            addNewPopoverTableView?.delegate = self
            addNewPopoverTableView?.bounces = true
            //Modified by kiran V3.2 -- ENGAGE0012667 -- tableview on popup list height fix
            //ENGAGE0012667 -- Start
            self.addNewPopoverTableView?.sectionHeaderHeight = 0
            //ENGAGE0012667 -- End
            addNewPopover = Popover()
            addNewPopover?.arrowSize = CGSize(width: 0.0, height: 0.0)
            
            let point = sender.convert(sender.center , to: appDelegate.window)
            addNewPopover?.sideEdge = 4.0
            let pointt = CGPoint(x: self.view.bounds.width - 31, y: point.y - 15)
            
            let bounds = UIScreen.main.bounds
            let height = bounds.size.height
            
            
            if point.y > height - 170{
                addNewPopover?.popoverType = .up
                addNewPopover?.show(addNewView, point: pointt)
                
            }else{
                addNewPopover?.show(addNewView, point: pointt)
            }
        }
        else
        {
            self.golfDuplicates()
            self.memberValidattionAPI({ [unowned self] (status) in
                if status == true{
                
                let addNewView : UIView!
                    //Added by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
                    //GATHER0000606 -- Start
                    //let popoverHeight = self.appDelegate.arrRegisterMultiMemberType.count * 50
                    let popoverHeight = self.appDelegate.addRequestOpt_Golf_MultiSelect.count * 50
                    //GATHER0000606 -- End
                addNewView = UIView(frame: CGRect(x: 100, y: 0, width: 180, height: popoverHeight/*146*/))
                
                self.addNewPopoverTableView = UITableView(frame: CGRect(x: 0, y: 5, width: 180, height: popoverHeight/*146*/))
                
                addNewView.addSubview(self.addNewPopoverTableView!)
                
                self.addNewPopoverTableView?.dataSource = self
                self.addNewPopoverTableView?.delegate = self
                self.addNewPopoverTableView?.bounces = true
                    //Modified by kiran V3.2 -- ENGAGE0012667 -- tableview on popup list height fix
                    //ENGAGE0012667 -- Start
                    self.addNewPopoverTableView?.sectionHeaderHeight = 0
                    //ENGAGE0012667 -- End
                self.addNewPopover = Popover()
                self.addNewPopover?.arrowSize = CGSize(width: 0.0, height: 0.0)
                
                let point = sender.convert(sender.center , to: self.appDelegate.window)
                self.addNewPopover?.sideEdge = 4.0
                let pointt = CGPoint(x: self.view.bounds.width - 31, y: point.y - 15)
                
                let bounds = UIScreen.main.bounds
                let height = bounds.size.height
                
                
                if point.y > height - 170{
                    self.addNewPopover?.popoverType = .up
                    self.addNewPopover?.show(addNewView, point: pointt)
                    
                }else{
                    self.addNewPopover?.show(addNewView, point: pointt)
                    
                }
                }
            })

        }
        
    }
    
//    Written by Zeeshan
    func switchToLotteryClicked() {
        enableFirstComeFirstServe(false)
    }
    
    
    func checkBoxClicked(cell: CustomDashBoardCell)
    {
        let indexPath = self.courceCollectionView.indexPath(for: cell)
        if self.courseDetailsResponse.courseDetails![indexPath!.row].scheduleType == "FCFS" {
            self.enableFirstComeFirstServe(true)
        } else {
            if cell.btnCheckBox.currentImage == UIImage(named : "CheckBox_uncheck")
            {
                let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                actionSheet.view.tintColor = hexStringToUIColor(hex: "40B2E6")
                
                let preferredCourse = UIAlertAction(title: self.appDelegate.masterLabeling.preffered_course,style: .default) { (action) in
                    
                    //Added by kiran v2.9 -- Cobalt Pha0010644 -- Function to show Hard & Soft message details of courses when date is changed
                    //Cobalt Pha0010644 -- Start
                    if let index = indexPath?.row,index >= 0 && index < (self.golfSettings?.courseDetails?.count ?? 0)
                    {
                        let courseId = self.golfSettings?.courseDetails?[index].id
                        self.showCourseAlert(preferredCourse: courseId ?? "") { [unowned self] alertType in
                            
                            switch alertType
                            {
                            case .hard:
                                self.clearSelectedCoursePreference()
                            case .soft,.none:
                                self.selectedPreference = indexPath?.row
                                self.courceCollectionView.reloadData()
                            }
                            
                        } noAction: { [unowned self] alertType in
                            
                            switch alertType
                            {
                            case .hard:
                                break
                            case .soft:
                                self.clearSelectedCoursePreference()
                            case .none:
                                break
                            }
                        }

                    }
                    //Cobalt Pha0010644 -- End
                    
                    //Old Logic
    //                self.selectedPreference = indexPath?.row
    //                self.courceCollectionView.reloadData()
                
                }
                
                let ecludeThisCourse = UIAlertAction(title: self.appDelegate.masterLabeling.exclude_course,style: .default) { (action) in
                self.selectedExcludedCourse = indexPath?.row

                self.courceCollectionView.reloadData()
                }
                
                let cancelAction = UIAlertAction(title: "Cancel",
                                                 style: .cancel,
                                                 handler: nil)
                
                actionSheet.addAction(preferredCourse)
                actionSheet.addAction(ecludeThisCourse)
                actionSheet.addAction(cancelAction)
                
                present(actionSheet, animated: true, completion: nil)

                
            }else {
                cell.btnCheckBox.isSelected = false
                cell.btnCheckBox.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                cell.lblCourse.isHidden = true
                if (self.arrExcludCourse.contains((self.golfSettings?.courseDetails?[indexPath!.row].id)!)){
                    self.arrExcludCourse.remove(at :0)
                    self.selectedExcludedCourse = -1


                }
                if (self.arrPreferredCource.contains((self.golfSettings?.courseDetails?[indexPath!.row].id)!)){
                    self.arrPreferredCource.remove(at: 0)
                    self.selectedPreference = -1

                }
                if self.arrTeeTimeDetails.count == 0
                {
                    
                }  else{
                    if (self.arrExcludCourse.contains((self.arrTeeTimeDetails[0].courseDetails?[indexPath!.row].id)!)){
                        self.arrExcludCourse.remove(at: 0)
                        
                    }
                    if (self.arrPreferredCource.contains((self.arrTeeTimeDetails[0].courseDetails?[indexPath!.row].id)!)){
                        self.arrPreferredCource.remove(at: 0)
                    }
                }
            }
        }
        
        
    }
    
 
    func getNextMonth(date:Date)->Date {
        
        
        self.lblMonth.text = self.formatterMonth.string(from: Calendar.current.date(byAdding: .month, value: 1, to:date)!)
        
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "YYYY"
        
        self.lblYear.text = formatter1.string(from: Calendar.current.date(byAdding: .month, value: 1, to:date)!)
        
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
        
        
    }
    
    func getPreviousMonth(date:Date)->Date {
        
        
        self.lblMonth.text = self.formatterMonth.string(from: Calendar.current.date(byAdding: .month, value: -1, to:date)!)
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "YYYY"
        
        self.lblYear.text = formatter1.string(from: Calendar.current.date(byAdding: .month, value: -1, to:date)!)
        
        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition)
    {
        print("did select date \(self.formatter.string(from: date))")
        reservationRequestDate = self.formatter.string(from: date)
        reservationRemindDate = self.newFormatter.string(from: date)
        
        self.golfDuplicates()
        self.memberValidattionAPI({ [unowned self] (status) in
            
            //Added by kiran v2.9 -- Cobalt Pha0010644 -- Updated the settings with selected date Date selection
            //Cobalt Pha0010644 -- Start
            self.updateSettings(success: { [unowned self] in
                
                if self.arrPreferredCource.count > 0
                {
                    self.showCourseAlert(preferredCourse: self.arrPreferredCource.last ?? "") { [unowned self] alertType in
                        
                        switch alertType
                        {
                        case .hard:
                            self.clearSelectedCoursePreference()
                        case .soft:
                            break
                        case .none:
                            break
                        }
                        
                    } noAction: { [unowned self] alertType in
                        
                        switch alertType
                        {
                        case .hard:
                            break
                        case .soft:
                            self.clearSelectedCoursePreference()
                        case .none:
                            break
                        }
                    }

                }
                let dateString = self.getDateString(givenDate: date)
                self.selectedSlotsList.removeAll()
                self.getTimeSlotsForDate(dateString: dateString)
                
            })
            //Cobalt Pha0010644 -- End
        })


    }
    
   
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "YYYY"

        self.lblMonth.text = self.formatterMonth.string(from: Calendar.current.date(byAdding: .month, value: 0, to:calendar.currentPage)!)
        self.lblYear.text = formatter1.string(from: Calendar.current.date(byAdding: .month, value: 0, to:calendar.currentPage)!)

    }
    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
        print("did deselect date \(self.formatter.string(from: date))")
    }
    
    func golfDuplicates(){
        preferenceList.removeAll()
        notPreferenceList.removeAll()
        groupList.removeAll()
        
        arrTempGroup1 = arrGroup1
        arrTempGroup2 = arrGroup2
        arrTempGroup3 = arrGroup3
        arrTempGroup4 = arrGroup4
        
        if isFrom == "Modify" || isFrom == "View" {
            
        }else{
            
            arrTempGroup1 =  arrTempGroup1.filter({$0.isEmpty == false})
            arrTempGroup2 =  arrTempGroup2.filter({$0.isEmpty == false})
            arrTempGroup3 =  arrTempGroup3.filter({$0.isEmpty == false})
            arrTempGroup4 =  arrTempGroup4.filter({$0.isEmpty == false})
            
        }
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            for i in 0 ..< arrTempGroup1.count {
                if self.arrTeeTimeDetails.count == 0{}else{
                    if self.arrTeeTimeDetails[0].groupDetails?[0].playerGroup == 1{
                        newPlayerGroup1 = 1
                    }else{
                        newPlayerGroup1 = self.arrTeeTimeDetails[0].groupDetails?[0].playerGroup
                    }
                }
                if  arrTempGroup1[i] is CaptaineInfo {
                    
                    let playObj = arrTempGroup1[i] as! CaptaineInfo
                    let memberInfo:[String: Any] = [
                        "PlayerLinkedMemberId": playObj.captainID ?? "",
                        "ReservationRequestDetailId": "",
                        "PlayerOrder": i + 1,
                        "PlayerGroup": 1,
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "AddBuddy": 0,
                        "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                        "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                    ]
                    
                    groupList.append(memberInfo)
                    
                }
                else if arrTempGroup1[i] is Detail
                {
                    let playObj = arrTempGroup1[i] as! Detail
                    
                    //Added by kiran V2.8 -- ENGAGE0011784 -- Added support for existing guest.
                    //ENGAGE0011784 -- Start
                    let memberType = CustomFunctions.shared.memberType(details: playObj, For: .golf)
                    
                    if memberType == .guest//playObj.id == nil
                    {
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId":  "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": newPlayerGroup1 ?? 1,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                            "GuestType": playObj.guestType ?? "",
                            "GuestName": playObj.guestName ?? "",
                            "GuestEmail": playObj.email ?? "",
                            "GuestContact": playObj.cellPhone ?? "",
                            "AddBuddy": playObj.addBuddy ?? 0,
                            //Added by kiran V2.8 -- ENGAGE0011784 --
                            //ENGAGE0011784 -- Start
                            APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                            APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                            APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                            APIKeys.kGuestGender : playObj.guestGender ?? "",
                            //ENGAGE0011784 -- End
                            "MemberRequestHoles": playObj.memberRequestHoles ?? "",
                            "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue
                        ]
                        groupList.append(memberInfo)
                    }
                    else if memberType == .existingGuest
                    {
                        
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": newPlayerGroup1 ?? 1,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "AddBuddy": playObj.addBuddy ?? 0,
                            "MemberRequestHoles": playObj.memberRequestHoles ?? "",
                            "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue
                        ]
                        //TODO:- Remove after approval
                        /* Remove after approval
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": newPlayerGroup1 ?? 1,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                            "GuestType": playObj.guestType ?? "",
                            "GuestName": playObj.guestName ?? "",
                            "GuestEmail": playObj.email ?? "",
                            "GuestContact": playObj.cellPhone ?? "",
                            "AddBuddy": playObj.addBuddy ?? 0,
                            APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                            APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                            APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                            APIKeys.kGuestGender : playObj.guestGender ?? ""
                            
                        ]
                        */
                        groupList.append(memberInfo)
                    }
                    else if memberType == .member
                    {
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": newPlayerGroup1 ?? 1,
                            "GuestMemberOf": "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "AddBuddy": playObj.addBuddy ?? 0,
                            "MemberRequestHoles": playObj.memberRequestHoles ?? "",
                            "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue
                        ]
                        groupList.append(memberInfo)
                    }
                    //ENGAGE0011784 -- End
                }
                else if arrTempGroup1[i] is MemberInfo
                {
                    let playObj = arrTempGroup1[i] as! MemberInfo
                    
                    let memberInfo:[String: Any] = [
                        "PlayerLinkedMemberId": playObj.id ?? "",
                        "ReservationRequestDetailId": "",
                        "PlayerOrder": i + 1,
                        "PlayerGroup": newPlayerGroup1 ?? 1,
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "AddBuddy": 0,
                        "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                        "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                    ]
                    groupList.append(memberInfo)
                }
                else if arrTempGroup1[i] is GuestInfo
                {
                    let playObj = arrTempGroup1[i] as! GuestInfo
                    
                    //For existing guest only details sent for member are required.Used same object for guest and existing guest as other details a not considered in backend
                    let memberInfo:[String: Any] = [
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        "PlayerLinkedMemberId": playObj.linkedMemberID ?? "",
                        //ENGAGE0011784 -- End
                        "ReservationRequestDetailId": "",
                        "PlayerOrder": i + 1,
                        "PlayerGroup": newPlayerGroup1 ?? 1,
                        "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                        "GuestType": playObj.guestType!,
                        "GuestName": playObj.guestName!,
                        "GuestEmail": playObj.email!,
                        "GuestContact": playObj.cellPhone!,
                        "AddBuddy": playObj.addToMyBuddy!,
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                        APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                        APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                        APIKeys.kGuestGender : playObj.guestGender ?? "",
                        //ENGAGE0011784 -- End
                        "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                        "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                    ]
                    groupList.append(memberInfo)
                }
            }
            for i in 0 ..< groupList.count {
                if groupList.count > arrRegReqID1.count{
                    arrRegReqID1.append("")
                }
                if arrRegReqID1.count == 0 {
                    
                }else{
                    groupList[i].updateValue(arrRegReqID1[i], forKey: "ReservationRequestDetailId")
                }
            }
            
            for i in 0 ..< arrTempGroup2.count {
                if self.arrTeeTimeDetails.count == 0{}else{
                    if (self.arrTeeTimeDetails[0].groupDetails?.count)! > 1{
                    if self.arrTeeTimeDetails[0].groupDetails?[1].playerGroup == 2{
                        newPlayerGroup2 = 2
                    }else{
                        newPlayerGroup2 = self.arrTeeTimeDetails[0].groupDetails?[1].playerGroup
                    }
                    }
                    }
                if  arrTempGroup2[i] is CaptaineInfo {
                    let playObj = arrTempGroup2[i] as! CaptaineInfo
                    let memberInfo:[String: Any] = [
                        "PlayerLinkedMemberId": playObj.captainID ?? "",
                        "ReservationRequestDetailId": "",
                        "PlayerOrder": i + 1,
                        "PlayerGroup": 2,
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "AddBuddy": 0,
                        "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                        "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                    ]
                    groupList.append(memberInfo)
                    
                }
                else if arrTempGroup2[i] is Detail
                {
                    let playObj = arrTempGroup2[i] as! Detail
                    
                    //Added by kiran V2.8 -- ENGAGE0011784 -- Added support for existing guest.
                    //ENGAGE0011784 -- Start
                    let memberType = CustomFunctions.shared.memberType(details: playObj, For: .golf)
                    
                    if memberType == .guest//playObj.id == nil
                    {
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId":  "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": newPlayerGroup2 ?? 2,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                            "GuestType": playObj.guestType ?? "",
                            "GuestName": playObj.guestName ?? "",
                            "GuestEmail": playObj.email ?? "",
                            "GuestContact": playObj.cellPhone ?? "",
                            "AddBuddy": playObj.addBuddy ?? 0,
                            //Added by kiran V2.8 -- ENGAGE0011784 --
                            //ENGAGE0011784 -- Start
                            APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                            APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                            APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                            APIKeys.kGuestGender : playObj.guestGender ?? "",
                            //ENGAGE0011784 -- End
                            "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                            "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                        ]
                        groupList.append(memberInfo)
                    }
                    else if memberType == .existingGuest
                    {
                        
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": newPlayerGroup2 ?? 2,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "AddBuddy": playObj.addBuddy ?? 0,
                            "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                            "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                        ]
                        //TODO:- Reove after approval
                        /*Remove after approval
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId":  playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": newPlayerGroup2 ?? 2,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                            "GuestType": playObj.guestType ?? "",
                            "GuestName": playObj.guestName ?? "",
                            "GuestEmail": playObj.email ?? "",
                            "GuestContact": playObj.cellPhone ?? "",
                            "AddBuddy": playObj.addBuddy ?? 0,
                            APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                            APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                            APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                            APIKeys.kGuestGender : playObj.guestGender ?? ""
                            
                        ]
                        */
                        groupList.append(memberInfo)
                    }
                    else if memberType == .member
                    {
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": newPlayerGroup2 ?? 2,
                            "GuestMemberOf": "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "AddBuddy": playObj.addBuddy ?? 0,
                            "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                            "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                        ]
                        groupList.append(memberInfo)
                    }
                    //ENGAGE0011784 -- End
                }
                else if arrTempGroup2[i] is MemberInfo
                {
                    let playObj = arrTempGroup2[i] as! MemberInfo
                    
                    let memberInfo:[String: Any] = [
                        "PlayerLinkedMemberId": playObj.id ?? "",
                        "ReservationRequestDetailId":"",
                        "PlayerOrder": i + 1,
                        "PlayerGroup": newPlayerGroup2 ?? 2,
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "AddBuddy": 0,
                        "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                        "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                    ]
                    groupList.append(memberInfo)
                }
                else if arrTempGroup2[i] is GuestInfo
                {
                    let playObj = arrTempGroup2[i] as! GuestInfo
                    //For existing guest only details sent for member are required.Used same object for guest and existing guest as other details a not considered in backend
                    let memberInfo:[String: Any] = [
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        "PlayerLinkedMemberId": playObj.linkedMemberID ?? "",
                        //ENGAGE0011784 -- End
                        "ReservationRequestDetailId": "",
                        "PlayerOrder": i + 1,
                        "PlayerGroup": newPlayerGroup2 ?? 2,
                        "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                        "GuestType": playObj.guestType!,
                        "GuestName": playObj.guestName!,
                        "GuestEmail": playObj.email!,
                        "GuestContact": playObj.cellPhone!,
                        "AddBuddy": playObj.addToMyBuddy!,
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                        APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                        APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                        APIKeys.kGuestGender : playObj.guestGender ?? "",
                        //ENGAGE0011784 -- End
                        "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                        "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                    ]
                    groupList.append(memberInfo)
                }
            }
            if isFrom == "Modify" || isFrom == "View"{
                for i in 0 ..< groupList.count -  arrTempGroup1.count{
                    if groupList.count  -  arrTempGroup1.count > arrRegReqID2.count{
                        arrRegReqID2.append("")
                    }
                    if arrRegReqID2.count == 0 {
                        
                    }else{
                        groupList[arrTempGroup1.count + i].updateValue(arrRegReqID2[i], forKey: "ReservationRequestDetailId")
                    }
                }
            }
            for i in 0 ..< arrTempGroup3.count {
                if self.arrTeeTimeDetails.count == 0{}else{
                     if (self.arrTeeTimeDetails[0].groupDetails?.count)! > 2{
                    if self.arrTeeTimeDetails[0].groupDetails?[2].playerGroup == 3{
                        newPlayerGroup3 = 3
                    }else{
                        newPlayerGroup3 = self.arrTeeTimeDetails[0].groupDetails?[2].playerGroup
                        }}}
                if  arrTempGroup3[i] is CaptaineInfo {
                    let playObj = arrTempGroup3[i] as! CaptaineInfo
                    let memberInfo:[String: Any] = [
                        "PlayerLinkedMemberId": playObj.captainID ?? "",
                        "ReservationRequestDetailId": "",
                        "PlayerOrder": i + 1,
                        "PlayerGroup": 3,
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "AddBuddy": 0,
                        "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                        "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                    ]
                    
                    groupList.append(memberInfo)
                    
                }
                else if arrTempGroup3[i] is Detail
                {
                    let playObj = arrTempGroup3[i] as! Detail
                    //Added by kiran V2.8 -- ENGAGE0011784 -- Added support for existing guest.
                    //ENGAGE0011784 -- Start
                    let memberType = CustomFunctions.shared.memberType(details: playObj, For: .golf)
                    
                    if memberType == .guest//playObj.id == nil
                    {
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId":  "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": newPlayerGroup3 ?? 3,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                            "GuestType": playObj.guestType ?? "",
                            "GuestName": playObj.guestName ?? "",
                            "GuestEmail": playObj.email ?? "",
                            "GuestContact": playObj.cellPhone ?? "",
                            "AddBuddy": playObj.addBuddy ?? 0,
                            //Added by kiran V2.8 -- ENGAGE0011784 --
                            //ENGAGE0011784 -- Start
                            APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                            APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                            APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                            APIKeys.kGuestGender : playObj.guestGender ?? "",
                            //ENGAGE0011784 -- End
                            "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                            "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                        ]
                        groupList.append(memberInfo)
                    }
                    else if memberType == .existingGuest
                    {
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": newPlayerGroup3 ?? 3,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "AddBuddy": playObj.addBuddy ?? 0,
                            "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                            "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                        ]
                        //TODO:- Remove after approval
                        /*
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId":  playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": newPlayerGroup3 ?? 3,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                            "GuestType": playObj.guestType ?? "",
                            "GuestName": playObj.guestName ?? "",
                            "GuestEmail": playObj.email ?? "",
                            "GuestContact": playObj.cellPhone ?? "",
                            "AddBuddy": playObj.addBuddy ?? 0,
                            APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                            APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                            APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                            APIKeys.kGuestGender : playObj.guestGender ?? ""
                        ]*/
                        groupList.append(memberInfo)
                    }
                    else if memberType == .member
                    {
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": newPlayerGroup3 ?? 3,
                            "GuestMemberOf": "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "AddBuddy": playObj.addBuddy ?? 0,
                            "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                            "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                        ]
                        groupList.append(memberInfo)
                    }
                    //ENGAGE0011784 -- End
                }else if arrTempGroup3[i] is MemberInfo {
                    let playObj = arrTempGroup3[i] as! MemberInfo
                    
                    let memberInfo:[String: Any] = [
                        "PlayerLinkedMemberId": playObj.id ?? "",
                        "ReservationRequestDetailId": "",
                        "PlayerOrder": i + 1,
                        "PlayerGroup": newPlayerGroup3 ?? 3,
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "AddBuddy": 0,
                        "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                        "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                    ]
                    groupList.append(memberInfo)
                }
                else if arrTempGroup3[i] is GuestInfo
                {
                    let playObj = arrTempGroup3[i] as! GuestInfo
                    //For existing guest only details sent for member are required.Used same object for guest and existing guest as other details a not considered in backend
                    let memberInfo:[String: Any] = [
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        "PlayerLinkedMemberId": playObj.linkedMemberID ?? "",
                        //ENGAGE0011784 -- End
                        "ReservationRequestDetailId": "",
                        "PlayerOrder": i + 1,
                        "PlayerGroup":newPlayerGroup3 ?? 3,
                        "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                        "GuestType": playObj.guestType!,
                        "GuestName": playObj.guestName!,
                        "GuestEmail": playObj.email!,
                        "GuestContact": playObj.cellPhone!,
                        "AddBuddy": playObj.addToMyBuddy!,
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                        APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                        APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                        APIKeys.kGuestGender : playObj.guestGender ?? "",
                        //ENGAGE0011784 -- End
                        "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                        "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                    ]
                    groupList.append(memberInfo)
                }
            }
            if isFrom == "Modify" || isFrom == "View"{
                for i in 0 ..< groupList.count  -  (arrTempGroup1.count + arrTempGroup2.count){
                    if groupList.count -  (arrTempGroup1.count + arrTempGroup2.count) > arrRegReqID3.count{
                        arrRegReqID3.append("")
                    }
                    if arrRegReqID3.count == 0 {
                        
                    }else{
                        groupList[arrTempGroup1.count + arrTempGroup2.count + i].updateValue(arrRegReqID3[i], forKey: "ReservationRequestDetailId")
                    }
                }}
            for i in 0 ..< arrTempGroup4.count {
                if self.arrTeeTimeDetails.count == 0{}else{
                     if (self.arrTeeTimeDetails[0].groupDetails?.count)! > 3{
                    if self.arrTeeTimeDetails[0].groupDetails?[3].playerGroup == 4{
                        newPlayerGroup4 = 4
                    }else{
                        newPlayerGroup4 = self.arrTeeTimeDetails[0].groupDetails?[3].playerGroup
                        }}}
                if  arrTempGroup4[i] is CaptaineInfo {
                    let playObj = arrTempGroup4[i] as! CaptaineInfo
                    let memberInfo:[String: Any] = [
                        "PlayerLinkedMemberId": playObj.captainID ?? "",
                        "ReservationRequestDetailId": "",
                        "PlayerOrder": i + 1,
                        "PlayerGroup": 4,
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "AddBuddy": 0,
                        "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                        "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                    ]
                    
                    groupList.append(memberInfo)
                    
                }
                else if arrTempGroup4[i] is Detail
                {
                    let playObj = arrTempGroup4[i] as! Detail
                    
                    //Added by kiran V2.8 -- ENGAGE0011784 -- Added support for existing guest.
                    //ENGAGE0011784 -- Start
                    let memberType = CustomFunctions.shared.memberType(details: playObj, For: .golf)
                    
                    
                    if memberType == .guest//playObj.id == nil
                    {
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId":  "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": newPlayerGroup4 ?? 4,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                            "GuestType": playObj.guestType ?? "",
                            "GuestName": playObj.guestName ?? "",
                            "GuestEmail": playObj.email ?? "",
                            "GuestContact": playObj.cellPhone ?? "",
                            "AddBuddy": playObj.addBuddy ?? 0,
                            //Added by kiran V2.8 -- ENGAGE0011784 --
                            //ENGAGE0011784 -- Start
                            APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                            APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                            APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                            APIKeys.kGuestGender : playObj.guestGender ?? "",
                            //ENGAGE0011784 -- End
                            "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                            "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                        ]
                        groupList.append(memberInfo)
                    }
                    else if memberType == .existingGuest
                    {
                        
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": newPlayerGroup4 ?? 4,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "AddBuddy": playObj.addBuddy ?? 0,
                            "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                            "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                        ]
                        //TODO:- Remove after approval
                        /*
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId":  playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": newPlayerGroup4 ?? 4,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                            "GuestType": playObj.guestType ?? "",
                            "GuestName": playObj.guestName ?? "",
                            "GuestEmail": playObj.email ?? "",
                            "GuestContact": playObj.cellPhone ?? "",
                            "AddBuddy": playObj.addBuddy ?? 0,
                            //Added by kiran V2.8 -- ENGAGE0011784 --
                            //ENGAGE0011784 -- Start
                            APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                            APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                            APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                            APIKeys.kGuestGender : playObj.guestGender ?? ""
                            //ENGAGE0011784 -- End
                        ]
                         */
                        groupList.append(memberInfo)
                    }
                    else if memberType == .member
                    {
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": newPlayerGroup4 ?? 4,
                            "GuestMemberOf": "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "AddBuddy": playObj.addBuddy ?? 0,
                            "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                            "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                            
                        ]
                        groupList.append(memberInfo)
                    }
                    
                    //ENGAGE0011784 -- Start
                    
                }else if arrTempGroup4[i] is MemberInfo {
                    let playObj = arrTempGroup4[i] as! MemberInfo
                    
                    let memberInfo:[String: Any] = [
                        "PlayerLinkedMemberId": playObj.id ?? "",
                        "ReservationRequestDetailId": "",
                        "PlayerOrder": i + 1,
                        "PlayerGroup": newPlayerGroup4 ?? 4,
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "AddBuddy": 0,
                        "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                        "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                    ]
                    groupList.append(memberInfo)
                }
                else if arrTempGroup4[i] is GuestInfo
                {
                    let playObj = arrTempGroup4[i] as! GuestInfo
                    //For existing guest only details sent for member are required.Used same object for guest and existing guest as other details a not considered in backend
                    let memberInfo:[String: Any] = [
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        "PlayerLinkedMemberId": playObj.linkedMemberID ?? "",
                        //ENGAGE0011784 -- End
                        "ReservationRequestDetailId": "",
                        "PlayerOrder": i + 1,
                        "PlayerGroup": newPlayerGroup4 ?? 4,
                        "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                        "GuestType": playObj.guestType!,
                        "GuestName": playObj.guestName!,
                        "GuestEmail": playObj.email!,
                        "GuestContact": playObj.cellPhone!,
                        "AddBuddy": playObj.addToMyBuddy!,
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                        APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                        APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                        APIKeys.kGuestGender : playObj.guestGender ?? "",
                        //ENGAGE0011784 -- End
                        "MemberTransType": playObj.memberTransType ?? TransportType.wlk.rawValue,
                        "MemberRequestHoles": playObj.memberRequestHoles ?? ""
                    ]
                    groupList.append(memberInfo)
                }
            }
            if isFrom == "Modify" || isFrom == "View"{
                for i in 0 ..< groupList.count -  (arrTempGroup1.count + arrTempGroup2.count + arrTempGroup3.count){
                    if groupList.count - (arrTempGroup1.count + arrTempGroup2.count + arrTempGroup3.count) > arrRegReqID4.count{
                        arrRegReqID4.append("")
                    }
                    if arrRegReqID4.count == 0 {
                        
                    }else{
                        groupList[arrTempGroup1.count + arrTempGroup2.count + arrTempGroup3.count + i].updateValue(arrRegReqID4[i], forKey: "ReservationRequestDetailId")
                    }
                }
            }
            
            if arrPreferredCource.count == 0 {
                let preference:[String: Any] = [
                    "SpaceDetailId": "",
                    ]
                preferenceList.append(preference)
            }else{
                for i in 0 ..< arrPreferredCource.count {
                    let preference:[String: Any] = [
                        "SpaceDetailId": arrPreferredCource[i],
                        ]
                    preferenceList.append(preference)
                }
            }
            if arrExcludCourse.count == 0 {
                let preference:[String: Any] = [
                    "SpaceDetailId": "",
                    ]
                notPreferenceList.append(preference)
            }else{
                for i in 0 ..< arrExcludCourse.count {
                    let preference:[String: Any] = [
                        "SpaceDetailId": arrExcludCourse[i],
                        ]
                    notPreferenceList.append(preference)
                }
            }
        }
    }
    
    func memberValidattionAPI(_ success : @escaping ((Bool) -> Void)){
        let paramaterDict:[String: Any] = [
            "Content-Type":"application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            "RequestId": requestID ?? "",
            "ReservationRequestDate": reservationRequestDate ?? "",
            "ReservationRequestTime": txtPreferredTeeTime.text ?? "",
            "GroupDetails": groupList,
            "GroupCount": Int(self.lblGroupNumber.text!) ?? 0,
            "GameType": gameType ?? 9,
            "LinkGroup": switchLinkGroup.isOn ? 1 : 0,
            "Earliest": txtEarliestTeeTime.text ?? "",
            "PreferedSpaceDetailId": preferenceList,
            "NotPreferedSpaceDetailId": notPreferenceList,
            "IsReservation": "1",
            "IsEvent": "0",
            "ReservationType": "Golf",
            "RegistrationID": requestID ?? ""
        ]
        
        APIHandler.sharedInstance.getMemberValidation(paramater: paramaterDict, onSuccess: { (response) in
            
            self.appDelegate.hideIndicator()
            
            if response.details?.count == 0
            {
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                self.addNewMeber = false
                self.firstTime = false
                
                success(false)
            }
            else
            {
                if response.responseCode == InternetMessge.kSuccess
                {
                    success(true)
                    self.firstTime = false
                    self.addNewMeber = true
                    
                }
                else
                {
                    if self.firstTime == true
                    {
                        //Commented on 1st June 2020 V2.1
//                        self.arrGroup1.remove(at: 0)
//                        self.arrGroup1.insert(RequestData(), at: 0)
                        self.firstTime = false
//                        self.groupsTableview.reloadData()
                        
                        //Added by kiran v2.9 -- Cobalt Pha0010644 -- Function to show Hard & Soft message details of courses when date is changed
                        //Cobalt Pha0010644 -- Start
                        success(false)
                        //Cobalt Pha0010644 -- End
                    }
                    else
                    {
                        if let impVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ImpotantContactsVC") as? ImpotantContactsVC
                        {
                            impVC.importantContactsDisplayName = response.brokenRules?.fields?[0] ?? ""
                            impVC.isFrom = "Reservations"
                            impVC.arrList = response.details!
                            //Added by kiran v2.9 -- Cobalt Pha0010644 -- Function to show Hard & Soft message details of courses when date is changed
                            //Cobalt Pha0010644 -- Start
                            impVC.closeClicked = {
                                success(false)
                            }
                            //Cobalt Pha0010644 -- End
                            impVC.modalTransitionStyle   = .crossDissolve;
                            impVC.modalPresentationStyle = .overCurrentContext
                            self.present(impVC, animated: true, completion: nil)
                            
                        }
                        //Added by kiran v2.9 -- Cobalt Pha0010644 -- Function to show Hard & Soft message details of courses when date is changed
                        //Cobalt Pha0010644 -- Start
                        else
                        {
                            success(false)
                        }
                        //Cobalt Pha0010644 -- End
                    }
                    
                    self.addNewMeber = false
                    //Commented by kiran v2.9 -- Cobalt Pha0010644 --
                    //Cobalt Pha0010644 -- Start
                    //success(false)
                    //Cobalt Pha0010644 -- End
                }
                
            }
            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            success(false)
            self.appDelegate.hideIndicator()
        }
    }
    
    @IBAction func requestClicked(_ sender: Any)
    {
        if self.isViewOnly
        {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        //Added on 4th July 2020 V2.2
        //added roles and privilages changes
        //since not allowed is handled before coming to this screen not need to check for it.
        switch self.accessManager.accessPermision(for: .golfReservation) {
        case .view:
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        default:
            break
        }
        
        //Added by kiran v2.9 -- Cobalt Pha0010644 -- Function to show Hard & Soft message details of courses when date is changed
        //Cobalt Pha0010644 -- Start
        self.showHardRule(preferredCourse: self.arrPreferredCource.last ?? "") { shouldSave in
            
            if shouldSave
            {
                self.golfDuplicates()
                
                var paramaterDict:[String: Any]!
                if self.isFirstComeFirstServe {
                    paramaterDict = [
                       "Content-Type":"application/json",
                       APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                       APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                       APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                       "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                       APIKeys.kdeviceInfo: [APIHandler.devicedict],
                       "RequestId": self.requestID ?? "",
                       "ReservationRequestDate": self.reservationRequestDate ?? "",
                       "ReservationRequestTime": self.txtPreferredTeeTime.text ?? "",
                       "GroupDetails": self.groupList,
                       "GroupCount": Int(self.lblGroupNumber.text!) ?? 0,
                       "GameType": self.gameType ?? 9,
                       "LinkGroup": self.switchLinkGroup.isOn ? 1 : 0,
                       "Earliest": self.txtEarliestTeeTime.text ?? "",
                       "PreferedSpaceDetailId": self.preferenceList,
                       "NotPreferedSpaceDetailId": self.notPreferenceList,
                       "GolfRequestType": "FCFS Request",
                       "RegistrationID": self.requestID ?? "",
                       "PreferredFCFSCoursesWithTime": self.selectedSlotsList,
                       "ReservationType": "Golf",
                       "IsEvent": 0,
                       "IsReservation": 1
                   ]
                } else {
                    paramaterDict = [
                       "Content-Type":"application/json",
                       APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                       APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                       APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                       "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                       APIKeys.kdeviceInfo: [APIHandler.devicedict],
                       "RequestId": self.requestID ?? "",
                       "ReservationRequestDate": self.reservationRequestDate ?? "",
                       "ReservationRequestTime": self.txtPreferredTeeTime.text ?? "",
                       "GroupDetails": self.groupList,
                       "GroupCount": Int(self.lblGroupNumber.text!) ?? 0,
                       "GameType": self.gameType ?? 9,
                       "LinkGroup": self.switchLinkGroup.isOn ? 1 : 0,
                       "GolfRequestType": "Lottery Request",
                       "PreferedSpaceDetailId": self.preferenceList,
                       "NotPreferedSpaceDetailId": self.notPreferenceList,
                       "Earliest": self.txtEarliestTeeTime.text ?? "",
                       "ReservationType": "Golf",
                       "IsEvent": 0,
                       "IsReservation": 1
                   ]
                }
//                print(self.groupList)
                
                var arrWaitlistGroupDetails = [[String : Any]]()
                
                for waitlistedGoup in self.arrWaitlistGropus
                {
                    if let waitlistDict = waitlistedGoup.toDict()
                    {
                        arrWaitlistGroupDetails.append(waitlistDict)
                    }
                }
                
                paramaterDict.updateValue(arrWaitlistGroupDetails, forKey: "GroupStatusDetails")
                
                APIHandler.sharedInstance.saveTeeTime(paramaterDict: paramaterDict, onSuccess: { memberLists in
                    
                    self.appDelegate.hideIndicator()
                    
                    if(memberLists.responseCode == InternetMessge.kSuccess)
                    {
                        self.appDelegate.hideIndicator()
                        
                        if self.isFrom == "Modify" || self.isFrom == "View"
                        {
                            if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView
                            {
                                self.appDelegate.hideIndicator()
                                succesView.delegate = self
                                if self.isOnlyFrom == "EventsModify"
                                {
                                    succesView.isFrom = "EventTennisUpdate"
                                    
                                }
                                else
                                {
                                    succesView.isFrom = "GolfUpdate"
                                    
                                }
                                succesView.imgUrl = memberLists.imagePath ?? ""
                                succesView.modalTransitionStyle   = .crossDissolve;
                                succesView.modalPresentationStyle = .overCurrentContext
                                self.present(succesView, animated: true, completion: nil)
                                
                            }
                            
                        }
                        else
                        {
                            if let share = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ThanksVC") as? ThanksVC
                            {
                                self.appDelegate.requestFrom = "Golf"
                                
                                let dateFormatterToSend = DateFormatter()
                                dateFormatterToSend.dateFormat = "MM/dd/yyyy"
                                
                                let isoDate = self.reservationRemindDate
                                
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                                let date = dateFormatter.date(from:isoDate!)!
                                
                                share.remindDate = dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: -((self.golfSettings?.minDaysInAdvance)!) , to: date)!)
                                share.delegate = self
                                share.palyDate = self.reservationRequestDate
                                share.modalTransitionStyle   = .crossDissolve;
                                share.modalPresentationStyle = .overCurrentContext
                                if self.isFirstComeFirstServe {
                                    share.isFrom = "FCFS"
                                } else {
                                    share.isFrom = ""
                                }
                                self.present(share, animated: true, completion: nil)
                                
                            }
                            
                        }
                        
                    }
                    else
                    {
                        self.appDelegate.hideIndicator()
                        
                        if memberLists.details?.count == 0
                        {
                            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:memberLists.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                            
                        }
                        else
                        {
                            if memberLists.responseCode == InternetMessge.kSuccess
                            {
                                
                            }
                            else if memberLists.details == nil
                            {
                                SharedUtlity.sharedHelper().showToast(on:
                                        self.view, withMeassge: memberLists.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                                
                            }
                            else
                            {
                                if let impVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ImpotantContactsVC") as? ImpotantContactsVC
                                {
                                    impVC.importantContactsDisplayName = memberLists.brokenRules?.fields?[0] ?? ""
                                    impVC.isFrom = "Reservations"
                                    impVC.arrList = memberLists.details!
                                    impVC.modalTransitionStyle   = .crossDissolve;
                                    impVC.modalPresentationStyle = .overCurrentContext
                                    self.present(impVC, animated: true, completion: nil)
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                },onFailure: { error  in
                    self.appDelegate.hideIndicator()
                    SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
                    
                })
                
            }
            else
            {//Occurs if hard rule exists
                //TODO:- Remove after V2.9 is approved in testing
                //self.clearSelectedCoursePreference()
            }
            
        }

        
        //Moved the logic to completion handler
        /*
        self.golfDuplicates()
            
        var paramaterDict:[String: Any] = [
            "Content-Type":"application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            "RequestId": requestID ?? "",
            "ReservationRequestDate": reservationRequestDate ?? "",
            "ReservationRequestTime": txtPreferredTeeTime.text ?? "",
            "GroupDetails": groupList,
            "GroupCount": Int(self.lblGroupNumber.text!) ?? 0,
            "GameType": gameType ?? 9,
            "LinkGroup": switchLinkGroup.isOn ? 1 : 0,
            "Earliest": txtEarliestTeeTime.text ?? "",
            "PreferedSpaceDetailId": preferenceList,
            "NotPreferedSpaceDetailId": notPreferenceList
        ]
        
        var arrWaitlistGroupDetails = [[String : Any]]()
        
        for waitlistedGoup in self.arrWaitlistGropus
        {
            if let waitlistDict = waitlistedGoup.toDict()
            {
                arrWaitlistGroupDetails.append(waitlistDict)
            }
        }
        
        paramaterDict.updateValue(arrWaitlistGroupDetails, forKey: "GroupStatusDetails")
        
        print(paramaterDict)
        APIHandler.sharedInstance.saveTeeTime(paramaterDict: paramaterDict, onSuccess: { memberLists in
                self.appDelegate.hideIndicator()
                
                
                if(memberLists.responseCode == InternetMessge.kSuccess)
                {
                    self.appDelegate.hideIndicator()
                    
                    
                    if self.isFrom == "Modify" || self.isFrom == "View"{

                        
                        if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView {
                            self.appDelegate.hideIndicator()
                            succesView.delegate = self
                            if self.isOnlyFrom == "EventsModify"{
                                succesView.isFrom = "EventTennisUpdate"
                            }else{
                                succesView.isFrom = "GolfUpdate"
                            }
                             succesView.imgUrl = memberLists.imagePath ?? ""
                            succesView.modalTransitionStyle   = .crossDissolve;
                            succesView.modalPresentationStyle = .overCurrentContext
                            self.present(succesView, animated: true, completion: nil)
                        }

                        
                    }else{
                    
                    if let share = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ThanksVC") as? ThanksVC {
                        self.appDelegate.requestFrom = "Golf"
                        
                        let dateFormatterToSend = DateFormatter()
                        dateFormatterToSend.dateFormat = "MM/dd/yyyy"
                        
                        let isoDate = self.reservationRemindDate
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                        let date = dateFormatter.date(from:isoDate!)!
                        
                        share.remindDate = dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: -((self.golfSettings?.minDaysInAdvance)!) , to: date)!)
                        share.delegate = self
                        share.palyDate = self.reservationRequestDate
                        share.modalTransitionStyle   = .crossDissolve;
                        share.modalPresentationStyle = .overCurrentContext
                        self.present(share, animated: true, completion: nil)
                    }
                    
                    }
                }else{
                    self.appDelegate.hideIndicator()
                    
                    
                    if memberLists.details?.count == 0 {
                        SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:memberLists.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                    }else{
                        if memberLists.responseCode == InternetMessge.kSuccess{
                            
                        }else if memberLists.details == nil{
                            SharedUtlity.sharedHelper().showToast(on:
                                self.view, withMeassge: memberLists.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                            
                        }else{
                            if let impVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ImpotantContactsVC") as? ImpotantContactsVC {
                                impVC.importantContactsDisplayName = memberLists.brokenRules?.fields?[0] ?? ""
                                impVC.isFrom = "Reservations"
                                impVC.arrList = memberLists.details!
                                impVC.modalTransitionStyle   = .crossDissolve;
                                impVC.modalPresentationStyle = .overCurrentContext
                                self.present(impVC, animated: true, completion: nil)
                            }
                        }
                    }
                }
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
            
//        else{
//
//            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
//
//        }
        
         
         
        */
        //Cobalt Pha0010644 -- End
    }
    
    
    @IBAction func cancelRequestClicked(_ sender: Any) {
        
        //Added on 4th July 2020 V2.2
        //added roles and privilages changes
        //since not allowed is handled before coming to this screen not need to check for it.
        switch self.accessManager.accessPermision(for: .golfReservation) {
        case .view:
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        default:
            break
        }
        
        if let cancelViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController {
            if isOnlyFrom == "EventsModify"{
                cancelViewController.isFrom = "EventGolfCancelRequest"
                cancelViewController.cancelFor = self.requestType == .reservation ? .GolfReservation : .Events
            }else{
                cancelViewController.isFrom = "GolfCancel"
                cancelViewController.cancelFor = .GolfReservation
            }
            cancelViewController.eventID = requestID
            cancelViewController.numberOfTickets = self.partySize == 0 ? "" : "\(self.partySize)"
            self.navigationController?.pushViewController(cancelViewController, animated: true)
        }
    }
    
    @IBAction func golfClicked(_ sender: Any) {
        
        let restarantpdfDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
        restarantpdfDetailsVC.pdfUrl = self.golfSettings?.golfPolicy ?? ""
        restarantpdfDetailsVC.restarantName = self.appDelegate.masterLabeling.golf_policy!

        self.navigationController?.pushViewController(restarantpdfDetailsVC, animated: true)
    }
    
    func cancelReservationRequest(){
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                "ReservationRequestId": "",
                "ConfirmedReservationID": self.confirmedReservationID!,
                "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!,
                ]
            
//            print(paramaterDict)
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.getRequestCancel(paramater: paramaterDict , onSuccess: { response in
                self.appDelegate.hideIndicator()
                if(response.responseCode == InternetMessge.kSuccess){
                    self.appDelegate.hideIndicator()
                    
                    
                    if self.arrGroup1.count == 0 {
                        self.arrGroup1 = self.arrGroup2
                        self.arrRegReqID1 = self.arrRegReqID2
                        
                        self.arrGroup2 = self.arrGroup3
                        self.arrRegReqID2 = self.arrRegReqID3
                        
                        self.arrGroup3 = self.arrGroup4
                        self.arrRegReqID3 = self.arrRegReqID4
                        
                        self.arrGroup4.removeAll()
                        self.arrRegReqID4.removeAll()
                        
                    }else if self.arrGroup2.count == 0 {
                        self.arrGroup2 = self.arrGroup3
                        self.arrRegReqID2 = self.arrRegReqID3
                        
                        self.arrGroup3 = self.arrGroup4
                        self.arrRegReqID3 = self.arrRegReqID4
                        
                        self.arrGroup4.removeAll()
                        self.arrRegReqID4.removeAll()
                    }else if self.arrGroup3.count == 0 {
                        self.arrGroup3 = self.arrGroup4
                        self.arrRegReqID3 = self.arrRegReqID4
                        
                        self.arrGroup4.removeAll()
                        self.arrRegReqID4.removeAll()
                        
                    }else if self.arrGroup4.count == 0 {

                    }
                    

                    self.lblGroupNumber.text = String(format: "%02d", self.arrGroupList.count)
                    
                    if(self.lblGroupNumber.text == "01"){
                        self.heightViewGroups.constant = 132
                        self.lblLinkGroupsReg.isHidden = true
                        self.switchLinkGroup.isHidden = true
                        self.switchLinkGroup.isOn = false
                    }
                    
                    self.groupsTableview.reloadData()
                    self.modifyTableview.reloadData()
                    
                    
                }
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
    
}

extension GolfRequestTeeTimeVC : ModifyDelegate {
    func deleteButtonClicked(cell: ModifyRequestHeaderView) {
        self.confirmedReservationID = self.arrTeeTimeDetails[0].groupDetails?[cell.tag].confirmedReservationID
        
        let alertController = UIAlertController(title: "", message: self.appDelegate.masterLabeling.aREYOUSURE_YOUWANTTO_REMOVE_GROUPFROM_REQUEST ?? "" , preferredStyle: .alert)
        
        // Create the actions
        let yesAction = UIAlertAction(title: self.appDelegate.masterLabeling.Yes, style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.selectedSection = cell.tag
            if cell.tag == 0 {
                self.arrGroup1.removeAll()
                self.arrRegReqID1.removeAll()
            }
            else if  cell.tag == 1 {
                self.arrGroup2.removeAll()
                self.arrRegReqID2.removeAll()
            }else if  cell.tag == 2 {
                self.arrGroup3.removeAll()
                 self.arrRegReqID3.removeAll()
            }else if  cell.tag == 3 {
                self.arrGroup4.removeAll()
                self.arrRegReqID4.removeAll()
            }
            
            if let groupNumber = self.arrTeeTimeDetails[0].groupDetails?[cell.tag].playerGroup
            {
                self.arrWaitlistGropus.removeAll {$0.GroupNo == groupNumber}
            }
            
            
            self.arrGroupList.remove(at: cell.tag)
            self.arrTeeTimeDetails[0].groupDetails?.remove(at: cell.tag)
//            self.arrGroup1.removeAll()
//            self.arrGroup2.removeAll()
//            self.arrGroup3.removeAll()
//            self.arrGroup4.removeAll()
            
            self.cancelReservationRequest()
            
            
        }
        let noAction = UIAlertAction(title: self.appDelegate.masterLabeling.No, style: UIAlertActionStyle.default) {
            UIAlertAction in
            
        }
        // Add the actions
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        //   dismiss(animated: true, completion: nil)

    }
    
    func addNewButtonClicked(cell: ModifyRequestHeaderView) {
        
        if self.addNewMeber == true{
            self.addNewPopupModifyCase(cell: cell)
        }else{
            self.golfDuplicates()
            self.memberValidattionAPI({ [unowned self] (status) in
                if status == true{
                    self.addNewPopupModifyCase(cell: cell)
                }
            })
        }
      
    }
  
    func addNewPopupModifyCase(cell: ModifyRequestHeaderView)
    {
        
        self.isMultiSelectionClicked = false
        selectedSection = cell.tag
        
        let addNewView : UIView!
        //Modified by kiran V2.5 -- GATHER0000606 -- modified to change height based on no of options
        //GATHER0000606 -- Start
        let optionsHeight = self.appDelegate.addRequestOpt_Golf.count * 50
        addNewView = UIView(frame: CGRect(x: 100, y: 0, width: 180, height: optionsHeight/*146*/))
        
        addNewPopoverTableView = UITableView(frame: CGRect(x: 0, y: 5, width: 180, height: optionsHeight/*146*/))
        //GATHER0000606 -- End
        addNewView.addSubview(addNewPopoverTableView!)
        
        
        addNewPopoverTableView?.dataSource = self
        addNewPopoverTableView?.delegate = self
        addNewPopoverTableView?.bounces = false
        //Modified by kiran V3.2 -- ENGAGE0012667 -- tableview on popup list height fix
        //ENGAGE0012667 -- Start
        self.addNewPopoverTableView?.sectionHeaderHeight = 0
        //ENGAGE0012667 -- End
        addNewPopover = Popover()
        addNewPopover?.arrowSize = CGSize(width: 0.0, height: 0.0)
        let point = cell.btnAddNew.convert(cell.btnAddNew.center , to: appDelegate.window)
        addNewPopover?.sideEdge = 4.0
        
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
       
//        if self.addNewMeber == true{
        
            if arrTeeTimeDetails[0].buttonTextValue == "3" || arrTeeTimeDetails[0].buttonTextValue == "4" || self.arrTeeTimeDetails[0].buttonTextValue == "5"{
                let pointt = CGPoint(x: self.view.bounds.width - 31, y: point.y - 190)
                if point.y > height - 20{
                    addNewPopover?.popoverType = .up
                    addNewPopover?.show(addNewView, point: pointt)
                    
                }else{
                    addNewPopover?.show(addNewView, point: pointt)
                    
                }
                
                
            }else{
                let pointt = CGPoint(x: self.view.bounds.width - 31, y: point.y - 105)
                if point.y > height - 170{
                    addNewPopover?.popoverType = .up
                    addNewPopover?.show(addNewView, point: pointt)
                    
                }else{
                    addNewPopover?.show(addNewView, point: pointt)
                    
                }
                
                
            }
//        }
        
    }
    
    func waitListClicked(cell: ModifyRequestHeaderView)
    {
        //Added on 4th Septmeber 2020 V2.3
        //Button should not be clickable when in view only.added as fail-safe.
        if self.isViewOnly || self.isFrom == "View"
        {
            return
        }
        
        //Added 1 because group numbers start from 1 but setions start from 0
        self.waitlistGroup = cell.tag
        let waitlistPickerView = TimePickerView.init(frame: self.view.bounds)
                     
        waitlistPickerView.lblTitle.text = self.appDelegate.masterLabeling.add_To_Waitlist
        waitlistPickerView.lblTopPickerTitle.text = self.appDelegate.masterLabeling.earliest_tee_time
        waitlistPickerView.lblBottomPIckerTitle.text = self.appDelegate.masterLabeling.latest_Tee_Time
                   
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "hh:mm a"
        
        waitlistPickerView.textFieldTopPicker.text = self.golfSettings?.fromTime
        waitlistPickerView.textFieldBottomPicker.text = self.golfSettings?.fromTime
        
        waitlistPickerView.minLimit = dateFormatter.date(from: self.golfSettings!.fromTime!)
        waitlistPickerView.maxLimit = dateFormatter.date(from: self.golfSettings!.toTime!)
        
        waitlistPickerView.runLatestEarliestComparision = true
        waitlistPickerView.pickerType = .time
        waitlistPickerView.timeInterval = self.golfSettings!.timeInterval!
        waitlistPickerView.dateFormat = "hh:mm a"
        waitlistPickerView.delegate = self
        self.view.addSubview(waitlistPickerView)
        
    }
    
    
}

//MARK:- View only funcitionality related functions
extension GolfRequestTeeTimeVC
{
    private func disableActions()
    {
        if self.isViewOnly
        {
            self.shouldDisableAllActions(true)
            self.btnRequest.setTitle(self.appDelegate.masterLabeling.bACK, for: .normal)
            
        }
    }
    
    /// Disables all the actions except save/ submit/register. that button will act as back button
    private func shouldDisableAllActions(_ bool : Bool)
    {
        self.btnDecreaseTickets.isUserInteractionEnabled = !bool
        self.btnIncreaseTicket.isUserInteractionEnabled = !bool
        self.topView.isUserInteractionEnabled = !bool
        self.calenderView.isUserInteractionEnabled = !bool
        self.timeView.isUserInteractionEnabled = !bool
        self.nineHolesView.isUserInteractionEnabled = !bool
        self.eighteenHolesView.isUserInteractionEnabled = !bool
        self.courseView.isUserInteractionEnabled = !bool
        self.viewGroups.isUserInteractionEnabled = !bool
        self.groupsTableview.isUserInteractionEnabled = !bool
        self.modifyTableview.isUserInteractionEnabled = !bool
        self.btnMultiSelect.isUserInteractionEnabled = !bool
        self.btnCancelRequest.isHidden = bool
        self.heightCancelRequest.constant = bool ? -20 : 37
    }
    
}


//MARK:- Time Picker View delegate
extension GolfRequestTeeTimeVC : TimePickerViewDelegate
{
    func didSelectTime(firstTime: String?, secondTime: String?)
    {
        guard let earliestTime = firstTime , let latestTime = secondTime,let sectionNumber = self.waitlistGroup else{
            self.waitlistGroup = nil
            return
        }
        self.waitlistGroup = nil
        
        guard let groupNumber = self.arrTeeTimeDetails[0].groupDetails?[sectionNumber].playerGroup else{
            return
        }
        
        if self.arrWaitlistGropus.contains(where: { $0.GroupNo == groupNumber})
        {
            if let index = self.arrWaitlistGropus.firstIndex(where: {$0.GroupNo == groupNumber})
            {
                self.arrWaitlistGropus[index].WaitlistEarliestTime = earliestTime
                self.arrWaitlistGropus[index].WaitlistLatestTime = latestTime
            }
        }
        else
        {
            let groupReservationID = self.arrTeeTimeDetails[0].groupDetails?[sectionNumber].confirmedReservationID
            
            let waitlistGroup = WatlistTeeTime.init(reservationID: groupReservationID ?? "", earliestTime: earliestTime, latestTime: latestTime, status: "WAITLIST", no: groupNumber)
            self.arrWaitlistGropus.append(waitlistGroup)
            self.arrTeeTimeDetails[0].groupDetails?[sectionNumber].status = self.appDelegate.masterLabeling.waitlist_Value
            self.arrTeeTimeDetails[0].groupDetails?[sectionNumber].color = self.appDelegate.masterLabeling.waitlist_Colorcode
            self.arrTeeTimeDetails[0].groupDetails?[sectionNumber].buttonTextValue = "4"
        }
        
        self.modifyTableview.reloadData()
        
    }
    
    func didCancel() {
        self.waitlistGroup = nil
    }
}


//MARK:- Custom Methods
extension GolfRequestTeeTimeVC
{
    //Added by kiran V2.5 -- GATHER0000606 -- Logic which indicates if add member button should be displayed or not
    //GATHER0000606 -- Start
    ///Indicates if add member button should be shown. only applicable for single member add not multi select
    private func shouldHideMemberAddOptions() -> Bool
    {
        return !(self.appDelegate.addRequestOpt_Golf.count > 0)
    }
    //GATHER0000606 -- End
    
    //Added by kiran v2.9 -- Cobalt Pha0010644 -- Function to show Hard & Soft message details of courses when date is changed
    //Cobalt Pha0010644 -- Start
    //NOTE:- This returns the use action with the alert type. okAction is used for hard alert,soft alert and a case where no restriction is present(returns none in ok action if not restricted.). No Action is only used for solf alert.
    private func showCourseAlert(preferredCourse : String,okAction : @escaping ((GolfCourseAlertType)->()) ,noAction : @escaping ((GolfCourseAlertType)->()))
    {
        //Note:- Any change in logic has to be done in showHardRule function as well.
        
        if let alertSettings = self.golfSettings?.courseDetails?.first(where: { $0.id == preferredCourse})?.golfCourseAlert
        {
            let selectedTime = (self.txtPreferredTeeTime.text ?? "").date(format: DateFormats.timehma)!
            //None indicates no alert is shown. i.e., not restricted
            var alertType : GolfCourseAlertType = .none
            var alertMessage : String = ""
            
            for setting in alertSettings
            {
                let startTime = (setting.startTime ?? "").date(format: DateFormats.timehma)!
                let endTime = (setting.endTime ?? "").date(format: DateFormats.timehma)!
                
                if (Calendar.current.compare(selectedTime, to: startTime, toGranularity: .minute) == .orderedDescending || Calendar.current.compare(selectedTime, to: startTime, toGranularity: .minute) == .orderedSame) && (Calendar.current.compare(selectedTime, to: endTime, toGranularity: .minute) == .orderedAscending || Calendar.current.compare(selectedTime, to: endTime, toGranularity: .minute) == .orderedSame)
                {
                    alertType = (setting.isShowHardRule == 1) ? .hard : .soft
                    alertMessage = setting.alertTitle ?? ""
                    break
                }
                
            }
            
            switch alertType
            {
            case .hard:
                
                let okAction = UIAlertAction.init(title: self.appDelegate.masterLabeling.golfAdvance_Ok ?? "", style: .default) { action in
                    okAction(alertType)
                }
                CustomFunctions.shared.showAlert(title: self.appDelegate.masterLabeling.golfAdvanceTitle ?? "", message: alertMessage, on: self, actions: [okAction])
            case .soft:
                let okAction = UIAlertAction.init(title: self.appDelegate.masterLabeling.golfAdvance_Yes ?? "", style: .default) { action in
                    okAction(alertType)
                }
                
                let noAction = UIAlertAction.init(title: self.appDelegate.masterLabeling.golfAdvance_No ?? "", style: .default) { action in
                    noAction(alertType)
                }
                CustomFunctions.shared.showAlert(title: self.appDelegate.masterLabeling.golfAdvanceTitle ?? "", message: alertMessage, on: self, actions: [okAction,noAction])
            case .none:
                okAction(alertType)
            }
            
        }
        else
        {
            okAction(.none)
        }
        
    }
    
    //NOte:- Returns true if no hard rle is present otherwise returns false.
    private func showHardRule(preferredCourse : String, success : @escaping ((Bool)->()))
    {
        //Note:- Any change in logic has to be done in showCourseAlert function as well.
        if let alertSettings = self.golfSettings?.courseDetails?.first(where: { $0.id == preferredCourse})?.golfCourseAlert
        {
            let selectedTime = (self.txtPreferredTeeTime.text ?? "").date(format: DateFormats.timehma)!
            //None indicates no alert is shown. i.e., not restricted
            var alertType : GolfCourseAlertType = .none
            var alertMessage : String = ""
            
            for setting in alertSettings
            {
                let startTime = (setting.startTime ?? "").date(format: DateFormats.timehma)!
                let endTime = (setting.endTime ?? "").date(format: DateFormats.timehma)!
                
                if (Calendar.current.compare(selectedTime, to: startTime, toGranularity: .minute) == .orderedDescending || Calendar.current.compare(selectedTime, to: startTime, toGranularity: .minute) == .orderedSame) && (Calendar.current.compare(selectedTime, to: endTime, toGranularity: .minute) == .orderedAscending || Calendar.current.compare(selectedTime, to: endTime, toGranularity: .minute) == .orderedSame)
                {
                    alertType = (setting.isShowHardRule == 1) ? .hard : .soft
                    alertMessage = setting.alertTitle ?? ""
                    break
                }
                
            }
            
            switch alertType
            {
            case .hard:
                
                let okAction = UIAlertAction.init(title: self.appDelegate.masterLabeling.golfAdvance_Ok ?? "", style: .default) { action in
                    success(false)
                }
                CustomFunctions.shared.showAlert(title: self.appDelegate.masterLabeling.golfAdvanceTitle ?? "", message: alertMessage, on: self, actions: [okAction])
            case .soft,.none:
                success(true)
            }
            
        }
        else
        {
            success(true)
        }
    }
    
    private func clearSelectedCoursePreference()
    {
        self.selectedPreference = -1
        self.arrPreferredCource.removeAll()
        self.courceCollectionView.reloadData()
    }
    //Cobalt Pha0010644 -- End
}
