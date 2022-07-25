//
//  SettingsViewController.swift
//  CSSI
//
//  Created by apple on 2/21/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit
import Gimbal
import BiometricAuthentication

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, settingDelegate
{
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    //Added by kiran V2.5 -- ENGAGE0011395
    //This is the man source of truth for settings. this will always have the latest values and this array is used to send save request to the server.
    var arrSettings = [Settings]()
    //Commented by kiran V2.5 -- ENGAGE0011395
    //var settingsvalues = Settings()
    
    //let arrList: [String] =
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    //Commented by kiran V2.5 -- ENGAGE0011395
    //ENGAGE0011395 -- Start
//    var isSwichClicked : Bool!
//    var arrTemp = [SettingList]()
//    var selectedSwitch : Int?
    //ENGAGE0011395 -- Stop
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Commented by kiran V2.5 -- ENGAGE0011395
        //ENGAGE0011395 -- Start
        /*
        let device = DeviceInfo.modelName
        arrTemp = appDelegate.arrSettingList
        
        if  ((device == "iPhone XR" ) || (device == "iPhone XS Max") || (device == "iPhone XS" ) || (device == "iPhone X") || (device == "Simulator iPhone XR") )
        {
            if self.arrTemp.count > 1{
            arrTemp.remove(at: 0)
            }
        }
        else
        {
             if self.arrTemp.count > 2
             {
                arrTemp.remove(at: 1)
             }

        }*/
        //ENGAGE0011395 -- End
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = self.appDelegate.masterLabeling.tT_PREFERENCES
//        let backButton = UIBarButtonItem()
        
//        backButton.title = self.appDelegate.masterLabeling.bACK ?? "" as String
        
        //Commented by kiran V2.5 -- ENGAGE0011395
        //ENGAGE0011395 -- Start
//        selectedSwitch = -1
//        isSwichClicked = false
        //ENGAGE0011395 -- End
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
        
      //

        self.getSettingsApi()
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
    //ENGAGE0011297 -- Start
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        
    }
    
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    //ENGAGE0011297 -- End

    
//    override func viewWillDisappear(_ animated: Bool) {
//      self.saveSettings()
//    }
    
    
    
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //Modified by kiran V2.5 -- ENGAGE0011395
        //ENGAGE0011395 -- Start
        return self.arrSettings.count
        
        //return arrTemp.count
        //ENGAGE0011395 -- End
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:SettingsCustomCell = self.settingsTableView.dequeueReusableCell(withIdentifier: "SettingsCell") as! SettingsCustomCell
        
        cell.switchToOnOff.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        cell.delegate = self
        //Added by kiran V2.5 -- ENGAGE0011395
        //ENGAGE0011395 -- Start
        let settingDetails = self.arrSettings[indexPath.row]
        cell.lblTitle.text = settingDetails.settingText
        cell.switchToOnOff.isOn = (settingDetails.settingValue == 1)
        //ENGAGE0011395 -- End
        
        //Commented by kiran V2.5 -- ENGAGE0011395
        //ENGAGE0011395 -- Start
        /*
         cell.lblTitle.text = arrTemp[indexPath.row].name
         let device = DeviceInfo.modelName

        if(isSwichClicked == false){
          
            if indexPath.row == 0  {
                if  ((device == "iPhone XR" ) || (device == "iPhone XS Max") || (device == "iPhone XS" ) || (device == "iPhone X") || (device == "Simulator iPhone XR") ){
                    
                    if(self.settingsvalues.faceIDRecognition == 0)  {
                        cell.switchToOnOff.isOn = false
                        
                    }
                    else{
                        cell.switchToOnOff.isOn = true
                    }
                    
                }
                else{
                    if(self.settingsvalues.fingerPrintRecognition == 0)  {
                        cell.switchToOnOff.isOn = false
                        
                    }
                    else{
                        cell.switchToOnOff.isOn = true
                    }
                }
                
                
            }
            
           
            if indexPath.row == 1 {
                if(self.settingsvalues.allowAppNotifications == 0)  {
                    cell.switchToOnOff.isOn = false
                    
                }
                else{
                    cell.switchToOnOff.isOn = true
                }            }
            if indexPath.row == 2 {
                if(self.settingsvalues.addContactstoPhone == 0)  {
                    cell.switchToOnOff.isOn = false
                }
                else{
                    cell.switchToOnOff.isOn = true
                }            }
            if indexPath.row == 3 {
                if(self.settingsvalues.syncCalendar == 0)  {
                    cell.switchToOnOff.isOn = false
                    
                }
                else{
                    cell.switchToOnOff.isOn = true
                }            }
            if indexPath.row == 4 {
                if(self.settingsvalues.shareImage == 0)  {
                    cell.switchToOnOff.isOn = false
                    
                }
                else{
                    cell.switchToOnOff.isOn = true
                }
            }
            
            //Added by kiran -- ENGAGE0011230
            //Start
//            if indexPath.row == 5
//            {
//                if self.settingsvalues.allowSmsNotifications == 0
//                {
//                    cell.switchToOnOff.isOn = false
//                }
//                else
//                {
//                    cell.switchToOnOff.isOn = true
//                }
//            }
            //End
        }
        
       
        if indexPath.row == 0  {
            
            if  ((device == "iPhone XR" ) || (device == "iPhone XS Max") || (device == "iPhone XS" ) || (device == "iPhone X") || (device == "Simulator iPhone XR") ){
                UserDefaults.standard.set(cell.switchToOnOff.isOn, forKey: UserDefaultsKeys.faceID.rawValue)

            }
            else{
                UserDefaults.standard.set(cell.switchToOnOff.isOn, forKey: UserDefaultsKeys.fingerPrint.rawValue)
            }
        }
       
        if indexPath.row == 1 {
            UserDefaults.standard.set(cell.switchToOnOff.isOn, forKey: UserDefaultsKeys.notification.rawValue)
        }
        if indexPath.row == 2 {
            UserDefaults.standard.set(cell.switchToOnOff.isOn, forKey: UserDefaultsKeys.addToContact.rawValue)
        }
        if indexPath.row == 3 {
            UserDefaults.standard.set(cell.switchToOnOff.isOn, forKey: UserDefaultsKeys.synchCalendar.rawValue)
        }
        if indexPath.row == 4 {
            UserDefaults.standard.set(cell.switchToOnOff.isOn, forKey: UserDefaultsKeys.shareUrl.rawValue)
        }
        //Added by kiran -- ENGAGE0011230
        //Start
//        if indexPath.row == 5
//        {
//            UserDefaults.standard.set(cell.switchToOnOff.isOn, forKey: UserDefaultsKeys.smsNotifications.rawValue)
//        }
        //End
        
       
        if indexPath.row == selectedSwitch{
            self.saveSettings()
        }
        */
        //ENGAGE0011395 -- End
        
        return cell
       
    }
    
    func settingSwitchClicked(cell: SettingsCustomCell)
    {
        
        //Added by kiran V2.5 -- ENGAGE0011395
        //ENGAGE0011395 -- Start
        let indexPath = self.settingsTableView.indexPath(for: cell)!
        
        self.arrSettings[indexPath.row].settingValue = cell.switchToOnOff.isOn ? 1 : 0
        
        switch SettingsKeys.init(rawValue: self.arrSettings[indexPath.row].optionCode!)
        {
        case .fingerPrint:
            UserDefaults.standard.set(cell.switchToOnOff.isOn, forKey: UserDefaultsKeys.fingerPrint.rawValue)
        case .faceID:
            UserDefaults.standard.set(cell.switchToOnOff.isOn, forKey: UserDefaultsKeys.faceID.rawValue)
        case .appNotifications:
            UserDefaults.standard.set(cell.switchToOnOff.isOn, forKey: UserDefaultsKeys.notification.rawValue)
        case .contactsToPhone:
            UserDefaults.standard.set(cell.switchToOnOff.isOn, forKey: UserDefaultsKeys.addToContact.rawValue)
        case .syncCalendar:
            UserDefaults.standard.set(cell.switchToOnOff.isOn, forKey: UserDefaultsKeys.synchCalendar.rawValue)
        case .shareImage:
            UserDefaults.standard.set(cell.switchToOnOff.isOn, forKey: UserDefaultsKeys.shareUrl.rawValue)
        case .gimbalService:
            //Added by kiran V2.5 --ENGAGE0011344 -- Gimbal Integration
            //ENGAGE0011344 -- start
            //MARK:- Uncomment For Beacon implementation
            
            //Added by kiran V2.9 -- ENGAGE0012323 -- Implementing App tracking Transperency changes
            //ENGAGE0012323 -- Start
            let hasAllPermissions = CustomFunctions.shared.gimbalHasAllPermissions()
            
            if hasAllPermissions.status
            {
                if cell.switchToOnOff.isOn
                {
                    self.appDelegate.InitializeGimbal()
                    Gimbal.start()
                }
                else
                {
                    Gimbal.stop()
                }
            }
            
            //Old logic added in ENGAGE0011344
            /*
            if cell.switchToOnOff.isOn
            {
                Gimbal.start()
            }
            else
            {
                Gimbal.stop()
            }
            */
            //ENGAGE0012323 -- End
            //ENGAGE0011344 -- End
        break
        case .none:
            break
        }
        
        self.saveSettings()
        //ENGAGE0011395 -- End
        
        //Commented by kiran V2.5 -- ENGAGE0011395
        //ENGAGE0011395 -- Start
//        selectedSwitch = indexPath?.row
//        isSwichClicked = true
//
//        if cell.switchToOnOff.isOn {
//
//        }
//        else {
//        }
//        self.settingsTableView.reloadData()
        //ENGAGE0011395 -- End
    }
    
    //Mark- Save Settings Api
    func saveSettings() -> Void
    {
        
        //Modified by kiran V2.5 -- ENGAGE0011395
        //ENGAGE0011395 -- Start
        var parameter : [String : Any] = [
            APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict]
        ]
        
        for setting in self.arrSettings
        {
            if let value = setting.settingValue
            {
                parameter.updateValue(value, forKey: setting.optionCode!)
            }
        }
        
        
//        let parameter:[String:Any] = [
//            APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
//            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
//            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
//            "FingerPrintRecognition": UserDefaults.standard.string(forKey: UserDefaultsKeys.fingerPrint.rawValue) ?? 1,
//            "FaceIDRecognition": UserDefaults.standard.string(forKey: UserDefaultsKeys.faceID.rawValue) ?? 1,
//            "AllowAppNotifications": UserDefaults.standard.string(forKey: UserDefaultsKeys.notification.rawValue)!,
//            "AddContactstoPhone": UserDefaults.standard.string(forKey: UserDefaultsKeys.addToContact.rawValue)!,
//            "SyncCalendar": UserDefaults.standard.string(forKey: UserDefaultsKeys.synchCalendar.rawValue)!,
//            "ShareImage": UserDefaults.standard.string(forKey: UserDefaultsKeys.shareUrl.rawValue)!,
//            APIKeys.kdeviceInfo: [APIHandler.devicedict]
//            //Added by kiran -- ENGAGE0011230
//            //APIKeys.smsNotifications :  UserDefaults.standard.string(forKey: UserDefaultsKeys.smsNotifications.rawValue) ?? 0
//        ]
        //ENGAGE0011395 -- End
        //print(parameter)
        
        if (Network.reachability?.isReachable) == true
        {
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.saveSettingsApi(paramaterDict:parameter, onSuccess: { resetPwdinfo in
                
                
                if(resetPwdinfo.responseCode == InternetMessge.kSuccess)
                {

                    self.appDelegate.hideIndicator()
                }
                else
                {
                    self.appDelegate.hideIndicator()
                    if(((resetPwdinfo.responseMessage?.count) ?? 0)>0)
                    {
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: resetPwdinfo.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    
                }

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
    
    
    //Mark- Get Settings Api
    func getSettingsApi() -> Void
    {

        let parameter:[String:Any] = [
            APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict]
        ]
        
        if (Network.reachability?.isReachable) == true
        {
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.getSettingsApi(paramaterDict:parameter, onSuccess: { resetPwdinfo in
                
                if(resetPwdinfo.responseCode == InternetMessge.kSuccess)
                {
                    //Commented by kiran V2.5 -- ENGAGE0011395
                    //ENGAGE0011395 -- Start
                    //self.settingsvalues = resetPwdinfo.getSettings!
                    //ENGAGE0011395 -- End
//                  SharedUtlity.sharedHelper().showToast(on:
//                  self.view, withMeassge:resetPwdinfo.responseCode , withDuration: Duration.kMediumDuration)
                    
                    //Added by kiran V2.5 -- ENGAGE0011395
                    //ENGAGE0011395 -- Start
                    self.arrSettings = resetPwdinfo.getSettings ?? [Settings]()
                    
                    //Modified by kiran V2.9 -- ENGAGE0011569 -- Showing Fingerprint/faceID options based on device capability and if those are setup in device
                    //ENGAGE0011569 -- Start
                    if BioMetricAuthenticator.shared.faceIDAvailable()
                    {
                        self.arrSettings.removeAll(where: {$0.optionCode! == SettingsKeys.fingerPrint.rawValue})
                    }
                    else if BioMetricAuthenticator.shared.touchIDAvailable()
                    {
                        self.arrSettings.removeAll(where: {$0.optionCode! == SettingsKeys.faceID.rawValue})
                    }
                    else
                    {
                        self.arrSettings.removeAll(where: {$0.optionCode! == SettingsKeys.fingerPrint.rawValue})
                        self.arrSettings.removeAll(where: {$0.optionCode! == SettingsKeys.faceID.rawValue})
                    }
                    
                    //Old logic based on device model
                    /*
                    let device = DeviceInfo.modelName
                    
                    if  ((device == "iPhone XR" ) || (device == "iPhone XS Max") || (device == "iPhone XS" ) || (device == "iPhone X") || (device == "Simulator iPhone XR"))
                    {
                        self.arrSettings.removeAll(where: {$0.optionCode! == SettingsKeys.fingerPrint.rawValue})
                    }
                    else
                    {
                        self.arrSettings.removeAll(where: {$0.optionCode! == SettingsKeys.faceID.rawValue})
                    }
                    */
                    //ENGAGE0011569 -- End
                    
                    //Added by kiran V2.5 --ENGAGE0011344 -- Gimbal Integration
                    //ENGAGE0011344 -- start
                    //Override for Contactless checkin value. we are not using the value saved in the server but using the isStarted value of gimbal SDK for State(Start/Stop)
                    //MARK:- Uncomment For Beacon implementation
                    
                    if let index = self.arrSettings.firstIndex(where: {$0.optionCode! == SettingsKeys.gimbalService.rawValue})
                    {
                        //Modified by kiran V2.7 -- ENGAGE0011628 -- removed the logic to update settings based on gimbal status and add the logic to start/Stop the gimbal service based on the setting.
                        //ENGAGE0011628 -- Start
                        
                        //Added by kiran V2.9 -- ENGAGE0012323 -- Implementing App tracking Transperency changes
                        //ENGAGE0012323 -- Start
                        let hasAllPermissions = CustomFunctions.shared.gimbalHasAllPermissions()
                        
                        if hasAllPermissions.status
                        {
                            //Turn service on
                            if self.arrSettings[index].settingValue == 1
                            {
                                self.appDelegate.InitializeGimbal()
                                //Checks if the gimbal service is off. if its turned off then we start the service.
                                if !Gimbal.isStarted()
                                {
                                    Gimbal.start()
                                }
                            }//Turn service off
                            else if self.arrSettings[index].settingValue == 0
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
                        if self.arrSettings[index].settingValue == 1
                        {
                            //Checks if the gimbal service is off. if its turned off then we start the service.
                            if !Gimbal.isStarted()
                            {
                                Gimbal.start()
                            }
                        }//Turn service off
                        else if self.arrSettings[index].settingValue == 0
                        {
                            //Checks if the gimbal service is turned on. if turned off then we stop the service.
                            if Gimbal.isStarted()
                            {
                                Gimbal.stop()
                            }
                        }
                        */
                        
                        //ENGAGE0012323 -- End
                        
                        //self.arrSettings[index].settingValue = Gimbal.isStarted() ? 1 : 0
                        
                        //ENGAGE0011628 -- End
                    }
                    
                     
                    //ENGAGE0011344 -- End
                    
                    for setting in self.arrSettings
                    {
                        
                        let isSettingEnabled = (setting.settingValue == 1)
                        
                        switch SettingsKeys.init(rawValue: setting.optionCode!)
                        {
                        case .fingerPrint:
                            UserDefaults.standard.set(isSettingEnabled, forKey: UserDefaultsKeys.fingerPrint.rawValue)
                        case .faceID:
                            UserDefaults.standard.set(isSettingEnabled, forKey: UserDefaultsKeys.faceID.rawValue)
                        case .appNotifications:
                            UserDefaults.standard.set(isSettingEnabled, forKey: UserDefaultsKeys.notification.rawValue)
                        case .contactsToPhone:
                            UserDefaults.standard.set(isSettingEnabled, forKey: UserDefaultsKeys.addToContact.rawValue)
                        case .syncCalendar:
                            UserDefaults.standard.set(isSettingEnabled, forKey: UserDefaultsKeys.synchCalendar.rawValue)
                        case .shareImage:
                            UserDefaults.standard.set(isSettingEnabled, forKey: UserDefaultsKeys.shareUrl.rawValue)
                        case .gimbalService:
                            break
                        case .none:
                            break
                        }
                    }
                    //ENGAGE0011395 -- End
                    
                    self.settingsTableView.reloadData()
                    self.appDelegate.hideIndicator()
                }
                else
                {
                    self.appDelegate.hideIndicator()
                    
                    if(((resetPwdinfo.responseMessage?.count) ?? 0)>0)
                    {
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: resetPwdinfo.responseMessage, withDuration: Duration.kMediumDuration)
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


}
