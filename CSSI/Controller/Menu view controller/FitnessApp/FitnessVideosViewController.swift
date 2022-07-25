//
//  FitnessVideosViewController.swift
//  CSSI
//
//  Created by Kiran on 12/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

//Modified by kiran V2.4 -- GATHER0000176
class FitnessVideosViewController: UIViewController
{
    @IBOutlet weak var filterOptionsCollectionView: UICollectionView!
    
    @IBOutlet weak var videosTblView: UITableView!
    @IBOutlet weak var searchBarHolderView: UIView!
    @IBOutlet weak var videoSearchBar: UISearchBar!
    @IBOutlet weak var searchBackBtn: UIButton!
    @IBOutlet weak var searchBarView: UIView!

    var filterOptionsArr = [FitnessVideoCategory]()
    var videosArr = [FitnessVideo]()

    var screenName : String?
    
    private var selectedCategory : FitnessVideoCategory?
    
    private var expandedDescriptionIndexArr = [ExpandedVideo]()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initialSetups()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = APPColor.NavigationControllerColors.barTintColor
        self.navigationItem.title = self.screenName
        self.addLeftNavItems()
        self.addRightNavItems(newNotification: false)
        self.fetchCatrgories()
    }
    
    @IBAction func searchBackClicked(_ sender: UIButton)
    {
        self.searchBarHolderView.isHidden = true
        self.videoSearchBar.endEditing(true)
    }
    
    @objc private func tapGestureAction(sender : UITapGestureRecognizer)
    {
        self.videoSearchBar.endEditing(true)
    }
    
    
    @objc private func backClicked(sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func menuClicked(sender : UIButton)
    {
        self.showFitnessAppMenu(delegate: self, view: self,selectedMenuID: AppIdentifiers.fitnessVideosScreenID)
    }
    
    @objc private func homeClicked(sender : UIButton)
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func notificationClicked(sender : UIButton)
    {
        
    }
    
}


//MARK:- Custom Methods
extension FitnessVideosViewController
{
    private func initialSetups()
    {
        self.applyDesignSpecs()
        
        self.filterOptionsCollectionView.delegate = self
        self.filterOptionsCollectionView.dataSource = self
        self.filterOptionsCollectionView.register(UINib.init(nibName: "FitnessVideoFilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FitnessVideoFilterCollectionViewCell")
        self.filterOptionsCollectionView.register(FitnessVideoFilterFooter.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "FitnessVideoFilterFooter")
        
        self.videosTblView.delegate = self
        self.videosTblView.dataSource = self
        self.videosTblView.estimatedRowHeight = 50
        self.videosTblView.rowHeight = UITableViewAutomaticDimension
       
        self.videosTblView.register(UINib.init(nibName:"FitnessVideoTableViewCell", bundle: nil), forCellReuseIdentifier: "FitnessVideoTableViewCell")
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.tapGestureAction(sender:)))
        tapGesture.delegate = self
        self.searchBarHolderView.addGestureRecognizer(tapGesture)
        
    }
    
    
    private func applyDesignSpecs()
    {
        let view = UIView.init()
        view.backgroundColor = .clear
        self.videosTblView.tableFooterView = view
        
        let searchBarFont = AppFonts.regular18
        
        if #available(iOS 13.0, *)
        {
            self.videoSearchBar.searchTextField.backgroundColor = .clear
            self.videoSearchBar.searchTextField.placeholder = self.appDelegate.masterLabeling.search
            self.videoSearchBar.searchTextField.font = searchBarFont
        }
        else
        {
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).placeholder = self.appDelegate.masterLabeling.search
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .clear
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = searchBarFont
        }
        
        self.videoSearchBar.setImage(UIImage.init(named: "search_black"), for: .search, state: .normal)
        self.searchBackBtn.setImage(UIImage.init(named: "leftArror_gray"), for: .normal)
        self.videoSearchBar.delegate = self
        self.searchBarView.layer.cornerRadius = 16
        self.searchBarView.layer.borderWidth = 0.5
        self.searchBarView.layer.borderColor = APPColor.FitnessApp.videoCategoryViewBG.cgColor
        self.searchBarView.clipsToBounds = true
        self.searchBarHolderView.isHidden = true
        self.filterOptionsCollectionView.applyShadow(color: APPColor.OtherColors.shadowColor, radius: 3, offset: CGSize.init(width: 0, height: 3), opacity: 0.6)
        self.searchBarHolderView.backgroundColor = APPColor.OtherColors.appWhite
        self.filterOptionsCollectionView.backgroundColor = APPColor.OtherColors.appWhite
        self.filterOptionsCollectionView.backgroundView?.backgroundColor = APPColor.OtherColors.appWhite
    }
    
    
    private func showMoreOptions()
    {
        let actionSheet = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        
        //TODO:- Get these groups from backend.
        for action in ["Groups"]
        {
            let action = UIAlertAction.init(title: action, style: .default) { (action) in
                
                if action.title == "Groups"
                {
                    let groupsVC = UIStoryboard.init(name: "FitnessApp", bundle: nil).instantiateViewController(withIdentifier: "FitnessGroupsViewController") as! FitnessGroupsViewController
                    self.navigationController?.pushViewController(groupsVC, animated: true)
                }
            }
            
            actionSheet.addAction(action)
        }
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    private func addLeftNavItems()
    {
        let backBtn = self.getBackButton(target: self, action: #selector(self.backClicked(sender:)), for: .touchUpInside)
        
        let menuBtn = self.getMenuBtn(target: self, action: #selector(self.menuClicked(sender:)), for: .touchUpInside)
        
        let leftBarButtonItem = UIBarButtonItem.init(customView: self.navStackView(with: [backBtn,menuBtn]))
        
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func addRightNavItems(newNotification : Bool)
    {
        let homeBtn = self.getHomeButton(target: self, action: #selector(self.homeClicked(sender:)), for: .touchUpInside)
        
        let notificationBtn = self.getNotificationBtn(newNotifications: newNotification, target: self, action: #selector(self.notificationClicked(sender:)), for: .touchUpInside)
        
        let rightBarButtonItem = UIBarButtonItem.init(customView: self.navStackView(with: [notificationBtn,homeBtn]))
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
}

//MARK:- API's
extension FitnessVideosViewController
{
    private func fetchCatrgories()
    {
        let params: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        APIHandler.sharedInstance.getFitnessVideoCategory(paramaterDict: params) { (categories) in
            
            self.filterOptionsArr = categories?.fitnessCategory ?? [FitnessVideoCategory]()
            
            if self.selectedCategory == nil
            {
                self.selectedCategory = self.filterOptionsArr.first
            }
            
            self.filterOptionsCollectionView.reloadData()
            self.appDelegate.hideIndicator()
            self.fetchVideoPreferences()
        } onFailure: { (error) in
            self.appDelegate.hideIndicator()
            self.handleError(error)
        }

    }
    
    private func fetchVideoPreferences()
    {
        let params: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            APIKeys.videoSubCategoryID : "",
            APIKeys.videoCategoryID : "",
            APIKeys.preferenceType : self.selectedCategory?.name ?? ""
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        APIHandler.sharedInstance.getFitnessVideoPreferences(paramaterDict: params) { (videos) in
           
            self.videosArr = videos?.videoDetails ?? [FitnessVideo]()
            
            self.videosTblView.setEmptyMessage((self.videosArr.count > 0) ? "" : (self.appDelegate.masterLabeling.no_Record_Found ?? ""))
            self.videosTblView.reloadData()
            self.appDelegate.hideIndicator()
        } onFailure: { (error) in
            self.appDelegate.hideIndicator()
            self.handleError(error)
        }

    }
    
    
    private func savePreference(index : IndexPath)
    {
        
        let video = self.videosArr[index.row]
        
        let isFavoutite : Int = (video.isFavourite == 1) ? 0 : 1
        
        let params: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",

            APIKeys.preferenceType : self.selectedCategory?.name ?? "",
            APIKeys.isFavourite : isFavoutite,
            APIKeys.videoID : video.videoID ?? ""
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        APIHandler.sharedInstance.saveVideoPreferences(paramaterDict: params) { (response) in
            
            self.videosArr[index.row].isFavourite = isFavoutite
            self.videosTblView.reloadRows(at: [index], with: .none)
            self.appDelegate.hideIndicator()
        } onFailure: { (error) in
            self.appDelegate.hideIndicator()
            self.handleError(error)
        }
        
    }
    
}

//MARK:- Tap gesture Delegates
extension FitnessVideosViewController : UIGestureRecognizerDelegate
{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool
    {
        if (touch.view?.isDescendant(of: self.searchBarHolderView) ?? false) && touch.view != self.searchBarHolderView
        {
            return false
        }
        
        return true
    }
}

//MARK:- Collection view delegates
extension FitnessVideosViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, FitnessVideoFilterFooterDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (collectionView.frame.width - 40)/CGFloat(self.filterOptionsArr.count)
        let height = collectionView.frame.height
        return CGSize.init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.filterOptionsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
    {
        
        switch section {
        case 0:
            return CGSize.init(width: 40, height: collectionView.frame.height)
        default:
            return CGSize.zero
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FitnessVideoFilterCollectionViewCell", for: indexPath) as! FitnessVideoFilterCollectionViewCell
        let option = filterOptionsArr[indexPath.row]
        cell.nameLbl.text = option.name
        
        let isSelectedOption = self.selectedCategory?.id == option.id
        cell.nameLbl.textColor = isSelectedOption ? APPColor.textColor.secondary : APPColor.textColor.primary
        
        let downloadTask = ImageDownloadTask()
        downloadTask.url = option.icon
        
        downloadTask.startDownload { (data, response, url) in
            
            if let data = data, url == option.icon
            {
                DispatchQueue.main.async {
                    cell.optionsImgView.image = UIImage.init(data: data)?.withRenderingMode(.alwaysTemplate)
                }
            }
        }
        
        cell.optionsImgView.tintColor = isSelectedOption ? APPColor.imageTint.fitnessVideoCategorySelect : APPColor.imageTint.fintnessVideoCategoryUnSelect
        
        cell.lineView.isHidden = (indexPath.row == self.filterOptionsArr.count - 1)
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        
        switch kind
        {
        case UICollectionElementKindSectionFooter:
            
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "FitnessVideoFilterFooter", for: indexPath) as! FitnessVideoFilterFooter
            footerView.delegate = self
            return footerView
        default:
            break
        }
        return UICollectionReusableView.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let filter = self.filterOptionsArr[indexPath.row]
        
        self.selectedCategory = filter
        switch filter.name
        {
        //TODO:- Replace with iD
        case "Search":
            self.searchBarHolderView.isHidden = false
        default:
            self.fetchVideoPreferences()
        }
        self.filterOptionsCollectionView.reloadData()
    }
    
    func didSelectOption()
    {
        self.showMoreOptions()
    }
    
}

//MARK:- Table view Delegates
extension FitnessVideosViewController : UITableViewDelegate,UITableViewDataSource, FitnessVideoTableViewCellDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videosArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FitnessVideoTableViewCell") as! FitnessVideoTableViewCell
        cell.delegate = self
        
        let video = self.videosArr[indexPath.row]
        
        cell.favouriteBtn.setImage(UIImage.init(named: (video.isFavourite == 1) ? "heart_favourite" :"heart_unFavourite"), for: .normal)
        cell.expandImgView.image = UIImage.init(named: "upArrow_gray")
        cell.nameLbl.text = video.title
        cell.groupLbl.text = "\(self.appDelegate.masterLabeling.Fit_Group ?? "")"
        cell.viewsLbl.text = ""
        cell.postedDateLbl.text = "\(self.appDelegate.masterLabeling.Fit_PostedOn ?? "") \(video.publishOn ?? "")"
        cell.descriptionTxtView.text = video.videoDescription
        
        cell.thumbnailImgView.image = nil
        
        let downloadTask = ImageDownloadTask()
        downloadTask.url = video.thumbnail
        
        downloadTask.startDownload { (data, response, url) in
            
            if let data = data , url == video.thumbnail
            {
                DispatchQueue.main.async {
                    cell.thumbnailImgView.image = UIImage.init(data: data)
                }
            }
            
        }
        
        if self.expandedDescriptionIndexArr.contains(where: {$0.position == indexPath})
        {
            let expandedVideoDetails = self.expandedDescriptionIndexArr.first(where: {$0.position == indexPath})!
            
            if expandedVideoDetails.shouldAnimate
            {
                cell.expandImgHolderView.rotate(from: 0, to: .pi, duration: 0.25, onCompletion: CGAffineTransform.init(rotationAngle: .pi))
                
                UIView.animate(withDuration: 0.25) {
                    cell.descriptionView.isHidden = false
                }
                
                self.expandedDescriptionIndexArr.first(where: {$0.position == indexPath})?.shouldAnimate = false
            }
            else
            {
                cell.expandImgHolderView.transform = CGAffineTransform.init(rotationAngle: .pi)
                cell.descriptionView.isHidden = false
            }
            
        }
        else
        {
            cell.descriptionView.isHidden = true
            cell.expandImgHolderView.transform = CGAffineTransform.init(rotationAngle: 0)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let videoDetailsVC = UIStoryboard.init(name: "FitnessApp", bundle: nil).instantiateViewController(withIdentifier: "FitnessVideoDetailsViewController") as! FitnessVideoDetailsViewController
        videoDetailsVC.selectedVideo = self.videosArr[indexPath.row]
        videoDetailsVC.showNavigationBar = false
        self.navigationController?.pushViewController(videoDetailsVC, animated: true)
    }
    
    func expandClicked(cell: FitnessVideoTableViewCell)
    {
       guard let indexPath = self.videosTblView.indexPath(for: cell) else{
        return
        }
        
        if self.expandedDescriptionIndexArr.contains(where: {$0.position == indexPath})
        {
            self.expandedDescriptionIndexArr.removeAll(where: {$0.position == indexPath})
            self.videosTblView.beginUpdates()
            cell.expandImgHolderView.rotate(from: .pi, to: 0, duration: 0.25, onCompletion: CGAffineTransform.init(rotationAngle: 0))
            cell.descriptionView.isHidden = true
            self.videosTblView.endUpdates()
        }
        else
        {
            let selectedPosition = ExpandedVideo.init()
            selectedPosition.position = indexPath
            selectedPosition.shouldAnimate = true
            self.expandedDescriptionIndexArr.append(selectedPosition)
            self.videosTblView.reloadData()
        }
        
    }
    
    func addToFavouriteClicked(cell: FitnessVideoTableViewCell)
    {
        if let index = self.videosTblView.indexPath(for: cell)
        {
            self.savePreference(index: index)
        }
    }
}


//MARK:- Seacrh bar delegate
extension FitnessVideosViewController : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.endEditing(true)
    }
}

//MARK:- Hamburger Menu delegates
extension FitnessVideosViewController : FitnessHamburgerMenuViewControllerDelegate
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
            break
        default:
            break
        }
        
    }
    
}

