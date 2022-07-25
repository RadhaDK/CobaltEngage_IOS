//
//  CheckinViewController.swift
//  CSSI
//
//  Created by Kiran on 27/10/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

//Modified by kiran V2.4 -- GATHER0000176
class CheckinViewController: UIViewController
{

    @IBOutlet weak var inputDetailsView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var progressInputView: UIView!
    @IBOutlet weak var inputLbl: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var recordsLbl: UILabel!
    @IBOutlet weak var recordsTableView: UITableView!
    
    var navTitle : String?
    var goalTitle : String?
    
    var goalChallange = GoalAndChallenge()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var recordsArr = [Checkin]()
    private var goalParticipantDataID = ""
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.initialSetups()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = self.navTitle
        
        self.navigationItem.rightBarButtonItem = self.navHomeBtnItem(target:self, action: #selector(self.homeClicked(sender:)))
        self.setLeftNavItems()
    }

    @objc private func homeClicked(sender : UIBarButtonItem)
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func backClicked(sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func menuClicked(sender: UIButton)
    {
        self.showFitnessAppMenu(delegate: self, view: self)
    }
    
    @IBAction func saveClicked(_ sender: UIButton)
    {
        self.saveRecord()
    }
}

//MARK:- Custom methods
extension CheckinViewController
{
    private func initialSetups()
    {
        self.applyDesignSpecs()
        
        self.titleLbl.text = self.goalTitle
        
        self.inputLbl.text = self.appDelegate.masterLabeling.Fit_InputText
        self.inputTextField.placeholder = self.appDelegate.masterLabeling.Fit_InputTextHere
        self.recordsLbl.text = self.appDelegate.masterLabeling.Fit_Records
        
        self.saveBtn.setTitle(self.appDelegate.masterLabeling.sAVE, for: .normal)
        
        self.recordsTableView.delegate = self
        self.recordsTableView.dataSource = self
        let blankView = UIView.init()
        blankView.backgroundColor = .clear
        self.recordsTableView.tableFooterView = blankView
        self.recordsTableView.estimatedRowHeight = 50
        self.recordsTableView.rowHeight = UITableViewAutomaticDimension
        
        self.recordsTableView.register(UINib.init(nibName: "CheckinRecordTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckinRecordTableViewCell")
        self.recordsTableView.separatorColor = APPColor.OtherColors.lineColor
        
        self.getRecords()
    }
    
    private func applyDesignSpecs()
    {
        self.view.backgroundColor = APPColor.OtherColors.appWhite
        
        self.titleLbl.font = AppFonts.semibold20
        self.titleLbl.textColor = APPColor.textColor.primary
        
        self.inputLbl.font = AppFonts.semibold14
        self.inputLbl.textColor = APPColor.textColor.primary
        
        self.inputTextField.font = AppFonts.regular15
        self.inputTextField.textColor = APPColor.textColor.primary
        
        self.saveBtn.setStyle(style: .outlined, type: .primary)
        
        self.recordsLbl.font = AppFonts.semibold18
        self.recordsLbl.textColor = APPColor.textColor.primary
        
        self.inputDetailsView.applyShadow(color: APPColor.OtherColors.shadowColor, radius: 3, offset: CGSize.init(width: 0, height: 3), opacity: 0.6)
        
        self.progressInputView?.layer.cornerRadius = 7.0
        self.progressInputView.applyShadow(color: APPColor.OtherColors.shadowColor, radius: 3, offset: .zero, opacity: 0.6)
        
    }
    
    
    private func setLeftNavItems()
    {
        var leftItemArr = [UIButton]()
        
        leftItemArr.append(self.getBackButton(target: self, action: #selector(self.backClicked(sender:)), for: .touchUpInside))
        
        leftItemArr.append(self.getMenuBtn(target: self, action: #selector(self.menuClicked(sender:)), for: .touchUpInside))
        
        let leftBarbutton = UIBarButtonItem.init(customView: self.navStackView(with: leftItemArr))
        self.navigationItem.leftBarButtonItem = leftBarbutton
    }
    
}

//MARK:- API's
extension CheckinViewController
{
    private func getRecords()
    {
        let params: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            APIKeys.goalID : self.goalChallange.goalID ?? ""
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        APIHandler.sharedInstance.getFitnessCheckin(paramaterDict: params) { (fitnessRecords) in
           
            self.recordsArr = fitnessRecords?.checkInDetails ?? [Checkin]()
            
            self.recordsTableView.reloadData()
            self.appDelegate.hideIndicator()
            
        } onFailure: { (error) in
            self.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
        }

    }
    
    private func saveRecord()
    {
        let params: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            APIKeys.goalID : self.goalChallange.goalID ?? "",
            APIKeys.achieved : (self.inputTextField.text ?? ""), //+ " " + (self.goalChallange.parameter ?? "")
            APIKeys.goalParticipantDataID : self.goalParticipantDataID
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        APIHandler.sharedInstance.saveFitnessCheckin(paramaterDict: params) {
            self.appDelegate.hideIndicator()
            self.inputTextField.text = ""
            self.getRecords()
        } onFailure: { (error) in
            self.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
        }

    }
    
    
}

//MARK:- Tableview Delegates
extension CheckinViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.recordsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckinRecordTableViewCell") as! CheckinRecordTableViewCell
        
        let record = self.recordsArr[indexPath.row]
        
        cell.dateLbl.text = record.submittedDate
        cell.progressLbl.text = record.achieved
        
        if self.goalParticipantDataID == record.goalParticipantDataID
        {
            cell.radioBtn.setBackgroundImage(UIImage.init(named:"radio_selected"), for: .normal)
        }
        else
        {
            cell.radioBtn.setBackgroundImage(UIImage.init(named:"radio_Unselected"), for: .normal)
        }
        
        cell.radioBtn.backgroundColor = .clear
        
        if indexPath.row == (self.recordsArr.count - 1)
        {
            cell.separatorInset = UIEdgeInsets.init(top: 0, left: self.view.frame.width, bottom: 0, right: 0)
        }
        else
        {
            cell.separatorInset = UIEdgeInsets.init(top: 0.5, left: 27, bottom: 0.5, right: 27)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let record = self.recordsArr[indexPath.row]
        self.goalParticipantDataID = record.goalParticipantDataID ?? ""
        self.recordsTableView.reloadData()
    }
    
    
}

//MARK:- Hamburger Menu Delegates
extension CheckinViewController : FitnessHamburgerMenuViewControllerDelegate
{
    func didSelectMenu(menu: HamburgerMenu, index: Int)
    {
        switch menu.Id
        {
        case AppIdentifiers.fitnessSettingsScreenID:
            
            let settingVC = UIStoryboard.init(name: "FitnessApp", bundle: nil).instantiateViewController(withIdentifier: "FitnessAppSettingsViewController") as! FitnessAppSettingsViewController
            settingVC.screenName = menu.name
            
            self.navigationController?.pushViewController(settingVC, animated: true)
            
        case AppIdentifiers.fitnessProfileScreenID :
             let profileVC = UIStoryboard.init(name: "FitnessApp", bundle: nil).instantiateViewController(withIdentifier: "FitnessProfileViewController") as! FitnessProfileViewController
            profileVC.screenName = menu.name
             self.navigationController?.pushViewController(profileVC, animated: true)
            
        case AppIdentifiers.fitnessVideosScreenID :
            let videoVC = UIStoryboard.init(name: "FitnessApp", bundle: nil).instantiateViewController(withIdentifier: "FitnessVideosViewController") as! FitnessVideosViewController
            videoVC.screenName = menu.name
            self.navigationController?.pushViewController(videoVC, animated: true)
        default:
            break
        }
    }
    
}

