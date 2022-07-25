//
//  MyBuddiesViewController.swift
//  CSSI
//
//  Created by apple on 4/17/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import FLAnimatedImage
import ScrollableSegmentedControl

class MyBuddiesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate, UIGestureRecognizerDelegate  {
    
    var isFrom : NSString!
    var index : Int!
    
    
    @IBOutlet weak var tblMemberDirectory: UITableView!
    @IBOutlet weak var viewFilterSegment: UIView!
    @IBOutlet weak var bttnLoadMore: UIButton!
    @IBOutlet weak var viewSegment: UIView!
    
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
    var selectedSection:Int = -1
    var selectedRow:Int = -1
    var delegate: MemberViewControllerDelegate?
    var isAddToBuddy : Int?
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrMemberList = [MemberInfo]()
    var sectionTitles = [String]()
    var contactsWithSections = [[MemberInfo]]()
    let collation = UILocalizedIndexedCollation.current()
    var eventCategory : String?
    
    var arrFilterIndexSection = [""]
    var filterSegmentedController = ScrollableSegmentedControl()
    private var selectedAlphabet : String?
    
    /*Hides/shows the segment controller for Alphabetic filtering*/
    private let enableFilterSegment = false
    
    //Added on 11th July 2020 V2.2
    private let accessManager = AccessManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.appDelegate.arrSelectedTagg.removeAll()
        self.refreshControls()
        self.bttnLoadMore.isHidden = true
        self.viewSegment.isHidden = !self.enableFilterSegment
        
        if self.enableFilterSegment
        {
            bttnLoadMore.backgroundColor = .clear
            bttnLoadMore.layer.cornerRadius = 18
            bttnLoadMore.layer.borderWidth = 1
            bttnLoadMore.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
            bttnLoadMore.setTitle(self.appDelegate.masterLabeling.SHOW_MORE, for: .normal)
        }
        else
        {
             self.getBuddyList(searchWithString: self.appDelegate.golfEventsSearchText)
        }
      
        
        arrIndexSection = ["A", "B", "C", "D", "E",  "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        
        if self.enableFilterSegment
        {
            self.arrFilterIndexSection = ["All","A", "B", "C", "D", "E",  "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        }

        
       
        NotificationCenter.default.addObserver(self, selector:#selector(self.notificationRecevied(notification:)) , name:Notification.Name("eventsData") , object: nil)
        
    }
    
    @objc func notificationRecevied(notification: Notification) {
        let strSearchText = notification.userInfo?["searchText"] ?? ""
        if enableFilterSegment
        {
            self.arrMemberList.removeAll()
            self.tblMemberDirectory.reloadData()
        }
        self.getBuddyList(searchWithString: strSearchText as! String)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

//        self.getAuthToken()
        
        self.navigationItem.title = appDelegate.masterLabeling.add_mybuddy
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if enableFilterSegment
        {
            self.loadFilterSegmentController()
        }
       
    }
    
    
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    func refreshControls()
    {
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        self.tblMemberDirectory.addSubview(refreshControl) // not required when using UITableViewController
        
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        
        self.arrMemberList.removeAll()
        self.tblMemberDirectory.reloadData()
        self.pageNo = 1
        self.strSearch = ""
        
        self.getBuddyList(searchWithString: self.appDelegate.golfEventsSearchText)
        self.refreshControl.endRefreshing()
        
        
    }
    
    //MARK:- verify url exist or not
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
    //MARK:- Scroll to first row
    func scrollToFirstRow() {
        if(self.arrMemberList.count > 0){
            let indexPath = IndexPath(row: 0, section: 0)
            self.tblMemberDirectory.scrollToRow(at: indexPath, at: .top, animated: true)
            
            
        }
    }
    
    //Mark- Pagination Logic
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // print("scrollViewDidEndDecelerating")
    }
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        // print("scrollViewDidEndDragging")
        if enableFilterSegment
        {
            
        }
        else
        {
            if ((tblMemberDirectory.contentOffset.y + tblMemberDirectory.frame.size.height) >= tblMemberDirectory.contentSize.height)
            {
                if !isDataLoading
                {
                    isDataLoading = true
                    self.pageNo=self.pageNo+1
                    self.limit=self.limit+10
                    self.offset=self.limit * self.pageNo

                    self.getBuddyList(searchWithString: self.appDelegate.golfEventsSearchText)

                }
            }
        }
        

        }
        
        //MARK:- Load More Bttn
    
    @IBAction func loadMoreClicked(_ sender: UIButton) {
        self.pageNo += 1
        self.getBuddyList(searchWithString: self.appDelegate.golfEventsSearchText)
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
    
    
    //MARK:-  Get Buddy List Api
    func getBuddyList(searchWithString: String){
       
        
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            var paramaterDict = [String : Any]()
            if self.enableFilterSegment
            {
                 paramaterDict = [
                    "Content-Type":"application/json",
                    APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                    APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                    "FirstNameFilter" : searchWithString,
                    "LastNameFilter" : searchWithString,
                    APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                    APIKeys.kdeviceInfo: [APIHandler.devicedict],
                    APIKeys.ksearchby: searchWithString,
                    APIKeys.kCategory: self.appDelegate.typeOfCalendar,
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
                    "FirstNameFilter" : searchWithString,
                    "LastNameFilter" : searchWithString,
                    APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                    APIKeys.kdeviceInfo: [APIHandler.devicedict],
                    APIKeys.ksearchby: searchWithString,
                    APIKeys.kCategory: self.appDelegate.typeOfCalendar,
                    "SearchChar": "MemberDirectory"
                ]
            }
            
            
            print("memberdict \(paramaterDict)")
            APIHandler.sharedInstance.getBuddyList(paramaterDict: paramaterDict, onSuccess: { memberLists in
                self.appDelegate.hideIndicator()
                
                if(memberLists.responseCode == InternetMessge.kSuccess)
                {
                    
                    if(memberLists.memberList == nil){
                        self.appDelegate.hideIndicator()
                        self.tblMemberDirectory.setEmptyMessage(InternetMessge.kNoData)
                    }
                    else{
                        
                        if self.enableFilterSegment
                        {
                            
                        }
                        else
                        {
                            self.arrMemberList.removeAll()
                        }
                      
                        for membberInfo in memberLists.memberList!{
                            self.arrMemberList.append(membberInfo)
                        }
                        
                        //   if MemberInfo
                        let (arrContacts, arrTitles) = self.collation.partitionObjects(array: self.arrMemberList, collationStringSelector: #selector(getter: MemberInfo.lastName))
                        
                        self.contactsWithSections = arrContacts as! [[MemberInfo]]
                        self.sectionTitles = arrTitles
                        
                        
                        self.bttnLoadMore.isHidden = self.enableFilterSegment ? (memberLists.isLoadMore ?? 0 == 0) : true
                        
//                        if memberLists.isLoadMore == 0
//                        {
//                            self.bttnLoadMore.isHidden = true
//                        }
//                        else
//                        {
//                            self.bttnLoadMore.isHidden = false
//                        }
                        
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
                                
                                self.scrollToFirstRow()
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
    
    
    //MARK:- Tableview methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsWithSections[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberDirectoryTableViewCell") as! MemberDirectoryTableViewCell
        let contact = contactsWithSections[indexPath.section][indexPath.row]
        cell.lblMemberName.text = contact.memberName ?? ""
        
        cell.lblMemberID.text = contact.memberID ?? ""
       
        
        let placeHolderImage = UIImage(named: "avtar")
        cell.imgMemberprofilepic.image = placeHolderImage
        
        cell.imgMemberprofilepic.layer.cornerRadius = cell.imgMemberprofilepic.frame.size.width/2
        cell.imgMemberprofilepic.layer.masksToBounds = true
        
        
        //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
        //ENGAGE0011419 -- Start
        let imageURLString = contact.profilePic ?? ""
        
        if imageURLString.isValidURL()
        {
            let url = URL.init(string:imageURLString)
            cell.imgMemberprofilepic.sd_setImage(with: url , placeholderImage: placeHolderImage)
        }
        /*
        if(imageURLString.count>0){
            let validUrl = self.verifyUrl(urlString: imageURLString)
            if(validUrl == true){
                let url = URL.init(string:imageURLString)
                cell.imgMemberprofilepic.sd_setImage(with: url , placeholderImage: placeHolderImage)
            }
        }
        */
        //ENGAGE0011419 -- End
        cell.lblMemberName.font = SFont.SourceSansPro_Semibold17
        cell.lblMemberName.textAlignment = .left
        cell.lblMemberName.textColor = APPColor.textColor.textNewColor
        
        return cell
    }
    
    //MARK:- Member Directory Api
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Added on 11th July 2020 V2.2
        //Added roles and privilages changes
        
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
        
        let contact = contactsWithSections[indexPath.section][indexPath.row]
        

        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.view.tintColor = hexStringToUIColor(hex: "40B2E6")

        let profileView = UIAlertAction(title: self.appDelegate.masterLabeling.pROFILE,
                                              style: .default) { (action) in
                                            
            if let profile = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "MyBuddiesProfileVC") as? MyBuddiesProfileVC {
                profile.modalTransitionStyle   = .crossDissolve;
                profile.modalPresentationStyle = .overCurrentContext
                
                profile.memberType = contact.buddyType ?? ""
                profile.selectedMemberId = contact.memberID ?? ""
                profile.iD = contact.id ?? ""
                profile.parentId = contact.parentid ?? ""
                profile.buddyListID = contact.buddyListID ?? ""
                self.present(profile, animated: true, completion: nil)
            }
        }
        
        if(self.appDelegate.typeOfCalendar == "Tennis"){
           
            eventCategory = self.appDelegate.masterLabeling.upcoming_court_times
        }
        else if(self.appDelegate.typeOfCalendar == "Dining"){
           
            eventCategory = self.appDelegate.masterLabeling.uPCOMING_DINING_RESERVATION

        }
        else if self.appDelegate.typeOfCalendar == "FitnessSpa"
        {
            eventCategory = self.appDelegate.masterLabeling.uPCOMING_FITNESSEVENTS
        }
        else{
            
            eventCategory = self.appDelegate.masterLabeling.upcoming_teetimes

        }
        
        let upComingTeeTimes = UIAlertAction(title: eventCategory,
                                           style: .default) { (action) in
                                            
            if let profile = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "UpcomingTeeTimesVC") as? UpcomingTeeTimesVC {
                profile.modalTransitionStyle   = .crossDissolve;
                profile.modalPresentationStyle = .overCurrentContext
                profile.title = self.eventCategory
                profile.memberID = contact.id ?? ""
                profile.memberType = contact.buddyType ?? ""
                self.present(profile, animated: true, completion: nil)
            }
        }
        let removeFromBuddyList = UIAlertAction(title: self.appDelegate.masterLabeling.remove_from_mybuddylist,
                                             style: .default) { (action) in
                        
            if let removeFromBuddyList = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController {
                removeFromBuddyList.isFrom = "Buddy"
                removeFromBuddyList.cancelFor = .RemoveBuddy
                removeFromBuddyList.parentID = contact.parentid ?? ""
                removeFromBuddyList.memberID = contact.memberID ?? ""
                removeFromBuddyList.ID = contact.id ?? ""
                removeFromBuddyList.guestID = contact.buddyListID ?? ""

                self.navigationController?.pushViewController(removeFromBuddyList, animated: true)
            }
                                                
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        actionSheet.addAction(profileView)

        if contact.buddyType == "Guest"{

        }else{
            actionSheet.addAction(upComingTeeTimes)

        }
        actionSheet.addAction(removeFromBuddyList)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
    }


    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        return arrIndexSection
    }
    func tableView(_ tableView: UITableView,
                   sectionForSectionIndexTitle title: String,
                   at index: Int) -> Int{
        if index > sectionTitles.count {
            
            if !isDataLoading{
                isDataLoading = false
                if self.enableFilterSegment
                {
                    
                }
                else
                {
                     self.pageNo=self.pageNo+1
                     self.limit=self.limit+10
                     self.offset=self.limit * self.pageNo
                    
                    self.getBuddyList(searchWithString: self.appDelegate.golfEventsSearchText)
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
    
    //MARK:- Segmented Controller -
    
    
    private func loadFilterSegmentController()
    {
        self.filterSegmentedController = ScrollableSegmentedControl.init(frame: self.viewFilterSegment.bounds)
        self.viewFilterSegment.addSubview(self.filterSegmentedController)
        self.filterSegmentedController.segmentStyle = .textOnly
            
        // self.segmentedController.segmentStyle = .imageOnLeft
            
            
        self.filterSegmentedController.underlineSelected = true
       // self.filterSegmentedController.backgroundColor = hexStringToUIColor(hex: "F5F5F5")
            
        self.filterSegmentedController.tintColor = APPColor.loginBackgroundButtonColor.loginBtnBGColor
            
        self.filterSegmentedController.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        self.filterSegmentedController.contentMode = .center
        //self.filterSegmentedController.segmentContentColor = hexStringToUIColor(hex: "40B2E6")
        //self.filterSegmentedController.selectedSegmentContentColor = UIColor.orange
        self.filterSegmentedController.widthPadding = 25
        
        for i in 0 ..< self.arrFilterIndexSection.count
        {
            self.filterSegmentedController.insertSegment(withTitle: self.arrFilterIndexSection[i], image: nil, at: i)
        }
        
        self.filterSegmentedController.selectedSegmentIndex = 0
    }
    
    
    @IBAction func bttnNextClicked(_ sender: Any)
    {
        var selectedSegment =  self.filterSegmentedController.selectedSegmentIndex  + 1
        if selectedSegment >= self.filterSegmentedController.numberOfSegments
        {
            selectedSegment = self.filterSegmentedController.numberOfSegments - 1
        }
        self.filterSegmentedController.selectedSegmentIndex = selectedSegment
    }
    
    @IBAction func bttnPreviousClicked(_ sender: Any)
    {
        var selectedSegment =  self.filterSegmentedController.selectedSegmentIndex  - 1
        if selectedSegment <= 0
        {
            selectedSegment = 0
        }
        self.filterSegmentedController.selectedSegmentIndex = selectedSegment
    }
    
   
    @objc func segmentSelected(sender:ScrollableSegmentedControl)
    {
        self.scrollToFirstRow()
        self.arrMemberList.removeAll()
        self.pageNo = 1
        self.selectedAlphabet = self.arrFilterIndexSection[sender.selectedSegmentIndex]
        print(self.arrFilterIndexSection[sender.selectedSegmentIndex])
        self.getBuddyList(searchWithString: self.appDelegate.golfEventsSearchText)
    }
    
}
