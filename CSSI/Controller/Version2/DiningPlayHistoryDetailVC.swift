//
//  DiningPlayHistoryDetailVC.swift
//  CSSI
//
//  Created by apple on 4/30/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class DiningPlayHistoryDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lblConfirmationNumber: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblReservation: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblSpecialRequest: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var lblPartySize: UILabel!
    @IBOutlet weak var lblCaptaine: UILabel!
    @IBOutlet weak var diningTableview: UITableView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblLabel1: UILabel!
    @IBOutlet weak var lblLabel2: UILabel!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var confirmationNumber: String?

    var confirmedReservationID : String?
    var arrHistoryDetails = [History]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        diningTableview.showsVerticalScrollIndicator = false
        loadPlayHistoryDetails()
        self.lblPartySize.textColor = APPColor.MainColours.primary1
        self.lblReservation.textColor = APPColor.MainColours.primary1
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
            tableViewHeight.constant = self.diningTableview.contentSize.height
            viewHeight.constant = 400 + tableViewHeight.constant
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrHistoryDetails.count == 0  {
            return 0
        }
        else{
        return self.arrHistoryDetails[0].playerDetails?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:playHistoryDetailCustomCell = self.diningTableview.dequeueReusableCell(withIdentifier: "HistoryCellID") as! playHistoryDetailCustomCell
       
        cell.lblPlayer1Text.text = arrHistoryDetails[0].playerDetails?[indexPath.row].player1
        cell.btnPlayed.setTitle(arrHistoryDetails[0].playerDetails?[indexPath.row].status, for: UIControlState.normal)
        cell.btnPlayed.backgroundColor = hexStringToUIColor(hex: arrHistoryDetails[indexPath.section].playerDetails?[indexPath.row].statusColor ?? "")

        cell.btnPlayed.layer.cornerRadius = 12
        cell.btnPlayed.layer.masksToBounds = true

       
        
        return cell
    }
  

    @IBAction func closeClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    //Mark- Get  Dining Play History Details Api

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
                        self.diningTableview.reloadData()
                        self.appDelegate.hideIndicator()
                        self.diningTableview.setEmptyMessage(InternetMessge.kNoData)
                        self.lblLabel1.isHidden = true
                        self.lblLabel2.isHidden = true

                    }
                    else{
                        
                        if(response.historyList?.count == 0)
                        {
                            self.arrHistoryDetails.removeAll()
                            self.diningTableview.reloadData()
                            
                            self.diningTableview.setEmptyMessage(InternetMessge.kNoData)
                            self.lblLabel1.isHidden = true
                            self.lblLabel2.isHidden = true

                            self.appDelegate.hideIndicator()
                            
                            
                            
                            
                        }else{
                            self.arrHistoryDetails = response.historyList!
                            self.diningTableview.reloadData()
                            self.lblLabel1.isHidden = false
                            self.lblLabel2.isHidden = false

                            let inputFormatter = DateFormatter()
                            inputFormatter.dateFormat = "MMM dd, yyyy"
                            let showDate = inputFormatter.date(from: self.arrHistoryDetails[0].date!)
                            inputFormatter.dateFormat = "MM/dd/yyyy"
                            let resultString = inputFormatter.string(from: showDate!)
                            
                            self.lblDate.text = resultString
                            self.lblReservation.text = String(format: "Reservation - %@", self.arrHistoryDetails[0].diningName ?? "")
                            self.lblTime.text = self.arrHistoryDetails[0].time
                            
                            //Added by Kiran V2.5 -- ENGAGE0011362 -- Special requests are not displayed
                            //Start -- ENGAGE0011362
                            //self.lblSpecialRequest.text = String(format: "%@ %@",self.appDelegate.masterLabeling.special_request!, self.arrHistoryDetails[0].tablePreferenceName ?? "")
                            self.lblSpecialRequest.text = String(format: "%@ %@",self.appDelegate.masterLabeling.special_request!, self.arrHistoryDetails[0].specialRequest ?? "")
                            //End -- ENGAGE0011362
                            self.lblComments.text = String(format: "%@ %@", self.appDelegate.masterLabeling.cOMMENTS_COLON!,self.arrHistoryDetails[0].comments ?? "")
                            self.lblPartySize.text = String(format: "Party Size (%d)", self.arrHistoryDetails[0].partySize ??  0)
                            self.lblCaptaine.text = String(format: "%@ %@", self.appDelegate.masterLabeling.captain!,self.arrHistoryDetails[0].captainName ?? "")
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
