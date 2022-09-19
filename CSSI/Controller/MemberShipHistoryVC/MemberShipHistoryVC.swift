//
//  MemberShipHistoryVC.swift
//  CSSI
//
//  Created by Vishal Pandey on 06/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
import Popover

enum typeRequestBillOrMember{
    case Membership,Billing
}
class MemberShipHistoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource,selectedHistoryFilter {
    func selectedFilterHistory(type: String) {
        filterTapped = true
        filteredValue = type
        arrMembershipHistory = []
        membershipHistoryList()
    }
    
  
    
    @IBOutlet weak var tblMemHistory:UITableView!
    @IBOutlet weak var btnClose:UIButton!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrMembershipHistory = [MembershipHistoryData]()
    var arrForFilterOption : [statusListing]?
    var typeOfHistory : typeRequestBillOrMember?
    var categoryHistory : String?
    var filterBarButtonItem: UIBarButtonItem!
    var filterTapped: Bool?
    var filteredValue : String?
    var filterPopover: Popover? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        tblMemHistory.delegate = self
        tblMemHistory.dataSource  = self
        btnClose.layer.cornerRadius = btnClose.bounds.size.height / 2
        btnClose.layer.borderWidth = 1.0
        btnClose.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
        self.btnClose.setStyle(style: .outlined, type: .primary)
        
        if typeOfHistory == .Membership{
            self.navigationItem.title = self.appDelegate.masterLabeling.DUES_RENEWAL_MEMBERSHIP_TYPE_HISTORY_TITLE
        }
        else if typeOfHistory == .Billing{
            self.navigationItem.title = self.appDelegate.masterLabeling.DUES_RENEWAL_BILLING_FREQUENCY_HISTORY_TITLE
        }

        registerNibs()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        if typeOfHistory == .Membership{
            categoryHistory = "MemberShipType"
        }
        else if typeOfHistory == .Billing{
            categoryHistory = "BillingFrequncy"
        }
        membershipHistoryList()

    }
    
    func registerNibs(){
            let homeNib = UINib(nibName: "MembershipHistoryCell" , bundle: nil)
           self.tblMemHistory.register(homeNib, forCellReuseIdentifier: "MembershipHistoryCell")
       }
    
    
    // MARK: - IBActions
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func closeBtnTapped(sender:UIButton){
//        btnClose.layer.borderColor = UIColor(red: 27/255, green: 202/255, blue: 255/255, alpha: 1).cgColor
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMembershipHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblMemHistory.dequeueReusableCell(withIdentifier: "MembershipHistoryCell", for: indexPath) as! MembershipHistoryCell
        let historyobj: MembershipHistoryData
        if arrMembershipHistory.count != 0{
            historyobj = arrMembershipHistory[indexPath.row]
            cell.viewReason.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor
            cell.viewReason.layer.borderWidth = 1

            if typeOfHistory == .Membership{
                cell.currentMemTypeHeadingLbl.text = "\(self.appDelegate.masterLabeling.OLD_MEMBERSHIP_TYPE_TITLE ?? ""):"
                cell.newMemTypeHeadingLbl.text = "\(self.appDelegate.masterLabeling.NEW_MEMBERSHIP_TYPE_TITLE ?? ""):"
            cell.currentMemTypeLbl.text =  historyobj.OldMembershipType
            cell.newMemTypeLbl.text =  historyobj.NewMembershipType
            }
            else if typeOfHistory == .Billing{
                cell.currentMemTypeHeadingLbl.text = "\(self.appDelegate.masterLabeling.CURRENT_MEM_TYPE_TITLE ?? ""):"
                cell.newMemTypeHeadingLbl.text = "\(self.appDelegate.masterLabeling.NEW_MEM_TYPE_TITLE ?? ""):"
                cell.currentMemTypeLbl.text =  historyobj.OldBilingFrequency
                cell.newMemTypeLbl.text =  historyobj.NewBilingFrequency
            }
            
            cell.requestedOnHeadingLbl.text = "\(self.appDelegate.masterLabeling.REQUESTED_ON_TITLE ?? ""):"
            cell.statusHeadingLbl.text = "\(self.appDelegate.masterLabeling.STATUS_TYPE_TITLE ?? ""):"
            cell.reasonHeadingLbl.text = "\(self.appDelegate.masterLabeling.COMMENT_TITLE ?? ""):"
            cell.requestedOnLbl.text = historyobj.RequestedOn
            cell.statusLbl.text = historyobj.Status
            cell.reasonLbl.text = historyobj.Comment
            if historyobj.Status == "Pending"{
                cell.statusLbl.backgroundColor = UIColor(red: 247/255, green: 140/255, blue: 37/255, alpha: 1)
            }
            else if  historyobj.Status == "Approved"{
                cell.statusLbl.backgroundColor = UIColor(red: 47/255, green: 140/255, blue: 7/255, alpha: 1)

            }
            else{
                cell.statusLbl.backgroundColor = UIColor(hexString: "FF3B30")
            }
            if historyobj.Status == "Pending" || historyobj.Status == "Approved"{
                cell.viewReasonBack.isHidden = true
              
            }
            else{
               cell.viewReasonBack.isHidden = false
            }
            
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - API CALLING
extension MemberShipHistoryVC{
    func membershipHistoryList(){
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
                APIKeys.kCategory: categoryHistory ?? ""
                
                ]
            if filterTapped == true{
                if typeOfHistory == .Membership{
                    paramaterDict?["MembershipStatus"] = filteredValue
                    
                }
                else{
                    paramaterDict?["BillingStatus"] = filteredValue

                }
            }
            
            APIHandler.sharedInstance.MembershipHistoryListing(paramater: paramaterDict, onSuccess: { membershipHistory in
                self.appDelegate.hideIndicator()
                self.arrMembershipHistory.removeAll()
                if self.typeOfHistory == .Membership{
                if(membershipHistory.MembershipTypeHistory == nil){
                        self.appDelegate.hideIndicator()
                        self.tblMemHistory.setEmptyMessage(InternetMessge.kNoData)
                    }
                    else{
                        
                        self.arrMembershipHistory = membershipHistory.MembershipTypeHistory!
                        if(self.arrMembershipHistory.count == 0)
                        {
                            self.appDelegate.hideIndicator()
                            self.tblMemHistory.setEmptyMessage(InternetMessge.kNoData)
                        }else{
                            self.tblMemHistory.restore()
                            self.arrMembershipHistory = membershipHistory.MembershipTypeHistory!
                            self.appDelegate.hideIndicator()
                        }
                        self.arrForFilterOption = membershipHistory.MembershipStatusList
                        if self.arrForFilterOption?.count != 0{
                            self.navigationItem.rightBarButtonItem = self.filterBarButtonItem;
                            self.filterBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Filter"), style: .plain, target: self, action: #selector(self.onTapFilter))
                            self.navigationItem.rightBarButtonItem = self.filterBarButtonItem

                        }
                        
                    }
            }
                else if self.typeOfHistory == .Billing{
                    if(membershipHistory.BillingFrequncyHistory == nil){
                            self.appDelegate.hideIndicator()
                            
                            self.tblMemHistory.setEmptyMessage(InternetMessge.kNoData)
                        }
                        else{
                            
                            self.arrMembershipHistory = membershipHistory.BillingFrequncyHistory!
                            if(self.arrMembershipHistory.count == 0)
                            {
                                self.appDelegate.hideIndicator()
                                self.tblMemHistory.setEmptyMessage(InternetMessge.kNoData)
                            }else{
                                self.tblMemHistory.restore()
                                self.arrMembershipHistory = membershipHistory.BillingFrequncyHistory!
                                self.appDelegate.hideIndicator()
                            }
                            self.arrForFilterOption = membershipHistory.BillingStatusList
                            if self.arrForFilterOption?.count != 0{
                                self.navigationItem.rightBarButtonItem = self.filterBarButtonItem;
                                self.filterBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Filter"), style: .plain, target: self, action: #selector(self.onTapFilter))
                                self.navigationItem.rightBarButtonItem = self.filterBarButtonItem

                            }
                        }
                }
                self.tblMemHistory.reloadData()
                
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


extension MemberShipHistoryVC
{
    @objc private func onTapFilter()
    {
        guard let filterView = UINib(nibName: "MembershiphHistoryFilterPopUpView", bundle: Bundle.main).instantiate(withOwner: MembershiphHistoryFilterPopUpView.self, options: nil).first as? MembershiphHistoryFilterPopUpView else
        {
            return
        }
        
        let screenSize = UIScreen.main.bounds
        filterView.frame = CGRect(x:4, y: 88, width:screenSize.width - 8, height:250)
        filterPopover = Popover()
        filterPopover?.arrowSize = CGSize(width: 28.0, height: 13.0)
        filterPopover?.sideEdge = 4.0
        filterView.arrForFilterOption = arrForFilterOption
        filterView.delegateHistoryFilter = self
        filterView.delegate = self
        let point = CGPoint(x: self.view.bounds.width - 35, y: 70)
        filterPopover?.show(filterView, point: point)
    }
}
extension MemberShipHistoryVC : GuestListFilterViewDelegate {
    func guestCardFilterApply(filter: GuestCardFilter) {
    }
    
    func guestCardFilterClose() {
        filterPopover?.dismiss()
    }
}
