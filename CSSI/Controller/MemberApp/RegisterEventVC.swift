//
//  RegisterEventVC.swift
//  CSSI
//  Created by apple on 2/26/19.
//  Copyright © 2019 yujdesigns. All rights reserved.

import UIKit
import Popover

//Added by kiran V1.3 -- PROD0000069 --
//PROD0000069 -- Start
protocol RegisterEventVCDelegate : NSObject {
    func eventSuccessPopupClosed()
}
//PROD0000069 -- End

class RegisterEventVC: UIViewController, RegistrationCell, ModifyRegistration, MemberViewControllerDelegate, guestViewControllerDelegate, closeUpdateSuccesPopup,AddGuestChildren {
   
    //Modified by kiran V1.3 -- PROD0000069 -- formatted the function
    //PROD0000069 -- Start
    func closeUpdateSuccessView()
    {
        self.delegate?.eventSuccessPopupClosed()
        self.dismiss(animated: true, completion: nil)
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for popToViewController in viewControllers
        {
            if self.appDelegate.closeFrom == "Calendar" || self.appDelegate.closeFrom == "Cancel"  || self.appDelegate.closeFrom == "Buddy"
            {
                if popToViewController is GolfCalendarVC
                {
                    //Modified by kiran -- ENGAGE0011177 -- V2.5 -- commented as its causing black bar issue on nav bar.
                    //self.navigationController?.navigationBar.isHidden = false
                    self.navigationController!.popToViewController(popToViewController, animated: true)
                }
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
                else
                {
                    self.navigationController!.popViewController(animated: true)
                    break
                }
            }
            
        }
        
    }
    //PROD0000069 -- End
    
    func ModifyThreeDotsClicked(cell: ModifyRegCustomCell) {
        
    }
    
    func threeDotsClickedToMoveGroup(cell: CustomNewRegCell) {
        
    }
  
    @IBOutlet weak var viewBase: UIView!
//    @IBOutlet weak var viewCountHeight: NSLayoutConstraint!
//    @IBOutlet weak var guestCountheight: NSLayoutConstraint!
//    @IBOutlet weak var guestModifyHeight: NSLayoutConstraint!
//    @IBOutlet weak var guestkidsHeight: NSLayoutConstraint!
//    @IBOutlet weak var kidsHeight: NSLayoutConstraint!
//    @IBOutlet weak var heightForMemberOlny: NSLayoutConstraint!
    @IBOutlet weak var lblMembersCount: UILabel!
    @IBOutlet weak var lblGuestCount: UILabel!
    @IBOutlet weak var lblKids3BelowCount: UILabel!
    @IBOutlet weak var lblKids3AboveCount: UILabel!
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
    //Modified on 28th Spetmeber 2020 V2.3
    //Repalced remainder label with text view to make links clickable.
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
    
    @IBOutlet weak var lblBottomText: UILabel!
    @IBOutlet weak var txtModifyInput: UITextField!
    @IBOutlet weak var btnModifyAdd: UIButton!
    @IBOutlet weak var btnCancelReservation: UIButton!
    @IBOutlet weak var baseViewForModifyNew: UIView!
    
    @IBOutlet weak var viewMemberCount: UIView!
    @IBOutlet weak var viewGuestCount: UIView!
    @IBOutlet weak var viewKids3BelowCount: UIView!
    @IBOutlet weak var viewKids3AboveCount: UIView!
    
    @IBOutlet weak var tblInstructions: SelfSizingTableView!
    @IBOutlet weak var tblInstructionsHeight: NSLayoutConstraint!
    //Added by kiran V1.4 -- PROD0000069 -- Support to request events from club news on click of news
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
    var selectedIndex : Int?
    var arrRegisterDetails = [RegisteredDetail]()
    var arrTotalList = [MemberInfo]()
    var arrMembers = [MemberInfo]()
    var arrBuddyList = [MemberInfo]()
    var duplicate = MemberInfo()
    
    var arrEventPlayers = [RequestData]()
    var selectedPlayerIndex : Int?
    var arrTemp = [RequestData]()

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
    var segmentIndex: Int?
    var eventRegistrationDetailID : String?

    var totalMembersCount: Int = 1
    var totoalGuestCount : Int = 0
    var totalKids3belowCount: Int = 0
    var totalKids3aboveCount: Int = 0
    var hideAddButton: Bool?
    var isInclude: Int?
    var isFor: String?
    var enterToGuestScreen: Int?

    private var arrInstructions = [Instruction]()
    
    var eventFor : EventType = .none
    
    ///When True disables the tap actions
    ///
    /// Note: This will just disbale the user interactions and hides cancel and submit buttons and adds back button.everything else will work based on the other variables passed while initializing this controller.
    var isViewOnly = false
    
    private var numberOfTickets : Int = 0
    
    //Added on 4th July 2020 V2.2
    private let accessManager = AccessManager.shared
    
    //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
    //PROD0000069 -- Start
    weak var delegate : RegisterEventVCDelegate?
    var navigatedFrom : EventNavigatedFrom?
    //PROD0000069 -- End
    
    //Added by kiran V1.4 -- PROD0000069 -- Support to request events from club news on click of news
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
        switch self.accessManager.accessPermision(for: .calendarOfEvents) {
        case .view:
            if !self.isViewOnly , let message = self.appDelegate.masterLabeling.role_Validation2 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            break
        default:
            break
        }
        
        
        self.tblInstructions.delegate = self
        self.tblInstructions.dataSource = self
        self.tblInstructions.allowsSelection = false
        self.tblInstructions.estimatedRowHeight = 40
        self.tblInstructions.rowHeight = UITableViewAutomaticDimension
        self.tblInstructions.backgroundColor = .clear
        self.tblInstructions.separatorStyle = .none
        self.tblInstructions.register(UINib.init(nibName: "InstructionsTableViewCell", bundle: nil), forCellReuseIdentifier: "InstructionsTableViewCell")
        self.getEventDetails()
        // Do any additional setup after loading the view.
        
        self.txtViewRemainder.text = ""
        self.txtViewRemainder.isHidden = true
        
        lblAdditionalEventDetails.text =  self.appDelegate.masterLabeling.additionalEventDetails
        lblKids3AboveCount.text = self.appDelegate.masterLabeling.kIDS3ABOVECOUNT
        lblKids3BelowCount.text = self.appDelegate.masterLabeling.kIDS3BELOWCOUNT
        lblGuestCount.text = self.appDelegate.masterLabeling.gUESTCOUNT
        
        lblComments.text =  self.appDelegate.masterLabeling.comments
        lblTickets.text =  self.appDelegate.masterLabeling.tickets
        lblMemberName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,UserDefaults.standard.string(forKey: UserDefaultsKeys.captainName.rawValue)!)
        self.lblAdditionalEventDetails.text = self.appDelegate.masterLabeling.additionalEventDetails
        
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
        self.hideAddButton = false
        if eventType == 1 {
            viewModify.isHidden = false
            self.modifyTableView.isHidden = false
            registrationTableview.isHidden = true
            btnRequest .setTitle(self.appDelegate.masterLabeling.sAVE, for: UIControlState.normal)
            btnCancelReservation.isHidden = false
            self.cancelReservationHeight.constant = 37
            btnCancelReservation .setTitle(self.appDelegate.masterLabeling.cancel_reservation, for: UIControlState.normal)
            viewComments.backgroundColor = hexStringToUIColor(hex: "F5F5F5")
        }
        else{
            viewModify.isHidden = true
            self.modifyTableView.isHidden = true

            registrationTableview.isHidden = false
            btnRequest .setTitle(self.appDelegate.masterLabeling.rEQUEST, for: UIControlState.normal)
            btnCancelReservation.isHidden = true
            self.cancelReservationHeight.constant = 0

            viewComments.backgroundColor = UIColor.white
            
            let captainInfo = CaptaineInfo.init()
            captainInfo.setCaptainDetails(id: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "", name: String(format: "%@",  UserDefaults.standard.string(forKey: UserDefaultsKeys.captainName.rawValue)!), firstName: UserDefaults.standard.string(forKey: UserDefaultsKeys.firstName.rawValue) ?? "", order: 1, memberID: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "", parentID: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "", profilePic: UserDefaults.standard.string(forKey: UserDefaultsKeys.userProfilepic.rawValue) ?? "")
            
            self.arrEventPlayers.append(RequestData())
            
            let selectedObject = captainInfo
            selectedObject.isEmpty = false
            self.arrEventPlayers.remove(at: 0)
            self.arrEventPlayers.insert(selectedObject, at: 0)
            
           
        }
        arrNewRegList.append("")
        
        self.lblBottomText.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)
        
        
        if self.isViewOnly
        {
            self.shouldDisableAllActions(true)
            self.btnRequest.setTitle(self.appDelegate.masterLabeling.bACK, for: .normal)
        }
   
        //Modified by kiran V2.5 -- GATHER0000606 -- Hiding add button when member selection option is empty
        //GATHER0000606 -- Start
        if self.eventType == 1
        {
            self.btnModifyAdd.isHidden = self.shouldHideMemberAddOptions()
        }
        
        //GATHER0000606 -- End
        
        //Added by kiran V1.4 -- PROD0000069 -- Support to request events from club news on click of news/calender of events flyer click and Added support to show status of the event.
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
    
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
         self.tblInstructionsHeight.constant = self.tblInstructions.contentSize.height
               if( eventType == 1) {
                //self.heightDetails.constant = 227 + txtViewRemainder.frame.height + self.tblInstructionsHeight.constant + self.lblEventMonthDay.frame.height + self.lblEventTime.frame.height - 44 /* removing the height of lblEventTime and lblEventMOnthDay previously added from 227*/
            self.modifyTableviewHeight.constant = modifyTableView.contentSize.height

            self.viewModifyheight.constant = 87 + modifyTableviewHeight.constant
            self.tableviewHeight.constant = 0
            
            self.middleViewHeight.constant = 56 + self.viewModifyheight.constant
            if self.eventDetails.count == 0 {}else{
            if (self.eventDetails[0].registrationFor == "Members Only" &&  self.eventDetails[0].guest == 0  && self.eventDetails[0].kids3Above == 0  && self.eventDetails[0].isSpouse == 1) || self.eventDetails[0].isTgaEvent == 1{
            //    self.heightForMemberOlny.constant = 10
                self.mainViewHeight.constant = 750 + self.middleViewHeight.constant + txtViewRemainder.frame.height + self.tblInstructionsHeight.constant

            }else{
              //  self.heightForMemberOlny.constant = 186
                self.mainViewHeight.constant = 906 + self.middleViewHeight.constant + txtViewRemainder.frame.height + self.tblInstructionsHeight.constant
                }}
                
                //Added by kiran V1.3 -- PROD0000069 -- adjusting the height according to showing or hiding the status
                //PROD0000069 -- Start
                self.mainViewHeight.constant += self.showStatus ? self.viewStatus.frame.height : 0
                //PROD0000069 -- End
            self.uiScrollview.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height:  self.mainViewHeight.constant)
        }
        else{
           
            //self.heightDetails.constant = 227 + txtViewRemainder.frame.height + self.tblInstructionsHeight.constant + self.lblEventMonthDay.frame.height + self.lblEventTime.frame.height - 44 /* removing the height of lblEventTime and lblEventMOnthDay previously added from 227*/
            tableviewHeight.constant = registrationTableview.contentSize.height
            self.viewModifyheight.constant = 0
            self.middleViewHeight.constant = 76 + tableviewHeight.constant
            if self.eventDetails.count == 0 {}else{
            if (self.eventDetails[0].registrationFor == "Members Only" &&  self.eventDetails[0].guest == 0  && self.eventDetails[0].kids3Above == 0  && self.eventDetails[0].isSpouse == 1) || self.eventDetails[0].isTgaEvent == 1{
               // self.heightForMemberOlny.constant = 10
                self.mainViewHeight.constant = 750 + self.middleViewHeight.constant + txtViewRemainder.frame.height + self.tblInstructionsHeight.constant
                
            }else{
              //  self.heightForMemberOlny.constant = 186
                self.mainViewHeight.constant = 906 + self.middleViewHeight.constant + txtViewRemainder.frame.height + self.tblInstructionsHeight.constant
                }}
            
            //Added by kiran V1.3 -- PROD0000069 -- adjusting the height according to showing or hiding the status
            //PROD0000069 -- Start
            self.mainViewHeight.constant += self.showStatus ? self.viewStatus.frame.height : 0
            //PROD0000069 -- End
            self.uiScrollview.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height:  self.mainViewHeight.constant)

        }

    }
    
    
    func dynamicGuestAndKidsValues(){
        
        //Uncomment if the labels has to be hidden/shown based on their ticket count
        
        
        /*if totoalGuestCount == 0 && totalKids3aboveCount == 0 && totalKids3belowCount == 0{
//            self.guestCountheight.constant = 0
//            self.guestModifyHeight.constant = 0
//            self.kidsHeight.constant = 0
//            self.guestkidsHeight.constant = 0
//
//            self.viewCountHeight.constant = 127
            self.viewMemberCount.isHidden = false
            self.viewGuestCount.isHidden = true
            
            self.viewKids3AboveCount.isHidden = true
            
            self.viewKids3BelowCount.isHidden = true
            
        }else if totoalGuestCount  > 0 && totalKids3aboveCount == 0 && totalKids3belowCount == 0{
            
//            self.viewCountHeight.constant = 171
//            self.guestCountheight.constant = 24
//            self.guestModifyHeight.constant = 20

            self.viewMemberCount.isHidden = false
            self.viewGuestCount.isHidden = false
            self.viewKids3AboveCount.isHidden = true
            self.viewKids3BelowCount.isHidden = true
            
        }else if totoalGuestCount > 0 && totalKids3aboveCount > 0 && totalKids3belowCount == 0{
            
//            self.kidsHeight.constant = 0
//            self.guestkidsHeight.constant = 0
//            self.guestCountheight.constant = 24
//            self.guestModifyHeight.constant = 20

//            self.viewCountHeight.constant = 215
            self.viewMemberCount.isHidden = false
            self.viewGuestCount.isHidden = false
            self.viewKids3AboveCount.isHidden = false
            self.viewKids3BelowCount.isHidden = true
            
        }else if totoalGuestCount > 0 && totalKids3aboveCount > 0 && totalKids3belowCount > 0{
            
//            self.guestCountheight.constant = 24
//            self.guestModifyHeight.constant = 20
//            self.kidsHeight.constant = 24
//            self.guestkidsHeight.constant = 20
//
//            self.viewCountHeight.constant = 259
            self.viewMemberCount.isHidden = false
            self.viewGuestCount.isHidden = false
            self.viewKids3AboveCount.isHidden = false
            self.viewKids3BelowCount.isHidden = false
            
        }else if totoalGuestCount > 0 && totalKids3aboveCount == 0 && totalKids3belowCount > 0{
//            self.guestCountheight.constant = 24
//            self.guestModifyHeight.constant = 20
//            self.kidsHeight.constant = 24
//            self.guestkidsHeight.constant = 20
//            self.viewCountHeight.constant = 215
            self.viewMemberCount.isHidden = false
            self.viewGuestCount.isHidden = false
            self.viewKids3AboveCount.isHidden = true
            self.viewKids3BelowCount.isHidden = false
            
        }else if totoalGuestCount == 0 && totalKids3aboveCount > 0 && totalKids3belowCount == 0{
//            self.guestCountheight.constant = 0
//            self.guestModifyHeight.constant = 0
//            self.kidsHeight.constant = 0
//            self.guestkidsHeight.constant = 0
//
//            self.viewCountHeight.constant = 171
            self.viewMemberCount.isHidden = false
            self.viewGuestCount.isHidden = true
            self.viewKids3AboveCount.isHidden = false
            self.viewKids3BelowCount.isHidden = true
        }else if totoalGuestCount == 0 && totalKids3aboveCount > 0 && totalKids3belowCount > 0{
//            self.guestCountheight.constant = 0
//            self.guestModifyHeight.constant = 0
//            self.kidsHeight.constant = 24
//            self.guestkidsHeight.constant = 20
//
//            self.viewCountHeight.constant = 215
            self.viewMemberCount.isHidden = false
            self.viewGuestCount.isHidden = true
            self.viewKids3AboveCount.isHidden = false
            self.viewKids3BelowCount.isHidden = false
        }else if totoalGuestCount == 0 && totalKids3aboveCount == 0 && totalKids3belowCount > 0{
//            self.guestCountheight.constant = 0
//            self.guestModifyHeight.constant = 0
//            self.kidsHeight.constant = 24
//            self.guestkidsHeight.constant = 20
//
//            self.viewCountHeight.constant = 171
            self.viewMemberCount.isHidden = false
            self.viewGuestCount.isHidden = true
            self.viewKids3AboveCount.isHidden = true
            self.viewKids3BelowCount.isHidden = false
        }*/
        
        
        if totoalGuestCount > 0
        {
            self.viewGuestCount.isHidden = false
        }
        
        if totalKids3aboveCount > 0
        {
            self.viewKids3AboveCount.isHidden = false
        }
        
        if totalKids3belowCount > 0
        {
            self.viewKids3BelowCount.isHidden = false
        }
        
//        self.viewKids3AboveCount.isHidden = false
//        self.viewKids3BelowCount.isHidden = false
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
        
        let indexPath = self.registrationTableview.indexPath(for: cell)
        
        selectedIndex = indexPath?.row
        selectedPlayerIndex = indexPath?.row
        
        let addNewView : UIView!

//        if(self.eventDetails[0].registrationFor == "Members Only"){
            addNewView = UIView(frame: CGRect(x: 100, y: 0, width: 180, height: 98))

            addNewPopoverTableView = UITableView(frame: CGRect(x: 0, y: 5, width: 180, height: 98))
//        }
//        else{
//            addNewView = UIView(frame: CGRect(x: 100, y: 0, width: 180, height: 146))
//
//            addNewPopoverTableView = UITableView(frame: CGRect(x: 0, y: 5, width: 180, height: 146))
//
//        }
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
    
    func AddGuestChildren(selecteArray: [RequestData]) {
        
        if(eventType == 1) && selectedPlayerIndex == -1{
            let selectedObject = selecteArray[0]
            selectedObject.isEmpty = false
            arrEventPlayers.append(selectedObject)
            
            self.view.setNeedsLayout()
            
        }else{
        let selectedObject = selecteArray[0]
        selectedObject.isEmpty = false
        arrEventPlayers.remove(at: selectedPlayerIndex ?? 0)
        arrEventPlayers.insert(selectedObject, at: selectedPlayerIndex ?? 0)
        }
        
        //Commented on 26th June 2020 V2.2
        //Sets the first member in the array as captain
        /*
        if(selectedPlayerIndex == 0){
           
             if arrEventPlayers[0] is GuestChildren {
                let guestObj = arrEventPlayers[0] as! GuestChildren
                self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.name!)
            }
        }
         */
        self.updateAddAction()
        
    }
    func updateAddAction(){
        totoalGuestCount = 0
        totalKids3aboveCount = 0
        totalKids3belowCount = 0
        totalMembersCount = 0
        
        for i in 0 ..< arrEventPlayers.count {
            if arrEventPlayers[i] is GuestChildren{
                let playObj = arrEventPlayers[i] as! GuestChildren
                if playObj.isInclude == 1{
                totalMembersCount = totalMembersCount + 1
                }
                totoalGuestCount = playObj.guestCount! + totoalGuestCount
                totalKids3aboveCount = playObj.kids3Above! + totalKids3aboveCount
                totalKids3belowCount = playObj.kids3Below! + totalKids3belowCount
            }else if arrEventPlayers[i] is MemberInfo{
                let playObj = arrEventPlayers[i] as! MemberInfo
                if playObj.isInclude == 1{
                    totalMembersCount = totalMembersCount + 1
                }
                totoalGuestCount = playObj.guest! + totoalGuestCount
                totalKids3aboveCount = playObj.kids3Above! + totalKids3aboveCount
                totalKids3belowCount = playObj.kids3Below! + totalKids3belowCount
            }
            else  if arrEventPlayers[i] is CaptaineInfo{
                totalMembersCount = totalMembersCount + 1
                
            }
        }
         if (self.eventDetails[0].registrationFor == "Members Only") {
           
                self.dynamicGuestAndKidsValues()
            
        }
        
        self.lblGuestCount.text = String(format: "%@ %02d",self.appDelegate.masterLabeling.gUESTCOUNT ?? "", totoalGuestCount)
        self.lblKids3AboveCount.text = String(format: "%@ %02d", self.appDelegate.masterLabeling.kIDS3ABOVECOUNT ?? "",totalKids3aboveCount)
        self.lblKids3BelowCount.text = String(format: "%@ %02d",self.appDelegate.masterLabeling.kIDS3BELOWCOUNT ?? "", totalKids3belowCount)
        self.lblMembersCount.text = String(format: "%@ %02d",self.appDelegate.masterLabeling.mEMBERCOUNT ?? "", totalMembersCount)

        arrTemp.removeAll()
        arrTemp = arrEventPlayers
        arrTemp =  arrTemp.filter({$0.isEmpty == false})
        
        if arrEventPlayers.count <= totalMembersCount + totoalGuestCount + totalKids3belowCount + totalKids3aboveCount {
            self.hideAddButton = true
            
        }else{
            self.hideAddButton = false
        }
        if arrNewRegList.count <= totalMembersCount + totoalGuestCount + totalKids3belowCount + totalKids3aboveCount {
            self.btnModifyAdd.isEnabled = false
            
        }else{
            self.btnModifyAdd.isEnabled = true
        }
        self.registrationTableview.reloadData()
        self.modifyTableView.reloadData()
    }
    
    func ModifyClicked(cell: ModifyRegCustomCell) {
        self.btnModifyAdd.isEnabled = true

        let indexPath = self.modifyTableView.indexPath(for: cell)
        selectedPlayerIndex = indexPath?.row
        arrEventPlayers.remove(at: selectedPlayerIndex!)
        if self.eventDetails[0].isTgaEvent == 1{
        }else{
         self.updateAddAction()
        }
        //Commented on 26th June 2020 V2.2
        /*
        if arrEventPlayers.count == 0 {
            self.lblMemberName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
        }*/
        modifyTableView.reloadData()
        self.view.setNeedsLayout()

    }
    
    func clearButtonClicked(cell: CustomNewRegCell) {
        let indexPath = self.registrationTableview.indexPath(for: cell)
        selectedPlayerIndex = indexPath?.row
        selectedIndex = indexPath?.row
        arrEventPlayers.remove(at: selectedPlayerIndex!)
        arrEventPlayers.insert(RequestData(), at: selectedPlayerIndex!)
        
        if self.eventDetails[0].isTgaEvent == 1{
        }else{
            self.updateAddAction()
        }
        
        //Commented on 26th June 2020 V2.2
        /*
        if(selectedIndex == 0){
            if arrEventPlayers[0] is GuestChildren {
                let guestObj = arrEventPlayers[0] as! GuestChildren
                self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,guestObj.name!)
                
                
            } else {
                self.lblMemberName.text =  String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,"")
            }
        }*/
        
        self.registrationTableview.reloadData()

        
    }
    
    func editClicked(cell: CustomNewRegCell)
    {
        
        let indexPath = self.registrationTableview.indexPath(for: cell)
        selectedPlayerIndex = indexPath?.row

        if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "GuestOrChildrenVC") as? GuestOrChildrenVC {
           
            
            if  arrEventPlayers[selectedPlayerIndex!] is CaptaineInfo ||  arrEventPlayers[selectedPlayerIndex!] is GuestChildren{
                if  arrEventPlayers[selectedPlayerIndex!] is GuestChildren{
                    let playObj = arrEventPlayers[selectedPlayerIndex!] as! GuestChildren
                    regGuest.totalNumberofTickets = ((arrEventPlayers.count - totalMembersCount) - (totoalGuestCount + totalKids3aboveCount + totalKids3belowCount)) + 1 + playObj.guestCount! + playObj.kids3Below! + playObj.kids3Above!
                    if self.eventDetails[0].guest == 0 {
                    regGuest.isSpousePresent = playObj.isSpouse
                    }
                    

                }else{
                    regGuest.totalNumberofTickets = ((arrEventPlayers.count - totalMembersCount) - (totoalGuestCount + totalKids3aboveCount + totalKids3belowCount)) + 1
                }
                if  arrEventPlayers[selectedPlayerIndex!] is CaptaineInfo{
                    regGuest.isSpousePresent = self.eventDetails[0].isSpouse
                }
            }else{
                if self.eventDetails[0].guest == 0 {
                    regGuest.isSpousePresent = self.eventDetails[0].isSpouse
                }
                regGuest.totalNumberofTickets = (arrEventPlayers.count - totalMembersCount) - (totoalGuestCount + totalKids3aboveCount + totalKids3belowCount)
            }
            regGuest.arrModifyData = [self.arrEventPlayers[(indexPath?.row)!]]
            regGuest.showGuest = self.eventDetails[0].guest
            regGuest.eventID = self.eventID
            regGuest.requestID = self.arrRegisterDetails[0].eventRegistrationID ?? ""

            regGuest.showKids = self.eventDetails[0].kids3Above
            regGuest.eventRegId = self.arrRegisterDetails[0].eventRegistrationID ?? ""

            regGuest.delegateGuestChildren = self
            navigationController?.pushViewController(regGuest, animated: true)
        }
    }
    
    func memberViewControllerResponse(selecteArray: [MemberInfo]) {
        
        if (eventType == 1){
            if (selectedCellText == "Member"){
                arrMembers.append(selecteArray[0])
            }
            else{
                arrBuddyList.append(selecteArray[0])
            }
            arrTotalList.append(selecteArray[0])
            self.modifyTableView.reloadData()

        }
        else{
        
        if arrTotalList.count == selectedIndex!{
            
            arrTotalList.append(selecteArray[0])
            if (selectedCellText == "Member"){
            arrMembers.append(selecteArray[0])
            }
            else{
            arrBuddyList.append(selecteArray[0])

            }
        }
        else{
            if arrTotalList.count < selectedIndex!{
                arrTotalList.append(selecteArray[0])
                if (selectedCellText == "Member"){
                    arrMembers.append(selecteArray[0])
                }
                else{
                    arrBuddyList.append(selecteArray[0])
                    
                }
            }
            else{
            
            if(arrBuddyList.contains(arrTotalList[selectedIndex!])){
                
            arrBuddyList.remove(at: arrBuddyList.index{$0 === arrTotalList[selectedIndex!]}!)
                if (selectedCellText == "Member"){
                    arrMembers.append(selecteArray[0])
                }
                else{
                    arrBuddyList.append(selecteArray[0])
                }
            }
            else if (arrMembers.contains(arrTotalList[selectedIndex!])){
                
                arrMembers.remove(at: arrMembers.index{$0 === arrTotalList[selectedIndex!]}!)

                if (selectedCellText == "Member"){
                    arrMembers.append(selecteArray[0])
                    
                }
                else{
                    arrBuddyList.append(selecteArray[0])
                    
                }
            }
            else{
                
                arrGuest.remove(at: 0)
                
                if (selectedCellText == "Member"){
                    arrMembers.append(selecteArray[0])
                    
                }
                else if (selectedCellText == "My Buddies"){
                    arrBuddyList.append(selecteArray[0])
                    
                }
                else{
                    
                }
                
            }
            arrTotalList[selectedIndex!] = selecteArray[0]
            }}
        self.registrationTableview.reloadData()
        }
       
    }
    
    func buddiesViewControllerResponse(selectedBuddy: [MemberInfo]) {
        

    }
    
    func guestViewControllerResponse(guestName: String) {
        
        if (eventType == 1){
            arrTotalList.append(duplicate)
            arrGuest.append(guestName)
            guestNameToDisplay = guestName
            self.modifyTableView.reloadData()

        }
        else{
        
        if arrTotalList.count == selectedIndex!{

            arrTotalList.append(duplicate)
            arrGuest.append(guestName)
            guestNameToDisplay = guestName

        }
        else{
            
            if arrTotalList.count < selectedIndex!{
                arrTotalList.append(duplicate)
                arrGuest.append(guestName)
                guestNameToDisplay = guestName
            }
            else{
            if(arrBuddyList.contains(arrTotalList[selectedIndex!])){
                
                arrBuddyList.remove(at: arrBuddyList.index{$0 === arrTotalList[selectedIndex!]}!)
            }
            else if (arrMembers.contains(arrTotalList[selectedIndex!])){
                
                arrMembers.remove(at: arrMembers.index{$0 === arrTotalList[selectedIndex!]}!)
            }
            else{
            }
            arrGuest.append(guestName)
            guestNameToDisplay = guestName

            arrTotalList[selectedIndex!] = duplicate

            
            }}
            self.registrationTableview.reloadData()

        }
    }
    
    func requestMemberViewControllerResponse(selecteArray: [RequestData])
    {
        
        if(eventType == 1){
            let selectedObject = selecteArray[0]
            selectedObject.isEmpty = false
            arrEventPlayers.append(selectedObject)
            
            self.modifyTableView.reloadData()
            self.view.setNeedsLayout()
            
        }
        else{
            let selectedObject = selecteArray[0]
            selectedObject.isEmpty = false
            arrEventPlayers.remove(at: selectedPlayerIndex!)
            arrEventPlayers.insert(selectedObject, at: selectedPlayerIndex!)

            self.registrationTableview.reloadData()
        }
        
    }
    
    //MARK:- Get Event Details Api

    func getEventDetails(){
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
                "EventRegistrationDetailID": eventRegistrationDetailID ?? ""

            ]
            print(paramaterDict)
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.getEventDetails(paramater: paramaterDict , onSuccess: { response in
                self.appDelegate.hideIndicator()
                if(response.responseCode == InternetMessge.kSuccess){
                    
                    self.eventDetails = [response]
                    let placeHolderImage = UIImage(named: "Icon-App-40x40")
                    self.imgEvent.image = placeHolderImage
                    self.arrRegisterDetails = response.registeredDetails!
                    
                    self.arrEventPlayers.append(contentsOf: response.registeredDetails![0].memberList!)
                    self.arrEventPlayers.append(contentsOf: response.registeredDetails![0].guestListModify!)
                    self.arrEventPlayers.append(contentsOf: response.registeredDetails![0].buddyList!)

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
                    
                    if response.isModify == 0 {
                        let alertController = UIAlertController(title: "", message: response.isModifyText, preferredStyle: .alert)
                        
                        // Create the actions
                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
                            UIAlertAction in

                           self.viewBase.isUserInteractionEnabled = false
                            
                        }
                       
                        // Add the actions
                        alertController.addAction(okAction)
                        
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                    self.lblTitle.text = response.eventName
                    self.lblEventVenue.text = response.eventVenue
                    self.lblEventMonthDay.text = response.eventDate
                    self.lblEventTime.text = response.eventTime
                    
                    //Modified on 28th September 2020 v2.3
                    //self.txtViewRemainder.text = response.additionalDetails
                    
                    let additionalDetailsAttrString : NSMutableAttributedString = NSMutableAttributedString.init(attributedString: response.additionalDetails?.generateAttributedString(isHtml: true) ?? NSAttributedString.init(string: ""))

                    let font : UIFont = UIFont.init(name: "SourceSansPro-Regular", size: 17.0)!
                    let fontColor : UIColor = hexStringToUIColor(hex: "#695B5E")
                    
                    additionalDetailsAttrString.addAttributes([.foregroundColor : fontColor , .font : font], range: NSMakeRange(0, additionalDetailsAttrString.length))
                    
                    self.txtViewRemainder.attributedText = additionalDetailsAttrString
                    
                    self.txtComments.text = response.registeredDetails![0].comments
                    //Hides or shows The lblreminder
                    
                    self.txtViewRemainder.isHidden = (self.txtViewRemainder.text == nil || self.txtViewRemainder.text == "")
                    
                    if response.eventDateTime![0].eventToTime == "" {
                        self.lblEventTime.text = response.eventDateTime![0].eventFromTime ?? ""
                    }else if response.eventDateTime![0].eventFromTime == "" {
                        self.lblEventTime.text = response.eventDateTime![0].eventToTime ?? ""
                    }else if response.eventDateTime![0].eventFromTime == "" &&  response.eventDateTime![0].eventToTime == ""{
                        self.lblEventTime.text = ""
                    }else{
                    self.lblEventTime.text = String(format: "%@ - %@", response.eventDateTime![0].eventFromTime!, response.eventDateTime![0].eventToTime!)
                    }

                    self.lblEventMonthDay.text = response.eventDate
                    self.lblNumberOfTickets.text = String(format: "%02d", 1)
                    self.btnDecreaseTickets.isEnabled = false

                    //Event type 1 is for modify. This is a locally used value not fetched from server.
                    if self.eventType == 1
                    {
                       self.btnDecreaseTickets.isEnabled = true

                        self.lblNumberOfTickets.text = String(format: "%02d", response.registeredDetails![0].noofTickets ?? 1)
                        
                        self.arrMembers = response.registeredDetails![0].memberList!
                        self.arrBuddyList = response.registeredDetails![0].buddyList!
                        self.guestList = response.registeredDetails![0].guestList!
                        self.newGuestList = response.registeredDetails![0].guestListModify!
                        self.arrTotalList.append(contentsOf: response.registeredDetails![0].memberList!)
                        self.arrTotalList.append(contentsOf: response.registeredDetails![0].guestListModify!)
                        self.arrTotalList.append(contentsOf: response.registeredDetails![0].buddyList!)
                        if (response.registeredDetails![0].noofTickets == 0){
                             self.arrNewRegList.append(contentsOf: repeatElement("", count: response.registeredDetails![0].noofTickets!))
    
                        }
                        else{
                        self.arrNewRegList.append(contentsOf: repeatElement("", count: response.registeredDetails![0].noofTickets! - 1))
                        }
                        
                        if let numberOfTickets = response.registeredDetails![0].noofTickets
                        {
                            self.numberOfTickets = numberOfTickets
                        }
                         
                        
                        if self.arrTotalList.count == 0{
                            self.btnDecreaseTickets.isEnabled = false

                        }
                        
                        
                        self.lblGuestCount.text = String(format: "%@ %02d",self.appDelegate.masterLabeling.gUESTCOUNT ?? "", response.registeredDetails![0].guestCount ?? 0)
                        self.lblKids3AboveCount.text = String(format: "%@ %02d", self.appDelegate.masterLabeling.kIDS3ABOVECOUNT ?? "",response.registeredDetails![0].kidsaboveCount ?? 0)
                        self.lblKids3BelowCount.text = String(format: "%@ %02d",self.appDelegate.masterLabeling.kIDS3BELOWCOUNT ?? "", response.registeredDetails![0].kids3belowCount ?? 0)
                        self.lblMembersCount.text = String(format: "%@ %02d",self.appDelegate.masterLabeling.mEMBERCOUNT ?? "", response.registeredDetails![0].memberCount ?? 0)

                        
                        self.totoalGuestCount = response.registeredDetails![0].guestCount ?? 0
                        self.totalKids3aboveCount = response.registeredDetails![0].kidsaboveCount ?? 0
                        self.totalKids3belowCount = response.registeredDetails![0].kids3belowCount ?? 0
                        self.totalMembersCount = response.registeredDetails![0].memberCount ?? 0
                        if self.arrNewRegList.count <= self.totalMembersCount + self.totoalGuestCount + self.totalKids3aboveCount + self.totalKids3belowCount {
                            self.btnModifyAdd.isEnabled = false
                            
                        }else{
                            self.btnModifyAdd.isEnabled = true
                        }
                        
                        self.modifyTableView.reloadData()

                    }
                    else
                    {
                    
                        self.lblGuestCount.text = String(format: "%@ %02d",self.appDelegate.masterLabeling.gUESTCOUNT ?? "", 0)
                        self.lblKids3AboveCount.text = String(format: "%@ %02d", self.appDelegate.masterLabeling.kIDS3ABOVECOUNT ?? "",0)
                        self.lblKids3BelowCount.text = String(format: "%@ %02d",self.appDelegate.masterLabeling.kIDS3BELOWCOUNT ?? "", 0)
                        self.lblMembersCount.text = String(format: "%@ %02d",self.appDelegate.masterLabeling.mEMBERCOUNT ?? "", self.totalMembersCount)
                        
                        
                        //Added by kiran V2.7 -- ENGAGE0011683 -- Added minimum ticket count for events
                        //ENGAGE0011683 -- Start
                        //Minimum tickets allowed should always be 1 or more and it should always be sent in response. otherwise its a backend issue.
                        while (self.eventDetails[0].minTicketsAllowed ?? 0 > 0) && self.arrEventPlayers.count < self.eventDetails[0].minTicketsAllowed ?? 0
                        {
                            self.arrEventPlayers.append(RequestData())
                            self.arrNewRegList.append("")
                        }
                        self.lblNumberOfTickets.text = String.init(format: "%02d", self.arrEventPlayers.count)
                        //ENGAGE0011683 -- End
                        self.registrationTableview.reloadData()

                    }
                    

                    if self.eventDetails[0].isTgaEvent == 1{
                        
//                        self.guestCountheight.constant = 0
//                        self.guestModifyHeight.constant = 0
//                        self.kidsHeight.constant = 0
//                        self.guestkidsHeight.constant = 0
//
//                        self.viewCountHeight.constant = 127
                        self.viewMemberCount.isHidden = false
                        self.viewGuestCount.isHidden = true
                        self.viewKids3AboveCount.isHidden = true
                        self.viewKids3BelowCount.isHidden = true
                        self.isFor = "OnlyMembers"
                        self.btnIncreaseTicket.isEnabled = false
                        
                    }else if (self.eventDetails[0].registrationFor == "Members Only" &&  self.eventDetails[0].guest == 0  && self.eventDetails[0].kids3Above == 0){
                        
//                        self.guestCountheight.constant = 0
//                        self.guestModifyHeight.constant = 0
//                        self.kidsHeight.constant = 0
//                        self.guestkidsHeight.constant = 0
//
//                        self.viewCountHeight.constant = 127
                        self.viewMemberCount.isHidden = false
                        self.viewGuestCount.isHidden = true
                        self.viewKids3AboveCount.isHidden = true
                        self.viewKids3BelowCount.isHidden = true
                        
                        self.isFor = "Members&Guest"
                        
                    }else if (self.eventDetails[0].registrationFor == "Members Only" &&  self.eventDetails[0].guest == 1  && self.eventDetails[0].kids3Above == 0){
                        
//                        self.kidsHeight.constant = 0
//                        self.guestkidsHeight.constant = 0
//
//                        self.viewCountHeight.constant = 171
                        
                        self.viewMemberCount.isHidden = false
                        self.viewGuestCount.isHidden = false
                        self.viewKids3AboveCount.isHidden = true
                        self.viewKids3BelowCount.isHidden = true
                        self.isFor = "Members&Guest"
                        
                    }else if (self.eventDetails[0].registrationFor == "Members Only" &&  self.eventDetails[0].guest == 0  && self.eventDetails[0].kids3Above == 1){
                        
//                        self.guestCountheight.constant = 0
//                        self.guestModifyHeight.constant = 0
//                        self.viewCountHeight.constant = 215
                        
                        self.viewMemberCount.isHidden = false
                        self.viewGuestCount.isHidden = true
                        self.viewKids3AboveCount.isHidden = false
                        self.viewKids3BelowCount.isHidden = false
                        self.isFor = "Members&Guest"
                        
                    }else{
                        self.viewMemberCount.isHidden = false
                        self.viewGuestCount.isHidden = false
                        self.viewKids3AboveCount.isHidden = false
                        self.viewKids3BelowCount.isHidden = false
                        self.isFor = "Members&Guest"
                    }
                    
                    //Guest only
                    if self.eventDetails[0].registrationFor == "Members Only" && self.eventDetails[0].guest == 1 && self.eventDetails[0].kids3Above == 0 && self.eventDetails[0].kids3Below == 0
                    {
                        self.eventFor = .member_Guest
                        self.arrInstructions = self.appDelegate.EventGuestInstruction
                        
                    }//KIds Only
                    else if self.eventDetails[0].registrationFor == "Members Only" && (self.eventDetails[0].kids3Below == 1 && self.eventDetails[0].kids3Above == 1) && self.eventDetails[0].guest == 0
                    {
                        self.eventFor = .member_Kid
                        self.arrInstructions = self.appDelegate.EventKidInstruction
                        
                    }//Guests and kids
                    else if self.eventDetails[0].registrationFor == "Members Only" && (self.eventDetails[0].kids3Below == 1 && self.eventDetails[0].kids3Above == 1) && self.eventDetails[0].guest == 1
                    {
                        self.eventFor = .member_Kid_Guest
                        self.arrInstructions = self.appDelegate.EventGuestKidInstruction
                        
                    }
                    else
                    {
                        self.eventFor = .member_Only
                        self.arrInstructions = self.appDelegate.MemberOnlyEventInstruction
                    }
                    
                    self.tblInstructions.reloadData()
                    
                    if self.eventType == 1 {
                        //Uncomment if you need label hide/show based on ticket count
                       // self.dynamicGuestAndKidsValues()
                    }else{
                        
                        
                    }
                    //Kids count hide/Show
                                       
                    if self.eventDetails[0].guest == 0
                    {
                        self.viewGuestCount.isHidden = true
                    }
                    else
                    {
                        self.viewGuestCount.isHidden = false
                    }
                    
                    if self.eventDetails[0].kids3Above == 0
                    {
                        self.viewKids3AboveCount.isHidden = true
                    }
                    else
                    {
                        self.viewKids3AboveCount.isHidden = false
                    }
                    
                    if self.eventDetails[0].kids3Below == 0
                    {
                        self.viewKids3BelowCount.isHidden = true
                    }
                    else
                    {
                        self.viewKids3BelowCount.isHidden = false
                        
                    }
                    
                    if response.registeredDetails?[0].guestCount ?? 0 > 0
                    {
                        self.viewGuestCount.isHidden = false
                    }
                    
                    if response.registeredDetails?[0].kidsaboveCount ?? 0 > 0
                    {
                        self.viewKids3AboveCount.isHidden = false
                    }
                    
                    if response.registeredDetails?[0].kids3belowCount ?? 0 > 0
                    {
                        self.viewKids3BelowCount.isHidden = false
                    }
                    
                    
                    if response.IsCancelEventAllowed == 0
                    {
                        self.btnCancelReservation.isHidden = true
                        self.cancelReservationHeight.constant = 0
                    }
                    
                    //Scheduler event
                    if response.isScheduleEvent == 1
                    {
                        self.lblEventTime.text = nil
                        self.lblEventTime.sizeToFit()
                    }
                    
                    self.txtViewRemainder .sizeToFit()
                    
                   
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
    
    @IBAction func requestClicked(_ sender: Any) {
        
        if self.isViewOnly
        {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        //Added on 4th July 2020 V2.2
        //added roles and privilages changes
        //since not allowed is handled before coming to this screen not need to check for it.
        switch self.accessManager.accessPermision(for: .calendarOfEvents) {
        case .view:
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        default:
            break
        }
        
        
        buddyArrayList.removeAll()
        memberArrayList.removeAll()
        guestArrayList.removeAll()
        
        //Added by kiran V2.8 -- ENGAGE0011745 -- Fixed the app crash issue beacuse of index out of range. casue when Clicking on add button after clicking submit and validation is fired.
        //ENGAGE0011745 -- Start
        var arrTempPlayers = [RequestData]()
        //ENGAGE0011745 -- End
        //Event type 1 is modify
        if eventType == 1
        {
            
            //Added by kiran V2.8 -- ENGAGE0011745
            //ENGAGE0011745 -- Start
            arrTempPlayers = self.arrEventPlayers
            //ENGAGE0011745 -- End
        }
        else
        {
            //Added by kiran V2.8 -- ENGAGE0011745 -- Fixed the app crash issue beacuse of index out of range. casue when Clicking on add button after clicking submit and validation is fired.
            //ENGAGE0011745 -- Start
            arrTempPlayers = self.arrEventPlayers.filter({$0.isEmpty == false})
            //arrEventPlayers = arrEventPlayers.filter({$0.isEmpty == false})
            //ENGAGE0011745 -- End
        }
        
        if (Network.reachability?.isReachable) == true
        {
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            //Added by kiran V2.8 -- ENGAGE0011745 -- Replacing arrEventPlayers arr with arrTempPlayers.
            //ENGAGE0011745 -- Start
            
            for (index,player) in arrTempPlayers.enumerated()
            {
                
                if let playObj = player as? CaptaineInfo
                {
                    
                    let memberInfo:[String: Any] = [
                        APIKeys.kMemberId : playObj.captainMemberID ?? "",
                        APIKeys.kid : playObj.captainID ?? "",
                        APIKeys.kParentId : playObj.captainParentID ?? "",
                        "MemberName" : playObj.captainName ?? "",
                        "Guest": 0,
                        "Kids3Below": 0,
                        "Kids3Above": 0,
                        "IsInclude": 1,
                        "IsPrimaryMember": 0,
                        "DisplayOrder": index + 1
                    ]
                    memberArrayList.append(memberInfo)
                    
                }
                else if let playObj = player as? GuestChildren
                {
                    
                    let memberInfo :[String: Any] = [
                        APIKeys.kMemberId : playObj.memberId ?? "",
                        APIKeys.kid : playObj.selectedID ?? "",
                        APIKeys.kParentId : playObj.parentID ?? "",
                        "MemberName" : playObj.name ?? "",
                        "Guest": playObj.guestCount ?? 0,
                        "Kids3Below": playObj.kids3Below ?? 0,
                        "Kids3Above": playObj.kids3Above ?? 0,
                        "IsInclude": playObj.isInclude ?? 1,
                        "IsPrimaryMember": 0,
                        "DisplayOrder": index + 1
                    ]
                    memberArrayList.append(memberInfo)
                }
                else if let playObj = player as? MemberInfo
                {
                    let memberInfo :[String: Any] = [
                        APIKeys.kMemberId : playObj.memberID ?? "",
                        APIKeys.kid : playObj.id ?? "",
                        APIKeys.kParentId : playObj.parentid ?? "",
                        "MemberName" : playObj.memberName ?? "",
                        "Guest": playObj.guest ?? 0,
                        "Kids3Below": playObj.kids3Below ?? 0,
                        "Kids3Above": playObj.kids3Above ?? 0,
                        "IsInclude": playObj.isInclude ?? 1,
                        "IsPrimaryMember": 0,
                        "DisplayOrder": index + 1
                    ]
                    memberArrayList.append(memberInfo)
                }
            }
            
            /*
            for i in 0 ..< arrEventPlayers.count {
                if  arrEventPlayers[i] is CaptaineInfo {
                    let playObj = arrEventPlayers[i] as! CaptaineInfo
                    let memberInfo:[String: Any] = [
                        APIKeys.kMemberId : playObj.captainMemberID ?? "",
                        APIKeys.kid : playObj.captainID ?? "",
                        APIKeys.kParentId : playObj.captainParentID ?? "",
                        "MemberName" : playObj.captainName ?? "",
                        "Guest": 0,
                        "Kids3Below": 0,
                        "Kids3Above": 0,
                        "IsInclude": 1,
                        "IsPrimaryMember": 0,
                        "DisplayOrder": i + 1
                    ]
                    memberArrayList.append(memberInfo)
                    
                }else if arrEventPlayers[i] is GuestChildren {
                    let playObj = arrEventPlayers[i] as! GuestChildren
                    
                    let memberInfo :[String: Any] = [
                        APIKeys.kMemberId : playObj.memberId ?? "",
                        APIKeys.kid : playObj.selectedID ?? "",
                        APIKeys.kParentId : playObj.parentID ?? "",
                        "MemberName" : playObj.name ?? "",
                        "Guest": playObj.guestCount ?? 0,
                        "Kids3Below": playObj.kids3Below ?? 0,
                        "Kids3Above": playObj.kids3Above ?? 0,
                        "IsInclude": playObj.isInclude ?? 1,
                        "IsPrimaryMember": 0,
                        "DisplayOrder": i + 1
                    ]
                    memberArrayList.append(memberInfo)
                }
                else if arrEventPlayers[i] is MemberInfo {
                    let playObj = arrEventPlayers[i] as! MemberInfo
                    let memberInfo :[String: Any] = [
                        APIKeys.kMemberId : playObj.memberID ?? "",
                        APIKeys.kid : playObj.id ?? "",
                        APIKeys.kParentId : playObj.parentid ?? "",
                        "MemberName" : playObj.memberName ?? "",
                        "Guest": playObj.guest ?? 0,
                        "Kids3Below": playObj.kids3Below ?? 0,
                        "Kids3Above": playObj.kids3Above ?? 0,
                        "IsInclude": playObj.isInclude ?? 1,
                        "IsPrimaryMember": 0,
                        "DisplayOrder": i + 1
                    ]
                    memberArrayList.append(memberInfo)
//                }else if playObj.buddyType == nil{
//                    let playObj = arrEventPlayers[i] as! MemberInfo
//
//                    let guestInfo:[String: Any] = [
//                        "GuestName" : playObj.guestName ?? ""
//                    ]
//                    guestArrayList.append(guestInfo)
//                }else if playObj.buddyType?.lowercased() == "guest"{
//                    let playObj = arrEventPlayers[i] as! MemberInfo
//
//                    let guestInfo:[String: Any] = [
//                        "GuestName" : playObj.guestName ?? ""
//                    ]
//                    guestArrayList.append(guestInfo)
//                }
//                else{
//                    let buddyInfo = [
//                        APIKeys.kMemberId : playObj.memberID ?? "",
//                        APIKeys.kid : playObj.id ?? "",
//                        APIKeys.kParentId : playObj.parentid ?? "",
//                        "MemberName" : playObj.memberName ?? ""
//                    ]
//                    buddyArrayList.append(buddyInfo)
//                }
           
                }
//                else if arrEventPlayers[i] is GuestInfo {
//                let playObj = arrEventPlayers[i] as! GuestInfo
//
//                let guestInfo:[String: Any] = [
//                    "GuestName" : playObj.guestName ?? ""
//                ]
//                guestArrayList.append(guestInfo)
//                }
            }*/
            //ENGAGE0011745 -- End

            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                "Role": UserDefaults.standard.string(forKey: UserDefaultsKeys.role.rawValue)!,
                "EventID": eventID ?? "",
                "Comments": txtComments.text ?? "",
                "NumberOfTickets": totalMembersCount + totoalGuestCount + totalKids3belowCount + totalKids3aboveCount,
                "EventRegistrationID": arrRegisterDetails[0].eventRegistrationID ?? "",
                "MemberList": memberArrayList,
                "BuddyList": [],
                "GuestList": [],
                "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue) ?? "",

                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            
           APIHandler.sharedInstance.saveEventRegistration(paramaterDict: paramaterDict, onSuccess: { memberLists in
                self.appDelegate.hideIndicator()

                if(memberLists.responseCode == InternetMessge.kSuccess)
                {
                    self.appDelegate.hideIndicator()
                    
                    if let succesView = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewSuccessUpdateView") as? NewSuccessUpdateView {
                        self.appDelegate.hideIndicator()
                        succesView.delegate = self
                        succesView.isFrom = "EventUpdate"
                        succesView.isFrom = self.isFrom
                        succesView.eventType = self.eventType
                        succesView.segmentIndex = self.segmentIndex
                        succesView.imgUrl = memberLists.imagePath ?? ""
                        if self.eventDetails[0].isTgaEvent == 1 && memberLists.responseMessage != ""{
                            succesView.isTGAEvent = 1
                            succesView.tgaMessage = memberLists.responseMessage
                        }
                        //Added by kiran V1.4 -- PROD0000148 -- Success mesage popup message change
                        //PROD0000148 -- Start
                        succesView.isFromModule = .events
                        succesView.successMessage = memberLists.responseMessage ?? ""
                        //PROD0000148 -- End
                        succesView.modalTransitionStyle   = .crossDissolve;
                        succesView.modalPresentationStyle = .overCurrentContext
                        self.present(succesView, animated: true, completion: nil)
                    }


                }else{
                    self.appDelegate.hideIndicator()
                    if(((memberLists.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: memberLists.responseMessage, withDuration: Duration.kMediumDuration)
                    }
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
        
        if (self.totalKids3belowCount + self.totalKids3aboveCount + self.totalMembersCount + totoalGuestCount) >= Int(self.lblNumberOfTickets.text ?? "")! {
            self.btnModifyAdd.isEnabled = false
        }else{
            self.btnModifyAdd.isEnabled = true
            let addNewView : UIView!
            
            addNewView = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 98))
            
            addNewPopoverTableView = UITableView(frame: CGRect(x: 0, y: 5, width: 180, height: 98))
            
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
            let point = self.btnModifyAdd.convert(self.btnModifyAdd.center , to: appDelegate.window)
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
        
//        }
        
       
    }
    @IBAction func clearClicked(_ sender: Any) {
        
        
    }
    @IBAction func cancelClicked(_ sender: Any) {
        
        //Added on 4th July 2020 V2.2
        //added roles and privilages changes
        //since not allowed is handled before coming to this screen not need to check for it.
        switch self.accessManager.accessPermision(for: .calendarOfEvents) {
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
            if self.isFrom == "RequestEvents"{
                cancelViewController.isFrom = "CancelEventFromReservation"
            
            }else{
                cancelViewController.isFrom = "CancelEvent"
            }
            cancelViewController.eventRegID = self.eventRegistrationDetailID
            cancelViewController.cancelFor = .Events
            cancelViewController.numberOfTickets = self.numberOfTickets == 0 ? "" : "\(self.numberOfTickets)"
            cancelViewController.eventID = self.eventID
            //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
            //PROD0000069 -- Start
            cancelViewController.delegate = self
            //PROD0000069 -- End
            self.navigationController?.pushViewController(cancelViewController, animated: true)
        }
        

    }
    
    @IBAction func increaseTicketsClicked(_ sender: Any)
    {
        
        if eventType == 1
        {
            if ("\(String(describing: arrNewRegList.count))" <= "\(String(describing: self.eventDetails[0].registeredDetails![0].noofTickets))")
            {
                if arrNewRegList.count == self.eventDetails[0].maxAllowedTickets
                {
                    btnIncreaseTicket.isEnabled = false
                }
                else
                {
                    btnDecreaseTickets.isEnabled = true
                    arrNewRegList.append("")
                    self.lblNumberOfTickets.text = String(format: "%02d", arrNewRegList.count)
                }
            }
            self.modifyTableView.isHidden = false
            self.registrationTableview.isHidden = true

        }
        else
        {
            self.hideAddButton = false
            self.modifyTableView.isHidden = true
            self.registrationTableview.isHidden = false
            
            if ("\(String(describing: arrNewRegList.count))" <= "\(String(describing: self.eventDetails[0].maxAllowedTickets))")
            {
                if arrNewRegList.count == self.eventDetails[0].maxAllowedTickets!
                {
                    btnIncreaseTicket.isEnabled = false
                    
                }
                else
                {
                    btnDecreaseTickets.isEnabled = true
                    arrNewRegList.append("")
                    self.lblNumberOfTickets.text = String(format: "%02d", arrNewRegList.count)
                    self.arrEventPlayers.append(RequestData())
                    
                }
                
            }
            
            if (self.eventDetails[0].registrationFor == "Members Only" &&  self.eventDetails[0].guest == 0  && self.eventDetails[0].kids3Above == 0)
            {
                self.updateAddAction()
            }else if self.eventDetails[0].isTgaEvent == 1
            {
                
            }
            else
            {
                
            }
            self.registrationTableview.reloadData()
            
        }

         self.btnModifyAdd.isEnabled = !(self.arrNewRegList.count <= self.totalMembersCount + self.totoalGuestCount + self.totalKids3aboveCount + self.totalKids3belowCount)//true
    }
    
    @IBAction func decreaseTicketsClicked(_ sender: Any)
    {

        if (eventType == 1)
        {
            if ("\(String(describing: arrNewRegList.count))" > "\(String(describing: 0))")
            {
                btnIncreaseTicket.isEnabled = true
                //Added by kiran V2.7 -- ENGAGE0011683 -- Added minimum ticket count. put default as 1 here as there will always be 1 minimum ticket count atleast.
                //ENGAGE0011683 -- Start
                if arrNewRegList.count == self.eventDetails[0].minTicketsAllowed ?? 1 /*1*/
                {//ENGAGE0011683 -- End
                    btnDecreaseTickets.isEnabled = false
                }
                else
                {
                    arrNewRegList.remove(at: 0)
                    //Added by kiran V2.7 -- ENGAGE0011683 -- Added minimum ticket count. put default as 1 here as there will always be 1 minimum ticket count atleast.
                    //ENGAGE0011683 -- Start
                    if arrNewRegList.count == self.eventDetails[0].minTicketsAllowed ?? 1 /*1*/
                    {//ENGAGE0011683 -- End
                        btnDecreaseTickets.isEnabled = false
                    }
                    
                }
                self.lblNumberOfTickets.text = String(format: "%02d", arrNewRegList.count)
                
            }

        }
        else
        {
            if ("\(String(describing: arrNewRegList.count))" > "\(String(describing: 0))")
            {
                btnIncreaseTicket.isEnabled = true
                //Added by kiran V2.7 -- ENGAGE0011683 -- Added minimum ticket count. put default as 1 here as there will always be 1 minimum ticket count atleast.
                //ENGAGE0011683 -- Start
                if(arrNewRegList.count == self.eventDetails[0].minTicketsAllowed ?? 1 /*1*/)
                {//ENGAGE0011683 -- End
                    btnDecreaseTickets.isEnabled = false
                    
                }
                else
                {
                    arrNewRegList.remove(at: 0)
                    self.arrEventPlayers.removeLast()
                    //Added by kiran V2.7 -- ENGAGE0011683 -- Added minimum ticket count. put default as 1 here as there will always be 1 minimum ticket count atleast.
                    //ENGAGE0011683 -- Start
                    if arrNewRegList.count == self.eventDetails[0].minTicketsAllowed ?? 1 /*1*/
                    {//ENGAGE0011683 -- End
                        btnDecreaseTickets.isEnabled = false
                        
                    }
                    
                }
                self.lblNumberOfTickets.text = String(format: "%02d", arrNewRegList.count)
                
                
                if(!(self.arrTotalList.count == 0))
                {
                    selectedIndex = nil
                    if(arrTotalList.count == arrNewRegList.count + 1)
                    {
                        if(arrBuddyList.contains(arrTotalList[arrTotalList.count - 1]))
                        {
                            arrBuddyList.remove(at: arrBuddyList.index{$0 === arrTotalList[arrTotalList.count - 1]}!)
                            
                        }
                        else if(arrMembers.contains(arrTotalList[arrTotalList.count - 1]))
                        {
                            arrMembers.remove(at: arrMembers.index{$0 === arrTotalList[arrTotalList.count - 1]}!)
                            
                        }
                        else
                        {
                            self.arrGuest.removeLast()
                            
                        }
                        
                        self.arrTotalList.removeLast()
                        
                    }
                    
                }
                
            }
            if (self.eventDetails[0].registrationFor == "Members Only" &&  self.eventDetails[0].guest == 0  && self.eventDetails[0].kids3Above == 0)
            {
                self.updateAddAction()
            }else if self.eventDetails[0].isTgaEvent == 1
            {
                
            }
            else
            {
                
            }
//            self.updateAddAction()
            self.registrationTableview.reloadData()
            
        }
        self.btnModifyAdd.isEnabled = !(self.arrNewRegList.count <= self.totalMembersCount + self.totoalGuestCount + self.totalKids3aboveCount + self.totalKids3belowCount)//true
        
    }
}
extension RegisterEventVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == addNewPopoverTableView {
            
//            if(self.eventDetails[0].registrationFor == "Members Only"){
            //Added by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
            //GATHER0000606 -- Start
            //return  self.appDelegate.arrEventRegTypeMemberOnly.count
            return self.appDelegate.addRequestOpt_Events.count
            //GATHER0000606 -- End

//            }
//            else{
//                return  self.appDelegate.arrEventRegType.count
//
//            }
            
        } else if tableView == modifyTableView{
            
//            if self.arrRegisterDetails.count == 0 {
//                return 0
//            }
//            else{
//                print("total count is\(self.arrTotalList.count)")
//
//                self.heightDetails.constant = 227 + txtViewRemainder.frame.height
//
//                if (arrTotalList.count == 0){
//                    modifyTableviewHeight.constant = 0
//
//                }
//                else if (arrTotalList.count <= 3){
//                    modifyTableviewHeight.constant = modifyTableView.contentSize.height + 20
//
//                }
//
//                else{
//                    if(isRemoveClicked == true){
//                        modifyTableviewHeight.constant = modifyTableView.contentSize.height + 20
//
//                    }
//                    else{
//
//                        modifyTableviewHeight.constant = modifyTableView.contentSize.height
//
//                        }
//
//                }
//                self.viewModifyheight.constant = 87 + modifyTableviewHeight.constant
//                self.tableviewHeight.constant = 0
//
//                self.middleViewHeight.constant = 56 + self.viewModifyheight.constant
//                self.mainViewHeight.constant = 806 + self.middleViewHeight.constant + txtViewRemainder.frame.height
//
//
//                self.uiScrollview.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height:  self.mainViewHeight.constant)
            
            //FIXME:- remove the temp fix and change the flow in next release i.e., V2.3
            //Added on 26th June 2020 V2.2
            if eventType == 1
            {
                self.updateCaptain(id: self.arrRegisterDetails.first?.requestedLinkedmemberID ?? "")
            }
            
            return self.arrEventPlayers.count
         
//            }
        
    }
    else if tableView == self.tblInstructions
    {
        return self.arrInstructions.count
    }
    else{
//            self.heightDetails.constant = 227 + txtViewRemainder.frame.height
//            if(arrNewRegList.count == 0){
//                tableviewHeight.constant = 10
//            }
//            else{
//                tableviewHeight.constant = registrationTableview.contentSize.height + 40
//
//            }
//            self.viewModifyheight.constant = 0
//            self.middleViewHeight.constant = 76 + tableviewHeight.constant
//            self.mainViewHeight.constant = 806 + self.middleViewHeight.constant + txtViewRemainder.frame.height
//            self.uiScrollview.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height:  self.mainViewHeight.constant)

            //FIXME:- remove the temp fix and change the flow in next release i.e., V2.3
            //Added on 26th June 2020 V2.2
            if eventType != 1
            {
                self.updateCaptain(id: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!)
            }
            
            return self.arrEventPlayers.count

        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == addNewPopoverTableView {
            
            let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 142, height: 34))
            cell.selectionStyle = .none
            cell.textLabel?.font = SFont.SourceSansPro_Regular18
            
//            if(self.eventDetails[0].registrationFor == "Members Only"){
            //Added by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
            //GATHER0000606 -- Start
            //cell.textLabel?.text = self.appDelegate.arrEventRegTypeMemberOnly[indexPath.row].name
            cell.textLabel?.text = self.appDelegate.addRequestOpt_Events[indexPath.row].name
            //GATHER0000606 -- End
//            }
//            else{
//                cell.textLabel?.text = self.appDelegate.arrEventRegType[indexPath.row].name
//
//            }
            
            cell.textLabel?.font =  SFont.SourceSansPro_Semibold18
            cell.textLabel?.textColor = hexStringToUIColor(hex: "64575A")
            tableView.separatorStyle = .none
            
            //Modified by kiran V2.5 -- GATHER0000606 -- Removing dotted line below the last option
            //GATHER0000606 -- Start
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
            //GATHER0000606 -- End
            return cell
        }
        else if tableView == modifyTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyCell", for: indexPath) as? ModifyRegCustomCell {
                
                cell.delegate = self
                cell.lblname.textColor  = hexStringToUIColor(hex: "40B2E6")

                
                if arrEventPlayers[indexPath.row] is MemberInfo {
                    let memberObj = arrEventPlayers[indexPath.row] as! MemberInfo
                    cell.lblname.text = memberObj.memberName
                    cell.lblID.text = memberObj.memberID
                    if memberObj.memberName == nil{
                        cell.lblname.text = memberObj.guestName
                        cell.lblID.text = self.appDelegate.masterLabeling.gUEST
                    }
                    if memberObj.isInclude == 0 {
                       cell.contentView.backgroundColor = UIColor.lightGray
                        cell.lblname.textColor  = hexStringToUIColor(hex: "40B2E6")
                    }else{
                        cell.contentView.backgroundColor = UIColor.white
                        cell.lblname.textColor  = hexStringToUIColor(hex: "40B2E6")
                    }

                }else if arrEventPlayers[indexPath.row] is GuestChildren{
                    
                    let guestOrChildrenObj = arrEventPlayers[indexPath.row] as! GuestChildren
                    cell.lblname.text = String(format: "%@", guestOrChildrenObj.name ?? "")
                    cell.lblID.text = guestOrChildrenObj.memberId
                    

                    if guestOrChildrenObj.isInclude == 0 {
                        cell.contentView.backgroundColor = UIColor.lightGray
                        cell.lblname.textColor  = hexStringToUIColor(hex: "40B2E6")
                    }else{
                        cell.contentView.backgroundColor = UIColor.white
                        cell.lblname.textColor  = hexStringToUIColor(hex: "40B2E6")
                    }
                    
                }
                else if arrEventPlayers[indexPath.row] is GuestInfo {
                    let guestObj = arrEventPlayers[indexPath.row] as! GuestInfo
                    cell.lblname.text = guestObj.guestName
                    cell.lblID.text = self.appDelegate.masterLabeling.gUEST

                } else {
                   
                }
                //Commented on 26th June 2020 V2.2
                //Assigns the captain name with first member in array
               /* if indexPath.row == 0 {
                    if arrEventPlayers[indexPath.row] is MemberInfo {
                        let memberObj = arrEventPlayers[indexPath.row] as! MemberInfo
                        
                            self.lblMemberName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.memberName! )
                        
                    }else if arrEventPlayers[indexPath.row] is GuestChildren{
                        let memberObj = arrEventPlayers[indexPath.row] as! GuestChildren
                        self.lblMemberName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,memberObj.name! )

                    }
                }*/
                
                if self.eventDetails.count != 0{
                if (self.eventDetails[0].isTgaEvent == 1) {

                    cell.btnClose.isEnabled = false
                    self.btnDecreaseTickets.isEnabled = false
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
        else if tableView == self.tblInstructions{
            
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
                
                
                cell.viewSearchField.layer.cornerRadius = 6
                cell.viewSearchField.layer.borderWidth = 0.25
                cell.viewSearchField.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
                
                cell.delegate = self
                cell.viewSearchField.isUserInteractionEnabled = true
                cell.txtSearchField.placeholder = String(format: "%@ %d", self.appDelegate.masterLabeling.person ?? "", indexPath.row + 1)

                if arrEventPlayers[indexPath.row] is MemberInfo {
                    
                    let memberObj = arrEventPlayers[indexPath.row] as! MemberInfo
                    cell.txtSearchField.text = String(format: "%@", memberObj.memberName!)
                }else if arrEventPlayers[indexPath.row] is GuestChildren{
                    
                    let guestOrChildrenObj = arrEventPlayers[indexPath.row] as! GuestChildren
                    cell.txtSearchField.text = String(format: "%@", guestOrChildrenObj.name ?? "")
                    cell.btnEdit.isEnabled = true
                    
                    
                    if guestOrChildrenObj.isSpouse == 1 && eventDetails[0].kids3Above == 0{
                         cell.btnEdit.isEnabled = false
                    }
                    
                    
                    
                    if guestOrChildrenObj.isInclude == 0 {
                        cell.viewSearchField.backgroundColor = UIColor.lightGray
                        cell.txtSearchField.backgroundColor = UIColor.clear
                    }else{
                        cell.viewSearchField.backgroundColor = UIColor.white
                        cell.txtSearchField.backgroundColor = UIColor.white
                    }
                    if (self.eventDetails[0].registrationFor == "Members Only" &&  self.eventDetails[0].guest == 0  && self.eventDetails[0].kids3Above == 0 && guestOrChildrenObj.isSpouse == 1){
                        cell.btnEdit.isEnabled = false
                        cell.btnAdd.isEnabled = true
                    }
                    if eventDetails[0].guest == 1{
                        cell.btnEdit.isEnabled = true
                    }
                    
                    
                } else if arrEventPlayers[indexPath.row] is CaptaineInfo {
                    let guestObj = arrEventPlayers[indexPath.row] as! CaptaineInfo
                    cell.txtSearchField.text = guestObj.captainName
                    cell.btnEdit.isEnabled = true
                    if self.eventDetails.count == 0{}else{
                    
                        if (self.eventDetails[0].registrationFor == "Members Only" &&  self.eventDetails[0].guest == 0  && self.eventDetails[0].kids3Above == 0  && self.eventDetails[0].isSpouse == 1){
                            cell.txtSearchField.text = guestObj.captainName
                            cell.viewSearchField.isUserInteractionEnabled = true
                            cell.btnEdit.isEnabled = false
                            cell.btnAdd.isEnabled = true
                        }
                        if (self.eventDetails[0].isTgaEvent == 1) {
                            cell.txtSearchField.text = guestObj.captainName
                            cell.viewSearchField.isUserInteractionEnabled = false
                            cell.btnEdit.isEnabled = false
                            cell.btnAdd.isEnabled = false
                        }
                        
                    }
                } else {
                    cell.btnEdit.isEnabled = false
                    cell.txtSearchField.text = ""
                    if self.hideAddButton == true{
                       cell.btnAdd.isEnabled = false
                    }else{
                        cell.btnAdd.isEnabled = true
                    }
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
            return UITableViewCell()
        }

    }
}

extension RegisterEventVC : UITableViewDelegate {
    
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                addNewPopover?.dismiss()
            if tableView == addNewPopoverTableView {
                let cell = self.addNewPopoverTableView?.cellForRow(at: indexPath)
                
                //Modified by kiran V2.5 -- GATHER0000606 -- replacing comparision with case insensetive compare with the value(id)
                //GATHER0000606 -- Start
                let selectedOption = self.appDelegate.addRequestOpt_Events[indexPath.row].Id ?? ""
                //GATHER0000606 -- End

                //Modified by kiran V2.5 -- GATHER0000606 -- replacing comparision with case insensetive compare with the value(id)
                //GATHER0000606 -- Start
                //if indexPath.row == 0
                if selectedOption.caseInsensitiveCompare(AddRequestIDS.member.rawValue) == .orderedSame
                //GATHER0000606 -- End
                {
                    if let memberDirectory = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MemberDirectoryViewController") as? MemberDirectoryViewController
                    {
                        selectedCellText = cell?.textLabel?.text
                        memberDirectory.isFrom = "Registration"
                        memberDirectory.delegate = self
                        memberDirectory.delegateGuestChildren = self
                        memberDirectory.isFor = self.isFor
                        memberDirectory.arrEventPlayers = self.arrEventPlayers
                        memberDirectory.requestID = arrRegisterDetails[0].eventRegistrationID
                        memberDirectory.eventID = self.eventID
                        memberDirectory.showSegmentController = true
                        memberDirectory.eventType = self.eventFor
                        
                        if eventType == 1 {
                                selectedPlayerIndex = -1
                                memberDirectory.totalNumberofTickets = (arrNewRegList.count - totalMembersCount) - (totoalGuestCount + totalKids3aboveCount + totalKids3belowCount)
                            
                            
                        }else{
                            if  arrEventPlayers[selectedPlayerIndex!] is CaptaineInfo ||  arrEventPlayers[selectedPlayerIndex!] is GuestChildren{
                                if  arrEventPlayers[selectedPlayerIndex!] is GuestChildren{
                                    let playObj = arrEventPlayers[selectedPlayerIndex!] as! GuestChildren
                                    memberDirectory.totalNumberofTickets = ((arrEventPlayers.count - totalMembersCount) - (totoalGuestCount + totalKids3aboveCount + totalKids3belowCount)) + 1 + playObj.guestCount! + playObj.kids3Below! + playObj.kids3Above!
                                }else if  arrEventPlayers[selectedPlayerIndex!] is CaptaineInfo{
                                    memberDirectory.totalNumberofTickets = ((arrEventPlayers.count - totalMembersCount) - (totoalGuestCount + totalKids3aboveCount + totalKids3belowCount)) + 1
                                }else{
                                    memberDirectory.totalNumberofTickets = ((arrEventPlayers.count - totalMembersCount) - (totoalGuestCount + totalKids3aboveCount + totalKids3belowCount)) + 1
                                }
                            }else{
                                
                                memberDirectory.totalNumberofTickets = (arrEventPlayers.count - totalMembersCount) - (totoalGuestCount + totalKids3aboveCount + totalKids3belowCount)
                            }
                        }
                        memberDirectory.showGuest = self.eventDetails[0].guest
//                        if self.eventDetails[0].isSpouse == 0 {
//                            memberDirectory.showGuest = 1
//                        }
                        memberDirectory.showKids = self.eventDetails[0].kids3Above
                        
                        memberDirectory.categoryForBuddy = self.eventCategory
                        memberDirectory.eventRegId = self.arrRegisterDetails[0].eventRegistrationID ?? ""
                        
                        //Added on 15th July 2020 V2.2
                        memberDirectory.isEvent = true

                        navigationController?.pushViewController(memberDirectory, animated: true)
                    }
                }
                //Modified by kiran V2.5 -- GATHER0000606 -- replacing comparision with case insensetive compare with the value(id)
                //GATHER0000606 -- Start
                //else if indexPath.row == 1
                else if selectedOption.caseInsensitiveCompare(AddRequestIDS.myBuddies.rawValue) == .orderedSame
                //GATHER0000606 -- End
                {
//                    if(self.eventDetails[0].registrationFor == "Members Only"){
                    
                        if let memberDirectory = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MemberDirectoryViewController") as? MemberDirectoryViewController {
                            selectedCellText = cell?.textLabel?.text
                            memberDirectory.categoryForBuddy = self.eventCategory
                            memberDirectory.registerType = "Event"
                            memberDirectory.isFrom = "BuddyList"
                            memberDirectory.registerType = "Event"
                            memberDirectory.arrEventPlayers = self.arrEventPlayers
                            memberDirectory.requestID = arrRegisterDetails[0].eventRegistrationID
                            memberDirectory.eventID = self.eventID
                            memberDirectory.showSegmentController = true
                            memberDirectory.isFor = self.isFor
                            memberDirectory.eventType = self.eventFor
                            if eventType == 1 {
                                selectedPlayerIndex = -1
                                memberDirectory.totalNumberofTickets = (arrNewRegList.count - totalMembersCount) - (totoalGuestCount + totalKids3aboveCount + totalKids3belowCount)
                                
                            }else{
                                if  arrEventPlayers[selectedPlayerIndex!] is CaptaineInfo ||  arrEventPlayers[selectedPlayerIndex!] is GuestChildren{
                                    if  arrEventPlayers[selectedPlayerIndex!] is GuestChildren{
                                        let playObj = arrEventPlayers[selectedPlayerIndex!] as! GuestChildren
                                        memberDirectory.totalNumberofTickets = ((arrEventPlayers.count - totalMembersCount) - (totoalGuestCount + totalKids3aboveCount + totalKids3belowCount)) + 1 +  playObj.guestCount! + playObj.kids3Below! + playObj.kids3Above!
                                    }else{
                                        memberDirectory.totalNumberofTickets = ((arrEventPlayers.count - totalMembersCount) - (totoalGuestCount + totalKids3aboveCount + totalKids3belowCount)) + 1
                                    }
                                }else{
                                    
                                    memberDirectory.totalNumberofTickets = (arrEventPlayers.count - totalMembersCount) - (totoalGuestCount + totalKids3aboveCount + totalKids3belowCount)
                                }
                            }
                            memberDirectory.showGuest = self.eventDetails[0].guest
//                            if self.eventDetails[0].isSpouse == 0 {
//                                memberDirectory.showGuest = 1
//                            }
                            memberDirectory.showKids = self.eventDetails[0].kids3Above
                            memberDirectory.delegate = self
                            memberDirectory.delegateGuestChildren = self

                            memberDirectory.eventRegId = self.arrRegisterDetails[0].eventRegistrationID ?? ""

                            //Added on 15th July 2020 V2.2
                            memberDirectory.isEvent = true
                            
                            navigationController?.pushViewController(memberDirectory, animated: true)
                        }
                    //NOTE:- With the change in V2.8 to show existing guests. the addgeustregVC may need additional details to be passed.check other reservaions for reference if needed.
//                    }
//                    else{
                    /*
                        if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddGuestRegVC") as? AddGuestRegVC {
                            regGuest.memberDelegate = self
                            selectedCellText = cell?.textLabel?.text
                            regGuest.isFrom = "EventGuest"
                            //Added by kiran V2.8 -- ENGAGE0011784 --
                            //ENGAGE0011784 -- Start
                            regGuest.usedForModule = .events
                            regGuest.screenType = .add
                            //ENGAGE0011784 -- End
                            navigationController?.pushViewController(regGuest, animated: true)
                        }*/
//                    }
//
                    
                }
//                else{
//                    if let memberDirectory = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MemberDirectoryViewController") as? MemberDirectoryViewController {
//                        selectedCellText = cell?.textLabel?.text
//
//                        memberDirectory.isFrom = "BuddyList"
//                        memberDirectory.categoryForBuddy = self.eventCategory
//                        memberDirectory.registerType = ""
//                        memberDirectory.delegate = self
//                        navigationController?.pushViewController(memberDirectory, animated: true)
//                    }
//                }
            }
            else if (tableView == modifyTableView){
                
                
                selectedPlayerIndex = indexPath.row
                
                
                if  arrEventPlayers[selectedPlayerIndex!] is GuestChildren{
                    if  arrEventPlayers[selectedPlayerIndex!] is GuestChildren{
                        let playObj = arrEventPlayers[selectedPlayerIndex!] as! GuestChildren
                         enterToGuestScreen = playObj.isSpouse
                        
                    
                }
                }else if arrEventPlayers[selectedPlayerIndex!] is MemberInfo{
                    if  arrEventPlayers[selectedPlayerIndex!] is MemberInfo{
                        let playObj = arrEventPlayers[selectedPlayerIndex!] as! MemberInfo
                        enterToGuestScreen = playObj.isSpouse
                }
                }
                
                if self.enterToGuestScreen == 1 && self.eventDetails[0].registrationFor == "Members Only" && self.eventDetails[0].guest == 0 && self.eventDetails[0].kids3Above == 0{
                    
                }else{
                
                if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "GuestOrChildrenVC") as? GuestOrChildrenVC {
                    
                    if (self.eventDetails[0].registrationFor == "Members Only" &&  self.eventDetails[0].guest == 0  && self.eventDetails[0].kids3Above == 0  && enterToGuestScreen == 1) || self.eventDetails[0].isTgaEvent == 1{
                    }else{

                    if  arrEventPlayers[selectedPlayerIndex!] is GuestChildren{
                        if  arrEventPlayers[selectedPlayerIndex!] is GuestChildren{
                            let playObj = arrEventPlayers[selectedPlayerIndex!] as! GuestChildren
                            regGuest.totalNumberofTickets = ((arrNewRegList.count - totalMembersCount) - (totoalGuestCount + totalKids3aboveCount + totalKids3belowCount)) + 1 + playObj.guestCount! + playObj.kids3Below! + playObj.kids3Above!
                            
                            regGuest.isSpousePresent = playObj.isSpouse

                        }else{
                            regGuest.totalNumberofTickets = ((arrNewRegList.count - totalMembersCount) - (totoalGuestCount + totalKids3aboveCount + totalKids3belowCount)) + 1
                        }
                    }else if arrEventPlayers[selectedPlayerIndex!] is MemberInfo{
                        if  arrEventPlayers[selectedPlayerIndex!] is MemberInfo{
                            let playObj = arrEventPlayers[selectedPlayerIndex!] as! MemberInfo
                            regGuest.totalNumberofTickets = ((arrNewRegList.count - totalMembersCount) - (totoalGuestCount + totalKids3aboveCount + totalKids3belowCount)) + 1 + playObj.guest! + playObj.kids3Below! + playObj.kids3Above!
                            regGuest.isSpousePresent = playObj.isSpouse
                        }else{
                            regGuest.totalNumberofTickets = ((arrNewRegList.count - totalMembersCount) - (totoalGuestCount + totalKids3aboveCount + totalKids3belowCount)) + 1
                        }
                    }else{
                        regGuest.totalNumberofTickets = (arrNewRegList.count - totalMembersCount) - (totoalGuestCount + totalKids3aboveCount + totalKids3belowCount)
                    }
                    regGuest.arrModifyData = [self.arrEventPlayers[(indexPath.row)]]
                    regGuest.showGuest = self.eventDetails[0].guest
//                        if self.eventDetails[0].isSpouse == 0 {
//                            regGuest.showGuest = 1
//                        }
                    regGuest.eventID = self.eventID
                    regGuest.showKids = self.eventDetails[0].kids3Above
                    regGuest.eventRegId = self.arrRegisterDetails[0].eventRegistrationID ?? ""
                    regGuest.requestID = self.arrRegisterDetails[0].eventRegistrationID ?? ""
                    regGuest.delegateGuestChildren = self
                        
                    navigationController?.pushViewController(regGuest, animated: true)
                    }
                    
                }
                        }
            }
            else if tableView == self.tblInstructions
            {
                
            }
            else{
                
            }
            
    }
}

//MARK:- View only funcitionality related functions
extension RegisterEventVC
{
    /// Disables all the actions except save/ submit/register. that button will act as back button
    private func shouldDisableAllActions(_ bool : Bool)
    {
        self.btnIncreaseTicket.isUserInteractionEnabled = !bool
        self.btnDecreaseTickets.isUserInteractionEnabled = !bool
        self.btnModifyAdd.isUserInteractionEnabled = !bool
        self.modifyTableView.isUserInteractionEnabled = !bool
        self.registrationTableview.isUserInteractionEnabled = !bool
        self.txtComments.isUserInteractionEnabled = !bool
        self.btnCancelReservation.isHidden = bool
        self.cancelReservationHeight.constant = bool ? 0 : 37
        //added on 12th October 2020 V2.3
        self.txtViewRemainder.isUserInteractionEnabled = !bool
    }
    
}

//Added on 24th June 2020 V2.2

//MARK:- Custom Methods
extension RegisterEventVC
{
    ///Sets the captain for the request
    ///
    /// Called only in one place tableview numberOfRows callback.
    private func updateCaptain(id : String)
    {
        var captainName = ""
        if self.containsCaptain(id: id)
        {
            if id == UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)
            {
                captainName = UserDefaults.standard.string(forKey: UserDefaultsKeys.captainName.rawValue)!
            }
            else
            {
                captainName = self.captainName(id: id) ?? ""
            }
            
        }
        else
        {
            if let member = (self.arrRegisterDetails.first?.requestedLinkedmemberID?.count ?? 0) > 0 ? self.arrEventPlayers.first : self.arrEventPlayers.filter({$0.isEmpty == false}).first
            {
                if let member = member as? CaptaineInfo
                {
                    captainName = member.captainName ?? ""
                }
                else if let member = member as? GuestChildren
                {
                    captainName = member.name ?? ""
                }
                else if let member = member as? MemberInfo
                {
                    captainName = member.memberName ?? ""
                }
            }
            
        }
        
        self.lblMemberName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!,captainName)
    }
    
    
    ///Checks if the request has a captain in the members.
    private func containsCaptain(id : String) -> Bool
    {
        var containsCaptain = false
        for member in self.arrEventPlayers
        {
            if let member = member as? CaptaineInfo
            {
                containsCaptain = (member.captainID == id)
            }
            else if let member = member as? GuestChildren
            {
                containsCaptain = (member.selectedID == id)
            }
            else if let member = member as? MemberInfo
            {
                containsCaptain = (member.id == id)
            }
            
            if containsCaptain
            {
                break
            }
        }
        
        return containsCaptain
    }
    
    
    
    private func captainName(id : String) -> String?
    {
        for member in self.arrEventPlayers
        {
            if let member = member as? CaptaineInfo
            {
                if member.captainID == id
                {
                    return member.captainName
                }
            }
            else if let member = member as? GuestChildren
            {
                if member.selectedID == id
                {
                    return member.name
                }
            }
            else if let member = member as? MemberInfo
            {
                if member.id == id
                {
                    return member.memberName
                }
            }
            
        }
        
        return nil
    }
    
    //Added by kiran V2.5 -- GATHER0000606 -- Logic which indicates if add member button should be displayed or not
    //GATHER0000606 -- Start
    ///Indicates if add member button should be shown. only applicable for single member add not multi select
    private func shouldHideMemberAddOptions() -> Bool
    {
        return !(self.appDelegate.addRequestOpt_Events.count > 0)
    }
    //GATHER0000606 -- End
}

//Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
//PROD0000069 -- Start
extension RegisterEventVC : CancelPopUpViewControllerDelegate
{
    func didCancel(status: Bool)
    {
        if status, let navFrom = self.navigatedFrom
        {
            self.delegate?.eventSuccessPopupClosed()
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
