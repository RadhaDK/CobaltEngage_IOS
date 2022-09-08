//
//  MemberShipHistoryVC.swift
//  CSSI
//
//  Created by Vishal Pandey on 06/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class MemberShipHistoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    
    @IBOutlet weak var tblMemHistory:UITableView!
    @IBOutlet weak var btnClose:UIButton!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrMembershipHistory = [MembershipHistoryData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tblMemHistory.delegate = self
        tblMemHistory.dataSource  = self
        btnClose.layer.cornerRadius = 15
        btnClose.layer.borderWidth = 1
        btnClose.layer.borderColor = UIColor(red: 27/255, green: 202/255, blue: 255/255, alpha: 1).cgColor
        registerNibs()
        // Do any additional setup after loading the view.
        membershipHistoryList()
    }
    
    func registerNibs(){
            let homeNib = UINib(nibName: "MembershipHistoryCell" , bundle: nil)
           self.tblMemHistory.register(homeNib, forCellReuseIdentifier: "MembershipHistoryCell")
       }
    
    @IBAction func closeBtnTapped(sender:UIButton){
//        btnClose.layer.borderColor = UIColor(red: 27/255, green: 202/255, blue: 255/255, alpha: 1).cgColor
        self.dismiss(animated: true, completion: nil)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMembershipHistory.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblMemHistory.dequeueReusableCell(withIdentifier: "MembershipHistoryCell", for: indexPath) as! MembershipHistoryCell
        let historyobj: MembershipHistoryData
        if arrMembershipHistory.count != 0{
            historyobj = arrMembershipHistory[indexPath.row]
            cell.currentMemTypeLbl.text =  historyobj.OldMembershipType
            cell.newMemTypeLbl.text =  historyobj.NewMembershipType
            cell.requestedOnLbl.text = historyobj.RequestedOn
            cell.statusLbl.text = historyobj.Status
            cell.reasonLbl.text = historyobj.Comment
//            if historyobj.Status == "Pending"{
//                cell.sta.isHidden = true
//            }
//            else if historyobj.Status == "Approved"{
//                cell.reasonHeadingLbl.isHidden = false
//            }
//            else{
//                cell.statusLbl.backgroundColor = co
//            }
            
            if historyobj.Status == "Pending" || historyobj.Status == "Approved"{
                cell.reasonHeadingLbl.isHidden = true
            }
            else{
                cell.reasonHeadingLbl.isHidden = false
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
  
    
}
extension MemberShipHistoryVC{
    func membershipHistoryList(){
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
            
            
            APIHandler.sharedInstance.MembershipHistoryListing(paramater: paramaterDict, onSuccess: { membershipHistory in
                self.appDelegate.hideIndicator()

                self.arrMembershipHistory.removeAll()
                if(membershipHistory.MembershipTypeHistory == nil){
                        self.appDelegate.hideIndicator()
                        
                        self.tblMemHistory.setEmptyMessage(InternetMessge.kNoData)
                    }
                    else{
                        
                        self.arrMembershipHistory = membershipHistory.MembershipTypeHistory!
                        if(self.arrMembershipHistory.count == 0)
                        {
                            self.appDelegate.hideIndicator()
                            self.tblMemHistory.setEmptyMessage("No new notification")
                        }else{
                            self.tblMemHistory.restore()
                            self.arrMembershipHistory = membershipHistory.MembershipTypeHistory!
                            self.appDelegate.hideIndicator()
                        }
                    }
                self.tblMemHistory.reloadData()
//                }else{
//                    self.appDelegate.hideIndicator()
//                    if(((notificationList.responseMessage?.count) ?? 0)>0){
//                        SharedUtlity.sharedHelper().showToast(on:
//                            self.view, withMeassge: notificationList.responseMessage, withDuration: Duration.kMediumDuration)
//                    }
//                }
//
                
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
}
