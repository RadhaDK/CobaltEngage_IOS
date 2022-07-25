//  TeeTimesViewController.swift
//  CSSI
////  Created by apple on 11/15/18.
//  Copyright © 2018 yujdesigns. All rights reserved.

import UIKit
import Popover
import AVFoundation
import AVKit
import Charts
import MessageUI

class TeeTimesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate, ChartViewDelegate, RequestCellDelegate  {
    func checkBoxClicked(cell: CustomDashBoardCell) {
        
    }
    
    func diningSpecialRequestCheckBoxClicked(cell: CustomDashBoardCell) {
        
    }
    @IBOutlet weak var alphaViewHeight: NSLayoutConstraint!
    @IBOutlet weak var golfsLeagueTableview: UITableView!
    
    @IBOutlet weak var lblGolfLeagues: UILabel!
    @IBOutlet weak var btnTournamentForms: UIButton!
    @IBOutlet weak var lblAlphaReports: UILabel!
    @IBOutlet weak var monthsView: UIView!
    @IBOutlet weak var instructionalVideoHeight: NSLayoutConstraint!
    @IBOutlet weak var instructionalCollectionViewheight: NSLayoutConstraint!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var aliphaReportsCollectionView: UICollectionView!
    @IBOutlet weak var alphaCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblAnnualPlayHistory: UILabel!
    @IBOutlet weak var chartScrollView: UIScrollView!
    @IBOutlet weak var teeTimesView: NSLayoutConstraint!
    @IBOutlet weak var heightUpcomingTop: NSLayoutConstraint!
    @IBOutlet weak var heightUpcomingLabel: NSLayoutConstraint!
    @IBOutlet weak var heightUpcomingEvent: NSLayoutConstraint!
    @IBOutlet weak var eventsView: UIView!
    @IBOutlet weak var viewMainImp: UIView!
    @IBOutlet weak var viewImpContactsBG: UIView!
    @IBOutlet weak var viewImpContacts: UIView!
    @IBOutlet weak var btnReqTeeTime: UIButton!
    @IBOutlet weak var imgImpContacts: UIImageView!
    @IBOutlet weak var lblUpComingEvents: UILabel!
    @IBOutlet weak var imgUpcomingEvents: UIImageView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var lblCalendarofEvents: UIButton!
    @IBOutlet weak var recentNewsTableview: UITableView!
    @IBOutlet weak var lblRecentNews: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var imgGolfMemberdirectory: UIImageView!
    @IBOutlet weak var lblMemberDirectory: UILabel!
    @IBOutlet weak var lblInstructionalVideos: UILabel!
    @IBOutlet weak var btnTournament: UIButton!
    @IBOutlet weak var viewGolfMemberDir: UIView!
    @IBOutlet weak var collectionViewIV: UICollectionView!
    @IBOutlet weak var lblMemberNameAndID: UILabel!
    @IBOutlet weak var heightRecentNewsTable: NSLayoutConstraint!
    @IBOutlet weak var btnrules: UIButton!
    @IBOutlet weak var golfLeagueTableHeight: NSLayoutConstraint!
    @IBOutlet weak var btnShare: UIButton!
    //Added by Kiran V2.9 -- GATHER0001167 -- Added golf BAL Button
    //GATHER0001167 -- Start
    @IBOutlet weak var btnBookALesson: UIButton!
    //GATHER0001167 -- End
    
    //Added by kiran V2.9 -- ENGAGE0012268 -- Lightning Warning button
    //ENGAGE0012268 -- Start
    @IBOutlet weak var stackViewLightningInfo: UIStackView!
    @IBOutlet weak var viewLightningInfo: UIView!
    @IBOutlet weak var btnLightningInfo: UIButton!
    //ENGAGE0012268 -- End
    
    var ClubNewsDetails: TeeTimesDetails? = nil
    var filterPopover: Popover? = nil
    var isUpcomingEventHidded : Bool?
    var reservationSettings = [RequestSettings]()
    var golfSettings : GolfSettings?
    var lineChartView: LineChartView!
    var response: AnualCourtBookingsResponse? = nil
    var  months = [String]()
    
    var unitsSold = [Double]()
    var valueColors = [UIColor]()
    var index = 0

    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    //Added on 4th July 2020 V2.2
    private let accessManager = AccessManager.shared
    
    //Added by kiran V2.9 -- ENGAGE0012268 -- Lightning Warning button
    //ENGAGE0012268 -- Start
    private let lightningBtnHeightAdjustment : CGFloat = 57
    //ENGAGE0012268 -- End
    
    //Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for composing Emails
    //PROD0000069 -- Start
    var arrselectedEmails = [String]()
    //PROD0000069 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Added by kiran V2.9 -- ENGAGE0012268 -- Any Initial setus should be done in this function.
        //ENGAGE0012268 -- Start
        //NOTE:- In Future any changes to setups in viewDidLoad should be done in this function.
        self.initialSetups()
        //ENGAGE0012268 -- End
        
        
        loadTeeTimeDetails()
        

        let golfMemberView = UITapGestureRecognizer(target: self, action:  #selector(self.golfMember(sender:)))
        self.viewGolfMemberDir.addGestureRecognizer(golfMemberView)

        let impContacts = UITapGestureRecognizer(target: self, action: #selector(self.importantContacts(sender:)))
        self.viewImpContacts.addGestureRecognizer(impContacts)

        
        self.lblGolfLeagues.text = self.appDelegate.masterLabeling.gOLF_LEAGUES ?? ""
 
        viewMainImp.layer.shadowColor = UIColor.lightGray.cgColor
        viewMainImp.layer.shadowOpacity = 1.0
        viewMainImp.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewMainImp.layer.shadowRadius = 4
        
        viewImpContactsBG.layer.shadowColor = UIColor.black.cgColor
        viewImpContactsBG.layer.shadowOpacity = 0.16
        viewImpContactsBG.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewImpContactsBG.layer.shadowRadius = 4
        
        self.lblAlphaReports.text = self.appDelegate.masterLabeling.aLPHA_REPORTS ?? "" as String
        
        let EventsimageView = UITapGestureRecognizer(target: self, action:  #selector(self.upComingEventsCliked(sender:)))
        self.eventsView.addGestureRecognizer(EventsimageView)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        
        self.monthsView.layer.shadowColor = UIColor.black.cgColor
        self.monthsView.layer.shadowOpacity = 0.09
        
        self.monthsView.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.monthsView.layer.shadowRadius = 2
        self.playHistoryDetails()
        self.loadData()
        
        self.btnTournamentForms.setTitle(self.appDelegate.masterLabeling.tournament_forms, for: UIControlState.normal)

        let itemSize = UIScreen.main.bounds.width/3-1
       // let screenHeight = (UIScreen.main.bounds.height - 357)/4
        
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
//        if UIScreen.main.bounds.height - 357 >= 455 {
//            layout.itemSize = CGSize(width: itemSize + 0.25, height: screenHeight - 4)
//
//        }else{
            layout.itemSize = CGSize(width: itemSize + 0.25, height: itemSize)
//        }
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        aliphaReportsCollectionView.collectionViewLayout = layout

        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    
    override func viewWillLayoutSubviews()
    {
        if isUpcomingEventHidded == true
        {
            self.heightUpcomingEvent.constant = 0
            self.heightUpcomingLabel.constant = 0
            self.heightUpcomingTop.constant = 0

            heightRecentNewsTable.constant = recentNewsTableview.contentSize.height
            
            if ClubNewsDetails?.instructionalVideos.count == 0
            {
                lblInstructionalVideos.isHidden = true
                instructionalVideoHeight.constant = 0
                instructionalCollectionViewheight.constant = 0
                self.alphaViewHeight.constant = self.aliphaReportsCollectionView.contentSize.height
                self.golfLeagueTableHeight.constant = self.golfsLeagueTableview.contentSize.height
                self.alphaCollectionViewHeight.constant = self.alphaViewHeight.constant
                //Added by kiran V2.9 -- ENGAGE0012268 -- Lightning Warning button height adjustment
                //ENGAGE0012268 -- Start
                self.teeTimesView.constant = 1200 + self.recentNewsTableview.contentSize.height + self.alphaViewHeight.constant + self.golfLeagueTableHeight.constant + (self.viewLightningInfo.isHidden ? 0 : self.lightningBtnHeightAdjustment)
                //ENGAGE0012268 -- End

            }
            else
            {
                self.alphaViewHeight.constant = self.aliphaReportsCollectionView.contentSize.height
                self.golfLeagueTableHeight.constant = self.golfsLeagueTableview.contentSize.height
                
                self.alphaCollectionViewHeight.constant = self.alphaViewHeight.constant
                //Added by kiran V2.9 -- ENGAGE0012268 -- Lightning Warning button height adjustment
                //ENGAGE0012268 -- Start
                self.teeTimesView.constant = 1400 + self.recentNewsTableview.contentSize.height + self.alphaViewHeight.constant + self.golfLeagueTableHeight.constant + (self.viewLightningInfo.isHidden ? 0 : self.lightningBtnHeightAdjustment)
                //ENGAGE0012268 -- End
            }
        }
        else
        {
            heightRecentNewsTable.constant = recentNewsTableview.contentSize.height
            
            if ClubNewsDetails?.instructionalVideos.count == 0
            {
                lblInstructionalVideos.isHidden = true
                instructionalVideoHeight.constant = 0
                instructionalCollectionViewheight.constant = 0
                self.alphaViewHeight.constant = self.aliphaReportsCollectionView.contentSize.height
                self.alphaCollectionViewHeight.constant = self.alphaViewHeight.constant
                self.golfLeagueTableHeight.constant = self.golfsLeagueTableview.contentSize.height
                //Added by kiran V2.9 -- ENGAGE0012268 -- Lightning Warning button height adjustment
                //ENGAGE0012268 -- Start
                self.teeTimesView.constant = 1488 + self.recentNewsTableview.contentSize.height + self.alphaViewHeight.constant + self.golfLeagueTableHeight.constant + (self.viewLightningInfo.isHidden ? 0 : self.lightningBtnHeightAdjustment)
                //ENGAGE0012268 -- End
                
            }
            else
            {
                self.alphaViewHeight.constant = self.aliphaReportsCollectionView.contentSize.height
                self.alphaCollectionViewHeight.constant = self.alphaViewHeight.constant
                self.golfLeagueTableHeight.constant = self.golfsLeagueTableview.contentSize.height
                
                //Added by kiran V2.9 -- ENGAGE0012268 -- Lightning Warning button height adjustment
                //ENGAGE0012268 -- Start
                self.teeTimesView.constant = 1650 + self.recentNewsTableview.contentSize.height + self.alphaViewHeight.constant + self.golfLeagueTableHeight.constant + (self.viewLightningInfo.isHidden ? 0 : self.lightningBtnHeightAdjustment)
                //ENGAGE0012268 -- End
            }
           // teeTimesView.constant = 1360 + recentNewsTableview.contentSize.height
        }
    }
    
    func playHistoryDetails(){
        
        if let m = response?.countBooking.map({ (booking) -> String in
            return booking.monthYear
        }) {
            months = m
        }
        
        if let m = response?.countBooking.map({ (booking) -> Double in
            return Double(booking.count)
        }) {
            unitsSold = m
        }
        let frame = CGRect(x: 0, y: 0, width: 4 * 74, height: Int(chartScrollView.frame.height))
        lineChartView = LineChartView(frame: frame)
        chartScrollView.contentSize = frame.size
        chartScrollView.addSubview(lineChartView)
        
        self.lineChartView.delegate = self
        
        self.lineChartView.noDataText = ""
        
        self.lineChartView.backgroundColor = UIColor.clear
//        self.chartView.backgroundColor = UIColor(red: 64/255, green: 178/255, blue: 230/255, alpha: 1.0)
        self.monthsView.layer.shadowColor = UIColor.black.cgColor
        self.monthsView.layer.shadowOpacity = 0.09
        
        self.monthsView.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.monthsView.layer.shadowRadius = 2
        
        
        loadMonths(at: 0)
        
    }
    func loadMonths(at: Int) {
        if at >= 0,
            at <= months.count - 4 {
            index = at
            let targetMonths = Array(months[index..<(index+4)])
            let targetUnits = Array(unitsSold[index..<(index+4)])
            lineChartView.clear()
            lineChartView.clearValues()
            lineChartView.clearAllViewportJobs()
            lineChartView.resetViewPortOffsets()
            setChartData(dataPoints: targetMonths, values: targetUnits)
        }
    }
    
    func setChartData(dataPoints: [String], values: [Double]) {        // 1 - creating an array of data entries
        var dataEntries: [ChartDataEntry] = []
        
        
        for i in 0 ..< dataPoints.count {
            
            dataEntries.append(ChartDataEntry(x: Double(i), y: values[i]))
            
            valueColors.append(colorPicker(value: values[i]))
            
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: nil)
        lineChartDataSet.axisDependency = .right
        lineChartDataSet.setColor(UIColor.white)
        lineChartDataSet.setCircleColor(UIColor.black) // our circle will be dark red
        
        
        lineChartView.xAxis.labelFont = UIFont(name:"Helvetica Neue", size: 14.0)!
        lineChartView.xAxis.labelTextColor = UIColor.white
        
        lineChartDataSet.lineWidth = 1.0
        lineChartDataSet.circleRadius = 4.2 // the radius of the node circle
        lineChartDataSet.fillAlpha = 1
        lineChartDataSet.fillColor = UIColor.white
        lineChartDataSet.highlightColor = UIColor.white
        lineChartDataSet.drawCircleHoleEnabled = true
        lineChartDataSet.circleHoleColor = UIColor.white
        //        lineChartDataSet.circleColors[1] = UIColor.red
        lineChartDataSet.valueFont = UIFont(name:"Helvetica Neue", size: 12.0)!
        lineChartDataSet.valueTextColor = UIColor.white

        lineChartDataSet.formLineDashLengths = [5.0, 12.5]
        var dataSets = [LineChartDataSet]()
    
        dataSets.append(lineChartDataSet)
  
        let lineChartData = LineChartData(dataSets: dataSets)
        
        lineChartView.data = lineChartData
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        lineChartData.setValueFormatter(formatter)
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.labelPosition = .top
        lineChartView.isUserInteractionEnabled = false
        
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.avoidFirstLastClippingEnabled = false
        lineChartView.xAxis.drawAxisLineEnabled = false
        
        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.drawGridLinesEnabled = false
        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.legend.enabled = false
        lineChartView.rightAxis.drawLabelsEnabled = false
        lineChartView.rightAxis.drawAxisLineEnabled = false
        
        
        
        lineChartView.pinchZoomEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        
        lineChartView.xAxis.avoidFirstLastClippingEnabled = false
        lineChartView.xAxis.yOffset = 40.0
        lineChartView.setViewPortOffsets(left: 40, top: 60, right: 40, bottom: 0)
    }
    
    func colorPicker(value : Double) -> UIColor {
        
        //input your own logic for how you actually want to color the x axis
        
        return UIColor.red
        
    }
    
    func loadData() {
        if let responseFileURL = Bundle.main.url(forResource: "document", withExtension: "json"),
            let responseData = try? Data(contentsOf: responseFileURL) {
            do {
                response = try JSONDecoder().decode(AnualCourtBookingsResponse.self, from: responseData)
            }
            catch(let error) {
                print(error)
            }
        }
        
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let params: [String : Any] = [
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kCategory : "Golf"
                ]
            
            APIHandler.sharedInstance.annualPlayHistoryDetails(paramater: params, onSuccess: { (AnnualPlayresponse) in
                
                self.response = AnnualPlayresponse
                self.playHistoryDetails()
                self.appDelegate.hideIndicator()

            }) { (error) in
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
                self.appDelegate.hideIndicator()
                
            }
        
        
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
//    func getTimeSlotsForDate(dateString: String) {
//        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
//        
//        let paramaterDict: [String : Any] = [
//            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
//            APIKeys.kdeviceInfo: [APIHandler.devicedict],
//            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
//            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
//            "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
//            "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!,
//            "ReservationRequestDate": dateString
//        ]
//        
//        APIHandler.sharedInstance.GetFCFSCourcesAvailabilityTimeList(paramater: paramaterDict , onSuccess: { response in
////            print(response)
//            if(response.responseCode == InternetMessge.kSuccess) {
//                
//            }
//            
//        }) { (error) in
//            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
//            self.appDelegate.hideIndicator()
//            
//        }
//    }
    
    func requestReservationApi() {
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        let paramaterDict: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
            "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!
        ]
        
        APIHandler.sharedInstance.getReservationSettings(paramater: paramaterDict , onSuccess: { response in
            
            
            
            self.appDelegate.arrGolfSettings = response.golfSettings
            self.appDelegate.arrTennisSettings = response.tennisSettings
            self.appDelegate.arrDiningSettings = response.dinningSettings
            print(response.dinningSettings)
            self.gotoGolfRequest()
            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            self.gotoGolfRequest()
            self.appDelegate.hideIndicator()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initController()
        self.navigationItem.title = self.appDelegate.masterLabeling.tee_times ?? "" as String
        self.lblRecentNews.text = self.appDelegate.masterLabeling.recent_news ?? "" as String
        self.lblInstructionalVideos.text = self.appDelegate.masterLabeling.instructional_videos ?? "" as String
        self.lblUpComingEvents.text = self.appDelegate.masterLabeling.up_coming_golf_events ?? "" as String
        btnTournament .setTitle(self.appDelegate.masterLabeling.tournament_forms, for: .normal)
        lblCalendarofEvents .setTitle(self.appDelegate.masterLabeling.calendar_title, for: .normal)
        btnrules .setTitle(self.appDelegate.masterLabeling.rules_etiquettes, for: .normal)
        btnViewAll .setTitle(self.appDelegate.masterLabeling.vIEW_ALL, for: .normal)
        self.appDelegate.dateSortToDate = ""
        self.appDelegate.dateSortFromDate = ""
        //NOTE:- Removed as its causing the below issue
        //after going to calendar and swiped right(not completely) to dismiss and let go without dismissing then the titles of the screen is changing to golf even when going from tennis / dining.
        //self.appDelegate.typeOfCalendar = ""

        self.navigationController?.navigationBar.isHidden = false
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
    }
   

    
    func initController(){
        
        self.imgImpContacts.layer.cornerRadius = 12
        self.lblCalendarofEvents.layer.borderWidth = 1
        self.lblCalendarofEvents.layer.borderColor = hexStringToUIColor(hex: "F06C42").cgColor
        self.lblCalendarofEvents.setStyle(style: .outlined, type: .primary)
        
        self.btnTournamentForms.layer.borderWidth = 1
        self.btnTournamentForms.layer.borderColor = hexStringToUIColor(hex: "F06C42").cgColor
        self.btnTournamentForms.setStyle(style: .outlined, type: .primary)
        
        self.btnReqTeeTime.layer.cornerRadius = 18
        self.btnReqTeeTime.layer.borderWidth = 1
        self.btnReqTeeTime.layer.borderColor = hexStringToUIColor(hex: "F06C42").cgColor
        self.btnReqTeeTime.setTitle(self.appDelegate.masterLabeling.request_tee_time, for: UIControlState.normal)
        self.btnReqTeeTime.setStyle(style: .outlined, type: .primary)
        
        self.btnViewAll.layer.borderWidth = 1
        self.btnViewAll.layer.borderColor = hexStringToUIColor(hex: "F06C42").cgColor
        self.btnTournament.layer.borderWidth = 1
        self.btnTournament.layer.borderColor = hexStringToUIColor(hex: "FFFFFF").cgColor
        self.btnViewAll.setStyle(style: .outlined, type: .primary)
        self.btnTournament.setStyle(style: .outlined, type: .primary)


        imgUpcomingEvents.layer.cornerRadius = 30
        imgUpcomingEvents.layer.borderWidth = 1
        imgUpcomingEvents.layer.masksToBounds = true
        imgUpcomingEvents.layer.borderColor = hexStringToUIColor(hex: "a7a7a7").cgColor


        
        recentNewsTableview.layer.shadowColor = UIColor.black.cgColor
        recentNewsTableview.layer.shadowOpacity = 0.16
        recentNewsTableview.layer.masksToBounds = false

        recentNewsTableview.layer.shadowOffset = CGSize.zero
        recentNewsTableview.layer.shadowRadius = 2
        
        self.lblMemberNameAndID.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)

        //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL button Setup
        //GATHER0001167 -- Start
        let hideBookLessonBtn = !(DataManager.shared.enableGolfLession == "1")
        self.btnBookALesson.isHidden = hideBookLessonBtn
        self.btnBookALesson.setStyle(style: .outlined, type: .primary, cornerRadius: 18)
        self.btnBookALesson.layer.borderWidth = 1.0
        self.btnBookALesson.titleLabel?.font = AppFonts.semibold22
        self.btnBookALesson.setTitle(self.appDelegate.masterLabeling.BMS_Golf_ButtonText ?? "", for: .normal)
        //GATHER0001167 -- End
      
    }
    
    @objc func golfMember(sender : UITapGestureRecognizer) {
        
        //Added on 17th July 2020 V2.2
        //Added for roles adn privilages
        switch self.accessManager.accessPermision(for: .memberDirectory)
        {
        case .notAllowed:
            
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        default:
            break
        }
        
        if let golfMemberDirectory = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MemberDirectoryViewController") as? MemberDirectoryViewController {
             golfMemberDirectory.isFrom = "TeeTimes"
            golfMemberDirectory.isFromDashBoard = true

            self.navigationController?.pushViewController(golfMemberDirectory, animated: true)
        }
        
    }
    
    //Added by Kiran V2.9 -- GATHER0001167 -- Golf BAL button Action
    @IBAction func BookALessonClicked(_ sender: UIButton)
    {
        self.getDepartmentDetails()
    }
    
    @objc func importantContacts(sender : UITapGestureRecognizer) {
        if let impVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ImpotantContactsVC") as? ImpotantContactsVC {
            impVC.importantContactsDisplayName = self.ClubNewsDetails?.importantContacts[0].displayName ?? ""

            impVC.modalTransitionStyle   = .crossDissolve;
            impVC.modalPresentationStyle = .overCurrentContext
            self.present(impVC, animated: true, completion: nil)
        }
    }
    
    @objc func upComingEventsCliked(sender : UITapGestureRecognizer)
    {
        //Added by kiran V1.4 --PROD0000069-- Club News - Addeds uport for upcoming event flyer click
        //PROD0000069 -- Start
        if let eventDetails = self.ClubNewsDetails?.upComingEvent.first, eventDetails.enableRedirectClubNewsToEvents == 1
        {
            self.showEventScreenFromFlyer(event: eventDetails)
        }
        else
        {
            if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ViewNewsViewController") as? ViewNewsViewController
            {
                clubNews.modalTransitionStyle   = .crossDissolve;
                clubNews.modalPresentationStyle = .overCurrentContext
                
                clubNews.isFrom = "Events"

                if (self.ClubNewsDetails?.upComingEvent.count != 0) {
                    
                    //Added on on 14th May 2020  v2.1
                    let mediaDetails = MediaDetails()
                    mediaDetails.type = .image
                    mediaDetails.newsImage = self.ClubNewsDetails?.upComingEvent[0].image ?? ""
                    clubNews.arrMediaDetails = [mediaDetails]
                    
                    //old logic
                    //clubNews.arrImgURl = [[ "NewsImage" : self.ClubNewsDetails?.upComingEvent[0].image ?? ""]]
                    //clubNews.imgURl = self.ClubNewsDetails?.upComingEvent[0].image
                    
                    //Added on 19th May 2020  v2.1
                    clubNews.contentType = .image
                    self.present(clubNews, animated: true, completion: nil)

                }
                else
                {
                    
                }
            }
            
        }
        //PROD0000069 -- End

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
    
    
    @IBAction func shareClicked(_ sender: Any) {
        if let share = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ShareViewController") as? ShareViewController {
            share.modalTransitionStyle   = .crossDissolve;
            share.modalPresentationStyle = .overCurrentContext
            //Old Logic
            //share.isFrom = "Events"
            //share.imgURl = self.ClubNewsDetails?.upComingEvent[0].imgthumb
            
            //Added on 19th May 2020 v2.1
            share.contentType = .events
            share.contentDetails = ContentDetails.init(id: self.ClubNewsDetails?.upComingEvent[0].imgthumb, date: nil, name: nil, link: self.ClubNewsDetails?.upComingEvent[0].imgthumb)
            self.present(share, animated: true, completion: nil)
        }
    }
    
    //MARK:- Get Golf Details  Api

    func loadTeeTimeDetails() {
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        let params: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            
        ]
        
        APIHandler.sharedInstance.teeTimeDetails(paramater: params, onSuccess: { (response) in
            
            
            self.ClubNewsDetails = response

            let placeHolderImage = UIImage(named: "Icon-App-40x40")
            if (self.ClubNewsDetails?.upComingEvent.count != 0)
            {
                //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
                //ENGAGE0011419 -- Start
                let imageURLString2 = self.ClubNewsDetails?.upComingEvent[0].imgthumb ?? ""
                
                if imageURLString2.isValidURL()
                {
                    self.isUpcomingEventHidded = false
                    if (UserDefaults.standard.string(forKey: UserDefaultsKeys.shareUrl.rawValue) == "1")
                    {
                    
                    }
                    else
                    {
                    
                    }

                    let url = URL.init(string:imageURLString2)
                    self.imgUpcomingEvents.sd_setImage(with: url , placeholderImage: placeHolderImage)
                    self.appDelegate.hideIndicator()

                }
                else
                {
                    self.isUpcomingEventHidded = true
                    self.lblUpComingEvents.isHidden = true
                }
                /*
                if(imageURLString2 != nil)
                {
                    let validUrl = self.verifyUrl(urlString: imageURLString2)
                    if(validUrl == true)
                    {
                        self.isUpcomingEventHidded = false
                        if (UserDefaults.standard.string(forKey: UserDefaultsKeys.shareUrl.rawValue) == "1")
                        {
                        
                        }
                        else
                        {
                        
                        }

                        let url = URL.init(string:imageURLString2!)
                        self.imgUpcomingEvents.sd_setImage(with: url , placeholderImage: placeHolderImage)
                        self.appDelegate.hideIndicator()

                    }
                    else
                    {
                        self.isUpcomingEventHidded = true
                        self.lblUpComingEvents.isHidden = true
                    }
                }
                */
                //ENGAGE0011419 -- End
            }
            else{
                self.isUpcomingEventHidded = true
                self.lblUpComingEvents.isHidden = true

            }
            
            if (self.ClubNewsDetails?.memberDirectory.count != 0) {

            self.lblMemberDirectory.text = self.ClubNewsDetails?.memberDirectory[0].displayName
                if self.ClubNewsDetails?.instructionalVideos.count == 0 {
                    self.collectionViewIV.setEmptyMessage(InternetMessge.kNoData)

                }
            
                //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
                //ENGAGE0011419 -- Start
                let imageURLString = self.ClubNewsDetails?.memberDirectory[0].icon2X ?? ""
                 
                if imageURLString.isValidURL()
                {
                    let url = URL.init(string:imageURLString)
                    self.imgGolfMemberdirectory.sd_setImage(with: url , placeholderImage: placeHolderImage)
                    self.appDelegate.hideIndicator()
                }
                /*
                if(imageURLString != nil)
                {
                    let validUrl = self.verifyUrl(urlString: imageURLString)
                    if(validUrl == true)
                    {
                        let url = URL.init(string:imageURLString!)
                        self.imgGolfMemberdirectory.sd_setImage(with: url , placeholderImage: placeHolderImage)
                        self.appDelegate.hideIndicator()
                    }
                }
                */
                //ENGAGE0011419 -- End
            }
            //Added by kiran V2.9 -- ENGAGE0012268 -- Lightning Warning button height adjustment
            //ENGAGE0012268 -- Start
            self.viewLightningInfo.isHidden = (self.ClubNewsDetails?.lightningUrl ?? "").isEmpty
            self.view.layoutIfNeeded()
            //ENGAGE0012268 -- End
            self.aliphaReportsCollectionView.reloadData()
            self.recentNewsTableview.reloadData()

            self.recentNewsTableview.invalidateIntrinsicContentSize()
            self.collectionViewIV.reloadData()
            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            self.appDelegate.hideIndicator()
            
        }
    }

    @IBAction func viewAllClicked(_ sender: Any) {
       
        if let allClubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AllClubNewsViewController") as? AllClubNewsViewController {
            allClubNews.isFrom = "TeeTimes"
            self.navigationController?.pushViewController(allClubNews, animated: true)
            
        }
    }
    @IBAction func calendarOfEventsClicked(_ sender: Any) {
        
        
        if let golf = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "GolfCalendarVC") as? GolfCalendarVC {
            self.appDelegate.buddyType = "First"
            self.appDelegate.typeOfCalendar = "Golf"
            self.navigationController?.pushViewController(golf, animated: true)
            
        }
    }
    
    //Added by kiran V2.9 -- ENGAGE0012268 -- Lightning Warning button action
    //ENGAGE0012268 -- Start
    @IBAction func btnLightningInfoClicked(_ sender: UIButton)
    {
        if let strLightningURL = self.ClubNewsDetails?.lightningUrl, strLightningURL.isValidURL(), let lightningURL = URL.init(string: strLightningURL)
        {
            UIApplication.shared.open(lightningURL)
        }
    }
    //ENGAGE0012268 -- End
    
    //MARK:- Tableview delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == golfsLeagueTableview {
          return appDelegate.arrGolfLeagues.count
        }else{
        return  ClubNewsDetails?.clubNews.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == golfsLeagueTableview {
            let cell:GolfLeaguesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GolfLeaguesTableViewCell") as! GolfLeaguesTableViewCell
            
            cell.selectionStyle = .none
            
            cell.btnLeague.layer.borderWidth = 1
            cell.btnLeague.layer.borderColor = hexStringToUIColor(hex: "F06C42").cgColor

            cell.btnLeague.setTitle(self.appDelegate.arrGolfLeagues[indexPath.row].text, for: UIControlState.normal)
            cell.btnLeague.setStyle(style: .outlined, type: .primary)
            cell.delegate = self
            self.view.setNeedsLayout()
            return cell
        }else{
        let cell:RecentNewsCustomCell = tableView.dequeueReusableCell(withIdentifier: "RecentNewsID") as! RecentNewsCustomCell
       
        
       
        if let recentNews = ClubNewsDetails?.clubNews[indexPath.row]
        {
            
            cell.lblNews.text = recentNews.newsTitle
            cell.lblNewsDate.text = recentNews.date
        }
        
        if isUpcomingEventHidded == true
        {
            self.lblUpComingEvents.isHidden = true
            self.heightUpcomingEvent.constant = 0
            self.heightUpcomingLabel.constant = 0
            self.heightUpcomingTop.constant = 0

            heightRecentNewsTable.constant = recentNewsTableview.contentSize.height

            //Added by kiran V2.9 -- ENGAGE0012268 -- Lightning Warning button height adjustment
            //ENGAGE0012268 -- Start
            self.teeTimesView.constant = 1100 + self.recentNewsTableview.contentSize.height + (self.viewLightningInfo.isHidden ? 0 : self.lightningBtnHeightAdjustment)
            //ENGAGE0012268 -- End
        }
        else
        {
            self.lblUpComingEvents.isHidden = false

            heightRecentNewsTable.constant = recentNewsTableview.contentSize.height
            //Added by kiran V2.9 -- ENGAGE0012268 -- Lightning Warning button height adjustment
            //ENGAGE0012268 -- Start
            teeTimesView.constant = 1360 + recentNewsTableview.contentSize.height + (self.viewLightningInfo.isHidden ? 0 : self.lightningBtnHeightAdjustment)
            //ENGAGE0012268 -- End
        }
        self.view.setNeedsLayout()
        return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.recentNewsTableview
        {
            //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
            //PROD0000069 -- Start
            if let clubnews = ClubNewsDetails?.clubNews[indexPath.row] , clubnews.enableRedirectClubNewsToEvents == 1
            {
                self.navigateToEventsScreen(selectedNews: clubnews)
            }
            else
            {
                //Added on 14th May 2020  v2.1
                if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ViewNewsViewController") as? ViewNewsViewController
                {
                    clubNews.modalTransitionStyle   = .crossDissolve;
                    clubNews.modalPresentationStyle = .overCurrentContext
                    clubNews.arrMediaDetails = self.appDelegate.imageDataToMediaDetails(list: ClubNewsDetails?.clubNews[indexPath.row].newsImageList)
                    
                    //Added on 19th May 2020  v2.1
                    clubNews.contentType = .clubNews
                    clubNews.contentDetails = ContentDetails.init(id: ClubNewsDetails?.clubNews[indexPath.row].id, date: ClubNewsDetails?.clubNews[indexPath.row].date, name: ClubNewsDetails?.clubNews[indexPath.row].newsTitle, link: nil)
                    self.present(clubNews, animated: true, completion: nil)
                }
                
            }
            //PROD0000069 -- End
            
            //Old logic
            /*
            if  (ClubNewsDetails?.clubNews[indexPath.row].newsVideoURL == "")
            {
                if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ViewNewsViewController") as? ViewNewsViewController
                {
                    clubNews.modalTransitionStyle   = .crossDissolve;
                    clubNews.modalPresentationStyle = .overCurrentContext
                    //clubNews.imgURl = ClubNewsDetails?.clubNews[indexPath.row].newsImage

                    self.present(clubNews, animated: true, completion: nil)
                }
                
            }
            else
            {
                
                if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "VideoViewController") as? VideoViewController
                {
                    clubNews.modalTransitionStyle   = .crossDissolve;
                    clubNews.modalPresentationStyle = .overCurrentContext
                    clubNews.videoURL = ClubNewsDetails?.clubNews[indexPath.row].newsVideoURL.videoID
                    
                    self.present(clubNews, animated: true, completion: nil)
                }
                
            }
            */
            
        }
        
        
    }

    
//MARK:- Collection View delegtae
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewIV {
        return ClubNewsDetails?.instructionalVideos.count ?? 0
        }else{
            if self.ClubNewsDetails?.reservationDateList.count == 0 || self.ClubNewsDetails?.reservationDateList.count == nil {
                return 0
            }else{
                return self.ClubNewsDetails?.reservationDateList.count ?? 0
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
         if collectionView == collectionViewIV {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCell", for: indexPath as IndexPath) as! CustomDashBoardCell
        
        if let instructionalVideos = ClubNewsDetails?.instructionalVideos[indexPath.row]
        {
            cell.videoWkWebview.scrollView.isScrollEnabled = false
            cell.imgInstructionalVideos.isHidden = true
            let videoURL = instructionalVideos.videoURL
            
            //Added by kiran V1.3 --PROD0000033-- Adding support for Youtube videos.
            //PROD0000033 -- Start
            if let url = URL(string: videoURL)//videoURL != nil || videoURL == ""
            {
                let requestObj = URLRequest(url: url)
                cell.videoWkWebview.load(requestObj)
                
                //Old Logic
                /*
                let url = URL (string: ("https://player.vimeo.com/video/") + (videoURL.videoID ?? ""))
                let requestObj = URLRequest(url: url!)
                cell.videoWkWebview.load(requestObj)
                */
                
                //PROD0000033 -- End
                
            }
            else
            {
                let url = URL (string: ("https://player.vimeo.com/video/"))
                let requestObj = URLRequest(url: url!)
                cell.videoWkWebview.load(requestObj)
            }
           // cell.imgInstructionalVideos.image = UIImage(named: "Group 1429")!
//            let placeholder:UIImage = UIImage(named: "Icon-App-40x40")!
            
//            let imageURLString = instructionalVideos.imageThumbnail
//            if(imageURLString != nil){
//                let validUrl = self.verifyUrl(urlString: imageURLString)
//                if(validUrl == true){
//                    let url = URL.init(string:imageURLString)
//                    cell.imgInstructionalVideos.sd_setImage(with: url , placeholderImage: placeholder)
//                }
//            }
//            else{
//                //   let url = URL.init(string:imageURLString)
//                cell.imgImageView.image = UIImage(named: "")!
//            }
            //  self.collectionViewHeight.constant = self.dashBoardCollectionView.contentSize.height;
            
            //Added by kiran V3.0 -- ENGAGE0012360 -- fixes the issue where video playes automitically with the app is left idle for 1+hrs
            //ENGAGE0012360 -- Start
            cell.videoWkWebview.configuration.mediaTypesRequiringUserActionForPlayback = [.audio,.video]
            //ENGAGE0012360 -- End
            
            return cell

        }
         }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCell", for: indexPath as IndexPath) as! CustomDashBoardCell
            
            cell.alphaView.layer.shadowColor = UIColor.lightGray.cgColor
            cell.alphaView.layer.shadowOpacity = 1.0
            cell.alphaView.layer.shadowOffset = CGSize(width: 2, height: 2)
            cell.alphaView.layer.shadowRadius = 1
            
            cell.alphaView.layer.cornerRadius = 12
            if let reports = self.ClubNewsDetails?.reservationDateList[indexPath.row]{
            
            cell.lblDate.text = reports.date
            cell.lblMonthName.text = reports.month
                
            }
            self.view.setNeedsLayout()

            cell.lblDate.textColor = APPColor.textColor.secondary
            return cell

        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        if collectionView == aliphaReportsCollectionView{
        let reports = self.ClubNewsDetails?.reservationDateList[indexPath.row]

        let golfRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "AlphaReportsVC") as! AlphaReportsVC
            golfRequest.date = reports?.lotteryDate
            
        self.navigationController?.pushViewController(golfRequest, animated: true)
        }
    }
//
    func imgViewClicked(cell: CustomDashBoardCell) {
        
//        let indexPath = self.collectionViewIV.indexPath(for: cell)
//
//        if let instructionalVideos = ClubNewsDetails?.instructionalVideos[indexPath!.row]
//        {
//            cell.instructionalVideo.isHidden = false
//
//            let videoURL = instructionalVideos.videoURL
//            let url = URL (string: ("https://player.vimeo.com/video/") + (videoURL.videoID ?? ""))
//            cell.instructionalVideo.mediaPlaybackRequiresUserAction = false
//            cell.instructionalVideo.scrollView.bounces = false
//
//            cell.instructionalVideo.scrollView.isScrollEnabled = false
//            let requestObj = NSURLRequest(url: url!)
//            cell.instructionalVideo.loadRequest(requestObj as URLRequest)
//        }
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tournamentClicked(_ sender: Any) {


    }
    
    @IBAction func requestTeetimesClicked(_ sender: Any) {
        
        self.requestReservationApi()
    }
    
    func gotoGolfRequest(){
        let golfRequest = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "GolfRequestTeeTimeVC") as! GolfRequestTeeTimeVC
        
        self.navigationController?.pushViewController(golfRequest, animated: true)
    }
    @IBAction func RulesClicked(_ sender: Any) {
        
        let restarantpdfDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
      //  restarantpdfDetailsVC.pdfUrl = (self.ClubNewsDetails?.rulesEtiquette[0].URL) ?? ""
        if self.ClubNewsDetails?.rulesEtiquette.count == 0 {
            restarantpdfDetailsVC.pdfUrl = ""
            restarantpdfDetailsVC.restarantName =  self.appDelegate.masterLabeling.rules_etiquettes!

        }else{
        restarantpdfDetailsVC.pdfUrl = (self.ClubNewsDetails?.rulesEtiquette[0].URL) ?? ""
        restarantpdfDetailsVC.restarantName = (self.ClubNewsDetails?.rulesEtiquette[0].title) ?? ""
        }
        self.navigationController?.pushViewController(restarantpdfDetailsVC, animated: true)
    }
    @IBAction func previousClicked(_ sender: Any) {
        loadMonths(at: index - 1)

    }
    @IBAction func nextClicked(_ sender: Any) {
        loadMonths(at: index + 1)

    }
    @IBAction func tournamentFormsClicked(_ sender: Any) {
        
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "menu": self.appDelegate.masterLabeling.tournament_forms ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                
                ]
            
            print("memberdict \(paramaterDict)")
            APIHandler.sharedInstance.getLeagueUrl(paramater: paramaterDict, onSuccess: { (response) in
                
                self.appDelegate.hideIndicator()
                
                
                guard let url = URL(string: response.filePath) else { return }
                UIApplication.shared.open(url)
            }) { (error) in
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
                self.appDelegate.hideIndicator()
            }
        }
    }
    
}
extension TeeTimesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let edgeInsets = (view.frame.size.width/2) - 91

        if ClubNewsDetails?.instructionalVideos.count == 1 {
            
            return UIEdgeInsetsMake(0, edgeInsets, 0, edgeInsets)
        }else{
            return UIEdgeInsetsMake(0, 0, 0, 0)

        }
        
        
    }
    
}

extension TeeTimesViewController : leagues{
   
    func leaguesButtonClicked(cell: GolfLeaguesTableViewCell) {
        
        let indexPath = self.golfsLeagueTableview.indexPath(for: cell)

        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)

            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "menu": self.appDelegate.arrGolfLeagues[(indexPath?.row)!].value ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict],

                ]

            //print("memberdict \(paramaterDict)")
            APIHandler.sharedInstance.getLeagueUrl(paramater: paramaterDict, onSuccess: { (response) in

                self.appDelegate.hideIndicator()
        

                guard let url = URL(string: response.filePath) else { return }
                UIApplication.shared.open(url)
            }) { (error) in
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
                self.appDelegate.hideIndicator()
            }
        }

       
        
    }
    
    
}

//Added by kiran v2.9 -- GATHER0001167 -- Golf BAL releated Functions
//GATHER0001167 -- Start
//MARK:- API Methods
extension TeeTimesViewController
{
    private func getDepartmentDetails()
    {
        guard Network.reachability?.isReachable == true else {
            CustomFunctions.shared.showToast(WithMessage: InternetMessge.kInternet_not_available, on: self.view)
            return
            
        }
        
        let paramaterDict:[String: Any] = [
            "Content-Type":"application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kAppointmentDetailID : self.appDelegate.bookingAppointmentDetails.appointmentID ?? "",
            APIKeys.kDepartment : BMSDepartment.golfBookALesson.rawValue
        ]
        
        CustomFunctions.shared.showActivityIndicator(withTitle: "", intoView: self.view)
        APIHandler.sharedInstance.getDepartmentDetails(paramater: paramaterDict, onSuccess: { [weak self] (departments) in
           
            if let department = (departments.departmentsDetails ?? [DepartmentDetails]()).first
            {
                self?.appDelegate.bookingAppointmentDetails = BMSAppointmentDetails()
                self?.appDelegate.bookingAppointmentDetails.requestScreenType = .request
                self?.appDelegate.bookingAppointmentDetails.department = department
                self?.appDelegate.BMSOrder.removeAll()
                self?.appDelegate.BMSOrder.append(contentsOf: department.appointmentFlow!)
                self?.StartBookingFlow()
            }
            
            CustomFunctions.shared.hideActivityIndicator()
        }) { [weak self] (error) in
            CustomFunctions.shared.handleRequestError(error: error, ShowToastOn: self?.view)
        }
        
        
    }
}

//MARK:- Custom Methods
extension TeeTimesViewController
{
    
    //Added by kiran V2.9 -- ENGAGE0012268 -- view customizations and font,color changes methods. These methods will also handle dark mode/ light mode chanegs.
    //ENGAGE0012268 -- Start
    private func initialSetups()
    {
        self.viewLightningInfo.isHidden = true
        self.applyFont()
        self.applyColor()
        self.applyViewCustomizations()
        self.applyLanguageFileData()
    }
    
    //Note:- Any color releated change to the customization should be handled here. Those colors should not be set in applyColor function.
    private func applyViewCustomizations()
    {
        //TODO:- Add dark mode support for color chanegs in this function
        self.btnLightningInfo.setStyle(style: .outlined, type: .primary)
        //NOTE:- Applied these as in this screen 2 types of orange shades are being used. The shade set in obkve function is not same as the calendar button share so applying darker shade.
//        self.btnLightningInfo.setTitleColor(hexStringToUIColor(hex: "#F06C42"), for: .normal)
//        self.btnLightningInfo.layer.borderColor = hexStringToUIColor(hex: "#F06C42").cgColor
    }
    
    private func applyFont()
    {
        self.btnLightningInfo.titleLabel?.font = AppFonts.semibold22
    }
    
    //Note:- Any colors releated change to the customization should be handled in applyViewCustomizations() function. i.e, for e.g., in case of button the border color, backgroung color and text color is appled in custom function hence those should not be applied here as they are related to view customization and change with button type.
    private func applyColor()
    {
        if #available(iOS 13.0,*)
        {
            //NOTE:- Apple colors separately for darn and light mode. for light mode use APPColor and for dark mode use APPColorDarkMode. any color added should be added to both the structs with same name.
            switch self.traitCollection.userInterfaceStyle
            {
            case .unspecified,.light:
                self.viewLightningInfo.backgroundColor = .clear
            case .dark:
                self.viewLightningInfo.backgroundColor = .clear
            }
            
        }
        else
        {
            self.viewLightningInfo.backgroundColor = .clear
        }
    }
    
    //This called when ever trait collection has any changes. Apply colors again to support Dark/Light Mode
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?)
    {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.applyColor()
    }
    
    //Apples language file data.
    private func applyLanguageFileData()
    {
        self.btnLightningInfo.setTitle(self.appDelegate.masterLabeling.Golf_LWS ?? "", for: .normal)
    }
    
    //ENGAGE0012268 -- End
    
    
    private func StartBookingFlow()
    {
        
        switch self.appDelegate.BMSOrder.first?.contentType ?? .none
        {
        case .services , .providers , .departments:
            
            guard let vc = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "FitnessRequestListingViewController") as? FitnessRequestListingViewController else {
                return
            }
            
            vc.contentType = (self.appDelegate.BMSOrder.first?.contentType)!
            vc.BMSBookingDepartment = .golfBookALesson
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .serviceType:
            
             guard let serviceTypeVC = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "ServiceTypeViewController") as? ServiceTypeViewController else{return}
            
            serviceTypeVC.BMSBookingDepartment = .golfBookALesson
            serviceTypeVC.modalPresentationStyle = .fullScreen
                       
            self.navigationController?.pushViewController(serviceTypeVC, animated: true)
            
        case .requestScreen:
            
            guard let requestVC = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "SpaAndFitnessRequestVC") as? SpaAndFitnessRequestVC else {
                return
                
            }
            
            requestVC.requestType = self.appDelegate.bookingAppointmentDetails.requestScreenType
            
            requestVC.BMSBookingDepartment = .golfBookALesson
            requestVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(requestVC, animated: true)
            
        case .none:
            break
            
        }
    }
    
}
//GATHER0001167 -- End

//Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
//PROD0000069 -- Start
extension TeeTimesViewController : RegisterEventVCDelegate
{
    //Added by kiran V1.4 --PROD0000069-- Club News - Added supoprt to upcoming event flyer image click.
    //PROD0000069 -- Start
    private func navigateToEventsScreen(selectedNews : RecentNews)
    {
        let eventDetails = EventNavDetails()
        eventDetails.eventCategory = selectedNews.eventCategory
        eventDetails.isMemberTgaEventNotAllowed = selectedNews.isMemberTgaEventNotAllowed
        eventDetails.eventID = selectedNews.eventID
        eventDetails.isMemberCalendar = selectedNews.isMemberCalendar
        eventDetails.requestID = selectedNews.requestID
        eventDetails.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID
        eventDetails.enableRedirectClubNewsToEvents = selectedNews.enableRedirectClubNewsToEvents
        eventDetails.eventValidationMessage = selectedNews.eventValidationMessage
        eventDetails.eventName = selectedNews.eventName
        eventDetails.eventstatus = selectedNews.eventstatus
        eventDetails.externalURL = selectedNews.externalURL
        eventDetails.colorCode = selectedNews.colorCode
        eventDetails.buttontextvalue = selectedNews.buttontextvalue
        
        self.showEventScreen(selectedNews: eventDetails)
    }
    
    private func showEventScreenFromFlyer(event : UpComing)
    {
        let eventDetails = EventNavDetails()
        eventDetails.eventCategory = event.eventCategory
        eventDetails.isMemberTgaEventNotAllowed = event.isMemberTgaEventNotAllowed
        eventDetails.eventID = event.eventID
        eventDetails.isMemberCalendar = event.isMemberCalendar
        eventDetails.requestID = event.requestID
        eventDetails.eventRegistrationDetailID = event.eventRegistrationDetailID
        eventDetails.enableRedirectClubNewsToEvents = event.enableRedirectClubNewsToEvents
        eventDetails.eventValidationMessage = event.eventValidationMessage
        eventDetails.eventName = event.eventName
        eventDetails.eventstatus = event.eventstatus
        eventDetails.externalURL = event.externalURL
        eventDetails.colorCode = event.colorCode
        eventDetails.buttontextvalue = event.buttontextvalue
        
        self.showEventScreen(selectedNews: eventDetails)
    }
    
    private func showEventScreen(selectedNews : EventNavDetails)
    {
        switch self.accessManager.accessPermission(eventCategory: selectedNews.eventCategory!, type: .events, departmentName: "")
        {
        case .view:
            break
        case .notAllowed:
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        case .allowed:
            break
        }
        //Commented by kiran V1.4 --PROD0000069--
        //PROD0000069 -- Start
        /*
        if let validationMessage = selectedNews.eventValidationMessage ,!validationMessage.isEmpty
        {
            let okAction = UIAlertAction.init(title: self.appDelegate.masterLabeling.clubNewsToEvents_OK ?? "", style: .default, handler: nil)
            CustomFunctions.shared.showAlert(title: "", message: validationMessage, on: self, actions: [okAction])
            //CustomFunctions.shared.showToast(WithMessage: validationMessage, on: self.view)
            return
        }*/
        //PROD0000069 -- End
        
        guard selectedNews.isMemberTgaEventNotAllowed != 1 else {
            SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.TGAMEMBERVALIDATION, withDuration: Duration.kMediumDuration)
            return
        }
        
        //Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for email to, external registerations, golf genious, No regterations and confirmes state.
        //PROD0000069 -- Start
        guard let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "RegisterEventVC") as? RegisterEventVC else{return}
        
        switch selectedNews.buttontextvalue ?? ""
        {
        // No buttons visible
        case "0":
            
            if let externalUrl = selectedNews.externalURL, !externalUrl.isEmpty
            {
                guard let url = URL(string: externalUrl) else { return }
                UIApplication.shared.open(url)
            }
            else
            {
                registerVC.eventID = selectedNews.eventID
                registerVC.eventCategory = selectedNews.eventCategory
                registerVC.eventType = selectedNews.isMemberCalendar
                registerVC.isViewOnly = true
                registerVC.isFrom = "EventUpdate"
                registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
                registerVC.showStatus = true
                registerVC.strStatus = selectedNews.eventstatus ?? ""
                registerVC.strStatusColor = selectedNews.colorCode ?? "#FFFFFF"
                registerVC.delegate = self
                registerVC.navigatedFrom = .golf
                self.navigationController?.pushViewController(registerVC, animated: true)
            }
        //3 is cancel, 4 is view only.
        case "3","4":
            
            registerVC.eventID = selectedNews.eventID
            registerVC.eventCategory = selectedNews.eventCategory
            registerVC.eventType = selectedNews.isMemberCalendar
            registerVC.isViewOnly = true
            registerVC.isFrom = "EventUpdate"
            registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
            registerVC.showStatus = true
            registerVC.strStatus = selectedNews.eventstatus ?? ""
            registerVC.strStatusColor = selectedNews.colorCode ?? "#FFFFFF"
            registerVC.delegate = self
            registerVC.navigatedFrom = .golf
            self.navigationController?.pushViewController(registerVC, animated: true)
        //1 is request, 2 is modify
        case "1","2":
            
            registerVC.eventID = selectedNews.eventID
            registerVC.eventCategory = selectedNews.eventCategory
            registerVC.eventType = selectedNews.isMemberCalendar
            registerVC.isFrom = "EventUpdate"
            registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
            registerVC.delegate = self
            registerVC.navigatedFrom = .golf
            self.navigationController?.pushViewController(registerVC, animated: true)
        //5 is for Golf genius
        case "5":
            guard let url = URL(string: selectedNews.externalURL ?? "") else { return }
            UIApplication.shared.open(url)
        //6 is for Email To
        case "6":
            
            let stremail = selectedNews.externalURL ?? ""
            let emailSubject = selectedNews.eventName ?? ""
            if(stremail == "")
            {
                
            }
            else
            {
                self.arrselectedEmails.removeAll()
                self.arrselectedEmails.append(stremail)
                
                let mailComposeViewController = configuredMailComposeViewController(subject: emailSubject)
                if MFMailComposeViewController.canSendMail()
                {
                    self.present(mailComposeViewController, animated: true, completion: nil)
                }
                else
                {
                    self.showSendMailErrorAlert()
                }
            }
            
        default :
            break
        }

        //Old logic
        /*
        if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "RegisterEventVC") as? RegisterEventVC
        {
            registerVC.eventID = selectedNews.eventID
            registerVC.eventCategory = selectedNews.eventCategory
            registerVC.eventType = selectedNews.isMemberCalendar
            registerVC.isFrom = "EventUpdate"
            registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
            registerVC.delegate = self
            registerVC.navigatedFrom = .golf
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
        */
        //PROD0000069 -- End
    }
    //PROD0000069 -- End
    
    func eventSuccessPopupClosed()
    {
        self.loadTeeTimeDetails()
    }
    
}
//PROD0000069 -- End

//Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for composing Emails
//PROD0000069 -- Start
extension TeeTimesViewController : MFMailComposeViewControllerDelegate
{
    func configuredMailComposeViewController(subject : String?) -> MFMailComposeViewController
    {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        mailComposerVC.setToRecipients(self.arrselectedEmails)
        mailComposerVC.setSubject(String(format: "%@ %@", subject ?? "",UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!))
        mailComposerVC.setMessageBody("", isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert()
    {
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        CustomFunctions.shared.showAlert(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", on: self, actions: [okAction])
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        controller.dismiss(animated: true, completion: nil)
    }
}
//PROD0000069 -- End
