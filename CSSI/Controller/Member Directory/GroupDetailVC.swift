//
//  GroupDetailVC.swift
//  CSSI
//
//  Created by apple on 4/23/19.
//  Copyright © 2019 yujdesigns. All rights reserved.

import UIKit

class GroupDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var btnAddMember: UIButton!
    @IBOutlet weak var groupTableview: UITableView!
    
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
    var arrMemberList = [GetMyGroupDetailsList]()
    var sectionTitles = [String]()
    var contactsWithSections = [[GetMyGroupDetailsList]]()
    let collation = UILocalizedIndexedCollation.current()
   
   
    
    @IBAction func addMemberClicked(_ sender: Any) {
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.appDelegate.arrSelectedTagg.removeAll()
        self.refreshControls()
        
        
        arrIndexSection = ["A", "B", "C", "D", "E",  "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        
       
        NotificationCenter.default.addObserver(self, selector:#selector(self.searchNotificationRecevied(notification:)) , name:Notification.Name("searchData") , object: nil)
    }
    @objc func searchNotificationRecevied(notification: Notification) {
        
      
        self.getBuddyList(searchWithString: (strSearch))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
      //  self.getAuthToken()
        self.getBuddyList(searchWithString: (strSearch))

        self.navigationItem.title = appDelegate.masterLabeling.add_mybuddy
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
    }
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    func refreshControls()
    {
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        self.groupTableview.addSubview(refreshControl) // not required when using UITableViewController
        
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        
        self.arrMemberList.removeAll()
        self.groupTableview.reloadData()
        self.pageNo = 1
        self.strSearch = ""
        
        self.getBuddyList(searchWithString: (strSearch))
        
        self.refreshControl.endRefreshing()
        
        
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
    //MARK:- Scroll to first row
    func scrollToFirstRow() {
        if(self.arrMemberList.count > 0){
            let indexPath = IndexPath(row: 0, section: 0)
            self.groupTableview.scrollToRow(at: indexPath, at: .top, animated: true)
            
            
        }
    }
    
    //Mark- Pagination Logic
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // print("scrollViewDidEndDecelerating")
    }
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        // print("scrollViewDidEndDragging")
        
        if ((groupTableview.contentOffset.y + groupTableview.frame.size.height) >= groupTableview.contentSize.height)
        {
            if !isDataLoading{
                isDataLoading = true
                self.pageNo=self.pageNo+1
                self.limit=self.limit+10
                self.offset=self.limit * self.pageNo
                
                self.getBuddyList(searchWithString: (strSearch))
                
            }
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
    
    
    //MARK:-  Get My Group Details  Api
    func getBuddyList(searchWithString: String){
        
        
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                "MyGroupID": self.appDelegate.groupID,
                "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!,
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "SearchBy": self.appDelegate.memberDictSearchText,
            ]
            
            print("memberdict \(paramaterDict)")
            APIHandler.sharedInstance.getMyGroupDetails(paramaterDict: paramaterDict, onSuccess: { groupDetailsList in
                self.appDelegate.hideIndicator()
                
                if(groupDetailsList.responseCode == InternetMessge.kSuccess)
                {
                    
                    if(groupDetailsList.getMyGroupDetailsList == nil){
                        self.appDelegate.hideIndicator()
                        self.groupTableview.setEmptyMessage(InternetMessge.kNoData)
                    }
                    else{
                        self.arrMemberList.removeAll()
                        for groupInfo in groupDetailsList.getMyGroupDetailsList!{
                            self.arrMemberList.append(groupInfo)
                        }
                        
                        //   if MemberInfo
                        let (arrContacts, arrTitles) = self.collation.partitionObjects(array: self.arrMemberList, collationStringSelector: #selector(getter: GetMyGroupDetailsList.name))
                        
                        self.contactsWithSections = arrContacts as! [[GetMyGroupDetailsList]]
                        self.sectionTitles = arrTitles
                        
                        if(arrTitles.count == 0)
                        {
                            self.groupTableview.setEmptyMessage(InternetMessge.kNoData)
                        }
                        else{
                            self.groupTableview.restore()
                        }
                        if(self.groupTableview == nil)
                        {
                            self.groupTableview.reloadData()
                            
                        }else{
                            if(self.appDelegate.strFilterSting == "All" || self.strSearch == "")
                            {
                                self.groupTableview.reloadData()
                            }
                            else{
                                
                                self.scrollToFirstRow()
                                self.groupTableview.reloadData()
                            }
                        }
                    }
                }else{
                    self.appDelegate.hideIndicator()
                    if(((groupDetailsList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: groupDetailsList.responseMessage, withDuration: Duration.kMediumDuration)
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
        cell.lblMemberName.text = contact.name
        
        cell.lblMemberID.text = contact.memberId
        
        let placeHolderImage = UIImage(named: "avtar")
        cell.imgMemberprofilepic.image = placeHolderImage
        
        cell.imgMemberprofilepic.layer.cornerRadius = cell.imgMemberprofilepic.frame.size.width/2
        cell.imgMemberprofilepic.layer.masksToBounds = true
        
        
        //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
        //ENGAGE0011419 -- Start
        let imageURLString = contact.image ?? ""
        
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
        cell.selectionStyle = .none
        
        return cell
    }
    
    //MARK:- Member Directory Api
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let contact = contactsWithSections[indexPath.section][indexPath.row]

            selectedRow = indexPath.row
            selectedSection = indexPath.section
     
        if let profileView = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "MyBuddiesProfileVC") as? MyBuddiesProfileVC {
                        profileView.modalTransitionStyle   = .crossDissolve;
                        profileView.modalPresentationStyle = .overCurrentContext
            
            
                        profileView.selectedMemberId = contact.memberId ?? ""
                        profileView.iD = contact.id ?? ""
                        profileView.parentId = contact.parentId ?? ""
            
                        self.present(profileView, animated: true, completion: nil)
        }
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
                self.pageNo=self.pageNo+1
                self.limit=self.limit+10
                self.offset=self.limit * self.pageNo
                
                self.getBuddyList(searchWithString: (strSearch))
                
            }
            
        }
        
        
        
        return index
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: self.groupTableview.frame.size.width, height: 24)) //set these values as necessary
        returnedView.backgroundColor = APPColor.viewBackgroundColor.viewbg
        returnedView.layer.cornerRadius = 12
        returnedView.layer.masksToBounds = true
        
        let label = UILabel(frame: CGRect(x: 35, y: 0, width: self.groupTableview.frame.size.width - 32, height: 24))
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
}




