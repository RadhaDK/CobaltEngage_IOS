//
//  PlayHistoryDetailVC.swift
//  CSSI
//
//  Created by apple on 4/18/19.
//  Copyright © 2019 yujdesigns. All rights reserved.


import UIKit

class PlayHistoryDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var playHistoryTablView: UITableView!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var playHistoryDetails: [PlayHistoryDetail]? = nil
    var historyDetails: PlayHistorydetails? = nil
    var confirmedReservationID : String?
    var arrHistoryDetails = [History]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playHistoryTablView.showsVerticalScrollIndicator = false
        loadPlayHistoryDetails()
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if(arrHistoryDetails.count == 0){
            return 0
        }
        else{
        return arrHistoryDetails.count
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHistoryDetails[section].playerDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:playHistoryDetailCustomCell = self.playHistoryTablView.dequeueReusableCell(withIdentifier: "HistoryCellID") as! playHistoryDetailCustomCell
        
        cell.lblPlayer1Text.text = arrHistoryDetails[indexPath.section].playerDetails?[indexPath.row].player1
        cell.btnPlayed .setTitle(arrHistoryDetails[indexPath.section].playerDetails?[indexPath.row].status, for: UIControlState.normal)
        cell.btnPlayed.backgroundColor = hexStringToUIColor(hex: arrHistoryDetails[indexPath.section].playerDetails?[indexPath.row].statusColor ?? "")
        cell.btnPlayed.layer.cornerRadius = 12
        cell.btnPlayed.layer.masksToBounds = true
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HeaderViewPlayHistory", owner: self, options: nil)?.first as! HeaderViewPlayHistory
        if(section == 0){
            headerView.lblTopLine.isHidden = true
        }
//        if let playHistoryBasicInfo = arrHistoryDetails[section] {
        
        headerView.lblCaptainName.text = String(format: "%@ %@",self.appDelegate.masterLabeling.captain!, arrHistoryDetails[section].captainName ?? "")
        headerView.lblCource.text = String(format: "%@ %@",self.appDelegate.masterLabeling.course_time_colon ?? "",arrHistoryDetails[section].courseName ?? "")
        headerView.lblID.text = arrHistoryDetails[section].confirmNumber
        headerView.lblLength.text = String(format: "%@ %@", self.appDelegate.masterLabeling.round_length ?? "" ,arrHistoryDetails[section].gameType ?? "")
        headerView.lblTeeTimes.text =  String(format: "%@: %@", self.appDelegate.masterLabeling.rEQUESTED_TEETIME ?? "" ,arrHistoryDetails[section].time ?? "")
        headerView.lblGroupNo.text = arrHistoryDetails[section].group
        headerView.lblPlayDate.text = String(format: "Play Date: %@", arrHistoryDetails[section].playDate ?? "")
        headerView.lblConfirmedteeTime.text = String(format: "Confirmed Tee Time: %@", arrHistoryDetails[section].confirmedTeeTime ?? "")
        
            
//        }
        
        return headerView
        
    
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 220
    }
    @IBAction func closeClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    //Mark- Get  Golf Play History Details Api

    func loadPlayHistoryDetails() {

        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                "UserName ": "Admin",
                "IsAdmin ": "1",
                "ConfirmedReservationID": confirmedReservationID ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            
            APIHandler.sharedInstance.getPlayHistoryDetails(paramaterDict: paramaterDict, onSuccess: { (response) in
                
                if(response.responseCode == InternetMessge.kSuccess)
                {
                    if(response.historyList == nil){
                        self.arrHistoryDetails.removeAll()
                        self.playHistoryTablView.reloadData()
                        self.appDelegate.hideIndicator()
                        self.playHistoryTablView.isHidden = true
                        self.playHistoryTablView.setEmptyMessage(InternetMessge.kNoData)

                    }
                    else{
                        
                        if(response.historyList?.count == 0)
                        {
                            self.arrHistoryDetails.removeAll()
                            self.playHistoryTablView.reloadData()
                            self.playHistoryTablView.isHidden = true
                            self.playHistoryTablView.setEmptyMessage(InternetMessge.kNoData)

                            self.appDelegate.hideIndicator()
                            
                            
                            
                            
                        }else{
                            self.playHistoryTablView.isHidden = false
                            self.arrHistoryDetails = response.historyList!
                            self.playHistoryTablView.reloadData()
                            self.appDelegate.hideIndicator()
                            

                        }
                        
                    }
                    
                    if(!(self.arrHistoryDetails.count == 0)){
                        
                    }
                    
                    
                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((response.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: response.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    
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
    
    
    


