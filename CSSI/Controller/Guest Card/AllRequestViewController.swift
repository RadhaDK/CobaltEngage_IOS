//
//  AllRequestViewController.swift
//  CSSI
//
//  Created by MACMINI13 on 26/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class AllRequestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

   
    @IBOutlet weak var tblAllRequest: UITableView!
     var arrGuestCardRequest = [AllGuestCardRequestInfo]()
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var refreshControl = UIRefreshControl()
    var strarrived = String()
    var strdeparted = String()


    
    
    //the method returning each cell of the list
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllRequestTableViewCell", for: indexPath) as! AllRequestTableViewCell
        cell.backgroundColor = APPColor.viewBgColor.viewbg
        let guestcardinfo: AllGuestCardRequestInfo
        guestcardinfo = arrGuestCardRequest[indexPath.row]
        cell.lblGuestName.font = SFont.SourceSansPro_Semibold16
        cell.lblGuestName.textColor = APPColor.textColor.text
        cell.lblGuestName.text = guestcardinfo.firstName! + " " + guestcardinfo.lastName!
//        if(guestcardinfo.status == CommonString.kpending)
//        {
//            cell.lblGuestStatus.textColor = APPColor.GuestCardstatus.pending
//
//        }else{
//            if(guestcardinfo.status == CommonString.kapproved)
//            {
//                cell.lblGuestStatus.textColor = APPColor.GuestCardstatus.approved
//
//            }
//        }
//
        
        cell.lblGuestdob.font = SFont.SourceSansPro_Regular14
        cell.lblGuestdeparted.font = SFont.SourceSansPro_Regular14
        cell.lblGuestdeparted.textColor = APPColor.solidbgColor.solidbg
        cell.lblGuestdob.textColor = APPColor.solidbgColor.solidbg

    //    cell.lblGuestdob.textColor = hexStringToUIColor(hex: "67aac9")
        cell.lblGuestdob.text = strarrived + guestcardinfo.fromDate!
        cell.lblGuestdeparted.text = strdeparted + guestcardinfo.toDate!



        cell.lblGuestStatus.font = SFont.SourceSansPro_Regular16
       // cell.lblGuestStatus.textColor = hexStringToUIColor(hex: "af192b")
       // cell.lblGuestStatus.text = guestcardinfo.status!
        
        return cell
    }
    
    
    
    func setLocalizedString()
    {
//        let jsonString = DataBaseHandlar.sharedInstance.getLocalizationValues()
//        if ((jsonString == nil) || (jsonString.count<1)) {
//
//        }
//        else{
//
//            let labelling = Labelling(JSONString: jsonString)!
//            print("getLocalizationValues:\(jsonString)")
//
        
            strarrived = (self.appDelegate.masterLabeling.aRRIVED)!
            strdeparted = (self.appDelegate.masterLabeling.dEPARTED)!

            
//        }
    }
    
    
    
    
    //the method returning size of the list
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrGuestCardRequest.count
    }
    
    
    //Mark- Common Color Code
    func commomColorCode()
    {
        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg
    
        
    }
    

    
    override func viewDidLoad() {
            super.viewDidLoad()
        
//         NotificationCenter.default.addObserver(self, selector: #selector(notificationRecevied(notification:)), name: NSNotification.Name(rawValue: "newDataToLoad"), object: nil)
        
        
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isTranslucent = false
        
        self.setLocalizedString()
        self.refreshControls()
        self.commomColorCode()

         self.tblAllRequest.separatorInset = .zero
         self.tblAllRequest.layoutMargins = .zero
         self.tblAllRequest.rowHeight = 90
         self.tblAllRequest.reloadData()
        self.tblAllRequest.allowsSelection = false
        self.tblAllRequest.separatorColor = APPColor.celldividercolor.divider

        self.tblAllRequest.tableFooterView = UIView()

        
        
       getAllGuestCardRequest(strSearch: "")
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     //Mark- Getting all guest request
    func getAllGuestCardRequest(strSearch :String) -> Void {
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.ksearchby: strSearch ,

                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            print(paramaterDict)
            APIHandler.sharedInstance.getAllCardRequests(paramater: paramaterDict, onSuccess: { eventList in
                if(eventList.responseCode == InternetMessge.kSuccess){
               
                    if(eventList.allguestcardList == nil){
                        self.appDelegate.hideIndicator()

                        self.arrGuestCardRequest.removeAll()

                        self.tblAllRequest.setEmptyMessage(InternetMessge.kNoData)
                        self.tblAllRequest.reloadData()


                    }
                    else{
                        if(eventList.allguestcardList?.count == 0)
                        {
                            self.appDelegate.hideIndicator()

                            self.arrGuestCardRequest.removeAll()

                            self.tblAllRequest.setEmptyMessage(InternetMessge.kNoData)
                            self.tblAllRequest.reloadData()

                            
                        }else{
                        self.appDelegate.hideIndicator()
                       // print(eventList.allguestcardList)
                        self.arrGuestCardRequest.removeAll()
                        self.tblAllRequest.restore()
                        self.arrGuestCardRequest = eventList.allguestcardList!//eventList.listevents!
                       // print(self.arrGuestCardRequest.count)
                        self.tblAllRequest.reloadData()
                        }
                    }
                }else{
                    self.appDelegate.hideIndicator()
                    self.refreshControl.endRefreshing()

                    if(((eventList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: eventList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.tblAllRequest.setEmptyMessage(eventList.responseMessage ?? "")

                }
                self.appDelegate.hideIndicator()
            },onFailure: { error  in
                self.refreshControl.endRefreshing()

                self.appDelegate.hideIndicator()
                print(error)
            })
        }
        else{
         //   self.tblAllRequest.setEmptyMessage(InternetMessge.kInternet_not_available)
            self.refreshControl.endRefreshing()

            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kShortDuration)
        }
    }
  
    
    
     //Mark- Refresh Control
    func refreshControls()
    {
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
         self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        self.tblAllRequest.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
          getAllGuestCardRequest(strSearch: "")
          self.refreshControl.endRefreshing()
        
    }
    
    


}
