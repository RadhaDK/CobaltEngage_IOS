//  AllClubNewsViewController.swift
//  CSSI
//  Created by apple on 10/31/18.
//  Copyright © 2018 yujdesigns. All rights reserved.


import UIKit
import ScrollableSegmentedControl
import Popover
import MessageUI

class AllClubNewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var newsSearchBar: UISearchBar!
    @IBOutlet weak var uiSegmentView: UIView!
    @IBOutlet weak var segmentMainView: UIView!
    @IBOutlet weak var allNewsTableview: UITableView!
    
    var arrEventCategory = [ListEventCategory]()
    var segmentedController = ScrollableSegmentedControl()
    var eventCategory: NSString!
    var filterPopover: Popover? = nil
    var isFrom : NSString!

    var arrClubNews = [ClubNews]()
    var clubNewsDetailsList: ClubNewsDetails? = nil
    var filterByDepartment : String!
    var filterByDate : String!
    var filterBy : String!

    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
    //PROD0000069 -- Start
    private let accessManager = AccessManager.shared
    //PROD0000069 -- End
    
    //Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for composing Emails
    //PROD0000069 -- Start
    var arrselectedEmails = [String]()
    //PROD0000069 -- End
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        allNewsTableview.estimatedRowHeight = 52
        allNewsTableview.rowHeight = UITableViewAutomaticDimension

        allNewsTableview.estimatedSectionHeaderHeight = 47
        
        self.navigationController?.navigationBar.isHidden = false

        // Do any additional setup after loading the view.
        self.getEventCategoriesApi(strSearch : "")

        
        newsSearchBar.searchBarStyle = .default
        
        newsSearchBar.layer.borderWidth = 1
        newsSearchBar.layer.borderColor = hexStringToUIColor(hex: "F5F5F5").cgColor

        
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = self.appDelegate.masterLabeling.recent_news ?? "" as String
        newsSearchBar.placeholder = self.appDelegate.masterLabeling.search_News ?? "" as String
        
        segmentMainView.layer.shadowColor = UIColor.lightGray.cgColor
        segmentMainView.layer.shadowOpacity = 1.0
        segmentMainView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        segmentMainView.layer.shadowRadius = 1.0
        segmentMainView.layer.masksToBounds = false

        


        let filterBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Filter"), style: .plain, target: self, action: #selector(onTapFilter))
        navigationItem.rightBarButtonItem = filterBarButtonItem
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.isAppAlreadyLaunchedOnce()
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnceViewNews"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnceViewNews")
            if let impVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "PopUpForCategoryVC") as? PopUpForCategoryVC {
                impVC.isFrom = "ViewNews"
                impVC.modalTransitionStyle   = .crossDissolve;
                impVC.modalPresentationStyle = .overCurrentContext
                self.present(impVC, animated: true, completion: nil)
            }
            print("App launched first time")
            return false
        }
    }
    
    @IBAction func previousClicked(_ sender: Any) {
        if self.arrEventCategory.count == 0 {
            
        }else{
        
        var selectedSegment =  self.segmentedController.selectedSegmentIndex  - 1
        if selectedSegment <= 0  {
            selectedSegment = 0
        }
        self.appDelegate.selectedEventsCategory = self.arrEventCategory[selectedSegment]
        self.segmentedController.selectedSegmentIndex = selectedSegment
        
        }
    }
    
   
    @IBAction func nextClicked(_ sender: Any) {
        if self.arrEventCategory.count == 0 {
            
        }else{
        var selectedSegment =  self.segmentedController.selectedSegmentIndex  + 1
        
        
        if selectedSegment >= self.segmentedController.numberOfSegments  {
            selectedSegment = self.segmentedController.numberOfSegments - 1
        }
        
        
        self.appDelegate.selectedEventsCategory = self.arrEventCategory[selectedSegment]
        
        
        self.segmentedController.selectedSegmentIndex = selectedSegment
        }}
    
    //MARK:- Segment Controller Selected
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        // print("Segment at index \(sender.selectedSegmentIndex)  selected")
        
        self.allNewsTableview.reloadData()
        self.appDelegate.selectedEventsCategory = self.arrEventCategory[sender.selectedSegmentIndex]
        
        // print()
        eventCategory = self.appDelegate.selectedEventsCategory.categoryName! as NSString
        
        self.getAllClubNewsApi(strSearch: newsSearchBar.text!)
        
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onTapFilter() {
        if let filterView = UINib(nibName: "GuestListFilterView", bundle: Bundle.main).instantiate(withOwner: GuestListFilterView.self, options: nil).first as? GuestListFilterView{
            filterPopover = Popover()
            
            filterView.filterWithDepartment = filterByDepartment
            filterView.filterWithDate = filterByDate
            filterView.isFromGuest = 2

            let screenSize = UIScreen.main.bounds
            
            
            filterView.frame = CGRect(x:4, y: 88, width:screenSize.width - 8, height:270)

            
            filterPopover?.arrowSize = CGSize(width: 28.0, height: 13.0)
            filterPopover?.sideEdge = 4.0

            filterView.delegate = self
            filterView.eventsArrayFilter = self.arrEventCategory
            let point = CGPoint(x: self.view.bounds.width - 35, y: 70)
            filterPopover?.show(filterView, point: point)
            
            
           
            
        }
    }
    
    //MARK:- Get Event Categories  Api
    func getEventCategoriesApi(strSearch :String) -> Void {
        if (Network.reachability?.isReachable) == true{
            
            arrEventCategory = [ListEventCategory]()
            self.arrEventCategory.removeAll()
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.getEventCategory(paramater: paramaterDict, onSuccess: { categoriesList in
                self.appDelegate.hideIndicator()
                if(categoriesList.responseCode == InternetMessge.kSuccess){
                    self.arrEventCategory.removeAll()
                    
                    if(categoriesList.clubNewsCategories == nil){
                        self.arrEventCategory.removeAll()
                        
                        // self.appDelegate.hideIndicator()
                    }
                    else{
                        self.arrEventCategory.removeAll()
                        
                        self.arrEventCategory = categoriesList.clubNewsCategories!
                        
                        self.appDelegate.selectedEventsCategory = self.arrEventCategory[0]
                        
                        self.loadsegmentController()
                    }
                }else{
                    if(((categoriesList.responseMessage!.count) )>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: categoriesList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                }
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
        }else{
            
            //self.tableViewStatement.setEmptyMessage(InternetMessge.kInternet_not_available)
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
    }
    //MARK:- Get Club News Api

    func getAllClubNewsApi(strSearch :String?, filter: GuestCardFilter? = nil)  {
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        if isFrom == "TeeTimes"{
            eventCategory = "Golf"
            
            for i in 0 ..< self.arrEventCategory.count {
                let statementData = self.arrEventCategory[i]
                if statementData.categoryName == "Golf" {
                    self.segmentedController.selectedSegmentIndex = i
                }
            }
            
            
        }
        if isFrom == "CourtTimes"{
            eventCategory = "Tennis"
            for i in 0 ..< self.arrEventCategory.count {
                let statementData = self.arrEventCategory[i]
                if statementData.categoryName == "Tennis" {
                    self.segmentedController.selectedSegmentIndex = i
                }
            }
        }
        if isFrom == "DiningReservation"{
            eventCategory = "Dining"
            for i in 0 ..< self.arrEventCategory.count {
                let statementData = self.arrEventCategory[i]
                if statementData.categoryName == "Dining" {
                    self.segmentedController.selectedSegmentIndex = i
                }
            }
        }
        
        //Added on 29th June 2020 V2.2
        
        if isFrom == "FitnessSpa"{
            eventCategory = "FitnessSpa"
            for i in 0 ..< self.arrEventCategory.count {
                let statementData = self.arrEventCategory[i]
                if statementData.categoryName == "FitnessSpa" {
                    self.segmentedController.selectedSegmentIndex = i
                }
            }
        }
        
        

            
        let params: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.ksearchby : strSearch ?? "",
            "DepartmentFilter" : eventCategory,
            "DateSort" : filterBy
        ]
        
        APIHandler.sharedInstance.getClubNewsDetails(paramater: params, onSuccess: { (response) in
            self.isFrom = ""
            
            

            self.clubNewsDetailsList = response
            self.appDelegate.hideIndicator()

            
            if (self.clubNewsDetailsList?.clubNews.count == 0){
            
            self.allNewsTableview.setEmptyMessage(InternetMessge.kNoData)
            }
            else{
                self.allNewsTableview.setEmptyMessage("")


            }
            self.allNewsTableview.reloadData()


            
        }) { (error) in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            self.appDelegate.hideIndicator()
            
        }
        
        
    }
    
    

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return clubNewsDetailsList?.clubNews.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubNewsDetailsList?.clubNews[section].clubNewsDetails.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AllNewsCustomTableViewCell = self.allNewsTableview.dequeueReusableCell(withIdentifier: "ClubCell") as! AllNewsCustomTableViewCell
        if let clubNewsList = clubNewsDetailsList?.clubNews[indexPath.section].clubNewsDetails[indexPath.row]
        {

            cell.lblNewsTitle.text = "\(clubNewsList.newsTitle ?? "")"
            cell.lblNewsBy.text = ""
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    //44
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("AllNewsHeaderView", owner: self, options: nil)?.first as! AllNewsHeaderView
        let dateAsString = clubNewsDetailsList?.clubNews[section].date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        if let date = dateFormatter.date(from: dateAsString!) {
            dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
            headerView.allNewsHeaderLabel.text = "\(dateFormatter.string(from: date))"
            headerView.allNewsHeaderLabel.sizeToFit()
        }

        headerView.allNewsHeaderLabel.textColor = APPColor.textColor.secondary
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let shadowView = UIView()
        
        
        
        
        let gradient = CAGradientLayer()
        gradient.frame.size = CGSize(width: allNewsTableview.bounds.width, height: 15)
        let stopColor = hexStringToUIColor(hex: "000000").cgColor
        shadowView.alpha = CGFloat(0.16)
        
        let startColor = UIColor.white.cgColor
        
        
        gradient.colors = [stopColor,startColor]
        
        
        gradient.locations = [0.0,0.8]
        
        shadowView.layer.addSublayer(gradient)
        
        
        return shadowView
    }
    //44
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //Modified by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
        //PROD0000069 -- Start
        let selectedNews = self.clubNewsDetailsList!.clubNews[indexPath.section].clubNewsDetails[indexPath.row]
        if selectedNews.enableRedirectClubNewsToEvents == 1
        {
            self.navigateToEventsScreen(selectedNews: selectedNews)
        }
        else
        {
            let newsMedia = self.clubNewsDetailsList?.clubNews[indexPath.section].clubNewsDetails[indexPath.row].newsImageList
            if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ViewNewsViewController") as? ViewNewsViewController
            {
                clubNews.modalTransitionStyle   = .crossDissolve;
                clubNews.modalPresentationStyle = .overCurrentContext
                clubNews.arrMediaDetails = newsMedia
                clubNews.contentDetails =  ContentDetails.init(id: self.clubNewsDetailsList?.clubNews[indexPath.section].clubNewsDetails[indexPath.row].id, date: self.clubNewsDetailsList?.clubNews[indexPath.section].clubNewsDetails[indexPath.row].date, name: self.clubNewsDetailsList?.clubNews[indexPath.section].clubNewsDetails[indexPath.row].newsTitle, link: nil)
                //Added on on 19th May 2020  v2.1
                clubNews.contentType = .clubNews
                self.present(clubNews, animated: true, completion: nil)
                
            }
            
        }
        
        //old logic
        /*
        //Added on on 14th May 2020  v2.1
        let newsMedia = self.clubNewsDetailsList?.clubNews[indexPath.section].clubNewsDetails[indexPath.row].newsImageList
        if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ViewNewsViewController") as? ViewNewsViewController {
            clubNews.modalTransitionStyle   = .crossDissolve;
            clubNews.modalPresentationStyle = .overCurrentContext
            clubNews.arrMediaDetails = newsMedia
            clubNews.contentDetails =  ContentDetails.init(id: self.clubNewsDetailsList?.clubNews[indexPath.section].clubNewsDetails[indexPath.row].id, date: self.clubNewsDetailsList?.clubNews[indexPath.section].clubNewsDetails[indexPath.row].date, name: self.clubNewsDetailsList?.clubNews[indexPath.section].clubNewsDetails[indexPath.row].newsTitle, link: nil)
            //Added on on 19th May 2020  v2.1
            clubNews.contentType = .clubNews
            self.present(clubNews, animated: true, completion: nil)
            
        }
        */
        //PROD0000069 -- End
        
        //OLd Logic
        /*
        if  (clubNewsDetailsList?.clubNews[indexPath.section].clubNewsDetails[indexPath.row].newsVideoURL == "")
        {
            if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ViewNewsViewController") as? ViewNewsViewController
            {
                clubNews.modalTransitionStyle   = .crossDissolve;
                clubNews.modalPresentationStyle = .overCurrentContext
               // clubNews.imgURl = clubNewsDetailsList?.clubNews[indexPath.section].clubNewsDetails[indexPath.row].newsImage
                clubNews.arrMediaDetails = clubNewsDetailsList?.clubNews[indexPath.section].clubNewsDetails[indexPath.row].newsImageList
                self.present(clubNews, animated: true, completion: nil)
                
            }
        }
        else
        {
            if let clubNews = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "VideoViewController") as? VideoViewController
            {
                clubNews.modalTransitionStyle   = .crossDissolve;
                clubNews.modalPresentationStyle = .overCurrentContext
            //  clubNews.imgURl = clubNewsDetailsList?.clubNews[indexPath.section].clubNewsDetails[indexPath.row].newsImage as NSString?
                clubNews.videoURL = clubNewsDetailsList?.clubNews[indexPath.section].clubNewsDetails[indexPath.row].newsVideoURL.videoID

                self.present(clubNews, animated: true, completion: nil)
                
            }
            
        }
        */
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        newsSearchBar.resignFirstResponder()
        self.getAllClubNewsApi(strSearch: newsSearchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            
            self.getAllClubNewsApi(strSearch: newsSearchBar.text!)

        }
        
    }
    func loadsegmentController()  {
        
        self.segmentedController = ScrollableSegmentedControl.init(frame: self.uiSegmentView.bounds)
        self.uiSegmentView.addSubview(self.segmentedController)
        self.segmentedController.segmentStyle = .textOnly
        
        self.segmentedController.underlineSelected = true
        self.segmentedController.selectedSegmentIndex = 0
        self.segmentedController.backgroundColor = hexStringToUIColor(hex: "F5F5F5")
        
        self.segmentedController.tintColor = APPColor.loginBackgroundButtonColor.loginBtnBGColor
        
        self.segmentedController.addTarget(self, action: #selector(CalendarOfEventsViewController.segmentSelected(sender:)), for: .valueChanged)
        
        
        
        // self.segmentedController.removeFromSuperview()
        for i in 0 ..< self.arrEventCategory.count {
            let statementData = self.arrEventCategory[i]
            
            self.segmentedController.insertSegment(withTitle: statementData.categoryText, image: nil, at: i)
        }
        
        self.segmentedController.selectedSegmentIndex = 0
    }


}
extension AllClubNewsViewController : GuestListFilterViewDelegate {
    
    func guestCardFilterApply(filter: GuestCardFilter) {
        
        if !(filter.department.value() == -1) {
            self.segmentedController.selectedSegmentIndex = filter.department.value() as Int
            eventCategory = filter.department.displayName() as NSString
            
        }
        filterBy = filter.date.value()

        filterByDepartment = eventCategory! as String
        filterByDate = filter.date.displayName()
        getAllClubNewsApi(strSearch: newsSearchBar.text, filter: filter)
        filterPopover?.dismiss()
    }
    
    func guestCardFilterClose() {
        filterPopover?.dismiss()
    }
    
    
}

//Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
//PROD0000069 -- Start
extension AllClubNewsViewController : RegisterEventVCDelegate, DiningEventRegistrationVCDelegate
{
    
    private func navigateToEventsScreen(selectedNews : ClubNewsDetail)
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
        }
         */
        //PROD0000069 -- End
        guard selectedNews.isMemberTgaEventNotAllowed != 1 else {
            SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.TGAMEMBERVALIDATION, withDuration: Duration.kMediumDuration)
            return
        }
        
        //Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for email to, external registerations, golf genious, No regterations and confirmes state.
        //PROD0000069 -- Start
        if selectedNews.eventCategory?.lowercased() == "dining"
        {
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
                    registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
                    registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
                    registerVC.showStatus = true
                    registerVC.strStatus = selectedNews.eventstatus ?? ""
                    registerVC.strStatusColor = selectedNews.colorCode ?? "#FFFFFF"
                    registerVC.delegate = self
                    registerVC.navigatedFrom = .clubNews
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
                registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
                registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
                registerVC.showStatus = true
                registerVC.strStatus = selectedNews.eventstatus ?? ""
                registerVC.strStatusColor = selectedNews.colorCode ?? "#FFFFFF"
                registerVC.delegate = self
                registerVC.navigatedFrom = .clubNews
                self.navigationController?.pushViewController(registerVC, animated: true)
                //1 is request, 2 is modify
            case "1","2":
                
                registerVC.eventID = selectedNews.eventID
                registerVC.eventCategory = selectedNews.eventCategory
                registerVC.eventType = selectedNews.isMemberCalendar
                registerVC.requestID = selectedNews.requestID
                registerVC.isFrom = "EventUpdate"
                registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
                registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
                registerVC.delegate = self
                registerVC.navigatedFrom = .clubNews
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
            
        }
        else
        {
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
                    registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
                    registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
                    registerVC.showStatus = true
                    registerVC.strStatus = selectedNews.eventstatus ?? ""
                    registerVC.strStatusColor = selectedNews.colorCode ?? "#FFFFFF"
                    registerVC.delegate = self
                    registerVC.navigatedFrom = .clubNews
                    self.navigationController?.pushViewController(registerVC, animated: true)
                }
            //3 is cancel, 4 is view only.
            case "3","4":
                
                registerVC.eventID = selectedNews.eventID
                registerVC.eventCategory = selectedNews.eventCategory
                registerVC.eventType = selectedNews.isMemberCalendar
                registerVC.isViewOnly = true
                registerVC.isFrom = "EventUpdate"
                registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
                registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
                registerVC.showStatus = true
                registerVC.strStatus = selectedNews.eventstatus ?? ""
                registerVC.strStatusColor = selectedNews.colorCode ?? "#FFFFFF"
                registerVC.delegate = self
                registerVC.navigatedFrom = .clubNews
                self.navigationController?.pushViewController(registerVC, animated: true)
            //1 is request, 2 is modify
            case "1","2":
                registerVC.eventID = selectedNews.eventID
                registerVC.eventCategory = selectedNews.eventCategory
                registerVC.eventType = selectedNews.isMemberCalendar
                registerVC.isFrom = "EventUpdate"
                registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
                registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
                registerVC.delegate = self
                registerVC.navigatedFrom = .clubNews
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
            
        }

        //Old logic
        /*
        if selectedNews.eventCategory?.lowercased() == "dining"
        {
            if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningEventRegistrationVC") as? DiningEventRegistrationVC
            {
                registerVC.eventID = selectedNews.eventID
                registerVC.eventCategory = selectedNews.eventCategory
                registerVC.eventType = selectedNews.isMemberCalendar
                registerVC.requestID = selectedNews.requestID
                registerVC.isFrom = "EventUpdate"
                registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
                registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
                registerVC.delegate = self
                registerVC.navigatedFrom = .clubNews
                self.navigationController?.pushViewController(registerVC, animated: true)
            }
        }
        else
        {
            if let registerVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "RegisterEventVC") as? RegisterEventVC
            {
                registerVC.eventID = selectedNews.eventID
                registerVC.eventCategory = selectedNews.eventCategory
                registerVC.eventType = selectedNews.isMemberCalendar
                registerVC.isFrom = "EventUpdate"
                registerVC.segmentIndex = self.segmentedController.selectedSegmentIndex
                registerVC.eventRegistrationDetailID = selectedNews.eventRegistrationDetailID ?? ""
                registerVC.delegate = self
                registerVC.navigatedFrom = .clubNews
                self.navigationController?.pushViewController(registerVC, animated: true)
            }
            
        }
        */

        //PROD0000069 -- End
    }
    
    func eventSuccessPopupClosed()
    {
        self.getAllClubNewsApi(strSearch: self.newsSearchBar.text ?? "")
    }
    
    func diningEventSuccessPopupClosed()
    {
        self.getAllClubNewsApi(strSearch: self.newsSearchBar.text ?? "")
    }
    
}
//PROD0000069 -- End

//Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for composing Emails
//PROD0000069 -- Start
extension AllClubNewsViewController : MFMailComposeViewControllerDelegate
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
