import UIKit
import Alamofire
import AlamofireImage
import Popover

extension UITableView {
    
    func setEmptyMessage(_ message: String)
    {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = SFont.SourceSansPro_Semibold16
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    //Added by kiran V2.9 -- ENGAGE0011597 -- Adding 2 fields for description and count.
    //ENGAGE0011597 -- Start
    
    //This is causing conflicting constraints as width is being applied by table wihici is not in our control. Even setting translatesAutoresizingMaskIntoConstraints false in tableview, tableview.backgroundView and messageView is not solving this.
    func setEmptyMessage(_ message: String,in size: CGSize)
    {
        let messageView = UIView.init()
        messageView.backgroundColor = .clear
        let messageLabel = UILabel.init()
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = SFont.SourceSansPro_Semibold16
        messageLabel.sizeToFit()
        messageView.addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //label releated constraints
        let leadingConstraint = NSLayoutConstraint.init(item: messageLabel, attribute: .leading, relatedBy: .equal, toItem: messageView, attribute: .leading, multiplier: 1, constant: 0)
        let centerYconstraint = NSLayoutConstraint.init(item: messageLabel, attribute: .centerY, relatedBy: .equal, toItem: messageView, attribute: .centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint.init(item: messageLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size.width)
        let heightConstraint = NSLayoutConstraint.init(item: messageLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size.height)
        
        //View releated Constraints
        let viewLeadingConstraint = NSLayoutConstraint.init(item: messageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let viewTrailingConstraint = NSLayoutConstraint.init(item: messageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let viewTopConstraint = NSLayoutConstraint.init(item: messageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let viewBottomConstraint = NSLayoutConstraint.init(item: messageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        
        self.backgroundView = messageView;
        NSLayoutConstraint.activate([viewTopConstraint,viewBottomConstraint,viewLeadingConstraint,viewTrailingConstraint,leadingConstraint,centerYconstraint,widthConstraint,heightConstraint])
        
        self.separatorStyle = .none;
    }
    //ENGAGE0011597 -- End
}
extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = SFont.SourceSansPro_Semibold16
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView = nil
    }
}

class GiftcardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate{
   
    
    
    
    
    
    private var mySearchBar: UISearchBar!
    private var giftCardSearchbar: UISearchBar!
    
    @IBOutlet weak var tableViewGiftCard: UITableView!
    private let cellReuseIdentifier: String = "GiftCell"
    var rightSearchbarButton = UIBarButtonItem()
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrgiftcard = [GiftCard]()
    var arrGiftCardList = [GiftCardList]()
    var dictgiftcardInfo = GiftCard()
    var refreshControl = UIRefreshControl()
    
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.refreshControls()
//        self.setColorCode()
       self.initController()
        
        self.tableViewGiftCard.register(GiftCardTableViewCell.self, forCellReuseIdentifier: "GiftCell")

//
    }
    
    func initController()
    {
        self.giftCardSearchbar = UISearchBar()

        self.tableViewGiftCard.reloadData()
        self.tableViewGiftCard.delegate = self
        self.tableViewGiftCard.dataSource = self
        self.tableViewGiftCard.rowHeight = 56
        self.tableViewGiftCard.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableViewGiftCard.sectionHeaderHeight = 56
        // self.tableViewGiftCard.separatorStyle = .none
        self.tableViewGiftCard.separatorInset = .zero
        self.tableViewGiftCard.separatorColor = APPColor.celldividercolor.divider

        self.tableViewGiftCard.layoutMargins = .zero
        self.tableViewGiftCard.tableFooterView = UIView()

        getGiftCard(strSearch: "")
        self.appDelegate.giftCardSearchText = ""

        self.definesPresentationContext = true
        
        
    }
    
    
//    //Mark- Common Color Code
//    func setColorCode()
//    {
//        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg
//
//
//    }
    
//    func refreshControls()
//    {
//        self.refreshControl.attributedTitle = NSAttributedString(string: "")
//        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
//        self.tableViewGiftCard.addSubview(refreshControl) // not required when using UITableViewController
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        //navigation item labelcolor
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = self.appDelegate.masterLabeling.tT_GIFT_CARD
        self.navigationController?.navigationBar.backItem?.title =  self.appDelegate.masterLabeling.bACK
      //  self.navigationController!.interactivePopGestureRecognizer!.isEnabled = false
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
//        self.getAuthToken()
     //   self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

    }
    
 
    //Mark- Token Api
//    func getAuthToken(){
//
//        if (Network.reachability?.isReachable) == true{
//            APIHandler.sharedInstance.getTokenApi(paramater: nil , onSuccess: { tokenList in
//                let access_token = tokenList.access_token
//                let expires_in = tokenList.expires_in
//                let token_type = tokenList.token_type
//                let jointToken = (token_type ?? "") + " " + (access_token ?? "")
//
//                print(jointToken)
//
//                UserDefaults.standard.set(access_token, forKey: UserDefaultsKeys.access_token.rawValue)
//                UserDefaults.standard.set(expires_in, forKey: UserDefaultsKeys.expires_in.rawValue)
//                UserDefaults.standard.set(token_type, forKey: UserDefaultsKeys.token_type.rawValue)
//                UserDefaults.standard.set(jointToken, forKey: UserDefaultsKeys.apiauthtoken.rawValue)
//                UserDefaults.standard.synchronize()
//                print(UserDefaults.standard.string(forKey: UserDefaultsKeys.apiauthtoken.rawValue) ?? "")
//
//
//
//            },onFailure: { error  in
//
//                print(error)
//                SharedUtlity.sharedHelper().showToast(on:
//                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
//            })
//        }
//    }
    
    

    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return (otherGestureRecognizer is UIScreenEdgePanGestureRecognizer)
//    }
    
    //Mark- Giftcard Api
    func getGiftCard(strSearch :String) -> Void {
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            
            // print(UserDefaultsKeys.userID.rawValue)
            let strUserID = UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)! as String
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : strUserID ,//UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,  //UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.ksearchby: strSearch,
                
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            print(paramaterDict)
            
            APIHandler.sharedInstance.getGiftCard(paramaterDict: paramaterDict, onSuccess: { arrGiftCard in
                if(arrGiftCard.responseCode == InternetMessge.kSuccess)
                {
                    if(arrGiftCard.giftcardList == nil)
                    {
                        
                        self.arrGiftCardList.removeAll()
                        self.tableViewGiftCard.setEmptyMessage(InternetMessge.kNoData)
                        self.tableViewGiftCard.reloadData()
                        
                        self.appDelegate.hideIndicator()
                    }else{
                        if(arrGiftCard.giftcardList?.count == 0)
                        {
                            
                            self.arrGiftCardList.removeAll()
                            self.tableViewGiftCard.setEmptyMessage(InternetMessge.kNoData)
                            self.tableViewGiftCard.reloadData()
                            
                        }else{
                            
//                            self.setCardView(view: self.tableViewGiftCard)
                            
                        //    self.tableViewGiftCard.restore()
                            self.arrGiftCardList = arrGiftCard.giftcardList!
                            
                            self.tableViewGiftCard.reloadData()
                            self.appDelegate.hideIndicator()
                        }
                    }
                    
                }else{
                    self.appDelegate.hideIndicator()
                    self.refreshControl.endRefreshing()
                    
                    if(((arrGiftCard.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: arrGiftCard.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                }
                
                self.appDelegate.hideIndicator()
                
            },onFailure: { error  in
                self.refreshControl.endRefreshing()
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
            
        }else{
            // self.tableViewGiftCard.setEmptyMessage(InternetMessge.kInternet_not_available)
            self.refreshControl.endRefreshing()
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
        
        
    }
    
    //MARK:- Set Card View
//    func setCardView(view : UIView){
//
//        view.layer.masksToBounds = false
//        view.layer.shadowOffset = CGSize(width: 0, height: 0)
//        view.layer.cornerRadius = 1;
//        view.layer.shadowRadius = 2;
//        view.layer.shadowOpacity = 0.5;
//
//    }
    
    
//    @objc func refresh(sender:AnyObject) {
//        // Code to refresh table view
//        getGiftCard(strSearch: "")
//        self.giftCardSearchbar.text = ""
//        self.appDelegate.giftCardSearchText = ""
//        self.refreshControl.endRefreshing()
//
//    }
    
//
//    //Mark- Scroll to First Row
//    func scrollToFirstRow() {
//        if(self.arrgiftcard.count > 0){
//            let indexPath = IndexPath(row: 0, section: 0)
//            self.tableViewGiftCard.scrollToRow(at: indexPath, at: .top, animated: true)
//
//
//        }
//
//    }
    
    
    
    //MARK:- Tableview Delegate & Datasource methods
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return  self.arrGiftCardList.count
    }
    
    
    //the method returning each cell of the list
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:GiftCardTableViewCell = self.tableViewGiftCard.dequeueReusableCell(withIdentifier: "GiftCell") as! GiftCardTableViewCell

//        var cell:GiftCardTableViewCell? = tableView.dequeueReusableCell(withIdentifier: String(format: "\(cellReuseIdentifier)%d", indexPath.row)) as? GiftCardTableViewCell
//        if (cell == nil) {
//            cell = (GiftCardTableViewCell(style:UITableViewCellStyle.default, reuseIdentifier: cellReuseIdentifier) as? GiftCardTableViewCell)
//        }
//        cell?.selectionStyle = .none
        
       // let giftCardDict = self.arrGiftCardList[indexPath.row]
        
//        cell?.lblCertifiedTypeName.text = giftCardDict.giftCardCategory
//        cell?.lblOriginalAmount.text = String(giftCardDict.originalPrice ?? 00.00)
//        cell?.lblBalanceAmount.text = String(format: "%.2f",giftCardDict.balanceAmount ?? 0.00)
//        cell?.lblCertifiedCardTypeNumber.text = String(describing: giftCardDict.certificateNo ?? 0000)

//                cell.lblCertifiedTypeName.text = ""
//                cell.lblOriginalAmount.text = ""
//                cell.lblBalanceAmount.text = ""
//                cell.lblCertifiedCardTypeNumber.text = ""

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableViewGiftCard.reloadData()
        //        self.navigationItem.rightBarButtonItem = rightSearchbarButton;
        //        self.navigationItem.titleView = nil
        let transactionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GiftCardDetailsViewController") as! GiftCardDetailsViewController
        transactionVC.dictGiftCardInfo = self.arrGiftCardList[indexPath.row]        
        self.navigationController?.pushViewController(transactionVC, animated: true)
    }
    
    
    @objc func didselectRowatindexpath(sender:UIButton) {
        self.tableViewGiftCard.reloadData()
        //        self.navigationItem.rightBarButtonItem = rightSearchbarButton;
        //        self.navigationItem.titleView = nil
        let transactionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GiftCardDetailsViewController") as! GiftCardDetailsViewController
        transactionVC.dictGiftCardInfo = self.arrGiftCardList[sender.tag]
        self.navigationController?.pushViewController(transactionVC, animated: true)
        
    }
    
    
    
}
