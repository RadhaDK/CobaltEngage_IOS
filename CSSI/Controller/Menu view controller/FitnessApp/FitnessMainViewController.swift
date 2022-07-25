//
//  FitnessMainViewController.swift
//  CSSI
//
//  Created by Kiran on 10/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit
import ScrollableSegmentedControl

//Modified by kiran V2.4 -- GATHER0000176
//Modified according to new specs

class FitnessMainViewController: UIViewController
{
    @IBOutlet weak var fitnessCollectionView: UICollectionView!
    
    private var arrFitnessActivities = [FitnessActivity]()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initialSetups()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        
        self.addLeftNavItems()
        self.addNotificationToNavBar(notifications: true, newNotifications: false)
        self.navigationItem.title = self.appDelegate.masterLabeling.Fit_FitnessActivities
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    
    @objc private func menuClicked(sender : UIButton)
    {
        self.showFitnessAppMenu(delegate: self, view: self)
    }
    
    @objc private func homeClicked(sender : UIButton)
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @objc private func backClicked(sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func notificationClicked(sender : UIButton)
    {
        
    }
}

//MARK:- Custom Methods
extension FitnessMainViewController
{
    private func initialSetups()
    {
        self.fitnessCollectionView.delegate = self
        self.fitnessCollectionView.dataSource = self
        self.fitnessCollectionView.register(UINib.init(nibName: "FitnessActivityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FitnessActivityCollectionViewCell")
        self.fitnessCollectionView.contentInset = UIEdgeInsets.init(top: 17, left: 19, bottom: 17, right: 19)
        let flowLayout = self.fitnessCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.minimumInteritemSpacing = 17
        flowLayout?.minimumLineSpacing = 17
        
        self.getFitnessActivity()
        
    }
    
    ///shows/Hides the notifications button in navigation bar
    private func addNotificationToNavBar(notifications : Bool,newNotifications : Bool)
    {
        var rightItemArr = [UIButton]()
        
        if notifications
        {
            let notificationBtn = self.getNotificationBtn(newNotifications: newNotifications, target: self, action: #selector(self.notificationClicked(sender:)), for: .touchUpInside)
            rightItemArr.append(notificationBtn)
        }
        
        rightItemArr.append(self.getHomeButton(target: self, action: #selector(self.homeClicked(sender:)), for: .touchUpInside))
        
        let rightBarbutton = UIBarButtonItem.init(customView: self.navStackView(with: rightItemArr))
        self.navigationItem.rightBarButtonItem = rightBarbutton
    }
    
    private func addLeftNavItems()
    {
        var leftItemArr = [UIButton]()
        
        leftItemArr.append(self.getBackButton(target: self, action: #selector(self.backClicked(sender:)), for: .touchUpInside))
        
        leftItemArr.append(self.getMenuBtn(target: self, action: #selector(self.menuClicked(sender:)), for: .touchUpInside))
        
        let leftBarbutton = UIBarButtonItem.init(customView: self.navStackView(with: leftItemArr))
        self.navigationItem.leftBarButtonItem = leftBarbutton
    }
    
}


//MARK:- APi Calls
extension FitnessMainViewController
{
    private func getFitnessActivity()
    {
        
        let paramaterDict: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kUserName: UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
            APIKeys.kIsAdmin: UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        APIHandler.sharedInstance.getFitnessActivity(paramaterDict: paramaterDict) { (fitnessActivity) in
            
            self.arrFitnessActivities = fitnessActivity.activities ?? [FitnessActivity]()
            
            self.fitnessCollectionView.setEmptyMessage((self.arrFitnessActivities.count > 0) ? "" : (self.appDelegate.masterLabeling.no_Record_Found ?? ""))
            
            self.fitnessCollectionView.reloadData()
            self.appDelegate.hideIndicator()
        } onFailure: { (error) in
            self.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
        }

        
    }
}

//MARK:- Hamburger Menu Delegate
extension FitnessMainViewController : FitnessHamburgerMenuViewControllerDelegate
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

//MARK:- Collection View Delegate
extension FitnessMainViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.arrFitnessActivities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let leftPadding : CGFloat = collectionView.contentInset.left
        let rightPadding : CGFloat = collectionView.contentInset.right
        let interItemSpace : CGFloat = flowLayout.minimumInteritemSpacing
        //let lineSpacing : CGFloat = flowLayout.minimumLineSpacing
        
        let width : CGFloat = (self.view.frame.width - ((interItemSpace)+leftPadding+rightPadding))/2
        let height : CGFloat = width * 0.9125
        return CGSize.init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FitnessActivityCollectionViewCell", for: indexPath) as! FitnessActivityCollectionViewCell
        
        let activity = self.arrFitnessActivities[indexPath.row]
        cell.nameLbl.text = activity.name
        
        let downloader = ImageDownloadTask.init()
        downloader.url = activity.icon3x
        
        downloader.startDownload { (data, response, url) in
            
            if let data = data , url == activity.icon3x
            {
                DispatchQueue.main.async {
                    cell.activityImageView.image = UIImage.init(data: data)
                }
            }
            
        }
        
        cell.applyShadow(color: APPColor.OtherColors.shadowColor, radius: 3, offset: CGSize.init(width: 0, height: 3), opacity: 0.6)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let activity = self.arrFitnessActivities[indexPath.row]
        
        switch activity.id
        {
        case FitnessScreenType.goals.rawValue,FitnessScreenType.challenges.rawValue:
            let viewController = UIStoryboard.init(name: "FitnessApp", bundle: nil).instantiateViewController(withIdentifier: "FitnessGoalsAndChallengesViewController") as! FitnessGoalsAndChallengesViewController
            viewController.screenType = FitnessScreenType(rawValue: activity.id!)
            viewController.screenName = activity.name
            self.navigationController?.pushViewController(viewController, animated: true)
        case FitnessScreenType.videos.rawValue:
            let videoVC = UIStoryboard.init(name: "FitnessApp", bundle: nil).instantiateViewController(withIdentifier: "FitnessVideosViewController") as! FitnessVideosViewController
            videoVC.screenName = activity.name
            self.navigationController?.pushViewController(videoVC, animated: true)
        default:
            break
        }
        
    }
    
}




