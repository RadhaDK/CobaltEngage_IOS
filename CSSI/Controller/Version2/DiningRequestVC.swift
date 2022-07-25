
//  DiningRequestVC.swift
//  CSSI
//  Created by apple on 5/10/19.
//  Copyright © 2019 yujdesigns. All rights reserved.



import UIKit
import FSCalendar
import Popover

class DiningRequestVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, RequestCellDelegate,MemberViewControllerDelegate, guestViewControllerDelegate, RegistrationCell, DiningRequestDelegate, RegistrationDiningCell, AddMemberDelegate, ModifyRegistration,closeModalView,closeUpdateSuccesPopup {
    func AddGuestChildren(selecteArray: [RequestData]) {
        
    }
    
    
    func closeUpdateSuccessView() {
        self.dismiss(animated: true, completion: nil)
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for popToViewController in viewControllers {
            if self.appDelegate.closeFrom == "DiningUpdate" {
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
    
func addMemberDelegate() {
        self.dismiss(animated: true, completion: nil)
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for popToViewController in viewControllers {
            if popToViewController is DiningReservationViewController {
                //Modified by kiran -- ENGAGE0011177 -- V2.5 -- commented as its causing black bar issue on nav bar.
                //self.navigationController?.navigationBar.isHidden = false
                self.navigationController!.popToViewController(popToViewController, animated: true)
                
            }
        }
        
    }
    func ModifyThreeDotsClicked(cell: ModifyRegCustomCell) {
        
    }
    
    
    @IBOutlet weak var btnModifyTime: UIButton!
    //@IBOutlet weak var heigthTimeView: NSLayoutConstraint!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var heightSelectRestaurant: NSLayoutConstraint!
    @IBOutlet weak var heightDiningPolicy: NSLayoutConstraint!
    @IBOutlet weak var viewSelectRestaurant: UIView!
    @IBOutlet weak var completeCalendarView: UIView!
    @IBOutlet weak var viewSpecialRequest: UIView!
    @IBOutlet weak var viewComments: UIView!
    @IBOutlet weak var viewRestaurant: UIView!
    @IBOutlet weak var heightCalendar: NSLayoutConstraint!
    @IBOutlet weak var btnModifyDate: UIButton!
    @IBOutlet weak var heightSelectRequestDate: NSLayoutConstraint!
    @IBOutlet weak var heightSpecialView: NSLayoutConstraint!
    @IBOutlet weak var diningCollectionView: UICollectionView!
    @IBOutlet weak var lblModifyCaptainName: UILabel!
    @IBOutlet weak var heightReservationComments: NSLayoutConstraint!
    @IBOutlet weak var heightCancelResr: NSLayoutConstraint!
    @IBOutlet weak var modifyTableview: UITableView!
    @IBOutlet weak var txtSearchField: UITextField!
    @IBOutlet weak var btnCancelreser: UIButton!
    @IBOutlet weak var heightViewModify: NSLayoutConstraint!
    @IBOutlet weak var lblConfirmNumber: UILabel!
    @IBOutlet weak var viewModify: UIView!
    @IBOutlet weak var btnAddNewPlayer: UIButton!
    @IBOutlet weak var btnIncrease: UIButton!
    @IBOutlet weak var btnDecrease: UIButton!
    @IBOutlet weak var myCalendar: FSCalendar!
    @IBOutlet weak var lblSelectRestaurant: UILabel!
    @IBOutlet weak var restaurantTableView: UITableView!
    @IBOutlet weak var lblSelectRequestdate: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblReservationtime: UILabel!
    @IBOutlet weak var lblNotEarlierThan: UILabel!
    @IBOutlet weak var lblNotLaterThan: UILabel!
    @IBOutlet weak var txtReservationtime: UITextField!
    @IBOutlet weak var txtNotEarlierThan: UITextField!
    @IBOutlet weak var txtNotLaterThan: UITextField!
    @IBOutlet weak var lblPartySize: UILabel!
    @IBOutlet weak var lblPartySizeNumber: UILabel!
    @IBOutlet weak var partyTableview: UITableView!
    @IBOutlet weak var lblAddASpecialReq: UILabel!
    @IBOutlet weak var btnTableUpfront: UIButton!
    @IBOutlet weak var btnWindowTable: UIButton!
    @IBOutlet weak var lblReservationComments: UILabel!
    @IBOutlet weak var txtComments: UITextView!
    @IBOutlet weak var btnRequest: UIButton!
    @IBOutlet weak var btnDiningPolicy: UIButton!
    @IBOutlet weak var lblBottomUserName: UILabel!
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var heightPartyTableview: NSLayoutConstraint!
    @IBOutlet weak var heightRestaurantView: NSLayoutConstraint!
    @IBOutlet weak var viewParty: UIView!
    @IBOutlet weak var btnMultiSelect: UIButton!
    @IBOutlet weak var viewMultiSelect: UIView!
    @IBOutlet weak var instructionsTableview: SelfSizingTableView!
    
    @IBOutlet weak var instructionsTableViewHeight: NSLayoutConstraint!
    
    //Added on 7th October 2020 V2.3
    @IBOutlet weak var preferredTimeView: UIView!
    @IBOutlet weak var preferredTimePickerCollectionView: UICollectionView!
    @IBOutlet weak var earlierThanView: UIView!
    @IBOutlet weak var earlierThanPickerCollectionView: UICollectionView!
    
    @IBOutlet weak var laterThanView: UIView!
    @IBOutlet weak var laterThanPickerCollectionView: UICollectionView!
    
    /// Indicates if multi selection button is clicked
    private var isMultiSelectClicked = false
    
    fileprivate var dob:Date? = nil
    var diningSettings : DinningSettings?
    var addNewPopoverTableView: UITableView? = nil
    var addNewPopover: Popover? = nil
    var gameType : String?
    var selectedIndex : Int?
    var selectedSpecialRequest: Int?
    var selectedSpecialRequestEdit: Int?
    var minTime: String?
    var maxTime: String?
    var currentTime: String?
    
    var selectedSection : Int?
    var selectedCellText : String?
    var selectedCellIndex : Int?
    var selectedCellModifyIndex : Int?
    var isFirstTime : Int?
    var ModifyCellIndex: Int?
    var ModifyGuestCellIndex: Int?
    
    var reservationRequestDate : String?
    var arrTotalList = [RequestData]()
    var arrSpecialOccasion = [RequestData]()
    var arrTempPlayers = [RequestData]()


    var isFrom : String?
    var type: String?
    var isOnlyFrom: String?
    
    var requestID : String?
    var nameOfMonth : String?
    var currentMonth : Date?

    var arrNewReqList = [String]()
    var selectedPreferenceID : String?
    var preferedSpaceDetailID : String?
    var partyList = [Dictionary<String, Any>]()
    var partyCount : Int?
    var arrTeeTimeDetails = [RequestTeeTimeDetail]()
    var modifyCount : Int = 0
    var captainName : String?
    var requestClear : String?
    var arrRegReqID = [String]()
    var paramaterDict:[String: Any] = [:]
    var dateAndTimeDromServer = Date()

    var datePicker3 = UIDatePicker()
    var datePicker2 = UIDatePicker()
    var datePicker1 = UIDatePicker()
    var isDateChanged : String?
    var reservationRemindDate: String?
    var defaultRestaurant: Bool?
    var previousRequestDate: String?
    var partySize: String?
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var isDateSelected : Bool?
    var addNewMeber: Bool?

    var requestType : RequestType?
    
    private var arrInstructions = [Instruction]()
    
    ///Height of multiselect button view for layout
    ///
    /// Note : if the layout is changed make sure to change this accordngly
    private var viewMultiSelectionHeight : CGFloat = 37/*Top constraint */+ 31.13/*Height of button*/
    
    ///When True disables the tap actions
    ///
    /// Note: This will just disbale the user interactions and hides cancel and submit buttons and adds back button.everything else will work based on the other variables passed while initializing this controller.
    var isViewOnly = false
    
    //Added on 4th July 2020 V2.2
    private let accessManager = AccessManager.shared
    
    private var numberOfTickets : Int = 0
    
    //Added on 7th October 2020 V2.3
    ///Holds the index of the selecte preferred time for a restraunt
    private var preferredTimeIndex : Int?
    
    //Added on 13th October 2020 V2.3
    ///Holds table preferences .Used only in view only mode
    private var arrPreference = [TablePreferencesType]()
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Added on 4th July 2020 V2.2
        //added roles and privilages changes
        //since not allowed is handled before coming to this screen not need to check for it.
        switch self.accessManager.accessPermision(for: .diningReservation) {
        case .view:
            if !self.isViewOnly, self.isFrom != "View" , let message = self.appDelegate.masterLabeling.role_Validation2 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            break
        default:
            break
        }
        
        self.instructionsTableview.delegate = self
        self.instructionsTableview.dataSource = self
        self.instructionsTableview.allowsSelection = false
        self.instructionsTableview.separatorStyle = .none
        self.instructionsTableview.backgroundColor = .clear
        self.instructionsTableview.estimatedRowHeight = 40
        self.instructionsTableview.rowHeight = UITableViewAutomaticDimension
        
        self.instructionsTableview.register(UINib.init(nibName: "InstructionsTableViewCell", bundle: nil), forCellReuseIdentifier: "InstructionsTableViewCell")
        
        //Added on 7th October 2020 V2.3
        self.preferredTimePickerCollectionView.delegate = self
        self.preferredTimePickerCollectionView.dataSource = self
        self.earlierThanPickerCollectionView.delegate = self
        self.earlierThanPickerCollectionView.dataSource = self
        self.laterThanPickerCollectionView.delegate = self
        self.laterThanPickerCollectionView.dataSource = self
        self.preferredTimePickerCollectionView.isHidden = true
        self.earlierThanPickerCollectionView.isHidden = true
        self.laterThanPickerCollectionView.isHidden = true
        self.preferredTimePickerCollectionView.register(UINib.init(nibName: "TimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TimeCollectionViewCell")
        self.earlierThanPickerCollectionView.register(UINib.init(nibName: "TimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TimeCollectionViewCell")
        self.laterThanPickerCollectionView.register(UINib.init(nibName: "TimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TimeCollectionViewCell")
        self.txtReservationtime.delegate = self
        self.txtNotLaterThan.delegate = self
        self.txtNotEarlierThan.delegate = self
        
        
        self.isDateChanged = "No"
        self.addNewMeber = false
        // Do any additional setup after loading the view.
        
        self.btnDiningPolicy.setTitle(self.appDelegate.masterLabeling.dining_policy!, for: UIControlState.normal)
        self.lblBottomUserName.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)
        self.lblSelectRestaurant.text = self.appDelegate.masterLabeling.select_restaurant_colon
        self.lblSelectRequestdate.text = self.appDelegate.masterLabeling.select_request_date
        self.lblReservationtime.text = self.appDelegate.masterLabeling.reservation_time
        
        self.lblNotEarlierThan.text = self.appDelegate.masterLabeling.not_earlier_than
        self.lblNotLaterThan.text = self.appDelegate.masterLabeling.not_later_than
        self.lblPartySize.text = self.appDelegate.masterLabeling.party_size
        
        
        self.lblAddASpecialReq.text = self.appDelegate.masterLabeling.special_request_add
        self.lblReservationComments.text = self.appDelegate.masterLabeling.reservation_comments
        
        restaurantTableView.separatorStyle = .none

        btnCancelreser.backgroundColor = .clear
        btnCancelreser.layer.cornerRadius = 18
        btnCancelreser.layer.borderWidth = 1
        btnCancelreser.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        btnCancelreser .setTitle(self.appDelegate.masterLabeling.cancel_reservation, for: UIControlState.normal)
        self.btnCancelreser.setStyle(style: .outlined, type: .primary)
        
        self.txtSearchField.text = self.appDelegate.masterLabeling.add_member_or_guest
        self.navigationController?.navigationBar.isHidden = false

        if isFrom == "Modify"{
            partyTableview.isHidden = true
            viewModify.isHidden = false
            btnCancelreser.isHidden = false
            self.btnCancelreser.isHidden = false
            self.btnAddNewPlayer.isEnabled = false
            isFirstTime = 1
            
            btnRequest.backgroundColor = .clear
            btnRequest.layer.cornerRadius = 18
            btnRequest.layer.borderWidth = 1
            btnRequest.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
            btnRequest .setTitle(self.appDelegate.masterLabeling.Save, for: UIControlState.normal)
            self.btnRequest.setStyle(style: .outlined, type: .primary)
            
            self.heightSelectRequestDate.constant = 84
            self.btnModifyDate.isHidden = false
            self.btnModifyTime.isHidden = true
            
            
        }else if  isFrom == "View"{
            completeCalendarView.isHidden = true
            heightCalendar.constant = 0
            viewRestaurant.isUserInteractionEnabled = false
            viewSpecialRequest.isUserInteractionEnabled = false
            viewComments.isUserInteractionEnabled = false
            self.txtReservationtime.isEnabled = false
            self.txtNotLaterThan.isEnabled = false
            self.txtNotEarlierThan.isEnabled = false
            self.btnCancelreser.isHidden = true
            self.viewParty.isUserInteractionEnabled = false
            partyTableview.isHidden = true
            viewModify.isHidden = false
            self.btnAddNewPlayer.isEnabled = false
            isFirstTime = 1
            self.txtNotEarlierThan.isEnabled = false
            self.txtNotLaterThan.isEnabled = false
            self.heightSelectRequestDate.constant = 20
            self.lblSelectRequestdate.isHidden = true
            self.viewSelectRestaurant.isHidden = true

            self.heightSelectRestaurant.constant = 0
            self.heightDiningPolicy.constant = -80
            self.btnRequest.isHidden = true
            //Added on 16th October 2020 V2.3
            self.viewSelectRestaurant.layoutIfNeeded()
            
            self.btnModifyDate.isHidden = false
            self.btnModifyTime.isHidden = false

            btnRequest.backgroundColor = .clear
            btnRequest.layer.cornerRadius = 18
            btnRequest.layer.borderWidth = 1
            btnRequest.layer.borderColor = UIColor.clear.cgColor
            btnRequest .setTitle(self.appDelegate.masterLabeling.Save, for: UIControlState.normal)
            btnRequest.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.btnRequest.setStyle(style: .outlined, type: .primary)
            
        }else{
            btnDecrease.isEnabled = false
            self.btnCancelreser.isHidden = true
            self.heightCancelResr.constant = -20
            self.lblReservationComments.isHidden = false
            self.txtComments.isHidden = false
            btnCancelreser.isHidden = true
            partyTableview.isHidden = false
            viewModify.isHidden = true
            isFirstTime = 0
            
            btnRequest.backgroundColor = hexStringToUIColor(hex: "F37D4A")
            btnRequest.layer.cornerRadius = 18
            btnRequest.layer.borderWidth = 1
            btnRequest.layer.borderColor = UIColor.clear.cgColor
            btnRequest .setTitle(self.appDelegate.masterLabeling.rEQUEST, for: UIControlState.normal)
            btnRequest.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.btnRequest.setStyle(style: .outlined, type: .primary)
            
            self.heightSelectRequestDate.constant = 42
            self.btnModifyDate.isHidden = true
            self.btnModifyTime.isHidden = true

        }
        
        txtComments.layer.cornerRadius = 6
        txtComments.layer.borderWidth = 1
        txtComments.layer.borderWidth = 0.25
        txtComments.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
        
        viewParty.layer.cornerRadius = 18
        viewParty.layer.shadowColor = UIColor.black.cgColor
        viewParty.layer.shadowOpacity = 0.23
        viewParty.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewParty.layer.shadowRadius = 4
        selectedSpecialRequest = -1
        selectedSpecialRequestEdit = -1
        selectedCellIndex = 0
        selectedCellModifyIndex = -1
        ModifyCellIndex = -1
        ModifyGuestCellIndex = -1
   
        let itemSize = (UIScreen.main.bounds.width - 48)/2-1

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.itemSize = CGSize(width: itemSize + 0.25, height: itemSize/4)
        
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        diningCollectionView.collectionViewLayout = layout
        
        self.myCalendar.allowsMultipleSelection = false
        self.myCalendar.weekdayHeight = 50
        self.myCalendar.delegate = self
        self.myCalendar.dataSource = self
        self.myCalendar.placeholderType = .none
        self.arrTotalList.append(RequestData())
        
        let captainInfo = CaptaineInfo.init()
        captainInfo.setCaptainDetails(id: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "", name:  UserDefaults.standard.string(forKey: UserDefaultsKeys.captainName.rawValue) ?? "", firstName: UserDefaults.standard.string(forKey: UserDefaultsKeys.firstName.rawValue) ?? "" , order: 1, memberID: UserDefaults.standard.string(forKey: UserDefaultsKeys.memberID.rawValue) ?? "", parentID: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "", profilePic: UserDefaults.standard.string(forKey: UserDefaultsKeys.userProfilepic.rawValue) ?? "")
        
        let selectedObject = captainInfo
        selectedObject.isEmpty = false
        arrTotalList.remove(at: 0)
        arrTotalList.insert(selectedObject, at: 0)
        
        self.requestReservationApi()
        defaultRestaurant = false

        self.diningSettings  = self.appDelegate.arrDiningSettings
        
        self.restaurantTableView.estimatedSectionHeaderHeight = 20
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
        
        self.partyTableview.estimatedSectionHeaderHeight = 25
        
        //Multi Selection button hide/show
        //Modified by kiran V2.5 -- GATHER0000606 -- added hiding multiselect button when multi select options are empty
        //GATHER0000606 -- Start
        self.viewMultiSelect.isHidden = (isFrom == "Modify" || isFrom == "View" || self.appDelegate.addRequestOpt_Dining_MultiSelect.count == 0)
        //GATHER0000606 -- End
        self.btnMultiSelect.setTitle(self.appDelegate.masterLabeling.MULTI_SELECT_DINING ?? "", for: .normal)
        self.btnMultiSelect.multiSelectBtnViewSetup()
        
        self.arrInstructions = self.appDelegate.ReservationsInstruction
        
        self.disableActions()
    
        //Added on 17th October 2020 V2.3
        if #available(iOS 14.0, *)
        {
            self.datePicker1.preferredDatePickerStyle = .wheels
            self.datePicker2.preferredDatePickerStyle = .wheels
            self.datePicker3.preferredDatePickerStyle = .wheels
        }
        
        self.myCalendar.appearance.selectionColor = APPColor.MainColours.primary2
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
        
    }
    
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    func minimumDate(for calendar: FSCalendar) -> Date {
        let dateDiff = findDateDiff(time1Str: self.minTime ?? "", time2Str: currentTime ?? "")
        if self.diningSettings?.minDaysInAdvance == 0 {
            if dateDiff.first == "-"{
                self.myCalendar.appearance.titleTodayColor =  UIColor.black
            }else{
            self.myCalendar.appearance.titleTodayColor =  UIColor.lightGray
            }
        }else{
            self.myCalendar.appearance.titleTodayColor =  UIColor.lightGray
            
        }
        
        if dateDiff.first == "+"{
            return Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.minDaysInAdvance ?? 0) + 1, to: self.dateAndTimeDromServer)!
            
        }else{
            return Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.minDaysInAdvance ?? 0) , to: self.dateAndTimeDromServer)!
        }
    }
    func maximumDate(for calendar: FSCalendar) -> Date {
        let dateDiff = findDateDiff(time1Str: self.maxTime ?? "", time2Str: currentTime ?? "")
        if dateDiff.first == "+"{
            
            return Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.maxDaysInAdvance ?? 0) + 1, to: self.dateAndTimeDromServer)!
            
        }else{
            return Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.maxDaysInAdvance ?? 0), to: self.dateAndTimeDromServer)!
            
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
        
        self.instructionsTableViewHeight.constant = self.instructionsTableview.contentSize.height
               
        let btnMultiSelectHeight = (self.viewMultiSelect.isHidden ? 0 : self.viewMultiSelectionHeight) + 5/*Gap between multi select and instructions*/
        //Added on 9th October 2020 V2.3
        
        let calTimeViewHeight : CGFloat = self.timeView.isHidden ? 0 : self.timeView.frame.height
        
        if isFrom == "Modify"
        {
            if self.arrTeeTimeDetails.count == 0
            {
                
                
            }
            else
            {
                if self.arrTeeTimeDetails[0].buttonTextValue == "3" || self.arrTeeTimeDetails[0].buttonTextValue == "4"  || self.arrTeeTimeDetails[0].buttonTextValue == "5"
                {
                    self.heightSpecialView.constant = self.diningCollectionView.contentSize.height + 78;
                    
                    self.heightViewModify.constant = self.modifyTableview.contentSize.height + 136
                    self.heightPartyTableview?.constant = self.modifyTableview.contentSize.height + 136
                    self.heightRestaurantView?.constant = self.restaurantTableView.contentSize.height
                    
                    //Added on 7th October 2020
                    let baseHeight : CGFloat = 600
                    
                    let calculatedHeight : CGFloat = heightRestaurantView.constant + heightViewModify.constant + self.heightSpecialView.constant + btnMultiSelectHeight + self.instructionsTableViewHeight.constant
                    
                    self.mainViewHeight.constant = baseHeight + calculatedHeight + calTimeViewHeight
                    
                    //self.mainViewHeight.constant = 600 + heightRestaurantView.constant + heightViewModify.constant + self.heightSpecialView.constant + btnMultiSelectHeight + self.instructionsTableViewHeight.constant
                    
                }
                else
                {
                    self.heightSpecialView.constant = self.diningCollectionView.contentSize.height + 78;
                    
                    self.heightViewModify.constant = self.modifyTableview.contentSize.height + 136
                    self.heightPartyTableview?.constant = self.modifyTableview.contentSize.height + 136
                    self.heightRestaurantView?.constant = self.restaurantTableView.contentSize.height
                    
                    //Added on 7th October 2020
                    let baseHeight : CGFloat = 1040
                        
                    let calculatedHeight : CGFloat = heightRestaurantView.constant + heightViewModify.constant + self.heightSpecialView.constant + btnMultiSelectHeight + self.instructionsTableViewHeight.constant
                        
                    self.mainViewHeight.constant = baseHeight + calculatedHeight + calTimeViewHeight
                    
                    //self.mainViewHeight.constant = 1200 + heightRestaurantView.constant + heightViewModify.constant + self.heightSpecialView.constant + btnMultiSelectHeight + self.instructionsTableViewHeight.constant
                }
                
            }
            
        }
        else if isFrom == "View"
        {
            self.heightSpecialView.constant = self.diningCollectionView.contentSize.height + 78;
            
            self.heightViewModify.constant = self.modifyTableview.contentSize.height + 136
            self.heightPartyTableview?.constant = self.modifyTableview.contentSize.height + 136
            self.heightRestaurantView?.constant = self.restaurantTableView.contentSize.height
            
            //Added on 7th October 2020
            let baseHeight : CGFloat = 500
                    
            let calculatedHeight : CGFloat = heightRestaurantView.constant + heightViewModify.constant + self.heightSpecialView.constant + btnMultiSelectHeight + self.instructionsTableViewHeight.constant
                
            self.mainViewHeight.constant = baseHeight + calculatedHeight + calTimeViewHeight
            
            //self.mainViewHeight.constant = 500 + heightRestaurantView.constant + heightViewModify.constant + self.heightSpecialView.constant + btnMultiSelectHeight + self.instructionsTableViewHeight.constant
            
        }
        else
        {
            self.heightSpecialView.constant = self.diningCollectionView.contentSize.height + 78;
            self.heightViewModify.constant = self.partyTableview.contentSize.height
            self.heightRestaurantView?.constant = self.restaurantTableView.contentSize.height
            self.heightPartyTableview?.constant = self.partyTableview.contentSize.height

            //Added on 7th October 2020
            let baseHeight : CGFloat = 990
                    
            let calculatedHeight : CGFloat = heightRestaurantView.constant + heightPartyTableview.constant + self.heightSpecialView.constant + btnMultiSelectHeight + self.instructionsTableViewHeight.constant
                
            self.mainViewHeight.constant = baseHeight + calculatedHeight + calTimeViewHeight
            
            //self.mainViewHeight.constant = 1150 + heightRestaurantView.constant + heightPartyTableview.constant + self.heightSpecialView.constant + btnMultiSelectHeight + self.instructionsTableViewHeight.constant

        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if self.appDelegate.specialCloseFrom == "SpecialNo"{
        self.appDelegate.specialCloseFrom = ""
        self.reservationRequestDate = nil
            
            
            for date in self.myCalendar!.selectedDates{
                self.myCalendar.deselect(date)
        }
            //Added on 9th October 2020 v2.3
            self.resetTimeSelection()
        }
        //self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationItem.title = self.appDelegate.masterLabeling.dining_request
        
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true

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
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didDOBDateChange(datePicker:UIDatePicker) {
        dob = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        txtReservationtime.text = dateFormatter.string(for: dob)
        self.NotEarlierThan()
        self.NotLaterThan()
    }
    @objc func didDOBDateChangeEarlier(datePicker: UIDatePicker) {
        dob = datePicker.date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        txtNotEarlierThan.text = dateFormatter.string(for: dob)
        
    }
    @objc func didDOBDateChangeLater(datePicker:UIDatePicker) {
        dob = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        txtNotLaterThan.text = dateFormatter.string(for: dob)
        
    }
    
    func NotEarlierThan()
    {
        //9th October 2020 V2.3
        if let _ = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup
        {
            return
        }
        
        let dateAsStringMin = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].openTime
        let dateFormatterMin = DateFormatter()
        dateFormatterMin.dateFormat = "hh:mm a"
        
        let dateMin = dateFormatterMin.date(from: dateAsStringMin!)
        dateFormatterMin.dateFormat = "HH:mm"
        
        let DateMin = dateFormatterMin.string(from: dateMin!)
        
        let dateAsStringMax = self.txtReservationtime.text
        let dateFormatterMax = DateFormatter()
        dateFormatterMax.dateFormat = "hh:mm a"
        
        let dateMax = dateFormatterMax.date(from: dateAsStringMax!)
        dateFormatterMax.dateFormat = "HH:mm"
        
        let DateMax = dateFormatterMax.string(from: dateMax!)
        
        
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat =  "HH:mm"
        let date3 = dateFormatter3.date(from: DateMin)
        
        
        self.datePicker3.datePickerMode = .time
        
        let minEarlier = dateFormatter3.date(from: DateMin)      //createing min time
        let maxEarlier = dateFormatter3.date(from: DateMax) //creating max time
        self.datePicker3.minimumDate = minEarlier  //setting min time to picker
        self.datePicker3.maximumDate = maxEarlier
        self.datePicker3.minuteInterval = self.diningSettings?.timeInterval ?? 0  // with interval of 30
        
      //  self.datePicker3.setDate(date3!, animated: true)
        self.datePicker3.addTarget(self, action: #selector(self.didDOBDateChangeEarlier(datePicker:)), for: .valueChanged)
        self.txtNotEarlierThan.inputView = self.datePicker3
    }
    
    
    func NotLaterThan()
    {
        //9th October 2020 V2.3
        if let _ = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup
        {
            return
        }
        
        let dateAsStringMin = self.txtReservationtime.text
        let dateFormatterMin = DateFormatter()
        dateFormatterMin.dateFormat = "hh:mm a"
        
        let dateMin = dateFormatterMin.date(from: dateAsStringMin!)
        dateFormatterMin.dateFormat = "HH:mm"
        
        let DateMin = dateFormatterMin.string(from: dateMin!)
        
        let dateAsStringMax = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].closeTime
        let dateFormatterMax = DateFormatter()
        dateFormatterMax.dateFormat = "hh:mm a"
        
        let dateMax = dateFormatterMax.date(from: dateAsStringMax!)
        dateFormatterMax.dateFormat = "HH:mm"
        
        let DateMax = dateFormatterMax.string(from: dateMax!)
        
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat =  "HH:mm"
        let date3 = dateFormatter3.date(from: DateMin)
        
        self.datePicker2.datePickerMode = .time
        
        let minEarlier = dateFormatter3.date(from: DateMin)      //createing min time
        let maxEarlier = dateFormatter3.date(from: DateMax) //creating max time
        self.datePicker2.minimumDate = minEarlier  //setting min time to picker
        self.datePicker2.maximumDate = maxEarlier
        self.datePicker2.minuteInterval = self.diningSettings?.timeInterval ?? 0  // with interval of 30
        
     //   self.datePicker2.setDate(date3!, animated: true)
        self.datePicker2.addTarget(self, action: #selector(self.didDOBDateChangeLater(datePicker:)), for: .valueChanged)
        self.txtNotLaterThan.inputView = self.datePicker2
    }
    
    func guestViewControllerResponse(guestName: String) {
        
    }
    
    func checkBoxClicked(cell: CustomDashBoardCell) {
        
        
    }
    
    //Added on 7th October 2020
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if let timeSetup = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup,textField == self.txtReservationtime || textField == self.txtNotEarlierThan || textField == self.txtNotLaterThan
        {
            if self.appDelegate.masterLabeling.IsDiningDateValidate == 1 && textField == self.txtReservationtime
            {
                guard self.reservationRequestDate != nil && self.reservationRequestDate != "" else{
                    SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.IsDiningDateValidationMessage ?? "", withDuration: Duration.kMediumDuration)
                    return false
                }
            }
            
            if timeSetup.count == 0
            {
                return false
            }
            
            switch textField
            {
            case self.txtReservationtime:
                
                if !self.preferredTimePickerCollectionView.isHidden
                {
                    self.preferredTimePickerCollectionView.isHidden = true
                    return false
                }
                
                self.preferredTimePickerCollectionView.reloadData()
                self.preferredTimePickerCollectionView.isHidden = false
                self.earlierThanPickerCollectionView.isHidden = true
                self.laterThanPickerCollectionView.isHidden = true
                self.timeView.layoutIfNeeded()
                if let index = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup?.firstIndex(where: {$0.time == textField.text ?? ""})
                {
                    
                    self.preferredTimePickerCollectionView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: .centeredHorizontally, animated: false)
                    self.preferredTimePickerCollectionView.setNeedsLayout()
                }
               
                
            case self.txtNotEarlierThan:
                
                if self.preferredTimeIndex == nil || !self.earlierThanPickerCollectionView.isHidden
                {
                    if !self.earlierThanPickerCollectionView.isHidden
                    {
                        self.earlierThanPickerCollectionView.isHidden = true
                    }
                    
                    return false
                }
                self.earlierThanPickerCollectionView.reloadData()
                self.preferredTimePickerCollectionView.isHidden = true
                self.earlierThanPickerCollectionView.isHidden = false
                self.laterThanPickerCollectionView.isHidden = true
                self.timeView.layoutIfNeeded()
                if let preferredIndex = self.preferredTimeIndex, let index = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup?[preferredIndex].earliestTime?.firstIndex(where: {$0.time == textField.text ?? ""})
                {
                    
                    self.earlierThanPickerCollectionView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: .centeredHorizontally, animated: false)
                    self.earlierThanPickerCollectionView.setNeedsLayout()
                }
                
               
                
            case self.txtNotLaterThan:
                
                if self.preferredTimeIndex == nil || !self.laterThanPickerCollectionView.isHidden
                {
                    if !self.laterThanPickerCollectionView.isHidden
                    {
                        self.laterThanPickerCollectionView.isHidden = true
                    }
                    return false
                }
                self.laterThanPickerCollectionView.reloadData()
                self.preferredTimePickerCollectionView.isHidden = true
                self.earlierThanPickerCollectionView.isHidden = true
                self.laterThanPickerCollectionView.isHidden = false
                self.timeView.layoutIfNeeded()
                
                if let preferredIndex = self.preferredTimeIndex, let index = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup?[preferredIndex].latestTime?.firstIndex(where: {$0.time == textField.text ?? ""})
                {
                    self.laterThanPickerCollectionView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: .centeredHorizontally, animated: false)
                    self.laterThanPickerCollectionView.setNeedsLayout()
                }
               
                
            default:
                break
            }
            
            return false
        }
        
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if txtNotLaterThan.text == ""  &&  textField == txtNotLaterThan{
            NotLaterThan()

            self.txtNotLaterThan.text = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].closeTime
        }
        else if  txtNotEarlierThan.text == "" && textField == txtNotEarlierThan {
            
            NotEarlierThan()
            self.txtNotEarlierThan.text = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].openTime
            
        }else{
        
        if textField == txtNotEarlierThan {
            let dateDiff = self.findDateDiff(time1Str: self.txtReservationtime.text ?? "", time2Str: txtNotEarlierThan.text ?? "")
            if dateDiff.first == "+"{
                txtNotEarlierThan.text = txtReservationtime.text
            }
            

        }
        if textField == txtNotLaterThan {
            let dateDiff = self.findDateDiff(time1Str: self.txtReservationtime.text ?? "", time2Str: txtNotLaterThan.text ?? "")
            if dateDiff.first == "-"{
                txtNotLaterThan.text = txtReservationtime.text
            }
            

        }
        }
        
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtReservationtime {
            let dateDiff = self.findDateDiff(time1Str: self.txtReservationtime.text ?? "", time2Str: txtNotEarlierThan.text ?? "")
            if dateDiff.first == "+"{
                txtNotEarlierThan.text = txtReservationtime.text
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "HH:mm"
            
            let dateFormatterEarlier = DateFormatter()
            dateFormatterEarlier.dateFormat = "hh:mm a"
            
            let dateEarlier = dateFormatterEarlier.date(from: self.txtNotEarlierThan.text!)
            dateFormatterEarlier.dateFormat = "HH:mm"
            
            let DateEarlier = dateFormatter.string(from: dateEarlier!)
            
            let date2 = dateFormatter.date(from: DateEarlier)
            self.datePicker3.setDate(date2!, animated: true)
            self.datePicker3.addTarget(self, action: #selector(self.didDOBDateChangeEarlier(datePicker:)), for: .valueChanged)
            self.txtNotEarlierThan.inputView = self.datePicker3
            
            let dateDiff2 = self.findDateDiff(time1Str: self.txtReservationtime.text ?? "", time2Str: txtNotLaterThan.text ?? "")
            if dateDiff2.first == "-"{
                txtNotLaterThan.text = txtReservationtime.text
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat =  "HH:mm"
                
                let dateFormatterEarlier = DateFormatter()
                dateFormatterEarlier.dateFormat = "hh:mm a"
                
                let dateEarlier = dateFormatterEarlier.date(from: self.txtNotLaterThan.text!)
                dateFormatterEarlier.dateFormat = "HH:mm"
                
                let DateEarlier = dateFormatter.string(from: dateEarlier!)
                
                let date2 = dateFormatter.date(from: DateEarlier)
                self.datePicker2.setDate(date2!, animated: true)
                self.datePicker2.addTarget(self, action: #selector(self.didDOBDateChangeLater(datePicker:)), for: .valueChanged)
                self.txtNotLaterThan.inputView = self.datePicker2
            }
        }
        
    }
    
    @IBAction func previousClicked(_ sender: Any) {
        let dateDiff = self.findDateDiff(time1Str: self.minTime ?? "", time2Str: self.currentTime ?? "")
        
        if dateDiff.first == "+"{
            currentMonth = Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.minDaysInAdvance ?? 0) + 1, to: self.dateAndTimeDromServer)

        }else{
            currentMonth = Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.minDaysInAdvance ?? 0), to: self.dateAndTimeDromServer)

        }
        
        
        let nameFormatter = DateFormatter()
        nameFormatter.dateFormat = "MMMM YYYY" // format January, February, March, ...
        
        let name = nameFormatter.string(from: currentMonth!)
        
        if  name == "\(self.lblMonth.text ?? "") \(self.lblYear.text ?? "")" {
            
        }else{
            myCalendar.setCurrentPage(getPreviousMonth(date: myCalendar.currentPage), animated: true)
        }
    }
    
    @IBAction func nextMonthClicked(_ sender: Any) {
  //      let currentDate = Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.maxDaysInAdvance)!, to: self.dateAndTimeDromServer)
        
//        let nameFormatter = DateFormatter()
//        nameFormatter.dateFormat = "MMMM"
//
//        let name = nameFormatter.string(from: currentDate!)
//
//        if  name == self.lblMonth.text {
//
//        }else{
//            myCalendar.setCurrentPage(getNextMonth(date: myCalendar.currentPage), animated: true)
//        }
//        let dateDiff = findDateDiff(time1Str: self.maxTime ?? "", time2Str: currentTime ?? "")
//        if dateDiff.first == "+"{
//            let currentDate = Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.maxDaysInAdvance ?? 0), to: self.dateAndTimeDromServer)
//            let nameFormatter = DateFormatter()
//            nameFormatter.dateFormat = "MMMM"
//
//            let name = nameFormatter.string(from: currentDate!)
//
//            if  name == self.lblMonth.text {
//
//            }else{
//                myCalendar.setCurrentPage(getNextMonth(date: myCalendar.currentPage), animated: true)
//            }
//        }else{
//            let currentDate = Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.maxDaysInAdvance ?? 0) - 1, to: self.dateAndTimeDromServer)
//            let nameFormatter = DateFormatter()
//            nameFormatter.dateFormat = "MMMM"
//
//            let name = nameFormatter.string(from: currentDate!)
//
//            if  name == self.lblMonth.text {
//
//            }else{
//                myCalendar.setCurrentPage(getNextMonth(date: myCalendar.currentPage), animated: true)
//            }
//        }
        
        let dateDiff = findDateDiff(time1Str: self.maxTime ?? "", time2Str: currentTime ?? "")
        if dateDiff.first == "+"{
            let currentDate = Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.maxDaysInAdvance ?? 0) + 1, to: self.dateAndTimeDromServer)
            let nameFormatter = DateFormatter()
            nameFormatter.dateFormat = "MMMM YYYY"
            
            let name = nameFormatter.string(from: currentDate!)
            
            if  name == "\(self.lblMonth.text ?? "") \(self.lblYear.text ?? "")" {
                
            }else{
                myCalendar.setCurrentPage(getNextMonth(date: myCalendar.currentPage), animated: true)
            }
        }else{
            let currentDate = Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.maxDaysInAdvance ?? 0), to: self.dateAndTimeDromServer)
            let nameFormatter = DateFormatter()
            nameFormatter.dateFormat = "MMMM YYYY"
            
            let name = nameFormatter.string(from: currentDate!)
            
            if  name == "\(self.lblMonth.text ?? "") \(self.lblYear.text ?? "")" {
                
            }else{
                myCalendar.setCurrentPage(getNextMonth(date: myCalendar.currentPage), animated: true)
            }
        }
    
    }
    
    //MARK:- Multi Selection button action
    @IBAction func multiSelectClicked(_ sender: UIButton)
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
        
        
        if self.appDelegate.masterLabeling.IsDiningDateValidate == 1
        {
            guard self.reservationRequestDate != nil && self.reservationRequestDate != "" else{
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.IsDiningDateValidationMessage ?? "", withDuration: Duration.kMediumDuration)
                return
            }
        }

        self.isMultiSelectClicked = true

        if self.addNewMeber == true
        {
            //Adds Popover for multi select button
            let addNewView : UIView!
            //Added by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
            //GATHER0000606 -- Start
            let popoverHeight = self.appDelegate.addRequestOpt_Dining_MultiSelect.count * 50
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
            self.diningDuplicateValidate()
            self.memberValidattionAPI({ [unowned self] (status) in
                if status == true{
                //Adds Popover for multi select button
                let addNewView : UIView!
                //Added by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
                //GATHER0000606 -- Start
                let popoverHeight = self.appDelegate.addRequestOpt_Dining_MultiSelect.count * 50
                //let popoverHeight = self.appDelegate.arrRegisterMultiMemberType.count * 50
                //GATHER0000606 -- Start
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
    
    
    //MARK:- Add member delegate from AddMemberVC
    func addMemberDelegate(selecteArray: [RequestData]) {
        if(isFrom == "Modify") || isFrom == "View"{

            let selectedObject = selecteArray[0]
            selectedObject.isEmpty = false
            if ModifyCellIndex == -1{
                arrTotalList.insert(selectedObject, at: modifyCount)
               
            }else{
                arrTotalList.remove(at: ModifyCellIndex!)
                arrTotalList.insert(selectedObject, at: ModifyCellIndex!)
            }
            
            modifyCount = arrTotalList.count
            
            if arrTotalList.count == Int(self.lblPartySizeNumber.text!)! {
                self.btnAddNewPlayer.isEnabled = false

            }
            self.modifyTableview.reloadData()
            self.view.setNeedsLayout()
            
        }else{
        let selectedObject = selecteArray[0]
        selectedObject.isEmpty = false
        arrTotalList.remove(at: selectedIndex!)
        arrTotalList.insert(selectedObject, at: selectedIndex!)

        self.partyTableview.reloadData()
        }
    }
    
    //MARK:- MemberDirectory Delegates
    func requestMemberViewControllerResponse(selecteArray: [RequestData]) {
        
        if(isFrom == "Modify") || isFrom == "View"{
            let selectedObject = selecteArray[0]
            selectedObject.isEmpty = false
            
            
            if ModifyGuestCellIndex == -1{
                arrTotalList.insert(selectedObject, at: modifyCount)
                
            }else{
                arrTotalList.remove(at: ModifyGuestCellIndex!)
                arrTotalList.insert(selectedObject, at: ModifyGuestCellIndex!)
            }
           
            modifyCount = arrTotalList.count
            
            if arrTotalList.count == Int(self.lblPartySizeNumber.text!)! {
                self.btnAddNewPlayer.isEnabled = false
                
            }
            self.modifyTableview.reloadData()
            self.view.setNeedsLayout()
            
        }else{
            
            let selectedObject = selecteArray[0]
            selectedObject.isEmpty = false
            arrTotalList.remove(at: selectedIndex!)
            arrTotalList.insert(selectedObject, at: selectedIndex!)

            self.partyTableview.reloadData()
        }
    }
    
    //Multi select response
    func multiSelectRequestMemberViewControllerResponse(selectedArray: [[RequestData]]) {
        
        if let totalPartyMembers = selectedArray.first
        {
            self.arrTotalList = totalPartyMembers
        }
        
        self.partyTableview.reloadData()
    }
    
    
    //MARK:- Modify Action
    func ModifyClicked(cell: ModifyRegCustomCell) {
        let indexPath = self.modifyTableview.indexPath(for: cell)
        selectedIndex = indexPath?.row
        arrTotalList.remove(at: selectedIndex!)
        modifyCount = arrTotalList.count
        if arrTotalList.count == 0 {
        self.lblModifyCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
        }
        
        if arrTotalList.count == Int(self.lblPartySizeNumber.text!)! {
            self.btnAddNewPlayer.isEnabled = false
        }
        else if arrTotalList.count < Int(self.lblPartySizeNumber.text!)! {
            self.btnAddNewPlayer.isEnabled = true

        }
        modifyTableview.reloadData()
        self.view.setNeedsLayout()
    }
    
    func memberViewControllerResponse(selecteArray: [MemberInfo]) {
        
       

    }
    
    func buddiesViewControllerResponse(selectedBuddy: [MemberInfo]) {
        
        
    }
    
    
    func diningSpecialRequestCheckBoxClicked(cell: CustomDashBoardCell) {
        
        selectedSpecialRequestEdit = -1
        let indexPath = self.diningCollectionView.indexPath(for: cell)
        if selectedSpecialRequest == indexPath?.row {
            cell.btnDiningRequest.isSelected = true
        }else{
            cell.btnDiningRequest.isSelected = false
        }
        
        if cell.btnDiningRequest.isSelected == false {
            cell.btnDiningRequest.isSelected = true
          selectedSpecialRequest = indexPath?.row
            //Added on 7th October 2020
            if let timeSetup = self.diningSettings?.restaurantDetails?[selectedCellIndex!].timeSetup
            {
                selectedPreferenceID = (timeSetup[self.preferredTimeIndex!].tablePreference?[(indexPath?.row)!].tablePreferenceID)!
            }
            else
            {
                //Modified by kiran V2.5 -- GATHER0000606 -- commented old logic i.e., logic before time setup is added
                //GATHER0000606 -- Start
                //Old logic
                /*
                selectedPreferenceID = (self.diningSettings?.restaurantDetails?[selectedCellIndex!].tablePreferences?[(indexPath?.row)!].tablePreferenceID)!
                 */
                
                //GATHER0000606 -- End
            }
            
            
        }else {
            cell.btnDiningRequest.isSelected = false
            selectedSpecialRequest = -1
           selectedPreferenceID = ""
        }
        self.diningCollectionView.reloadData()
    }
    
    func threeDotsClickedToMoveGroup(cell: CustomNewRegCell) {
        
    }
    func clearButtonClicked(cell: CustomNewRegCell) {
        
            let indexPath = self.partyTableview.indexPath(for: cell)
            selectedIndex = indexPath?.row
            arrTotalList.remove(at: selectedIndex!)
            arrTotalList.insert(RequestData(), at: selectedIndex!)
//        if selectedIndex == 0 {
//            captainName = ""
//            requestClear = "Yes"
//        }
            partyTableview.reloadData()
        
    }
    
    func checkBoxClicked(cell: GlanceCustomTableViewCell) {
        selectedSpecialRequestEdit = -1
        let indexPath = self.restaurantTableView.indexPath(for: cell)
        //Added by kiran V2.4 -- ENGAGE0011198
        self.selectedPreferenceID = ""
        
        selectedCellIndex = indexPath?.row
        selectedCellModifyIndex = indexPath?.row
        self.requestReservationApi()
        defaultRestaurant = true
        self.restaurantTableView.reloadData()
    }
    
    //MARK:- Add new popover (register) button action
    func addNewPopOverClickedDining(cell: CustomNewRegCell) {
        
        if self.appDelegate.masterLabeling.IsDiningDateValidate == 1
        {
            guard self.reservationRequestDate != nil && self.reservationRequestDate != "" else{
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.IsDiningDateValidationMessage ?? "", withDuration: Duration.kMediumDuration)
                return
            }
        }
        
        self.isMultiSelectClicked = false
        if self.addNewMeber == true{
            self.addNewPopOverForRequest(cell: cell)
        }else{
            self.diningDuplicateValidate()
            self.memberValidattionAPI({ [unowned self] (status) in
                if status == true{
                    self.addNewPopOverForRequest(cell: cell)
                }
            })
        }
        
        
    }
    
    //MARK:- Add new popover for request
    func addNewPopOverForRequest(cell: CustomNewRegCell) {
        let indexPath = self.partyTableview.indexPath(for: cell)
        
        selectedIndex = indexPath?.row
        selectedSection = indexPath?.section
        
        let addNewView : UIView!
        
        //Modified by kiran V2.5 -- GATHER0000606 -- modified to change height based on no of options
        //GATHER0000606 -- Start
        let optionsHeight = self.numberOfPopupOptions() * 50
        
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
        
    }
    func addNewPopOverClicked(cell: CustomNewRegCell) {
        
        
    }
    func editClicked(cell: CustomNewRegCell) {
        
    }
    
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
    
    func specialEventRequest()
    {
        guard self.isFrom != "View" else{return}
        
        if let cancelViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController {
            if self.isFrom == "Modify"{
                cancelViewController.eventType = 1
                cancelViewController.requestID = self.requestID
                
                cancelViewController.isFrom = "ModifySpecialEvent"
                if self.isOnlyFrom == "EventsModify"{
                    cancelViewController.isOnlyFrom = "EventSPecialDiningUpdate"
                }
                
            }else{
                cancelViewController.isFrom = "SpecialEvent"
                cancelViewController.eventType = 0
                cancelViewController.requestID = ""
            }
            cancelViewController.cancelFor = .DiningSpecialEvent
            //cancelViewController.message = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].validationMessage
            cancelViewController.reservationReqDate = self.reservationRequestDate
            cancelViewController.reservationRemindDate = self.reservationRemindDate
            cancelViewController.diningSettings = self.diningSettings
            //cancelViewController.eventID = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].eventID
            
            //Modified on 8th October 2020
            if let timeSetup = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup
            {
                cancelViewController.message = timeSetup[self.preferredTimeIndex!].validationMessage
                cancelViewController.eventID = timeSetup[self.preferredTimeIndex!].eventID
            }
            else
            {
                //Modified by kiran V2.5 -- GATHER0000606 -- commented old logic i.e., logic before time setup is added
                //GATHER0000606 -- Start
                //Old logic
                /*
                cancelViewController.message = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].validationMessage
                cancelViewController.eventID = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].eventID
                 */
                
                //GATHER0000606 -- End
            }
            
            self.navigationController?.pushViewController(cancelViewController, animated: true)
        }
    }
    
    //Mark- Get Reservation Setting Details Api

    func requestReservationApi() {
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        var paramaterDict: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
            "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!,
            "ReservationRequestDate": reservationRequestDate ?? "",
            "PreviousRequestDate": previousRequestDate ?? ""
        ]
        
        //Added on 13th October 2020 V2.3
        if self.isFrom == "View" || self.isViewOnly
        {
            //This is used to send details in time setup when in view mode for the reqeusts which are made from back office for the time which is not allowed to be used in app and website.
            paramaterDict.updateValue(self.requestID ?? "", forKey: "RequestID")
        }
        
        print(paramaterDict)
        APIHandler.sharedInstance.getReservationSettings(paramater: paramaterDict , onSuccess: { response in
            if self.isFirstTime == 1 && (self.isFrom == "Modify" || self.isFrom == "View") {
                //Time reset is done at the end of this function
                self.reservationRequestDate = nil

            }
            self.diningSettings = response.dinningSettings
            //Added by kiran V2.5 -- GATHER0000606 -- Hides add button for modify scenario
            //GATHER0000606 -- Start
            if self.isFrom == "Modify"
            {
                self.btnAddNewPlayer.isHidden = self.shouldHideMemberAddOption()
            }
            //GATHER0000606 -- End
            self.appDelegate.hideIndicator()
            
            //Added on 7th October 2020 V2.3
            if let _ = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup
            {
                self.diningDuplicateValidate()
                self.memberValidattionAPI({ (status) in
                    
                })
            }
            else
            {
                //Modified by kiran V2.5 -- GATHER0000606 -- commented old logic i.e., logic before time setup is added
                //GATHER0000606 -- Start
                //Old logic
                /*
                if response.dinningSettings?.restaurantDetails?[self.selectedCellIndex!].specialEvent == 1 &&  response.dinningSettings?.restaurantDetails?[self.selectedCellIndex!].isRegistered == 1 && self.isFirstTime != 1{
                    SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.dinningSettings?.restaurantDetails?[self.selectedCellIndex!].validationMessage, withDuration: Duration.kMediumDuration)
                    self.reservationRequestDate = nil
                  
                    let delay = 3 // seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
                    for date in self.myCalendar!.selectedDates{
                        self.myCalendar.deselect(date)
                    }
                    }
                }else if response.dinningSettings?.restaurantDetails?[self.selectedCellIndex!].specialEvent == 1 && self.isFirstTime != 1{
                    self.specialEventRequest()
                }else{
                    self.diningDuplicateValidate()
                    self.memberValidattionAPI({ [unowned self] (status) in
                        
                    })
                    
                }
                */
                
                //GATHER0000606 -- End
            }

            if self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].isEffectivityChanged == 1 || self.isDateChanged == "No"
            {
                
                self.minTime = self.diningSettings?.minDaysInAdvanceTime
                self.maxTime = self.diningSettings?.maxDaysInAdvanceTime
                
                if let _ = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup
                {
                    self.resetTimeSelection()
                }
                else
                {
                    //Modified by kiran V2.5 -- GATHER0000606 -- commented old logic i.e., logic before time setup is added
                    //GATHER0000606 -- Start
                    /*
                    let dateAsStringMin = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].openTime
                    let dateFormatterMin = DateFormatter()
                    dateFormatterMin.dateFormat = "hh:mm a"
                    
                    let dateMin = dateFormatterMin.date(from: dateAsStringMin!)
                    dateFormatterMin.dateFormat = "HH:mm"
                    
                    let DateMin = dateFormatterMin.string(from: dateMin!)
                    
                    let dateAsStringMax = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].closeTime
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
                    self.datePicker1.minuteInterval = (self.diningSettings?.timeInterval)!  // with interval of 30
                    
                    self.datePicker1.setDate(date!, animated: true)
                    self.datePicker1.addTarget(self, action: #selector(self.didDOBDateChange(datePicker:)), for: .valueChanged)
                    self.txtReservationtime.inputView = self.datePicker1
                    self.txtReservationtime.delegate = self
                    
                    let dateFormatter2 = DateFormatter()
                    dateFormatter2.dateFormat =  "HH:mm"
                    let date2 = dateFormatter2.date(from: DateMax)
                    
                    self.datePicker2.datePickerMode = .time
                    
                    let minLater = dateFormatter2.date(from: DateMin)      //createing min time
                    let maxLater = dateFormatter2.date(from: DateMax) //creating max time
                    self.datePicker2.minimumDate = minLater  //setting min time to picker
                    self.datePicker2.maximumDate = maxLater
                    self.datePicker2.minuteInterval = (self.diningSettings?.timeInterval)!  // with interval of 30
                    
                    self.datePicker2.setDate(date2!, animated: true)
                    self.datePicker2.addTarget(self, action: #selector(self.didDOBDateChangeLater(datePicker:)), for: .valueChanged)
                    self.txtNotLaterThan.inputView = self.datePicker2
                    self.txtNotLaterThan.delegate = self
                    
                    
                   
                    
                    let dateFormatter3 = DateFormatter()
                    dateFormatter3.dateFormat =  "HH:mm"
                    let date3 = dateFormatter3.date(from: DateMin)
                    
                    self.datePicker3.datePickerMode = .time
                    
                    let minEarlier = dateFormatter3.date(from: DateMin)      //createing min time
                    let maxEarlier = dateFormatter3.date(from: DateMax) //creating max time
                    self.datePicker3.minimumDate = minEarlier  //setting min time to picker
                    self.datePicker3.maximumDate = minEarlier
                    self.datePicker3.minuteInterval = self.diningSettings?.timeInterval ?? 0  // with interval of 30
                    
                    self.datePicker3.setDate(date3!, animated: true)
                    self.datePicker3.addTarget(self, action: #selector(self.didDOBDateChangeEarlier(datePicker:)), for: .valueChanged)
                    self.txtNotEarlierThan.inputView = self.datePicker3
                    self.txtNotEarlierThan.delegate = self
                    
                    self.txtReservationtime.text = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].openTime
                    self.txtNotEarlierThan.text = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].openTime
                    self.txtNotLaterThan.text = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].closeTime
                    */
                    //GATHER0000606 -- End
                }
                
                let dateFormatterToSend = DateFormatter()
                dateFormatterToSend.dateFormat = "MM/dd/yyyy"
                //            self.reservationRequestDate = dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!)
                //
                //            self.reservationRemindDate = self.newFormatter.string(from: Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!)
                
                
                //                let dateFormatterToSend = DateFormatter()
                //                dateFormatterToSend.dateFormat = "MM/dd/yyyy"
                //
                let dateString = self.diningSettings?.gETDATETIME
                
                
                let dateFormatter6 = DateFormatter()
                dateFormatter6.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                dateFormatter6.locale = Locale(identifier: "en_US_POSIX")
                self.dateAndTimeDromServer = dateFormatter6.date(from:dateString ?? "")!
                
                let currentDateFormatter = DateFormatter()
                currentDateFormatter.dateFormat = "hh:mm a"
                self.currentTime = currentDateFormatter.string(from:self.dateAndTimeDromServer)
                
                if self.isFrom == "Modify" || self.isFrom == "View" {
                    if self.reservationRequestDate == nil{
                        
                        let dateFormatterYear = DateFormatter()
                        dateFormatterYear.dateFormat = "LLLL"
                        let dateDiff = self.findDateDiff(time1Str: self.minTime ?? "", time2Str: self.currentTime ?? "")
                        
                        if dateDiff.first == "+"{
                            self.nameOfMonth = dateFormatterYear.string(from: Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.minDaysInAdvance)! + 1, to: self.dateAndTimeDromServer)!)
                            
                            
                        }else{
                            self.nameOfMonth = dateFormatterYear.string(from: Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!)
                            
                        }
                        let calendar = Calendar.current
                        self.lblYear.text = "\(calendar.component(.year, from: self.dateAndTimeDromServer))"
                        
                        self.lblMonth.text = self.nameOfMonth
                        
                        self.myCalendar.reloadData()
                    }
                    
                }
                else{
                    if self.reservationRequestDate == nil{
                        if self.defaultRestaurant == false {
                            
                            let dateDiff = self.findDateDiff(time1Str: self.minTime ?? "", time2Str: self.currentTime ?? "")
                            if dateDiff.first == "-"{
                                // self.myCalendar.select(Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer))
                                //  self.reservationRequestDate = dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!)
                                //   self.reservationRemindDate = self.newFormatter.string(from: Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!)
                                
                                
                            }else{
                                
                                //  self.myCalendar.select(Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.minDaysInAdvance)! + 1, to: self.dateAndTimeDromServer))
                                //  self.reservationRequestDate = dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.minDaysInAdvance)! + 1, to: self.dateAndTimeDromServer)!)
                                // self.reservationRemindDate = self.newFormatter.string(from: Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.minDaysInAdvance)! + 1, to: self.dateAndTimeDromServer)!)
                                
                                
                            }
                        }
                        let dateFormatterYear = DateFormatter()
                        dateFormatterYear.dateFormat = "LLLL"
                        let dateDiff = self.findDateDiff(time1Str: self.minTime ?? "", time2Str: self.currentTime ?? "")
                        
                        if dateDiff.first == "+"{
                            self.nameOfMonth = dateFormatterYear.string(from: Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.minDaysInAdvance)! + 1, to: self.dateAndTimeDromServer)!)
                        }else{
                            self.nameOfMonth = dateFormatterYear.string(from: Calendar.current.date(byAdding: .day, value: +(self.diningSettings?.minDaysInAdvance)!, to: self.dateAndTimeDromServer)!)
                            
                        }
                        let calendar = Calendar.current
                        self.lblYear.text = "\(calendar.component(.year, from: self.dateAndTimeDromServer))"
                        if self.isDateSelected == true{
                        
                        }else{
                        self.lblMonth.text = self.nameOfMonth
                        }
                        self.myCalendar.reloadData()
                        
                    }
                    
                    
                }
                self.btnIncrease.isEnabled = true
                
                if (self.isFrom == "Modify" || self.isFrom == "View") && self.isFirstTime == 1{
                    self.getDiningEventDetailsApi()
                    
                    self.isFirstTime = 0
                }else{
                    self.selectedSpecialRequestEdit = -1
                }
                
                //Modified on 7th October 2020 V2.3
                if let _ = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup
                {
                    //self.preferredTimeIndex = 0
                    //self.updateDetailsForTime(time: timeSetup[self.preferredTimeIndex], removeMembers: true)
                }
                else
                {
                    //Modified by kiran V2.5 -- GATHER0000606 -- commented old logic i.e., logic before time setup is added
                    //GATHER0000606 -- Start
                    /*
                    self.partyCount = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].maxPartysize
                    
                    if self.partyCount! < self.arrTotalList.count
                    {
                        let  arrTemp =  self.arrTotalList
                        
                        self.arrTotalList.removeAll()
                        let content =  arrTemp[0..<Int(self.partyCount!)]
                        self.arrTotalList.append(contentsOf: content)
                        self.lblPartySizeNumber.text = String(format: "%02d", self.arrTotalList.count)
                        self.modifyTableview.reloadData()
                        self.btnAddNewPlayer.isEnabled = false
                        
                        
                    }
                    else if self.partyCount! == self.arrTotalList.count
                    {
                        self.lblPartySizeNumber.text = String(format: "%02d", self.arrTotalList.count)
                        self.modifyTableview.reloadData()
                        self.btnAddNewPlayer.isEnabled = false
                    }
                    else
                    {
                        let  arrTemp =  self.arrTotalList
                        
                        self.arrTotalList.removeAll()
                        let content =  arrTemp[0..<Int(arrTemp.count)]
                        self.arrTotalList.append(contentsOf: content)
                        if self.arrTotalList.count < Int(self.lblPartySizeNumber.text!)!
                        {
                            if self.partyCount! <= Int(self.lblPartySizeNumber.text!)!
                            {
                                self.lblPartySizeNumber.text = String(format: "%02d", self.partyCount!)
                                
                            }
                            self.btnAddNewPlayer.isEnabled = true
                        }
                        else
                        {
                            self.lblPartySizeNumber.text = String(format: "%02d", self.arrTotalList.count)
                            self.btnAddNewPlayer.isEnabled = false
                        }
                        self.modifyTableview.reloadData()
                        
                    }
                    */
                    //GATHER0000606 -- End
                }

                self.selectedSpecialRequest = -1
              //  self.txtComments.text = ""
                self.restaurantTableView .reloadData()
                self.partyTableview.reloadData()
                self.diningCollectionView.reloadData()
                self.appDelegate.hideIndicator()
            }
            else
            {
                //Modified on 8th October 2020 V2.3
                if let _ = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup
                {
                    self.resetTimeSelection()
                }
                
            }
           
            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            self.appDelegate.hideIndicator()
        }
    }
    //Mark- Get Dining Request Details Api

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
                "RequestID": requestID ?? ""
            ]
            
            APIHandler.sharedInstance.getRequestDiningDetails(paramaterDict: paramaterDict, onSuccess: { response in
                self.appDelegate.hideIndicator()
                
                if(response.responseCode == InternetMessge.kSuccess)
                {
                    if(response.requestDiningDetails == nil){
                        self.arrTeeTimeDetails.removeAll()
                        self.partyTableview.setEmptyMessage(InternetMessge.kNoData)
                        self.partyTableview.reloadData()
                    }
                    else{
                       
                        
                        if(response.requestDiningDetails?.count == 0)
                        {
                            self.arrTeeTimeDetails.removeAll()
                            self.partyTableview.setEmptyMessage(InternetMessge.kNoData)
                            self.partyTableview.reloadData()
                            
                            
                        }else{
                            self.arrTeeTimeDetails = response.requestDiningDetails! //eventList.listevents!

                            self.reservationRequestDate = self.formatter.string(from: self.formatter.date(from: self.arrTeeTimeDetails[0].reservationRequestDate!)!)
                          //  self.requestReservationApi()
                            self.partyTableview.restore()
                            self.partyTableview.reloadData()
                            self.lblConfirmNumber.text = self.arrTeeTimeDetails[0].confirmationNumber ?? " "
                            self.txtReservationtime.text = self.arrTeeTimeDetails[0].reservationRequestTime
                            self.txtNotEarlierThan.text = self.arrTeeTimeDetails[0].earliest
                            self.txtNotLaterThan.text = self.arrTeeTimeDetails[0].latest
                            self.lblPartySizeNumber.text = String(format: "%02d",self.arrTeeTimeDetails[0].partySize!)
                            self.modifyCount = self.arrTeeTimeDetails[0].diningDetails?.count ?? 0
                            
                            self.arrTotalList.removeAll()
                            
                            self.isFirstTime = 0
                            

                            if self.arrTeeTimeDetails[0].buttonTextValue == "3" || self.arrTeeTimeDetails[0].buttonTextValue == "4"  || self.arrTeeTimeDetails[0].buttonTextValue == "5" {
                                
                                self.timeView.isHidden = true
                                //self.heigthTimeView.constant = 0
                                //Added on 7th October 2020
                                self.timeView.layoutIfNeeded()
                                
                                self.completeCalendarView.isHidden = true
                                self.heightCalendar.constant = 0
                                self.viewRestaurant.isUserInteractionEnabled = false
                                self.viewSpecialRequest.isUserInteractionEnabled = false
                                self.viewComments.isUserInteractionEnabled = false
                                self.txtReservationtime.isEnabled = false
                                self.txtNotLaterThan.isEnabled = false
                                self.txtNotEarlierThan.isEnabled = false
                                self.viewParty.isUserInteractionEnabled = false
                                self.partyTableview.isHidden = true
                                self.viewModify.isHidden = false
                                //self.isFirstTime = 1
                                
                                self.heightSelectRequestDate.constant = 20
                                self.lblSelectRequestdate.isHidden = true
                                self.viewSelectRestaurant.isHidden = true
                                
                                self.heightSelectRestaurant.constant = 0
                                
                                self.btnModifyDate.isHidden = false
                                self.btnModifyTime.isHidden = false

//                                self.btnRequest.backgroundColor = .clear
//                                self.btnRequest.layer.cornerRadius = 18
//                                self.btnRequest.layer.borderWidth = 1
//                                self.btnRequest.layer.borderColor = UIColor.clear.cgColor
//                                self.btnRequest .setTitle(self.appDelegate.masterLabeling.Save, for: UIControlState.normal)
//                                self.btnRequest.setTitleColor(UIColor.white, for: UIControlState.normal)
                                self.view.layoutIfNeeded()
                                //Added on 16th October 2020 V2.3
                                self.viewSelectRestaurant.layoutIfNeeded()
                                
                            }
                            else{
                                
                                if self.isFrom == "View" {
                                    //self.heigthTimeView.constant = 0
                                    
                                    self.timeView.isHidden = true
                                    //Added on 7th October 2020
                                    self.timeView.layoutIfNeeded()
                                }
                                else{
                                    self.txtReservationtime.text = self.arrTeeTimeDetails[0].reservationRequestTime ?? ""
                                    self.txtNotEarlierThan.text = self.arrTeeTimeDetails[0].earliest ?? ""
                                    self.txtNotLaterThan.text = self.arrTeeTimeDetails[0].latest ?? ""
                                    
                                    let dateFormatterMin = DateFormatter()
                                    dateFormatterMin.dateFormat = "hh:mm a"
                                    
                                    
                                    let dateMin = dateFormatterMin.date(from: self.txtReservationtime.text ?? "")
                                    dateFormatterMin.dateFormat = "HH:mm"
                                    
                                    let DateMin = dateFormatterMin.string(from: dateMin!)
                                    
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat =  "HH:mm"
                                    let date = dateFormatter.date(from: DateMin)
                                    
                                    self.datePicker1.setDate(date!, animated: true)
                                    self.datePicker1.addTarget(self, action: #selector(self.didDOBDateChange(datePicker:)), for: .valueChanged)
                                    self.txtReservationtime.inputView = self.datePicker1
                                    
                                    if self.txtNotEarlierThan.text == "" {
                                        
                                    }else{
                                    let dateFormatterEarlier = DateFormatter()
                                    dateFormatterEarlier.dateFormat = "hh:mm a"
                                    
                                    let dateEarlier = dateFormatterEarlier.date(from: self.txtNotEarlierThan.text ?? "")
                                    dateFormatterEarlier.dateFormat = "HH:mm"
                                    
                                    let DateEarlier = dateFormatterMin.string(from: dateEarlier!)
                                    
                                    
                                    let date2 = dateFormatter.date(from: DateEarlier)
                                    self.datePicker3.setDate(date2!, animated: true)
                                    self.datePicker3.addTarget(self, action: #selector(self.didDOBDateChangeEarlier(datePicker:)), for: .valueChanged)
                                    self.txtNotEarlierThan.inputView = self.datePicker3
                                        self.NotEarlierThan()
                                        self.NotLaterThan()
                                    }
                                    if self.txtNotLaterThan.text == "" {
                                        
                                    }else{
                                    let dateFormatterLater = DateFormatter()
                                    dateFormatterLater.dateFormat = "hh:mm a"
                                    
                                    let dateLater = dateFormatterLater.date(from: self.txtNotLaterThan.text ?? "")
                                    dateFormatterLater.dateFormat = "HH:mm"
                                    
                                    let DatLater = dateFormatterMin.string(from: dateLater!)
                                    
                                    let date3 = dateFormatter.date(from: DatLater)
                                    
                                    
                                    self.datePicker2.setDate(date3!, animated: true)
                                    self.datePicker2.addTarget(self, action: #selector(self.didDOBDateChangeLater(datePicker:)), for: .valueChanged)
                                    self.txtNotLaterThan.inputView = self.datePicker2
                                        self.NotEarlierThan()
                                        self.NotLaterThan()
                                    }
                                   
                                    
                                    self.reservationRequestDate = self.formatter.string(from: self.formatter.date(from: self.arrTeeTimeDetails[0].reservationRequestDate!)!)
                                    
                                }
                                
                            }

                            self.selectedPreferenceID = self.arrTeeTimeDetails[0].tablePreference ?? ""
                            
                            for _ in 0..<self.arrTeeTimeDetails[0].diningDetails!.count {
                                self.arrTotalList.append(RequestData())
                            }
                            
                            for i in 0..<self.arrTeeTimeDetails[0].diningDetails!.count {
                                self.arrTotalList.remove(at: i)

                                self.arrTotalList.insert(((self.arrTeeTimeDetails[0].diningDetails?[i])!), at: i)
                                let playObj = self.arrTotalList[i] as! GroupDetail
                                
                                self.arrRegReqID.append(playObj.reservationRequestDetailId ?? "")

                            }
                            if self.arrTotalList.count == 1{
                                self.btnDecrease.isEnabled = false
                            }
                            
                            if self.arrTeeTimeDetails[0].isCancel == 1{
                                if self.isFrom == "View" {
                                    self.btnCancelreser.isHidden = true
                                    
                                    
                                }else{
                                    
                                }
                                
                            }else{
                                self.btnCancelreser.isHidden = true
                                self.heightCancelResr.constant = -20
                            }
                  
                         //   self.myCalendar.select(self.formatter.date(from: self.arrTeeTimeDetails[0].reservationRequestDate!)!)
                            
                            self.btnModifyDate.setTitle(self.arrTeeTimeDetails[0].reservationRequestDate, for: UIControlState.normal)
                            self.btnModifyTime.setTitle(self.arrTeeTimeDetails[0].reservationRequestTime, for: UIControlState.normal)
            
                            
                            let  arrTemp =  self.diningSettings!.restaurantDetails!
                            
                            //Added on 13th October 2020 V2.3
                            if self.isFrom == "View" || self.isViewOnly
                            {
                                for i in 0..<arrTemp.count
                                {
                                    if self.arrTeeTimeDetails[0].preferedSpaceDetailId == self.diningSettings?.restaurantDetails?[i].id
                                    {
                                        if self.selectedCellModifyIndex == -1
                                        {
                                            self.selectedCellModifyIndex = i
                                            self.selectedCellIndex = self.selectedCellModifyIndex
                                        }
                                        break
                                    }
                                }
                                    
                            }
                            else
                            {
                                
                                for i in 0..<arrTemp.count{
                                    
    //                                if self.isFrom == "View"{
    //
    //
    //                                self.diningSettings?.restaurantDetails?.removeAll()
    //                                    if self.arrTeeTimeDetails[0].preferedSpaceDetailId == arrTemp[i].id{
    //                                    let content =  arrTemp[i]
    //                                        self.diningSettings?.restaurantDetails?.append(content)
    //
    //                                }
    //                                }else{
                                    if self.arrTeeTimeDetails[0].preferedSpaceDetailId == self.diningSettings?.restaurantDetails?[i].id
                                    {
                                        //Modified on 7th October 2020
                                        self.preferredTimeIndex = self.diningSettings?.restaurantDetails?[i].timeSetup?.firstIndex(where: {$0.time == self.arrTeeTimeDetails[0].reservationRequestTime ?? ""})
                                        
                                        
                                        
                                        self.preferredTimePickerCollectionView.reloadData()
                                        self.earlierThanPickerCollectionView.reloadData()
                                        self.laterThanPickerCollectionView.reloadData()
                                       
                                        if self.selectedCellModifyIndex == -1 {
                                            self.selectedCellModifyIndex = i
                                            self.selectedCellIndex = self.selectedCellModifyIndex
                                            
                                            //Added on 8th October 2020 V2.3
                                            
                                            if let timeSetup = self.diningSettings!.restaurantDetails![self.selectedCellModifyIndex!].timeSetup
                                            {
                                                if timeSetup[self.preferredTimeIndex!].specialEvent == 1 &&  timeSetup[self.preferredTimeIndex!].isRegistered == 1 && self.isFirstTime != 1
                                                {
                                                    SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:timeSetup[self.preferredTimeIndex!].validationMessage, withDuration: Duration.kMediumDuration)
                                                    
                                                    self.reservationRequestDate = nil
                                                    
                                                    let delay = 3 // seconds
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)){
                                                        
                                                        for date in self.myCalendar!.selectedDates
                                                        {
                                                            self.myCalendar.deselect(date)
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                    //Added on 9th October 2020 V2.3
                                                    self.resetTimeSelection()
                                                }
                                                else if timeSetup[self.preferredTimeIndex!].specialEvent == 1 && self.isFirstTime != 1
                                                {
                                                    self.specialEventRequest()
                                                }
                                                
                                            }
                                            else
                                            {
                                                //Modified by kiran V2.5 -- GATHER0000606 -- commented old logic i.e., logic before time setup is added
                                                //GATHER0000606 -- Start
                                                /*
                                                if self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].specialEvent == 1 &&  self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].isRegistered == 1 && self.isFirstTime != 1
                                                {
                                                    SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].validationMessage, withDuration: Duration.kMediumDuration)
                                                    self.reservationRequestDate = nil
                                                    
                                                    let delay = 3 // seconds
                                                    
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
                                                        for date in self.myCalendar!.selectedDates
                                                        {
                                                            self.myCalendar.deselect(date)
                                                        }
                                                        
                                                    }
                                                }
                                                else if self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].specialEvent == 1 && self.isFirstTime != 1
                                                {
                                                    self.specialEventRequest()
                                                }
                                                */
                                                //GATHER0000606 -- End
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                    

                                }
                               

                            }
                            
                            self.restaurantTableView.reloadData()

//                            for i in 0..<self.diningSettings!.restaurantDetails!.count{
                            if self.selectedCellModifyIndex == -1 {
                                
                                
                            }
                            else
                            {
                                //Added on 13th October 2020 V2.3
                                if self.isFrom == "View" || self.isViewOnly
                                {
                                    if (self.arrTeeTimeDetails[0].tablePreference?.count ?? 0) > 0
                                    {
                                        let preference = TablePreferencesType.init()
                                        preference.preferenceName = self.arrTeeTimeDetails[0].tablePreferenceName
                                        preference.tablePreferenceID = self.arrTeeTimeDetails[0].tablePreference
                                        
                                        self.arrPreference = [preference]
                                        self.selectedSpecialRequestEdit = 0
                                    }
                                   
                                }
                                else
                                {
                                    //Modified on 7th October 2020
                                    if let timeSetup = self.diningSettings?.restaurantDetails?[self.selectedCellModifyIndex!].timeSetup
                                    {
                                        for j in 0..<timeSetup[self.preferredTimeIndex!].tablePreference!.count
                                        {
                                            if self.arrTeeTimeDetails[0].tablePreference == timeSetup[self.preferredTimeIndex!].tablePreference?[j].tablePreferenceID
                                            {
                                                if self.selectedSpecialRequestEdit == -1
                                                {
                                                    self.selectedSpecialRequestEdit = j
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                    }
                                    else
                                    {
                                        //Modified by kiran V2.5 -- GATHER0000606 -- commented old logic i.e., logic before time setup is added
                                        //GATHER0000606 -- Start
                                        /*
                                        for j in 0..<self.diningSettings!.restaurantDetails![self.selectedCellModifyIndex!].tablePreferences!.count
                                        {
                                            if self.arrTeeTimeDetails[0].tablePreference == self.diningSettings?.restaurantDetails?[self.selectedCellModifyIndex!].tablePreferences?[j].tablePreferenceID
                                            {
                                                if self.selectedSpecialRequestEdit == -1
                                                {
                                                    self.selectedSpecialRequestEdit = j
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                        */
                                        //GATHER0000606 -- End
                                        
                                    }
                                }

                            }

                            self.txtComments.text = self.arrTeeTimeDetails[0].comments
//                            let dateFormatterYear = DateFormatter()
//                            dateFormatterYear.dateFormat = "LLLL"
//                            self.nameOfMonth = dateFormatterYear.string(from: self.formatter.date(from: self.arrTeeTimeDetails[0].reservationRequestDate!)!)
//                            
//                            let calendar = Calendar.current
//                            self.lblYear.text = "\(calendar.component(.year, from: self.dateAndTimeDromServer))"
//                            
//                            self.lblMonth.text = self.nameOfMonth
                            
                            self.lblModifyCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
                            
                            self.modifyTableview.reloadData()
                            self.diningCollectionView.reloadData()
                        }
                        
                    }
                    
                    if(!(self.arrTeeTimeDetails.count == 0)){
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.partyTableview.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    
                    if let partySize = response.requestDiningDetails?[0].partySize
                    {
                        self.numberOfTickets = partySize
                    }
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((response.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: response.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.partyTableview.setEmptyMessage(response.responseMessage ?? "")
                    
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        //MOdified on 8th October 2020 V2.3
        switch collectionView
        {
        case self.preferredTimePickerCollectionView:
            return self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup?.count ?? 0
        case self.earlierThanPickerCollectionView:
            if let preferredIndex = self.preferredTimeIndex
            {
                return self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup?[preferredIndex].earliestTime?.count ?? 0
            }
            
        case self.laterThanPickerCollectionView:
            
            if let preferredIndex = self.preferredTimeIndex
            {
                return self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup?[preferredIndex].latestTime?.count ?? 0
            }

        case self.diningCollectionView:
            
            if let timeSetup = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup
            {
                if self.isFrom == "View" || self.isViewOnly
                {
                    return self.arrPreference.count
                }
                
                if let preferredIndex = self.preferredTimeIndex
                {
                    return timeSetup[preferredIndex].tablePreference?.count ?? 0
                }
                
            }
            else
            {
                //Modified by kiran V2.5 -- GATHER0000606 -- commented old logic i.e., logic before time setup is added
                //GATHER0000606 -- Start
                
                //return self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].tablePreferences?.count ?? 0
                
                //GATHER0000606 -- End
            }
            
        default :
            break
        }
        
        return 0
            //return self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].tablePreferences?.count ?? 0

    }
    
    //Added on 8th October 2020 V2.3
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        switch collectionView
        {
        case self.preferredTimePickerCollectionView,self.earlierThanPickerCollectionView,self.laterThanPickerCollectionView:
            
            var timeString = ""
            let height : CGFloat = 70
            
            if collectionView == self.preferredTimePickerCollectionView
            {
                timeString = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup?[indexPath.row].time ?? ""
            }
            else if collectionView == self.earlierThanPickerCollectionView
            {
                timeString = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup?[self.preferredTimeIndex!].earliestTime?[indexPath.row].time ?? ""
            }
            else if collectionView == self.laterThanPickerCollectionView
            {
                timeString = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup?[self.preferredTimeIndex!].latestTime?[indexPath.row].time ?? ""
            }
            
            //This is the font given in Interface builder
            let font = UIFont.init(name: "SourceSansPro-Semibold", size: 29.0)
            //5 is the leading and trailing padding given in Interface Builder
            let width = 5 + timeString.width(withConstrainedHeight: height, font: font!) + 5
            
            return CGSize.init(width: width, height: height)
            
        case self.diningCollectionView:
            let itemSize = (UIScreen.main.bounds.width - 48)/2-1
            return CGSize(width: itemSize + 0.25, height: itemSize/4)
        default:
            return CGSize.zero
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case self.preferredTimePickerCollectionView,self.earlierThanPickerCollectionView,self.laterThanPickerCollectionView:
            
            var timeString : String?
            var colorHex = UIColor.clear
            var isSelected = false
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCollectionViewCell", for: indexPath) as! TimeCollectionViewCell
            
            if collectionView == self.preferredTimePickerCollectionView
            {
                timeString = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup?[indexPath.row].time
                isSelected = self.txtReservationtime.text == timeString
            }
            else if collectionView == self.earlierThanPickerCollectionView
            {
                timeString = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup?[self.preferredTimeIndex!].earliestTime?[indexPath.row].time
                isSelected = self.txtNotEarlierThan.text == timeString
            }
            else if collectionView == self.laterThanPickerCollectionView
            {
                timeString = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup?[self.preferredTimeIndex!].latestTime?[indexPath.row].time
                isSelected = self.txtNotLaterThan.text == timeString
            }
            
            if isSelected
            {
                colorHex = APPColor.MainColours.primary2
            }
            else
            {
                colorHex = hexStringToUIColor(hex: "#818181")
            }
            let time = timeString?.date(format: "hh:mm a")
            cell.lblTime.text = time?.toString(format: "hh:mm")
            cell.lblPeriod.text = time?.toString(format: "a")
            
            cell.lblTime.textColor = colorHex//hexStringToUIColor(hex: colorHex)
            cell.lblPeriod.textColor = colorHex//hexStringToUIColor(hex: colorHex)
            
            return cell
        case self.diningCollectionView:
            
            if self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup != nil || self.isFrom == "View" || self.isViewOnly  //let timeSetup = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup
            {
                var preferenceName : String?
                var tablePreferences : [TablePreferencesType]?
                
                if self.isFrom == "View" || self.isViewOnly
                {
                    preferenceName = self.arrPreference[indexPath.row].preferenceName
                    tablePreferences = self.arrPreference
                }
                else
                {
                    let timeSetup = self.diningSettings!.restaurantDetails![self.selectedCellIndex!].timeSetup!
                    preferenceName = timeSetup[self.preferredTimeIndex!].tablePreference?[indexPath.row].preferenceName
                    tablePreferences = timeSetup[self.preferredTimeIndex!].tablePreference
                }
                
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCell", for: indexPath as IndexPath) as! CustomDashBoardCell
                
                cell.btnDiningRequest.setTitle(preferenceName , for: UIControlState.normal)
                
                var isSelectedPreference = false
                var isSelectedPreferenceEdit = false
                
                if let selectedIndex = selectedSpecialRequest, selectedIndex >= 0 && selectedIndex <= (tablePreferences?.count ?? -1 )
                {
                    isSelectedPreference = tablePreferences?[indexPath.row] == tablePreferences?[selectedIndex]
                }
                
                if let selectedIndex = selectedSpecialRequestEdit, selectedIndex >= 0 && selectedIndex <= (tablePreferences?.count ?? -1 )
                {
                    isSelectedPreferenceEdit = tablePreferences?[indexPath.row] == tablePreferences?[selectedIndex]
                }
                
                if isSelectedPreference || isSelectedPreferenceEdit
                {
                    cell.btnDiningRequest.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                }
                else
                {
                    cell.btnDiningRequest.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                }
                
                self.heightSpecialView.constant = self.diningCollectionView.contentSize.height;
                cell.delegate = self
                heightOfColectionView()
                return cell
            }
            else
            {
                //Modified by kiran V2.5 -- GATHER0000606 -- commented old logic i.e., logic before time setup is added
                //GATHER0000606 -- Start
                //This is old logic beofore change on 8th October 2020 V2.3
                /*
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCell", for: indexPath as IndexPath) as! CustomDashBoardCell

                    cell.btnDiningRequest.setTitle(self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].tablePreferences?[indexPath.row].preferenceName, for: UIControlState.normal)
                    if indexPath.row == selectedSpecialRequest || indexPath.row == selectedSpecialRequestEdit{
                        cell.btnDiningRequest.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    }else{
                        cell.btnDiningRequest.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                    }


                self.heightSpecialView.constant = self.diningCollectionView.contentSize.height;
                cell.delegate = self
                heightOfColectionView()
                return cell
                */
                return UICollectionViewCell.init()
                //GATHER0000606 -- End
            }
            
        default:
            return UICollectionViewCell.init()
        }

    }
    
    //Added on 8th October 2020 V2.3
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == self.preferredTimePickerCollectionView || collectionView == self.earlierThanPickerCollectionView || collectionView == self.laterThanPickerCollectionView
        {
           switch collectionView
           {
           case self.preferredTimePickerCollectionView:
            
            self.preferredTimeIndex = indexPath.row
            self.updateDetailsForTime(time: self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup?[indexPath.row], removeMembers: true)
            self.preferredTimePickerCollectionView.isHidden = true
            
            //MARK:- Uncomment if there is an issue with table preference saving
            //self.selectedPreferenceID = ""
            
           case self.earlierThanPickerCollectionView:
            
            self.txtNotEarlierThan.text = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup?[self.preferredTimeIndex!].earliestTime?[indexPath.row].time
            self.earlierThanPickerCollectionView.isHidden = true
           case self.laterThanPickerCollectionView:
            self.txtNotLaterThan.text = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup?[self.preferredTimeIndex!].latestTime?[indexPath.row].time
            self.laterThanPickerCollectionView.isHidden = true
           default :
            break
            
           }
            self.timeView.layoutIfNeeded()
            collectionView.reloadData()
        }
        
    }
    
    func heightOfColectionView() {
        
        heightSpecialView.constant = diningCollectionView.collectionViewLayout.collectionViewContentSize.height
        
        
        
        self.view.setNeedsLayout()
    }
    
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == addNewPopoverTableView
        {
            
            //modified on 8th October 2020
            //Modified by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
            //GATHER0000606 -- Start
            if let isAllowGuest = self.diningSettings?.isAllowGuest
            {
                if isAllowGuest == 1
                {
                    return self.isMultiSelectClicked ? self.appDelegate.addRequestOpt_Dining_MultiSelect.count : self.appDelegate.addRequestOpt_Dining.count
                    //return self.isMultiSelectClicked ? self.appDelegate.arrRegisterMultiMemberType.count : self.appDelegate.MB_Dining_RegisterMemberType.count
                }
                else
                {
                    return self.isMultiSelectClicked ? self.appDelegate.addRequestOpt_Dining_MultiSelect.count : self.appDelegate.MB_Dining_RegisterMemberType_MemberOnly.count
                    //return self.isMultiSelectClicked ? self.appDelegate.arrRegisterMultiMemberType.count : self.appDelegate.MB_Dining_RegisterMemberType_MemberOnly.count
                }
            }
            else
            {
                return self.isMultiSelectClicked ? self.appDelegate.addRequestOpt_Dining_MultiSelect.count : self.appDelegate.addRequestOpt_Dining.count
                //return self.isMultiSelectClicked ? self.appDelegate.arrRegisterMultiMemberType.count : self.appDelegate.arrEventRegType.count
            }
            
            //GATHER0000606 -- End

        }
        else if tableView == restaurantTableView{
            return self.diningSettings?.restaurantDetails?.count ?? 0

        }
        else if tableView == modifyTableview{
            return arrTotalList.count
        }
        else if tableView == self.instructionsTableview
        {
            return self.arrInstructions.count
        }
        else{
            return arrTotalList.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == addNewPopoverTableView {
           
            let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 142, height: 34))
            cell.selectionStyle = .none
            
            //Added on 9th October 2020 V2.3
            
            var labelName : String?
            //Modified by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
            //GATHER0000606 -- Start
            if let isAllowedGuest = self.diningSettings?.isAllowGuest
            {
                if isAllowedGuest == 1
                {
                    labelName = self.isMultiSelectClicked ? self.appDelegate.addRequestOpt_Dining_MultiSelect[indexPath.row].name : self.appDelegate.addRequestOpt_Dining[indexPath.row].name
                    //labelName = self.isMultiSelectClicked ? self.appDelegate.arrRegisterMultiMemberType[indexPath.row].name : self.appDelegate.MB_Dining_RegisterMemberType[indexPath.row].name
                }
                else
                {
                    labelName = self.isMultiSelectClicked ? self.appDelegate.addRequestOpt_Dining_MultiSelect[indexPath.row].name : self.appDelegate.MB_Dining_RegisterMemberType_MemberOnly[indexPath.row].name
                    //labelName = self.isMultiSelectClicked ? self.appDelegate.arrRegisterMultiMemberType[indexPath.row].name : self.appDelegate.MB_Dining_RegisterMemberType_MemberOnly[indexPath.row].name
                }
            }
            else
            {
                labelName = self.isMultiSelectClicked ? self.appDelegate.addRequestOpt_Dining_MultiSelect[indexPath.row].name : self.appDelegate.addRequestOpt_Dining[indexPath.row].name
                //Old logic
                //labelName = self.isMultiSelectClicked ? self.appDelegate.arrRegisterMultiMemberType[indexPath.row].name : self.appDelegate.arrEventRegType[indexPath.row].name
            }
            //GATHER0000606 -- End
            cell.textLabel?.text = labelName
            
            cell.textLabel?.font =  SFont.SourceSansPro_Semibold18
            cell.textLabel?.textColor = hexStringToUIColor(hex: "64575A")
            tableView.separatorStyle = .none
            
            //Modified by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
            //GATHER0000606 -- Start
            if indexPath.row < (self.isMultiSelectClicked ? self.appDelegate.addRequestOpt_Dining_MultiSelect.count : self.appDelegate.addRequestOpt_Dining.count) - 1
            {
//            if indexPath.row < (self.isMultiSelectClicked ? self.appDelegate.arrRegisterMultiMemberType.count : self.appDelegate.arrEventRegType.count) - 1
//            {
            //GATHER0000606 -- End
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
        else if (tableView == restaurantTableView){
            let cell:GlanceCustomTableViewCell = self.restaurantTableView.dequeueReusableCell(withIdentifier: "glanceIdentifier") as! GlanceCustomTableViewCell

            cell.lblLocation.text = self.diningSettings?.restaurantDetails?[indexPath.row].restaurantName
            self.restaurantTableView.separatorStyle = UITableViewCellSeparatorStyle.none

            cell.lblComments.text = self.diningSettings?.restaurantDetails?[indexPath.row].time
            
            let placeHolderImage = UIImage(named: "Icon-App-40x40")
            cell.imgGlanceImage.image = placeHolderImage

            //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
            //ENGAGE0011419 -- Start
            let imageURLString = self.diningSettings?.restaurantDetails?[indexPath.row].restauranImage ?? ""
            
            if imageURLString.isValidURL()
            {
                let url = URL.init(string:imageURLString)
                cell.imgGlanceImage.sd_setImage(with: url , placeholderImage: placeHolderImage)
            }
            /*
            if(imageURLString.count>0){
                let validUrl = self.verifyUrl(urlString: imageURLString)
                if(validUrl == true){

                    let url = URL.init(string:imageURLString)
                    //  cell.imgGlanceImage.contentMode = .scaleAspectFit

                    cell.imgGlanceImage.sd_setImage(with: url , placeholderImage: placeHolderImage)

                }
            }
            */
            //ENGAGE0011419 -- End
            if selectedCellIndex == indexPath.row  || selectedCellModifyIndex == indexPath.row{
                if selectedCellModifyIndex == -1  && self.isFrom == "View"{
                    cell.diningCheckBox.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)

                }else{
                    cell.diningCheckBox.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    preferedSpaceDetailID = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].id
            }
                }else {
                    cell.diningCheckBox.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                }
            cell.delegate = self
            self.view.setNeedsLayout()
            return cell
        }
        else if (tableView == modifyTableview){
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyCell", for: indexPath) as? ModifyRegCustomCell {
                cell.delegate = self as? ModifyRegistration
                cell.lblname.textColor  = hexStringToUIColor(hex: "40B2E6")
                
                if isFrom == "View"{
                    cell.btnClose.isHidden = true
                }
                if arrTotalList[indexPath.row] is GroupDetail {
                    let playObj = arrTotalList[indexPath.row] as! GroupDetail
                    

                    if playObj.name == "" {
                        cell.lblname.text = playObj.guestName
                        //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                        //ENGAGE0011843 -- Start
                        cell.lblID.text = CustomFunctions.shared.guestTypeDisplayName(id: playObj.guestType)
                        //cell.lblID.text = playObj.guestType
                        //ENGAGE0011843 -- End

                        
                    }else{
                        cell.lblname.text = playObj.name
                        cell.lblID.text = playObj.memberID
                        
                    }
                    
                    
                }else if arrTotalList[indexPath.row] is DiningMemberInfo {
                    let memberObj = arrTotalList[indexPath.row] as! DiningMemberInfo
                    cell.lblname.text = memberObj.name
                    cell.lblID.text = memberObj.memberId
                }
                else if arrTotalList[indexPath.row] is MemberInfo {
                    let memberObj = arrTotalList[indexPath.row] as! MemberInfo
                    cell.lblname.text = String(format: "%@", memberObj.memberName ?? "")
                    cell.lblID.text = memberObj.memberID
                }
                else if arrTotalList[indexPath.row] is GuestInfo {
                    let guestObj = arrTotalList[indexPath.row] as! GuestInfo
                    cell.lblname.text = guestObj.guestName
                    //Added by kiran V2.8 -- ENGAGE0011784 -- 
                    //ENGAGE0011784 -- Start
                    let memberDetails = CustomFunctions.shared.memberType(details: guestObj, For: .dining)
                    
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
                    if arrTotalList[indexPath.row] is GroupDetail {
                        let playObj = arrTotalList[indexPath.row] as! GroupDetail
                        
                        if playObj.name == "" {
                            self.lblModifyCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,playObj.guestName!)
                            
                            
                        }else{
                            self.lblModifyCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,playObj.name! )
                        }
                        
                        
                    }else if arrTotalList[indexPath.row] is MemberInfo {
                        let memberObj = arrTotalList[indexPath.row] as! MemberInfo
                        self.lblModifyCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.memberName ?? "")
                    }else if arrTotalList[indexPath.row] is DiningMemberInfo {
                        let memberObj = arrTotalList[indexPath.row] as! DiningMemberInfo
                        self.lblModifyCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.name!)
                    }else if arrTotalList[indexPath.row] is GuestInfo {
                        let guestObj = arrTotalList[indexPath.row] as! GuestInfo
                        self.lblModifyCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.guestName!)
                    } else {
                        self.lblModifyCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
                    }
                }

                //Added by kiran V2.5 -- GATHER0000606 -- Hiding clear button if options array is empty
                //GATHER0000606 -- Start
                let hideMemberOptions = self.shouldHideMemberAddOption()
                cell.btnClose.isHidden = hideMemberOptions
                //GATHER0000606 -- End
                
                self.view.setNeedsLayout()
                return cell
            }
            return UITableViewCell()
            
            
        }
        else if tableView == self.instructionsTableview
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
            return UITableViewCell()
        }
        else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "RegCell", for: indexPath) as? CustomNewRegCell {
                cell.delegateDining = self
                cell.delegate = self
                
                if self.partyTableview.isHidden == true {
                }else{


                if arrTotalList[indexPath.row] is CaptaineInfo {
                        let memberObj = arrTotalList[indexPath.row] as! CaptaineInfo
                        cell.txtSearchField.text = String(format: "%@", memberObj.captainName!)
                }else if arrTotalList[indexPath.row] is MemberInfo {
                    let memberObj = arrTotalList[indexPath.row] as! MemberInfo
                    cell.txtSearchField.text = String(format: "%@", memberObj.memberName ?? "")
                } else if arrTotalList[indexPath.row] is GuestInfo {
                    let guestObj = arrTotalList[indexPath.row] as! GuestInfo
                    cell.txtSearchField.text = guestObj.guestName
                }else if arrTotalList[indexPath.row] is DiningMemberInfo {
                    let memberObj = arrTotalList[indexPath.row] as! DiningMemberInfo
                    cell.txtSearchField.text = memberObj.name
                }else {
                    cell.txtSearchField.text = ""
                }
                
                cell.viewSearchField.layer.masksToBounds = true
                cell.viewSearchField.layer.cornerRadius = 6
                cell.viewSearchField.layer.borderWidth = 0.25
                cell.viewSearchField.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
                
                cell.txtSearchField.placeholder = String(format: "%@ %d", "Reservation", indexPath.row + 1)

                }
                
                //Added by kiran V2.5 -- GATHER0000606 -- Hiding add button and clear button if options array is empty
                //GATHER0000606 -- Start
                let hideMemberOptions = self.shouldHideMemberAddOption()
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
        if tableView == addNewPopoverTableView {
            let cell = self.addNewPopoverTableView?.cellForRow(at: indexPath)
            
            //Modified on 9th October 2020 V2.3
            if let isAllowedGuest = self.diningSettings?.isAllowGuest,!self.isMultiSelectClicked
            {
                var selectedOption = ""
                //Modified by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
                //GATHER0000606 -- Start
                if isAllowedGuest == 1
                {
                    selectedOption = self.appDelegate.addRequestOpt_Dining[indexPath.row].Id ?? ""
                    //selectedOption = self.appDelegate.MB_Dining_RegisterMemberType[indexPath.row].Id ?? ""
                }
                //GATHER0000606 -- End
                else
                {
                    selectedOption = self.appDelegate.MB_Dining_RegisterMemberType_MemberOnly[indexPath.row].Id ?? ""
                }
                
                //Modified by kiran V2.5 -- GATHER0000606 -- replacing comparision with case insensetive compare with the value(id)
                //GATHER0000606 -- Start
                if selectedOption.caseInsensitiveCompare(AddRequestIDS.member.rawValue) == .orderedSame//selectedOption == "Member"
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
                        memberDirectory.categoryForBuddy = "Dining"
                        memberDirectory.isFor = "OnlyMembers"
                        memberDirectory.isOnlyFor = "DiningRequest"
                        memberDirectory.showSegmentController = true
                        memberDirectory.delegate = self
                        memberDirectory.requestID = requestID
                        memberDirectory.selectedDate = self.reservationRequestDate
                        memberDirectory.selectedTime = self.txtReservationtime.text ?? ""
                        //Added on 9th OCtober 2020 V2.3
                        memberDirectory.preferedSpaceDetailId = self.preferedSpaceDetailID
                        if self.isMultiSelectClicked
                        {
                            memberDirectory.shouldEnableMultiSelect = true
                            memberDirectory.arrMultiSelectedMembers.append(self.arrTotalList)
                        }
                        else
                        {
                             memberDirectory.membersData = self.arrTotalList
                        }
                        
                        navigationController?.pushViewController(memberDirectory, animated: true)
                    }
                }
                //Modified by kiran V2.5 -- GATHER0000606 -- replacing comparision with case insensetive compare with the value(id)
                //GATHER0000606 -- Start
                else if selectedOption.caseInsensitiveCompare(AddRequestIDS.guest.rawValue) == .orderedSame//selectedOption == "Guest"
                //GATHER0000606 -- End
                {
                    
                    if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddGuestRegVC") as? AddGuestRegVC
                    {
                        regGuest.memberDelegate = self
                        //Added by kiran V2.8 -- ENGAGE0011784 -- Hiding the existing guest feature and showing guest dob and gender fields
                        //ENGAGE0011784 -- Start
                        //Commented as this is replaced with usedForModule.
                        //regGuest.isOnlyFor = "Dining"
                        
                        regGuest.screenType = .add
                        regGuest.usedForModule = .dining
                        regGuest.showExistingGuestsOption = true
                        regGuest.isDOBHidden = false
                        regGuest.isGenderHidden = false
                        regGuest.enableGuestNameSuggestions = true
                        regGuest.hideAddtoBuddy = false
                        regGuest.hideExistingGuestAddToBuddy = false
                        regGuest.requestTime = self.txtReservationtime.text ?? ""
                        regGuest.requestDates = [self.reservationRequestDate ?? ""]
                        regGuest.preferedSpaceDetailId = self.preferedSpaceDetailID ?? ""
                        regGuest.requestID = self.requestID ?? ""
                        regGuest.arrAddedMembers = [self.arrTotalList]
                        //ENGAGE0011784 -- End
                        selectedCellText = cell?.textLabel?.text
                        navigationController?.pushViewController(regGuest, animated: true)
                    }
                }
                //Modified by kiran V2.5 -- GATHER0000606 -- replacing comparision with case insensetive compare with the value(id)
                //GATHER0000606 -- Start
                else if selectedOption.caseInsensitiveCompare(AddRequestIDS.myBuddies.rawValue) == .orderedSame//selectedOption == "MyBuddies"
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
                        memberDirectory.isFrom = "BuddyList"
                        memberDirectory.isOnlyFor = "DiningRequest"
                        memberDirectory.isFor = "OnlyMembers"
                        //memberDirectory.membersData = self.arrTotalList
                        memberDirectory.showSegmentController = true
                        memberDirectory.requestID = requestID
                        memberDirectory.selectedDate = self.reservationRequestDate
                        memberDirectory.selectedTime = self.txtReservationtime.text ?? ""
                        memberDirectory.categoryForBuddy = "Dining"
                        memberDirectory.delegate = self
                        //Added on 9th OCtober 2020 V2.3
                        memberDirectory.preferedSpaceDetailId = self.preferedSpaceDetailID
                        //Used to show or hide guests
                        memberDirectory.registerType = (isAllowedGuest == 1) ? "" : "diningReservation"
                        
                        if self.isMultiSelectClicked
                        {
                            memberDirectory.shouldEnableMultiSelect = true
                            memberDirectory.arrMultiSelectedMembers.append(self.arrTotalList)
                        }
                        else
                        {
                             memberDirectory.membersData = self.arrTotalList
                        }
                        navigationController?.pushViewController(memberDirectory, animated: true)
                    }
                }
                
            }
            else
            {
                //Added by kiran V2.5 -- GATHER0000606 -- for replacing comparision with case insensetive compare with the value(id)
                //GATHER0000606 -- Start
                
                let selectedOption = self.isMultiSelectClicked ? (self.appDelegate.addRequestOpt_Dining_MultiSelect[indexPath.row].Id ?? "") : (self.appDelegate.addRequestOpt_Dining[indexPath.row].Id ?? "")
                
                //GATHER0000606 -- Start
                
                //Old logic
                //Modified by kiran V2.5 -- GATHER0000606 -- replacing comparision with case insensetive compare with the value(id)
                //GATHER0000606 -- Start
                if selectedOption.caseInsensitiveCompare(AddRequestIDS.member.rawValue) == .orderedSame
                //if /*indexPath.row == 0*/ cell?.textLabel?.text ?? "" == "Member"
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
                        memberDirectory.categoryForBuddy = "Dining"
                        memberDirectory.isFor = "OnlyMembers"
                        memberDirectory.isOnlyFor = "DiningRequest"
                        memberDirectory.showSegmentController = true
                        memberDirectory.delegate = self
                        memberDirectory.requestID = requestID
                        memberDirectory.selectedDate = self.reservationRequestDate
                        memberDirectory.selectedTime = self.txtReservationtime.text ?? ""
                        //Added on 9th OCtober 2020 V2.3
                        memberDirectory.preferedSpaceDetailId = self.preferedSpaceDetailID
                        if self.isMultiSelectClicked
                        {
                            memberDirectory.shouldEnableMultiSelect = true
                            memberDirectory.arrMultiSelectedMembers.append(self.arrTotalList)
                        }
                        else
                        {
                             memberDirectory.membersData = self.arrTotalList
                        }
                        
                        navigationController?.pushViewController(memberDirectory, animated: true)
                    }
                }
                //Modified by kiran V2.5 -- GATHER0000606 -- replacing comparision with case insensetive compare with the value(id)
                //GATHER0000606 -- Start
                else if selectedOption.caseInsensitiveCompare(AddRequestIDS.guest.rawValue) == .orderedSame
                //else if /*indexPath.row == 1*/ cell?.textLabel?.text ?? "" == "Guest"
                //GATHER0000606 -- End
                {
                    
                    if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddGuestRegVC") as? AddGuestRegVC {
                        regGuest.memberDelegate = self
                        //Added by kiran V2.8 -- ENGAGE0011784 -- showing the existing guest feature and showing guest dob and gender fields
                        //ENGAGE0011784 -- Start
                        //Commented as this is replaced with usedForModule.
                        //regGuest.isOnlyFor = "Dining"

                        regGuest.screenType = .add
                        regGuest.usedForModule = .dining
                        regGuest.showExistingGuestsOption = true
                        regGuest.isDOBHidden = false
                        regGuest.isGenderHidden = false
                        regGuest.enableGuestNameSuggestions = true
                        regGuest.hideAddtoBuddy = false
                        regGuest.hideExistingGuestAddToBuddy = false
                        regGuest.requestTime = self.txtReservationtime.text ?? ""
                        regGuest.requestDates = [self.reservationRequestDate ?? ""]
                        regGuest.preferedSpaceDetailId = self.preferedSpaceDetailID ?? ""
                        regGuest.requestID = self.requestID ?? ""
                        regGuest.arrAddedMembers = [self.arrTotalList]
                        //ENGAGE0011784 -- End
                        selectedCellText = cell?.textLabel?.text
                        navigationController?.pushViewController(regGuest, animated: true)
                    }
                }
                //Modified by kiran V2.5 -- GATHER0000606 -- replacing comparision with case insensetive compare with the value(id)
                //GATHER0000606 -- Start
                else if selectedOption.caseInsensitiveCompare(AddRequestIDS.myBuddies.rawValue) == .orderedSame
                //else if cell?.textLabel?.text ?? "" == "My Buddies"
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
                        memberDirectory.isOnlyFor = "DiningRequest"
                        memberDirectory.isFor = "OnlyMembers"
                        //memberDirectory.membersData = self.arrTotalList
                        memberDirectory.showSegmentController = true
                        memberDirectory.requestID = requestID
                        memberDirectory.selectedDate = self.reservationRequestDate
                        memberDirectory.selectedTime = self.txtReservationtime.text ?? ""
                        memberDirectory.categoryForBuddy = "Dining"
                        memberDirectory.delegate = self
                        //Added on 9th OCtober 2020 V2.3
                        memberDirectory.preferedSpaceDetailId = self.preferedSpaceDetailID
                        
                        if self.isMultiSelectClicked
                        {
                            memberDirectory.shouldEnableMultiSelect = true
                            memberDirectory.arrMultiSelectedMembers.append(self.arrTotalList)
                            //Added on 13th October 2020 V2.3
                            //Used to show or hide guests
                            memberDirectory.registerType = (self.diningSettings?.isAllowGuest == 1) ? "" : "diningReservation"
                        }
                        else
                        {
                             memberDirectory.membersData = self.arrTotalList
                        }
                        navigationController?.pushViewController(memberDirectory, animated: true)
                    }
                }
            }
            

            
            self.isMultiSelectClicked = false
        }
            
        else if  tableView == modifyTableview
        {
            ModifyCellIndex = indexPath.row
            ModifyGuestCellIndex = indexPath.row
            
            if arrTotalList[indexPath.row] is GroupDetail
            {
                let playObj = arrTotalList[indexPath.row] as! GroupDetail
                
                let memberType : MemberType = CustomFunctions.shared.memberType(details: playObj, For: .dining)
                
                //Added by kiran V2.8 -- ENGAGE0011784 -- Modified logic to identify guest/exisitng guest and member
                //ENGAGE0011784 -- Start
                if memberType == .guest || memberType == .existingGuest//playObj.name == ""
                {//ENGAGE0011784 -- End
                    
                    //TODO:- Discuss if this settting is valid for both guest and existing guest
                    //Added on 13th October 2020 V2.3
                    if self.diningSettings?.isAllowGuest ?? 1 == 0
                    {
                        return
                    }

                    if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddGuestRegVC") as? AddGuestRegVC
                    {
                        regGuest.arrTotalList = [arrTotalList[indexPath.row]]
                        regGuest.memberDelegate = self
                        regGuest.arrSpecialOccasion = (self.arrTeeTimeDetails[0].diningDetails?[indexPath.row].specialOccasion)!

                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        //Commented as these are replaced with screenType and usedForModule.
//                        regGuest.isOnlyFor = "Dining"
//                        regGuest.isFrom = "Modify"

                        regGuest.usedForModule = .dining
                        regGuest.requestTime = self.txtReservationtime.text ?? ""
                        regGuest.requestDates = [self.reservationRequestDate ?? ""]
                        regGuest.preferedSpaceDetailId = self.preferedSpaceDetailID ?? ""
                        regGuest.requestID = self.requestID ?? ""
                        regGuest.isDOBHidden = false
                        regGuest.isGenderHidden = false
                        
                        if isFrom == "View"
                        {
                            //Commented as this is replaced with screenType
                            //regGuest.isView = "Yes"
                            regGuest.screenType = .view
                        }
                        else
                        {
                            //Commented as this is replaced with screenType
                            //regGuest.isView = ""
                            regGuest.screenType = .modify
                        }
                        
                        //old Logic
                        /*
                        if isFrom == "View"{
                            regGuest.isView = "Yes"
                        }else{
                        regGuest.isView = ""
                        }*/
                        //ENGAGE0011784 -- End
                        
                        self.navigationController?.pushViewController(regGuest, animated: true)
                    }
                    
                }//Added by kiran V2.8 -- ENGAGE0011784 -- Modified logic to identify guest/exisitng guest and member
                //ENGAGE0011784 -- Start
                else if memberType == .member
                {//ENGAGE0011784 -- End
                 
                    if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddMemberVC") as? AddMemberVC
                    {
                        regGuest.arrTotalList = [arrTotalList[indexPath.row]]
                        if isFrom == "View"
                        {
                            regGuest.isFrom = "View"
                        }
                        else
                        {
                            regGuest.isFrom = "Modify"
                        }
                        regGuest.arrSpecialOccasion = (self.arrTeeTimeDetails[0].diningDetails?[indexPath.row].specialOccasion)!

                        regGuest.delegateAddMember = self
                        navigationController?.pushViewController(regGuest, animated: true)
                    }
                    
                }
                
                
            }
            else if arrTotalList[indexPath.row] is DiningMemberInfo
            {
                if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddMemberVC") as? AddMemberVC
                {
                    regGuest.arrTotalList = [arrTotalList[indexPath.row]]
                    if isFrom == "View"{
                        regGuest.isFrom = "View"
                    }else{
                        regGuest.isFrom = "Modify"
                    }
                    
                   // regGuest.arrSpecialOccasion = (self.arrTeeTimeDetails[0].diningDetails?[indexPath.row].specialOccasion)!

                    regGuest.delegateAddMember = self
                    navigationController?.pushViewController(regGuest, animated: true)
                }
                
            }
            else if arrTotalList[indexPath.row] is GuestInfo
            {
                if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddGuestRegVC") as? AddGuestRegVC
                {
                    regGuest.arrTotalList = [arrTotalList[indexPath.row]]
                    
                  //  regGuest.arrSpecialOccasion = (self.arrTeeTimeDetails[0].diningDetails?[indexPath.row].specialOccasion)!

                    regGuest.memberDelegate = self
                    //Added by kiran V2.8 -- ENGAGE0011784 --
                    //ENGAGE0011784 -- Start
                    //Commented as these are replaced with screenType and usedForModule
//                    regGuest.isOnlyFor = "Dining"
//                    regGuest.isFrom = "Modify"
                    
                    regGuest.usedForModule = .dining
                    
                    regGuest.requestTime = self.txtReservationtime.text ?? ""
                    regGuest.requestDates = [self.reservationRequestDate ?? ""]
                    regGuest.preferedSpaceDetailId = self.preferedSpaceDetailID ?? ""
                    regGuest.requestID = self.requestID ?? ""
                    regGuest.isDOBHidden = false
                    regGuest.isGenderHidden = false
                    
                    if isFrom == "View"
                    {
                        //commented as this is replaced with screenType
                        //regGuest.isView = "Yes"
                        regGuest.screenType = .view
                        
                    }
                    else
                    {
                        //commented as this is replaced with screenType
                        //regGuest.isView = ""
                        regGuest.screenType = .modify
                    }
                    
                    //old Logic
                    /*
                    if isFrom == "View"{
                        regGuest.isView = "Yes"
                    }else{
                        regGuest.isView = ""
                    }*/
                    //ENGAGE0011784 -- End
                    navigationController?.pushViewController(regGuest, animated: true)
                }
                
            }
            
            
        }
        else if tableView == self.instructionsTableview
        {
            
        }
        else if tableView == restaurantTableView{
            self.isDateChanged = "No"
            selectedSpecialRequestEdit = -1
            //Added by kiran V2.4 -- ENGAGE0011198
            self.selectedPreferenceID = ""
            
            selectedCellIndex = indexPath.row
            selectedCellModifyIndex = indexPath.row
            
            defaultRestaurant = true
//            if self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].specialEvent == 1 {
//                self.specialEventRequest()
//            }
            self.requestReservationApi()
            if self.reservationRequestDate == nil && self.previousRequestDate == nil {
                self.isDateSelected = true
            }else{
                self.isDateSelected = false
            }
            self.restaurantTableView .reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView == self.instructionsTableview
        {
            return nil
        }
        
        let headerView = Bundle.main.loadNibNamed("RequestHeaderView", owner: self, options: nil)?.first as! RequestHeaderView
        headerView.lblGroupNumber.isHidden = true
        headerView.viewGroupNumber.isHidden = true
        if self.partyTableview.isHidden == true {
        }else{
        if arrTotalList[section] is CaptaineInfo {
            let memberObj = arrTotalList[section] as! CaptaineInfo
            headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.captainName!)
        }else if arrTotalList[section] is MemberInfo {
            let memberObj = arrTotalList[section] as! MemberInfo
            headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.memberName!)
        } else if arrTotalList[section] is GuestInfo {
            let guestObj = arrTotalList[section] as! GuestInfo
            headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.guestName!)
        }else if arrTotalList[section] is DiningMemberInfo {
            let memberObj = arrTotalList[section] as! DiningMemberInfo
            headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.name!)
        } else {
            headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
        }
        
        }

        
        return headerView
        
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == addNewPopoverTableView || tableView == restaurantTableView || tableView == modifyTableview || tableView == self.instructionsTableview  {
            return 0
        }
        else{
            return UITableViewAutomaticDimension//70
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
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "YYYY"
        
        self.lblMonth.text = self.formatterMonth.string(from: Calendar.current.date(byAdding: .month, value: 0, to:calendar.currentPage)!)
        self.lblYear.text = formatter1.string(from: Calendar.current.date(byAdding: .month, value: 0, to:calendar.currentPage)!)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.formatter.string(from: date))")
        self.previousRequestDate = self.reservationRequestDate ?? ""
        self.isDateChanged = "Yes"
        reservationRequestDate = self.formatter.string(from: date)
        reservationRemindDate = self.newFormatter.string(from: date)
        
       if self.previousRequestDate == "" {
            self.isDateChanged = "No"
        }
        
        self.requestReservationApi()
       
    }
    
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
        print("did deselect date \(self.formatter.string(from: date))")
    }
    
    func diningDuplicateValidate()
    {
        arrTempPlayers = arrTotalList
        
        partyList.removeAll()
        if isFrom == "Modify" || isFrom == "View" {
//            self.partySize = String(format: "%d", arrTempPlayers.count)

            
        }else{
            arrTempPlayers =  arrTempPlayers.filter({$0.isEmpty == false})
//            self.partySize = self.lblPartySizeNumber.text

            
        }
        
        if (Network.reachability?.isReachable) == true{
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let specialOccassion:[String: Any] = [
                "Birthday":0,
                "Anniversary":0,
                "Other":0,
                "OtherText":""
            ]
            
            
            for i in 0 ..< arrTempPlayers.count {
                if  arrTempPlayers[i] is CaptaineInfo {
                    let playObj = arrTempPlayers[i] as! CaptaineInfo
                    
                    let memberInfo:[String: Any] = [
                        "ReservationRequestDetailId": "",
                        "LinkedMemberID": playObj.captainID ?? "",
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "HighChairCount": 0,
                        "BoosterChairCount": 0,
                        "SpecialOccasion": [specialOccassion],
                        "DietaryRestrictions": "",
                        "DisplayOrder": i + 1,
                        "AddBuddy": 0
                    ]
                    partyList.append(memberInfo)
                    
                }
                    
                else if arrTempPlayers[i] is DiningMemberInfo {
                    let playObj = arrTempPlayers[i] as! DiningMemberInfo
                    let specialOccassionInfo:[String: Any] = [
                        "Birthday": playObj.birthDay ?? 0,
                        "Anniversary": playObj.anniversary ?? 0,
                        "Other": playObj.other ?? 0,
                        "OtherText": playObj.otherText ?? ""
                    ]
                    
                    let memberInfo:[String: Any] = [
                        "ReservationRequestDetailId": "",
                        "LinkedMemberID": playObj.linkedMemberID ?? "",
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "HighChairCount": playObj.highChairCount ?? 0,
                        "BoosterChairCount": playObj.boosterChairCount ?? 0,
                        "SpecialOccasion": [specialOccassionInfo],
                        "DietaryRestrictions": playObj.dietaryRestrictions ?? 0,
                        "DisplayOrder": i + 1,
                        "AddBuddy": 0
                    ]
                    partyList.append(memberInfo)
                }
                else if arrTempPlayers[i] is GuestInfo
                {
                    let playObj = arrTempPlayers[i] as! GuestInfo
                    
                    let specialOccassionInfo:[String: Any] = [
                        "Birthday": playObj.birthDay ?? 0,
                        "Anniversary": playObj.anniversary ?? 0,
                        "Other": playObj.other ?? 0,
                        "OtherText": playObj.otherText ?? ""
                    ]
                    //For existing guest only details sent for member are required.Used same object for guest and existing guest as other details a not considered in backend
                    let memberInfo:[String: Any] = [
                        "ReservationRequestDetailId": "",
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        "LinkedMemberID": playObj.linkedMemberID ?? "",
                        //ENGAGE0011784 -- End
                        "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                        "GuestType": playObj.guestType ?? "",
                        "GuestName": playObj.guestName ?? "",
                        "GuestEmail": playObj.email ?? "",
                        "GuestContact": playObj.cellPhone ?? "",
                        "HighChairCount": playObj.highChairCount ?? 0,
                        "BoosterChairCount": playObj.boosterChairCount ?? 0,
                        "SpecialOccasion": [specialOccassionInfo],
                        "DietaryRestrictions": playObj.dietaryRestrictions ?? 0,
                        "DisplayOrder": i + 1,
                        "AddBuddy": playObj.addToMyBuddy ?? 0,
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
                else if arrTempPlayers[i] is GroupDetail
                {
                    let playObj = arrTempPlayers[i] as! GroupDetail
                    //Added by kiran V2.8 -- ENGAGE0011784 -- Added support for existing guest.
                    //ENGAGE0011784 -- Start
                    let memberType = CustomFunctions.shared.memberType(details: playObj, For: .dining)
                    
                    if memberType == .guest//playObj.id == nil
                    {
                        arrSpecialOccasion = playObj.specialOccasion!
                        let playObj2 = arrSpecialOccasion[0] as! GroupDetail
                        let specialOccassionInfo:[String: Any] = [
                            "Birthday": playObj2.birthDay ?? 0,
                            "Anniversary": playObj2.anniversary ?? 0,
                            "Other": playObj2.other ?? 0,
                            "OtherText": playObj2.otherText ?? ""
                        ]
                        
                        let memberInfo:[String: Any] = [
                            "LinkedMemberID": "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailId!,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                            "GuestType": playObj.guestType ?? "",
                            "GuestName": playObj.guestName ?? "",
                            "GuestEmail": playObj.email ?? "",
                            "GuestContact": playObj.cellPhone ?? "",
                            "HighChairCount": playObj.highchair ?? 0,
                            "BoosterChairCount": playObj.boosterCount ?? 0,
                            "SpecialOccasion": [specialOccassionInfo],
                            "DietaryRestrictions": playObj.dietary ?? "",
                            "DisplayOrder": i + 1,
                            "AddBuddy": playObj.addBuddy ?? 0,
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
                    else if memberType == .existingGuest
                    {
                        arrSpecialOccasion = playObj.specialOccasion!
                        let playObj2 = arrSpecialOccasion[0] as! GroupDetail
                        let specialOccassionInfo:[String: Any] = [
                            "Birthday": playObj2.birthDay ?? 0,
                            "Anniversary": playObj2.anniversary ?? 0,
                            "Other": playObj2.other ?? 0,
                            "OtherText": playObj2.otherText ?? ""
                        ]
                        
                        let memberInfo:[String: Any] = [
                            "LinkedMemberID": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailId!,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "HighChairCount": playObj.highchair ?? 0,
                            "BoosterChairCount": playObj.boosterCount ?? 0,
                            "SpecialOccasion": [specialOccassionInfo],
                            "DietaryRestrictions": playObj.dietary ?? "",
                            "DisplayOrder": i + 1,
                            "AddBuddy": playObj.addBuddy ?? 0
                        ]
                        
                        //TODO:- remove after approval
                        /*
                        let memberInfo:[String: Any] = [
                            "LinkedMemberID": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailId!,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                            "GuestType": playObj.guestType ?? "",
                            "GuestName": playObj.guestName ?? "",
                            "GuestEmail": playObj.email ?? "",
                            "GuestContact": playObj.cellPhone ?? "",
                            "HighChairCount": playObj.highchair ?? 0,
                            "BoosterChairCount": playObj.boosterCount ?? 0,
                            "SpecialOccasion": [specialOccassionInfo],
                            "DietaryRestrictions": playObj.dietary ?? "",
                            "DisplayOrder": i + 1,
                            "AddBuddy": playObj.addBuddy ?? 0,
                            APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                            APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                            APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                            APIKeys.kGuestGender : playObj.guestGender ?? ""
                        ]
                        */
                        partyList.append(memberInfo)

                    }
                    else if memberType == .member
                    {
                        arrSpecialOccasion = playObj.specialOccasion!
                        let playObj2 = arrSpecialOccasion[0] as! GroupDetail
                        let specialOccassionInfo:[String: Any] = [
                            "Birthday": playObj2.birthDay ?? 0,
                            "Anniversary": playObj2.anniversary ?? 0,
                            "Other": playObj2.other ?? 0,
                            "OtherText": playObj2.otherText ?? ""
                        ]
                        let memberInfo:[String: Any] = [
                            "LinkedMemberID": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailId!,
                            "GuestMemberOf": "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "HighChairCount": playObj.highchair ?? 0,
                            "BoosterChairCount": playObj.boosterCount ?? 0,
                            "SpecialOccasion": [specialOccassionInfo],
                            "DietaryRestrictions": playObj.dietary ?? "",
                            "DisplayOrder": i + 1,
                            "AddBuddy": 0
                        ]
                        partyList.append(memberInfo)
                    }
                    
                    //ENGAGE0011784 -- Start
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
          
        }
    }
    
    func memberValidattionAPI(_ success : @escaping ((Bool) -> Void)){
        paramaterDict = [
            "Content-Type":"application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            "RequestId": requestID ?? "",
            "ReservationRequestDate": reservationRequestDate ?? "",
            "ReservationRequestTime": txtReservationtime.text ?? "",
            "PartySize": self.arrTempPlayers.count,
            "Earliest": txtNotEarlierThan.text ?? "",
            "Latest": txtNotLaterThan.text ?? "",
            "Comments": txtComments.text ?? "",
            "PreferedSpaceDetailId": preferedSpaceDetailID ?? "" ,
            "TablePreference": selectedPreferenceID ?? "",
            "DiningDetails" : partyList,
            "IsReservation": "1",
            "IsEvent": "0",
            "ReservationType": "Dining",
            "RegistrationID": requestID ?? ""
        ]
        
        APIHandler.sharedInstance.getMemberValidation(paramater: paramaterDict, onSuccess: { (response) in
            
            self.appDelegate.hideIndicator()
            
            if response.details?.count == 0
            {
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                self.addNewMeber = false

                 success(false)
            }
            else
            {
                if response.responseCode == InternetMessge.kSuccess
                {
                    self.addNewMeber = true
                    success(true)
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
        switch self.accessManager.accessPermision(for: .diningReservation) {
        case .view:
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        default:
            break
        }
        
        
        
            self.diningDuplicateValidate()
                paramaterDict = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "RequestId": requestID ?? "",
                "ReservationRequestDate": reservationRequestDate ?? "",
                "ReservationRequestTime": txtReservationtime.text ?? "",
                "PartySize": self.lblPartySizeNumber.text ?? "",
                "Earliest": txtNotEarlierThan.text ?? "",
                "Latest": txtNotLaterThan.text ?? "",
                "Comments": txtComments.text ?? "",
                "PreferedSpaceDetailId": preferedSpaceDetailID ?? "" ,
                "TablePreference": selectedPreferenceID ?? "",
                "DiningDetails" : partyList
            ]

            print("memberdict \(paramaterDict)")
            APIHandler.sharedInstance.saveDiningReservationRequest(paramaterDict: paramaterDict, onSuccess: { memberLists in
                self.appDelegate.hideIndicator()
//                if memberLists.responseCode == InternetMessge.kFail {
//                    
//                   if memberLists.specialEvent == 1 {
//                        
//                    if let cancelViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController {
//                        if self.isFrom == "Modify"{
//                            
//                            cancelViewController.isFrom = "ModifySpecialEvent"
//                            if self.isOnlyFrom == "EventsModify"{
//                                cancelViewController.isOnlyFrom = "EventSPecialDiningUpdate"
//                            }
//
//                        }else{
//                            cancelViewController.isFrom = "SpecialEvent"
//
//                        }
//                        cancelViewController.message = memberLists.brokenRules?.fields?[0]
//                        cancelViewController.paramater = self.paramaterDict
//                        cancelViewController.reservationReqDate = self.reservationRequestDate
//                        cancelViewController.reservationRemindDate = self.reservationRemindDate
//                        cancelViewController.diningSettings = self.diningSettings
//                        self.navigationController?.pushViewController(cancelViewController, animated: true)
//                    }
//                    
//                   }else{
//                    
//                     let brokenMessage = (memberLists.brokenRules?.message)!  + (memberLists.brokenRules?.fields?.joined(separator: ","))!
//                     SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:brokenMessage, withDuration: Duration.kMediumDuration)
//                    
//                    
//                    
//                    }
//                }
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
                                succesView.isFrom = "DiningUpdate"
                            }
                             succesView.imgUrl = memberLists.imagePath ?? ""
                            succesView.modalTransitionStyle   = .crossDissolve;
                            succesView.modalPresentationStyle = .overCurrentContext
                            self.present(succesView, animated: true, completion: nil)
                        }
                        
                    }else{
                        if let share = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ThanksVC") as? ThanksVC {
                        share.delegate = self

                        self.appDelegate.requestFrom = "Dining"
                        let dateFormatterToSend = DateFormatter()
                        dateFormatterToSend.dateFormat = "MM/dd/yyyy"
                        
                        let isoDate = self.reservationRemindDate
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                        let date = dateFormatter.date(from:isoDate!)!
                        
                        share.remindDate = dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: -((self.diningSettings?.minDaysInAdvance)!), to: date)!)
                        share.palyDate = self.reservationRequestDate
                        share.modalTransitionStyle   = .crossDissolve;
                        share.modalPresentationStyle = .overCurrentContext
                        self.present(share, animated: true, completion: nil)
                    }

                    }
                }else{
                    self.appDelegate.hideIndicator()
                    self.appDelegate.hideIndicator()
                    
                    
                    if memberLists.details?.count == 0 {
                        //Modified on 16th October 2020 V2.3
                        SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:memberLists.brokenRules?.fields?.joined(separator: ","), withDuration: Duration.kMediumDuration)
                        //SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:memberLists.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                    }else{
                        if memberLists.responseCode == InternetMessge.kSuccess{
                            
                        }else if memberLists.details == nil{
                            //Modified on 16th October 2020 V2.3
                            SharedUtlity.sharedHelper().showToast(on:
                                self.view, withMeassge: memberLists.brokenRules?.fields?.joined(separator: ","), withDuration: Duration.kMediumDuration)
                            //SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: memberLists.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
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



        
    }
    
  
    
    @IBAction func diningPolicyClicked(_ sender: Any) {
        
        let restarantpdfDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
        restarantpdfDetailsVC.pdfUrl = self.diningSettings?.diningURl ?? ""
        restarantpdfDetailsVC.restarantName = self.appDelegate.masterLabeling.dining_policy!

        self.navigationController?.pushViewController(restarantpdfDetailsVC, animated: true)
    }
    
    
    @IBAction func increasePartySizeClicked(_ sender: Any)
    {
        //Modified on 9th October 2020 V2.3
        if self.preferredTimeIndex == nil
        {
            return
        }
        
        if let timeSetup = self.diningSettings?.restaurantDetails?[self.selectedCellIndex!].timeSetup
        {
            if isFrom == "Modify" || isFrom == "View"
            {
                btnDecrease.isEnabled = true
                
                if Int(self.lblPartySizeNumber.text!) == (timeSetup[self.preferredTimeIndex!].maxPartySize)!
                {
                    btnIncrease.isEnabled = false
                }
                else
                {
                    if Int(self.lblPartySizeNumber.text!)! >= (timeSetup[self.preferredTimeIndex!].maxPartySize)!
                    {
                        btnIncrease.isEnabled = false
                        
                    }
                    
                    self.lblPartySizeNumber.text = String(format: "%02d", Int(self.lblPartySizeNumber.text!)! + 1)
                    
                    if Int(self.lblPartySizeNumber.text!)! >= (timeSetup[self.preferredTimeIndex!].maxPartySize)!
                    {
                        btnIncrease.isEnabled = false
                        
                    }
                    
                    if arrTotalList.count == Int(self.lblPartySizeNumber.text!)!
                    {
                        self.btnAddNewPlayer.isEnabled = false
                        
                    }
                    else if arrTotalList.count < Int(self.lblPartySizeNumber.text!)!
                    {
                        self.btnAddNewPlayer.isEnabled = true
                        
                    }
                    
                }
                
                self.modifyTableview.reloadData()
            }
            else
            {
                btnDecrease.isEnabled = true
                
                if Int(self.lblPartySizeNumber.text!) == (timeSetup[self.preferredTimeIndex!].maxPartySize)!
                {
                    btnIncrease.isEnabled = false
                }
                else
                {
                    btnIncrease.isEnabled = true
                    
                    if arrTotalList.count == (timeSetup[self.preferredTimeIndex!].maxPartySize)! - 1
                    {
                        btnIncrease.isEnabled = false
                    }
                    else
                    {
                        btnIncrease.isEnabled = true
                    }
                    arrTotalList.append(RequestData())
                    self.lblPartySizeNumber.text = String(format: "%02d", arrTotalList.count)
                }
              
                self.partyTableview .reloadData()
            }

        }
        else
        {
            //Modified by kiran V2.5 -- GATHER0000606 -- commented old logic i.e., logic before time setup is added
            //GATHER0000606 -- Start
            //Old Logic before 9th October 2020 change
            /*
            if isFrom == "Modify" || isFrom == "View"{
               
                btnDecrease.isEnabled = true
               //Modified on 11th July 2020 V2.2
                if Int(self.lblPartySizeNumber.text!) == (self.diningSettings?.restaurantDetails?[selectedCellIndex!].maxPartysize)! {
                    btnIncrease.isEnabled = false
                }
                else
                {
                    if Int(self.lblPartySizeNumber.text!)! >= (self.diningSettings?.restaurantDetails?[selectedCellIndex!].maxPartysize)! {
                            btnIncrease.isEnabled = false
                        }

                            self.lblPartySizeNumber.text = String(format: "%02d", Int(self.lblPartySizeNumber.text!)! + 1)
                            if Int(self.lblPartySizeNumber.text!)! >= (self.diningSettings?.restaurantDetails?[selectedCellIndex!].maxPartysize)! {
                                btnIncrease.isEnabled = false
                            }
                    //    }

                        if arrTotalList.count == Int(self.lblPartySizeNumber.text!)! {
                            self.btnAddNewPlayer.isEnabled = false
                        }
                        else if arrTotalList.count < Int(self.lblPartySizeNumber.text!)! {
                            self.btnAddNewPlayer.isEnabled = true
                        }
                }
                

                self.modifyTableview.reloadData()
            }else{
                btnDecrease.isEnabled = true
                if Int(self.lblPartySizeNumber.text!) == (self.diningSettings?.restaurantDetails?[selectedCellIndex!].maxPartysize)! {
                    btnIncrease.isEnabled = false
                }
                else{
                    btnIncrease.isEnabled = true
                    
                    if arrTotalList.count == (self.diningSettings?.restaurantDetails?[selectedCellIndex!].maxPartysize)! - 1 {
                        btnIncrease.isEnabled = false
                    }
                    else{
                        btnIncrease.isEnabled = true
                    }
                    arrTotalList.append(RequestData())
                    self.lblPartySizeNumber.text = String(format: "%02d", arrTotalList.count)
                }
              
                self.partyTableview .reloadData()
            }
            
            */
            //GATHER0000606 -- End
        }
        
    }
   
    @IBAction func decresePartySizeClicked(_ sender: Any) {
        
        if isFrom == "Modify" || isFrom == "View"{
            btnIncrease.isEnabled = true

//            if Int(self.lblPartySizeNumber.text!)! == 01 {
//                btnDecrease.isEnabled = false
//
//            }else{
            self.lblPartySizeNumber.text = String(format: "%02d", Int(self.lblPartySizeNumber.text!)! - 1)
//            }
            if Int(self.lblPartySizeNumber.text!)! == 01 {
                btnDecrease.isEnabled = false
                
            }
            if arrTotalList.count == Int(self.lblPartySizeNumber.text!)! {
                self.btnAddNewPlayer.isEnabled = false
            }
            else if arrTotalList.count < Int(self.lblPartySizeNumber.text!)! {
                self.btnAddNewPlayer.isEnabled = true
                
            }
            modifyTableview.reloadData()
            self.view.setNeedsLayout()
            
        }else{
            btnIncrease.isEnabled = true
            
            if arrTotalList.count == 1 {
                btnDecrease.isEnabled = false
            }
            else{
                arrTotalList.removeLast()
                if arrTotalList.count == 1 {
                    btnDecrease.isEnabled = false
                }
            }
            
            self.lblPartySizeNumber.text = String(format: "%02d", arrTotalList.count)
            self.partyTableview .reloadData()
        }
       
    
    }
    @IBAction func cancelReservationClicked(_ sender: Any) {
        
        //Added on 4th July 2020 V2.2
        //added roles and privilages changes
        //since not allowed is handled before coming to this screen not need to check for it.
        switch self.accessManager.accessPermision(for: .diningReservation) {
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
                cancelViewController.isFrom = "EventDiningCancelRequest"
                cancelViewController.cancelFor = self.requestType == .reservation ? .DiningReservation : .DiningEvent
            }
            else
            {
                cancelViewController.isFrom = "DiningCancel"
                cancelViewController.cancelFor = .DiningReservation
            }
            cancelViewController.eventID = requestID
            cancelViewController.numberOfTickets = self.numberOfTickets == 0 ? "" : "\(self.numberOfTickets)"
            self.navigationController?.pushViewController(cancelViewController, animated: true)
        }
        
        
    }
    
    //MARK:- Add new popover modify bttn acton
    @IBAction func btnAddPlayer(_ sender: Any) {
        
        if self.addNewMeber == true{
            self.addNewPopupModifyCase()
        }else{
            self.diningDuplicateValidate()
            self.memberValidattionAPI({ [unowned self] (status) in
                if status == true{
                    self.addNewPopupModifyCase()
                }
            })
        }
        
    }
    
    //MARK:- Add new popover modify case
    func addNewPopupModifyCase(){
        self.ModifyCellIndex = -1
        ModifyGuestCellIndex = -1
        
        
        
        let addNewView : UIView!
        
        //Modified by kiran V2.5 -- GATHER0000606 -- modified to change height based on no of options
        //GATHER0000606 -- Start
        let optionsHeight = self.numberOfPopupOptions() * 50
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
        let point = btnAddNewPlayer.convert(btnAddNewPlayer.center , to: appDelegate.window)
        addNewPopover?.sideEdge = 4.0
        
        let pointt = CGPoint(x: self.view.bounds.width - 22, y: point.y - 74)
        
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        if point.y > height - 170{
            addNewPopover?.popoverType = .up
            addNewPopover?.show(addNewView, point: pointt)
            
        }else{
            addNewPopover?.show(addNewView, point: pointt)
            
        }
    }
}

//MARK:- View only funcitionality related functions
extension DiningRequestVC
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
        self.restaurantTableView.isUserInteractionEnabled = !bool
        self.btnModifyDate.isUserInteractionEnabled = !bool
        self.btnModifyTime.isUserInteractionEnabled = !bool
        self.completeCalendarView.isUserInteractionEnabled = !bool
        self.timeView.isUserInteractionEnabled = !bool
        self.viewParty.isUserInteractionEnabled = !bool
        self.partyTableview.isUserInteractionEnabled = !bool
        self.viewModify.isUserInteractionEnabled = !bool
        self.viewSpecialRequest.isUserInteractionEnabled = !bool
        self.viewComments.isUserInteractionEnabled = !bool
        self.btnMultiSelect.isUserInteractionEnabled = !bool
        
        self.btnCancelreser.isHidden = bool
        self.heightCancelResr.constant = bool ? -20 : 37
    }
    
}

//Added on 8th October 2020 V2.3
//MARK:- Custon Methods
extension DiningRequestVC
{
    ///Sets the party size and
    private func updateDetailsForTime(time : DiningTimeSettings? , removeMembers : Bool)
    {
        
        self.txtReservationtime.text = time?.time
        self.txtNotEarlierThan.text = time?.earliestTime?.first?.time
        self.txtNotLaterThan.text = time?.latestTime?.last?.time
        
        self.partyCount = time?.maxPartySize
        
        
        if removeMembers
        {
            if self.partyCount! < self.arrTotalList.count{
                let  arrTemp =  self.arrTotalList
                
                self.arrTotalList.removeAll()
                let content =  arrTemp[0..<Int(self.partyCount!)]
                self.arrTotalList.append(contentsOf: content)
                self.lblPartySizeNumber.text = String(format: "%02d", self.arrTotalList.count)
                self.modifyTableview.reloadData()
                self.btnAddNewPlayer.isEnabled = false
                
                
            }else if self.partyCount! == self.arrTotalList.count{
                self.lblPartySizeNumber.text = String(format: "%02d", self.arrTotalList.count)
                self.modifyTableview.reloadData()
                self.btnAddNewPlayer.isEnabled = false
            }else{
                let  arrTemp =  self.arrTotalList
                
                self.arrTotalList.removeAll()
                let content =  arrTemp[0..<Int(arrTemp.count)]
                self.arrTotalList.append(contentsOf: content)
                if self.arrTotalList.count < Int(self.lblPartySizeNumber.text!)!
                {
                   if self.partyCount! <= Int(self.lblPartySizeNumber.text!)!{
                    self.lblPartySizeNumber.text = String(format: "%02d", self.partyCount!)
                    }
                    self.btnAddNewPlayer.isEnabled = true
                }else{
                self.lblPartySizeNumber.text = String(format: "%02d", self.arrTotalList.count)
                self.btnAddNewPlayer.isEnabled = false
                }
                self.modifyTableview.reloadData()
                
            }
        }
        
        self.btnIncrease.isEnabled = self.arrTotalList.count < (self.partyCount ?? -1)
        
        self.partyTableview.reloadData()
        self.diningCollectionView.reloadData()
        
        self.preferredTimePickerCollectionView.reloadData()
        self.earlierThanPickerCollectionView.reloadData()
        self.laterThanPickerCollectionView.reloadData()
        
        if time?.specialEvent == 1
        {
            if time?.isRegistered == 1
            {
                
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:time?.validationMessage, withDuration: Duration.kMediumDuration)
                self.reservationRequestDate = nil
                
                let delay = 3 // seconds
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
                    for date in self.myCalendar!.selectedDates
                    {
                        self.myCalendar.deselect(date)
                        
                    }
                    
                }
                
                //Added on 9th October 2020 V2.3
                self.resetTimeSelection()
            }
            else
            {
                self.specialEventRequest()
            }
            
        }
        
        //Added on 14th October 2020 V2.3
        self.memberValidattionAPI { (bool) in
            
        }

    }
    
    
    private func resetTimeSelection()
    {
        self.preferredTimeIndex = nil
        self.txtReservationtime.text = ""
        self.txtNotEarlierThan.text = ""
        self.txtNotLaterThan.text = ""
        self.preferredTimePickerCollectionView.reloadData()
        self.earlierThanPickerCollectionView.reloadData()
        self.laterThanPickerCollectionView.reloadData()
    }
    
    //Added by kiran V2.5 -- GATHER0000606 -- Logic which indicates if add member button should be displayed or not
    //GATHER0000606 -- Start
    ///Indicates if add member button should be shown. only applicable for single member add not multi select
    private func shouldHideMemberAddOption() -> Bool
    {
        var optionsArray = [BWOption]()
        if let isAllowGuest = self.diningSettings?.isAllowGuest
        {
            if isAllowGuest == 1
            {
                optionsArray = self.appDelegate.addRequestOpt_Dining
            }
            else
            {
                optionsArray = self.appDelegate.MB_Dining_RegisterMemberType_MemberOnly
            }
        }
        else
        {
            optionsArray = self.appDelegate.addRequestOpt_Dining
        }
        
        return !(optionsArray.count > 0)
    }
    //GATHER0000606 -- End
    
    //Added by kiran V2.5 -- GATHER0000606 -- returns the numbr of options available for when add button is clicked
    //GATHER0000606 -- Start
    ///Returns the number of options when add new popup clicked
    private func numberOfPopupOptions() -> Int
    {
        var optionsArray = [BWOption]()
        if let isAllowGuest = self.diningSettings?.isAllowGuest
        {
            if isAllowGuest == 1
            {
                optionsArray = self.appDelegate.addRequestOpt_Dining
            }
            else
            {
                optionsArray = self.appDelegate.MB_Dining_RegisterMemberType_MemberOnly
            }
        }
        else
        {
            optionsArray = self.appDelegate.addRequestOpt_Dining
        }
        
        return optionsArray.count
    }
    //GATHER0000606 -- End
}
