//
//  TodayAtGlanceVC.swift
//  CSSI
//
//  Created by apple on 11/6/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import ScrollableSegmentedControl
import Alamofire

class TodayAtGlanceVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {

    @IBOutlet weak var todayAtGlanceSearchBar: UISearchBar!
    @IBOutlet weak var todatAtGlanceTableview: UITableView!
    @IBOutlet weak var uiSegmentView: UIView!
    
    var segmentedController = ScrollableSegmentedControl()
    var arrTodayAtGlanceCategory = [GlanceCategory]()
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrTodaysGlanceList = [TodayAtGlance]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.getGlanceDetails()

        
        self.getGlanceCategoriesApi(strSearch : "")
        

        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = self.appDelegate.masterLabeling.tODAY_AT_A_GLANCE
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

        self.isAppAlreadyLaunchedOnce()
        
    }
   override func viewWillDisappear(_ animated: Bool)
   {
        super.viewWillDisappear(animated)
    //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
    //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
   }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnceTAG"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnceTAG")
            if let impVC = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "PopUpForCategoryVC") as? PopUpForCategoryVC {
                impVC.isFrom = "TodayAtGlance"
                impVC.modalTransitionStyle   = .crossDissolve;
                impVC.modalPresentationStyle = .overCurrentContext
                self.present(impVC, animated: true, completion: nil)
            }
            return false
        }
    }
    @IBAction func nextClicked(_ sender: Any) {
        if self.arrTodayAtGlanceCategory.count == 0 {
            
        }else{
        
        var selectedSegment =  self.segmentedController.selectedSegmentIndex  + 1
        
        if selectedSegment >= self.segmentedController.numberOfSegments  {
            selectedSegment = self.segmentedController.numberOfSegments - 1
        }
        
        
        self.appDelegate.selectedGlanceCategory = self.arrTodayAtGlanceCategory[selectedSegment]
        
        
        self.segmentedController.selectedSegmentIndex = selectedSegment
        }
    }
    
 
    @IBAction func previousClicked(_ sender: Any) {
        if self.arrTodayAtGlanceCategory.count == 0 {
            
        }else{
        
        var selectedSegment =  self.segmentedController.selectedSegmentIndex  - 1
        if selectedSegment <= 0  {
            selectedSegment = 0
        }
        self.appDelegate.selectedGlanceCategory = self.arrTodayAtGlanceCategory[selectedSegment]
        self.segmentedController.selectedSegmentIndex = selectedSegment
    }
    }
    //MARK:- Segment Controller Selected
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        
        self.todatAtGlanceTableview.reloadData()
        self.appDelegate.selectedGlanceCategory = self.arrTodayAtGlanceCategory[sender.selectedSegmentIndex]
        
        self.getGlanceDetails()

    }
   

    
    //MARK:- Get Todaysat Glance Categories
    func getGlanceCategoriesApi(strSearch :String) -> Void {
        if (Network.reachability?.isReachable) == true{
            
            arrTodayAtGlanceCategory = [GlanceCategory]()
            self.arrTodayAtGlanceCategory.removeAll()
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.getGlanceCategory(paramater: paramaterDict, onSuccess: { categoriesList in
                self.appDelegate.hideIndicator()
                if(categoriesList.responseCode == InternetMessge.kSuccess){
                    self.arrTodayAtGlanceCategory.removeAll()
                    
                    if(categoriesList.glanceCategory == nil){
                        self.arrTodayAtGlanceCategory.removeAll()
                        
                        // self.appDelegate.hideIndicator()
                    }
                    else{
                        self.arrTodayAtGlanceCategory.removeAll()
                       

                        
                        self.arrTodayAtGlanceCategory = categoriesList.glanceCategory!
                        
                        if self.arrTodayAtGlanceCategory.count == 0 {
                            

                             self.todatAtGlanceTableview.setEmptyMessage(InternetMessge.kNoData)

                        }
                        else{
                        
                        self.appDelegate.selectedGlanceCategory = self.arrTodayAtGlanceCategory[0]
                        
                        self.loadsegmentController()
                        }
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
                        
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
    }
    //MARK:- Get Galnce Details  Api

    func getGlanceDetails() {
        
        if (Network.reachability?.isReachable) == true{
            
            let todaysDate:NSDate = NSDate()
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = APIKeys.valuedateformat
            let todayString:String = dateFormatter.string(from: todaysDate as Date)
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.keffectivedate: todayString,
                APIKeys.kGlanceCategory: self.appDelegate.selectedGlanceCategory.categoryName ?? ""

            ]
            
            APIHandler.sharedInstance.getGlanceDetails(paramater: paramaterDict, onSuccess: { eventList in
                self.appDelegate.hideIndicator()
                
                if(eventList.responseCode == InternetMessge.kSuccess){
                    if(eventList.todayGlance == nil){
                        self.appDelegate.hideIndicator()
                        self.todatAtGlanceTableview.setEmptyMessage(InternetMessge.kNoData)

                    }
                    else{
                        self.todatAtGlanceTableview.setEmptyMessage("")

                        self.arrTodaysGlanceList = eventList.todayGlance!
                        self.appDelegate.hideIndicator()
                        self.todatAtGlanceTableview.reloadData()
                    }
                    if(!(self.arrTodaysGlanceList.count == 0)){

                        let indexPath = IndexPath(row: 0, section: 0)
                        self.todatAtGlanceTableview.scrollToRow(at: indexPath, at: .top, animated: true)
                    }else{
                        self.appDelegate.hideIndicator()
                        self.arrTodaysGlanceList.removeAll()
                        self.todatAtGlanceTableview.setEmptyMessage(InternetMessge.kNoData)
                    }

                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((eventList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: eventList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                }
                
                
            },onFailure: { error  in
                print(error)
                self.appDelegate.hideIndicator()
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }else{
            
            
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
    
    //Commented by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead
    //ENGAGE0011419 -- Start
    //Mark- Verify url exist
//    func verifyUrl(urlString: String?) -> Bool {
//        if let urlString = urlString {
//            if let url = URL(string: urlString) {
//                return UIApplication.shared.canOpenURL(url)
//            }
//        }
//        return false
//    }
    //ENGAGE0011419 -- End
    
    //Mark- Tableview Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTodaysGlanceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:GlanceCustomTableViewCell = self.todatAtGlanceTableview.dequeueReusableCell(withIdentifier: "glanceIdentifier") as! GlanceCustomTableViewCell
     //   self.todatAtGlanceTableview.separatorStyle = .singleLine
        var eventobj =  TodayAtGlance()
        eventobj = arrTodaysGlanceList[indexPath.row]
        cell.lblLocation.text = (eventobj.location ?? "")
        cell.btnStatus .setTitle(eventobj.status, for: .normal)
        cell.btnStatus.layer.cornerRadius = 12
        cell.btnStatus.layer.masksToBounds = true
        cell.lblComments.text = eventobj.comment
        cell.lblTime.text = eventobj.time
       
        cell.btnStatus .backgroundColor = hexStringToUIColor(hex: eventobj.statusColor ?? "")
        if eventobj.statusColor == ""{
            cell.btnStatus.backgroundColor = UIColor.clear
        }

        let placeHolderImage = UIImage(named: "Icon-App-40x40")
        cell.imgGlanceImage.image = placeHolderImage

        //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
        //ENGAGE0011419 -- Start
        let imageURLString = eventobj.glanceImage ?? ""
        
        if imageURLString.isValidURL()
        {
            let url = URL.init(string:imageURLString)
            cell.imgGlanceImage.sd_setImage(with: url , placeholderImage: placeHolderImage)
        }
        /*
        if(imageURLString.count>0){
            let validUrl = self.verifyUrl(urlString: imageURLString)
            if(validUrl == true){

                let url = URL.init(string:imageURLString)
              //  cell.imgGlanceImage.contentMode = .scaleAspectFit

                cell.imgGlanceImage.sd_setImage(with: url , placeholderImage: placeHolderImage)

            }
        }
        */
        //ENGAGE0011419 -- End
        return cell
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
        for i in 0 ..< self.arrTodayAtGlanceCategory.count {
            let statementData = self.arrTodayAtGlanceCategory[i]
            
            
            self.segmentedController.insertSegment(withTitle: statementData.categoryName, image: nil, at: i)
        }
        
        self.segmentedController.selectedSegmentIndex = 0
    }
    
    
}
