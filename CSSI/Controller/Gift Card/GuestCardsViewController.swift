//
//  GiftCardsViewController.swift
//  CSSI
//
//  Created by Prashamsa on 25/09/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import UIKit
import Popover

fileprivate enum GuestCardMode {
    case None
    case RunningGuestCard
    case FutureGuestCard
    case NewOrExpireGuestCard
}

class GuestCardsViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblNameAndID: UILabel!
    @IBOutlet weak var btnGuestPolicy: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnAddVisit: UIButton!
    @IBOutlet weak var btnModify: UIButton!
    @IBOutlet weak var btnHistory: UIButton!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var guestListTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var searchBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var searchBar: UISearchBar!
    fileprivate var enableSelectionMode = false
    fileprivate var selectedGuest : Guest? = nil
    fileprivate var multipleSelectionMode : GuestCardMode = .None {
        didSet {
            switch multipleSelectionMode {
            case .None:
                btnAddVisit.isEnabled = true
                btnModify.isEnabled = true
                btnCancel.isEnabled = true
                btnHistory.isEnabled = true
            case .RunningGuestCard:
                btnAddVisit.isEnabled = true
                btnModify.isEnabled = true
                btnCancel.isEnabled = false
                btnHistory.isEnabled = true
            case .FutureGuestCard:
                btnAddVisit.isEnabled = true
                btnModify.isEnabled = true
                btnCancel.isEnabled = true
                btnHistory.isEnabled = true
            case .NewOrExpireGuestCard:
                btnAddVisit.isEnabled = true
                btnModify.isEnabled = false
                btnCancel.isEnabled = false
                btnHistory.isEnabled = true
            }
        }
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var guests : [Guest] = []
    var guestDropDown: [GuestDropDown] = []

    var addNewPopover: Popover? = nil
    var filterPopover: Popover? = nil
    var addNewPopoverTableView: UITableView? = nil
    var catAndSubCatDict: NSMutableDictionary = NSMutableDictionary()
    var isFrom : NSString!
    var multipleSelectionArray:[String] = []
    var currentFromDatesArray : [String] = []
    var currentToDatesArray : [String] = []
    //Commented by kiran V3.0 -- ENGAGE0011843 -- Replacing the use of filterWith with relationFilter
    //ENGAGE0011843 -- Start
    var relationFilter : RelationFilter?
    //var filterBy : String!
    //ENGAGE0011843 -- End
    
    var filterByDate : String!

    //Added on 4th July 2020 V2.2
    private let accessManager = AccessManager.shared
    
    //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
    //ENGAGE0011898 -- Start
    private var policyURL : String?
    private var PDFTitle : String?
    //ENGAGE0011898 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.searchBarStyle = .default
        
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = hexStringToUIColor(hex: "F5F5F5").cgColor
        //   eventSearchBar.layer.masksToBounds = true

        //Commented by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        //self.navigationItem.title = self.appDelegate.masterLabeling.tITLE_GUEST_CARD ?? "" as String
        //ENGAGE0011898 -- End
        
        searchBar.placeholder = self.appDelegate.masterLabeling.search_guest_Name ?? "" as String
        btnModify .setTitle(self.appDelegate.masterLabeling.modify, for: .normal)
        btnCancel .setTitle(self.appDelegate.masterLabeling.cancel_Card, for: .normal)
        btnHistory .setTitle(self.appDelegate.masterLabeling.history, for: .normal)
        btnAddVisit .setTitle(self.appDelegate.masterLabeling.add_Visit, for: .normal)
        btnGuestPolicy .setTitle(self.appDelegate.masterLabeling.guest_Card_Policy_Title, for: .normal)
        self.lblNameAndID.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)

        bottomViewHeight.constant = 0
        
        btnHistory.layer.borderWidth = 1.0
        btnCancel.layer.borderWidth = 1.0
        btnModify.layer.borderWidth = 1.0
        btnAddVisit.layer.borderWidth = 1.0
        
        btnHistory.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
        btnCancel.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
        btnModify.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
        btnAddVisit.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
        
        self.bottomView.isHidden = true

        self.btnHistory.setStyle(style: .outlined, type: .primary)
        self.btnCancel.setStyle(style: .outlined, type: .primary)
        self.btnModify.setStyle(style: .outlined, type: .primary)
        self.btnAddVisit.setStyle(style: .outlined, type: .primary)
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)

        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
        
        //Commented by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        self.PDFTitle = self.appDelegate.masterLabeling.guestCardPolicy_Name
        self.getGuestPolicyURL()
        //ENGAGE0011898 -- End
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        multipleSelectionArray = []
        currentFromDatesArray = []
        currentToDatesArray = []
        
        //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        self.navigationItem.title = self.appDelegate.masterLabeling.tITLE_GUEST_CARD ?? "" as String
        //ENGAGE0011898 -- End
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.navigationBar.isHidden = false
         self.navigationController?.setNavigationBarHidden(false, animated: animated)

        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        multipleSelectionMode = .None

        if  enableSelectionMode == false {
            let filterBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Filter"), style: .plain, target: self, action: #selector(onTapFilter))
            navigationItem.rightBarButtonItem = filterBarButtonItem
//            getGuestList(strSearch: searchBar.text)

        }
        else{
        
            self.navigationRightBar()


        }
        getGuestList(strSearch: searchBar.text)

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
    
    @IBAction func guestpolicyClicked(_ sender: Any)
    {
        //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        
        CustomFunctions.shared.showPDFWith(url: self.policyURL ?? "", title: self.PDFTitle ?? "", navigationController: self.navigationController)
        
        //old Logic
        /*
        if let guestPolicy = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "GuestCardPolicyVC") as? GuestCardPolicyVC {
            guestPolicy.modalPresentationStyle = .fullScreen
            self.appDelegate.hideIndicator()

            self.present(guestPolicy, animated: true, completion: nil)
            
           // self.navigationController?.present(addNewGuestViewController, animated: true, completion: nil)
        }
         */
        //ENGAGE0011898 -- End
    }
    @IBAction func modifyClicked(_ sender: Any) {
        guard let selectedIndexPaths = guestListTableView.indexPathsForSelectedRows,
            selectedIndexPaths.count > 0 else {
                SharedUtlity.sharedHelper().showToast(on: view, withMeassge: self.appDelegate.masterLabeling.gUEST_REQUEST_ERROR ?? "" as String, withDuration: Duration.kShortDuration)
                return
        }
      //  if UserDefaults.standard.string(forKey: UserDefaultsKeys.status.rawValue) == "Active" {
            
            var selectedGuests: [Guest] = []
            for indexPath in selectedIndexPaths {
                selectedGuests.append(guests[indexPath.row])
            }
            
            if multipleSelectionMode == .RunningGuestCard,
                let ModifyRunningCards = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "ModifyRunningCardsViewController") as? ModifyRunningCardsViewController
            {
                ModifyRunningCards.guests = selectedGuests
                //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
                //ENGAGE0011898 -- Start
                ModifyRunningCards.policyURL = self.policyURL
                ModifyRunningCards.PDFTitle = self.PDFTitle
                //ENGAGE0011898 -- End
                self.navigationController?.pushViewController(ModifyRunningCards, animated: true)
            }
            else if let visitViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "AddVisitViewController") as? AddVisitViewController
            {
                visitViewController.guests = selectedGuests
                visitViewController.isFrom = "Modify"
                visitViewController.isFromSelection = "Multi"
                //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
                //ENGAGE0011898 -- Start
                visitViewController.policyURL = self.policyURL
                visitViewController.PDFTitle = self.PDFTitle
                //ENGAGE0011898 -- End
                
                self.navigationController?.pushViewController(visitViewController, animated: true)
            }
//        }
//        else{
//            SharedUtlity.sharedHelper().showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.guest_suspended_validation1, withDuration: Duration.kShortDuration)
//        }
//
        
    }
    @IBAction func addVisitClicked(_ sender: Any) {
        
        
        guard let selectedIndexPaths = guestListTableView.indexPathsForSelectedRows,
            selectedIndexPaths.count > 0 else {
                SharedUtlity.sharedHelper().showToast(on: view, withMeassge: self.appDelegate.masterLabeling.gUEST_REQUEST_ERROR ?? "" as String, withDuration: Duration.kShortDuration)
                return
        }
//        if UserDefaults.standard.string(forKey: UserDefaultsKeys.status.rawValue) == "Active" {
        
            var selectedGuests: [Guest] = []
            for indexPath in selectedIndexPaths {
                selectedGuests.append(guests[indexPath.row])
            }
            
            if let visitViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "AddVisitViewController") as? AddVisitViewController {
                visitViewController.guests = selectedGuests
                visitViewController.isFrom = "Add Visit"
                visitViewController.isFromSelection = "Multi"
                
                //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
                //ENGAGE0011898 -- Start
                visitViewController.policyURL = self.policyURL
                visitViewController.PDFTitle = self.PDFTitle
                //ENGAGE0011898 -- End
                self.navigationController?.pushViewController(visitViewController, animated: true)
                
            }
//        }
//        else{
//            SharedUtlity.sharedHelper().showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.guest_suspended_validation1, withDuration: Duration.kShortDuration)
//        }
    
    }
    @IBAction func historyClicked(_ sender: Any) {
        
        guard let selectedIndexPaths = guestListTableView.indexPathsForSelectedRows,
            selectedIndexPaths.count > 0 else {
                SharedUtlity.sharedHelper().showToast(on: view, withMeassge: self.appDelegate.masterLabeling.gUEST_REQUEST_ERROR ?? "" as String, withDuration: Duration.kShortDuration)
                return
        }
        
        var selectedGuests: [Guest] = []
        for indexPath in selectedIndexPaths {
            selectedGuests.append(guests[indexPath.row])
        }
        
        if let historyViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController
        {
            historyViewController.guests = selectedGuests
            //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
            //ENGAGE0011898 -- Start
            historyViewController.policyURL = self.policyURL
            historyViewController.PDFTitle = self.PDFTitle
            //ENGAGE0011898 -- End
            self.navigationController?.pushViewController(historyViewController, animated: true)
        }
        
    }
    @IBAction func cancelClicked(_ sender: Any) {
        
        
        //Added on 4th July 2020 V2.2
        //Added roles and privilages changes
        switch self.accessManager.accessPermision(for: .guestCard) {
        case .view:
            
            if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
            {
                SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
            }
            
            return
        default:
            break
        }
        
        
        
        guard let selectedIndexPaths = guestListTableView.indexPathsForSelectedRows,
            selectedIndexPaths.count > 0 else {
                SharedUtlity.sharedHelper().showToast(on: view, withMeassge: self.appDelegate.masterLabeling.gUEST_REQUEST_ERROR ?? "" as String, withDuration: Duration.kShortDuration)
                return
        }
        var selectedGuests: [Guest] = []
        for indexPath in selectedIndexPaths {
            selectedGuests.append(guests[indexPath.row])
        }
        
        if let cancelViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController {
            cancelViewController.guests = selectedGuests
            cancelViewController.cancelFor = .GuestCard
            self.navigationController?.pushViewController(cancelViewController, animated: true)
        }

    }
    @IBAction func onTapAdd(_ sender: UIButton) {
        
//        if UserDefaults.standard.string(forKey: UserDefaultsKeys.status.rawValue) == "Active" {
            let addNewView = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 98))
            
            addNewPopoverTableView = UITableView(frame: CGRect(x: 0, y: 20, width: 180, height: 98))
            addNewPopoverTableView?.dataSource = self
            addNewPopoverTableView?.delegate = self
            addNewPopoverTableView?.bounces = true
            addNewView.addSubview(addNewPopoverTableView!)
            addNewPopover = Popover()
            addNewPopover?.arrowSize = CGSize(width: 28.0, height: 13.0)
            //            let point = CGPoint(x: self.view.bounds.width - 70, y: 135)
            
            let pointt = self.addButton.convert(self.addButton.center , to: appDelegate.window)
            
            let point = CGPoint(x: self.view.bounds.width - 70, y: pointt.y - 25)
            addNewPopover?.show(addNewView, point: point)
            
//        }
//        else{
//            SharedUtlity.sharedHelper().showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.guest_suspended_validation1, withDuration: Duration.kShortDuration)
//        }
    }


@objc func didTapOnHome(sender: UIButton){
    self.navigationController?.popToRootViewController(animated: true)
}
    
@objc func didTapOnFilter(sender: UIButton)
{
    //Added by kiran V3.0 -- ENGAGE0011843 -- Replacing the logic with a function
    //ENGAGE0011843 -- Start
    self.showFilterView()
    /*
    if let filterView = UINib(nibName: "GuestListFilterView", bundle: Bundle.main).instantiate(withOwner: GuestListFilterView.self, options: nil).first as? GuestListFilterView
    {
        
        filterView.isFromGuest = 1
        
        filterView.filter.relation = self.relationFilter
        filterView.filterWith = filterBy
        filterView.filterWithDate = filterByDate
        
        let screenSize = UIScreen.main.bounds
        
        filterView.frame = CGRect(x:4, y: 88, width:screenSize.width - 8, height:290)


        filterPopover = Popover()
        filterPopover?.arrowSize = CGSize(width: 28.0, height: 13.0)
        filterPopover?.sideEdge = 4.0
        
        filterView.delegate = self
        
        let point = CGPoint(x: self.view.bounds.width - 35, y: 50)
        filterPopover?.show(filterView, point: point)
        
    }*/
    //ENGAGE0011843 -- End
    
    
}
    
    @IBAction func onTapEdit(_ sender: UIButton)
    {
        
        getGuestList(strSearch: "")
       self.navigationRightBar()

        self.bottomView.isHidden = false

        enableSelectionMode = true
        self.topView.isHidden = true
        searchBarHeightConstraint.constant = 0
        bottomViewHeight.constant = 136
        guestListTableView.reloadData()
        multipleSelectionMode = .None
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 1338"), style: .plain, target: self, action: #selector(onTapCancel))
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.onTapCancel))
        //ENGAGE0011297 -- End
       
    }
    
    func navigationRightBar() {
        let filter = UIButton(type: .custom)
        filter.setImage(UIImage(named: "Filter"), for: .normal)
        filter.frame = CGRect(x: 0, y: 0, width: 25, height: 30)
        // btn1.addTarget(self, action: Selector(("didTapEditButton:")), for: .touchUpInside)
        filter.addTarget(self, action:#selector(self.didTapOnFilter), for: .touchUpInside)
        
        let itemFilter = UIBarButtonItem(customView: filter)
        
        let home = UIButton(type: .custom)
        home.setImage(UIImage(named: "Path 398"), for: .normal)
        home.frame = CGRect(x: 0, y: 0, width: 25, height: 30)
        //btn2.addTarget(self, action: Selector(("didTapSearchButton:")), for: .touchUpInside)
        home.addTarget(self, action:#selector(self.didTapOnHome), for: .touchUpInside)
        
        let itemHome = UIBarButtonItem(customView: home)
        self.navigationItem.setRightBarButtonItems([itemHome,itemFilter], animated: true)
    }
    
    @objc func onTapCancel() {
        searchBar.text = ""
        getGuestList(strSearch: "")
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        //navigationItem.leftBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
        
        searchBarHeightConstraint.constant = 75.0
        self.topView.isHidden = false

        enableSelectionMode = false
        guestListTableView.reloadData()
        bottomViewHeight.constant = 0
        self.bottomView.isHidden = true

        multipleSelectionArray = []
        
        let filter = UIButton(type: .custom)
        filter.setImage(UIImage(named: "Filter"), for: .normal)
        filter.frame = CGRect(x: 0, y: 0, width: 25, height: 30)
        // btn1.addTarget(self, action: Selector(("didTapEditButton:")), for: .touchUpInside)
        filter.addTarget(self, action:#selector(self.didTapOnFilter), for: .touchUpInside)
        
        let itemFilter = UIBarButtonItem(customView: filter)
        
        let home = UIButton(type: .custom)
        home.setImage(UIImage(named: ""), for: .normal)
        home.frame = CGRect(x: 0, y: 0, width: 25, height: 30)
        //btn2.addTarget(self, action: Selector(("didTapSearchButton:")), for: .touchUpInside)
        home.addTarget(self, action:#selector(self.didTapOnHome), for: .touchUpInside)
        
        let itemHome = UIBarButtonItem(customView: home)
        self.navigationItem.setRightBarButtonItems([itemFilter,itemHome], animated: true)

    }
    
    @objc func onTapFilter()
    {
        //Added by kiran V3.0 -- ENGAGE0011843 -- Replacing the logic with a function
        //ENGAGE0011843 -- Start
        
        self.showFilterView()
        /*
        if let filterView = UINib(nibName: "GuestListFilterView", bundle: Bundle.main).instantiate(withOwner: GuestListFilterView.self, options: nil).first as? GuestListFilterView
        {
            
            
            let screenSize = UIScreen.main.bounds
            

            filterView.isFromGuest = 1
            filterView.filterWith = filterBy
            filterView.filterWithDate = filterByDate

            filterPopover = Popover()
            
            filterView.frame = CGRect(x:4, y: 88, width:screenSize.width - 8, height:290)

            filterPopover?.arrowSize = CGSize(width: 28.0, height: 13.0)
            filterPopover?.sideEdge = 4.0

            filterView.delegate = self
            
            let point = CGPoint(x: self.view.bounds.width - 35, y: 50)
            filterPopover?.show(filterView, point: point)
        } */
        //ENGAGE0011843 -- End
 
    }
}

//Added by kiran V3.0 -- ENGAGE0011843 -- Filter change
//ENGAGE0011843 -- Start
//MARK:- Custom Functions
extension GuestCardsViewController
{
    private func showFilterView()
    {
        guard let filterView = UINib(nibName: "GuestListFilterView", bundle: Bundle.main).instantiate(withOwner: GuestListFilterView.self, options: nil).first as? GuestListFilterView else
        {
            return
        }
        
        let screenSize = UIScreen.main.bounds
        filterView.frame = CGRect(x:4, y: 88, width:screenSize.width - 8, height:290)
        
        filterPopover = Popover()
        filterPopover?.arrowSize = CGSize(width: 28.0, height: 13.0)
        filterPopover?.sideEdge = 4.0
        
        filterView.isFromGuest = 1
        filterView.filter.relation = self.relationFilter ?? (self.appDelegate.arrRelationFilter.first ?? RelationFilter())
        filterView.filterWithDate = filterByDate
        filterView.delegate = self
        
        let point = CGPoint(x: self.view.bounds.width - 35, y: 50)
        filterPopover?.show(filterView, point: point)
    }
    
}

private extension GuestCardsViewController {
    func guestCardMode(guestCard: Guest) -> GuestCardMode {
        let dateFormator = SharedUtlity.sharedHelper().dateFormatter
        let fromDate = dateFormator?.date(from: guestCard.fromDate)
        let toDate = dateFormator?.date(from: guestCard.toDate)
//        if let fromDate = fromDate,
//            let _ = toDate {
        print(multipleSelectionMode)
        if isFrom == "SingleSelection" || isFrom == "MultiSingleSelection" {
            if fromDate == nil {
                multipleSelectionArray.append("NewOrExpireGuestCard")

                return .NewOrExpireGuestCard
            }
            // else{
            if fromDate! > Date(){
                multipleSelectionArray.append("FutureGuestCard")

                return .FutureGuestCard
            } else {
                multipleSelectionArray.append("RunningGuestCard")
                currentFromDatesArray.append((dateFormator?.string(from: fromDate!))!)
                currentToDatesArray.append((dateFormator?.string(from: toDate!))!)

                return .RunningGuestCard
            }
        }
        else{
            if fromDate == nil {
                if isFrom == "MultiDeSelection"{
                    if let index = multipleSelectionArray.index(of: "NewOrExpireGuestCard") {
                        multipleSelectionArray.remove(at: index)
                    }
                }
                else{
                    multipleSelectionArray.append("NewOrExpireGuestCard")
                    }
                }
             else{
                if fromDate! > Date(){
                    if isFrom == "MultiDeSelection"{
                        if let index = multipleSelectionArray.index(of: "FutureGuestCard") {
                            multipleSelectionArray.remove(at: index)
                        }
                    }
                else{
                        multipleSelectionArray.append("FutureGuestCard")
                    }
                } else {
                    if isFrom == "MultiDeSelection"{
                        if let index = multipleSelectionArray.index(of: "RunningGuestCard") {
                            multipleSelectionArray.remove(at: index)
                        }
                        if let index = currentFromDatesArray.index(of: (dateFormator?.string(from: fromDate!))!) {
                            currentFromDatesArray.remove(at: index)
                        }
                        if let index = currentToDatesArray.index(of: (dateFormator?.string(from: toDate!))!) {
                            currentToDatesArray.remove(at: index)
                        }
                        
                    }
                    else{
                        multipleSelectionArray.append("RunningGuestCard")
                        currentFromDatesArray.append((dateFormator?.string(from: fromDate!))!)
                        currentToDatesArray.append((dateFormator?.string(from: toDate!))!)
                        }
            }
              }
            if (multipleSelectionArray.contains("FutureGuestCard") && multipleSelectionArray.contains("RunningGuestCard")) || (multipleSelectionArray.contains("NewOrExpireGuestCard") && multipleSelectionArray.contains("RunningGuestCard")) {
                btnAddVisit.isEnabled = true
                btnModify.isEnabled = false
                btnCancel.isEnabled = false
                btnHistory.isEnabled = true
                return .NewOrExpireGuestCard
            }
            else if multipleSelectionArray.contains("FutureGuestCard") || (multipleSelectionArray.contains("NewOrExpireGuestCard") && multipleSelectionArray.contains("FutureGuestCard")) {
                btnAddVisit.isEnabled = true
                btnModify.isEnabled = true
                btnCancel.isEnabled = true
                btnHistory.isEnabled = true
                return .FutureGuestCard
                }
            else if multipleSelectionArray.contains("RunningGuestCard"){
                
                let allFromDatesEqual = currentFromDatesArray.dropLast().allSatisfy { $0 == currentFromDatesArray.last }
                let allToDatesEqual = currentToDatesArray.dropLast().allSatisfy { $0 == currentToDatesArray.last }
                
                if allFromDatesEqual == true && allToDatesEqual == true {
                    btnAddVisit.isEnabled = true
                    btnModify.isEnabled = true
                    btnCancel.isEnabled = false
                    btnHistory.isEnabled = true                }
                else{
                    btnAddVisit.isEnabled = true
                    btnModify.isEnabled = false
                    btnCancel.isEnabled = false
                    btnHistory.isEnabled = true
                }

                
                return .RunningGuestCard
                }
            else if multipleSelectionArray.contains("NewOrExpireGuestCard"){
                btnAddVisit.isEnabled = true
                btnModify.isEnabled = false
                btnCancel.isEnabled = false
                btnHistory.isEnabled = true
                return .RunningGuestCard
            }
            else{
                btnAddVisit.isEnabled = true
                btnModify.isEnabled = true
                btnCancel.isEnabled = true
                btnHistory.isEnabled = true
                return .FutureGuestCard
                }
        }
  
    }
    
    func getSelectedGuests() -> [Guest] {
        var targetGuests: [Guest] = []
        if let indexPaths = guestListTableView.indexPathsForSelectedRows {
            for index in indexPaths {
                targetGuests.append(guests[index.row])
            }
        }
        return targetGuests
    }
    //MARK:- Get Guest List  Api

    func getGuestList(strSearch :String?, filter: GuestCardFilter? = nil){
        
        //Added by kiran V3.0 -- ENGAGE0011843 -- Filter changes.
        //ENGAGE0011843 -- Start
        self.relationFilter = filter?.relation
        
        //Old
        //filterBy = filter?.relation.displayName()
        //ENGAGE0011843 -- End
        filterByDate = filter?.date.displayName()
        
        if (Network.reachability?.isReachable) == true{
            
            let paramaterDict:[String: Any] = [
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "" ,
                APIKeys.ksearchby: strSearch ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                //Added by kiran V3.0 -- ENGAGE0011843 -- Filter changes.
                //ENGAGE0011843 -- Start
                "RelationFilter" : self.relationFilter?.relationID ?? "",
                //"RelationFilter" : filter?.relation.value() ?? "",
                //ENGAGE0011843 -- End
                "NameFilter" : "",
                "DateSort" : filter?.date.value() ?? ""

            ]
            
            print(paramaterDict)
            APIHandler.sharedInstance.getMyGuestList(paramater: paramaterDict , onSuccess: { guestLists in
               // self.appDelegate.hideIndicator()
                
                if(guestLists.responseCode == InternetMessge.kSuccess){
                    if(guestLists.guests.isEmpty){
//                        self.appDelegate.hideIndicator()
                        
                        self.guests.removeAll()
                        self.guestDropDown.removeAll()
                        self.guestListTableView.setEmptyMessage(InternetMessge.kNoData)
                        self.guestListTableView.reloadData()
                        self.appDelegate.hideIndicator()
                        
                    } else {
                            self.guestListTableView.restore()
//                            self.dictguest = guestLists
                            self.guests.removeAll()
                            self.guestDropDown.removeAll()
                            self.guestDropDown = guestLists.guestDropDown
                            self.guests = guestLists.guests
                            self.guestListTableView.reloadData()
                            self.appDelegate.hideIndicator()
                            
                        }
                } else {
                    self.appDelegate.hideIndicator()
                    self.guests.removeAll()
                    self.guestListTableView.reloadData()
//                    self.refreshControl.endRefreshing()
                    //                    SharedUtlity.sharedHelper().showToast(on:
                    //                        self.view, withMeassge: guestLists.responseMessage, withDuration: Duration.kMediumDuration)
                    
                    self.guestListTableView.setEmptyMessage(guestLists.responseMessage )
                    
                }
              //  self.appDelegate.hideIndicator()
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
            
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            
            //  self.tblGuestListViews.setEmptyMessage(InternetMessge.kInternet_not_available)
            
        }
        
    }
    
    //MARK:- Mobile Config API
    //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
    //ENGAGE0011898 -- Start
    private func getGuestPolicyURL()
    {
        guard Network.reachability?.isReachable == true else {
            CustomFunctions.shared.showToast(WithMessage: InternetMessge.kInternet_not_available, on: self.view)
            return
        }
        
        CustomFunctions.shared.showActivityIndicator(withTitle: "", intoView: self.view)
        let paramaterDict:[String: Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "" ,
            APIKeys.kCategory: self.appDelegate.masterLabeling.guestCardPolicy_Category ?? "",
            APIKeys.kSectionName : self.appDelegate.masterLabeling.guestCardPolicy_Section ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict]
        ]
        
        APIHandler.sharedInstance.getMobileConfigurations(paramaterDict: paramaterDict) { mobileConfig in
            
            self.policyURL = mobileConfig?.filePath
            
            CustomFunctions.shared.hideActivityIndicator()
        } onFailure: { error in
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
            CustomFunctions.shared.hideActivityIndicator()
        }

    }
    //ENGAGE0011898 -- End
    
    func showEditOptionsForGuest(guest: Guest) {
        isFrom = "SingleSelection"
        self.selectedGuest = guest
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let mode = self.guestCardMode(guestCard: self.selectedGuest!)

        actionSheet.view.tintColor = hexStringToUIColor(hex: "40B2E6")
        
        let modifyVisitAction = UIAlertAction(title: self.appDelegate.masterLabeling.modify_Visit,
                                              style: .default) { (action) in
                                                let mode = self.guestCardMode(guestCard: self.selectedGuest!)
                                                
//                                                if UserDefaults.standard.string(forKey: UserDefaultsKeys.status.rawValue) == "Active" {
                                                
                                                    if mode == .None ||
                                                        mode == .NewOrExpireGuestCard {
                                        
                                                    }
                                                    else if mode == .FutureGuestCard {
                                                        
                                                        
                                                        if let visitViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "AddVisitViewController") as? AddVisitViewController {
                                                            visitViewController.guests = [guest]
                                                            visitViewController.isFrom = "Modify"
                                                            visitViewController.isFromSelection = "Single"
                                                            //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
                                                            //ENGAGE0011898 -- Start
                                                            visitViewController.policyURL = self.policyURL
                                                            visitViewController.PDFTitle = self.PDFTitle
                                                            //ENGAGE0011898 -- End
                                                            
                                                            self.navigationController?.pushViewController(visitViewController, animated: true)
                                                        }
                                                    }
                                                        
                                                    else{
                                                        if let ModifyRunningCards = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "ModifyRunningCardsViewController") as? ModifyRunningCardsViewController {
                                                            ModifyRunningCards.guests = [guest]
                                                            //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
                                                            //ENGAGE0011898 -- Start
                                                            ModifyRunningCards.policyURL = self.policyURL
                                                            ModifyRunningCards.PDFTitle = self.PDFTitle
                                                            //ENGAGE0011898 -- End
                                                            
                                                            self.navigationController?.pushViewController(ModifyRunningCards, animated: true)
                                                        }
                                                    }
//                                                }
//                                                else{
//                                                    SharedUtlity.sharedHelper().showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.guest_suspended_validation1, withDuration: Duration.kShortDuration)
//
//                                                }
        }
        
        let addVisitAction = UIAlertAction(title: self.appDelegate.masterLabeling.add_Visit,
                                           style: .default) { (action) in
                                            
                                   
//                                            if UserDefaults.standard.string(forKey: UserDefaultsKeys.status.rawValue) == "Active" {
                                            
                                                if let visitViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "AddVisitViewController") as? AddVisitViewController {
                                                    visitViewController.guests = [guest]
                                                    visitViewController.isFrom = "Add Visit"
                                                    visitViewController.isFromSelection = "Single"
                                                    //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
                                                    //ENGAGE0011898 -- Start
                                                    visitViewController.policyURL = self.policyURL
                                                    visitViewController.PDFTitle = self.PDFTitle
                                                    //ENGAGE0011898 -- End
                                                    
                                                    self.navigationController?.pushViewController(visitViewController, animated: true)
                                                }
//                                            }
//                                            else{
//                                                SharedUtlity.sharedHelper().showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.guest_suspended_validation1, withDuration: Duration.kShortDuration)
//                                                
//                                            }
        }
        let historyAction = UIAlertAction(title: self.appDelegate.masterLabeling.history,
                                          style: .default) { (action) in
                                            self.bottomView.isHidden = true

                                            let mode = self.guestCardMode(guestCard: self.selectedGuest!)
                                            
                                            if mode == .NewOrExpireGuestCard {
                                                
                                            }
                                            
                                            
                                            if let historyViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController {
                                                historyViewController.guests = [guest]
                                                //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
                                                //ENGAGE0011898 -- Start
                                                historyViewController.policyURL = self.policyURL
                                                historyViewController.PDFTitle = self.PDFTitle
                                                //ENGAGE0011898 -- End
                                                self.navigationController?.pushViewController(historyViewController, animated: true)
                                            }

        }
        
        let cancelVisitAction = UIAlertAction(title: self.appDelegate.masterLabeling.cancel_Card,
                                              style: .default) { (action) in
                                                
                                                //Added on 4th July 2020 V2.2
                                                //Added roles adn privilages changes
                                                switch self.accessManager.accessPermision(for: .guestCard) {
                                                case .view:
                                                    
                                                    if let message = self.appDelegate.masterLabeling.role_Validation1 , message.count > 0
                                                    {
                                                        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                                                    }
                                                    
                                                    return
                                                default:
                                                    break
                                                }
                                                self.bottomView.isHidden = true

                                                let mode = self.guestCardMode(guestCard: self.selectedGuest!)
                                                
                                                if mode == .None ||
                                                    mode == .NewOrExpireGuestCard ||  mode == .RunningGuestCard {
                                                    return
                                                }
                                                
                                                if let cancelViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "CancelPopUpViewController") as? CancelPopUpViewController {
                                                    cancelViewController.guests = [guest]
                                                    cancelViewController.cancelFor = .GuestCard
                                                    self.navigationController?.pushViewController(cancelViewController, animated: true)
                                                }
                                                

        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        if mode == .FutureGuestCard {

        }
        else if mode == .None || mode == .NewOrExpireGuestCard{
            if cancelVisitAction.title == "Cancel Card" || modifyVisitAction.title == "Modify Visit"{
                cancelVisitAction.setValue(UIColor.lightGray, forKey: "titleTextColor")
               // alert.view.superview.subviews[0] isUserInteractionEnabled = false
                cancelVisitAction.isEnabled = false
                modifyVisitAction.isEnabled = false
            }
        }
        else if mode == .RunningGuestCard{

            if cancelVisitAction.title == "Cancel Card"{
                cancelVisitAction.setValue(UIColor.lightGray, forKey: "titleTextColor")
                cancelVisitAction.isEnabled = false

            }
            
        }
        else{

        }
       

        actionSheet.addAction(modifyVisitAction)
        actionSheet.addAction(addVisitAction)
        actionSheet.addAction(historyAction)
        actionSheet.addAction(cancelVisitAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    func showConformationAlert(title: String?, message: String?, yes:@escaping() -> Void, no:@escaping() -> Void) {
        let conformationAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            yes()
        }
        let noAction = UIAlertAction(title: "No", style: .cancel) { (action) in
            no()
        }
        conformationAlert.addAction(yesAction)
        conformationAlert.addAction(noAction)
        present(conformationAlert, animated: true, completion: nil)
    }
}

extension GuestCardsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == addNewPopoverTableView {
            return  2
        } else {
            return guests.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == addNewPopoverTableView {
            let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 150, height: 34))
            cell.selectionStyle = .none
            cell.textLabel?.font = SFont.SourceSansPro_Regular18
                if indexPath.row == 0 {
                    cell.textLabel?.text = self.appDelegate.masterLabeling.new_Guest_Card ?? "" as String
                } else {
                    cell.textLabel?.text = self.appDelegate.masterLabeling.New_Visit ?? "" as String
                }
            tableView.separatorStyle = .none
            
            let shapeLayer:CAShapeLayer = CAShapeLayer()
            let frameSize = cell.frame.size
            let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: 0)
            
            shapeLayer.bounds = shapeRect
            shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height)
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = UIColor.darkGray.cgColor
           // shapeLayer.lineWidth = 1.0
            shapeLayer.lineDashPhase = 3.0 // Add "lineDashPhase" property to CAShapeLayer

            shapeLayer.lineJoin = kCALineJoinRound
            shapeLayer.lineDashPattern = [1,4]
            

            shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 15, y: shapeRect.height + 4, width: 140, height: 0), cornerRadius: 0).cgPath

            cell.layer.addSublayer(shapeLayer)
            
            return cell
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? GuestCardTableViewCell {
                
                cell.guest = guests[indexPath.row]
                cell.editMode = enableSelectionMode
               
                return cell
            }
            return UITableViewCell()
        }
    }
}

extension GuestCardsViewController : UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == addNewPopoverTableView {
            addNewPopover?.dismiss()
            if indexPath.row == 0 {
                if let addNewGuestViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "AddNewGuestViewController") as? AddNewGuestViewController
                {
                    //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
                    //ENGAGE0011898 -- Start
                    addNewGuestViewController.policyURL = self.policyURL
                    addNewGuestViewController.PDFTitle = self.PDFTitle
                    //ENGAGE0011898 -- End
                    navigationController?.pushViewController(addNewGuestViewController, animated: true)
                }
            } else {
                if let newVisitViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "NewVisitViewController") as? NewVisitViewController
                {
                    newVisitViewController.guests = guestDropDown
                    //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
                    //ENGAGE0011898 -- Start
                    newVisitViewController.policyURL = self.policyURL
                    newVisitViewController.PDFTitle = self.PDFTitle
                    //ENGAGE0011898 -- End
                    navigationController?.pushViewController(newVisitViewController, animated: true)
                }
            }
        } else {
            if let cell = tableView.cellForRow(at: indexPath) as? GuestCardTableViewCell,
                let guest = cell.guest {
                if enableSelectionMode == false {
                    tableView.deselectRow(at: indexPath, animated: false)
                    showEditOptionsForGuest(guest: guest)
                    print("You tapped cell number \(guests[indexPath.row]).")
                } else {
                    isFrom = "MultiSelection"
                    switch multipleSelectionMode {
                    case .None:
                        isFrom = "MultiSingleSelection"
                        multipleSelectionMode = guestCardMode(guestCard: guest)
                        break
                    case .RunningGuestCard:
                        if guestCardMode(guestCard: guest) != .RunningGuestCard {
                        }
                        
                        break
                    case .FutureGuestCard:
                        if guestCardMode(guestCard: guest) != .FutureGuestCard {
                        }
                        break
                    case .NewOrExpireGuestCard:
                        if guestCardMode(guestCard: guest) != .NewOrExpireGuestCard {
                        }
                        
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == guestListTableView,
            enableSelectionMode == true {
             if let cell = tableView.cellForRow(at: indexPath) as? GuestCardTableViewCell,
            let guest = cell.guest {

            if tableView.indexPathsForSelectedRows?.count == nil {
                multipleSelectionMode = .None
                multipleSelectionArray.removeAll()
            }
            else{
                if multipleSelectionArray.count == 1
                {
                    multipleSelectionArray.removeAll()
                }
                isFrom = "MultiDeSelection"
                switch multipleSelectionMode {
                case .None:
                    multipleSelectionMode = guestCardMode(guestCard: guest)
                    break
                case .RunningGuestCard:
                    if guestCardMode(guestCard: guest) != .RunningGuestCard {
                      
                    }
                    break
                case .FutureGuestCard:
                    if guestCardMode(guestCard: guest) != .FutureGuestCard {
                    }
                    break
                case .NewOrExpireGuestCard:
                    if guestCardMode(guestCard: guest) != .NewOrExpireGuestCard {
                    }
                }
                }
            }
            }
        }
    }


extension GuestCardsViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        getGuestList(strSearch: searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            
            getGuestList(strSearch: searchBar.text)

        }
    }
        
}

extension GuestCardsViewController : GuestListFilterViewDelegate {
    func guestCardFilterApply(filter: GuestCardFilter) {
        getGuestList(strSearch: searchBar.text, filter: filter)
        filterPopover?.dismiss()
    }
    
    func guestCardFilterClose() {
        filterPopover?.dismiss()
    }
    
    
}



