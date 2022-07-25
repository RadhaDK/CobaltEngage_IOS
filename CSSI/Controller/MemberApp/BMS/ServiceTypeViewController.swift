//
//  ServiceTypeViewController.swift
//  CSSI
//
//  Created by Kiran on 28/05/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class ServiceTypeViewController: UIViewController
{
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var serviceTypeCollectionView: UICollectionView!
    @IBOutlet weak var serviceTypeFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var serviceCollectionHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnDressCode: UIButton!
    @IBOutlet weak var lblBottomUserName: UILabel!
    
    @IBOutlet weak var imgViewSwitch: UIImageView!
    
    
    @IBOutlet weak var viewSpecialOffers: UIView!
    @IBOutlet weak var specialOffersTblView: SelfSizingTableView!
    @IBOutlet weak var specialOffersTblViewHeight: NSLayoutConstraint!
    
    private var arrServiceType : [ProductionClass] = [ProductionClass]()
    private var arrSpecialOffers = [OfferDetail]()
    
    private var minimumLineSpacing : CGFloat = 14
    private var minimumInterItemSpacing : CGFloat = 13
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Added on 4th July 2020
    private let accessManager = AccessManager.shared
    
    //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
    //GATHER0000700 - Start
    ///Indicates for which department booking is made, like Fitness & Spa or Tennis or etc..,
    var BMSBookingDepartment : BMSDepartment = .none
    //GATHER0000700 - End
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initialSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? ""
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        //        let barbutton = UIBarButtonItem.init(image : UIImage.init(named: "back_btn"), style: .plain, target: self , action: #selector(backBtnClicked(sender:)))
        //        barbutton.imageInsets = UIEdgeInsets.init(top: 0, left: -6.5, bottom: 0, right: 0)
        //        self.navigationItem.leftBarButtonItem = barbutton
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnClicked(sender:)))
        //ENGAGE0011297 -- End
        

        self.navigationItem.hidesBackButton = true
        self.serviceTypeCollectionView.reloadData()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //Set collection view height to a lowest value which will no be interpreted as 0. if height is set to 0 collecton view is not loading cells after reload(i.e., cell for item at delegate is not being called)
        self.serviceCollectionHeightConstraint.constant = self.serviceTypeCollectionView.contentSize.height == 0 ? 1 : self.serviceTypeCollectionView.contentSize.height
        
        self.specialOffersTblViewHeight.constant = self.specialOffersTblView.contentSize.height
        self.viewSpecialOffers.isHidden = self.specialOffersTblViewHeight.constant == 0
        
        self.mainScrollView.contentSize.height = self.contentView.frame.height
        
    }
    
    @objc func backBtnClicked(sender : UIButton)
    {
        //TODO:- Remove after approval
        /*
        if self.appDelegate.bookingAppointmentDetails.requestScreenType == .request
        {
            self.appDelegate.bookingAppointmentDetails.serviceType = nil
        }*/
        
        if self.appDelegate.bookingAppointmentDetails.requestScreenType == .modify
        {
            self.appDelegate.closeFrom = "BMSFlow"
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dressCodeClicked(_ sender: UIButton)
    {
        let restarantpdfDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
        restarantpdfDetailsVC.pdfUrl = self.appDelegate.bookingAppointmentDetails.department?.dressCode ?? ""
        restarantpdfDetailsVC.restarantName = self.appDelegate.masterLabeling.BMS_DressCode ?? ""
        self.navigationController?.pushViewController(restarantpdfDetailsVC, animated: true)
    }
    
}

//MARK:- Custom methods
extension ServiceTypeViewController
{
    private func initialSetup()
    {
        
        //Added on 4th July 2020 V2.2
        //Added roles and privelages changes
        
        //Added by kiran V2.7 -- ENGAGE0011652 -- Added comparisons for department wise showing message in roles and priviliges.
        //ENGAGE0011652 -- Start
        //Shows the toast message if the current screen is the first screen in order. And to support department wise roles and privilages this will show view only access message in the sceond screen of the order and this is only for request scenario.
        if self.appDelegate.BMSOrder.first?.contentType == .serviceType || (self.appDelegate.BMSOrder[1].contentType == .serviceType && self.appDelegate.bookingAppointmentDetails.requestScreenType == .request)
        {//ENGAGE0011652 -- End
            //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Siwtching between fitness and spa and tennis booak a lession modules to implement roels and previleges.
            //GATHER0000700 - Start
            var module : SAModule!
            switch self.BMSBookingDepartment
            {
            case .fitnessAndSpa:
                module = .fitnessSpaAppointment
                
                //TODO:- Remove in march 2021 release this is temp work aroun to save time.
                //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments.
                //ENGAGE0011652 -- Start
                switch self.accessManager.accessPermissionFor(departmentName: self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "") {
                case .view:
                    if let message = self.appDelegate.masterLabeling.role_Validation2 , message.count > 0
                    {
                        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                    }
                default:
                    break
                }
            //ENGAGE0011652 -- End
                
            case .tennisBookALesson:
                module = .tennisBookALesson
                //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL roles and privilages Supprt
                //GATHER0001167 -- Start
            case .golfBookALesson:
                module = .golfBookALesson
                //GATHER0001167 -- End
            case .none:
                //This case should not occur if it does app will crash and this is a development issue.
                break
            }
            
            //TODO:- Remove comparision in march 2021 release this is temp work aroun to save time.
            //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments.
            //ENGAGE0011652 -- Start
            if self.BMSBookingDepartment != .fitnessAndSpa
            {
                switch self.accessManager.accessPermision(for: module/*.fitnessSpaAppointment*/)
                {//GATHER0000700 - End
                    
                case .view:
                    if let message = self.appDelegate.masterLabeling.role_Validation2 , message.count > 0
                    {
                        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                    }
                    
                    break
                default:
                    break
                }
            }
            //ENGAGE0011652 -- End
           
        }
        
        self.imgViewSwitch.isHidden = true
        
        self.serviceTypeCollectionView.register(UINib.init(nibName: "ServiceTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ServiceTypeCollectionViewCell")
        
        self.serviceTypeCollectionView.delegate = self
        self.serviceTypeCollectionView.dataSource = self
        
        self.serviceTypeFlowLayout.minimumLineSpacing = self.minimumLineSpacing
        self.serviceTypeFlowLayout.minimumInteritemSpacing = self.minimumInterItemSpacing
        self.btnDressCode.setTitle(self.appDelegate.masterLabeling.BMS_DressCode, for: .normal)
        self.lblBottomUserName.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)
        
        self.specialOffersTblView.delegate = self
        self.specialOffersTblView.dataSource = self
        self.specialOffersTblView.register(UINib.init(nibName: "FitnessEventTableViewCell", bundle: nil), forCellReuseIdentifier: "FitnessEventTableViewCell")
        self.specialOffersTblView.estimatedRowHeight = 50
        self.specialOffersTblView.rowHeight = UITableViewAutomaticDimension
        self.specialOffersTblView.estimatedSectionHeaderHeight = 0
        self.specialOffersTblView.separatorStyle = .none
        
        self.getServiceType()
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    ///Shows PDF
    private func showPDFWith(url : String , title : String)
    {
        let pdfVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
        pdfVC.pdfUrl = url
        pdfVC.restarantName = title
        self.navigationController?.pushViewController(pdfVC, animated: true)
        
    }

    ///Plays VIdeo in WebView
    private func playVideoWith(url : String , title : String)
    {
        if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "VideoViewController") as? VideoViewController
        {
            clubNews.modalTransitionStyle   = .crossDissolve;
            clubNews.modalPresentationStyle = .overCurrentContext
            clubNews.videoURL = url.videoID
            
            self.present(clubNews, animated: true, completion: nil)
            
        }
        
    }
    
    ///Opens URL in Browser
    private func openBusinessURL(url : String)
    {
        //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
        //ENGAGE0011419 -- Start
        guard url.isValidURL(), let urlLink = URL.init(string: url) else {return}
        //guard url.verifyUrl(), let urlLink = URL.init(string: url) else {return}
        //ENGAGE0011419 -- End
        UIApplication.shared.open(urlLink, options: [:], completionHandler: nil)
    }
    
    private func navigateToNextScreen()
    {
        //Getting the current index to find the sequence number and then using that sequence number to get next screen index
        guard let currentIndex = self.appDelegate.BMSOrder.firstIndex(where: {$0.contentType == .serviceType}) ,let nextScreenIndex = self.appDelegate.BMSOrder.firstIndex(where: {$0.sequenceNo == self.appDelegate.BMSOrder[currentIndex].sequenceNo! + 1}) else {return}
        
        switch self.appDelegate.BMSOrder[nextScreenIndex].contentType ?? .none
        {
        case .services , .providers , .departments:
            
            guard let vc = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "FitnessRequestListingViewController") as? FitnessRequestListingViewController else {
                return
            }
            
            vc.contentType = self.appDelegate.BMSOrder[nextScreenIndex].contentType!
            //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
            //GATHER0000700 - Start
            vc.BMSBookingDepartment = self.BMSBookingDepartment
            //GATHER0000700 - End
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .serviceType:
            break
        case .requestScreen:
            
            guard let requestVC = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "SpaAndFitnessRequestVC") as? SpaAndFitnessRequestVC else {
                return
                
            }
            requestVC.requestType = self.appDelegate.bookingAppointmentDetails.requestScreenType
            //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
            //GATHER0000700 - Start
            requestVC.BMSBookingDepartment = self.BMSBookingDepartment
            //GATHER0000700 - End
            requestVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(requestVC, animated: true)
            
            
        case .none:
            break
            
        }
    }
    
    private func getServiceType()
    {
        guard Network.reachability?.isReachable == true else {
            SharedUtlity.sharedHelper().showToast(on:
            self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            return
            
        }
        
        let paramaterDict:[String: Any] = [
            "Content-Type":"application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kProductClassID : self.appDelegate.bookingAppointmentDetails.serviceType?.productClassID ?? "",
            APIKeys.kProviderID : self.appDelegate.bookingAppointmentDetails.provider?.providerID ?? "",
            APIKeys.kServiceID : self.appDelegate.bookingAppointmentDetails.service?.serviceID ?? "",
            APIKeys.kLocationID : self.appDelegate.bookingAppointmentDetails.department?.locationID ?? "",
            APIKeys.kAppointmentDetailID : self.appDelegate.bookingAppointmentDetails.appointmentID ?? ""
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        APIHandler.sharedInstance.getProductionClassDetails(paramater: paramaterDict, onSuccess: { (productionClassDetails) in
            
            self.arrServiceType = productionClassDetails.productClassDetails ?? [ProductionClass]()
            self.arrSpecialOffers = productionClassDetails.offerDetails ?? [OfferDetail]()
            if productionClassDetails.isSkip == 1
            {
                if let serviceType = self.arrServiceType.first
                {
                    self.appDelegate.bookingAppointmentDetails.serviceType = serviceType
                    self.navigateToNextScreen()
                }
            }
            
            self.serviceTypeCollectionView.reloadData()
            self.specialOffersTblView.reloadData()
            
            self.appDelegate.hideIndicator()
            
        }) { [weak self] (error) in
            self?.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper().showToast(on:
            self?.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
        }
    }
    
}

//MARK: Collectionview Delegates
extension ServiceTypeViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.arrServiceType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let width = (collectionView.frame.width - (self.minimumInterItemSpacing + self.serviceTypeFlowLayout.sectionInset.left + self.serviceTypeFlowLayout.sectionInset.right))/2
        
        // 0.873 is the ratio between with to height. calculated it from the mock up sizes i.e., 144/165.  Same ratio is applied for image view height in ServiceTypeCollectionViewCell
        let height = 0.873 * width
        
        return CGSize.init(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceTypeCollectionViewCell", for: indexPath) as! ServiceTypeCollectionViewCell

        let serviceType = self.arrServiceType[indexPath.row]
        
        //Added by kiran v2.7 -- GATHER0000855
        //GATHER0000855 -- Start
        
        cell.serviceTypeImgView.setImage(imageURL: serviceType.imagePath,shouldCache: true)
        /*let imageDownloader = ImageDownloadTask()
        imageDownloader.url = serviceType.imagePath
        
        imageDownloader.startDownload { (data, response, url) in

            if url == serviceType.imagePath , let data = data
            {
                DispatchQueue.main.async {
                     cell.serviceTypeImgView.image = UIImage.init(data: data)
                }
            }
        }*/
        //GATHER0000855 -- End
        cell.nameLbl.text = serviceType.productClass ?? ""
        cell.applyShadow(color: hexStringToUIColor(hex: "#00000014"), radius: 3, offset: CGSize.init(width: 0, height: 3), opacity: 0.8)
        cell.nameLbl.sizeToFit()
        
        if self.appDelegate.bookingAppointmentDetails.serviceType?.productClassID == serviceType.productClassID
        {
            cell.viewSelectionIndicator.backgroundColor = .lightGray
            cell.viewSelectionIndicator.alpha = 0.4
        }
        else
        {
            cell.viewSelectionIndicator.backgroundColor = .clear
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let selectedServiceType = self.arrServiceType[indexPath.row]
        
        //Added on 12th August 2020 V2.3
        if selectedServiceType.productClassID != self.appDelegate.bookingAppointmentDetails.serviceType?.productClassID
        {
            self.appDelegate.bookingAppointmentDetails.provider = nil
            self.appDelegate.bookingAppointmentDetails.service = nil
            //Necessary to assign empty object instead of nill. when empty dafault option(i.e., ANY) will be selected in request screen. if nil is assigned then in modify scenario no preference gender selected at the time of request maybe assigned.
            self.appDelegate.bookingAppointmentDetails.providerGender = FilterOption()
        }
        
        self.appDelegate.bookingAppointmentDetails.serviceType = selectedServiceType
        
        self.navigateToNextScreen()
    }
    
}

//MARK:- TableView Delegates

extension ServiceTypeViewController : UITableViewDelegate , UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSpecialOffers.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let file = self.arrSpecialOffers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FitnessEventTableViewCell") as! FitnessEventTableViewCell
        
        cell.lblEventName.text = file.name
        
        let placeHolder = UIImage.init(named: "Icon-App-40x40")
        cell.eventImageView.image = placeHolder
        
        
        //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
        //ENGAGE0011419 -- Start
        if let imageLink = file.image ,imageLink.isValidURL()//.verifyUrl()
        {
            cell.eventImageView.sd_setImage(with: URL.init(string: imageLink), placeholderImage: placeHolder)
        }
        //ENGAGE0011419 -- End
        cell.selectionStyle = .none
        
        cell.delegate = self
        return cell
    }
    
}

//MARK:- FitnessEventTableViewCell Delegate
extension ServiceTypeViewController : FitnessEventTableViewCellDelegate
{
    func didClickViewOn(Cell: FitnessEventTableViewCell)
    {
        if let indexPath = self.specialOffersTblView.indexPath(for: Cell)
        {
            let file = self.arrSpecialOffers[indexPath.row]
            switch file.fileType {
            case FileType.file.rawValue:
                self.showPDFWith(url: file.path ?? "", title: file.name ?? "")
            case FileType.videoURL.rawValue:
                self.playVideoWith(url: file.videoURL ?? "", title: file.name ?? "")
            case FileType.businessURL.rawValue:
                self.openBusinessURL(url: file.businessUrl ?? "")
            default:
                break
            }
           
        }

    }
    
}

