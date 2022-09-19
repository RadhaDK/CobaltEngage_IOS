//
//  EditMembershipTypeVC.swift
//  CSSI
//
//  Created by Vishal Pandey on 05/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
import Alamofire

enum requestAction{
    case save,cancel
}
class EditMembershipTypeVC: UIViewController {
    
    
    //MARK:- outlets
    @IBOutlet weak var tblMembershipType: UITableView!
    @IBOutlet weak var btnCancelPendingrequest: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var heightBottom: NSLayoutConstraint!
    
    var thereIsCellTapped = false
    var expanded:[IndexPath] = []
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrMembershipType = [MembershipTypeData]()
    var expandedIndexSet : IndexSet = []
    var expandedIndexSetClose : IndexSet = []
    var selectedMemberShip : String?
    var actionrequestButton : requestAction?
    var AllowtocancelMTRequest : Int?

    @IBOutlet weak var heightCancel: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMembershipType.delegate = self
        tblMembershipType.dataSource = self
        self.navigationItem.title = self.appDelegate.masterLabeling.DUES_RENEWAL_UPDATE_MEMBERSHIP_TYPE_TITLE
        btnSave.setStyle(style: .outlined, type: .primary, cornerRadius: self.btnSave.frame.height/2)
        btnCancel.setStyle(style: .outlined, type: .primary, cornerRadius: self.btnCancel.frame.height/2)
        btnCancelPendingrequest.setStyle(style: .outlined, type: .primary, cornerRadius: self.btnCancelPendingrequest.frame.height/2)
        registerNibs()
        if AllowtocancelMTRequest == 1{
            btnCancelPendingrequest.isHidden = false
            heightBottom.constant = 128
            heightCancel.constant = 40
        }
        else{
            btnCancelPendingrequest.isHidden = true
            heightBottom.constant = 85
            heightCancel.constant = 0
        }
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        membershipTypeList()
    }
    
    //MARK:- register Nib
    func registerNibs(){
        let menuNib = UINib(nibName: "EditMembershipTypeTableViewCell" , bundle: nil)
        self.tblMembershipType.register(menuNib, forCellReuseIdentifier: "EditMembershipTypeTableViewCell")
        self.tblMembershipType.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: - IBActions
    @IBAction func btnCancelPendingRequest(_ sender: Any) {
        actionrequestButton = .cancel
        SavemembershipTypeList()
    }
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        UserDefaults.standard.removeObject(forKey: "selectedCell")
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSave(_ sender: Any) {
        actionrequestButton = .save
        if selectedMemberShip != nil && selectedMemberShip != ""{
            SavemembershipTypeList()
        }
        else{
            SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.PLEASE_SELECT_TYPE_MESSAGE, withDuration: Duration.kMediumDuration)
        }
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - TableView Methods
extension EditMembershipTypeVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMembershipType.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblMembershipType.dequeueReusableCell(withIdentifier: "EditMembershipTypeTableViewCell", for: indexPath) as! EditMembershipTypeTableViewCell
        let notifyobj: MembershipTypeData
        if arrMembershipType.count != 0{
            notifyobj = arrMembershipType[indexPath.row]
            cell.lblMembershipType.text =  notifyobj.Text
            cell.lblMembershipDescription.text =  notifyobj.Description
            let color = UIColor(hexString: notifyobj.ColorCode)
            cell.ViewBack.layer.backgroundColor = color.cgColor
            if expandedIndexSet.contains(indexPath.row) {
                cell.lblMembershipDescription.isHidden = false
                cell.imgExpand.image = #imageLiteral(resourceName: "icon-tickMark-dark")
                cell.ViewBack.layer.borderColor = UIColor(red: 23/255, green: 70/255, blue: 76/255, alpha: 1).cgColor
                cell.ViewBack.layer.borderWidth = 1
            }
            else{
                cell.lblMembershipDescription.isHidden = true
                cell.imgExpand.image = #imageLiteral(resourceName: "dues-icon-expand")
                cell.ViewBack.layer.backgroundColor = color.cgColor
               cell.ViewBack.layer.borderWidth = 0
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let memberobj = arrMembershipType[indexPath.row]
        if(expandedIndexSet.contains(indexPath.row)){
            expandedIndexSet.remove(indexPath.row)
            selectedMemberShip = ""
        } else {
            expandedIndexSet = []
            expandedIndexSet.insert(indexPath.row)
            selectedMemberShip =  memberobj.Value
        }
        tblMembershipType.reloadData()
    }
}

// MARK: - API Calling
extension EditMembershipTypeVC{
    //MARK:- Membershiptype Api
    func membershipTypeList(){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kIsAdmin: "0",
                APIKeys.kUserID: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kusername: UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                APIKeys.kRole: "Full Access",
                APIKeys.kCategory: "MemberShipType"
            ]
            APIHandler.sharedInstance.getMembershipListing(paramater: paramaterDict, onSuccess: { membershipList in
                self.appDelegate.hideIndicator()
                self.arrMembershipType.removeAll()
                if(membershipList.MembershipType == nil){
                    self.appDelegate.hideIndicator()
                    self.tblMembershipType.setEmptyMessage(InternetMessge.kNoData)
                }
                else{
                    self.arrMembershipType = membershipList.MembershipType!
                    if(self.arrMembershipType.count == 0)
                    {
                        self.appDelegate.hideIndicator()
                        self.tblMembershipType.setEmptyMessage(InternetMessge.kNoData)
                    }else{
                        self.tblMembershipType.restore()
                        self.arrMembershipType = membershipList.MembershipType!
                        self.appDelegate.hideIndicator()
                    }
                }
                self.tblMembershipType.reloadData()
            },onFailure: { error  in
                print(error)
                self.appDelegate.hideIndicator()
                SharedUtlity.sharedHelper().showToast(on:
                                                        self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }else{
            //    self.tableView.setEmptyMessage(InternetMessge.kInternet_not_available)
            
            SharedUtlity.sharedHelper().showToast(on:
                                                    self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
    
    func SavemembershipTypeList(){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            var paramaterDict:[String: Any]?
            paramaterDict = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kIsAdmin: "0",
                APIKeys.kUserID: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kusername: UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                APIKeys.kRole: "Full Access",
                APIKeys.kCategory: "MemberShipType"
            ] as [String : Any]
            if actionrequestButton == .save{
                paramaterDict?["NewBaseMemberTypeID"] = selectedMemberShip ?? ""
            }
            
            APIHandler.sharedInstance.saveMembershipListing(paramater: paramaterDict, onSuccess: { membershipSavedData in
                self.appDelegate.hideIndicator()
                if let thankyouMembershipViewController = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ThankYouMemberShipVC") as? ThankYouMemberShipVC {

                if membershipSavedData.IsMTAutoApproved == 0{
                        if self.actionrequestButton == .cancel{
                            thankyouMembershipViewController.thankYouDesc = self.appDelegate.masterLabeling.DUES_RENEWAL_MEMBERSHIP_TYPE_CANCELLED_MESSAGE
                        }
                        else if self.actionrequestButton == .save{
                            thankyouMembershipViewController.thankYouDesc = self.appDelegate.masterLabeling.DUES_RENEWAL_MEMBERSHIP_TYPE_UPDATE_REQUEST_MESSAGE
                        }
                    }
                
                else{
                    if let thankyouMembershipViewController = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ThankYouMemberShipVC") as? ThankYouMemberShipVC {
                        if self.actionrequestButton == .cancel{
                            thankyouMembershipViewController.thankYouDesc = self.appDelegate.masterLabeling.DUES_RENEWAL_MEMBERSHIP_TYPE_CANCELLED_MESSAGE
                        }
                        else if self.actionrequestButton == .save{
                            thankyouMembershipViewController.thankYouDesc = self.appDelegate.masterLabeling.AUTO_APPROVED_MESSAGE
                            thankyouMembershipViewController.modalPresentationStyle = .fullScreen
                        }
                    }}
                    self.present(thankyouMembershipViewController, animated: true, completion: nil)
                }
            },onFailure: { error  in
                print(error)
                self.appDelegate.hideIndicator()
                SharedUtlity.sharedHelper().showToast(on:
                                                        self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }else{
            SharedUtlity.sharedHelper().showToast(on:
                                                    self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
}
