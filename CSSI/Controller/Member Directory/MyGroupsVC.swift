//
//  MyGroupsVC.swift
//  CSSI
//
//  Created by apple on 4/22/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class MyGroupsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MyGroupCellDelegate {
    
    
    @IBOutlet weak var myGroupsTableview: UITableView!
    @IBOutlet weak var viewGroup: UIView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var lblBottonUserNameID: UILabel!
    @IBOutlet weak var btnViewgroup: UIButton!
    @IBOutlet weak var viewGroupheight: NSLayoutConstraint!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrMyGroupList = [GetMyGroupListElement]()

    //Added on 10th July 2020 V2.2
    //Added for roles and privilages changes
    private let accessManager = AccessManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myGroupsTableview.separatorStyle = .none
        // Do any additional setup after loading the view.
        
        self.getMyGroupList(searchWithString: "")
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.notificationRecevied(notification:)) , name:Notification.Name("groupData") , object: nil)
        
         NotificationCenter.default.addObserver(self, selector:#selector(self.searchNotificationRecevied(notification:)) , name:Notification.Name("searchData") , object: nil)
        
        self.btnViewgroup.setTitle(self.appDelegate.masterLabeling.view_groups, for: UIControlState.normal)
        
        self.lblBottonUserNameID.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)
        
        let image = UIImage.init(named: "Path 1338")?.withRenderingMode(.alwaysTemplate)
        self.btnViewgroup.setImage(image, for: .normal)
        self.btnViewgroup.tintColor = APPColor.MainColours.primary2
        
    }
    
    @objc func searchNotificationRecevied(notification: Notification) {
        
       
        self.getMyGroupList(searchWithString: "")
    }
    
    @objc func notificationRecevied(notification: Notification) {
        
  
        if self.appDelegate.groupType == "Add" {
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: self.appDelegate.masterLabeling.mYGROUP_CREATED_SUCCESS_MESSAGE , withDuration: Duration.kMediumDuration)
            
        }
        else if self.appDelegate.groupType == "Edit"{
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: self.appDelegate.masterLabeling.mYGROUP_UPDATED_SUCCESS_MESSAGE , withDuration: Duration.kMediumDuration)
            
        }
        self.getMyGroupList(searchWithString: "")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.viewGroupheight.constant = 0
        viewGroup.isHidden = true
        self.appDelegate.groupType = ""
        self.getMyGroupList(searchWithString: "")

    }
    
    @IBAction func viewGroupsClicked(_ sender: Any) {
        
        //Added on 10th July 2020 V2.2
        //Added roles and previlages changes
        switch self.accessManager.accessPermision(for: .memberDirectory) {
        case .view,.notAllowed:
            
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        default:
            break
        }
        
        self.appDelegate.memberDictSearchText = ""
        self.viewGroupheight.constant = 0
        viewGroup.isHidden = true

        if self.childViewControllers.count > 0{
            let viewControllers:[UIViewController] = self.childViewControllers
            for viewContoller in viewControllers{
                viewContoller.willMove(toParentViewController: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParentViewController()
            }
        }
        
    }
    func editButtonClicked(cell: MyGroupCustomCell) {
        
        
        //Added on 10th July 2020 V2.2
        //Added roles and previlages changes
        switch self.accessManager.accessPermision(for: .memberDirectory) {
        case .view,.notAllowed:
            
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        default:
            break
        }
        
        let indexPath = self.myGroupsTableview.indexPath(for: cell)
        self.appDelegate.groupType = "Edit"

        
        if let share = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "AddGroupVC") as? AddGroupVC {
            share.myGroupID = self.arrMyGroupList[indexPath!.row].myGroupID ?? ""
            share.imageName = self.arrMyGroupList[indexPath!.row].imageName ?? ""
            share.groupName = self.arrMyGroupList[indexPath!.row].groupName ?? ""
            share.imgURL = self.arrMyGroupList[indexPath!.row].image ?? ""
            share.modalTransitionStyle   = .crossDissolve;
            share.modalPresentationStyle = .overCurrentContext
            self.present(share, animated: true, completion: nil)
        }
        
       
    }
    
    func removeButtonClicked(cell: MyGroupCustomCell) {
        
        //Added on 10th July 2020 V2.2
        //Added roles and previlages changes
        switch self.accessManager.accessPermision(for: .memberDirectory) {
        case .view,.notAllowed:
            
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        default:
            break
        }
        
        let indexPath = self.myGroupsTableview.indexPath(for: cell)

        if let removeFromBuddyList = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController {
                removeFromBuddyList.isFrom = "Groups"
                removeFromBuddyList.cancelFor = .RemoveGroup
                removeFromBuddyList.myGroupID = self.arrMyGroupList[indexPath!.row].myGroupID ?? ""
            
                self.navigationController?.pushViewController(removeFromBuddyList, animated: true)
            }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMyGroupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell") as! MyGroupCustomCell
        
        cell.mainView.layer.shadowColor = UIColor.black.cgColor
        cell.mainView.layer.shadowOpacity = 0.1
        cell.mainView.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.mainView.layer.shadowRadius = 3
        
        
        if(indexPath.row == arrMyGroupList.count - 1){
            
            cell.viewHeight.constant = 0
            cell.lblgroupName.isHidden = true
            cell.btnEdit.isHidden = true
            cell.btnRemove.isHidden = true
            cell.imgHeight.constant = 207
        }
        else{
             cell.viewHeight.constant = 40
            cell.lblgroupName.isHidden = false
            cell.btnEdit.isHidden = false
            cell.btnRemove.isHidden = false
            cell.imgHeight.constant = 167
            cell.lblgroupName.text = self.arrMyGroupList[indexPath.row].groupName
            

        }
        let placeholder:UIImage = UIImage(named: "Icon-App-40x40")!
        cell.imgGroup.image = placeholder
        //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
        //ENGAGE0011419 -- Start
        let imageURLString = self.arrMyGroupList[indexPath.row].image ?? ""
        
        if imageURLString.isValidURL()
        {
            let url = URL.init(string:imageURLString)
            cell.imgGroup.sd_setImage(with: url , placeholderImage: placeholder)
        }
        /*
        if(imageURLString.count>0){
            let validUrl = self.verifyUrl(urlString: imageURLString)
            if(validUrl == true){
                let url = URL.init(string:imageURLString)
                cell.imgGroup.sd_setImage(with: url , placeholderImage: placeholder)
            }
        }
        */
        //ENGAGE0011419 -- End
        //cell.btnRemove.isEnabled = false
        
        self.myGroupsTableview.separatorStyle = UITableViewCellSeparatorStyle.none
        cell.delegate = self

        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Added on 10th July 2020 V2.2
        //Added roles and previlages changes
        switch self.accessManager.accessPermision(for: .memberDirectory) {
        case .view,.notAllowed:
            
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        default:
            break
        }
        
        if(indexPath.row == arrMyGroupList.count - 1){
            self.appDelegate.groupType = "Add"

            if let share = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "AddGroupVC") as? AddGroupVC {
                share.modalTransitionStyle   = .crossDissolve;
                share.modalPresentationStyle = .overCurrentContext
                self.present(share, animated: true, completion: nil)
            }
            
        }
        else{
        self.viewGroupheight.constant = 32
        viewGroup.isHidden = false
        self.appDelegate.groupID = self.arrMyGroupList[indexPath.row].myGroupID!
        let myGroup = storyboard!.instantiateViewController(withIdentifier: "GroupDetailVC")
        configureChildViewControllerForstatenents(childController: myGroup, onView: self.baseView)
        }
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
    
    //MARK:-  Get MyGroup List Api
    func getMyGroupList(searchWithString: String){
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        if (Network.reachability?.isReachable) == true{

            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any]
            paramaterDict = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "MyGroupID": "",
                "SearchBy": self.appDelegate.memberDictSearchText,
                "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!,
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!
        
            ]
            
            
            APIHandler.sharedInstance.getMyGroupsList(paramaterDict: paramaterDict, onSuccess: { groupList in
                self.appDelegate.hideIndicator()
                
                
                if(groupList.responseCode == InternetMessge.kSuccess)
                {
                    if(groupList.getMyGroupList == nil){
                        self.arrMyGroupList.removeAll()
                        self.myGroupsTableview.setEmptyMessage(InternetMessge.kNoData)
                        self.myGroupsTableview.reloadData()
                        self.appDelegate.hideIndicator()
                    }
                    else{
                        
                        if(groupList.getMyGroupList?.count == 0)
                        {
                            self.arrMyGroupList.removeAll()
                            self.myGroupsTableview.setEmptyMessage(InternetMessge.kNoData)
                            self.myGroupsTableview.reloadData()
                            
                            
                            self.appDelegate.hideIndicator()
                            
                        }else{
                            self.myGroupsTableview.restore()
                            self.arrMyGroupList = groupList.getMyGroupList!  //eventList.listevents!
                            self.myGroupsTableview.reloadData()
                        }
                        
                    }
                    
                    if(!(self.arrMyGroupList.count == 0)){
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.myGroupsTableview.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((groupList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: groupList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.myGroupsTableview.setEmptyMessage(groupList.responseMessage ?? "")
                    
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
            //  self.tableViewHeroes.setEmptyMessage(InternetMessge.kInternet_not_available)
            
        }
        
    }

}
