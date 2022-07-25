
import UIKit
import IQKeyboardManagerSwift
import MBProgressHUD
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import UserNotifications
import Contacts
import CoreLocation
import FirebaseCore
import CoreBluetooth
import Gimbal
import AppTrackingTransparency

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate
{
    
    let gcmMessageIDKey = "gcm.message_id"
    
    var window: UIWindow?
    var navController: UINavigationController?

    var activityIndicator = MBProgressHUD()
    var isMoveToParentViewController = Bool()
    var arrSelectedTagg = [String]()
    var dictGuestCardDetails = GuestCardDetail()
    var guestID = String()
    var arrRequest = [Guest1]()
    var strFilterSting = String()
    var tabbarControllerInit = TabbarModel()
    var strguestresource = String()
    var masterLabeling = Label()
    var registeryourdevice = Label()
    
    var authTokenTimer = Timer()
    var selectedGuest = Guest1()
    var isViewNews = String()
    
    var selectedStmtCategory = ListStatementCategories()
    var selectedEventsCategory = ListEventCategory()
    var selectedGlanceCategory = GlanceCategory()
    var selectedPreviousStmtCategory = ListStatementCategories()

    var arrReleationList = [GuestRelation]()
    var contactStore = CNContactStore()
    var arrWeeks = [Week]()
    var arrDays = [Day]()
    var arrBoardofGovernors = [BoardofGovernors]()
    var arrTimeForClubnews = [ClubNewsRotationValue]()
    var arrMonthName = [ListOfMonths]()
    var arrRelationFilter = [RelationFilter]()
    var arrDateSort = [DateSort]()
    var arrCalenderSortFilter = [DateSort]()
    var arrEventStatusFilter = [EventStatusFilter]()

    var arrSufix = [Suffix]()
    var arrPrefix = [Prefix]()
    var arrAddressTypes = [AddressTypes]()
    var arrAllMarketingOptions = [AllMarkettingOtions]()
    var arrAllInterest = [MyTotalInterest]()
    var arrStates = [States]()
    var arrReminderTime = [ReminderTime]()
    //Commented by kiran V2.5 -- ENGAGE0011395 -- Settings screen implementation change
    //ENGAGE0011395 -- Start
    //var arrSettingList = [SettingList]()
    //ENGAGE0011395 -- End
    var arrShareUrlList = [ShareURL]()
    //Commented by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
    //GATHER0000606 -- Start
    //var arrEventRegType = [RegisterType]()
    //var arrRegisterMultiMemberType = [RegisterType]()
    //var arrEventRegTypeMemberOnly = [RegisterType]()
    //GATHER0000606 -- End
    var arrReqDayType = [SelectionDayType]()
    var arrDuration = [DurationType]()
    var arrGolfGame = [GolfGameType]()
    var arrGuestType = [GuestType]()
    var arrGolfLeagues = [GolfLeagues]()
    var arrGolfSettings : GolfSettings?
    var arrTennisSettings : TennisSettings?
    var arrDiningSettings : DinningSettings?
    var guestNumberOfday = Int()
    var downloadMonth = String()
    var downloadYear = String()

    var arrCancelPopImageList = [CancelPopImage]()
    var giftCardSearchText = String()
    var statementSearchText = String()
    var groupType = String()
    var groupID = String()
    
    var requestFrom = String()

    var golfEventsSearchText = String()
    
    var typeOfCalendar = String()
    var categoryForBuddy = String()
    var buddyType = String()
    var myValue = String()
    var eventsCloseFrom = String()
    var dateSortFromDate = String()
    var dateSortToDate = String()
    var segmentIndex = Int()
    var selectedSegment = String()
    
    var statementStartDate = String()
    var statementEndDate = String()
    var memberDictSearchText = String()
    var guestCardSearchText = String()
    var closeFrom = String()
    var specialCloseFrom = String()
    var currentVersion : String?
    var versionFromServer: String?
    var filterFrom: String?
    
    var monthCount : Int = 0
    
    var EventKidInstruction = [Instruction]()
    var DirectoryMemberKidInstruction = [Instruction]()
    var DirectoryBuddyKidInstruction = [Instruction]()
    var EventGuestInstruction = [Instruction]()
    var DirectoryMemberGuestInstruction = [Instruction]()
    var DirectoryBuddyGuestInstruction = [Instruction]()
    var EventGuestKidInstruction = [Instruction]()
    var DirectoryMemberGuestKidInstruction = [Instruction]()
    var DirectoryBuddyGuestKidInstruction = [Instruction]()
    var ReservationsInstruction = [Instruction]()
    var DiningEventInstruction = [Instruction]()
    var MemberOnlyEventInstruction = [Instruction]()
    
    var privacyPolicyLink : String?
    var termsOfUsageLink : String?
    
    //BMS Chanegs
    //Added on 1st June 2020 BMS
    var BMSOrder : [FlowSequence] = [FlowSequence]()
    ///Fitness and SPA BMS appointment details
    var bookingAppointmentDetails : BMSAppointmentDetails = BMSAppointmentDetails()
    
    var BMS_cancelReasons = [CancelReason]()
    
    //Added on 4th June 2020 BMS
    
    var genderFilterOptions : [FilterOption] = [FilterOption]()
    
    //Added on 11Th july 2020 V2.2
    //Added to track app entering background state
    private var appDidEnterBackground = false
    
    //Added on 4th September 2020 V2.3
    var guestGenderOptions : [GuestGender] = [GuestGender]()
    
    //Added on 9th October 2020 V2.3
    //Commented by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
    //GATHER0000606 -- Start
    //var MB_Dining_RegisterMemberType = [BWOption]()
    //GATHER0000606 -- End
    var MB_Dining_RegisterMemberType_MemberOnly = [BWOption]()
    
    //Added on 12th October 2020 V2.3
    var giftCertificateCardType = [BWOption]()
    var giftCertificateStatus = [FilterOption]()
    
    //Added on 28th October 2020 V2.3 -- GATHER0000176
    var fitnessSettings = [FitnessSetting]()
    var appFitnessMenu = [HamburgerMenu]()
    
    //Added by kiran V2.5 --ENGAGE0011344 -- Gimbal Integration
    //ENGAGE0011344 -- start
    //MARK:- Uncomment For Beacon implementation
    var isGimbalInitialized = false
    var gimbalPlaceManager : PlaceManager!
    //var gimbalBeaconManager : BeaconManager!
    var locationManager : CLLocationManager?
    var bluetoothManager: CBCentralManager?
    var beaconDetails : [BeaconDetails]?
 
    //ENGAGE0011344 -- End
    
    //Added by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
    //GATHER0000606 -- Start
    var addRequestOpt_BMS = [BWOption]()
    var addRequestOpt_Events = [BWOption]()
    var addRequestOpt_Dining = [BWOption]()
    var addRequestOpt_Dining_MultiSelect = [BWOption]()
    var addRequestOpt_Golf = [BWOption]()
    var addRequestOpt_Golf_MultiSelect = [BWOption]()
    var addRequestOpt_Tennis = [BWOption]()
    var addRequestOpt_Tennis_MultiSelect = [BWOption]()
    //GATHER0000606 -- End
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        
        //Old run script for fabric
        //"${PROJECT_DIR}/Fabric.framework/run" 9f2041046aaf3d0b912ae34c002339a96c049ab6 a0a46fa597de595989c2713a44e439019cddf464feb4713e52953af5d7f6470f
        FirebaseApp.configure()
        //Modified by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
        //ENGAGE0012667 -- Start
        navController = CustomNavigationController()//UINavigationController()
        //ENGAGE0012667 -- End

        isViewNews = "First"
        
        // Check Internet connection
        do {
            Network.reachability = try Reachability(hostname: "www.google.com")
            do {
                try Network.reachability?.start()
            } catch let error as Network.Error {
                print(error)
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
        
       
       // UIApplication.shared.applicationIconBadgeNumber = 10
        
        //Commented by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
        //ENGAGE0012667 -- Start
        /*
        
        // Title text color Black => Text appears in white
        UINavigationBar.appearance().barStyle = UIBarStyle.black
        // Translucency; false == opaque
        UINavigationBar.appearance().isTranslucent = false
        // BACKGROUND color of nav bar
        UINavigationBar.appearance().barTintColor = APPColor.navigationColor.barbackgroundcolor //UIColor.red
        // Foreground color of bar button item text, e.g. "< Back", "Done", and so on.
        //        UINavigationBar.appearance().tintColor = APPColor.tintColor.tint
        UINavigationBar.appearance().tintColor = APPColor.viewBgColor.viewbg
        */
        //ENGAGE0012667 -- End
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = APPColor.navigationColor.barbackgroundcolor
        UITabBar.appearance().tintColor = UIColor.white
        
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        
        let memberid = UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)
        
        if memberid == nil {
            print("Member Id null")
        }
        else{
            let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
            self.window?.rootViewController = tabBarVC
            self.window?.makeKeyAndVisible()
        }
        
        //Added by kiran V1.3 -- PROD0000028 -- Setting default style as light. To fix the issue in app where background is turning to black in dark mode.
        //PROD0000028 -- Start
        if #available(iOS 13.0, *)
        {
           self.window?.overrideUserInterfaceStyle = .light
        }
        //PROD0000028 -- End
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in
                    //Added by kiran V2.5 --ENGAGE0011344 -- Gimbal Integration
                    //ENGAGE0011344 -- start
                    //MARK:- Uncomment For Beacon implementation
                    
                    DispatchQueue.main.async {
                        self.locationManager = CLLocationManager.init()
                        self.locationManager?.delegate = self
                    }
                    self.bluetoothManager = CBCentralManager.init(delegate: self, queue: nil)
                     
                    //ENGAGE0011344 -- End
                })
            // For iOS 10 data message (sent via FCM
            Messaging.messaging().delegate = self
            //            messaging().remoteMessageDelegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        

        application.registerForRemoteNotifications()

//        Fabric.sharedSDK().debug = true
//        Fabric.with([Crashlytics.self])

        self.logUser()
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool
    {
        UNUserNotificationCenter.current().delegate = self
        
        //MARK:- Uncomment for app release
        //APIHandler.sharedInstance.generateBaseURL()
        
        return true
    }
    
    func logUser() {
        // TODO: Use the current user's information
        // You can call any combination of these three methods
        
        Crashlytics.crashlytics().setUserID("12345")
//        Crashlytics.sharedInstance().setUserEmail("swarup@yujdesigns.com")
//        Crashlytics.sharedInstance().setUserIdentifier("12345")
//        Crashlytics.sharedInstance().setUserName("Test User")
    }
    
    
    func applicationWillResignActive(_ application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication)
    {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application
        
        //Added on 11th July 2020 V2.2
        //Added to refresh dashboard when app enters from backgroung for roles and privilages changes.
        self.appDidEnterBackground = true
    }

    class func getAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    private func checkActiveAndUpdateStatus()
    {
        if (Network.reachability?.isReachable) == true{
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                
                ]
            
            print("memberdict \(paramaterDict)")
            APIHandler.sharedInstance.getAppVersion(paramater: paramaterDict, onSuccess: { (response) in
                
                self.versionFromServer = response.currentAppVersion
                
                let appCurrentVersion : String  = (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String)!
                let appVersionFromServer : String  = response.currentAppVersion
                
                
                let currentAppVersion = appCurrentVersion
                let versionFromServer = appVersionFromServer
                
                if UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "" == "" || UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "" == ""{
                    
                }else{
                
                if response.memberStatus == 0{
                    // Create the actions
                    
                    let alertController = UIAlertController(title: self.masterLabeling.mEMBER_DEACTIVATED ?? "Member Deactivated", message: self.masterLabeling.dEACTIVATED_LOGOUT ?? "Your account is Inactive, please contact info@mycobaltsoftware.com", preferredStyle: .alert)
                    
                    // Create the actions
                    let logOut = UIAlertAction(title: self.masterLabeling.lOGOUT ?? "Logout", style: UIAlertActionStyle.default) {
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
                        let navigationController = CustomNavigationController(rootViewController: initialLoginVC) //UINavigationController(rootViewController: initialLoginVC)
                        //ENGAGE0012667 -- End
                        UIApplication.shared.keyWindow?.rootViewController = navigationController
                        UIApplication.shared.keyWindow?.makeKeyAndVisible()

                        //Modified by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
                        //ENGAGE0012667 -- Start
                        let nav: UINavigationController = CustomNavigationController()//UINavigationController()
                        //ENGAGE0012667 -- End

                        self.window?.rootViewController = nav


                        nav.setViewControllers([initialLoginVC], animated: true)
                    }
                    alertController.addAction(logOut)
                    self.window?.rootViewController?.present(alertController, animated: true, completion: nil)

                    
                }
                    
                    //Added by kiran V1.3 -- PROD0000019 -- Added 2 step verification
                    //PROD0000019 -- Start
                    if response.hasAccountExpired == 1
                    {
                        let alertController = UIAlertController(title: self.masterLabeling.authentication_AccountExpired ?? "Account Expired", message: self.masterLabeling.authentication_ExpiredText ?? "Your account has expired, please contact info@mycobaltsoftware.com", preferredStyle: .alert)
                        
                        let logOut = UIAlertAction(title: self.masterLabeling.authentication_Logout ?? "Logout", style: UIAlertActionStyle.default) {
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

                            self.window?.rootViewController = nav


                            nav.setViewControllers([initialLoginVC], animated: true)
                        }
                        alertController.addAction(logOut)
                        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                     }
                    //PROD0000019 -- End
                }
                
                 if (currentAppVersion < versionFromServer) {
                    
                    let alertController = UIAlertController(title: self.masterLabeling.nEW_VERSION_AVAILABLE ?? "New Version Available", message: self.masterLabeling.newVersion_Message ?? "A new version of the app is available, please click the Update button to upgrade to the latest version", preferredStyle: .alert)
                    
                    // Create the actions
                    let okAction = UIAlertAction(title: self.masterLabeling.uPDATE ?? "UPDATE", style: UIAlertActionStyle.default) {
                        UIAlertAction in
                        
                        guard let url = URL(string: "https://itunes.apple.com/us/app/cobaltengage/id1536936241") else { return }
                        UIApplication.shared.open(url)
                    }
                    alertController.addAction(okAction)
                    
                    self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                    
                }
                
               
                
            }) { (error) in
                
            }
        
        }

    }
    
    //Added on 11th July 2020 V2.2
    //Performs view will appear when app comes to foreground from background
    private func performRolesAndPrivalagesRefresh()
    {
        //Added to refresh dashboard when app enters from backgroung for roles and privilages changes.
        if self.appDidEnterBackground
        {
            self.appDidEnterBackground = false
            if let dashboard = ((self.window?.rootViewController as? UITabBarController)?.viewControllers?.first as? UINavigationController)?.topViewController as? DashBoardViewController
            {
                dashboard.performWillApperAction()
            }
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        //self.checkActiveAndUpdateStatus()
        
    }
    
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            
        }
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        //added on 11th July 2020 V2.2
        self.performRolesAndPrivalagesRefresh()
        
        self.checkActiveAndUpdateStatus()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func showIndicator(withTitle: String , intoView: UIView){
        self.activityIndicator.removeFromSuperview()
        self.activityIndicator = MBProgressHUD.init()
        intoView.addSubview(self.activityIndicator)
        self.activityIndicator.show(animated: true)
        self.activityIndicator.backgroundColor = UIColor.clear
        self.activityIndicator.label.text = withTitle
        self.activityIndicator.bezelView.color = UIColor.darkGray
        self.activityIndicator.tintColor = .white
        self.activityIndicator.contentColor = .white
            //   activityIndicator.bezelView.style = .solidColor
    }
    
    func hideIndicator() {
        self.activityIndicator .show(animated: false)
        self.activityIndicator .removeFromSuperview()
    }
    
    //OLd logic commented on 14th May 2020 V2.1
    /*
    func imageDataToDict(list : [ImageData]?) -> [[String : Any]]
    {
        var imagesDict = [[String : Any]]()
        
        if let imagesList = list
        {
            for imageData in imagesList
            {
                imagesDict.append(["NewsImage" : imageData.NewsImage , "ImageID" : imageData.ImageID])
            }
        }
        
    
        return imagesDict
    }*/
    
    func imageDataToMediaDetails(list : [ImageData]?) -> [MediaDetails]
    {
        var arrImagesData = [MediaDetails]()
        
        if let imagesList = list
        {
            for imageData in imagesList
            {
                if let dictDetails = imageData.toDict(), let medaiDetails = MediaDetails.init(JSON: dictDetails)
                {
                    arrImagesData.append(medaiDetails)
                }
                else
                {
                    continue
                }
                
            }
        }
        
    
        return arrImagesData
    }
    
    //MARK:- [START receive_message]
    // The callback to handle data message received via FCM for devices running iOS 10 or above.
//    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
//        print(remoteMessage.appData)
//    }
    
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        
        let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
        UIApplication.shared.keyWindow?.rootViewController = tabBarVC
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
            
          
            
        }
        
        // Print full message.
        //        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        
        let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
        UIApplication.shared.keyWindow?.rootViewController = tabBarVC
        

        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
            
            
            
        }
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        // Print full message.
        //        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        
        // With swizzling disabled you must set the APNs token here.
        Messaging.messaging().apnsToken = deviceToken
    }
    
}



// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        completionHandler([UNNotificationPresentationOptions.alert,UNNotificationPresentationOptions.sound,UNNotificationPresentationOptions.badge])

        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([])
    }
    
    func userNotificationCenter(center: UNUserNotificationCenter, willPresentNotification notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void)
    {
        //Handle the notification
        completionHandler(
            [UNNotificationPresentationOptions.alert,
             UNNotificationPresentationOptions.sound,
             UNNotificationPresentationOptions.badge])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo

        let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
        UIApplication.shared.keyWindow?.rootViewController = tabBarVC
        
       if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
            
              if  let controller = self.window?.rootViewController as? UITabBarController
              {
                  //Modified by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
                  //ENGAGE0012667 -- Start
                    let nav: UINavigationController = CustomNavigationController()//UINavigationController()
                  //ENGAGE0012667 -- End
                    
                    self.window?.rootViewController = nav
                
                if let notificationDetail = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "NotificationDetailsVC") as? NotificationDetailVC
                {
                    if let notificationInfo = userInfo["aps"] as? [String:Any]
                    {
                        if let notification = notificationInfo["alert"] as? [String:Any]
                        {
                            notificationDetail.notificationSubject = notification["title"] as? String
                            notificationDetail.notificationText = notification["body"] as? String
                            //Modified on 30th September 2020 V2.3
                            //notificationDetail.notificationID = notification["NotificationDetailID"] as? String
                            notificationDetail.notificationID = userInfo["NotificationDetailID"] as? String
                            //Added on 21st October 2020 V2.4
                            notificationDetail.shouldUseAPi = true
                            //Added by Kiran V2.5 --GATHER0000441-- Notifications not removing from system tray when opened from app
                            notificationDetail.isRead = false
                        }
                        
                    }
                    //Commented by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
                    //ENGAGE0012667 -- Start
                    /*
                    nav.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
                    nav.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
                    nav.navigationBar.tintColor = APPColor.viewNews.backButtonColor
                    */
                    //ENGAGE0012667 -- End
                    nav.setViewControllers([controller,notificationDetail], animated: true)
                    
                }
                
              }
              else{
                  //Modified by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
                  //ENGAGE0012667 -- Start
                let nav: UINavigationController = CustomNavigationController()//UINavigationController()
                  //ENGAGE0012667 -- End
                
                self.window?.rootViewController = nav
                
                if let notificationDetail = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                    
                    if let notificationInfo = userInfo["aps"] as? [String:Any] {
                        
                        if let notification = notificationInfo["alert"] as? [String:Any]{
                            
                            notificationDetail.notifyTitle = notification["title"] as? String
                            notificationDetail.notifyText = notification["body"] as? String
                            notificationDetail.isFrom = "Notification"
                            //Added on 21st October 2020 V2.4
                            notificationDetail.notificationID = userInfo["NotificationDetailID"] as? String
                        }
                    }
                    
                    //Commented by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
                    //ENGAGE0012667 -- Start
                    /*
                    nav.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
                    nav.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
                    nav.navigationBar.tintColor = APPColor.viewNews.backButtonColor
                    */
                    //ENGAGE0012667 -- End
                    nav.setViewControllers([notificationDetail], animated: true)
        }

        }
        }
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }
}
// [END ios_10_message_handling]


extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        //Added by kiran V2.5 -- ENGAGE0011322 --
        //Updated FCM as push notifications where not working with old FCM liberary
        guard let fcmToken = fcmToken else{return}
        
        print("Firebase registration token: \(fcmToken)")
        
        UserDefaults.standard.set(fcmToken, forKey: UserDefaultsKeys.FCMToken.rawValue)
        UserDefaults.standard.synchronize()
        
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//        print("Received data message: \(remoteMessage.appData)")
//    }
}


//Added on 10th June 2020
//MARK:- Bluetooth Auth delegate
//MARK:- Uncomment For Beacon implementation
extension AppDelegate : CBCentralManagerDelegate
{
    func centralManagerDidUpdateState(_ central: CBCentralManager)
    {
        //Added by kiran V2.5 --ENGAGE0011344 -- Gimbal Integration
        //ENGAGE0011344 -- start
        var isAllowed = false
        if #available(iOS 13.0,*)
        {
            if central.authorization == .allowedAlways
            {
                isAllowed = true
            }
        }
        else
        {
            isAllowed = true
        }
        
        
        if central.state == .poweredOff || central.state == .resetting || central.state == .unsupported || central.state == .unauthorized
        {
            
        }
        
        if isAllowed
        {
//            self.locationManager = CLLocationManager.init()
//            self.locationManager?.delegate = self
            
            //Added by kiran V2.9 -- ENGAGE0012323 -- Implementing App tracking Transperency changes
            //ENGAGE0012323 -- Start
            if #available(iOS 14.5, *)
            {
                ATTrackingManager.requestTrackingAuthorization { status in
                    
                    switch status
                    {
                    case .authorized:
                        self.locationManager?.requestWhenInUseAuthorization()
                    case .denied:
                        break
                    case .notDetermined:
                        break
                    case .restricted:
                        break
                    }
                    
                }
                
            }
            else
            {
                if #available(iOS 13.0,*)
                {
                    self.locationManager?.requestWhenInUseAuthorization()
                }
                else
                {
                    self.locationManager?.requestAlwaysAuthorization()
                }
            }
            //ENGAGE0012323 -- End
          
        }
        //ENGAGE0011344 -- End
    }
}

//Added on 10th June 2020
//MARK:- Location Auth delegate
extension AppDelegate : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        //Added by kiran V2.5 --ENGAGE0011344 -- Gimbal Integration
        //ENGAGE0011344 -- start
        if status == .authorizedWhenInUse || status == .authorizedAlways
        {
            self.InitializeGimbal()
        }
        
        if #available (iOS 13.0,*)
        {
            if status == .authorizedWhenInUse
            {
                self.locationManager?.requestAlwaysAuthorization()
            }
        }
        
        
        if status == .denied || status == .notDetermined || status == .restricted
        {
             //SharedUtlity.sharedHelper()?.showToast(on: self.window?.rootViewController?.view, withMeassge: "location permission not given", withDuration: 10)
        }
        //ENGAGE0011344 -- End
    }
    
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion)
    {
        //NOTE:- this functionality is not implemneted yet as of V2.5. This is still in R&D.
        //Added by kiran V2.5 --ENGAGE0011341 -- Gimbal Geo fence implementation
        //ENGAGE0011341 -- start
        /*
        //self.showLocalNotificationWith(title: "Geo fence", message: region.identifier, id: region.identifier)
        if region.identifier.contains("startgimbal")
        {
            if !Gimbal.isStarted()
            {
                Gimbal.start()
                //self.showLocalNotificationWith(title: "Started gimbal", message: "", id: region.identifier + "gimbalstarting")
            }
            
        }
        
        if region.identifier.contains("stopgimbal")
        {
            if Gimbal.isStarted()
            {
                Gimbal.stop()
                //self.showLocalNotificationWith(title: "Stopped gimbal", message: "", id: region.identifier + "gimbalstopping")
            }
        }
        
        */
        //ENGAGE0011341 -- End
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion)
    {
        //self.showLocalNotificationWith(title: "Exit", message: region.identifier, id: region.identifier)
    }
    
}

//Added by kiran V2.5 --ENGAGE0011344 -- Gimbal Integration
//ENGAGE0011344 -- start
//MARK:- Gimbal
extension AppDelegate
{
    func InitializeGimbal()
    {
        if self.isGimbalInitialized
        {
            return
        }
        
        //Boca west Keys
        
        //Config for lfapollo@bocawestcc.org Gimbal Account (Live Account)
        //Gimbal.setAPIKey("cd4e4acd-208a-47ad-a883-53b8eaa75674", options: nil)
        
        //config for sivapp@ecssi.com Gimbal account (Test account)
        //Gimbal.setAPIKey("9a16f9f1-bd09-484a-810e-5068ffa328fc", options: nil)
        
        //Cobalt Member App keys
        
        //config for sivapp@ecssi.com Gimbal account (Test account)
        //Gimbal.setAPIKey("2bd61c25-ce5b-4467-aa52-615697fc40cb", options: nil)
        
        //Config for michael@ecssi.com  Gimbal account (West account)
        //Gimbal.setAPIKey("892ba65a-863c-4084-8052-2be06cf968df", options: nil)
        
        //Cobalt Engage App Keys
        //Config for michael@ecssi.com  Gimbal account (West account)
        Gimbal.setAPIKey("88ff8a16-98d4-493d-855c-e87b738ecf67", options: nil)
        
        self.gimbalPlaceManager = PlaceManager()
        self.gimbalPlaceManager.delegate = self
        self.isGimbalInitialized = true
    }
    
}

//MARK:- Gimbal Delegates
extension AppDelegate : PlaceManagerDelegate
{
    func placeManager(_ manager: PlaceManager, didBegin visit: Visit)
    {
        self.loadBeaconDetails()
        if self.beaconDetails?.contains(where: {($0.place == visit.place.name)}) ?? false
        {
            self.sendPlace(visit: visit)
        }
        
    }
    
    
    func placeManager(_ manager: PlaceManager, didEnd visit: Visit)
    {
        self.loadBeaconDetails()
        if self.beaconDetails?.contains(where: {($0.place == visit.place.name)}) ?? false
        {
            self.sendExit(visit: visit)
        }
        
    }
    
    func placeManager(_ manager: PlaceManager, didReceive sighting: BeaconSighting, forVisits visits: [Any])
    {
        self.sendBeacon(sighting : sighting)
    }
    
}

//ENGAGE0011344 -- End

//MARK:- Custom methods
extension AppDelegate
{
    private func showLocalNotificationWith(title: String , message : String,id : String)
    {
        let content = UNMutableNotificationContent.init()
        content.body = message
        content.title = title
        content.sound = .default()
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest.init(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    /*
    func createRegionWith(latitude : CLLocationDegrees,longitude : CLLocationDegrees,radius : CLLocationDegrees,id:String) -> CLCircularRegion
    {
        let regionRadius = self.locationManager!.maximumRegionMonitoringDistance < radius ? self.locationManager!.maximumRegionMonitoringDistance : radius
        let region = CLCircularRegion.init(center: CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude), radius: regionRadius, identifier: id)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        return region
    }
 */
    
    //Added by kiran V2.5 --ENGAGE0011344 -- Gimbal Integration
    //ENGAGE0011344 -- start
    //MARK:- Uncomment For Beacon implementation
    
    private func beaconIDFor(visit : Visit) -> String
    {
        self.loadBeaconDetails()
        if let arrBeaconDetails = self.beaconDetails , let details = arrBeaconDetails.first(where: {$0.place == visit.place.name})
        {
            return details.beaconID ?? "-1"
        }
        return "-1"
    }
    
     ///The Distance received is in meters and will be converted to feet if required on RPOS side or backend.
    private func distanceFor(visit : Visit) -> String
    {
        self.loadBeaconDetails()
        if let arrBeaconDetails = self.beaconDetails , let details = arrBeaconDetails.first(where: {$0.place == visit.place.name})
        {
            return "\(details.placeDistance ?? -1)"
        }
        return "-1"
    }
     ///The Distance received is in meters and will be converted to feet if required on RPOS side or backend.
    private func distanceFor(rssi : NSInteger) -> String
    {
        self.loadBeaconDetails()
        if let arrBeaconDetails = self.beaconDetails , let details = arrBeaconDetails.first(where: {($0.fromRSSI! >= rssi && $0.toRSSI! <= rssi)})
        {
            return "\(details.beaconDistance ?? -1)"
        }
        return "-1"
    }
    
    private func loadBeaconDetails()
    {
        let jsonString = UserDefaults.standard.string(forKey: UserDefaultsKeys.masterList.rawValue) ?? ""
        let memberDirectoryInterest = MemberDirectoryInterest(JSONString: jsonString)
        
        self.beaconDetails = memberDirectoryInterest?.beaconSettings
    }
    
    //ENGAGE0011344 -- End
}

//Added by kiran V2.5 --ENGAGE0011344 -- Gimbal Integration
//ENGAGE0011344 -- start
//MARK:- Beacon APi's
//MARK:- Uncomment For Beacon implementation
extension AppDelegate
{
    func sendBeacon(sighting : BeaconSighting)
    {
        
        if (UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) != nil)
        {
//            let power = (-69 - Double(sighting.rssi))/(10 * 2)
//            let distance = pow(10.0, power)
            
            let distance = self.distanceFor(rssi: sighting.rssi)
            
            //self.showLocalNotificationWith(title: sighting.beacon.uuid, message: "Beacon Detected - Distance - \(distance)", id: "beacon - \(Date())")
            
            let params: [String : Any] = [
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kdeviceInfo: APIHandler.devicedict,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
        
                //"Distance": Double(round(1000*distance)/1000),
                "Distance": distance,
                "Accuracy": distance,
                "Proximity": "OnBeaconSighting",
                "UniqueDeviceID" : UIDevice.current.identifierForVendor!.uuidString,
                "BeaconID": String(format: "%@", sighting.beacon.uuid),
            ]
            
            APIHandler.sharedInstance.beaconIdentification(paramater: params, onSuccess: {
                
            }) {(error) in
                
            }
            
        }
        
    }
    
    private func sendExit(visit : Visit)
    {
        self.loadBeaconDetails()
        if (UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) != nil)
        {
            let beaconID = self.beaconIDFor(visit: visit)
            
            //self.showLocalNotificationWith(title: visit.place.name, message: "Exited the place", id: "place - \(Date())")
            
            let params: [String : Any] = [
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kdeviceInfo: APIHandler.devicedict,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
        
                "Distance": visit.place.identifier,
                "Accuracy": visit.place.identifier,
                "Proximity": "OnExit",
                "UniqueDeviceID" : UIDevice.current.identifierForVendor!.uuidString,
                "BeaconID": String(format: "%@", beaconID)
            ]
            
            APIHandler.sharedInstance.beaconIdentification(paramater: params, onSuccess: {
                
            }) {(error) in
                
            }
            
        }
        
    }
    
    
    private func sendPlace(visit : Visit)
    {
        if (UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) != nil)
        {
            let beaconID = self.beaconIDFor(visit: visit)
            let distance = self.distanceFor(visit: visit)
            
            //self.showLocalNotificationWith(title: "Entered \(visit.place.name)", message: "Entered \(visit.place.name)", id: "Beacons place \(Date())")
            let params: [String : Any] = [
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kdeviceInfo: APIHandler.devicedict,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
        
                "Distance": distance,
                "Accuracy": distance,
                "Proximity": "OnEnter",
                "UniqueDeviceID" : UIDevice.current.identifierForVendor!.uuidString,
                "BeaconID": String(format: "%@", beaconID),
            ]
            
            APIHandler.sharedInstance.beaconIdentification(paramater: params, onSuccess: {
                
            }) {(error) in
                
            }
            
        }
        
    }
}
//ENGAGE0011344 -- End
