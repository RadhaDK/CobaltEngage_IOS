
import UIKit
import Alamofire
import AlamofireImage
import FLAnimatedImage
import ScrollableSegmentedControl

protocol MemberViewControllerDelegate
{
    func multiSelectRequestMemberViewControllerResponse (selectedArray : [[RequestData]])
    func requestMemberViewControllerResponse(selecteArray: [RequestData])
    func memberViewControllerResponse(selecteArray: [MemberInfo])
    func buddiesViewControllerResponse(selectedBuddy: [MemberInfo])
    func AddGuestChildren(selecteArray: [RequestData])
}

extension MemberViewControllerDelegate
{
    func multiSelectRequestMemberViewControllerResponse (selectedArray : [[RequestData]]){
        
    }
}

class MemberDirectoryViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate, UISearchBarDelegate,UISearchControllerDelegate, UIGestureRecognizerDelegate  {
    var isReservation: String?
    var isFrom : NSString!
    var categoryForBuddy: String?
    var isOnlyFrom : String!
    var index : Int!
    var type : NSString!
    var locationIndex: Int!
    var registerType: String?
    var forDiningEvent: String?
    var isFor: String?
    var eventRegId: String?
    var isFromDashBoard: Bool?
    var isFirsttime: Bool?
    var selectedAlphabet: String?
    /// Member data of tennis and BMS. Used to identify duplicates
    ///
    /// Note : Dont pass any data to this incase of Multiselect being enabled
    var membersData =  [RequestData]()
    var arrTempPlayers = [RequestData]()
    //This array is used to store the selected member for all reservations and BMS in single selection
    var memberDetails = [RequestData]()
    var partyList = [Dictionary<String, Any>]()
    var groupList = [Dictionary<String, Any>]()
    var arrEventPlayers = [RequestData]()
    var eventID : String?
    var requestID : String?

    var gameType : String?
    var selectedDates = [Dictionary<String, Any>]()
    var memberArrayList = [Dictionary<String, Any>]()
    

    /**Used to show Horizontal scroll segement controller.Default is false.
     
     Note:- Currently only being used to show for reservation add guest/Ticket.
     */
    var showSegmentController : Bool = false
    
    //temp group is only used for Golf.
    //NOTE : Dont pass any valus to these variables related to tennis group in case of multi select.
    var arrTempGroup1 = [RequestData]()
    var arrTempGroup2 = [RequestData]()
    var arrTempGroup3 = [RequestData]()
    var arrTempGroup4 = [RequestData]()
     
    /// 1st group member details
    ///
    /// Used to detect duplicate(same member selection twice) selection
    var arrGroup1 = [RequestData]()
    /// 2nd group member details
    ///
    /// Used to detect duplicate(same member selection twice) selection
    var arrGroup2 = [RequestData]()
    /// 3rd group member details
    ///
    /// Used to detect duplicate(same member selection twice) selection
    var arrGroup3 = [RequestData]()
    /// 4th group member details
    ///
    /// Used to detect duplicate(same member selection twice) selection
    var arrGroup4 = [RequestData]()
    
    var isGolfChildren: Bool?
    

    
    var selectedDate: String?
    var selectedTime: String?
    var reservationRequestDates = [String]()

    
    @IBOutlet weak var btnFiter: UIButton!
    var searchController : UISearchController!
    private var memDictSearchbar: UISearchBar!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var loadMoreView: UIView!
    @IBOutlet weak var btnLoadMore: UIButton!
    @IBOutlet weak var baseSaegmentView: UIView!
   // @IBOutlet weak var segmentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var uiSegmentView: UIView!
    @IBOutlet weak var uiViewMemberMybuddies: UIView!
    @IBOutlet weak var btnMyBuddies: UIButton!
    @IBOutlet weak var btnMembers: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnAddToBuddies: UIButton!
    @IBOutlet weak var boardofDireViewHight: NSLayoutConstraint!
    @IBOutlet weak var heightSectionsView: NSLayoutConstraint!
    @IBOutlet weak var boardOfDirectors: UIView!
    @IBOutlet weak var viewSections: UIView!
    @IBOutlet weak var tblMemberDirectory: UITableView!
    @IBOutlet weak var lblBoardOfDirectory: UILabel!
    @IBOutlet weak var memberSearchBar: UISearchBar!
    @IBOutlet weak var btnBoardOfGoverners: UIButton!
    @IBOutlet weak var lblInstructions: UILabel!
    @IBOutlet weak var viewInstructions: UIView!
    
    @IBOutlet var collectionSegmentedView: [UIView]!
    
    @IBOutlet var collectionSegmentedViewBttn : [UIButton]!
    
    @IBOutlet weak var viewMultiSelection: UIView!
    @IBOutlet weak var collectionViewMultiSelection: UICollectionView!
    @IBOutlet weak var lblMultiSelectionCount: UILabel!
    @IBOutlet weak var viewAddBuddy: UIView!
    
    
    var isDataLoading:Bool=false
    var pageNo:Int = 1
    var limit:Int = 20
    var offset:Int = 0 //pageNo*limit
    var didEndReached:Bool=false
    var filter:String!
    var strSearch = String()
    var refreshControl = UIRefreshControl()
    var Category: NSString!
    var arrIndexSection: [String] = []
    var arrVerticalIndexSection: [String] = []
    var arrEmpty: [String] = []

    var selectedSection:Int = -1
    var selectedRow:Int = -1
    var delegate: MemberViewControllerDelegate?
    var delegateGuestChildren: AddGuestChildren?

    var isAddToBuddy : Int?
    var arrEventCategory = [ListEventCategory]()
    var segmentedController = ScrollableSegmentedControl()
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let collation = UILocalizedIndexedCollation.current()
    
    var contacts = [MemberInfo]()
    ///Contains the array of Members/Buddies Who are devided in to arrays of Member/Buddies with alphabetical sort.
    ///
    /// using UILocalizedIndexedCollation
    var contactsWithSections = [[MemberInfo]]()
    var dictgiftcardInfo = MemberInfo()
    var eventCategory: String?
    var eventCategoryForActionSheet: String?
    var isOnlyFor : String?
    
    ///Titles for sections with respect to contactsWithSections generated by UILocalizedIndexedCollation.
    var sectionTitles = [String]()
    
    var rightSearchbarButton = UIBarButtonItem()
    var halfModalTransitioningDelegate: HalfModalTransitioningDelegate?
    var filterTapped: String?
    var arrMemberList = [MemberInfo]()
    var filterBarButtonItem: UIBarButtonItem!
    
    var categoryType: String?
    var categoryType2: String?
    var categoryType3: String?
    /**The total number of tickets which can be added (or) total tickets available*/
    var totalNumberofTickets: Int?
    var showGuest: Int?
    var showKids: Int?
    var showSpouse: Int?
    
    /**used to show instruction label. label is hidden for None case*/
    var eventType : EventType = .none
    
    /// Enables multiselection of the Members/Buddies
    ///
    ///  Note :  Along with enablling this variable one should also assign values to arrMultiSelectedMembers and conform to the protocol multiSelectRequestMemberViewControllerResponse (selectedArray : [[RequestData]]).  Functionality only implemented for Golf/Tennis Reservation.
    var shouldEnableMultiSelect : Bool = false
    
    ///Array of groups of members
    ///
    /// Each array is a group of members. The tickets count , selected tickets and max ticktest are calculated based on this array.
    ///
    /// Note : The multi select functionality works depends on this array. This array must contain atleast one array(group) of members and empty records in case of no member. otherwise functionality will break.
    var arrMultiSelectedMembers = [[RequestData]]()
    
    ///Skipped positions indexes
    ///
    /// used to identify the positions which are skipped.
    private var arrSkippedIndexes = [IndexPath]()
    
    /// Bool which enables skipping of positions while multi selection is active
    ///
    /// enables the functionality where user can skip a position in group by clicking on the cell in collection view (multi select collectionview which shows selected members.)
    ///
    /// Note : This will only work if the variable shouldEnableMultiSelect is set to true
    var shouldEnableSkipping = false
    
    ///Used to empty array while fetching buddies form section indexes(contacts like aplhabetic sorting menu)
    var shouldEmptyArray = false
    
    ///Holds the tasks which fetch
    private var arrProfilePicTask = [String : ImageDownloadTask]()
    
    //Added on 16th June 2020 BMS
    var appointmentType : MemberSelectionType?
    var hideAddToBuddy = false
    
    //Added on 4th July 2020 V2.2
    private let accessManager = AccessManager.shared
    
    //Added on 15th July 2020 V2.2
    var isEvent : Bool?
    
    //Added on 9th October 2020 v2.3
    ///slelected Restaurant ID. Only used for dining
    var preferedSpaceDetailId : String?
    
    //Added by kiran V2.7 -- GATHER0000832
    //GATHER0000832 -- Start
    var duration : String?
    //GATHER0000832 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initController()
        self.appDelegate.arrSelectedTagg.removeAll()
   //     self.refreshControls()
        self.setColorCode()
        
        
        self.hideInstructions(self.eventType == .none)
        
        switch self.eventType {
        case .member_Guest:
            self.lblInstructions.text = self.isFrom == "BuddyList" ? self.appDelegate.masterLabeling.DIRECTORY_BUDDY_GUEST_INSTRUCTION : self.appDelegate.masterLabeling.DIRECTORY_MEMBER_GUEST_INSTRUCTION
        case .member_Kid:
            self.lblInstructions.text = self.isFrom == "BuddyList" ? self.appDelegate.masterLabeling.DIRECTORY_BUDDY_KID_ISNTRUCTION : self.appDelegate.masterLabeling.DIRECTORY_MEMBER_KID_INSTRUCTION
        case .member_Kid_Guest:
            self.lblInstructions.text = self.isFrom == "BuddyList" ? self.appDelegate.masterLabeling.DIRECTORY_BUDDY_GUEST_KID_INSTRUCTION : self.appDelegate.masterLabeling.DIRECTORY_MEMBER_GUEST_KID_INSTRUCTION
        case .none , .member_Only:
            self.lblInstructions.text = ""
        }
        
        isGolfChildren = false
        if (isFrom == "Registration"){
            memberSearchBar.placeholder = self.appDelegate.masterLabeling.search_memberName_id ?? "" as String
        }
        else if (isFrom == "BuddyList"){
            memberSearchBar.placeholder = self.appDelegate.masterLabeling.search_buddyname_Id ?? "" as String
        }
        else{
        memberSearchBar.placeholder = self.appDelegate.masterLabeling.search_memberName_id ?? "" as String
        }
        btnBoardOfGoverners.setTitle(self.appDelegate.masterLabeling.board_of_governers ?? "" as String, for: UIControlState.normal)
        
        self.btnBoardOfGoverners.layer.borderWidth = 1
        self.btnBoardOfGoverners.layer.borderColor = hexStringToUIColor(hex: "C1C1C1").cgColor
        self.btnBoardOfGoverners.layer.cornerRadius = 15

      
        self.btnMembers.layer.cornerRadius = 17
        self.btnMembers.layer.masksToBounds = true
     
        self.uiViewMemberMybuddies.layer.borderWidth = 1
        self.uiViewMemberMybuddies.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        self.uiViewMemberMybuddies.layer.cornerRadius = 17
        self.uiViewMemberMybuddies.layer.masksToBounds = true
        

        self.btnMyBuddies.layer.cornerRadius = 17
        self.btnMyBuddies.layer.masksToBounds = true
        self.btnMyBuddies.backgroundColor = UIColor.clear
        
        self.btnLoadMore.isHidden = true
        if isFromDashBoard == true || self.showSegmentController{
        self.isFirsttime = true
            
        self.hideSegmentedControllerView(false)
            
        //self.baseSaegmentView.isHidden = false
        //self.segmentViewHeight.constant = 62
        }else{
            
            self.hideSegmentedControllerView(true)
            
           // self.baseSaegmentView.isHidden = true
           // self.segmentViewHeight.constant = 0
        }
        
        self.navigationItem.backBarButtonItem?.title = ""

        memberSearchBar.searchBarStyle = .default
        
        memberSearchBar.layer.borderWidth = 1
        memberSearchBar.layer.borderColor = hexStringToUIColor(hex: "F5F5F5").cgColor
        
        //Modified on 16th June 2020 BMS
        //isAddToBuddy = 1
        isAddToBuddy = self.hideAddToBuddy ? 0 : 1
        
        //Modified on 5th August 2020 V2.3
        if self.isFrom == "BuddyList"
        {
            //When iSAddToBuddy is 1 then the backend will add the that member/buddy/geust to buddylist without any further checks.
            self.isAddToBuddy = 0
        }

        arrIndexSection = ["All","A", "B", "C", "D", "E",  "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        
        arrVerticalIndexSection = ["A", "B", "C", "D", "E",  "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

        
        
        if self.isFromDashBoard == true {
           // self.membersButtonClicked()
            self.myBuddiesClicked(self.btnMyBuddies)
            self.membersClicked(self.btnMembers)
        }
        
        if self.showSegmentController
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.005) {
                self.loadsegmentController()
            }
            
           // self.getMemberDirectoryCategoriesApi(strSearch: "")
           
        }
        
        //Load more button text
        self.btnLoadMore.setTitle(self.appDelegate.masterLabeling.SHOW_MORE ?? "", for: .normal)
        
        self.btnMembers.setStyle(style: .contained, type: .primary)
        self.btnMyBuddies.setStyle(style: .outlined, type: .primary)
        self.uiViewMemberMybuddies.layer.borderColor = APPColor.MainColours.primary1.cgColor
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    

    //Added on 23rd June 2020 BMS
    
    @objc private func backBtnClicked(sender:UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
//
//    func refreshControls()
//    {
//
//        self.refreshControl.attributedTitle = NSAttributedString(string: "")
//        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
//        self.tblMemberDirectory.addSubview(refreshControl) // not required when using UITableViewController
//
//    }
//
//    @objc func refresh(sender:AnyObject) {
//
//        // Code to refresh table view
//        self.arrMemberList.removeAll()
//        self.tblMemberDirectory.reloadData()
//        self.pageNo = 1
//        if (isFrom == "Registration"){
//            self.getMemberSpouseList(searchWithString: (strSearch))
//        }
//        else if (isFrom == "BuddyList") || type == "MyBuddies"{
//            self.getBuddyList(searchWithString: (strSearch))
//        }
//        else{
//            self.getMemberDirectory(withFilter: self.appDelegate.strFilterSting,searchWithString: (strSearch ))
//        }
//        self.memDictSearchbar.text = ""
//        self.refreshControl.endRefreshing()
//    }
//
    
    //Mark- Go to Filter menu
    @objc func onTapFilter() {

        filterTapped = "Yes"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pvc = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        
        pvc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(pvc, animated: true, completion: nil)
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
//        FilterFrom = ""
    }
    
    
    @IBAction func previousClicked(_ sender: Any) {
        if type == "MyBuddies"{
        if self.arrEventCategory.count == 0 || self.arrIndexSection.count == 0 {
            
        }else{
        var selectedSegment =  self.segmentedController.selectedSegmentIndex  - 1
        if selectedSegment <= 0  {
            selectedSegment = 0
        }
        self.appDelegate.selectedEventsCategory = self.arrEventCategory[selectedSegment]
        self.segmentedController.selectedSegmentIndex = selectedSegment
            }
        }else{
            var selectedSegment =  self.segmentedController.selectedSegmentIndex  - 1
            if selectedSegment <= 0  {
                selectedSegment = 0
            }
            selectedAlphabet = self.arrIndexSection [selectedSegment]
            self.segmentedController.selectedSegmentIndex = selectedSegment
        }
    }
    
    @IBAction func nextClicked(_ sender: Any) {
        if type == "MyBuddies"{
        if self.arrEventCategory.count == 0 || self.arrIndexSection.count == 0{
            
        }else{
        var selectedSegment =  self.segmentedController.selectedSegmentIndex  + 1
        
        
        if selectedSegment >= self.segmentedController.numberOfSegments  {
            selectedSegment = self.segmentedController.numberOfSegments - 1
        }
        
        
        self.appDelegate.selectedEventsCategory = self.arrEventCategory[selectedSegment]
        
        
        self.segmentedController.selectedSegmentIndex = selectedSegment
            }}else{
            var selectedSegment =  self.segmentedController.selectedSegmentIndex + 1
            
            
            if selectedSegment >= self.segmentedController.numberOfSegments  {
                selectedSegment = self.segmentedController.numberOfSegments - 1
            }
            
            
            selectedAlphabet = self.arrIndexSection[selectedSegment]
            
            self.segmentedController.selectedSegmentIndex = selectedSegment
        }
    }
    //MARK:- Segment Controller Selected
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        self.scrollToFirstRow()

        self.arrMemberList.removeAll()
        
        self.pageNo = 1
        if type == "MyBuddies"{

        self.appDelegate.selectedEventsCategory = self.arrEventCategory[sender.selectedSegmentIndex]

       
        eventCategory = self.appDelegate.selectedEventsCategory.categoryValue ?? ""
        
        if self.appDelegate.selectedEventsCategory.categoryValue == "MyGroups" {
            let myGroup = storyboard!.instantiateViewController(withIdentifier: "MyGroupsVC")
            //            previousStatementVC.title =  self.appDelegate.masterLabeling.tAB_PREVIOUS
            self.tblMemberDirectory.isHidden = true
            configureChildViewControllerForstatenents(childController: myGroup, onView: self.mainView)
        }else{
            self.tblMemberDirectory.isHidden = false
            if self.childViewControllers.count > 0{
                let viewControllers:[UIViewController] = self.childViewControllers
                for viewContoller in viewControllers{
                    viewContoller.willMove(toParentViewController: nil)
                    viewContoller.view.removeFromSuperview()
                    viewContoller.removeFromParentViewController()
                }
            }
        self.getBuddyList(searchWithString: (strSearch))

        }
        }else{
            selectedAlphabet = self.arrIndexSection[sender.selectedSegmentIndex]
            if self.isFrom == "BuddyList"
            {
                self.getBuddyList(searchWithString: (strSearch))
            }
            else
            {
                if self.isFrom == "Registration"
                {
                    self.getMemberSpouseList(searchWithString: strSearch)
                }
                else
                {
                    self.getMemberDirectory(withFilter: self.appDelegate.strFilterSting,searchWithString: (strSearch ))
                }
                
                //self.getMemberDirectory(withFilter: self.appDelegate.strFilterSting,searchWithString: (strSearch ))
            }
            

        }
    }
    
    
    func loadsegmentController()  {
        
        self.segmentedController = ScrollableSegmentedControl.init(frame: self.uiSegmentView.bounds)
        self.uiSegmentView.addSubview(self.segmentedController)
        self.segmentedController.segmentStyle = .textOnly
        
        //self.segmentedController.segmentStyle = .imageOnLeft
        
        
        self.segmentedController.underlineSelected = true
        self.segmentedController.backgroundColor = hexStringToUIColor(hex: "F5F5F5")
        
        self.segmentedController.tintColor = APPColor.loginBackgroundButtonColor.loginBtnBGColor
        
        self.segmentedController.addTarget(self, action: #selector(CalendarOfEventsViewController.segmentSelected(sender:)), for: .valueChanged)
        self.segmentedController.contentMode = .center
        // self.segmentedController.removeFromSuperview()
        if type == "MyBuddies"{
        for i in 0 ..< self.arrEventCategory.count {
            let statementData = self.arrEventCategory[i]
            
            self.segmentedController.insertSegment(withTitle: statementData.categoryName, image: nil, at: i)

        }
        }else{
            self.segmentedController.segmentContentColor = hexStringToUIColor(hex: "40B2E6")
            self.segmentedController.selectedSegmentContentColor = APPColor.textColor.secondary
            self.segmentedController.widthPadding = 25
            for i in 0 ..< self.arrIndexSection.count {
                
                self.segmentedController.insertSegment(withTitle: self.arrIndexSection[i], image: nil, at: i)
                
            }
        }
        
        self.segmentedController.selectedSegmentIndex = 0
        
    }
    
    private func hideSegmentedControllerView(_ bool : Bool)
    {
        self.collectionSegmentedView.forEach({ $0.isHidden = bool})
        self.collectionSegmentedViewBttn.forEach({$0.isHidden = bool})
        
        self.baseSaegmentView.isHidden = self.lblInstructions.isHidden ? bool : false
        
    }
    
    private func hideInstructions(_ bool : Bool)
    {
        self.lblInstructions.isHidden = bool
        self.viewInstructions.isHidden = bool
    }
    
    
//    func membersButtonClicked(){
//        self.arrMemberList.removeAll()
//        type = "Member"
//        self.navigationItem.rightBarButtonItem = filterBarButtonItem;
//
//        self.btnMembers.layer.cornerRadius = 17
//        self.btnMembers.layer.masksToBounds = true
//        self.btnMembers.backgroundColor = hexStringToUIColor(hex: "F37D4A")
//        self.btnMembers.setTitleColor(.white, for: .normal)
//
//        self.btnMyBuddies.layer.cornerRadius = 17
//        self.btnMyBuddies.layer.masksToBounds = true
//        self.btnMyBuddies.backgroundColor = UIColor.clear
//        self.btnMyBuddies.setTitleColor(hexStringToUIColor(hex: "F37D4A"), for: .normal)
//        if isFromDashBoard == true{
//            self.baseSaegmentView.isHidden = false
//            self.segmentViewHeight.constant = 62
//        }else{
//            self.baseSaegmentView.isHidden = true
//            self.segmentViewHeight.constant = 0
//        }
//
//
//        self.tblMemberDirectory.isHidden = false
//        //     self.getMemberDirectory(withFilter: self.appDelegate.strFilterSting,searchWithString: (strSearch ))
//        if self.childViewControllers.count > 0{
//            let viewControllers:[UIViewController] = self.childViewControllers
//            for viewContoller in viewControllers{
//                viewContoller.willMove(toParentViewController: nil)
//                viewContoller.view.removeFromSuperview()
//                viewContoller.removeFromParentViewController()
//            }
//        }
//        self.loadsegmentController()
//
//    }
    
    @IBAction func membersClicked(_ sender: Any) {
        self.arrMemberList.removeAll()
        type = "Member"
        self.navigationItem.rightBarButtonItem = filterBarButtonItem;
        
        self.btnMembers.layer.cornerRadius = 17
        self.btnMembers.layer.masksToBounds = true
        self.btnMembers.backgroundColor = hexStringToUIColor(hex: "F37D4A")
        self.btnMembers.setTitleColor(.white, for: .normal)
        self.btnMembers.setStyle(style: .contained, type: .primary)
        
        self.btnMyBuddies.layer.cornerRadius = 17
        self.btnMyBuddies.layer.masksToBounds = true
        self.btnMyBuddies.backgroundColor = UIColor.clear
        self.btnMyBuddies.setTitleColor(hexStringToUIColor(hex: "F37D4A"), for: .normal)
        self.btnMyBuddies.setStyle(style: .outlined, type: .primary)
        if isFromDashBoard == true || self.showSegmentController{
            self.hideSegmentedControllerView(false)
            
            //self.baseSaegmentView.isHidden = false
            //self.segmentViewHeight.constant = 62
        }else{
           self.hideSegmentedControllerView(true)
            
            // self.baseSaegmentView.isHidden = true
           // self.segmentViewHeight.constant = 0
        }
        
        
        self.tblMemberDirectory.isHidden = false
        //     self.getMemberDirectory(withFilter: self.appDelegate.strFilterSting,searchWithString: (strSearch ))
        if self.childViewControllers.count > 0{
            let viewControllers:[UIViewController] = self.childViewControllers
            for viewContoller in viewControllers{
                viewContoller.willMove(toParentViewController: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParentViewController()
            }
        }
        
        if self.isFirsttime == true {
            self.isFirsttime = false
        }else{
        self.loadsegmentController()
        }
        
    }
    @IBAction func myBuddiesClicked(_ sender: Any) {
       // self.arrMemberList.removeAll()
         self.btnLoadMore.isHidden = true
        type = "MyBuddies"
        self.navigationItem.rightBarButtonItem = nil;


        self.btnMembers.layer.cornerRadius = 17
        self.btnMembers.layer.masksToBounds = true
        self.btnMembers.backgroundColor = UIColor.clear
        self.btnMembers.setTitleColor(hexStringToUIColor(hex: "F37D4A"), for: .normal)
        self.btnMembers.setStyle(style: .outlined, type: .primary)

        self.btnMyBuddies.layer.cornerRadius = 17
        self.btnMyBuddies.layer.masksToBounds = true
        self.btnMyBuddies.backgroundColor = hexStringToUIColor(hex: "F37D4A")
        self.btnMyBuddies.setTitleColor(.white, for: .normal)
        self.btnMyBuddies.setStyle(style: .contained, type: .primary)
        
        
        self.hideSegmentedControllerView(false)
        //self.baseSaegmentView.isHidden = false
        //self.segmentViewHeight.constant = 62
       
        
        self.getMemberDirectoryCategoriesApi(strSearch : "")
        

    //    self.getBuddyList(searchWithString: (strSearch))
        

    }
    @IBAction func boardOfGovernersClicked(_ sender: Any) {
        
        let restarantpdfDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
        if self.appDelegate.arrBoardofGovernors.count == 0 {
          restarantpdfDetailsVC.pdfUrl = ""
        }else{
        restarantpdfDetailsVC.pdfUrl = self.appDelegate.arrBoardofGovernors[0].url ?? ""
        }
        restarantpdfDetailsVC.restarantName = self.appDelegate.masterLabeling.board_of_governers ?? "" as String
        
        self.navigationController?.pushViewController(restarantpdfDetailsVC, animated: true)
        
    }
   
  
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isDataLoading = false
    }
    

    
    //MARK:- Scroll to first row
    func scrollToFirstRow() {
        if(self.arrMemberList.count > 0){
            let indexPath = IndexPath(row: 0, section: 0)
            self.tblMemberDirectory.scrollToRow(at: indexPath, at: .top, animated: true)
            
            
        }
    }
    
    
    //MARK:- Token Api
//    func getAuthToken(){
//
//        if (Network.reachability?.isReachable) == true{
//            APIHandler.sharedInstance.getTokenApi(paramater: nil , onSuccess: { tokenList in
//                let access_token = tokenList.access_token
//                let expires_in = tokenList.expires_in
//                let token_type = tokenList.token_type
//                let jointToken = (token_type ?? "") + " " + (access_token ?? "")
//
//                //                print(jointToken)
//
//                UserDefaults.standard.set(access_token, forKey: UserDefaultsKeys.access_token.rawValue)
//                UserDefaults.standard.set(expires_in, forKey: UserDefaultsKeys.expires_in.rawValue)
//                UserDefaults.standard.set(token_type, forKey: UserDefaultsKeys.token_type.rawValue)
//                UserDefaults.standard.set(jointToken, forKey: UserDefaultsKeys.apiauthtoken.rawValue)
//                UserDefaults.standard.synchronize()
//                //                print(UserDefaults.standard.string(forKey: UserDefaultsKeys.apiauthtoken.rawValue) ?? "")
//
//
//
//            },onFailure: { error  in
//
//                print(error)
//                SharedUtlity.sharedHelper().showToast(on:
//                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
//            })
//        }
//    }
    
  
    //MARK:- Search bar logic
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.contactsWithSections.removeAll()
        self.sectionTitles.removeAll()
            self.arrMemberList.removeAll()
            self.pageNo = 1
            self.appDelegate.memberDictSearchText = searchBar.text ?? ""
            strSearch = memberSearchBar.text ?? ""
            if (isFrom == "Registration"){

                self.getMemberSpouseList(searchWithString: (strSearch))
            }
            else if (isFrom == "BuddyList"){
                self.getBuddyList(searchWithString: (strSearch))
            }else if type == "MyBuddies"{
                 self.getBuddyList(searchWithString: (strSearch))
            }
            else{
            self.getMemberDirectory(withFilter: self.appDelegate.strFilterSting,searchWithString: (strSearch ))
            }
            self.scrollToFirstRow()
            self.tblMemberDirectory.reloadData()
            self.btnLoadMore.isHidden = true
            NotificationCenter.default.post(name: NSNotification.Name("searchData"), object: nil, userInfo:nil )

            searchBar.resignFirstResponder()

        
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if searchText.count == 0 {
            self.contactsWithSections.removeAll()
            self.sectionTitles.removeAll()
            self.arrMemberList.removeAll()
            self.pageNo = 1
            self.appDelegate.memberDictSearchText = searchBar.text ?? ""
            strSearch = memberSearchBar.text ?? ""
            
            if (isFrom == "Registration"){
                self.getMemberSpouseList(searchWithString: (strSearch))
            }
            else if (isFrom == "BuddyList"){
                self.getBuddyList(searchWithString: (strSearch))
            }
            else if type == "MyBuddies"{
                self.getBuddyList(searchWithString: (strSearch))
            }
            else{
                self.getMemberDirectory(withFilter: self.appDelegate.strFilterSting,searchWithString: (strSearch ))
            }
            self.tblMemberDirectory.reloadData()
            self.btnLoadMore.isHidden = true
            self.scrollToFirstRow()
            searchBar.resignFirstResponder()
        }
        NotificationCenter.default.post(name: NSNotification.Name("searchData"), object: nil, userInfo:nil )
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func loadMoreClicked(_ sender: Any) {
        
        
        self.pageNo=self.pageNo+1
        self.limit=self.limit+10
        self.offset=self.limit * self.pageNo
        if (isFrom == "Registration"){
            
            self.getMemberSpouseList(searchWithString: (strSearch))
        }
        else if (isFrom == "BuddyList") || (type == "MyBuddies"){
            self.getBuddyList(searchWithString: (strSearch))
        }
        else{
            self.getMemberDirectory(withFilter: self.appDelegate.strFilterSting,searchWithString: (strSearch ))
        }
    }
    
    
    
//    Mark- Pagination Logic
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // print("scrollViewDidEndDecelerating")
    }
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        if (isFromDashBoard == true && type == "Member") || self.showSegmentController{
            
        }else{
        if !decelerate {
            //didEndDecelerating will be called for sure
            return
        }
        else
        {
            if ((tblMemberDirectory.contentOffset.y + tblMemberDirectory.frame.size.height) >= tblMemberDirectory.contentSize.height)
            {
                if filterTapped == "Yes"{

                }else{
                if !isDataLoading{
                    isDataLoading = true
                    self.pageNo=self.pageNo+1
                    self.limit=self.limit+10
                    self.offset=self.limit * self.pageNo
                    if (isFrom == "Registration"){
                        self.getMemberSpouseList(searchWithString: (strSearch))
                    }
                    else if (isFrom == "BuddyList") || (type == "MyBuddies"){
                        //self.getBuddyList(searchWithString: (strSearch))
                    }
                    else{
                        self.getMemberDirectory(withFilter: self.appDelegate.strFilterSting,searchWithString: (strSearch ))
                    }
                }
            }
            }
        }
        }





    }
    
    //Mark- Common Color Code
    func setColorCode()
    {
        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg
        
        
    }
    //Commented by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead
    //ENGAGE0011419 -- Start
    //MARK:- verify url exist or not
//    func verifyUrl(urlString: String?) -> Bool {
//        if let urlString = urlString {
//            if let url = URL(string: urlString) {
//                return UIApplication.shared.canOpenURL(url)
//            }
//        }
//        return false
//    }
    //ENGAGE0011419 -- End
    
    func initController()
    {
        self.memDictSearchbar = UISearchBar()
        filter = "All"
//        if(self.appDelegate.strFilterSting == nil ||  self.appDelegate.strFilterSting.count == 0 ){
//            self.appDelegate.strFilterSting = "All"
//        }
        
        self.appDelegate.strFilterSting = "All"
        btnAdd.backgroundColor = .clear
        btnAdd.layer.cornerRadius = 18
        btnAdd.layer.borderWidth = 1
        btnAdd.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        self.btnAdd.setStyle(style: .outlined, type: .primary)
        
        btnLoadMore.backgroundColor = .clear
        btnLoadMore.layer.cornerRadius = 18
        btnLoadMore.layer.borderWidth = 1
        btnLoadMore.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        self.btnLoadMore.setStyle(style: .outlined, type: .primary)

        btnCancel.backgroundColor = .clear
        btnCancel.layer.cornerRadius = 18
        btnCancel.layer.borderWidth = 1
        btnCancel.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        self.btnCancel.setStyle(style: .outlined, type: .primary)
        
        btnAddToBuddies.backgroundColor = .clear
        btnAddToBuddies.layer.cornerRadius = 22
        btnAddToBuddies.layer.borderWidth = 1
        btnAddToBuddies.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        self.btnAddToBuddies.setStyle(style: .outlined, type: .primary)

        self.pageNo = 1
        self.appDelegate.memberDictSearchText = ""
        if (isFrom == "Registration"){
            if !self.showSegmentController
            {
                self.getMemberSpouseList(searchWithString: (strSearch))
            }
          //self.getMemberSpouseList(searchWithString: (strSearch))
        }
        else if (isFrom == "BuddyList"){
            eventCategory = self.categoryForBuddy
            if !self.showSegmentController
            {
                 self.getBuddyList(searchWithString: (strSearch))
            }

        }
        else{
           // self.getMemberDirectory(withFilter: self.appDelegate.strFilterSting,searchWithString: (strSearch ))
        }
        
        self.tblMemberDirectory.separatorInset = .zero
        self.tblMemberDirectory.layoutMargins = .zero
        self.tblMemberDirectory.rowHeight = 68
        self.tblMemberDirectory.separatorColor = APPColor.celldividercolor.divider
        
        //Multi Selection Collection view initial setups
        self.viewMultiSelection.isHidden = !self.shouldEnableMultiSelect
        self.lblMultiSelectionCount.isHidden = !self.shouldEnableMultiSelect
        self.lblMultiSelectionCount.text = ""
        self.collectionViewMultiSelection.isHidden = !self.shouldEnableMultiSelect
        
        if self.shouldEnableMultiSelect
        {
           
            self.collectionViewMultiSelection.delegate = self
            self.collectionViewMultiSelection.dataSource = self
            self.memberDetails.append(contentsOf: self.arrGroup1)
            self.memberDetails.append(contentsOf: self.arrGroup2)
            self.memberDetails.append(contentsOf: self.arrGroup3)
            self.memberDetails.append(contentsOf: self.arrGroup4)
            self.updateMultiSelectionDisplay()
        }
        
        
        
        
        
        
//        //search icons
//        self.rightSearchbarButton = UIBarButtonItem(image: UIImage(named: "Icon_SearchNavBar"), style: .plain, target: self, action: #selector(searchBarButtonPressed))
//        self.navigationItem.rightBarButtonItem = self.rightSearchbarButton
//        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.bextButtonPressedfromOtherViewController) , name:Notification.Name("NotificationIdentifier") , object: nil)
        
        self.tblMemberDirectory.allowsMultipleSelection = self.shouldEnableMultiSelect
        
    }
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    @objc func bextButtonPressedfromOtherViewController(notification: NSNotification){
        
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        guard (notification.userInfo?["SelectedItems"] as? String) != nil else { return}
        
        let list = self.appDelegate.arrSelectedTagg.joined(separator: ",")
        filter = list
        self.pageNo = 1
        self.appDelegate.strFilterSting = list
        self.arrMemberList.removeAll()
        
        if (isFrom == "Registration"){

            self.getMemberSpouseList(searchWithString: (strSearch))
        }
        else if (isFrom == "BuddyList"){
            self.getBuddyList(searchWithString: (strSearch))
        }
        else{
            self.getMemberDirectory(withFilter: self.appDelegate.strFilterSting,searchWithString: (strSearch ))
        }
        
    }
    
    
    //MARK:- Set cardview
    func setCardView(view : UIView){
        
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = 1;
        view.layer.shadowRadius = 2;
        view.layer.shadowOpacity = 0.5;
        
    }
    
    //MARK:- Tennis Duplicate (Member Validation)
    func CourtTimeDuplicate()
    {
        arrTempPlayers.removeAll()
        partyList.removeAll()
        self.selectedDates.removeAll()

        arrTempPlayers = self.membersData
        
        if self.shouldEnableMultiSelect
        {
            self.arrMultiSelectedMembers.forEach({self.arrTempPlayers.append(contentsOf: $0.filter({$0.isEmpty == false}))})
            //arrTempPlayers.append(contentsOf: self.memberDetails)
        }
        else
        {
            membersData.removeLast()
        }
        
        
        if (Network.reachability?.isReachable) == true
        {
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
            for i in 0 ..< arrTempPlayers.count
            {
                if  arrTempPlayers[i] is CaptaineInfo
                {
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
                    else if memberType == .existingGuest
                    {
                        
                        let memberInfo:[String: Any] = [
                            "LinkedMemberID": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID!,
                            "PlayerOrder": i + 1,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",
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
                    
                    //ENGAGE0011784 -- End
                }
                else if arrTempPlayers[i] is MemberInfo
                {
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
                        //Added by kiran V2.8 -- ENGAGE0011784 -- passed linked member id for existing guest support
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
            
            
            if gameType == "Singleday"
            {
                let dateInfo:[String: Any] = [
                    "RequestDate": selectedDate ?? "",
                ]
                selectedDates.append(dateInfo)
            
            }
            else
            {
            
                for i in 0 ..< reservationRequestDates.count
                {
                    let dateInfo:[String: Any] = [
                        "RequestDate": reservationRequestDates[i],
                    ]
                    selectedDates.append(dateInfo)
                
                }
            
            }
        
        }
        
        let paramaterDict:[String: Any] = [
            "Content-Type":"application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            "RequestId": requestID ?? "",
            "ReservationRequestDate": selectedDates,
            "ReservationRequestTime": selectedTime ?? "",
            "PlayerCount": 0,
            "Earliest": "",
            "Latest": "",
            "Comments": "",
            "TennisDetails" : partyList,
            "PlayType": "",
            "RequestType": gameType ?? "",
            //Added by kiran V2.7 -- GATHER0000832
            //GATHER0000832 -- Start
            APIKeys.kDuration :  self.duration ?? "",
            //GATHER0000832 -- End
            "BallMachine":0,
            "IsReservation": "1",
            "IsEvent": "0",
            "ReservationType": self.categoryForBuddy ?? "",
            "RegistrationID": requestID ?? ""
        ]
        
        //print("memberdict \(paramaterDict)")
        
        APIHandler.sharedInstance.getMemberValidation(paramater: paramaterDict, onSuccess: { (response) in
            
            self.appDelegate.hideIndicator()
            
            if response.responseCode == InternetMessge.kFail
            {
                            
                if self.shouldEnableMultiSelect
                {
                    if let duplicateDetails = response.details
                    {
                        self.showConflictedMembers(members: duplicateDetails, message: response.brokenRules?.fields?[0])
                    }
                    else
                    {
                        SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                    }
                }
                else
                {
                        SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                }
                           
            }
            else
            {
                            
                if(self.isAddToBuddy == 1)
                {
                    if(self.isFrom == "BuddyList"){
                                    
                    }
                    else
                    {
                        self.AddtoBuddyList()
                                    
                    }
                                
                }
                            
                            
                if self.shouldEnableMultiSelect
                {
                    self.delegate?.multiSelectRequestMemberViewControllerResponse(selectedArray: self.arrMultiSelectedMembers)
                }
                else
                {
                    self.delegate?.requestMemberViewControllerResponse(selecteArray: self.memberDetails)
                }
                            
                self.navigationController?.popViewController(animated: true)
                            
            }
            
        }) { (error) in
            
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            self.appDelegate.hideIndicator()
            
        }
        
    }
    
    //MARK:- Golf Duplicates (Member Validation)
    ///Member validation for golf.
    ///
    /// Checks if the member is already part of a reservation or not. To avoid adding the same mumber multiple times to the same request before submitting it we are appending the current selection member to the previous selection and sending to check duplicates.
    func golfDuplicates(){
        
        arrTempGroup1.removeAll()
        arrTempGroup2.removeAll()
        arrTempGroup3.removeAll()
        arrTempGroup4.removeAll()
        groupList.removeAll()

        arrTempGroup1 = arrGroup1
        arrTempGroup2 = arrGroup2
        arrTempGroup3 = arrGroup3
        arrTempGroup4 = arrGroup4
        
        //Note:- previously the selected member was added to group4 and then removed here. From multiselect instead of appending to array4 and calling golfDuplicates we are adding the selected members to arrTempGroup4 avoiding the need to add and remove
        if self.shouldEnableMultiSelect
        {
            self.arrMultiSelectedMembers.forEach({self.arrTempGroup4.append(contentsOf: $0.filter({$0.isEmpty == false}))})
            //self.arrTempGroup4.append(contentsOf: self.memberDetails)
        }
        else
        {
            self.arrGroup4.removeLast()
        }
        
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            for i in 0 ..< arrTempGroup1.count {
                
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
                        "AddBuddy": 0
                        
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
                            "PlayerGroup": 1,
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
                        groupList.append(memberInfo)
                    }
                    else if memberType == .existingGuest
                    {
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": 1,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "AddBuddy": playObj.addBuddy ?? 0
                            
                        ]
                        //TODO:- Remove after approval
                        /*
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": 1,
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
                            "PlayerGroup":  1,
                            "GuestMemberOf": "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "AddBuddy": playObj.addBuddy ?? 0
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
                        "PlayerGroup": 1,
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "AddBuddy": 0
                        
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
                        "PlayerGroup":1,
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
                    groupList.append(memberInfo)
                }
            }
            
            for i in 0 ..< arrTempGroup2.count {
                
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
                        "AddBuddy": 0
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
                            "PlayerGroup": 2,
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
                        groupList.append(memberInfo)
                    }
                    else if memberType == .existingGuest
                    {
                        
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": 2,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "AddBuddy": playObj.addBuddy ?? 0
                            
                        ]
                        //TODO:- Remove after approval
                        /*
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId":  playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": 2,
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
                            "PlayerGroup": 2,
                            "GuestMemberOf": "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "AddBuddy": playObj.addBuddy ?? 0
                            
                        ]
                        groupList.append(memberInfo)
                    }
                    //ENGAGE0011784 -- End
                    
                }else if arrTempGroup2[i] is MemberInfo {
                    let playObj = arrTempGroup2[i] as! MemberInfo
                    
                    let memberInfo:[String: Any] = [
                        "PlayerLinkedMemberId": playObj.id ?? "",
                        "ReservationRequestDetailId":"",
                        "PlayerOrder": i + 1,
                        "PlayerGroup": 2,
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "AddBuddy": 0
                        
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
                        "PlayerGroup": 2,
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
                    groupList.append(memberInfo)
                }
            }
           
            for i in 0 ..< arrTempGroup3.count {
                
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
                        "AddBuddy": 0
                        
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
                            "PlayerGroup": 3,
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
                        groupList.append(memberInfo)
                    }
                    else if memberType == .existingGuest
                    {
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": 3,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "AddBuddy": playObj.addBuddy ?? 0
                            
                        ]
                        //TODO:- Remove after approval
                        /*
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId":  playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": 3,
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
                            "PlayerGroup": 3,
                            "GuestMemberOf": "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "AddBuddy": playObj.addBuddy ?? 0
                            
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
                        "PlayerGroup": 3,
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "AddBuddy": 0
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
                        "PlayerGroup": 3,
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
                    groupList.append(memberInfo)
                }
            }
            
            for i in 0 ..< arrTempGroup4.count {
                
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
                        "AddBuddy": 0
                        
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
                            "PlayerGroup": 4,
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
                        groupList.append(memberInfo)
                    }
                    else if memberType == .existingGuest
                    {
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": 4,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "AddBuddy": playObj.addBuddy ?? 0
                            
                        ]
                        //TODO:- Remove after approval
                        /*
                        let memberInfo:[String: Any] = [
                            "PlayerLinkedMemberId":  playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailID ?? "",
                            "PlayerOrder": i + 1,
                            "PlayerGroup": 4,
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
                            "PlayerGroup": 4,
                            "GuestMemberOf": "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "AddBuddy": playObj.addBuddy ?? 0
                            
                        ]
                        groupList.append(memberInfo)
                    }
                    
                    //ENGAGE0011784 -- End
                }else if arrTempGroup4[i] is MemberInfo {
                    let playObj = arrTempGroup4[i] as! MemberInfo
                    
                    let memberInfo:[String: Any] = [
                        "PlayerLinkedMemberId": playObj.id ?? "",
                        "ReservationRequestDetailId": "",
                        "PlayerOrder": i + 1,
                        "PlayerGroup": 4,
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "AddBuddy": 0
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
                        "PlayerGroup": 4,
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
                    
                    groupList.append(memberInfo)
                }
            }
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "RequestId": requestID ?? "",
                "ReservationRequestDate": selectedDate ?? "",
                "ReservationRequestTime": selectedTime ?? "",
                "GroupDetails": groupList,
                "GroupCount":  0,
                "GameType": 9,
                "LinkGroup": 1,
                "Earliest": "",
                "PreferedSpaceDetailId": [],
                "NotPreferedSpaceDetailId": [],
                "IsReservation": "1",
                "IsEvent": "0",
                "ReservationType": self.categoryForBuddy ?? "",
                "RegistrationID": requestID ?? ""
            ]
//            print(paramaterDict)
            APIHandler.sharedInstance.getMemberValidation(paramater: paramaterDict, onSuccess: { (response) in
                
                self.appDelegate.hideIndicator()
                
                
                if response.responseCode == InternetMessge.kFail {
                    if self.shouldEnableMultiSelect
                    {
                        if let duplicateDetails = response.details
                        {
                            self.showConflictedMembers(members: duplicateDetails, message: response.brokenRules?.fields?[0])
                        }
                        else
                        {
                            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                        }
                         
                    }
                    else
                    {
                        SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                    }
                    
                }else{
                    
                    if(self.isAddToBuddy == 1){
                        if(self.isFrom == "BuddyList"){
                            
                        }
                        else{
                            
                            self.AddtoBuddyList()
                        }
                    }
                    
                    if self.shouldEnableMultiSelect
                    {
                        self.delegate?.multiSelectRequestMemberViewControllerResponse(selectedArray: self.arrMultiSelectedMembers)
                    }
                    else
                    {
                        self.delegate?.requestMemberViewControllerResponse(selecteArray: self.memberDetails)
                    }
                    
               
                self.navigationController?.popViewController(animated: true)
                }
            }) { (error) in
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
                self.appDelegate.hideIndicator()
            }
        }
        
    }
    
    
    //MARK:- Events Duplicate (Member Validation)
    func eventsDuplicate(){
        self.arrTempPlayers.removeAll()
        self.memberArrayList.removeAll()
        self.arrTempPlayers = self.arrEventPlayers

       
        self.arrEventPlayers.removeLast()
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
           
            for i in 0 ..< arrTempPlayers.count {
                if  arrTempPlayers[i] is CaptaineInfo {
                    let playObj = arrTempPlayers[i] as! CaptaineInfo
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
                    
                }else if arrTempPlayers[i] is GuestChildren {
                    let playObj = arrTempPlayers[i] as! GuestChildren
                    
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
                else if arrTempPlayers[i] is MemberInfo {
                    let playObj = arrTempPlayers[i] as! MemberInfo
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
                    
                }
            }
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                "Role": UserDefaults.standard.string(forKey: UserDefaultsKeys.role.rawValue)!,
                "EventID": eventID ?? "",
                "Comments": "",
                "NumberOfTickets": "",
                "EventRegistrationID": "",
                "MemberList": memberArrayList,
                "BuddyList": [],
                "GuestList": [],
                "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue) ?? "",
                "IsReservation": "0",
                "IsEvent": "1",
                "ReservationType": "",
                "RegistrationID": requestID ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            
//            print("memberdict \(paramaterDict)")
                APIHandler.sharedInstance.getMemberValidation(paramater: paramaterDict, onSuccess: { (response) in
                    
                    self.appDelegate.hideIndicator()
                   
                    if response.responseCode == InternetMessge.kFail {
                        SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                    }else{
                        if(self.isAddToBuddy == 1){
                            if(self.isFrom == "BuddyList"){
                                
                            }
                            else{
                                self.AddtoBuddyList()
                            }
                        }
                        else{
                            
                        }
                        
                    for controller in self.navigationController!.viewControllers as Array {
                        
                        if controller.isKind(of: RegisterEventVC.self) {
                            self.delegateGuestChildren?.AddGuestChildren(selecteArray: self.memberDetails)

                            self.navigationController!.popToViewController(controller, animated: true)
                            break
                        }
                        
                        
                    }
                    }
                    
                   
                    
                }) { (error) in
                    SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
                    self.appDelegate.hideIndicator()
            }
    }
        
  
    }
  
    //MARK:- Dining Reservation Duplicate (Member Validation)
    //Note:- This is only used for dining reservation multi select only. Other dining requests are redirected to AddMemberVC with a member/buddy is selected.
    func DiningReservationDuplicate()
    {
        arrTempPlayers.removeAll()
        partyList.removeAll()
        
        if self.shouldEnableMultiSelect
        {
            self.arrMultiSelectedMembers.forEach({self.arrTempPlayers.append(contentsOf: $0.filter({$0.isEmpty == false}))})
        }
        else
        {
            
        }
        
        if (Network.reachability?.isReachable) == true{
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
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
                        "SpecialOccasion": [],
                        "DietaryRestrictions": "",
                        "DisplayOrder": i + 1,
                        "AddBuddy": 0
                    ]
                    partyList.append(memberInfo)
                    
                }
                    
                else if arrTempPlayers[i] is DiningMemberInfo {
                    let playObj = arrTempPlayers[i] as! DiningMemberInfo
                    
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
                        "SpecialOccasion": [],
                        "DietaryRestrictions": playObj.dietaryRestrictions ?? 0,
                        "DisplayOrder": i + 1,
                        "AddBuddy": 0
                    ]
                    partyList.append(memberInfo)
                }
                else if arrTempPlayers[i] is GuestInfo
                {
                    let playObj = arrTempPlayers[i] as! GuestInfo
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
                        "SpecialOccasion": [],
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
                            "SpecialOccasion": [],
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
                            "SpecialOccasion": [],
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
                            "SpecialOccasion": [],
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
                            "SpecialOccasion": [],
                            "DietaryRestrictions": playObj.dietary ?? "",
                            "DisplayOrder": i + 1,
                            "AddBuddy": 0
                        ]
                        partyList.append(memberInfo)
                    }
                    
                    //ENGAGE0011784 -- End
                }
                
                
            }
            
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "RequestId": requestID ?? "",
                "ReservationRequestDate": selectedDate ?? "",
                //Added by kiran V2.8 -- ENGAGE0011784 --
                //ENGAGE0011784 -- Start
                "ReservationRequestTime": self.selectedTime ?? "",
                //ENGAGE0011784 -- End
                "PartySize": "",
                "Earliest": "",
                "Latest": "",
                "Comments": "",
                //Modified on 9th October 2020 V2.3
                "PreferedSpaceDetailId": self.preferedSpaceDetailId ?? "" ,
                "TablePreference": "",
                "DiningDetails" : partyList,
                "IsReservation": "1",
                "IsEvent": "0",
                "ReservationType": "Dining",
                "RegistrationID": requestID ?? ""
            ]
            
            
//            print("memberdict \(paramaterDict)")
            APIHandler.sharedInstance.getMemberValidation(paramater: paramaterDict, onSuccess: { (response) in
                
                self.appDelegate.hideIndicator()
               
                if response.responseCode == InternetMessge.kFail {
                    
                    if self.shouldEnableMultiSelect
                    {
                        if let duplicateDetails = response.details
                        {
                            self.showConflictedMembers(members: duplicateDetails, message: response.brokenRules?.fields?[0])
                        }
                        else
                        {
                            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                        }
                         
                    }
                    else
                    {
                        SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                    }
                    
                }
                else
                {
                    
                    if(self.isAddToBuddy == 1)
                    {
                        if(self.isFrom == "BuddyList")
                        {
                            
                        }
                        else
                        {
                            if self.shouldEnableMultiSelect
                            {
                                self.AddtoBuddyList()
                            }
                            else
                            {
                               
                            }
                            
                        }
                    }
                    
                    if self.shouldEnableMultiSelect
                    {
                        self.delegate?.multiSelectRequestMemberViewControllerResponse(selectedArray: self.arrMultiSelectedMembers)
                    }
                    else
                    {
                    }
                    self.navigationController?.popViewController(animated: true)
                }
                
            }) { (error) in
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
                self.appDelegate.hideIndicator()
            }
            
        }
    }
    
    //MARK:- Member Directory Api
    func getMemberDirectory(withFilter: String,searchWithString: String){
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        if isFrom == "TeeTimes"{
            Category = "Golf"
        }
        else if isFrom == "CourtTimes"{
            Category = "Tennis"
        }
        else{
            Category = ""
        }

        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kinterest: self.appDelegate.strFilterSting,
                APIKeys.kpagecount:self.pageNo,
                APIKeys.krecordperpage:25,
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.ksearchby : searchWithString,
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kCategory: Category ?? "",
                "SearchChar": selectedAlphabet ?? "All"
            ]
//            print(paramaterDict)
            APIHandler.sharedInstance.getMemberList(paramaterDict: paramaterDict, onSuccess: { memberLists in
                self.appDelegate.hideIndicator()
                
                if(memberLists.responseCode == InternetMessge.kSuccess)
                {
                    
                    if(memberLists.memberList == nil){
                        self.appDelegate.hideIndicator()
                        

                        self.tblMemberDirectory.setEmptyMessage(InternetMessge.kNoData)
                    }
                    else{
                        /*
                        if self.filterTapped == "Yes"{
                            self.arrMemberList.removeAll()

                        }*/
                      //  self.arrMemberList.removeAll()

                        for membberInfo in memberLists.memberList!{
                            self.arrMemberList.append(membberInfo)
                        }
                        
                        let (arrContacts, arrTitles) = self.collation.partitionObjects(array: self.arrMemberList, collationStringSelector: #selector(getter: MemberInfo.lastName))
                        if self.isFromDashBoard == true || self.showSegmentController{
                            
                            self.btnLoadMore.isHidden = false
                        }else{
                            self.btnLoadMore.isHidden = true
                       }
                        if memberLists.isLoadMore == 0{
                            self.btnLoadMore.isHidden = true
                            
                        }else{
                            self.btnLoadMore.isHidden = false
                        }
                        self.contactsWithSections = arrContacts as! [[MemberInfo]]
                       
                        self.sectionTitles = arrTitles
                        
                        if(arrTitles.count == 0)
                        {
                           self.tblMemberDirectory.setEmptyMessage(InternetMessge.kNoData)
                            self.btnLoadMore.isHidden = true
                        }
                        else{
                            self.tblMemberDirectory.restore()
                        }
                            
                        
                        
                        if(self.tblMemberDirectory == nil)
                        {
                            self.tblMemberDirectory.reloadData()
                            
                        }else{
                            if(self.appDelegate.strFilterSting == "All" || self.strSearch == "")
                            {
                                  self.tblMemberDirectory.reloadData()

                            }
                            else{
                                
                            
                            self.tblMemberDirectory.reloadData()
                            }
                        }
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
    
    //MARK:- Member Spouse Api
    func getMemberSpouseList(searchWithString: String){
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        if (Network.reachability?.isReachable) == true{
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            var paramaterDict = [String : Any]()
            
            if self.showSegmentController
            {
                 paramaterDict = [
                    "Content-Type":"application/json",
                    APIKeys.kpagecount:self.pageNo,
                    APIKeys.krecordperpage:25,
                    APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                    APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                    APIKeys.ksearchby : searchWithString,
                    APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                    APIKeys.kdeviceInfo: [APIHandler.devicedict],
                    
                    APIKeys.kinterest: self.appDelegate.strFilterSting,
                    APIKeys.kCategory: Category ?? "",
                    "SearchChar": selectedAlphabet ?? "All"
                ]
                
                
            }
            else
            {
                paramaterDict = [
                    "Content-Type":"application/json",
                    APIKeys.kpagecount:self.pageNo,
                    APIKeys.krecordperpage:100,
                    APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                    APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                    APIKeys.ksearchby : searchWithString,
                    APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                    APIKeys.kdeviceInfo: [APIHandler.devicedict]
                ]
            }
           
        
            //Modified on BMS added fitness and spa
            //not sure if this works when showSegemntController is false.Need to check
            //Modified by Kiran V2.9 -- GATHER0001167 -- Golf BAL Support
            //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. added comparision for tennis book an appointment
            //GATHER0000700/GATHER0001167 - Start
            if self.shouldEnableMultiSelect || self.isOnlyFrom == "RegistrationCourt" || self.isOnlyFrom == "GolfCourt" || (self.isOnlyFor == "DiningRequest" /*&& self.forDiningEvent != "DiningEvent"*/) || self.isOnlyFrom == "FitnessSpa" || self.isOnlyFrom == BMSDepartment.tennisBookALesson.rawValue || self.isOnlyFrom == BMSDepartment.golfBookALesson.rawValue
            { //GATHER0000700/GATHER0001167 - End
                var requestDate = [[String:String]]()
                
                if self.isOnlyFrom == "RegistrationCourt"
                {
                    if self.reservationRequestDates.count > 0
                    {
                        self.reservationRequestDates.forEach({requestDate.append(["RequestDate":$0])})
                    }
                    else
                    {
                        requestDate.append(["RequestDate" : self.selectedDate ?? ""])
                    }
                    
                    //Added by kiran V2.7 -- GATHER0000832
                    //GATHER0000832 -- Start
                    paramaterDict.updateValue(self.duration ?? "", forKey: APIKeys.kDuration)
                    //GATHER0000832 -- End
                }
                //Modified by kiran V2.9 -- GATHER0001167 -- Added support Golf BAL
                //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. added comparision for tennis book an appointment
                //GATHER0000700/GATHER0001167 - Start
                else if (self.isOnlyFrom == "GolfCourt" || self.isOnlyFor == "DiningRequest" || self.isOnlyFrom == "FitnessSpa" || self.isOnlyFrom == BMSDepartment.tennisBookALesson.rawValue) || self.isOnlyFrom == BMSDepartment.golfBookALesson.rawValue
                { //GATHER0000700/GATHER0001167 - End
                    requestDate.append(["RequestDate" : self.selectedDate ?? ""])
                }
                else
                {
                    requestDate.append(["RequestDate" : ""])
                }
                
                let requestTime = self.selectedTime ?? ""
                
                paramaterDict.updateValue(requestDate, forKey: "ReservationRequestDate")
                paramaterDict.updateValue(requestTime, forKey: "ReservationRequestTime")
                paramaterDict.updateValue(self.requestID ?? "", forKey: "RequestId")
                //Modified on BMS Added fitness and spa
                //Modified by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
                //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. added comparision for tennis book an appointment
                //GATHER0000700/GATHER0001167 - Start
                paramaterDict.updateValue((self.isOnlyFrom == "GolfCourt" || self.isOnlyFor == "DiningRequest" || self.isOnlyFrom == "RegistrationCourt" || self.isOnlyFrom == "FitnessSpa" || self.isOnlyFrom == BMSDepartment.tennisBookALesson.rawValue || self.isOnlyFrom == BMSDepartment.golfBookALesson.rawValue) ? self.categoryForBuddy ?? "" : "", forKey: "Type")
                //GATHER0000700/GATHER0001167 - End
                //For dining event
                paramaterDict.updateValue(self.eventID ?? "", forKey: "EventID")
                
            }
            
            //Added by kiran V2.8 -- ENGAGE0011808 --
            //ENGAGE0011808 -- Start
            if (isFrom == "Registration") || (isFrom == "BuddyList")
            {
                paramaterDict.updateValue(self.eventID ?? "", forKey: "EventID")
            }
            //ENGAGE0011808 -- End
            
            //Added on 15th July 2020 V2.2
            if self.isEvent == true
            {
                paramaterDict.updateValue("Events", forKey: "Type")
            }
            
            //Added on 9th October 2020 V2.3
            //Only for dining
            if self.isOnlyFor == "DiningRequest"
            {
                paramaterDict.updateValue(self.preferedSpaceDetailId ?? "", forKey: "PreferedSpaceDetailId")
            }
            
//            print("memberdict \(paramaterDict)")
            APIHandler.sharedInstance.getMemberSpouseList(paramaterDict: paramaterDict, onSuccess: { memberLists in
                self.appDelegate.hideIndicator()
                
                
                if(memberLists.responseCode == InternetMessge.kSuccess)
                {
                    
                    if(memberLists.memberList == nil){
                        self.appDelegate.hideIndicator()
                        self.tblMemberDirectory.setEmptyMessage(InternetMessge.kNoData)
                    }
                    else{
                        // self.arrMemberList.removeAll()
                        for membberInfo in memberLists.memberList!{
                            self.arrMemberList.append(membberInfo)
                        }
                        
                     //   if MemberInfo
                        let (arrContacts, arrTitles) = self.collation.partitionObjects(array: self.arrMemberList, collationStringSelector: #selector(getter: MemberInfo.lastName))
                        
                        self.contactsWithSections = arrContacts as! [[MemberInfo]]
                        self.sectionTitles = arrTitles
                        
                        if self.showSegmentController
                        {
                            self.btnLoadMore.isHidden = (memberLists.isLoadMore ?? 0 == 0)
                        }
                        
                        if(arrTitles.count == 0)
                        {
                            self.tblMemberDirectory.setEmptyMessage(InternetMessge.kNoData)
                        }
                        else{
                            self.tblMemberDirectory.restore()
                        }
                        
                        if(self.tblMemberDirectory == nil)
                        {
                            self.tblMemberDirectory.reloadData()
                            
                        }else{
                            if(self.appDelegate.strFilterSting == "All" || self.strSearch == "")
                            {
                                self.tblMemberDirectory.reloadData()
                            }
                            else{
                                
                                self.tblMemberDirectory.reloadData()
                            }
                        }
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
    
    //MARK:-  Get Buddy List Api
    func getBuddyList(searchWithString: String){
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        if (Network.reachability?.isReachable) == true{
            
            
            for i in 0 ..< self.arrEventCategory.count {
                let statementData = self.arrEventCategory[i]
                if statementData.categoryName == eventCategory {
                    self.segmentedController.selectedSegmentIndex = i
                }
            }
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            var paramaterDict = [String: Any]()
            if self.showSegmentController
            {
                paramaterDict = [
                    "Content-Type":"application/json",
                    APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                    APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                    "FirstNameFilter" : "",
                    "LastNameFilter" : "",
                    APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                    APIKeys.kdeviceInfo: [APIHandler.devicedict],
                    "Category" : eventCategory ?? "",
                    "Action" : self.registerType ?? "",
                    APIKeys.ksearchby : searchWithString,
                    "SearchChar": selectedAlphabet ?? "All",
                    APIKeys.kpagecount:self.pageNo,
                    APIKeys.krecordperpage:25
                ]
            }
            else
            {
                paramaterDict = [
                    "Content-Type":"application/json",
                    APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                    APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                    "FirstNameFilter" : "",
                    "LastNameFilter" : "",
                    APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                    APIKeys.kdeviceInfo: [APIHandler.devicedict],
                    "Category" : eventCategory ?? "",
                    "Action" : self.registerType ?? "",
                    APIKeys.ksearchby : searchWithString,
                    "SearchChar": "MemberDirectory"
                ]
            }
            
            //not sure if this works when showSegemntController is false.Need to check
            //Modified by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
            //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. added comparision for tennis book an appointment
            //GATHER0000700/GATHER0001167 - Start
            if self.shouldEnableMultiSelect || self.isOnlyFrom == "RegistrationCourt" || self.isOnlyFrom == "GolfCourt" || (self.isOnlyFor == "DiningRequest" /*&& self.forDiningEvent != "DiningEvent"*/) || self.isOnlyFrom == "FitnessSpa" || self.isOnlyFrom == BMSDepartment.tennisBookALesson.rawValue || self.isOnlyFrom == BMSDepartment.golfBookALesson.rawValue
            {//GATHER0000700/GATHER0001167 - End
               var requestDate = [[String:String]]()
                
                if self.isOnlyFrom == "RegistrationCourt"
                {
                    if self.reservationRequestDates.count > 0
                    {
                        self.reservationRequestDates.forEach({requestDate.append(["RequestDate":$0])})
                    }
                    else
                    {
                        requestDate.append(["RequestDate" : self.selectedDate ?? ""])
                    }
                    
                    //Added by kiran V2.7 -- GATHER0000832
                    //GATHER0000832 -- Start
                    paramaterDict.updateValue(self.duration ?? "", forKey: APIKeys.kDuration)
                    //GATHER0000832 -- End
                }
                else if (self.isOnlyFrom == "GolfCourt" || self.isOnlyFor == "DiningRequest")
                {
                    requestDate.append(["RequestDate" : self.selectedDate ?? ""])
                }
                else
                {
                    requestDate.append(["RequestDate" : ""])
                }
                           
                let requestTime = self.selectedTime ?? ""
                           
                paramaterDict.updateValue(requestDate, forKey: "ReservationRequestDate")
                paramaterDict.updateValue(requestTime, forKey: "ReservationRequestTime")
                paramaterDict.updateValue(self.requestID ?? "", forKey: "RequestId")
                //MOdified by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
                //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. added comparision for tennis book an appointment
                //GATHER0000700/GATHER0001167 - Start
                paramaterDict.updateValue((self.isOnlyFrom == "GolfCourt" || self.isOnlyFor == "DiningRequest" || self.isOnlyFrom == "RegistrationCourt" || self.isOnlyFrom == "FitnessSpa" || self.isOnlyFrom == BMSDepartment.tennisBookALesson.rawValue || self.isOnlyFrom == BMSDepartment.golfBookALesson.rawValue ) ? self.categoryForBuddy ?? "" : "", forKey: "Type")
                //GATHER0000700/GATHER0001167 - End
                //For dining event
                 paramaterDict.updateValue(self.eventID ?? "", forKey: "EventID")
            }
            
            //Added by kiran V2.8 -- ENGAGE0011808 --
            //ENGAGE0011808 -- Start
            if (isFrom == "Registration") || (isFrom == "BuddyList")
            {
                paramaterDict.updateValue(self.eventID ?? "", forKey: "EventID")
            }
            //ENGAGE0011808 -- End
            
            //Added on 15th July 2020 V2.2
            if self.isEvent == true
            {
                paramaterDict.updateValue("Events", forKey: "Type")
            }
            
            //Added on 9th October 2020 V2.3
            //Only for dining
            if self.isOnlyFor == "DiningRequest"
            {
                paramaterDict.updateValue(self.preferedSpaceDetailId ?? "", forKey: "PreferedSpaceDetailId")
            }
            
//             let paramaterDict:[String: Any]
//                 paramaterDict = [
//                    "Content-Type":"application/json",
//                    APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
//                    APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
//                    "FirstNameFilter" : "",
//                    "LastNameFilter" : "",
//                    APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
//                    APIKeys.kdeviceInfo: [APIHandler.devicedict],
//                    "Category" : eventCategory ?? "",
//                    "Action" : self.registerType ?? "",
//                    APIKeys.ksearchby : searchWithString,
//                    "SearchChar": selectedAlphabet ?? "All",
//                    APIKeys.kpagecount:self.pageNo,
//                    APIKeys.krecordperpage:25
//                ]
//            print(paramaterDict)
            
            APIHandler.sharedInstance.getBuddyList(paramaterDict: paramaterDict, onSuccess: { memberLists in
               // self.appDelegate.hideIndicator()
                
                if(memberLists.responseCode == InternetMessge.kSuccess)
                {
                    if(memberLists.memberList == nil){
                        self.appDelegate.hideIndicator()
                        self.tblMemberDirectory.setEmptyMessage(InternetMessge.kNoData)
                    }
                    else{
                        if /*self.filterTapped == "Yes" ||*/ self.shouldEmptyArray{
                            self.arrMemberList.removeAll()
                            //self.shouldEmptyArray = false
                        }
                        
                        
                        //self.arrMemberList.removeAll()
                        for membberInfo in memberLists.memberList!{
                            self.arrMemberList.append(membberInfo)
                            self.appDelegate.hideIndicator()
                        }
                        //   if MemberInfo
                        let (arrContacts, arrTitles) = self.collation.partitionObjects(array: self.arrMemberList, collationStringSelector: #selector(getter: MemberInfo.lastName))
                        
                        self.contactsWithSections = arrContacts as! [[MemberInfo]]
                        self.sectionTitles = arrTitles
                        
                        if self.showSegmentController
                        {
                            self.btnLoadMore.isHidden = (memberLists.isLoadMore ?? 0 == 0)
//                            if memberLists.isLoadMore == 0
//                            {
//                                self.btnLoadMore.isHidden = false
//                            }
//                            else
//                            {
//                                 self.btnLoadMore.isHidden = true
//                            }
                            
                         }else{
                             self.btnLoadMore.isHidden = true
                        }
                        
                        if(arrTitles.count == 0)
                        {
                            self.tblMemberDirectory.setEmptyMessage(InternetMessge.kNoData)
                            self.appDelegate.hideIndicator()
                        }
                        else{
                            self.tblMemberDirectory.restore()
                        }
                        if(self.tblMemberDirectory == nil)
                        {
                            self.tblMemberDirectory.reloadData()
                            
                        }else{
                            if(self.appDelegate.strFilterSting == "All" || self.strSearch == "")
                            {
                                self.tblMemberDirectory.reloadData()

                            }
                            else{
                                
                                self.tblMemberDirectory.reloadData()
                            }
                        }
                    }
                }else{
                    self.appDelegate.hideIndicator()
                    if(((memberLists.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: memberLists.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                }
            }) { error  in
                self.appDelegate.hideIndicator()
                print(error)
            }
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contactsWithSections[indexPath.section][indexPath.row]
        
        
        //0 is allowed
        switch contact.isMemberNotAllowed {
        case 1:
            
            let message = self.isOnlyFrom == "GolfCourt" ? self.appDelegate.masterLabeling.IsMemberExistsValidation_Golf_1 : self.isOnlyFor == "DiningRequest" ? self.appDelegate.masterLabeling.IsMemberExistsValidation_Dining_1 : self.isOnlyFrom == "RegistrationCourt" ? self.appDelegate.masterLabeling.IsMemberExistsValidation_Tennis_1 : ""
            
            self.showTostWith(memberName: contact.memberName ?? "", requestedBy: contact.requestedBy ?? "", in: message ?? "")
            
            //SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message , withDuration: Duration.kMediumDuration)
            self.tblMemberDirectory.deselectRow(at: indexPath, animated: true)
            return
        case 2:
            
            let message = self.isOnlyFrom == "GolfCourt" ? self.appDelegate.masterLabeling.IsMemberExistsValidation_Golf_2 : self.isOnlyFrom == "RegistrationCourt" ? self.appDelegate.masterLabeling.IsMemberExistsValidation_Tennis_2 : ""
            
             self.showTostWith(memberName: contact.memberName ?? "", requestedBy: contact.requestedBy ?? "", in: message ?? "")
            //SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message , withDuration: Duration.kMediumDuration)
            
            self.tblMemberDirectory.deselectRow(at: indexPath, animated: true)
            return
        default:
            break
        }
        
        if self.shouldEnableMultiSelect
        {
            guard self.selectedTickets() < self.maxTickets() else{
                tableView.deselectRow(at: indexPath, animated: true)
                return
            }
            
            var didAddMember = false
            let arrTempMultiSelectedMembers = self.arrMultiSelectedMembers
            
            for (groupIndex,group) in arrTempMultiSelectedMembers.enumerated()
            {
                //Condition for checking if member already exists
                
                // Note: MemberInfo object (Any member/Buddy) -- checking is done with id.
                // Note: GuestInfo object (Any guest tennis/Dining) -- checking for memberInfo object fails then check is done with buddyListID as guests have no id.
                // Note : CaptainInfo object (First member of each group) -- if check for GuestInfo Object fails then the check id done with captainID.
                // Note : DiningMemberInfo objects(Only dining members) -- if check for captainInfo object fails then check is done with dining member id (linked member id is being used for ID).
                
                if !group.contains(where: { (($0 as? MemberInfo)?.id != nil && contact.id != nil && ($0 as? MemberInfo)?.id == contact.id) || (($0 as? GuestInfo)?.buddyID != nil && ($0 as? GuestInfo)?.buddyID != "" && contact.buddyListID != nil && ($0 as? GuestInfo)?.buddyID == contact.buddyListID) || (($0 as? CaptaineInfo)?.captainID != nil && ($0 as? CaptaineInfo)?.captainID != "" && contact.id != nil && ($0 as? CaptaineInfo)?.captainID == contact.id) || (($0 as? DiningMemberInfo)?.linkedMemberID != nil && ($0 as? DiningMemberInfo)?.linkedMemberID != "" && contact.id != nil && ($0 as? DiningMemberInfo)?.linkedMemberID == contact.id)})
                {
                    var emptyIndex : Int?
                    
                    //This iteration is used instead of first index to support skipping of position.
                    //checks if the position is empty and if the position is empty check if its skipped, if not member is added to this index
                    for (posIndex,position) in group.enumerated()
                    {
                        if position.isEmpty == true
                        {
                            if !self.arrSkippedIndexes.contains(where: {$0.section == groupIndex && $0.row == posIndex})
                            {
                                emptyIndex = posIndex
                                break
                            }
                        }
                    }
                    
                    
                    
                    if let index = emptyIndex  //group.firstIndex(where: {$0.isEmpty == true})
                    {
                        didAddMember = true
                        self.arrMultiSelectedMembers[groupIndex].remove(at: index)
                        
                        
                        if self.isOnlyFor == "DiningRequest" && contact.buddyType != "Guest"
                        {
                            let diningMember = DiningMemberInfo()
                            diningMember.isEmpty = false
                            
                            diningMember.setDiningMemberDetails(MemberId: contact.memberID ?? "", firstName: contact.firstName ?? "", Name: contact.memberName ?? "", profilePic: contact.profilePic ?? "", id: contact.id ?? "", parentID: contact.parentid ?? "", highChair: 0, booster: 0, dietary: "", otherNo: 0, otherTextInformation: "", birthdayNo: 0, anniversaryNo: 0)
                            self.arrMultiSelectedMembers[groupIndex].insert(diningMember, at: index)
                           
                        }
                        else if contact.buddyType == "Guest"
                        {
                            let guest = GuestInfo.init()
                            guest.isEmpty = false
                            //Added by kiran V2.8 -- ENGAGE0011784 -- modified to include first and last names, linkedMemberID and guestMemberNo
                            //ENGAGE0011784 -- Start
                            guest.setGuestDetails(name: contact.memberName ?? "", firstName: contact.guestFirstName ?? "", lastName: contact.guestLastName ?? "",linkedMemberID: "", guestMemberOf: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",guestMemberNo: "",gender : contact.guestGender ?? "",DOB: contact.guestDOB ?? "", buddyID: contact.buddyListID ?? "", type: contact.guestType ?? "", phone: contact.guestContact ?? "", primaryemail: contact.guestEmail ?? "", guestLinkedMemberID: "", highChair: 0, booster: 0, dietary: "", addGuestAsBuddy: isAddToBuddy ?? 0, otherNo: 0, otherTextInformation: "", birthdayNo: 0, anniversaryNo: 0)
                            //ENGAGE0011784 -- End
                            self.arrMultiSelectedMembers[groupIndex].insert(guest, at: index)
                        }
                        else
                        {
                            contact.isEmpty = false
                            self.arrMultiSelectedMembers[groupIndex].insert(contact, at: index)
                        }
                        
                        break
                    }
                    
                    continue
                }
                
            }
            
            if !didAddMember
            {
                self.tblMemberDirectory.deselectRow(at: indexPath, animated: true)
            }
            
          /*  if !self.memberDetails.contains(where: { (($0 as? MemberInfo)?.id != nil && contact.id != nil && ($0 as? MemberInfo)?.id == contact.id) || ((($0 as? MemberInfo)?.buddyListID != nil && contact.buddyListID != nil && ($0 as? MemberInfo)?.buddyListID == contact.buddyListID))})
            {
               self.memberDetails.append(contact)
            }
            else
            {
                tableView.deselectRow(at: indexPath, animated: true)
            }*/
            
            self.updateMultiSelectionDisplay()
        }
        else
        {
            
            if(isOnlyFor == "DiningRequest")
            {
                if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddMemberVC") as? AddMemberVC
                {
                    regGuest.SelectedMemberInfo = [contactsWithSections[indexPath.section][indexPath.row]]
                    regGuest.selectedData = String(format: "%@, %@", contactsWithSections[indexPath.section][indexPath.row].lastName!, contactsWithSections[indexPath.section][indexPath.row].firstName!)
                    regGuest.delegateAddMember = self.delegate as? AddMemberDelegate
                    regGuest.membersData = self.membersData
                    regGuest.requestID = requestID
                    regGuest.selectedDate = self.selectedDate
                    regGuest.selectedTime = self.selectedTime
                    regGuest.eventID = self.eventID
                    regGuest.requestID = self.requestID
                    regGuest.selectedDate = selectedDate
                    //Added on 15th October 2020 V2.3
                    regGuest.preferedSpaceDetailId = self.preferedSpaceDetailId
                    

                    if(isFrom == "BuddyList")
                    {
                        
                    }
                    else
                    {
                        regGuest.isAddToBuddy = self.isAddToBuddy
                    }
                    
                    regGuest.type = contactsWithSections[indexPath.section][indexPath.row].buddyType
                    
                    if contactsWithSections[indexPath.section][indexPath.row].buddyType == "Guest"
                    {
                        
                        regGuest.guestName = contactsWithSections[indexPath.section][indexPath.row].guestName
                        regGuest.guestEmail = contactsWithSections[indexPath.section][indexPath.row].guestEmail
                        regGuest.guestContact = contactsWithSections[indexPath.section][indexPath.row].guestContact
                        regGuest.guetType = contactsWithSections[indexPath.section][indexPath.row].guestType
                        regGuest.guestBuddyListID = contactsWithSections[indexPath.section][indexPath.row].buddyListID
                        //Added by kiran V2.5 -- ENGAGE0011372 --
                        //ENGAGE0011372 -- Start
                        regGuest.guestFirstName = contactsWithSections[indexPath.section][indexPath.row].guestFirstName
                        regGuest.guestLastName = contactsWithSections[indexPath.section][indexPath.row].guestLastName
                        regGuest.guestDOB = contactsWithSections[indexPath.section][indexPath.row].guestDOB
                        regGuest.gustGender = contactsWithSections[indexPath.section][indexPath.row].guestGender
                        regGuest.selectedData = String(format: "%@, %@", contactsWithSections[indexPath.section][indexPath.row].guestLastName!, contactsWithSections[indexPath.section][indexPath.row].guestFirstName!)
                        //ENGAGE0011372 -- Start
                    }
                    else
                    {
                        
                        regGuest.memberID = contactsWithSections[indexPath.section][indexPath.row].memberID
                        regGuest.iD = contactsWithSections[indexPath.section][indexPath.row].id
                        regGuest.parentID = contactsWithSections[indexPath.section][indexPath.row].parentid
                        regGuest.memberName = String(format: "%@", contactsWithSections[indexPath.section][indexPath.row].memberName!)
                        regGuest.memberFirstName = contactsWithSections[indexPath.section][indexPath.row].firstName
                        regGuest.memberProfilePic = contactsWithSections[indexPath.section][indexPath.row].profilePic
                        
                    }
                    self.appDelegate.categoryForBuddy = self.categoryForBuddy ?? ""
                    
                    regGuest.forDiningEvent = self.forDiningEvent
                    navigationController?.pushViewController(regGuest, animated: true)
                }
            }
            else if (isFrom == "Registration") || (isFrom == "BuddyList")
            {
                if self.isFor == "OnlyMembers"
                {
                    selectedRow = indexPath.row
                    selectedSection = indexPath.section
                }
                else
                {
                    if (contactsWithSections[indexPath.section][indexPath.row].isSpouse == 1 && self.showGuest == 0 && self.showKids == 0)
                    {
                        selectedRow = indexPath.row
                        selectedSection = indexPath.section
                        showSpouse = 1
                    
                        self.bottomView.isHidden = false
                        self.bottomViewHeight.constant = 78
                    }
                    else
                    {
                        self.bottomView.isHidden = true
                        self.bottomViewHeight.constant = 0
                        
                        if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "GuestOrChildrenVC") as? GuestOrChildrenVC
                        {
                            if isGolfChildren == true
                            {
                                self.arrEventPlayers.removeLast()
                                
                            }
                            else
                            {
                                
                            }
                            regGuest.totalNumberofTickets = self.totalNumberofTickets
                            regGuest.delegateGuestChildren = delegate as? AddGuestChildren
                            regGuest.memberID = contactsWithSections[indexPath.section][indexPath.row].memberID
                            regGuest.iD = contactsWithSections[indexPath.section][indexPath.row].id
                            regGuest.parentID = contactsWithSections[indexPath.section][indexPath.row].parentid
                            regGuest.isSpousePresent = self.showSpouse
                            regGuest.showGuest = self.showGuest
                            regGuest.showKids = self.showKids
                            regGuest.categoryForBuddy = self.categoryForBuddy
                            regGuest.isAddToBuddy = self.isAddToBuddy
                            regGuest.eventRegId = self.eventRegId
                            regGuest.arrEventPlayers = self.arrEventPlayers
                            regGuest.requestID = requestID
                            regGuest.eventID = self.eventID
                    
                    
                            if isFrom == "BuddyList"
                            {
                                regGuest.isFrom = "BuddyList"
                                
                            }
                            else
                            {
                                regGuest.isFrom = ""
                                
                            }
                            regGuest.memberName = String(format: "%@", contactsWithSections[indexPath.section][indexPath.row].memberName!)

                    
                            regGuest.isSpousePresent = contactsWithSections[indexPath.section][indexPath.row].isSpouse
                       
                    
                            navigationController?.pushViewController(regGuest, animated: true)
                            
                        }
                    }
                    
                }
            }
            else
            {
                //Added on 4th July 2020 V2.2
                //Added roles and previlages changes
                switch self.accessManager.accessPermision(for: .memberDirectory) {
                case .view,.notAllowed:
                    
                    if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
                    {
                        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                    }
                    tableView.deselectRow(at: indexPath, animated: true)
                    return
                default:
                    break
                }
                
                
                if (type == "MyBuddies")
                {
                    self.appDelegate.typeOfCalendar = eventCategory ?? ""
                    
                    if(self.appDelegate.typeOfCalendar == "Tennis")
                    {
                        eventCategoryForActionSheet = self.appDelegate.masterLabeling.upcoming_court_times
                    }
                    else if(self.appDelegate.typeOfCalendar == "Dining")
                    {
                        eventCategoryForActionSheet = self.appDelegate.masterLabeling.uPCOMING_DINING_RESERVATION
                    }
                    else if(self.appDelegate.typeOfCalendar == "Golf")
                    {
                        eventCategoryForActionSheet = self.appDelegate.masterLabeling.upcoming_teetimes
                    }
                    else
                    {
                        eventCategoryForActionSheet = ""
                    }
                    
                    categoryType = ""
                    categoryType2 = ""
                    categoryType3 = ""

                    if contact.categories?.count == 1
                    {
                        if(contact.categories?[0].category?.lowercased() == "tennis")
                        {
                            categoryType3 = self.appDelegate.masterLabeling.upcoming_court_times
                            
                        }
                        else if(contact.categories?[0].category?.lowercased() == "dining")
                        {
                            categoryType3 = self.appDelegate.masterLabeling.uPCOMING_DINING_RESERVATION
                        }
                        else if(contact.categories?[0].category?.lowercased() == "golf")
                        {
                            categoryType3 = self.appDelegate.masterLabeling.upcoming_teetimes
                        }
                        
                        categoryType = ""
                        categoryType2 = ""

                    }
                    
                    if contact.categories?.count == 2
                    {
                        if (contact.categories?[0].category?.lowercased() == "tennis" && contact.categories?[1].category?.lowercased() == "golf") || (contact.categories?[1].category?.lowercased() == "tennis" && contact.categories?[0].category?.lowercased() == "golf")
                        {
                            categoryType3 = self.appDelegate.masterLabeling.upcoming_court_times
                            categoryType = self.appDelegate.masterLabeling.upcoming_teetimes
                        }
                        else if (contact.categories?[0].category?.lowercased() == "dining" && contact.categories?[1].category?.lowercased() == "tennis") || (contact.categories?[1].category?.lowercased() == "dining" && contact.categories?[0].category?.lowercased() == "tennis")
                        {
                            categoryType3 = self.appDelegate.masterLabeling.uPCOMING_DINING_RESERVATION
                            categoryType = self.appDelegate.masterLabeling.upcoming_court_times
                        }
                        else if(contact.categories?[0].category?.lowercased() == "golf" && contact.categories?[1].category?.lowercased() == "dining") || (contact.categories?[1].category?.lowercased() == "golf" && contact.categories?[0].category?.lowercased() == "dining")
                        {
                            categoryType3 = self.appDelegate.masterLabeling.upcoming_teetimes
                            categoryType = self.appDelegate.masterLabeling.uPCOMING_DINING_RESERVATION
                        }
                        
                        categoryType2 = ""

                    }
                    
                    if contact.categories?.count == 3
                    {
                        categoryType3 = self.appDelegate.masterLabeling.upcoming_teetimes
                        categoryType = self.appDelegate.masterLabeling.upcoming_court_times
                        categoryType2 = self.appDelegate.masterLabeling.uPCOMING_DINING_RESERVATION
                    }
                    
                    let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                    actionSheet.view.tintColor = hexStringToUIColor(hex: "40B2E6")
                    
                    let profileView = UIAlertAction(title: self.appDelegate.masterLabeling.pROFILE,
                                                    style: .default) { (action) in
                                                        
                                                        if let profile = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "MyBuddiesProfileVC") as? MyBuddiesProfileVC {
                                                            profile.modalTransitionStyle   = .crossDissolve;
                                                            profile.modalPresentationStyle = .overCurrentContext
                                                            
                                                            profile.memberType = contact.buddyType ?? ""
                                                            profile.buddyListID = contact.buddyListID ?? ""

                                                            profile.selectedMemberId = contact.memberID ?? ""
                                                            profile.iD = contact.id ?? ""
                                                            profile.parentId = contact.parentid ?? ""
                                                            
                                                            self.present(profile, animated: true, completion: nil)
                                                        }
                                                        
                    }
                    let upComingAll = UIAlertAction(title: eventCategoryForActionSheet,
                                                         style: .default) { (action) in
                                                            
                                                            if let profile = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "UpcomingTeeTimesVC") as? UpcomingTeeTimesVC {
                                                                profile.modalTransitionStyle   = .crossDissolve;
                                                                profile.modalPresentationStyle = .overCurrentContext
                                                                profile.memberType = contact.buddyType ?? ""
                                                                profile.memberID = contact.id ?? ""
                                                                profile.title = self.eventCategoryForActionSheet
                                
                                                                self.present(profile, animated: true, completion: nil)
                                                            }
                                                            
                    }
                    let upComingTeeTimes = UIAlertAction(title: categoryType3,
                                                         style: .default) { (action) in
                                                            
                                                            if let profile = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "UpcomingTeeTimesVC") as? UpcomingTeeTimesVC {
                                                                profile.modalTransitionStyle   = .crossDissolve;
                                                                profile.modalPresentationStyle = .overCurrentContext
                                                                profile.memberType = contact.buddyType ?? ""
                                                                profile.memberID = contact.id ?? ""
                                                                profile.title = self.categoryType3
                                                                if self.categoryType3 == self.appDelegate.masterLabeling.upcoming_teetimes{
                                                                    self.appDelegate.typeOfCalendar = "Golf"
                                                                }else if self.categoryType3 == self.appDelegate.masterLabeling.upcoming_court_times{
                                                                    self.appDelegate.typeOfCalendar = "Tennis"
                                                                }else{
                                                                        self.appDelegate.typeOfCalendar = "Dining"
                                                                }
                                                                self.present(profile, animated: true, completion: nil)
                                                            }
                                                            
                    }
                    let upComingTennis = UIAlertAction(title: categoryType,
                                                         style: .default) { (action) in

                                                            if let profile = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "UpcomingTeeTimesVC") as? UpcomingTeeTimesVC {
                                                                profile.modalTransitionStyle   = .crossDissolve;
                                                                profile.modalPresentationStyle = .overCurrentContext
                                                                profile.memberType = contact.buddyType ?? ""
                                                                profile.memberID = contact.id ?? ""
                                                                profile.title = self.categoryType ?? ""
                                                                if self.categoryType == self.appDelegate.masterLabeling.upcoming_teetimes{
                                                                    self.appDelegate.typeOfCalendar = "Golf"
                                                                }else if self.categoryType == self.appDelegate.masterLabeling.upcoming_court_times{
                                                                    self.appDelegate.typeOfCalendar = "Tennis"
                                                                }else if self.categoryType == self.appDelegate.masterLabeling.uPCOMING_DINING_RESERVATION{
                                                                    self.appDelegate.typeOfCalendar = "Dining"
                                                                }
                                                                self.present(profile, animated: true, completion: nil)
                                                            }

                    }
                    let upComingDining = UIAlertAction(title: categoryType2,
                                                          style: .default) { (action) in

                                                            if let profile = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "UpcomingTeeTimesVC") as? UpcomingTeeTimesVC {
                                                                profile.modalTransitionStyle   = .crossDissolve;
                                                                profile.modalPresentationStyle = .overCurrentContext
                                                                profile.memberType = contact.buddyType ?? ""
                                                                profile.memberID = contact.id ?? ""
                                                                profile.title = self.categoryType2 ?? ""
                                                                if self.categoryType2 == self.appDelegate.masterLabeling.upcoming_teetimes{
                                                                    self.appDelegate.typeOfCalendar = "Golf"
                                                                }else if self.categoryType2 == self.appDelegate.masterLabeling.upcoming_court_times{
                                                                    self.appDelegate.typeOfCalendar = "Tennis"
                                                                }else if self.categoryType2 == self.appDelegate.masterLabeling.uPCOMING_DINING_RESERVATION{
                                                                    self.appDelegate.typeOfCalendar = "Dining"
                                                                }
                                                                self.present(profile, animated: true, completion: nil)
                                                            }

                    }
                    let removeFromBuddyList = UIAlertAction(title: self.appDelegate.masterLabeling.remove_from_mybuddylist,
                                                            style: .default) { (action) in
                                                                
                                                                if let removeFromBuddyList = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController {
                                                                    removeFromBuddyList.isFrom = "MemberRemoveBuddy"
                                                                    removeFromBuddyList.parentID = contact.parentid ?? ""
                                                                    removeFromBuddyList.memberID = contact.memberID ?? ""
                                                                    removeFromBuddyList.ID = contact.id ?? ""
                                                                    removeFromBuddyList.guestID = contact.buddyListID ?? ""
                                                                    removeFromBuddyList.cancelFor = .RemoveBuddy
                                                                    self.navigationController?.pushViewController(removeFromBuddyList, animated: true)
                                                                }
                                                                
                    }
                    let cancelAction = UIAlertAction(title: "Cancel",
                                                     style: .cancel,
                                                     handler: nil)
                    actionSheet.addAction(profileView)
                    
                    if contact.categories?.count == 3
                    {
                        actionSheet.addAction(upComingTeeTimes)
                        actionSheet.addAction(upComingTennis)
                        actionSheet.addAction(upComingDining)

                    }
                    else if contact.categories?.count == 2
                    {
                        actionSheet.addAction(upComingTeeTimes)
                        actionSheet.addAction(upComingTennis)
                        
                    }
                    else if contact.categories?.count == 1
                    {
                        if self.appDelegate.typeOfCalendar.lowercased() == "tennis" || self.appDelegate.typeOfCalendar.lowercased() == "dining" || self.appDelegate.typeOfCalendar.lowercased() == "golf"
                        {
                            actionSheet.addAction(upComingAll)

                        }
                        else
                        {
                            actionSheet.addAction(upComingTeeTimes)
                        }
                        
                    }
                    else if contact.categories?.count == 0
                    {
                       // actionSheet.addAction(upComingAll)
                    }
                    else if contact.buddyType?.lowercased() == "guest"
                    {
                        
                    }
                    else
                    {
                        actionSheet.addAction(upComingAll)
                    }

                    actionSheet.addAction(removeFromBuddyList)


                    actionSheet.addAction(cancelAction)
                    
                    present(actionSheet, animated: true, completion: nil)
                }
                
                self.tblMemberDirectory.reloadData()
                let transactionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MemberDirectoryDetailsViewController") as! MemberDirectoryDetailsViewController
                transactionVC.selectedMemberId = contact.memberID ?? ""
                transactionVC.iD = contact.id ?? ""
                transactionVC.parentId = contact.parentid ?? ""
            
                self.navigationController?.pushViewController(transactionVC, animated: true)
                
            }

        }
        
        
       
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if self.shouldEnableMultiSelect
        {
            let contact = contactsWithSections[indexPath.section][indexPath.row]
            guard self.selectedTickets() > 0 else{
                return
            }
            
            let arrTempMultiSelectedMembers = self.arrMultiSelectedMembers
            var hasRemovedMember = false
            for (groupIndex,group) in arrTempMultiSelectedMembers.enumerated()
            {
                //Condition for checking if member already exists and getting their index
                
                // Note: MemberInfo object (Any member/Buddy) -- checking is done with id.
                // Note: GuestInfo object (Any guest tennis/Dining) -- checking for memberInfo object fails then check is done with buddyListID as guests have no id.
                // Note : CaptainInfo object (First member of each group) -- if check for GuestInfo Object fails then the check id done with captainID.
                // Note : DiningMemberInfo objects(Only dining members) -- if check for captainInfo object fails then check is done with dining member id (linked member id is being used for ID).
                
                if let index = group.firstIndex(where: {(($0 as? MemberInfo)?.id != nil && contact.id != nil && ($0 as? MemberInfo)?.id == contact.id) || (($0 as? GuestInfo)?.buddyID != nil && ($0 as? GuestInfo)?.buddyID != "" && contact.buddyListID != nil && ($0 as? GuestInfo)?.buddyID == contact.buddyListID) || (($0 as? CaptaineInfo)?.captainID != nil && ($0 as? CaptaineInfo)?.captainID != "" && contact.id != nil && ($0 as? CaptaineInfo)?.captainID == contact.id) || (($0 as? DiningMemberInfo)?.linkedMemberID != nil && ($0 as? DiningMemberInfo)?.linkedMemberID != "" && contact.id != nil && ($0 as? DiningMemberInfo)?.linkedMemberID == contact.id)})
                {
                    self.arrMultiSelectedMembers[groupIndex].remove(at: index)
                    self.arrMultiSelectedMembers[groupIndex].insert(RequestData(), at: index)
                    hasRemovedMember = true
                    break
                }
            }
            
            if !hasRemovedMember
            {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
            
            
//            self.memberDetails.removeAll(where: {(($0 as? MemberInfo)?.id != nil && contact.id != nil && ($0 as? MemberInfo)?.id == contact.id) || ((($0 as? MemberInfo)?.buddyListID != nil && contact.buddyListID != nil && ($0 as? MemberInfo)?.buddyListID == contact.buddyListID))})
            self.updateMultiSelectionDisplay()
        }
        
    }
    
    @IBAction func addClicked(_ sender: Any) {
        
        if self.shouldEnableMultiSelect
        {
            guard self.selectedTickets() > 0 else{
                SharedUtlity.sharedHelper().showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.please_select_Member, withDuration: Duration.kMediumDuration)
                return
            }
            
            if self.isFrom == "Registration" || self.isOnlyFrom == "RegistrationCourt" || self.isFrom == "BuddyList"
            {
                if self.isOnlyFrom == "GolfCourt" && self.categoryForBuddy == "Golf"
                {
                    self.golfDuplicates()
                }
                else if self.isOnlyFrom == "RegistrationCourt" && self.categoryForBuddy == "Tennis"
                {
                    self.CourtTimeDuplicate()
                }
                else if self.isOnlyFor == "DiningRequest" && self.categoryForBuddy == "Dining"
                {
                    self.DiningReservationDuplicate()
                }
            }
        }
        else
        {
            isGolfChildren = true
            
            if (selectedSection == -1)
            {
                SharedUtlity.sharedHelper().showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.please_select_Member, withDuration: Duration.kMediumDuration)
                
            }
            else
            {
                if(isOnlyFor == "DiningRequest")
                {
                    if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddMemberVC") as? AddMemberVC
                    {
                        regGuest.SelectedMemberInfo = [contactsWithSections[selectedSection][selectedRow]]
                        regGuest.delegateAddMember = self.delegate as? AddMemberDelegate
                        regGuest.selectedTime = self.selectedTime
                        navigationController?.pushViewController(regGuest, animated: true)
                        
                    }
                    
                }
                else if showSpouse == 1
                {
                    let guestChildrenInfo = GuestChildren.init()
                    let memberData = contactsWithSections[selectedSection][selectedRow]
                    guestChildrenInfo.setGuestChildrenInfo(MemberId: memberData.memberID ?? "", Name: memberData.memberName ?? "", id: memberData.id ?? "", parentId: memberData.parentid ?? "", guest: 0, kid3Above: 0, kids3Below: 0, isInclude: 1, isSpouse: showSpouse ?? 0)
                        
                    self.memberDetails = [guestChildrenInfo]
                    arrEventPlayers.append(guestChildrenInfo)
                    self.eventsDuplicate()
                    
                }
                else if (isOnlyFrom == "RegistrationCourt" || isOnlyFrom == "BuddyListCourt" || isOnlyFrom == "GolfCourt")
                {
                    let guestInfo = GuestInfo.init()
                    let guestDetails = contactsWithSections[selectedSection][selectedRow]
                    if guestDetails.buddyType == "Guest"
                    {
                        //Added by kiran V2.8 -- ENGAGE0011784 -- modified to include first and last names, linkedMemberID and guestMemberNo
                        //ENGAGE0011784 -- Start
                        guestInfo.setGuestDetails(name: guestDetails.guestName ?? "", firstName: guestDetails.guestFirstName ?? "", lastName: guestDetails.guestLastName ?? "",linkedMemberID: "", guestMemberOf: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",guestMemberNo: "",gender : guestDetails.guestGender ?? "",DOB: guestDetails.guestDOB ?? "", buddyID: guestDetails.buddyListID ?? "" , type: guestDetails.guestType ?? "", phone: guestDetails.guestContact ?? "", primaryemail: guestDetails.guestEmail ?? "", guestLinkedMemberID: "", highChair: 0, booster: 0, dietary: "", addGuestAsBuddy: isAddToBuddy!, otherNo: 0 , otherTextInformation: "", birthdayNo: 0, anniversaryNo: 0)
                        //ENGAGE0011784 -- End
                        delegate?.requestMemberViewControllerResponse(selecteArray: [guestInfo])
                    }
                    else
                    {
                        self.memberDetails = [contactsWithSections[selectedSection][selectedRow]]
                        
                    }
                    
                    // self.delegate?.requestMemberViewControllerResponse(selecteArray: [contactsWithSections[selectedSection][selectedRow]])
                    
                    if self.categoryForBuddy == "Tennis"
                    {
                        self.membersData.append(contactsWithSections[selectedSection][selectedRow])
                        
                        if guestDetails.buddyType == "Guest"
                        {
                            self.navigationController?.popViewController(animated: true)
                            
                        }
                        else
                        {
                            self.CourtTimeDuplicate()
                            
                        }
                        
                    }
                    
                    if self.categoryForBuddy == "Golf"
                    {
                        self.arrGroup4.append(contactsWithSections[selectedSection][selectedRow])
                        self.golfDuplicates()
                        
                    }
                    
                    if self.categoryForBuddy == "Dining"
                    {
                        
                    }
                    
                }//Added on 16th June 2020 BMS
                //Modified by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
                //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. added comparision for tennis book an appointment
                //GATHER0000700/GATHER0001167 - Start
                else if self.isFrom == "Registration" && (self.isOnlyFrom == "FitnessSpa" || self.isOnlyFrom == BMSDepartment.tennisBookALesson.rawValue || self.isOnlyFrom == BMSDepartment.golfBookALesson.rawValue)
                {//GATHER0000700/GATHER0001167 - End
                    self.performAppointmentMemberSelection()
                }
                else
                {
                    delegate?.requestMemberViewControllerResponse(selecteArray: [contactsWithSections[selectedSection][selectedRow]])
//                    self.membersData.append(contactsWithSections[selectedSection][selectedRow])
//                    self.CourtTimeDuplicate()
                    
                }
                
                
            }
            

        }
        
    }
    
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    @IBAction func addToBuddiesClicked(_ sender: Any) {
        
        
        if let button = sender as? UIButton {
            
            if button.isSelected {
                button.isSelected = false
                btnAddToBuddies.setImage(UIImage(named:"Group 2130"), for: UIControlState.normal)
                isAddToBuddy = 1
                
            } else {
                
                btnAddToBuddies.setImage(UIImage(named:"CheckBox_uncheck"), for: UIControlState.normal)
                isAddToBuddy = 0

                button.isSelected = true
            }
        }
        
        
            
        
    }
    
    //MARK:- AddToBuddy List Api
    func AddtoBuddyList(){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            var buddyInfo : [String : Any] = [String : Any]()
            var arrBuddyInfo : [[String : Any]] = [[String : Any]]()
            if self.shouldEnableMultiSelect
            {
                var tempMemberArray = [RequestData]()
                self.arrMultiSelectedMembers.forEach({tempMemberArray.append(contentsOf: $0.filter({$0.isEmpty == false}))})
                
                for member in tempMemberArray
                {
                    if let member = member as? CaptaineInfo
                    {
                        arrBuddyInfo.append([
                            APIKeys.kMemberId : member.captainMemberID ?? "",
                            APIKeys.kid :  member.captainID ?? "",
                            APIKeys.kParentId : member.captainParentID ?? "",
                            "Category": self.categoryForBuddy ?? ""
                        ])
                    }
                    else if let member = member as? MemberInfo
                    {
                        arrBuddyInfo.append([
                            APIKeys.kMemberId : member.memberID ?? "",
                            APIKeys.kid :  member.id ?? "",
                            APIKeys.kParentId : member.parentid ?? "",
                            "Category": self.categoryForBuddy ?? ""
                        ])
                    }
                    else if let member = member as? DiningMemberInfo
                    {
                        arrBuddyInfo.append([
                            APIKeys.kMemberId : member.memberId ?? "",
                            APIKeys.kid :  member.linkedMemberID ?? "",
                            APIKeys.kParentId : member.parentID ?? "",
                            "Category": self.categoryForBuddy ?? ""
                        ])
                    }
                    else if let member = member as? GuestInfo
                    {
                        arrBuddyInfo.append([
                            APIKeys.kMemberId : "",
                            APIKeys.kid :  "",
                            APIKeys.kParentId : "",
                            "Category": self.categoryForBuddy ?? ""
                        ])
                    }
                }
            }
            else
            {
                buddyInfo = [
                    APIKeys.kMemberId : contactsWithSections[selectedSection][selectedRow].memberID ?? "",
                    APIKeys.kid :  contactsWithSections[selectedSection][selectedRow].id ?? "",
                    APIKeys.kParentId : contactsWithSections[selectedSection][selectedRow].parentid ?? "",
                    "Category": self.categoryForBuddy ?? ""
                ]
            }
       
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "AddBuddy" : self.shouldEnableMultiSelect ? arrBuddyInfo : buddyInfo,
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            
//            print("memberdict \(paramaterDict)")
            APIHandler.sharedInstance.addToBuddyList(paramaterDict: paramaterDict, onSuccess: { memberLists in
                self.appDelegate.hideIndicator()
                
                
                if(memberLists.responseCode == InternetMessge.kSuccess)
                {
                    self.appDelegate.hideIndicator()
                    let currentViewController = UIApplication.topViewController()

                   // SharedUtlity.sharedHelper().showToast(on:currentViewController?.view, withMeassge:memberLists.responseMessage, withDuration: Duration.kMediumDuration)
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
    
    override func viewWillAppear(_ animated: Bool)
    {
        
//        self.getAuthToken()
        
        UIApplication.shared.isStatusBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.isHidden = false
        //navigation item labelcolor
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        //Added back button in BMS
        //let barbutton = UIBarButtonItem.init(image : UIImage.init(named: "back_btn"), style: .plain, target: self , action: #selector(backBtnClicked(sender:)))
        //barbutton.imageInsets = UIEdgeInsets.init(top: 0, left: -6.5, bottom: 0, right: 0)
        //self.navigationItem.leftBarButtonItem = barbutton
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnClicked(sender:)))
        //ENGAGE0011297 -- End
        
        
        if(isFrom == "Registration") || (isFrom == "BuddyList"){

        }
        else{
           let _ = self.isAppAlreadyLaunchedOnce()

        }
        
        if (isFrom == "Registration") && isOnlyFor == "DiningRequest"{
            self.boardOfDirectors.backgroundColor = UIColor.white
            
            self.btnAddToBuddies.isHidden = false
            //self.boardofDireViewHight.constant = 74
            //self.btnBoardOfGoverners.isHidden = true
            self.hideBoardOfGoverners(true)
            self.btnAddToBuddies.setTitle(appDelegate.masterLabeling.add_to_buddylist, for: UIControlState.normal)
            // self.btnAddToBuddies.setImage(UIImage(named: "CheckBox_uncheck"), for: UIControlState.normal)
            
            if self.shouldEnableMultiSelect
            {
                self.bottomView.isHidden = false
            }
            else
            {
                self.bottomView.isHidden = true
                self.bottomViewHeight.constant = 0
            }
           // self.bottomView.isHidden = true
            
            //self.bottomViewHeight.constant = 0
            self.heightSectionsView.constant = 0
            self.viewSections.isHidden = true

            self.navigationItem.title = appDelegate.masterLabeling.add_member
            let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
            navigationItem.rightBarButtonItem = homeBarButton
        }
            
        else if (isFrom == "Registration")  {
            self.boardOfDirectors.backgroundColor = UIColor.white
            
            self.btnAddToBuddies.isHidden = false
            //self.boardofDireViewHight.constant = 74
            //self.btnBoardOfGoverners.isHidden = true
            self.hideBoardOfGoverners(true)
            self.btnAddToBuddies.setTitle(appDelegate.masterLabeling.add_to_buddylist, for: UIControlState.normal)
            // self.btnAddToBuddies.setImage(UIImage(named: "CheckBox_uncheck"), for: UIControlState.normal)
            if self.isFor == "OnlyMembers"{
                self.bottomView.isHidden = false
                self.bottomViewHeight.constant = 78
                
            }else{
            self.bottomView.isHidden = true
            self.bottomViewHeight.constant = 0
            }
            self.heightSectionsView.constant = 0
            
            self.viewSections.isHidden = true
            
            self.navigationItem.title = appDelegate.masterLabeling.add_member
            let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
            navigationItem.rightBarButtonItem = homeBarButton
        }
        else if (isFrom == "BuddyList") && isOnlyFor == "DiningRequest" {
            
            self.btnAddToBuddies.isHidden = true
            //self.boardofDireViewHight.constant = 0
            //self.btnBoardOfGoverners.isHidden = true
            self.hideBoardOfGoverners(true)
            
            //self.bottomView.isHidden = true
            //self.bottomViewHeight.constant = 0
            self.heightSectionsView.constant = 0
            self.viewSections.isHidden = true

            if self.shouldEnableMultiSelect
            {
                self.bottomView.isHidden = false
            }
            else
            {
                self.bottomView.isHidden = true
                self.bottomViewHeight.constant = 0
            }
            
            self.navigationItem.title = appDelegate.masterLabeling.add_mybuddy
            let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
            navigationItem.rightBarButtonItem = homeBarButton
        }
        else if (isFrom == "BuddyList"){
            
            self.btnAddToBuddies.isHidden = true
           // self.boardofDireViewHight.constant = 0
           // self.btnBoardOfGoverners.isHidden = true
            self.hideBoardOfGoverners(true)
            if self.isFor == "OnlyMembers"{
                self.bottomView.isHidden = false
                self.bottomViewHeight.constant = 78
                
            }else{
                self.bottomView.isHidden = true
                self.bottomViewHeight.constant = 0
            }
            self.heightSectionsView.constant = 0
            self.viewSections.isHidden = true
            
            self.navigationItem.title = appDelegate.masterLabeling.add_mybuddy
            let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
            navigationItem.rightBarButtonItem = homeBarButton
        }
        else if type == "MyBuddies"{
            self.arrMemberList.removeAll()
            self.getBuddyList(searchWithString: (strSearch))
            self.navigationItem.title = self.appDelegate.masterLabeling.tT_MEMBER_DIRECTORY

        }
        else{
            self.boardOfDirectors.backgroundColor = hexStringToUIColor(hex: "F5F5F5")
            
            self.btnAddToBuddies.isHidden = true
            //self.boardofDireViewHight.constant = 47
            //self.btnBoardOfGoverners.isHidden = false
            self.hideBoardOfGoverners(false)
            self.bottomView.isHidden = true
            self.bottomViewHeight.constant = 0
            self.heightSectionsView.constant = 74
            self.viewSections.isHidden = false

            self.navigationItem.title = self.appDelegate.masterLabeling.tT_MEMBER_DIRECTORY
            filterBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Filter"), style: .plain, target: self, action: #selector(onTapFilter))
            navigationItem.rightBarButtonItem = filterBarButtonItem
            
        }
        
        //Modified on 16th June 2020 for BMS
        //self.viewAddBuddy.isHidden = (self.lblMultiSelectionCount.isHidden == true && self.btnAddToBuddies.isHidden == true)
        self.viewAddBuddy.isHidden = self.hideAddToBuddy ? true : (self.lblMultiSelectionCount.isHidden == true && self.btnAddToBuddies.isHidden == true)
      
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnceMD"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnceMD")
            if let impVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "PopUpForCategoryVC") as? PopUpForCategoryVC {
                 impVC.isFrom = "MemberDir"
              
                impVC.modalTransitionStyle   = .crossDissolve;
                impVC.modalPresentationStyle = .overCurrentContext
                self.present(impVC, animated: true, completion: nil)
            }
            print("App launched first time")
            return false
        }
    }
    
    //MARK:- Member Directory Categories Api
    func getMemberDirectoryCategoriesApi(strSearch :String) -> Void {
        
        
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
                    
                    if(categoriesList.myBuddiesCategory == nil){
                        self.arrEventCategory.removeAll()
                        
                        // self.appDelegate.hideIndicator()
                    }
                    else{
                        self.arrEventCategory.removeAll()
                        
                        self.arrEventCategory = categoriesList.myBuddiesCategory!
                        
                        self.appDelegate.selectedEventsCategory = self.arrEventCategory[0]
                        
                        self.loadsegmentController()
                        //eventCategory = self.appDelegate.selectedEventsCategory.categoryName! as NSString
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
    
    //MARK:- Tableview methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsWithSections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberDirectoryTableViewCell") as! MemberDirectoryTableViewCell
        let contact = contactsWithSections[indexPath.section][indexPath.row]
        cell.imageUrl = contact.profilePic
       
        cell.lblMemberName.text = contact.memberName ?? ""
      
        cell.lblMemberID.text = contact.memberID ?? ""

        cell.imgMemberprofilepic.layer.cornerRadius = cell.imgMemberprofilepic.frame.size.width/2
        cell.imgMemberprofilepic.layer.masksToBounds = true
        
        let placeHolderImage = UIImage(named: "avtar")
        cell.imgMemberprofilepic.image = placeHolderImage
        
        let imageURLString = contact.profilePic ?? ""
        
        if let imageDataTask = self.arrProfilePicTask[imageURLString]
        {
            if let data = imageDataTask.data , !data.isEmpty , imageDataTask.state == .finished
            {
                cell.imgMemberprofilepic.image = UIImage.init(data: data)
            }
            
        }
        else
        {
            
            //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
            //ENGAGE0011419 -- Start
            if imageURLString.isValidURL()
            {
                let downloadTask = ImageDownloadTask()
                downloadTask.url = imageURLString
                self.arrProfilePicTask.updateValue(downloadTask, forKey: imageURLString)
                downloadTask.startDownload { (data, response,url) in
                    if cell.imageUrl == url , let data = data , !data.isEmpty
                    {
                        DispatchQueue.main.async {
                            cell.imgMemberprofilepic.image = UIImage.init(data: data)
                        }
                    }
                    
                }
            }
            
            /*
            if(imageURLString.count>0)
            {
                let validUrl = self.verifyUrl(urlString: imageURLString)
                if(validUrl == true)
                {
                    let downloadTask = ImageDownloadTask()
                    downloadTask.url = imageURLString
                    self.arrProfilePicTask.updateValue(downloadTask, forKey: imageURLString)
                    downloadTask.startDownload { (data, response,url) in
                        if cell.imageUrl == url , let data = data , !data.isEmpty
                        {
                            DispatchQueue.main.async {
                                cell.imgMemberprofilepic.image = UIImage.init(data: data)
                            }
                        }
                        
                    }
                }
            }
            */
            //ENGAGE0011419 -- End
            
        }
        
        //Old Logic
        /*
        if(imageURLString.count>0){
            let validUrl = self.verifyUrl(urlString: imageURLString)
            if(validUrl == true){
                
                DispatchQueue.global(qos: .background).async {
                    do
                    {
                        let data = try Data.init(contentsOf: URL.init(string:imageURLString)!)
                        DispatchQueue.main.async {
                            let image = UIImage(data: data as Data)
                            cell.imgMemberprofilepic.image = image
                        }
                    }
                    catch {
                    }
                }
            }
        } */
   
        
        cell.lblMemberName.font = SFont.SourceSansPro_Semibold17
        cell.lblMemberName.textAlignment = .left
        cell.lblMemberName.textColor = APPColor.textColor.textNewColor
        cell.selectionStyle = .gray //UIColor.init(red: 225/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1.0).cgColor
        
        if self.shouldEnableMultiSelect
        {
            //FIXME: Guests have no id in buddylist. hence unable to show selection.
            
            for group in self.arrMultiSelectedMembers
            {
                //Condition for checking if member already exists
                
                // Note: MemberInfo object (Any member/Buddy) -- checking is done with id.
                // Note: GuestInfo object (Any guest tennis/Dining) -- checking for memberInfo object fails then check is done with buddyListID as guests have no id.
                // Note : CaptainInfo object (First member of each group) -- if check for GuestInfo Object fails then the check id done with captainID.
                // Note : DiningMemberInfo objects(Only dining members) -- if check for captainInfo object fails then check is done with dining member id (linked member id is being used for ID).
                
                if group.contains(where: {(($0 as? MemberInfo)?.id != nil && contact.id != nil && ($0 as? MemberInfo)?.id == contact.id) || (($0 as? GuestInfo)?.buddyID != nil && ($0 as? GuestInfo)?.buddyID != "" && contact.buddyListID != nil && ($0 as? GuestInfo)?.buddyID == contact.buddyListID) || (($0 as? CaptaineInfo)?.captainID != nil && ($0 as? CaptaineInfo)?.captainID != "" && contact.id != nil && ($0 as? CaptaineInfo)?.captainID == contact.id) || (($0 as? DiningMemberInfo)?.linkedMemberID != nil && ($0 as? DiningMemberInfo)?.linkedMemberID != "" && contact.id != nil && ($0 as? DiningMemberInfo)?.linkedMemberID == contact.id)})
                {
                    self.tblMemberDirectory.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    break
                }
            }
//            if self.memberDetails.contains(where: {(($0 as? MemberInfo)?.id != nil && contact.id != nil && ($0 as? MemberInfo)?.id == contact.id) || ((($0 as? MemberInfo)?.buddyListID != nil && contact.buddyListID != nil && ($0 as? MemberInfo)?.buddyListID == contact.buddyListID))})
//            {
//                self.tblMemberDirectory.selectRow(at: indexPath, animated: true, scrollPosition: .none)
//            }

        }
        
        return cell
    }
//        arrIndexSection =
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if (isFromDashBoard == true  && type == "Member") || self.showSegmentController{
            return arrEmpty
        }else{
        return arrVerticalIndexSection
        }
    }
    func tableView(_ tableView: UITableView,
                   sectionForSectionIndexTitle title: String,
                   at index: Int) -> Int{
        self.shouldEmptyArray = true
        //self.arrMemberList.removeAll()
        if index > sectionTitles.count {

                if !isDataLoading{
                    isDataLoading = false
                    self.pageNo=self.pageNo+1
                    self.limit=self.limit+10
                    self.offset=self.limit * self.pageNo
                    if (isFrom == "Registration")
                    {
                        if !self.showSegmentController
                        {
                            self.getMemberSpouseList(searchWithString: (strSearch))
                        }
                        
                     // self.getMemberSpouseList(searchWithString: (strSearch))
                    }
                    else if (isFrom == "BuddyList") || type == "MyBuddies"{
                        if !self.showSegmentController
                        {
                            self.arrMemberList.removeAll()
                            self.getBuddyList(searchWithString: (strSearch))
                        }
                      
                    }

                    else{
                    self.getMemberDirectory(withFilter: self.appDelegate.strFilterSting,searchWithString: (strSearch ))
                    }
                }

        }



        return index
    }
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: self.tblMemberDirectory.frame.size.width, height: 24)) //set these values as necessary
        returnedView.backgroundColor = APPColor.viewBackgroundColor.viewbg
        returnedView.layer.cornerRadius = 12
        returnedView.layer.masksToBounds = true
        
        let label = UILabel(frame: CGRect(x: 35, y: 0, width: self.tblMemberDirectory.frame.size.width - 32, height: 24))
        label.textColor = APPColor.solidbgColor.solidbg
        label.font = SFont.SourceSansPro_Semibold16
        label.text = sectionTitles[section]
        
        returnedView.addSubview(label)
        
        return returnedView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        
        // Gets the header view as a UITableViewHeaderFooterView and changes the text colour
        var headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.textColor = APPColor.viewBackgroundColor.viewbg
        
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "ModalViewController" &&  self.appDelegate.arrRequest.count > 0 { // you define it in the storyboard (click on the segue, then Attributes' inspector > Identifier
            
            return true
        }
        if (self.searchController == nil){
        }
        else{
            self.searchController.isActive = false
        }
        
        return false
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (self.searchController == nil){
        }
        else{
            self.searchController.isActive = false
        }
        
        super.prepare(for: segue, sender: sender)
        
        self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: self, presentingViewController: segue.destination)
        
        segue.destination.modalPresentationStyle = .custom
        segue.destination.transitioningDelegate = self.halfModalTransitioningDelegate
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

//MARK:- Multi Selection COllectionView Delegates
extension MemberDirectoryViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource , MultiSelectionCollectionViewCellDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 80.0, height: collectionView.frame.height)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.arrMultiSelectedMembers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrMultiSelectedMembers[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MultiSelectionCollectionViewCell", for: indexPath) as? MultiSelectionCollectionViewCell
        cell?.imageViewProfile.image = UIImage.init(named: "avtar")
        
        let member = self.arrMultiSelectedMembers[indexPath.section][indexPath.row]
        
        if self.arrSkippedIndexes.contains(indexPath)
        {
            cell?.imageViewProfile.image = UIImage.init(named: "SkipIcon")
        }
        else
        {
            cell?.imageViewProfile.image = UIImage.init(named: "avtar")
        }
               
        if let member = member as? MemberInfo
        {
            cell?.lblName.text = member.firstName
            
            if let imagelink = member.profilePic
            {
                cell?.imageViewProfile.sd_setImage(with: URL.init(string: imagelink), placeholderImage: UIImage.init(named: "avtar"))
            }
            
        }
        else if let member = member as? CaptaineInfo
        {
            cell?.lblName.text = member.captainFirstName
            
            if let imagelink = member.captainProfilePic
            {
                cell?.imageViewProfile.sd_setImage(with: URL.init(string: imagelink), placeholderImage: UIImage.init(named: "avtar"))
            }
            
        }
        else if let guest = member as? GuestInfo
        {
            cell?.lblName.text = guest.guestName
            
        }
        else if let member = member as? DiningMemberInfo
        {
            cell?.lblName.text = member.firstName
            
            if let imagelink = member.profilePic
            {
                cell?.imageViewProfile.sd_setImage(with: URL.init(string: imagelink), placeholderImage: UIImage.init(named: "avtar"))
            }
        }
        else
        {
            cell?.lblName.text = ""
        }
        
        cell?.btnCancel.isHidden = member.isEmpty == true
        cell?.btnCancel.setTitleColor(APPColor.ButtonColors.secondary, for: .normal)
        cell?.delegate = self
        cell?.viewSkipIndicator.backgroundColor = .clear
       
        return cell ?? UICollectionViewCell.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let member = self.arrMultiSelectedMembers[indexPath.section][indexPath.row]
        
        if member.isEmpty && self.shouldEnableSkipping
        {
            if !self.arrSkippedIndexes.contains(where: {$0.section == indexPath.section && $0.row == indexPath.row})
            {
                self.arrSkippedIndexes.append(indexPath)
            }
            else
            {
                if let index = self.arrSkippedIndexes.firstIndex(where: {$0.section == indexPath.section && $0.row == indexPath.row})
                {
                    self.arrSkippedIndexes.remove(at: index)
                }
            }
            
            self.collectionViewMultiSelection.reloadData()
        }
        
    }
    
    
    func didSelectCancel(cell: MultiSelectionCollectionViewCell) {
        if let index = self.collectionViewMultiSelection.indexPath(for: cell)
        {
            self.arrMultiSelectedMembers[index.section].remove(at: index.row)
            self.arrMultiSelectedMembers[index.section].insert(RequestData(), at: index.row)
            self.tblMemberDirectory.reloadData()
            self.updateMultiSelectionDisplay()
        }
    }
    
}

//MARK:- Custom methods
extension MemberDirectoryViewController
{
    private func hideBoardOfGoverners(_ bool : Bool)
    {
        self.boardOfDirectors.isHidden = bool
        self.btnBoardOfGoverners.isHidden = bool
    }
    
    /// Updates the selected members
    ///
    /// updates the count of selected members , reloads & shows / hides collection view
    private func updateMultiSelectionDisplay()
    {
        self.lblMultiSelectionCount.text = "\(self.appDelegate.masterLabeling.SELECTED_COLON ?? "") \(self.selectedTickets()) / \(self.maxTickets())"
        
//        if self.selectedTickets() > 0
//        {
//            self.collectionViewMultiSelection.isHidden = false
//            self.viewMultiSelection.isHidden = false
//        }
//        else
//        {
//            self.collectionViewMultiSelection.isHidden = true
//            self.viewMultiSelection.isHidden = true
//        }
        self.collectionViewMultiSelection.reloadData()
    }
    
    /// Shows the list of members with scroll
    ///
    /// Shows dupicate members (members who are not available or some conflicts occured while adding ) list.
    private func showConflictedMembers(members : [DetailDuplicate] , message : String?)
    {
        if let impVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ImpotantContactsVC") as? ImpotantContactsVC
        {
            impVC.importantContactsDisplayName = message
            impVC.isFrom = "Reservations"
            impVC.arrList = members
            impVC.modalTransitionStyle   = .crossDissolve;
            impVC.modalPresentationStyle = .overCurrentContext
            self.present(impVC, animated: true, completion: nil)
        }
    }
    
    /// Returns the max number of members that can be selected
    ///
    /// calculates by iterating through arrMultiSelectedMembers and counting the members in each group ([RequestData]) inside arrMultiSelectedMembers
    private func maxTickets() -> Int
    {
        var count : Int = 0
        
        self.arrMultiSelectedMembers.forEach({count += $0.count})
        return count
    }
    
    /// Returns the number of  tickets selected
    ///
    /// calculates by iterating through arrMultiSelectedMembers and counting the non empty members in each group ([RequestData]) inside arrMultiSelectedMembers
    private func selectedTickets() -> Int
    {
        var count : Int = 0
        self.arrMultiSelectedMembers.forEach({count += $0.filter({$0.isEmpty == false}).count})
        return count
    }
    
    /// Returns the number of  tickets that can be selected
    ///
    /// calculates by iterating through arrMultiSelectedMembers and counting the empty members in each group ([RequestData]) inside arrMultiSelectedMembers
    private func availableTickets() -> Int
    {
        var count : Int = 0
        self.arrMultiSelectedMembers.forEach({count += $0.filter({$0.isEmpty == true}).count})
        return count
    }
    
    
    private func showTostWith(memberName : String , requestedBy : String, in message : String)
    {
        let newMessage = message.replacingOccurrences(of: "{#SM}", with: memberName).replacingOccurrences(of: "{#RequestedBy}", with: requestedBy)
        
        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: newMessage , withDuration: Duration.kMediumDuration)
    }
    
    
    //MARK:- Appointment validation
    //Added on 16th June 2020
    ///Used for validating BMS appointents currently used only for Fitness
    private func appointmentValidation()
    {
        
        guard Network.reachability?.isReachable == true else {
            SharedUtlity.sharedHelper().showToast(on:
            self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            return
            
        }
        //Modified on 4th September 2020 v2.3
        //Copy of the selected members
        let arrSelectedMembers = self.membersData
        //let arrSelectedMembers = self.memberDetails
        //Removed the last for the following scenario
        //When a member who is not available is selected and validated the validation will fail. and when add is clicked again by selecting the same member or different member then the previously selected member is still present in the list and the validation will still fail even if the newly selected member is available.
        self.membersData.removeLast()
        
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
                    APIKeys.kGuestGender : "",
                    APIKeys.kGuestDOB : ""
                ]
                arrMemberData.append(memberInfo)
                
            }
            else if let memberDetail = member as? Detail
            {
                
                //Added by kiran V2.8 -- ENGAGE0011784 -- Added support for existing guest.
                //ENGAGE0011784 -- Start
                let memberType = CustomFunctions.shared.memberType(details: memberDetail, For: .BMS)
                
                if memberType == .guest//memberDetail.id == nil
                {
                    let memberInfo:[String: Any] = [
                        
                        APIKeys.kAppointmentMemberID : memberDetail.appointmentMemberID ?? "",
                        APIKeys.kMemberLastName : "",
                        APIKeys.kName : "",
                        APIKeys.kLinkedMemberID : "",
                        APIKeys.kGuestMemberOf : memberDetail.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
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
                    
                }
                else if memberType == .existingGuest
                {
                    //TODO:- Do existing guest chnage
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
                        //Added on 4th September 2020 V2.3
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
                        APIKeys.kGuestMemberOf : memberDetail.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                        APIKeys.kGuestMemberNo : "",
                        APIKeys.kGuestType : memberDetail.guestType ?? "",
                        APIKeys.kGuestName : memberDetail.guestName ?? "",
                        APIKeys.kGuestEmail : memberDetail.email ?? "",
                        APIKeys.kGuestContact : memberDetail.cellPhone ?? "",
                        APIKeys.kDisplayOrder : "\(index + 1)",
                        //Added on 4th September 2020 V2.3
                        APIKeys.kGuestGender : memberDetail.guestGender ?? "",
                        APIKeys.kGuestDOB : memberDetail.guestDOB ?? "",
                        APIKeys.kGuestFirstName : memberDetail.guestFirstName ?? "",
                        APIKeys.kGuestLastName : memberDetail.guestLastName ?? "",
                        APIKeys.kGuestLinkedMemberID : memberDetail.guestLinkedMemberID ?? ""
                        
                    ]*/
                    
                    arrMemberData.append(memberInfo)
                }
                else if memberType == .member
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
                //TODO:- Do existing guest change
                //For existing guest only details sent for member are required.Used same object for guest and existing guest as other details a not considered in backend
                let memberInfo:[String: Any] = [
                    
                    APIKeys.kAppointmentMemberID : "",
                    APIKeys.kMemberLastName : "",
                    APIKeys.kName : "",
                    APIKeys.kLinkedMemberID : memberDetail.linkedMemberID ?? "",
                    APIKeys.kGuestMemberOf : memberDetail.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
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
            APIKeys.kAppointmentType : self.appointmentType?.rawValue ?? "",
            APIKeys.kAppointmentDate : self.selectedDate ?? "",
            APIKeys.kAppointmentTime : self.selectedTime ?? "",
            APIKeys.kAppointmentDetailID : self.requestID ?? "",
            APIKeys.kMemberCount : "\(arrMemberData.count)",
            APIKeys.kDetails : arrMemberData
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        APIHandler.sharedInstance.getAppointmentValidation(paramater: paramaterDict, onSuccess: { (status) in
             
            self.appDelegate.hideIndicator()
             if status.responseCode == InternetMessge.kFail
             {
                
                if self.shouldEnableMultiSelect
                {
                    if let duplicateDetails = status.details
                    {
                        self.showConflictedMembers(members: duplicateDetails, message: status.brokenRules?.fields?[0])
                        
                    }
                    else
                    {
                         SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:status.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                     }
                      
                 }
                 else
                 {
                     SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:status.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                 }
                
             }
             else
             {
                
                if self.shouldEnableMultiSelect
                {
                    self.delegate?.multiSelectRequestMemberViewControllerResponse(selectedArray: self.arrMultiSelectedMembers)
                    
                }
                else
                {
                    self.delegate?.requestMemberViewControllerResponse(selecteArray: self.memberDetails)
                    
                }
                
                self.navigationController?.popViewController(animated: true)
                
            }
            
        }) { (error) in
            
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            self.appDelegate.hideIndicator()
        }
        
    }
    //MARK:- Perform Appointment Member Selection
    //Added on 16th June 2020 BMS
    ///Performs add action for Appointment member selection
    private func performAppointmentMemberSelection()
    {
        let member = contactsWithSections[selectedSection][selectedRow]
        member.isEmpty = false
        //Modified on 4th September 2020 V2.3
        self.memberDetails = [member]
        self.membersData.append(member)
        //self.memberDetails.append(member)
        self.appointmentValidation()
    }
    
}

extension UILocalizedIndexedCollation {
    //func for partition array in sections
    //func for partition array in sections
    func partitionObjects(array:[AnyObject], collationStringSelector:Selector) -> ([AnyObject], [String]) {
        var unsortedSections = [[AnyObject]]()
        //1. Create a array to hold the data for each section
        for _ in self.sectionTitles {
            unsortedSections.append([]) //appending an empty array
        }
        //2. Put each objects into a section
        for item in array {
            let index:Int = self.section(for: item, collationStringSelector:collationStringSelector)
            unsortedSections[index].append(item)
        }
        //3. sorting the array of each sections
        var sectionTitles = [String]()
        var sections = [AnyObject]()
        for index in 0 ..< unsortedSections.count { if unsortedSections[index].count > 0 {
            sectionTitles.append(self.sectionTitles[index])
            sections.append(self.sortedArray(from: unsortedSections[index], collationStringSelector: collationStringSelector) as AnyObject)
            }
        }
        return (sections, sectionTitles)
    }
}


