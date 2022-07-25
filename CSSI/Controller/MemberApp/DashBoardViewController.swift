//
//  DashBoardViewController.swift
//  CSSI

//  Created by apple on 10/30/18.
//  Copyright © 2018 yujdesigns. All rights reserved.

import UIKit
import Alamofire
import AlamofireImage
import Popover
import PINRemoteImage
import ObjectMapper
import SwiftyJSON
import Fabric
import CoreLocation
import Gimbal
import CoreBluetooth
import AppTrackingTransparency
import MessageUI

class DashBoardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var bottomBarHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var dashBoardScrollview: UIScrollView!
    @IBOutlet weak var lblSendUsFeedback: UILabel!
    @IBOutlet weak var lblWeatherDescription: UILabel!
    @IBOutlet weak var lblWeatherReport: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnAllNews: UIButton!
    @IBOutlet weak var imgProfileImage: UIImageView!
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var dashBoardCollectionView: UICollectionView!
    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var lblClubNews: UILabel!
    @IBOutlet weak var lblClubNewsDate: UILabel!
    @IBOutlet weak var clubNewsView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var sendUsFeedbackView: UIView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    //Added by kiran -- ENGAGE0011226 -- Covid rules
    @IBOutlet weak var alertBtn: UIButton!
    //Added by kiran V2.7 --ENGAGE0011678 -- Disabling touches on dashbaord screen until dashboard api is a success
    //ENGAGE0011678 -- Start
    @IBOutlet weak var viewSocial: UIView!
    //ENGAGE0011678 -- End
    @IBOutlet weak var viewLinkToPrivateSiteHolder: UIView!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrfooterTabbar = [LandingMenus]()
    var btnNotificationBadge = UIButton()
    var arrNotifications = [NotificationsData]()
    var notificationCount = Int()
    var arrEventList = [ListEvents]()
    var arrClubNews = [ClubNews]()
    var currentVersion : String?
    
    var golfSettingsDetail : GolfSettings?
    var courtSettingsDetail : TennisSettings?
    var diningSettingsDetail : DinningSettings?
    var screenCodeName: String?
    var pageName: String?
    var isLogOut: String?
    var arrClubNewsDetails = [ClubNews]()
    var facebookLink: String?
    var instaLink: String?
    var twitterLink: String?
    var pinterestLink: String?
    var appToPrivateSiteLink: String?


    
    var height : CGFloat!
    var i : Int = 0
    var j : Int = 0
    var clubNewsTime : Double = 1
    var timer: Timer? = nil
    var count : Int?
    var floatt: Float?

    let apiKey = "aefcfa688b46287a25c254bc102c9465"
    
    
    let defaults = String()
    
    //Added on 4th July 2020 V2.2
    private let accessManager = AccessManager.shared
    
    //Added by kiran -- ENGAGE0011226 -- Covid rules
    private var alertTitle = ""

    var linkedInLink : String?
    
    //Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for composing Emails
    //PROD0000069 -- Start
    var arrselectedEmails = [String]()
    //PROD0000069 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Added by kiran V2.5 --ENGAGE0011344 -- Gimbal Integration
        //ENGAGE0011344 -- start
        //Commented by kiran V2.7 -- ENGAGE0011628 -- Commented beacuse this logic is moved to Dashboard api call
        //ENGAGE0011628 -- Start
        //self.startGimbalServices()
        //ENGAGE0011628 -- End
        //ENGAGE0011344 -- End
        
        self.setLocalization()
        self.initController()
      //  self.setLocalizedString()
        
        

        self.lblProfileName.text = ""
        self.lblWeatherReport.text = ""
        self.lblWeatherDescription.text = ""
        self.imgWeather.image = nil
        self.lblSendUsFeedback.text = ""
        
        let itemSize = UIScreen.main.bounds.width/3-1
        let screenHeight = (UIScreen.main.bounds.height - 357)/4
        
    
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        if UIScreen.main.bounds.height - 357 >= 455 {
            layout.itemSize = CGSize(width: itemSize + 0.25, height: screenHeight - 4)

        }else{
        layout.itemSize = CGSize(width: itemSize + 0.25, height: itemSize)
        }
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        dashBoardCollectionView.collectionViewLayout = layout
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction(sender:)))
        self.clubNewsView.addGestureRecognizer(gesture)
        
        btnAllNews .setTitle(self.appDelegate.masterLabeling.vIEW_ALL, for: .normal)

        
        let profilegesture = UITapGestureRecognizer(target: self, action:  #selector(self.profile(sender:)))
        self.profileView.addGestureRecognizer(profilegesture)
        
        let notification = UITapGestureRecognizer(target: self, action:  #selector(self.notificationButtonClick(sender:)))
        self.notificationView.addGestureRecognizer(notification)
        
        let sendUsFeedBack = UITapGestureRecognizer(target: self, action:  #selector(self.sendUsFeedbackClicked(sender:)))
        self.sendUsFeedbackView.addGestureRecognizer(sendUsFeedBack)
        
        //Added by kiran -- ENGAGE0011226 -- Covid rules
        //Start
        self.alertBtn.setStyle(style: .contained, type: .alert)
        self.alertBtn.titleLabel?.font = AppFonts.semibold17
        //End
        
        //Added by kiran V1.3 -- PROD0000036 -- Removing place holder image set in Sotryboard
        //PROD0000036 -- Start
        self.imgProfileImage.image = nil
        //PROD0000036 -- End
        
        self.sendUsFeedbackView.backgroundColor = APPColor.MainColours.primary2
        self.requestReservationApi()
        self.getMultiLingualApi()
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timer?.invalidate()
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    func timerr(){
        
        if(self.appDelegate.arrTimeForClubnews.count == 0){
            
        }
        else{
            clubNewsTime = Double(self.appDelegate.arrTimeForClubnews[0].value ?? "1")!
            floatt = Float(self.appDelegate.arrTimeForClubnews[0].value ?? "1")
            timer = Timer.scheduledTimer(timeInterval: clubNewsTime, target: self, selector: #selector(self.handleTimer), userInfo: nil, repeats: true)
            
            
        }
    }
    //MARK:- getMultiLingual Api
    func getMultiLingualApi() -> Void{
        
        if (Network.reachability?.isReachable) == true{
            let paramaterDict:[String: Any] = [
                APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? ""
            ]
            
            APIHandler.sharedInstance.getLocalizationData(paramater: paramaterDict, onSuccess: { (localizeinfo, responseString, localizeinfoDict) in
                if(localizeinfo.responseCode == InternetMessge.kSuccess){
                    //                    self.masterLabeling = localizeinfo
                    let cultureCode = UserDefaults.standard.string(forKey: UserDefaultsKeys.culturecode.rawValue) ?? ""
                    
                    for dictData in localizeinfoDict{
                        if(dictData.key == cultureCode){
                            let masterData = Mapper<MainLangauage>().map(JSONObject: dictData.value)!
                            //                            let masterData = Mapper<MainLangauage>().map(JSONObject: dictData.value)!
                            self.appDelegate.masterLabeling = masterData.label!
                            self.lblSendUsFeedback.text = self.appDelegate.masterLabeling.lINKTOPRIVATESITE ?? "" as String

//                            self.lblSendUsFeedback.text = self.appDelegate.masterLabeling.rEDIRECTTO_PRIVATESITE
//                            let selectGuest: NSMutableAttributedString = NSMutableAttributedString(string: self.lblSendUsFeedback.text!)
//                            selectGuest.setColor(color: hexStringToUIColor(hex: self.appDelegate.masterLabeling.rEQUIREDFIELD_COLOR!), forText: "*")   // or use direct value for text "red"
//
//                            self.lblSendUsFeedback.attributedText = selectGuest
                            break;
                        }
                    }
                    
                   
                    UserDefaults.standard.set(responseString, forKey: UserDefaultsKeys.getMultiLingualData.rawValue)
                    UserDefaults.standard.synchronize()
                    
                }
                
            },onFailure: { error  in
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }
    }
    
    //MARK:- Dynamic Tab bar/drawer API
    func getIcon() -> Void {
        
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            APIHandler.sharedInstance.getTabbar(paramater:nil, onSuccess: { (tabbarmodelinfo, responseString) in
                
                
                
                if(tabbarmodelinfo.responseCode == InternetMessge.kSuccess){
                    
                    self.appDelegate.hideIndicator()
                    self.appDelegate.tabbarControllerInit = tabbarmodelinfo
            
                   
                    self.arrfooterTabbar = (self.appDelegate.tabbarControllerInit.memberApp?.landingMenus) ?? []
                    
                    
                    self.appDelegate.hideIndicator()
                    self.dashBoardCollectionView.reloadData()
                }
                else{
                    self.appDelegate.hideIndicator()
                    
                    if(((tabbarmodelinfo.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: tabbarmodelinfo.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                }
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                
                self.appDelegate.hideIndicator()
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
//        self.masterListData()
        //Added by kiran V1.4 -- PROD0000145 -- This fixes the issue - Share screen is not displayed properly, when member open share screen for Dining and Tennis Reservations after navigating form “Golf/Tennis/Dining & Fitness & Spa” My Calendar screen.
        //PROD0000145 -- Start
        self.appDelegate.typeOfCalendar = ""
        //PROD0000145 -- End
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer)
    {
        //Uncoment when needed
        //Added on 4th July 2020 V2.2
        //Added roles and privilages changes
        /*switch self.accessManager.accessPermision(for: .viewNews)
        {
        case .notAllowed:
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        default:
            break
        }*/

        if arrClubNews.count == 0 {
            
        }
        else
        {
            //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
            //PROD0000069 -- Start
           
            var selectedNews = ClubNews()
            
            if i == -1
            {
                selectedNews = arrClubNews[arrClubNews.count - 1]
            }
            else
            {
                selectedNews = arrClubNews[i]
            }
            
            if selectedNews.enableRedirectClubNewsToEvents == 1
            {
                self.navigateToEventsScreen(selectedNews: selectedNews)
            }
            else
            {
                //Added on 14th May 2020 v2.1
                if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ViewNewsViewController") as? ViewNewsViewController
                {
                    clubNews.modalTransitionStyle   = .crossDissolve;
                    clubNews.modalPresentationStyle = .overCurrentContext
                    
                    var arrMedia : [MediaDetails]?
                   
                    if i == -1
                    {
                        arrMedia = arrClubNews[arrClubNews.count - 1].newsImageList
                        clubNews.contentDetails = ContentDetails.init(id: arrClubNews[arrClubNews.count - 1].id, date: arrClubNews[arrClubNews.count - 1].date, name: arrClubNews[arrClubNews.count - 1].title, link: nil)
                    }
                    else
                    {
                        arrMedia = arrClubNews[i].newsImageList
                        clubNews.contentDetails = ContentDetails.init(id: arrClubNews[i].id, date: arrClubNews[i].date, name: arrClubNews[i].title, link: nil)
                    }
                    
                    clubNews.arrMediaDetails = arrMedia
                    //Added on 19th May 2020 v2.1
                    clubNews.contentType = .clubNews
                    self.present(clubNews, animated: true, completion: nil)
                    
                }
                
            }
            //PROD0000069 -- End
            //Old Logic
            /*
            if (arrClubNews[i == -1 ? (arrClubNews.count - 1) : i].newsVideoURL == "")
            {
                if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ViewNewsViewController") as? ViewNewsViewController
                {
                    clubNews.modalTransitionStyle   = .crossDissolve;
                    clubNews.modalPresentationStyle = .overCurrentContext
                    
                    if (arrClubNews.count == 0)
                    {
                        
                    }
                    else
                    {
                        if i == -1
                        {
                            //clubNews.imgURl = arrClubNews[arrClubNews.count - 1].newsImage
                            clubNews.arrMediaDetails = arrClubNews[arrClubNews.count - 1].newsImageList
                            
                        }
                        else
                        {
                            //clubNews.imgURl = arrClubNews[i].newsImage
                            clubNews.arrMediaDetails = arrClubNews[i].newsImageList
                            
                        }
                        self.present(clubNews, animated: true, completion: nil)
                        
                    }
                    
                }
                
            }
            else
            {
                if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "VideoViewController") as? VideoViewController
                {
                    clubNews.modalTransitionStyle   = .crossDissolve;
                    clubNews.modalPresentationStyle = .overCurrentContext
                    
                    if (arrClubNews.count == 0)
                    {
                        
                    }
                    else
                    {
                        if i == -1
                        {
                            clubNews.videoURL = arrClubNews[arrClubNews.count - 1].newsVideoURL?.videoID
                        }
                        else
                        {
                            clubNews.videoURL = arrClubNews[i].newsVideoURL?.videoID
                        }
                        
                        self.present(clubNews, animated: true, completion: nil)
                        
                    }
                    
                }
                
            }
            */
        }
    }

    @objc func profile(sender : UITapGestureRecognizer)
    {
        //Added on 4th July 2020 V2.2
        //Added roles and privilages changes
        switch self.accessManager.accessPermision(for: .profile) {
        case .notAllowed:
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        default:
            break
        }
        
        screenCodeName = "TST_MYP"
        pageName = "My Profile"
        self.userActivity()

        if let changePW = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ProfileViewOnlyVC") as? ProfileViewOnlyVC {
           
            self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor
            self.navigationController?.pushViewController(changePW, animated: true)
        }
    }
    
    
    @objc func sendUsFeedbackClicked(sender : UITapGestureRecognizer) {
        dashBoardScrollview.setContentOffset(.zero, animated: true)

        if let sendUsFeedback = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "SendUsFeedbackVC") as? SendUsFeedbackVC {
            sendUsFeedback.isFrom = "Feedback"
            sendUsFeedback.privateSiteURL = self.appToPrivateSiteLink
            sendUsFeedback.modalTransitionStyle   = .crossDissolve;
            sendUsFeedback.modalPresentationStyle = .overCurrentContext
            self.present(sendUsFeedback, animated: true, completion: nil)
        }
    }
    func initController()
    {
        self.notificationCount = 0

        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true

        self.btnNotificationBadge.frame  = CGRect(x: 13, y: -6, width: 20, height: 20)
        self.btnNotificationBadge.layer.cornerRadius = self.btnNotificationBadge.frame.size.width/2
        self.btnNotificationBadge.layer.masksToBounds = true
        self.btnNotificationBadge.backgroundColor = .red
        self.btnNotificationBadge .setTitle(String(0), for: .normal)
        self.btnNotificationBadge.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.btnNotificationBadge .setTitleColor(.white, for: .normal)
        self.btnNotification.addSubview(self.btnNotificationBadge)

        self.btnAllNews.layer.cornerRadius = 12
        self.btnAllNews.layer.masksToBounds = true
        self.btnAllNews.layer.borderColor = APPColor.viewNews.viewbg.cgColor         //hexStringToUIColor(hex: "ffffff").cgColor
        self.btnAllNews.layer.borderWidth = 1
        self.btnAllNews.setStyle(style: .outlined, type: .primary)
        
        self.lblProfile.text = (self.appDelegate.masterLabeling.tT_PROFILE ?? "")
       
        self.getNotificationDetails()
        if(self.appDelegate.authTokenTimer.isValid){
            self.getDashboardDetails()
            self.getNotificationDetails()
        }
        else{
//            self.getAuthToken()
        }
        
    }
//    func setLocalizedString(){
//
//        self.lblProfileName.text = ((self.appDelegate.masterLabeling.hI) ?? "") + " " + (UserDefaults.standard.string(forKey: UserDefaultsKeys.firstName.rawValue) ?? "") + self.appDelegate.masterLabeling.eXCLAMATORY!
//        self.lblProfileName.numberOfLines = 2
//        lblProfile.text = (self.appDelegate.masterLabeling.tT_PROFILE ?? "")
//        //self.btnMore.setTitle(self.appDelegate.masterLabeling., for: .normal)
//
//
//
//    }
    func heightOfColectionView() {
        
        height = dashBoardCollectionView.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeight.constant = height
        
        let device = DeviceInfo.modelName
        
        if  ((device == "iPhone X" ) || (device == "Simulator iPhone X")){
            
            bottomViewHeight.constant = height + 138 + 44
            bottomBarHeight.constant = 13

        }

        else if  ((device == "iPhone XR" ) || (device == "Simulator iPhone11,8") || (device == "iPhone XS" ) || (device == "Simulator iPhone11,2")){
            
            bottomViewHeight.constant = height + 145 + 44
            bottomBarHeight.constant = 20
            
        }
       
        else{

        bottomViewHeight.constant = height + 163 + 44
            bottomBarHeight.constant = 7.5

        }
        
        bottomViewHeight.constant += (self.viewLinkToPrivateSiteHolder.isHidden ? -34.5 : 0)
        self.view.setNeedsLayout()
    }
    

    override func viewWillAppear(_ animated: Bool)
    {
        dismiss(animated: true, completion: nil)
        //Added by kiran V2.4 -- GATHER0000176
        self.navigationController?.navigationBar.barTintColor = APPColor.NavigationControllerColors.barTintColor
        
        //Modified by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
        //ENGAGE0012667 -- Start
        (self.navigationController as? CustomNavigationController)?.setNavBarColorFor(MemberID: false)
        //ENGAGE0012667 -- End
        
        self.performWillApperAction()
    }
    
    
    //Added on 11th June 2020 V2.2
    //Added to make view will appear call when app enters from background to forground and is on dashbaord
    
    func performWillApperAction()
    {
        //self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.setLocalization()
        self.getDashboardDetails()
        self.navigationController?.navigationBar.isHidden = true
        
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        timeFormatter.timeZone = TimeZone(abbreviation: "EST")
        
        dateFormatter.dateFormat = "MMMM dd,  yyyy"
        timeFormatter.dateFormat = "hh:mm a"
                
        let dateInFormat = dateFormatter.string(from: NSDate() as Date)
        let time = timeFormatter.string(from: NSDate() as Date)
                
        lblDate.text = dateInFormat
        lblTime.text = time
        self.weatherReport()
        //self.masterListData()
        self.getMasterList()
                
        i = 0
        self.getNotificationDetails()
                
        self.imgProfileImage.layer.cornerRadius = self.imgProfileImage.frame.size.width / 2
        self.imgProfileImage.layer.masksToBounds = true
        self.imgProfileImage.layer.borderColor = UIColor.white.cgColor
        self.imgProfileImage.layer.borderWidth = 1.0

        self.getIcon()

    }
    
    //Added by kiran V2.7 --ENGAGE0011678 -- Disabling touches on dashbaord screen until dashboard api is a success
    //ENGAGE0011678 -- Start
    private func enableTaps(bool : Bool)
    {
        self.dashBoardCollectionView.isUserInteractionEnabled = bool
        self.btnNotification.isUserInteractionEnabled = bool
        self.btnAllNews.isUserInteractionEnabled = bool
        self.clubNewsView.isUserInteractionEnabled = bool
        self.profileView.isUserInteractionEnabled = bool
        self.notificationView.isUserInteractionEnabled = bool
        self.alertBtn.isUserInteractionEnabled = bool
        self.viewSocial.isUserInteractionEnabled = bool
        self.sendUsFeedbackView.isUserInteractionEnabled = bool
    }
    
    //ENGAGE0011678 -- End
    
    
    //MARK:- GetMultiLingual Api
    func setLocalization(){
        let jsonString = UserDefaults.standard.string(forKey: UserDefaultsKeys.getMultiLingualData.rawValue) ?? ""
        let cultureCode = UserDefaults.standard.string(forKey: UserDefaultsKeys.culturecode.rawValue) ?? ""
        
        
        if let data = jsonString.data(using: String.Encoding.utf8) {
            do {
                let localizeinfoDict =  try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                for dictData in localizeinfoDict!{
                    //print(dictData.key)
                    if(dictData.key == cultureCode){
                        //print(dictData.value)
                        let masterData = Mapper<MainLangauage>().map(JSONObject: dictData.value)!
                        self.appDelegate.masterLabeling = masterData.label!
                        //print(self.appDelegate.masterLabeling.aDD_GUEST ?? "")
                        
                        
                        InternetMessge.kNoData = self.appDelegate.masterLabeling.nO_RECORD_FOUND ?? ""
                        InternetMessge.kInternet_not_available = self.appDelegate.masterLabeling.iNTERNET_CONNECTION_ERROR ?? ""
                        Symbol.khash = self.appDelegate.masterLabeling.hASH ?? ""
                        CommonString.kappname = self.appDelegate.masterLabeling.bOCA_WEST ?? ""
                        
                        break;
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }
    }
    //MARK:- Dashboard API called
    @objc func getDashboardDetails() {
        if (Network.reachability?.isReachable) == true{
            
            
            let todaysDate:Date = Date()
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = APIKeys.valuedateformat
            let todayString:String = dateFormatter.string(from: todaysDate)
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            //Added by kiran V2.7 --ENGAGE0011678 -- Disabling touches on dashbaord screen until dashboard api is a success
            //ENGAGE0011678 -- Start
            self.enableTaps(bool: false)
            //ENGAGE0011678 -- End
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.keffectivedate: todayString,
                
                //Added by kiran V2.5 -- ENGAGE0011322 -- Added device token
                APIKeys.kdeviceID: UserDefaults.standard.string(forKey: UserDefaultsKeys.FCMToken.rawValue) ?? ""
            ]
            
            APIHandler.sharedInstance.getDashBoardData(paramaterDict: paramaterDict , onSuccess: { eventList in
                if(eventList.responseCode == InternetMessge.kSuccess)
                {
                    //Added on 4th July 2020 V2.2
                    //Added roles and privilages
                    self.accessManager.rolesAndPrivilages = eventList.userRolesandPrivilages!
                    
                    //Added by kiran V2.4-- ENGAGE0011226 -- added for Covid rules
                    //Start
                    self.alertBtn.setTitle(eventList.alertRulesText, for: .normal)
                    self.alertBtn.isHidden = !(eventList.isShowAlertRules == 1)
                    self.alertTitle = eventList.alertRulesText ?? ""
                    //End
                    
                    switch self.accessManager.accessPermision(for: .login) {
                    case .notAllowed :
                        
                        let alertController = UIAlertController(title: self.appDelegate.masterLabeling.mEMBER_DEACTIVATED ?? "Member Deactivated", message: self.appDelegate.masterLabeling.dEACTIVATED_LOGOUT ?? "Your account is Inactive, please contact info@mycobaltsoftware.com", preferredStyle: .alert)
                        
                        let logOut = UIAlertAction(title: self.appDelegate.masterLabeling.lOGOUT ?? "Logout", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                            
                            let prefs = UserDefaults.standard

                            prefs.removeObject(forKey:"userID")
                            prefs.removeObject(forKey:"getTabbar")
                            prefs.removeObject(forKey: "parentID")
                            prefs.removeObject(forKey: "id")
                            prefs.removeObject(forKey: "username")
                            prefs.removeObject(forKey: "masterList")

                            UserDefaults.standard.synchronize()


                            self.resetDefaults()
                            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                            let initialLoginVC = mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                            //Modified by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
                            //ENGAGE0012667 -- Start
                            let navigationController = CustomNavigationController(rootViewController: initialLoginVC)//UINavigationController(rootViewController: initialLoginVC)
                            //ENGAGE0012667 -- End
                            UIApplication.shared.keyWindow?.rootViewController = navigationController
                            UIApplication.shared.keyWindow?.makeKeyAndVisible()

                            //Modified by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
                            //ENGAGE0012667 -- Start
                            let nav: CustomNavigationController = CustomNavigationController()//UINavigationController = UINavigationController()
                            //ENGAGE0012667 -- End

                            self.appDelegate.window?.rootViewController = nav


                            nav.setViewControllers([initialLoginVC], animated: true)
                        }
                        alertController.addAction(logOut)
                        self.present(alertController, animated: true, completion: nil)

                        return
                    default:
                        break
                    }
                    
                    //Added by kiran V1.3 -- PROD0000019 -- Added 2 step verification
                    //PROD0000019 -- Start
                    if eventList.hasAccountExpired == 1
                    {
                        let alertController = UIAlertController(title: self.appDelegate.masterLabeling.authentication_AccountExpired ?? "Account Expired", message: self.appDelegate.masterLabeling.authentication_ExpiredText ?? "Your account has expired, please contact info@mycobaltsoftware.com", preferredStyle: .alert)
                        
                        let logOut = UIAlertAction(title: self.appDelegate.masterLabeling.authentication_Logout ?? "Logout", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                            
                            let prefs = UserDefaults.standard

                            prefs.removeObject(forKey:"userID")
                            prefs.removeObject(forKey:"getTabbar")
                            prefs.removeObject(forKey: "parentID")
                            prefs.removeObject(forKey: "id")
                            prefs.removeObject(forKey: "username")
                            prefs.removeObject(forKey: "masterList")

                            UserDefaults.standard.synchronize()


                            self.resetDefaults()
                            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                            let initialLoginVC = mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                            let navigationController = UINavigationController(rootViewController: initialLoginVC)
                            UIApplication.shared.keyWindow?.rootViewController = navigationController
                            UIApplication.shared.keyWindow?.makeKeyAndVisible()

                            let nav: UINavigationController = UINavigationController()

                            self.appDelegate.window?.rootViewController = nav


                            nav.setViewControllers([initialLoginVC], animated: true)
                        }
                        alertController.addAction(logOut)
                        self.present(alertController, animated: true, completion: nil)
                     }
                    //PROD0000019 -- End
                    
                    
                    self.arrEventList = eventList.upcomingEvent!
                    self.arrClubNews = eventList.clubnews!
                    
                    let fullName = eventList.fullName
                    let memberNameDisplay = eventList.memberNameDisplay
                    self.facebookLink = eventList.facebookUrl
                    self.instaLink = eventList.instaUrl
                    self.twitterLink = eventList.twitterUrl
                    self.pinterestLink = eventList.pinterestUrl
                    self.appToPrivateSiteLink = eventList.appPrivateSiteUrl
                    self.linkedInLink = eventList.linkedIn
                    
                    self.lblProfileName.text = memberNameDisplay
                    self.lblProfileName.numberOfLines = 2
                    
                    UserDefaults.standard.set(fullName, forKey: UserDefaultsKeys.fullName.rawValue)
                    UserDefaults.standard.set(memberNameDisplay, forKey: UserDefaultsKeys.memberNameDisplay.rawValue)
                    UserDefaults.standard.set(eventList.appVersion, forKey: UserDefaultsKeys.version.rawValue)
                    UserDefaults.standard.set(eventList.captainName, forKey: UserDefaultsKeys.captainName.rawValue)

                    
                    if self.arrClubNews.count != 0{
                        
                        self.lblClubNews.text = self.arrClubNews[0].title
                        self.lblClubNewsDate.text = self.arrClubNews[0].date
                        self.arrClubNewsDetails = [self.arrClubNews[0]]
                        self.timer?.invalidate()

                        self.timerr()
                       // self.i+=1

                    }
                    else{
                    
                    self.lblClubNews.text = ""
                    self.lblClubNewsDate.text = ""
                        
                    }
                    
                    let appCurrentVersion : String  = (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String)!
                    let appVersionFromServer : String  = eventList.appVersion!
                    
                    
                    let currentAppVersion = appCurrentVersion
                    let versionFromServer = appVersionFromServer
                 
                        if (currentAppVersion < versionFromServer) {
                            let alertController = UIAlertController(title: self.appDelegate.masterLabeling.nEW_VERSION_AVAILABLE, message: self.appDelegate.masterLabeling.newVersion_Message, preferredStyle: .alert)

                            // Create the actions
                            let okAction = UIAlertAction(title: self.appDelegate.masterLabeling.uPDATE, style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                guard let url = URL(string: "https://itunes.apple.com/us/app/cobaltengage/id1536936241") else { return }
                                UIApplication.shared.open(url)

                            }
                            // Add the actions
                            alertController.addAction(okAction)

                            // Present the controller
                            self.present(alertController, animated: true, completion: nil)
                        }

                    //Commented by kiran V1.3 -- PROD0000036 -- removing place holder image from app
                    //PROD0000036 -- Start
                    //let placeHolderImage = UIImage(named: "avtar")
                    //PROD0000036 -- End
                    
                    //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
                    //ENGAGE0011419 -- Start
                    
                    let imageURLString = eventList.profilePic ?? ""
                    
                    if imageURLString.isValidURL()
                    {
                        //Added by kiran V2.5 -- ENGAGE0011378 -- fix for image not updating when image added from Membership department
                        //Start -- ENGAGE0011378
                        UserDefaults.standard.set(imageURLString, forKey: UserDefaultsKeys.userProfilepic.rawValue)
                        //End -- ENGAGE0011378
                       
                        //Added by kiran V1.3 -- PROD0000036 -- Showing place holder images based on gender which are fetched from URL
                        //PROD0000036 -- Start
                        self.imgProfileImage.setImage(imageURL: imageURLString,shouldCache: true)
                        //Old logic
                        //let url = URL.init(string:imageURLString)
                        //self.imgProfileImage.sd_setImage(with: url , placeholderImage: placeHolderImage)
                        //PROD0000036 -- End
                    }
                    /*
                    if(imageURLString.count>0){
                        let validUrl = self.verifyUrl(urlString: imageURLString)
                        if(validUrl == true){
                            //Added by kiran V2.5 -- ENGAGE0011378 -- fix for image not updating when image added from Membership department
                            //Start -- ENGAGE0011378
                            UserDefaults.standard.set(imageURLString, forKey: UserDefaultsKeys.userProfilepic.rawValue)
                            //End -- ENGAGE0011378
                            let url = URL.init(string:imageURLString)
                            self.imgProfileImage.sd_setImage(with: url , placeholderImage: placeHolderImage)
                        }
                    }
                    */
                    //ENGAGE0011419 -- End

                    // print(self.arrEventList.count)
                 //   self.tableviewEvents.reloadData()
                    
                    //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
                    //GATHER0000700 - Start
                    DataManager.shared.enableTennisLesson = eventList.enableTennisLesson
                    //GATHER0000700 - End
                    
                    //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL Button Flag
                    //GATHER0001167 -- Start
                    DataManager.shared.enableGolfLession = eventList.enableGolfLesson
                    //GATHER0001167 -- End
                    
                    //Added by kiran V2.7 -- ENGAGE0011628 -- add the logic to start/Stop the gimbal service based on the setting.
                    //ENGAGE0011628 -- Start
                    
                    //Added by kiran V2.9 -- ENGAGE0012323 -- Implementing App tracking Transperency changes
                    //ENGAGE0012323 -- Start
                    let hasAllPermissions = CustomFunctions.shared.gimbalHasAllPermissions()
                    
                    if hasAllPermissions.status
                    {
                        //Turn service on
                        if eventList.gimbalService == 1
                        {
                            self.appDelegate.InitializeGimbal()
                            //Checks if the gimbal service is off. if its turned off then we start the service.
                            if !Gimbal.isStarted()
                            {
                                Gimbal.start()
                            }
                        }//Turn service off
                        else if eventList.gimbalService == 0
                        {
                            //Checks if the gimbal service is turned on. if turned off then we stop the service.
                            if Gimbal.isStarted()
                            {
                                Gimbal.stop()
                            }
                        }
                    }
                    else
                    {
                        if Gimbal.isStarted()
                        {
                            Gimbal.stop()
                        }
                    }
                    
                    //Old logic added in ENGAGE0011628
                    /*
                    //Turn service on
                    if eventList.gimbalService == 1
                    {
                        //Checks if the gimbal service is off. if its turned off then we start the service.
                        if !Gimbal.isStarted()
                        {
                            Gimbal.start()
                        }
                    }//Turn service off
                    else if eventList.gimbalService == 0
                    {
                        //Checks if the gimbal service is turned on. if turned off then we stop the service.
                        if Gimbal.isStarted()
                        {
                            Gimbal.stop()
                        }
                    }*/
                    //ENGAGE0012323 -- End
                    //ENGAGE0011628 -- End
                    
                    //Added by kiran V2.7 --ENGAGE0011678 -- Disabling touches on dashbaord screen until dashboard api is a success
                    //ENGAGE0011678 -- Start
                    self.enableTaps(bool: true)
                    //ENGAGE0011678 -- End
                    
                    //Added by kiran V1.3 -- PROD0000019 -- Hides Linked to memberID bar
                    //PROD0000019 -- Start
                    self.viewLinkToPrivateSiteHolder.isHidden = (eventList.hideLinkToMemberSite == 1)
                    self.heightOfColectionView()
                    //PROD0000019 -- End
                    
                    self.appDelegate.hideIndicator()
                }else{
                    self.appDelegate.hideIndicator()
                    if(((eventList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: eventList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
       
                }
                
                //Added by kiran V2.7 -- ENGAGE0011614 -- sending the bluetooth and location permission and service state to backend
                //ENGAGE0011614 -- Start
                DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.25) {
                    self.updatePermissionData()
                }
                //ENGAGE0011614 -- End
                
                self.appDelegate.hideIndicator()
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
        }
        else
        {
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
    
    //Added by kiran V2.7 -- ENGAGE0011614 -- sending the bluetooth and location permission and service state to backend
    //ENGAGE0011614 -- Start
    private func updatePermissionData()
    {
        
        
        if (Network.reachability?.isReachable) == true
        {
            var paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                ]
            
            ///Indicates if bluetooth is turned on or off
            let bluetoothServiceState : Int = self.appDelegate.bluetoothManager?.state.rawValue ?? -1
            //Indicates if location service is turned on/turned off
            let locationServiceState : Int = CLLocationManager.locationServicesEnabled() ? 1 : 0
            
            ///Authorization User provided to app to access bluetooth
            var bluetoothPermission : Int = -1
            if #available(iOS 13.1, *)
            {
                //authorization(class property) was introduced in 13.1
                bluetoothPermission = CBManager.authorization.rawValue
            }
            else if #available(iOS 13.0, *)
            {
                //authorization(instance property) was introduced in 13.0 and depricated in 13.1
                bluetoothPermission = self.appDelegate.bluetoothManager?.authorization.rawValue ?? -1
            }
            else
            {
                //in iOS 12 and below bluetooth permission is not asked. this was introduced in iOS 13. so we consider the permission is always allowed.
                bluetoothPermission = 3
            }
            
            ///Authorization User provided to app to access location
            var locationPermission : Int = -1
            
            if #available(iOS 14.0, *)
            {
                //authorizationStatus is class property in iOS 14.0 and above
                locationPermission = Int(self.appDelegate.locationManager?.authorizationStatus.rawValue ?? -1)
            }
            else
            {
                //authorizationStatus as instance property depricated in iOS 14.0
                locationPermission = Int(CLLocationManager.authorizationStatus().rawValue)
            }
            
            paramaterDict.updateValue(bluetoothServiceState, forKey: APIKeys.kBluetoothServiceStatus)
            paramaterDict.updateValue(bluetoothPermission, forKey: APIKeys.kBluetoothPermissionType)
            paramaterDict.updateValue(locationServiceState, forKey: APIKeys.kLocationServiceStatus)
            paramaterDict.updateValue(locationPermission, forKey: APIKeys.kLocationPermissionType)
            //1 indicates that the api is used for saving data instead of using it to fetch app version details.
            paramaterDict.updateValue(1, forKey: APIKeys.kIsStoreInfo)
            
            //Added by kiran V2.9 -- ENGAGE0012323 -- Implementing App tracking Transperency changes
            //ENGAGE0012323 -- Start
            var appTrackingPermission : Int = -1
            if #available(iOS 14.5, *)
            {
                appTrackingPermission = Int(ATTrackingManager.trackingAuthorizationStatus.rawValue)
            }
            else
            {
                appTrackingPermission = 3
            }
            
            paramaterDict.updateValue(appTrackingPermission, forKey: APIKeys.kAppTrackingPermission)
            //ENGAGE0012323 -- End
            
            APIHandler.sharedInstance.getAppVersion(paramater: paramaterDict, onSuccess: { (response) in
                                
            }) { (error) in
                
            }
        
        }

    }
    //ENGAGE0011614 -- End

    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            
        }
    }
    @objc func handleTimer(_ timer: Timer) {
        
        if self.arrClubNews.count != 0{

            if self.arrClubNews.count == i + 1{
                i = 0
            }else{
            i+=1
            self.lblClubNews.text = self.arrClubNews[i].title
            self.lblClubNewsDate.text = self.arrClubNews[i].date
            
 
            if i + 1 == self.arrClubNews.count{
                i = -1
                
            }
            }
//            if count == 0 {
//                if i == arrClubNews.count {
//                    i = 0
//                }
//                self.lblClubNews.text = self.arrClubNews[i].title
//                self.lblClubNewsDate.text = self.arrClubNews[i].date
//
//                count = Int(self.appDelegate.arrTimeForClubnews[0].value ?? "1")
//
//            }else{
//
////                count = count! - 1
////                if count == 0 {
//                i+=1
//                count = 0
////                }
//            }
        }
    }
    //MARK:- User Activity  Api

    func userActivity(){
        if (Network.reachability?.isReachable) == true{

            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                "PageUrl": "api/Member/GetCampaignList",
                "PageName": pageName ?? "",
                "ScreenCode": screenCodeName ?? ""
            ]
            
            APIHandler.sharedInstance.getUserActivity(paramaterDict: paramaterDict , onSuccess: { eventList in
                if(eventList.responseCode == InternetMessge.kSuccess)
                {
            
                    self.appDelegate.hideIndicator()
                }else{
                    self.appDelegate.hideIndicator()
                    if(((eventList.responseMessage?.count) ?? 0)>0){
//                        SharedUtlity.sharedHelper().showToast(on:
//                            self.view, withMeassge: eventList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                }
                
                self.appDelegate.hideIndicator()
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
//                SharedUtlity.sharedHelper().showToast(on:
//                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
    
    //MARK:- Authentication API called

//    func getAuthToken(){
//
//        if (Network.reachability?.isReachable) == true{
//            APIHandler.sharedInstance.getTokenApi(paramater: nil , onSuccess: { tokenList in
//                let access_token = tokenList.access_token
//                let expires_in = tokenList.expires_in
//                let token_type = tokenList.token_type
//                let jointToken = (token_type ?? "") + " " + (access_token ?? "")
//
//
//                UserDefaults.standard.set(access_token, forKey: UserDefaultsKeys.access_token.rawValue)
//                UserDefaults.standard.set(expires_in, forKey: UserDefaultsKeys.expires_in.rawValue)
//                UserDefaults.standard.set(token_type, forKey: UserDefaultsKeys.token_type.rawValue)
//                UserDefaults.standard.set(jointToken, forKey: UserDefaultsKeys.apiauthtoken.rawValue)
//                UserDefaults.standard.synchronize()
//                print(UserDefaults.standard.string(forKey: UserDefaultsKeys.apiauthtoken.rawValue) ?? "")
//
//                self.getDashboardDetails()
//                self.getNotificationDetails()
//
//            },onFailure: { error  in
//
//                print(error)
//                SharedUtlity.sharedHelper().showToast(on:
//                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
//            })
//        }
//    }
    
    //Mark- get Notification Api
    func getNotificationDetails() {
        
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                "USERID": UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                "Modulekey":"MB",
                "SearchText":  ""
                
            ]
            
            APIHandler.sharedInstance.getNotificationDetails(paramater: paramaterDict, onSuccess: { notificationList in
                
//                if(notificationList.responseCode == InternetMessge.kSuccess)
//                {
//
                    // print(notificationList.notifications)
//                    self.arrNotifications = notificationList.data!
                    self.appDelegate.hideIndicator()
                    
//                    if(self.arrNotifications .count > 0 )
//                    {
//                        let notifyobj: NotificationsData
//                        self.arrNotifications.removeAll()
//                        notifyobj = self.arrNotifications [0]
//                      //  self.btnNotification.setTitle(notifyobj.notificationText, for: .normal)
//
//                    }else{
//                       // self.btnNotification.setTitle(self.appDelegate.masterLabeling.nO_NEW_NOTIFICATION, for: .normal)
//
//                    }
                
                    self.notificationCount = 0
//                    for dictData in self.arrNotifications {
//                        if(dictData.readstatus == false)
//                        {
//                            self.notificationCount += 1
//                        }
//                    }
                    if(notificationList.unReadCount == 0)
                    {
                        
                        self.btnNotificationBadge.isHidden = true
                    }
                    else
                    {
                        
                        if let priceOfProduct = notificationList.unReadCount
                        {
                            //added on 29th October 2020 V2.4 -- ENGAGE0011212
                            self.btnNotificationBadge.isHidden = false
                            
                            if priceOfProduct >= 100
                            {
                                self.btnNotificationBadge.frame = CGRect(x: 13, y: -15, width: 30, height: 30)
                                self.btnNotificationBadge.layer.cornerRadius = self.btnNotificationBadge.frame.size.width/2
                                self.btnNotificationBadge.layer.masksToBounds = true
                                self.btnNotificationBadge.backgroundColor = .red
                                self.btnNotificationBadge .setTitle(String(0), for: .normal)
                                self.btnNotificationBadge.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                                self.btnNotificationBadge .setTitleColor(.white, for: .normal)
                                self.btnNotification.addSubview(self.btnNotificationBadge)
                                self.btnNotificationBadge .setTitle(String(priceOfProduct), for: .normal)

                            }
                            else
                            {
                                self.btnNotificationBadge .setTitle(String(priceOfProduct), for: .normal)
                            }
                        }
                        
                    }
                    
                    
//                }else{
//                    self.appDelegate.hideIndicator()
//                    if(((notificationList.responseMessage?.count) ?? 0)>0){
//                        SharedUtlity.sharedHelper().showToast(on:
//                            self.view, withMeassge: notificationList.responseMessage, withDuration: Duration.kMediumDuration)
//                    }
//
//                }
                
                self.appDelegate.hideIndicator()
            },onFailure: { error  in
                print(error)
                self.appDelegate.hideIndicator()
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
    
    // MARK:- Master List data
    func masterListData(){
      //  self.getMasterList()
        let jsonString = UserDefaults.standard.string(forKey: UserDefaultsKeys.masterList.rawValue) ?? ""
        let memberDirectoryInterest = MemberDirectoryInterest(JSONString: jsonString)
        
        if (((memberDirectoryInterest?.relation?.count) ?? 0)<=0) {
            //self.getMasterList()
        }
        else{
            self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            
            
        }
        if (((memberDirectoryInterest?.weeks?.count) ?? 0)<=0) {
           // self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrWeeks = (memberDirectoryInterest?.weeks)!
            
        }
        if (((memberDirectoryInterest?.days?.count) ?? 0)<=0) {
          //  self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrDays = (memberDirectoryInterest?.days)!
            
        }
        
        if (((memberDirectoryInterest?.boardofGovernors?.count) ?? 0)<=0) {
           // self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrBoardofGovernors = (memberDirectoryInterest?.boardofGovernors)!
            
        }
        if (((memberDirectoryInterest?.clubNewsRotation?.count) ?? 0)<=0) {
           // self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrTimeForClubnews = (memberDirectoryInterest?.clubNewsRotation)!

        }
        
        if (((memberDirectoryInterest?.relationFilter?.count) ?? 0)<=0) {
           // self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrRelationFilter = (memberDirectoryInterest?.relationFilter)!
            
        }
        if (((memberDirectoryInterest?.dateSort?.count) ?? 0)<=0) {
           // self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrDateSort = (memberDirectoryInterest?.dateSort)!
            
        }
        
        if (((memberDirectoryInterest?.calendarSort?.count) ?? 0)<=0) {
            // self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrCalenderSortFilter = (memberDirectoryInterest?.calendarSort)!
            
        }
        
        if (((memberDirectoryInterest?.eventStatusFilter?.count) ?? 0)<=0) {
            // self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrEventStatusFilter = (memberDirectoryInterest?.eventStatusFilter)!
            
        }
        
        if (((memberDirectoryInterest?.sufix?.count) ?? 0)<=0) {
           // self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrSufix = (memberDirectoryInterest?.sufix)!
            
        }
        if (((memberDirectoryInterest?.prefix?.count) ?? 0)<=0) {
            //self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrPrefix = (memberDirectoryInterest?.prefix)!
            
        }
        if (((memberDirectoryInterest?.sendStatementsTo?.count) ?? 0)<=0) {
            //self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrAddressTypes = (memberDirectoryInterest?.sendStatementsTo)!
            
        }
        if (((memberDirectoryInterest?.allMarkettingOptions?.count) ?? 0)<=0) {
           // self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrAllMarketingOptions = (memberDirectoryInterest?.allMarkettingOptions)!
            
        }
        
        if (((memberDirectoryInterest?.states?.count) ?? 0)<=0) {
          //  self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrStates = (memberDirectoryInterest?.states)!
            
        }
        if (((memberDirectoryInterest?.remainderTime?.count) ?? 0)<=0) {
           // self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrReminderTime = (memberDirectoryInterest?.remainderTime)!
            
        }
        
        //Commented by kiran V2.5 -- ENGAGE0011395 -- Settings screen implementation change
        //ENGAGE0011395 -- Start
        /*
        if (((memberDirectoryInterest?.settingsList?.count) ?? 0)<=0) {
          //  self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrSettingList = (memberDirectoryInterest?.settingsList)!
            
        }
         */
        //ENGAGE0011395 -- End
        
        if (((memberDirectoryInterest?.shareUrlList?.count) ?? 0)<=0) {
           // self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrShareUrlList = (memberDirectoryInterest?.shareUrlList)!
            
        }
        
        //Commented by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
        //GATHER0000606 -- Start
        /*
        if (((memberDirectoryInterest?.mbEventRegType?.count) ?? 0)<=0) {
           // self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrEventRegType = (memberDirectoryInterest?.mbEventRegType)!
            
        }
        
        if (((memberDirectoryInterest?.registerMultiMemberType?.count) ?? 0)<=0) {
           // self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrRegisterMultiMemberType = (memberDirectoryInterest?.registerMultiMemberType)!
            
        }
         */
        //GATHER0000606 -- End
        
        if (((memberDirectoryInterest?.CancelPopImageList?.count) ?? 0)<=0) {
           // self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrCancelPopImageList = (memberDirectoryInterest?.CancelPopImageList)!
            
        }
        
        //Commented by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
        //GATHER0000606 -- Start
        /*
        if (((memberDirectoryInterest?.eventRegMemberOnly?.count) ?? 0)<=0) {
            //self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrEventRegTypeMemberOnly = (memberDirectoryInterest?.eventRegMemberOnly)!
            
        }
        */
        //GATHER0000606 -- End
        
        if (((memberDirectoryInterest?.selectionDayType?.count) ?? 0)<=0) {
           // self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrReqDayType = (memberDirectoryInterest?.selectionDayType)!
            
        }
        
        if (((memberDirectoryInterest?.duration?.count) ?? 0)<=0) {
           // self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrDuration = (memberDirectoryInterest?.duration)!
            
        }
        if (((memberDirectoryInterest?.golfGameType?.count) ?? 0)<=0) {
          //  self.getMasterList()
        }
        else{
            // self.appDelegate.arrReleationList = (memberDirectoryInterest?.relation)!
            self.appDelegate.arrGolfGame = (memberDirectoryInterest?.golfGameType)!
            
        }
        if (((memberDirectoryInterest?.guestType?.count) ?? 0)<=0) {
           // self.getMasterList()
        }
        else{
            self.appDelegate.arrGuestType = (memberDirectoryInterest?.guestType)!
            
        }
        
        if (((memberDirectoryInterest?.golfLeagues?.count) ?? 0)<=0) {
            // self.getMasterList()
        }
        else{
            self.appDelegate.arrGolfLeagues = (memberDirectoryInterest?.golfLeagues)!

        }
        
        //MARK:- Master list Instructions
        
        
        if (((memberDirectoryInterest?.EventKidInstruction?.count) ?? 0)<=0)
        {
            // self.getMasterList()
            
        }
        else
        {
            self.appDelegate.EventKidInstruction = (memberDirectoryInterest?.EventKidInstruction)!
        }
        
        if (((memberDirectoryInterest?.DirectoryMemberKidInstruction?.count) ?? 0)<=0)
        {
            // self.getMasterList()
            
        }
        else
        {
            self.appDelegate.DirectoryMemberKidInstruction = (memberDirectoryInterest?.DirectoryMemberKidInstruction)!
        }
        
        if (((memberDirectoryInterest?.DirectoryBuddyKidInstruction?.count) ?? 0)<=0)
        {
            // self.getMasterList()
            
        }
        else
        {
            self.appDelegate.DirectoryBuddyKidInstruction = (memberDirectoryInterest?.DirectoryBuddyKidInstruction)!
        }
        
        if (((memberDirectoryInterest?.EventGuestInstruction?.count) ?? 0)<=0)
        {
            // self.getMasterList()
            
        }
        else
        {
            self.appDelegate.EventGuestInstruction = (memberDirectoryInterest?.EventGuestInstruction)!
        }
        
        if (((memberDirectoryInterest?.DirectoryMemberGuestInstruction?.count) ?? 0)<=0)
        {
            // self.getMasterList()
            
        }
        else
        {
            self.appDelegate.DirectoryMemberGuestInstruction = (memberDirectoryInterest?.DirectoryMemberGuestInstruction)!
        }
        
        if (((memberDirectoryInterest?.DirectoryBuddyGuestInstruction?.count) ?? 0)<=0)
        {
            // self.getMasterList()
            
        }
        else
        {
            self.appDelegate.DirectoryBuddyGuestInstruction = (memberDirectoryInterest?.DirectoryBuddyGuestInstruction)!
        }
        
        if (((memberDirectoryInterest?.EventGuestKidInstruction?.count) ?? 0)<=0)
        {
            // self.getMasterList()
            
        }
        else
        {
            self.appDelegate.EventGuestKidInstruction = (memberDirectoryInterest?.EventGuestKidInstruction)!
        }
        
        if (((memberDirectoryInterest?.DirectoryMemberGuestKidInstruction?.count) ?? 0)<=0)
        {
            // self.getMasterList()
            
        }
        else
        {
            self.appDelegate.DirectoryMemberGuestKidInstruction = (memberDirectoryInterest?.DirectoryMemberGuestKidInstruction)!
        }
        
        if (((memberDirectoryInterest?.DirectoryBuddyGuestKidInstruction?.count) ?? 0)<=0)
        {
            // self.getMasterList()
            
        }
        else
        {
            self.appDelegate.DirectoryBuddyGuestKidInstruction = (memberDirectoryInterest?.DirectoryBuddyGuestKidInstruction)!
        }
        
        if (((memberDirectoryInterest?.ReservationsInstruction?.count) ?? 0)<=0)
        {
            // self.getMasterList()
            
        }
        else
        {
            self.appDelegate.ReservationsInstruction = (memberDirectoryInterest?.ReservationsInstruction)!
        }
        
        
        if (((memberDirectoryInterest?.DiningEventInstruction?.count) ?? 0)<=0)
        {
            // self.getMasterList()
            
        }
        else
        {
            self.appDelegate.DiningEventInstruction = (memberDirectoryInterest?.DiningEventInstruction)!
        }
        
        if (((memberDirectoryInterest?.MemberOnlyEventInstruction?.count) ?? 0)<=0)
        {
            // self.getMasterList()
            
        }
        else
        {
            self.appDelegate.MemberOnlyEventInstruction = (memberDirectoryInterest?.MemberOnlyEventInstruction)!
        }
        
        if let privacyPolicyLink = memberDirectoryInterest?.PrivacyPolicy
        {
            self.appDelegate.privacyPolicyLink = privacyPolicyLink
        }
        
        if let termsOfUseLink = memberDirectoryInterest?.TermsofUse
        {
            self.appDelegate.termsOfUsageLink = termsOfUseLink
        }
        //Added on June BMS
        if let genderFilterOptions = memberDirectoryInterest?.genderOptions
        {
            self.appDelegate.genderFilterOptions = genderFilterOptions
        }
        
        //Added on 4th September 2020 V2.3
        if let guestGenderOptions = memberDirectoryInterest?.guestGender
        {
            self.appDelegate.guestGenderOptions = guestGenderOptions
        }
        
        //Added on 9th October 2020 V2.3
        if let MB_Dining_RegisterMemberType_MemberOnly = memberDirectoryInterest?.MB_Dining_RegisterMemberType_MemberOnly
        {
            self.appDelegate.MB_Dining_RegisterMemberType_MemberOnly = MB_Dining_RegisterMemberType_MemberOnly
        }
        
        //Commented by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
        //GATHER0000606 -- Start
        /*
        if let MB_Dining_RegisterMemberType = memberDirectoryInterest?.MB_Dining_RegisterMemberType
        {
            self.appDelegate.MB_Dining_RegisterMemberType = MB_Dining_RegisterMemberType
        }
        */
        //GATHER0000606 -- End
        
        //Added on 12th October 2020 V2.3
        if let giftCertificateCardType = memberDirectoryInterest?.giftCertificateCardType
        {
            self.appDelegate.giftCertificateCardType = giftCertificateCardType
        }
        
        if let giftCertificateStatus = memberDirectoryInterest?.giftCertificateStatus
        {
            self.appDelegate.giftCertificateStatus = giftCertificateStatus
        }
        
        //Added on 28th October 2020 V2.3 -- GATHER0000176
        
        if let fitnessSettings = memberDirectoryInterest?.fitnessSettings
        {
            self.appDelegate.fitnessSettings = fitnessSettings
        }
        
        if let hamburgerMenuDatails = memberDirectoryInterest?.appFitnessMenu
        {
            self.appDelegate.appFitnessMenu = hamburgerMenuDatails
        }
        
        //Added by kiran V2.5 --ENGAGE0011341 -- Gimbal Geo fence implementation
        //NOTE:- this functionality is not implemneted yet as of V2.5. This is still in R&D.
        //ENGAGE0011341 -- Start
//        if let geofence = memberDirectoryInterest?.geofences
//        {
//            self.updateGeofences(fences: geofence)
//        }
        //ENGAGE0011341 -- End
        
        //Added by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
        //GATHER0000606 -- Start
        if let MB_AddRequestOpt_BMS = memberDirectoryInterest?.MB_AddRequestOpt_BMS
        {
            self.appDelegate.addRequestOpt_BMS = MB_AddRequestOpt_BMS
        }
        
        if let MB_AddRequestOpt_Events = memberDirectoryInterest?.MB_AddRequestOpt_Events
        {
            self.appDelegate.addRequestOpt_Events = MB_AddRequestOpt_Events
        }
        
        if let MB_AddRequestOpt_Dining = memberDirectoryInterest?.MB_AddRequestOpt_Dining
        {
            self.appDelegate.addRequestOpt_Dining = MB_AddRequestOpt_Dining
        }
        
        if let MB_AddRequestOpt_Dining_Member = memberDirectoryInterest?.MB_AddRequestOpt_Dining_Member
        {
            self.appDelegate.addRequestOpt_Dining_MultiSelect = MB_AddRequestOpt_Dining_Member
        }
        
        if let MB_AddRequestOpt_Golf = memberDirectoryInterest?.MB_AddRequestOpt_Golf
        {
            self.appDelegate.addRequestOpt_Golf = MB_AddRequestOpt_Golf
        }
        
        if let MB_AddRequestOpt_Golf_Member = memberDirectoryInterest?.MB_AddRequestOpt_Golf_Member
        {
            self.appDelegate.addRequestOpt_Golf_MultiSelect = MB_AddRequestOpt_Golf_Member
        }
        
        if let MB_AddRequestOpt_Tennis = memberDirectoryInterest?.MB_AddRequestOpt_Tennis
        {
            self.appDelegate.addRequestOpt_Tennis = MB_AddRequestOpt_Tennis
        }
        
        if let MB_AddRequestOpt_Tennis_Member = memberDirectoryInterest?.MB_AddRequestOpt_Tennis_Member
        {
            self.appDelegate.addRequestOpt_Tennis_MultiSelect = MB_AddRequestOpt_Tennis_Member
        }
        
        //GATHER0000606 -- End
        
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes.
        //GATHER0000700 - Start
        if let MB_AddRequestOpt_TennisLesson = memberDirectoryInterest?.MB_AddRequestOpt_TennisLesson
        {
            DataManager.shared.AddRequestOpt_TennisLesson = MB_AddRequestOpt_TennisLesson
        }
        //GATHER0000700 - End
        
        //Added by kiran V2.8 -- ENGAGE0011784 -- added special occasions for addGuestRegVC.
        //ENGAGE0011784 -- Start
        if let specialOcassionList = memberDirectoryInterest?.specialOccasion
        {
            DataManager.shared.specialOccasion = specialOcassionList
        }
        //ENGAGE0011784 -- End
        
        //Added by kiran v2.9 -- GATHER0001167 -- Golf BAL add options
        //GATHER0001167 -- Start
        if let MB_AddRequestOpt_GolfLesson = memberDirectoryInterest?.MB_AddRequestOpt_GolfLesson
        {
            DataManager.shared.addRequestOpt_GolfLesson = MB_AddRequestOpt_GolfLesson
        }
        //GATHER0001167 -- End
    }
    
    //MARK:- Master List API called
    func getMasterList()
    {
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                //                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                //                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                //                APIKeys.kdeviceInfo: APIHandler.devicedict
            ]
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.getMasterList(paramater: paramaterDict , onSuccess: { masterList in
                self.appDelegate.hideIndicator()
                
                if(masterList.responseCode == InternetMessge.kSuccess){
//                    print(masterList.relation?.count)
                    if(masterList.relation == nil){
                       
                    }
                    else{
                        self.masterListData()
                        self.appDelegate.guestNumberOfday = masterList.guestNumberOfDays ?? 90
                        self.appDelegate.arrReleationList = masterList.relation!
                        self.appDelegate.arrWeeks = masterList.weeks!
                        self.appDelegate.arrDays = masterList.days!
                        self.appDelegate.arrBoardofGovernors = masterList.boardofGovernors!
                        self.appDelegate.arrTimeForClubnews = masterList.clubNewsRotation!
                        self.appDelegate.arrRelationFilter = masterList.relationFilter!
                        self.appDelegate.arrDateSort = masterList.dateSort!
                        self.appDelegate.arrSufix = masterList.sufix!
                        self.appDelegate.arrPrefix = masterList.prefix!
                        self.appDelegate.arrAllMarketingOptions = masterList.allMarkettingOptions!
                        self.appDelegate.arrAddressTypes = masterList.sendStatementsTo!
                        self.appDelegate.arrReminderTime = masterList.remainderTime!
                        self.appDelegate.arrGolfLeagues = masterList.golfLeagues!
                        //Commented by kiran V2.5 -- ENGAGE0011395 -- Settings screen implementation change
                        //ENGAGE0011395 -- Start
                       // self.appDelegate.arrSettingList = masterList.settingsList!
                        //ENGAGE0011395 -- End
                        self.appDelegate.arrShareUrlList = masterList.shareUrlList!
                        //Commented by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
                        //GATHER0000606 -- Start
                        /*
                        self.appDelegate.arrEventRegType = masterList.mbEventRegType!
                        self.appDelegate.arrEventRegTypeMemberOnly = masterList.eventRegMemberOnly!
                        */
                        //GATHER0000606 -- End
                        self.appDelegate.arrReqDayType = masterList.selectionDayType!
                        self.appDelegate.arrDuration = masterList.duration!
                        self.appDelegate.arrGolfGame = masterList.golfGameType!
                        self.appDelegate.arrGuestType = masterList.guestType!
                        self.appDelegate.arrCalenderSortFilter = masterList.dateSort!//masterList.calendarSort!
                        self.lblSendUsFeedback.font = UIFont(name:"SourceSansPro-Regular", size: CGFloat(masterList.linkToWebSiteFontSize ?? 14))

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
        }
    }
    
   // to get the weather
    func weatherReport (){
        
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?q=Boca%20raton,us&appid=\(apiKey)&units=metric").responseJSON {            response in
            if let responseStr = response.result.value {
                
                
                let jsonResponse = JSON(responseStr)
                let jsonTemp = jsonResponse["main"]
                let jsonCloud = jsonResponse["weather"][0]
            
                let temp = Float(round(jsonTemp["temp"].doubleValue))
                //print((temp * 1.8) + 32)
                self.lblWeatherReport.text = "\(Int(temp * 1.8) + 32)\("°")"
                self.lblWeatherDescription.text = "\(jsonCloud["description"])"
                self.lblWeatherDescription.text = self.lblWeatherDescription.text!.capitalized

                
                let placeHolderImage = UIImage(named: "")

                //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
                //ENGAGE0011419 -- Start
                let imageURLString = "http://openweathermap.org/img/w/\(jsonCloud["icon"]).png";
                
                if imageURLString.isValidURL()
                {
                    let url = URL.init(string:imageURLString)
                    self.self.imgWeather.sd_setImage(with: url , placeholderImage: placeHolderImage)
                }
                /*
                let validUrl = self.verifyUrl(urlString: imageURLString)
                if(validUrl == true){
                    let url = URL.init(string:imageURLString)
                    self.self.imgWeather.sd_setImage(with: url , placeholderImage: placeHolderImage)
                }
                */
                //ENGAGE0011419 -- End
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrfooterTabbar.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCell", for: indexPath as IndexPath) as! CustomDashBoardCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        //cell.myLabel.text = self.items[indexPath.item]
        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        var dictdata = LandingMenus()
        dictdata = self.arrfooterTabbar[indexPath.row]
        //print("View Controller : \(dictdata.displayName!)")
        //FIXME:- Add name from language api
        cell.lblDisplayname.text = dictdata.displayName
        let placeholder:UIImage = UIImage(named: "Icon-App-40x40")!
        
        //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
        //ENGAGE0011419 -- Start
        let imageURLString = dictdata.icon ?? ""
        
        if imageURLString.isValidURL()
        {
            let url = URL.init(string:imageURLString)
            cell.imgImageView.sd_setImage(with: url , placeholderImage: placeholder)
        }
        else
        {
            cell.imgImageView.image = UIImage(named: "Icon-App-40x40")!
        }
        /*
        if((imageURLString?.count) ?? 0 > 0){
            let validUrl = self.verifyUrl(urlString: imageURLString)
            if(validUrl == true){
                let url = URL.init(string:imageURLString!)
                cell.imgImageView.sd_setImage(with: url , placeholderImage: placeholder)
            }
        }
        else{
            //   let url = URL.init(string:imageURLString)
            cell.imgImageView.image = UIImage(named: "Icon-App-40x40")!
        }
        */
        //ENGAGE0011419 -- End
        self.collectionViewHeight.constant = self.dashBoardCollectionView.contentSize.height;

        heightOfColectionView()
        return cell
    }
    

    // MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        //Modified on 4th July 2020 V2.2
        //Added roles and provilages and changed tap event handeling to menu value instead of position
        let selectedMenu = self.arrfooterTabbar[indexPath.row]
        
        
        //when the SACode in menu is empty string then its treated as full access. otherwise permission is checked
        if selectedMenu.SACode != ""
        {
            switch self.accessManager.accessPermission(SACode : selectedMenu.SACode) {
            case .notAllowed:
                if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
                {
                    SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                }
                return
            default:
                break
            }
        }
        
        // handle tap events
        if let menuValue = selectedMenu.menuValue
        {
            switch menuValue {
                
            case SAModule.todayAtGlance.rawValue:
                screenCodeName = "TST_TAG"
                pageName = "Today at a Glance"
                self.userActivity()
                if let guestCard = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "TodayAtGlanceVC") as? TodayAtGlanceVC {
                    self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
                    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
                    self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor

                    self.navigationController?.pushViewController(guestCard, animated: true)
                    
                }
                break;
            case SAModule.calendarOfEvents.rawValue:
                 screenCodeName = "TST_CAE"
                 pageName = "Calendar of Events"
                 self.userActivity()
                 self.appDelegate.filterFrom = "COE"
                 if let guestCard = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "CalendarOfEventsViewController") as? CalendarOfEventsViewController {
                    self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
                    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
                    self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor


                    self.navigationController?.pushViewController(guestCard, animated: true)
                    
                }
                break;
            case SAModule.diningReservation.rawValue:
                
                screenCodeName = "TST_DINRESCON"
                pageName = "Dining Resv & Conf"
                self.userActivity()
                    if let diningReservations = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningReservationViewController") as? DiningReservationViewController {
                        self.appDelegate.golfEventsSearchText = ""
                        self.appDelegate.categoryForBuddy = "Dining"
                        diningReservations.diningSettings = self.diningSettingsDetail
                        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
                        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
                        self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor

                        self.navigationController?.pushViewController(diningReservations, animated: true)

                    }


                   /* if let restaurents = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "RestaurantsViewController") as? RestaurantsViewController {
                        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
                        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
                        self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor

                        self.navigationController?.pushViewController(restaurents, animated: true)
                        
                    }*/
                    break;
            case SAModule.golfReservation.rawValue:
                screenCodeName = "TST_TEETIME"
                pageName = "Tee Times"
                self.userActivity()
                if let teeTimesVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "TeeTimesViewController") as? TeeTimesViewController {
                   // teeTimesVC.reservationSettings = reservationSettings
                    teeTimesVC.golfSettings = self.golfSettingsDetail

                    self.appDelegate.golfEventsSearchText = ""
                    self.appDelegate.categoryForBuddy = "Golf"
                    self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
                    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
                    self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor

                    self.navigationController?.pushViewController(teeTimesVC, animated: true)
                    
                }
                  break;
            case SAModule.tennisReservation.rawValue:
                screenCodeName = "TST_COURTREQCON"
                pageName = "Court Requests & Confirmations"
                self.userActivity()
                if let courtTimesVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "CourtTimesViewController") as? CourtTimesViewController {
                    courtTimesVC.tennisSettings = self.courtSettingsDetail
                    self.appDelegate.golfEventsSearchText = ""
                    self.appDelegate.categoryForBuddy = "Tennis"
                    self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
                    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
                    self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor

                    self.navigationController?.pushViewController(courtTimesVC, animated: true)
                    
                }
                    break;
            case SAModule.fitnessSpaAppointment.rawValue:
                
                screenCodeName = "TST_FITSPA" //"TST_MOBMEHO"
                pageName = "Fitness & Spa" //"Mobile - Menus & Hours"
                self.userActivity()
                           
                if let spaAndFitness = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "SpaAndFitnessViewController") as? SpaAndFitnessViewController
                {
                    self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
                    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
                    self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor
                    self.navigationController?.pushViewController(spaAndFitness, animated: true)
                    
                }
                    break;
            case SAModule.giftCard.rawValue:
                screenCodeName = "TST_MYGIC"
                pageName = "My Gift Card"
                self.userActivity()
                    if let giftCard = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "GiftcardViewController") as? GiftCardVC {
                        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
                        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
                        self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor

                        self.navigationController?.pushViewController(giftCard, animated: true)
                        
                    }
                    break;
            case SAModule.guestCard.rawValue:
                screenCodeName = "TST_MYGUEC"
                pageName = "My Guest Card"
                self.userActivity()
                self.appDelegate.filterFrom = ""
                    if let guestCard = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "GuestCardsViewController") as? GuestCardsViewController {
                        guestCard.isFrom = "Dashboard"
                        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
                        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
                        self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor

                        self.navigationController?.pushViewController(guestCard, animated: true)
                        
                    }
                    break;
            case SAModule.statements.rawValue:
                screenCodeName = "TST_MYSTS"
                pageName = "My Statements"
                self.userActivity()
                if let statements = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "StatementViewController") as? StatementViewController {
                    self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
                    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
                    self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor

                    self.navigationController?.pushViewController(statements, animated: true)
                    
                }
                break;
            
            case SAModule.importantClubNumbers.rawValue:
                screenCodeName = "TST_IMCN"
                pageName = "Important Club Numbers"
                self.userActivity()
                if let importantNumber = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ImportantNumberViewController") as? ImportantNumberViewController {
                    self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
                    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
                    self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor

                    self.navigationController?.pushViewController(importantNumber, animated: true)
                    
                }
                break;
            
            case SAModule.memberDirectory.rawValue:
                screenCodeName = "TST_MEMD"
                pageName = "Member Directory"
                self.userActivity()
                if let memberDirectory = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MemberDirectoryViewController") as? MemberDirectoryViewController {
                    memberDirectory.isFromDashBoard = true
                    self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
                    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
                    self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor

                    self.navigationController?.pushViewController(memberDirectory, animated: true)
                    
                }
                break;
            case SAModule.memberID.rawValue:
                screenCodeName = "TST_MEMID"
                pageName = "MemberID"
                self.userActivity()
                if let memberID = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MemberIDViewController") as? MemberIDViewController {
                    self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
                    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
                    self.navigationController?.pushViewController(memberID, animated: true)
                    self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor

                }
                break;
            default:
                
                break;
            }
            
        }
        
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

    @IBAction func allNewsClicked(_ sender: Any)
    {
        //Uncoment when needed
        //Added on 4th July 2020 V2.2
        //Added roles and privilages changes
        /*switch self.accessManager.accessPermision(for: .viewNews)
        {
        case .notAllowed:
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        default:
            break
        }*/
        
        
        
        screenCodeName = "TST_CLN"
        pageName = "Club News"
        self.userActivity()
        self.appDelegate.filterFrom = ""

       if let allNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AllClubNewsViewController") as? AllClubNewsViewController {
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
        self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor
            self.navigationController?.pushViewController(allNews, animated: true)

        }
    }
    @IBAction func notificationClicked(_ sender: Any) {
        
        
        
 
    }
    
    @IBAction func twitterClicked(_ sender: Any) {
        
        let twitterUrl = URL(string: "twitter://user?screen_name=")
        if UIApplication.shared.canOpenURL(twitterUrl!) {
            UIApplication.shared.open(twitterUrl!, options: [:], completionHandler: nil)
        } else {
            //redirect to safari because the user doesn't have Instagram
            if self.twitterLink == "" || self.twitterLink == nil{}else{
            UIApplication.shared.open(URL(string: self.twitterLink ?? "")!, options: [:], completionHandler: nil)
            }
        }
    }
    @IBAction func pinterestClicked(_ sender: Any) {
       
        let pinterestUrl = URL(string: "pinterest://user/")
        if UIApplication.shared.canOpenURL(pinterestUrl!) {
            UIApplication.shared.open(pinterestUrl!, options: [:], completionHandler: nil)
        } else {
            //redirect to safari because the user doesn't have Instagram
            if self.pinterestLink == "" || self.pinterestLink == nil{}else{
            UIApplication.shared.open(URL(string: self.pinterestLink ?? "")!, options: [:], completionHandler: nil)
            }
        }
        
    }
    
    @IBAction func fbClicked(_ sender: Any) {
        
        let fbUrl = URL(string: "fb://profile/")
        if UIApplication.shared.canOpenURL(fbUrl!) {
            UIApplication.shared.open(fbUrl!, options: [:], completionHandler: nil)
        } else {
            //redirect to safari because the user doesn't have Instagram
            if self.facebookLink == "" || self.facebookLink == nil{}else{
            UIApplication.shared.open(URL(string: self.facebookLink ?? "")!, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func instClicked(_ sender: Any) {
        let instagramHooks = "instagram://user?username="
        let instagramUrl = URL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl!) {
            UIApplication.shared.open(instagramUrl!, options: [:], completionHandler: nil)
        } else {
            //redirect to safari because the user doesn't have Instagram
            if self.instaLink == "" || self.instaLink == nil{}else{
            UIApplication.shared.open(URL(string: self.instaLink ?? "")!, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func linkedInClicked(_ sender: UIButton)
    {
        if (self.linkedInLink?.count ?? 0) < 1
        {
            return
        }
                
        if self.linkedInLink == "" || self.linkedInLink == nil
        {
            
        }
        else
        {
            UIApplication.shared.open(URL(string: self.linkedInLink ?? "")!, options: [:], completionHandler: nil)
            
        }
    }
    
    //Added by kiran -- ENGAGE0011226 -- added for Covid rules
    @IBAction func alertClicked(_ sender: UIButton)
    {
        if let alertDetailsVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AlertDetailsViewController") as? AlertDetailsViewController
        {
            alertDetailsVC.screenName = self.alertTitle
            self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor
            self.navigationController?.pushViewController(alertDetailsVC, animated: true)
        }
    }
    
    @objc func notificationButtonClick(sender : UITapGestureRecognizer)
    {
        
        //Added on 4th July 2020 V2.2
        //Added roles and privilages changes
        //Uncommnet if needed
        /*
         switch self.accessManager.accessPermision(for: .notifications) {
         case .notAllowed:
             if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
             {
                 SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
             }
             return
         default:
             break
         }
         */
        
        
        screenCodeName = "TST_NTF"
        pageName = "Notifications"
        self.userActivity()
        
        if let notificationList = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "NotificationListViewController") as? NotificationListViewController {
           // notificationList.arrNotifications = self.arrNotifications
            
            self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
            self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor
            self.navigationController?.pushViewController(notificationList, animated: true)
        }
    }
    
    //MARK:- Reservations Settings  Api

    func requestReservationApi() {
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        let paramaterDict: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue) ?? "",
            "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue) ?? ""
            ]
        
        APIHandler.sharedInstance.getReservationSettings(paramater: paramaterDict , onSuccess: { response in

           
            self.golfSettingsDetail = response.golfSettings
            self.courtSettingsDetail = response.tennisSettings
            self.diningSettingsDetail = response.dinningSettings
            self.appDelegate.arrGolfSettings = response.golfSettings
            self.appDelegate.arrTennisSettings = response.tennisSettings
            self.appDelegate.arrDiningSettings = response.dinningSettings
         
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            self.appDelegate.hideIndicator()
            
        }
    }
}

//MARK:- Beacon & Geo-fence related Functions
extension DashBoardViewController
{
    //Added by kiran V2.5 --ENGAGE0011344 -- Gimbal Integration
    //ENGAGE0011344 -- start
    
    //Commented by kiran V2.7 -- ENGAGE0011628 -- Commented beacuse this logic is moved to Dashboard api call
    //ENGAGE0011628 -- Start
    /*private func startGimbalServices()
    {
        if Gimbal.isStarted()
        {

        }
        else
        {
            //Modified by kiran V2.6 - Changed to make setting as false by default, so unless member starts the service from settings screen beacons won't be detected.
//            if !UserDefaults.standard.bool(forKey: UserDefaultsKeys.hasInitiatedGimbalFirstTime.rawValue)
//            {
//                Gimbal.start()
//                UserDefaults.standard.setValue(true, forKey: UserDefaultsKeys.hasInitiatedGimbalFirstTime.rawValue)
//            }
        }
        
    }*/
    //ENGAGE0011628 -- End
    //ENGAGE0011344 -- End
    
    //Added by kiran V2.5 --ENGAGE0011341 -- Gimbal Geo fence implementation
    //NOTE:- this functionality is not implemneted yet as of V2.5. This is still in R&D.
    //ENGAGE0011341 -- start
    /*
    private func updateGeofences( fences : [CSSIGeofence]?)
    {
        
        if let fences = fences
        {
            
            if let monitoredRegions = self.appDelegate.locationManager?.monitoredRegions
            {
                for monitoredRegion in monitoredRegions
                {
                    //removing geo fence if its not in the list. monitoredRegion.identifier.contains("com.bocawest") ensures we only remove the geo fences we assigned
                    if (!fences.contains(where: {$0.id == monitoredRegion.identifier})) && monitoredRegion.identifier.contains("com.bocawest")
                    {
                        self.appDelegate.locationManager?.stopMonitoring(for: monitoredRegion)
                    }
                    
                }
                
            }
            
            for geofence in fences
            {
                //adding geo fence if its not already added
                if !(self.appDelegate.locationManager?.monitoredRegions.contains(where: {$0.identifier == geofence.id}) ?? false)
                {
                    let region = self.appDelegate.createRegionWith(latitude: geofence.latitude!, longitude: geofence.longitude!, radius: geofence.radius!, id: geofence.id!)
                    region.notifyOnExit = false
                    self.appDelegate.locationManager?.startMonitoring(for: region)
                }
                
            }
            
        }
        
    }
    */
    //ENGAGE0011341 -- End
    
}

//Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
//PROD0000069 -- Start
extension DashBoardViewController : RegisterEventVCDelegate, DiningEventRegistrationVCDelegate
{
    
    private func navigateToEventsScreen(selectedNews : ClubNews)
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
        if selectedNews.eventCategory?.lowercased() == "dining"
        {
            guard let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningEventRegistrationVC") as? DiningEventRegistrationVC else{return}
            
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
                    registerVC.isViewOnly = true
                    registerVC.eventType = selectedNews.isMemberCalendar
                    registerVC.requestID = selectedNews.requestID
                    registerVC.isFrom = "EventUpdate"
                    registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
                    registerVC.showStatus = true
                    registerVC.strStatus = selectedNews.eventstatus ?? ""
                    registerVC.strStatusColor = selectedNews.colorCode ?? "#FFFFFF"
                    registerVC.delegate = self
                    registerVC.navigatedFrom = .dashboard
                    self.navigationController?.pushViewController(registerVC, animated: true)
                }
            //3 is cancel, 4 is view only.
            case "3","4":
                
                registerVC.eventID = selectedNews.eventID
                registerVC.eventCategory = selectedNews.eventCategory
                registerVC.isViewOnly = true
                registerVC.eventType = selectedNews.isMemberCalendar
                registerVC.requestID = selectedNews.requestID
                registerVC.isFrom = "EventUpdate"
                registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
                registerVC.showStatus = true
                registerVC.strStatus = selectedNews.eventstatus ?? ""
                registerVC.strStatusColor = selectedNews.colorCode ?? "#FFFFFF"
                registerVC.delegate = self
                registerVC.navigatedFrom = .dashboard
                self.navigationController?.pushViewController(registerVC, animated: true)
            //1 is request, 2 is modify
            case "1","2":
                
                registerVC.eventID = selectedNews.eventID
                registerVC.eventCategory = selectedNews.eventCategory
                registerVC.eventType = selectedNews.isMemberCalendar
                registerVC.requestID = selectedNews.requestID
                registerVC.isFrom = "EventUpdate"
                registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
                registerVC.delegate = self
                registerVC.navigatedFrom = .dashboard
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
            
        }
        else
        {
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
                    registerVC.navigatedFrom = .dashboard
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
                registerVC.navigatedFrom = .dashboard
                self.navigationController?.pushViewController(registerVC, animated: true)
            //1 is request, 2 is modify
            case "1","2":
                
                registerVC.eventID = selectedNews.eventID
                registerVC.eventCategory = selectedNews.eventCategory
                registerVC.eventType = selectedNews.isMemberCalendar
                registerVC.isFrom = "EventUpdate"
                registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
                registerVC.delegate = self
                registerVC.navigatedFrom = .dashboard
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
            
        }
        
        //Old logic
        /*
        if selectedNews.eventCategory?.lowercased() == "dining"
        {
            if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningEventRegistrationVC") as? DiningEventRegistrationVC
            {
                registerVC.eventID = selectedNews.eventID
                registerVC.eventCategory = selectedNews.eventCategory
                registerVC.eventType = selectedNews.isMemberCalendar
                registerVC.requestID = selectedNews.requestID
                registerVC.isFrom = "EventUpdate"
                registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
                registerVC.delegate = self
                registerVC.navigatedFrom = .dashboard
                self.navigationController?.pushViewController(registerVC, animated: true)
            }
        }
        else
        {
            if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "RegisterEventVC") as? RegisterEventVC
            {
                registerVC.eventID = selectedNews.eventID
                registerVC.eventCategory = selectedNews.eventCategory
                registerVC.eventType = selectedNews.isMemberCalendar
                registerVC.isFrom = "EventUpdate"
                registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
                registerVC.delegate = self
                registerVC.navigatedFrom = .dashboard
                self.navigationController?.pushViewController(registerVC, animated: true)
            }
            
        }
        */
        //PROD0000069 -- End
    }
    
    func eventSuccessPopupClosed()
    {
        
    }
    
    func diningEventSuccessPopupClosed()
    {
        
    }
    
}
//PROD0000069 -- End

//Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for composing Emails
//PROD0000069 -- Start
extension DashBoardViewController : MFMailComposeViewControllerDelegate
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
