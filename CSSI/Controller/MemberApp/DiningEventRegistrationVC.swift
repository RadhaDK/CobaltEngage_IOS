//
//  DiningEventRegistrationVC.swift
//  CSSI
//
//  Created by apple on 8/24/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit
import Popover

//Added by kiran V1.3 -- PROD0000069 --
//PROD0000069 -- Start
protocol DiningEventRegistrationVCDelegate : NSObject {
    func diningEventSuccessPopupClosed()
}
//PROD0000069 -- End

class DiningEventRegistrationVC: UIViewController,UITableViewDataSource,UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, RegistrationCell, ModifyRegistration, MemberViewControllerDelegate, guestViewControllerDelegate, closeUpdateSuccesPopup,AddMemberDelegate, closeModalView {
    func AddGuestChildren(selecteArray: [RequestData]) {
        
    }
    
    func memberViewControllerResponse(selecteArray: [MemberInfo]) {
        
    }

    func buddiesViewControllerResponse(selectedBuddy: [MemberInfo]) {
        
    }

    func guestViewControllerResponse(guestName: String) {
        
    }
    func addMemberDelegate() {
        self.dismiss(animated: true, completion: nil)
        //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
        //PROD0000069 -- Start
        self.delegate?.diningEventSuccessPopupClosed()
        //PROD0000069 -- End
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for popToViewController in viewControllers {
            if self.appDelegate.requestFrom == "DiningEventReservation"{
               // self.appDelegate.requestFrom = ""
                if popToViewController is CalendarOfEventsViewController {
                    //Modified by kiran -- ENGAGE0011177 -- V2.5 -- commented as its causing black bar issue on nav bar.
                    //self.navigationController?.navigationBar.isHidden = true
                    self.navigationController!.popToViewController(popToViewController, animated: true)
                    
                }
                //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
                //PROD0000069 -- Start
                else
                {
                    self.navigationController!.popViewController(animated: true)
                    break
                }
                //PROD0000069 -- End
            }
            else if self.appDelegate.requestFrom == "DiningReservationFromRes"{
                // self.appDelegate.requestFrom = ""
                if popToViewController is GolfCalendarVC {
                    //Modified by kiran -- ENGAGE0011177 -- V2.5 -- commented as its causing black bar issue on nav bar.
                    //self.navigationController?.navigationBar.isHidden = false
                    self.navigationController!.popToViewController(popToViewController, animated: true)
                    
                }
            }
            else{
            if popToViewController is DiningReservationViewController {
                //Modified by kiran -- ENGAGE0011177 -- V2.5 -- commented as its causing black bar issue on nav bar.
                //self.navigationController?.navigationBar.isHidden = false
                self.navigationController!.popToViewController(popToViewController, animated: true)
                
            }
            }
        }
        
    }

    func closeUpdateSuccessView()
    {
        self.dismiss(animated: true, completion: nil)
        
        //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
        //PROD0000069 -- Start
        self.delegate?.diningEventSuccessPopupClosed()
        //PROD0000069 -- End
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        
        for popToViewController in viewControllers
        {
            if self.appDelegate.closeFrom == "Calendar"
            {
                if popToViewController is GolfCalendarVC
                {
                    //Modified by kiran -- ENGAGE0011177 -- V2.5 -- commented as its causing black bar issue on nav bar.
                    //self.navigationController?.navigationBar.isHidden = false
                    self.navigationController!.popToViewController(popToViewController, animated: true)
                    
                }
                
            }
            else if self.appDelegate.closeFrom == "SpecialRequest"
            {
                if popToViewController is GolfCalendarVC
                {
                    //Modified by kiran -- ENGAGE0011177 -- V2.5 -- commented as its causing black bar issue on nav bar.
                    //self.navigationController?.navigationBar.isHidden = false
                    self.navigationController!.popToViewController(popToViewController, animated: true)
                    
                }//Added by kiran -- ENGAGE0011298 -- V2.5 -- This fixed a issue where when coming from calendar of events modify and special request is selected and saved then not navigating to calendar of events of screen.
                //ENGAGE0011298 -- Start
                else if popToViewController is CalendarOfEventsViewController
                {
                    self.navigationController!.popToViewController(popToViewController, animated: true)
                }
                //ENGAGE0011298 -- End
                //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
                //PROD0000069 -- Start
                else
                {
                    self.navigationController!.popViewController(animated: true)
                    break
                }
                //PROD0000069 -- End
            }
            else
            {
                if popToViewController is CalendarOfEventsViewController
                {
                    //Modified by kiran -- ENGAGE0011177 -- V2.5 -- commented as its causing black bar issue on nav bar.
                    //self.navigationController?.navigationBar.isHidden = true
                    self.navigationController!.popToViewController(popToViewController, animated: true)
                    
                }
                //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
                //PROD0000069 -- Start
                else
                {
                    self.navigationController!.popViewController(animated: true)
                    break
                }
                //PROD0000069 -- End
            }
            
        }
        
    }
    
    func ModifyThreeDotsClicked(cell: ModifyRegCustomCell) {
        
    }
    
    func threeDotsClickedToMoveGroup(cell: CustomNewRegCell) {
        
    }
    
    @IBOutlet weak var viewPartySize: UIView!
   // @IBOutlet weak var eventTimeHeight: NSLayoutConstraint!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var lblTimeLabel: UILabel!
    
    @IBOutlet weak var txtTime: UITextField!
    
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var timeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var cancelReservationHeight: NSLayoutConstraint!
    @IBOutlet weak var uiScrollview: UIScrollView!
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var middleViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
   //@IBOutlet weak var heightDetails: NSLayoutConstraint!
    @IBOutlet weak var viewModifyheight: NSLayoutConstraint!
    @IBOutlet weak var modifyTableviewHeight: NSLayoutConstraint!
    @IBOutlet weak var modifyTableView: UITableView!
    @IBOutlet weak var viewModify: UIView!
    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var registrationTableview: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblEventVenue: UILabel!
    @IBOutlet weak var lblEventMonthDay: UILabel!
    @IBOutlet weak var lblEventTime: UILabel!
    @IBOutlet weak var lblAdditionalEventDetails: UILabel!
    @IBOutlet weak var viewComments: UIView!
    //Modified on 28th September 2020 V2.3
    //Replaces Remainder label with textview to make links clickable
    @IBOutlet weak var txtViewRemainder: UITextView!
    @IBOutlet weak var lblTickets: UILabel!
    @IBOutlet weak var lblNumberOfTickets: UILabel!
    @IBOutlet weak var btnIncreaseTicket: UIButton!
    @IBOutlet weak var btnDecreaseTickets: UIButton!
    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var txtComments: UITextView!
    @IBOutlet weak var btnRequest: UIButton!
    
    @IBOutlet weak var lblConfirmationNumber: UILabel!
    @IBOutlet weak var lblBottomText: UILabel!
    @IBOutlet weak var txtModifyInput: UITextField!
    @IBOutlet weak var btnModifyAdd: UIButton!
    @IBOutlet weak var btnCancelReservation: UIButton!
    @IBOutlet weak var baseViewForModifyNew: UIView!
    
    @IBOutlet weak var lblEarlierThan: UILabel!
    @IBOutlet weak var lblLaterThan: UILabel!
    @IBOutlet weak var viewEarlierThan: UIView!
    @IBOutlet weak var viewLaterThan: UIView!
    @IBOutlet weak var txtEarlierThan: UITextField!
    @IBOutlet weak var txtLaterThan: UITextField!
    @IBOutlet weak var instructionsTableView: SelfSizingTableView!
    
    @IBOutlet weak var instructionsTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnMultiSelect: UIButton!
    @IBOutlet weak var viewMultiSelect: UIView!
    
    //Added by kiran V1.4 -- PROD0000069 --
    //PROD0000069 -- Start
    @IBOutlet weak var stackViewStatus: UIStackView!
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var lblStatusHeader: UILabel!
    @IBOutlet weak var viewStatusColor: UIView!
    @IBOutlet weak var lblStatus: UILabel!
    //PROD0000069 -- End
    
    var addNewPopoverTableView: UITableView? = nil
    var addNewPopover: Popover? = nil
    var arrNewRegList = [String]()
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var eventID : String?
    var eventCategory : String?
    var eventType : Int?
    var requestID: String?
    var selectedIndex : Int?
    var arrRegisterDetails = [RegisteredDetail]()
   // var arrTotalList = [MemberInfo]()
    var arrMembers = [MemberInfo]()
    var arrBuddyList = [MemberInfo]()
    var duplicate = MemberInfo()
    
    var arrEventPlayers = [RequestData]()
    var selectedPlayerIndex : Int?
    var arrTemp = [RequestData]()
    
    var arrTotalList = [RequestData]()
    var arrTempPlayers = [RequestData]()

    var arrSpecialOccasion = [RequestData]()
    var partyList = [Dictionary<String, Any>]()
    var reservationReqDate : String?
    var reservationRemindDate: String?
    var diningSettings : DinningSettings?

    var dinigRequestTime: String?
    var dinigRequestDate: String?
    var arrGuest = [String]()
    var guestNameToDisplay : String?
    var eventDetails = [EventDetail]()
    var selectedCellText : String?
    var memberArrayList = [Dictionary<String, Any>]()
    var buddyArrayList = [Dictionary<String, Any>]()
    var guestArrayList = [Dictionary<String, Any>]()
    var guestList = [GuestListName]()
    var newGuestList = [MemberInfo]()
    var isRemoveClicked : Bool!
    var isMinusClicked : Bool!
    var registrationFor : String?
    var isFrom: String?
    var isOnlyFrom: String?
    var segmentIndex: Int?
    var eventRegistrationDetailID : String?
    var ModifyCellIndex: Int?
    var ModifyGuestCellIndex: Int?
    var modifyCount : Int = 0
    var paramaterDict:[String: Any] = [:]
    var preferredDetailID: String?
    var arrRegReqID = [String]()
    var partySize : String?
    //var datePicker = UIDatePicker()
    fileprivate var dob:Date? = nil
    
    fileprivate var timeInterverls: UIPickerView? = nil;
    var selected: String {
        return UserDefaults.standard.string(forKey: "selected") ?? ""
    }
    
    private var selectedTextField : UITextField?
    private var earliarThanTime : String?
    private var laterThanTime : String?
    
    /**Event/Venue open time*/
    private var openTime : String?
    /**Event /Venue close time*/
    private var closeTime : String?
    /**Time interval for date picker.Default is 5 mins*/
    private var timeInterval : Int = 0
    /**Time Picker*/
    private let timePicker : UIDatePicker = {
        let picker = UIDatePicker.init()
        picker.datePickerMode = .time
        //Added on 14th October 2020 V2.3
        //Added for iOS 14 date picker change
        if #available(iOS 14.0,*)
        {
            picker.preferredDatePickerStyle = .wheels
        }
        return picker
    }()
    
    private var arrInstructions = [Instruction]()
    
    ///When True disables the tap actions
    ///
    /// Note: This will just disbale the user interactions and hides cancel and submit buttons and adds back button.everything else will work based on the other variables passed while initializing this controller.
    var isViewOnly = false
    
    private var isMultiSelectClicked = false
    private var numberOfTickets : Int = 0
    
    //Added on 4th July 2020 V2.2
    private let accessManager = AccessManager.shared
    
    //Added by kiran V1.3 -- PROD0000069 --
    //PROD0000069 -- Start
    weak var delegate : DiningEventRegistrationVCDelegate?
    var navigatedFrom : EventNavigatedFrom?
    //PROD0000069 -- End
    
    //Added by kiran V1.4 -- PROD0000069 --
    //PROD0000069 -- Start
    var showStatus : Bool = false
    var strStatusColor : String = ""
    var strStatus : String = ""
    //PROD0000069 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Added on 4th July 2020 V2.2
        //added roles and privilages changes
        //since not allowed is handled before coming to this screen not need to check for it.
        switch self.accessManager.accessPermision(for: .diningReservation) {
        case .view:
            if !self.isViewOnly , let message = self.appDelegate.masterLabeling.role_Validation2 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            break
        default:
            break
        }
        
        self.instructionsTableView.delegate = self
        self.instructionsTableView.dataSource = self
        
        self.instructionsTableView.estimatedRowHeight = 40
        self.instructionsTableView.rowHeight = UITableViewAutomaticDimension
        
        self.instructionsTableView.allowsSelection = false
        self.instructionsTableView.separatorStyle = .none
        self.instructionsTableView.backgroundColor = .clear
        
        self.instructionsTableView.register(UINib.init(nibName: "InstructionsTableViewCell", bundle: nil), forCellReuseIdentifier: "InstructionsTableViewCell")
        
        self.getEventDetails()
        // Do any additional setup after loading the view.
        self.txtViewRemainder.text = ""
        self.timeInterval = self.appDelegate.arrDiningSettings?.timeInterval ?? 0
        
        lblComments.text =  self.appDelegate.masterLabeling.comments
        //lblTickets.text =  self.appDelegate.masterLabeling.tickets
        lblMemberName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,UserDefaults.standard.string(forKey: UserDefaultsKeys.captainName.rawValue)!)
        self.lblAdditionalEventDetails.text = self.appDelegate.masterLabeling.additionalEventDetails
        self.lblAdditionalEventDetails.sizeToFit()
        btnRequest.backgroundColor = .clear
        btnRequest.layer.cornerRadius = 15
        btnRequest.layer.borderWidth = 1
        btnRequest.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        self.btnRequest.setStyle(style: .outlined, type: .primary)
        
        btnCancelReservation.backgroundColor = .clear
        btnCancelReservation.layer.cornerRadius = 15
        btnCancelReservation.layer.borderWidth = 1
        btnCancelReservation.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        self.btnCancelReservation.setStyle(style: .outlined, type: .primary)
        
        txtComments.layer.cornerRadius = 15
        txtComments.layer.borderWidth = 0.25
        txtComments.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
        
        txtModifyInput.text = self.appDelegate.masterLabeling.add_member_or_guest

        isRemoveClicked = false
        isMinusClicked = false
        
        if eventType == 1 {
            
            viewModify.isHidden = false
            self.modifyTableView.isHidden = false
            registrationTableview.isHidden = true
            btnRequest .setTitle(self.appDelegate.masterLabeling.sAVE, for: UIControlState.normal)
            btnCancelReservation.isHidden = false
            self.bottomViewHeight.constant = 156
            btnCancelReservation .setTitle(self.appDelegate.masterLabeling.cancel_reservation, for: UIControlState.normal)
            viewComments.backgroundColor = hexStringToUIColor(hex: "F5F5F5")
            
        }else if eventType == 2{
            
            viewComments.isUserInteractionEnabled = false
            timeView.isUserInteractionEnabled = false
            viewPartySize.isUserInteractionEnabled = false
            btnCancelReservation.isHidden = true
            btnRequest.isHidden = true
            self.bottomViewHeight.constant = 10
            viewComments.backgroundColor = hexStringToUIColor(hex: "F5F5F5")
            registrationTableview.isHidden = true
            self.btnModifyAdd.isEnabled = false
            arrTotalList.append(RequestData())
            
        }
        else{
            
            viewModify.isHidden = true
            self.modifyTableView.isHidden = true
            
            registrationTableview.isHidden = false
            btnRequest .setTitle(self.appDelegate.masterLabeling.rEQUEST, for: UIControlState.normal)
            btnCancelReservation.isHidden = true
            self.bottomViewHeight.constant = 120
            
            viewComments.backgroundColor = UIColor.white
            arrTotalList.append(RequestData())
            let captainInfo = CaptaineInfo.init()
            captainInfo.setCaptainDetails(id: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "", name: String(format: "%@", UserDefaults.standard.string(forKey: UserDefaultsKeys.captainName.rawValue)!), firstName: UserDefaults.standard.string(forKey: UserDefaultsKeys.firstName.rawValue) ?? "" , order: 1, memberID: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "", parentID: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "", profilePic: UserDefaults.standard.string(forKey: UserDefaultsKeys.userProfilepic.rawValue) ?? "")
            
            arrNewRegList.append("")
            
            let selectedObject = captainInfo
            selectedObject.isEmpty = false
            arrTotalList.remove(at: 0)
            arrTotalList.insert(selectedObject, at: 0)
        }
        
        
        self.lblBottomText.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)
        
        self.lblTickets.text =  self.appDelegate.masterLabeling.party_size
        
//        self.datePicker.datePickerMode = .time
        
        
//        self.datePicker.setDate(Date(), animated: true)
//        self.datePicker.addTarget(self, action: #selector(self.didDOBDateChange(datePicker:)), for: .valueChanged)
//        self.txtTime.inputView = self.datePicker
        ModifyCellIndex = -1
        ModifyGuestCellIndex = -1
        
        
        timeInterverls = UIPickerView()
        timeInterverls?.dataSource = self
        timeInterverls?.delegate = self
        self.timePicker.addTarget(self, action: #selector(didTimePickerValueChanged(picker:)), for: .valueChanged)
        
        txtTime.inputView = timeInterverls
        txtEarlierThan.inputView = self.timePicker
        txtLaterThan.inputView = self.timePicker
        txtTime.delegate = self
        txtEarlierThan.delegate = self
        txtLaterThan.delegate = self
        
        self.lblLaterThan.text = self.appDelegate.masterLabeling.not_later_than
        self.lblEarlierThan.text = self.appDelegate.masterLabeling.not_earlier_than
        self.viewEarlierThan.isHidden = true
        self.viewLaterThan.isHidden = true
        
     //  if self.eventDetails.count != 0 {
        
//
//        if let roww = self.eventDetails[0].timeInterval?.index(of: selected){
//            picker.selectRow(row, inComponent: 0, animated: false)
//            }
//
//        }
        
        if self.isViewOnly
        {
            self.shouldDisableAllActions(true)
            self.btnRequest.setTitle(self.appDelegate.masterLabeling.bACK, for: .normal)
        }
        
        self.btnMultiSelect.multiSelectBtnViewSetup()
        self.btnMultiSelect.setTitle(self.appDelegate.masterLabeling.MULTI_SELECT_DINING, for: .normal)
        //self.btnMultiSelect.isHidden = (self.eventType == 1)
        //Modified by kiran V2.5 -- GATHER0000606 -- added hiding multiselect button when multi select options are empty.Hiding add button when member selection option is empty
        //GATHER0000606 -- Start
        self.viewMultiSelect.isHidden = (self.eventType == 1 || self.eventType == 2 || self.appDelegate.addRequestOpt_Dining_MultiSelect.count == 0)
        //self.viewMultiSelect.isHidden = (self.eventType == 1 || self.eventType == 2)
        //GATHER0000606 -- End
        
        //Added by kiran V1.4 -- PROD0000069 -- Support to request events from club news on click of news
        //PROD0000069 -- Start
        self.viewStatus.isHidden = !self.showStatus
        self.lblStatusHeader.text = self.appDelegate.masterLabeling.status
        self.lblStatus.text = self.strStatus
        self.viewStatusColor.layer.borderWidth = 0.5
        self.viewStatusColor.layer.borderColor = hexStringToUIColor(hex: "3D3D3D").cgColor
        self.viewStatusColor.layer.cornerRadius = self.viewStatusColor.frame.height/2
        self.viewStatusColor.clipsToBounds = true
        self.viewStatusColor.backgroundColor = hexStringToUIColor(hex: self.strStatusColor)
        
        self.viewStatus.backgroundColor = APPColor.OtherColors.appWhite
        self.lblStatus.textColor = APPColor.textColor.primary
        self.lblStatusHeader.textColor = APPColor.textColor.primary
        self.lblStatus.font = AppFonts.regular16
        self.lblStatusHeader.font = AppFonts.regular16
        //PROD0000069 -- End
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    @objc func didDOBDateChange(datePicker:UIDatePicker) {
        dob = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        txtTime.text = dateFormatter.string(for: dob)
       
        
    }

    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        self.navigationItem.title = self.appDelegate.masterLabeling.event_registration
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
        
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

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.instructionsTableViewHeight.constant = self.instructionsTableView.contentSize.height
        if( eventType == 1) {
            if self.txtViewRemainder.text == "" {
               // self.heightDetails.constant = 140 + self.lblAdditionalEventDetails.frame.height + 30//30 is the bottom padding of details view
            }else{
               // self.heightDetails.constant = 227 + txtViewRemainder.frame.height + self.lblAdditionalEventDetails.frame.height + 30//30 is the bottom padding of details view

            }
            self.modifyTableviewHeight.constant = modifyTableView.contentSize.height
            
            self.viewModifyheight.constant = 87 + modifyTableviewHeight.constant
            self.tableviewHeight.constant = 0
            
            self.middleViewHeight.constant = 56 + self.viewModifyheight.constant + ((self.btnMultiSelect.isHidden || self.viewMultiSelect.isHidden) ? 0 : 76.13)/*76.13(31.13 is multi-select button height and 45 is the top distance form multi-select button to view) is the hight thats need to be added for multi select button*/
            self.mainViewHeight.constant = 806 + self.middleViewHeight.constant + txtViewRemainder.frame.height + (self.viewEarlierThan.isHidden ? 0 : 120) /*120 Earlier and Later than views combined height (60+60)*/ + self.instructionsTableViewHeight.constant
            //Added by kiran V1.3 -- PROD0000069 -- adjusting the height according to showing or hiding the status
            //PROD0000069 -- Start
            self.mainViewHeight.constant += self.showStatus ? self.viewStatus.frame.height : 0
            //PROD0000069 -- End
            self.uiScrollview.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height:  self.mainViewHeight.constant)
        }else if( eventType == 2) {
            
            if self.txtViewRemainder.text == "" {
               // self.heightDetails.constant = 140 + self.lblAdditionalEventDetails.frame.height + 30//30 is the bottom padding of details view
            }else{
               // self.heightDetails.constant = 227 + txtViewRemainder.frame.height + self.lblAdditionalEventDetails.frame.height + 30//30 is the bottom padding of details view
                
            }
            self.modifyTableviewHeight.constant = modifyTableView.contentSize.height
            
            self.viewModifyheight.constant = 87 + modifyTableviewHeight.constant
            self.tableviewHeight.constant = 0
            
            self.middleViewHeight.constant = 56 + self.viewModifyheight.constant + ((self.btnMultiSelect.isHidden || self.viewMultiSelect.isHidden) ? 0 : 76.13)/*76.13(31.13 is multi-select button height and 45 is the top distance form multi-select button to view) is the hight thats need to be added for multi select button*/
            
            self.mainViewHeight.constant = 675 + self.middleViewHeight.constant + txtViewRemainder.frame.height + (self.viewEarlierThan.isHidden ? 0 : 120) + self.instructionsTableViewHeight.constant
            
            //Added by kiran V1.3 -- PROD0000069 -- adjusting the height according to showing or hiding the status
            //PROD0000069 -- Start
            self.mainViewHeight.constant += self.showStatus ? self.viewStatus.frame.height : 0
            //PROD0000069 -- End
            self.uiScrollview.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height:  self.mainViewHeight.constant)
            
        }
        else{
            if self.txtViewRemainder.text == "" {
               // self.heightDetails.constant = 140 + self.lblAdditionalEventDetails.frame.height + 30//30 is the bottom padding of details view
            }else{
               // self.heightDetails.constant = 227 + txtViewRemainder.frame.height + self.lblAdditionalEventDetails.frame.height + 30//30 is the bottom padding of details view
            }
            tableviewHeight.constant = registrationTableview.contentSize.height
            self.viewModifyheight.constant = 0
            self.middleViewHeight.constant = 76 + tableviewHeight.constant + ((self.btnMultiSelect.isHidden || self.viewMultiSelect.isHidden) ? 0 : 76.13)/*76.13(31.13 is multi-select button height and 45 is the top distance form multi-select button to view) is the hight thats need to be added for multi select button*/
            
            self.mainViewHeight.constant = 806 + self.middleViewHeight.constant + txtViewRemainder.frame.height + (self.viewEarlierThan.isHidden ? 0 : 120) + self.instructionsTableViewHeight.constant
            //Added by kiran V1.3 -- PROD0000069 -- adjusting the height according to showing or hiding the status
            //PROD0000069 -- Start
            self.mainViewHeight.constant += self.showStatus ? self.viewStatus.frame.height : 0
            //PROD0000069 -- End
            self.uiScrollview.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height:  self.mainViewHeight.constant)
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //  IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
    
    func addNewPopOverClicked(cell: CustomNewRegCell)
    {
        //Modified by kiran V2.5 -- ENGAGE0011300 -- Member validation is not shown for dining event
        //ENGAGE0011300 -- Start
        self.isMultiSelectClicked = false
        self.memberValidationAPI { (success) in
            
            if success
            {
                
                let indexPath = self.registrationTableview.indexPath(for: cell)
                self.selectedIndex = indexPath?.row
                self.selectedPlayerIndex = indexPath?.row
                
                let addNewView : UIView!
                
                if self.eventDetails[0].registrationFor == "Members Only" &&  self.eventDetails[0].guest == 0 {
                    addNewView = UIView(frame: CGRect(x: 100, y: 0, width: 180, height: 98))
                    
                    self.addNewPopoverTableView = UITableView(frame: CGRect(x: 0, y: 5, width: 180, height: 98))
                }
                else{
                    addNewView = UIView(frame: CGRect(x: 100, y: 0, width: 180, height: 146))
                    
                    self.addNewPopoverTableView = UITableView(frame: CGRect(x: 0, y: 5, width: 180, height: 146))
                    
                }
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
            
        }
        //ENGAGE0011300 -- End
    
    }
    
    func addMemberDelegate(selecteArray: [RequestData]) {
        if(eventType == 1){
            
            let selectedObject = selecteArray[0]
            selectedObject.isEmpty = false
            if ModifyCellIndex == -1{
                arrTotalList.insert(selectedObject, at: modifyCount)

            }else{
                arrTotalList.remove(at: ModifyCellIndex!)
                arrTotalList.insert(selectedObject, at: ModifyCellIndex!)
            }
          //  arrTotalList.append(selectedObject)
            modifyCount = arrTotalList.count
           
            self.modifyTableView.reloadData()
            self.view.setNeedsLayout()
            
        }else{
            let selectedObject = selecteArray[0]
            selectedObject.isEmpty = false
            arrTotalList.remove(at: selectedIndex!)
            arrTotalList.insert(selectedObject, at: selectedIndex!)
            if(selectedIndex == 0){
                //                if arrTotalList[0] is CaptaineInfo {
                //                    let memberObj = arrTotalList[0] as! CaptaineInfo
                //                    self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.captainName!)
                //                }
                
                if arrTotalList[0] is CaptaineInfo {
                    let memberObj = arrTotalList[0] as! CaptaineInfo
                    self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.captainName!)
                    
                    
                } else if arrTotalList[0] is DiningMemberInfo {
                    let memberObj = arrTotalList[0] as! DiningMemberInfo
                    self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.name ?? "")
                    
                }
                else if arrTotalList[0] is GuestInfo {
                    let guestObj = arrTotalList[0] as! GuestInfo
                    self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.guestName!)
                    
                    
                } else {
                    self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
                }
            }
            self.registrationTableview.reloadData()
        }
    }
    
    func requestMemberViewControllerResponse(selecteArray: [RequestData]) {
        
        if(eventType == 1){
           
            let selectedObject = selecteArray[0]
            selectedObject.isEmpty = false
            
            if ModifyGuestCellIndex == -1{
                arrTotalList.insert(selectedObject, at: modifyCount)
                
            }else{
                arrTotalList.remove(at: ModifyGuestCellIndex!)
                arrTotalList.insert(selectedObject, at: ModifyGuestCellIndex!)
            }
            modifyCount = arrTotalList.count
            
            self.modifyTableView.reloadData()
            self.view.setNeedsLayout()
        }
        else{
            let selectedObject = selecteArray[0]
            selectedObject.isEmpty = false
            arrTotalList.remove(at: selectedIndex!)
            arrTotalList.insert(selectedObject, at: selectedIndex!)
            
//            if(selectedIndex == 0){
////                if arrTotalList[0] is CaptaineInfo {
////                    let memberObj = arrTotalList[0] as! CaptaineInfo
////                    self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.captainName!)
////                }
//            
//                if arrTotalList[0] is CaptaineInfo {
//                    let memberObj = arrTotalList[0] as! CaptaineInfo
//                    self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.captainName!)
//                    
//                    
//                } else if arrTotalList[0] is MemberInfo {
//                    let memberObj = arrTotalList[0] as! MemberInfo
//                    self.lblMemberName.text =  String(format: "%@ %@, %@",self.appDelegate.masterLabeling.captain!,memberObj.lastName!, memberObj.firstName!)
//                    
//                }
//                else if arrTotalList[0] is GuestInfo {
//                    let guestObj = arrTotalList[0] as! GuestInfo
//                    self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.guestName!)
//                    
//                    
//                } else {
//                    self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
//                }
//            }
            
            self.registrationTableview.reloadData()
        }
    }
    
    //MARK:- Multiselect member directory delegate
    func multiSelectRequestMemberViewControllerResponse(selectedArray: [[RequestData]]) {
        
        if let selectedMembers = selectedArray.first
        {
            self.arrTotalList.removeAll()
            self.arrTotalList = selectedMembers
            self.registrationTableview.reloadData()
        }
    }
    
    func ModifyClicked(cell: ModifyRegCustomCell) {
        self.btnModifyAdd.isEnabled = true
        
        let indexPath = self.modifyTableView.indexPath(for: cell)
        selectedPlayerIndex = indexPath?.row
        arrTotalList.remove(at: selectedPlayerIndex!)
       // arrTotalList.insert(RequestData(), at: selectedPlayerIndex!)
        modifyCount = arrTotalList.count
        if(arrTotalList.count == 0){

                self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
            }
        
        modifyTableView.reloadData()
        self.view.setNeedsLayout()
        
    }
    func editClicked(cell: CustomNewRegCell) {
        
    }
    
    func clearButtonClicked(cell: CustomNewRegCell) {
        
        //        cell.txtSearchField.text = ""
        
        let indexPath = self.registrationTableview.indexPath(for: cell)
        selectedPlayerIndex = indexPath?.row
        arrTotalList.remove(at: selectedPlayerIndex!)
        arrTotalList.insert(RequestData(), at: selectedPlayerIndex!)
//        if(selectedPlayerIndex == 0){
//            if arrTotalList[0] is CaptaineInfo {
//                let memberObj = arrTotalList[0] as! CaptaineInfo
//                self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.captainName!)
//            }
//        }
        if(selectedPlayerIndex == 0){
            if arrTotalList[0] is CaptaineInfo {
                let memberObj = arrTotalList[0] as! CaptaineInfo
                self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.captainName!)
                
                
            } else if arrTotalList[0] is DiningMemberInfo {
                let memberObj = arrTotalList[0] as! DiningMemberInfo
                self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.name ?? "")
                
            }
            else if arrTotalList[0] is GuestInfo {
                let guestObj = arrTotalList[0] as! GuestInfo
                self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.guestName!)
                
                
            } else {
                self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
            }
        }
        
        registrationTableview.reloadData()
    }
    
   
    //MARK:- Get Event Details  Api

    func getEventDetails()
    {
        
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                "Role": UserDefaults.standard.string(forKey: UserDefaultsKeys.role.rawValue)!,
                "EventID": eventID ?? "",
                "Category": eventCategory ?? "",
                "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!,
                "EventRegistrationDetailID": eventRegistrationDetailID ?? "",
                "RequestID": requestID ?? ""
            ]
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.getEventDetails(paramater: paramaterDict , onSuccess: { response in
                
                self.appDelegate.hideIndicator()
                if(response.responseCode == InternetMessge.kSuccess){
                    
                    self.eventDetails = [response]
                    
                    //Modified by kiran V2.5 -- GATHER0000606 -- Hiding add button when member selection option is empty
                    //GATHER0000606 -- Start
                    if self.eventType == 1
                    {
                        self.btnModifyAdd.isHidden = self.shouldHideMemberAddOptions()
                    }
                    //GATHER0000606 -- End
                    let placeHolderImage = UIImage(named: "Icon-App-40x40")
                    self.imgEvent.image = placeHolderImage
                    self.arrRegisterDetails = response.registeredDetails!
                    
                    //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
                    //ENGAGE0011419 -- Start
                    let imageURLString = response.thumbnail ?? ""
                    
                    if imageURLString.isValidURL()
                    {
                        let url = URL.init(string:imageURLString)
                        self.imgEvent.sd_setImage(with: url , placeholderImage: placeHolderImage)
                    }
                    /*
                    if(imageURLString.count>0){
                        let validUrl = self.verifyUrl(urlString: imageURLString)
                        if(validUrl == true){
                            
                            let url = URL.init(string:imageURLString)
                            self.imgEvent.sd_setImage(with: url , placeholderImage: placeHolderImage)
                            
                        }
                    }
                    */
                    //ENGAGE0011419 -- End
                    
//                    for _ in 0..<self.arrRegisterDetails[0].diningDetails!.count {
//                        self.arrTotalList.append(RequestData())
//                    }
//                    
//                    for i in 0..<self.arrRegisterDetails[0].diningDetails!.count {
//                        self.arrTotalList.remove(at: i)
//                        
//                        self.arrTotalList.insert(((self.arrTeeTimeDetails[0].diningDetails?[i])!), at: i)
//                        let playObj = self.arrTotalList[i] as! GroupDetail
//                        
//                        self.arrRegReqID.append(playObj.reservationRequestDate!)
//                        
//                    }
                  
                    self.lblTitle.text = response.eventName
                    self.lblEventVenue.text = response.eventVenue
                    self.lblEventMonthDay.text = response.eventDate
                    self.lblEventTime.text = response.eventTime
                    //Modified on 28th September 2020 V2.3
                    //self.txtViewRemainder.text = response.additionalDetails
                    
                    let additionalDetailsAttrString : NSMutableAttributedString = NSMutableAttributedString.init(attributedString: response.additionalDetails?.generateAttributedString(isHtml: true) ?? NSAttributedString.init(string: ""))

                     let font : UIFont = UIFont.init(name: "SourceSansPro-Regular", size: 17.0)!
                     let fontColor : UIColor = hexStringToUIColor(hex: "#695B5E")

                     additionalDetailsAttrString.addAttributes([.foregroundColor : fontColor , .font : font], range: NSMakeRange(0, additionalDetailsAttrString.length))
                    
                    self.txtViewRemainder.attributedText = additionalDetailsAttrString
                    
                   if response.requestDiningDetails?.count == 0 {
                    
                   }else{
                    self.txtComments.text = response.requestDiningDetails![0].comments
                    self.lblConfirmationNumber.text = response.requestDiningDetails?[0].confirmationNumber ?? ""

                    }
                    
                    self.dinigRequestDate = response.eventDate
                    self.dinigRequestTime = response.eventTime
                    self.preferredDetailID =  response.preferedSpaceDetailId
                    let inputFormatter = DateFormatter()
                    inputFormatter.dateFormat = "MMM dd, yyy"
                    let showDate = inputFormatter.date(from: self.dinigRequestDate ?? "")
                    inputFormatter.dateFormat = "MM/dd/yyyy"
                    self.dinigRequestDate = inputFormatter.string(from: showDate ?? Date())
                    
                    if  response.eventDateTime?.count != 0{
                        if response.eventDateTime![0].eventToTime == "" {
                            self.lblEventTime.text = response.eventDateTime![0].eventFromTime ?? ""
                        }else if response.eventDateTime![0].eventFromTime == "" {
                            self.lblEventTime.text = response.eventDateTime![0].eventToTime ?? ""
                        }else if response.eventDateTime![0].eventFromTime == "" &&  response.eventDateTime![0].eventToTime == ""{
                            self.lblEventTime.text = ""
                        }else{
                        
                    self.lblEventTime.text = String(format: "%@ - %@", response.eventDateTime![0].eventFromTime!, response.eventDateTime![0].eventToTime!)
                        }
                    }
                    
                    if response.isMemberChangeTime == 1 {
                        self.timeView.isHidden = false
                        self.timeViewHeight.constant = 50
                        self.lblEventTime.isHidden = true
                    }else{
                        self.timeView.isHidden = true
                        self.timeViewHeight.constant = 0
                        self.lblEventTime.isHidden = false
                    }
                    self.lblNumberOfTickets.text = String(format: "%02d", 1)
                    //Request
                    if response.requestDiningDetails?.count == 0 {
                        if self.eventDetails.count != 0  {
                            if self.eventDetails[0].timeInterval?.count != 0{
                                self.txtTime.text = self.eventDetails[0].timeInterval?[0].value ?? ""
                            }
                        }
                    }else{//Modify
                        
                        //Modified on 17th October 2020 V2.3
                        let reqeustTime = response.requestDiningDetails![0].reservationRequestTime ?? ""
                        
                        if self.eventDetails[0].timeInterval?.contains(where: {$0.value == reqeustTime}) ?? false
                        {
                            self.txtTime.text = response.requestDiningDetails![0].reservationRequestTime ?? ""
                        }
                        else
                        {
                            self.txtTime.text = self.eventDetails[0].timeInterval?[0].value ?? ""
                        }
                    //self.txtTime.text = response.requestDiningDetails![0].reservationRequestTime ?? ""
                        
                        if response.requestDiningDetails![0].reservationRequestTime == "" {
                             self.txtTime.text = self.eventDetails[0].timeInterval?[0].value ?? ""
                        }
                        
                        self.lblNumberOfTickets.text = String(format: "%02d", response.requestDiningDetails![0].partySize ?? 1)
                        
                        
                        if (response.requestDiningDetails![0].partySize == 0){
                            self.arrNewRegList.append(contentsOf: repeatElement("", count: response.requestDiningDetails![0].partySize!))
                        }
                        else{
                            self.arrNewRegList.append(contentsOf: repeatElement("", count: response.requestDiningDetails![0].partySize!))
                        }
                    }
                    
                    if let numberOftickets = response.requestDiningDetails?.first?.partySize
                    {
                        self.numberOfTickets = numberOftickets
                    }
//                    let dateFormatterMin = DateFormatter()
//                    dateFormatterMin.dateFormat = "hh:mm a"
//
//                    let dateMin = dateFormatterMin.date(from: response.eventTime ?? "")
//                    dateFormatterMin.dateFormat = "HH:mm"
//
//                    let DateMin = dateFormatterMin.string(from: dateMin!)
//
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat =  "HH:mm"
//                    let date = dateFormatter.date(from: DateMin)

                     if response.isMemberChangeTime == 1 {
                         self.dinigRequestTime = self.txtTime.text
                     }else{
                        
                    }
                    
                    if response.additionalDetails == "" {
                      // self.lblAdditionalEventDetails.isHidden = true
                    }
                    
                    self.lblEventMonthDay.text = response.eventDate
                   
                    self.btnDecreaseTickets.isEnabled = false
                    
                    if self.eventType == 1 || self.eventType == 2{
                        
                        self.arrTotalList.removeAll()
                        if response.requestDiningDetails?.count == 0 {
                        }else{
                        for i in 0..<response.requestDiningDetails![0].diningDetails!.count {
                            self.arrTotalList.append(RequestData())

                            self.arrTotalList.remove(at: i)
                            
                            self.arrTotalList.insert(((response.requestDiningDetails?[0].diningDetails?[i])!), at: i)

                            let playObj = self.arrTotalList[i] as! GroupDetail
                            
                            self.arrRegReqID.append(playObj.reservationRequestDetailId!)
                            self.arrTemp = self.arrTotalList
                            
                        }
//                         for i in 0..<self.arrTemp.count {
//
//
//                            let playObj = self.arrTemp[i] as! GroupDetail
//
//
//                            if String((playObj.memberID?.dropFirst())!) == UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "" {
//                                self.arrTotalList.remove(at: i)
//                            }
//                        }
                        }
                        self.modifyCount = self.arrTotalList.count

                        self.btnDecreaseTickets.isEnabled = true
                        
                       
                        self.modifyTableView.reloadData()
                        
                    }
                    else{
                       //  self.arrTotalList.append(RequestData())
                        self.registrationTableview.reloadData()
                        
                    }
                    
                    
                    self.txtViewRemainder .sizeToFit()
                    self.lblAdditionalEventDetails.sizeToFit()
                    
                    self.viewEarlierThan.isHidden = !(response.IsAllowEarliestLatestTime ?? 0 == 1)
                    self.viewLaterThan.isHidden = !(response.IsAllowEarliestLatestTime ?? 0 == 1)
                    
                    //Modify Case
                    if self.eventType == 1
                    {
                        if let earlierThan = response.requestDiningDetails?.first?.earliest
                        {
                            //Modified on 17th October 2020 V2.3
                            if self.eventDetails[0].timeInterval?.contains(where: {$0.value == earlierThan}) ?? false
                            {
                                self.txtEarlierThan.text = earlierThan
                                self.earliarThanTime = earlierThan
                            }
                            else
                            {
                                self.txtEarlierThan.text = self.eventDetails[0].timeInterval?.first?.value ?? ""
                                self.earliarThanTime = self.eventDetails[0].timeInterval?.first?.value ?? ""
                            }
                            
                        }
                        
                        if let laterThan = response.requestDiningDetails?.first?.latest
                        {
                            //Modified on 17th October 2020 V2.3
                            if self.eventDetails[0].timeInterval?.contains(where: {$0.value == laterThan}) ?? false
                            {
                                self.txtLaterThan.text = laterThan
                                self.laterThanTime = laterThan
                            }
                            else
                            {
                                self.txtLaterThan.text = self.eventDetails[0].timeInterval?.last?.value ?? ""
                                self.laterThanTime = self.eventDetails[0].timeInterval?.last?.value ?? ""
                            }
                            
                           
                        }
                    }//View Case
                    else if self.eventType == 2
                    {
                        if let earlierThan = response.requestDiningDetails?.first?.earliest
                        {
                            //Modified on 17th October 2020 V2.3
                            if self.eventDetails[0].timeInterval?.contains(where: {$0.value == earlierThan}) ?? false
                            {
                                self.txtEarlierThan.text = earlierThan
                                self.earliarThanTime = earlierThan
                            }
                            else
                            {
                                self.txtEarlierThan.text = self.eventDetails[0].timeInterval?.first?.value ?? ""
                                self.earliarThanTime = self.eventDetails[0].timeInterval?.first?.value ?? ""
                            }
//                            self.txtEarlierThan.text = earlierThan
//                            self.earliarThanTime = earlierThan
                        }
                        
                        if let laterThan = response.requestDiningDetails?.first?.latest
                        {
                            //Modified on 17th October 2020 V2.3
                            if self.eventDetails[0].timeInterval?.contains(where: {$0.value == laterThan}) ?? false
                            {
                                self.txtLaterThan.text = laterThan
                                self.laterThanTime = laterThan
                            }
                            else
                            {
                                self.txtLaterThan.text = self.eventDetails[0].timeInterval?.last?.value ?? ""
                                self.laterThanTime = self.eventDetails[0].timeInterval?.last?.value ?? ""
                            }
//                            self.txtLaterThan.text = laterThan
//                            self.laterThanTime = laterThan
                        }
                        
                        self.txtEarlierThan.isUserInteractionEnabled = false
                        self.txtLaterThan.isUserInteractionEnabled = false
                    }
                    else //Request Case
                    {
                        self.txtEarlierThan.text = self.eventDetails[0].timeInterval?.first?.value ?? ""
                        self.earliarThanTime = self.eventDetails[0].timeInterval?.first?.value
                       
                        
                        self.txtLaterThan.text = self.eventDetails[0].timeInterval?.last?.value ?? ""
                        self.laterThanTime = self.eventDetails[0].timeInterval?.last?.value
                        
                        
                        //Added by kiran V2.8 -- ENGAGE0011779 -- Adding suport for minimum number of tickets.
                        //ENGAGE0011779 -- Start
                        //Minimum tickets allowed should always be 1 or more and it should always be sent in response. otherwise its a backend issue.
                        while (self.eventDetails.first?.minTicketsAllowed ?? 0 > 0) && self.arrTotalList.count < (self.eventDetails.first?.minTicketsAllowed ?? 1)
                        {
                            self.arrTotalList.append(RequestData())
                            self.arrNewRegList.append("")
                        }
                        
                        self.lblNumberOfTickets.text = String.init(format: "%02d", self.arrTotalList.count)
                        self.registrationTableview.reloadData()
                        
                        //ENGAGE0011779 -- End
                        
                    }
                    
                    self.openTime = self.eventDetails[0].timeInterval?.first?.value
                    self.closeTime = self.eventDetails[0].timeInterval?.last?.value
                    
                    if response.IsCancelEventAllowed == 0
                    {
                        self.btnCancelReservation.isHidden = true
                        self.cancelReservationHeight.constant = -20
                    }
                    
                    self.arrInstructions = self.appDelegate.DiningEventInstruction
                    self.instructionsTableView.reloadData()
                    
                    if response.isScheduleEvent == 1
                    {
                        self.lblEventTime.text = nil
                        self.lblEventTime.sizeToFit()
                    }
                    
                }else{
                    
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
        }
        
    }
    
    //MARK:- Multi select Bttn Action
    @IBAction func MultiSelectBtnAction(_ sender: UIButton)
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
        
        //Added by kiran V2.5 -- ENGAGE0011300 -- Member validation is not shown for dining event
        //ENGAGE0011300 -- Start
        self.memberValidationAPI { (success) in
            
            if success
            {
                self.isMultiSelectClicked = true
                /* let addNewView : UIView!
                 
                 if self.eventDetails[0].registrationFor == "Members Only" &&  self.eventDetails[0].guest == 0 {
                     addNewView = UIView(frame: CGRect(x: 100, y: 0, width: 180, height: 98))
                     
                     addNewPopoverTableView = UITableView(frame: CGRect(x: 0, y: 5, width: 180, height: 98))
                 }
                 else{
                     addNewView = UIView(frame: CGRect(x: 100, y: 0, width: 180, height: 146))
                     
                     addNewPopoverTableView = UITableView(frame: CGRect(x: 0, y: 5, width: 180, height: 146))
                     
                 }
                 addNewView.addSubview(addNewPopoverTableView!)
                 
                 addNewPopoverTableView?.dataSource = self
                 addNewPopoverTableView?.delegate = self
                 addNewPopoverTableView?.bounces = true
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
                     
                 }*/
                
                let addNewView : UIView!
                //Modified by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
                //GATHER0000606 -- Start
                let popoverHeight = self.appDelegate.addRequestOpt_Dining_MultiSelect.count * 50
                //let popoverHeight = self.appDelegate.arrRegisterMultiMemberType.count * 50
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

                if point.y > height - 170
                {
                    self.addNewPopover?.popoverType = .up
                    self.addNewPopover?.show(addNewView, point: pointt)
                }
                else
                {
                    self.addNewPopover?.show(addNewView, point: pointt)
                }
                
            }
        }
        //ENGAGE0011300 -- End
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
        
        
        
        if (self.lblNumberOfTickets.text?.hasPrefix("0"))! {
            partySize = self.lblNumberOfTickets.text
            partySize =  String((partySize?.characters.dropFirst())!)
        }else{
            partySize = self.lblNumberOfTickets.text
        }
        
        arrTempPlayers = arrTotalList
        partyList.removeAll()

        if eventType == 1 {
            
        }else{
            arrTempPlayers =  arrTempPlayers.filter({$0.isEmpty == false})
            
        }
        
        if (Network.reachability?.isReachable) == true{
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
//            let specialOccassion:[String: Any] = [
//                "Birthday":0,
//                "Anniversary":0,
//                "Other":0,
//                "OtherText":""
//            ]
//            let memberInfo:[String: Any] = [
//                "ReservationRequestDetailId": "",
//                "LinkedMemberID": UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
//                "GuestMemberOf": "",
//                "GuestType": "",
//                "GuestName": "",
//                "GuestEmail": "",
//                "GuestContact": "",
//                "HighChairCount": 0,
//                "BoosterChairCount": 0,
//                "SpecialOccasion": [specialOccassion],
//                "DietaryRestrictions": "",
//                "DisplayOrder": 1,
//                "AddBuddy": 0
//            ]
////            if eventType == 1{
////
////            }else{
//            partyList.append(memberInfo)
//            }
            for i in 0 ..< arrTempPlayers.count {
                
                if arrTempPlayers[i] is CaptaineInfo {
                    let specialOccassionInfo:[String: Any] = [
                        "Birthday":0,
                        "Anniversary":0,
                        "Other":0,
                        "OtherText":""
                    ]
                    
                    let memberInfo:[String: Any] = [
                        "ReservationRequestDetailId": "",
                        "LinkedMemberID": UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "HighChairCount": 0,
                        "BoosterChairCount": 0,
                        "SpecialOccasion": [specialOccassionInfo],
                        "DietaryRestrictions": "",
                        "DisplayOrder": 1,
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
                    let memberType = CustomFunctions.shared.memberType(details: playObj, For: .diningEvents)
                    
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
                        //TODO:- Remove after approval
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
                    
                    //ENGAGE0011784 -- End
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
            
            paramaterDict = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "RequestId": requestID ?? "",
                "ReservationRequestDate": dinigRequestDate ?? "",
                "ReservationRequestTime": dinigRequestTime ?? "",
                "PartySize": partySize ?? "",
                "Comments": txtComments.text ?? "",
                "DiningDetails" : partyList,
                "EventID":eventID ?? "",
                "PreferedSpaceDetailId": self.preferredDetailID ?? "",
                "Earliest" : self.earliarThanTime ?? "",
                "Latest" : self.laterThanTime ?? ""
                
            ]
            
            print("memberdict \(paramaterDict)")
            APIHandler.sharedInstance.saveDiningReservationRequest(paramaterDict: paramaterDict, onSuccess: { memberLists in
                self.appDelegate.hideIndicator()
                if(memberLists.responseCode == InternetMessge.kSuccess)
                {
                    self.appDelegate.hideIndicator()
                    if self.isFrom == "SpecialRequest" && (self.isOnlyFrom == "EventSPecialDiningUpdate" || self.isOnlyFrom == "ModifySpecialEvent"){
                        
                        if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView {
                            self.appDelegate.hideIndicator()
                            succesView.delegate = self
                            succesView.isFrom = "SpecialRequest"
                            succesView.imgUrl = memberLists.imagePath ?? ""
                            succesView.modalTransitionStyle   = .crossDissolve;
                            succesView.modalPresentationStyle = .overCurrentContext
                            self.present(succesView, animated: true, completion: nil)
                        }
                    }else if self.isFrom == "SpecialRequest"{
                        
                        if let share = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ThanksVC") as? ThanksVC {
                            share.delegate = self
                            self.appDelegate.requestFrom = "Dining"
                            share.isFrom = "SpecialDiningEvent"
                            let dateFormatterToSend = DateFormatter()
                            dateFormatterToSend.dateFormat = "MM/dd/yyyy"
                            
                            let isoDate = self.reservationRemindDate
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                            let date = dateFormatter.date(from:isoDate!)!
                            
                            share.remindDate = dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: -(self.diningSettings?.minDaysInAdvance)!, to: date)!)
                            share.palyDate = self.reservationReqDate
                            
                            share.modalTransitionStyle   = .crossDissolve;
                            share.modalPresentationStyle = .overCurrentContext
                            self.present(share, animated: true, completion: nil)
                        }
                    }
                    else{
                        if self.eventType == 1 {
                        
                    if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView {
                        self.appDelegate.hideIndicator()
                        succesView.delegate = self
                        succesView.isFrom = "EventUpdate"
                        succesView.isFrom = self.isFrom
                        succesView.eventType = self.eventType
                        succesView.segmentIndex = self.segmentIndex
                        succesView.imgUrl = memberLists.imagePath ?? ""
                        succesView.modalTransitionStyle   = .crossDissolve;
                        succesView.modalPresentationStyle = .overCurrentContext
                        self.present(succesView, animated: true, completion: nil)
                    }
                        }else{
                        if let share = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ThanksVC") as? ThanksVC {
                            self.appDelegate.hideIndicator()
                            share.delegate = self
                            
                            share.isFrom = "DiningEventReservation"
                            share.segmentIndex = self.segmentIndex
                            if self.isFrom == "EventRequest"{
                            share.isFrom = self.isFrom
                            }
                            let inputFormatter = DateFormatter()
                            inputFormatter.dateFormat = "MM/dd/yyyy"
                            let showDate = inputFormatter.date(from: self.dinigRequestDate ?? "")
                            inputFormatter.dateFormat = "yyyy-MM-dd"
                            self.reservationRemindDate = inputFormatter.string(from: showDate ?? Date()) + "T00:00:00+0530"
                            
                            
                            let dateFormatterToSend = DateFormatter()
                            dateFormatterToSend.dateFormat = "MM/dd/yyyy"
                            
                            let isoDate = self.reservationRemindDate
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                            let date = dateFormatter.date(from:isoDate!)!
                            
                            share.remindDate = dateFormatterToSend.string(from: Calendar.current.date(byAdding: .day, value: -((self.eventDetails[0].minDaysInAdvance)!), to: date)!)
                            share.palyDate = self.dinigRequestDate
                            share.modalTransitionStyle   = .crossDissolve;
                            share.modalPresentationStyle = .overCurrentContext
                            self.present(share, animated: true, completion: nil)
                        }
                            
                        }
                        
                    }
                   
                }else{
                    self.appDelegate.hideIndicator()
                    
                    //Added by kiran V2.5 -- ENGAGE0011300 -- Member validation is not shown for dining event
                    //ENGAGE0011300 -- Start
                    //SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: memberLists.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                    //Added by kiran V2.8 -- ENGAGE0011779 -- Added check for member count and if zero showing as toast message.
                    //ENGAGE0011779 -- Start
                    if let details = memberLists.details,details.count > 0 , let impVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ImpotantContactsVC") as? ImpotantContactsVC
                    {
                        impVC.importantContactsDisplayName = memberLists.brokenRules?.fields?[0] ?? ""
                        impVC.isFrom = "Reservations"
                        impVC.arrList = details
                        impVC.modalTransitionStyle   = .crossDissolve;
                        impVC.modalPresentationStyle = .overCurrentContext
                        self.present(impVC, animated: true, completion: nil)
                    }
                    else
                    {
                        SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: memberLists.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                    }
                    //ENGAGE0011779 -- End
                    //ENGAGE0011300 -- End
                }
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
            
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            
        }
        
        
    }
    
    @IBAction func modifyAddButtonClicked(_ sender: Any)
    {
        //Modified by kiran V2.5 -- ENGAGE0011300 -- Member validation is not shown for dining event
        //ENGAGE0011300 -- Start
        self.isMultiSelectClicked = false
        self.memberValidationAPI { (success) in
            
            if success
            {
                self.ModifyCellIndex = -1
                self.ModifyGuestCellIndex = -1
                
                if self.arrTotalList.count  >= Int(self.lblNumberOfTickets.text ?? "")! {
                    self.btnModifyAdd.isEnabled = false
                }else{
                    self.btnModifyAdd.isEnabled = true
                    let addNewView : UIView!
                    
                    if(self.eventDetails[0].registrationFor == "Members Only") && (self.eventDetails[0].guest == 0){
                        addNewView = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 98))
                        
                        self.addNewPopoverTableView = UITableView(frame: CGRect(x: 0, y: 5, width: 180, height: 98))
                    }
                    else{
                        addNewView = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 146))
                        
                        self.addNewPopoverTableView = UITableView(frame: CGRect(x: 0, y: 5, width: 180, height: 146))
                        
                    }
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
                    let point = self.btnModifyAdd.convert(self.btnModifyAdd.center , to: self.appDelegate.window)
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

            }
        }
        //ENGAGE0011300 -- End
        
    }
    
    @IBAction func clearClicked(_ sender: Any) {
        
        
    }
    @IBAction func cancelClicked(_ sender: Any) {
        
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
            if self.isFrom == "SpecialRequest" && (self.isOnlyFrom == "EventSPecialDiningUpdate" || self.isOnlyFrom == "ModifySpecialEvent"){
                cancelViewController.isFrom = "EventDiningCancelRequestReservation"
                cancelViewController.isOnlyFrom = "EventDiningCancelRequestRes"
            }else if self.isFrom == "RequestEvents"{
                 cancelViewController.isFrom = "EventDiningCancelRequestReservation"
            }
            else{
                cancelViewController.isOnlyFrom = "DiningEvent"
               cancelViewController.isFrom = "DiningCancel"
            }
            cancelViewController.cancelFor = .DiningEvent
            cancelViewController.eventID = requestID
            cancelViewController.numberOfTickets = self.numberOfTickets == 0 ? "" : "\(self.numberOfTickets)"
            //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
            //PROD0000069 -- Start
            cancelViewController.delegate = self
            //PROD0000069 -- End
            self.navigationController?.pushViewController(cancelViewController, animated: true)
        }
        
        
    }
    
    @IBAction func increaseTicketsClicked(_ sender: Any) {
        btnDecreaseTickets.isEnabled = true
        self.btnModifyAdd.isEnabled = true
        
        
        if eventType == 1
        {
            //Added by kiran V2.8 -- ENGAGE0011779 -- Fixed the issue where member is able to add tickets more then the maxAllowed tickets. when a request is made from back office with members more than the max allowed and opthe request in app. members are able to increase the tickets n times and submit the request
            //ENGAGE0011779 -- Start
            //Commented the old comparision using strings as it was failing in the above mentioned scenario
            if self.arrNewRegList.count < self.eventDetails[0].maxAllowedTickets ?? 1 //("\(String(describing: arrNewRegList.count))" <= "\(String(describing: self.eventDetails[0].maxAllowedTickets))")
            {
                
                if arrNewRegList.count == self.eventDetails[0].maxAllowedTickets {
                    btnIncreaseTicket.isEnabled = false
                }
                else{
                    btnDecreaseTickets.isEnabled = true
                    
                    arrNewRegList.append("")
                    
                    self.lblNumberOfTickets.text = String(format: "%02d",Int(self.lblNumberOfTickets.text!)! + 1)
                }
            }//Added else part as part of ENGAGE0011779
            else
            {
                btnIncreaseTicket.isEnabled = false
            }
            //ENGAGE0011779 -- End
            self.modifyTableView.isHidden = false
            self.registrationTableview.isHidden = true
            
        }
        else {
            
            self.modifyTableView.isHidden = true
            self.registrationTableview.isHidden = false
            
            if ("\(String(describing: arrNewRegList.count))" <= "\(String(describing: self.eventDetails[0].maxAllowedTickets))"){
                
                if arrNewRegList.count == self.eventDetails[0].maxAllowedTickets!{
                    btnIncreaseTicket.isEnabled = false
                    
                }
                else{
                    btnDecreaseTickets.isEnabled = true
                    arrNewRegList.append("")
                    arrTotalList.append(RequestData())

                    self.lblNumberOfTickets.text = String(format: "%02d", Int(self.lblNumberOfTickets.text!)! + 1)
                    
                }
                
            }
            
            self.registrationTableview.reloadData()
        }
        
    }
    
    @IBAction func decreaseTicketsClicked(_ sender: Any)
    {
        
        btnModifyAdd.isEnabled = true
        btnIncreaseTicket.isEnabled = true
        if (eventType == 1)
        {
            //Added by kiran V2.8 -- ENGAGE0011779 -- Adding suport for minimum number of tickets.
            //ENGAGE0011779 -- Start
            if Int(self.lblNumberOfTickets.text!)! <= (self.eventDetails.first?.minTicketsAllowed ?? 1) /*01*/
            {
                btnDecreaseTickets.isEnabled = false
            }
            else
            {
                arrNewRegList.removeLast()
                self.lblNumberOfTickets.text = String(format: "%02d", Int(self.lblNumberOfTickets.text!)! - 1)
                if Int(self.lblNumberOfTickets.text!)! == (self.eventDetails.first?.minTicketsAllowed ?? 1)/*01*/
                {
                    btnDecreaseTickets.isEnabled = false
                }
            }
            
            //ENGAGE0011779 -- End
            modifyTableView.reloadData()
            self.view.setNeedsLayout()
            
        }
        else
        {
            btnDecreaseTickets.isEnabled = true
            
            //Added by kiran V2.8 -- ENGAGE0011779 -- Adding suport for minimum number of tickets.
            //ENGAGE0011779 -- Start
            if arrTotalList.count <= (self.eventDetails.first?.minTicketsAllowed ?? 1) /*0*/
            {
                btnDecreaseTickets.isEnabled = false
                //Added by kiran V2.8 -- ENGAGE0011779 -- Adding suport for minimum number of tickets.
                //ENGAGE0011779 -- Start
                return
                //ENGAGE0011779 -- End
            }
            else
            {
               // arrTotalList.removeLast()
            }
             arrTotalList.removeLast()
            if arrTotalList.count == (self.eventDetails.first?.minTicketsAllowed ?? 1) /*0*/
            {
                btnDecreaseTickets.isEnabled = false
            }
            //ENGAGE0011779 -- End
            arrNewRegList.removeLast()
            self.lblNumberOfTickets.text = String(format: "%02d", Int(self.lblNumberOfTickets.text!)! - 1)
            self.registrationTableview.reloadData()
        }
        
    }
    
    //MARK:- Text Field Delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtTime{
            self.selectedTextField = txtTime
            
            self.timeInterverls?.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(timeInterverls!, didSelectRow: 0, inComponent: 0)
            
        }else if textField == self.txtEarlierThan{
            self.selectedTextField = self.txtEarlierThan
            self.timePicker.minuteInterval = self.timeInterval
            
            self.timePicker.maximumDate = self.timeConverter(time: self.txtTime.text)
            self.timePicker.minimumDate = self.timeConverter(time: self.openTime)
            
            if let earlierDate = self.timeConverter(time: self.txtEarlierThan.text)
            {
                self.timePicker.setDate(earlierDate, animated: false)
            }
            
        }else if textField == self.txtLaterThan{
            self.selectedTextField = self.txtLaterThan
            self.timePicker.minuteInterval = self.timeInterval
            
            self.timePicker.minimumDate = self.timeConverter(time: self.txtTime.text)
            self.timePicker.maximumDate = self.timeConverter(time: self.closeTime)
            
            if let laterDate = self.timeConverter(time: self.txtLaterThan.text)
            {
                self.timePicker.setDate(laterDate, animated: false)
            }
        }
     
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.txtTime
        {
            guard let eventDate = self.timeConverter(time: textField.text),
                let earlierDate = self.timeConverter(time: self.earliarThanTime) , let laterDate = self.timeConverter(time: self.laterThanTime) else{
                    return
                    
            }
            //Earlier time compare and reset if greater than event time
            let earlier_Event_result = Calendar.current.compare(earlierDate, to: eventDate, toGranularity: .minute)
            
            if earlier_Event_result == .orderedDescending
            {
                self.txtEarlierThan.text = textField.text
                self.earliarThanTime = textField.text
            }
            
            //Later time compare and reset if smaller than Event time
            let later_event_result = Calendar.current.compare(laterDate, to: eventDate, toGranularity: .minute)
            
            if later_event_result == .orderedAscending
            {
                self.txtLaterThan.text = textField.text
                self.laterThanTime = textField.text
            }
        }
    }
    
    //MARK:- Picker Delegates
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return self.eventDetails[0].timeInterval?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        return self.eventDetails[0].timeInterval?[row].value
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
       // self.txtTime.text = self.eventDetails[0].timeInterval?[row].value
        self.selectedTextField?.text = self.eventDetails[0].timeInterval?[row].value
        
       // self.dinigRequestTime = self.txtTime.text
        
        if self.selectedTextField == self.txtTime
        {
            self.dinigRequestTime = self.eventDetails[0].timeInterval?[row].value
        }
        
    }
    
    
    
    
    //MARK:- Time Picker functions
    
    @objc func didTimePickerValueChanged(picker : UIDatePicker)
    {
        let time = self.timeConverter_twelve(time: picker.date)
        self.selectedTextField?.text = time
        
        if self.selectedTextField == self.txtEarlierThan
        {
            self.earliarThanTime = time
        }
        else if self.selectedTextField == self.txtLaterThan
        {
            self.laterThanTime = time
        }
    }
    
    /**converts 12 hrs format string to 24 hrs formate date*/
       private func timeConverter(time : String?) -> Date?
       {
           if let strTime = time
           {
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "hh:mm a"
               
               let tempDate = dateFormatter.date(from: strTime)
               dateFormatter.dateFormat = "HH:mm"
               
               let time = dateFormatter.string(from: tempDate!)
               return dateFormatter.date(from: time)
           }
           
           return nil
       }
       
       /**Converts 24 hrs formate date to 12 hrs format string*/
       private func timeConverter_twelve(time : Date) -> String
       {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "hh:mm a"
           
           return dateFormatter.string(from: time)
       }
    
    
    //MARK:- tableView Delegates

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == addNewPopoverTableView {

            //Modified by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
            //GATHER0000606 -- Start
            if self.isMultiSelectClicked
            {
                return self.appDelegate.addRequestOpt_Dining_MultiSelect.count
                //return self.appDelegate.arrRegisterMultiMemberType.count
            }
            
            if(self.eventDetails[0].registrationFor == "Members Only") &&  (self.eventDetails[0].guest == 0)
            {
                return self.appDelegate.MB_Dining_RegisterMemberType_MemberOnly.count
               // return self.appDelegate.arrEventRegTypeMemberOnly.count
            }
            else
            {
                return self.appDelegate.addRequestOpt_Dining.count
                //return self.appDelegate.arrEventRegType.count
            }
            //GATHER0000606 -- End
        }
        else if tableView == modifyTableView{
            return arrTotalList.count
        }
        else if tableView == self.instructionsTableView
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
            cell.textLabel?.font = SFont.SourceSansPro_Regular18
            //Modified by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
            //GATHER0000606 -- Start
            if self.isMultiSelectClicked
            {
                cell.textLabel?.text = self.appDelegate.addRequestOpt_Dining_MultiSelect[indexPath.row].name
                //cell.textLabel?.text = self.appDelegate.arrRegisterMultiMemberType[indexPath.row].name
            }
            else
            {
                if(self.eventDetails[0].registrationFor == "Members Only") && (self.eventDetails[0].guest == 0)
                {
                    cell.textLabel?.text = self.appDelegate.MB_Dining_RegisterMemberType_MemberOnly[indexPath.row].name
                    //cell.textLabel?.text = self.appDelegate.arrEventRegTypeMemberOnly[indexPath.row].name
                }
                else
                {
                    cell.textLabel?.text = self.appDelegate.addRequestOpt_Dining[indexPath.row].name
                    //cell.textLabel?.text = self.appDelegate.arrEventRegType[indexPath.row].name
                }
            }
            //GATHER0000606 -- End
            
            
            cell.textLabel?.font =  SFont.SourceSansPro_Semibold18
            cell.textLabel?.textColor = hexStringToUIColor(hex: "64575A")
            tableView.separatorStyle = .none
            
            if indexPath.row < (tableView.numberOfRows(inSection: indexPath.section) - 1)
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
//        else if tableView == modifyTableView {
//            print(self.arrRegisterDetails[0].guestList?.count as Any)
//            if let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyCell", for: indexPath) as? ModifyRegCustomCell {
//
//                cell.delegate = self
//
//                if arrEventPlayers[indexPath.row] is MemberInfo {
//                    let memberObj = arrEventPlayers[indexPath.row] as! MemberInfo
//                    cell.lblname.text = memberObj.memberName
//                    cell.lblID.text = memberObj.memberID
//                    if memberObj.memberName == nil{
//                        cell.lblname.text = memberObj.guestName
//                        cell.lblID.text = self.appDelegate.masterLabeling.gUEST
//                    }
//
//                } else if arrEventPlayers[indexPath.row] is GuestInfo {
//                    let guestObj = arrEventPlayers[indexPath.row] as! GuestInfo
//                    cell.lblname.text = guestObj.guestName
//                    cell.lblID.text = self.appDelegate.masterLabeling.gUEST
//
//                } else {
//
//                }
//
//
//                self.view.setNeedsLayout()
//
//                return cell
//            }
//            return UITableViewCell()
//        }
//
//        else{
//            if let cell = tableView.dequeueReusableCell(withIdentifier: "RegCell", for: indexPath) as? CustomNewRegCell {
//
//
//                cell.viewSearchField.layer.cornerRadius = 6
//                cell.viewSearchField.layer.borderWidth = 0.25
//                cell.viewSearchField.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
//
//                cell.delegate = self
//
//
//                cell.txtSearchField.placeholder = String(format: "%@ %d", self.appDelegate.masterLabeling.person ?? "", indexPath.row + 2)
//
//                if arrEventPlayers[indexPath.row] is MemberInfo {
//                    let memberObj = arrEventPlayers[indexPath.row] as! MemberInfo
//
//                    if memberObj.buddyType?.lowercased() == "guest"{
//                        cell.txtSearchField.text = memberObj.guestName
//
//                    }else{
//                        cell.txtSearchField.text = String(format: "%@, %@", memberObj.lastName!, memberObj.firstName!)
//                    }
//                } else if arrEventPlayers[indexPath.row] is GuestInfo {
//                    let guestObj = arrEventPlayers[indexPath.row] as! GuestInfo
//                    cell.txtSearchField.text = guestObj.guestName
//                } else {
//                    cell.txtSearchField.text = ""
//                }
//                self.view.setNeedsLayout()
//
//                return cell
//            }
//            return UITableViewCell()
//        }
//
//
//
//    }

        else if (tableView == modifyTableView){
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyCell", for: indexPath) as? ModifyRegCustomCell {
                cell.delegate = self as? ModifyRegistration
                cell.lblname.textColor  = hexStringToUIColor(hex: "40B2E6")
                
                if eventType == 2{
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
                    cell.lblname.text = String(format: "%@", memberObj.memberName!)
                    cell.lblID.text = memberObj.memberID
                }
                else if arrTotalList[indexPath.row] is GuestInfo {
                    let guestObj = arrTotalList[indexPath.row] as! GuestInfo
                    cell.lblname.text = guestObj.guestName
                    //Added by kiran V2.8 -- ENGAGE0011784 --
                    //ENGAGE0011784 -- Start
                    let memberDetails = CustomFunctions.shared.memberType(details: guestObj, For: .diningEvents)
                    
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
                  if  arrTotalList[indexPath.row] is GroupDetail {
                        let playObj = arrTotalList[indexPath.row] as! GroupDetail
                        
                        self.lblMemberName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,playObj.name! )
                    if playObj.name! == "" {
                        self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,playObj.guestName!)
                    }
                        
                    }
                   else if arrTotalList[0] is CaptaineInfo {
                        let memberObj = arrTotalList[0] as! CaptaineInfo
                        self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.captainName!)
                        
                        
                    } else if arrTotalList[0] is DiningMemberInfo {
                        let memberObj = arrTotalList[0] as! DiningMemberInfo
                        self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.name ?? "")
                        
                    }
                    else if arrTotalList[0] is GuestInfo {
                        let guestObj = arrTotalList[0] as! GuestInfo
                        self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.guestName!)
                        
                        
                    } else {
                        self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
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
        else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "RegCell", for: indexPath) as? CustomNewRegCell {
//                cell.delegateDining = self
                cell.delegate = self
                
//                if self.partyTableview.isHidden == true {
//                }else{
//
                
                    if arrTotalList[indexPath.row] is CaptaineInfo {
                        let memberObj = arrTotalList[indexPath.row] as! CaptaineInfo
                        cell.txtSearchField.text = String(format: "%@", memberObj.captainName!)
                    }else if arrTotalList[indexPath.row] is MemberInfo {
                        let memberObj = arrTotalList[indexPath.row] as! MemberInfo
                        cell.txtSearchField.text = String(format: "%@", memberObj.memberName!)
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
                    
                    cell.txtSearchField.placeholder = String(format: "%@ %d", self.appDelegate.masterLabeling.rESERVATION ?? "", indexPath.row + 1)
                    
//                }
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
            var selectedOption = ""
            
            if self.isMultiSelectClicked
            {
                selectedOption = self.appDelegate.addRequestOpt_Dining_MultiSelect[indexPath.row].Id ?? ""
            }
            else if(self.eventDetails[0].registrationFor == "Members Only") &&  (self.eventDetails[0].guest == 0)
            {
                selectedOption = self.appDelegate.MB_Dining_RegisterMemberType_MemberOnly[indexPath.row].Id ?? ""
            }
            else
            {
                selectedOption = self.appDelegate.addRequestOpt_Dining[indexPath.row].Id ?? ""
            }
            //GATHER0000606 -- End
            
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
//                    memberDirectory.isFrom = "Registration"
//                    memberDirectory.delegate = self
                    
                    memberDirectory.isFrom = "Registration"
                    
                    memberDirectory.isOnlyFor = "DiningRequest"
                    memberDirectory.delegate = self
                    memberDirectory.forDiningEvent = "DiningEvent"
                    memberDirectory.categoryForBuddy = self.eventCategory
                    
                    memberDirectory.requestID = self.requestID
                    memberDirectory.eventID = eventID
                    memberDirectory.selectedDate = dinigRequestDate
                    memberDirectory.showSegmentController = true
                    memberDirectory.selectedTime = self.txtTime.text
                    //Added on 9th OCtober 2020 V2.3
                    memberDirectory.preferedSpaceDetailId = self.preferredDetailID
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
            //else if /*indexPath.row == 1*/cell?.textLabel?.text ?? "" == "Guest"
            
            {
                
                if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddGuestRegVC") as? AddGuestRegVC {
                    regGuest.memberDelegate = self
                    selectedCellText = cell?.textLabel?.text

                    //Added by kiran V2.8 -- ENGAGE0011784 -- Hiding the existing guest feature and showing guest dob and gender fields
                    //ENGAGE0011784 -- Start
                    //Commented as this is replaced with usedForModule variable.
                    //regGuest.isOnlyFor = "Dining"
                    
                    regGuest.screenType = .add
                    regGuest.usedForModule = .diningEvents
                    regGuest.showExistingGuestsOption = true
                    regGuest.isDOBHidden = false
                    regGuest.isGenderHidden = false
                    regGuest.enableGuestNameSuggestions = true
                    regGuest.hideAddtoBuddy = false
                    regGuest.hideExistingGuestAddToBuddy = false
                    regGuest.requestDates = [self.dinigRequestDate ?? ""]
                    regGuest.requestTime = self.dinigRequestTime ?? ""
                    regGuest.preferedSpaceDetailId = self.preferredDetailID ?? ""
                    regGuest.requestID = self.requestID ?? ""
                    regGuest.eventID = self.eventID ?? ""
                    regGuest.arrAddedMembers = [self.arrTotalList]
                    
                    //ENGAGE0011784 -- End

                    navigationController?.pushViewController(regGuest, animated: true)
                }
                
                //Old logic
                /*
                if(self.eventDetails[0].registrationFor == "Members Only") && (self.eventDetails[0].guest == 0){
                    
                    if let memberDirectory = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MemberDirectoryViewController") as? MemberDirectoryViewController {
                        selectedCellText = cell?.textLabel?.text
                        memberDirectory.categoryForBuddy = self.eventCategory
                        memberDirectory.registerType = "Event"
                        memberDirectory.isFrom = "BuddyList"
                        memberDirectory.isOnlyFor = "DiningRequest"
                        memberDirectory.forDiningEvent = "DiningEvent"
                        
                        memberDirectory.eventID = eventID
                        memberDirectory.requestID = self.requestID
                        memberDirectory.selectedDate = dinigRequestDate
                        memberDirectory.showSegmentController = true
                        memberDirectory.delegate = self
                        memberDirectory.selectedTime = self.txtTime.text
                        //FIXME:-  This case should not occuers.DIdnt implement code for ths scenario
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
                else{
                    if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddGuestRegVC") as? AddGuestRegVC {
                        regGuest.memberDelegate = self
                        selectedCellText = cell?.textLabel?.text
                        regGuest.isOnlyFor = "Dining"

                        navigationController?.pushViewController(regGuest, animated: true)
                    }
                    
                    
                }
                 */
                
                //GATHER0000606 -- End
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
                    
//                    memberDirectory.isFrom = "BuddyList"
                    memberDirectory.categoryForBuddy = self.eventCategory
                    memberDirectory.isFrom = "BuddyList"
                    memberDirectory.isOnlyFor = "DiningRequest"
                    memberDirectory.forDiningEvent = "DiningEvent"
                    
                    memberDirectory.eventID = eventID
                    memberDirectory.requestID = self.requestID
                    memberDirectory.selectedDate = dinigRequestDate
                    memberDirectory.showSegmentController = true
                    //This is used to remove guests from buddy list. this is passed to Action value
                    memberDirectory.registerType = ((self.eventDetails[0].registrationFor == "Members Only") &&  (self.eventDetails[0].guest == 0)) ? "Event" : ""
                    //memberDirectory.registerType = "Event"
                    memberDirectory.delegate = self
                    memberDirectory.selectedTime = self.txtTime.text
                    
                    //Added on 9th OCtober 2020 V2.3
                    memberDirectory.preferedSpaceDetailId = self.preferredDetailID
                    
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
        else if (tableView == modifyTableView){
            ModifyCellIndex = indexPath.row
            ModifyGuestCellIndex = indexPath.row
            
            if arrTotalList[indexPath.row] is GroupDetail
            {
                //Added by kiran V2.8 -- ENGAGE0011784 --
                //ENGAGE0011784 -- Start
                let playObj = arrTotalList[indexPath.row] as! GroupDetail
                
                let memberType : MemberType = CustomFunctions.shared.memberType(details: playObj, For: .diningEvents)
                
                if memberType == .guest || memberType == .existingGuest
                {
                    if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddGuestRegVC") as? AddGuestRegVC {
                        regGuest.arrTotalList = [arrTotalList[indexPath.row]]
                        regGuest.memberDelegate = self
                        regGuest.arrSpecialOccasion = (self.eventDetails[0].requestDiningDetails?[0].diningDetails?[indexPath.row].specialOccasion)!
//                        regGuest.forDiningEvent = "DiningEvent"

                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        //Commented as these are replaced with screentype and usedForModule.
//                        regGuest.isOnlyFor = "Dining"
//                        regGuest.isFrom = "Modify"
                        
                       
                        regGuest.usedForModule = .diningEvents
                        
                        regGuest.requestDates = [self.dinigRequestDate ?? ""]
                        regGuest.requestTime = self.dinigRequestTime ?? ""
                        regGuest.preferedSpaceDetailId = self.preferredDetailID ?? ""
                        regGuest.requestID = self.requestID ?? ""
                        regGuest.eventID = self.eventID ?? ""
                        regGuest.isDOBHidden = false
                        regGuest.isGenderHidden = false
                        
                        if isFrom == "View" || eventType == 2
                        {
                            //commented as this is replaced with screenType.
                            //regGuest.isView = "Yes"
                            regGuest.screenType = .view
                        }
                        else
                        {
                            //commented as this is replaced with screenType.
                            //regGuest.isView = ""
                            regGuest.screenType = .modify
                        }
                        
                        //Old logic
                        /*
                        if isFrom == "View" || eventType == 2{
                            regGuest.isView = "Yes"
                        }else{
                            regGuest.isView = ""
                        }*/
                        
                        //ENGAGE0011784 -- End
                        navigationController?.pushViewController(regGuest, animated: true)
                    }

                }
                else if memberType == .member
                {
                    if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddMemberVC") as? AddMemberVC {
                        regGuest.arrTotalList = [arrTotalList[indexPath.row]]
                        if isFrom == "View" || eventType == 2{
                            regGuest.isFrom = "View"
                        }else{
                            regGuest.isFrom = "Modify"
                        }
                        regGuest.forDiningEvent = "DiningEvent"

                        regGuest.arrSpecialOccasion = (self.eventDetails[0].requestDiningDetails?[0].diningDetails?[indexPath.row].specialOccasion)!
                        
                        regGuest.delegateAddMember = self
                        navigationController?.pushViewController(regGuest, animated: true)
                    }

                }
                //ENGAGE0011784 -- End
            }
            else if arrTotalList[indexPath.row] is DiningMemberInfo
            {
                if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddMemberVC") as? AddMemberVC {
                    regGuest.arrTotalList = [arrTotalList[indexPath.row]]
                    if isFrom == "View" || eventType == 2{
                        regGuest.isFrom = "View"
                    }else{
                        regGuest.isFrom = "Modify"
                    }
                    regGuest.forDiningEvent = "DiningEvent"

                    // regGuest.arrSpecialOccasion = (self.arrTeeTimeDetails[0].diningDetails?[indexPath.row].specialOccasion)!
                    
                    regGuest.delegateAddMember = self
                    navigationController?.pushViewController(regGuest, animated: true)
                }
                
            }
                
            else if arrTotalList[indexPath.row] is GuestInfo {
                if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddGuestRegVC") as? AddGuestRegVC {
                    regGuest.arrTotalList = [arrTotalList[indexPath.row]]
                    
                    //  regGuest.arrSpecialOccasion = (self.arrTeeTimeDetails[0].diningDetails?[indexPath.row].specialOccasion)!
                    
                    regGuest.memberDelegate = self
                    
                    //Added by kiran V2.8 -- ENGAGE0011784 --
                    //ENGAGE0011784 -- Start
                    //Commented as these are replaces with screenType and usedForModule
//                    regGuest.isOnlyFor = "Dining"
//                    regGuest.isFrom = "Modify"
                    
                    
                    regGuest.usedForModule = .diningEvents
                    
                    regGuest.requestDates = [self.dinigRequestDate ?? ""]
                    regGuest.requestTime = self.dinigRequestTime ?? ""
                    regGuest.preferedSpaceDetailId = self.preferredDetailID ?? ""
                    regGuest.requestID = self.requestID ?? ""
                    regGuest.eventID = self.eventID ?? ""
                    regGuest.isDOBHidden = false
                    regGuest.isGenderHidden = false
                    
                    if isFrom == "View" || eventType == 2
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
                    if isFrom == "View" || eventType == 2{
                        regGuest.isView = "Yes"
                    }else{
                        regGuest.isView = ""
                    }*/
                    //ENGAGE0011784 -- End
                    navigationController?.pushViewController(regGuest, animated: true)
                }
            }
            
            
        }
        else if tableView == self.instructionsTableView
        {
            
        }
        else
        {
            
        }
        
    }

}

//MARK:- View only funcitionality related functions
extension DiningEventRegistrationVC
{
    /// Disables all the actions except save/ submit/register. that button will act as back button
    private func shouldDisableAllActions(_ bool : Bool)
    {
        self.txtTime.isUserInteractionEnabled = !bool
        self.txtEarlierThan.isUserInteractionEnabled = !bool
        self.txtLaterThan.isUserInteractionEnabled = !bool
        self.btnDecreaseTickets.isUserInteractionEnabled = !bool
        self.btnIncreaseTicket.isUserInteractionEnabled = !bool
        self.modifyTableView.isUserInteractionEnabled = !bool
        self.registrationTableview.isUserInteractionEnabled = !bool
        self.txtComments.isUserInteractionEnabled = !bool
        self.btnModifyAdd.isUserInteractionEnabled = !bool
        self.btnMultiSelect.isUserInteractionEnabled = !bool
        self.btnCancelReservation.isHidden = bool
        self.bottomViewHeight.constant = bool ? 120 : 156
        //Added on 12th October 2020 V2.3
        self.txtViewRemainder.isUserInteractionEnabled = !bool
        
    }
    
}

//MARK:- Validation API
extension DiningEventRegistrationVC
{
    //Added by kiran V2.5 -- ENGAGE0011300 -- Member validation is not shown for dining event
    //ENGAGE0011300 -- Start
    func memberValidationAPI(_ success : @escaping ((Bool) -> Void))
    {
        
        if (Network.reachability?.isReachable) == true
        {
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            //Members details sent to the server.
            var memberList = [[String : Any]]()
            //Members Selected for the request.
            let selectedMembers = (eventType == 1) ? self.arrTotalList : self.arrTotalList.filter({$0.isEmpty == false})
            
            let specialOccassion:[String: Any] = [
                "Birthday":0,
                "Anniversary":0,
                "Other":0,
                "OtherText":""
            ]
            
            
            for (index,member) in selectedMembers.enumerated()
            {
                if member is CaptaineInfo
                {
                    let playObj = member as! CaptaineInfo
                    
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
                        "DisplayOrder": index + 1,
                        "AddBuddy": 0
                    ]
                    
                    memberList.append(memberInfo)
                    
                }
                else if member is DiningMemberInfo
                {
                    let playObj = member as! DiningMemberInfo
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
                        "DisplayOrder": index + 1,
                        "AddBuddy": 0
                    ]
                    memberList.append(memberInfo)
                }
                else if member is GuestInfo
                {
                    let playObj = member as! GuestInfo
                    
                    let specialOccassionInfo:[String: Any] = [
                        "Birthday": playObj.birthDay ?? 0,
                        "Anniversary": playObj.anniversary ?? 0,
                        "Other": playObj.other ?? 0,
                        "OtherText": playObj.otherText ?? ""
                    ]
                    
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
                        "DisplayOrder": index + 1,
                        "AddBuddy": playObj.addToMyBuddy ?? 0,
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                        APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                        APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                        APIKeys.kGuestGender : playObj.guestGender ?? ""
                        //ENGAGE0011784 -- End
                    ]
                    memberList.append(memberInfo)
                }
                else if member is GroupDetail
                {
                    let playObj = member as! GroupDetail
                    //Added by kiran V2.8 -- ENGAGE0011784 -- Added support for existing guest.
                    //ENGAGE0011784 -- Start
                    let memberType = CustomFunctions.shared.memberType(details: playObj, For: .diningEvents)
                    
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
                            "DisplayOrder": index + 1,
                            "AddBuddy": playObj.addBuddy ?? 0,
                            //Added by kiran V2.8 -- ENGAGE0011784 --
                            //ENGAGE0011784 -- Start
                            APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                            APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                            APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                            APIKeys.kGuestGender : playObj.guestGender ?? ""
                            //ENGAGE0011784 -- End
                        ]
                        memberList.append(memberInfo)
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
                            "DisplayOrder": index + 1,
                            "AddBuddy": playObj.addBuddy ?? 0
                        ]
                        //TODO:- Reome after approval
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
                            "DisplayOrder": index + 1,
                            "AddBuddy": playObj.addBuddy ?? 0,
                            APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                            APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                            APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                            APIKeys.kGuestGender : playObj.guestGender ?? ""
                        ]
                         */
                        memberList.append(memberInfo)
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
                            "DisplayOrder": index + 1,
                            "AddBuddy": 0
                        ]
                        memberList.append(memberInfo)
                    }
                    
                    //ENGAGE0011784 -- End
                }
            }
            
            for i in 0 ..< memberList.count
            {
                if memberList.count > arrRegReqID.count
                {
                    arrRegReqID.append("")
                }
                if arrRegReqID.count == 0
                {
                    
                }
                else
                {
                    memberList[i].updateValue(arrRegReqID[i], forKey: "ReservationRequestDetailId")
                }
            }

            let paramaterDict : [String : Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "RequestId": self.requestID ?? "",
                "ReservationRequestDate": self.dinigRequestDate ?? "",
                "ReservationRequestTime": self.dinigRequestTime ?? "",
                "PartySize": self.arrTempPlayers.count,
                "Earliest": self.earliarThanTime ?? "",
                "Latest": self.laterThanTime ?? "",
                "Comments": self.txtComments.text ?? "",
                "PreferedSpaceDetailId": self.preferredDetailID ?? "" ,
                "DiningDetails" : memberList,
                "IsReservation": "0",
                "IsEvent": "1",
                "ReservationType": "Dining",
                "RegistrationID": self.requestID ?? "",
                "EventID": self.eventID ?? ""
            ]
            
            APIHandler.sharedInstance.getMemberValidation(paramater: paramaterDict, onSuccess: { (response) in
                
                self.appDelegate.hideIndicator()
                
                if response.details?.count == 0
                {
                    SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                    
                     success(false)
                }
                else
                {
                    if response.responseCode == InternetMessge.kSuccess
                    {
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
                        
                        success(false)
                    }
                    
                }
                
            }) { (error) in
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
                self.appDelegate.hideIndicator()
            }

        }
                
    }
    //ENGAGE0011300 -- End

}

extension DiningEventRegistrationVC
{
    //Added by kiran V2.5 -- GATHER0000606 -- Logic which indicates if add member button should be displayed or not
    //GATHER0000606 -- Start
    ///Indicates if add member button should be shown. only applicable for single member add not multi select
    private func shouldHideMemberAddOptions() -> Bool
    {
        var membersArray = [BWOption]()
        
        if(self.eventDetails.first?.registrationFor == "Members Only") &&  (self.eventDetails.first?.guest == 0)
        {
            membersArray = self.appDelegate.MB_Dining_RegisterMemberType_MemberOnly
        }
        else
        {
            membersArray = self.appDelegate.addRequestOpt_Dining
        }
        
        return !(membersArray.count > 0)
    }
    //GATHER0000606 -- End
}

//Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
//PROD0000069 -- Start
extension DiningEventRegistrationVC : CancelPopUpViewControllerDelegate
{
    func didCancel(status: Bool)
    {
        if status, let navFrom = self.navigatedFrom
        {
            self.delegate?.diningEventSuccessPopupClosed()
            for vc in self.navigationController!.viewControllers
            {
                switch navFrom
                {
                case .clubNews:
                    if vc is AllClubNewsViewController
                    {
                        self.navigationController?.popToViewController(vc, animated: true)
                        break
                    }
                case .dashboard:
                    if vc is DashBoardViewController
                    {
                        self.navigationController?.popToViewController(vc, animated: true)
                        break
                    }
                case .golf:
                    if vc is TeeTimesViewController
                    {
                        self.navigationController?.popToViewController(vc, animated: true)
                        break
                    }
                case .tennis:
                    if vc is CourtTimesViewController
                    {
                        self.navigationController?.popToViewController(vc, animated: true)
                        break
                    }
                case .dining:
                    if vc is DiningReservationViewController
                    {
                        self.navigationController?.popToViewController(vc, animated: true)
                        break
                    }
                case .fitnessSpa:
                    if vc is SpaAndFitnessViewController
                    {
                        self.navigationController?.popToViewController(vc, animated: true)
                        break
                    }
                }
            }
        }
    }
}
//PROD0000069 -- End
