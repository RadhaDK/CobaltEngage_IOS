

import UIKit
import ScrollableSegmentedControl
import simd


class PreviousStatementDetailsViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate,UISearchControllerDelegate {
    //    var searchControllerStatement  = UISearchController()
    //    lazy var searchBar:UISearchBar = UISearchBar()
    
    var refreshControl = UIRefreshControl()
    
    private var prevstmtsearchbar: UISearchBar!
    
    private let cellReuseIdentifier: String = "cell"
    @IBOutlet weak var tableViewStatement: UITableView!
    @IBOutlet weak var segmentedController: ScrollableSegmentedControl!
    var rightSearchbarButton = UIBarButtonItem()
    
    @IBOutlet weak var lblTotalValue: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    @IBOutlet weak var btnprevios: UIButton!
    @IBOutlet weak var btnnext: UIButton!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var previosmonth:String!
    
    @IBOutlet weak var uiViewMonthTitle: UIView!
    var arrstmtcate = [ListStatementCategories]()
    var arrstmt = [ListCurrentStatement]()
    var strdate = String()
    var strdesc = String()
    var stramt = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setColorCode()
        self.refreshControls()
        self.initController()
        
        
    }
    
    //Mark- StatementCategories Api
    func getStatementCategoriesApi(strSearch :String) -> Void {
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        if (Network.reachability?.isReachable) == true{
            
            self.arrstmtcate = [ListStatementCategories]()
            self.arrstmtcate.removeAll()
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!
            ]
            
            APIHandler.sharedInstance.getStatement(paramater: paramaterDict, onSuccess: { categoriesList in
                
                if(categoriesList.responseCode == InternetMessge.kSuccess)
                {
                    if(categoriesList.listcategories != nil || !( categoriesList.listcategories?.count == 0))
                    {
                        
                        self.arrstmtcate.removeAll()
                        
                        self.tableViewStatement.restore()
                        self.arrstmtcate = categoriesList.listcategories!
                        
                        self.appDelegate.selectedPreviousStmtCategory = self.arrstmtcate[0]
                        
                        self.getCurrentstmtApi(withType: (self.appDelegate.selectedPreviousStmtCategory.categoryname)!,strSearch: strSearch)
                        self.loadsegmentController()
                    }
                }else{
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: categoriesList.responseMessage, withDuration: Duration.kMediumDuration)
                }
                self.appDelegate.hideIndicator()
                
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
        }else{
            self.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
    }
    
    func loadsegmentController()  {
        for i in 0 ..< self.arrstmtcate.count {
            let statementData = self.arrstmtcate[i]
            self.segmentedController.insertSegment(withTitle: statementData.categoryname, image: nil, at: i)
        }
        self.segmentedController.selectedSegmentIndex = 0
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.navigationItem.rightBarButtonItem = rightSearchbarButton;
        self.navigationItem.titleView = nil
        self.prevstmtsearchbar.text = ""
        //        self.appDelegate.statementSearchText = ""
        
        self.getCurrentstmtApi(withType: (self.appDelegate.selectedPreviousStmtCategory.categoryname)!,strSearch: "")
        
        //        self.getStatementCategoriesApi(strSearch: "")
        
        
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            //            self.appDelegate.statementSearchText = searchText
            self.prevstmtsearchbar.text = searchText
            
            self.getCurrentstmtApi(withType: (self.appDelegate.selectedPreviousStmtCategory.categoryname)!,strSearch: searchText)
            //            getStatementCategoriesApi(strSearch: searchBar.text ?? "")
        }
        self.prevstmtsearchbar.resignFirstResponder()
        if let cancelButton : UIButton = searchBar.value(forKey: "_cancelButton") as? UIButton{
            cancelButton.isEnabled = true
        }
        
    }
    
    
    //Mark- Common Color Code
    func setColorCode()
    {
        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg
        
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        
        searchBar.setValue("Cancel", forKey: "_cancelButtonText")
        
        
    }
    //Mark- Search logic for Previousstatement
    @objc func searchBarButtonPressed() {
        
        
        self.prevstmtsearchbar.delegate = self
        self.prevstmtsearchbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44)     // CGRect(0, 0, 300, 80)
        if #available(iOS 11.0, *) {
            self.prevstmtsearchbar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
        
        //        self.prevstmtsearchbar.layer.shadowOpacity = 0.5
        self.prevstmtsearchbar.layer.masksToBounds = false
        
        self.prevstmtsearchbar.showsCancelButton = true;
        
        self.prevstmtsearchbar.showsBookmarkButton = false
        
        // set Default bar status.
        self.prevstmtsearchbar.searchBarStyle = .default
        
        
        self.prevstmtsearchbar.barTintColor = UIColor.gray
        self.prevstmtsearchbar.tintColor = UIColor.gray
        UIBarButtonItem.appearance().tintColor = UIColor.white
        
        self.prevstmtsearchbar.showsSearchResultsButton = false
        
        // add searchBar to the view.
        
        self.navigationItem.titleView = prevstmtsearchbar
        self.navigationItem.rightBarButtonItem = nil ;
        self.prevstmtsearchbar.becomeFirstResponder()
        
        
    }
    
    func presentSearchController(_ searchController: UISearchController) {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //It will show the status bar again after dismiss
        
        
    }
    
    //Mark- Current Statement Api
    func getCurrentstmtApi(withType:String,strSearch :String) -> Void {
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year =  components.year
        
        
        let dateFormatters = DateFormatter()
        
        dateFormatters.dateFormat = "MMMM"
        dateFormatters.dateFormat = "dd"
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            
            let dictData:[String: Any] = [
                APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kdepartmentName:withType ,
                APIKeys.kyear:year ?? "",
              //  APIKeys.kmonth:previosmonth ?? "",
                APIKeys.kdeviceInfo:[APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.ksearchby:  strSearch,
                
                
                ]
            
            
            APIHandler.sharedInstance.getCurrentStatement(paramater: dictData, onSuccess: { currentstmtList in
                
                self.appDelegate.hideIndicator()
                if(currentstmtList.responseCode == InternetMessge.kSuccess)
                {
                    if(currentstmtList.liststatement == nil){
                        self.appDelegate.hideIndicator()
                        self.tableViewStatement.setEmptyMessage(InternetMessge.kNoData)
                        
                    }
                    else{
                        self.appDelegate.hideIndicator()
                        self.arrstmt.removeAll()
                        if(currentstmtList.liststatement?.count == 0){
                            self.lblTotalValue.text = ""
                            self.tableViewStatement.setEmptyMessage(InternetMessge.kNoData)
                            self.lblTotalValue.text = ""
                            
                            self.lblTotalValue.text = currentstmtList.monthTotal ?? ""
//                            if(currentstmtList.monthTotal == nil)
//                            {
//                            }else{
//
//                                var statementTotal = self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",currentstmtList.monthTotal ?? 0.00)
//                                if((currentstmtList.monthTotal ?? 00) < 0){
//                                    let temp = -(currentstmtList.monthTotal ?? 00)
//                                    let firstchar = String(format: "%.2f",currentstmtList.monthTotal ?? 00).prefix(1)
//                                    statementTotal = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
//                                }
//                                self.lblTotalValue.text = statementTotal //self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",currentstmtList.monthTotal ?? 0.00)
//                            }
                            self.tableViewStatement.reloadData()
                        }else{
                            self.tableViewStatement.restore()
                            self.arrstmt = currentstmtList.liststatement ?? []
                            self.lblTotalValue.text = ""
                            self.lblTotalValue.text = currentstmtList.monthTotal ?? ""
//                            if(currentstmtList.monthTotal == nil)
//                            {
//                            }else{
//                                var statementMonthTotal = self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",currentstmtList.monthTotal ?? 0.00)
//                                if((currentstmtList.monthTotal ?? 00) < 0){
//                                    let temp = -(currentstmtList.monthTotal ?? 00)
//                                    let firstchar = String(format: "%.2f",currentstmtList.monthTotal ?? 00).prefix(1)
//                                    statementMonthTotal = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
//                                }
//                                self.lblTotalValue.text = statementMonthTotal //self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",currentstmtList.monthTotal ?? 0.00)
//                            }
                            self.tableViewStatement.reloadData()
                        }
                    }
                }
                else{
                    if(((currentstmtList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: currentstmtList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                }
                
                
                
                
                
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                
                // print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
        }
        else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
    }
    func refreshControls()
    {
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        self.tableViewStatement.addSubview(refreshControl) // not required when using UITableViewController
    }
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        //    self.getStatementCategoriesApi(strSearch: "")
        //     self.getCurrentstmtApi(withType: <#T##String#>, strSearch: "")
        let selectedCategory = self.appDelegate.selectedPreviousStmtCategory.categoryname?.uppercased() ?? ""
        if(selectedCategory.count<=0){
            self.getStatementCategoriesApi(strSearch: "")
        }
        else{
            self.getCurrentstmtApi(withType: selectedCategory,strSearch: "")
            
            self.navigationItem.rightBarButtonItem = rightSearchbarButton;
            self.navigationItem.titleView = nil
            self.prevstmtsearchbar.text = ""
            
        }
        self.prevstmtsearchbar.text = ""
        self.refreshControl.endRefreshing()
        
    }
    
    
   
    
    func initController()
    {
        
        self.prevstmtsearchbar = UISearchBar()
        self.lblTotalValue.text = ""
        lblTotal.font = SFont.SourceSansPro_Regular18
        lblTotalValue.font = SFont.SourceSansPro_Semibold18
        
        
        self.rightSearchbarButton = UIBarButtonItem(image: UIImage(named: "Icon_SearchNavBar"), style: .plain, target: self, action: #selector(searchBarButtonPressed))
        self.navigationItem.rightBarButtonItem = self.rightSearchbarButton
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
        
        self.getStatementCategoriesApi(strSearch : "")
        
        // Do any additional setup after loading the view.
        
        self.tableViewStatement.delegate = self
        self.tableViewStatement.dataSource = self
        self.tableViewStatement.rowHeight = 64
        self.tableViewStatement.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableViewStatement.sectionHeaderHeight = 44
        self.tableViewStatement.separatorStyle = .none
        self.tableViewStatement.separatorInset = .zero
        self.tableViewStatement.layoutMargins = .zero
        self.tableViewStatement.backgroundColor = UIColor.clear
        self.tableViewStatement.tableFooterView = UIView()
        self.segmentedController.segmentStyle = .textOnly
        self.tableViewStatement.separatorColor = APPColor.celldividercolor.divider
        
        
        self.segmentedController.underlineSelected = true
        self.segmentedController.selectedSegmentIndex = 0
        self.segmentedController.backgroundColor = APPColor.statementcategories.category
        
        self.segmentedController.tintColor = APPColor.loginBackgroundButtonColor.loginBtnBGColor
        self.uiViewMonthTitle.backgroundColor = APPColor.viewBackgroundColor.viewbg
        self.segmentedController.addTarget(self, action: #selector(CurrentStatementViewController.segmentSelected(sender:)), for: .valueChanged)
        
        let rowheight:Double = 42 //Double(self.tableViewStatement.rowHeight)
        let rowWidth:Double = Double(self.view.frame.size.width)   //Double(self.tableViewStatement.frame.size.width)
        let numberofColouns:Int = 3
        
        var xAxis: Double = 20
        let yAxis: Double = 0
        let uiViewHeaderView = UIView.init()
        uiViewHeaderView.frame = CGRect(x: 0, y: 0, width: rowWidth , height: rowheight-1)
        let uiViewLine = UIView.init()
        uiViewLine.frame = CGRect(x: 0, y: rowheight - 1, width: rowWidth , height: 1)
        uiViewLine.backgroundColor = APPColor.celldividercolor.divider  //UIColor.groupTableViewBackground
        uiViewHeaderView .addSubview(uiViewLine)
        uiViewHeaderView.backgroundColor = APPColor.selectedcellColor.selectedcell
        uiViewHeaderView.addBottomBorderWithColor(color:APPColor.tintColor.tint , width: 1)
        
        let viewWidth: Double = (rowWidth / Double(numberofColouns))-20
        for j in 0 ..< numberofColouns {
            let uiView = UIView.init()
            uiView.frame = CGRect(x: xAxis, y: yAxis, width: viewWidth , height: rowheight)
            xAxis = xAxis + Double(uiView.frame.size.width)  + Double(8)
            uiViewHeaderView .addSubview(uiView)
            
            let lableHeight = uiView.frame.size.height
            let btnTitle = UIButton.init()
            btnTitle.frame = CGRect(x: 0, y: 0, width: uiView.frame.size.width, height: lableHeight)
            btnTitle.titleLabel?.font = SFont.SourceSansPro_Semibold12
            uiView.addSubview(btnTitle)
            btnTitle.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0) // top // left // bottom // right
            btnTitle.contentHorizontalAlignment = .left
            
            if(j == 0){
                btnTitle .setTitle(self.appDelegate.masterLabeling.dATE ?? "", for: .normal)
            }
            if(j == 1){
                btnTitle .setTitle(self.appDelegate.masterLabeling.dESCRIPTION ?? "", for: .normal)
            }
            if(j == 2){
                btnTitle .setTitle(self.appDelegate.masterLabeling.aMOUNT ?? "", for: .normal)
                btnTitle.contentHorizontalAlignment = .right
            }
            btnTitle.setTitleColor(UIColor.darkGray, for: .normal)
            btnTitle.titleLabel?.numberOfLines = 2
            btnTitle.titleLabel?.lineBreakMode = .byWordWrapping
        }
        self.tableViewStatement.tableHeaderView = uiViewHeaderView
        self.btnprevios.backgroundColor = APPColor.statementcategories.category
        self.btnnext.backgroundColor = APPColor.statementcategories.category
        
        //
        
        
    }
    
    
    
    
    //MARK:- Segment Controller Selected
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        // print("Segment at index \(sender.selectedSegmentIndex)  selected")
        
        self.arrstmt.removeAll()
        self.tableViewStatement.reloadData()
        
        
        self.appDelegate.selectedPreviousStmtCategory = self.arrstmtcate[sender.selectedSegmentIndex]
        self.getCurrentstmtApi(withType: (self.appDelegate.selectedPreviousStmtCategory.categoryname?.uppercased())!,strSearch: "")
        
        
        
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year =  components.year
        
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.backItem?.title = self.appDelegate.masterLabeling.bACK
        self.navigationController?.navigationBar.topItem?.title = self.appDelegate.masterLabeling.bACK
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
//        let backButton = UIBarButtonItem()
//
//        backButton.title = self.appDelegate.masterLabeling.bACK
//
//        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
        
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End

        
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = true
        
        var stryear = "\(year)"
        if let year = year as? Int {
            let yearString = String(year)
            self.navigationItem.title = previosmonth! + " "  + yearString
            lblTotal.text =  previosmonth! + " " + self.appDelegate.masterLabeling.mTD!
        }
        
        
        
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = true
        
        
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        strdate = (self.appDelegate.masterLabeling.dATE)!
        strdesc = (self.appDelegate.masterLabeling.dESCRIPTION)!
        stramt = (self.appDelegate.masterLabeling.aMOUNT)!
        
        
    }
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Tableview Delegate & Datasource methods
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.arrstmt.count
    }
    
    //the method returning each cell of the list
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: String(format: "\(cellReuseIdentifier)%d", indexPath.row))
        if (cell == nil) {
            cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:cellReuseIdentifier)
        }
        
        let rowheight:Double = Double(self.tableViewStatement.rowHeight)
        let rowWidth:Double = Double(self.view.frame.size.width) //Double(self.tableViewStatement.frame.size.width)
        let numberofColouns:Int = 3
        var xAxis: Double = 20
        let yAxis: Double = 0
        let viewWidth: Double = (rowWidth / Double(numberofColouns)) - 20
        let statementDict = self.arrstmt[indexPath.row]
        var strReceiptNo = String()
        
        if((statementDict.receiptNo?.count)!>0){
            strReceiptNo = statementDict.receiptNo!
        }
        
        
        
        let btnDate = UIButton.init()
        let btnCategoryName = UIButton.init()
        let btnReceiptNo = UIButton.init()
        let btnDescription = UIButton.init()
        let btnAmount = UIButton.init()
        
        
        
        for i in 0 ..< numberofColouns {
            let uiView = UIView.init()
            uiView.frame = CGRect(x: xAxis, y: yAxis, width: viewWidth , height: rowheight)
            cell?.contentView.addSubview(uiView)
            xAxis = xAxis + Double(uiView.frame.size.width)  + Double(8)
            let lableHeight = uiView.frame.size.height
            
            
            
            
            if(i == 0){
                
                btnDate.frame = CGRect(x: 0, y: 0, width: uiView.frame.size.width, height: (lableHeight / 2) - 2)
                btnDate.titleLabel?.font = SFont.SourceSansPro_Regular14
                uiView.addSubview(btnDate)
                btnDate.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0) // top // left // bottom // right
                btnDate.setTitleColor(APPColor.textColor.text, for: .normal)
                btnDate.contentHorizontalAlignment = .left
                btnDate.titleLabel?.lineBreakMode = .byTruncatingTail
                btnDate.setTitle(statementDict.purchaseDate ?? "", for: .normal)
                
                
                btnCategoryName.frame = CGRect(x: 0, y: btnDate.frame.size.height, width: uiView.frame.size.width, height: (lableHeight / 2) - 2)
                btnCategoryName.titleLabel?.font = SFont.SourceSansPro_Regular14
                uiView.addSubview(btnCategoryName)
                btnCategoryName.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0) // top // left // bottom // right
                btnCategoryName.setTitleColor(APPColor.textColor.text, for: .normal)
                btnCategoryName.contentHorizontalAlignment = .left
                btnCategoryName.titleLabel?.lineBreakMode = .byTruncatingTail
                
                
                let uiViewLine = UIView.init()
                uiViewLine.frame = CGRect(x: 0, y: rowheight - 1, width: rowWidth , height: 1)
                uiViewLine.backgroundColor = UIColor.groupTableViewBackground
                uiView .addSubview(uiViewLine)
                btnCategoryName.setTitleColor(APPColor.textColor.text, for: .normal)
                
                btnCategoryName.setTitle(statementDict.category, for: .normal)
                
            }
            
            if(i == 1){
                
                btnReceiptNo.frame = CGRect(x: 0, y: 0, width: uiView.frame.size.width, height: (lableHeight / 2))
                btnReceiptNo .setTitle(strReceiptNo, for: .normal)
                btnReceiptNo.titleLabel?.font = SFont.SourceSansPro_Regular14
                
                btnReceiptNo.setTitleColor(APPColor.textColor.text, for: .normal)
                btnReceiptNo.contentHorizontalAlignment = .left
                btnReceiptNo.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0) // top // left // bottom // right
                uiView.addSubview(btnReceiptNo)
                btnReceiptNo .setTitle(strReceiptNo, for: .normal)
                
                
                let description = statementDict.descriptions ?? ""
                
                if(description.count>0){
                    
                    btnDescription.frame = CGRect(x: 0, y: btnReceiptNo.frame.size.height, width: uiView.frame.size.width, height: lableHeight  - btnReceiptNo.frame.size.height)
                    btnDescription .setTitle(strReceiptNo, for: .normal)
                    btnDescription.titleLabel?.font = SFont.SourceSansPro_Regular14
                    btnDescription.titleLabel?.numberOfLines = 2
                    btnDescription.titleLabel?.lineBreakMode = .byTruncatingTail
                    
                    btnDescription.setTitleColor(APPColor.textColor.text, for: .normal)
                    btnDescription.contentHorizontalAlignment = .left
                    btnDescription.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0) // top // left // bottom // right
                    btnDescription.contentVerticalAlignment = .top
                    uiView.addSubview(btnDescription)
                    btnDescription .setTitle(description, for: .normal)
                    
                    //                    btnDescription.sizeToFit()
                }
            }
            
            
            if(i == 2){
                
                btnAmount.frame = CGRect(x: 0, y: 0, width: uiView.frame.size.width, height: lableHeight)
                btnAmount .setTitle(strReceiptNo, for: .normal)
                btnAmount.titleLabel?.font = SFont.SourceSansPro_Semibold14
                
                btnAmount.setTitleColor(APPColor.textColor.text, for: .normal)
                btnAmount.contentHorizontalAlignment = .left
                btnAmount.contentEdgeInsets = UIEdgeInsetsMake(8, 0, 0, 0) // top // left // bottom // right
                uiView.addSubview(btnAmount)
                
                let result = sign(12.00)
                print("\(sign(result))")
                
                let statementAmount = statementDict.amount ?? ""
//                if((statementDict.amount ?? 0.00) < 0){
//                    let temp = -(statementDict.amount ?? 0.00)
//                    let firstchar = String(format: "%.2f",statementDict.amount ?? 0.00).prefix(1)
//                    statementAmount = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
//                }
                
                btnAmount .setTitle(statementAmount, for: .normal)
                btnAmount.setTitleColor(APPColor.textColor.text, for: .normal)
                btnAmount.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0) // top // left // bottom // right
                btnAmount.titleLabel?.font = SFont.SourceSansPro_Semibold16
                btnAmount.contentHorizontalAlignment = .right
            }
            
            btnDate.tag = indexPath.row
            btnCategoryName.tag = indexPath.row
            btnReceiptNo.tag = indexPath.row
            btnDescription.tag = indexPath.row
            btnAmount.tag = indexPath.row
            
            
            
            btnDate.addTarget(self, action: #selector(didselectRowatindexpath(sender:)), for: .touchUpInside)
            btnCategoryName.addTarget(self, action: #selector(didselectRowatindexpath(sender:)), for: .touchUpInside)
            btnReceiptNo.addTarget(self, action: #selector(didselectRowatindexpath(sender:)), for: .touchUpInside)
            btnDescription.addTarget(self, action: #selector(didselectRowatindexpath(sender:)), for: .touchUpInside)
            btnAmount.addTarget(self, action: #selector(didselectRowatindexpath(sender:)), for: .touchUpInside)
            
            
            
            
        }
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableViewStatement.reloadData()
        let transactionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransactionDetailsViewController") as! TransactionDetailsViewController
        let statementDict = self.arrstmt[indexPath.row]
        transactionVC.receiptno = statementDict.receiptNo!
        self.navigationController?.pushViewController(transactionVC, animated: true)
    }
    
    
    @objc func didselectRowatindexpath(sender:UIButton) {
        self.tableViewStatement.reloadData()
        let statementDict = self.arrstmt[sender.tag]
        let transactionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransactionDetailsViewController") as! TransactionDetailsViewController
        transactionVC.receiptno = statementDict.receiptNo!
        self.tableViewStatement.reloadData()
        self.navigationController?.pushViewController(transactionVC, animated: true)
    }
    
    
    //MARK:- handle segment controller
    @IBAction func btnBackwordSegmentPressed(_ sender: UIButton) {
        var selectedSegment =  self.segmentedController.selectedSegmentIndex  - 1
        if selectedSegment <= 0  {
            selectedSegment = 0
        }
        self.arrstmt.removeAll()
        self.tableViewStatement.reloadData()
        
        //        var dict = ListStatementCategories()
        //        dict = self.arrstmtcate[selectedSegment]
        //        self.getCurrentstmtApi(withType: (dict.categoryname)!,strSearch: "")
        //        self.segmentedController.selectedSegmentIndex = selectedSegment
        
        self.appDelegate.selectedPreviousStmtCategory = self.arrstmtcate[selectedSegment]
        self.getCurrentstmtApi(withType: (self.appDelegate.selectedPreviousStmtCategory.categoryname)!,strSearch: "")
        
    }
    
    @IBAction func btnForwordSegmentPressed(_ sender: UIButton) {
        var selectedSegment =  self.segmentedController.selectedSegmentIndex  + 1
        if selectedSegment >= self.segmentedController.numberOfSegments  {
            selectedSegment = self.segmentedController.numberOfSegments - 1
        }
        self.arrstmt.removeAll()
        self.tableViewStatement.reloadData()
        
        //        var dict = ListStatementCategories()
        //        dict = self.arrstmtcate[selectedSegment]
        
        //        self.getCurrentstmtApi(withType: (dict.categoryname)!,strSearch: "")
        
        self.appDelegate.selectedPreviousStmtCategory = self.arrstmtcate[selectedSegment]
        self.getCurrentstmtApi(withType: (self.appDelegate.selectedPreviousStmtCategory.categoryname)!,strSearch: "")
        
        
        self.segmentedController.selectedSegmentIndex = selectedSegment
        
        
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
