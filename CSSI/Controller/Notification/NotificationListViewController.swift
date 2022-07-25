
import UIKit
import Alamofire
class NotificationListViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchbarView: UIView!
    @IBOutlet weak var notificationSearch: UISearchBar!
    var arrNotifications = [NotificationsData]()
    
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setColorCode()
        self.initController()
        
        // Do any additional setup after loading the view.
        //        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine;
        notificationSearch.delegate = self
        notificationSearch.searchBarStyle = .default
        
        notificationSearch.layer.borderWidth = 1
        notificationSearch.layer.borderColor = hexStringToUIColor(hex: "F5F5F5").cgColor
        notificationSearch.placeholder = self.appDelegate.masterLabeling.search_Notifications ?? "" as String


        searchbarView.layer.shadowColor = hexStringToUIColor(hex: "C1C1C1").cgColor
        searchbarView.layer.shadowOpacity = 0.3
        searchbarView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        searchbarView.layer.shadowRadius = 0.6
        searchbarView.layer.masksToBounds = false
        
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true

        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
        
    }
    func initController()
    {
        self.tableView.estimatedRowHeight = 64
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorInset = .zero
        self.tableView.layoutMargins = .zero
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorColor = APPColor.celldividercolor.divider
        
        self.tableView.tableFooterView = UIView.init()
        self.tableView.allowsSelection = true
        
        
        self.notificationDetails(strSearch: self.notificationSearch.text!)
        self.tableView.reloadData()
//        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
        
        self.navigationController?.navigationBar.isHidden = false
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.backItem?.title = self.appDelegate.masterLabeling.bACK
        self.navigationController?.navigationBar.topItem?.title = self.appDelegate.masterLabeling.bACK
        
        self.navigationItem.title = self.appDelegate.masterLabeling.tT_NOTIFICATIONS
        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg
        self.tableView.backgroundColor = APPColor.viewBackgroundColor.viewbg
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
//        navigationController!.interactivePopGestureRecognizer!.isEnabled = false
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.notificationDetails(strSearch: self.notificationSearch.text!)

    }
    
    //Added by Kiran V2.5 --GATHER0000441-- Notifications not removing from system tray when opened from app
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
//            self.navigationController?.setNavigationBarHidden(true, animated: animated)
//            self.navigationController?.navigationBar.isHidden = true
       

        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
  
    //Mark- Common Color Code
    func setColorCode()
    {
        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {

        if let notificationDetail = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "NotificationDetailsVC") as? NotificationDetailVC
        {
            
            let notifyobj: NotificationsData
            notifyobj = arrNotifications[indexPath.row]
            
            notificationDetail.notificationSubject = notifyobj.messageHeader
            notificationDetail.notificationText = notifyobj.message
            notificationDetail.notificationID = notifyobj.notificationDetailID
    
            //Added by Kiran V2.5 --GATHER0000441-- Notifications not removing from system tray when opened from app
            notificationDetail.isRead = notifyobj.isRead == 1
            
            //self.appDelegate.myValue = notifyobj.notificationText!
            
            //self.notificationDetails(strSearch: self.notificationSearch.text!)
            self.navigationController?.pushViewController(notificationDetail, animated: true)
        }
        
    }
    
    
    //MARK:- Tableview Delegate & Datasource methods    
    //the method returning size of the list
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrNotifications.count
    }
    
    
    //the method returning each cell of the list
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "NotificationListTableViewCell", for: indexPath) as! NotificationListTableViewCell
        
        //getting the hero for the specified position
        let notifyobj: NotificationsData
        notifyobj = arrNotifications[indexPath.row]
        //   let trimmedString = hero.bio!.trimmingCharacters(in: .whitespacesAndNewlines)
        //   print(trimmedString)
        
        //displaying values
        //   cell.lblNotificationdetails.text = trimmedString
        //cell.eventdesc.text = hero.team
        //        cell.lblNotificationDate.text = hero.team
        
        cell.selectionStyle = .none
        
        cell.lblNotificationdetails.text = notifyobj.messageHeader
        cell.lblNotificationDate.text = notifyobj.notificationDate
        
        cell.lblColor.layer.cornerRadius = cell.lblColor.frame.size.width / 2
        cell.lblColor.layer.masksToBounds = true
        cell.lblColor.backgroundColor = hexStringToUIColor(hex: self.appDelegate.masterLabeling.nOTIFICATION_READ_COLOR ?? "")

        if(notifyobj.isRead == 1)
        {
           cell.lblColor.isHidden = true
        }else{
           cell.lblColor.isHidden = false
        }
        cell.lblNotificationDate.textColor = APPColor.MainColours.primary2
        
        return cell
    }
    
    //MARK:- Notification Details Api
    func notificationDetails(strSearch :String?){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                "USERID": UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                "Modulekey":"MB",
                "SearchText": self.notificationSearch.text ?? ""
                
                ]
            
            
            APIHandler.sharedInstance.getNotificationDetails(paramater: paramaterDict, onSuccess: { notificationList in
                self.appDelegate.hideIndicator()

                self.arrNotifications.removeAll()
                    if(notificationList.data == nil){
                        self.appDelegate.hideIndicator()
                        
                        self.tableView.setEmptyMessage(InternetMessge.kNoData)
                    }
                    else{
                        
                        self.arrNotifications = notificationList.data!
                        if(self.arrNotifications.count == 0)
                        {
                            self.appDelegate.hideIndicator()
                            self.tableView.setEmptyMessage("No new notification")
                        }else{
                            self.tableView.restore()
                            self.arrNotifications = notificationList.data!
                            self.appDelegate.hideIndicator()
                        }
                    }
                self.tableView.reloadData()
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
    
    func setCardView(view : UIView){
        
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = 1;
        view.layer.shadowRadius = 2;
        view.layer.shadowOpacity = 0.5;
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        notificationSearch.resignFirstResponder()
        self.notificationDetails(strSearch: notificationSearch.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            
            self.notificationDetails(strSearch: notificationSearch.text!)

        }
        
    }
    
    
    
    
    
    
}
