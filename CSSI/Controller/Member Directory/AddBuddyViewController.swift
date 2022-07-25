//
//  AddBuddyViewController.swift
//  CSSI
//
//  Created by apple on 6/1/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class AddBuddyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MemberCategoryDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblSelectCategory: UILabel!
    @IBOutlet weak var btnSelectAll: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    var linkedMemberID: String?
    var buttonType: String?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var groups : [GetMyGroup] = []
    var category: [GetCategory] = []
    var arrSelectedCategories = [String]()
    var arrSelectedGroups = [String]()
    var iD = String()
    var parentId = String()
    var memberID : String?
    var categotyList = [Dictionary<String, Any>]()
    var groupList = [Dictionary<String, Any>]()
    var selectedItems = [Int]()
    var selectedItems2 = [Int]()
    var selectAll: Bool?
    
    //Added by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
    //ENGAGE0012667 -- Start
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    //ENGAGE0012667 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        self.getMemberCategory()
        tableView.separatorStyle = .none
        selectAll = false
        if buttonType == "Add"{
        btnAdd.backgroundColor = .clear
        btnAdd.layer.cornerRadius = 18
        btnAdd.layer.borderWidth = 1
        btnAdd.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        btnAdd.setTitle("Add", for: UIControlState.normal)

            self.btnAdd.setStyle(style: .outlined, type: .primary)
        }else{
            btnAdd.backgroundColor = .clear
            btnAdd.layer.cornerRadius = 18
            btnAdd.layer.borderWidth = 1
            btnAdd.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
            btnAdd.setTitle("Remove", for: UIControlState.normal)
            self.btnAdd.setStyle(style: .outlined, type: .primary)
        }
        btnCancel.backgroundColor = .clear
        btnCancel.layer.cornerRadius = 18
        btnCancel.layer.borderWidth = 1
        btnCancel.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        
        self.btnCancel.setStyle(style: .outlined, type: .primary)
        self.tableView.setEmptyMessage(InternetMessge.kNoData)

       
    }
    //MARK:- Get Member Categories Api
    func getMemberCategory(){
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)

        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "" ,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "LinkedMemberID": linkedMemberID ?? "",
                "Action": buttonType ?? ""
                
            ]
            
            print(paramaterDict)
            APIHandler.sharedInstance.getMemberCategory(paramater: paramaterDict , onSuccess: { categoryList in
                self.appDelegate.hideIndicator()
                self.tableView.setEmptyMessage("")

                if(categoryList.responseCode == InternetMessge.kSuccess){
                    if(categoryList.getMyGroup.isEmpty) && (categoryList.getCategory.isEmpty){
                        self.appDelegate.hideIndicator()
                        
                        self.groups.removeAll()
                        self.category.removeAll()
                        self.tableView.setEmptyMessage(InternetMessge.kNoData)
                        self.tableView.reloadData()
                        
                    } else {
                        self.tableView.restore()
                        self.groups.removeAll()
                        self.category.removeAll()
                        self.category = categoryList.getCategory
                        self.groups = categoryList.getMyGroup
                        self.tableView.reloadData()
                        self.appDelegate.hideIndicator()
                        
                    }
                    if self.groups.count == 0 && self.category.count == 0 {
                        self.btnSelectAll.isHidden = true
                    }
                    else{
                        self.btnSelectAll.isHidden = false

                    }
                } else {
                    self.appDelegate.hideIndicator()
                    self.groups.removeAll()
                    self.tableView.reloadData()
                    
                    self.tableView.setEmptyMessage(categoryList.responseMessage )
                    
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
    @IBAction func selectAllClicked(_ sender: Any) {
        let btn : UIButton = sender as! UIButton
        
        if selectAll == false{
            
            
            btn.tag = 1
            selectAll = true
            btnSelectAll.setImage(UIImage(named:"Group 2130"), for: UIControlState.normal)
            self.selectedItems.removeAll()
            self.selectedItems2.removeAll()
            self.arrSelectedCategories.removeAll()
            self.arrSelectedGroups.removeAll()
            
            for i in 0 ..< self.category.count {
                arrSelectedCategories.append(category[i].value)
                
                self.selectedItems.append(i)
            }
            
            for i in 0 ..< self.groups.count {
                arrSelectedGroups.append(groups[i].myGroupID)
                
                self.selectedItems2.append(i)
            }

        }
        else{
            btn.tag = 0
            selectAll = false

            btnSelectAll.setImage(UIImage(named: "CheckBox_uncheck"), for: UIControlState.normal)
            self.selectedItems.removeAll()
            self.selectedItems2.removeAll()
            self.arrSelectedCategories.removeAll()
            self.arrSelectedGroups.removeAll()
            }
        self.tableView.reloadData()

    }
    func CheckBoxClicked(cell: AddBuddyCustomCell) {
       
        let indexPath = self.tableView.indexPath(for: cell)

        

          if indexPath?.section == 0 {
        if (self.selectedItems.contains((indexPath?.row)!)) {
            let indexxx = self.selectedItems.index(where: { $0 == indexPath?.row })

            self.selectedItems.remove(at: indexxx!)
            if (self.arrSelectedCategories.contains((category[(indexPath?.row)!].value))){
                self.arrSelectedCategories.remove(at: self.arrSelectedCategories.index(where: {$0 == (category[(indexPath?.row)!].value)})!)
            }
        }
        else {
            arrSelectedCategories.append(category[(indexPath?.row)!].value)

            self.selectedItems.append((indexPath?.row)!)
        }
          }else{
            if (self.selectedItems2.contains((indexPath?.row)!)) {
                // let index = self.selectedItems.indexOf(indexPath?.row)
                let indexxx = self.selectedItems2.index(where: { $0 == indexPath?.row })
                
                self.selectedItems2.remove(at: indexxx!)
                if (self.arrSelectedGroups.contains((groups[(indexPath?.row)!].myGroupID))){
                    self.arrSelectedGroups.remove(at: self.arrSelectedGroups.index(where: {$0 == (groups[(indexPath?.row)!].myGroupID)})!)
                }
            }
            else {
                self.selectedItems2.append((indexPath?.row)!)
                arrSelectedGroups.append(groups[(indexPath?.row)!].myGroupID)

            }
        }
        if self.selectedItems2.count == groups.count && self.selectedItems.count == category.count{
            btnSelectAll.setImage(UIImage(named:"Group 2130"), for: UIControlState.normal)
            selectAll = true

        }else {
            btnSelectAll.setImage(UIImage(named: "CheckBox_uncheck"), for: UIControlState.normal)
            selectAll = false
        }

        
//        }
        self.tableView.reloadData()
    }
    
    
    @IBAction func closeClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func addClciekd(_ sender: Any) {
        
        groupList.removeAll()
        categotyList.removeAll()
        if buttonType == "Delete"{
            if (Network.reachability?.isReachable) == true{
                
                self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
                
                for i in 0 ..< self.arrSelectedCategories.count {
                    let categoryInfo:[String: Any] = [
                        APIKeys.kMemberId : self.memberID ?? "",
                        APIKeys.kid :  self.iD ,
                        APIKeys.kParentId : self.parentId ,
                        "Category": self.arrSelectedCategories[i]
                    ]
                    categotyList.append(categoryInfo)
                }
                for j in 0 ..< self.arrSelectedGroups.count {
                    let groupInfo:[String: Any] = [
                        APIKeys.kMemberId : self.memberID ?? "",
                        APIKeys.kid :  self.iD ,
                        APIKeys.kParentId : self.parentId ,
                        "MyGroupID": self.arrSelectedGroups[j]
                    ]
                    groupList.append(groupInfo)
                }

                let paramaterDict:[String: Any] = [
                    "Content-Type":"application/json",
                    APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                    APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                    APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                    APIKeys.kdeviceInfo: [APIHandler.devicedict],
                    "RemoveBuddy": categotyList,
                    "RemoveMyGroup" : groupList
                ]
                print(paramaterDict)
                
                self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
                
                APIHandler.sharedInstance.removeBuddyFromList(paramater: paramaterDict , onSuccess: { response in
                    self.appDelegate.hideIndicator()
                    if(response.responseCode == InternetMessge.kSuccess){
                        self.appDelegate.hideIndicator()
                        
                        
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: self.appDelegate.masterLabeling.bUDDY_REMOVED_SUCCESS_MESSAGE, withDuration: Duration.kShortDuration)
                        let delay = 2 // seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
                            self.dismiss(animated: true, completion: nil)
                        }


                    }
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
        }else{
        
            if (Network.reachability?.isReachable) == true{
                
                
                self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
                
                for i in 0 ..< self.arrSelectedCategories.count {
                let categoryInfo:[String: Any] = [
                    APIKeys.kMemberId : self.memberID ?? "",
                    APIKeys.kid :  self.iD ,
                    APIKeys.kParentId : self.parentId ,
                    "Category": self.arrSelectedCategories[i]
                ]
                    categotyList.append(categoryInfo)
                }
                for j in 0 ..< self.arrSelectedGroups.count {
                    let groupInfo:[String: Any] = [
                        APIKeys.kMemberId : self.memberID ?? "",
                        APIKeys.kid :  self.iD ,
                        APIKeys.kParentId : self.parentId ,
                        "MyGroupID": self.arrSelectedGroups[j]
                    ]
                    groupList.append(groupInfo)
                }
                
                let paramaterDict:[String: Any] = [
                    "Content-Type":"application/json",
                    APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                    APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                    APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                    "AddBuddy" : categotyList,
                    "AddMyGroup" : groupList,
                    APIKeys.kdeviceInfo: [APIHandler.devicedict]
                ]
                
                print("memberdict \(paramaterDict)")
                APIHandler.sharedInstance.addToBuddyList(paramaterDict: paramaterDict, onSuccess: { memberLists in
                    self.appDelegate.hideIndicator()
                    
                    
                    if(memberLists.responseCode == InternetMessge.kSuccess)
                    {
                        self.appDelegate.hideIndicator()
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: self.appDelegate.masterLabeling.bUDDY_ADDED_SUCCESS_MESSAGE, withDuration: Duration.kShortDuration)
                       
                        let delay = 2 // seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
                            self.dismiss(animated: true, completion: nil)
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
                })
                
                
            }else{
                
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
                
            }
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return category.count
        }else{
            return groups.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AddBuddyCell", for: indexPath) as? AddBuddyCustomCell {
            cell.delegate = self
            if indexPath.section == 0 {
               // cell.lblName.text = category[indexPath.row].text
                cell.btnCheckBox.setTitle(category[indexPath.row].text, for: UIControlState.normal)
                if (selectedItems.contains(indexPath.row)) {
                    cell.btnCheckBox.setImage(UIImage(named:"Group 2130"), for: UIControlState.normal)
                }
                else {
                    cell.btnCheckBox.setImage(UIImage(named: "CheckBox_uncheck"), for: UIControlState.normal)
                }
            }else{
               // cell.lblName.text = groups[indexPath.row].groupName
                cell.btnCheckBox.setTitle(groups[indexPath.row].groupName, for: UIControlState.normal)

                if (selectedItems2.contains(indexPath.row)) {
                    cell.btnCheckBox.setImage(UIImage(named:"Group 2130"), for: UIControlState.normal)
                }
                else {
                    cell.btnCheckBox.setImage(UIImage(named: "CheckBox_uncheck"), for: UIControlState.normal)
                }
            }
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            cell.btnCheckBox.tag = indexPath.row
            

           return cell
        }
         return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0{
            return 0.1
        }else{
             return 50
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("AddBuddyHeaderView", owner: self, options: nil)?.first as! AddBuddyHeaderView
       
        if section == 0 {
            headerView.isHidden = true
            return headerView
        }else{
            headerView.isHidden = false
           
            headerView.lblMyGroup.text = "My Groups"
            
            return headerView
        }
       
        
    }
    
    
}
