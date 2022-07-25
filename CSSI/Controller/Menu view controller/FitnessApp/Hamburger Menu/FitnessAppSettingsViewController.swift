//
//  FitnessAppSettingsViewController.swift
//  CSSI
//
//  Created by Kiran on 11/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

//23rd October 2020 V2.4 -- GATHER0000176
//Modified according to new specs
class FitnessAppSettingsViewController: UIViewController
{
    @IBOutlet weak var settingsTabelView: UITableView!
    
    var screenName : String?
    private var settingsArr = [FitnessSetting]()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)

        self.navigationItem.title = self.screenName
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnCLicked(sender:)))
        self.navigationItem.rightBarButtonItem = self.navHomeBtnItem(target: self, action: #selector(self.homeClicked(sender:)))
    }
    
    @objc private func homeClicked(sender : UIBarButtonItem)
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func backBtnCLicked(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }

}

//MARK:- Table view delegates
extension FitnessAppSettingsViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.settingsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FitnessAppSettingsTVC") as! FitnessAppSettingsTVC
        
        let details = self.settingsArr[indexPath.row]
        
        cell.settingLbl.text = details.name
        cell.settingSwitch.isOn = details.isEnabled ?? false
        cell.settingSwitch.transform = CGAffineTransform.init(scaleX: 0.80, y: 0.80)
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    
}


extension FitnessAppSettingsViewController : FitnessAppSettingsTVCDelegate
{
    func didtoggleSwitch(isEnabled: Bool, cell: FitnessAppSettingsTVC)
    {
        if let index = self.settingsTabelView.indexPath(for: cell)
        {
            self.settingsArr[index.row].isEnabled = isEnabled
            self.saveSettings()
            self.settingsTabelView.reloadData()
        }
        
    }
    
}

//MARK:- Custom methods
extension FitnessAppSettingsViewController
{
    
    private func initialSetup()
    {
        self.settingsTabelView.register(UINib.init(nibName: "FitnessAppSettingsTVC", bundle: nil), forCellReuseIdentifier: "FitnessAppSettingsTVC")
        self.settingsTabelView.delegate = self
        self.settingsTabelView.dataSource = self
        let view = UIView.init()
        view.backgroundColor = .clear
        self.settingsTabelView.tableFooterView = view
        self.settingsTabelView.estimatedRowHeight = 50
        self.settingsTabelView.rowHeight = UITableViewAutomaticDimension
        self.settingsTabelView.separatorInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        
        self.getSettings()
    }
    
    
    private func getSettings()
    {
        let paramaterDict : [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kUserName: UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
            APIKeys.kIsAdmin: UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!,
            
            APIKeys.kCategory : AppIdentifiers.fitnessApp
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        APIHandler.sharedInstance.getSettingsApi(paramaterDict: paramaterDict) { (settings) in
            self.appDelegate.hideIndicator()
            if let fitnessProfileSettings = settings.fitnessProfileSettings
            {
                //TODO:- Once the main app settings(in profile screen from dashboard) and fitness app setting are changed to use ids to identify the setting nsame remove the fitnessSettings object and replace with the new settings object. delete Fitness Settings class from models.
                let setting1 : FitnessSetting = FitnessSetting.init()
                setting1.name = self.appDelegate.fitnessSettings[0].name
                setting1.isEnabled = fitnessProfileSettings.videoUploadNotification == 1
                
                let setting2 : FitnessSetting = FitnessSetting.init()
                setting2.name = self.appDelegate.fitnessSettings[1].name
                setting2.isEnabled = fitnessProfileSettings.goalRemainderNotification == 1
                
                self.settingsArr = [setting1,setting2]
                self.settingsTabelView.reloadData()
            }
            
        } onFailure: { (error) in
            self.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
        }

    }
    
    
    private func saveSettings()
    {
        //TODO:- change this after api change
        let paramaterDict : [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            
            APIKeys.kCategory : AppIdentifiers.fitnessApp,
            "GoalRemainderNotification" : (self.settingsArr[1].isEnabled ?? false ) ? 1 : 0,
            "VideoUploadNotification" : (self.settingsArr[0].isEnabled ?? false ) ? 1 : 0
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        APIHandler.sharedInstance.saveSettingsApi(paramaterDict: paramaterDict) { (status) in
            self.appDelegate.hideIndicator()
            
            if(status.responseCode == InternetMessge.kSuccess)
            {
                print("saved")
            }
            else
            {
                if(((status.responseMessage?.count) ?? 0)>0)
                {
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: status.responseMessage, withDuration: Duration.kMediumDuration)
                }
                
            }
            
        } onFailure: { (error) in
            self.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
        }

        
    }
    
}
