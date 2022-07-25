//
//  FitnessGroupsViewController.swift
//  CSSI
//
//  Created by Kiran on 14/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

//Modified by kiran V2.4 -- GATHER0000176
class FitnessGroupsViewController: UIViewController
{
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var groupsCollectionView: UICollectionView!
    
    private var subCategories : FitnessVideoSubCategories?
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initialSetups()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barTintColor = APPColor.NavigationControllerColors.barWhite
        self.setLeftNavItems()
        self.setRightNavItems(newNotification: false)
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc private func backBtnClicked(_ sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func notificationClicked(_ sender : UIButton)
    {
        
    }
    
    @objc private func homeBtnClicked(_ sender : UIButton)
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

//MARK:- Custom Methods
extension FitnessGroupsViewController
{
    private func initialSetups()
    {
        self.applyDesignSpecs()
        self.groupsCollectionView.delegate = self
        self.groupsCollectionView.dataSource = self
        self.groupsCollectionView.register(UINib.init(nibName: "FitnessGroupCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FitnessGroupCollectionViewCell")
        self.groupsCollectionView.register(UINib.init(nibName: "FitnessGroupHeaderCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "FitnessGroupHeaderCollectionViewCell")
        self.getGroups()
    }
    
    private func applyDesignSpecs()
    {
        let flowLayout = self.groupsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.sectionInset = UIEdgeInsets.init(top: 22, left: 19, bottom: 22, right: 19)
        flowLayout?.minimumInteritemSpacing = 17
        flowLayout?.minimumLineSpacing = 23
        
        self.lineView.backgroundColor = APPColor.OtherColors.lineColor
    }
    
    private func setLeftNavItems()
    {
        let backButton = self.getBackButton(target: self, action: #selector(self.backBtnClicked(_:)), for: .touchUpInside)
        backButton.setTitle(self.appDelegate.masterLabeling.Fit_BackToVideos ?? "", for: .normal)
        backButton.setTitleColor(APPColor.textColor.fitnessGroupActivity, for: .normal)
        backButton.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 7, bottom: 0, right: -7)
        
        backButton.titleLabel?.font = AppFonts.regular16
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: self.navStackView(with: [backButton]))
    }
    
    private func setRightNavItems(newNotification : Bool)
    {
        let homeBtn = self.getHomeButton(target: self, action: #selector(self.homeBtnClicked(_:)), for: .touchUpInside)
        
        let notificationBtn = self.getNotificationBtn(newNotifications: newNotification, target: self, action: #selector(self.notificationClicked(_:)), for: .touchUpInside)
        
        let rightBarButton = UIBarButtonItem.init(customView: self.navStackView(with: [notificationBtn,homeBtn]))
        
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
}

//MARK:- Api's
extension FitnessGroupsViewController
{
    
    private func getGroups()
    {
        let params: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        APIHandler.sharedInstance.getVideoSubCategories(paramaterDict: params) { (videoCategory) in
            
            self.subCategories = videoCategory?.videoCategoryDetails?.first
            self.groupsCollectionView.reloadData()
            self.appDelegate.hideIndicator()
        } onFailure: { (error) in
            self.appDelegate.hideIndicator()
            self.handleError(error)
        }

    }
}

//MARK:- Collection view Delegates
extension FitnessGroupsViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.subCategories?.subCategoryDetails?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        switch section
        {
        case 0:

            //Leading space of the labels in FitnessGroupHeaderCollectionViewCell.update this if the leading constraint is changed
            let leadingSpace : CGFloat = 20
            //Trailing space of the labels in FitnessGroupHeaderCollectionViewCell.update this if the trailing constraint is changed
            let trailingSpace : CGFloat = 20
            
            let activityTxt = self.appDelegate.masterLabeling.Fit_FitnessActivities ?? ""
            let groupTxt = self.subCategories?.categoryName ?? ""
            
            //Font used for activily lable in FitnessGroupHeaderCollectionViewCell. Change if font is changed.
            let activityFont = AppFonts.regular16!
            //Font used for group lable in FitnessGroupHeaderCollectionViewCell. Change if font is changed.
            let groupFont = AppFonts.bold24!
            
            let width = collectionView.frame.width - (leadingSpace + trailingSpace)
            let calculatedHeight = activityTxt.heightFor(width: width, font: activityFont) + groupTxt.heightFor(width: width, font: groupFont)
            //90 is Default header size according to XD link.
            var height : CGFloat = 90
            
            if calculatedHeight >= height
            {
                height = calculatedHeight + 20
            }
            
            return CGSize.init(width: collectionView.frame.width, height: height)
        default:
            return CGSize.zero
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        
        switch kind
        {
        case UICollectionElementKindSectionHeader:
            
            switch indexPath.section
            {
            case 0:
                
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "FitnessGroupHeaderCollectionViewCell", for: indexPath)
                
                if let header = view as? FitnessGroupHeaderCollectionViewCell
                {
                    header.activityLbl.text = self.appDelegate.masterLabeling.Fit_FitnessActivities ?? ""
                    header.groupLbl.text = self.subCategories?.categoryName ?? ""
                }
                return view
                
            default:
                return UICollectionReusableView.init()
            }
           
        default:
            return UICollectionReusableView.init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let flowLayout = (collectionViewLayout as! UICollectionViewFlowLayout)
        let interItemSpacing = flowLayout.minimumInteritemSpacing
        let leadingInset = flowLayout.sectionInset.left
        let trailingInset = flowLayout.sectionInset.right
        
        let width = (collectionView.frame.width - interItemSpacing - leadingInset - trailingInset)/2
        let height = width * 1.3125
        return CGSize.init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FitnessGroupCollectionViewCell", for: indexPath) as! FitnessGroupCollectionViewCell
        
        let category = self.subCategories?.subCategoryDetails?[indexPath.row]

        cell.groupNameLbl.text = category?.subCategoryName
        cell.exercisesLbl.text = "\(category?.videosCount ?? 0) \(self.appDelegate.masterLabeling.Fit_Exercises ?? "")"
        cell.groupImgView.image = nil
        
        cell.groupImgView.backgroundColor = APPColor.MainColours.primary1
        
        let downloadTask = ImageDownloadTask.init()
        downloadTask.url = category?.image
        
        downloadTask.startDownload { (data, response, url) in
            
            if let data = data , url == category?.image
            {
                DispatchQueue.main.async {
                    cell.groupImgView.image = UIImage.init(data: data)
                }
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let videoDetailsVC = UIStoryboard.init(name: "FitnessApp", bundle: nil).instantiateViewController(withIdentifier: "FitnessVideoDetailsViewController") as! FitnessVideoDetailsViewController
        videoDetailsVC.showNavigationBar = false
        
        self.navigationController?.pushViewController(videoDetailsVC, animated: true)
    }
    
}

