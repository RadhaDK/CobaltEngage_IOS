

import UIKit
import ScrollableSegmentedControl
import DTCalendarView

class StatementViewController: UIViewController, UISearchBarDelegate,UISearchControllerDelegate {
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    fileprivate let now = Date()
    
    fileprivate let calendar = Calendar.current

    @IBOutlet weak var btnDownloadStatement: UIButton!
    @IBOutlet weak var lblMemberNameID: UILabel!
    @IBOutlet weak var uiViewPrevoius: UIView!
    @IBOutlet weak var uiViewCurrent: UIView!
    @IBOutlet weak var uiContainerView: UIView!
  //  var rightSearchbarButton = UIBarButtonItem()
  //  var searchController : UISearchController!
  //  private var stmtSearchbar = UISearchBar()
    
    @IBOutlet weak var viewCalendar: UIView!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var statmentSearchBar: UISearchBar!
    @IBOutlet weak var btnCurrent: UIButton!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var lblyear: UILabel!
    @IBOutlet weak var lblMonthName: UILabel!
    @IBOutlet weak var lblDate: UILabel!

    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    var calendarRangeStartDate : NSString!
    var calendarRangeEndDate : NSString!

    
    @IBOutlet weak var eventDateRangeView: DTCalendarView!{
        didSet {
            eventDateRangeView.delegate = self
            
            eventDateRangeView.displayStartDate = Date(timeIntervalSince1970: 1513228704)
            eventDateRangeView.displayEndDate = Date()
            eventDateRangeView.previewDaysInPreviousAndMonth = false
        }
    }
    fileprivate let monthYearFormatter: DateFormatter = {
        
        
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        
        formatter.dateFormat = "MMMM"
        
        return formatter
    }()
    fileprivate let YearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        
        formatter.dateFormat = "YYYY"
        
        return formatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initController()
        
        btnDownloadStatement .setTitle(self.appDelegate.masterLabeling.download_statement, for: .normal)
        btnDownloadStatement.setImage(UIImage(named: "Group 884"), for: .normal)
        btnDownloadStatement.titleLabel?.font = SFont.SourceSansPro_Semibold18
        btnDownloadStatement.layer.borderWidth = 1.0
        btnDownloadStatement.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
        self.btnDownloadStatement.setStyle(style: .outlined, type: .primary)

        self.lblMemberNameID  .text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)
        
        statmentSearchBar.searchBarStyle = .default
        
        statmentSearchBar.layer.borderWidth = 1
        statmentSearchBar.layer.borderColor = hexStringToUIColor(hex: "F5F5F5").cgColor
        
        
        viewCalendar.layer.masksToBounds = true
        viewCalendar.layer.cornerRadius = 10
        viewCalendar.layer.borderWidth = 0.6
        viewCalendar.layer.borderColor = hexStringToUIColor(hex: "A9A9A9").cgColor

        viewCalendar.layer.shadowColor = UIColor.white.cgColor
        viewCalendar.layer.shadowOpacity = 1
        viewCalendar.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewCalendar.layer.shadowRadius = 6
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    func initController()
    {
       // self.stmtSearchbar = UISearchBar()
        
        self.extendedLayoutIncludesOpaqueBars = false
        
    //    NotificationCenter.default.addObserver(self, selector:#selector(self.pullTorefreshCalled(notification:)) , name:Notification.Name("pulltoRefresh") , object: nil)
        
        
//        self.rightSearchbarButton = UIBarButtonItem(image: UIImage(named: "Icon_SearchNavBar"), style: .plain, target: self, action: #selector(searchBarButtonPressed))
//        self.navigationItem.rightBarButtonItem = self.rightSearchbarButton
//        self.navigationItem.rightBarButtonItem?.tintColor = APPColor.viewBgColor.viewbg
        
        if self.childViewControllers.count > 0{
            let viewControllers:[UIViewController] = self.childViewControllers
            for viewContoller in viewControllers{
                viewContoller.willMove(toParentViewController: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParentViewController()
            }
        }
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        lblDate.text = String(format: "%d",components.day!)
        lblyear.text = String(format: "%d",components.year!)
        
        statmentSearchBar.placeholder = self.appDelegate.masterLabeling.search_Statement ?? "" as String

        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM"
        
        let dateAndMonth: String = dateFormat.string(from: date)
        
        lblMonthName.text = dateAndMonth
        let currentStatementVC = storyboard!.instantiateViewController(withIdentifier: "CurrentStatementViewController")
        configureChildViewControllerForstatenents(childController: currentStatementVC, onView: self.uiContainerView)
        
        self.uiViewCurrent.backgroundColor = APPColor.SegmentController.selectedSegmentBGColor
        self.uiViewPrevoius.backgroundColor = APPColor.SegmentController.nonSelectedSegmentBGColor
        
        let calandergesture = UITapGestureRecognizer(target: self, action:  #selector(self.calander(sender:)))
        self.calendarView.addGestureRecognizer(calandergesture)
        
        
    }
    fileprivate func currentDate(matchesMonthAndYearOf date: Date) -> Bool {
        let nowMonth = calendar.component(.month, from: now)
        let nowYear = calendar.component(.year, from: now)
        
        let askMonth = calendar.component(.month, from: date)
        let askYear = calendar.component(.year, from: date)
        
        if nowMonth == askMonth && nowYear == askYear {
            return true
        }
        
        return false
    }

    @objc func calander(sender : UITapGestureRecognizer) {

        
        eventDateRangeView.isHidden = false
        uiContainerView.isHidden = true
        viewBottom.isHidden = true
        btnClose.isHidden = false
        calendarView.isHidden = true
        btnReset.isHidden = false
    }

    @IBAction func downloadClicked(_ sender: Any) {
        
        self.appDelegate.downloadMonth = ""
        NotificationCenter.default.post(name: NSNotification.Name("downloadData"), object: nil, userInfo: nil)

        let restarantpdfDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
        restarantpdfDetailsVC.isFrom = "downloadStatements"
        restarantpdfDetailsVC.month =  self.appDelegate.downloadMonth
        restarantpdfDetailsVC.year = self.appDelegate.downloadYear
        self.navigationController?.pushViewController(restarantpdfDetailsVC, animated: true)
        
    }
    

    
    
    @IBAction func resetClicked(_ sender: Any) {
        eventDateRangeView.selectionStartDate = nil
        eventDateRangeView.selectionEndDate = nil
        
        calendarRangeStartDate = ""
        calendarRangeEndDate = ""
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchText = statmentSearchBar.text {
            print(searchText)
          //  self.stmtSearchbar.becomeFirstResponder()
            
            //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "statementData"), object: searchText)
            
            self.appDelegate.statementSearchText = searchText
            let userInfo = [ "searchText" : searchText ]
            NotificationCenter.default.post(name: NSNotification.Name("statementData"), object: nil, userInfo: userInfo)
        }
        statmentSearchBar.resignFirstResponder()
 
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count == 0 {
            self.appDelegate.statementSearchText = searchText
            let userInfo = [ "searchText" : searchText ]
            NotificationCenter.default.post(name: NSNotification.Name("statementData"), object: nil, userInfo: userInfo)

        }

    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.extendedLayoutIncludesOpaqueBars = true
        btnClose.isHidden = true
        btnReset.isHidden = true

        eventDateRangeView.isHidden = true

       // let now = Date()
        
        eventDateRangeView.selectionStartDate = Date()
        
        eventDateRangeView.scrollTo(month: eventDateRangeView.displayEndDate, animated: false)

        self.btnCurrent.setTitle(self.appDelegate.masterLabeling.tAB_CURRENT, for: .normal)
        self.btnPrevious.setTitle(self.appDelegate.masterLabeling.tAB_PREVIOUS, for: .normal)
        self.navigationController?.navigationBar.isHidden = false
        //navigation item labelcolor
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = self.appDelegate.masterLabeling.tITLE_STATEMENTS
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        if(self.appDelegate.statementSearchText == "")
        {
            
        }else{
//            if let cancelButton : UIButton = self.stmtSearchbar.value(forKey: "_cancelButton") as? UIButton{
//                                cancelButton.isEnabled = true
//                      }
        }

        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End

        
//        if (self.stmtSearchbar == nil){
//        }
//        else{
//            self.stmtSearchbar.text = self.appDelegate.statementSearchText
//            self.stmtSearchbar.showsCancelButton = true;
//
//            self.stmtSearchbar.resignFirstResponder()
//            if let cancelButton : UIButton = self.stmtSearchbar.value(forKey: "_cancelButton") as? UIButton{
//                cancelButton.isEnabled = true
//            }
//        }
        
     //   self.getAuthToken()
        
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
    
    //Mark - Current tab listener
    @IBAction func btnCurrentStateMentPressed(_ sender: UIButton) {
        if self.childViewControllers.count > 0{
            let viewControllers:[UIViewController] = self.childViewControllers
            for viewContoller in viewControllers{
                viewContoller.willMove(toParentViewController: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParentViewController()
            }
        }
        self.statmentSearchBar.text = ""
        self.appDelegate.statementSearchText = ""
        
        self.uiViewCurrent.backgroundColor = APPColor.SegmentController.selectedSegmentBGColor
        self.uiViewPrevoius.backgroundColor = APPColor.SegmentController.nonSelectedSegmentBGColor
        
        self.btnCurrent.setTitleColor(APPColor.tabBtnColor.selected, for: .normal)
        self.btnPrevious.setTitleColor(APPColor.tabBtnColor.unselected, for: .normal)
        
        
       // self.navigationItem.rightBarButtonItem = rightSearchbarButton;
        self.navigationItem.titleView = nil
        
        
       // self.rightSearchbarButton = UIBarButtonItem(image: UIImage(named: "Icon_SearchNavBar"), style: .plain, target: self, action: #selector(searchBarButtonPressed))
        
        
        let currentStatementVC = storyboard!.instantiateViewController(withIdentifier: "CurrentStatementViewController")
        currentStatementVC.title = self.appDelegate.masterLabeling.tAB_CURRENT
        configureChildViewControllerForstatenents(childController: currentStatementVC, onView: self.uiContainerView)
    }
    @IBAction func closeClicked(_ sender: Any) {
        
        calendarView.isHidden = false
        btnClose.isHidden = true
        btnReset.isHidden = true

        eventDateRangeView.isHidden = true
        uiContainerView.isHidden = false
        
        viewBottom.isHidden = false
        
        let userStartDate = [ "startDate" : calendarRangeStartDate ]
        let userEndate = [ "endDate" : calendarRangeEndDate ]

        NotificationCenter.default.post(name: NSNotification.Name("statementStart"), object: nil, userInfo: userStartDate as [AnyHashable : Any])
        NotificationCenter.default.post(name: NSNotification.Name("statement"), object: nil, userInfo: userEndate as [AnyHashable : Any])

    }
    
    //Mark- Previous tab listener
    @IBAction func btnPreviousStatementPressed(_ sender: UIButton) {
        
        if self.childViewControllers.count > 0{
            let viewControllers:[UIViewController] = self.childViewControllers
            for viewContoller in viewControllers{
                viewContoller.willMove(toParentViewController: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParentViewController()
            }
        }
        
      //  self.stmtSearchbar.text = ""
        self.appDelegate.statementSearchText = ""
        
        self.uiViewCurrent.backgroundColor = APPColor.SegmentController.nonSelectedSegmentBGColor
        self.uiViewPrevoius.backgroundColor = APPColor.SegmentController.selectedSegmentBGColor
        
        self.btnCurrent.setTitleColor(APPColor.tabBtnColor.unselected, for: .normal)
        self.btnPrevious.setTitleColor(APPColor.tabBtnColor.selected, for: .normal)
        
       // self.navigationItem.rightBarButtonItem = rightSearchbarButton;
        self.navigationItem.titleView = nil
        
        
       // self.rightSearchbarButton = UIBarButtonItem(image: UIImage(named: "Icon_SearchNavBar"), style: .plain, target: self, action: #selector(searchBarButtonPressed))
        
        
        
        let previousStatementVC = storyboard!.instantiateViewController(withIdentifier: "PreviousStatementViewController")
        previousStatementVC.title =  self.appDelegate.masterLabeling.tAB_PREVIOUS
        
        configureChildViewControllerForstatenents(childController: previousStatementVC, onView: self.uiContainerView)
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
    
    
}






extension UIViewController {
    func configureChildViewControllerForstatenents(childController: UIViewController, onView: UIView?) {
        var holderView = self.view
        if let onView = onView {
            holderView = onView
        }
        addChildViewController(childController)
        holderView?.addSubview(childController.view)
        constrainViewEqualStmt(holderView: holderView!, view: childController.view)
        childController.didMove(toParentViewController: self)
    }
    
    
    func constrainViewEqualStmt(holderView: UIView, view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        //pin 100 points from the top of the super
        let pinTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                                        toItem: holderView, attribute: .top, multiplier: 1.0, constant: 0)
        let pinBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
                                           toItem: holderView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let pinLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal,
                                         toItem: holderView, attribute: .left, multiplier: 1.0, constant: 0)
        let pinRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal,
                                          toItem: holderView, attribute: .right, multiplier: 1.0, constant: 0)
        
        holderView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
        
    }
    
    //Added on 12th Spetember 2020 V2.3
    ///Removes the child view controller from parent view
    ///
    ///Note :- removes added by configureChildViewControllerForstatenents(childController: UIViewController, onView: UIView?) method
    func remove(childConroller : UIViewController?)
    {
        childConroller?.willMove(toParentViewController: nil)
        childConroller?.view.removeFromSuperview()
        childConroller?.removeFromParentViewController()
    }
}
extension StatementViewController: DTCalendarViewDelegate {
    
    func calendarView(_ calendarView: DTCalendarView, dragFromDate fromDate: Date, toDate: Date) {
        
        if let nowDayOfYear = calendar.ordinality(of: .day, in: .year, for: now),
            let selectDayOfYear = calendar.ordinality(of :.day, in: .year, for: toDate),
            selectDayOfYear > nowDayOfYear {
            return
        }
        
        if let startDate = calendarView.selectionStartDate,
            fromDate == startDate {
            
            if let endDate = calendarView.selectionEndDate {
                if toDate < endDate {
                    calendarView.selectionStartDate = toDate
                }
            } else {
                calendarView.selectionStartDate = toDate
            }
            
        } else if let endDate = calendarView.selectionEndDate,
            fromDate == endDate {
            
            if let startDate = calendarView.selectionStartDate {
                if toDate > startDate {
                    calendarView.selectionEndDate = toDate
                }
            } else {
                calendarView.selectionEndDate = toDate
            }
        }
    }
    
    func calendarView(_ calendarView: DTCalendarView, viewForMonth month: Date) -> UIView {
        
        
        
        let myview = UIView()
        let label = UILabel(frame: CGRect(x: 0, y: 40, width: 200, height: 28))
        
        label.text = monthYearFormatter.string(from: month)
        label.textColor = UIColor(red: 61.0/255.0, green: 61.0/255.0, blue: 61.0/255.0, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.backgroundColor = UIColor.white
        myview.addSubview(label)
        
        let label2 = UILabel(frame: CGRect(x: 0, y: 10, width: 200, height: 22))
        label2.text = YearFormatter.string(from: month)
        label2.textColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        label2.font = UIFont.boldSystemFont(ofSize: 28)
        label2.backgroundColor = UIColor.white
        myview.addSubview(label2)
        
        
        return myview
    }
    
    func calendarView(_ calendarView: DTCalendarView, disabledDaysInMonth month: Date) -> [Int]? {
        
        if currentDate(matchesMonthAndYearOf: month) {
            var disabledDays = [Int]()
            
            let nowDay = calendar.component(.day, from: now)
            
            for day in 1 ... nowDay {
                disabledDays.append(day)
            }
            
            return disabledDays
        }
        
        return nil
    }
    
    func calendarView(_ calendarView: DTCalendarView, didSelectDate date: Date) {
        
        if let nowDayOfYear = calendar.ordinality(of: .day, in: .year, for: now),
            let selectDayOfYear = calendar.ordinality(of :.day, in: .year, for: date),
            calendar.component(.year, from: now) == calendar.component(.year, from: date),
            selectDayOfYear > nowDayOfYear {
            return
        }
        
        if calendarView.selectionStartDate == nil {
            calendarView.selectionStartDate = date
            
        } else if calendarView.selectionEndDate == nil {
            if let startDateValue = calendarView.selectionStartDate {
                if date <= startDateValue {
                    calendarView.selectionStartDate = date
                } else {
                    calendarView.selectionEndDate = date
                    calendarRangeEndDate = SharedUtlity.sharedHelper().dateFormatter.string(from: calendarView.selectionEndDate!) as NSString
                }
            }
        } else {
            calendarView.selectionStartDate = date
            calendarView.selectionEndDate = nil
            
        }
        calendarRangeStartDate = SharedUtlity.sharedHelper().dateFormatter.string(from: calendarView.selectionStartDate!) as NSString
    }
    
    func calendarViewHeightForWeekRows(_ calendarView: DTCalendarView) -> CGFloat {
        return 60
    }
    
    func calendarViewHeightForWeekdayLabelRow(_ calendarView: DTCalendarView) -> CGFloat {
        return 50
    }
    
    func calendarViewHeightForMonthView(_ calendarView: DTCalendarView) -> CGFloat {
        return 80
    }
}



