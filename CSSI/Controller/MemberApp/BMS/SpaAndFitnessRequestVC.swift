//
//  SpaAndFitnessRequestVC.swift
//  CSSI
//
//  Created by Kiran on 03/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit
import FSCalendar
import Popover

class SpaAndFitnessRequestVC: UIViewController
{
    
    @IBOutlet weak var scrollVIew: UIScrollView!
    
    @IBOutlet weak var scrollContentView: UIView!
    
    @IBOutlet weak var viewAppointmentData: UIView!
    @IBOutlet weak var viewGender: UIView!
    @IBOutlet weak var imgViewGender: UIImageView!
    @IBOutlet weak var lblProviderName: UILabel!
    @IBOutlet weak var lblAppointmentDate: UILabel!
    @IBOutlet weak var lblServiceName: UILabel!
    
    @IBOutlet weak var ViewGenderSelect: UIView!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnAny: UIButton!
    @IBOutlet var btnGenderCollection: [UIButton]!
    
    
    @IBOutlet weak var viewCalenderHeader: UIView!
    @IBOutlet weak var btnPreviousMonth: UIButton!
    @IBOutlet weak var btnNextMonth: UIButton!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var calendarView: FSCalendar!
    
    @IBOutlet weak var viewAppointmentTime: UIView!
    @IBOutlet weak var viewAppointTimeText: UIView!
    @IBOutlet weak var lblAppointTimeText: UILabel!
    @IBOutlet weak var viewSelectedTime: UIView!
    @IBOutlet weak var lblSelectedHour: UILabel!
    @IBOutlet weak var lblSelectedMinutes: UILabel!
    @IBOutlet weak var lblSelectedPeriod: UILabel!
    @IBOutlet weak var btnSelectTimeAction: UIButton!
    
    @IBOutlet weak var collectionViewTimePicker: UICollectionView!
    
    @IBOutlet weak var viewDuration: UIView!
    @IBOutlet weak var lblDuration: UILabel!
    
    @IBOutlet weak var viewGroupSettings: UIView!
    @IBOutlet weak var btnSingleSetting: UIButton!
    @IBOutlet weak var btnGroupSetting: UIButton!
    
    
    @IBOutlet weak var viewGroupCount: UIView!
    @IBOutlet weak var cardVIewGroupCount: UIView!
    @IBOutlet weak var lblGroupCountTitle: UILabel!
    @IBOutlet weak var lblGroupCount: UILabel!
    @IBOutlet weak var btnDecreaseCount: UIButton!
    @IBOutlet weak var btnIncreaseCount: UIButton!
    
    @IBOutlet weak var viewMembers: UIView!
    @IBOutlet weak var tblVIewMembers: SelfSizingTableView!
    @IBOutlet weak var tblViewMembersHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewSubmit: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var viewSubmitAndNew: UIView!
    @IBOutlet weak var btnSubmitAndNew: UIButton!
    
    @IBOutlet weak var tblMemberViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tblMemberViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewModifyHeader: UIView!
    @IBOutlet weak var viewModifyCaptainName: UIView!
    @IBOutlet weak var lblModifyCaptainName: UILabel!
    
    @IBOutlet weak var viewModifycaptainID: UIView!
    @IBOutlet weak var lblModifyCaptainID: UILabel!
    
    @IBOutlet weak var viewAddMemberLbl: UIView!
    @IBOutlet weak var lblAddMember: UILabel!
    
    @IBOutlet weak var btnModifyAdd: UIButton!
    
    @IBOutlet weak var viewComments: UIView!
    @IBOutlet weak var lblCommentHeader: UILabel!
    @IBOutlet weak var textViewComments: UITextView!
    
    // Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
    //GATHER0000923 -- Start
    @IBOutlet weak var viewPickleBall: UIView!
    @IBOutlet weak var lblPickleBallHeader: UILabel!
    @IBOutlet weak var txtFieldPickleBall: UITextField!
    //GATHER0000923 -- End
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var requestType : RequestScreenType?
    
    ///Format for the Date time we receive form server
    private var serverDateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    
    private var serverDateTimeLocale = Locale(identifier: "en_US_POSIX")
    
    private var currentDate : Date?
    
    private var selectedDate : String? {
        didSet{
            self.updateAppointmentDetails()
            self.getAppointmentAvailableTimes()
        }
    }
    
    private var selectedGender : FilterOption?{
        //Added on 18th August 2020 V2.3
        //used to store the user preference so that it can be repopulated when needed.
        didSet{
            self.appDelegate.bookingAppointmentDetails.providerGender = self.selectedGender
        }
    }
    
    private var selectedTime : BTimes?{
        didSet{
            self.updateSelectedTime()
            self.updateDurationLbl()
        }
    }
    
    private var unAvailableDateColor : UIColor = {
        
        return hexStringToUIColor(hex: "#DBDBDB")
    }()
    
    private var arrUnAvailabeDates = [BDates](){
        didSet{
            self.calendarView.reloadData()
        }
    }
    
    private var arrAvailableTimes : [BTimes] = [BTimes](){
        didSet{
            self.collectionViewTimePicker.reloadData()
        }
    }
    
    //KVO gives a call back everytime a value is inserted or removed in to the array.
    private var arrMembers : [RequestData] = [RequestData](){
        //Added on 18th August 2020 V2.3
        //Used to maintain the copy of members so that we can remember the selection of the user to repopulate it when needed.
        didSet{
            self.appDelegate.bookingAppointmentDetails.members = self.arrMembers
        }
    }
    
    private var tblViewAddMembers : UITableView?
    private var popoverAddMember : Popover?
    
    private var popoverOptions : [BWOption] = [BWOption]()
    
    private var memberAddIndex : IndexPath?
    
    ///Indicates if member selection is for single or group of members.
    //This value is send as paramater in api calls.
    private var memberSelectionType : MemberSelectionType? {
        //Added on 18th August 2020 V2.3
        //Added to save the user selection so that it can be repopulated when needed.
        didSet{
            self.appDelegate.bookingAppointmentDetails.memberSelectionType = self.memberSelectionType
        }
    }
    
    private let tblMemberTopSpace : (request : CGFloat,modify : CGFloat) = (28,0)
    private let tblMemberBottomSpace : (request : CGFloat,modify : CGFloat) = (16,0)
    
    private var screenType : RequestScreenType?
    
    private var isFirstTime = false
    
    private let accessManager = AccessManager.shared
    
    //Added on 5th September 2020 V2.3
    //Used to identify if the guest is modified in modify scenario
    private var isModifyClicked = false
    
    //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
    //GATHER0000700 - Start
    ///Indicates for which department booking is made, like Fitness & Spa or Tennis or etc..,
    var BMSBookingDepartment : BMSDepartment = .none
    //GATHER0000700 - End
    
    // Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
    //GATHER0000923 -- Start
    var selectedServiceCategoty : ServiceCategory?{
        
        didSet{
            self.txtFieldPickleBall.text = self.selectedServiceCategoty?.categoryName ?? ""
        }
    }
    
    private let serviceCategoryPicker : UIPickerView = UIPickerView.init()
    //GATHER0000923 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initialSetups()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. changing Request screen name according to BMS department.
        //GATHER0000700 - Start
        
        var navTitle = ""
        
        switch self.BMSBookingDepartment
        {
        
        case .fitnessAndSpa:
            //Added by kiran V1.4 -- PROD0000121 -- changed the request key to individual departents keys.
            //PROD0000121 -- Start
            let departmentName = self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? ""
            var departmentRequest = ""
            
            if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Fitness!) == .orderedSame
            {
                departmentRequest = self.appDelegate.masterLabeling.BMS_Fitness_Request ?? ""
            }
            else if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Spa!) == .orderedSame
            {
                departmentRequest = self.appDelegate.masterLabeling.BMS_Spa_Request ?? ""
            }
            else if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Salon!) == .orderedSame
            {
                departmentRequest = self.appDelegate.masterLabeling.BMS_Salon_Request ?? ""
            }
            else
            {
                departmentRequest = self.appDelegate.masterLabeling.BMS_Request ?? ""
            }
            
            navTitle = "\(self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "") \(departmentRequest)"
            
            //Old logic
            //navTitle = "\(self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "") \(self.appDelegate.masterLabeling.BMS_Request ?? "")"
            
            //PROD0000121 -- End
        
        case .tennisBookALesson:
            
            //Added by kiran V1.4 -- PROD0000121 -- changed the request key to individual departents keys.
            //PROD0000121 -- Start
            navTitle = "\(self.appDelegate.masterLabeling.TL_TennisLesson ?? "") \(self.appDelegate.masterLabeling.BMS_Tennis_Request ?? "")"
            
            //Old logic
            //navTitle = "\(self.appDelegate.masterLabeling.TL_TennisLesson ?? "") \(self.appDelegate.masterLabeling.BMS_Request ?? "")"
            //PROD0000121 -- End
        
            //Added by kiran V2.9 -- GATHER0001167 -- GOlf BAL title text
            //GATHER0001167 -- Start
        case .golfBookALesson:
            navTitle = "\(self.appDelegate.masterLabeling.BMS_GolfLesson ?? "") \(self.appDelegate.masterLabeling.BMS_Golf_Request ?? "")"
            //GATHER0001167 -- End
        case .none:
            break
        }
        self.navigationItem.title = navTitle
        //self.navigationItem.title = "\(self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "") \(self.appDelegate.masterLabeling.BMS_Request ?? "")"
        //GATHER0000700 - End
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        //        let barbutton = UIBarButtonItem.init(image : UIImage.init(named: "back_btn"), style: .plain, target: self , action: #selector(backBtnAction(sender:)))
        //        barbutton.imageInsets = UIEdgeInsets.init(top: 0, left: -6.5, bottom: 0, right: 0)
        //        self.navigationItem.leftBarButtonItem = barbutton
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(self.homeBtnClicked(sender:)))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
        //GATHER0000923 -- Start
        self.txtFieldPickleBall.layer.cornerRadius = 6.0
        self.txtFieldPickleBall.layer.borderWidth = 0.25
        self.txtFieldPickleBall.layer.borderColor = APPColor.DropDownColors.borderColor.cgColor
        self.txtFieldPickleBall.clipsToBounds = true
        //GATHER0000923 -- End
        
        self.tblViewMembersHeightConstraint.constant = self.tblVIewMembers.contentSize.height
        self.scrollVIew.contentSize.height = self.scrollContentView.frame.height
        
    }
    
    @objc private func homeBtnClicked(sender : UIBarButtonItem)
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        if self.appDelegate.bookingAppointmentDetails.requestScreenType == .modify
        {
            self.appDelegate.closeFrom = "BMSFlow"
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //Action for Male , Female and Any gender btns
    @IBAction func GenederClickActions(_ sender: UIButton)
    {
        self.selectGenderFor(button: sender)
    }
    
    
    @IBAction func previousMonthClickAction(_ sender: UIButton)
    {
        self.calendarView.setCurrentPage(Calendar.current.date(byAdding: .month, value: -1, to: self.calendarView.currentPage)!, animated: true)
    }
    
    @IBAction func nextMonthClickAction(_ sender: UIButton)
    {
        self.calendarView.setCurrentPage(Calendar.current.date(byAdding: .month, value: 1, to: self.calendarView.currentPage)!, animated: true)
    }
    
    @IBAction func SelectTimeClickAction(_ sender: UIButton)
    {
        if self.selectedDate != nil , self.arrAvailableTimes.count > 0
        {
            //Added by kiran V2.7 -- GATHER0000902 -- Added the logic not hide the view as well wheb clicked on the time and added the scroll to functionality. so that the selected cell will be visible.
            //GATHER0000902 -- Start
            if self.collectionViewTimePicker.isHidden
            {
                self.collectionViewTimePicker.reloadData()
                self.showPickerView(bool: true)
                self.collectionViewTimePicker.layoutIfNeeded()
                
                //Scrolls the collectionview to the selected index.
                if let index = self.arrAvailableTimes.firstIndex(where: {$0.time == self.selectedTime?.time})
                {
                    self.collectionViewTimePicker.scrollToItem(at: IndexPath.init(row: index, section: 0) , at: .centeredHorizontally, animated: false)
                    self.collectionViewTimePicker.setNeedsLayout()
                }
            }
            else
            {
                self.showPickerView(bool: false)
            }
            
            //Old logic which only shows the collectionview dosent hide it.
            //self.showPickerView(bool: true)
            
            //GATHER0000902 -- End
        }
        
    }
    
    @IBAction func singleSettingClickAction(_ sender: UIButton)
    {
        
    }
    
    @IBAction func groupSettingClickAction(_ sender: UIButton)
    {
        
    }
    
    @IBAction func increaseGroupCountClikAction(_ sender: UIButton)
    {
        
    }
    
    @IBAction func decreaseGroupCountClickAction(_ sender: UIButton)
    {
        
    }
    
    @IBAction func modifyAddClicked(_ sender: UIButton)
    {
        //Added on 5th Septmeber 2020 V2.3
        self.isModifyClicked = false
        guard self.hasSelectedMaxMembers() else {
            self.btnModifyAdd.isEnabled = false
            return
        }
        
        let point = sender.convert(sender.center, to: self.appDelegate.window)
        self.addPopup(point: point, arrowOffsetWidth: sender.bounds.width/2 + 20/*Trailing padding*/)
    }
    
    
    @IBAction func submitClickAction(_ sender: UIButton)
    {

        switch self.screenType {
        case .request,.modify:
            
            
            //Added on 4th July 2020 V2.2
            //Added roles and privelages changes
            
            //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Siwtching between fitness and spa and tennis booak a lession modules to implement roels and previleges.
            //GATHER0000700 - Start
            var module : SAModule!
            switch self.BMSBookingDepartment
            {
            case .fitnessAndSpa:
                module = .fitnessSpaAppointment
                //TODO:- Remove in march 2021 release this is temp work aroun to save time.
                //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments.
                //ENGAGE0011652 -- Start
                switch self.accessManager.accessPermissionFor(departmentName: self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "") {
                case .view:
                    //Modified by kiran V1.4 -- ENGAGE0012550 -- Showing wrong message for roles and privilage. Change the message from role_Validation2 to role_Validation1
                    //ENGAGE0012550 -- Start
                    if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
                    {//ENGAGE0012550 -- End
                        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                    }
                    return
                default:
                    break
                }
            //ENGAGE0011652 -- End
                
            case .tennisBookALesson:
                module = .tennisBookALesson
                //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL roles and privilages
                //GATHER0001167 -- Start
            case .golfBookALesson:
                module = .golfBookALesson
                //GATHER0001167 -- End
            case .none:
                //This case should not occur if it does app will crash and this is a development issue.
                break
            }
            
            //TODO:- Remove comparision in march 2021 release this is temp work aroun to save time.
            //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments.
            //ENGAGE0011652 -- Start
            if self.BMSBookingDepartment != .fitnessAndSpa
            {
                switch self.accessManager.accessPermision(for: module/*.fitnessSpaAppointment*/)
                {//GATHER0000700 - End
                    
                case .view:
                    //Modified by kiran V1.4 -- ENGAGE0012550 -- Showing wrong message for roles and privilage. Change the message from role_Validation2 to role_Validation1
                    //ENGAGE0012550 -- Start
                    if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
                    {//ENGAGE0012550 -- End
                        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                    }
                    
                    return
                default:
                    break
                }
            }
            //ENGAGE0011652 -- End

            //Modified by Kiran V2.7 -- GATHER0000838 - Getting success message for thankyou screen from save api instead of lang file.
            //GATHER0000838 -- Start
            self.performSubmit { (status,details) in
                
                //self.showThankyouScreen(imagePath: imagePath)
                self.showThankyouScreen(details: details)
                {
            //GATHER0000838 -- End
                    if self.screenType == .request
                    {
                        //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. nagvation flow
                        //GATHER0000700 - Start
                        for /*(index,vc)*/ vc in self.navigationController!.viewControllers
                        {
                            
                            switch self.BMSBookingDepartment
                            {
                            case .fitnessAndSpa:
                                if let vc = vc as? SpaAndFitnessViewController
                                {
                                    _ = self.navigationController?.popToViewController(vc, animated: true)
                                    return
                                }
                                
                            case .tennisBookALesson :
                                
                                if let vc = vc as? CourtTimesViewController
                                {
                                    _ = self.navigationController?.popToViewController(vc, animated: true)
                                    return
                                    
                                }
                                //Added by kiran V2.9 -- GATHER0001167 -- navigation logic for Golf BAL
                                //GATHER0001167 -- Start
                            case .golfBookALesson :
                                if let vc = vc as? TeeTimesViewController
                                {
                                    _ = self.navigationController?.popToViewController(vc, animated: true)
                                    return
                                }
                                //GATHER0001167 -- End
                            case .none:
                                break
                            }
                            
                            /* OLd logic
                             if let vc = vc as? FitnessRequestListingViewController , vc.contentType == .departments
                             {
                                 if index - 1 > 0
                                 {
                                     let popToView = self.navigationController!.viewControllers[index - 1]
                                     _ = self.navigationController?.popToViewController(popToView, animated: true)
                                     return
                                 }
                                 
                             }
                             */
                            //GATHER0000700 - End
                            
                        }
                        
                    }
                    else if self.screenType == .modify
                    {
                        
                        self.appDelegate.closeFrom = "BMSFlow"
                        for vc in self.navigationController!.viewControllers
                        {
                            if let vc = vc as? GolfCalendarVC
                            {
                                _ = self.navigationController?.popToViewController(vc, animated: true)
                                return
                                
                            }
                            else if let vc = vc as? CalendarOfEventsViewController
                            {
                                _ = self.navigationController?.popToViewController(vc, animated: true)
                                return
                            }
                        }
                    }
                    
                }
                
            }
            
        case .view:
            self.navigationController?.popViewController(animated: true)
        default:
            break
        }
        
        

    }
    
    @IBAction func btnSubmitAndNewClickAction(_ sender: UIButton)
    {
        
        //Added on 4th July 2020 V2.2
        //Added roles and privelages changes
        
        //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Siwtching between fitness and spa and tennis booak a lession modules to implement roels and previleges.
        //GATHER0000700 - Start
        var module : SAModule!
        switch self.BMSBookingDepartment
        {
        case .fitnessAndSpa:
            module = .fitnessSpaAppointment
            
            //TODO:- Remove in march 2021 release this is temp work aroun to save time.
            //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments.
            //ENGAGE0011652 -- Start
            switch self.accessManager.accessPermissionFor(departmentName: self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "") {
            case .view:
                switch self.requestType
                {
                case .request:
                    //Modified by kiran V1.4 -- ENGAGE0012550 -- Showing wrong message for roles and privilage. Change the message from role_Validation2 to role_Validation1
                    //ENGAGE0012550 -- Start
                    if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
                    {//ENGAGE0012550 -- End
                        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                    }
                case .modify:
                    if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
                    {
                        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                    }
                default:
                    break
                }
                return
            default:
                break
            }
        //ENGAGE0011652 -- End
        case .tennisBookALesson:
            module = .tennisBookALesson
            //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL roles nad privilages
            //GATHER0001167 -- Start
        case .golfBookALesson:
            module = .golfBookALesson
            //GATHER0001167 -- End
        case .none:
            //This case should not occur if it does app will crash and this is a development issue.
            break
        }
        
        //TODO:- Remove comparision in march 2021 release this is temp work aroun to save time.
        //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments.
        //ENGAGE0011652 -- Start
        if self.BMSBookingDepartment != .fitnessAndSpa
        {
            switch self.accessManager.accessPermision(for: module/*.fitnessSpaAppointment*/)
            {//GATHER0000700 - End
                
            case .view:
                
                switch self.requestType
                {
                case .request:
                    //Modified by kiran V1.4 -- ENGAGE0012550 -- Showing wrong message for roles and privilage. Change the message from role_Validation2 to role_Validation1
                    //ENGAGE0012550 -- Start
                    if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
                    {//ENGAGE0012550 -- End
                        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                    }
                case .modify:
                    if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
                    {
                        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                    }
                default:
                    break
                }
                
                
                return
            default:
                break
            }
        }
        //ENGAGE0011652 -- End
        
        switch self.screenType
        {
        case .request:
            //Modified by Kiran V2.7 -- GATHER0000838 - Getting success message for thankyou screen from save api instead of lang file.
            //GATHER0000838 -- Start
            self.performSubmit { (status,details) in
                
                //self.showThankyouScreen(imagePath: imagePath)
                self.showThankyouScreen(details: details)
                {
            //GATHER0000838 -- End
                    //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. nagvation flow
                    //GATHER0000700 - Start
                    self.appDelegate.bookingAppointmentDetails.serviceType = nil
                    self.appDelegate.bookingAppointmentDetails.service = nil
                    self.appDelegate.bookingAppointmentDetails.provider = nil
                    self.appDelegate.bookingAppointmentDetails.comments = nil
                    self.appDelegate.bookingAppointmentDetails.members = nil
                    self.appDelegate.bookingAppointmentDetails.providerGender = nil
                    self.appDelegate.bookingAppointmentDetails.memberSelectionType = nil
                    
                    for vc in self.navigationController!.viewControllers
                    {
                        
                        switch self.BMSBookingDepartment
                        {
                        case .fitnessAndSpa:
                            if let vc = vc as? FitnessRequestListingViewController , vc.contentType == .departments
                            {
                                _ = self.navigationController?.popToViewController(vc, animated: true)
                                return
                            }
                            //Modified by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
                        //GATHER0001167 -- Start
                        case .tennisBookALesson,.golfBookALesson:
                            
                            guard let firstScreen = self.appDelegate.BMSOrder.first!.contentType else{
                                return
                            }
                            
                            switch firstScreen
                            {
                            case .departments:
                                if let vc = vc as? FitnessRequestListingViewController , vc.contentType == .departments
                                {
                                    _ = self.navigationController?.popToViewController(vc, animated: true)
                                    return
                                }
                            case .services:
                                if let vc = vc as? FitnessRequestListingViewController , vc.contentType == .services
                                {
                                    _ = self.navigationController?.popToViewController(vc, animated: true)
                                    return
                                }
                            case .serviceType:
                                if let vc = vc as? ServiceTypeViewController
                                {
                                    _ = self.navigationController?.popToViewController(vc, animated: true)
                                    return
                                }
                            case .providers:
                                if let vc = vc as? FitnessRequestListingViewController , vc.contentType == .providers
                                {
                                    _ = self.navigationController?.popToViewController(vc, animated: true)
                                    return
                                }
                            case .requestScreen:
                                if let vc = vc as? CourtTimesViewController
                                {
                                    _ = self.navigationController?.popToViewController(vc, animated: true)
                                    return
                                }//GATHER0001167 -- Golf BAL Navigation Logic
                                else if let vc = vc as? TeeTimesViewController
                                {
                                    _ = self.navigationController?.popToViewController(vc, animated: true)
                                    return
                                }
                                //GATHER0001167 -- End
                            case .none:
                            break
                            }
                            
                        case .none:
                            break
                        }
                        //GATHER0000700 - End
                    }

                }
                
            }
            
        case .modify:
            
            //Modified on 8th July 2020 V2.2
            //Added cancel succes popup and cancelation reason settigs
            if let appointmentID = self.appDelegate.bookingAppointmentDetails.appointmentID , let department = self.appDelegate.bookingAppointmentDetails.department
            {
                
                if department.settings?.first?.app_CaptureCacellationReason == "1"
                {
                    let cancelScreen =  BMSCancelView.init(frame: self.appDelegate.window!.bounds)
                    cancelScreen.appointmentDetailID = appointmentID
                    cancelScreen.success = { [unowned self] (imgPath) in
                        
                        if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView
                        {
                            self.appDelegate.hideIndicator()
                            succesView.delegate = self
                            succesView.imgUrl = imgPath
                            //Added by kiran V2.9 -- GATHER0001167 -- Using cancelFor instead of isFrom for better handling
                            //GATHER0001167 -- Start
                            //Commented as this is replaced with cancelFor
                            //succesView.isFrom = CancelCategory.fitnessSpa.rawValue
                            
                            var category : CancelCategory = .BMS
                            
                            switch self.BMSBookingDepartment
                            {
                            case .fitnessAndSpa:
                                category = .fitnessSpa
                            case .golfBookALesson:
                                category = .golfBookALesson
                            case .tennisBookALesson:
                                category = .tennisBookALesson
                            case .none:
                                //This case should not occur. if it does its error in coding
                                break
                            }
                           
                            succesView.cancelFor = category//.BMS
                            succesView.departmentName = department.departmentName ?? ""
                            //GATHER0001167 -- End
                            succesView.modalTransitionStyle   = .crossDissolve;
                            succesView.modalPresentationStyle = .overCurrentContext
                            self.present(succesView, animated: true, completion: nil)
                        }
                    }
                    
                     self.appDelegate.window?.rootViewController?.view.addSubview(cancelScreen)
                }
                else if department.settings?.first?.app_CaptureCacellationReason == "0"
                {
                    if let cancelViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController
                    {
                        cancelViewController.delegate = self
                        cancelViewController.departmentName = department.departmentName ?? ""
                        cancelViewController.eventID = appointmentID
                        
                        //Added by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
                        //GATHER0001167 -- Start
                        var category : CancelCategory = .BMS
                        
                        switch self.BMSBookingDepartment
                        {
                        case .fitnessAndSpa:
                            category = .fitnessSpa
                        case .golfBookALesson:
                            category = .golfBookALesson
                        case .tennisBookALesson:
                            category = .tennisBookALesson
                            
                        case .none:
                            //This case should not occur. if it does its error in coding
                            break
                        }
                        cancelViewController.cancelFor = category//.fitnessSpa
                        //GATHER0001167 -- End
                        cancelViewController.numberOfTickets = ""
                        self.navigationController?.pushViewController(cancelViewController, animated: true)
                    }
                }
               
            }
            
        default:
            break
            
        }

    }
    
}


//MARK:- Custom methods
extension SpaAndFitnessRequestVC
{
    private func initialSetups()
    {
        
        //Added on 4th July 2020 V2.2
        //Added roles and privelages changes
        if self.appDelegate.BMSOrder.first?.contentType == .requestScreen
        {
            //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Siwtching between fitness and spa and tennis booak a lession modules to implement roels and previleges.
            //GATHER0000700 - Start
            var module : SAModule!
            switch self.BMSBookingDepartment
            {
            case .fitnessAndSpa:
                module = .fitnessSpaAppointment
                
                //TODO:- Remove in march 2021 release this is temp work aroun to save time.
                //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments.
                //ENGAGE0011652 -- Start
                switch self.accessManager.accessPermissionFor(departmentName: self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "") {
                case .view:
                    if let message = self.appDelegate.masterLabeling.role_Validation2 , message.count > 0
                    {
                        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                    }
                default:
                    break
                }
            //ENGAGE0011652 -- End
                
            case .tennisBookALesson:
                module = .tennisBookALesson
            //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL support
            //GATHER0001167 -- Start
            case .golfBookALesson:
                module = .golfBookALesson
                //GATHER0001167 -- End
            case .none:
                //This case should not occur if it does app will crash and this is a development issue.
                break
            }
            
            
            //TODO:- Remove comparision in march 2021 release this is temp work around to save time.
            //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments.
            //ENGAGE0011652 -- Start
            if self.BMSBookingDepartment != .fitnessAndSpa
            {
                switch self.accessManager.accessPermision(for: module/*.fitnessSpaAppointment*/)
                {//GATHER0000700 - End
                    
                case .view:
                    if self.requestType != .view ,let message = self.appDelegate.masterLabeling.role_Validation2 , message.count > 0
                    {
                        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                    }
                    
                    break
                default:
                    break
                }
            }
            //ENGAGE0011652 -- End

        }
        
        self.screenType = self.appDelegate.bookingAppointmentDetails.requestScreenType
        
        //Generating today date from date string fetched from server
        self.currentDate = self.appDelegate.bookingAppointmentDetails.department!.systemDateTime!.date(format : self.serverDateFormat , locale : self.serverDateTimeLocale)
        
        //Appointment details view shadow
        
        self.viewAppointmentData.applyShadow(color: hexStringToUIColor(hex: "#00000017"), radius: 3, offset: CGSize.init(width: 0, height: 3), opacity: 0.6)
        
        //Appointment details assigning
        self.updateAppointmentDetails()
        
        //Gender buttons view setup
        
        self.btnMale.setTitle(self.appDelegate.masterLabeling.BMS_GenderMale ?? "", for: .normal)
        self.btnFemale.setTitle(self.appDelegate.masterLabeling.BMS_GenderFemale ?? "", for: .normal)
        self.btnAny.setTitle(self.appDelegate.masterLabeling.BMS_GenderAny ?? "", for: .normal)
        
        if self.appDelegate.bookingAppointmentDetails.provider?.providerID?.count ?? 0 > 0
        {
            self.ViewGenderSelect.isHidden = true
        }
        else
        {
            
            self.ViewGenderSelect.isHidden = false
            //Modified on 18th August 2020 V2.3
            switch self.screenType
            {
            case .request:
                
                //Repopulating the user selection if the value exists.
                self.selectGenderFor(id: self.appDelegate.bookingAppointmentDetails.providerGender?.Id)
                
                //TODO:- remove after approval
                /*
                var btnGender : UIButton = self.btnAny
                
                //self.selectGenderFor(button: self.btnAny)
                
                //Note:- Any change in gender filter option values from master list will impact this selection as we are going with posotion. followed this approached instead of using id's to stay in sync with android.
                //Repopulating the user selection if the value exists.
                if let gender = self.appDelegate.bookingAppointmentDetails.providerGender
                {
                    
                    if gender.Id == self.appDelegate.genderFilterOptions[0].Id
                    {
                        btnGender = self.btnMale
                    }
                    else if gender.Id == self.appDelegate.genderFilterOptions[1].Id
                    {
                        btnGender = self.btnFemale
                    }
                    
                }
                self.selectGenderFor(button: btnGender)
                
                */
                
                
            default:
                break
            }
            
            
        }
        
        //Calender View setups
        self.updateCalendarHeaderViewWith(date: self.calendarView.currentPage)
        
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
        self.calendarView.weekdayHeight = 50
        self.calendarView.allowsMultipleSelection = false
        self.calendarView.placeholderType = .none
        
        //Hides pickerview and shows Duration View
        self.lblAppointTimeText.text = self.appDelegate.masterLabeling.BMS_AvailableTime ?? ""
        self.showPickerView(bool: false)
        
        //Picker collection view setup
        
        self.collectionViewTimePicker.register(UINib.init(nibName: "TimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TimeCollectionViewCell")
        self.collectionViewTimePicker.delegate = self
        self.collectionViewTimePicker.dataSource = self
        
        //Hiding single and group setting buttons and member count increase/Decrease view
        self.viewGroupSettings.isHidden = true
        self.viewGroupCount.isHidden = true
        
        
        //Members Tableview setup
        
        self.tblVIewMembers.delegate = self
        self.tblVIewMembers.dataSource = self
        self.tblVIewMembers.estimatedRowHeight = 40
        self.tblVIewMembers.rowHeight = UITableViewAutomaticDimension
        self.tblVIewMembers.tableFooterView = nil
        self.tblVIewMembers.register(UINib.init(nibName: "RequestTableViewCell", bundle: nil), forCellReuseIdentifier: "RequestTableViewCell")
        self.tblVIewMembers.register(UINib.init(nibName: "ModifyTableViewCell", bundle: nil), forCellReuseIdentifier: "ModifyTableViewCell")
        
        switch self.screenType {
        case .request:
            self.tblVIewMembers.separatorStyle = .none
        default:
            break
        }
        
        self.setUpMemberView(type: self.screenType)
        
        //Submit buttons Setup
        switch self.screenType {
        case .request:
            
            self.btnSubmit.setTitle(self.appDelegate.masterLabeling.rEQUEST ?? "", for: .normal)
            self.btnSubmit.fitnessRequestBttnViewSetup()
            self.btnSubmit.setTitleColor(.white, for: .normal)
            self.btnSubmitAndNew.setTitle(self.appDelegate.masterLabeling.BMS_SubmitNew ?? "", for: .normal)
            self.btnSubmitAndNew.fitnessRequestBttnViewSetup()
            self.btnSubmitAndNew.setTitleColor(.white, for: .normal)
            self.btnSubmit.setStyle(style: .contained, type: .primary)
            self.btnSubmitAndNew.setStyle(style: .contained, type: .primary)
        case .modify:
            let color = hexStringToUIColor(hex: "F37D4A")
            self.btnSubmit.setTitle(self.appDelegate.masterLabeling.Save ?? "", for: .normal)
            self.btnSubmit.transparentBtnSetup(color : color)
            self.btnSubmitAndNew.setTitle(self.appDelegate.masterLabeling.cANCEL ?? "", for: .normal)
            self.btnSubmitAndNew.transparentBtnSetup(color : color)
            self.btnSubmit.setStyle(style: .outlined, type: .primary)
            self.btnSubmitAndNew.setStyle(style: .outlined, type: .primary)
        case .view:
            let color = hexStringToUIColor(hex: "F37D4A")
            self.btnSubmit.setTitle(self.appDelegate.masterLabeling.bACK ?? "", for: .normal)
            self.btnSubmit.transparentBtnSetup(color : color)
            self.btnSubmitAndNew.setTitle(self.appDelegate.masterLabeling.cANCEL ?? "", for: .normal)
            self.btnSubmitAndNew.isHidden = true
            self.btnSubmit.setStyle(style: .outlined, type: .primary)
        default:
            break
        }

        //Comments Setup
        //Added by kiran V2.8 -- GATHER0001149 --
        //GATHER0001149 -- Start
        var commentsHeaderText : String = self.appDelegate.masterLabeling.comments ?? ""
        
        switch self.BMSBookingDepartment
        {
        case .fitnessAndSpa:
            
            if let departmentName = self.appDelegate.bookingAppointmentDetails.department?.departmentName
            {
                if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Fitness!) == .orderedSame
                {
                    commentsHeaderText = self.appDelegate.masterLabeling.BMS_Fitness_Comments ?? ""
                }
                else if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Spa!) == .orderedSame
                {
                    commentsHeaderText = self.appDelegate.masterLabeling.BMS_Spa_Comments ?? ""
                }
                else if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Salon!) == .orderedSame
                {
                    commentsHeaderText = self.appDelegate.masterLabeling.BMS_Salon_Comments ?? ""
                }
                
            }
            
        case .tennisBookALesson:
            commentsHeaderText = self.appDelegate.masterLabeling.BMS_Tennis_Comments ?? ""
            //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL comments text support
            //GATHER0001167 -- Start
        case .golfBookALesson:
            commentsHeaderText = self.appDelegate.masterLabeling.BMS_Golf_Comments ?? ""
            //GATHER0001167 -- End
        case .none:
            break
        }
        
        self.lblCommentHeader.text = commentsHeaderText
        //self.lblCommentHeader.text = self.appDelegate.masterLabeling.comments
        //GATHER0001149 -- End
        
        self.textViewComments.layer.cornerRadius = 6
        self.textViewComments.layer.borderWidth = 1
        self.textViewComments.layer.borderWidth = 0.25
        self.textViewComments.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
        
        //Added on 18th August 2020 V2.3
        //Added delegate to save changes so they can be repopulated if needed.
        self.textViewComments.delegate = self
        
        //repopulatign the user comnets if they exists
        if let comment = self.appDelegate.bookingAppointmentDetails.comments
        {
            self.textViewComments.text = comment
        }
        
        //Setting group type. single/ group
        switch self.screenType {
        case .request:
            
            if let members = self.appDelegate.bookingAppointmentDetails.members
            {
                self.arrMembers = members
                self.memberSelectionType = self.appDelegate.bookingAppointmentDetails.memberSelectionType!
            }
            else
            {
                let captainInfo = CaptaineInfo.init()
                captainInfo.setCaptainDetails(id: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "", name: UserDefaults.standard.string(forKey: UserDefaultsKeys.captainName.rawValue) ?? "", firstName: UserDefaults.standard.string(forKey: UserDefaultsKeys.firstName.rawValue) ?? "", order: 1, memberID: UserDefaults.standard.string(forKey: UserDefaultsKeys.memberID.rawValue) ?? "", parentID: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "", profilePic: UserDefaults.standard.string(forKey: UserDefaultsKeys.userProfilepic.rawValue) ?? "")
                captainInfo.isEmpty = false
                
                self.selectGroup(type: .single,add: captainInfo)
            }
            
        default:
            break
        }
        
        
        //Setting PickleBall picker
        //Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
        //GATHER0000923 -- Start
        
        self.viewPickleBall.isHidden = !(self.appDelegate.bookingAppointmentDetails.service?.showCategoryInApp == 1 && (self.appDelegate.bookingAppointmentDetails.service?.serviceCategoryList?.count ?? 0) > 0)
        
        self.serviceCategoryPicker.delegate = self
        self.serviceCategoryPicker.dataSource = self
        
        self.lblPickleBallHeader.font = AppFonts.regular18
        self.lblPickleBallHeader.textColor = APPColor.textColor.pickleBallHeaderColor
        self.lblPickleBallHeader.text = self.appDelegate.masterLabeling.BMS_Select_Category ?? ""
        
        self.txtFieldPickleBall.textColor = APPColor.DropDownColors.textColor
        self.txtFieldPickleBall.font = AppFonts.regular18
        self.txtFieldPickleBall.setRightIcon(imageName: "Path 1847")
        self.txtFieldPickleBall.rightViewMode = .always
        self.txtFieldPickleBall.tintColor = .clear

        //Adding paddign at the start of textfield
        let paddingView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 8, height: 10))
        paddingView.backgroundColor = .clear
        self.txtFieldPickleBall.leftView = paddingView
        self.txtFieldPickleBall.leftViewMode = .always
        
        self.txtFieldPickleBall.delegate = self
        self.txtFieldPickleBall.inputView = self.serviceCategoryPicker
        //GATHER0000923 -- End
        
        
        //Disabling tap for viewonly case
        
        switch self.screenType {
        case .view:
            self.viewAppointmentData.isUserInteractionEnabled = false
            self.ViewGenderSelect.isUserInteractionEnabled = false
            self.viewCalenderHeader.isUserInteractionEnabled = false
            self.calendarView.isUserInteractionEnabled = false
            self.viewAppointmentTime.isUserInteractionEnabled = false
            self.collectionViewTimePicker.isUserInteractionEnabled = false
            self.viewGroupSettings.isUserInteractionEnabled = false
            self.viewGroupCount.isUserInteractionEnabled = false
            self.viewMembers.isUserInteractionEnabled = false
            self.viewComments.isUserInteractionEnabled = false
            self.btnSubmitAndNew.isUserInteractionEnabled = false
            self.btnSubmit.isUserInteractionEnabled = true
            // Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
            //GATHER0000923 -- Start
            self.viewPickleBall.isUserInteractionEnabled = false
            //GATHER0000923 -- End
        default:
            break
        }
        
        
        
        //Add member options
        
        //Added by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
        //GATHER0000606 -- Start
        //self.popoverOptions = self.appDelegate.arrEventRegType.filter({$0.name != "My Buddies"})
        
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
        //GATHER0000700 - Start
        //self.popoverOptions = self.appDelegate.addRequestOpt_BMS
        switch self.BMSBookingDepartment
        {
        case .fitnessAndSpa:
            self.popoverOptions = self.appDelegate.addRequestOpt_BMS
        case .tennisBookALesson:
            self.popoverOptions = DataManager.shared.AddRequestOpt_TennisLesson
            //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL add options
            //GATHER0001167 -- Start
        case .golfBookALesson:
            self.popoverOptions = DataManager.shared.addRequestOpt_GolfLesson
            //GATHER0001167 -- End
        case .none:
            break
        }
        //GATHER0000700 - End
        //GATHER0000606 -- End
        
        //Used to not show message if the first date is not available for the first time
        self.isFirstTime = true
        
        //Api Calls
        
        switch self.screenType
        {
        case .request:
             self.getUnAvailableDates()
            
            // Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
            //GATHER0000923 -- Start
            if !self.viewPickleBall.isHidden
            {
                self.selectedServiceCategoty = self.appDelegate.bookingAppointmentDetails.service?.serviceCategoryList?[0]
            }
            //GATHER0000923 -- End
        
        case .modify,.view:
            //Modified by kiran V2.5 -- GATHER0000606 -- Hiding add button when member selection option is empty
            //GATHER0000606 -- Start
            self.btnModifyAdd.isHidden = self.shouldHideAddMemberOptions()
            //GATHER0000606 -- End
            self.getAppointmentDetails()
        default:
            break
        }
        
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
        self.lblAppointmentDate.textColor = APPColor.textColor.secondary
        self.calendarView.appearance.selectionColor = APPColor.MainColours.primary2
    }
    
    ///Updates the time , provider and service details.
    private func updateAppointmentDetails()
    {
        if (self.appDelegate.bookingAppointmentDetails.provider?.providerID ?? "").count > 0
        {
            self.lblProviderName.text = self.appDelegate.bookingAppointmentDetails.provider?.name ?? ""
        }
        else
        {
            //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
            //GATHER0000700 - Start
            
            var providerText = ""
            
            switch self.BMSBookingDepartment {
            case .fitnessAndSpa:
                providerText = self.appDelegate.masterLabeling.BMS_PROVIDERNOT ?? ""
            case .tennisBookALesson:
                providerText = self.appDelegate.masterLabeling.TL_ProfessionalNot_Preferred ?? ""
                //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL provider Not preferred text
                //GATHER0001167 -- Start
            case .golfBookALesson:
                providerText = self.appDelegate.masterLabeling.BMS_Golf_ProviderNotPreferred ?? ""
                //GATHER0001167 -- End
            case .none:
                break
            }
            
            self.lblProviderName.text = providerText
            //self.lblProviderName.text = self.appDelegate.masterLabeling.BMS_PROVIDERNOT ?? ""
            //GATHER0000700 - End
        }
        
        if let gender = self.appDelegate.bookingAppointmentDetails.provider?.gender , (self.appDelegate.bookingAppointmentDetails.provider?.providerID ?? "").count > 0
        {
            var imageName = ""
            var hideGenderImage = false
            switch gender
            {
            case "Male":
                imageName = "male_Blue"
            case "Female":
                imageName = "female_Pink"
            default:
                hideGenderImage = true
            }
            
            self.viewGender.isHidden = hideGenderImage
            if !hideGenderImage
            {
                self.imgViewGender.image = UIImage.init(named: imageName)
            }
        }
        else
        {
            self.viewGender.isHidden = true
        }
        
        self.lblServiceName.text = self.appDelegate.bookingAppointmentDetails.service?.serviceName
        
        self.lblAppointmentDate.text = self.selectedDate
    }
    
    ///Updates the month and year on the claneder view with given date
    private func updateCalendarHeaderViewWith(date : Date)
    {
        self.lblMonth.text = date.getMonth()
        self.lblYear.text = date.getYear()
    }
    
    ///Chanegs the color of today based on isAvailable
    private func setTodayColorBy(isAvailabile : Bool)
    {
        self.calendarView.appearance.todayColor = .clear
        
        if isAvailabile
        {
            self.calendarView.appearance.titleTodayColor = .black
        }
        else
        {
            self.calendarView.appearance.titleTodayColor = .lightGray
        }
    }
    
    ///Updates the selected time from selected date. by dividing it into hours , minutes and period.
    private func updateSelectedTime()
    {
        let date = self.selectedTime?.time?.date(format: "hh:mm a")
        
        self.lblSelectedHour.text = date?.toString(format: "hh")
        
        self.lblSelectedMinutes.text = date?.toString(format: "mm")
        
        self.lblSelectedPeriod.text = date?.toString(format: "a")
    }
    
    ///Updats the Duration lable based on seleted date and by adding the duration of the service.
    private func updateDurationLbl()
    {
        self.lblDuration.text = "\(self.appDelegate.masterLabeling.BMS_Duration ?? "") \(self.generateDurationString())"
    }
    
    ///Setup of member view.
    private func setUpMemberView(type : RequestScreenType?)
    {
        //Hidden for now as the decision was not made to show this yet.
        self.viewModifyCaptainName.isHidden = true
        self.viewModifycaptainID.isHidden = true
        
        self.viewAddMemberLbl.layer.cornerRadius = 6.0
        self.viewAddMemberLbl.layer.borderWidth = 0.25
        self.viewAddMemberLbl.layer.borderColor = hexStringToUIColor(hex: "#2D2D2D").cgColor
        self.viewAddMemberLbl.clipsToBounds = true
        
        switch type {
        case .request:
            self.tblMemberViewTopConstraint.constant = self.tblMemberTopSpace.request
            self.tblMemberViewBottomConstraint.constant = self.tblMemberBottomSpace.request
            self.viewModifyHeader.isHidden = true
        case .modify,.view:
            self.tblMemberViewTopConstraint.constant = self.tblMemberTopSpace.modify
            self.tblMemberViewBottomConstraint.constant = self.tblMemberBottomSpace.modify
            self.viewModifyHeader.isHidden = false
            self.lblAddMember.text = self.appDelegate.masterLabeling.add_member_or_guest
        default:
            break
        }
        
        self.viewMembers.layoutIfNeeded()
    }
    
    
    private func generateDurationString() -> String
    {
        guard let date = self.selectedTime?.time?.date(format: "hh:mm a") else{
            return ""
        }
        
        let fromTime = self.selectedTime?.time//date?.toString(format: "hh:mm a")
        
        let duration = Int(self.appDelegate.bookingAppointmentDetails.service?.duration ?? "0") ?? 0
        
        let todate = Calendar.current.date(byAdding: .minute, value: duration, to: date)
        let toTime = todate?.toString(format: "hh:mm a")
        
        //Modified by kiran V2.7 -- GATHER0000700 -- Book A lesson - replaced the format of duration string with language file.
        //GATHER0000700 -- Start
        let durationString = (self.appDelegate.masterLabeling.BMSDuration_Text ?? "").replacingOccurrences(of: "{#ST}", with: fromTime ?? "").replacingOccurrences(of: "{#ET}", with: toTime ?? "")
        return durationString
        //return "\(fromTime ?? "") to \(toTime ?? "")"
        //GATHER0000700 -- End
    }
    
    ///Performs Gender selection
    private func selectGenderFor(button : UIButton)
    {
        for genderBtn in self.btnGenderCollection
        {
            if genderBtn == button
            {
                genderBtn.setImage(UIImage.init(named: "radio_selected"), for: .normal)
                genderBtn.isSelected = true
                
            }
            else
            {
                genderBtn.setImage(UIImage.init(named: "radio_Unselected"), for: .normal)
                genderBtn.isSelected = false
            }
        
        }
        
        //Note:- Any change in gender filter option values from master list will impact this selection as we are going with posotion. followed this approached instead of using id's to stay in sync with android.
        switch self.btnGenderCollection.filter({$0.isSelected == true}).first
        {
        case self.btnMale:
            self.selectedGender = self.appDelegate.genderFilterOptions[0]
        case self.btnFemale:
            self.selectedGender = self.appDelegate.genderFilterOptions[1]
        case self.btnAny:
            self.selectedGender = self.appDelegate.genderFilterOptions[2]
        default:
            break
        }
        
    }
    
    ///Show/Hides the horizontal time picker view
    private func showPickerView(bool : Bool)
    {
        self.collectionViewTimePicker.isHidden = !bool
        self.viewDuration.isHidden = bool
    }
    
    ///Modifies the member arr based on group type and if captain is given then added to first position
    //Only in request scenario this is used. need to change to include modify scenatio if needed
    private func selectGroup(type : MemberSelectionType , add captain : CaptaineInfo? = nil)
    {
        switch  self.screenType {
        case .request:
            switch type {
            case .single:
                
                let requestData = RequestData.init()
                requestData.isEmpty = true
                
                self.arrMembers = [RequestData]()
                let maxMembers = Int(self.appDelegate.bookingAppointmentDetails.department!.settings!.first!.maxMembersPerAppointment!)!
                self.arrMembers.append(contentsOf: repeatElement(requestData, count: maxMembers))
                
                if let captain = captain
                {
                    if self.arrMembers.count > 0
                    {
                        self.arrMembers.insert(captain, at: 0)
                    }
                    else
                    {
                        self.arrMembers = [captain]
                    }
                }
                
                self.arrMembers.removeSubrange(maxMembers..<self.arrMembers.count)
                self.tblVIewMembers.reloadData()
                
            case .group:
                break
            }
        default:
            break
        }

        
        self.memberSelectionType = type
    }
    
    
    ///Checks today is available. i.e., min number of days is 0
    private func isTodayAvailable() -> Bool
    {
        if self.appDelegate.bookingAppointmentDetails.department?.settings?.first?.minimumDaysinAdvace == "0"
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    
    ///Identifies if the days should be increased for date range based on min or max time.
    private func shouldIncreaseDay(time : String) -> Bool
    {
        let minDate = time.date(format: "hh:mm a")
        //Note : The time is calculated using timeintervalform value. so converting the date to string and then back to date. If this is not done the interval value for current date will be higher beacuse the min date is generated form time string "hh:mm a"
        let currentTime = self.currentDate!.toString(format: "hh:mm a")
        let currentDate = currentTime.date(format: "hh:mm a")
        let result = self.findTimeDiff(time1: minDate!, time2: currentDate!)
        //+ indicates time2 is grateer than time1. hours and mintues comparision
        return result.first == "+"
    }
    
    ///Checks if the date is available
    private func isDateAvailable(date : Date ,minDate : Date) -> Bool
    {
        let comparisionResult = Calendar.current.compare(date, to: minDate, toGranularity: .day)
        
        return (comparisionResult == .orderedSame || comparisionResult == .orderedDescending)
    }
    
    ///Generates the date by addding the days to the current date received form server.
    private func generateDateByAdding(days : Int?) -> Date
    {
        return Calendar.current.date(byAdding: .day, value: days ?? 0 , to: self.currentDate!)!
    }
    
    ///Used for showign popup i reqeust scenario
    private func showPopover(cell : RequestTableViewCell)
    {
        self.memberAddIndex = tblVIewMembers.indexPath(for: cell)
        
        let point = cell.btnAdd.convert(cell.btnAdd.center , to: appDelegate.window)
        
        
        self.addPopup(point: point, arrowOffsetWidth : cell.btnAdd.bounds.size.width/2 + 20 /*20 is padding between view and button trailing*/)
    }
    
    ///Shows member add  popup.
    ///
    /// Uses the origin in the CGRect to identify poision and
    private func addPopup(point : CGPoint , arrowOffsetWidth : CGFloat)
    {
        let addNewView : UIView!
        
        let popoverHeight = self.popoverOptions.count * 50
        addNewView = UIView(frame: CGRect(x: 100, y: 0, width: 180, height: popoverHeight))
        
        self.tblViewAddMembers = UITableView(frame: CGRect(x: 0, y: 5, width: 180, height: popoverHeight))
        
        addNewView.addSubview(self.tblViewAddMembers!)
        
        self.tblViewAddMembers?.dataSource = self
        self.tblViewAddMembers?.delegate = self
        self.tblViewAddMembers?.bounces = true
        //Modified by kiran V3.2 -- ENGAGE0012667 -- tableview on popup list height fix
        //ENGAGE0012667 -- Start
        self.tblViewAddMembers?.sectionHeaderHeight = 0
        //ENGAGE0012667 -- End
        self.popoverAddMember = Popover()
        self.popoverAddMember?.arrowSize = CGSize(width: 30, height: 20)
        
        //let point = cell.btnAdd.convert(cell.btnAdd.center , to: appDelegate.window)
        self.popoverAddMember?.sideEdge = 4.0
        
        let pointt = CGPoint(x: self.view.bounds.width - arrowOffsetWidth, y: point.y - 10)
        
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        if point.y > height - 170{
            self.popoverAddMember?.popoverType = .up
            self.popoverAddMember?.show(addNewView, point: pointt)
            
        }else{
            self.popoverAddMember?.show(addNewView, point: pointt)
            
        }
    }
    //Modified by Kiran V2.7 -- GATHER0000838 - Getting success message for thankyou screen from save api instead of lang file.Changed the completion handler paramter to successpopupdetails class from string.
    //GATHER0000838 -- Start
    ///Performs submit and retuens status bool in callback
    private func performSubmit(status : @escaping ((Bool,SuccessPopupDetails/*String*/) -> ()))
    {
       self.submitRequest(status: {status($0,$1)})
    //GATHER0000838 -- End
    }
    
    ///This is used to generate the member details along with other appointment details. Used for save and validation API's
    private func generateParamaterDict() -> [String : Any]
    {
        //FIXME:- When the request allows more than one member then we will have an issue with empty records as we are not filtering for empty records while submitting.
        //TODO: Filter for empty records and check in modify scenairo too. as sometimes members we receive from details apis will have isEmpty as true.
        
        //Copy of the selected members
        let arrSelectedMembers = self.arrMembers
        
        var arrMemberData = [[String : Any]]()
        
        for (index,member) in arrSelectedMembers.enumerated()
        {
            if let memberDetail = member as? CaptaineInfo
            {
                let memberInfo:[String: Any] = [
                    APIKeys.kAppointmentMemberID : "",
                    APIKeys.kMemberLastName : "",
                    APIKeys.kName : memberDetail.captainName ?? "",
                    APIKeys.kLinkedMemberID : memberDetail.captainID ?? "",
                    APIKeys.kGuestMemberOf : "",
                    APIKeys.kGuestMemberNo : "",
                    APIKeys.kGuestType : "",
                    APIKeys.kGuestName : "",
                    APIKeys.kGuestEmail : "",
                    APIKeys.kGuestContact : "",
                    APIKeys.kDisplayOrder : "\(index + 1)",
                    //Added on 4th September 2020 V2.3
                    APIKeys.kGuestGender :"",
                    APIKeys.kGuestDOB : ""
                ]
                arrMemberData.append(memberInfo)
                
            }
            else if let memberDetail = member as? Detail
            {
                //Added by kiran V2.8 -- ENGAGE0011784 --
                //ENGAGE0011784 -- Start
                let appModule = self.getAppModule(department: self.BMSBookingDepartment)
                let memberType = CustomFunctions.shared.memberType(details: member, For: appModule)
               
                switch memberType
                {
                case .guest:
                    let memberInfo:[String: Any] = [
                        
                        APIKeys.kAppointmentMemberID : memberDetail.appointmentMemberID ?? "",
                        APIKeys.kMemberLastName : "",
                        APIKeys.kName : "",
                        APIKeys.kLinkedMemberID : "",
                        APIKeys.kGuestMemberOf : memberDetail.guestMemberOf ?? "",// UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                        APIKeys.kGuestMemberNo : "",
                        APIKeys.kGuestType : memberDetail.guestType ?? "",
                        APIKeys.kGuestName : memberDetail.guestName ?? "",
                        APIKeys.kGuestEmail : memberDetail.email ?? "",
                        APIKeys.kGuestContact : memberDetail.cellPhone ?? "",
                        APIKeys.kDisplayOrder : "\(index + 1)",
                        //Added on 4th September 2020 V2.3
                        APIKeys.kGuestGender : memberDetail.guestGender ?? "",
                        APIKeys.kGuestDOB : memberDetail.guestDOB ?? "",
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        APIKeys.kGuestFirstName : memberDetail.guestFirstName ?? "",
                        APIKeys.kGuestLastName : memberDetail.guestLastName ?? "",
                        APIKeys.kGuestLinkedMemberID : memberDetail.guestLinkedMemberID ?? "",
                        APIKeys.kGuestIdentityID : memberDetail.guestIdentityID ?? ""
                        //ENGAGE0011784 -- End
                        
                    ]
                    
                    arrMemberData.append(memberInfo)
                case .existingGuest:
                    
                    let memberInfo:[String: Any] = [
                        
                        APIKeys.kAppointmentMemberID : memberDetail.appointmentMemberID ?? "",
                        APIKeys.kMemberLastName : "",
                        APIKeys.kName : memberDetail.name ?? "",
                        APIKeys.kLinkedMemberID : memberDetail.id ?? "",
                        APIKeys.kGuestMemberOf : memberDetail.guestMemberOf ?? "",
                        APIKeys.kGuestMemberNo : "",
                        APIKeys.kGuestType : "",
                        APIKeys.kGuestName : "",
                        APIKeys.kGuestEmail : "",
                        APIKeys.kGuestContact : "",
                        APIKeys.kDisplayOrder : "\(index + 1)",
                        APIKeys.kGuestGender : "",
                        APIKeys.kGuestDOB : "",
                        APIKeys.kGuestLinkedMemberID : memberDetail.guestLinkedMemberID ?? "",
                        APIKeys.kGuestIdentityID : memberDetail.guestIdentityID ?? ""

                    ]
                    
                    //TODO:- Remove after approval
                    /*
                    let memberInfo:[String: Any] = [
                        
                        APIKeys.kAppointmentMemberID : memberDetail.appointmentMemberID ?? "",
                        APIKeys.kMemberLastName : "",
                        APIKeys.kName : "",
                        APIKeys.kLinkedMemberID : memberDetail.id ?? "",
                        APIKeys.kGuestMemberOf : memberDetail.guestMemberOf ?? "",// UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                        APIKeys.kGuestMemberNo : "",
                        APIKeys.kGuestType : memberDetail.guestType ?? "",
                        APIKeys.kGuestName : memberDetail.guestName ?? "",
                        APIKeys.kGuestEmail : memberDetail.email ?? "",
                        APIKeys.kGuestContact : memberDetail.cellPhone ?? "",
                        APIKeys.kDisplayOrder : "\(index + 1)",
                        //Added on 4th September 2020 V2.3
                        APIKeys.kGuestGender : memberDetail.guestGender ?? "",
                        APIKeys.kGuestDOB : memberDetail.guestDOB ?? "",
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        APIKeys.kGuestFirstName : memberDetail.guestFirstName ?? "",
                        APIKeys.kGuestLastName : memberDetail.guestLastName ?? "",
                        APIKeys.kGuestLinkedMemberID : memberDetail.guestLinkedMemberID ?? ""
                        //ENGAGE0011784 -- End
                        
                    ]
                    */
                    arrMemberData.append(memberInfo)
                case .member:
                    let memberInfo:[String: Any] = [
                        
                        APIKeys.kAppointmentMemberID : memberDetail.appointmentMemberID ?? "",
                        APIKeys.kMemberLastName : "",
                        APIKeys.kName : memberDetail.name ?? "",
                        APIKeys.kLinkedMemberID : memberDetail.id ?? "",
                        APIKeys.kGuestMemberOf : "",
                        APIKeys.kGuestMemberNo : "",
                        APIKeys.kGuestType : "",
                        APIKeys.kGuestName : "",
                        APIKeys.kGuestEmail : "",
                        APIKeys.kGuestContact : "",
                        APIKeys.kDisplayOrder : "\(index + 1)",
                        //Added on 4th September 2020 V2.3
                        APIKeys.kGuestGender : "",
                        APIKeys.kGuestDOB : ""

                    ]
                    
                    arrMemberData.append(memberInfo)
                }
                
                //Old code
              /*
                var isGuest : Bool?
                
                switch self.screenType {
                case .request:
                    isGuest = memberDetail.id == nil
                case .modify,.view:
                    //Only for BMS Guest shouid be identified by name as guest will return ID (liked member id) in get Appointment response
                    isGuest = !(memberDetail.guestName == nil || memberDetail.guestName == "")
                default:
                    break
                }
                
                if isGuest == true
                {
                    let memberInfo:[String: Any] = [
                        
                        APIKeys.kAppointmentMemberID : memberDetail.appointmentMemberID ?? "",
                        APIKeys.kMemberLastName : "",
                        APIKeys.kName : "",
                        APIKeys.kLinkedMemberID : "",
                        APIKeys.kGuestMemberOf : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                        APIKeys.kGuestMemberNo : "",
                        APIKeys.kGuestType : memberDetail.guestType ?? "",
                        APIKeys.kGuestName : memberDetail.guestName ?? "",
                        APIKeys.kGuestEmail : memberDetail.email ?? "",
                        APIKeys.kGuestContact : memberDetail.cellPhone ?? "",
                        APIKeys.kDisplayOrder : "\(index + 1)",
                        //Added on 4th September 2020 V2.3
                        APIKeys.kGuestGender : memberDetail.guestGender ?? "",
                        APIKeys.kGuestDOB : memberDetail.guestDOB ?? "",
                        
                    ]
                    
                    arrMemberData.append(memberInfo)
                    
                }
                else
                {
                    let memberInfo:[String: Any] = [
                        
                        APIKeys.kAppointmentMemberID : memberDetail.appointmentMemberID ?? "",
                        APIKeys.kMemberLastName : "",
                        APIKeys.kName : memberDetail.name ?? "",
                        APIKeys.kLinkedMemberID : memberDetail.id ?? "",
                        APIKeys.kGuestMemberOf : "",
                        APIKeys.kGuestMemberNo : "",
                        APIKeys.kGuestType : "",
                        APIKeys.kGuestName : "",
                        APIKeys.kGuestEmail : "",
                        APIKeys.kGuestContact : "",
                        APIKeys.kDisplayOrder : "\(index + 1)",
                        //Added on 4th September 2020 V2.3
                        APIKeys.kGuestGender : "",
                        APIKeys.kGuestDOB : ""

                    ]
                    
                    arrMemberData.append(memberInfo)
                }
                */
                //ENGAGE0011784 -- End
            }
            else if let memberDetail = member as? MemberInfo
            {
                
                let memberInfo:[String: Any] = [
                    
                    APIKeys.kAppointmentMemberID : "",
                    APIKeys.kMemberLastName : memberDetail.lastName ?? "",
                    APIKeys.kName : memberDetail.memberName ?? "",
                    APIKeys.kLinkedMemberID : memberDetail.id ?? "",
                    APIKeys.kGuestMemberOf : "",
                    APIKeys.kGuestMemberNo : "",
                    APIKeys.kGuestType : "",
                    APIKeys.kGuestName : "",
                    APIKeys.kGuestEmail : "",
                    APIKeys.kGuestContact : "",
                    APIKeys.kDisplayOrder : "\(index + 1)",
                    //Added on 4th September 2020 V2.3
                    APIKeys.kGuestGender : "",
                    APIKeys.kGuestDOB : ""

                ]
                arrMemberData.append(memberInfo)
            }
            else if let memberDetail = member as? GuestInfo
            {
                //For existing guest only details sent for member are required.Used same object for guest and existing guest as other details a not considered in backend
                let memberInfo:[String: Any] = [
                    //TODO:- Once the modify scenario of AddGuestRegVC is changed send Empty string only.
                    APIKeys.kAppointmentMemberID : memberDetail.appointmentMemberID ?? "",//"",
                    APIKeys.kMemberLastName : "",
                    APIKeys.kName : "",
                    //TODO:- Once the modify scenario of AddGuestRegVC is changed send Empty string only.
                    APIKeys.kLinkedMemberID : memberDetail.linkedMemberID ?? "",//"",
                    APIKeys.kGuestMemberOf : memberDetail.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                    //TODO:- Once the modify scenario of AddGuestRegVC is changed send Empty string only.
                    APIKeys.kGuestMemberNo : memberDetail.guestMemberNo ?? "",//"",
                    APIKeys.kGuestType : memberDetail.guestType ?? "",
                    APIKeys.kGuestName : memberDetail.guestName ?? "",
                    APIKeys.kGuestEmail : memberDetail.email ?? "",
                    APIKeys.kGuestContact : memberDetail.cellPhone ?? "",
                    APIKeys.kDisplayOrder : "\(index + 1)",
                    //Added on 4th September 2020 V2.3
                    APIKeys.kGuestGender : memberDetail.guestGender ?? "",
                    APIKeys.kGuestDOB : memberDetail.guestDOB ?? "",
                    //Added by kiran V2.8 -- ENGAGE0011784 --
                    //ENGAGE0011784 -- Start
                    APIKeys.kGuestFirstName : memberDetail.guestFirstName ?? "",
                    APIKeys.kGuestLastName : memberDetail.guestLastName ?? "",
                    APIKeys.kGuestLinkedMemberID : memberDetail.guestLinkedMemberID ?? "",
                    APIKeys.kGuestIdentityID : memberDetail.guestIdentityID ?? ""
                    //ENGAGE0011784 -- End
                ]
                arrMemberData.append(memberInfo)
            }
            
        }
        
        let paramaterDict : [String : Any] = [
            APIHeader.kContentType :"application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kdeviceInfo : [APIHandler.devicedict],
            APIKeys.kIsAdmin : "0",
            APIKeys.kusername: UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
            APIKeys.kRole : "Member",
            APIKeys.kUserID : "",
            APIKeys.kLocationID : self.appDelegate.bookingAppointmentDetails.department?.locationID ?? "",
            APIKeys.kServiceID : self.appDelegate.bookingAppointmentDetails.service?.serviceID ?? "",
            APIKeys.kProductClassID : self.appDelegate.bookingAppointmentDetails.serviceType?.productClassID ?? "",
            APIKeys.kProviderID : self.appDelegate.bookingAppointmentDetails.provider?.providerID ?? "",
            APIKeys.kProviderGender : self.selectedGender?.Id ?? "",
            APIKeys.kAppointmentType : self.memberSelectionType?.rawValue ?? "",
            APIKeys.kAppointmentDate : self.selectedDate ?? "",
            APIKeys.kAppointmentTime : self.selectedTime?.time ?? "",
            APIKeys.kAppointmentDetailID : self.appDelegate.bookingAppointmentDetails.appointmentID ?? "",
            APIKeys.kMemberCount : "\(arrMemberData.count)",
            APIKeys.kDetails : arrMemberData,
            APIKeys.kComments : self.textViewComments.text ?? "",
            // Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
            //GATHER0000923 -- Start
            APIKeys.kServiceCategoryID : self.selectedServiceCategoty?.serviceCategoryID ?? ""
            //GATHER0000923 -- End
        ]
        
        return paramaterDict
    }
    
    private func showMemberDirecotry()
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
            //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
            //GATHER0000700 - Start
            var departmentType = ""
            switch self.BMSBookingDepartment
            {
            case .fitnessAndSpa:
                departmentType = "FitnessSpa"
            case .tennisBookALesson:
                departmentType = BMSDepartment.tennisBookALesson.rawValue
                //Added by kiran V2.9 -- GATHER0001167 -- Member Directory Golf BAL support
                //GATHER0001167 -- Start
            case .golfBookALesson:
                departmentType = BMSDepartment.golfBookALesson.rawValue
                //GATHER0001167 -- End
            case .none:
                break
            }
            
            memberDirectory.isOnlyFrom = departmentType//"FitnessSpa"
            memberDirectory.categoryForBuddy = departmentType//"FitnessSpa"
            //GATHER0000700 - End
            memberDirectory.isFrom = "Registration"
            memberDirectory.isFor = "OnlyMembers"
            memberDirectory.showSegmentController = true
            memberDirectory.requestID = self.appDelegate.bookingAppointmentDetails.appointmentID ?? ""
            memberDirectory.selectedDate = self.selectedDate
            memberDirectory.selectedTime = self.selectedTime?.time
            //MOdified on 4th September 2020 V2.3
            memberDirectory.membersData = self.arrMembers
            //memberDirectory.memberDetails = self.arrMembers
            memberDirectory.appointmentType = self.memberSelectionType
            memberDirectory.hideAddToBuddy = true
            memberDirectory.delegate = self
            navigationController?.pushViewController(memberDirectory, animated: true)
        }
        
    }
    
    //Modified on 5th September 2020 V2.3
    //Added screen type age geust to add support for modify of guest
    private func showAddGuest(screenType: GuestScreenType,guest : RequestData? = nil)
    {
        if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddGuestRegVC") as? AddGuestRegVC
        {
            regGuest.memberDelegate = self
            
            //Added by kiran V2.8 -- ENGAGE0011784 --
            //ENGAGE0011784 -- Start
            
            //Commented as these are replaced with screenType and usedForModule.
            //regGuest.isFrom = "Request"
            //Modified by Kiran V2.7 -- GATHER0000700 - Changed fitnessSpa with generic code BMS as add geusts screen should behave same for fitness & spa and Tennis book a lesson.
            //GATHER0000700 - Start
            //regGuest.isOnlyFor = "BMS"//"FitnessSpa"
            //GATHER0000700 - End
            
            regGuest.usedForModule = self.getAppModule(department: self.BMSBookingDepartment)
            regGuest.requestDates = [self.selectedDate ?? ""]
            regGuest.requestTime = self.selectedTime?.time ?? ""
            regGuest.requestID = self.appDelegate.bookingAppointmentDetails.appointmentID ?? ""
            regGuest.appointmentType = self.memberSelectionType
            regGuest.arrAddedMembers = [self.arrMembers]
            regGuest.BMSDepartmentName = self.appDelegate.bookingAppointmentDetails.department?.departmentName
            //regGuest.usedForModule = .BMS
            //ENGAGE0011784 -- End
            
            regGuest.hideAddtoBuddy = true
            regGuest.hideExistingGuestAddToBuddy = true
            //Added on 4th Septmeber 2020 V2.3
            regGuest.isGenderHidden = false
            
            //Added on 24th September 2020 V2.3
            regGuest.isDOBHidden = false
            
            //Added by kiran V2.8 -- ENGAGE0011784 -- showing the existing guest feature
            //ENGAGE0011784 -- Start
            regGuest.showExistingGuestsOption = true
            regGuest.enableGuestNameSuggestions = false
            //ENGAGE0011784 -- End
            
            regGuest.screenType = screenType
            if let guestData = guest
            {
                regGuest.arrTotalList = [guestData]
            }
            
            navigationController?.pushViewController(regGuest, animated: true)
        }
    }
    //Modified by Kiran V2.7 -- GATHER0000838 - Getting success message for thankyou screen from save api instead of lang file.Changed the image path paramater with SuccessPopupDetails class.
    //GATHER0000838 -- Start
    //private func showThankyouScreen(imagePath : String ,closed : @escaping (()->()))
    private func showThankyouScreen(details : SuccessPopupDetails ,closed : @escaping (()->()))
    {//GATHER0000838 -- End
        let vc = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "BMSThankYouVC") as! BMSThankYouVC
        
        //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes.
        //GATHER0000700 - Start
        
        //Added by kiran V1.4 -- PROD0000121 -- change the logic to get the success popup department string from API
        //PROD0000121 -- Start
        
        vc.strDepartment = details.successHeader ?? ""
        //Old Logic
        /*
        var departmentString = ""
        
        switch self.BMSBookingDepartment
        {
        case .fitnessAndSpa:
            
            departmentString = "\(self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "") \(self.appDelegate.masterLabeling.BMS_Request ?? "")"
            
        case .tennisBookALesson:
            departmentString = "\(self.appDelegate.masterLabeling.TL_TennisLesson ?? "") \(self.appDelegate.masterLabeling.BMS_Request ?? "")"
            //Added by kiran V2.9 -- GATHER0001167 -- Thank You screen GOlf BAL message support
            //GATHER0001167 -- Start
        case .golfBookALesson:
            departmentString = "\(self.appDelegate.masterLabeling.BMS_GolfLesson ?? "") \(self.appDelegate.masterLabeling.BMS_Golf_Request ?? "")"
            //GATHER0001167 -- End
        case .none:
            break
        }
        
        vc.strDepartment = departmentString
         */
        //PROD0000121 -- End
        
        //vc.strDepartment = "\(self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "") \(self.appDelegate.masterLabeling.BMS_Request ?? "")"
        //GATHER0000700 - End
        vc.strService = self.appDelegate.bookingAppointmentDetails.service?.serviceName ?? ""
        vc.strDate = self.selectedDate ?? ""
        vc.strTime = self.generateDurationString()
        vc.strThankyou = self.appDelegate.masterLabeling.thank_You ?? ""
        //Modified by Kiran V2.7 -- GATHER0000838 - Getting success message for thankyou screen from save api instead of lang file.Commented old code and fetched the image path also from the new class.
        //GATHER0000838 -- Start
        vc.imagePath = details.backgroundImage ?? ""
        //vc.imagePath = imagePath
        
        //Added by kiran V2.5 -- GATHER0000586 -- Added representative message
        //GATHER0000586 -- Start
        
        //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes.
        //GATHER0000700 - Start
        
        //Commented by kiran V2.7 -- GATHER0000838
        /*
        var repMessage = ""
        var successMessage = ""
        
        switch self.BMSBookingDepartment
        {
        case .fitnessAndSpa:
            
            switch self.screenType
            {
            case .request:
                successMessage = self.appDelegate.masterLabeling.BMS_SubmitMessage ?? ""
            case .modify:
                successMessage = self.appDelegate.masterLabeling.BMS_Modify ?? ""
            default:
                break
            }
            
            repMessage = (self.appDelegate.masterLabeling.BMS_SubmitMessageRep ?? "")
            //repMessage = (self.appDelegate.masterLabeling.BMS_SubmitMessageRep ?? "").replacingOccurrences(of: "{#NL}", with: "\n").replacingOccurrences(of: "{#BMSD}", with: self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "")
            
        case .tennisBookALesson:
            
            switch self.screenType
            {
            case .request:
                successMessage = self.appDelegate.masterLabeling.TL_SubmitMessage ?? ""
            case .modify:
                successMessage = self.appDelegate.masterLabeling.TL_Modify ?? ""
            default:
                break
            }
            
            repMessage = (self.appDelegate.masterLabeling.TL_SubmitMessageRep ?? "")
            //repMessage = (self.appDelegate.masterLabeling.TL_SubmitMessageRep ?? "").replacingOccurrences(of: "{#NL}", with: "\n").replacingOccurrences(of: "{#BMSD}", with: self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "")
            
        case .none:
            break
        }
        
        //remove once approved for porduction
        //let repMessage = (self.appDelegate.masterLabeling.BMS_SubmitMessageRep ?? "").replacingOccurrences(of: "{#NL}", with: "\n").replacingOccurrences(of: "{#BMSD}", with: self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "")
        
        vc.strSuccessMessage = (successMessage + repMessage).replacingOccurrences(of: "{#NL}", with: "\n").replacingOccurrences(of: "{#BMSD}", with: self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "")
        //vc.strSuccessMessage = self.screenType == .modify ? (self.appDelegate.masterLabeling.BMS_Modify ?? "") : self.appDelegate.masterLabeling.BMS_SubmitMessage ?? ""
        */
        
        vc.strSuccessMessage = (details.successMessage ?? "").replacingOccurrences(of: "{#NL}", with: "\n").replacingOccurrences(of: "{#BMSD}", with: self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "")
        
        //GATHER0000838 -- End
        //GATHER0000700 - End
        //GATHER0000586 -- End
        vc.closeClicked = {
            closed()
        }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    private func handleError(error : Error)
    {
        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
    }
    
    private func hasSelectedMaxMembers() -> Bool
    {
       return self.arrMembers.count < Int(self.appDelegate.bookingAppointmentDetails.department!.settings!.first!.maxMembersPerAppointment!)!
    }
    
    //Added on 8th July 2020 V2.2
    ///Navigates to a screen when cancel is clicked
    private func cancelNavigation()
    {
        self.appDelegate.closeFrom = "BMSFlow"
        
        for vc in self.navigationController!.viewControllers
        {
            if let vc = vc as? GolfCalendarVC
            {
                _ = self.navigationController?.popToViewController(vc, animated: true)
                return
                
            }
            else if let vc = vc as? CalendarOfEventsViewController
            {
                _ = self.navigationController?.popToViewController(vc, animated: true)
                return
            }
            
        }

    }
    
    ///Assigns gender from id for no preference gender view.
    private func selectGenderFor(id: String?)
    {
        //Note:- Any change in gender filter option values from master list will impact this selection as we are going with posotion. followed this approached instead of using id's to stay in sync with android.
        var genderBtn : UIButton!
        if id == self.appDelegate.genderFilterOptions[0].Id
        {
            genderBtn = self.btnMale
        }
        else if id == self.appDelegate.genderFilterOptions[1].Id
        {
            genderBtn = self.btnFemale
        }
        else
        {
            //This is a deafult selection. If we receive id as empty or nil or ID of ANY then this is used.
            genderBtn = self.btnAny
        }
        self.selectGenderFor(button: genderBtn)
    }
    
    //Added on 5th September 2020 V2.3
    //Identifies if the member wrapped in ibject Detail is a guest or not.
    private func isMemberGuest(member : RequestData) -> Bool
    {
        //Existing guest is treated as member and edit icon should not be shown so existing guest is considered a member in this logic
        var isGuest = false
        
       
        let module = self.getAppModule(department: self.BMSBookingDepartment)
        let memberType = CustomFunctions.shared.memberType(details: member, For: module)
        
        switch memberType
        {
        case .guest:
            isGuest = true
        case .existingGuest,.member:
            isGuest = false
        }
        /*
        switch self.screenType {
        case .request:
            isGuest = member.id == nil
        case .modify,.view:
            //Only for BMS Guest should be identified by name as guest will return ID (liked member id) in get Appointment response.If guest name exist then the member is treated as guest.
            isGuest = !(member.guestName == nil || member.guestName == "")
        default:
            break
        }*/
        return isGuest
    }
    
    //Added on 5th September 2020 V2.3
    //Action when guest edit ic clicked
    private func performGuestModify(member : RequestData)
    {
        var allowEdit = false
        if let _ = member as? GuestInfo
        {
            allowEdit = true
        }
        else if let member = member as? Detail
        {
            allowEdit = self.isMemberGuest(member: member)
        }
        
        if allowEdit
        {
            self.isModifyClicked = true
            self.showAddGuest(screenType: .modify, guest: member)
        }
    }
    
    //Added by kiran V2.5 -- GATHER0000606 -- Logic which indicates if add member button should be displayed or not
    //GATHER0000606 -- Start
    ///Indicates if add member button should be shown. only applicable for single member add not multi select
    private func shouldHideAddMemberOptions() -> Bool
    {
        return !(self.popoverOptions.count > 0)
    }
    //GATHER0000606 -- End
    
    //Added by kiran V2.8 -- ENGAGE0011784 --
    //ENGAGE0011784 -- Start
    private func getAppModule(department : BMSDepartment) -> AppModules
    {
        var appModule : AppModules = .BMS
        
        switch self.BMSBookingDepartment
        {
        case .fitnessAndSpa:
            appModule = .fitnessSpa
        case .tennisBookALesson:
            appModule = .bookALessonTennis
            //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL Support
            //GATHER0001167 -- Start
        case .golfBookALesson:
            appModule = .bookALessonGolf
            //GATHER0001167 -- End
        case .none:
            break
        }
        
        return appModule
    }
    //ENGAGE0011784 -- End
}

//MARK:- Api Methods
extension SpaAndFitnessRequestVC
{
    ///Fetches Unavailable dates
    private func getUnAvailableDates()
    {
        guard Network.reachability?.isReachable == true else {
            SharedUtlity.sharedHelper().showToast(on:
            self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            return
            
        }
        
        let paramaterDict:[String: Any] = [
            "Content-Type":"application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kProviderID : self.appDelegate.bookingAppointmentDetails.provider?.providerID ?? "",
            APIKeys.kServiceID : self.appDelegate.bookingAppointmentDetails.service?.serviceID ?? "",
            APIKeys.kProductClassID: self.appDelegate.bookingAppointmentDetails.serviceType?.productClassID ?? "",
            APIKeys.kLocationID: self.appDelegate.bookingAppointmentDetails.department?.locationID ?? "",
            APIKeys.kStatus : "",
            APIKeys.kAppointmentDetailID : self.appDelegate.bookingAppointmentDetails.appointmentID ?? ""
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        APIHandler.sharedInstance.getAppointmentAvailableDates(paramater: paramaterDict, onSuccess: { (dates) in
            
            //KVO refreshes Calendar view
            self.arrUnAvailabeDates = dates.unAvailableDates ?? [BDates]()
            
            self.appDelegate.hideIndicator()
            
            switch self.screenType
            {
            case .request:
                // self.getAppointmentAvailableTimes()
                break
            default:
                break
            }
            
//            if self.screenType == .modify || self.screenType == .request
//            {
//                self.validateMembers {}
//            }
            
        }) { (error) in
            self.appDelegate.hideIndicator()
            self.handleError(error: error)
        }
        
    }
    
    ///Fetches available times for request
    private func getAppointmentAvailableTimes()
    {
        guard Network.reachability?.isReachable == true else {
            SharedUtlity.sharedHelper().showToast(on:
            self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            return
            
        }
        
        let paramaterDict:[String: Any] = [
            "Content-Type":"application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kProviderID : self.appDelegate.bookingAppointmentDetails.provider?.providerID ?? "",
            APIKeys.kServiceID : self.appDelegate.bookingAppointmentDetails.service?.serviceID ?? "",
            APIKeys.kProductClassID: self.appDelegate.bookingAppointmentDetails.serviceType?.productClassID ?? "",
            APIKeys.kLocationID: self.appDelegate.bookingAppointmentDetails.department?.locationID ?? "",
            APIKeys.kAppointmentDate : self.selectedDate ?? "",
            APIKeys.kStatus : "",
            APIKeys.kAppointmentDetailID : self.appDelegate.bookingAppointmentDetails.appointmentID ?? ""
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        APIHandler.sharedInstance.getAppointmentAvailableTimes(paramater: paramaterDict, onSuccess: { (availableTimes) in
            
            self.arrAvailableTimes = availableTimes.availableTimeList ?? [BTimes]()
            //KVO refreshes collectionview and udpates the selected time
            
            //selected tiem is only nil when screen is first loaded for request scenario and when ever date is selected. this comparision prevents the validation when member first loads for modify scenario.
            if self.selectedTime == nil
            {
                self.selectedTime = self.arrAvailableTimes.first
                self.validateMembers {}
            }
            
            self.appDelegate.hideIndicator()
            
        }) { (error) in
            self.appDelegate.hideIndicator()
            self.handleError(error: error)
        }
        
    }
    
    ///Validates members and perfroms a call back on success
    private func validateMembers(onSuccess : @escaping (() -> ()))
    {
        guard Network.reachability?.isReachable == true else {
            SharedUtlity.sharedHelper().showToast(on:
            self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            return
            
        }
        
        let paramaterDict = self.generateParamaterDict()
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        APIHandler.sharedInstance.getAppointmentValidation(paramater: paramaterDict, onSuccess: { (status) in
            
            self.appDelegate.hideIndicator()
            
            if status.details?.count == 0
            {
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:status.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
            }
            else
            {
                if status.responseCode == InternetMessge.kSuccess
                {
                    self.isFirstTime = false
                    onSuccess()
                }
                else
                {
                    if self.isFirstTime
                    {
                         
                    }
                    else
                    {
                        if let impVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ImpotantContactsVC") as? ImpotantContactsVC
                        {
                            impVC.importantContactsDisplayName = status.brokenRules?.fields?[0] ?? ""
                            impVC.isFrom = "Reservations"
                            impVC.arrList = status.details!
                            impVC.modalTransitionStyle   = .crossDissolve;
                            impVC.modalPresentationStyle = .overCurrentContext
                            self.present(impVC, animated: true, completion: nil)
                        }
                        
                    }
                }
                
            }
            
           self.isFirstTime = false
            
        }) { (error) in
            
            self.appDelegate.hideIndicator()
            self.handleError(error: error)
        }

    }
    
    //Modified by Kiran V2.7 -- GATHER0000838 - Getting success message for thankyou screen from save api instead of lang file.Changed the string paramater in call back to successpopupDetails class.
    //GATHER0000838 -- Start
    private func submitRequest(status : @escaping ((Bool,SuccessPopupDetails/*String*/) -> ()))
    {//GATHER0000838 -- End
        guard Network.reachability?.isReachable == true else {
            SharedUtlity.sharedHelper().showToast(on:
            self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            return
        }
        
        let paramaterDict = generateParamaterDict()
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        APIHandler.sharedInstance.saveAppointment(paramater: paramaterDict, onSuccess: { (response) in
            
            self.appDelegate.hideIndicator()
            
            if response.responseCode == InternetMessge.kSuccess
            {
                //Modified by Kiran V2.7 -- GATHER0000838 - Getting success message for thankyou screen from save api instead of lang file.
                //GATHER0000838 -- Start
                let details = SuccessPopupDetails.init()
                details.backgroundImage = response.imagePath
                details.successMessage = response.responseMessage
                //Added by kiran V1.4 -- PROD0000121 -- success popup department name string
                //PROD0000121 -- Start
                details.successHeader = response.BMS_Success_Header
                //PROD0000121 -- End
                status(true,details)
                //status(true,response.imagePath ?? "")
                //GATHER0000838 -- End
            }
            else
            {
                if response.details?.count ?? 0 == 0
                {
                    SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                }
                else
                {
                    if let impVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ImpotantContactsVC") as? ImpotantContactsVC
                    {
                        impVC.importantContactsDisplayName = response.brokenRules?.fields?[0] ?? ""
                        impVC.isFrom = "Reservations"
                        impVC.arrList = response.details!
                        impVC.modalTransitionStyle   = .crossDissolve;
                        impVC.modalPresentationStyle = .overCurrentContext
                        self.present(impVC, animated: true, completion: nil)
                        
                    }
                    
                }
                
            }
        }) { (error) in
            self.appDelegate.hideIndicator()
            self.handleError(error: error)
        }
    }
    
    
    private func getAppointmentDetails()
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
        APIKeys.kAppointmentID : self.appDelegate.bookingAppointmentDetails.appointmentID!]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        APIHandler.sharedInstance.getAppointment(paramater: paramaterDict, onSuccess: { (appointment) in
            
            let appointmentDetails = appointment.appointmentDetails!.first!
                                
            let btime = BTimes()
            btime.time = appointmentDetails.appointmentTime
            self.selectedTime = btime
            
            //Selected date should always be assigned after time as when date is assigned KVO trigers getAppointmentAvailableTimes api which after completion calls validation Api
            self.selectedDate = appointmentDetails.appointmentDate
            
            if let members = self.appDelegate.bookingAppointmentDetails.members
            {
                self.arrMembers = members
            }
            else
            {
                self.arrMembers = appointmentDetails.details!
            }
            
            self.tblVIewMembers.reloadData()
            
            self.textViewComments.text = self.appDelegate.bookingAppointmentDetails.comments ?? appointmentDetails.comments
            
            self.appDelegate.BMS_cancelReasons = appointmentDetails.cancelReasonList ?? [CancelReason]()
            
            
            switch self.screenType
            {
            case .view:
                self.appDelegate.bookingAppointmentDetails.service?.duration = appointmentDetails.duration
                self.appDelegate.bookingAppointmentDetails.service?.serviceName = appointmentDetails.serviceName
                self.appDelegate.bookingAppointmentDetails.provider?.providerID = appointmentDetails.providerID
                if let providerID = appointmentDetails.providerID, providerID.count > 0
                {
                    self.appDelegate.bookingAppointmentDetails.provider?.name = appointmentDetails.providerName
                    self.appDelegate.bookingAppointmentDetails.provider?.gender = appointmentDetails.providerGender
                }
                else
                {
                     //Note:- Any change in gender filter option values from master list will impact this selection as we are going with posotion. followed this approached instead of using id's to stay in sync with android.
                    
                    //Modified on
                    self.selectGenderFor(id: appointmentDetails.providerGender)
                    //TODO:- remove after approval
                    /*
                    if appointmentDetails.providerGender == self.appDelegate.genderFilterOptions[0].Id
                    {
                        self.selectGenderFor(button: self.btnMale)
                    }
                    else if appointmentDetails.providerGender == self.appDelegate.genderFilterOptions[1].Id
                    {
                        self.selectGenderFor(button: self.btnFemale)
                    }
                    else
                    {
                        self.selectGenderFor(button: self.btnAny)
                    }*/
                    
                    
                }
                
                self.updateAppointmentDetails()
                self.updateDurationLbl()
                
                if self.appDelegate.bookingAppointmentDetails.department?.settings?.first?.app_ShowProviderAfterSubmit == "0"
                {
                    self.viewGender.isHidden = true
                    self.lblProviderName.text = ""
                    self.ViewGenderSelect.isHidden = true
                }
                
                // Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
                //GATHER0000923 -- Start
                if let categoryName = appointment.appointmentDetails?.first?.categoryName , categoryName.count > 0
                {
                    self.viewPickleBall.isHidden = false
                    self.txtFieldPickleBall.text = categoryName
                }
                //GATHER0000923 -- End
                
            case .modify:
                
                //This is for the case when no preference was selected at the type of request and when no preference is selectied event while modify(i.e., didnt change no preference selection in modify adn let it be same as request)
                if (appointmentDetails.providerID?.count ?? 0) < 1 && (self.appDelegate.bookingAppointmentDetails.provider?.providerID?.count ?? 0) < 1
                {
                     //Note:- Any change in gender filter option values from master list will impact this selection as we are going with posotion. followed this approached instead of using id's to stay in sync with android.
                    //Comparing with Position of geneder options
                    
                    //Modified on 18th August 2020 V2.3
                    //TODO:- Remove after approval
                    //var genderBtn : UIButton!
                    //if the previous selection stored in app delegate is nil we go with the data given in details API.
                    //The providerGender object (i.e., FilterOption). will exist with all its variable as Nil When default selection has to be selected. Using empty as indicator for default as the very first time we come to this screen providerGender will be nil.
                    if let providerGender = self.appDelegate.bookingAppointmentDetails.providerGender
                    {
                        self.selectGenderFor(id: providerGender.Id)
                        //TODO:- Remove after approval
                        /*
                        if providerGender.Id == self.appDelegate.genderFilterOptions[0].Id
                        {
                            genderBtn = self.btnMale
                        }
                        else if providerGender.Id == self.appDelegate.genderFilterOptions[1].Id
                        {
                            genderBtn = self.btnFemale
                        }
                        else
                        {
                            //This is a deafult selection. If we receive id as empty or nil or ID of ANY then this is used.
                            genderBtn = self.btnAny
                        }*/
                    }
                    else
                    {
                        self.selectGenderFor(id: appointmentDetails.providerGender)
                        //TODO:- Remove after approval
                        /*
                        if appointmentDetails.providerGender == self.appDelegate.genderFilterOptions[0].Id
                        {
                            genderBtn = self.btnMale
                        }
                        else if appointmentDetails.providerGender == self.appDelegate.genderFilterOptions[1].Id
                        {
                            genderBtn =  self.btnFemale
                        }
                        else
                        {
                            genderBtn = self.btnAny
                        }*/
                    }
                     //TODO:-Remove after approval
                   // self.selectGenderFor(button: genderBtn)
//                    if appointmentDetails.providerGender == self.appDelegate.genderFilterOptions[0].Id
//                    {
//                        self.selectGenderFor(button: self.btnMale)
//                    }
//                    else if appointmentDetails.providerGender == self.appDelegate.genderFilterOptions[1].Id
//                    {
//                        self.selectGenderFor(button: self.btnFemale)
//                    }
//                    else
//                    {
//                        self.selectGenderFor(button: self.btnAny)
//                    }
                    
                    
                }//This is for the scenario when
                else if self.appDelegate.bookingAppointmentDetails.provider?.providerID?.count ?? 0 == 0
                {
                    let providerGender = self.appDelegate.bookingAppointmentDetails.providerGender
                    
                    self.selectGenderFor(id: providerGender?.Id)
                    //TODO:- Remove after approval
                    /*
                     var genderBtn : UIButton!
                    if providerGender?.Id == self.appDelegate.genderFilterOptions[0].Id
                    {
                        genderBtn = self.btnMale
                    }
                    else if providerGender?.Id == self.appDelegate.genderFilterOptions[1].Id
                    {
                        genderBtn = self.btnFemale
                    }
                    else
                    {
                        //This is a deafult selection. If we receive id as empty or nil or ID of ANY then this is used.
                        genderBtn = self.btnAny
                    }
                    
                    self.selectGenderFor(button: genderBtn)*/
                }
                
                //Added on 14th July 2020
                self.btnSubmitAndNew.isHidden = appointment.appointmentDetails?.first?.isCancel == 0
                
                // Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
                //GATHER0000923 -- Start
                if !self.viewPickleBall.isHidden
                {
                    if let index = self.appDelegate.bookingAppointmentDetails.service?.serviceCategoryList?.firstIndex(where: {$0.serviceCategoryID == appointment.appointmentDetails?.first?.serviceCategoryID})
                    {
                        self.selectedServiceCategoty = self.appDelegate.bookingAppointmentDetails.service?.serviceCategoryList?[index]
                    }
                    else
                    {
                        self.selectedServiceCategoty = self.appDelegate.bookingAppointmentDetails.service?.serviceCategoryList?.first
                    }
                }
                //GATHER0000923 -- End
                
            default:
                break
            }
            
            self.btnModifyAdd.isEnabled = self.hasSelectedMaxMembers()
            

            self.appDelegate.hideIndicator()
            
            self.getUnAvailableDates()
            
        }) { (error) in
            self.appDelegate.hideIndicator()
            self.handleError(error: error)
        }
    }
    
    
}

//MARK:- FSCalendar Delegates
extension SpaAndFitnessRequestVC : FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance
{
    
    func minimumDate(for calendar: FSCalendar) -> Date
    {
        
        var days = Int(self.appDelegate.bookingAppointmentDetails.department?.settings?.first?.minimumDaysinAdvace ?? "0")
        let shouldIncreaseDay = self.shouldIncreaseDay(time: self.appDelegate.bookingAppointmentDetails.department?.settings?.first?.minimumTimeinAdvace ?? "")
        
        if shouldIncreaseDay
        {
            days = (days ?? 0) + 1
        }
        
        let date = self.generateDateByAdding(days: days)
        //Added by kiran V2.5 -- GATHER0000590 -- Date format change form YYYY to yyyy
        //GATHER0000590 -- Start
        let minDayAvailable = !self.arrUnAvailabeDates.contains(where: {$0.date == date.toString(format: DateFormats.mm_dd_yyyy_WithDash)})
        //let minDayAvailable = !self.arrUnAvailabeDates.contains(where: {$0.date == date.toString(format: "MM-dd-YYYY")})
        //GATHER0000590 -- End
        self.updateCalendarHeaderViewWith(date: date)
        if self.isTodayAvailable() && !shouldIncreaseDay
        {
            self.setTodayColorBy(isAvailabile: minDayAvailable)
        }
        
        switch self.screenType
        {
        case .request:
            //Uncomment if default selection of first available date is needed on load of screen.
//            if minDayAvailable
//            {
//                self.selectedDate = date.toString(format: "MMM dd, YYYY")
//                self.calendarView.select(date)
//            }
//            else
//            {
//                self.selectedDate = nil
//                self.calendarView.deselect(date)
//            }
            break
        default:
            break
        }
        
        return date
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date
    {
        var days = Int(self.appDelegate.bookingAppointmentDetails.department?.settings?.first?.maximumDaysinAdvace ?? "0")
        if self.shouldIncreaseDay(time: self.appDelegate.bookingAppointmentDetails.department?.settings?.first?.maximumTimeinAdvace ?? "")
        {
            days = (days ?? 0) + 1
            
        }
        
        return self.generateDateByAdding(days: days)
    }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar)
    {
        self.updateCalendarHeaderViewWith(date: calendar.currentPage)
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        //Added by kiran V2.5 -- GATHER0000590 -- Date format change form YYYY to yyyy
        //GATHER0000590 -- Start
        if self.arrUnAvailabeDates.contains(where: {$0.date == date.toString(format: DateFormats.mm_dd_yyyy_WithDash)})
        {
            let date = self.arrUnAvailabeDates.first(where: {$0.date == date.toString(format: DateFormats.mm_dd_yyyy_WithDash)})
            
//        if self.arrUnAvailabeDates.contains(where: {$0.date == date.toString(format: "MM-dd-YYYY")})
//        {
//            let date = self.arrUnAvailabeDates.first(where: {$0.date == date.toString(format: "MM-dd-YYYY")})
            //GATHER0000590 -- End
            var message : String?
            switch date?.isProviderOrService
            {
            case .provider:
                //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes.
                //GATHER0000700 - Start
                switch self.BMSBookingDepartment
                {
                case .fitnessAndSpa:
                    message = self.appDelegate.masterLabeling.BMS_ProviderValidation
                case .tennisBookALesson:
                    message = self.appDelegate.masterLabeling.TL_ProviderValidation
                    //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL provider not available message
                    //GATHER0001167 -- Start
                case .golfBookALesson:
                    message = self.appDelegate.masterLabeling.BMS_Golf_ProviderNotAvailable
                    //GATHER0001167 -- End
                case .none:
                    break
                }
                //GATHER0000700 - End
            case .service:
                message = self.appDelegate.masterLabeling.BMS_ServiceValidation
            default:
                break
            }
            let messageView = BMSNotAvailableView.init(frame: self.view.bounds)
            messageView.lblMessage.text = message ?? ""
            self.view.addSubview(messageView)
            return false
        }
        
        return true
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition)
    {
        //Added by kiran V2.5 -- GATHER0000590 -- Date format change form YYYY to yyyy
        //GATHER0000590 -- Start
        //KVO is used to set the current date on the appointmentDetails view
        self.selectedDate = date.toString(format: DateFormats.BMSSelectedDate)
        //self.selectedDate = date.toString(format: "MMM dd, YYYY")
        //GATHER0000590 -- End
        self.selectedTime = nil
    }
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor?
    {
        //Added by kiran V2.5 -- GATHER0000590 -- Date format change form YYYY to yyyy
        //GATHER0000590 -- Start
        if calendar.isDate(inRange: date) && self.arrUnAvailabeDates.contains(where: {$0.date == date.toString(format: DateFormats.mm_dd_yyyy_WithDash)})
        {
//        if calendar.isDate(inRange: date) && self.arrUnAvailabeDates.contains(where: {$0.date == date.toString(format: "MM-dd-YYYY")})
//        {
            //GATHER0000590 -- End
            return self.unAvailableDateColor
        }
        else
        {
            return nil
        }
    }
    
}

//MARK:- Collection View Delegate
extension SpaAndFitnessRequestVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrAvailableTimes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height : CGFloat = 70
        
        let dateString = self.arrAvailableTimes[indexPath.row].time?.date(format: "hh:mm a")?.toString(format: "hh:mm") ?? ""
        //This is the font given in Interface builder
        let font = UIFont.init(name: "SourceSansPro-Semibold", size: 29.0)
        //5 is the leading and trailing padding given in Interface Builder
        let width = 5 + dateString.width(withConstrainedHeight: height, font: font!) + 5
        
        return CGSize.init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCollectionViewCell", for: indexPath) as! TimeCollectionViewCell
        
        let timeString = self.arrAvailableTimes[indexPath.row]
        let time = timeString.time?.date(format: "hh:mm a")
        cell.lblTime.text = time?.toString(format: "hh:mm")
        cell.lblPeriod.text = time?.toString(format: "a")
        
        var colorHex = UIColor.clear
        if self.selectedTime?.time == timeString.time
        {
            colorHex = APPColor.MainColours.primary2//"#F06C42"
        }
        else
        {
            colorHex = hexStringToUIColor(hex: "#818181")
        }
                
                
        cell.lblTime.textColor = colorHex
        cell.lblPeriod.textColor = colorHex
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.showPickerView(bool: false)
        //selected time and duration are automaticallt updated by kvo of selectedtime
        self.selectedTime = self.arrAvailableTimes[indexPath.row]
    }
    
    
}

//MARK:- Tableview delegates
extension SpaAndFitnessRequestVC : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tblVIewMembers
        {
            return self.arrMembers.count
        }
        else if tableView == self.tblViewAddMembers
        {
            return self.popoverOptions.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        switch tableView
        {
            //Members Cell
        case self.tblVIewMembers:
            
            let member = self.arrMembers[indexPath.row]
            
            var name : String? = ""
            var id : String? = ""
            
            //Added on 5th September 2020 V2.3
            var allowEdit : Bool?
            
            if let member = member as? CaptaineInfo
            {
                name = member.captainName
                id = member.captainMemberID
            }
            else if let member = member as? MemberInfo
            {
                name = member.memberName
                id = member.memberID
            }
            else if let member = member as? GuestInfo
            {
                name = member.guestName
                
                let memberType = CustomFunctions.shared.memberType(details: member, For: self.getAppModule(department: self.BMSBookingDepartment))
                if memberType == .guest
                {
                    //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                    //ENGAGE0011843 -- Start
                    id = CustomFunctions.shared.guestTypeDisplayName(id: member.guestType)
                    //id = member.guestType
                    //ENGAGE0011843 -- End
                }
                else if memberType == .existingGuest
                {
                    id = member.guestMemberNo
                }
              
                //Added on 5th September 2020 V2.3
                allowEdit = self.isMemberGuest(member: member)
            }
            else if let member = member as? Detail
            {
                
                //TODO:- remove after approval
//                var isGuest : Bool?
//                switch self.screenType {
//                case .request:
//                    isGuest = member.id == nil
//                case .modify,.view:
//                    //Only for BMS Guest should be identified by name as guest will return ID (liked member id) in get Appointment response.If guest name exist then the member is treated as guest.
//                    isGuest = !(member.guestName == nil || member.guestName == "")
//                default:
//                    break
//                }
                let isGuest = self.isMemberGuest(member: member)
                //Added on 5th September 2020 V2.3
                allowEdit = isGuest
                if isGuest == true
                {
                    name = member.guestName
                    //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                    //ENGAGE0011843 -- Start
                    id = CustomFunctions.shared.guestTypeDisplayName(id: member.guestType)
                    //id = member.guestType
                    //ENGAGE0011843 -- End
                }
                else
                {
                    name = member.name
                    id = member.memberId
                }
            }
            else
            {
                name = self.appDelegate.masterLabeling.BMS_Member ?? ""
                id = ""
            }
            
            switch self.screenType {
            case .request:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RequestTableViewCell") as! RequestTableViewCell
                
                cell.lblName.text = name
                
                cell.btnClear.isHidden = false
                //Added on 5th September 2020 V2.3
                cell.btnEdit.isHidden = !(allowEdit ?? false)
                cell.delegate = self
                
                //Added by kiran V2.5 -- GATHER0000606 -- Hiding add button and clear button if options array is empty
                //GATHER0000606 -- Start
                let hideMemberOptions = self.shouldHideAddMemberOptions()
                cell.btnAdd.isHidden = hideMemberOptions
                cell.btnClear.isHidden = hideMemberOptions
                //GATHER0000606 -- End
                cell.selectionStyle = .none
                return cell
            case .modify,.view:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyTableViewCell") as! ModifyTableViewCell
                
                cell.lblName.text = name
                cell.lblID.text = id
                cell.delegate = self
                
                //Added on 21st September 2020 V2.3
                cell.lblName.textColor = hexStringToUIColor(hex: (allowEdit ?? false) ? "#3B87C1" : "#695B5E")
                //Added by kiran V2.5 -- GATHER0000606 -- Hiding clear button if options array is empty
                //GATHER0000606 -- Start
                cell.btnRemove.isHidden = self.shouldHideAddMemberOptions()
                //GATHER0000606 -- End
                cell.selectionStyle = .none
                return cell
            default:
                let tableViewCell = UITableViewCell()
                tableViewCell.selectionStyle = .none
                return tableViewCell
            }
            
            
            //Add member popup option cell
        case self.tblViewAddMembers:
            
            let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 142, height: 34))
            cell.selectionStyle = .none
            
            cell.textLabel?.text = self.popoverOptions[indexPath.row].name
            cell.textLabel?.font =  SFont.SourceSansPro_Semibold18
            cell.textLabel?.textColor = hexStringToUIColor(hex: "64575A")
            tableView.separatorStyle = .none
            
            if indexPath.row < (self.popoverOptions.count - 1)
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
        default:
            return UITableViewCell()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        switch tableView
        {
        case self.tblViewAddMembers:
            
            //Modified by kiran V2.5 -- GATHER0000606 -- replacing comparision with case insensetive compare with the value(id)
            //GATHER0000606 -- Start
//            switch self.popoverOptions[indexPath.row].name
//            {
//            case "Member":
//                self.showMemberDirecotry()
//            case "Guest":
//                self.showAddGuest(screenType: .add)
//            default:
//                break
//            }
            switch (self.popoverOptions[indexPath.row].Id ?? "").lowercased()
            {
            case AddRequestIDS.member.rawValue.lowercased():
                self.showMemberDirecotry()
            case AddRequestIDS.guest.rawValue.lowercased():
                self.showAddGuest(screenType: .add)
            default:
                break
            }
            //GATHER0000606 -- End
            break
        //Added on 5th September 2020 V2.3
        case self.tblVIewMembers:
            
            if self.screenType == .modify
            {
                let member = self.arrMembers[indexPath.row]
                self.memberAddIndex = indexPath
                
                let memberType = CustomFunctions.shared.memberType(details: member, For: self.getAppModule(department: self.BMSBookingDepartment))
                
                switch memberType
                {
                case .existingGuest,.member:
                    break
                case .guest:
                    self.performGuestModify(member: member)
                }
                
            }
            
        default:
            break
        }
        
        self.popoverAddMember?.dismiss()
    }
    
    
}


//MARK:- RequestTableViewCellDelegate
extension SpaAndFitnessRequestVC : RequestTableViewCellDelegate
{
    func didClickClear(cell: RequestTableViewCell)
    {
        if let index = self.tblVIewMembers.indexPath(for: cell)
        {
            self.arrMembers.remove(at: index.row)
            let requestData = RequestData.init()
            requestData.isEmpty = true
            self.arrMembers.insert(requestData, at: index.row)
            self.tblVIewMembers.reloadData()
        }
       //Added on 5th Septmeber 2020 V2.3
        //Fail-Safe
       self.isModifyClicked = false
    }
    
    func didClickAdd(cell: RequestTableViewCell)
    {
        
        self.memberAddIndex = self.tblVIewMembers.indexPath(for: cell)
        self.validateMembers {
            self.showPopover(cell: cell)
        }
        //Added on 5th Septmeber 2020 V2.3
        self.isModifyClicked = false
    }
    
    //Added on 5th Septmeber 2020 V2.3
    func didClickEdit(cell: RequestTableViewCell)
    {
        if let index = self.tblVIewMembers.indexPath(for: cell)
        {
            let member = self.arrMembers[index.row]
            self.memberAddIndex = index
            self.performGuestModify(member: member)
        }
    }
    
}

//MARK:- ModifyTableViewCellDelegate

extension SpaAndFitnessRequestVC : ModifyTableViewCellDelegate
{
    func removeClicked(cell: ModifyTableViewCell)
    {
        
        if let index = self.tblVIewMembers.indexPath(for: cell)
        {
            self.arrMembers.remove(at: index.row)
            self.tblVIewMembers.reloadData()
            self.btnModifyAdd.isEnabled = self.hasSelectedMaxMembers()
        }
        
        //Added on 5th Septmeber 2020 V2.3
        //Fail-Safe
        self.isModifyClicked = false
    }
    
}

//MARK:- Member Directory Delegates
extension SpaAndFitnessRequestVC : MemberViewControllerDelegate
{
    func requestMemberViewControllerResponse(selecteArray: [RequestData])
    {
        switch self.screenType {
        case .request:
            let arrSelectedMember = selecteArray.filter({$0.isEmpty == false})
            
            switch self.memberSelectionType {
            case .single:
                if let selectedMember = arrSelectedMember.last , let index = self.memberAddIndex
                {
                    self.arrMembers.remove(at: index.row)
                    self.arrMembers.insert(selectedMember, at: index.row)
                    self.tblVIewMembers.reloadData()
                }
                
            default:
                break
            }
        case .modify:
            
            if let selectedMember = selecteArray.last
            {
                //Modified on 5th Septmeber 2020 V2.3
                if self.isModifyClicked
                {
                    self.isModifyClicked = false
                    if let index = self.memberAddIndex
                    {
                        self.arrMembers.remove(at: index.row)
                        self.arrMembers.insert(selectedMember, at: index.row)
                        self.tblVIewMembers.reloadData()
                    }
                }
                else
                {
                    self.arrMembers.append(selectedMember)
                    self.tblVIewMembers.reloadData()
                        
                    self.btnModifyAdd.isEnabled = self.hasSelectedMaxMembers()
                    
                }
                
            }
            
        default:
            break
        }
        
        //changing it to false for request scenario and fail-safe for modify scenario
        if self.isModifyClicked
        {
            self.isModifyClicked = false
        }
    }
    
    func memberViewControllerResponse(selecteArray: [MemberInfo])
    {
        
    }
    
    func buddiesViewControllerResponse(selectedBuddy: [MemberInfo])
    {
        
    }
    
    func AddGuestChildren(selecteArray: [RequestData])
    {
        
    }
    
}

//Added on 8th July 2020 V2.2
//MARK:- CancelPopUpViewController Delegate
extension SpaAndFitnessRequestVC : CancelPopUpViewControllerDelegate
{
    func didCancel(status: Bool)
    {
        self.cancelNavigation()
    }
}


//Added on 8th July 2020 V2.2
//MARK:- closeUpdateSuccesPopup Delegate
extension SpaAndFitnessRequestVC : closeUpdateSuccesPopup
{
    func closeUpdateSuccessView()
    {
        self.cancelNavigation()
    }
    
}

//Added on 18th August 2020 V2.3
//MARK:- Text view Delegate

extension SpaAndFitnessRequestVC : UITextViewDelegate
{
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if textView == self.textViewComments
        {
            self.appDelegate.bookingAppointmentDetails.comments = textView.text
        }
    }
}


// Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
//GATHER0000923 -- Start
extension SpaAndFitnessRequestVC : UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if let index = self.appDelegate.bookingAppointmentDetails.service?.serviceCategoryList?.firstIndex(where: {$0.serviceCategoryID == self.selectedServiceCategoty?.serviceCategoryID})
        {
            self.serviceCategoryPicker.selectRow(index, inComponent: 0, animated: false)
        }
        else
        {
            if self.appDelegate.bookingAppointmentDetails.service?.serviceCategoryList?.count ?? 0 > 0
            {
                self.serviceCategoryPicker.selectRow(0, inComponent: 0, animated: false)
                self.selectedServiceCategoty = self.appDelegate.bookingAppointmentDetails.service?.serviceCategoryList?.first
            }
        }
    }
}

extension SpaAndFitnessRequestVC : UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
      return self.appDelegate.bookingAppointmentDetails.service?.serviceCategoryList?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.appDelegate.bookingAppointmentDetails.service?.serviceCategoryList?[row].categoryName ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if let selectedService = self.appDelegate.bookingAppointmentDetails.service?.serviceCategoryList?[row]
        {
            //If the selected object is assigned to SelectedServiceCategory KVO will handle assigning it to the textfield
            self.selectedServiceCategoty = selectedService
        }
    }
    
}
//GATHER0000923 -- End

