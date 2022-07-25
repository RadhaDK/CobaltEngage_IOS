//
//  UpcomingTeeTimesVC.swift
//  CSSI
//
//  Created by apple on 4/18/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class UpcomingTeeTimesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var upcomingTableview: UITableView!
    @IBOutlet weak var uiScrollview: UIScrollView!
    @IBOutlet weak var lblupcomingteeTimes: UILabel!
    var Title: String?
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrTeeTimes = [TeeTimes]()
    var memberType: String?
    var memberID: String?
    
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
        uiScrollview.isScrollEnabled = false
        if memberType == "Guest"{
            self.upcomingTableview.setEmptyMessage(InternetMessge.kNoData)

        }else{
        self.getUpcomingTeeTimes()
        }
       self.lblupcomingteeTimes.text = title
        self.upcomingTableview.showsVerticalScrollIndicator = false
    }
    
    //MARK:- Get Upcoming Golf Details  Api

    
    func getUpcomingTeeTimes() {
        
        if (Network.reachability?.isReachable) == true{
           
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: memberID ?? "",
                APIKeys.ksearchby: "",
                APIKeys.kCategory: self.appDelegate.typeOfCalendar,
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            
            print(paramaterDict)
            
            APIHandler.sharedInstance.getUpcomingTeeTimes(paramaterDict: paramaterDict, onSuccess: { upcomingTeeTimesList in
                self.appDelegate.hideIndicator()
                
                if(upcomingTeeTimesList.responseCode == InternetMessge.kSuccess)
                {
                    if(upcomingTeeTimesList.upComingTeeTimes == nil){
                        self.arrTeeTimes.removeAll()
                        //                        self.tablePlayHistory.setEmptyMessage(InternetMessge.kNoData)
                        self.upcomingTableview.reloadData()
                        self.appDelegate.hideIndicator()
                        self.upcomingTableview.setEmptyMessage(InternetMessge.kNoData)

                    }
                    else{
                        
                        if(upcomingTeeTimesList.upComingTeeTimes?.count == 0)
                        {
                            self.arrTeeTimes.removeAll()
                            //                            self.tablePlayHistory.setEmptyMessage(InternetMessge.kNoData)
                            self.upcomingTableview.reloadData()
                            
                            self.upcomingTableview.setEmptyMessage(InternetMessge.kNoData)

                            self.appDelegate.hideIndicator()
                            
                        }else{
                            //                            self.tablePlayHistory.restore()
                            self.arrTeeTimes = upcomingTeeTimesList.upComingTeeTimes!  //playHistoryList.listevents!
                            self.upcomingTableview.reloadData()
                        }
                        
                    }
                    
                    if(!(self.arrTeeTimes.count == 0)){
                       // let indexPath = IndexPath(row: 0, section: 0)
                        // self.tablePlayHistory.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((upcomingTeeTimesList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: upcomingTeeTimesList.responseMessage, withDuration: Duration.kMediumDuration)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTeeTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingCell") as! UpComingTeeTimesCustomCell
            cell.lblDate.text = self.arrTeeTimes[indexPath.row].confirmationNumber ?? ""
            cell.lblTime.text = String(format: "%@ - %@",self.arrTeeTimes[indexPath.row].date!,self.arrTeeTimes[indexPath.row].time!)
        
        if(self.appDelegate.typeOfCalendar == "Tennis"){
            cell.lblNoPlayers.isHidden = true
            cell.lblGroupText.isHidden = true
            cell.lblTennisType.isHidden = false
            cell.lblTennisType.text = self.arrTeeTimes[indexPath.row].tennisGameType
        }
        else if(self.appDelegate.typeOfCalendar == "Dining"){
            cell.lblGroupText.text = "Reservation"
            cell.lblNoPlayers.text = self.arrTeeTimes[indexPath.row].diningName
            cell.lblTennisType.isHidden = true
            cell.lblNoPlayers.isHidden = false
            cell.lblGroupText.isHidden = false
        }
        else{
            cell.lblGroupText.text = self.arrTeeTimes[indexPath.row].golfName
            cell.lblNoPlayers.text = self.arrTeeTimes[indexPath.row].playersCount
            cell.lblTennisType.isHidden = true
            cell.lblNoPlayers.isHidden = false
            cell.lblGroupText.isHidden = false
        }
        return cell
    }
    

    @IBAction func closeClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
}
