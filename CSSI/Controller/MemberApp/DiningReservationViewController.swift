//
//  DiningReservationViewController.swift
//  CSSI
//
//  Created by apple on 11/22/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import Popover
import Charts
import MessageUI

class DiningReservationViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource, ChartViewDelegate  {

    @IBOutlet weak var instructionalLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var cateringVideosHeight: NSLayoutConstraint!
    @IBOutlet weak var btnDiningReq: UIButton!
    @IBOutlet weak var diningEventsView: UIView!
    @IBOutlet weak var diningReservationHeight: NSLayoutConstraint!
    @IBOutlet weak var heightUpcomingEvent: NSLayoutConstraint!
    @IBOutlet weak var heightUpcomingTop: NSLayoutConstraint!
    @IBOutlet weak var heightUpcomingLabel: NSLayoutConstraint!
    @IBOutlet weak var ImpMainView: UIView!
    @IBOutlet weak var viewImpContacts: UIView!
    @IBOutlet weak var imgImpContacts: UIImageView!
    @IBOutlet weak var viewContactsBase: UIView!
    @IBOutlet weak var lblUpComingEvents: UILabel!
    @IBOutlet weak var imgUpcomingEvents: UIImageView!
    @IBOutlet weak var lblCalendarofEvents: UIButton!
    @IBOutlet weak var recentNewsTableview: UITableView!
    @IBOutlet weak var lblRecentNews: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var lblInstructionalVideos: UILabel!
    @IBOutlet weak var collectionViewIV: UICollectionView!
    @IBOutlet weak var lblMemberNameAndID: UILabel!
    @IBOutlet weak var lblHostAnEvent: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var heightRecentNewsTable: NSLayoutConstraint!
    @IBOutlet weak var lblEmailaddress: UILabel!
    @IBOutlet weak var imgHost: UIImageView!
    @IBOutlet weak var btnrules: UIButton!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnMenusHours: UIButton!
    
    var ClubNewsDetails: DiningRS? = nil
    var filterPopover: Popover? = nil
    var isUpcomingEventHidded : Bool?
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var diningSettings : DinningSettings?

    //Added on 4th July 2020 V2.2
    private let accessManager = AccessManager.shared
    
    //Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for composing Emails
    //PROD0000069 -- Start
    var arrselectedEmails = [String]()
    //PROD0000069 -- End

    override func viewDidLoad() {
        super.viewDidLoad()
        diningReservationDetails()

        
        self.navigationController?.navigationBar.isHidden = false

        
        let impContacts = UITapGestureRecognizer(target: self, action: #selector(self.importantContacts(sender:)))
        self.viewImpContacts.addGestureRecognizer(impContacts)
        
        let EventsimageView = UITapGestureRecognizer(target: self, action:  #selector(self.upComingEventsCliked(sender:)))
        self.diningEventsView.addGestureRecognizer(EventsimageView)
        
        viewContactsBase.layer.shadowColor = UIColor.black.cgColor
        viewContactsBase.layer.shadowOpacity = 0.16
        viewContactsBase.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewContactsBase.layer.shadowRadius = 4
        
//        self.btnDiningReq.layer.cornerRadius = 18
//        self.btnDiningReq.layer.borderWidth = 1
//        self.btnDiningReq.layer.borderColor = hexStringToUIColor(hex: "F06C42").cgColor
        self.btnDiningReq.diningBtnViewSetup()
        self.btnDiningReq.setTitle(self.appDelegate.masterLabeling.dining_request, for: UIControlState.normal)
        self.btnDiningReq.setStyle(style: .outlined, type: .primary)
        
        self.btnMenusHours.diningBtnViewSetup()
        self.btnMenusHours.setTitle(self.appDelegate.masterLabeling.menus_hours ?? "", for: .normal)
        self.btnMenusHours.setStyle(style: .outlined, type: .primary)
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
        
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        initController()
        
        self.navigationItem.title = self.appDelegate.masterLabeling.dining_reservations ?? "" as String
        self.lblRecentNews.text = self.appDelegate.masterLabeling.recent_news ?? "" as String
        self.lblInstructionalVideos.text = self.appDelegate.masterLabeling.instructional_videos_dining ?? "" as String
        self.lblUpComingEvents.text = self.appDelegate.masterLabeling.upcoming_dining_times ?? "" as String
        lblCalendarofEvents .setTitle(self.appDelegate.masterLabeling.calendar_title, for: .normal)
        btnrules .setTitle(self.appDelegate.masterLabeling.dress_code, for: .normal)
        btnViewAll .setTitle(self.appDelegate.masterLabeling.vIEW_ALL, for: .normal)
        self.appDelegate.dateSortToDate = ""
        self.appDelegate.dateSortFromDate = ""

        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        //NOTE:- Removed as its causing the below issue
        //after going to calendar and swiped right(not completely) to dismiss and let go without dismissing then the titles of the screen is changing to golf even when going from tennis / dining.
       // self.appDelegate.typeOfCalendar = ""

        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
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
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
   
    
    func initController()
    {
        
        self.imgImpContacts.layer.cornerRadius = 12
        self.lblCalendarofEvents.layer.borderWidth = 1
        self.lblCalendarofEvents.layer.borderColor = hexStringToUIColor(hex: "F06C42").cgColor
        self.btnViewAll.layer.borderWidth = 1
        self.btnViewAll.layer.borderColor = hexStringToUIColor(hex: "F06C42").cgColor
        self.lblCalendarofEvents.setStyle(style: .outlined, type: .primary)
        self.btnViewAll.setStyle(style: .outlined, type: .primary)
        
        imgUpcomingEvents.layer.cornerRadius = 30
        imgUpcomingEvents.layer.borderWidth = 1
        imgUpcomingEvents.layer.masksToBounds = true
        imgUpcomingEvents.layer.borderColor = hexStringToUIColor(hex: "a7a7a7").cgColor
    
        recentNewsTableview.layer.shadowColor = UIColor.black.cgColor
        recentNewsTableview.layer.shadowOpacity = 0.16
        recentNewsTableview.layer.masksToBounds = false
        
        recentNewsTableview.layer.shadowOffset = CGSize.zero
        recentNewsTableview.layer.shadowRadius = 2
        
        self.lblMemberNameAndID.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)
        
        ImpMainView.layer.shadowColor = UIColor.lightGray.cgColor
        ImpMainView.layer.shadowOpacity = 1.0
        ImpMainView.layer.shadowOffset = CGSize(width: 2, height: 2)
        ImpMainView.layer.shadowRadius = 4

    }
    
    @objc func upComingEventsCliked(sender : UITapGestureRecognizer)
    {
        
        //Added by kiran V1.4 --PROD0000069-- Club News - Addeds uport for upcoming event flyer click
        //PROD0000069 -- Start
        if let eventDetails = self.ClubNewsDetails?.upComingEvent.first, eventDetails.enableRedirectClubNewsToEvents == 1
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

                if (self.ClubNewsDetails?.upComingEvent.count != 0) {
                    
                    //clubNews.imgURl = self.ClubNewsDetails?.upComingEvent[0].image
                    //Added on 14th May 2020  v2.1
                    let mediaDetails = MediaDetails()
                    mediaDetails.type = .image
                    mediaDetails.newsImage = self.ClubNewsDetails?.upComingEvent[0].image ?? ""
                    
                    clubNews.arrMediaDetails = [mediaDetails]
                    //Old logic
                    //clubNews.arrImgURl = [["NewsImage" : self.ClubNewsDetails?.upComingEvent[0].image ?? ""]]
                    //Added on 19th May 2020  v2.1
                    clubNews.contentType = .image
                    self.present(clubNews, animated: true, completion: nil)

                }
                else{
                }
            }
        }
        //PROD0000069 -- End
 
    }
   
    @objc func importantContacts(sender : UITapGestureRecognizer) {
        if let impVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ImpotantContactsVC") as? ImpotantContactsVC {
            impVC.isFrom = "DiningReservation"
            impVC.importantContactsDisplayName = self.ClubNewsDetails?.importantContacts[0].displayName ?? ""
            
            
            impVC.modalTransitionStyle   = .crossDissolve;
            impVC.modalPresentationStyle = .overCurrentContext
            self.present(impVC, animated: true, completion: nil)
        }
        
        
    }
    
    //Commented by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead
    //ENGAGE0011419 -- Start
//    func verifyUrl(urlString: String?) -> Bool {
//        if let urlString = urlString {
//            if let url = URL(string: urlString) {
//                return UIApplication.shared.canOpenURL(url)
//            }
//        }
//        return false
//    }
    //ENGAGE0011419 -- End
    
    override func viewWillLayoutSubviews() {
        if isUpcomingEventHidded == true {
            self.heightUpcomingEvent.constant = 0
            self.heightUpcomingLabel.constant = 0
            self.heightUpcomingTop.constant = 0

            heightRecentNewsTable.constant = recentNewsTableview.contentSize.height
            
            
            if ClubNewsDetails?.instructionalVideos.count == 0{
                lblInstructionalVideos.isHidden = true
                instructionalLabelHeight.constant = 0
                cateringVideosHeight.constant = 0
                self.diningReservationHeight.constant = 652 + self.recentNewsTableview.contentSize.height
                
            }else{
                diningReservationHeight.constant = 824 + recentNewsTableview.contentSize.height
            }
            
        }
        else{
            heightRecentNewsTable.constant = recentNewsTableview.contentSize.height
            
            if ClubNewsDetails?.instructionalVideos.count == 0{
                lblInstructionalVideos.isHidden = true
                instructionalLabelHeight.constant = 0
                cateringVideosHeight.constant = 0
                self.diningReservationHeight.constant = 934 + self.recentNewsTableview.contentSize.height
                
            }else{
                self.diningReservationHeight.constant = 1106 + self.recentNewsTableview.contentSize.height
            }
            
        }
    }
    //MARK:- Get Dining Details  Api

    func diningReservationDetails() {
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        let params: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            
            ]
        
        APIHandler.sharedInstance.diningReservationDetails(paramater: params, onSuccess: { (response) in
            
            self.ClubNewsDetails = response
            
            let placeHolderImage = UIImage(named: "Icon-App-40x40")
            if (self.ClubNewsDetails?.upComingEvent.count != 0)
            {
                //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
                //ENGAGE0011419 -- Start
                let imageURLString2 = self.ClubNewsDetails?.upComingEvent[0].imgthumb ?? ""
                
                if imageURLString2.isValidURL()
                {
                    self.isUpcomingEventHidded = false
                    if (UserDefaults.standard.string(forKey: UserDefaultsKeys.shareUrl.rawValue) == "1")
                    {
                        
                    }
                    else
                    {
                        
                    }

                    let url = URL.init(string:imageURLString2)
                    self.imgUpcomingEvents.sd_setImage(with: url , placeholderImage: placeHolderImage)
                    self.appDelegate.hideIndicator()
                }
                else
                {
                    self.isUpcomingEventHidded = true
                    self.lblUpComingEvents.isHidden = true
                }
                
                
                /*
                if(imageURLString2 != nil)
                {
                    let validUrl = self.verifyUrl(urlString: imageURLString2)
                    if(validUrl == true)
                    {
                        self.isUpcomingEventHidded = false
                        if (UserDefaults.standard.string(forKey: UserDefaultsKeys.shareUrl.rawValue) == "1")
                        {
                            
                        }
                        else
                        {
                            
                        }

                        let url = URL.init(string:imageURLString2!)
                        self.imgUpcomingEvents.sd_setImage(with: url , placeholderImage: placeHolderImage)
                        self.appDelegate.hideIndicator()
            
                    }
                    else
                    {
                        self.isUpcomingEventHidded = true
                        self.lblUpComingEvents.isHidden = true

                    }
                }
                */
                //ENGAGE0011419 -- End
            }
            else{
                //   let url = URL.init(string:imageURLString)
                self.isUpcomingEventHidded = true
                self.lblUpComingEvents.isHidden = true

            }
            if self.ClubNewsDetails?.instructionalVideos.count == 0 {
                self.collectionViewIV.setEmptyMessage(InternetMessge.kNoData)
                
            }

            
            if (self.ClubNewsDetails?.hostAnEvent.count != 0)
            {
                
                self.lblHostAnEvent.text = self.ClubNewsDetails?.hostAnEvent[0].displayName
                self.lblPhoneNumber.text = self.ClubNewsDetails?.hostAnEvent[0].phone
                self.lblEmailaddress.text = self.ClubNewsDetails?.hostAnEvent[0].email

                //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
                //ENGAGE0011419 -- Start
                let imageURLString = self.ClubNewsDetails?.hostAnEvent[0].icon2X ?? ""
                
                if imageURLString.isValidURL()
                {
                    let url = URL.init(string:imageURLString)
                    self.imgHost.sd_setImage(with: url , placeholderImage: placeHolderImage)
                    self.appDelegate.hideIndicator()
                }
                /*
                if(imageURLString != nil)
                {
                    let validUrl = self.verifyUrl(urlString: imageURLString)
                    if(validUrl == true)
                    {
                        let url = URL.init(string:imageURLString!)
                        self.imgHost.sd_setImage(with: url , placeholderImage: placeHolderImage)
                        self.appDelegate.hideIndicator()
                        
                    }
                    
                }
                */
                //ENGAGE0011419 -- End
                self.recentNewsTableview.reloadData()
            
            }
          //

            self.collectionViewIV.reloadData()
            
            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            self.appDelegate.hideIndicator()
            
        }        
    }
    
    @IBAction func viewAllClicked(_ sender: Any) {
        
        
        if let allClubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AllClubNewsViewController") as? AllClubNewsViewController {
            allClubNews.isFrom = "DiningReservation"
            self.navigationController?.pushViewController(allClubNews, animated: true)
            
        }
    }
    
    @IBAction func calendarOfEventsClicked(_ sender: Any) {
        
        
        if let calendar = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "GolfCalendarVC") as? GolfCalendarVC
        {
            self.appDelegate.buddyType = "First"
            self.appDelegate.typeOfCalendar = "Dining"
            self.navigationController?.pushViewController(calendar, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  ClubNewsDetails?.clubNews.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RecentNewsCustomCell = tableView.dequeueReusableCell(withIdentifier: "RecentNewsID") as! RecentNewsCustomCell
        
        if let recentNews = ClubNewsDetails?.clubNews[indexPath.row]
        {
            cell.lblNews.text = recentNews.newsTitle
            cell.lblNewsDate.text = recentNews.date
        }
        if isUpcomingEventHidded == true {
            self.heightUpcomingEvent.constant = 0
            self.heightUpcomingLabel.constant = 0
            self.heightUpcomingTop.constant = 0

            self.lblUpComingEvents.isHidden = true
            heightRecentNewsTable.constant = recentNewsTableview.contentSize.height
            
            diningReservationHeight.constant = 824 + recentNewsTableview.contentSize.height
        }
        else{
            self.lblUpComingEvents.isHidden = false
            heightRecentNewsTable.constant = recentNewsTableview.contentSize.height
            diningReservationHeight.constant = 1106 + recentNewsTableview.contentSize.height
        }
        self.view.setNeedsLayout()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ClubNewsDetailsViewController") as? ClubNewsDetailsViewController {
//
//            clubNews.newsDescription = ClubNewsDetails?.clubNews[indexPath.row].description as NSString?
//            clubNews.imgURl = ClubNewsDetails?.clubNews[indexPath.row].newsImage as NSString?
//
//            self.navigationController?.pushViewController(clubNews, animated: true)
//
//        }
        
//        if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ViewNewsViewController") as? ViewNewsViewController {
//            clubNews.modalTransitionStyle   = .crossDissolve;
//            clubNews.modalPresentationStyle = .overCurrentContext
//            clubNews.imgURl = ClubNewsDetails?.clubNews[indexPath.row].newsImage as NSString?
//
//            self.present(clubNews, animated: true, completion: nil)
//        }
        
        //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
        //PROD0000069 -- Start
        
        if let clubnews = self.ClubNewsDetails?.clubNews[indexPath.row], clubnews.enableRedirectClubNewsToEvents == 1
        {
            self.navigateToEventsScreen(selectedNews: clubnews)
        }
        else
        {
            //Added on 14th May 2020  v2.1
            if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ViewNewsViewController") as? ViewNewsViewController
            {
                clubNews.modalTransitionStyle   = .crossDissolve;
                clubNews.modalPresentationStyle = .overCurrentContext

                clubNews.arrMediaDetails = self.appDelegate.imageDataToMediaDetails(list: ClubNewsDetails?.clubNews[indexPath.row].newsImageList)
                //Added on 19th May 2020  v2.1
                clubNews.contentType = .clubNews
                clubNews.contentDetails = ContentDetails.init(id: ClubNewsDetails?.clubNews[indexPath.row].id, date: ClubNewsDetails?.clubNews[indexPath.row].date, name: ClubNewsDetails?.clubNews[indexPath.row].newsTitle, link: nil)
                self.present(clubNews, animated: true, completion: nil)
                
            }
        }
        
        //PROD0000069 -- End
        //Old Logic
        /*
        if  (ClubNewsDetails?.clubNews[indexPath.row].newsVideoURL == "")
        {
            if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ViewNewsViewController") as? ViewNewsViewController
            {
                clubNews.modalTransitionStyle   = .crossDissolve;
                clubNews.modalPresentationStyle = .overCurrentContext
                //clubNews.imgURl = ClubNewsDetails?.clubNews[indexPath.row].newsImage
                clubNews.arrImgURl = self.appDelegate.imageDataToDict(list: ClubNewsDetails?.clubNews[indexPath.row].newsImageList)
                self.present(clubNews, animated: true, completion: nil)
                
            }
            
        }
        else
        {
            
            if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "VideoViewController") as? VideoViewController
            {
                clubNews.modalTransitionStyle   = .crossDissolve;
                clubNews.modalPresentationStyle = .overCurrentContext
                clubNews.videoURL = ClubNewsDetails?.clubNews[indexPath.row].newsVideoURL.videoID
                    
                self.present(clubNews, animated: true, completion: nil)
                
            }
            
        }
        */
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ClubNewsDetails?.instructionalVideos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCell", for: indexPath as IndexPath) as! CustomDashBoardCell
        
        
        if let instructionalVideos = ClubNewsDetails?.instructionalVideos[indexPath.row]
        {
            cell.videoWkWebview.scrollView.isScrollEnabled = false
            cell.imgInstructionalVideos.isHidden = true
            let videoURL = instructionalVideos.videoURL
            
            //Added by kiran V1.3 -- PROD0000033 -- Adding support for Youtube videos.
            //PROD0000033 -- Start
            if let url = URL(string: videoURL)//videoURL != nil || videoURL == ""
            {
                let requestObj = URLRequest(url: url)
                cell.videoWkWebview.load(requestObj)
                
                //Old Logic
                /*
                let url = URL (string: ("https://player.vimeo.com/video/") + (videoURL.videoID ?? ""))
                let requestObj = URLRequest(url: url!)
                cell.videoWkWebview.load(requestObj)
                */
            //PROD0000033 -- End
            }
            else
            {
                let url = URL (string: ("https://player.vimeo.com/video/"))
                let requestObj = URLRequest(url: url!)
                cell.videoWkWebview.load(requestObj)
            }
            
            
            let placeholder:UIImage = UIImage(named: "Icon-App-40x40")!

            //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
            //ENGAGE0011419 -- Start
            let imageURLString = instructionalVideos.imageThumbnail
            
            if imageURLString.isValidURL()
            {
                let url = URL.init(string:imageURLString)
                cell.imgInstructionalVideos.sd_setImage(with: url , placeholderImage: placeholder)
            }
            else
            {
                cell.imgImageView.image = UIImage(named: "")!
            }
            
            /*
            if(imageURLString != nil){
                let validUrl = self.verifyUrl(urlString: imageURLString)
                if(validUrl == true){
                    let url = URL.init(string:imageURLString)
                    cell.imgInstructionalVideos.sd_setImage(with: url , placeholderImage: placeholder)
                }
            }
            else{
                //   let url = URL.init(string:imageURLString)
                cell.imgImageView.image = UIImage(named: "")!
            }
            */
            //ENGAGE0011419 -- End
            //  self.collectionViewHeight.constant = self.dashBoardCollectionView.contentSize.height;
            
            //Added by kiran V3.0 -- ENGAGE0012360 -- fixes the issue where video playes automitically with the app is left idle for 1+hrs
            //ENGAGE0012360 -- Start
            cell.videoWkWebview.configuration.mediaTypesRequiringUserActionForPlayback = [.audio,.video]
            //ENGAGE0012360 -- End
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    @IBAction func shareClicked(_ sender: Any) {
        if let share = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ShareViewController") as? ShareViewController {
            share.modalTransitionStyle   = .crossDissolve;
            share.modalPresentationStyle = .overCurrentContext
            //Added on 19th May 2020 v2.1
            //OLd logic
            //share.imgURl = self.ClubNewsDetails?.upComingEvent[0].imgthumb
            
            //share.isFrom = "Events"
            share.contentType = .events
            share.contentDetails = ContentDetails.init(id: self.ClubNewsDetails?.upComingEvent[0].imgthumb, date: nil, name: nil, link: self.ClubNewsDetails?.upComingEvent[0].imgthumb)
            self.present(share, animated: true, completion: nil)
        }
    }
    
    @IBAction func menuAndHoursClicked(_ sender: UIButton) {
        
        if let restaurents = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "RestaurantsViewController") as? RestaurantsViewController {
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
        self.navigationController?.navigationBar.tintColor = APPColor.viewNews.backButtonColor

        self.navigationController?.pushViewController(restaurents, animated: true)
        }
        
    }
    
    @IBAction func RulesClicked(_ sender: Any) {
        
        let restarantpdfDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
        if self.ClubNewsDetails?.dressCode.count == 0 {
            restarantpdfDetailsVC.pdfUrl = ""
            restarantpdfDetailsVC.restarantName =  self.appDelegate.masterLabeling.dress_code!
            
        }else{
            restarantpdfDetailsVC.pdfUrl = (self.ClubNewsDetails?.dressCode[0].URL) ?? ""
            restarantpdfDetailsVC.restarantName = (self.ClubNewsDetails?.dressCode[0].title) ?? ""
        }
//        restarantpdfDetailsVC.pdfUrl = (self.ClubNewsDetails?.dressCode[0].URL)!
//        restarantpdfDetailsVC.restarantName = (self.ClubNewsDetails?.dressCode[0].title)!
        self.navigationController?.pushViewController(restarantpdfDetailsVC, animated: true)
        
    }
    func requestReservationApi() {
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        let paramaterDict: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue) ?? "",
            "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue) ?? ""
        ]
        
        APIHandler.sharedInstance.getReservationSettings(paramater: paramaterDict , onSuccess: { response in
            
            
            
            self.appDelegate.arrGolfSettings = response.golfSettings
            self.appDelegate.arrTennisSettings = response.tennisSettings
            self.appDelegate.arrDiningSettings = response.dinningSettings
            
            self.diningRequestClicked()
            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            self.diningRequestClicked()
            self.appDelegate.hideIndicator()
            
        }
    }
    @IBAction func diningRequestClicked(_ sender: Any) {
        
        
       self.requestReservationApi()
    }
    
    func diningRequestClicked(){
        if let impVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningRequestVC") as? DiningRequestVC {
            
           // impVC.diningSettings = self.diningSettings
            
            self.navigationController?.pushViewController(impVC, animated: true)
            
        }
    }
}


extension DiningReservationViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edgeInsets = (view.frame.size.width/2) - 91
        
        if ClubNewsDetails?.instructionalVideos.count == 1 {
            
            return UIEdgeInsetsMake(0, edgeInsets, 0, edgeInsets)
        }else{
            return UIEdgeInsetsMake(0, 0, 0, 0)
            
        }
        
    }
    
}

//Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
//PROD0000069 -- Start
extension DiningReservationViewController : DiningEventRegistrationVCDelegate
{
    
    //Added by kiran V1.4 --PROD0000069-- Club News - Added supoprt to upcoming event flyer image click.
    //PROD0000069 -- Start
    private func navigateToEventsScreen(selectedNews : RecentNewsDining)
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
    
    private func showEventScreenFromFlyer(event : UpComingDining)
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
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
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
            let okAction = UIAlertAction.init(title: self.appDelegate.masterLabeling.clubNewsToEvents_OK ?? "", style: .default, handler: nil)
            CustomFunctions.shared.showAlert(title: "", message: validationMessage, on: self, actions: [okAction])
            //CustomFunctions.shared.showToast(WithMessage: validationMessage, on: self.view)
            return
        }*/
        //PROD0000069 -- End
        
        guard selectedNews.isMemberTgaEventNotAllowed != 1 else {
            SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.TGAMEMBERVALIDATION, withDuration: Duration.kMediumDuration)
            return
        }
        
        //Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for email to, external registerations, golf genious, No regterations and confirmes state.
        //PROD0000069 -- Start
        guard let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningEventRegistrationVC") as? DiningEventRegistrationVC else{return}
        
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
                registerVC.isViewOnly = true
                registerVC.eventType = selectedNews.isMemberCalendar
                registerVC.requestID = selectedNews.requestID
                registerVC.isFrom = "EventUpdate"
                registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
                registerVC.showStatus = true
                registerVC.strStatus = selectedNews.eventstatus ?? ""
                registerVC.strStatusColor = selectedNews.colorCode ?? "#FFFFFF"
                registerVC.delegate = self
                registerVC.navigatedFrom = .dining
                self.navigationController?.pushViewController(registerVC, animated: true)
            }
        //3 is cancel, 4 is view only.
        case "3","4":
            
            registerVC.eventID = selectedNews.eventID
            registerVC.eventCategory = selectedNews.eventCategory
            registerVC.isViewOnly = true
            registerVC.eventType = selectedNews.isMemberCalendar
            registerVC.requestID = selectedNews.requestID
            registerVC.isFrom = "EventUpdate"
            registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
            registerVC.showStatus = true
            registerVC.strStatus = selectedNews.eventstatus ?? ""
            registerVC.strStatusColor = selectedNews.colorCode ?? "#FFFFFF"
            registerVC.delegate = self
            registerVC.navigatedFrom = .dining
            self.navigationController?.pushViewController(registerVC, animated: true)
        //1 is request, 2 is modify
        case "1","2":
            
            registerVC.eventID = selectedNews.eventID
            registerVC.eventCategory = selectedNews.eventCategory
            registerVC.eventType = selectedNews.isMemberCalendar
            registerVC.requestID = selectedNews.requestID
            registerVC.isFrom = "EventUpdate"
            registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
            registerVC.delegate = self
            registerVC.navigatedFrom = .dining
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
        if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningEventRegistrationVC") as? DiningEventRegistrationVC
        {
            registerVC.eventID = selectedNews.eventID
            registerVC.eventCategory = selectedNews.eventCategory
            registerVC.eventType = selectedNews.isMemberCalendar
            registerVC.requestID = selectedNews.requestID
            registerVC.isFrom = "EventUpdate"
            registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
            registerVC.delegate = self
            registerVC.navigatedFrom = .dining
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
        */
        //PROD0000069 -- End

    }
    //PROD0000069 -- Start
    
    func diningEventSuccessPopupClosed()
    {
        self.diningReservationDetails()
    }
    
}
//PROD0000069 -- End

//Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for composing Emails
//PROD0000069 -- Start
extension DiningReservationViewController : MFMailComposeViewControllerDelegate
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
