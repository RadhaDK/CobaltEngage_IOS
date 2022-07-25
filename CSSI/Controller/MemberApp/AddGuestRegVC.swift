//
//  AddGuestRegVC.swift
//  CSSI
//
//  Created by apple on 2/28/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit
import Popover
protocol guestViewControllerDelegate
{
    func guestViewControllerResponse(guestName: String)

}

//Added by kiran V2.8 -- ENGAGE0011784 -- Reorganised the functions to improve readability. Moved the functions to respective extensions and created new methods to organise the code in viewDidLoad function. And renamed few IB outlets to better refelect their purpose.
//ENGAGE0011784 -- Start
class AddGuestRegVC: UIViewController
{
    
    //Added by kiran V2.8 -- ENGAGE0011784 -- Commented the outlets for constraints which where used to change the heights and replaced it with auto adjusting layiut style.
    //ENGAGE0011784 -- Start
    //@IBOutlet weak var heightBuddyToOptional: NSLayoutConstraint!
    //@IBOutlet weak var addToMyBuddyHeight: NSLayoutConstraint!
    //@IBOutlet weak var heightGuestView: NSLayoutConstraint!
    //@IBOutlet weak var heightBaseView: NSLayoutConstraint!
    //@IBOutlet weak var heightSpecialRequest: NSLayoutConstraint!
    //@IBOutlet weak var heightOtherText: NSLayoutConstraint!
    //@IBOutlet weak var heightSpecialOccassion: NSLayoutConstraint!
    //@IBOutlet weak var heightViewBottom: NSLayoutConstraint!
    //ENGAGE0011784 -- End
    
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var mainView: UIView!
    //Added by kiran V2.8 -- ENGAGE0011784 -- Commented as the view associated to this is removed from storyboard as this style of showing suggestions is no longer suitable when name is split into first name and lastname .
    //ENGAGE0011784 -- Start
    //@IBOutlet weak var heightGuestTableview: NSLayoutConstraint!
    //@IBOutlet weak var guestTableview: UITableView!
    //ENGAGE0011784 -- End
    /// Has additional dining details
    ///
    /// like High chair  count , dietery instructions , etc
    @IBOutlet weak var viewDiningSpecialRequest: UIView!
    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var viewAddToMyBuddyList: UIView!
    @IBOutlet weak var btnAddToMybuddyList: UIButton!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var txtGuestFirstname: UITextField!
    @IBOutlet weak var txtTypeOfGuest: UITextField!
    @IBOutlet weak var viewGuestType: UIView!

    @IBOutlet weak var txtOther: UITextView!
 
    @IBOutlet weak var viewPrimaryEmail: UIView!
    @IBOutlet weak var viewCellPhone: UIView!
    @IBOutlet weak var viewNewGuestDetails: UIView!
    @IBOutlet weak var lblCellPhone: UILabel!
    @IBOutlet weak var txtCellPhone: UITextField!
    @IBOutlet weak var lblOptiona: UILabel!
    @IBOutlet weak var txtPrimaryEmail: UITextField!
    @IBOutlet weak var lblPrimaryEmail: UILabel!
    
    @IBOutlet weak var btnDecreaseHighChair: UIButton!
    @IBOutlet weak var btnDecreaseBooster: UIButton!
    @IBOutlet weak var lblBooster: UILabel!
    @IBOutlet weak var lblHighChair: UILabel!
    @IBOutlet weak var lbladdASpecialRequest: UILabel!
    @IBOutlet weak var btnHighChair: UIButton!
    @IBOutlet weak var btnBooster: UIButton!
    @IBOutlet weak var lblAddASpecialOccassion: UILabel!
    @IBOutlet weak var btnAnniversary: UIButton!
    @IBOutlet weak var btnBirthDay: UIButton!
    @IBOutlet weak var btnOther: UIButton!
    @IBOutlet weak var lblShouldWeBeaware: UILabel!
    @IBOutlet weak var txtSpecify: UITextView!
    
    //Added on 4th September 2020 V2.3
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var viewTxtGender: UIView!
    @IBOutlet weak var viewGender: UIView!
    
    //Added on 23rd Spetmeber 2020 V2.3
    @IBOutlet weak var viewDOB: UIView!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var viewTxtDOB: UIView!
    @IBOutlet weak var txtDOB: UITextField!
    
    @IBOutlet weak var txtGuestLastName: UITextField!
    //Added by kiran V2.8 -- ENGAGE0011784
    //ENGAGE0011784 -- Start
    
    @IBOutlet weak var scrollViewGuestCard: UIScrollView!
    @IBOutlet weak var viewTxtOther: UIView!
    
    @IBOutlet weak var viewGuestOption: UIView!
    
    @IBOutlet weak var viewExistingGuestOption: UIView!
    @IBOutlet weak var imgViewExistingGuestOption: UIImageView!
    @IBOutlet weak var lblExistingGuestOption: UILabel!
    @IBOutlet weak var btnExistingGuestOption: UIButton!
    
    @IBOutlet weak var viewNewGuestOption: UIView!
    @IBOutlet weak var imgViewNewGuestOption: UIImageView!
    @IBOutlet weak var lblNewGuestOption: UILabel!
    @IBOutlet weak var btnNewGuestOption: UIButton!
    
    @IBOutlet weak var viewNewGuest: UIView!
    @IBOutlet weak var viewNewGuestName: UIView!
    @IBOutlet weak var viewExistingGuestList: UIView!
    
    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var searchBarGuest: UISearchBar!
    
    @IBOutlet weak var tblViewExistingGuests: UITableView!
    
    @IBOutlet weak var heightViewGuestOptions: NSLayoutConstraint!
    
    @IBOutlet weak var viewExistingGuestAddToBuddy: UIView!
    @IBOutlet weak var btnExistingGuestAddToBuddy: UIButton!
    
    @IBOutlet weak var viewModifyGuestName: UIView!
    
    @IBOutlet weak var searchBarModifyGuestName: UISearchBar!
    
    
    //StackViews
    @IBOutlet weak var stackViewGuestOptionParent: UIStackView!
    @IBOutlet weak var stackViewGuestOptions: UIStackView!
    @IBOutlet weak var stackViewAddToBuddy: UIStackView!
    @IBOutlet weak var stackViewNewGuestName: UIStackView!
    
    @IBOutlet weak var stackViewNewGuestDetails: UIStackView!
    
    @IBOutlet weak var stackViewDiningSpecialRequest: UIStackView!
    
    @IBOutlet weak var stackViewModifyGuestName: UIStackView!
    //ENGAGE0011784 -- End
    
    @IBOutlet weak var heightViewBottom: NSLayoutConstraint!
    var isAddToBuddy : Int?
    ///Pass the guest details to populate in case of modify or view.
    ///
    /// Note:- Conatins guest info in case of modify or view.
    var arrTotalList = [RequestData]()

    var arrSpecialOccasion = [RequestData]()
    var boosterValue: Int?
    var highChairValue: Int?
    var other: Int?
    var birthDay: Int?
    var anniversary: Int?
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var memberDelegate: MemberViewControllerDelegate?
    var guestDelegate: guestViewControllerDelegate?
    fileprivate var relationPicker: UIPickerView? = nil;
    fileprivate var selectedRelation: GuestType? = nil

    //Added by kiran V2.8 -- ENGAGE0011784 - Commented as these are no longer being used.
    //ENGAGE0011784 -- Start
    //var isFrom : String?
    //var isOnlyFor : String?
    //var isView: String?
    //var category: String?
    //var contacts = [MemberInfo]()
    //var locationIndex: Int!
    //var isOnlyFrom : String?
    //var strSuggestionSearch : String = ""
    //ENGAGE0011784 -- End
    
    var arrBooster = [String]()
    var arrHighChair = [String]()
    
    //Added by kiran V2.8 -- ENGAGE0011784 - renamed arrguestList to arrGuestSuggestions
    //ENGAGE0011784 -- Start
    var arrGuestSuggestions : [ReservationGuestListElement] = []
    //ENGAGE0011784 -- End
    var AllData:Array<Dictionary<String,String>> = []
    var SearchData:Array<Dictionary<String,String>> = []
    //Added on 16th june 2020 BMS
    var hideAddtoBuddy = false
    
    //Added on 4th September 2020 V2.3
    ///Hides the gender Dropdown. Default is true.
    var isGenderHidden = false
    private var genderPicker : UIPickerView?

    ///Indicates screen type.
    ///
    ///Note:- Default is Add
    //Note:- change the use of isFrom to identify if the screen is for modify or view to this variable.
    var screenType : GuestScreenType = .add
    //Added on 23rd Spetmeber 2020 V2.3
    ///Shows / Hides date of birth view
    var isDOBHidden = false
    
    private var DOBPicker : UIDatePicker?
    
    
    //Added by kiran V2.8 -- ENGAGE0011784-
    //ENGAGE0011784 -- Start
    
    ///Indicates if showExisting guests and new guest option is displayed.
    ///
    ///Default is false i.e., only add guest screen is displayed.
    var showExistingGuestsOption : Bool = false
    
    ///Enable/Disable showing name suggestions  while entering guest name.
    ///
    ///Default value is false
    var enableGuestNameSuggestions : Bool = false
    
    ///Indicates which moduleis using the VC.
    var usedForModule : AppModules!
    ///Date for the request
    var requestDates = [String]()
    //Time of the request
    var requestTime = ""
    ///Duration of the Tennis request
    ///
    ///e.g., 90,60,etc..
    var duration = ""
    
    var requestID = ""
    
    var eventID = ""
    ///Tennis game type.
    ///
    ///e.g., SingleDay , etc..
    var gameType = ""
    
    ///Dining Space detail id.
    var preferedSpaceDetailId = ""
    
    var BMSDepartmentName : String?
    
    ///Used for BMS
    var appointmentType : MemberSelectionType?
    
    ///Pass the members/buddies/Guests already added for the requests.
    ///
    ///Note:- This is only osed for member validation.Here each Array<Reqeust Data> denoted a group in case of golf. for other use the first object
    var arrAddedMembers = [[RequestData]]()
    
    ///Indicates if showExisting guests and new guest option is displayed.
    ///
    ///Default is false i.e., only add guest screen is displayed.
    var hideExistingGuestAddToBuddy : Bool = false
    ///Exisitng guests list
    private var arrExistingGuests : [ExistingGuest] = [ExistingGuest]()
    
    ///Guest selected
    private var selectedGuest : ExistingGuest?
    
    private var stringGuestSearch : String = ""
    
    private var showingExistingUserSpecialOption : Bool = false
    
    ///This is used to store the height of the guest options view to restore after hiding the view.
    private var guestOptionHeight : CGFloat = 0
    
    private var arrGuestProfilePicTask = [String : ImageDownloadTask]()
    
    private var existingGuestPageNumber : Int = 1
    
    private var isLoadMoreClicked = false
    
    private var viewPopOver = Popover.init()
    
    private let tblViewNameSuggetions = UITableView.init()

    private var showLoadMore : Bool = false
    
    //Only used for is active functionality in existing guest list
    private var existingGuestSelectedIndex : IndexPath?
    //ENGAGE0011784 -- End
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Added by kiran V2.8 -- ENGAGE0011784 -- Created new functions and moved the logics to new functions.(like inititalsetups method.)
        //ENGAGE0011784 -- Start
        /*
        if isOnlyFor == "Golf" || self.hideAddtoBuddy
        {
        self.addToMyBuddyHeight.constant = 0
        self.heightBuddyToOptional.constant = 0
        self.btnAddToMybuddyList.isHidden = true
        }else{
            self.addToMyBuddyHeight.constant = 43
            self.btnAddToMybuddyList.isHidden = false
            self.heightBuddyToOptional.constant = 35

        }*/
        
        self.initialSetups()
        
        //ENGAGE0011784 -- End
   /*
        if isFrom == "EventGuest"{
            txtGuestFirstname.placeholder = appDelegate.masterLabeling.tYPE_GUEST_NAME_ASTERISK

            self.viewNewGuestDetails.isHidden = true
            let selectGuest: NSMutableAttributedString = NSMutableAttributedString(string: self.txtGuestFirstname.placeholder!)
            selectGuest.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
            self.txtGuestFirstname.attributedPlaceholder = selectGuest
        }
        else{
            txtGuestFirstname.placeholder = appDelegate.masterLabeling.type_guest_name
        }
        guestTableview.separatorStyle = .none

        
        selectedRelation = appDelegate.arrGuestType[1]
        txtTypeOfGuest.text = selectedRelation?.name

        SearchData=AllData
        txtGuestFirstname.setLeftPaddingPoints(15)
        
        //Modified on 5th September 2020 V2.3
        //TODO:- Change the use of isfrom to screenType for identify modify case.
        if isFrom == "Modify" || self.screenType == .modify{
            
            //TODO:- Change the use of isView  to screenType for identifying view case.
            if isView == "Yes" {
                self.mainView.isUserInteractionEnabled = false
                self.viewBottom.isHidden = true
                //Added by kiran V2.8 -- ENGAGE0011784
                //ENGAGE0011784 -- Start
                //self.heightViewBottom.constant = 0
                //ENGAGE0011784 -- End
            }
            if arrTotalList[0] is GroupDetail {
                let guestObj = arrTotalList[0] as! GroupDetail
                txtSpecify.text = guestObj.dietary ?? ""

                txtGuestFirstname.text = guestObj.guestName
                txtTypeOfGuest.text = guestObj.guestType
                txtPrimaryEmail.text = guestObj.email
                txtCellPhone.text = guestObj.cellPhone
                
                if  guestObj.highchair == 0 {
                    highChairValue = 0
                    arrHighChair.append("")
                }else{
                    self.lblHighChair.text = String(format: "%02d", guestObj.highchair ?? 1)
                    btnHighChair.isSelected = true
                    btnHighChair.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    for _ in 0 ..< guestObj.highchair! {
                        self.arrHighChair.append("")
                    }
                }
                if  guestObj.boosterCount == 0 {
                    boosterValue = 0
                    arrBooster.append("")
                }else{
                    self.lblBooster.text = String(format: "%02d", guestObj.boosterCount ?? 1)
                    btnBooster.isSelected = true
                    btnBooster.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    for _ in 0 ..< guestObj.boosterCount! {
                        self.arrBooster.append("")
                    }
                }
                
                if arrSpecialOccasion[0] is GroupDetail {
                    let guestObj = arrSpecialOccasion[0] as! GroupDetail
                if guestObj.birthDay == 0{
                    birthDay = 0
                    btnBirthDay.isSelected = false
                    btnBirthDay.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                    
                }else if guestObj.birthDay == 1{
                    btnBirthDay.isSelected = true
                    btnBirthDay.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    birthDay = 1
                }
                if guestObj.anniversary == 0{
                    btnAnniversary.isSelected = false
                    btnAnniversary.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                    anniversary = 0
                }else if guestObj.anniversary == 1{
                    btnAnniversary.isSelected = true
                    btnAnniversary.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    anniversary = 1
                }
                if guestObj.other == 0{
                    btnOther.isSelected = false
                    btnOther.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                    other = 0
                    //Added by kiran V2.8 -- ENGAGE0011784
                    //ENGAGE0011784 -- Start
                    //self.heightOtherText.constant = -117
                    self.viewTxtOther.isHidden = true
                    //self.heightSpecialOccassion.constant = 173
                    //ENGAGE0011784 -- End
                    self.txtOther.isHidden = true
                }else if guestObj.other == 1{
                    btnOther.isSelected = true
                    btnOther.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    other = 1
                    //Added by kiran V2.8 -- ENGAGE0011784
                    //ENGAGE0011784 -- Start
                    self.viewTxtOther.isHidden = false
                    //self.heightOtherText.constant = 97
                    //self.heightSpecialOccassion.constant = 290
                    //ENGAGE0011784 -- End
                    self.txtOther.isHidden = false
                    
                    txtOther.layer.cornerRadius = 6
                    txtOther.layer.borderWidth = 1
                    txtOther.layer.borderWidth = 0.25
                    //Added by kiran V2.8 -- ENGAGE0011784 -- replacing colors with app colors.
                    //ENGAGE0011784 -- Start
                    txtOther.layer.borderColor = APPColor.OtherColors.borderColor.cgColor//hexStringToUIColor(hex: "2D2D2D").cgColor
                    
                    //ENGAGE0011784 -- End
                }
                
                txtOther.text = guestObj.otherText ?? ""
                    
                }
            }else if arrTotalList[0] is GuestInfo {
                let memberObj = arrTotalList[0] as! GuestInfo
                txtGuestFirstname.text = memberObj.guestName
                txtTypeOfGuest.text = memberObj.guestType
                txtPrimaryEmail.text = memberObj.email
                txtCellPhone.text = memberObj.cellPhone
                //Added on 4th September 2020 V2.3
                self.txtGender.text = memberObj.guestGender
                
                //Added on 24th September 2020 V2.3
                self.txtDOB.text = memberObj.guestDOB
                
                self.txtSpecify.text = memberObj.dietaryRestrictions ?? ""
                
                if  memberObj.highChairCount == 0 {
                    highChairValue = 0
                    arrHighChair.append("")

                }else{
                    self.lblHighChair.text = String(format: "%02d", memberObj.highChairCount ?? 1)
                    btnHighChair.isSelected = true
                    btnHighChair.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    for _ in 0 ..< memberObj.highChairCount! {
                        self.arrHighChair.append("")
                    }
                }
                
                if  memberObj.boosterChairCount == 0 {
                    boosterValue = 0
                    arrBooster.append("")
                    
                }else{
                    self.lblBooster.text = String(format: "%02d", memberObj.boosterChairCount ?? 1)
                    btnBooster.isSelected = true
                    btnBooster.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    for _ in 0 ..< memberObj.boosterChairCount! {
                        self.arrBooster.append("")
                    }
                }
           
                if memberObj.birthDay == 0{
                    birthDay = 0
                    btnBirthDay.isSelected = false
                    btnBirthDay.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                    
                }else if memberObj.birthDay == 1{
                    btnBirthDay.isSelected = true
                    btnBirthDay.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    birthDay = 1
                }
                if memberObj.anniversary == 0{
                    btnAnniversary.isSelected = false
                    btnAnniversary.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                    anniversary = 0
                }else if memberObj.anniversary == 1{
                    btnAnniversary.isSelected = true
                    btnAnniversary.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    anniversary = 1
                }
                if memberObj.other == 0{
                    btnOther.isSelected = false
                    btnOther.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                    other = 0
                    //Added by kiran V2.8 -- ENGAGE0011784
                    //ENGAGE0011784 -- Start
                    self.viewTxtOther.isHidden = true
                    //self.heightOtherText.constant = -117
                    //self.heightSpecialOccassion.constant = 173
                    //ENGAGE0011784 -- End
                    self.txtOther.isHidden = true
                }else if memberObj.other == 1{
                    btnOther.isSelected = true
                    btnOther.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    other = 1
                    txtOther.layer.cornerRadius = 6
                    txtOther.layer.borderWidth = 1
                    txtOther.layer.borderWidth = 0.25
                    //Added by kiran V2.8 -- ENGAGE0011784 -- replacing colors with app colors.
                    //ENGAGE0011784 -- Start
                    txtOther.layer.borderColor = APPColor.OtherColors.borderColor.cgColor//hexStringToUIColor(hex: "2D2D2D").cgColor
                   
                    //ENGAGE0011784 -- End
                }
                txtOther.text = memberObj.otherText ?? ""
            }//Added on 5th September 2020 V2.3
            //Added to add support for modify of guest details for fitness and spa
            else if arrTotalList.first is Detail
            {
                let memberObj = arrTotalList[0] as! Detail
                txtGuestFirstname.text = memberObj.guestName
                txtTypeOfGuest.text = memberObj.guestType
                txtPrimaryEmail.text = memberObj.email
                txtCellPhone.text = memberObj.cellPhone
                //Added on 4th September 2020 V2.3
                self.txtGender.text = memberObj.guestGender
                //Added on 24th September 2020 v2.3
                self.txtDOB.text = memberObj.guestDOB
            }
            else {
                txtGuestFirstname.text = ""
            }
        }else{
            arrBooster.append("")
            arrHighChair.append("")
            btnDecreaseHighChair.isEnabled = false
            btnDecreaseBooster.isEnabled = false
            //Added by kiran V2.8 -- ENGAGE0011784
            //ENGAGE0011784 -- Start
            self.viewTxtOther.isHidden = true
            //self.heightOtherText.constant = -117
           // self.heightSpecialOccassion.constant = 173
            //ENGAGE0011784 -- End
            self.txtOther.isHidden = true
            if isOnlyFor == "Golf"
            {
                isAddToBuddy = 0
                
            }else{
                isAddToBuddy = 1

            }
            other = 0
            birthDay = 0
            anniversary = 0
            highChairValue = 0
            boosterValue = 0
            
            
        }
        
        // Unselects add to buddy by default for registerations
        //For golf add to buddy option is not provided hence not implemented
        if(isOnlyFor == "Dining" || isOnlyFrom == "RequestCourt"){
            
            //Shows the additional details required for dining reservation only
            viewDiningSpecialRequest.isHidden = !(isOnlyFor == "Dining")
            self.guestTableview.isHidden = !(isOnlyFor == "Dining")
            
            self.btnAddToMybuddyList.setImage(UIImage(named:"CheckBox_uncheck"), for: UIControlState.normal)
            self.btnAddToMybuddyList.isSelected = true
            isAddToBuddy = 0
        }
        else{
            self.guestTableview.isHidden = true
            
            viewDiningSpecialRequest.isHidden = true
        }*/
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        //Added by kiran V2.8 -- ENGAGE0011784 -- modified to include the changes for existing guests functionality
        //ENGAGE0011784 -- Start
        self.addLeftEdgeSwipeAction()
        //self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011784 -- End
        //ENGAGE0011372 -- Start
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        //Added on 3rd July 2020 in BMS
//        let barbutton = UIBarButtonItem.init(image : UIImage.init(named: "back_btn"), style: .plain, target: self , action: #selector(backBtnClicked(sender:)))
//        barbutton.imageInsets = UIEdgeInsets.init(top: 0, left: -6.5, bottom: 0, right: 0)
//        self.navigationItem.leftBarButtonItem = barbutton
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnClicked(sender:)))
        //ENGAGE0011297 -- End
         
    }
    
    override func viewWillLayoutSubviews()
    {
        //Added by kiran V2.8 -- ENGAGE0011784 -- modified to code to make view auto adjust to the content.
        //ENGAGE0011784 -- Start
        //super.updateViewConstraints()
        super.viewWillLayoutSubviews()
        //Added by kiran V2.8 -- ENGAGE0011784 -- Commented as the view associated to this is removed from storyboard as this style of showing suggestions is no longer suitable when name is split into first name and lastname .
        //ENGAGE0011784 -- Start
        //self.heightGuestTableview.constant =  self.guestTableview.isHidden ? 0 : self.guestTableview.contentSize.height
        //ENGAGE0011784 -- End
        self.scrollViewGuestCard.contentSize.height = self.mainView.frame.height
        
        if !self.showExistingGuestsOption
        {
            self.heightViewGuestOptions.constant = 0
        }
        
        if self.heightViewGuestOptions.constant > 0
        {
            self.guestOptionHeight = self.heightViewGuestOptions.constant
        }
        
        /*
        if(isOnlyFor == "Dining"){
            //self.heightGuestTableview.constant = self.guestTableview.contentSize.height
            //self.heightGuestView.constant = self.heightGuestTableview.constant + 87
            
            //self.heightBaseView.constant = 1154
        }
        else{
            if(isFrom == "Request"){
                //self.heightGuestView.constant =  87
                //self.heightBaseView.constant = 480
            }
            else{
                //self.heightGuestView.constant =  87
                //self.heightBaseView.constant = 480

            }
        }
        
        //Added on 4th September 2020 V2.3
        //self.heightBaseView.constant += self.viewGender.isHidden ? 0 : 110
     
        //Added on 24th September 2020 V2.3
        //self.heightBaseView.constant += self.viewDOB.isHidden ? 0 : 110
        */
        //ENGAGE0011784 -- End
    }
    
    
    @objc func onTapHome()
    {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    //Added on 3rd July 2020 BMS
    @objc private func backBtnClicked(sender:UIBarButtonItem)
    {
        if self.showingExistingUserSpecialOption
        {
            self.showDiningAdditionalOptions(bool: false)
        }
        else
        {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    //Added on 24th September 2020 V2.3
    @objc func didDOBDateChange(datePicker:UIDatePicker)
    {
        self.txtDOB.text = SharedUtlity.sharedHelper().dateFormatter.string(from: datePicker.date)
    }

    @IBAction func boosterClicked(_ sender: Any) {
        if btnBooster.isSelected == false {
            btnBooster.isSelected = true
            boosterValue = 1
            btnBooster.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
        }else {
            btnBooster.isSelected = false
            boosterValue = 0
            btnBooster.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
        }
    }
    @IBAction func highChair(_ sender: Any) {
        if btnHighChair.isSelected == false {
            btnHighChair.isSelected = true
            highChairValue = 1
            btnHighChair.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
        }else {
            btnHighChair.isSelected = false
            highChairValue = 0

            btnHighChair.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
        }
        
    }
    @IBAction func highDecreased(_ sender: Any) {
        if arrHighChair.count == 1 {
            btnDecreaseHighChair.isEnabled = false
        }
        else{
            arrHighChair.remove(at: 0)
            if arrHighChair.count == 1 {
                btnDecreaseHighChair.isEnabled = false
            }
        }
        self.lblHighChair.text = String(format: "%02d", arrHighChair.count)
        
    }
    @IBAction func highCharIncreased(_ sender: Any) {
        btnDecreaseHighChair.isEnabled = true
        
        arrHighChair.append("")
        
        self.lblHighChair.text = String(format: "%02d", arrHighChair.count)
        
        
    }
    
    @IBAction func boosterIncreased(_ sender: Any) {
        btnDecreaseBooster.isEnabled = true
        
        arrBooster.append("")
        
        self.lblBooster.text = String(format: "%02d", arrBooster.count)
        
    }
    @IBAction func boosterDecreased(_ sender: Any) {
        if arrBooster.count == 1 {
            btnDecreaseBooster.isEnabled = false
        }
        else{
            arrBooster.remove(at: 0)
            if arrBooster.count == 1 {
                btnDecreaseBooster.isEnabled = false
            }
        }
        self.lblBooster.text = String(format: "%02d", arrBooster.count)
        
    }
    
    @IBAction func birthDayClicked(_ sender: Any) {
        
        if btnBirthDay.isSelected == false {
            btnBirthDay.isSelected = true
            btnBirthDay.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
            birthDay = 1

        }else {
            btnBirthDay.isSelected = false
            btnBirthDay.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
            birthDay = 0
        }
        
    }
    @IBAction func anniversaryClicked(_ sender: Any) {
        if btnAnniversary.isSelected == false {
            btnAnniversary.isSelected = true
            btnAnniversary.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
            anniversary = 1

        }else {
            btnAnniversary.isSelected = false
            btnAnniversary.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
            anniversary = 0
        }
    }
    @IBAction func otherClicked(_ sender: Any) {
        if btnOther.isSelected == false {
            btnOther.isSelected = true
            btnOther.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
            
            //Added by kiran V2.8 -- ENGAGE0011784
            //ENGAGE0011784 -- Start
            self.viewTxtOther.isHidden = false
            //self.heightOtherText.constant = 97
            //self.heightSpecialOccassion.constant = 290
            //ENGAGE0011784 -- End
            self.txtOther.isHidden = false
            txtOther.layer.cornerRadius = 6
            txtOther.layer.borderWidth = 1
            txtOther.layer.borderWidth = 0.25
            //Added by kiran V2.8 -- ENGAGE0011784 -- replacing colors with app colors.
            //ENGAGE0011784 -- Start
            txtOther.layer.borderColor = APPColor.OtherColors.borderColor.cgColor//hexStringToUIColor(hex: "2D2D2D").cgColor
            
            //ENGAGE0011784 -- End
            other = 1
        }else {
            btnOther.isSelected = false
            btnOther.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
            
            //Added by kiran V2.8 -- ENGAGE0011784
            //ENGAGE0011784 -- Start
            self.viewTxtOther.isHidden = true
            //self.heightOtherText.constant = -117
            //self.heightSpecialOccassion.constant = 173
            //ENGAGE0011784 -- End
            self.txtOther.isHidden = true
            other = 0
        }
    }
 
    @IBAction func cancelClicked(_ sender: Any)
    {
        if self.showingExistingUserSpecialOption
        {
            self.showDiningAdditionalOptions(bool: false)
        }
        else
        {
            self.navigationController?.popViewController(animated: true)
        }

    }
    
    @IBAction func addToMyBuddyClicked(_ sender: Any) {
        
        if let button = sender as? UIButton {
            
            if button.isSelected {
                button.isSelected = false
                btnAddToMybuddyList.setImage(UIImage(named:"Group 2130"), for: UIControlState.normal)
                isAddToBuddy = 1
                
            } else {
                
                btnAddToMybuddyList.setImage(UIImage(named:"CheckBox_uncheck"), for: UIControlState.normal)
                isAddToBuddy = 0
                
                button.isSelected = true
            }
        }
        
    }
    
    @IBAction func existingGuestAddToBuddyClicked(_ sender: UIButton)
    {
        sender.isSelected = !sender.isSelected
    }
    
    
    @IBAction func addGuestClicked(_ sender: Any)
    {
        
        var isExistingGuest = false
        
        if self.screenType == .modify
        {
            let memberType = CustomFunctions.shared.memberType(details: self.arrTotalList.first!, For: self.usedForModule)
            isExistingGuest = (memberType == .existingGuest)
        }
        
        if (self.showExistingGuestsOption && self.btnExistingGuestOption.isSelected) || (self.screenType == .modify && isExistingGuest)
        {
            if self.screenType == .add
            {
                if let _ = self.selectedGuest
                {
                    self.existingGuestValidation()
                }
                else
                {
                    SharedUtlity.sharedHelper().showToast(on:
                                                            self.view, withMeassge: self.appDelegate.masterLabeling.go_Please_Select_Guest ?? "", withDuration: Duration.kMediumDuration)
                }
            }
            else
            {
                self.existingGuestValidation()
            }
        }
        else
        {
            self.newGuestValidation()
        }
        
    }
    
    
    //Added by kiran V2.8 -- ENGAGE0011784
    //ENGAGE0011784 -- Start
    @IBAction func existingUserClicked(_ sender: UIButton)
    {
        if !sender.isSelected
        {
            self.showExistingGuestsView()
            self.imgViewExistingGuestOption.image = UIImage.init(named:"radio_selected")
            self.imgViewNewGuestOption.image =  UIImage.init(named:"radio_Unselected")
            sender.isSelected = true
            self.btnNewGuestOption.isSelected = false
            self.view.layoutIfNeeded()
            self.existingGuestPageNumber = 1
            self.isLoadMoreClicked = false
            self.getGuestList()
            self.selectedGuest = nil
            
            //Note:- Any changed done to addToBuddyList for existing Guests should also be done in initialSetups() function
            if !self.hideExistingGuestAddToBuddy
            {
                if self.usedForModule == .dining || self.usedForModule == .diningEvents || self.usedForModule == .tennis
                {
                    self.btnExistingGuestAddToBuddy.isSelected = false
                    
                }
                else
                {
                    self.btnExistingGuestAddToBuddy.isSelected = true
                }
            }
            
            self.view.endEditing(true)
        }
        
    }
    
    @IBAction func newUserClicked(_ sender: UIButton)
    {
        
        if !sender.isSelected
        {
            self.showNewGuestView()
            self.imgViewExistingGuestOption.image = UIImage.init(named:"radio_Unselected")
            self.imgViewNewGuestOption.image =  UIImage.init(named:"radio_selected")
            sender.isSelected = true
            self.btnExistingGuestOption.isSelected = false
            self.emptyNewGuestDetails()
            self.view.layoutIfNeeded()
            self.view.endEditing(true)
        }
        
    }
    
    //ENGAGE0011784 -- End
    
    
    //Added by kiran V2.8 -- ENGAGE0011784 -- modified to include the changes for existing guests functionality
    //ENGAGE0011784 -- Start
    ///Pops the current view controller from the navigation controller
    @objc private func guestLeftEdgeAction(sender : UIScreenEdgePanGestureRecognizer)
    {
        if self.showingExistingUserSpecialOption
        {
            self.showDiningAdditionalOptions(bool: false)
        }
        else
        {
            self.navigationController?.popViewController(animated: true)
        }
    }
    //ENGAGE0011784 -- End
    
    @IBAction func loadMoreClicked(_ sender: UIButton)
    {
        self.existingGuestPageNumber += 1
        self.isLoadMoreClicked = true
        self.getGuestList()
    }
    
    
    
}
//ENGAGE0011784 -- End

//Added by kiran V2.8 -- ENGAGE0011784 -- Added these functions to organise the setup.
//ENGAGE0011784 -- Start
//MARK:- Custom Methods
extension AddGuestRegVC
{
    private func initialSetups()
    {
        self.viewAddToMyBuddyList.isHidden = self.hideAddtoBuddy//(isOnlyFor == "Golf" || self.hideAddtoBuddy)
        //Added by kiran V2.8 -- ENGAGE0011784 -- Added last name field.
        //ENGAGE0011784 -- Start
        self.viewExistingGuestAddToBuddy.isHidden = self.hideExistingGuestAddToBuddy
        self.txtGuestLastName.delegate = self
        //ENGAGE0011784 -- End
        //Added on 4th September 2020 V2.3
        self.viewGender.isHidden = self.isGenderHidden
        self.lblGender.text = self.appDelegate.masterLabeling.BMS_Gender
        self.txtGender.placeholder = self.appDelegate.masterLabeling.BMS_Gender
        //Added on 23rd Spetmeber 2020 V2.3
        self.viewDOB.isHidden = self.isDOBHidden
        self.lblDOB.text = self.appDelegate.masterLabeling.BMS_GuestDOB
        self.txtDOB.placeholder = self.appDelegate.masterLabeling.BMS_GuestDOB
        
        self.viewModifyGuestName.isHidden = true
        self.searchBarModifyGuestName.isUserInteractionEnabled = false
        self.searchBarModifyGuestName.setImage(UIImage.init(), for: .clear, state: .normal)
        self.searchBarModifyGuestName.searchBarStyle = .default
        self.searchBarModifyGuestName.backgroundImage = UIImage.init()
        
        self.relationPicker = UIPickerView()
        self.relationPicker?.dataSource = self
        self.relationPicker?.delegate = self
        self.txtTypeOfGuest.inputView = relationPicker
        self.txtTypeOfGuest.delegate = self
        
        //Added on 4th September 2020 V2.3
        self.genderPicker = UIPickerView()
        self.genderPicker?.dataSource = self
        self.genderPicker?.delegate = self
        self.txtGender.inputView = self.genderPicker
        self.txtGender.delegate = self
        self.txtGender.setRightIcon(imageName: "Path 1847")
        
        //Added on 23rd September 2020 2.3
        self.DOBPicker = UIDatePicker.init()
        self.DOBPicker?.datePickerMode = .date
        self.DOBPicker?.setDate(Date(), animated: true)
        self.DOBPicker?.maximumDate = Date()
        self.DOBPicker?.addTarget(self, action: #selector(didDOBDateChange(datePicker:)), for: .valueChanged)
        
        //Added by kiran V2.8 -- ENGAGE0011784 -- Show Existing guest by default
        //ENGAGE0011784 -- Start
        let footerView = UIView()
        footerView.backgroundColor = .clear
        
        self.tblViewExistingGuests.delegate = self
        self.tblViewExistingGuests.dataSource = self
        self.tblViewExistingGuests.tableFooterView = footerView
        self.tblViewExistingGuests.estimatedRowHeight = 30
        self.tblViewExistingGuests.rowHeight = UITableViewAutomaticDimension
        self.tblViewExistingGuests.estimatedSectionFooterHeight = 40
        self.tblViewExistingGuests.register(UINib.init(nibName: "MemberTableViewCell", bundle: nil
        ), forCellReuseIdentifier: "MemberTableViewCell")
        self.tblViewExistingGuests.separatorStyle = .none

        //Name suggestions tableview
        self.tblViewNameSuggetions.delegate = self
        self.tblViewNameSuggetions.dataSource = self
        self.tblViewNameSuggetions.tableFooterView = footerView
        self.tblViewNameSuggetions.estimatedRowHeight = 30
        self.tblViewNameSuggetions.rowHeight = UITableViewAutomaticDimension
        self.tblViewNameSuggetions.register(UINib.init(nibName: "GuestNameSuggestionTableViewCell", bundle: nil), forCellReuseIdentifier: "GuestNameSuggestionTableViewCell")
        self.tblViewNameSuggetions.separatorStyle = .none

        //ENGAGE0011784 -- End
        
        //Added on 14th October 2020 V2.3
        //Added for iOS 14 date picker change
        if #available(iOS 14.0,*)
        {
            self.DOBPicker?.preferredDatePickerStyle = .wheels
        }
        
        self.txtDOB.setRightIcon(imageName: "Icon_Calendar")
        self.txtDOB.inputView = self.DOBPicker
        self.txtDOB.delegate = self
        
        self.txtTypeOfGuest.setRightIcon(imageName: "Path 1847")
        
        navigationItem.title = appDelegate.masterLabeling.tT_ADD_GUEST
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
        
        self.searchBarGuest.delegate = self
        
        //Added by kiran V2.8 -- ENGAGE0011784 -- Show Existing guest by default
        //ENGAGE0011784 -- Start
        self.imgViewExistingGuestOption.image = UIImage.init(named:"radio_Unselected")
        self.imgViewNewGuestOption.image =  UIImage.init(named:"radio_Unselected")
        
        switch self.screenType
        {
        case .add:
            
            if self.showExistingGuestsOption
            {
                self.showExistingGuestsView()
                self.btnExistingGuestOption.isSelected = true
                self.btnNewGuestOption.isSelected = false
                self.imgViewExistingGuestOption.image = UIImage.init(named:"radio_selected")
            }
            else
            {
                self.showNewGuestView()
                self.btnExistingGuestOption.isSelected = false
                self.btnNewGuestOption.isSelected = true
                self.imgViewNewGuestOption.image = UIImage.init(named:"radio_selected")
            }
            
            
        case .modify,.view:
            
            self.showModifyView()
            
            if self.screenType == .view
            {
                self.mainView.isUserInteractionEnabled = false
                //self.viewBottom.isHidden = true
                self.heightViewBottom.constant = 0
                self.mainView.layoutIfNeeded()
            }
        }

        self.viewBottom.clipsToBounds = true
        //ENGAGE0011784 -- End
        self.viewGuestOption.clipsToBounds = true
        
        self.setViewsLayout()
        self.applyFontColors()
        self.applyLangData()
        
        //Added by kiran V2.8 -- ENGAGE0011784 -- Commented as the view associated to this is removed from storyboard as this style of showing suggestions is no longer suitable when name is split into first name and lastname .
        //ENGAGE0011784 -- Start
        //self.guestTableview.separatorStyle = .none
        //ENGAGE0011784 -- End
        
        self.selectedRelation = self.appDelegate.arrGuestType[1]
        self.txtTypeOfGuest.text = self.selectedRelation?.name
        self.SearchData = self.AllData
        
        //Incase of modify arrTotalList holds the details of the guest/Existing get which was reveived from the api.
        if self.screenType == .modify || self.screenType == .view
        {
            /* Commented as this is hadnled above
            if self.screenType == .view
            {
                self.mainView.isUserInteractionEnabled = false
                self.viewBottom.isHidden = true
                //Added by kiran V2.8 -- ENGAGE0011784
                //ENGAGE0011784 -- Start
                //self.heightViewBottom.constant = 0
                //ENGAGE0011784 -- End
            }*/
            
            if arrTotalList[0] is GroupDetail
            {
                let guestObj = arrTotalList[0] as! GroupDetail
                
                self.txtSpecify.text = guestObj.dietary ?? ""
                
                //Added by kiran V2.8 -- ENGAGE0011784 -- replaced guest name with first name. And added first name, last name, DOb and gender
                //ENGAGE0011784 -- Start
                self.txtGuestFirstname.text = guestObj.guestFirstName//guestObj.guestName
                
                //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                //ENGAGE0011843 -- Start
                self.txtTypeOfGuest.text = CustomFunctions.shared.guestTypeDisplayName(id: guestObj.guestType)
                self.selectedRelation = self.appDelegate.arrGuestType.first(where: {$0.value == guestObj.guestType})
                //self.txtTypeOfGuest.text = guestObj.guestType
                //ENGAGE0011843 -- End
                
                self.txtPrimaryEmail.text = guestObj.email
                self.txtCellPhone.text = guestObj.cellPhone
                
                self.txtGuestLastName.text = guestObj.guestLastName
                self.txtDOB.text = guestObj.guestDOB
                self.txtGender.text = guestObj.guestGender
                
                self.searchBarModifyGuestName.text = guestObj.name
                //ENGAGE0011784 -- End
                if  guestObj.highchair == 0
                {
                    self.highChairValue = 0
                    self.arrHighChair.append("")
                }
                else
                {
                    self.lblHighChair.text = String(format: "%02d", guestObj.highchair ?? 1)
                    self.btnHighChair.isSelected = true
                    self.btnHighChair.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    for _ in 0 ..< guestObj.highchair!
                    {
                        self.arrHighChair.append("")
                    }
                }
                
                if  guestObj.boosterCount == 0
                {
                    self.boosterValue = 0
                    self.arrBooster.append("")
                }
                else
                {
                    self.lblBooster.text = String(format: "%02d", guestObj.boosterCount ?? 1)
                    self.btnBooster.isSelected = true
                    self.btnBooster.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    for _ in 0 ..< guestObj.boosterCount!
                    {
                        self.arrBooster.append("")
                    }
                }
                
                if arrSpecialOccasion[0] is GroupDetail
                {
                    let guestObj = arrSpecialOccasion[0] as! GroupDetail
                    
                    if guestObj.birthDay == 0
                    {
                        self.birthDay = 0
                        self.btnBirthDay.isSelected = false
                        self.btnBirthDay.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                    
                    }
                    else if guestObj.birthDay == 1
                    {
                        self.btnBirthDay.isSelected = true
                        self.btnBirthDay.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                        self.birthDay = 1
                    }
                    
                    if guestObj.anniversary == 0
                    {
                        self.btnAnniversary.isSelected = false
                        self.btnAnniversary.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                        self.anniversary = 0
                    }
                    else if guestObj.anniversary == 1
                    {
                        self.btnAnniversary.isSelected = true
                        self.btnAnniversary.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                        self.anniversary = 1
                    }
                    
                    if guestObj.other == 0
                    {
                        self.btnOther.isSelected = false
                        self.btnOther.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                        self.other = 0
                        //Added by kiran V2.8 -- ENGAGE0011784
                        //ENGAGE0011784 -- Start
                        //self.heightOtherText.constant = -117
                        self.viewTxtOther.isHidden = true
                        //self.heightSpecialOccassion.constant = 173
                        //ENGAGE0011784 -- End
                        self.txtOther.isHidden = true
                    }
                    else if guestObj.other == 1
                    {
                        self.btnOther.isSelected = true
                        self.btnOther.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                        self.other = 1
                        //Added by kiran V2.8 -- ENGAGE0011784
                        //ENGAGE0011784 -- Start
                        self.viewTxtOther.isHidden = false
                        //self.heightOtherText.constant = 97
                        //self.heightSpecialOccassion.constant = 290
                        //ENGAGE0011784 -- End
                        self.txtOther.isHidden = false
                    
                        self.txtOther.layer.cornerRadius = 6
                        self.txtOther.layer.borderWidth = 1
                        self.txtOther.layer.borderWidth = 0.25
                        //Added by kiran V2.8 -- ENGAGE0011784 -- replacing colors with app colors.
                        //ENGAGE0011784 -- Start
                        self.txtOther.layer.borderColor = APPColor.OtherColors.borderColor.cgColor//hexStringToUIColor(hex: "2D2D2D").cgColor
                    
                        //ENGAGE0011784 -- End
                    }
                
                    self.txtOther.text = guestObj.otherText ?? ""
                    
                }
                
            }
            else if arrTotalList[0] is GuestInfo
            {
                let memberObj = arrTotalList[0] as! GuestInfo
                //Added by kiran V2.8 -- ENGAGE0011784 -- replaced guest name with first name.
                //ENGAGE0011784 -- Start
                
                self.txtGuestFirstname.text = memberObj.guestFirstName //memberObj.guestName
                //ENGAGE0011784 -- End
                
                self.searchBarModifyGuestName.text = memberObj.guestName
                
                //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                //ENGAGE0011843 -- Start
                self.txtTypeOfGuest.text = CustomFunctions.shared.guestTypeDisplayName(id: memberObj.guestType)
                self.selectedRelation = self.appDelegate.arrGuestType.first(where: {$0.value == memberObj.guestType})
                //self.txtTypeOfGuest.text = memberObj.guestType
                //ENGAGE0011843 -- End
                
                self.txtPrimaryEmail.text = memberObj.email
                self.txtCellPhone.text = memberObj.cellPhone
                //Added on 4th September 2020 V2.3
                self.txtGender.text = memberObj.guestGender
                
                //Added on 24th September 2020 V2.3
                self.txtDOB.text = memberObj.guestDOB
                
                //Added by kiran V2.8 -- ENGAGE0011784 -- Added last name.
                //ENGAGE0011784 -- Start
                self.txtGuestLastName.text = memberObj.guestLastName
                //ENGAGE0011784 -- End
                
                self.txtSpecify.text = memberObj.dietaryRestrictions ?? ""
                
                if  memberObj.highChairCount == 0
                {
                    self.highChairValue = 0
                    self.arrHighChair.append("")
                }
                else
                {
                    self.lblHighChair.text = String(format: "%02d", memberObj.highChairCount ?? 1)
                    self.btnHighChair.isSelected = true
                    self.btnHighChair.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    for _ in 0 ..< memberObj.highChairCount!
                    {
                        self.arrHighChair.append("")
                    }
                }
                
                if  memberObj.boosterChairCount == 0
                {
                    self.boosterValue = 0
                    self.arrBooster.append("")
                    
                }
                else
                {
                    self.lblBooster.text = String(format: "%02d", memberObj.boosterChairCount ?? 1)
                    self.btnBooster.isSelected = true
                    self.btnBooster.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    for _ in 0 ..< memberObj.boosterChairCount!
                    {
                        self.arrBooster.append("")
                    }
                }
                
                if memberObj.birthDay == 0
                {
                    self.birthDay = 0
                    self.btnBirthDay.isSelected = false
                    self.btnBirthDay.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                    
                }
                else if memberObj.birthDay == 1
                {
                    self.btnBirthDay.isSelected = true
                    self.btnBirthDay.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    self.birthDay = 1
                }
                
                if memberObj.anniversary == 0
                {
                    self.btnAnniversary.isSelected = false
                    self.btnAnniversary.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                    self.anniversary = 0
                }
                else if memberObj.anniversary == 1
                {
                    self.btnAnniversary.isSelected = true
                    self.btnAnniversary.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    self.anniversary = 1
                }
                
                if memberObj.other == 0
                {
                    self.btnOther.isSelected = false
                    self.btnOther.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                    self.other = 0
                    //Added by kiran V2.8 -- ENGAGE0011784
                    //ENGAGE0011784 -- Start
                    self.viewTxtOther.isHidden = true
                    //self.heightOtherText.constant = -117
                    //self.heightSpecialOccassion.constant = 173
                    //ENGAGE0011784 -- End
                    self.txtOther.isHidden = true
                }
                else if memberObj.other == 1
                {
                    self.btnOther.isSelected = true
                    self.btnOther.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    self.other = 1
                    self.txtOther.layer.cornerRadius = 6
                    self.txtOther.layer.borderWidth = 1
                    self.txtOther.layer.borderWidth = 0.25
                    //Added by kiran V2.8 -- ENGAGE0011784 -- replacing colors with app colors.
                    //ENGAGE0011784 -- Start
                    self.txtOther.layer.borderColor = APPColor.OtherColors.borderColor.cgColor//hexStringToUIColor(hex: "2D2D2D").cgColor
                   
                    //ENGAGE0011784 -- End
                }
                
                self.txtOther.text = memberObj.otherText ?? ""
            }//Added on 5th September 2020 V2.3
            //Added to add support for modify of guest details for fitness and spa
            else if arrTotalList.first is Detail
            {
                let memberObj = arrTotalList[0] as! Detail
                //Added by kiran V2.8 -- ENGAGE0011784 -- replaced guest name with first name.
                //ENGAGE0011784 -- Start
                self.txtGuestFirstname.text = memberObj.guestFirstName//memberObj.guestName
                //ENGAGE0011784 -- End
                
                //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                //ENGAGE0011843 -- Start
                self.txtTypeOfGuest.text = CustomFunctions.shared.guestTypeDisplayName(id: memberObj.guestType)
                self.selectedRelation = self.appDelegate.arrGuestType.first(where: {$0.value == memberObj.guestType})
                //self.txtTypeOfGuest.text = memberObj.guestType
                //ENGAGE0011843 -- End
                
                self.txtPrimaryEmail.text = memberObj.email
                self.txtCellPhone.text = memberObj.cellPhone
                //Added on 4th September 2020 V2.3
                self.txtGender.text = memberObj.guestGender
                //Added on 24th September 2020 v2.3
                self.txtDOB.text = memberObj.guestDOB
                //Added by kiran V2.8 -- ENGAGE0011784 -- Added Last name for guest.
                //ENGAGE0011784 -- Start
                self.txtGuestLastName.text = memberObj.guestLastName
                //ENGAGE0011784 -- End
                
                self.searchBarModifyGuestName.text = memberObj.name
            }
            else
            {
                self.txtGuestFirstname.text = ""
            }
            
        }
        else
        {
            self.arrBooster.append("")
            self.arrHighChair.append("")
            self.btnDecreaseHighChair.isEnabled = false
            self.btnDecreaseBooster.isEnabled = false
            //Added by kiran V2.8 -- ENGAGE0011784
            //ENGAGE0011784 -- Start
            self.viewTxtOther.isHidden = true
            //self.heightOtherText.constant = -117
           // self.heightSpecialOccassion.constant = 173
            //ENGAGE0011784 -- End
            self.txtOther.isHidden = true
            if self.usedForModule == .golf
            {
                self.isAddToBuddy = 0
            }
            else
            {
                self.isAddToBuddy = 1
            }
            
            
            
            self.other = 0
            self.birthDay = 0
            self.anniversary = 0
            self.highChairValue = 0
            self.boosterValue = 0
            
        }

        //Added by kiran V2.8 -- ENGAGE0011784 -- modifiying the logic as moved the logic to a new place.
        //ENGAGE0011784 -- Start
        
        self.btnExistingGuestAddToBuddy.setImage(UIImage(named:"Group 2130"), for: UIControlState.selected)
        self.btnExistingGuestAddToBuddy.setImage(UIImage(named:"CheckBox_uncheck"), for: UIControlState.normal)
        
        //Note:- Any changed done to addToBuddyList for new guest should also be done in emptyNewGuestDetails function
        
        if self.usedForModule == .dining || self.usedForModule == .tennis || self.usedForModule == .diningEvents
        {
            //Shows the additional details required for dining reservation only
            //self.viewDiningSpecialRequest.isHidden = !(self.usedForModule == .dining)//(isOnlyFor == "Dining")
            //self.guestTableview.isHidden = !(self.usedForModule == .dining)//(isOnlyFor == "Dining")
            
            self.btnAddToMybuddyList.setImage(UIImage(named:"CheckBox_uncheck"), for: UIControlState.normal)
            self.btnAddToMybuddyList.isSelected = true
            self.isAddToBuddy = 0
            
        }
        else
        {
//            self.guestTableview.isHidden = true
//            self.viewDiningSpecialRequest.isHidden = true
        }
        
        //Note:- Any changed done to addToBuddyList for existing should also be done in existingUserClicked function
        if self.hideExistingGuestAddToBuddy
        {
            //Fail safe to make sure add to buddy isSelected is false when addToMyBuddy option is hidden.
            self.btnExistingGuestAddToBuddy.isSelected = false
        }
        else
        {
            if self.usedForModule == .dining || self.usedForModule == .diningEvents || self.usedForModule == .tennis
            {
                self.btnExistingGuestAddToBuddy.isSelected = false
            }
            else
            {
                self.btnExistingGuestAddToBuddy.isSelected = true
            }
          
        }
        
        //ENGAGE0011784 -- End
        //Added by kiran V2.8 -- ENGAGE0011784 -- Commented as the view associated to this is removed from storyboard as this style of showing suggestions is no longer suitable when name is split into first name and lastname .
        //ENGAGE0011784 -- Start
        //self.guestTableview.isHidden = !self.enableGuestNameSuggestions
        //ENGAGE0011784 -- End
        
        //Added by kiran V2.8 -- ENGAGE0011784 -- When add to buddy is hidden. making add to buddy as 0.
        //ENGAGE0011784 -- Start
        if self.hideAddtoBuddy
        {
            self.isAddToBuddy = 0
        }
        //ENGAGE0011784 -- End
        
        //Added by kiran V2.8 -- ENGAGE0011784 -- Fetching existing guests list if existing guest is checked by default.
        //ENGAGE0011784 -- Start
        if self.btnExistingGuestOption.isSelected
        {
            self.getGuestList()
        }
        //ENGAGE0011784 -- End
        
        
    }
    
    ///Sets borders and colors for view setups.
    private func setViewsLayout()
    {
        //Added by kiran V2.8 -- ENGAGE0011784 -- replacing colors with app colors.
        //ENGAGE0011784 -- Start
        
        //Commented as the view associated to this is removed from storyboard as this style of showing suggestions is no longer suitable when name is split into first name and lastname.
        /*
        self.guestTableview.backgroundColor = .clear
        self.guestTableview.layer.cornerRadius = 6
        self.guestTableview.layer.borderWidth = 0.25
        self.guestTableview.layer.borderColor = APPColor.OtherColors.borderColor.cgColor//hexStringToUIColor(hex: "2D2D2D").cgColor
         */
        
        self.viewGuestType.backgroundColor = .clear
        self.viewGuestType.layer.cornerRadius = 6
        self.viewGuestType.layer.borderWidth = 0.25
        self.viewGuestType.layer.borderColor = APPColor.OtherColors.borderColor.cgColor//hexStringToUIColor(hex: "2D2D2D").cgColor
        
        self.txtGuestFirstname.backgroundColor = .clear
        self.txtGuestFirstname.layer.cornerRadius = 6
        self.txtGuestFirstname.layer.borderWidth = 0.25
        self.txtGuestFirstname.layer.borderColor = APPColor.OtherColors.borderColor.cgColor//hexStringToUIColor(hex: "2D2D2D").cgColor
        self.txtGuestFirstname.setLeftPaddingPoints(15)
        
        //Added on 4th September 2020 V2.3
        self.viewTxtGender.backgroundColor = .clear
        self.viewTxtGender.layer.cornerRadius = 6
        self.viewTxtGender.layer.borderWidth = 0.25
        self.viewTxtGender.layer.borderColor = APPColor.OtherColors.borderColor.cgColor//hexStringToUIColor(hex: "2D2D2D").cgColor
        
        //Added on 24th September 2020 V2.3
        self.viewTxtDOB.backgroundColor = .clear
        self.viewTxtDOB.layer.cornerRadius = 6
        self.viewTxtDOB.layer.borderWidth = 0.25
        self.viewTxtDOB.layer.borderColor = APPColor.OtherColors.borderColor.cgColor//hexStringToUIColor(hex: "2D2D2D").cgColor
        
        self.viewCellPhone.backgroundColor = .clear
        self.viewCellPhone.layer.cornerRadius = 6
        self.viewCellPhone.layer.borderWidth = 0.25
        self.viewCellPhone.layer.borderColor = APPColor.OtherColors.borderColor.cgColor//hexStringToUIColor(hex: "2D2D2D").cgColor
        
        self.viewPrimaryEmail.backgroundColor = .clear
        self.viewPrimaryEmail.layer.cornerRadius = 6
        self.viewPrimaryEmail.layer.borderWidth = 0.25
        self.viewPrimaryEmail.layer.borderColor = APPColor.OtherColors.borderColor.cgColor//hexStringToUIColor(hex: "2D2D2D").cgColor

        self.txtSpecify.layer.cornerRadius = 6
        self.txtSpecify.layer.borderWidth = 1
        self.txtSpecify.layer.borderWidth = 0.25
        self.txtSpecify.layer.borderColor = APPColor.OtherColors.borderColor.cgColor//hexStringToUIColor(hex: "2D2D2D").cgColor
        
        self.searchBarModifyGuestName.layer.borderWidth = 1
        self.searchBarModifyGuestName.layer.borderColor = APPColor.OtherColors.appWhite.cgColor
        //ENGAGE0011784 -- End
        //Added by kiran V2.8 -- ENGAGE0011784 -- replacing view setup with custom methods use.
        //ENGAGE0011784 -- Start
        //Replaces these with the extension method for buttons.
        /*self.btnAddToMybuddyList.backgroundColor = .clear
        self.btnAddToMybuddyList.layer.cornerRadius = 22
        self.btnAddToMybuddyList.layer.borderWidth = 1
        self.btnAddToMybuddyList.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        
        self.btnAdd.backgroundColor = .clear
        self.btnAdd.layer.cornerRadius = 18
        self.btnAdd.layer.borderWidth = 1
        self.btnAdd.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        
        self.btnCancel.backgroundColor = .clear
        self.btnCancel.layer.cornerRadius = 18
        self.btnCancel.layer.borderWidth = 1
        self.btnCancel.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor*/
        
        self.btnAdd.setStyle(style: .outlined, type: .primary)
        self.btnCancel.setStyle(style: .outlined, type: .primary)
        self.btnAddToMybuddyList.setStyle(style: .outlined, type: .primary)
        self.btnExistingGuestAddToBuddy.setStyle(style: .outlined, type: .primary)
        //ENGAGE0011784 -- End
        
        //Added by kiran V2.8 -- ENGAGE0011784 -- Added last name textfield details
        //ENGAGE0011784 -- Start
        self.txtGuestLastName.backgroundColor = .clear
        self.txtGuestLastName.layer.cornerRadius = 6
        self.txtGuestLastName.layer.borderWidth = 0.25
        self.txtGuestLastName.layer.borderColor = APPColor.OtherColors.borderColor.cgColor
        self.txtGuestLastName.setLeftPaddingPoints(15)
        //ENGAGE0011784 -- End

    }
    
    ///Appplies the font and text colors for labels.
    private func applyFontColors()
    {
        self.txtGuestFirstname.font = AppFonts.regular14
        self.txtGuestFirstname.textColor = APPColor.textColor.primary
        
        self.txtGuestLastName.font = AppFonts.regular14
        self.txtGuestLastName.textColor = APPColor.textColor.primary
        
        self.txtTypeOfGuest.font = AppFonts.regular14
        self.txtTypeOfGuest.textColor = APPColor.textColor.primary
        
        self.btnAddToMybuddyList.titleLabel?.font = AppFonts.regular18
        //self.btnAddToMybuddyList.setTitleColor(APPColor.ButtonColors.primary, for: .normal)
        
        self.btnExistingGuestAddToBuddy.titleLabel?.font = AppFonts.regular18
        //self.btnExistingGuestAddToBuddy.setTitleColor(APPColor.ButtonColors.primary, for: .normal)
        
        self.lblOptiona.font = AppFonts.semibold17
        self.lblOptiona.textColor = APPColor.textColor.primaryHeader
        
        self.lblGender.font = AppFonts.regular17
        self.lblGender.textColor = APPColor.textColor.primaryHeader
        self.txtGender.font = AppFonts.regular14
        self.txtGender.textColor = APPColor.textColor.primary
        
        self.lblDOB.font = AppFonts.regular17
        self.lblDOB.textColor = APPColor.textColor.primaryHeader
        self.txtDOB.font = AppFonts.regular14
        self.txtDOB.textColor = APPColor.textColor.primary
        
        self.lblCellPhone.font = AppFonts.regular17
        self.lblCellPhone.textColor = APPColor.textColor.primaryHeader
        self.txtCellPhone.font = AppFonts.regular14
        self.txtCellPhone.textColor = APPColor.textColor.primary
        
        self.lblPrimaryEmail.font = AppFonts.regular17
        self.lblPrimaryEmail.textColor = APPColor.textColor.primaryHeader
        self.txtPrimaryEmail.font = AppFonts.regular14
        self.txtPrimaryEmail.textColor = APPColor.textColor.primary
        
        self.lbladdASpecialRequest.font = AppFonts.regular17
        self.lbladdASpecialRequest.textColor = APPColor.textColor.primary
        
        self.btnHighChair.titleLabel?.font = AppFonts.regular17
        self.btnHighChair.setTitleColor(APPColor.textColor.primary, for: .normal)
        self.lblHighChair.font = AppFonts.semibold30
        self.lblHighChair.textColor = APPColor.textColor.primary
        
        self.btnBooster.titleLabel?.font = AppFonts.regular17
        self.btnBooster.setTitleColor(APPColor.textColor.primary, for: .normal)
        self.lblBooster.font = AppFonts.semibold30
        self.lblBooster.textColor = APPColor.textColor.primary
        
        self.lblAddASpecialOccassion.font = AppFonts.regular17
        self.lblAddASpecialOccassion.textColor = APPColor.textColor.primary
        
        self.btnBirthDay.titleLabel?.font = AppFonts.regular17
        self.btnBirthDay.setTitleColor(APPColor.textColor.primary, for: .normal)
        
        self.btnAnniversary.titleLabel?.font = AppFonts.regular17
        self.btnAnniversary.setTitleColor(APPColor.textColor.primary, for: .normal)
        
        self.btnOther.titleLabel?.font = AppFonts.regular17
        self.btnOther.setTitleColor(APPColor.textColor.primary, for: .normal)
        self.txtOther.font = AppFonts.regular14
        self.txtOther.textColor = APPColor.textColor.primary
        
        self.lblShouldWeBeaware.font = AppFonts.regular16
        self.lblShouldWeBeaware.textColor = APPColor.textColor.primary
        self.txtSpecify.font = AppFonts.regular14
        self.txtSpecify.textColor = APPColor.textColor.primary
        
        self.viewModifyGuestName.backgroundColor = APPColor.OtherColors.appWhite
        
        if #available(iOS 13.0, *)
        {
            self.searchBarGuest.searchTextField.textColor = APPColor.textColor.primary
            self.searchBarGuest.searchTextField.font = AppFonts.regular16
             
            self.searchBarModifyGuestName.searchTextField.textColor = APPColor.textColor.primary
            self.searchBarModifyGuestName.searchTextField.font = AppFonts.regular16
        }
        else
        {
            
        }
        
        self.lblExistingGuestOption.font = AppFonts.semibold17
        self.lblExistingGuestOption.textColor = APPColor.textColor.primary
        
        self.lblNewGuestOption.font = AppFonts.semibold17
        self.lblNewGuestOption.textColor = APPColor.textColor.primary

        self.viewNewGuestName.backgroundColor = .white//APPColor.OtherColors.appWhite
        self.viewSearchBar.backgroundColor = APPColor.OtherColors.appWhite
        self.searchBarGuest.tintColor = APPColor.searchbarColors.curserColor
        
        self.viewBottom.backgroundColor = APPColor.OtherColors.appWhite

    }
    
    private func applyLangData()
    {
        //Added by kiran V2.8 -- ENGAGE0011784 -- getting the text from language file. Not added previously.
        //ENGAGE0011784 -- Start
    
        self.lblExistingGuestOption.text = self.appDelegate.masterLabeling.go_Existing_Guest
        self.lblNewGuestOption.text = self.appDelegate.masterLabeling.go_New_Guest
        
        if self.usedForModule == .events
        {
            self.txtGuestFirstname.placeholder = appDelegate.masterLabeling.tYPE_GUEST_NAME_ASTERISK
            self.viewNewGuestDetails.isHidden = true
            let selectGuest: NSMutableAttributedString = NSMutableAttributedString(string: self.txtGuestFirstname.placeholder!)
            selectGuest.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
            self.txtGuestFirstname.attributedPlaceholder = selectGuest
        }
        else
        {
            self.txtGuestFirstname.placeholder = self.appDelegate.masterLabeling.go_First_Name
            self.txtGuestLastName.placeholder = self.appDelegate.masterLabeling.go_Last_Name
        }
        
        self.searchBarGuest.placeholder = self.appDelegate.masterLabeling.go_Search_Guest_Name
        
        self.btnAddToMybuddyList.setTitle(appDelegate.masterLabeling.add_to_buddylist, for: UIControlState.normal)
        
        self.btnExistingGuestAddToBuddy.setTitle(appDelegate.masterLabeling.add_to_buddylist, for: UIControlState.normal)
        
        self.lblOptiona.text = self.appDelegate.masterLabeling.BMS_Optional
        
        self.lblCellPhone.text = self.appDelegate.masterLabeling.cELL_PHONE
        self.txtCellPhone.placeholder = self.appDelegate.masterLabeling.cELL_PHONE
        
        self.lblPrimaryEmail.text = self.appDelegate.masterLabeling.pRIMARY_EMAIL
        self.txtPrimaryEmail.placeholder = self.appDelegate.masterLabeling.pRIMARY_EMAIL
        
        self.lbladdASpecialRequest.text = self.appDelegate.masterLabeling.special_request_add
        self.btnHighChair.setTitle(self.appDelegate.masterLabeling.hIGH_CHAIR, for: .normal)
        self.btnBooster.setTitle(self.appDelegate.masterLabeling.bOOSTER_SEAT, for: .normal)
        
        self.lblAddASpecialOccassion.text = self.appDelegate.masterLabeling.aDD_SPECIAL_OCCASSION_COLON
        
        if DataManager.shared.specialOccasion.count > 0
        {
            self.btnBirthDay.setTitle(DataManager.shared.specialOccasion.first?.name ?? "", for: .normal)
        }
        
        if DataManager.shared.specialOccasion.count >= 2
        {
            self.btnAnniversary.setTitle(DataManager.shared.specialOccasion[1].name ?? "", for: .normal)
        }
        
        if DataManager.shared.specialOccasion.count >= 3
        {
            self.btnOther.setTitle(DataManager.shared.specialOccasion[2].name ?? "", for: .normal)
        }
        
        self.lblShouldWeBeaware.text = self.appDelegate.masterLabeling.dIETARY_RESTRICTIONS_INFO
        
        self.btnAdd.setTitle(self.appDelegate.masterLabeling.aDD, for: .normal)
        self.btnCancel.setTitle(self.appDelegate.masterLabeling.cANCEL, for: .normal)
        
        //ENGAGE0011784 -- End
    }
    
    //Added by kiran V2.8 -- ENGAGE0011784 -- modified to include the changes for existing guests functionality
    //ENGAGE0011784 -- Start
    ///Enables Left edge swipe to dismiss view controller.
    func addLeftEdgeSwipeAction()
    {
        let leftEdgeGestureRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(self.guestLeftEdgeAction(sender:)))
        leftEdgeGestureRecognizer.edges = .left
        self.view.addGestureRecognizer(leftEdgeGestureRecognizer)
    }
    //ENGAGE0011784 -- End
    
    func sendResponce()
    {
        
        let guestInfo = self.generateGuestInfoObject()
        self.memberDelegate?.requestMemberViewControllerResponse(selecteArray: [guestInfo])
        self.navigationController?.popViewController(animated: true)
        
        //TODO:- Remove once V2.8 goes live or the ticket is approved in UAT. moved this logic to generateGuestInfoObject function
        /*
        if boosterValue == 0
        {
            self.arrBooster.removeAll()
        }
        
        if highChairValue == 0
        {
            self.arrHighChair.removeAll()
        }
        
        let guestInfo = GuestInfo.init()
        
        //Added on 4th September 2020 v2.3
        var guestGender = ""
        var dob = ""
        var linkedMemberID = ""
        var guestMemberNo = ""
        
        //Guest gender and DOB are passed on in case of modify for fitness and spa. gender is replaced with the gender textfield value if its visible , dob is replaced with the dob textfield value if its visible.
        
        //Modified by Kiran V2.7 -- GATHER0000700 - Changed fitnessSpa with generic code BMS as guests should behave same for fitness & spa and Tennis book a lesson.
        //GATHER0000700 - Start
        if self.screenType == .modify && CustomFunctions.shared.isBMSModule(self.usedForModule) //(self.usedForModule == .BMS || self.usedForModule == .bookALessonTennis || self.usedForModule == .fitnessSpa)//self.isOnlyFor == "BMS"//"FitnessSpa"
        {//GATHER0000700 - End
            if let details = self.arrTotalList.first as? GuestInfo
            {
                dob = details.guestDOB ?? ""
                guestGender = details.guestGender ?? ""
                guestInfo.appointmentMemberID = details.appointmentMemberID
                
                linkedMemberID = details.linkedMemberID ?? ""
                guestMemberNo = details.guestMemberNo ?? ""
                
                /*
                guestInfo.linkedMemberID = details.linkedMemberID
                guestInfo.guestMemberNo = details.guestMemberNo
                 */
            }
            else if let details = self.arrTotalList.first as? Detail
            {
                dob = details.guestDOB ?? ""
                guestGender = details.guestGender ?? ""
                guestInfo.appointmentMemberID = details.appointmentMemberID
                
                linkedMemberID = details.id ?? ""
                guestMemberNo = details.guestMemberNo ?? ""
                /*
                guestInfo.linkedMemberID = details.id
                guestInfo.guestMemberNo = details.guestMemberNo
                */
            }
        }
        
        //When guest gender popup is show then the value in the text field have highest preference
        if !self.isGenderHidden
        {
            guestGender = self.txtGender.text ?? ""
        }

        //Added on 24th September 2020 V2.3
        //When guest DOB popup is shown then the value in the text field have highest preference
        if !self.isDOBHidden
        {
            dob = self.txtDOB.text ?? ""
        }
        
        if self.showExistingGuestsOption && self.btnExistingGuestOption.isSelected
        {
            guestInfo.isExistingGuest = true
            if self.usedForModule == .dining || self.usedForModule == .diningEvents
            {
                guestInfo.setGuestDetails(name: self.selectedGuest?.memberName ?? "", firstName: self.selectedGuest?.firstName ?? "", lastName: self.selectedGuest?.lastName ?? "",linkedMemberID: self.selectedGuest?.ID ?? "",guestMemberNo: "",gender : "",DOB: "", buddyID: "", type: "", phone: "", primaryemail: "" , highChair: self.arrHighChair.count, booster: self.arrBooster.count, dietary: self.txtSpecify.text ?? "", addGuestAsBuddy: 0, otherNo: self.other ?? 0 , otherTextInformation: self.txtOther.text, birthdayNo: self.birthDay ?? 0, anniversaryNo: self.anniversary ?? 0)
            }
            else if self.usedForModule == .events
            {
                
            }
            else
            {
                guestInfo.setGuestDetails(name: self.selectedGuest?.memberName ?? "", firstName: self.selectedGuest?.firstName ?? "", lastName: self.selectedGuest?.lastName ?? "",linkedMemberID: self.selectedGuest?.ID ?? "",guestMemberNo: "",gender : "",DOB: "", buddyID: "", type: "", phone: "", primaryemail: "", highChair: 0, booster: 0, dietary: "", addGuestAsBuddy: 0, otherNo: 0 , otherTextInformation: "", birthdayNo: 0, anniversaryNo: 0)
            }
            
        }
        else
        {
            guestInfo.isExistingGuest = false
            
            if self.usedForModule == .events
            {
                if self.txtGuestFirstname.text == ""
                {
                    SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:self.appDelegate.masterLabeling.gUEST_NAME_REQUIRED, withDuration: Duration.kMediumDuration)
                }
                else
                {
                    var memberName = ""
                    
                    if (self.txtGuestFirstname.text ?? "").count > 0 && (self.txtGuestLastName.text ?? "").count > 0
                    {
                        memberName = "\(self.txtGuestLastName.text ?? ""), \(self.txtGuestFirstname.text ?? "")"
                    }
                    else if (self.txtGuestFirstname.text ?? "").count > 0
                    {
                        memberName = self.txtGuestFirstname.text ?? ""
                    }
                    else if (self.txtGuestLastName.text ?? "").count > 0
                    {
                        memberName = self.txtGuestLastName.text ?? ""
                    }
                    
                    guestInfo.setGuestDetails(name: memberName, firstName: self.txtGuestFirstname.text ?? "", lastName: self.txtGuestLastName.text ?? "",linkedMemberID: "",guestMemberNo: "",gender : guestGender, DOB: dob, buddyID: "", type:"", phone: "", primaryemail: "", highChair: 0, booster: 0, dietary: "", addGuestAsBuddy: self.isAddToBuddy ?? 0, otherNo: 0 , otherTextInformation: "", birthdayNo: 0, anniversaryNo: 0)
//                    self.memberDelegate?.requestMemberViewControllerResponse(selecteArray: [guestInfo])
//                    self.navigationController?.popViewController(animated: true)
                }
            }
            else if self.usedForModule == .golf || self.usedForModule == .tennis ||  CustomFunctions.shared.isBMSModule(self.usedForModule) //self.usedForModule == .BMS || self.usedForModule == .bookALessonTennis || self.usedForModule == .fitnessSpa
            {
                
                if self.txtGuestLastName.text == ""
                {
                    if self.usedForModule == .tennis
                    {
                        //TODO:- Langfile
                        self.txtGuestLastName.text = "Guest"
                    }
                    else
                    {
                        self.txtGuestLastName.text = self.appDelegate.masterLabeling.gUESTNAME_FORMAT
                    }
                   
                }
                
                var memberName = ""
                
                if (self.txtGuestFirstname.text ?? "").count > 0 && (self.txtGuestLastName.text ?? "").count > 0
                {
                    memberName = "\(self.txtGuestLastName.text ?? ""), \(self.txtGuestFirstname.text ?? "")"
                }
                else if (self.txtGuestFirstname.text ?? "").count > 0
                {
                    memberName = self.txtGuestFirstname.text ?? ""
                }
                else if (self.txtGuestLastName.text ?? "").count > 0
                {
                    memberName = self.txtGuestLastName.text ?? ""
                }

                
                guestInfo.setGuestDetails(name: memberName, firstName: self.txtGuestFirstname.text ?? "", lastName: self.txtGuestLastName.text ?? "",linkedMemberID: linkedMemberID,guestMemberNo: guestMemberNo,gender : guestGender,DOB: dob, buddyID: "", type: self.txtTypeOfGuest.text ?? "", phone: self.txtCellPhone.text ?? "", primaryemail: self.txtPrimaryEmail.text ?? "", highChair: 0, booster: 0, dietary: "", addGuestAsBuddy: self.isAddToBuddy ?? 0, otherNo: 0 , otherTextInformation: "", birthdayNo: 0, anniversaryNo: 0)
                //Added on 16th june 2020 for bms
                //Modified by Kiran V2.7 -- GATHER0000700 - Changed fitnessSpa with generic code BMS as guests should behave same for fitness & spa and Tennis book a lesson.
                //GATHER0000700 - Start
//                if self.usedForModule == .BMS || self.usedForModule == .bookALessonTennis || self.usedForModule == .fitnessSpa
//                {//GATHER0000700 - End
//                    guestInfo.isEmpty = false
//                }
                
            }
            else if self.usedForModule == .dining || self.usedForModule == .diningEvents
            {
                if self.txtGuestLastName.text == ""
                {
                    self.txtGuestLastName.text = self.appDelegate.masterLabeling.gUESTNAME_FORMAT
                }
                
                var memberName = ""
                
                if (self.txtGuestFirstname.text ?? "").count > 0 && (self.txtGuestLastName.text ?? "").count > 0
                {
                    memberName = "\(self.txtGuestLastName.text ?? ""), \(self.txtGuestFirstname.text ?? "")"
                }
                else if (self.txtGuestFirstname.text ?? "").count > 0
                {
                    memberName = self.txtGuestFirstname.text ?? ""
                }
                else if (self.txtGuestLastName.text ?? "").count > 0
                {
                    memberName = self.txtGuestLastName.text ?? ""
                }
                
                guestInfo.setGuestDetails(name: memberName, firstName: self.txtGuestFirstname.text ?? "", lastName: self.txtGuestLastName.text ?? "",linkedMemberID: "",guestMemberNo: "",gender : guestGender,DOB: dob, buddyID: "", type: self.txtTypeOfGuest.text ?? "", phone: self.txtCellPhone.text ?? "", primaryemail: self.txtPrimaryEmail.text ?? "" , highChair: self.arrHighChair.count, booster: self.arrBooster.count, dietary: self.txtSpecify.text ?? "", addGuestAsBuddy: self.isAddToBuddy ?? 0, otherNo: self.other ?? 0 , otherTextInformation: self.txtOther.text, birthdayNo: self.birthDay ?? 0, anniversaryNo: self.anniversary ?? 0)
            }
            
        }
        
        guestInfo.isEmpty = false
        self.memberDelegate?.requestMemberViewControllerResponse(selecteArray: [guestInfo])
        self.navigationController?.popViewController(animated: true)
         */
        
        
        //OLd logic. Do not remove for now
        /*
         if isFrom == "EventGuest"
         {
             if txtGuestFirstname.text == ""
             {
                 SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:self.appDelegate.masterLabeling.gUEST_NAME_REQUIRED, withDuration: Duration.kMediumDuration)
             }
             else
             {
                 guestInfo.setGuestDetails(name: txtGuestFirstname.text ?? "",gender : guestGender, DOB: dob, buddyID: "", type:"", phone: "", primaryemail: "", highChair: 0, booster: 0, dietary: "", addGuestAsBuddy: isAddToBuddy ?? 0, otherNo: 0 , otherTextInformation: "", birthdayNo: 0, anniversaryNo: 0)
                 memberDelegate?.requestMemberViewControllerResponse(selecteArray: [guestInfo])
                 self.navigationController?.popViewController(animated: true)
             }
         }
         else
         {
             if isFrom == "Request"
             {
                 if txtGuestFirstname.text == ""
                 {
                     txtGuestFirstname.text = self.appDelegate.masterLabeling.gUESTNAME_FORMAT
                 }
                 guestInfo.setGuestDetails(name: txtGuestFirstname.text ?? "",gender : guestGender,DOB: dob, buddyID: "", type: txtTypeOfGuest.text ?? "", phone: txtCellPhone.text ?? "", primaryemail: txtPrimaryEmail.text ?? "", highChair: 0, booster: 0, dietary: "", addGuestAsBuddy: isAddToBuddy ?? 0, otherNo: 0 , otherTextInformation: "", birthdayNo: 0, anniversaryNo: 0)
                 //Added on 16th june 202o for bms
                 //Modified by Kiran V2.7 -- GATHER0000700 - Changed fitnessSpa with generic code BMS as guests should behave same for fitness & spa and Tennis book a lesson.
                 //GATHER0000700 - Start
                 if self.isOnlyFor == "BMS"//"FitnessSpa"
                 {//GATHER0000700 - End
                     guestInfo.isEmpty = false
                 }
             }
             else
             {
                 if txtGuestFirstname.text == ""
                 {
                     txtGuestFirstname.text = self.appDelegate.masterLabeling.gUESTNAME_FORMAT
                 }
                 guestInfo.setGuestDetails(name: txtGuestFirstname.text ?? "",gender : guestGender,DOB: dob, buddyID: "", type: txtTypeOfGuest.text ?? "", phone: txtCellPhone.text ?? "", primaryemail: txtPrimaryEmail.text ?? "" , highChair: arrHighChair.count, booster: arrBooster.count, dietary: txtSpecify.text ?? "", addGuestAsBuddy: isAddToBuddy ?? 0, otherNo: other ?? 0 , otherTextInformation: txtOther.text, birthdayNo: birthDay ?? 0, anniversaryNo: anniversary ?? 0)
                 
             }
             
             
             if txtPrimaryEmail.text == ""
             {
                 if isOnlyFrom == "RequestCourt" || isOnlyFor == "Dining"  || isOnlyFor == "Golf"{
                     memberDelegate?.requestMemberViewControllerResponse(selecteArray: [guestInfo])
                     self.navigationController?.popViewController(animated: true)
                 } else {
                     memberDelegate?.requestMemberViewControllerResponse(selecteArray: [guestInfo])
                     self.navigationController?.popViewController(animated: true)
                 }
             }
             else
             {
 //                if isValidEmail(testStr: txtPrimaryEmail.text!){
                     if isOnlyFrom == "RequestCourt" || isOnlyFor == "Dining"  || isOnlyFor == "Golf"
                     {
                         memberDelegate?.requestMemberViewControllerResponse(selecteArray: [guestInfo])
                         self.navigationController?.popViewController(animated: true)
                     }
                     else
                     {
                         memberDelegate?.requestMemberViewControllerResponse(selecteArray: [guestInfo])
                         self.navigationController?.popViewController(animated: true)
                     }
                     
                  /*
                 }
                 else
                  {

                     SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:self.appDelegate.masterLabeling.eRR_MSG_EMAIL, withDuration: Duration.kMediumDuration)

                 }
                 */
             }
             
         }
         */

    }
    
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    

    func checkCellPhoneNumberFormat(string: String?, str: String?) -> Bool
    {
        //Added by kiran V2.8 -- ENGAGE0011784 -- Removed depricated methods
        //ENGAGE0011784 -- Start
        /*if string == ""
        { //BackSpace
            return true
        }
        else if str!.characters.count  == 4
        {
            txtCellPhone.text = txtCellPhone.text! + "-"
        }
        else if str!.characters.count == 8
        {
            txtCellPhone.text = txtCellPhone.text! + "-"
        }
        else if str!.characters.count > 12
        {
            return false
        }*/
        
        if string == ""
        { //BackSpace
            return true
        }
        else if str!.count  == 4
        {
            txtCellPhone.text = txtCellPhone.text! + "-"
        }
        else if str!.count == 8
        {
            txtCellPhone.text = txtCellPhone.text! + "-"
        }
        else if str!.count > 12
        {
            return false
        }
        //ENGAGE0011784 -- End
        return true
    }
    
    ///Shows/Hides special options with clicked on Guest listing in case of dining.
    private func showDiningAdditionalOptions(bool : Bool)
    {
        self.viewExistingGuestList.isHidden = bool
        self.viewNewGuest.isHidden = !bool
        self.viewNewGuestName.isHidden = bool
        self.viewNewGuestDetails.isHidden = bool
        self.viewDiningSpecialRequest.isHidden = !bool
        //self.viewBottom.isHidden = !bool
        self.heightViewBottom.constant = (!bool ? 0 : 78)
        
        if bool
        {
            self.heightViewGuestOptions.constant = 0
        }
        else
        {
            self.heightViewGuestOptions.constant = self.guestOptionHeight
        }
        
        self.showingExistingUserSpecialOption = bool
        
        self.viewModifyGuestName.isHidden = !bool
        self.searchBarModifyGuestName.text = (!bool) ? "" : (self.selectedGuest?.memberName ?? "")
    }
    
    private func showNewGuestView()
    {
        self.viewExistingGuestList.isHidden = true
        self.viewNewGuest.isHidden = false
        self.viewNewGuestName.isHidden = false
        self.viewNewGuestDetails.isHidden = false
        self.viewDiningSpecialRequest.isHidden = !(self.usedForModule == .dining || self.usedForModule == .diningEvents)
        //self.viewBottom.isHidden = false
        self.heightViewBottom.constant = 78
    }
    
    private func showExistingGuestsView()
    {
        self.viewExistingGuestList.isHidden = false
        self.viewNewGuest.isHidden = true
        self.viewNewGuestName.isHidden = true
        self.viewNewGuestDetails.isHidden = true
        self.viewDiningSpecialRequest.isHidden = true
        //self.viewBottom.isHidden = (self.usedForModule == .dining || self.usedForModule == .diningEvents)
        self.heightViewBottom.constant = (self.usedForModule == .dining || self.usedForModule == .diningEvents) ? 0 : 78
    }
    
    private func showModifyView()
    {
        switch self.usedForModule!
        {
        case .golf:
            break
        case .tennis:
            break
        case .dining,.diningEvents:
            //Hides existing geust view
            self.viewExistingGuestList.isHidden = true
            //Hides new guest view
            self.viewNewGuest.isHidden = false
            
            let memberType = CustomFunctions.shared.memberType(details: self.arrTotalList.first!, For: self.usedForModule)
            
            if memberType == .existingGuest
            {
                self.viewNewGuestName.isHidden = true
                self.viewNewGuestDetails.isHidden = true
                self.viewDiningSpecialRequest.isHidden = false
                //self.viewBottom.isHidden = false
                self.heightViewBottom.constant = 78
                self.viewModifyGuestName.isHidden = false
            }
            else
            {
                
                self.viewNewGuestName.isHidden = false
                self.viewNewGuestDetails.isHidden = false
                self.viewDiningSpecialRequest.isHidden = false
                //self.viewBottom.isHidden = false
                self.heightViewBottom.constant = 78
                
            }

        case .events:
            break
            //Modified by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
            //GATHER0001167 -- Start
        case .BMS,.fitnessSpa,.bookALessonTennis,.bookALessonGolf:
            //GATHER0001167 -- End
            self.viewExistingGuestList.isHidden = true
            self.viewNewGuest.isHidden = false
            self.viewNewGuestName.isHidden = false
            self.viewNewGuestDetails.isHidden = false
            self.viewDiningSpecialRequest.isHidden = true
            //self.viewBottom.isHidden = false
            self.heightViewBottom.constant = 78
            self.heightViewGuestOptions.constant = 0
        }
        
        self.view.layoutIfNeeded()
    }
    
    
    private func showSuggestions()
    {
        guard self.enableGuestNameSuggestions else{
            return
        }
        
        var textField : UITextField?
        
        if self.txtGuestFirstname.isEditing
        {
            textField = self.txtGuestFirstname
        }
        else if self.txtGuestLastName.isEditing
        {
            textField = self.txtGuestLastName
        }
        
        if let editingTxtField = textField
        {
            if self.viewPopOver.superview == nil
            {
                self.tblViewNameSuggetions.frame = CGRect(x: editingTxtField.frame.origin.x, y:  editingTxtField.frame.maxY, width:  editingTxtField.frame.size.width, height: 146)
                
                self.viewPopOver.arrowSize = CGSize(width: 0.0, height: 0.0)
                self.viewPopOver.show(tblViewNameSuggetions, point: CGPoint.init(x: editingTxtField.frame.midX, y: editingTxtField.frame.maxY), inView: self.viewNewGuest)
                self.tblViewNameSuggetions.reloadData()
            }
            else
            {
                self.tblViewNameSuggetions.reloadData()
            }
            
        }
        
    }
    
    
    private func removeSuggestions()
    {
        if self.viewPopOver.superview != nil
        {
            self.viewPopOver.dismiss()
            self.arrGuestSuggestions.removeAll()
            self.tblViewNameSuggetions.reloadData()
        }
    }
    
    private func showTostWith(memberName : String , requestedBy : String, in message : String)
    {
        let newMessage = message.replacingOccurrences(of: "{#SM}", with: memberName).replacingOccurrences(of: "{#RequestedBy}", with: requestedBy)
        
        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: newMessage , withDuration: Duration.kMediumDuration)
    }
    
    
    private func generateGuestInfoObject() -> GuestInfo
    {
        if boosterValue == 0
        {
            self.arrBooster.removeAll()
        }
        
        if highChairValue == 0
        {
            self.arrHighChair.removeAll()
        }
        
        let guestInfo = GuestInfo.init()
        
        //Added by kiran V2.8 -- ENGAGE0011784 -- Commented as there are a few changes in BMS. So removed this logic and placed it in BMS add guest if block.
        //ENGAGE0011784 -- Start
       /*
        //Added on 4th September 2020 v2.3
        var guestGender = ""
        var dob = ""
        var linkedMemberID = ""
        //var guestMemberNo = ""
        
        //Guest gender and DOB are passed on in case of modify for fitness and spa. gender is replaced with the gender textfield value if its visible , dob is replaced with the dob textfield value if its visible.
        
        //Modified by Kiran V2.7 -- GATHER0000700 - Changed fitnessSpa with generic code BMS as guests should behave same for fitness & spa and Tennis book a lesson.
        //GATHER0000700 - Start
        if self.screenType == .modify && CustomFunctions.shared.isBMSModule(self.usedForModule) //(self.usedForModule == .BMS || self.usedForModule == .bookALessonTennis || self.usedForModule == .fitnessSpa)//self.isOnlyFor == "BMS"//"FitnessSpa"
        {//GATHER0000700 - End
            if let details = self.arrTotalList.first as? GuestInfo
            {
                dob = details.guestDOB ?? ""
                guestGender = details.guestGender ?? ""
                guestInfo.appointmentMemberID = details.appointmentMemberID
                
                linkedMemberID = details.linkedMemberID ?? ""
                guestMemberNo = details.guestMemberNo ?? ""
                
                /*
                guestInfo.linkedMemberID = details.linkedMemberID
                guestInfo.guestMemberNo = details.guestMemberNo
                 */
            }
            else if let details = self.arrTotalList.first as? Detail
            {
                dob = details.guestDOB ?? ""
                guestGender = details.guestGender ?? ""
                guestInfo.appointmentMemberID = details.appointmentMemberID
                
                linkedMemberID = details.id ?? ""
                guestMemberNo = details.guestMemberNo ?? ""
                /*
                guestInfo.linkedMemberID = details.id
                guestInfo.guestMemberNo = details.guestMemberNo
                */
            }
        }
        
        //When guest gender popup is show then the value in the text field have highest preference
        if !self.isGenderHidden
        {
            guestGender = self.txtGender.text ?? ""
        }

        //Added on 24th September 2020 V2.3
        //When guest DOB popup is shown then the value in the text field have highest preference
        if !self.isDOBHidden
        {
            dob = self.txtDOB.text ?? ""
        }
        */
        //ENGAGE0011784 -- End
        
        var isExistingGuest = false
        
        if self.screenType == .modify
        {
            let memberType = CustomFunctions.shared.memberType(details: self.arrTotalList.first!, For: self.usedForModule)
            isExistingGuest = (memberType == .existingGuest)
        }
        
        if (self.showExistingGuestsOption && self.btnExistingGuestOption.isSelected) || (self.screenType == .modify && isExistingGuest)
        {//Exisitng Guest
        
            if self.screenType == .add
            {
                if self.usedForModule == .dining || self.usedForModule == .diningEvents
                {
                    guestInfo.setGuestDetails(name: self.selectedGuest?.memberName ?? "", firstName: self.selectedGuest?.firstName ?? "", lastName: self.selectedGuest?.lastName ?? "",linkedMemberID: self.selectedGuest?.ID ?? "", guestMemberOf: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",guestMemberNo: self.selectedGuest?.memberID ?? "",gender : "",DOB: "", buddyID: "", type: "", phone: "", primaryemail: "", guestLinkedMemberID: "" , highChair: self.arrHighChair.count, booster: self.arrBooster.count, dietary: self.txtSpecify.text ?? "", addGuestAsBuddy: 0, otherNo: self.other ?? 0 , otherTextInformation: self.txtOther.text, birthdayNo: self.birthDay ?? 0, anniversaryNo: self.anniversary ?? 0)
                }
                else if self.usedForModule == .events
                {
                    
                }
                else if CustomFunctions.shared.isBMSModule(self.usedForModule)
                {
                    guestInfo.guestIdentityID = self.selectedGuest?.guestIdentityID
                    //New Guest
                    if (self.selectedGuest?.ID ?? "").isEmpty
                    {
                        //let memberName = self.generateExistingGuestName()
                        guestInfo.setGuestDetails(name: self.selectedGuest?.memberName ?? "", firstName: self.selectedGuest?.guestFirstName ?? "", lastName: self.selectedGuest?.guestLastName ?? "",linkedMemberID: "", guestMemberOf: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",guestMemberNo: "",gender : self.selectedGuest?.guestGender ?? "",DOB: self.selectedGuest?.guestDOB ?? "", buddyID: "", type: self.selectedGuest?.guestType ?? "", phone: self.selectedGuest?.guestPhone ?? "", primaryemail: self.selectedGuest?.guestEmail ?? "", guestLinkedMemberID: "", highChair: 0, booster: 0, dietary: "", addGuestAsBuddy: 0, otherNo: 0 , otherTextInformation: "", birthdayNo: 0, anniversaryNo: 0)
                    }
                    else
                    {//Existing Guest
                        guestInfo.setGuestDetails(name: self.selectedGuest?.memberName ?? "", firstName: self.selectedGuest?.firstName ?? "", lastName: self.selectedGuest?.lastName ?? "",linkedMemberID: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "", guestMemberOf: "",guestMemberNo: self.selectedGuest?.memberID ?? "",gender : "",DOB: "", buddyID: "", type: "", phone: "", primaryemail: "", guestLinkedMemberID: self.selectedGuest?.ID ?? "", highChair: 0, booster: 0, dietary: "", addGuestAsBuddy: 0, otherNo: 0 , otherTextInformation: "", birthdayNo: 0, anniversaryNo: 0)
                    }
                    
                }
                else
                {
                    guestInfo.setGuestDetails(name: self.selectedGuest?.memberName ?? "", firstName: self.selectedGuest?.firstName ?? "", lastName: self.selectedGuest?.lastName ?? "",linkedMemberID: self.selectedGuest?.ID ?? "", guestMemberOf: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",guestMemberNo: self.selectedGuest?.memberID ?? "",gender : "",DOB: "", buddyID: "", type: "", phone: "", primaryemail: "", guestLinkedMemberID: "", highChair: 0, booster: 0, dietary: "", addGuestAsBuddy: 0, otherNo: 0 , otherTextInformation: "", birthdayNo: 0, anniversaryNo: 0)
                }

            }
            //Modify Case
            else
            {
                
                let guestdetails = self.generateExistingGuestModifyInfo()
                
                if self.usedForModule == .dining || self.usedForModule == .diningEvents
                {
                    
                    guestInfo.setGuestDetails(name: guestdetails.guestName ?? "", firstName: guestdetails.guestFirstName ?? "", lastName: guestdetails.guestLastName ?? "",linkedMemberID: guestdetails.linkedMemberID ?? "", guestMemberOf: guestdetails.guestMemberOf ?? "",guestMemberNo: guestdetails.guestMemberNo ?? "",gender : guestdetails.guestGender ?? "",DOB: guestdetails.guestDOB ?? "", buddyID: "", type: guestdetails.guestType ?? "", phone: guestdetails.cellPhone ?? "", primaryemail: guestdetails.email ?? "", guestLinkedMemberID: guestdetails.guestLinkedMemberID ?? "" , highChair: self.arrHighChair.count, booster: self.arrBooster.count, dietary: self.txtSpecify.text ?? "", addGuestAsBuddy: 0, otherNo: self.other ?? 0 , otherTextInformation: self.txtOther.text, birthdayNo: self.birthDay ?? 0, anniversaryNo: self.anniversary ?? 0)
                }
                else if self.usedForModule == .events
                {
                    
                }//Note:-This is an guessed logic this is not implemneted as of V2.8.Remove note after implementation
                else if CustomFunctions.shared.isBMSModule(self.usedForModule)
                {
                    guestInfo.guestIdentityID = guestdetails.guestIdentityID
                    
                    guestInfo.setGuestDetails(name: guestdetails.guestName ?? "", firstName: guestdetails.guestFirstName ?? "", lastName: guestdetails.guestLastName ?? "",linkedMemberID: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "", guestMemberOf: guestdetails.guestMemberOf ?? "",guestMemberNo: guestdetails.guestMemberNo ?? "",gender : guestdetails.guestGender ?? "",DOB: guestdetails.guestDOB ?? "", buddyID: "", type: guestdetails.guestType ?? "", phone: guestdetails.cellPhone ?? "", primaryemail: guestdetails.email ?? "", guestLinkedMemberID: guestdetails.guestLinkedMemberID ?? "" , highChair: 0, booster: 0, dietary: "", addGuestAsBuddy: 0, otherNo: 0 , otherTextInformation: "", birthdayNo:0, anniversaryNo:0)
                }
                else
                {//Note:-This is an guessed logic this is not implemneted as of V2.8.Remove note after implementation
                    guestInfo.setGuestDetails(name: guestdetails.guestName ?? "", firstName: guestdetails.guestFirstName ?? "", lastName: guestdetails.guestLastName ?? "",linkedMemberID: guestdetails.linkedMemberID ?? "", guestMemberOf: guestdetails.guestMemberOf ?? "",guestMemberNo: guestdetails.guestMemberNo ?? "",gender : guestdetails.guestGender ?? "",DOB: guestdetails.guestDOB ?? "", buddyID: "", type: guestdetails.guestType ?? "", phone: guestdetails.cellPhone ?? "", primaryemail: guestdetails.email ?? "", guestLinkedMemberID: guestdetails.guestLinkedMemberID ?? "", highChair: 0, booster: 0, dietary: "", addGuestAsBuddy: 0, otherNo: 0 , otherTextInformation: "", birthdayNo: 0, anniversaryNo: 0)
                }

            }
            
        }
        else
        {//Add new guest
            
            if self.usedForModule == .events
            {
                if self.txtGuestFirstname.text == ""
                {
                    SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:self.appDelegate.masterLabeling.gUEST_NAME_REQUIRED, withDuration: Duration.kMediumDuration)
                }
                else
                {
                    let memberName = self.generateMemberName()
                    
                    guestInfo.setGuestDetails(name: memberName, firstName: self.txtGuestFirstname.text ?? "", lastName: self.txtGuestLastName.text ?? "",linkedMemberID: "", guestMemberOf: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",guestMemberNo: "",gender : self.txtGender.text ?? "", DOB: self.txtDOB.text ?? "", buddyID: "", type:"", phone: "", primaryemail: "", guestLinkedMemberID: "", highChair: 0, booster: 0, dietary: "", addGuestAsBuddy: self.isAddToBuddy ?? 0, otherNo: 0 , otherTextInformation: "", birthdayNo: 0, anniversaryNo: 0)
//                    self.memberDelegate?.requestMemberViewControllerResponse(selecteArray: [guestInfo])
//                    self.navigationController?.popViewController(animated: true)
                }
            }
            else if CustomFunctions.shared.isBMSModule(self.usedForModule)
            {
                if self.txtGuestLastName.text == ""
                {
                    self.txtGuestLastName.text = self.appDelegate.masterLabeling.gUESTNAME_FORMAT
                   
                }
                
                let memberName = self.generateMemberName()
                
                var guestMemberNo = ""
                var guestIdentityID = ""
                if self.screenType == .modify
                {
                    if let details = self.arrTotalList.first as? GuestInfo
                    {
                        guestInfo.appointmentMemberID = details.appointmentMemberID
                        guestMemberNo = details.guestMemberNo ?? ""
                        guestIdentityID = details.guestIdentityID ?? ""
                    }
                    else if let details = self.arrTotalList.first as? Detail
                    {
                        guestInfo.appointmentMemberID = details.appointmentMemberID
                        guestMemberNo = details.guestMemberNo ?? ""
                        guestIdentityID = details.guestIdentityID ?? ""
                    }
                }
                
                guestInfo.guestIdentityID = guestIdentityID
                
                //Added by kiran V3.0 -- ENGAGE0011843 -- Assiging the selected relation ID to type instead of the displayed name.
                //ENGAGE0011843 -- Start
                guestInfo.setGuestDetails(name: memberName, firstName: self.txtGuestFirstname.text ?? "", lastName: self.txtGuestLastName.text ?? "",linkedMemberID: "", guestMemberOf: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",guestMemberNo: guestMemberNo,gender : self.txtGender.text ?? "",DOB: self.txtDOB.text ?? "", buddyID: "", type: self.selectedRelation?.value ?? ""/*self.txtTypeOfGuest.text ?? ""*/, phone: self.txtCellPhone.text ?? "", primaryemail: self.txtPrimaryEmail.text ?? "", guestLinkedMemberID: "", highChair: 0, booster: 0, dietary: "", addGuestAsBuddy: self.isAddToBuddy ?? 0, otherNo: 0 , otherTextInformation: "", birthdayNo: 0, anniversaryNo: 0)
                //ENGAGE0011843 -- End
                
            }
            else if self.usedForModule == .golf || self.usedForModule == .tennis//self.usedForModule == .BMS || self.usedForModule == .bookALessonTennis || self.usedForModule == .fitnessSpa
            {
                
                if self.txtGuestLastName.text == ""
                {
                    if self.usedForModule == .tennis
                    {
                        self.txtGuestLastName.text = self.appDelegate.masterLabeling.go_Guest
                    }
                    else
                    {
                        self.txtGuestLastName.text = self.appDelegate.masterLabeling.gUESTNAME_FORMAT
                    }
                   
                }
                
                let memberName = self.generateMemberName()

                //Added by kiran V3.0 -- ENGAGE0011843 -- Assiging the selected relation ID to type instead of the displayed name.
                //ENGAGE0011843 -- Start
                guestInfo.setGuestDetails(name: memberName, firstName: self.txtGuestFirstname.text ?? "", lastName: self.txtGuestLastName.text ?? "",linkedMemberID: "", guestMemberOf: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",guestMemberNo: "",gender : self.txtGender.text ?? "",DOB: self.txtDOB.text ?? "", buddyID: "", type: self.selectedRelation?.value ?? ""/*self.txtTypeOfGuest.text ?? ""*/, phone: self.txtCellPhone.text ?? "", primaryemail: self.txtPrimaryEmail.text ?? "", guestLinkedMemberID: "", highChair: 0, booster: 0, dietary: "", addGuestAsBuddy: self.isAddToBuddy ?? 0, otherNo: 0 , otherTextInformation: "", birthdayNo: 0, anniversaryNo: 0)
                //ENGAGE0011843 -- End
                //Added on 16th june 2020 for bms
                //Modified by Kiran V2.7 -- GATHER0000700 - Changed fitnessSpa with generic code BMS as guests should behave same for fitness & spa and Tennis book a lesson.
                //GATHER0000700 - Start
//                if self.usedForModule == .BMS || self.usedForModule == .bookALessonTennis || self.usedForModule == .fitnessSpa
//                {//GATHER0000700 - End
//                    guestInfo.isEmpty = false
//                }
                
            }
            else if self.usedForModule == .dining || self.usedForModule == .diningEvents
            {
                if self.txtGuestLastName.text == ""
                {
                    self.txtGuestLastName.text = self.appDelegate.masterLabeling.gUESTNAME_FORMAT
                }
                
                let memberName = self.generateMemberName()

                //Added by kiran V3.0 -- ENGAGE0011843 -- Assiging the selected relation ID to type instead of the displayed name.
                //ENGAGE0011843 -- Start
                guestInfo.setGuestDetails(name: memberName, firstName: self.txtGuestFirstname.text ?? "", lastName: self.txtGuestLastName.text ?? "",linkedMemberID: "", guestMemberOf: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",guestMemberNo: "",gender : self.txtGender.text ?? "",DOB: self.txtDOB.text ?? "", buddyID: "", type: self.selectedRelation?.value ?? ""/*self.txtTypeOfGuest.text ?? ""*/, phone: self.txtCellPhone.text ?? "", primaryemail: self.txtPrimaryEmail.text ?? "", guestLinkedMemberID: "" , highChair: self.arrHighChair.count, booster: self.arrBooster.count, dietary: self.txtSpecify.text ?? "", addGuestAsBuddy: self.isAddToBuddy ?? 0, otherNo: self.other ?? 0 , otherTextInformation: self.txtOther.text, birthdayNo: self.birthDay ?? 0, anniversaryNo: self.anniversary ?? 0)
                //ENGAGE0011843 -- End
            }
            
        }
        
        guestInfo.isEmpty = false
        
        return guestInfo
    }
    
    //For existing Guest in modify scenario the details(except special requests) should be taken from the arrTotalList.This function generates the details.
    private func generateExistingGuestModifyInfo() -> GuestInfo
    {
        let guestInfo = GuestInfo.init()
        if let member = arrTotalList.first as? GroupDetail
        {
            guestInfo.setGuestDetails(name: member.name ?? "", firstName: member.guestFirstName ?? "", lastName: member.guestLastName ?? "", linkedMemberID: member.id ?? "", guestMemberOf: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "", guestMemberNo: member.memberID ?? "", gender: member.guestGender ?? "", DOB: member.guestDOB ?? "", buddyID: "", type: member.guestType ?? "", phone: member.cellPhone ?? "", primaryemail: member.email ?? "", guestLinkedMemberID: member.guestLinkedMemberID ?? "", highChair: 0, booster: 0, dietary: "", addGuestAsBuddy: 0, otherNo: 0, otherTextInformation: "", birthdayNo: 0, anniversaryNo: 0)
        }
        else if let member = arrTotalList.first as? GuestInfo
        {
            guestInfo.guestIdentityID = member.guestIdentityID
            guestInfo.setGuestDetails(name: member.guestName ?? "", firstName: member.guestFirstName ?? "", lastName: member.guestLastName ?? "", linkedMemberID: member.linkedMemberID ?? "", guestMemberOf: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "", guestMemberNo: member.guestMemberNo ?? "", gender: member.guestGender ?? "", DOB: member.guestDOB ?? "", buddyID: "", type: member.guestType ?? "", phone: member.cellPhone ?? "", primaryemail: member.email ?? "", guestLinkedMemberID: member.guestLinkedMemberID ?? "", highChair: 0, booster: 0, dietary: "", addGuestAsBuddy: 0, otherNo: 0, otherTextInformation: "", birthdayNo: 0, anniversaryNo: 0)

        }
        else if let member = arrTotalList.first as? Detail
        {
            guestInfo.guestIdentityID = member.guestIdentityID
            guestInfo.setGuestDetails(name: member.guestName ?? "", firstName: member.guestFirstName ?? "", lastName: member.guestLastName ?? "", linkedMemberID: member.id ?? "", guestMemberOf: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "", guestMemberNo: member.memberId ?? "", gender: member.guestGender ?? "", DOB: member.guestDOB ?? "", buddyID: "", type: member.guestType ?? "", phone: member.cellPhone ?? "", primaryemail: member.email ?? "", guestLinkedMemberID: member.guestLinkedMemberID ?? "", highChair: 0, booster: 0, dietary: "", addGuestAsBuddy: 0, otherNo: 0, otherTextInformation: "", birthdayNo: 0, anniversaryNo: 0)
            
        }
        
        guestInfo.isEmpty = false
        
        return guestInfo
    }
    
    private func generateMemberName() -> String
    {
        var memberName = ""
        
        if (self.txtGuestFirstname.text ?? "").count > 0 && (self.txtGuestLastName.text ?? "").count > 0
        {
            memberName = "\(self.txtGuestLastName.text ?? ""), \(self.txtGuestFirstname.text ?? "")"
        }
        else if (self.txtGuestFirstname.text ?? "").count > 0
        {
            memberName = self.txtGuestFirstname.text ?? ""
        }
        else if (self.txtGuestLastName.text ?? "").count > 0
        {
            memberName = self.txtGuestLastName.text ?? ""
        }
        
        return memberName
    }
    
    private func generateExistingGuestName() -> String
    {
        var memberName = ""
        
        memberName = "\(self.selectedGuest?.guestLastName ?? ""), \(self.selectedGuest?.guestFirstName ?? "")"
        
        return memberName
    }
    
    
    private func getCategoryType() -> (category : String , type : String)
    {
        var category = ""
        var type = ""
        
        switch self.usedForModule!
        {
        case .golf:
            type = AppModuleKeys.golf
            category = AppModuleKeys.reservation
        case .tennis:
            type = AppModuleKeys.tennis
            category = AppModuleKeys.reservation
        case .dining:
            type = AppModuleKeys.dining
            category = AppModuleKeys.reservation
        case .diningEvents:
            type = AppModuleKeys.dining
            category = AppModuleKeys.events
        case .bookALessonTennis:
            type = AppModuleKeys.tennisBookALesson
            category = AppModuleKeys.BMS
        case .fitnessSpa:
            type = AppModuleKeys.fitnessAndSpa
            category = AppModuleKeys.BMS
            //Added by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
            //GATHER0001167 -- Start
        case .bookALessonGolf:
            type = AppModuleKeys.golfBookALesson
            category = AppModuleKeys.BMS
            //GATHER0001167 -- End
        case .events:
            break
        case .BMS:
            break
        }
        
        return(category,type)
    }
    
    //MARK:- Api body and header methods
 
    ///Generated the paramater dixt which can be used in validation apis.
    private func generateParamatersForValidation() -> [String : Any]
    {
        var memberList = self.arrAddedMembers
        
        var isExistingGuest = false
        
        if self.screenType == .modify
        {
            let memberType = CustomFunctions.shared.memberType(details: self.arrTotalList.first!, For: self.usedForModule)
            isExistingGuest = (memberType == .existingGuest)
            //memberList.append(contentsOf: [self.arrTotalList])
        }
        
        if (self.showExistingGuestsOption && self.btnExistingGuestOption.isSelected) || (self.screenType == .modify && isExistingGuest)
        {
            let guestInfo = self.generateGuestInfoObject()
            
            if memberList.count > 0
            {
                var lastObjectIndex = memberList.count - 1
                
                if lastObjectIndex < 0
                {
                    lastObjectIndex = 0
                }
                
                memberList[lastObjectIndex].append(guestInfo)
            }
            else
            {
                memberList.append([guestInfo])
            }
            
        }
        
        let memberDetails = CustomFunctions.shared.generateMembersDict(membersDetails: memberList, usedIn: self.usedForModule)
        
        switch self.usedForModule!
        {
        case .golf:
            
            let dateSelected = self.requestDates.first ?? ""
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "RequestId": self.requestID,
                "ReservationRequestDate": dateSelected,
                "ReservationRequestTime": self.requestTime,
                "GroupDetails": memberDetails,
                "GroupCount":  0,
                "GameType": 9,
                "LinkGroup": 1,
                "Earliest": "",
                "PreferedSpaceDetailId": [],
                "NotPreferedSpaceDetailId": [],
                "IsReservation": "1",
                "IsEvent": "0",
                "ReservationType": AppModuleKeys.golf,
                "RegistrationID": self.requestID
            ]
            
            return paramaterDict
            
        case .tennis:
            
            var selectedDates : [[String : Any]] = [[String : Any]]()
            
            for date in self.requestDates
            {
                let date : [String : Any] = [
                    "RequestDate": date,
                ]
                selectedDates.append(date)
            }
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "RequestId": self.requestID,
                "ReservationRequestDate": selectedDates,
                "ReservationRequestTime": self.requestTime,
                "PlayerCount": 0,
                "Earliest": "",
                "Latest": "",
                "Comments": "",
                "TennisDetails" : memberDetails,
                "PlayType": "",
                "RequestType": self.gameType,
                APIKeys.kDuration : self.duration,
                "BallMachine":0,
                "IsReservation": "1",
                "IsEvent": "0",
                "ReservationType": AppModuleKeys.tennis,
                "RegistrationID": self.requestID
            ]
            
            return paramaterDict
            
        case .dining:
            
            let selectedDate = self.requestDates.first ?? ""
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "RequestId": self.requestID,
                "ReservationRequestDate": selectedDate,
                "ReservationRequestTime": "",
                "PartySize": "",
                "Earliest": "",
                "Latest": "",
                "Comments": "",
                "PreferedSpaceDetailId": self.preferedSpaceDetailId,
                "TablePreference": "",
                "DiningDetails" : memberDetails,
                "IsReservation": "1",
                "IsEvent": "0",
                "ReservationType": AppModuleKeys.dining,
                "RegistrationID": self.requestID
            ]
            
            return paramaterDict
            
        case .diningEvents:
            
            let selectedDate = self.requestDates.first ?? ""
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "RequestId": self.requestID,
                "ReservationRequestDate": selectedDate,
                "ReservationRequestTime": "",
                "PartySize": "",
                "Comments": "",
                "DiningDetails" : memberDetails,
                "EventID": self.eventID,
                "PreferedSpaceDetailId": self.preferedSpaceDetailId,
                "IsReservation": "0",
                "IsEvent": "1",
                "ReservationType": "",
                "RegistrationID": self.requestID
            ]
            
            return paramaterDict
            
        case .events:
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                "Role": UserDefaults.standard.string(forKey: UserDefaultsKeys.role.rawValue)!,
                "EventID": self.eventID,
                "Comments": "",
                "NumberOfTickets": "",
                "EventRegistrationID": "",
                "MemberList": memberDetails,
                "BuddyList": [],
                "GuestList": [],
                "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue) ?? "",
                "IsReservation": "0",
                "IsEvent": "1",
                "ReservationType": "",
                "RegistrationID": self.requestID,
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            
            return paramaterDict
            //Added by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
            //GATHER0001167 -- Start
        case .BMS,.fitnessSpa,.bookALessonTennis,.bookALessonGolf:
            //GATHER0001167 -- End
            let selectedDate = self.requestDates.first ?? ""
            
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
                APIKeys.kAppointmentType : self.appointmentType?.rawValue ?? "",
                APIKeys.kAppointmentDate : selectedDate,
                APIKeys.kAppointmentTime : self.requestTime,
                APIKeys.kAppointmentDetailID : self.requestID ,
                APIKeys.kMemberCount : "\(memberDetails.count)",
                APIKeys.kDetails : memberDetails
            ]
            
            return paramaterDict
        }

    }
    
    
    //Note:- Any changed done to this function for new guest should also be done in InitialSetups function
    private func emptyNewGuestDetails()
    {
        self.txtGuestFirstname.text = ""
        self.txtGuestLastName.text = ""
        self.txtGender.text = ""
        self.txtDOB.text = ""
        self.txtCellPhone.text = ""
        self.txtPrimaryEmail.text = ""
        
        self.selectedRelation = self.appDelegate.arrGuestType[1]
        self.txtTypeOfGuest.text = self.selectedRelation?.name
        
        self.emptySpecialOptions()
        
        if self.usedForModule == .golf
        {
            self.isAddToBuddy = 0
        }
        else
        {
            self.isAddToBuddy = 1
        }
        
        //Note:- Any changed done to addToBuddyList for new guest should also be done in InitialSetups function
        if self.usedForModule == .dining || self.usedForModule == .tennis || self.usedForModule == .diningEvents
        {
            self.btnAddToMybuddyList.setImage(UIImage(named:"CheckBox_uncheck"), for: UIControlState.normal)
            self.btnAddToMybuddyList.isSelected = true
            self.isAddToBuddy = 0
        }
        
        if self.hideAddtoBuddy
        {
            self.isAddToBuddy = 0
        }
     
    }
    
    private func emptySpecialOptions()
    {
        self.btnBooster.isSelected = false
        self.boosterValue = 0
        self.btnBooster.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
        self.arrBooster.removeAll()
        self.arrBooster.append("")
        self.lblBooster.text = String(format: "%02d", self.arrBooster.count)
        
        self.btnHighChair.isSelected = false
        self.highChairValue = 0
        self.btnHighChair.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
        self.arrHighChair.removeAll()
        self.arrHighChair.append("")
        self.lblHighChair.text = String(format: "%02d", self.arrHighChair.count)
        
        self.btnBirthDay.isSelected = false
        self.btnBirthDay.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
        self.birthDay = 0
        
        self.btnAnniversary.isSelected = false
        self.btnAnniversary.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
        self.anniversary = 0
        
        self.btnOther.isSelected = false
        self.btnOther.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
        self.viewTxtOther.isHidden = true
        self.txtOther.isHidden = true
        self.other = 0
        self.txtOther.text = ""
        
        self.txtSpecify.text = ""
    }
    
}

//MARK:- APi's
extension AddGuestRegVC
{
    //Added by kiran V2.8 -- ENGAGE0011784 --
    //ENGAGE0011784 -- Start
    
    ///Existing guest API
    private func getGuestList()
    {
        
        if Network.reachability?.isReachable ?? false
        {
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let categoryTypeTuple = self.getCategoryType()

            var requestDate = [[String : Any]]()
            self.requestDates.forEach({requestDate.append([APIKeys.kRequestDate : $0])})
            
            let paramaterDict : [String : Any] = [
                APIHeader.kContentType : "application/json",
                APIHeader.kSearchChar : "All",
                APIKeys.kCategory: categoryTypeTuple.category,
                APIKeys.kpagecount : self.existingGuestPageNumber,
                APIKeys.krecordperpage : 25,
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.ksearchby : self.stringGuestSearch,
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kdeviceInfo : [APIHandler.devicedict],
                APIKeys.kinterest: self.appDelegate.strFilterSting,
                APIKeys.kType : categoryTypeTuple.type,
                APIKeys.kReservationRequestDate : requestDate,
                APIKeys.kReservationRequestTime : self.requestTime,
                APIKeys.kDuration : self.duration,
                "RequestId" : self.requestID,
                "PreferedSpaceDetailId" : self.preferedSpaceDetailId,
                "EventID" : self.eventID
            ]
            
            
            APIHandler.sharedInstance.getMemberExistingGuestList(paramaterDict: paramaterDict) { (existingGuestsList) in
                
                
                if self.isLoadMoreClicked
                {
                    self.isLoadMoreClicked = false
                    if let guests = existingGuestsList?.existingGuests
                    {
                        self.arrExistingGuests.append(contentsOf: guests)
                    }
                }
                else
                {
                    self.arrExistingGuests = existingGuestsList?.existingGuests ?? [ExistingGuest]()
                }
               
                /* //Dummy data
                if self.arrGuestSuggestions.count < 1
                {
                    self.arrExistingGuests.removeAll()
                    for i in 1...4
                    {
                        if i == 1
                        {
                            let existingGuest = ExistingGuest.init()
                            existingGuest.firstName = "Harvey"
                            existingGuest.lastName = "Spectre"
                            existingGuest.memberName = "Spectre, Harvey"
                            existingGuest.guestVisitData = "05/12/2021 - 05/18/2021"
                            existingGuest.memberID = "24231-30"
                            self.arrExistingGuests.append(existingGuest)
                        }
                        else if i == 2
                        {
                            let existingGuest = ExistingGuest.init()
                            existingGuest.firstName = "Donna"
                            existingGuest.lastName = "Paulson"
                            existingGuest.memberName = "Paulson, Donna"
                            existingGuest.guestVisitData = "04/14/2021 - 04/19/2021"
                            existingGuest.memberID = "04231-13"
                            self.arrExistingGuests.append(existingGuest)
                        }
                        else if i == 3
                        {
                            let existingGuest = ExistingGuest.init()
                            existingGuest.firstName = "Tom"
                            existingGuest.lastName = "Keen"
                            existingGuest.memberName = "Keen, Tom"
                            existingGuest.guestVisitData = ""
                            existingGuest.memberID = "04231-16"
                            self.arrExistingGuests.append(existingGuest)
                        }
                        else if i == 4
                        {
                            let existingGuest = ExistingGuest.init()
                            existingGuest.firstName = "Ray"
                            existingGuest.lastName = "Reddington"
                            existingGuest.memberName = "Reddington, Ray"
                            existingGuest.guestVisitData = ""
                            existingGuest.memberID = "04231-14"
                            self.arrExistingGuests.append(existingGuest)
                        }
                        
                    }
                }
                 */
                
                //Sets empty message if list is empty
                self.tblViewExistingGuests.setEmptyMessage((self.arrExistingGuests.count > 0) ? "" : (self.appDelegate.masterLabeling.no_Record_Found ?? ""))
                self.tblViewExistingGuests.reloadData()
                
                self.showLoadMore = !((existingGuestsList?.isLoadMore ?? 0) == 0)
                
                self.appDelegate.hideIndicator()

            } onFailure: { (error) in
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
                self.appDelegate.hideIndicator()
            }

        }
        else
        {
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
    }
    
    ///Validate member API
    private func existingGuestValidation()
    {
        if Network.reachability?.isReachable ?? false
        {
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict = self.generateParamatersForValidation()
            
            if CustomFunctions.shared.isBMSModule(self.usedForModule)
            {
                APIHandler.sharedInstance.getAppointmentValidation(paramater: paramaterDict) { [unowned self] (status) in
                    
                    self.appDelegate.hideIndicator()
                    
                     if status.responseCode == InternetMessge.kFail
                     {
                        SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:status.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                        
                     }
                     else
                     {
                        switch self.screenType
                        {
                        case .add:
                            if self.btnExistingGuestAddToBuddy.isSelected && !self.hideExistingGuestAddToBuddy
                            {
                                self.AddtoBuddyList()
                            }
                        case .modify,.view:
                            break
                        }
                        
                        self.sendResponce()
                     }

                } onFailure: { (error) in
                    SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
                    self.appDelegate.hideIndicator()
                }

            }
            else
            {
                APIHandler.sharedInstance.getMemberValidation(paramater: paramaterDict) { [unowned self] (response) in
                    
                    self.appDelegate.hideIndicator()
                    
                    if response.responseCode == InternetMessge.kFail
                    {
                        SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                        
                    }
                    else
                    {
                        switch self.screenType
                        {
                        case .add:
                            if self.btnExistingGuestAddToBuddy.isSelected && !self.hideExistingGuestAddToBuddy
                            {
                                self.AddtoBuddyList()
                            }
                        case .modify,.view:
                            break
                        }
                        
                        self.sendResponce()
                    }
                
                } onFailure: { (error) in
                    SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
                    self.appDelegate.hideIndicator()
                }

            }
        }
        else
        {
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
    
    //Renamed to NewGuestValidtion from cellPhoneValidation. and added first name,last name,DOB,Guest Type,Gender,type and categoty for validation.
    private func newGuestValidation()
    {
        if Network.reachability?.isReachable ?? false
        {
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let categoryTypeTuple = self.getCategoryType()
            
            let params: [String : Any] = [
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                
                //Added by kiran V2.8 -- ENGAGE0011784 -- Added to enable validation
                //ENGAGE0011784 -- Start
                APIKeys.kType : categoryTypeTuple.type,
                APIKeys.kCategory : categoryTypeTuple.category,
                APIKeys.kGuestFirstName : self.txtGuestFirstname.text ?? "",
                APIKeys.kGuestLastName : self.txtGuestLastName.text ?? "",
                //Added by kiran V3.0 -- ENGAGE0011843 -- Passing relation ID instead of displayed name.
                //ENGAGE0011843 -- Start
                APIKeys.kGuestType : self.selectedRelation?.value ?? "",
                //APIKeys.kGuestType : self.txtTypeOfGuest.text ?? "",
                //ENGAGE0011843 -- End
                APIKeys.kGuestGender : self.txtGender.text ?? "",
                APIKeys.kGuestDOB : self.txtDOB.text ?? "",
                //ENGAGE0011784 -- End
                "GuestContact" : txtCellPhone.text ?? "",
                "GuestEmail" : txtPrimaryEmail.text ?? ""
                
            ]
            
            APIHandler.sharedInstance.getGuestValidation(paramater: params, onSuccess: { (response) in
                
              
                self.appDelegate.hideIndicator()
                self.sendResponce()
                
            }) { (error) in
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
                self.appDelegate.hideIndicator()
                
            }
        }
        else
        {
            SharedUtlity.sharedHelper().showToast(on: self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
    }
    
 
    //Loads Suhhestions
    private func reservationGuestList(searchStr : String)
    {
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)

        if (Network.reachability?.isReachable) == true
        {
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "" ,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.ksearchby: searchStr//self.strSuggestionSearch
            ]
            
            APIHandler.sharedInstance.reservationGuestList(paramater: paramaterDict , onSuccess: { guestList in
                self.appDelegate.hideIndicator()
                
                if(guestList.responseCode == InternetMessge.kSuccess)
                {
                    if(guestList.reservationGuestList.isEmpty)
                    {
                        self.arrGuestSuggestions.removeAll()
                        //Added by kiran V2.8 -- ENGAGE0011784 -- Commented as the view associated to this is removed from storyboard as this style of showing suggestions is no longer suitable when name is split into first name and lastname.
                        //ENGAGE0011784 -- Start
                        //self.arrGuestSuggestions.removeAll()
                        //self.appDelegate.hideIndicator()
                        //self.guestTableview.setEmptyMessage(InternetMessge.kNoData)
                        //self.guestTableview.reloadData()
                        //ENGAGE0011784 -- End
                        
                    }
                    else
                    {
                        //Added by kiran V2.8 -- ENGAGE0011784 -- Commented guestTableview as the view associated to this is removed from storyboard as this style of showing suggestions is no longer suitable when name is split into first name and lastname.
                        //ENGAGE0011784 -- Start
                        //self.guestTableview.restore()
                        self.arrGuestSuggestions.removeAll()
                        self.arrGuestSuggestions = guestList.reservationGuestList
                        //self.guestTableview.reloadData()
                        //self.appDelegate.hideIndicator()
                        //ENGAGE0011784 -- End
                    }
                }
                else
                {
                    self.arrGuestSuggestions.removeAll()
                    //Added by kiran V2.8 -- ENGAGE0011784 -- Commented as the view associated to this is removed from storyboard as this style of showing suggestions is no longer suitable when name is split into first name and lastname.
                    //ENGAGE0011784 -- Start
                    
                    //self.arrGuestSuggestions.removeAll()
                    //self.appDelegate.hideIndicator()
                    //self.guestTableview.reloadData()
                    //self.guestTableview.setEmptyMessage(guestList.responseMessage )
                    
                    //ENGAGE0011784 -- End
                }
                //self.appDelegate.hideIndicator()
                
                if self.arrGuestSuggestions.count > 0
                {
                    self.showSuggestions()
                }
                else
                {
                    self.removeSuggestions()
                }
                
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
//                SharedUtlity.sharedHelper().showToast(on:
//                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
        }
        else
        {
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
    }
    
    //Adds to buddy list
    private func AddtoBuddyList()
    {
        
        if Network.reachability?.isReachable ?? false
        {
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let categoryTypeTuple = self.getCategoryType()
            
            let buddyInfo : [String : Any] = [
                APIKeys.kMemberId : self.selectedGuest?.memberID ?? "",
                APIKeys.kid :  self.selectedGuest?.ID ?? "",
                APIKeys.kParentId : self.selectedGuest?.parentID ?? "",
                APIKeys.kCategory : categoryTypeTuple.type
            ]
       
            let paramaterDict:[String: Any] = [
                APIHeader.kContentType : "application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kAddBuddy : buddyInfo,
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            
            
            APIHandler.sharedInstance.addToBuddyList(paramaterDict: paramaterDict, onSuccess: { memberLists in
                self.appDelegate.hideIndicator()

                if(memberLists.responseCode == InternetMessge.kSuccess)
                {
                    self.appDelegate.hideIndicator()
                    
                }
                else
                {
                    self.appDelegate.hideIndicator()
                    if(((memberLists.responseMessage?.count) ?? 0)>0)
                    {
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
            
            
        }
        else
        {
            
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            
        }
    }
    //ENGAGE0011784 -- End
    
}

//MARK:- Table view Delegates
extension AddGuestRegVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //Added by kiran V2.8 -- ENGAGE0011784 -- Commented as the view associated to this is removed from storyboard as this style of showing suggestions is no longer suitable when name is split into first name and lastname.
        //ENGAGE0011784 -- Start
//        if tableView == self.guestTableview
//        {
//            return arrGuestSuggestions.count
//        }
        //ENGAGE0011784 -- End
        if tableView == self.tblViewNameSuggetions
        {
            return self.arrGuestSuggestions.count
        }
        //Added by kiran V2.8 -- ENGAGE0011784 -- added existing user tableview list
        //ENGAGE0011784 -- Start
        else if tableView == self.tblViewExistingGuests
        {
            return self.arrExistingGuests.count
        }
        //ENGAGE0011784 -- End
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if tableView == self.tblViewExistingGuests
        {
            if self.showLoadMore
            {
                if section == 0 && self.arrExistingGuests.count > 0
                {
                    return UITableViewAutomaticDimension
                }
            }
            
        }
        
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        if tableView == self.tblViewExistingGuests
        {
            if section == 0 && self.arrExistingGuests.count > 0 && self.showLoadMore
            {
                let footerView = Bundle.main.loadNibNamed("LoadMoreFooterTableViewCell", owner: self, options: nil)?.first as! LoadMoreFooterTableViewCell
                
                footerView.btnLoadMore.setTitle(self.appDelegate.masterLabeling.SHOW_MORE ?? "", for: .normal)
                footerView.btnLoadMore.addTarget(self, action: #selector(self.loadMoreClicked(_:)), for: .touchUpInside)
                return footerView
            }
            
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //Added by kiran V2.8 -- ENGAGE0011784 -- Commented as the view associated to this is removed from storyboard as this style of showing suggestions is no longer suitable when name is split into first name and lastname.
        //ENGAGE0011784 -- Start
        /*
        if tableView == self.guestTableview
        {
            let cell:AllNewsCustomTableViewCell = self.guestTableview.dequeueReusableCell(withIdentifier: "ClubCell") as! AllNewsCustomTableViewCell

            cell.lblGuestName.text = arrGuestSuggestions[indexPath.row].guestName
            self.guestTableview.separatorStyle = UITableViewCellSeparatorStyle.none
            cell.selectionStyle = .none
            
            //Added by kiran V2.8 -- ENGAGE0011784 -- applying font color from a shared objects
            //ENGAGE0011784 -- Start
            cell.lblGuestName.font = AppFonts.regular17
            cell.lblGuestName.textColor = APPColor.textColor.primary
            //ENGAGE0011784 -- End
            
            return cell
        }
         */
        //ENGAGE0011784 -- End
        if tableView == self.tblViewNameSuggetions
        {
            let cell:GuestNameSuggestionTableViewCell = self.tblViewNameSuggetions.dequeueReusableCell(withIdentifier: "GuestNameSuggestionTableViewCell") as! GuestNameSuggestionTableViewCell
            cell.lblName.text = self.arrGuestSuggestions[indexPath.row].guestName
            return cell
        }
        //Added by kiran V2.8 -- ENGAGE0011784 -- added existing user tableview list
        //ENGAGE0011784 -- Start
        else if tableView == self.tblViewExistingGuests
        {
            let cell : MemberTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MemberTableViewCell") as! MemberTableViewCell
            
            let guestDetails = self.arrExistingGuests[indexPath.row]
            
            cell.lblName.text = guestDetails.memberName
            cell.lblMemberID.text = guestDetails.memberID
            cell.lblVisit.text = guestDetails.guestVisitData ?? ""
            
            cell.imgProfilePic.image = UIImage(named: "avtar")
            
            cell.imageUrl = guestDetails.profilePic
            let imageURLString = guestDetails.profilePic ?? ""
            
            if let imageDataTask = self.arrGuestProfilePicTask[imageURLString]
            {
                if let data = imageDataTask.data , !data.isEmpty , imageDataTask.state == .finished
                {
                    cell.imgProfilePic.image = UIImage.init(data: data)
                }
                
            }
            else
            {
                if imageURLString.isValidURL()
                {
                    let downloadTask = ImageDownloadTask()
                    downloadTask.url = imageURLString
                    self.arrGuestProfilePicTask.updateValue(downloadTask, forKey: imageURLString)
                    downloadTask.startDownload { (data, response,url) in
                        if cell.imageUrl == url , let data = data , !data.isEmpty
                        {
                            DispatchQueue.main.async {
                                cell.imgProfilePic.image = UIImage.init(data: data)
                            }
                        }
                        
                    }
                }
            }
            
            cell.viewLine.backgroundColor = (indexPath.row == (self.arrExistingGuests.count - 1)) ? .clear : APPColor.OtherColors.lineColor
            return cell
        }
        
        //ENGAGE0011784 -- End
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //Added by kiran V2.8 -- ENGAGE0011784 -- added existing user tableview list and Commented guestTableview as the view associated to this is removed from storyboard as this style of showing suggestions is no longer suitable when name is split into first name and lastname.
        //ENGAGE0011784 -- Start
        /*
        if tableView == self.guestTableview
        {
            self.txtPrimaryEmail.text = arrGuestSuggestions[indexPath.row].guestMail
            self.txtCellPhone.text = arrGuestSuggestions[indexPath.row].guestPhone
            self.txtSpecify.text = arrGuestSuggestions[indexPath.row].dietaryRestriction
            self.txtGuestFirstname.text = arrGuestSuggestions[indexPath.row].guestName
            self.txtTypeOfGuest.text = arrGuestSuggestions[indexPath.row].guestType
            arrGuestSuggestions.removeAll()
            guestTableview.reloadData()
            self.view.setNeedsLayout()
        }
         */
        if tableView == self.tblViewNameSuggetions
        {
            let selectedSuggestion = self.arrGuestSuggestions[indexPath.row]
            self.txtGuestFirstname.text = selectedSuggestion.guestFirstName
            self.txtGuestLastName.text = selectedSuggestion.guestLastName
            
            //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
            //ENGAGE0011843 -- Start
            self.txtTypeOfGuest.text = CustomFunctions.shared.guestTypeDisplayName(id: selectedSuggestion.guestType)
            self.selectedRelation = self.appDelegate.arrGuestType.first(where: {$0.value == selectedSuggestion.guestType})
            //self.txtTypeOfGuest.text = selectedSuggestion.guestType
            //ENGAGE0011843 -- End
            
            self.txtDOB.text = selectedSuggestion.guestDOB
            self.txtGender.text = selectedSuggestion.guestGender
            self.txtCellPhone.text = selectedSuggestion.guestPhone
            self.txtPrimaryEmail.text = selectedSuggestion.guestMail
            
            if self.usedForModule == .dining || self.usedForModule == .diningEvents
            {
                self.txtSpecify.text = selectedSuggestion.dietaryRestriction
            }
            
            self.view.endEditing(true)
            self.removeSuggestions()
            
        }
        else if tableView == self.tblViewExistingGuests
        {
            let selectedGuest = self.arrExistingGuests[indexPath.row]
            //0 is allowed
            switch selectedGuest.isMemberNotAllowed {
            case 1:
                
                var message = ""
                
                switch self.usedForModule
                {
                case .golf:
                    message = self.appDelegate.masterLabeling.IsMemberExistsValidation_Golf_1 ?? ""
                case .dining,.diningEvents:
                    message = self.appDelegate.masterLabeling.IsMemberExistsValidation_Dining_1 ?? ""
                case .tennis:
                    message = self.appDelegate.masterLabeling.IsMemberExistsValidation_Tennis_1 ?? ""
                default:
                    message = ""
                }
                
                self.showTostWith(memberName: selectedGuest.memberName ?? "", requestedBy: selectedGuest.requestedBy ?? "", in: message)
                
                self.tblViewExistingGuests.deselectRow(at: indexPath, animated: true)
                return
            case 2:
                
                var message = ""
                
                switch self.usedForModule
                {
                case .golf:
                    message = self.appDelegate.masterLabeling.IsMemberExistsValidation_Golf_2 ?? ""
                case .tennis:
                    message = self.appDelegate.masterLabeling.IsMemberExistsValidation_Tennis_2 ?? ""
                default:
                    message = ""
                }
                
                 self.showTostWith(memberName: selectedGuest.memberName ?? "", requestedBy: selectedGuest.requestedBy ?? "", in: message)
                
                self.tblViewExistingGuests.deselectRow(at: indexPath, animated: true)
                return
            default:
                break
            }
            
           
            if self.arrExistingGuests[indexPath.row].isActive == 0
            {
                //Note:- Only use existingGuestSelectedIndex in this function. dont use anywhere else as this becomes nil wheh either yes or no is selected. use selectedGuest instead ot get the selected guest details.
                self.existingGuestSelectedIndex = indexPath
                var messageBody : String?
                
                switch usedForModule!
                {
                case .golf:
                    messageBody = self.appDelegate.masterLabeling.golfReservation_GuestAdd
                case .tennis:
                    messageBody = self.appDelegate.masterLabeling.tennisReservation_GuestAdd
                case .dining,.diningEvents:
                    messageBody = self.appDelegate.masterLabeling.diningReservation_GuestAdd
                case .events:
                    break
                case .fitnessSpa:
                    
                    if let departmentName = self.BMSDepartmentName
                    {
                        if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Fitness!) == .orderedSame
                        {
                            messageBody = self.appDelegate.masterLabeling.BMS_Fitness_GuestAdd
                        }
                        else if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Spa!) == .orderedSame
                        {
                            messageBody = self.appDelegate.masterLabeling.BMS_Spa_GuestAdd
                        }
                        else if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Salon!) == .orderedSame
                        {
                            messageBody = self.appDelegate.masterLabeling.BMS_Salon_GuestAdd
                        }
                        
                    }
                    
                case .bookALessonTennis:
                    messageBody = self.appDelegate.masterLabeling.BMS_Tennis_GuestAdd
                    //Added by kiran V2.9 -- GATHER0001167 -- Added Golf BAL message
                    //GATHER0001167 -- Start
                case .bookALessonGolf:
                    messageBody = self.appDelegate.masterLabeling.BMS_Golf_GuestAdd
                    //GATHER0001167 -- End
                case .BMS:
                    break
                }
                
                let alertController = UIAlertController.init(title: "", message: messageBody, preferredStyle: .alert)
                
                let okAction = UIAlertAction.init(title: self.appDelegate.masterLabeling.confirm_Yes ?? "", style: .default) { (action) in
                    
                    self.selectedGuest = self.arrExistingGuests[self.existingGuestSelectedIndex!.row]
                    if self.usedForModule == .dining || self.usedForModule == .diningEvents
                    {
                        self.emptySpecialOptions()
                        self.showDiningAdditionalOptions(bool: true)
                    }
                    
                    self.existingGuestSelectedIndex = nil
                }
                alertController.addAction(okAction)
                
                let noAction = UIAlertAction.init(title: self.appDelegate.masterLabeling.confirm_No ?? "", style: .default) { (action) in
                    self.tblViewExistingGuests.deselectRow(at: self.existingGuestSelectedIndex!, animated: true)
                    self.existingGuestSelectedIndex = nil
                    self.selectedGuest = nil
                }
                alertController.addAction(noAction)
               
                self.present(alertController, animated: true, completion: nil)

            }
            else
            {
                self.selectedGuest = self.arrExistingGuests[indexPath.row]
                if self.usedForModule == .dining || self.usedForModule == .diningEvents
                {
                    self.emptySpecialOptions()
                    self.showDiningAdditionalOptions(bool: true)
                }
            }
            
        }
        //ENGAGE0011784 -- End
    }
    
}

//MARK:- TextField Delegate
extension AddGuestRegVC : UITextFieldDelegate
{
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField == txtTypeOfGuest
        {
            self.relationPicker?.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(relationPicker!, didSelectRow: 0, inComponent: 0)
        }//Added on 4th Septmeber 2020 V2.3
        else if textField == self.txtGender
        {
            
            if let genderIndex = self.appDelegate.guestGenderOptions.firstIndex(where: {$0.name == textField.text})
            {
                //Picks previously selected gender
                self.genderPicker?.selectRow(genderIndex, inComponent: 0, animated: true)
            }
            else
            {
                //When empty sets the first index item as default
                self.pickerView(self.genderPicker!, didSelectRow: 0, inComponent: 0)
            }
            
        }
        else if textField == self.txtDOB
        {
            //Added by kiran V2.8 -- ENGAGE0011784 --
            //ENGAGE0011784 -- Start
            if (textField.text ?? "").isEmpty
            {
                self.txtDOB.text = Date.init().toString(format: DateFormats.addGuestDatePickerFormat)
            }
            //ENGAGE0011784 -- End
            
            if let dateString = textField.text, dateString.count > 0 , let date = SharedUtlity.sharedHelper().dateFormatter.date(from: dateString)
            {
                self.DOBPicker?.setDate(date, animated: true)
            }
            else
            {
                self.DOBPicker?.setDate(Date.init(), animated: true)
            }
            
        }
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        if textField == self.txtCellPhone
        {
            let str = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            
            if textField == txtCellPhone
            {
                return checkCellPhoneNumberFormat(string: string, str: str)
            }
        }
        //Added by kiran V2.8 -- ENGAGE0011784 -- Adding name suggestions support for last name.
        //ENGAGE0011784 -- Start
        else if textField == self.txtGuestFirstname || textField == self.txtGuestLastName
        {
            
            guard self.enableGuestNameSuggestions else{
                return true
            }
            
            var searchText  = textField.text! + string
            
            if string.isEmpty
            {
                //Added by kiran V2.8 -- ENGAGE0011784 -- removed depricated method.
                //ENGAGE0011784 -- Start
                searchText = String(searchText.dropLast()) //String(searchText.characters.dropLast())
                //ENGAGE0011784 -- End
            }
            
            if searchText.count >= 2
            {
                //self.strSuggestionSearch = searchText
                self.reservationGuestList(searchStr: searchText)
                
            }
            else
            {
                self.removeSuggestions()
                //Added by kiran V2.8 -- ENGAGE0011784 -- Commented as the view associated to this is removed from storyboard as this style of showing suggestions is no longer suitable when name is split into first name and lastname.
                //ENGAGE0011784 -- Start
                //self.arrGuestSuggestions.removeAll()
                /*
                if(self.usedForModule == .dining || self.usedForModule == .diningEvents/* isOnlyFor == "Dining"*/)
                {
                    self.guestTableview.reloadData()
                    
                }
                self.view.setNeedsLayout()
                 */
                //ENGAGE0011784 -- End
                
            }
        
        }
        //ENGAGE0011784 -- End
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField)
    {
        
        if textField == self.txtGuestFirstname || textField == self.txtGuestLastName
        {
            self.removeSuggestions()
        }
        
        //Added by kiran V2.8 -- ENGAGE0011784 -- Commented as the view associated to this is removed from storyboard as this style of showing suggestions is no longer suitable when name is split into first name and lastname.
        //ENGAGE0011784 -- Start
        /*
        self.arrGuestSuggestions.removeAll()
        self.guestTableview.reloadData()
        self.view.setNeedsLayout()
         */
        //ENGAGE0011784 -- End
        /*
        if textField.text?.count == 0
        {

        }
        else
        {
            if textField == self.txtPrimaryEmail
            {
                if isValidEmail(testStr: txtPrimaryEmail.text!)
                {
                }
                else
                {
                    SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:self.appDelegate.masterLabeling.email_Validation, withDuration: Duration.kMediumDuration)
                }
                
            }
        }
        */
        
    }
    
    
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //Moves the curser to last name textfield when return is clicked on keyboard when first name txt field is in editing
        if textField == self.txtGuestFirstname
        {
            self.txtGuestFirstname.resignFirstResponder()
            self.txtGuestLastName.becomeFirstResponder()
        }
        
        return true
    }
}

//ENGAGE0011784 -- End
extension AddGuestRegVC : UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
//        if pickerView == relationPicker {
//            return appDelegate.arrReleationList.count
//        }
        //Modified on 4th September 2020 V2.3
        switch pickerView
        {
        case self.relationPicker:
            return appDelegate.arrGuestType.count
        case self.genderPicker:
            return self.appDelegate.guestGenderOptions.count
        default:
            return 0
        }
        //return appDelegate.arrGuestType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //Modified on 4th September 2020 V2.3
        switch pickerView {
        case self.relationPicker:
            return appDelegate.arrGuestType[row].name
        case self.genderPicker:
            return self.appDelegate.guestGenderOptions[row].name
        default:
            return nil
        }
        //return appDelegate.arrGuestType[row].name
    }
}

extension AddGuestRegVC : UIPickerViewDelegate
{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == relationPicker, appDelegate.arrGuestType.count > row
        {
            selectedRelation = appDelegate.arrGuestType[row]
            txtTypeOfGuest.text = selectedRelation?.name
        }//Modified on 4th September 2020 V2.3
        else if pickerView == self.genderPicker, self.appDelegate.guestGenderOptions.count > row
        {
            self.txtGender.text = self.appDelegate.guestGenderOptions[row].name
        }
        
    }
    
}

//Added by kiran V2.8 -- ENGAGE0011784 -- Search bar delegates
//ENGAGE0011784 -- Start
extension AddGuestRegVC : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        self.stringGuestSearch = searchBar.text ?? ""
        self.getGuestList()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        self.stringGuestSearch = searchText
        
        if self.stringGuestSearch.count < 1
        {
            self.getGuestList()
        }
    }
    
}
//ENGAGE0011784 -- End
