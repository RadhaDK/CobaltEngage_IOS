//
//  FitnessGoalsAndChallengesViewController.swift
//  CSSI
//
//  Created by Kiran on 10/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

//Modified by kiran V2.4 -- GATHER0000176
class FitnessGoalsAndChallengesViewController: UIViewController
{

    @IBOutlet weak var goalsAndChallengesCollectionView: UICollectionView!
    @IBOutlet weak var goalsAndChallengesTblView: UITableView!
    
    @IBOutlet weak var viewCategory: UIView!
    
    private var arrGoalsAndChallenges = [GoalAndChallenge]()
    
    var screenType : FitnessScreenType!
    var screenName : String?
    
    ///Idndex of the cell on which start challenge is clicked
    private var startChallengeIndex : IndexPath?
    private var arrCategories = [FitnessActivityCategory]()
    private var selectedCategory : FitnessActivityCategory?
    
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
        self.setLeftNavItems()
        self.setRightNavItems()
        
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
    
    @objc private func filterCLicked(sender : UIButton)
    {
        
    }

}

//MARK:- Custom Methods
extension FitnessGoalsAndChallengesViewController
{
    private func initialSetup()
    {
        self.goalsAndChallengesCollectionView.register(UINib.init(nibName: "FitnessCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FitnessCategoryCollectionViewCell")
        self.goalsAndChallengesCollectionView.delegate = self
        self.goalsAndChallengesCollectionView.dataSource = self
        let flowLayout = self.goalsAndChallengesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //flowLayout.minimumInteritemSpacing = 13
        flowLayout.minimumLineSpacing = 13
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        self.viewCategory.backgroundColor = APPColor.OtherColors.appWhite
        self.viewCategory.applyShadow(color: APPColor.OtherColors.shadowColor, radius: 3, offset: .init(width: 0, height: 3), opacity: 0.6)
        
        self.goalsAndChallengesTblView.delegate = self
        self.goalsAndChallengesTblView.dataSource = self
        self.goalsAndChallengesTblView.estimatedRowHeight = 50
        self.goalsAndChallengesTblView.rowHeight = UITableViewAutomaticDimension
        self.goalsAndChallengesTblView.contentInset = UIEdgeInsets.init(top: 9, left: 0, bottom: 9, right: 0)
        let blankView = UIView.init()
        blankView.backgroundColor = .clear
        self.goalsAndChallengesTblView.tableFooterView = blankView
        self.goalsAndChallengesTblView.backgroundColor = .clear
        
        self.goalsAndChallengesTblView.register(UINib.init(nibName: "FitnessGoalChallangeTableViewCell", bundle: nil), forCellReuseIdentifier: "FitnessGoalChallangeTableViewCell")
        self.goalsAndChallengesTblView.separatorStyle = .none
        
        self.fetchGoalsChallanges()
    }
    
    
    private func setLeftNavItems()
    {
        var leftItemArr = [UIButton]()
        
        leftItemArr.append(self.getBackButton(target: self, action: #selector(self.backClicked(sender:)), for: .touchUpInside))
        
        leftItemArr.append(self.getMenuBtn(target: self, action: #selector(self.menuClicked(sender:)), for: .touchUpInside))
        
        let leftBarbutton = UIBarButtonItem.init(customView: self.navStackView(with: leftItemArr))
        self.navigationItem.leftBarButtonItem = leftBarbutton
    }
    
    
    private func setRightNavItems()
    {
        var rightItemArr = [UIButton]()
        
        let filterBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        filterBtn.setImage(UIImage.init(named: "Filter"), for: .normal)
        filterBtn.setTitle(nil, for: .normal)
        filterBtn.addTarget(self, action: #selector(self.filterCLicked(sender:)), for: .touchUpInside)
        rightItemArr.append(filterBtn)
        
        rightItemArr.append(self.getHomeButton(target: self, action: #selector(self.homeClicked(sender:)), for: .touchUpInside))
        
        let rightBarbutton = UIBarButtonItem.init(customView: self.navStackView(with: rightItemArr))
        self.navigationItem.rightBarButtonItem = rightBarbutton
    }
    
}

//MARK:- API's
extension FitnessGoalsAndChallengesViewController
{
    private func fetchGoalsChallanges()
    {
        
        let params: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            APIKeys.goalType : self.screenType.rawValue,
            APIKeys.goalMasterID : self.selectedCategory?.goalMasterID ?? ""
        ]

        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        APIHandler.sharedInstance.getGoalsAndChallenges(paramaterDict: params) { (details) in
            
            self.arrCategories = details?.masterData ?? [FitnessActivityCategory]()
            self.arrGoalsAndChallenges = details?.details ?? [GoalAndChallenge]()
            
            self.goalsAndChallengesTblView.setEmptyMessage(self.arrGoalsAndChallenges.count > 0 ? "" : (self.appDelegate.masterLabeling.no_Record_Found ?? ""))
            
            if self.selectedCategory == nil
            {
                self.selectedCategory = self.arrCategories.first
            }
            
            self.goalsAndChallengesCollectionView.reloadData()
            self.goalsAndChallengesTblView.reloadData()
            self.appDelegate.hideIndicator()
        } onFailure: { (error) in
            self.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            
        }

    }
    
}



//MARK:- Collection view delegates
extension FitnessGoalsAndChallengesViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        //width as per design
        let width : CGFloat = 48 + 5 + 5 //5 is the padding on both sides
        
        let height = collectionView.frame.height
        
        return CGSize.init(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "FitnessCategoryCollectionViewCell", for: indexPath) as! FitnessCategoryCollectionViewCell
        
        let category = self.arrCategories[indexPath.row]
        
        cell.nameLbl.text = category.goalMasterName
        let downloadTask = ImageDownloadTask.init()
        downloadTask.url = category.icon2x
        
        downloadTask.startDownload { (data, response, url) in
            
            if category.icon2x == url ,let data = data
            {
                DispatchQueue.main.async {
                    cell.categoryImageView.image = UIImage.init(data: data)?.withRenderingMode(.alwaysTemplate)
                }
            }
        }
        
        
        cell.categoryImageView.layer.cornerRadius = 6
        if category.goalMasterID == self.selectedCategory?.goalMasterID
        {
            cell.categoryImageView.layer.borderWidth = 0
            cell.categoryImageView.layer.borderColor = UIColor.clear.cgColor
            cell.categoryImageView.backgroundColor = APPColor.MainColours.primary2
            cell.categoryImageView.clipsToBounds = false
            cell.categoryImageView.applyShadow(color: APPColor.OtherColors.shadowColor, radius: 3, offset: CGSize.init(width: 0, height: 0), opacity: 0.6)
            cell.nameLbl.textColor = APPColor.textColor.secondary
            cell.categoryImageView.tintColor = APPColor.imageTint.fitnessCategorySelect
        }
        else
        {
            cell.categoryImageView.layer.borderWidth = 1.5
            cell.categoryImageView.layer.borderColor = APPColor.FitnessApp.categoryBorderColor.cgColor
            cell.categoryImageView.backgroundColor = .clear
            cell.categoryImageView.clipsToBounds = true
            cell.categoryImageView.applyShadow(color: .clear, radius: 0, offset: CGSize.init(width: 0, height: 0), opacity: 0)
            cell.nameLbl.textColor = APPColor.textColor.primary
            cell.categoryImageView.tintColor = APPColor.imageTint.fitnessCategoryUnselect
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.selectedCategory = self.arrCategories[indexPath.row]
        self.goalsAndChallengesCollectionView.reloadData()
        
        self.fetchGoalsChallanges()
    }
    
}

//MARK:- Tableview Delegate
extension FitnessGoalsAndChallengesViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrGoalsAndChallenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FitnessGoalChallangeTableViewCell") as! FitnessGoalChallangeTableViewCell
        
        let data = self.arrGoalsAndChallenges[indexPath.row]
        cell.delegate = self
        cell.lblTitle.text = data.goalTitle
        cell.txtViewShortDescription.text = data.goalDescription
        
        cell.btnKnowMore.setTitle(self.appDelegate.masterLabeling.Fit_KnowMore, for: .normal)
        
        let duration = (self.appDelegate.masterLabeling.duration ?? "") + " " + (data.duration ?? "")
        cell.lblDuration.text = duration
        
        let goal = String(format: "%@ %@ %@", (self.appDelegate.masterLabeling.Fit_Goal ?? ""),(data.goalName ?? ""),(data.parameter ?? ""))
        cell.lblGoal.text = goal
        
        var saveBtnTitle : String?
        switch self.screenType
        {
        case .goals:
            saveBtnTitle = self.appDelegate.masterLabeling.Fit_Checkin
        case .challenges:
            if data.isStarted == 1 || self.startChallengeIndex == indexPath
            {
                saveBtnTitle = self.appDelegate.masterLabeling.Fit_Checkin
            }
            else
            {
                saveBtnTitle = self.appDelegate.masterLabeling.Fit_StartChallenge
            }
        default :
            break
        }
        cell.btnSubmit.setTitle(saveBtnTitle, for: .normal)
        
        cell.mainContentView.layer.cornerRadius = 7
        cell.mainContentView.applyShadow(color: APPColor.OtherColors.shadowColor, radius: 3, offset: .zero, opacity: 0.6)
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}

//MARK:- FitnessGoalChallangeTableViewCellDelegate
extension FitnessGoalsAndChallengesViewController : FitnessGoalChallangeTableViewCellDelegate
{
    func knowMoreClicked(cell: FitnessGoalChallangeTableViewCell)
    {
        print("Know more Clicked")
    }
    
    func submitClicked(cell: FitnessGoalChallangeTableViewCell)
    {
        if let index = self.goalsAndChallengesTblView.indexPath(for: cell)
        {
            
            let data = self.arrGoalsAndChallenges[index.row]
            var allowCheckin = false
            //FIXME:- Need backend help
            switch self.screenType
            {
            case .goals:
                allowCheckin = true
            case .challenges:
                allowCheckin = (data.isStarted == 1 || self.startChallengeIndex == index)
                
                if data.isStarted == 0
                {
                    self.startChallengeIndex = index
                    self.goalsAndChallengesTblView.reloadData()
                }
                
            default:
                break
            }
            
            if allowCheckin
            {
                
                let goal = self.arrGoalsAndChallenges[index.row]
                let checkInVC = UIStoryboard.init(name: "FitnessApp", bundle: nil).instantiateViewController(withIdentifier: "CheckinViewController") as! CheckinViewController
                checkInVC.navTitle = self.screenName
                checkInVC.goalTitle = goal.goalTitle
                checkInVC.goalChallange = goal
                self.navigationController?.pushViewController(checkInVC, animated: true)
            }
            
            
        }
        
    }
    
}

//MARK:- Hamburger Menu Delegates
extension FitnessGoalsAndChallengesViewController : FitnessHamburgerMenuViewControllerDelegate
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

