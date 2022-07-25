//
//  CourtRequestVC.swift
//  CSSI
//
//  Created by apple on 5/9/19.
//  Copyright © 2019 yujdesigns. All rights reserved.

import UIKit
import FSCalendar
import Popover
class CourtRequestVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, guestViewControllerDelegate, RequestCellDelegate,MemberViewControllerDelegate, RegistrationCell, ModifyRegistration, closeModalView,closeUpdateSuccesPopup {
    func AddGuestChildren(selecteArray: [RequestData]) {
        
    }
    
    
    func closeUpdateSuccessView() {
        self.dismiss(animated: true, completion: nil)
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for popToViewController in viewControllers {
            if self.appDelegate.closeFrom == "TennisUpdate" {
                
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
    
    
    func threeDotsClickedToMoveGroup(cell: CustomNewRegCell) {
        
    }
    func ModifyThreeDotsClicked(cell: ModifyRegCustomCell) {
        
    }
    func addMemberDelegate() {
        self.dismiss(animated: true, completion: nil)
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for popToViewController in viewControllers {
            if popToViewController is CourtTimesViewController {
                //Modified by kiran -- ENGAGE0011177 -- V2.5 -- commented as its causing black bar issue on nav bar.
                //self.navigationController?.navigationBar.isHidden = false
                self.navigationController!.popToViewController(popToViewController, animated: true)
                
            }
        }
        
    }
    
    @IBOutlet weak var modifyTime: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var heightTimeView: NSLayoutConstraint!
    @IBOutlet weak var viewDuration: UIView!
    @IBOutlet weak var heightCalendar: NSLayoutConstraint!
    @IBOutlet weak var viewCalendar: UIView!
    @IBOutlet weak var btnModifyDate: UIButton!
    
    @IBOutlet weak var heightSelectRequestDate: NSLayoutConstraint!
    @IBOutlet weak var lblConfirmNumberModify: UILabel!
    @IBOutlet weak var btnAddPlayer: UIButton!
    @IBOutlet weak var btnCancelReservation: UIButton!
    @IBOutlet weak var txtPlayerText: UITextField!
    @IBOutlet weak var heightCancelReservation: NSLayoutConstraint!
    @IBOutlet weak var captainViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var heightTypeOfCalendar: NSLayoutConstraint!
    @IBOutlet weak var requestButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var modifyView: UIView!
    @IBOutlet weak var modifyViewHeight: NSLayoutConstraint!
    @IBOutlet weak var modifyCourtTableView: UITableView!
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblSelectDates: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var btnSingleDay: UIButton!
    @IBOutlet weak var btnMultiday: UIButton!
    @IBOutlet weak var myCalendar: FSCalendar!
    @IBOutlet weak var lblCourtTimes: UILabel!
    //@IBOutlet weak var lblNotLaterThan: UILabel!
   // @IBOutlet weak var lblNotearlierthan: UILabel!
    @IBOutlet weak var txtCourtTime: UITextField!
//    @IBOutlet weak var tctNotLaterThan: UITextField!
//    @IBOutlet weak var txtNotEarlierthan: UITextField!
    @IBOutlet weak var lblBottomUserName: UILabel!
    @IBOutlet weak var btnTennisPolicy: UIButton!
    @IBOutlet weak var btnRequest: UIButton!
    @IBOutlet weak var txtComments: UITextView!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var viewRequestBall: UIView!
    @IBOutlet weak var btnRequestBall: UIButton!
    @IBOutlet weak var lblPlayers: UILabel!
    @IBOutlet weak var viewYearAndMonth: UIView!
    
    @IBOutlet weak var tableViewheight: NSLayoutConstraint!
    @IBOutlet weak var lblCaptainName: UILabel!
    @IBOutlet weak var btnSingle: UIButton!
    @IBOutlet weak var btnDoubles: UIButton!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var btnThirtyMin: UIButton!
    @IBOutlet weak var btnSixtyMin: UIButton!
    @IBOutlet weak var btnNintyMin: UIButton!
    
    @IBOutlet weak var groupTableView: UITableView!
    
    //Multiple selection of members
    @IBOutlet weak var btnMultiSelection: UIButton!
    
    @IBOutlet weak var viewMultiSelect: UIView!
    @IBOutlet weak var instructionsTableView: SelfSizingTableView!
    @IBOutlet weak var instructionsTableViewHeight: NSLayoutConstraint!
    ///Flag to check if multiple selection button is  clicked
    private var isMultiSelectionClicked = false
    
    fileprivate var dob:Date? = nil
    var tennisSettings : TennisSettings?
    var addNewPopoverTableView: UITableView? = nil
    var addNewPopover: Popover? = nil
    var gameType : String?
    var durationType : String?
    var partyCount : String = ""
    var modifyCount : Int = 0
    var minTime: String?
    var maxTime: String?
    var currentTime: String?
    var currentMonth: Date?

    var playType : String?
    var arrPlayers = [RequestData]()
    var arrTempPlayers = [RequestData]()

    var arrRegReqID = [String]()
    var partyList = [Dictionary<String, Any>]()
    var ballMachine : Int?
    var isFrom : String?
    var isOnlyFrom: String?
    var requestID : String?
    var arrTeeTimeDetails = [RequestTeeTimeDetail]()
//    var captainName : String?
//    var requestClear : String?
    var datePicker3 = UIDatePicker()
    var datePicker2 = UIDatePicker()
    var datePicker1 = UIDatePicker()

    var reservationRequestDate : String?
    var reservationRemindDate: String?
    var reservationRequestDates = [String]()
    var selectedDates = [Dictionary<String, Any>]()
    var nameOfMonth : String?
    var dateAndTimeDromServer = Date()

    var selectedIndex : Int?
    var selectedSection : Int?
    var selectedCellText : String?
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var firstTime: Bool?
    var addNewMeber: Bool?
    
    ///Height of multiselect button view for layout
    ///
    /// Note : if the layout is changed make sure to change this accordngly
    private var viewMultiSelectionHeight : CGFloat = 37/*Top constraint */+ 31.13/*Height of button*/
    
    var requestType : RequestType?
    
    private var arrInstructions = [Instruction]()

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
    fileprivate let formatterMonth: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        return formatter
    }()

    ///Tickets Available for adding members
    ///
    /// Calculated by identifying then number of occupied tickets  and substracting them from max tickets
    private var availableTickets : Int = 0
    
    ///When True disables the tap actions
    ///
    /// Note: This will just disbale the user interactions and hides cancel and submit buttons and adds back button.everything else will work based on the other variables passed while initializing this controller.
    var isViewOnly = false
    
    private var partySize : Int = 0
    
    //Added on 4th July 2020 V2.2
    private let accessManager = AccessManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Added on 4th July 2020 V2.2
        //added roles and privilages changes
        //since not allowed is handled before coming to this screen not need to check for it.
        switch self.accessManager.accessPermision(for: .tennisReservation) {
        case .view:
            if !self.isViewOnly , self.isFrom != "View" , let message = self.appDelegate.masterLabeling.role_Validation2 , message.count > 0
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
        
        self.addNewMeber = false
        // Do any additional setup after loading the view.
        self.lblSelectDates.text = self.appDelegate.masterLabeling.tennis_request_date
        self.lblCourtTimes.text = self.appDelegate.masterLabeling.court_time
      //  self.lblNotearlierthan.text = self.appDelegate.masterLabeling.not_earlier_than
       // self.lblNotLaterThan.text = self.appDelegate.masterLabeling.not_later_than
        self.lblDuration.text = self.appDelegate.masterLabeling.duration_colon
        self.lblComments.text = self.appDelegate.masterLabeling.comments
        
        self.lblCaptainName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,UserDefaults.standard.string(forKey: UserDefaultsKeys.captainName.rawValue) ?? "")
        
        self.lblPlayers.text = self.appDelegate.masterLabeling.players
        self.btnRequestBall.setTitle(self.appDelegate.masterLabeling.request_ball_machine!, for: UIControlState.normal)
        self.btnTennisPolicy.setTitle(self.appDelegate.masterLabeling.tennis_policy!, for: UIControlState.normal)
        self.lblBottomUserName.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)

        btnSingle.tag = 1
        btnDoubles.tag = 2
        
       txtCourtTime.delegate = self
        
        btnCancelReservation.backgroundColor = .clear
        btnCancelReservation.layer.cornerRadius = 18
        btnCancelReservation.layer.borderWidth = 1
        btnCancelReservation.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        btnCancelReservation .setTitle(self.appDelegate.masterLabeling.cancel_reservation, for: UIControlState.normal)
        
        btnMultiday.backgroundColor = .clear
        btnMultiday.layer.cornerRadius = 22
        btnMultiday.layer.borderWidth = 1
        
        btnMultiday.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        
        btnSingleDay.layer.cornerRadius = 22
        btnSingleDay.layer.borderWidth = 1
        btnSingleDay.layer.borderWidth = 1
        btnSingleDay.layer.borderColor = UIColor.white.cgColor

        btnNintyMin.layer.cornerRadius = 6
        btnNintyMin.layer.borderWidth = 1
        btnNintyMin.layer.borderWidth = 0.25
        btnNintyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
        btnNintyMin.backgroundColor = hexStringToUIColor(hex: "F47D4C")

        btnThirtyMin.layer.cornerRadius = 6
        btnThirtyMin.layer.borderWidth = 1
        btnThirtyMin.layer.borderWidth = 0.25
        btnThirtyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
        btnThirtyMin.backgroundColor = .clear
        btnThirtyMin.setTitleColor(hexStringToUIColor(hex: "695B5E"), for: UIControlState.normal)
        
        btnSixtyMin.layer.cornerRadius = 6
        btnSixtyMin.layer.borderWidth = 1
        btnSixtyMin.layer.borderWidth = 0.25
        btnSixtyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
        btnSixtyMin.backgroundColor = .clear
        btnSixtyMin.setTitleColor(hexStringToUIColor(hex: "695B5E"), for: UIControlState.normal)

        txtPlayerText.text = self.appDelegate.masterLabeling.add_member_or_guest

        txtComments.layer.cornerRadius = 6
        txtComments.layer.borderWidth = 1
        txtComments.layer.borderWidth = 0.25
        txtComments.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
        
        
        viewRequestBall.layer.shadowColor = hexStringToUIColor(hex: "000000").cgColor
        viewRequestBall.layer.shadowOpacity = 0.1
        viewRequestBall.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewRequestBall.layer.shadowRadius = 2
        
        if self.appDelegate.arrReqDayType.count == 0{}else{
        self.btnSingleDay.setTitle(self.appDelegate.arrReqDayType[0].name, for: UIControlState.normal)
        self.btnMultiday.setTitle(self.appDelegate.arrReqDayType[1].name, for: UIControlState.normal)
        }
       self.txtPlayerText.text = self.appDelegate.masterLabeling.add_member_or_guest
        
  
        
        self.myCalendar.allowsMultipleSelection = false
        self.myCalendar.weekdayHeight = 50
        self.myCalendar.delegate = self
        self.myCalendar.placeholderType = .none
        self.myCalendar.dataSource = self


        btnDoubles.setImage(UIImage(named : "Group 2384"), for: UIControlState.normal)
        btnSingle.setImage(UIImage(named : "Rectangle 2117"), for: UIControlState.normal)
        
        gameType = "Singleday"
        durationType = "90"
        partyCount = "4"
        playType = "Doubles"
        ballMachine = 0
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
        
        
        
        
        
        if isFrom == "Modify"{
            self.captainViewHeight.constant = 80 + ((isFrom == "Modify" || isFrom == "View") ? 0 : self.viewMultiSelectionHeight)
            self.lblPlayers.isHidden = true
            self.modifyView.isHidden = false
            self.groupTableView.isHidden = true
            self.modifyCourtTableView.isHidden = false

            self.btnCancelReservation.isHidden = false
            self.heightCancelReservation.constant = 37
            self.lblConfirmNumberModify.isHidden = false
            self.heightTypeOfCalendar.constant = 0
            self.btnSingleDay.isHidden = true
            self.btnMultiday.isHidden = true
            self.heightSelectRequestDate.constant = 84
            self.btnModifyDate.isHidden = false
            self.modifyTime.isHidden = true

            btnRequest.backgroundColor = .clear
            btnRequest.layer.cornerRadius = 18
            btnRequest.layer.borderWidth = 1
            btnRequest.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
            btnRequest .setTitle(self.appDelegate.masterLabeling.Save, for: UIControlState.normal)
            self.btnRequest.setStyle(style: .outlined, type: .primary)
        }
        else{
            self.captainViewHeight.constant = 110 + ((isFrom == "Modify" || isFrom == "View") ? 0 : self.viewMultiSelectionHeight)
            self.lblPlayers.isHidden = false
            self.viewRequestBall.isHidden = false
            self.modifyView.isHidden = true
            self.groupTableView.isHidden = false
            self.modifyCourtTableView.isHidden = true
            self.btnCancelReservation.isHidden = true
            self.heightCancelReservation.constant = -20
            self.lblConfirmNumberModify.isHidden = true
            self.heightTypeOfCalendar.constant = 80
            self.btnSingleDay.isHidden = false
            self.btnMultiday.isHidden = false
            self.heightSelectRequestDate.constant = 42
            self.btnModifyDate.isHidden = true
            self.modifyTime.isHidden = true

            btnRequest.backgroundColor = hexStringToUIColor(hex: "F37D4A")
            btnRequest.layer.cornerRadius = 18
            btnRequest.layer.borderWidth = 1
            btnRequest.layer.borderColor = UIColor.clear.cgColor
            btnRequest .setTitle(self.appDelegate.masterLabeling.rEQUEST, for: UIControlState.normal)
            btnRequest.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.btnRequest.setStyle(style: .contained, type: .primary)
            
            let captainInfo = CaptaineInfo.init()
            captainInfo.setCaptainDetails(id: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "", name: UserDefaults.standard.string(forKey: UserDefaultsKeys.captainName.rawValue) ?? "", firstName: UserDefaults.standard.string(forKey: UserDefaultsKeys.firstName.rawValue) ?? "", order: 1, memberID: UserDefaults.standard.string(forKey: UserDefaultsKeys.memberID.rawValue) ?? "", parentID: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "", profilePic: UserDefaults.standard.string(forKey: UserDefaultsKeys.userProfilepic.rawValue) ?? "")
            
            for _ in 0..<Int(self.partyCount)! {
               
                    arrPlayers.append(RequestData())
                
            }
            
            let selectedObject = captainInfo
            selectedObject.isEmpty = false
            arrPlayers.remove(at: 0)
            arrPlayers.insert(selectedObject, at: 0)

        }
        
        self.tennisSettings  = self.appDelegate.arrTennisSettings
        
        //Multi Selection button hide/show
        //Modified by kiran V2.5 -- GATHER0000606 -- added hiding multiselect button when multi select options are empty.Hiding add button when member selection option is empty
        //GATHER0000606 -- Start
        self.viewMultiSelect.isHidden = (isFrom == "Modify" || isFrom == "View" || self.appDelegate.addRequestOpt_Tennis_MultiSelect.count == 0)
        //self.viewMultiSelect.isHidden = (isFrom == "Modify" || isFrom == "View")
        //Hiding add button when member selection option is empty
        if isFrom == "Modify"
        {
            self.btnAddPlayer.isHidden = self.shouldHideMemberAddOptions()
        }
        //GATHER0000606 -- End
        
        self.btnMultiSelection.setTitle(self.appDelegate.masterLabeling.MULTI_SELECT ?? "", for: .normal)
        self.btnMultiSelection.multiSelectBtnViewSetup()
        
        self.requestReservationApi()
        
        self.arrInstructions = self.appDelegate.ReservationsInstruction
        
        self.disableActions()
        
        //Added on 14th October 2020 V2.3
        //Added for iOS 14 date picker change
        if #available(iOS 14.0,*)
        {
            self.datePicker1.preferredDatePickerStyle = .wheels
            self.datePicker2.preferredDatePickerStyle = .wheels
            self.datePicker3.preferredDatePickerStyle = .wheels
        }
        
        self.myCalendar.appearance.selectionColor = APPColor.MainColours.primary2
        self.lblPlayers.textColor = APPColor.textColor.secondary
        
        self.btnCancelReservation.setStyle(style: .outlined, type: .primary)
        self.btnMultiday.setStyle(style: .outlined, type: .primary)
        self.btnSingleDay.setStyle(style: .contained, type: .primary)
        self.btnNintyMin.setStyle(style: .contained, type: .secondary, cornerRadius: 6)
        
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
    func minimumDate(for calendar: FSCalendar) -> Date {
        let dateDiff = findDateDiff(time1Str: self.minTime ?? "", time2Str: currentTime ?? "")
        
        if self.tennisSettings?.minDaysInAdvance == 0 {
            if dateDiff.first == "-"{
                self.myCalendar.appearance.titleTodayColor =  UIColor.black
            }else{
                self.myCalendar.appearance.titleTodayColor =  UIColor.lightGray
            }
        }else{
            self.myCalendar.appearance.titleTodayColor =  UIColor.lightGray
            
        }
        if dateDiff.first == "+"{
            return Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance ?? 0) + 1, to: self.dateAndTimeDromServer)!
            
        }else{
            return Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance ?? 0), to: self.dateAndTimeDromServer)!
        }
    }
    func maximumDate(for calendar: FSCalendar) -> Date {
        
            let dateDiff = findDateDiff(time1Str: self.maxTime ?? "", time2Str: currentTime ?? "")
            if dateDiff.first == "+"{
                return Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.maxDaysInAdvance ?? 0) + 1, to: self.dateAndTimeDromServer)!
                
            }else{
                return Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.maxDaysInAdvance ?? 0), to: self.dateAndTimeDromServer)!
                
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
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        
        self.instructionsTableViewHeight.constant = self.instructionsTableView.contentSize.height
        
        let instruction_MultiHeight = (self.viewMultiSelect.isHidden ? 0 : self.viewMultiSelectionHeight) + 5/*Space between instructions and multi select button */ + self.instructionsTableViewHeight.constant
        if isFrom == "Modify"{
            
            if self.arrTeeTimeDetails.count == 0 {
                
            }else{
                if self.arrTeeTimeDetails[0].buttonTextValue == "3" || self.arrTeeTimeDetails[0].buttonTextValue == "4"  || self.arrTeeTimeDetails[0].buttonTextValue == "5"{
                    self.captainViewHeight.constant = 80 + instruction_MultiHeight
                    
                    self.modifyViewHeight.constant =  self.modifyCourtTableView.contentSize.height + 62
                    self.tableViewheight?.constant = self.modifyCourtTableView.contentSize.height + 62
                    self.mainViewHeight.constant = 770 + tableViewheight.constant + instruction_MultiHeight
                }else{
                    self.captainViewHeight.constant = 80 + instruction_MultiHeight
                    
                    self.modifyViewHeight.constant =  self.modifyCourtTableView.contentSize.height + 62
                    self.tableViewheight?.constant = self.modifyCourtTableView.contentSize.height + 62
                    self.mainViewHeight.constant = 1250 + tableViewheight.constant + instruction_MultiHeight
                }
                    
            }
          

        }else{
          //  self.requestButtonHeight.constant = 32
            self.captainViewHeight.constant = 110 + instruction_MultiHeight
            self.tableViewheight?.constant = self.groupTableView.contentSize.height
            self.modifyViewHeight.constant = self.groupTableView.contentSize.height
            self.mainViewHeight.constant = 1250 + tableViewheight.constant + instruction_MultiHeight

        }
}
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.title = self.appDelegate.masterLabeling.request_court_time
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //  IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    @objc func didDOBDateChange(datePicker:UIDatePicker) {
        dob = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        txtCourtTime.text = dateFormatter.string(for: dob)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtCourtTime{
        self.courtCommanClass()
        self.memberValidattionAPI({ [unowned self] (status) in
            
        })
        }
        
    }

    //MARK:- Multiple selection clicked
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
             self.addNewPopOverMasterBttn()
        }
        else
        {
            self.courtCommanClass()
            self.memberValidattionAPI({ [unowned self] (status) in
                if status == true{
                     self.addNewPopOverMasterBttn()
                }
                })
        }
       
        
    }
    
    //MARK:- Adds pop over for Multi selection Bttn
    private func addNewPopOverMasterBttn()
    {
        let addNewView : UIView!
        //Modified by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
        //GATHER0000606 -- Start
        
        let popoverHeight = self.appDelegate.addRequestOpt_Tennis_MultiSelect.count * 50
        //let popoverHeight = self.appDelegate.arrRegisterMultiMemberType.count * 50
       
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
        
        let point = self.btnMultiSelection.convert(self.btnMultiSelection.center , to: appDelegate.window)
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
    
//    @objc func didDOBDateChangeEarlier(datePicker: UIDatePicker) {
//        dob = datePicker.date
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "hh:mm a"
//        txtNotEarlierthan.text = dateFormatter.string(for: dob)
//
//    }
//    @objc func didDOBDateChangeLater(datePicker:UIDatePicker) {
//        dob = datePicker.date
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "hh:mm a"
//
//        tctNotLaterThan.text = dateFormatter.string(for: dob)
//
//    }
    
//    func PreferenceTimeChanged(){
//
//        let dateAsStringMax = txtCourtTime.text
//        let dateFormatterMax = DateFormatter()
//        dateFormatterMax.dateFormat = "hh:mm a"
//
//        let dateMax = dateFormatterMax.date(from: dateAsStringMax!)
//        dateFormatterMax.dateFormat = "HH:mm"
//
//        let DateMax = dateFormatterMax.string(from: dateMax!)
//
//        let dateAsStringMin = self.tennisSettings?.fromTime
//        let dateFormatterMin = DateFormatter()
//        dateFormatterMin.dateFormat = "hh:mm a"
//
//        let dateMin = dateFormatterMin.date(from: dateAsStringMin!)
//        dateFormatterMin.dateFormat = "HH:mm"
//
//        let DateMin = dateFormatterMin.string(from: dateMin!)
//
//        let dateFormatter3 = DateFormatter()
//        dateFormatter3.dateFormat =  "HH:mm"
//        let date3 = dateFormatter3.date(from: DateMin)
//
//        self.datePicker3.datePickerMode = .time
//
//        let minEarlier = dateFormatter3.date(from: DateMin)      //createing min time
//        let maxEarlier = dateFormatter3.date(from: DateMax) //creating max time
//        self.datePicker3.minimumDate = minEarlier  //setting min time to picker
//        self.datePicker3.maximumDate = maxEarlier
//        self.datePicker3.minuteInterval = (self.tennisSettings?.timeInterval)!  // with interval of 30
//
//      //  self.datePicker3.setDate(date3!, animated: true)
//        self.datePicker3.addTarget(self, action: #selector(self.didDOBDateChangeEarlier(datePicker:)), for: .valueChanged)
//
//        self.txtNotEarlierthan.inputView = self.datePicker3
//
//    }
//
//    func NotLaterTimeChanged(){
//
//        let dateAsStringMax = self.tennisSettings?.toTime
//        let dateFormatterMax = DateFormatter()
//        dateFormatterMax.dateFormat = "hh:mm a"
//
//        let dateMax = dateFormatterMax.date(from: dateAsStringMax!)
//        dateFormatterMax.dateFormat = "HH:mm"
//
//        let DateMax = dateFormatterMax.string(from: dateMax!)
//
//        let dateAsStringMin = self.txtCourtTime.text
//        let dateFormatterMin = DateFormatter()
//        dateFormatterMin.dateFormat = "hh:mm a"
//
//        let dateMin = dateFormatterMin.date(from: dateAsStringMin!)
//        dateFormatterMin.dateFormat = "HH:mm"
//
//        let DateMin = dateFormatterMin.string(from: dateMin!)
//
//        let dateFormatter3 = DateFormatter()
//        dateFormatter3.dateFormat =  "HH:mm"
//        let date3 = dateFormatter3.date(from: DateMin)
//
//        self.datePicker2.datePickerMode = .time
//
//        let minEarlier = dateFormatter3.date(from: DateMin)      //createing min time
//        let maxEarlier = dateFormatter3.date(from: DateMax) //creating max time
//        self.datePicker2.minimumDate = minEarlier  //setting min time to picker
//        self.datePicker2.maximumDate = maxEarlier
//        self.datePicker2.minuteInterval = (self.tennisSettings?.timeInterval)!  // with interval of 30
//
//       // self.datePicker2.setDate(date3!, animated: true)
//        self.datePicker2.addTarget(self, action: #selector(self.didDOBDateChangeLater(datePicker:)), for: .valueChanged)
//
//        self.tctNotLaterThan.inputView = self.datePicker2
//
//    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//        if textField == txtNotEarlierthan {
//            let dateDiff = self.findDateDiff(time1Str: self.txtCourtTime.text ?? "", time2Str: txtNotEarlierthan.text ?? "")
//            if dateDiff.first == "+"{
//                txtNotEarlierthan.text = txtCourtTime.text
//            }
//        }
//        if textField == tctNotLaterThan {
//            let dateDiff = self.findDateDiff(time1Str: self.txtCourtTime.text ?? "", time2Str: tctNotLaterThan.text ?? "")
//             if dateDiff.first == "-"{
//                tctNotLaterThan.text = txtCourtTime.text
//            }
//        }
//
//
//    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == addNewPopoverTableView
        {
            //Modified by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
            //GATHER0000606 -- Start
            
            return self.isMultiSelectionClicked ? self.appDelegate.addRequestOpt_Tennis_MultiSelect.count : self.appDelegate.addRequestOpt_Tennis.count
            
            //return self.isMultiSelectionClicked ? self.appDelegate.arrRegisterMultiMemberType.count : self.appDelegate.arrEventRegType.count
            //GATHER0000606 -- End
        }
        else if(tableView == modifyCourtTableView){
            
            return arrPlayers.count
        }
        else if tableView == self.instructionsTableView
        {
            return self.arrInstructions.count
        }
        else{
            return arrPlayers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == addNewPopoverTableView {
            
            let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 142, height: 34))
            cell.selectionStyle = .none
            
            //Modified by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
            //GATHER0000606 -- Start
            cell.textLabel?.text = self.isMultiSelectionClicked ? self.appDelegate.addRequestOpt_Tennis_MultiSelect[indexPath.row].name : self.appDelegate.addRequestOpt_Tennis[indexPath.row].name
            //cell.textLabel?.text = self.isMultiSelectionClicked ? self.appDelegate.arrRegisterMultiMemberType[indexPath.row].name : self.appDelegate.arrEventRegType[indexPath.row].name
            
            cell.textLabel?.font =  SFont.SourceSansPro_Semibold18
            cell.textLabel?.textColor = hexStringToUIColor(hex: "64575A")
            tableView.separatorStyle = .none
            
            //if indexPath.row < (self.isMultiSelectionClicked ? self.appDelegate.arrRegisterMultiMemberType.count : self.appDelegate.arrEventRegType.count) - 1
            if indexPath.row < (self.isMultiSelectionClicked ? self.appDelegate.addRequestOpt_Tennis_MultiSelect.count : self.appDelegate.addRequestOpt_Tennis.count) - 1
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
        else if (tableView == groupTableView){
            if let cell = tableView.dequeueReusableCell(withIdentifier: "RegCell", for: indexPath) as? CustomNewRegCell {
                cell.delegate = self
            
                if self.groupTableView.isHidden == true {
                }else{
                if arrPlayers[indexPath.row] is CaptaineInfo {
                    let memberObj = arrPlayers[indexPath.row] as! CaptaineInfo
                    cell.txtSearchField.text = String(format: "%@", memberObj.captainName!)
                    
                }else if arrPlayers[indexPath.row] is MemberInfo {
                    let memberObj = arrPlayers[indexPath.row] as! MemberInfo
                    cell.txtSearchField.text = String(format: "%@", memberObj.memberName!)
                } else if arrPlayers[indexPath.row] is GuestInfo {
                    let guestObj = arrPlayers[indexPath.row] as! GuestInfo
                    cell.txtSearchField.text = guestObj.guestName
                } else {
                    cell.txtSearchField.text = ""
                }
                
                cell.viewSearchField.layer.masksToBounds = true
                cell.viewSearchField.layer.cornerRadius = 6
                cell.viewSearchField.layer.borderWidth = 0.25
                cell.viewSearchField.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
                
                cell.txtSearchField.placeholder = String(format: "%@ %d", self.appDelegate.masterLabeling.player ?? "", indexPath.row + 1)
                }
                //Added by kiran V2.5 -- GATHER0000606 -- Hiding add button and clear button if options array is empty
                //GATHER0000606 -- Start
                let hideMemberOptions = self.shouldHideMemberAddOptions()
                cell.btnAdd.isHidden = hideMemberOptions
                cell.viewClearBtn.isHidden = hideMemberOptions
                //GATHER0000606 -- End
                
                self.view.setNeedsLayout()
                return cell
            }
        }else if (tableView == modifyCourtTableView){
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyCell", for: indexPath) as? ModifyRegCustomCell {
                cell.delegate = self
                
                if self.modifyCourtTableView.isHidden == true {
                    
                }else{
                if arrPlayers[indexPath.row] is Detail {
                    let playObj = arrPlayers[indexPath.row] as! Detail
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

                }else if arrPlayers[indexPath.row] is MemberInfo {
                    let memberObj = arrPlayers[indexPath.row] as! MemberInfo
                    cell.lblname.text = String(format: "%@", memberObj.memberName!)
                    cell.lblID.text = memberObj.memberID
                }
                else if arrPlayers[indexPath.row] is GuestInfo {
                    let guestObj = arrPlayers[indexPath.row] as! GuestInfo
                    cell.lblname.text = guestObj.guestName
                    //Added by kiran V2.8 -- ENGAGE0011784 --
                    //ENGAGE0011784 -- Start
                    let memberDetails = CustomFunctions.shared.memberType(details: guestObj, For: .tennis)
                    
                    switch memberDetails
                    {
                    case .existingGuest:
                        cell.lblID.text = guestObj.guestMemberNo
                    case .guest:
                        //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                        //ENGAGE0011843 -- Start
                        cell.lblID.text = CustomFunctions.shared.guestTypeDisplayName(id: guestObj.guestType)
                        //cell.lblID.text = guestObj.guestType
                        //ENGAGE0011843 -- End
                    case .member:
                        break
                    }
                    //cell.lblID.text = guestObj.guestType
                    //ENGAGE0011784 -- End
                } else {
                    cell.lblname.text = ""
                    cell.lblID.text = ""

                }
                
                if indexPath.row == 0 {
                    if arrPlayers[indexPath.row] is Detail {
                        let playObj = arrPlayers[indexPath.row] as! Detail
                        
                        if playObj.name == "" {
                            self.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,playObj.guestName!)
                            
                            
                        }else{
                            self.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,playObj.name! )
                        }
                        
                        
                    }else if arrPlayers[indexPath.row] is MemberInfo {
                        let memberObj = arrPlayers[indexPath.row] as! MemberInfo
                        self.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.memberName!)
                    }else if arrPlayers[indexPath.row] is DiningMemberInfo {
                        let memberObj = arrPlayers[indexPath.row] as! DiningMemberInfo
                        self.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.name!)
                    }else if arrPlayers[indexPath.row] is GuestInfo {
                        let guestObj = arrPlayers[indexPath.row] as! GuestInfo
                        self.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.guestName!)
                    } else {
                        self.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
                    }
                }
                }
                
                //Added by kiran V2.5 -- GATHER0000606 -- Hiding clear button if options array is empty
                //GATHER0000606 -- Start
                let hideMemberOptions = self.shouldHideMemberAddOptions()
                cell.btnClose.isHidden = hideMemberOptions
                //GATHER0000606 -- End
                self.view.setNeedsLayout()
                return cell
            }
       
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
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        addNewPopover?.dismiss()
        if tableView == addNewPopoverTableView
        {
            
            let cell = self.addNewPopoverTableView?.cellForRow(at: indexPath)
            
            //Modified by kiran V2.5 -- GATHER0000606 -- replacing comparision with case insensetive compare with the value(id)
            //GATHER0000606 -- Start
            let selectedOption = self.isMultiSelectionClicked ? (self.appDelegate.addRequestOpt_Tennis_MultiSelect[indexPath.row].Id ?? "") : (self.appDelegate.addRequestOpt_Tennis[indexPath.row].Id ?? "")
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
                
                if let memberDirectory = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MemberDirectoryViewController") as? MemberDirectoryViewController {
                    selectedCellText = cell?.textLabel?.text
                    memberDirectory.isFrom = "Registration"
                    memberDirectory.isOnlyFrom = "RegistrationCourt"
                    memberDirectory.delegate = self
                    memberDirectory.categoryForBuddy = "Tennis"
                    memberDirectory.isFor = "OnlyMembers"
                    memberDirectory.showSegmentController = true
                    
                    memberDirectory.gameType = gameType
                    
                    memberDirectory.selectedDate = self.reservationRequestDate
                    memberDirectory.reservationRequestDates = self.reservationRequestDates
                    memberDirectory.selectedTime = txtCourtTime.text ?? ""
                    memberDirectory.locationIndex = selectedIndex
                    memberDirectory.requestID = requestID
                    
                    //Added by kiran V2.7 -- GATHER0000832
                    //GATHER0000832 -- Start
                    memberDirectory.duration = self.durationType
                    //GATHER0000832 -- End
                    
                    if self.isMultiSelectionClicked
                    {
                        memberDirectory.shouldEnableMultiSelect = true
                        
                        memberDirectory.arrMultiSelectedMembers.append(self.arrPlayers)
                       /* self.availableTickets = (Int(self.partyCount) ?? 0) - self.arrPlayers.filter({$0.isEmpty == false}).count
                            
                        memberDirectory.totalNumberofTickets = self.availableTickets*/
                    }
                    else
                    {
                        arrTempPlayers = arrPlayers

                        if isFrom == "Modify" {
                            
                        }else{
                            arrTempPlayers =  arrTempPlayers.filter({$0.isEmpty == false})
                            
                        }
                        
                        memberDirectory.membersData = arrTempPlayers
                    }
                    
                    //Previous logicof multi selection without master selection button
                    
//                    if isFrom == "Modify"
//                    {
//
//                    }
//                    else
//                    {
//                        memberDirectory.shouldEnableMultiSelect = true
//
//                        self.availableTickets = (Int(self.partyCount) ?? 0) - self.arrPlayers.filter({$0.isEmpty == false}).count
//
//                        memberDirectory.totalNumberofTickets = self.availableTickets
//                    }
                    
                    navigationController?.pushViewController(memberDirectory, animated: true)
                }
            }
            
            //Modified by kiran V2.5 -- GATHER0000606 -- replacing comparision with case insensetive compare with the value(id)
            //GATHER0000606 -- Start
            //else if /*indexPath.row == 1*/ cell?.textLabel?.text ?? "" == "Guest"
            else if selectedOption.caseInsensitiveCompare(AddRequestIDS.guest.rawValue) == .orderedSame
            //GATHER0000606 -- End
            {
                
                if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddGuestRegVC") as? AddGuestRegVC {
                    regGuest.memberDelegate = self
                    
                    //Added by kiran V2.8 -- ENGAGE0011784 -- showing the existing guest feature and showing guest dob and gender fields
                    //ENGAGE0011784 -- Start
                    //commneted these are they are replaced with screentype and usedForModule.
//                    regGuest.isFrom = "Request"
//                    regGuest.isOnlyFrom = "RequestCourt"
                    
                    regGuest.screenType = .add
                    regGuest.usedForModule = .tennis
                    regGuest.showExistingGuestsOption = true
                    regGuest.isDOBHidden = false
                    regGuest.isGenderHidden = false
                    regGuest.enableGuestNameSuggestions = false
                    regGuest.hideAddtoBuddy = false
                    regGuest.hideExistingGuestAddToBuddy = false
                    
                    if self.gameType == "Singleday"
                    {
                        regGuest.requestDates = [self.reservationRequestDate ?? ""]
                    }
                    else
                    {
                        regGuest.requestDates = self.reservationRequestDates
                    }
                    
                    regGuest.requestTime = self.txtCourtTime.text ?? ""
                    regGuest.duration = self.durationType ?? ""
                    regGuest.requestID = self.requestID ?? ""
                    regGuest.gameType = self.gameType ?? ""
                    regGuest.arrAddedMembers = [self.arrPlayers]
                    //commented as this is not being used in the addguestregVC.
                    //regGuest.locationIndex = selectedIndex
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
                    memberDirectory.isOnlyFrom = "RegistrationCourt"
                    memberDirectory.isFor = "OnlyMembers"
                    memberDirectory.showSegmentController = true
                    
                    memberDirectory.gameType = gameType
                    
                    memberDirectory.selectedDate = self.reservationRequestDate
                    memberDirectory.reservationRequestDates = self.reservationRequestDates

                    memberDirectory.selectedTime = txtCourtTime.text ?? ""
                    memberDirectory.requestID = requestID

                    memberDirectory.categoryForBuddy = "Tennis"
                    memberDirectory.delegate = self
                    memberDirectory.locationIndex = selectedIndex
                    
                    //Added by kiran V2.7 -- GATHER0000832
                    //GATHER0000832 -- Start
                    memberDirectory.duration = self.durationType
                    //GATHER0000832 -- End
                    
                    if self.isMultiSelectionClicked
                    {
                        memberDirectory.shouldEnableMultiSelect = true
                                               
                        memberDirectory.arrMultiSelectedMembers.append(self.arrPlayers)
                    }
                    else
                    {
                        arrTempPlayers = arrPlayers
                        
                        if isFrom == "Modify" {
                            
                        }else{
                            arrTempPlayers =  arrTempPlayers.filter({$0.isEmpty == false})
                            
                        }
                        memberDirectory.membersData = arrTempPlayers
                    }
                    
                    //Previous logic form multi selection without master selection button
                    /*
                    if isFrom == "Modify"
                    {
                        
                    }
                    else
                    {
                        memberDirectory.shouldEnableMultiSelect = true
                        
                        self.availableTickets = (Int(self.partyCount) ?? 0) - self.arrPlayers.filter({$0.isEmpty == false}).count
                                               
                        memberDirectory.totalNumberofTickets = self.availableTickets
                        
                    }*/
                    
                    navigationController?.pushViewController(memberDirectory, animated: true)
                }
            }
            self.isMultiSelectionClicked = false
        }
        else if tableView == self.instructionsTableView
        {
            
        }
        else{
            
        }
    }
    func guestViewControllerResponse(guestName: String) {
        
    }
    
    func checkBoxClicked(cell: CustomDashBoardCell) {
        
    }
    
    func addPlayerButtonClicked(){
        
        if playType == "Singles" {
            if self.arrPlayers.count >= 2 {
                self.btnAddPlayer.isEnabled = false
            }else{
                self.btnAddPlayer.isEnabled = true
            }
        }else{
            if self.arrPlayers.count >= 4 {
                self.btnAddPlayer.isEnabled = false
            }else{
                self.btnAddPlayer.isEnabled = true
            }
        }
    }
    
    //MARK:- This methods returns added members/ my biddues for request only
    func requestMemberViewControllerResponse(selecteArray: [RequestData]) {
        
        if(isFrom == "Modify"){
            addPlayerButtonClicked()
            let selectedObject = selecteArray[0]
            selectedObject.isEmpty = false
            arrPlayers.insert(selectedObject, at: modifyCount)
            modifyCount = arrPlayers.count
            
            if self.arrTeeTimeDetails.count != 0{
                self.lblConfirmNumberModify.text =  self.arrTeeTimeDetails[0].confirmationNumber

            }
            self.lblConfirmNumberModify.isHidden = false
            
            self.addPlayerButtonClicked()
            self.modifyCourtTableView.reloadData()
            self.view.setNeedsLayout()
            
        }
        else
        {
            if selecteArray.count < 1
            {
                return
            }
            
            if self.isMultiSelectionClicked
            {
                // This is no longer being used moved this logic to multiSelectRequestMemberViewControllerResponse(selectedArray: [[RequestData]])
                /* self.isMasterSelectionClicked = false
                selecteArray.forEach { (newMember) in
                    
                    
                    if self.arrPlayers.filter({$0.isEmpty == false}).count < Int(self.partyCount) ?? 0
                    {
                        if let emptyIndex : Int = self.arrPlayers.firstIndex(where: {$0.isEmpty == true})
                        {
                            self.arrPlayers.remove(at: emptyIndex)
                            newMember.isEmpty = false
                            self.arrPlayers.insert(newMember, at: emptyIndex)
                        }
                    
                    }
                    
                }*/
                
            }
            else
            {
                let selectedObject = selecteArray[0]
                selectedObject.isEmpty = false
                arrPlayers.remove(at: selectedIndex!)
                arrPlayers.insert(selectedObject, at: selectedIndex!)
                
            }
        
            
            if(selectedIndex == 0){
                if arrPlayers[0] is CaptaineInfo {
                    let memberObj = arrPlayers[0] as! CaptaineInfo
                    self.lblCaptainName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.captainName!)
                    
                } else if arrPlayers[0] is MemberInfo {
                    let memberObj = arrPlayers[0] as! MemberInfo
                    self.lblCaptainName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.memberName!)

                }
                else if arrPlayers[0] is GuestInfo {
                    let guestObj = arrPlayers[0] as! GuestInfo
                    self.lblCaptainName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.guestName!)

                    
                } else {
                    self.lblCaptainName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
                }
            }
        self.lblConfirmNumberModify.isHidden = true
        self.groupTableView.reloadData()
        }
    }
    
    //MARK:- Response for multi selection from member directory for member/my buddy
    func multiSelectRequestMemberViewControllerResponse(selectedArray: [[RequestData]])
    {
        if let playersData = selectedArray.first
        {
            self.arrPlayers = playersData
        }
        
        self.groupTableView.reloadData()
    }
    
    func memberViewControllerResponse(selecteArray: [MemberInfo]) {
        
    }

    
    func buddiesViewControllerResponse(selectedBuddy: [MemberInfo]) {
        
    }
    func editClicked(cell: CustomNewRegCell) {
        
    }
    
    func addNewPopOverClicked(cell: CustomNewRegCell) {
        self.isMultiSelectionClicked = false
         if self.addNewMeber == true{
            self.addNewPopOverForRequest(cell: cell)
         }else{
            self.courtCommanClass()
            self.memberValidattionAPI({ [unowned self] (status) in
                if status == true{
                    self.addNewPopOverForRequest(cell: cell)
                }
                })
        }
        
    }
    
    /// Adds Popup for registerration
    func addNewPopOverForRequest(cell: CustomNewRegCell){

        
//        guard cell.txtSearchField.text?.count ?? 0 < 1 else{
//
//            /Change message
//            let alertController = UIAlertController.init(title: "", message: "Remove the member to add.", preferredStyle: .alert)
//            let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//            return
//        }
        
        //removed as this is removing the empty members which is making the selected order of member change. Suppose a member in index 1 is removed. when this logic executes the member at index 2 becomes member at index 1
        
//        let  arrTemp =  arrPlayers.filter({$0.isEmpty == false})
//
//        arrPlayers.removeAll()
//
//        if Int(partyCount) == arrTemp.count {
//            arrPlayers = arrTemp
//        }else if Int(partyCount)! < arrTemp.count {
//            let content =  arrTemp[0..<Int(partyCount)!]
//            arrPlayers.append(contentsOf: content)
//        }else if Int(partyCount)! > arrTemp.count{
//            let difference = Int(partyCount)! - arrTemp.count
//
//            arrPlayers.append(contentsOf: arrTemp)
//
//            if difference > 0 {
//                for _ in 0..<difference {
//                    arrPlayers.append(RequestData())
//                }
//            }
//
//        }
        
        let indexPath = self.groupTableView.indexPath(for: cell)
        
        selectedIndex = indexPath?.row
        selectedSection = indexPath?.section
        
        
        let addNewView : UIView!
        
        addNewView = UIView(frame: CGRect(x: 100, y: 0, width: 180, height: 146))
        
        addNewPopoverTableView = UITableView(frame: CGRect(x: 0, y: 5, width: 180, height: 146))
        
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
        
    }
    
    
    
    func clearButtonClicked(cell: CustomNewRegCell) {
        
        let indexPath = self.groupTableView.indexPath(for: cell)
        selectedIndex = indexPath?.row
        arrPlayers.remove(at: selectedIndex!)
        arrPlayers.insert(RequestData(), at: selectedIndex!)

        if(selectedIndex == 0){
            if arrPlayers[0] is CaptaineInfo {
                let memberObj = arrPlayers[0] as! CaptaineInfo
                self.lblCaptainName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.captainName!)
                
                
            } else if arrPlayers[0] is MemberInfo {
                let memberObj = arrPlayers[0] as! MemberInfo
                self.lblCaptainName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!, memberObj.memberName!)
                
            }
            else if arrPlayers[0] is GuestInfo {
                let guestObj = arrPlayers[0] as! GuestInfo
                self.lblCaptainName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.guestName!)
                
                
            } else {
                self.lblCaptainName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
            }
        }
        groupTableView.reloadData()
        
    }
    
    func ModifyClicked(cell: ModifyRegCustomCell) {
        
        let indexPath = self.modifyCourtTableView.indexPath(for: cell)
        selectedIndex = indexPath?.row
        arrPlayers.remove(at: selectedIndex!)
        modifyCount = arrPlayers.count
        if arrPlayers.count == 0 {
            self.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
        }
        modifyCourtTableView.reloadData()
        self.view.setNeedsLayout()
        
        self.addPlayerButtonClicked()
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
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "YYYY"
        
        self.lblMonth.text = self.formatterMonth.string(from: Calendar.current.date(byAdding: .month, value: 0, to:calendar.currentPage)!)
        self.lblYear.text = formatter1.string(from: Calendar.current.date(byAdding: .month, value: 0, to:calendar.currentPage)!)
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.formatter.string(from: date))")
        reservationRemindDate = self.newFormatter.string(from: date)
        if gameType == "Singleday" {
            reservationRequestDate = self.formatter.string(from: date)
        }else{
            self.reservationRequestDates.append(self.formatter.string(from: date))
        }
        self.courtCommanClass()
        self.memberValidattionAPI({ [unowned self] (status) in
            
        })
        
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did deselect date \(self.formatter.string(from: date))")
        
        if gameType == "Singleday" {
        }else{
            let index = self.reservationRequestDates.firstIndex(of: self.formatter.string(from: date))
            if index == nil{
                
            }else{
            self.reservationRequestDates.remove(at: index!)
            }
            
            print(self.reservationRequestDates)
            self.courtCommanClass()
            self.memberValidattionAPI({ (status) in
                
            })
        }
//        print(self.reservationRequestDates)
//        self.courtCommanClass()
//        self.memberValidattionAPI({ [unowned self] (status) in
//
//        })
        
        
//        if gameType == "Singleday" {
//        }else{
//            self.reservationRequestDates.append(self.formatter.string(from: date))
//            self.reservationRequestDates.rem
//        }
    }
    
    @IBAction func durationClicked(_ sender: Any) {
        
        if (sender as AnyObject).tag == 0 {
            btnNintyMin.layer.cornerRadius = 6
            btnNintyMin.layer.borderWidth = 1
            btnNintyMin.layer.borderWidth = 0.25
            btnNintyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
            btnNintyMin.backgroundColor = hexStringToUIColor(hex: "F47D4C")
            btnNintyMin.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.btnNintyMin.setStyle(style: .contained, type: .secondary, cornerRadius: 6)

            btnThirtyMin.layer.cornerRadius = 6
            btnThirtyMin.layer.borderWidth = 1
            btnThirtyMin.layer.borderWidth = 0.25
            btnThirtyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
            btnThirtyMin.backgroundColor = .clear
            btnThirtyMin.setTitleColor(hexStringToUIColor(hex: "695B5E"), for: UIControlState.normal)

            
            btnSixtyMin.layer.cornerRadius = 6
            btnSixtyMin.layer.borderWidth = 1
            btnSixtyMin.layer.borderWidth = 0.25
            btnSixtyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
            btnSixtyMin.backgroundColor = .clear
            btnSixtyMin.setTitleColor(hexStringToUIColor(hex: "695B5E"), for: UIControlState.normal)

            durationType = "90"
            
        }else if (sender as AnyObject).tag == 1{
            btnNintyMin.layer.cornerRadius = 6
            btnNintyMin.layer.borderWidth = 1
            btnNintyMin.layer.borderWidth = 0.25
            btnNintyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
            btnNintyMin.backgroundColor = .clear
            btnNintyMin.setTitleColor(hexStringToUIColor(hex: "695B5E"), for: UIControlState.normal)

            btnThirtyMin.layer.cornerRadius = 6
            btnThirtyMin.layer.borderWidth = 1
            btnThirtyMin.layer.borderWidth = 0.25
            btnThirtyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
            btnThirtyMin.backgroundColor = .clear
            btnThirtyMin.setTitleColor(hexStringToUIColor(hex: "695B5E"), for: UIControlState.normal)

            
            btnSixtyMin.layer.cornerRadius = 6
            btnSixtyMin.layer.borderWidth = 1
            btnSixtyMin.layer.borderWidth = 0.25
            btnSixtyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
            btnSixtyMin.backgroundColor = hexStringToUIColor(hex: "F47D4C")
            btnSixtyMin.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.btnSixtyMin.setStyle(style: .contained, type: .secondary, cornerRadius: 6)

            durationType = "60"
        }else {
            btnNintyMin.layer.cornerRadius = 6
            btnNintyMin.layer.borderWidth = 1
            btnNintyMin.layer.borderWidth = 0.25
            btnNintyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
            btnNintyMin.backgroundColor = .clear
            btnNintyMin.setTitleColor(hexStringToUIColor(hex: "695B5E"), for: UIControlState.normal)

            btnThirtyMin.layer.cornerRadius = 6
            btnThirtyMin.layer.borderWidth = 1
            btnThirtyMin.layer.borderWidth = 0.25
            btnThirtyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
            btnThirtyMin.backgroundColor = hexStringToUIColor(hex: "F47D4C")
            btnThirtyMin.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.btnThirtyMin.setStyle(style: .contained, type: .secondary, cornerRadius: 6)
            
            btnSixtyMin.layer.cornerRadius = 6
            btnSixtyMin.layer.borderWidth = 1
            btnSixtyMin.layer.borderWidth = 0.25
            btnSixtyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
            btnSixtyMin.backgroundColor = .clear
            btnSixtyMin.setTitleColor(hexStringToUIColor(hex: "695B5E"), for: UIControlState.normal)

            durationType = "30"

        }
        
    }
    
    @IBAction func singleOrDoubleClicked(_ sender: Any) {
        
        if (sender as AnyObject).tag == 1 {
            btnDoubles.setImage(UIImage(named : "Rectangle 2117"), for: UIControlState.normal)
            btnSingle.setImage(UIImage(named : "Group 2384"), for: UIControlState.normal)
            
            
            playType = btnSingle.titleLabel!.text
            
            partyCount = "2"
            
            self.singleDouble()
            self.addPlayerButtonClicked()
            
        }else {
            btnDoubles.setImage(UIImage(named : "Group 2384"), for: UIControlState.normal)
            btnSingle.setImage(UIImage(named : "Rectangle 2117"), for: UIControlState.normal)
            
            partyCount = "4"
            playType = btnDoubles.titleLabel!.text
            self.singleDouble()
            self.addPlayerButtonClicked()
        }
        
    }
    
    func singleDouble(){
        if (isFrom == "Modify"){
            
            
           
            
            if playType == "Singles"{
                let  arrTemp =  arrPlayers
                
                arrPlayers.removeAll()
                if Int(partyCount)! <= arrTemp.count {
                let content =  arrTemp[0..<Int(partyCount)!]
                arrPlayers.append(contentsOf: content)
                    modifyCount = arrPlayers.count
                }
                if arrTemp.count == 1 {
                    let content =  arrTemp[0..<1]
                    arrPlayers.append(contentsOf: content)
                    modifyCount = arrPlayers.count
                }
            }

            self.modifyCourtTableView.reloadData()
        }
        else{
        let  arrTemp =  arrPlayers.filter({$0.isEmpty == false})
        
            
            arrPlayers.removeAll()

            if Int(partyCount) == arrTemp.count {
            arrPlayers = arrTemp
            }else if Int(partyCount)! < arrTemp.count {
                let content =  arrTemp[0..<Int(partyCount)!]
            arrPlayers.append(contentsOf: content)
            }else if Int(partyCount)! > arrTemp.count{
                let difference = Int(partyCount)! - arrTemp.count
            
            arrPlayers.append(contentsOf: arrTemp)

            if difference > 0 {
                for _ in 0..<difference {
                    arrPlayers.append(RequestData())
                }
            }
            
        }
            self.groupTableView.reloadData()

        }
    
    }
    
    @IBAction func reuestBallMachineClciekd(_ sender: Any) {
        if btnRequestBall .isSelected == false {
            btnRequestBall.isSelected = true
            btnRequestBall.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
            ballMachine = 1
        }else {
            btnRequestBall.isSelected = false
            btnRequestBall.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
            ballMachine = 0
        }
        
        
    }
    @IBAction func singleOrMultidayClicked(_ sender: Any) {
        self.reservationRequestDates.removeAll()

        for date in self.myCalendar!.selectedDates{
            self.myCalendar.deselect(date)
        }
        
        let dateFormatterToSend = DateFormatter()
        dateFormatterToSend.dateFormat = "MM/dd/yyyy"
        let dateDiff = self.findDateDiff(time1Str: self.minTime ?? "", time2Str: self.currentTime ?? "")
        if dateDiff.first == "-"{
            self.myCalendar.select(Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer))
            self.reservationRequestDate = dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!)
            self.reservationRemindDate = self.newFormatter.string(from: Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!)
            self.reservationRequestDates.append(dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!))

            
            
            
        }else{
            self.myCalendar.select(Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)! + 1, to: self.dateAndTimeDromServer))
            self.reservationRequestDate = dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)! + 1, to: self.dateAndTimeDromServer)!)
            self.reservationRemindDate = self.newFormatter.string(from: Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)! + 1, to: self.dateAndTimeDromServer)!)
            self.reservationRequestDates.append(dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)! + 1, to: self.dateAndTimeDromServer)!))

            
            
        }


        
        if (sender as AnyObject).tag == 0 {
            self.myCalendar.allowsMultipleSelection = false
            self.myCalendar.weekdayHeight = 50
            self.myCalendar.delegate = self
            self.myCalendar.dataSource = self
         //   self.myCalendar.appearance.todayColor = .white
          //  self.myCalendar.appearance.titleTodayColor = .black
           

            btnMultiday.backgroundColor = .clear
        btnMultiday.layer.cornerRadius = 22
        btnMultiday.layer.borderWidth = 1
        btnMultiday.setTitleColor(hexStringToUIColor(hex: "F37D4A"), for: UIControlState.normal)
        btnMultiday.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
            self.btnMultiday.setStyle(style: .outlined, type: .primary)
            
        btnSingleDay.layer.cornerRadius = 22
        btnSingleDay.layer.borderWidth = 1
        btnSingleDay.layer.borderWidth = 1
        btnSingleDay.layer.borderColor = UIColor.white.cgColor
        btnSingleDay.backgroundColor = hexStringToUIColor(hex: "F37D4A")
        btnSingleDay.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.btnSingleDay.setStyle(style: .contained, type: .primary)
            
            gameType = "Singleday"
        }
        else{
         //   self.reservationRequestDates.removeAll()
            self.myCalendar.reloadData()
          //  self.reservationRequestDates.append(dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!))
            btnSingleDay.backgroundColor = .clear
            btnSingleDay.layer.cornerRadius = 22
            btnSingleDay.layer.borderWidth = 1
            btnSingleDay.setTitleColor(hexStringToUIColor(hex: "F37D4A"), for: UIControlState.normal)
            btnSingleDay.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
            self.btnSingleDay.setStyle(style: .outlined, type: .primary)
            
            btnMultiday.layer.cornerRadius = 22
            btnMultiday.layer.borderWidth = 1
            btnMultiday.layer.borderWidth = 1
            btnMultiday.layer.borderColor = UIColor.white.cgColor
            btnMultiday.backgroundColor = hexStringToUIColor(hex: "F37D4A")
            btnMultiday.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.btnMultiday.setStyle(style: .contained, type: .primary)
            
            self.myCalendar.allowsMultipleSelection = true
            self.myCalendar.weekdayHeight = 50
            self.myCalendar.delegate = self
            
            gameType = "Multiday"
            self.courtCommanClass()
            self.memberValidattionAPI({ [unowned self] (status) in
                
            })
        }

    }
    @IBAction func newPlayerAddClicked(_ sender: Any) {
        
        if self.addNewMeber == true{
            self.addNewPopupModifyCase()
        }else{
            self.courtCommanClass()
            self.memberValidattionAPI({ [unowned self] (status) in
                if status == true{
                    self.addNewPopupModifyCase()
                }
            })
        }
    
    }
    func addNewPopupModifyCase(){
        
        self.isMultiSelectionClicked = false
        let addNewView : UIView!
        
        
        addNewView = UIView(frame: CGRect(x: 100, y: 0, width: 180, height: 146))
        
        addNewPopoverTableView = UITableView(frame: CGRect(x: 0, y: 5, width: 180, height: 146))
        
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
        let point = btnAddPlayer.convert(btnAddPlayer.center , to: appDelegate.window)
        addNewPopover?.sideEdge = 4.0
        
        let pointt = CGPoint(x: self.view.bounds.width - 22, y: point.y - 1)
        
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        if point.y > height - 170{
            addNewPopover?.popoverType = .up
            addNewPopover?.show(addNewView, point: pointt)
            
        }else{
            addNewPopover?.show(addNewView, point: pointt)
            
        }
    }
    @IBAction func tennisPolicyClicked(_ sender: Any) {
        
       
        let restarantpdfDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
        restarantpdfDetailsVC.pdfUrl = self.tennisSettings?.tennisPolicy ?? ""
        restarantpdfDetailsVC.restarantName = self.appDelegate.masterLabeling.tennis_policy!
        self.navigationController?.pushViewController(restarantpdfDetailsVC, animated: true)
    }
    @IBAction func cancelReservation(_ sender: Any)
    {
        
        //Added on 4th July 2020 V2.2
        //added roles and privilages changes
        //since not allowed is handled before coming to this screen not need to check for it.
        switch self.accessManager.accessPermision(for: .tennisReservation) {
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
            if isOnlyFrom == "EventsModify"
            {
                cancelViewController.isFrom = "EventTennisCancelRequest"
                cancelViewController.cancelFor = self.requestType == .reservation ? .TennisReservation : .Events
            }
            else
            {
                cancelViewController.isFrom = "CancelRequest"
                cancelViewController.cancelFor = .TennisReservation
            }
            cancelViewController.eventID = requestID
            cancelViewController.numberOfTickets = self.partySize == 0 ? "" : "\(self.partySize)"
            self.navigationController?.pushViewController(cancelViewController, animated: true)
        }
    }
    
    
    
    @IBAction func previousClicked(_ sender: Any) {
        let dateDiff = self.findDateDiff(time1Str: self.minTime ?? "", time2Str: self.currentTime ?? "")

        if dateDiff.first == "+"{
            currentMonth = Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance ?? 0) + 1, to: self.dateAndTimeDromServer)
            
        }else{
            currentMonth = Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance ?? 0), to: self.dateAndTimeDromServer)
            
        }
        
        let nameFormatter = DateFormatter()
        nameFormatter.dateFormat = "MMMM YYYY" // format January 2020, February 2020, March 2020, ...

        let name = nameFormatter.string(from: currentMonth!)

      if name == "\(self.lblMonth.text ?? "") \(self.lblYear.text ?? "")" {

      }else{
        myCalendar.setCurrentPage(getPreviousMonth(date: myCalendar.currentPage), animated: true)
        }
    }
    @IBAction func nextMonthClicked(_ sender: Any) {
        


        let dateDiff = findDateDiff(time1Str: self.maxTime ?? "", time2Str: currentTime ?? "")
        if dateDiff.first == "+"{
            let currentDate = Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.maxDaysInAdvance ?? 0) + 1, to: self.dateAndTimeDromServer)
            let nameFormatter = DateFormatter()
            nameFormatter.dateFormat = "MMMM YYYY"
            
            let name = nameFormatter.string(from: currentDate!)
            
            if  name == "\(self.lblMonth.text ?? "") \(self.lblYear.text ?? "")" {
                
            }else{
                myCalendar.setCurrentPage(getNextMonth(date: myCalendar.currentPage), animated: true)
            }
        }else{
            let currentDate = Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.maxDaysInAdvance ?? 0), to: self.dateAndTimeDromServer)
            let nameFormatter = DateFormatter()
            nameFormatter.dateFormat = "MMMM YYYY"
            
            let name = nameFormatter.string(from: currentDate!)
            
            if  name == "\(self.lblMonth.text ?? "") \(self.lblYear.text ?? "")" {
                
            }else{
                myCalendar.setCurrentPage(getNextMonth(date: myCalendar.currentPage), animated: true)
            }
        }

    }
    func courtCommanClass(){
        partyList.removeAll()
        selectedDates.removeAll()
        arrTempPlayers = arrPlayers
        
        if isFrom == "Modify" {
            
        }else{
            arrTempPlayers =  arrTempPlayers.filter({$0.isEmpty == false})
            
        }
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            for i in 0 ..< arrTempPlayers.count {
                
                if  arrTempPlayers[i] is CaptaineInfo {
                    let playObj = arrTempPlayers[i] as! CaptaineInfo
                    let memberInfo:[String: Any] = [
                        "LinkedMemberID": playObj.captainID ?? "",
                        "ReservationRequestDetailId": "",
                        "PlayerOrder": i + 1,
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "AddBuddy": 0
                        
                    ]
                    partyList.append(memberInfo)
                    
                }
                else if arrTempPlayers[i] is Detail
                {
                    let playObj = arrTempPlayers[i] as! Detail
                    //Added by kiran V2.8 -- ENGAGE0011784 -- Added support for existing guest.
                    //ENGAGE0011784 -- Start
                    let memberType = CustomFunctions.shared.memberType(details: playObj, For: .tennis)
                    
                    if memberType == .guest//playObj.id == nil
                    {
                        let memberInfo:[String: Any] = [
                            "LinkedMemberID": "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID!,
                            "PlayerOrder": i + 1,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                            "GuestType": playObj.guestType!,
                            "GuestName": playObj.guestName!,
                            "GuestEmail": playObj.email!,
                            "GuestContact": playObj.cellPhone!,
                            "AddBuddy": playObj.addBuddy!,
                            //Added by kiran V2.8 -- ENGAGE0011784 --
                            //ENGAGE0011784 -- Start
                            APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                            APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                            APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                            APIKeys.kGuestGender : playObj.guestGender ?? ""
                            //ENGAGE0011784 -- End
                            
                        ]
                        partyList.append(memberInfo)
                    }
                    else if memberType == .member
                    {
                        let memberInfo:[String: Any] = [
                            "LinkedMemberID": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID!,
                            "PlayerOrder": i + 1,
                            "GuestMemberOf": "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "AddBuddy": 0
                            
                        ]
                        partyList.append(memberInfo)
                    }
                    else if memberType == .existingGuest
                    {
                        
                        let memberInfo:[String: Any] = [
                            "LinkedMemberID": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID!,
                            "PlayerOrder": i + 1,
                            "GuestMemberOf":  playObj.guestMemberOf ?? "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "AddBuddy": playObj.addBuddy ?? 0
                            
                        ]
                        //TODO:- Remove after approval
                        /*
                        let memberInfo:[String: Any] = [
                            "LinkedMemberID": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID!,
                            "PlayerOrder": i + 1,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                            "GuestType": playObj.guestType!,
                            "GuestName": playObj.guestName!,
                            "GuestEmail": playObj.email!,
                            "GuestContact": playObj.cellPhone!,
                            "AddBuddy": playObj.addBuddy!,
                            APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                            APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                            APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                            APIKeys.kGuestGender : playObj.guestGender ?? ""
                            
                        ]
                         */
                        partyList.append(memberInfo)
                    }
                    //ENGAGE0011784 -- End
                }else if arrTempPlayers[i] is MemberInfo {
                    
                    let playObj = arrTempPlayers[i] as! MemberInfo
                    
                    let memberInfo:[String: Any] = [
                        "LinkedMemberID": playObj.id ?? "",
                        "ReservationRequestDetailId": "",
                        "PlayerOrder": i + 1,
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "AddBuddy": 0
                    ]
                    partyList.append(memberInfo)
                    
                    
                }
                else if arrTempPlayers[i] is GuestInfo
                {
                    let playObj = arrTempPlayers[i] as! GuestInfo
                    //For existing guest only details sent for member are required.Used same object for guest and existing guest as other details a not considered in backend
                    let memberInfo:[String: Any] = [
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        "LinkedMemberID": playObj.linkedMemberID ?? "",
                        //ENGAGE0011784 -- End
                        "ReservationRequestDetailId": "",
                        "PlayerOrder": i + 1,
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
                        APIKeys.kGuestGender : playObj.guestGender ?? ""
                        //ENGAGE0011784 -- End
                        
                    ]
                    partyList.append(memberInfo)
                }
            }
            
            for i in 0 ..< partyList.count {
                if partyList.count > arrRegReqID.count{
                    arrRegReqID.append("")
                }
                if arrRegReqID.count == 0 {
                    
                }else{
                    partyList[i].updateValue(arrRegReqID[i], forKey: "ReservationRequestDetailId")
                }
            }
            
            if gameType == "Singleday" {
                let dateInfo:[String: Any] = [
                    "RequestDate": reservationRequestDate ?? "",
                    ]
                selectedDates.append(dateInfo)
            }else{
                for i in 0 ..< reservationRequestDates.count {
                    
                    let dateInfo:[String: Any] = [
                        "RequestDate": reservationRequestDates[i],
                        ]
                    selectedDates.append(dateInfo)
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
            "ReservationRequestDate": selectedDates,
            "ReservationRequestTime": txtCourtTime.text ?? "",
            "PlayerCount": partyCount,
            "Earliest": "",
            "Latest": "",
            "Comments": txtComments.text ?? "",
            "TennisDetails" : partyList,
            "PlayType": playType ?? "",
            "RequestType": gameType ?? "",
            "Duration": durationType ?? "",
            "BallMachine": ballMachine ?? 0,
            "IsReservation": "1",
            "IsEvent": "0",
            "ReservationType": "Tennis",
            "RegistrationID": requestID ?? ""
        ]
        print(paramaterDict)
        APIHandler.sharedInstance.getMemberValidation(paramater: paramaterDict, onSuccess: { (response) in
            
            self.appDelegate.hideIndicator()
            
            if response.details?.count == 0 {
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                self.addNewMeber = false
                self.firstTime = false

                success(false)
            }else{
                if response.responseCode == InternetMessge.kSuccess{
                    self.firstTime = false
                    self.addNewMeber = true
                    success(true)
                }else{
                    if self.firstTime == true{
                        //Commented on 1st June 2020 V2.1
//                        self.arrPlayers.remove(at: 0)
//                        self.arrPlayers.insert(RequestData(), at: 0)
                        self.firstTime = false
//                        self.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
//
//                        self.groupTableView.reloadData()
                    }else{
                    if let impVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ImpotantContactsVC") as? ImpotantContactsVC {
                        impVC.importantContactsDisplayName = response.brokenRules?.fields?[0] ?? ""
                        impVC.isFrom = "Reservations"
                        impVC.arrList = response.details!
                        impVC.modalTransitionStyle   = .crossDissolve;
                        impVC.modalPresentationStyle = .overCurrentContext
                        self.present(impVC, animated: true, completion: nil)
                    }
                    }
                    self.addNewMeber = false
                    success(false)
                }
            }
            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            self.appDelegate.hideIndicator()
        }
    }
    
    @IBAction func requestClicked(_ sender: Any) {
        
        if self.isViewOnly
        {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        //Added on 4th July 2020 V2.2
        //added roles and privilages changes
        //since not allowed is handled before coming to this screen not need to check for it.
        switch self.accessManager.accessPermision(for: .tennisReservation) {
        case .view:
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        default:
            break
        }
        
        
        
        self.courtCommanClass()

            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "RequestId": requestID ?? "",
                "ReservationRequestDate": selectedDates,
                "ReservationRequestTime": txtCourtTime.text ?? "",
                "PlayerCount": partyCount,
                "Earliest": "",
                "Latest": "",
                "Comments": txtComments.text ?? "",
                "TennisDetails" : partyList,
                "PlayType": playType ?? "",
                "RequestType": gameType ?? "",
                "Duration": durationType ?? "",
                "BallMachine": ballMachine ?? 0
            ]
            
            print("memberdict \(paramaterDict)")
            APIHandler.sharedInstance.saveCourtRequest(paramaterDict: paramaterDict, onSuccess: { memberLists in
                self.appDelegate.hideIndicator()
                
                
                if(memberLists.responseCode == InternetMessge.kSuccess)
                {
                    self.appDelegate.hideIndicator()
                    
                    
                    
                    if self.isFrom == "Modify"{
//                        if let updateGuestViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "ThanksUPdateViewController") as? ThanksUPdateViewController {
//                            self.appDelegate.hideIndicator()
//                            if self.isOnlyFrom == "EventsModify"{
//                                updateGuestViewController.isFrom = "EventTennisUpdate"
//                            }else{
//                            updateGuestViewController.isFrom = "TennisUpdate"
//                            }
//
//                            self.navigationController?.pushViewController(updateGuestViewController, animated: true)
//                        }
                        
                        if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView {
                            self.appDelegate.hideIndicator()
                            succesView.delegate = self
                            if self.isOnlyFrom == "EventsModify"{
                                succesView.isFrom = "EventTennisUpdate"
                            }else{
                                succesView.isFrom = "TennisUpdate"
                            }
                             succesView.imgUrl = memberLists.imagePath ?? ""
                            succesView.modalTransitionStyle   = .crossDissolve;
                            succesView.modalPresentationStyle = .overCurrentContext
                            self.present(succesView, animated: true, completion: nil)
                        }
                        
                    }else{
                        if let share = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ThanksVC") as? ThanksVC {
                        self.appDelegate.requestFrom = "Tennis"
                        share.delegate = self
                        
                        let dateFormatterToSend = DateFormatter()
                        dateFormatterToSend.dateFormat = "MM/dd/yyyy"
                        
                        let isoDate = self.reservationRemindDate
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                        let date = dateFormatter.date(from:isoDate!)!

                        share.remindDate = dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: -((self.tennisSettings?.minDaysInAdvance)! ), to: date)!)
                        
                        if self.gameType == "Singleday" {
                            share.palyDate = self.reservationRequestDate
                        }else if self.gameType == "Multiday"{
                           share.type = "Multi"
                            share.palyDate = "05/22/2019"

                        }
                        

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
            
            
//        }else{
//
//            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
//
//        }
        //
        
    }
    
    //Mark- Get Court Request Details Api
    func getCourtRequestDetailsApi() {
        
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
                "RequestID": requestID ?? ""
            ]
            
            APIHandler.sharedInstance.getRequestTennisDetails(paramaterDict: paramaterDict, onSuccess: { response in
                self.appDelegate.hideIndicator()
                
                if(response.responseCode == InternetMessge.kSuccess)
                {
                    if(response.requestTennisDetails == nil){
                        self.arrTeeTimeDetails.removeAll()
                        self.modifyCourtTableView.setEmptyMessage(InternetMessge.kNoData)
                        self.modifyCourtTableView.reloadData()
                        self.arrPlayers.removeAll()
                    }
                    else{
                        
                        if(response.requestTennisDetails?.count == 0)
                        {
                            self.arrTeeTimeDetails.removeAll()
                            self.modifyCourtTableView.setEmptyMessage(InternetMessge.kNoData)
                            self.modifyCourtTableView.reloadData()
                            self.arrPlayers.removeAll()
                            
                            
                        }else{
                            self.modifyCourtTableView.restore()
                            self.arrTeeTimeDetails = response.requestTennisDetails! //eventList.listevents!
                            
                            if self.arrTeeTimeDetails[0].buttonTextValue == "3" || self.arrTeeTimeDetails[0].buttonTextValue == "4" || self.arrTeeTimeDetails[0].buttonTextValue == "5"{
                                self.timeView.isHidden = true
                                self.heightTimeView.constant = 0
                                self.heightTypeOfCalendar.constant = 0
                                self.btnSingleDay.isHidden = true
                                self.btnMultiday.isHidden = true
                                self.lblSelectDates.isHidden = true
                                self.heightCalendar.constant = 0
                                self.viewCalendar.isHidden = true
                                self.heightSelectRequestDate.constant = 42
                                self.txtComments.isEditable = false
                                self.txtCourtTime.isEnabled = false
//                                self.txtNotEarlierthan.isEnabled = false
//                                self.tctNotLaterThan.isEnabled = false
                                self.viewDuration.isUserInteractionEnabled = false
                                self.viewRequestBall.isUserInteractionEnabled = false
                                self.btnSingle.isEnabled = false
                                self.btnDoubles.isEnabled = false
                                self.modifyTime.isHidden = false
                                self.txtCourtTime.text = self.arrTeeTimeDetails[0].reservationRequestTime ?? ""

                                self.modifyTime.setTitle(self.arrTeeTimeDetails[0].reservationRequestTime, for: UIControlState.normal)

                            }else{
                                self.txtCourtTime.text = self.arrTeeTimeDetails[0].reservationRequestTime ?? ""
//                                self.txtNotEarlierthan.text = self.arrTeeTimeDetails[0].earliest ?? ""
//                                self.tctNotLaterThan.text = self.arrTeeTimeDetails[0].latest ?? ""
                                
                                let dateFormatterMin = DateFormatter()
                                dateFormatterMin.dateFormat = "hh:mm a"
                                
                                let dateMin = dateFormatterMin.date(from: self.txtCourtTime.text!)
                                dateFormatterMin.dateFormat = "HH:mm"
                                
                                let DateMin = dateFormatterMin.string(from: dateMin!)
                                
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat =  "HH:mm"
                                let date = dateFormatter.date(from: DateMin)
                                
                                self.datePicker1.setDate(date!, animated: true)
                                self.datePicker1.addTarget(self, action: #selector(self.didDOBDateChange(datePicker:)), for: .valueChanged)
                                self.txtCourtTime.inputView = self.datePicker1
                                
                                
//                                let dateFormatterEarlier = DateFormatter()
//                                dateFormatterEarlier.dateFormat = "hh:mm a"
//
//                                let dateEarlier = dateFormatterEarlier.date(from: self.txtNotEarlierthan.text!)
//                                dateFormatterEarlier.dateFormat = "HH:mm"
//
//                                let DateEarlier = dateFormatterMin.string(from: dateEarlier!)
//
//                                let date2 = dateFormatter.date(from: DateEarlier)
//                                self.datePicker3.setDate(date2!, animated: true)
//                                self.datePicker3.addTarget(self, action: #selector(self.didDOBDateChangeEarlier(datePicker:)), for: .valueChanged)
//                                self.txtNotEarlierthan.inputView = self.datePicker3
//
//                                let dateFormatterLater = DateFormatter()
//                                dateFormatterLater.dateFormat = "hh:mm a"
//
//                                let dateLater = dateFormatterLater.date(from: self.tctNotLaterThan.text!)
//                                dateFormatterLater.dateFormat = "HH:mm"
//
//                                let DatLater = dateFormatterMin.string(from: dateLater!)
//
//                                let date3 = dateFormatter.date(from: DatLater)
//
//
//                                self.datePicker2.setDate(date3!, animated: true)
//                                self.datePicker2.addTarget(self, action: #selector(self.didDOBDateChangeLater(datePicker:)), for: .valueChanged)
//                                self.tctNotLaterThan.inputView = self.datePicker2
//
//                                self.PreferenceTimeChanged()
//
//                                self.NotLaterTimeChanged()

                            }
                            
                            for _ in 0..<self.arrTeeTimeDetails[0].tennisDetailsOnly!.count {
                                self.arrPlayers.append(RequestData())
                            }
                            
                            for i in 0..<self.arrTeeTimeDetails[0].tennisDetailsOnly!.count {
                                self.arrPlayers.remove(at: (self.arrTeeTimeDetails[0].tennisDetailsOnly?[i].playerOrder ?? 1) - 1)
                                self.arrPlayers.insert((self.arrTeeTimeDetails[0].tennisDetailsOnly?[i])!, at: (self.arrTeeTimeDetails[0].tennisDetailsOnly?[i].playerOrder ?? 1) - 1)
                                if self.arrPlayers[i] is Detail {
                                let playObj = self.arrPlayers[i] as! Detail
                                self.arrRegReqID.append(playObj.reservationRequestDetailID!)
                                }
                                
                            }
                            
                            if self.arrTeeTimeDetails[0].isCancel == 1{
                                self.btnCancelReservation.isHidden = false
                                self.heightCancelReservation.constant = 37

                                
                            }else{
                                self.btnCancelReservation.isHidden = true
                                self.heightCancelReservation.constant = -20

                            }
                            
                          
                            self.btnModifyDate.setTitle(self.arrTeeTimeDetails[0].reservationRequestDate, for: UIControlState.normal)

                            self.reservationRequestDate = self.formatter.string(from: self.formatter.date(from: self.arrTeeTimeDetails[0].reservationRequestDate!)!)


                            
                            self.lblConfirmNumberModify.text =  self.arrTeeTimeDetails[0].confirmationNumber

                            self.modifyCount = self.arrTeeTimeDetails[0].tennisDetailsOnly?.count ?? 0
                            self.modifyCourtTableView.reloadData()
                            
                            if(self.arrTeeTimeDetails[0].duration == "90"){

                                self.btnNintyMin.layer.cornerRadius = 6
                                self.btnNintyMin.layer.borderWidth = 1
                                self.btnNintyMin.layer.borderWidth = 0.25
                                self.btnNintyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
                                self.btnNintyMin.backgroundColor = hexStringToUIColor(hex: "F47D4C")
                                self.btnNintyMin.setStyle(style: .contained, type: .secondary,cornerRadius: 6)
                                
                                self.btnThirtyMin.layer.cornerRadius = 6
                                self.btnThirtyMin.layer.borderWidth = 1
                                self.btnThirtyMin.layer.borderWidth = 0.25
                                self.btnThirtyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
                                self.btnThirtyMin.backgroundColor = .clear
                                self.btnThirtyMin.setTitleColor(hexStringToUIColor(hex: "695B5E"), for: UIControlState.normal)
                                
                                self.btnSixtyMin.layer.cornerRadius = 6
                                self.btnSixtyMin.layer.borderWidth = 1
                                self.btnSixtyMin.layer.borderWidth = 0.25
                                self.btnSixtyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
                                self.btnSixtyMin.backgroundColor = .clear
                                self.btnSixtyMin.setTitleColor(hexStringToUIColor(hex: "695B5E"), for: UIControlState.normal)
                                self.durationType = "90"
                            }
                            else if(self.arrTeeTimeDetails[0].duration == "60"){
                                
                                self.btnNintyMin.layer.cornerRadius = 6
                                self.btnNintyMin.layer.borderWidth = 1
                                self.btnNintyMin.layer.borderWidth = 0.25
                                self.btnNintyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
                                self.btnNintyMin.backgroundColor = .clear
                                self.btnNintyMin.setTitleColor(hexStringToUIColor(hex: "695B5E"), for: UIControlState.normal)
                                
                                self.btnThirtyMin.layer.cornerRadius = 6
                                self.btnThirtyMin.layer.borderWidth = 1
                                self.btnThirtyMin.layer.borderWidth = 0.25
                                self.btnThirtyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
                                self.btnThirtyMin.backgroundColor = .clear
                                self.btnThirtyMin.setTitleColor(hexStringToUIColor(hex: "695B5E"), for: UIControlState.normal)
                                
                                
                                self.btnSixtyMin.layer.cornerRadius = 6
                                self.btnSixtyMin.layer.borderWidth = 1
                                self.btnSixtyMin.layer.borderWidth = 0.25
                                self.btnSixtyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
                                self.btnSixtyMin.backgroundColor = hexStringToUIColor(hex: "F47D4C")
                                self.btnSixtyMin.setTitleColor(UIColor.white, for: UIControlState.normal)
                                self.btnSixtyMin.setStyle(style: .contained, type: .secondary,cornerRadius: 6)
                                self.durationType = "60"
                            }
                            else if(self.arrTeeTimeDetails[0].duration == "30"){
                                
                                self.btnNintyMin.layer.cornerRadius = 6
                                self.btnNintyMin.layer.borderWidth = 1
                                self.btnNintyMin.layer.borderWidth = 0.25
                                self.btnNintyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
                                self.btnNintyMin.backgroundColor = .clear
                                self.btnNintyMin.setTitleColor(hexStringToUIColor(hex: "695B5E"), for: UIControlState.normal)
                                
                                self.btnThirtyMin.layer.cornerRadius = 6
                                self.btnThirtyMin.layer.borderWidth = 1
                                self.btnThirtyMin.layer.borderWidth = 0.25
                                self.btnThirtyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
                                self.btnThirtyMin.backgroundColor = hexStringToUIColor(hex: "F47D4C")
                                self.btnThirtyMin.setTitleColor(UIColor.white, for: UIControlState.normal)
                                self.btnThirtyMin.setStyle(style: .contained, type: .secondary,cornerRadius: 6)
                                
                                self.btnSixtyMin.layer.cornerRadius = 6
                                self.btnSixtyMin.layer.borderWidth = 1
                                self.btnSixtyMin.layer.borderWidth = 0.25
                                self.btnSixtyMin.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
                                self.btnSixtyMin.backgroundColor = .clear
                                self.btnSixtyMin.setTitleColor(hexStringToUIColor(hex: "695B5E"), for: UIControlState.normal)
                                self.durationType = "30"
                            }
                                
                                self.txtComments.text = self.arrTeeTimeDetails[0].comments ?? ""
                                if self.arrTeeTimeDetails[0].ballMachine == 1 {
                                        self.btnRequestBall.isSelected = true

                                        self.btnRequestBall.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                                        self.ballMachine = 1
                                    }else {
                                    self.btnRequestBall.isSelected = false

                                        self.btnRequestBall.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                                        self.ballMachine = 0
                                    }
                                
                            

                            if(self.arrTeeTimeDetails[0].playType?.lowercased() == "singles"){
                                    self.btnDoubles.setImage(UIImage(named : "Rectangle 2117"), for: UIControlState.normal)
                                    self.btnSingle.setImage(UIImage(named : "Group 2384"), for: UIControlState.normal)
                                    
                                    
                                    self.playType = self.btnSingle.titleLabel!.text
                                    self.partyCount = "2"
                                    self.addPlayerButtonClicked()
                                    
                                    self.singleDouble()
                                    
                                }
                            else if(self.arrTeeTimeDetails[0].playType?.lowercased() == "doubles"){
                                    self.btnDoubles.setImage(UIImage(named : "Group 2384"), for: UIControlState.normal)
                                    self.btnSingle.setImage(UIImage(named : "Rectangle 2117"), for: UIControlState.normal)
                                    
                                    self.partyCount = "4"
                                
                                
                                    self.playType = self.btnDoubles.titleLabel!.text
                                self.addPlayerButtonClicked()
                                    self.singleDouble()
                                
                            
                            }

                        }
                        
                    }
                    
                    if(!(self.arrTeeTimeDetails.count == 0)){
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.modifyCourtTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    
                    if let partySize = response.requestTennisDetails?[0].partySize
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
                    self.modifyCourtTableView.setEmptyMessage(response.responseMessage ?? "")
                    
                }
                if self.isFrom == "Modify"{
                    self.groupTableView.reloadData()

                }else{
                    self.modifyCourtTableView.reloadData()

                }
                
                self.appDelegate.hideIndicator()
                
                self.disableActions()
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
            
            self.tennisSettings = response.tennisSettings

            let dateAsStringMax = self.tennisSettings?.toTime
            let dateFormatterMax = DateFormatter()
            dateFormatterMax.dateFormat = "hh:mm a"
            
            let dateMax = dateFormatterMax.date(from: dateAsStringMax!)
            dateFormatterMax.dateFormat = "HH:mm"
            
            let DateMax = dateFormatterMax.string(from: dateMax!)
            
           
            let dateAsStringMin = self.tennisSettings?.fromTime
            let dateFormatterMin = DateFormatter()
            dateFormatterMin.dateFormat = "hh:mm a"
    
            let dateMin = dateFormatterMin.date(from: dateAsStringMin!)
            dateFormatterMin.dateFormat = "HH:mm"
    
            let DateMin = dateFormatterMin.string(from: dateMin!)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "HH:mm"
            let date = dateFormatter.date(from: DateMin)
            
            self.datePicker1.datePickerMode = .time
            
            let min = dateFormatter.date(from: DateMin)      //createing min time
            let max = dateFormatter.date(from: DateMax) //creating max time
            self.datePicker1.minimumDate = min  //setting min time to picker
            self.datePicker1.maximumDate = max
            self.datePicker1.minuteInterval = (self.tennisSettings?.timeInterval)!  // with interval of 30
            
            self.datePicker1.setDate(date!, animated: true)
            self.datePicker1.addTarget(self, action: #selector(self.didDOBDateChange(datePicker:)), for: .valueChanged)
            self.txtCourtTime.inputView = self.datePicker1
            
            
            let dateString = self.tennisSettings?.gETDATETIME
            
            let dateFormatter6 = DateFormatter()
            dateFormatter6.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//            dateFormatter6.locale = Locale(identifier: "en_US_POSIX")
            self.dateAndTimeDromServer = dateFormatter6.date(from:dateString!)!
            
//            let dateFormatter2 = DateFormatter()
//            dateFormatter2.dateFormat =  "HH:mm"
//            let date2 = dateFormatter2.date(from: DateMax)
//
//            self.datePicker2.datePickerMode = .time
//
//            let minLater = dateFormatter2.date(from: DateMin)      //createing min time
//            let maxLater = dateFormatter2.date(from: DateMax) //creating max time
//            self.datePicker2.minimumDate = minLater  //setting min time to picker
//            self.datePicker2.maximumDate = maxLater
//            self.datePicker2.minuteInterval = (self.tennisSettings?.timeInterval)!   // with interval of 30
//
//            self.datePicker2.setDate(date2!, animated: true)
//            self.datePicker2.addTarget(self, action: #selector(self.didDOBDateChangeLater(datePicker:)), for: .valueChanged)
//            self.tctNotLaterThan.inputView = self.datePicker2
//            self.tctNotLaterThan.delegate = self

            let currentDateFormatter = DateFormatter()
            currentDateFormatter.dateFormat = "hh:mm a"
            self.currentTime = currentDateFormatter.string(from:self.dateAndTimeDromServer)
            
            self.minTime = self.tennisSettings?.minDaysInAdvanceTime
            self.maxTime = self.tennisSettings?.maxDaysInAdvanceTime
            
            let dateFormatter3 = DateFormatter()
//            dateFormatter3.dateFormat =  "HH:mm"
//            let date3 = dateFormatter3.date(from: DateMin)
//
//            self.datePicker3.datePickerMode = .time
//
//            let minEarlier = dateFormatter3.date(from: DateMin)      //createing min time
//            let maxEarlier = dateFormatter3.date(from: DateMax) //creating max time
//            self.datePicker3.minimumDate = minEarlier  //setting min time to picker
//            self.datePicker3.maximumDate = minEarlier
//            self.datePicker3.minuteInterval = (self.tennisSettings?.timeInterval)!  // with interval of 30
//
//            self.datePicker3.setDate(date3!, animated: true)
//            self.datePicker3.addTarget(self, action: #selector(self.didDOBDateChangeEarlier(datePicker:)), for: .valueChanged)
//
//
//
//            self.txtNotEarlierthan.inputView = self.datePicker3
//            self.txtNotEarlierthan.delegate = self
            let dateFormatterToSend = DateFormatter()
            dateFormatterToSend.dateFormat = "MM/dd/yyyy"
            self.reservationRequestDate = dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!)
            self.reservationRemindDate = self.newFormatter.string(from: Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!)

            
            if self.isFrom == "Modify"{
                
            }
            else{
                let dateDiff = self.findDateDiff(time1Str: self.minTime ?? "", time2Str: self.currentTime ?? "")
                if dateDiff.first == "-"{
                    self.myCalendar.select(Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer))
                    self.reservationRequestDate = dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!)
                    self.reservationRemindDate = self.newFormatter.string(from: Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!)
                    
                }else{
                    self.myCalendar.select(Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)! + 1, to: self.dateAndTimeDromServer))
                    self.reservationRequestDate = dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)! + 1, to: self.dateAndTimeDromServer)!)
                    self.reservationRemindDate = self.newFormatter.string(from: Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)! + 1, to: self.dateAndTimeDromServer)!)
                }
                
                
                
            }
            
            
            
            
            let dateFormatterYear = DateFormatter()
            dateFormatterYear.dateFormat = "LLLL"
            let dateDiff = self.findDateDiff(time1Str: self.minTime ?? "", time2Str: self.currentTime ?? "")

            if dateDiff.first == "+"{
                self.nameOfMonth = dateFormatterYear.string(from: Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)! + 1, to: self.dateAndTimeDromServer)!)
                
                
            }else{
                self.nameOfMonth = dateFormatterYear.string(from: Calendar.current.date(byAdding: .day, value: +(self.tennisSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!)
                
            }
            let calendar = Calendar.current
            self.lblYear.text = "\(calendar.component(.year, from: self.dateAndTimeDromServer))"
            
            self.lblMonth.text = self.nameOfMonth
            self.myCalendar.reloadData()
            self.txtCourtTime.text = self.tennisSettings?.memberFromTime

           
            
                let dateFormatterMinFromTime = DateFormatter()
                dateFormatterMinFromTime.dateFormat = "hh:mm a"
                
                let dateMinFromTime = dateFormatterMinFromTime.date(from: self.txtCourtTime.text!)
                dateFormatterMinFromTime.dateFormat = "HH:mm"
                
                let DateMinFromTime = dateFormatterMin.string(from: dateMinFromTime!)
                
                let dateFormatterFromTime = DateFormatter()
                dateFormatterFromTime.dateFormat =  "HH:mm"
                let dateFromTime = dateFormatterFromTime.date(from: DateMinFromTime)
                
                self.datePicker1.setDate(dateFromTime!, animated: true)
                self.datePicker1.addTarget(self, action: #selector(self.didDOBDateChange(datePicker:)), for: .valueChanged)
                self.txtCourtTime.inputView = self.datePicker1
            
            
            
//            self.txtNotEarlierthan.text = self.tennisSettings?.memberFromTime
//            self.tctNotLaterThan.text = self.tennisSettings?.memberToTime
            self.appDelegate.hideIndicator()
            
            if self.isFrom == "Modify"{
            self.getCourtRequestDetailsApi()
            }else{
                let delay = 1 // seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
                    self.courtCommanClass()
                    self.firstTime = true
                    self.memberValidattionAPI({ [unowned self] (status) in
                        
                    })
                    
                }
                
            }

            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            self.appDelegate.hideIndicator()
            
        }
    }
    
    
}

//MARK:- View only funcitionality related functions
extension CourtRequestVC
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
        self.viewDuration.isUserInteractionEnabled = !bool
        self.viewRequestBall.isUserInteractionEnabled = !bool
        self.viewCalendar.isUserInteractionEnabled = !bool
        self.btnSingle.isUserInteractionEnabled = !bool
        self.btnDoubles.isUserInteractionEnabled = !bool
        self.txtCourtTime.isUserInteractionEnabled = !bool
        self.modifyCourtTableView.isUserInteractionEnabled = !bool
        self.groupTableView.isUserInteractionEnabled = !bool
        self.btnCancelReservation.isHidden = bool
        self.heightCancelReservation.constant = bool ? -20 : 37
        self.txtComments.isUserInteractionEnabled = !bool
        self.btnMultiSelection.isUserInteractionEnabled = !bool
        self.btnMultiday.isUserInteractionEnabled = !bool
        self.btnAddPlayer.isUserInteractionEnabled = !bool
        self.btnModifyDate.isUserInteractionEnabled = !bool
        self.modifyTime.isUserInteractionEnabled = !bool
    }
}

//MARK:- Custom methods
extension CourtRequestVC
{
    //Added by kiran V2.5 -- GATHER0000606 -- Logic which indicates if add member button should be displayed or not
    //GATHER0000606 -- Start
    ///Indicates if add member button should be shown. only applicable for single member add not multi select
    private func shouldHideMemberAddOptions() -> Bool
    {
        return !(self.appDelegate.addRequestOpt_Tennis.count > 0)
    }
    //GATHER0000606 -- End
}
