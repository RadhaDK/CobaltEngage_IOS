//
//  AlertDetailsViewController.swift
//  CSSI
//
//  Created by Kiran on 29/10/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

//Created by kiran -- ENGAGE0011226 -- added for Covid rules
class AlertDetailsViewController: UIViewController
{
    @IBOutlet weak var alertCollectionView: UICollectionView!
    
    var screenName : String?
    
    private var alertRulesArr = [AlertRules]()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.initialSetups()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = self.screenName
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backClicked(sender:)))
    }
    
    @objc func backClicked(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK:- Custom Methods
extension AlertDetailsViewController
{
    private func initialSetups()
    {
        self.applyDesignSpecs()
        self.alertCollectionView.delegate = self
        self.alertCollectionView.dataSource = self
        self.alertCollectionView.register(UINib.init(nibName: "AlertDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AlertDetailCollectionViewCell")
        self.getAlertDetails()
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    private func applyDesignSpecs()
    {
        self.view.backgroundColor = APPColor.OtherColors.appWhite
        self.alertCollectionView.backgroundColor = .clear
        let flowLayout = self.alertCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumInteritemSpacing = 6
        flowLayout.minimumLineSpacing = 8
        flowLayout.sectionInset = UIEdgeInsets.init(top: 15, left: 17, bottom: 30, right: 17)
    }
}

//MARK:- API's
extension AlertDetailsViewController
{
    private func getAlertDetails()
    {
        let paramaterDict : [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kUserName: UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
            APIKeys.kIsAdmin: UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        APIHandler.sharedInstance.getCovidRules(paramaterDict: paramaterDict) { (alertDetails) in
            
            self.alertRulesArr = alertDetails?.covidRules ?? [AlertRules]()
            self.alertCollectionView.setEmptyMessage((self.alertRulesArr.count > 0) ? "" : (self.appDelegate.masterLabeling.no_Record_Found ?? ""))
            self.alertCollectionView.reloadData()
            self.appDelegate.hideIndicator()
        } onFailure: { (error) in
            self.appDelegate.hideIndicator()
            self.handleError(error)
        }

        
    }
}

//MARK:- Collection view delegates
extension AlertDetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let leftPadding : CGFloat = layout.sectionInset.left
        let rightPadding : CGFloat = layout.sectionInset.right
        let interitemSpacing : CGFloat = layout.minimumInteritemSpacing
        
        let width : CGFloat = (collectionView.frame.width - leftPadding - rightPadding - interitemSpacing)/2
        let height : CGFloat = 160
        
        return CGSize.init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.alertRulesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlertDetailCollectionViewCell", for: indexPath) as! AlertDetailCollectionViewCell
        
        let details = self.alertRulesArr[indexPath.row]
        
        cell.sectionImageView.image = nil
        let downloadTask = ImageDownloadTask.init()
        downloadTask.url = details.imagePath
        
        downloadTask.startDownload { (data, response, url) in
            
            if let data = data , url == details.imagePath
            {
                DispatchQueue.main.async {
                    cell.sectionImageView.image = UIImage.init(data: data)
                }
            }
        }

        cell.nameLbl.text = details.sectionName
        cell.applyShadow(color: APPColor.OtherColors.shadowColor, radius: 3, offset: CGSize.init(width: 0, height: 3), opacity: 0.6)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
     
        if let PDFVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as? PDfViewController
        {
            let details = self.alertRulesArr[indexPath.row]
            PDFVC.restarantName = details.sectionName ?? ""
            PDFVC.pdfUrl = details.filePath ?? ""
            self.navigationController?.pushViewController(PDFVC, animated: true)
        }
        
    }
    
}
