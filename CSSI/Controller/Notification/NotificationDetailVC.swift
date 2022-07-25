//
//  NotificationDetailVC.swift
//  CSSI
//  Created by apple on 3/7/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class NotificationDetailVC: UIViewController {
    
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var uiScrollView: UIScrollView!
    //Added on 7th August 2020 v2.3
    //removed the label which shows the message and replaced with textview
    @IBOutlet weak var txtViewMessage: UITextView!
    
    var notificationText: String?
    var notificationSubject: String?
    var notificationID: String?
    

    var details: Any!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Added on 21st October 2020 V2.4
    ///When true will fetch details from api using notification id
    var shouldUseAPi = false
    
    //Added by Kiran V2.5 --GATHER0000441-- Notifications not removing from system tray when opened from app
    var isRead : Bool?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   
        self.title = ""
        self.txtViewMessage.text = ""
        self.lblSubject.text = ""
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        
        self.navigationItem.title = self.appDelegate.masterLabeling.tT_NOTIFICATIONS
        self.navigationController?.navigationBar.barTintColor = APPColor.navigationColor.barTintColor
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = APPColor.navigationColor.barTintColor
        
        //self.notificationReadApi()
        //Added on 21st October 2020 V2.4
        if self.shouldUseAPi
        {
            self.notificationDetails(strSearch: "")
        }
        else
        {
            self.notificationReadApi()
            //Modified on 7th August 2020 V2.3
            //Added support clickable links
            let attributedString : NSMutableAttributedString = NSMutableAttributedString.init(attributedString: (notificationText ?? "").generateAttributedString(isHtml: true) ?? NSAttributedString.init())
            
            let fontSize : CGFloat = CGFloat.init(Double.init(self.appDelegate.masterLabeling.notification_Font_Size ?? "18")!)
            
            attributedString.addAttributes([NSAttributedStringKey.font : UIFont.init(name: "SourceSansPro-Semibold", size: fontSize)!,.foregroundColor : hexStringToUIColor(hex: "#695B5E")], range: NSRange.init(location: 0, length: attributedString.length))
            
            self.txtViewMessage.attributedText = attributedString

            lblSubject.text = notificationSubject
        }
        
        if(self.appDelegate.masterLabeling.tT_NOTIFICATIONS  == nil ){
            self.navigationItem.title = "Notifications"
        }
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
       
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
   
    //Added by Kiran V2.5 --GATHER0000441-- Notifications not removing from system tray when opened from app
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard self.isRead == false else{return}
        if UIApplication.shared.applicationIconBadgeNumber > 0
        {
            UIApplication.shared.applicationIconBadgeNumber -= 1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
        //self.navigationController?.setNavigationBarHidden(true, animated: animated)
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //Note:- Never remove this. When this screen is opened by clickng on the push notification, we are adding the tabr bar controller which has navigation controller with Dashbaord screen in another navigation bar and this is the only place where we have access to this new navigation bar.
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK:- Notification Read Api
    func notificationReadApi() {
        
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                "USERNAME": UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                "NotificationDetailID": notificationID ?? ""
                
                ]
            
            
            APIHandler.sharedInstance.getNotificationStatus(paramater: paramaterDict, onSuccess: { notificationList in
                self.appDelegate.hideIndicator()
                if(notificationList.responseCode == InternetMessge.kSuccess)
                {
                   // self.notificationDetails(strSearch: self.notificationSearch.text!)
                    
                    self.appDelegate.hideIndicator()
                }else{
                    self.appDelegate.hideIndicator()
                    if(((notificationList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: notificationList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                }
                
                
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
    
   
}

//Added on 21st October 2020 V2.4
//MARK:- Notification detail APi
extension NotificationDetailVC
{
    //MARK:- Notification Details Api
    private func notificationDetails(strSearch :String?)
    {
        if (Network.reachability?.isReachable) == true
        {
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                "USERID": UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                "Modulekey":"MB",
                "SearchText": strSearch ?? ""
                
                ]
            
            
            APIHandler.sharedInstance.getNotificationDetails(paramater: paramaterDict, onSuccess: { notificationList in
                
                self.appDelegate.hideIndicator()
                self.notificationReadApi()
                
                if(notificationList.data == nil)
                {
                    SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: InternetMessge.kNoData, withDuration: Duration.kMediumDuration)
                    
                }
                else
                {
                    if let notifications = notificationList.data , let notification = notifications.first(where: {$0.notificationDetailID == self.notificationID})
                    {
                        self.notificationText = notification.message
                        self.notificationSubject = notification.messageHeader
                        
                        let attributedString : NSMutableAttributedString = NSMutableAttributedString.init(attributedString: (self.notificationText ?? "").generateAttributedString(isHtml: true) ?? NSAttributedString.init())
                        
                        let fontSize : CGFloat = CGFloat.init(Double.init(self.appDelegate.masterLabeling.notification_Font_Size ?? "18")!)
                        
                        attributedString.addAttributes([NSAttributedStringKey.font : UIFont.init(name: "SourceSansPro-Semibold", size: fontSize)!,.foregroundColor : hexStringToUIColor(hex: "#695B5E")], range: NSRange.init(location: 0, length: attributedString.length))
                        
                        self.lblSubject.text = self.notificationSubject
                        
                        self.txtViewMessage.attributedText = attributedString
                    }
                    
                }

            },onFailure: { error  in
                self.appDelegate.hideIndicator()
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
    
}
