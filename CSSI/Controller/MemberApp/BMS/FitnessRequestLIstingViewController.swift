//
//  FitnessRequestLIstingViewController.swift
//  CSSI
//
//  Created by Kiran on 22/05/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit
import Popover

/// This view controller is used for all the fitness appointment screens which show data in a tableview.
///
/// Currently this is being used for Appointemt type screen,Providers Screen and service screen
class FitnessRequestListingViewController: UIViewController
{
    
    @IBOutlet weak var listTableView: UITableView!
    
    var contentType : BMSRequestScreen = .none
    var requestScreenType : RequestScreenType?
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    ///Used or request type only
    private var arrDepartments = [DepartmentDetails]()
    
    //Used for providers type only
    private var arrProviders = [Provider]()
    
    //Used for services type only
    private var arrServices = [Service]()
    
    
    private var popupView : Popover?
    
    private var selectedFilter : SelectedFilter?
    
    //Added on 4th July 2020 V2.2
    private let accessManager = AccessManager.shared
    
    //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
    //GATHER0000700 - Start
    ///Indicates for which department booking is made, like Fitness & Spa or Tennis or etc..,
    var BMSBookingDepartment : BMSDepartment = .none
    //GATHER0000700 - End
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        //        let barbutton = UIBarButtonItem.init(image : UIImage.init(named: "back_btn"), style: .plain, target: self , action: #selector(self.backBtnAction(sender:)))
        //        barbutton.imageInsets = UIEdgeInsets.init(top: 0, left: -6.5, bottom: 0, right: 0)
        //        self.navigationItem.leftBarButtonItem = barbutton
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End

        
        switch self.contentType
        {
        case .departments:
             self.navigationItem.title = self.appDelegate.masterLabeling.FITNESS_SPA
        case .providers:
            
            //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. changing provider listing name suffix according to BMS department
            //GATHER0000700 - Start
            var providerTitleSuffix = ""
            
            switch self.BMSBookingDepartment
            {
            case .fitnessAndSpa:
                providerTitleSuffix = self.appDelegate.masterLabeling.BMS_Providers ?? ""
            case .tennisBookALesson:
                providerTitleSuffix = self.appDelegate.masterLabeling.TL_Providers ?? ""
            //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL profesionsl text
            //GATHER0001167 -- Start
            case .golfBookALesson:
                providerTitleSuffix = self.appDelegate.masterLabeling.BMS_Golf_Professionals ?? ""
            //GATHER0001167 -- End
            case .none:
                break
            }
            self.navigationItem.title = "\(self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "") \(providerTitleSuffix)"
            //self.navigationItem.title = "\(self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "") \(self.appDelegate.masterLabeling.BMS_Providers ?? "")"
            //GATHER0000700 - End
             self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "Filter"), style: .plain, target: self, action: #selector(self.filterBtnClicked(sender:)))
            self.listTableView.reloadData()
        case .services:
            
            //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. changing service listing screen name according to BMS department.
            //GATHER0000700 - Start
            var navTitle = ""
            
            switch self.BMSBookingDepartment
            {
            case .fitnessAndSpa:
                
                //Added by kiran V1.4 -- PROD0000121 -- changed the request key to individual departents keys.
                //PROD0000121 -- Start
                let departmentName = self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? ""
                var departmentRequest = ""
                
                if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Fitness!) == .orderedSame
                {
                    departmentRequest = self.appDelegate.masterLabeling.BMS_Fitness_Request ?? ""
                }
                else if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Spa!) == .orderedSame
                {
                    departmentRequest = self.appDelegate.masterLabeling.BMS_Spa_Request ?? ""
                }
                else if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Salon!) == .orderedSame
                {
                    departmentRequest = self.appDelegate.masterLabeling.BMS_Salon_Request ?? ""
                }
                else
                {
                    departmentRequest = self.appDelegate.masterLabeling.BMS_Request ?? ""
                }
                
                navTitle = "\(self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "") \(departmentRequest)"
                
                //Old logic
                //navTitle = "\(self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "") \(self.appDelegate.masterLabeling.BMS_Request ?? "")"
            
                //PROD0000121 -- End
            
            case .tennisBookALesson:
                
                //Added by kiran V1.4 -- PROD0000121 -- changed the request key to individual departents keys.
                //PROD0000121 -- Start
                navTitle = "\(self.appDelegate.masterLabeling.TL_TennisLesson ?? "") \(self.appDelegate.masterLabeling.BMS_Tennis_Request ?? "")"
                
                //Old logic
                //navTitle = "\(self.appDelegate.masterLabeling.TL_TennisLesson ?? "") \(self.appDelegate.masterLabeling.BMS_Request ?? "")"
            
                //PROD0000121 -- End
            
                //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL title string
                //GATHER0001167 -- Start
            case .golfBookALesson:
                navTitle = "\(self.appDelegate.masterLabeling.BMS_GolfLesson ?? "") \(self.appDelegate.masterLabeling.BMS_Golf_Request ?? "")"
                //GATHER0001167 -- End
            case .none:
                break
            }
            self.navigationItem.title = navTitle
            //self.navigationItem.title = "\(self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "") \(self.appDelegate.masterLabeling.BMS_Request ?? "")"
            //GATHER0000700 - End
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(self.homeBtnClicked(sender:)))
            self.listTableView.reloadData()
        default:
           self.navigationItem.title = ""
        }
       
    }
    
    
    @objc private func homeBtnClicked(sender : UIBarButtonItem)
    {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        //TODO:- Remove after approval
        /*if self.appDelegate.bookingAppointmentDetails.requestScreenType == .request
        {
            switch self.contentType {
            case .departments:
                self.appDelegate.bookingAppointmentDetails.department = nil
            case .services:
                self.appDelegate.bookingAppointmentDetails.service = nil
            case .providers:
                self.appDelegate.bookingAppointmentDetails.provider = nil
            default:
                break
            }
        }*/
        
        if self.appDelegate.bookingAppointmentDetails.requestScreenType == .modify
        {
            self.appDelegate.closeFrom = "BMSFlow"
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func filterBtnClicked(sender : UIBarButtonItem)
    {
        //Modified on 4th August 2020 V2.3
        
        //Need to give padding as the arrow is created inside the bounds of the view,causing the arrow to be hidden by the content view as it overlaps the arrow.
        let arrowPadding : CGFloat = 20
        let width : CGFloat = self.view.frame.width - 8
        //FIXME:- Make this dynamic height
        let height : CGFloat = 230 + arrowPadding
        
        //Created this view to add padding above the filter view (padding in y).
        let adjustmentView = UIView.init(frame: CGRect.init(x: 4, y: 88, width: width, height: height))
        
        let filterView = HorizontalFilterView.init(frame: CGRect.init(x: 0, y: arrowPadding, width: adjustmentView.frame.width, height: adjustmentView.frame.height - arrowPadding))
        adjustmentView.addSubview(filterView)
        adjustmentView.backgroundColor = .clear
        
        filterView.show(filter: Filter.init(type: .Gender, options: self.appDelegate.genderFilterOptions, displayName: self.appDelegate.masterLabeling.BMS_Gender ?? ""))
        filterView.delegate = self
        filterView.selectedFiter = self.selectedFilter
        //filterView.backgroundColor = .clear
        
        //If not called here filter view is not calling layoutsubviews when collection view is reloaded.
        filterView.layoutSubviews()
        
        self.popupView = Popover()
        popupView?.popoverType = .down
        popupView?.arrowSize = CGSize(width: 28.0, height: 13.0)
        popupView?.sideEdge = 4.0
        
        let point = CGPoint(x: self.view.bounds.width - 28, y: 55)
        popupView?.show(adjustmentView, point: point)
        
    }
    
    
}

//MARK:- Custom Methods
extension FitnessRequestListingViewController
{
    private func initialSetup()
    {
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        self.listTableView.tableFooterView = UIView()
        
        self.listTableView.estimatedRowHeight = 50
        self.listTableView.rowHeight = UITableViewAutomaticDimension
        //Modified by kiran V3.2 -- ENGAGE0012667 -- tableview on popup list height fix
        //ENGAGE0012667 -- Start
        if #available(iOS 15.0, *) {
            self.listTableView.sectionHeaderTopPadding = 0
        }
        //ENGAGE0012667 -- End
        //Added on 4th July 2020 V2.2
        //Added roles and privelages changes
        
        //Added by kiran V2.7 -- ENGAGE0011652 -- Added comparisons for department wise showing message in roles and priviliges.
        //ENGAGE0011652 -- Start
        //Shows the toast message if the current screen is the first screen in order. And to support department wise roles and privilages this will show view only access message in the sceond screen of the order and this is only for request scenario.
        if self.appDelegate.BMSOrder.first?.contentType == self.contentType || ((self.appDelegate.BMSOrder[1].contentType == .services || self.appDelegate.BMSOrder[1].contentType == .providers) && self.appDelegate.bookingAppointmentDetails.requestScreenType == .request)
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
                if self.contentType != .departments
                {
                    switch self.accessManager.accessPermissionFor(departmentName: self.appDelegate.bookingAppointmentDetails.department?.departmentName ?? "") {
                    case .view:
                        if let message = self.appDelegate.masterLabeling.role_Validation2 , message.count > 0
                        {
                            SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: message, withDuration: Duration.kMediumDuration)
                        }
                    default:
                        break
                    }
                }
            //ENGAGE0011652 -- End
            case .tennisBookALesson:
                module = .tennisBookALesson
                //Added by kiran V2.9 -- GATHER0001167 -- Golf Bal support for Roles and privilages
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
            if self.contentType == .departments && self.BMSBookingDepartment != .fitnessAndSpa
            {
                switch self.accessManager.accessPermision(for: module /*.fitnessSpaAppointment*/)
                {
                    
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
            
        }
        //ENGAGE0011652 -- End
        
        switch self.contentType
        {
        case .departments:
        
            self.listTableView.separatorStyle = .none
            self.listTableView.contentInset = UIEdgeInsets.init(top: 20, left: 0, bottom: 20, right: 0)
            self.listTableView.register(UINib.init(nibName: "FitnessDepartmentsTableViewCell", bundle: nil), forCellReuseIdentifier: "FitnessDepartmentsTableViewCell")
            self.getDepartmentDetails()
        case .providers:
           
            self.listTableView.separatorColor = hexStringToUIColor(hex: "#CCCBCB")
            self.listTableView.contentInset = UIEdgeInsets.init(top: 11, left: 0, bottom: 11, right: 0)
            self.listTableView.register(UINib.init(nibName: "FitnessProvidersTableViewCell", bundle: nil), forCellReuseIdentifier: "FitnessProvidersTableViewCell")
            self.getProviders()
        case .services:
            
            self.listTableView.separatorStyle = .none
            self.listTableView.estimatedSectionHeaderHeight = 50
            self.listTableView.sectionHeaderHeight = UITableViewAutomaticDimension
            
           self.listTableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 4.5, right: 0)
            self.listTableView.register(UINib.init(nibName: "FitnessRequestTableViewCell", bundle: nil), forCellReuseIdentifier: "FitnessRequestTableViewCell")
            self.getServices()
        default:
          break
        }
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    
    private func navigateToNextScreen()
    {
        //Getting the current index to find the sequence number and then using that sequence number to get next screen
        guard let currentIndex = self.appDelegate.BMSOrder.firstIndex(where: {$0.contentType == self.contentType}) ,let nextScreenIndex = self.appDelegate.BMSOrder.firstIndex(where: {$0.sequenceNo == self.appDelegate.BMSOrder[currentIndex].sequenceNo! + 1}) else {return}
        
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
            
             guard let serviceTypeVC = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "ServiceTypeViewController") as? ServiceTypeViewController else{return}
            //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
            //GATHER0000700 - Start
            serviceTypeVC.BMSBookingDepartment = self.BMSBookingDepartment
            //GATHER0000700 - End
            serviceTypeVC.modalPresentationStyle = .fullScreen
                       
            self.navigationController?.pushViewController(serviceTypeVC, animated: true)
            
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
    
    
    private func getDepartmentDetails()
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
            APIKeys.kAppointmentDetailID : self.appDelegate.bookingAppointmentDetails.appointmentID ?? "",
            //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
            //GATHER0000700 - Start
            APIKeys.kDepartment : self.BMSBookingDepartment.rawValue
            //GATHER0000700 - End
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        APIHandler.sharedInstance.getDepartmentDetails(paramater: paramaterDict, onSuccess: { [weak self] (departments) in
           
            self?.arrDepartments = departments.departmentsDetails ?? [DepartmentDetails]()
            
            if self?.arrDepartments.count ?? 0 == 0
            {
                self?.listTableView.setEmptyMessage(self?.appDelegate.masterLabeling.no_Record_Found ?? "")
                
            }
            self?.listTableView.reloadData()
            
            self?.appDelegate.hideIndicator()
        }) { [weak self] (error) in
            self?.handleRequestError(error: error)
        }
        
        
    }
    
    
    private func getProviders(gender : String = "")
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
            APIKeys.kLocationID: self.appDelegate.bookingAppointmentDetails.department?.locationID ?? "",
            APIKeys.kServiceID: self.appDelegate.bookingAppointmentDetails.service?.serviceID ?? "",
            APIKeys.kProductClassID: self.appDelegate.bookingAppointmentDetails.serviceType?.productClassID ?? "",
            APIKeys.kProviderID: self.appDelegate.bookingAppointmentDetails.provider?.providerID ?? "",
            APIKeys.kGender: gender,
            APIKeys.kAppointmentDetailID : self.appDelegate.bookingAppointmentDetails.appointmentID ?? ""
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        APIHandler.sharedInstance.getProviderDetails(paramater: paramaterDict, onSuccess: { [weak self] (providerDetails) in
            
            self?.arrProviders = providerDetails.providerDetails ?? [Provider]()
            //Added on 4th September 2020 V2.3
            self?.listTableView.setEmptyMessage("")
            
            if providerDetails.isSkip == 1
            {
                if let provider = self?.arrProviders.first
                {
                    self?.appDelegate.bookingAppointmentDetails.provider = provider
                    self?.navigateToNextScreen()
                }
                else
                {
                    self?.listTableView.setEmptyMessage(self?.appDelegate.masterLabeling.no_Record_Found ?? "")
                }
            }
            
            if providerDetails.providerDetails?.count ?? 0 == 0
            {
                self?.listTableView.setEmptyMessage(self?.appDelegate.masterLabeling.no_Record_Found ?? "")
            }
            
            self?.listTableView.reloadData()
            
            self?.appDelegate.hideIndicator()
        }) { [weak self] (error) in
            self?.handleRequestError(error: error)
        }
    }
    
    
    private func getServices()
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
                   APIKeys.kLocationID: self.appDelegate.bookingAppointmentDetails.department?.locationID ?? "",
                   APIKeys.kServiceID: self.appDelegate.bookingAppointmentDetails.service?.serviceID ?? "",
                   APIKeys.kProductClassID: self.appDelegate.bookingAppointmentDetails.serviceType?.productClassID ?? "",
                   APIKeys.kProviderID: self.appDelegate.bookingAppointmentDetails.provider?.providerID ?? "",
                   APIKeys.kAppointmentDetailID : self.appDelegate.bookingAppointmentDetails.appointmentID ?? ""
               ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        APIHandler.sharedInstance.getServiceDetails(paramater: paramaterDict, onSuccess: { [weak self] (serviceDetails) in
            
            self?.arrServices = serviceDetails.serviceDetails ?? [Service]()
            
            if serviceDetails.isSkip == 1
            {
                if let service = self?.arrServices.first
                {
                    //Added by kiran v2.9 -- GATHER0000623 -- Disclaimer set-up by service to prompt based on settings
                    //GATHER0000623 -- Start
                    if (service.disclaimer ?? "").isEmpty
                    {
                        self?.appDelegate.bookingAppointmentDetails.service = service
                        self?.navigateToNextScreen()
                    }
                    else
                    {
                        if let parentVC = self
                        {
                            
                            let okAction = UIAlertAction.init(title: self?.appDelegate.masterLabeling.BMS_Ok ?? "", style: .default) { action in
                                self?.appDelegate.bookingAppointmentDetails.service = service
                                self?.navigateToNextScreen()
                            }
                            
                            CustomFunctions.shared.showAlert(title: self?.appDelegate.masterLabeling.BMS_Disclaimer ?? "", message: service.disclaimer ?? "", on: parentVC, actions: [okAction])
                        }
                       
                    }
                    //GATHER0000623 -- End
                }
                else
                {
                    self?.listTableView.setEmptyMessage(self?.appDelegate.masterLabeling.no_Record_Found ?? "")
                }
            }
            
            if self?.arrServices.count ?? 0 == 0
            {
                self?.listTableView.setEmptyMessage(self?.appDelegate.masterLabeling.no_Record_Found ?? "")
                
            }
            
            self?.listTableView.reloadData()
            
            self?.appDelegate.hideIndicator()
        }) { [weak self] (error) in
            self?.handleRequestError(error: error)
        }
    }
    
    private func handleRequestError(error : Error)
    {
        self.appDelegate.hideIndicator()
        SharedUtlity.sharedHelper().showToast(on:
        self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
    }
}

//MARK:- Table View Delegates
extension FitnessRequestListingViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch self.contentType
        {
        case .departments:
            return self.arrDepartments.count
        case .providers:
            return self.arrProviders.count
        case .services:
            return self.arrServices.count
        default:
          return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        
        switch self.contentType {
        case .services:
            let providerID = self.appDelegate.bookingAppointmentDetails.provider?.providerID
            let serviceType = self.appDelegate.bookingAppointmentDetails.serviceType?.productClass
            
            guard providerID?.count ?? 0 > 0 || serviceType?.count ?? 0 > 0 else{
                return nil
            }
            let view = ProviderDetailsHeaderView.init()
            
            var name : String?
            var type : String?
            
            if providerID == nil || providerID?.count ?? 0 < 1
            {
                name = self.appDelegate.bookingAppointmentDetails.serviceType?.productClass
            }
            else
            {
                name = self.appDelegate.bookingAppointmentDetails.provider?.name
                type = self.appDelegate.bookingAppointmentDetails.serviceType?.productClass
            }
            
            
            //If providervalue exists show provider name or else show service
            view.nameLbl.text = name
            //IF provider is no yet selected then make this empty
            view.typelbl.text = type
            view.nameLbl.textColor = APPColor.textColor.secondary
            view.layoutIfNeeded()
            return view
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch self.contentType
        {
        case .departments:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FitnessDepartmentsTableViewCell") as! FitnessDepartmentsTableViewCell
            
            let departmentDetails = self.arrDepartments[indexPath.row]

            let imageDownloader = ImageDownloadTask()
            imageDownloader.url = departmentDetails.icon3x
            
            cell.contentView.applyShadow(color: hexStringToUIColor(hex: "#00000029"), radius: 3, offset: CGSize.init(width: 0, height: 3), opacity: 0.8)
            
            imageDownloader.startDownload { (imageData, reponse, url) in
                
                if url == departmentDetails.icon3x, let data = imageData
                {
                    DispatchQueue.main.async {
                        cell.departmentImgView.image = UIImage.init(data: data)
                    }
                    
                }
                
            }
            
            cell.nameLbl.text = departmentDetails.departmentName
            
            cell.isSelected = self.appDelegate.bookingAppointmentDetails.department?.locationID == departmentDetails.locationID
            
            return cell
            
        case .providers:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FitnessProvidersTableViewCell") as! FitnessProvidersTableViewCell
            let provider = self.arrProviders[indexPath.row]
            cell.providerNameLbl.text = provider.name
            
            if let profileImage = provider.profileImage , profileImage.count > 0
            {
                let downloadTask = ImageDownloadTask()
                downloadTask.url = profileImage
                downloadTask.startDownload { (data, response, url) in
                    
                    if url == provider.profileImage , let data = data
                    {
                        DispatchQueue.main.async {
                             cell.providerPicImgView.image = UIImage.init(data: data)
                        }
                       
                    }
                    
                }
            }
            
            
            cell.accessoryType = .disclosureIndicator
            cell.separatorInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
            
            if indexPath.row == self.arrProviders.count - 1
            {
                cell.separatorInset = UIEdgeInsets.init(top: 0, left: self.view.frame.width, bottom: 0, right: 0)
            }
            
            return cell
            
        case .services:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FitnessRequestTableViewCell") as! FitnessRequestTableViewCell
            
            let service = self.arrServices[indexPath.row]
            cell.lblRequest.text = service.serviceName
            
            cell.indicatorImgView.image = self.appDelegate.bookingAppointmentDetails.service?.serviceID == service.serviceID ? UIImage
                .init(named: "radio_selected") : UIImage.init(named: "radio_Unselected")
            
            cell.cardView.applyShadow(color: hexStringToUIColor(hex: "#00000029"), radius: 3, offset: CGSize.init(width: 0, height: 3), opacity: 0.8)
            cell.selectionStyle = .none
            return cell
            
        default:
         let cell = UITableViewCell.init(style: .default, reuseIdentifier: "")
          return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.contentType == .providers
        {
            let provider = self.arrProviders[indexPath.row]
            
            cell.setSelected(self.appDelegate.bookingAppointmentDetails.provider?.providerID == provider.providerID, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
     
        //Added on 24th September 2020 V2.3
        var showAlert = false
        var alertMessage = ""
        //Added by kiran v2.9 -- GATHER0000623 -- Disclaimer set-up by service to prompt based on settings
        //GATHER0000623 -- Start
        var alertTitle = ""
        var okTitle = ""
        //GATHER0000623 -- End
        
        switch self.contentType
         {
         case .departments:
            //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
            //GATHER0000700 - Start
            self.appDelegate.bookingAppointmentDetails = BMSAppointmentDetails()
            self.appDelegate.bookingAppointmentDetails.requestScreenType = self.requestScreenType
            self.appDelegate.bookingAppointmentDetails.department = self.arrDepartments[indexPath.row]
             //Note : Removing and adding all the sequences except department(as sequence is only given for screens after the department screen. And department screen sequence is added in fintness and spa screen.) every time department is selected.
            self.appDelegate.BMSOrder.removeAll(where: {$0.contentType != .departments})
            self.appDelegate.BMSOrder.append(contentsOf: self.arrDepartments[indexPath.row].appointmentFlow!)
             
            //Added on 24th September 2020 V2.3
            let department = self.arrDepartments[indexPath.row]
            //Shows Alert when value is 1
            showAlert = department.isShowAppointmentText == 1
            alertMessage = department.appointmentText ?? ""
            
            //Added by kiran v2.9 -- GATHER0000623 -- Assigning the alert and ok button titles
            //GATHER0000623 -- Start
            alertTitle = self.appDelegate.masterLabeling.BMS_AppText_Header ?? ""
            okTitle = self.appDelegate.masterLabeling.OK ?? ""
            //GATHER0000623 -- End
            
         case .services:
            let selectedService =  self.arrServices[indexPath.row]
            self.appDelegate.bookingAppointmentDetails.service = selectedService
            
            //Added by kiran v2.9 -- GATHER0000623 -- Disclaimer set-up by service to prompt based on settings
            //GATHER0000623 -- Start
            showAlert = !(selectedService.disclaimer ?? "").isEmpty
            alertMessage = selectedService.disclaimer ?? ""
            alertTitle = self.appDelegate.masterLabeling.BMS_Disclaimer ?? ""
            okTitle = self.appDelegate.masterLabeling.BMS_Ok ?? ""
            //GATHER0000623 -- End
             
         case .providers:
            
            let selectedProvider = self.arrProviders[indexPath.row]
            self.appDelegate.bookingAppointmentDetails.provider = selectedProvider
            
            //Added on 19th August 2020 V2.3
            if selectedProvider.providerID?.count ?? 0 > 0
            {
                //Necessary to assign empty object instead of nill. when empty dafault option(i.e., ANY) will be selected in request screen. if nil is assigned then in modify scenario no preference gender selected at the time of request is assigned.
                // Used to handle the following scenario
                //When user selects no preference and selects gender in request screen and comes back to provider screen screen and change to a specific provider and comes back provider screen again to change back to no preference then default selection(i.e., ANY) should be selected in request screen.Hence its necessary to assign empty instead of nil.
                self.appDelegate.bookingAppointmentDetails.providerGender = FilterOption()
            }
        
         default:
             break
         }
        
        self.listTableView.reloadData()
        //Added on 24th September 2020 V2.3
        if showAlert
        {
            //Added by kiran v2.9 -- GATHER0000623 -- replaced the titles with variable.
            //GATHER0000623 -- Start
            let alertVC = UIAlertController.init(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            
            let okAction = UIAlertAction.init(title: okTitle, style: .default) { (action) in
                self.navigateToNextScreen()
            }
            //GATHER0000623 -- End
            alertVC.addAction(okAction)
            
            self.present(alertVC, animated: true, completion: nil)

        }
        else
        {
            self.navigateToNextScreen()
        }
       
        
    }
    
}

extension FitnessRequestListingViewController : HorizontalFilterViewDelegate
{
    func closeClicked() {
        self.popupView?.dismiss()
    }
    
    func doneClickedWith(filter: SelectedFilter?)
    {
        self.popupView?.dismiss()
        
        self.selectedFilter = filter
        switch self.contentType {
        case .providers:
            self.getProviders(gender: filter?.option.Id ?? "")
        default:
            break
        }
    }
    
    
}
