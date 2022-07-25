import UIKit
import ScrollableSegmentedControl
import Alamofire
import AlamofireImage
import Popover

class CurrentStatementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrstmtcate = [ListStatementCategories]()
    var arrstmt = [ListCurrentStatement]()
    var arrMonthNameList = [ListOfMonths]()
    var strdate = String()
    var strdesc = String()
    var stramt = String()
    var refreshControl = UIRefreshControl()
    var currentMonth: String!
    var year: String!
    
    @IBOutlet weak var uiSegmentView: UIView!
    
    @IBOutlet weak var txtMonthDropDown: UITextField!
    @IBOutlet weak var btnprevious: UIButton!
    
    @IBOutlet weak var btnnext: UIButton!
    fileprivate var monthPicker : UIPickerView? = nil;

    fileprivate var selectedMonth: ListOfMonths? = nil
    
    var calendarRangeStartDate : NSString!
    var calendarRangeEndDate : NSString!


    @IBAction func btnNextTapped(_ sender: Any) {
        
        if self.arrstmtcate.count == 0 {
            
        }else{
        var selectedSegment =  self.segmentedController.selectedSegmentIndex  + 1
        
        
        if selectedSegment >= self.segmentedController.numberOfSegments  {
            selectedSegment = self.segmentedController.numberOfSegments - 1
        }
        self.arrstmt.removeAll()
        self.tableViewStatement.reloadData()
        
        
        self.appDelegate.selectedStmtCategory = self.arrstmtcate[selectedSegment]
        
        
        self.segmentedController.selectedSegmentIndex = selectedSegment
        }
        
    }
    
    
    
    @IBAction func btnPrevioustapped(_ sender: Any) {
        if self.arrstmtcate.count == 0 {
            
        }else{
        var selectedSegment =  self.segmentedController.selectedSegmentIndex  - 1
        if selectedSegment <= 0  {
            selectedSegment = 0
        }
        
        self.arrstmt.removeAll()
        self.tableViewStatement.reloadData()
        
        
        self.appDelegate.selectedStmtCategory = self.arrstmtcate[selectedSegment]
        
        
        self.segmentedController.selectedSegmentIndex = selectedSegment
        
        }
    }
    
    
    
    
    
    @IBOutlet weak var uiViewMonthTitle: UIView!
    
    private let cellReuseIdentifier: String = "cell"
    @IBOutlet weak var tableViewStatement: UITableView!
    //        @IBOutlet weak var segmentedController: ScrollableSegmentedControl!
    var segmentedController = ScrollableSegmentedControl()
    
    @IBOutlet weak var lblTitlevalue: UILabel!

    
    @objc func notificationRecevied(notification: Notification) {
        let strSearch = notification.userInfo?["searchText"] ?? ""

        self.getCurrentstmtApi(withType: (self.appDelegate.selectedStmtCategory.categoryname ?? ""),strSearch: strSearch as! String)
 
    }
    
    @objc func downloadRecevied(notification: Notification) {
        var myStringArr = txtMonthDropDown.text!.components(separatedBy: ",")
        
        if myStringArr.count == 0 ||   myStringArr.count == 1{
            
        }else{
        currentMonth = myStringArr [0]
        year = myStringArr[1].trimmingCharacters(in: .whitespaces)
        
        self.appDelegate.downloadMonth = currentMonth
        self.appDelegate.downloadYear = year
        }
    }
    
    
    @objc func notificationStartDate(notification: Notification) {
        let strSearch = notification.userInfo?["searchText"] ?? ""
        calendarRangeStartDate = notification.userInfo?["startDate"] as? NSString
        calendarRangeEndDate = notification.userInfo?["endDate"] as? NSString

        currentMonth = ""
        txtMonthDropDown.text = ""
        self.getCurrentstmtApi(withType: (self.appDelegate.selectedStmtCategory.categoryname)!,strSearch: strSearch as! String)
        
    }
    @objc func notificationEndDate(notification: Notification) {
        let strSearch = notification.userInfo?["searchText"] ?? ""
        calendarRangeEndDate = notification.userInfo?["endDate"] as? NSString
        currentMonth = ""
        txtMonthDropDown.text = ""

        self.getCurrentstmtApi(withType: (self.appDelegate.selectedStmtCategory.categoryname)!,strSearch: strSearch as! String)
        
    }
    
    @objc func notificationDownloadStatement(notification: Notification) {
//        let strSearch = notification.userInfo?["searchText"] ?? ""
//        calendarRangeEndDate = notification.userInfo?["endDate"] as? NSString
//        currentMonth = ""
//        txtMonthDropDown.text = ""
//
//        self.getCurrentstmtApi(withType: (self.appDelegate.selectedStmtCategory.categoryname)!,strSearch: strSearch as! String)
//
        
        let restarantpdfDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
        restarantpdfDetailsVC.isFrom = "downloadStatements"
        
        self.navigationController?.pushViewController(restarantpdfDetailsVC, animated: true)
    }
    
   
    func refreshControls()
    {
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        self.tableViewStatement.addSubview(refreshControl) // not required when using UITableViewController
    }
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        
        //self.giftCardSearchbar.text = ""
        
        
//        self.appDelegate.selectedStmtCategory
        self.appDelegate.statementSearchText = ""
        self.refreshControl.endRefreshing()
        let selectedCategory = self.appDelegate.selectedStmtCategory.categoryname?.uppercased() ?? ""
        if(selectedCategory.count<=0){
          self.getStatementCategoriesApi(strSearch: "")
        }
        else{
            self.getCurrentstmtApi(withType: selectedCategory,strSearch: "")
            NotificationCenter.default.post(name: NSNotification.Name("pulltoRefresh"), object: nil, userInfo: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.setLocalizedString()
         self.refreshControls()
         self.initController()
         self.setColorCode()
        
        //txtMonthDropDown.setRightIcon(#imageLiteral(resourceName: "icon_calendar_event"))

        
        txtMonthDropDown.setRightIcon(imageName: "Icon_Calendar")
        
        monthPicker = UIPickerView()
        monthPicker?.delegate = self
        monthPicker?.dataSource = self
        txtMonthDropDown.inputView = monthPicker
        
        txtMonthDropDown.layer.borderWidth = 1.0
        txtMonthDropDown.layer.borderColor = hexStringToUIColor(hex: "F06E44").cgColor
        
        
        txtMonthDropDown.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: txtMonthDropDown.frame.height))
        txtMonthDropDown.leftViewMode = .always
        txtMonthDropDown.layer.borderColor = APPColor.MainColours.primary1.cgColor
        txtMonthDropDown.textColor = APPColor.textColor.secondary
        
        uiViewMonthTitle.layer.shadowColor = UIColor.lightGray.cgColor
        uiViewMonthTitle.layer.shadowOpacity = 0.8
        uiViewMonthTitle.layer.shadowOffset = CGSize(width: 2, height: 2)
        uiViewMonthTitle.layer.shadowRadius = 4

//       txtMonthDropDown.setRightIcon(#imageLiteral(resourceName: "Icon_ArrowDown"))
        
    }
    func initController()
    {
        self.getStatementCategoriesApi(strSearch : "")
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.notificationRecevied(notification:)) , name:Notification.Name("statementData") , object: nil)
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.downloadRecevied(notification:)) , name:Notification.Name("downloadData") , object: nil)
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.notificationStartDate(notification:)) , name:Notification.Name("statementStart") , object: nil)
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.notificationEndDate(notification:)) , name:Notification.Name("statement") , object: nil)
        

    }
    
    
    //
    
    
    //MARK:- Segment Controller Selected
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        // print("Segment at index \(sender.selectedSegmentIndex)  selected")
        
        self.arrstmt.removeAll()
        self.tableViewStatement.reloadData()
        
        
        self.appDelegate.selectedStmtCategory = self.arrstmtcate[sender.selectedSegmentIndex]
        self.getCurrentstmtApi(withType: (self.appDelegate.selectedStmtCategory.categoryname?.uppercased())!,strSearch: "")
        
        
    }
    
    //Mark- Common Color Code
    func setColorCode(){
        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
            self.monthPicker?.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(monthPicker!, didSelectRow: 0, inComponent: 0)
       
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if self.arrMonthNameList.count == 0 {
        }
        else{
            var myStringArr = txtMonthDropDown.text!.components(separatedBy: ",")
            
            currentMonth = myStringArr [0]
            year = myStringArr[1].trimmingCharacters(in: .whitespaces)
            
            self.getCurrentstmtApi(withType: (self.appDelegate.selectedStmtCategory.categoryname)!,strSearch: "")

        }

    }
    
    
    
    //MARK:- Get Statement Categories
    func getStatementCategoriesApi(strSearch :String) -> Void {
        if (Network.reachability?.isReachable) == true{
            
            arrstmtcate = [ListStatementCategories]()
            self.arrstmtcate.removeAll()
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.getStatement(paramater: paramaterDict, onSuccess: { categoriesList in
                self.appDelegate.hideIndicator()
                if(categoriesList.responseCode == InternetMessge.kSuccess){
                    self.arrstmtcate.removeAll()
                    
                    self.arrMonthNameList = categoriesList.months ?? []
                    
                    if (self.arrMonthNameList.count == 0) {
                        self.txtMonthDropDown.text = ""
                    }
                    else{
                    if self.txtMonthDropDown.text == "" {
                        self.txtMonthDropDown.text = nil
                        self.currentMonth = self.arrMonthNameList[0].monthName
                        self.year = self.arrMonthNameList[0].year
                        self.txtMonthDropDown.text = self.arrMonthNameList[0].monthYear ?? ""
                    }
                    }
                    if(categoriesList.listcategories == nil){
                        self.arrstmtcate.removeAll()
                        self.tableViewStatement.setEmptyMessage(InternetMessge.kNoData)
                        
                        // self.appDelegate.hideIndicator()
                    }
                    else{
                        self.arrstmtcate.removeAll()
                        
                        self.tableViewStatement.restore()
                        self.arrstmtcate = categoriesList.listcategories!
                        
                        self.appDelegate.selectedStmtCategory = self.arrstmtcate[0]
                        
                        self.getCurrentstmtApi(withType: (self.appDelegate.selectedStmtCategory.categoryname)!,strSearch: strSearch)
                        self.loadsegmentController()
                    }
                }else{
                    if(((categoriesList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: categoriesList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.tableViewStatement.setEmptyMessage(categoriesList.responseMessage ?? "")
                }
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
        }else{
            
            //self.tableViewStatement.setEmptyMessage(InternetMessge.kInternet_not_available)
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
    }
    //MARK:- Get Current Statement details
    func getCurrentstmtApi(withType:String,strSearch :String) -> Void {
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
     //
//        let year =  components.year
        //        let month = components.month
        //        let day = components.day
        
        
        
        let dateFormatters = DateFormatter()

        dateFormatters.dateFormat = "MMMM"


        

        
        dateFormatters.dateFormat = "dd"
        
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            
            let dictData:[String: Any] = [
                APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "" ,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.ksearchby:  strSearch ,
                
                APIKeys.kdepartmentName:withType ,
                APIKeys.kyear:year ?? "",
                APIKeys.kmonth: currentMonth ?? "" ,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
//                "StartDate" : calendarRangeStartDate ?? "",
//                "EndDate" : calendarRangeEndDate ?? ""
            ]
            
            print("dictData: \(dictData)")
            
            
            
            APIHandler.sharedInstance.getCurrentStatement(paramater: dictData, onSuccess: { currentstmtList in
                self.appDelegate.hideIndicator()
                self.arrstmt.removeAll()
                
              
                if(currentstmtList.liststatement == nil)
                {
                    self.arrstmt.removeAll()
                    self.appDelegate.hideIndicator()
                    
                    self.tableViewStatement.setEmptyMessage(InternetMessge.kNoData)
                    self.tableViewStatement.reloadData()
                    
                    
                }else{
                    
                    if(currentstmtList.liststatement?.count == 0)
                    {
                        self.arrstmt.removeAll()
                        self.tableViewStatement.setEmptyMessage(InternetMessge.kNoData)
                        self.lblTitlevalue.text = ""
                        
                        self.lblTitlevalue.text = String(format: "Total %@", currentstmtList.monthTotal ?? "")
//                        if(currentstmtList.monthTotal == nil)
//                        {
//
//                        }else{
//                            var statementTotal = self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",currentstmtList.monthTotal ?? 0.00)
//                            if((currentstmtList.monthTotal ?? 00) < 0){
//                                let temp = -(currentstmtList.monthTotal ?? 00)
//                                let firstchar = String(format: "%.2f",currentstmtList.monthTotal ?? 00).prefix(1)
//                                statementTotal = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
//                            }
//
//                            self.lblTitlevalue.text = String(format: "Total %@", statementTotal)
//                        }
                        
                        self.tableViewStatement.reloadData()
                        
                    }else{
                        self.appDelegate.hideIndicator()
                        
                        self.tableViewStatement.restore()
                        
                        self.arrstmt = currentstmtList.liststatement ?? []
                        self.lblTitlevalue.text = String(format: "Total %@", currentstmtList.monthTotal ?? "")
//                        if(currentstmtList.monthTotal == nil)
//                        {
//
//                        }else{
//                            var statementTotalMonthTotal = self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",currentstmtList.monthTotal ?? 0.00)
//                            if((currentstmtList.monthTotal ?? 00) < 0){
//                                let temp = -(currentstmtList.monthTotal ?? 00)
//                                let firstchar = String(format: "%.2f",currentstmtList.monthTotal ?? 00).prefix(1)
//                                statementTotalMonthTotal = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
//                            }
//
//                            self.lblTitlevalue.text = String(format: "Total %@", statementTotalMonthTotal) //self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",currentstmtList.monthTotal ?? 0.00)
//
//                        }
                        
                        
                        self.tableViewStatement.reloadData()
                    }
                }
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
        }else{
            self.tableViewStatement.setEmptyMessage(InternetMessge.kInternet_not_available)
            
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadsegmentController()  {
        
        
        self.segmentedController = ScrollableSegmentedControl.init(frame: self.uiSegmentView.bounds)
        self.uiSegmentView.addSubview(self.segmentedController)
        self.segmentedController.segmentStyle = .textOnly
        
        self.segmentedController.underlineSelected = true
        self.segmentedController.selectedSegmentIndex = 0
        self.segmentedController.backgroundColor = hexStringToUIColor(hex: "F5F5F5")
        
        self.segmentedController.tintColor = APPColor.loginBackgroundButtonColor.loginBtnBGColor
       // self.uiViewMonthTitle.backgroundColor =  APPColor.viewBackgroundColor.viewbg
        
        self.segmentedController.addTarget(self, action: #selector(CurrentStatementViewController.segmentSelected(sender:)), for: .valueChanged)
        
        
        
        // self.segmentedController.removeFromSuperview()
        for i in 0 ..< self.arrstmtcate.count {
            let statementData = self.arrstmtcate[i]
            
            self.segmentedController.insertSegment(withTitle: statementData.categoryname, image: nil, at: i)
        }
        self.segmentedController.selectedSegmentIndex = 0
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
       // self.uiSegmentView.backgroundColor = APPColor.viewBackgroundColor.viewbg
        self.setLocalizedString()
        
        self.isAppAlreadyLaunchedOnce()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnceStatement"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnceStatement")
            if let impVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "PopUpForCategoryVC") as? PopUpForCategoryVC {
                impVC.isFrom = "Statements"
                impVC.modalTransitionStyle   = .crossDissolve;
                impVC.modalPresentationStyle = .overCurrentContext
                self.present(impVC, animated: true, completion: nil)
            }
            print("App launched first time")
            return false
        }
    }
    
    //MARK:- Tableview Delegate & Datasource methods
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.arrstmt.count
    }
    
    //the method returning each cell of the list
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomStatementTableViewCell
        let statementDict = self.arrstmt[indexPath.row]
        
        if((statementDict.receiptNo?.count)!>0){
//            strReceiptNo = statementDict.receiptNo!
        }
        
        cell.lblDate.text = statementDict.purchaseDate ?? ""
        cell.lblCategory.text = statementDict.category
        cell.lblReceipt.text = statementDict.receiptNo ?? ""
        cell.lblDescription.text = statementDict.descriptions ?? ""
        
//        if((statementDict.amount ?? 0.00) < 0){
//            let temp = -(statementDict.amount ?? 0.00)
//            let firstchar = String(format: "%.2f",statementDict.amount ?? 0.00).prefix(1)
//            cell.lblAmount.text = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
//        }else{
        
        cell.lblAmount.text = String(format: "%@", statementDict.amount ?? "")
//        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableViewStatement.reloadData()
        let statementDict = self.arrstmt[indexPath.row]
        
        if let receiptNo = statementDict.receiptNo, receiptNo != ""
        {
            let transactionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransactionDetailsViewController") as! TransactionDetailsViewController
            transactionVC.receiptno = receiptNo //statementDict.receiptNo!
            transactionVC.category = statementDict.category ?? ""
            transactionVC.descriptions = statementDict.descriptions ?? ""
            transactionVC.purchaseDate = statementDict.purchaseDate ?? ""
            transactionVC.purchaseTime = statementDict.purchaseTime ?? ""
            transactionVC.amount = statementDict.amount ?? ""
            transactionVC.statementID = statementDict.id ?? ""
            
            self.navigationController?.pushViewController(transactionVC, animated: true)
        }
       
    }
    
    
    func setCardView(view : UIView){
        
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = 1;
        view.layer.shadowRadius = 2;
        view.layer.shadowOpacity = 0.5;
        
    }
    
    
    
    func setLocalizedString()
    {
        
        self.navigationController?.navigationBar.isHidden = false
        //navigation item labelcolor
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = self.appDelegate.masterLabeling.tT_STATEMENTS
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true

        
//        NotificationCenter.default.addObserver(self, selector: #selector(notificationRecevied(notification:)), name: NSNotification.Name(rawValue: "statementData"), object: nil)
        
        
        strdate = (self.appDelegate.masterLabeling.dATE)!
        strdesc = (self.appDelegate.masterLabeling.dESCRIPTION)!
        stramt = (self.appDelegate.masterLabeling.aMOUNT)!
        
        
        //        }
    }
    
    
    
    
    
    @objc func didselectRowatindexpath(sender:UIButton) {
        self.tableViewStatement.reloadData()
        var statementDict = self.arrstmt[sender.tag]
        let transactionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransactionDetailsViewController") as! TransactionDetailsViewController
        transactionVC.receiptno = statementDict.receiptNo!
        self.tableViewStatement.reloadData()
        self.navigationController?.pushViewController(transactionVC, animated: true)
    }
    
    
    func hexStringToUIColorCurrentSatement (hex:String) -> UIColor {
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

extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    
    
    
}
extension CurrentStatementViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.arrMonthNameList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.arrMonthNameList[row].monthYear
    }
}
extension CurrentStatementViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.arrMonthNameList.count == 0 {
        }
        else{
        selectedMonth = self.arrMonthNameList[row]
        txtMonthDropDown.text = selectedMonth?.monthYear
        self.currentMonth = selectedMonth?.monthYear
        }
    }
}

