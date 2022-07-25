//
//  SpaAndFitnessViewController.swift
//  CSSI
//
//  Created by Kiran on 14/02/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit
import MessageUI

class SpaAndFitnessViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var btnCalendar: UIButton!
    @IBOutlet weak var lblEventsTitle: UILabel!
    @IBOutlet weak var imageViewNews: UIImageView!
    @IBOutlet weak var upcomingTblView: SelfSizingTableView!
    @IBOutlet weak var upcomingTblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var eventsTblView: SelfSizingTableView!
    @IBOutlet weak var eventsTblViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnRules: UIButton!
    @IBOutlet weak var lblMemberName: UILabel!
    
    @IBOutlet weak var viewContacts: UIView!
    @IBOutlet weak var btnContacts: UIButton!
    
    //Added on 24th June 2020 v2.2
    @IBOutlet weak var viewInstructions: UIView!
    @IBOutlet weak var viewInstructionLbl: UIView!
    @IBOutlet weak var lblInstruction: UILabel!
    @IBOutlet weak var collectionViewInstructions: UICollectionView!
    
    //Added on 29th June 2020 v2.2
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var btnRequest: UIButton!
    @IBOutlet weak var viewRequest: UIView!
    
    //Added on 21st September 2020 V2.2
    @IBOutlet weak var btnFitnessApp: UIButton!
    
    private var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    private var FitnessDetails : FitnessSpaRS?
    
    //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
    //PROD0000069 -- Start
    private let accessManager = AccessManager.shared
    //PROD0000069 -- End
    
    //Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for composing Emails
    //PROD0000069 -- Start
    var arrselectedEmails = [String]()
    //PROD0000069 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initialSetups()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.upcomingTblViewHeight.constant = self.upcomingTblView.contentSize.height
        self.eventsTblViewHeight.constant = self.eventsTblView.contentSize.height
        
        self.scrollView.contentSize.height = self.contentView.frame.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = self.appDelegate?.masterLabeling.FITNESS_SPA
        self.appDelegate?.dateSortToDate = ""
        self.appDelegate?.dateSortFromDate = ""
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    @IBAction func calendarClicked(_ sender: UIButton)
    {
        
        if let calendar = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "GolfCalendarVC") as? GolfCalendarVC {
            self.appDelegate?.buddyType = "First"
            self.appDelegate?.typeOfCalendar = "FitnessSpa"
            self.navigationController?.pushViewController(calendar, animated: true)
        }
    }
    
    @IBAction func rulesClicked(_ sender: UIButton)
    {
        self.showPDFWith(url: self.FitnessDetails?.rulesEtiquette.first?.URL ?? "", title: self.FitnessDetails?.rulesEtiquette.first?.title ?? self.appDelegate?.masterLabeling.rules_etiquettes ?? "")
    }
    
    
    @IBAction func contactsClicked(_ sender: UIButton)
    {
        if let impVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ImpotantContactsVC") as? ImpotantContactsVC
        {
            impVC.isFrom = "FitnessSpa"
            impVC.importantContactsDisplayName = self.FitnessDetails?.importantContacts.first?.displayName ?? ""
            impVC.modalTransitionStyle   = .crossDissolve;
            impVC.modalPresentationStyle = .overCurrentContext
            self.present(impVC, animated: true, completion: nil)
        }
        
    }
    
    
    //Added on 29th June 2020 V2.2
    @IBAction func viewAllNewsClicked(_ sender: UIButton)
    {
        
        if let allClubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AllClubNewsViewController") as? AllClubNewsViewController
        {
            allClubNews.isFrom = "FitnessSpa"
            self.navigationController?.pushViewController(allClubNews, animated: true)
            
        }
        
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapUpcomingEvent(sender : UITapGestureRecognizer)
    {
        
        //Added by kiran V1.4 --PROD0000069-- Club News - Addeds uport for upcoming event flyer click
        //PROD0000069 -- Start
        if let eventDetails = self.FitnessDetails?.upComingEvent.first, eventDetails.enableRedirectClubNewsToEvents == 1
        {
            self.showEventScreenFromFlyer(event: eventDetails)
        }
        else
        {
            if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ViewNewsViewController") as? ViewNewsViewController
            {
                clubNews.modalTransitionStyle   = .crossDissolve;
                clubNews.modalPresentationStyle = .overCurrentContext
                clubNews.isFrom = "Events"

                if (self.FitnessDetails?.upComingEvent.count != 0)
                {
                    //Added on 14th May 2020 v2.1
                    let mediaDetails = MediaDetails()
                    mediaDetails.type = .image
                    mediaDetails.newsImage = self.FitnessDetails?.upComingEvent.first?.image ?? ""
                    clubNews.arrMediaDetails = [mediaDetails]
                    //Old logic
                    //clubNews.arrImgURl = [["NewsImage" : self.FitnessDetails?.upComingEvent.first?.image ?? ""]]
                    
                    //Added on 19th May 2020 v2.1
                    clubNews.contentType = .image
                    self.present(clubNews, animated: true, completion: nil)

                }
                else
                {
                    
                }
                
            }
        }
        //PROD0000069 -- End
        
    }
    
    //Added by CSSI on 21st May 2020 BMS
    @IBAction func requestClicked(_ sender: UIButton)
    {
        
        //Note : The sequence order of screens is only given for screens after the depatment screen. So adding the department screen for flow.

        //IF removing department adding check if tableview's didSelectRowAt delegate in FitnessRequestListingViewController for contentType department requires any change.
        let departmentSequence = FlowSequence()
        departmentSequence.contentType = .departments
        departmentSequence.sequenceNo = 0
        departmentSequence.name = ""
        
        self.appDelegate?.BMSOrder = [departmentSequence]
        
        guard let requestVC = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "FitnessRequestListingViewController") as? FitnessRequestListingViewController else{return}
         requestVC.modalPresentationStyle = .fullScreen
        requestVC.requestScreenType = .request
        requestVC.contentType = .departments
        
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
        //GATHER0000700 - Start
        requestVC.BMSBookingDepartment = .fitnessAndSpa
        //GATHER0000700 - End
         
        self.navigationController?.pushViewController(requestVC, animated: true)
        
        //Added on 18th August 2020 V2.3
        //removing the details in case if they exist from previous selection
        self.appDelegate?.bookingAppointmentDetails = BMSAppointmentDetails()
        
    }
    
    
    //Added on 21st September 2020 V2.3
    @IBAction func fitnessAppClicked(_ sender: UIButton)
    {
        let fitnessVC = UIStoryboard.init(name: "FitnessApp", bundle: nil).instantiateViewController(withIdentifier: "FitnessMainViewController")
        
        self.navigationController?.pushViewController(fitnessVC, animated: true)
    }
    
}

//MARK:- Custom methods
extension SpaAndFitnessViewController
{
    private func initialSetups()
    {
        self.title = self.appDelegate?.masterLabeling.FITNESS_SPA
        
        self.lblEventsTitle.text = self.appDelegate?.masterLabeling.uPCOMING_FITNESSEVENTS
        
        self.btnRules.setTitle(self.appDelegate?.masterLabeling.rules_etiquettes, for: .normal)
        
        self.lblMemberName.text = "\(UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!) | \(self.appDelegate!.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)"
        
        //Upcoming Event Image
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(didTapUpcomingEvent(sender:)))
        self.imageViewNews.addGestureRecognizer(tapGesture)
        self.imageViewNews.isUserInteractionEnabled = true
        
        //Club news Tableview
        self.upcomingTblView.delegate = self
        self.upcomingTblView.dataSource = self
        self.upcomingTblView.register(UINib.init(nibName: "RecentNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentNewsTableViewCell")
        self.upcomingTblView.estimatedRowHeight = 20
        self.upcomingTblView.rowHeight = UITableViewAutomaticDimension
        self.upcomingTblView.estimatedSectionHeaderHeight = 1
        self.upcomingTblView.sectionHeaderHeight = UITableViewAutomaticDimension
        self.upcomingTblView.separatorStyle = .none
        
        self.upcomingTblView.applyShadow(color:  hexStringToUIColor(hex: "#00000029"), radius: 2, offset: CGSize.init(width: 0, height: 3), opacity: 0.6)
        
        //Events TableView
        
        self.eventsTblView.delegate = self
        self.eventsTblView.dataSource = self
        self.eventsTblView.register(UINib
            .init(nibName: "FitnessEventTableViewCell", bundle: nil), forCellReuseIdentifier: "FitnessEventTableViewCell")
        self.eventsTblView.estimatedRowHeight = 50
        self.eventsTblView.rowHeight = UITableViewAutomaticDimension
        self.eventsTblView.sectionHeaderHeight = 0
        self.eventsTblView.separatorStyle = .none
        
        self.imageViewNews.layer.cornerRadius = 30
        self.imageViewNews.layer.borderWidth = 1
        self.imageViewNews.layer.masksToBounds = true
        self.imageViewNews.layer.borderColor = hexStringToUIColor(hex: "a7a7a7").cgColor
        
        //Calendar view and button
        
        self.btnCalendar.diningBtnViewSetup()
        self.btnCalendar.setTitle(self.appDelegate?.masterLabeling.calendar_title, for: .normal)
        
        //Important Cantact View
        
        self.viewContacts.applyShadow(color: .black, radius: 4, offset: CGSize.init(width: 2, height: 2), opacity: 0.16)
        
        //Instructions View
        
        self.lblInstruction.text = self.appDelegate?.masterLabeling.instructional_videos
        self.collectionViewInstructions.delegate = self
        self.collectionViewInstructions.dataSource = self
        self.collectionViewInstructions.register(UINib.init(nibName: "InstructionVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InstructionVideoCollectionViewCell")
        
        //Added on 29th June 2020 V2.2
        self.btnViewAll.diningBtnViewSetup()
        self.btnViewAll.setTitle(self.appDelegate?.masterLabeling.vIEW_ALL, for: .normal)
        
        //Added on 21st May 2020 BMS
        self.viewRequest.applyShadow(color: .black, radius: 4, offset: CGSize.init(width: 2, height: 2), opacity: 0.16)
        self.btnRequest.fitnessRequestBttnViewSetup() 
        self.btnRequest.setTitle(self.appDelegate?.masterLabeling.BMS_RequestAppointment, for: .normal)
        //self.btnRequest.setTitle("Req. Appointment", for: .normal)
        
        self.viewRequest.isHidden = true
        //Added on 8th July 2020 V2.2
        self.viewInstructions.isHidden = true
        
        //Added on 21st September 2020 V2.3
        self.btnFitnessApp.setTitle(self.appDelegate?.masterLabeling.Fit_FitnessApp, for: .normal)
        self.btnFitnessApp.fitnessRequestBttnViewSetup()
        
        self.btnCalendar.setStyle(style: .outlined, type: .primary)
        self.btnViewAll.setStyle(style: .outlined, type: .primary)
        self.btnRequest.setStyle(style: .contained, type: .primary)
        self.btnFitnessApp.setStyle(style: .contained, type: .primary)
        
        //Added on 13th October 2020 V2.3
        self.btnFitnessApp.isHidden = true
        self.btnRequest.isHidden = true
        //Fetching Details
        self.getFitnessSpaDetails()
        

        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    private func getFitnessSpaDetails()
    {
        self.appDelegate?.showIndicator(withTitle: "", intoView: self.view)
        let params: [String : Any] = [
        APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
        APIKeys.kdeviceInfo: [APIHandler.devicedict],
        APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
        APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
        ]
        
        APIHandler.sharedInstance.getFitnessSpa(paramater: params, onSuccess: { [unowned self] (FitnessSpaRS) in
            
            self.FitnessDetails = FitnessSpaRS
            
            //Added on 21st Spetember 2020 V2.3
            let showRequestBtn = FitnessSpaRS.enableAppointment == "1"
            let showFitnessAppBtn = FitnessSpaRS.enableFitnessActivity == "1"
            
            self.btnRequest.isHidden = !showRequestBtn
            self.btnFitnessApp.isHidden = !showFitnessAppBtn
            
            if showFitnessAppBtn && showRequestBtn
            {
                let widthAnchor = NSLayoutConstraint.init(item: self.btnFitnessApp, attribute: .width, relatedBy: .equal, toItem: self.viewRequest, attribute: .width, multiplier: 0.414, constant: 0)
                widthAnchor.isActive = true
            }
            
            //Added on 3rd June 2020 BMS
            //Modified on 21st September 2020 V2.3
            //self.viewRequest.isHidden = FitnessSpaRS.enableAppointment == "0"
            self.viewRequest.isHidden =  !(showRequestBtn || showFitnessAppBtn)
            //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
            //ENGAGE0011419 -- Start
            if let imageLink = FitnessSpaRS.upComingEvent.first?.imageThumb ,imageLink.isValidURL()//self.verifyUrl(urlString: imageLink)
            {
                //ENGAGE0011419 -- End
                self.imageViewNews.sd_setImage(with: URL.init(string: imageLink), placeholderImage: UIImage(named: "Icon-App-40x40"))
                self.imageViewNews.isHidden = false
                self.lblEventsTitle.text = self.appDelegate?.masterLabeling.uPCOMING_FITNESSEVENTS
            }
            else
            {
                self.imageViewNews.image = UIImage(named: "Icon-App-40x40")
                self.imageViewNews.isHidden = true
                self.lblEventsTitle.text = ""
            }
            
            //Added on 8th July 2020 V2.2
            self.viewInstructions.isHidden = self.FitnessDetails?.instructionalVideos.count ?? 0 < 1
            
            self.upcomingTblView.reloadData()
            self.eventsTblView.reloadData()
            self.collectionViewInstructions.reloadData()
            self.appDelegate?.hideIndicator()
            
        }, onFailure: {(error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
             self.appDelegate?.hideIndicator()
        })
    }
    
    //Commented by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead
    //ENGAGE0011419 -- Start
//    func verifyUrl(urlString: String?) -> Bool
//    {
//        if let urlString = urlString
//        {
//            if let url = URL(string: urlString)
//            {
//                return UIApplication.shared.canOpenURL(url)
//
//            }
//
//        }
//        return false
//
//    }
    //ENGAGE0011419 -- End
    
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
    
    //Opens URL in Browser
    private func openBusinessURL(url : String)
    {
        //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
        //ENGAGE0011419 -- Start
        guard url.isValidURL(), let urlLink = URL.init(string: url) else {return}
        //guard self.verifyUrl(urlString: url), let urlLink = URL.init(string: url) else {return}
        //ENGAGE0011419 -- End
        UIApplication.shared.open(urlLink, options: [:], completionHandler: nil)
    }
}

//MARK:- TableView Delegates and custon cell delegates
extension SpaAndFitnessViewController : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if tableView == self.upcomingTblView
        {
            count = self.FitnessDetails?.clubNews.count ?? 0
        }
        else if tableView == self.eventsTblView
        {
            count = self.FitnessDetails?.fitnessSpaFiles.count ?? 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == self.upcomingTblView
        {
            let news = self.FitnessDetails?.clubNews[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentNewsTableViewCell") as! RecentNewsTableViewCell
            cell.lblTitle.text = news?.newsTitle
            cell.lblDate.text = news?.date
            cell.viewSeparator.isHidden = indexPath.row < ((self.FitnessDetails?.clubNews.count ?? 0 ) - 1)
            cell.selectionStyle = .none
            
            return cell
        }
        else if tableView == self.eventsTblView
        {
            let file = self.FitnessDetails?.fitnessSpaFiles[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "FitnessEventTableViewCell") as! FitnessEventTableViewCell
            cell.lblEventName.text = file?.name
            
            let placeHolder = UIImage.init(named: "Icon-App-40x40")
            cell.eventImageView.image = placeHolder
            //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
            //ENGAGE0011419 -- Start
            if let imageLink = file?.image , imageLink.isValidURL()//self.verifyUrl(urlString: imageLink)
            {
            //ENGAGE0011419 -- End
                cell.eventImageView.sd_setImage(with: URL.init(string: imageLink), placeholderImage: placeHolder)
            }
            
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if tableView == self.upcomingTblView
        {
            return UITableViewAutomaticDimension
        }

         return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if tableView == self.upcomingTblView
        {
            let view = HeaderView.init()
            view.lblTitle.text = self.appDelegate?.masterLabeling.recent_news
            view.contentView.backgroundColor = hexStringToUIColor(hex: "#F5F5F5")
            return view
        }
        
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        if tableView == self.upcomingTblView
        {
            //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
            //PROD0000069 -- Start
            if let clubnews = self.FitnessDetails?.clubNews[indexPath.row] , clubnews.enableRedirectClubNewsToEvents == 1
            {
                self.navigateToEventsScreen(selectedNews: clubnews)
            }
            else
            {
                //Added on 14th May 2020 v2.1
                if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ViewNewsViewController") as? ViewNewsViewController
                {
                    clubNews.modalTransitionStyle   = .crossDissolve;
                    clubNews.modalPresentationStyle = .overCurrentContext
                    clubNews.arrMediaDetails = self.appDelegate?.imageDataToMediaDetails(list: self.FitnessDetails?.clubNews[indexPath.row].newsImageList)
                    //Added on 19th May 2020 v2.1
                    clubNews.contentType = .clubNews
                    clubNews.contentDetails = ContentDetails.init(id: self.FitnessDetails?.clubNews[indexPath.row].id, date: self.FitnessDetails?.clubNews[indexPath.row].date, name: self.FitnessDetails?.clubNews[indexPath.row].newsTitle, link: nil)
                    
                    self.present(clubNews, animated: true, completion: nil)
                    
                }
            }
            //PROD0000069 -- End
            
            //Old logic
            /*
            if (self.FitnessDetails?.clubNews[indexPath.row].newsVideoURL == "")
            {
                if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ViewNewsViewController") as? ViewNewsViewController
                {
                    clubNews.modalTransitionStyle   = .crossDissolve;
                    clubNews.modalPresentationStyle = .overCurrentContext
                    clubNews.arrImgURl = self.appDelegate?.imageDataToDict(list: self.FitnessDetails?.clubNews[indexPath.row].newsImageList)
                    self.present(clubNews, animated: true, completion: nil)
                    
                }
                
            }
            else
            {
                if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "VideoViewController") as? VideoViewController
                {
                    clubNews.modalTransitionStyle   = .crossDissolve;
                    clubNews.modalPresentationStyle = .overCurrentContext
                    clubNews.videoURL = self.FitnessDetails?.clubNews[indexPath.row].newsVideoURL.videoID
                    
                    self.present(clubNews, animated: true, completion: nil)
                    
                }
                
            }
            */
        }
        else if tableView == self.eventsTblView
        {
            
        }
        
        
    }
    
}
//MARK:- FitnessEventTableViewCellDelegate
extension SpaAndFitnessViewController : FitnessEventTableViewCellDelegate
{
    func didClickViewOn(Cell: FitnessEventTableViewCell) {
        
        if let indexPath = self.eventsTblView.indexPath(for: Cell)
        {
            let file = self.FitnessDetails?.fitnessSpaFiles[indexPath.row]
            
            switch file?.fileType {
            case FileType.file.rawValue:
                self.showPDFWith(url: file?.path ?? "", title: file?.name ?? "")
            case FileType.videoURL.rawValue:
                self.playVideoWith(url: file?.videoURL ?? "", title: file?.name ?? "")
            case FileType.businessURL.rawValue:
                self.openBusinessURL(url: file?.businessUrl ?? "")
            default:
                break
            }
           
        }
        
    }
}

extension SpaAndFitnessViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if let instructionVideo = self.FitnessDetails?.instructionalVideos
        {
            return instructionVideo.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = self.collectionViewInstructions.frame.height
        
        let width : CGFloat = 182
        return CGSize.init(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edgeInsets = (view.frame.size.width/2) - 91

        if self.FitnessDetails?.instructionalVideos.count == 1 {
            
            return UIEdgeInsetsMake(0, edgeInsets, 0, edgeInsets)
        }else{
            return UIEdgeInsetsMake(0, 0, 0, 0)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstructionVideoCollectionViewCell", for: indexPath) as! InstructionVideoCollectionViewCell
        let instructionalVideo = self.FitnessDetails?.instructionalVideos[indexPath.row]
        
        //Added by kiran V1.3 -- PROD0000033 -- Adding support for Youtube videos.
        //PROD0000033 -- Start
        if let url = URL(string: instructionalVideo?.videoURL ?? "")
        {
            let requestObj = URLRequest(url: url)
            cell.webViewVideo.load(requestObj)
        }
        
        //Old Logic
        /*
        let url = URL(string: "https://player.vimeo.com/video/\(instructionalVideo?.videoURL.videoID ?? "")")
        let requestObj = URLRequest(url: url!)
        cell.webViewVideo.load(requestObj)
        */
        //PROD0000033 -- End
        //Added on 25th August 2020 V2.3
        //Added to stop automatic video play when the app is idle for a while.
        cell.webViewVideo.configuration.mediaTypesRequiringUserActionForPlayback = [.audio,.video]
        return cell
    }
    
    
}

//Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
//PROD0000069 -- Start
extension SpaAndFitnessViewController : RegisterEventVCDelegate
{

    //Added by kiran V1.4 --PROD0000069-- Club News - Added supoprt to upcoming event flyer image click.
    //PROD0000069 -- Start
    private func navigateToEventsScreen(selectedNews : RecentNewsFitness)
    {
        let eventDetails = EventNavDetails()
        eventDetails.eventCategory = selectedNews.eventCategory
        eventDetails.isMemberTgaEventNotAllowed = selectedNews.isMemberTgaEventNotAllowed
        eventDetails.eventID = selectedNews.eventID
        eventDetails.isMemberCalendar = selectedNews.isMemberCalendar
        eventDetails.requestID = selectedNews.requestID
        eventDetails.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID
        eventDetails.enableRedirectClubNewsToEvents = selectedNews.enableRedirectClubNewsToEvents
        eventDetails.eventValidationMessage = selectedNews.eventValidationMessage
        eventDetails.eventName = selectedNews.eventName
        eventDetails.eventstatus = selectedNews.eventstatus
        eventDetails.externalURL = selectedNews.externalURL
        eventDetails.colorCode = selectedNews.colorCode
        eventDetails.buttontextvalue = selectedNews.buttontextvalue
        
        self.showEventScreen(selectedNews: eventDetails)
    }
    
    private func showEventScreenFromFlyer(event : UpComingFitness)
    {
        let eventDetails = EventNavDetails()
        eventDetails.eventCategory = event.eventCategory
        eventDetails.isMemberTgaEventNotAllowed = event.isMemberTgaEventNotAllowed
        eventDetails.eventID = event.eventID
        eventDetails.isMemberCalendar = event.isMemberCalendar
        eventDetails.requestID = event.requestID
        eventDetails.eventRegistrationDetailID = event.eventRegistrationDetailID
        eventDetails.enableRedirectClubNewsToEvents = event.enableRedirectClubNewsToEvents
        eventDetails.eventValidationMessage = event.eventValidationMessage
        eventDetails.eventName = event.eventName
        eventDetails.eventstatus = event.eventstatus
        eventDetails.externalURL = event.externalURL
        eventDetails.colorCode = event.colorCode
        eventDetails.buttontextvalue = event.buttontextvalue
        
        self.showEventScreen(selectedNews: eventDetails)
    }
    
    private func showEventScreen(selectedNews : EventNavDetails)
    {
        switch self.accessManager.accessPermission(eventCategory: selectedNews.eventCategory!, type: .events, departmentName: "")
        {
        case .view:
            break
        case .notAllowed:
            if let message = self.appDelegate?.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            return
        case .allowed:
            break
        }
        
        //Commented by kiran V1.4 --PROD0000069--
        //PROD0000069 -- Start
        /*
        if let validationMessage = selectedNews.eventValidationMessage ,!validationMessage.isEmpty
        {
            let okAction = UIAlertAction.init(title: self.appDelegate?.masterLabeling.clubNewsToEvents_OK ?? "", style: .default, handler: nil)
            CustomFunctions.shared.showAlert(title: "", message: validationMessage, on: self, actions: [okAction])
            //CustomFunctions.shared.showToast(WithMessage: validationMessage, on: self.view)
            return
        }*/
         //PROD0000069 -- End
        
        guard selectedNews.isMemberTgaEventNotAllowed != 1 else {
            SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: self.appDelegate?.masterLabeling.TGAMEMBERVALIDATION, withDuration: Duration.kMediumDuration)
            return
        }
        
        //Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for email to, external registerations, golf genious, No regterations and confirmes state.
        //PROD0000069 -- Start
        guard let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "RegisterEventVC") as? RegisterEventVC else{return}
        
        switch selectedNews.buttontextvalue ?? ""
        {
        // No buttons visible
        case "0":
            
            if let externalUrl = selectedNews.externalURL, !externalUrl.isEmpty
            {
                guard let url = URL(string: externalUrl) else { return }
                UIApplication.shared.open(url)
            }
            else
            {
                registerVC.eventID = selectedNews.eventID
                registerVC.eventCategory = selectedNews.eventCategory
                registerVC.eventType = selectedNews.isMemberCalendar
                registerVC.isViewOnly = true
                registerVC.isFrom = "EventUpdate"
                registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
                registerVC.showStatus = true
                registerVC.strStatus = selectedNews.eventstatus ?? ""
                registerVC.strStatusColor = selectedNews.colorCode ?? "#FFFFFF"
                registerVC.delegate = self
                registerVC.navigatedFrom = .fitnessSpa
                self.navigationController?.pushViewController(registerVC, animated: true)
            }
        //3 is cancel, 4 is view only.
        case "3","4":
            
            registerVC.eventID = selectedNews.eventID
            registerVC.eventCategory = selectedNews.eventCategory
            registerVC.eventType = selectedNews.isMemberCalendar
            registerVC.isViewOnly = true
            registerVC.isFrom = "EventUpdate"
            registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
            registerVC.showStatus = true
            registerVC.strStatus = selectedNews.eventstatus ?? ""
            registerVC.strStatusColor = selectedNews.colorCode ?? "#FFFFFF"
            registerVC.delegate = self
            registerVC.navigatedFrom = .fitnessSpa
            self.navigationController?.pushViewController(registerVC, animated: true)
        //1 is request, 2 is modify
        case "1","2":
            
            registerVC.eventID = selectedNews.eventID
            registerVC.eventCategory = selectedNews.eventCategory
            registerVC.eventType = selectedNews.isMemberCalendar
            registerVC.isFrom = "EventUpdate"
            registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
            registerVC.delegate = self
            registerVC.navigatedFrom = .fitnessSpa
            self.navigationController?.pushViewController(registerVC, animated: true)
        //5 is for Golf genius
        case "5":
            guard let url = URL(string: selectedNews.externalURL ?? "") else { return }
            UIApplication.shared.open(url)
        //6 is for Email To
        case "6":
            
            let stremail = selectedNews.externalURL ?? ""
            let emailSubject = selectedNews.eventName ?? ""
            if(stremail == "")
            {
                
            }
            else
            {
                self.arrselectedEmails.removeAll()
                self.arrselectedEmails.append(stremail)
                
                let mailComposeViewController = configuredMailComposeViewController(subject: emailSubject)
                if MFMailComposeViewController.canSendMail()
                {
                    self.present(mailComposeViewController, animated: true, completion: nil)
                }
                else
                {
                    self.showSendMailErrorAlert()
                }
            }
            
        default :
            break
        }

        //Old logic
        /*
        if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "RegisterEventVC") as? RegisterEventVC
        {
            registerVC.eventID = selectedNews.eventID
            registerVC.eventCategory = selectedNews.eventCategory
            registerVC.eventType = selectedNews.isMemberCalendar
            registerVC.isFrom = "EventUpdate"
            registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
            registerVC.delegate = self
            registerVC.navigatedFrom = .fitnessSpa
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
         */
        //PROD0000069 -- End

    }
    //PROD0000069 -- Start
    func eventSuccessPopupClosed()
    {
        self.getFitnessSpaDetails()
    }
    
}
//PROD0000069 -- End

//Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for composing Emails
//PROD0000069 -- Start
extension SpaAndFitnessViewController : MFMailComposeViewControllerDelegate
{
    func configuredMailComposeViewController(subject : String?) -> MFMailComposeViewController
    {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        mailComposerVC.setToRecipients(self.arrselectedEmails)
        mailComposerVC.setSubject(String(format: "%@ %@", subject ?? "",UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!))
        mailComposerVC.setMessageBody("", isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert()
    {
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        CustomFunctions.shared.showAlert(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", on: self, actions: [okAction])
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        controller.dismiss(animated: true, completion: nil)
    }
}
//PROD0000069 -- End

