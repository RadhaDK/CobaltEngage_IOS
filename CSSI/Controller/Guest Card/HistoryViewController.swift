//
//  HistoryViewController.swift
//  CSSI
//
//  Created by Apple on 29/09/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var historyTableview: UITableView!
    
    @IBOutlet weak var btnGuestPolicy: UIButton!
    @IBOutlet weak var lblBottom: UILabel!
    let cellReuseIdentifier = "MutlipleSelectionID"
    var guests: [Guest]? = nil
    var historyDetails: GuestCardsHistoryResponse? = nil
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
    //ENGAGE0011898 -- Start
    var policyURL : String?
    var PDFTitle : String?
    //ENGAGE0011898 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Commented by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        //self.navigationItem.title = self.appDelegate.masterLabeling.guest_Card_History ?? "" as String
        //ENGAGE0011898 -- End
        
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
        //ENGAGE0011297 -- Start
//        let backButton = UIBarButtonItem()
//
//        backButton.title = self.appDelegate.masterLabeling.bACK ?? "" as String
//
//        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
        //ENGAGE0011297 -- End

        loadHistory()
        
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
        btnGuestPolicy .setTitle(self.appDelegate.masterLabeling.guest_Card_Policy_Title, for: .normal)

        
        self.lblBottom.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)

        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
    //ENGAGE0011297 -- Start
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        self.navigationItem.title = self.appDelegate.masterLabeling.guest_Card_History ?? "" as String
        //ENGAGE0011898 -- End
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
       
    }
    
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    //ENGAGE0011297 -- End
    
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    func loadHistory() {
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        let guestIds = guests?.map { $0.guestID } ?? []

        let params: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            "GuestID" : "",
            "AllGuestID" : guestIds
        ]
        
        APIHandler.sharedInstance.getHistory(paramater: params, onSuccess: { (response) in
            self.appDelegate.hideIndicator()
            self.historyDetails = response
            if response.guests.count == 0 {
                let label = UILabel(frame: self.historyTableview.bounds)
                label.text = self.appDelegate.masterLabeling.no_Record_Found
                label.textAlignment = .center
                self.historyTableview.backgroundView = label
            } else {
                self.historyTableview.reloadData()
            }
            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            self.appDelegate.hideIndicator()
        }
    }
    @IBAction func guestPolicyClicked(_ sender: Any)
    {
        //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        CustomFunctions.shared.showPDFWith(url: self.policyURL ?? "", title: self.PDFTitle ?? "", navigationController: self.navigationController)
        //Old Logic
        /*
        if let guestPolicy = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "GuestCardPolicyVC") as? GuestCardPolicyVC {
            self.appDelegate.hideIndicator()
            
            self.present(guestPolicy, animated: true, completion: nil)
        }*/
        //ENGAGE0011898 -- End
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return historyDetails?.guests.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyDetails?.guests[section].guestCardDetails.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CustomMultipleSelectionCell = self.historyTableview.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CustomMultipleSelectionCell
        if let cardHistory = historyDetails?.guests[indexPath.section].guestCardDetails[indexPath.row]
            {
            
                cell.lblDateRange.text = "\(cardHistory.fromDate) - \(cardHistory.toDate)"
                
                if(cardHistory.days == 1){
                    cell.lbldays.text = String(format: "%d %@", cardHistory.days,self.appDelegate.masterLabeling.day ?? "" as String)

                }
                else{
                cell.lbldays.text = String(format: "%d %@", cardHistory.days,self.appDelegate.masterLabeling.days ?? "" as String)
                }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 142
    }
    //44
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HeaderTableView", owner: self, options: nil)?.first as! HeaderTableView
        if let guestBasicInfo = historyDetails?.guests[section] {
            headerView.lblGuestName.text = guestBasicInfo.memberName
            headerView.guestID.text = "\(guestBasicInfo.guestMemberID)"
            headerView.lblTotalDays.text = self.appDelegate.masterLabeling.total_days ?? "" as String
            headerView.daysVisited.text = self.appDelegate.masterLabeling.days_visited ?? "" as String
            if guestBasicInfo.guestCardDetails.count != 0{
            headerView.lblDaterange.text = "\(guestBasicInfo.guestCardDetails[0].fromDate) - \(guestBasicInfo.guestCardDetails[0].toDate)"
            }
            let placeholder:UIImage = UIImage(named: "avtar")!

            //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
            //ENGAGE0011419 -- Start
            
            let imageURLString = guestBasicInfo.guestPhoto
            
            if imageURLString.isValidURL()
            {
                let url = URL.init(string:imageURLString)
               headerView.imgImage.sd_setImage(with: url , placeholderImage: placeholder)
            }
            else
            {
                headerView.imgImage.image = UIImage(named: "avtar")!
            }
            /*
            if(imageURLString.count>0){
                let validUrl = self.verifyUrl(urlString: imageURLString)
                if(validUrl == true){
                    let url = URL.init(string:imageURLString)
                   headerView.imgImage.sd_setImage(with: url , placeholderImage: placeholder)
                }
            }
            else{
                //   let url = URL.init(string:imageURLString)
                headerView.imgImage.image = UIImage(named: "avtar")!
            }
            */
            //ENGAGE0011419 -- End
        }

        return headerView
        
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
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 58
    }
    //44
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("FooterTableViewCell", owner: self, options: nil)?.first as! FooterTableViewCell
        if let guestCardHistory = historyDetails?.guests[section].guestCardDetails {
           // headerView.lblTotalDays.text = "\((guestCardHistory.map({$0.days}).reduce(0, +)) + (self.appDelegate.masterLabeling.days))"
            headerView.lblTotalDays.text = String(format: "%d %@", guestCardHistory.map({$0.days}).reduce(0, +),self.appDelegate.masterLabeling.days ?? "" as String)
        }
        
        return headerView
        
}
}
