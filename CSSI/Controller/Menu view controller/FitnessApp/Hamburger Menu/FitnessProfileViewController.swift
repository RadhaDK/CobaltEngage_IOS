//
//  FitnessProfileViewController.swift
//  CSSI
//
//  Created by Kiran on 16/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

//23rd October 2020 V2.4 -- GATHER0000176
//Modified according to new specs
class FitnessProfileViewController: UIViewController
{
    @IBOutlet weak var profileScrollView: UIScrollView!
    @IBOutlet weak var profileScrollContentView: UIView!
    @IBOutlet weak var profilePicImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var heightValueLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var weightValueLbl: UILabel!
    @IBOutlet weak var groupsLbl: UILabel!
    @IBOutlet weak var groupsCollectionView: UICollectionView!
    @IBOutlet weak var groupsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var saveBtn: UIButton!
    
    private var statusIndicatorView : UIView?
    private var profileDetails = FitnessProfileDetails()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var screenName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initialSetups()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = self.screenName
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnCLicked(sender:)))
        self.navigationItem.rightBarButtonItem = self.navHomeBtnItem(target: self, action: #selector(self.homeBtnAction(sender:)))
    }
    
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        
        self.groupsCollectionViewHeight.constant = self.groupsCollectionView.contentSize.height
    }
    
    @objc private func homeBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func backBtnCLicked(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveClicked(_ sender: UIButton)
    {
        self.saveProfile()
    }
    
    
}

//MARK:- Collection view delegates
extension FitnessProfileViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.profileDetails.groupDetails?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let leftPadding : CGFloat = flowLayout.sectionInset.left
        let rightPadding : CGFloat = flowLayout.sectionInset.right
        let interItemSpaing : CGFloat = flowLayout.minimumInteritemSpacing
        
        let width : CGFloat = (self.view.frame.width - (leftPadding + rightPadding + interItemSpaing))/2
        let height : CGFloat = 48
        
        return CGSize.init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FitnessInterestGroupCollectionViewCell", for: indexPath) as! FitnessInterestGroupCollectionViewCell
        
        let group = self.profileDetails.groupDetails![indexPath.row]
        cell.nameLbl.text = group.groupName
        
        let isOptIn = group.isGroupOptIn == 1
        
        cell.contentView.backgroundColor = isOptIn ? APPColor.MainColours.primary1 : .clear
        cell.nameLbl.textColor = isOptIn ? APPColor.textColor.conatinedTextColor : APPColor.textColor.primary
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let isOptIn = self.profileDetails.groupDetails![indexPath.row].isGroupOptIn
        
        if isOptIn == 1
        {
            self.profileDetails.groupDetails![indexPath.row].isGroupOptIn = 0
        }
        else
        {
            self.profileDetails.groupDetails![indexPath.row].isGroupOptIn = 1
        }
        self.groupsCollectionView.reloadData()
    }
    
    
}

//MARK:- Api Methods
extension FitnessProfileViewController
{
    private func getProfile()
    {
        let paramaterDict: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kUserName: UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
            APIKeys.kIsAdmin: UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!,
            
            APIKeys.videoSubCategoryID: "",
            APIKeys.videoCategoryID: "",
            APIKeys.preferenceType: ""
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        APIHandler.sharedInstance.getFitnessProfile(paramaterDict: paramaterDict) { (profile) in
            
            self.profileDetails = profile.getProfileDetails?.first ?? FitnessProfileDetails()
            self.updateProfileDetails()
            self.groupsCollectionView.reloadData()
            self.profileScrollContentView.layoutIfNeeded()
            self.appDelegate.hideIndicator()
        } onFailure: { (error) in
            self.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            
        }

    }
    
    private func saveProfile()
    {
        let paramaterDict: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kUserName: UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
            APIKeys.kIsAdmin: UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!,
            
            APIKeys.fitnessProfileID: self.profileDetails.fitnessProfileID ?? "",
            APIKeys.height: self.profileDetails.height ?? "",
            APIKeys.weight: self.profileDetails.weight ?? "",
            APIKeys.groupDetails: self.selectedGroups()
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        APIHandler.sharedInstance.saveFitnessProfile(paramaterDict: paramaterDict) { (response) in
            self.appDelegate.hideIndicator()
            
            self.navigationController?.popViewController(animated: true)
        } onFailure: { (error) in
            self.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
        }

        
    }
    
    private func selectedGroups() -> [[String:Any]]
    {
        var groups = [[String : Any]]()
        
        if let selectedGroups = self.profileDetails.groupDetails?.filter({$0.isGroupOptIn == 1})
        {
            for selectedGroup in selectedGroups
            {
                let group = [
                    APIKeys.groupAdienceID : selectedGroup.groupAudienceID ?? "",
                    APIKeys.groupID : selectedGroup.groupID ?? ""
                ]
                
                groups.append(group)
            }
        }
        
        return groups
    }
}

//MARK:- Custom methods
extension FitnessProfileViewController
{
    private func initialSetups()
    {
        self.setDesignSpecs()
        self.profilePicImgView.layer.cornerRadius = self.profilePicImgView.frame.height/2.0
        self.profilePicImgView.clipsToBounds = true
        self.profilePicImgView.image = UIImage(named: "avtar")
        
        self.addStatusIndicator()
        
        self.groupsCollectionView.delegate = self
        self.groupsCollectionView.dataSource = self
        self.groupsCollectionView.register(UINib.init(nibName: "FitnessInterestGroupCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FitnessInterestGroupCollectionViewCell")
        (self.groupsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset = UIEdgeInsets.init(top: 0, left: 27, bottom: 0, right: 27)
        (self.groupsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing = 12
        (self.groupsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing = 13
        
        self.nameLbl.text = UserDefaults.standard.string(forKey: UserDefaultsKeys.lastName.rawValue)

        self.groupsLbl.text = self.appDelegate.masterLabeling.Fit_Groups
        self.heightLbl.text = self.appDelegate.masterLabeling.Fit_Height
        self.weightLbl.text = self.appDelegate.masterLabeling.Fit_Weight
        self.saveBtn.setStyle(style: .contained, type: .primary)
        self.saveBtn.setTitle(self.appDelegate.masterLabeling.sAVE, for: .normal)
        
        self.getProfile()
    }
    
    private func setDesignSpecs()
    {
        self.nameLbl.font = AppFonts.semibold22
        self.nameLbl.textColor = APPColor.textColor.primary
        
        self.groupsLbl.font = AppFonts.semibold18
        self.groupsLbl.textColor = APPColor.textColor.primary
        
        self.heightLbl.font = AppFonts.semibold16
        self.heightLbl.textColor = APPColor.textColor.primary
        self.heightValueLbl.font = AppFonts.semibold16
        self.heightValueLbl.textColor = APPColor.textColor.primary
        
        self.weightLbl.font = AppFonts.semibold16
        self.weightLbl.textColor = APPColor.textColor.primary
        self.weightValueLbl.font = AppFonts.semibold16
        self.weightValueLbl.textColor = APPColor.textColor.primary
        
        self.statusLbl.font = AppFonts.regular16
        self.statusLbl.textColor = APPColor.textColor.activeStatusText
        
        self.saveBtn.titleLabel?.font = AppFonts.semibold21
    }
    
    private func updateProfileDetails()
    {
        self.statusLbl.text = self.profileDetails.status
        self.heightValueLbl.text = self.profileDetails.height
        self.weightValueLbl.text = self.profileDetails.weight
        //TODO:- Take value from profile details API
        self.setStatusIndicatorColor(color: APPColor.OtherColors.activeDot)
    }
    
    ///Adds the indicator circle ciew on the profile pic
    private func addStatusIndicator()
    {
        
        let pointOnCircle = self.generateXYCoordinate(315, self.profilePicImgView.frame.width/2.0)
        
        let circleIndicatorWidth : CGFloat = 18
        let circleIndicatorHeight : CGFloat = 18
        
        let frame = CGRect.init(x: (self.profilePicImgView.frame.origin.x + pointOnCircle.x) - circleIndicatorWidth/2.0, y:  (self.profilePicImgView.frame.origin.y + pointOnCircle.y) - circleIndicatorHeight/2.0, width: circleIndicatorWidth, height: circleIndicatorHeight)
        self.statusIndicatorView = UIView.init(frame: frame)
        self.statusIndicatorView?.layer.cornerRadius = circleIndicatorWidth/2.0
        self.statusIndicatorView?.clipsToBounds = true
        self.profileScrollContentView.addSubview(self.statusIndicatorView!)
        self.view.layoutIfNeeded()
    }
    
    //Updats the status color of the indicator view on profie pic
    private func setStatusIndicatorColor(color : UIColor)
    {
        self.statusIndicatorView?.backgroundColor = color
    }
    
    ///Generates a point on the radius of the circle with the given angle. in iOS the angles are anti-clockwise. example for a point in 45 degrees(clockwise) on the view give 315 degrees.
    ///
    /// Note:- This give a point on the radius. to align enter remove half of width adn heigh of the view being added at this point to x and y point respectively
    private func generateXYCoordinate(_ angle: CGFloat , _ radius : CGFloat) -> CGPoint
    {
        var overlayAngle = angle
        if angle < 0
        {
            overlayAngle = 360 - angle.magnitude
        }
        let rad = overlayAngle.magnitude * .pi/180
        let sinValue = sin(rad)
        let cosValue = cos(rad)
        var XPosition : CGFloat = 0
        var YPosition : CGFloat = 0
    
    
        switch overlayAngle.magnitude
        {
        case 0...90:
            XPosition = radius + radius * cosValue
            YPosition = radius - radius * sinValue
    
        case 91...180:
            XPosition = radius + radius * cosValue
            YPosition = radius - radius * sinValue
    
        case 181...270:
            XPosition = radius + radius * cosValue
            YPosition = radius + abs(radius * sinValue)
    
        case 271...360:
            XPosition = radius + radius * cosValue
            YPosition = radius + abs(radius * sinValue)
    
        default:
            XPosition = radius
            YPosition = radius
            
        }
        
        return CGPoint.init(x: XPosition, y: YPosition)
    }
    
}
