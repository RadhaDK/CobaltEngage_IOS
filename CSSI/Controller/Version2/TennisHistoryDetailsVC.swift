//
//  TennisHistoryDetailsVC.swift
//  CSSI
//
//  Created by apple on 5/1/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class TennisHistoryDetailsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTypeOfMatch: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblConfirmationNumber: UILabel!
    @IBOutlet weak var lblConfirmedCourtTime: UILabel!
    @IBOutlet weak var lblPartySize: UILabel!
    @IBOutlet weak var lblCaptainName: UILabel!
    @IBOutlet weak var tennisTableView: UITableView!
    @IBOutlet weak var heightTableview: NSLayoutConstraint!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblLabel2: UILabel!
    @IBOutlet weak var lblLabel1: UILabel!
    var confirmedReservationID : String?
    var confirmationNumber: String?
    var arrHistoryDetails = [History]()
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tennisTableView.showsVerticalScrollIndicator = false
        loadPlayHistoryDetails()
        self.lblPartySize.textColor = APPColor.MainColours.primary1
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        heightTableview.constant = self.tennisTableView.contentSize.height
        viewHeight.constant = 400 + heightTableview.constant
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrHistoryDetails.count == 0  {
            return 0
        }
        else{
            return self.arrHistoryDetails[0].playerDetails?.count ?? 0
        }    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:playHistoryDetailCustomCell = self.tennisTableView.dequeueReusableCell(withIdentifier: "HistoryCellID") as! playHistoryDetailCustomCell
        
        cell.lblPlayer1Text.text = arrHistoryDetails[0].playerDetails?[indexPath.row].player1
        cell.btnPlayed.layer.cornerRadius = 12
        cell.btnPlayed.layer.masksToBounds = true
        cell.btnPlayed.setTitle(arrHistoryDetails[0].playerDetails?[indexPath.row].status, for: UIControlState.normal)
        cell.btnPlayed.backgroundColor = hexStringToUIColor(hex: arrHistoryDetails[indexPath.section].playerDetails?[indexPath.row].statusColor ?? "")

        
        return cell
    }
    @IBAction func closeClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    //Mark- Get  Court Play History Details Api

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
                        self.tennisTableView.reloadData()
                        self.appDelegate.hideIndicator()
                        self.tennisTableView.setEmptyMessage(InternetMessge.kNoData)
                        self.lblLabel1.isHidden = true
                        self.lblLabel2.isHidden = true

                    }
                    else{
                        
                        if(response.historyList?.count == 0)
                        {
                            self.arrHistoryDetails.removeAll()
                            self.tennisTableView.reloadData()
                            self.tennisTableView.setEmptyMessage(InternetMessge.kNoData)
                            self.lblLabel1.isHidden = true
                            self.lblLabel2.isHidden = true

                            self.appDelegate.hideIndicator()
                        }else{
                            self.arrHistoryDetails = response.historyList!
                            self.tennisTableView.reloadData()
                            self.appDelegate.hideIndicator()
                            self.lblLabel1.isHidden = false
                            self.lblLabel2.isHidden = false


                            let inputFormatter = DateFormatter()
                            inputFormatter.dateFormat = "MMM dd, yyyy"
                            let showDate = inputFormatter.date(from: self.arrHistoryDetails[0].date!)
                            inputFormatter.dateFormat = "MM/dd/yyyy"
                            let resultString = inputFormatter.string(from: showDate!)
                            
                            self.lblTime.text = resultString
                            self.lblConfirmedCourtTime.text = String(format: "Confirmed Court Time: %@", self.arrHistoryDetails[0].time ?? "")
                            self.lblDuration.text = String(format: "Duration: %@", self.arrHistoryDetails[0].duration ?? "")
                            self.lblTypeOfMatch.text = String(format: "Match: %@", self.arrHistoryDetails[0].match ?? "")
                            self.lblPartySize.text = "Players"
                            self.lblCaptainName.text = String(format: "Captain: %@", self.arrHistoryDetails[0].captainName ?? "")
                            self.lblConfirmationNumber.text = self.confirmationNumber
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
