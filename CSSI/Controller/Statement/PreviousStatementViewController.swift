

import UIKit

class PreviousStatementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewStatement: UITableView!
    private let cellReuseIdentifier: String = "cell"
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrstmt = [Statements]()
    var strmonth = String()
    var strdate = String()
    var refreshControl = UIRefreshControl()

    var stramount = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commomColorCode()
        self.initController()
   
    
    }
    
    func initController()
    {
        
        //           NotificationCenter.default.addObserver(self, selector: #selector(notificationRecevied(notification:)), name: NSNotification.Name(rawValue: "statementData"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.notificationRecevied(notification:)) , name:Notification.Name("statementData") , object: nil)
        
        
        self.setLocalizedString()
        // Do any additional setup after loading the view.
        self.refreshControls()
        self.tableViewStatement.delegate = self
        self.tableViewStatement.dataSource = self
        self.tableViewStatement.rowHeight = 54
        self.tableViewStatement.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableViewStatement.sectionHeaderHeight = 44
        self.tableViewStatement.separatorStyle = .none
        self.tableViewStatement.tableFooterView = UIView()
        self.tableViewStatement.separatorColor = APPColor.celldividercolor.divider
        
        getPreviousstmtApi(strSearch : "")
        
        
        
        let rowheight:Double = 42 //Double(self.tableViewStatement.rowHeight)
        let rowWidth:Double = Double(self.view.frame.size.width)
        let numberofColouns:Int = 3
        
        var xAxis: Double = 8
        let yAxis: Double = 0
        let uiViewHeaderView = UIView.init()
        uiViewHeaderView.frame = CGRect(x: 0, y: 0, width: rowWidth , height: rowheight-1)
        let uiViewLine = UIView.init()
        uiViewLine.frame = CGRect(x: xAxis, y: rowheight - 1, width: rowWidth , height: 1)
        uiViewLine.backgroundColor = APPColor.celldividercolor.divider //UIColor.groupTableViewBackground
        uiViewHeaderView .addSubview(uiViewLine)
        uiViewHeaderView.backgroundColor = APPColor.selectedcellColor.selectedcell
        uiViewHeaderView.addBottomBorderWithColor(color:APPColor.tintColor.tint , width: 1)
        
        let viewWidth: Double = (rowWidth / Double(numberofColouns))-20
        
        for j in 0 ..< numberofColouns {
            let uiView = UIView.init()
            
            uiView.frame = CGRect(x: xAxis+10, y: yAxis, width: viewWidth , height: rowheight)
            xAxis = xAxis + Double(uiView.frame.size.width)  + Double(8)
            
            uiViewHeaderView .addSubview(uiView)
            let lableHeight = uiView.frame.size.height
            let btnTitle = UIButton.init()
            btnTitle.frame = CGRect(x: 0, y: 0, width: uiView.frame.size.width, height: lableHeight)
            
            //font
            btnTitle.titleLabel?.font = SFont.SourceSansPro_Semibold12
            btnTitle .setTitle(strmonth, for: .normal)
            btnTitle.setTitleColor(APPColor.textheaderColor.header, for: .normal)
            uiView.addSubview(btnTitle)
            btnTitle.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0) // top // left // bottom // right
            btnTitle.contentHorizontalAlignment = .left
            
            if(j == 0){
                btnTitle .setTitle(strmonth, for: .normal)
            }
            if(j == 1){
                btnTitle .setTitle(strdate, for: .normal)
            }
            if(j == 2){
                btnTitle .setTitle(stramount, for: .normal)
                btnTitle.contentHorizontalAlignment = .right
            }
            btnTitle.setTitleColor(APPColor.textheaderColor.header, for: .normal)
            btnTitle.titleLabel?.numberOfLines = 2
            btnTitle.titleLabel?.lineBreakMode = .byWordWrapping
            btnTitle.setTitleColor(APPColor.textheaderColor.header, for: .normal)
            
        }
        
        
        self.tableViewStatement.tableHeaderView = uiViewHeaderView
    }
    
    
    
    func refreshControls()
    {
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        self.tableViewStatement.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        self.getPreviousstmtApi(strSearch: "")
        //self.giftCardSearchbar.text = ""
        self.appDelegate.statementSearchText = ""
        self.refreshControl.endRefreshing()
        
        NotificationCenter.default.post(name: NSNotification.Name("pulltoRefresh"), object: nil, userInfo: nil)
        
        
    }
    @objc func notificationRecevied(notification: Notification) {
        let strSearch = notification.userInfo?["searchText"] ?? ""
        
        self.getPreviousstmtApi(strSearch: strSearch as! String)
     
    }
    func setLocalizedString(){
        strmonth = self.appDelegate.masterLabeling.mONTH ?? ""
        strdate = self.appDelegate.masterLabeling.dATE ?? ""
        stramount = self.appDelegate.masterLabeling.aMOUNT ?? ""
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark- Common Color Code
    func commomColorCode()
    {
        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector:#selector(self.notificationRecevied(notification:)) , name:Notification.Name("statementData") , object: nil)
    }
    
    //MARK:- Tableview Delegate & Datasource methods
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrstmt.count
    }
    
    //the method returning each cell of the list
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: String(format: "\(cellReuseIdentifier)%d", indexPath.row))
        if (cell == nil) {
            cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:cellReuseIdentifier)
            cell?.selectionStyle = .none
            
        }
        
        let rowheight:Double = Double(self.tableViewStatement.rowHeight)
        let rowWidth:Double = Double(self.view.frame.size.width)
        let numberofColouns:Int = 3
        
        var xAxis: Double = 8
        let yAxis: Double = 0
        
        let viewWidth: Double = (rowWidth / Double(numberofColouns)) - 20
        
        let previosStmt = self.arrstmt[indexPath.row]
        for i in 0 ..< numberofColouns {
            
            let uiView = UIView.init()
            uiView.frame = CGRect(x: xAxis, y: yAxis, width: viewWidth , height: rowheight)
            //            uiView.backgroundColor = UIColor.groupTableViewBackground
            cell?.contentView.addSubview(uiView)
            
            xAxis = xAxis + Double(uiView.frame.size.width)  + Double(8)
            
            let lableHeight = uiView.frame.size.height
            
            
            let lblTitle = UILabel.init()
            lblTitle.frame = CGRect(x: 10, y: 0, width: uiView.frame.size.width, height: lableHeight - 1)
            uiView.addSubview(lblTitle)
            lblTitle.textAlignment = .left
            lblTitle.textColor = APPColor.textColor.text
            
            let uiViewLine = UIView.init()
            uiViewLine.frame = CGRect(x: 0, y: rowheight - 1, width: rowWidth , height: 1)
            uiViewLine.backgroundColor = UIColor.groupTableViewBackground
            uiView .addSubview(uiViewLine)
            
            if(i == 0){
                lblTitle.text = previosStmt.statement ?? ""
                lblTitle.font = SFont.SourceSansPro_Semibold14
                
            }
            
            if(i == 1){
                lblTitle.text = previosStmt.statemnetDate ?? ""
                lblTitle.font = SFont.SourceSansPro_Semibold14
                
            }
            if(i == 2){
                
                var statementTotal = String(format:self.appDelegate.masterLabeling.cURRENCY! + "%.2f",previosStmt.statementTotal ?? 0.00)
                if((previosStmt.statementTotal ?? 0.00) < 0){
                    let temp = -(previosStmt.statementTotal ?? 0.00)
                    let firstchar = String(format: "%.2f",previosStmt.statementTotal ?? 0.00).prefix(1)
                    statementTotal = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
                }
                
                
                lblTitle.text = statementTotal
                
                lblTitle.font = SFont.SourceSansPro_Semibold16
                
                lblTitle.textAlignment = .right
            }
            lblTitle.textColor = APPColor.textColor.text
            lblTitle.tag = indexPath.row
        }
        return cell!
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let statementDict = self.arrstmt[indexPath.row]
        
        // self.tableViewStatement.reloadData()
        let statementDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreviousStatementDetailsViewController") as! PreviousStatementDetailsViewController
        statementDetailsVC.previosmonth = statementDict.statement!
        self.navigationController?.pushViewController(statementDetailsVC, animated: false)
    }
    
    //Mark - Previous statement Api
    func getPreviousstmtApi(strSearch :String) -> Void {
        
        
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let dictData:[String: Any] = [
                APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "" ,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.ksearchby: strSearch ,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kdeviceInfo:[APIHandler.devicedict]
                
            ]
            
            APIHandler.sharedInstance.getPreviosStatement(paramater: dictData, onSuccess: { previousstmtList in
                self.appDelegate.hideIndicator()
                if(previousstmtList.responseCode == InternetMessge.kSuccess){
                    
                    if(previousstmtList.statement == nil)
                    {
                        self.tableViewStatement.setEmptyMessage(InternetMessge.kNoData)
                        
                        self.appDelegate.hideIndicator()
                        
                    }else{
                        if(previousstmtList.statement?.count == 0)
                        {
                            self.arrstmt.removeAll()
                            self.tableViewStatement.setEmptyMessage(InternetMessge.kNoData)
                            self.tableViewStatement.reloadData()
                            
                        }else{
                            
                            
                            self.tableViewStatement.restore()
                            self.arrstmt =  previousstmtList.statement!
                            
                            self.appDelegate.hideIndicator()
                            self.tableViewStatement.reloadData()
                        }
                    }
                    
                }
                else
                {
                    
                    if(((previousstmtList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: previousstmtList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                }
                
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
        }else{
            //   self.tableViewStatement.setEmptyMessage(InternetMessge.kInternet_not_available)
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
    }

    func hexStringToUIColorStatement (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
}
