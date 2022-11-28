//
//  DiningReservationVC.swift
//  CSSI
//
//  Created by Aks on 03/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
import DTCalendarView
import FSCalendar



class DiningReservationVC: UIViewController, UITableViewDelegate,UITableViewDataSource, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, selectedPartySizeTime, dateSelection, DiningTimeSlotsDelegate {
   
//MARK:- Iboutlets
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var tblResturat: UITableView!
    @IBOutlet weak var lblSelectedDate: UILabel!
    @IBOutlet weak var btnSelectedDate: UIButton!
    @IBOutlet weak var viewPrevious: UIView!
    @IBOutlet weak var viewNext: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnPartySize: UIButton!
    @IBOutlet weak var lblSelectedSizeTime: UILabel!
    @IBOutlet weak var lblDatePartySize: UILabel!
    @IBOutlet weak var lblLoggedInuserInfo: UILabel!
    @IBOutlet weak var lblDiningHeading: UILabel!
    @IBOutlet weak var lblNext: UILabel!
    @IBOutlet weak var lblPrevious: UILabel!
    @IBOutlet weak var btnDinningPolicy: UIButton!
    @IBOutlet weak var lblTorequestRestaurantTime: UILabel!

    //MARK:- variables
    var showNavigationBar = true
    var myCalendar: FSCalendar!
    var currentDate = Date()
    var diningReservation = DinningReservationFCFS.init()
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var restaurantsList: [DiningRestaurantsData] = []
    var diningSetting = DiningSettingData.init()
    var enumForDinningMode : dinningMode = .create
    var requestedId : String?
    var isInitial = true
    var diningPolicyURL = ""
    var reservationDate = ""
    var reservationTime = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUiInitialization()

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = !self.showNavigationBar
    }
    
    //MARK: - setUpUI
    func setUpUi(){
        
        shadowView(viewName: viewTime)
        shadowView(viewName: viewPrevious)
        shadowView(viewName: viewDate)
        shadowView(viewName: viewNext)
        btnSelectedDate.setTitle("", for: .normal)
        btnBack.setTitle("", for: .normal)
        btnHome.setTitle("", for: .normal)
        btnPartySize.setTitle("", for: .normal)
        
        if enumForDinningMode == .create{
           
            lblDiningHeading.text =  self.appDelegate.masterLabeling.DINING_FCFS_TITLE ?? ""
            reservationList()
        } else {
            if enumForDinningMode == .modify{
                lblDiningHeading.text = "Modify Reservation"
            }
            else if enumForDinningMode == .view{
                lblDiningHeading.text = self.appDelegate.masterLabeling.DINING_FCFS_TITLE ?? ""
//                tblResturat.isUserInteractionEnabled = false
                viewTime.isUserInteractionEnabled = false
                btnNext.isUserInteractionEnabled = false
                btnPrevious.isUserInteractionEnabled = false
                btnSelectedDate.isUserInteractionEnabled = false
            }
            reservationListModifyView()
        }
        self.lblLoggedInuserInfo.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)
        lblNext.text = self.appDelegate.masterLabeling.DINING_FCFS_NEXT_DATE ?? ""
        lblPrevious.text = self.appDelegate.masterLabeling.tAB_PREVIOUS ?? ""
        btnDinningPolicy.setTitle(self.appDelegate.masterLabeling.dining_policy ?? "", for: .normal)
        lblTorequestRestaurantTime.text = self.appDelegate.masterLabeling.DINING_FCFS_DININGINFOONE ?? ""
    }
    
    func setUpUiInitialization(){
        tblResturat.delegate = self
        tblResturat.dataSource  = self
        registerNibs()
        setUpUi()
    }
    
    func updateUI() {

        self.diningReservation.SelectedTime = getTimeString(givenDate: currentDate)
        self.assigenSelectdSizeTimeDetails(dayOfWeek: getDayOfWeek(givenDate: currentDate))
        self.assigenDatePartySizeDetails(yearOfMonth: getDateDinning(givenDate: currentDate))
        self.assigenSelectedDate()
        self.diningReservation.SelectedDate = getDateStringFromDate(givenDate: currentDate)
        self.tblResturat.reloadData()
    }
    
    //MARK: - Xib Registration
    func registerNibs(){
        let homeNib = UINib(nibName: "DiningResvTableCell" , bundle: nil)
        self.tblResturat.register(homeNib, forCellReuseIdentifier: "DiningResvTableCell")
    }

    //MARK: - IBActions
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSelectPartySize(_ sender: Any) {
        let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "PartySizePopUpVC") as? PartySizePopUpVC
        vc?.delegateSelectedTimePatySize = self
        vc?.maxPartySize = self.diningSetting.MaxPartySize
        vc?.minimumDaysInAdvance = self.diningSetting.MinDaysInAdvance
        vc?.maximumDaysInAdvance = self.diningSetting.MaxDaysInAdvance
        vc?.selectedPartySize = self.diningReservation.PartySize
        vc?.selectedDate = currentDate
        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func btnHome(_ sender: Any) {
//        let homeVC = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
//        self.navigationController?.pushViewController(homeVC, animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func selectDateBtnTapped(sender:UIButton){
        let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DiningRequestSelectResturantDateVC") as? DiningRequestSelectResturantDateVC
        vc?.delegateSelectedDateCalendar = self
        vc?.minDaysInAdvance = self.diningSetting.MinDaysInAdvance
        vc?.maxDaysInAdvance = self.diningSetting.MaxDaysInAdvance
        vc?.selectedDate = currentDate
        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func btnNextPrevious(_ sender: UIButton) {
        if sender.tag == 1{
            if getDateDinning(givenDate: currentDate) == getDateDinning(givenDate: Date()) {
                return
            }
            let daysDifference = Calendar.current.dateComponents([.day], from: Date(), to: currentDate).day ?? 0
            if daysDifference >= self.diningSetting.MinDaysInAdvance {
                currentDate = Calendar.current.date(byAdding: .weekday , value: -1, to: currentDate)!
                updateUI()
                reservationList()
            }
        }
        else{
            if getDateDinning(givenDate: currentDate) == getDateDinning(givenDate: Calendar.current.date(byAdding: .weekday, value: self.diningSetting.MaxDaysInAdvance, to: Date())!) {
                return
            }
            let daysDifference = Calendar.current.dateComponents([.day], from: Date(), to: currentDate).day ?? 0
            if daysDifference < self.diningSetting.MaxDaysInAdvance {
                currentDate = Calendar.current.date(byAdding: .weekday, value: 1, to: currentDate)!
                updateUI()
                reservationList()
            }
        }
    }
    @IBAction func dinningClicked(_ sender: Any) {
        
        let restarantpdfDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
        restarantpdfDetailsVC.pdfUrl = self.diningPolicyURL
        restarantpdfDetailsVC.restarantName = self.appDelegate.masterLabeling.dining_policy!

        self.navigationController?.pushViewController(restarantpdfDetailsVC, animated: true)
    }
    
    //MARK: - Functions
    func shadowView(viewName : UIView){
        viewName.layer.shadowColor = UIColor.black.cgColor
        viewName.layer.shadowOpacity = 0.12
        viewName.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewName.layer.shadowRadius = 6
    }
    
    
    func assigenSelectdSizeTimeDetails(dayOfWeek: String) {
        lblSelectedSizeTime.text = "\(self.diningReservation.PartySize) * \(self.diningReservation.SelectedTime)  \(dayOfWeek)"
    }
    
    func assigenDatePartySizeDetails(yearOfMonth: String) {
        lblDatePartySize.text = "\(self.appDelegate.masterLabeling.DINING_FCFS_SELECTED_DATE ?? ""), \(yearOfMonth) |  \(self.appDelegate.masterLabeling.party_size ?? "") \(self.diningReservation.PartySize) | \(self.appDelegate.masterLabeling.DINING_FCFS_ANYRESTAURANT ?? "")"
    }
    
    func assigenSelectedDate() {
        let dateString = self.getDateString(givenDate: currentDate)
        lblSelectedDate.text = dateString
    }
    
    func getStartAndEndTimeString(timings: [DiningTimmingsData]) -> String{
        var returnString = ""
        
        for i in timings {
            if returnString != "" {
                returnString = returnString + ", "
            }
            returnString = returnString + " " + i.StartTime + " to " + i.EndTime
        }
        
        return returnString
    }
    
    func combainDateTime(dateString: String, timeString: String) {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "YYYY-MM-dd hh:mm a"
        currentDate = inputFormatter.date(from: dateString + " " + timeString)!
    }


    //MARK: - Custom Delgates Functions
    func SelectedPartysizeTme(PartySize: Int, Time: Date) {
        self.diningReservation.PartySize = PartySize
        self.currentDate = Time
        updateUI()
        
        reservationList()
    }
    
    func dateSelection(date: String) {
        let timeString = getTimeString(givenDate: currentDate)
        combainDateTime(dateString: date, timeString: timeString)
        updateUI()
        reservationList()
    }
    

    
    func SelectedDiningTimeSlot(timeSlot: String, row: Int) {
        if enumForDinningMode != .view {
            moveToMemberDetails(timeSlot: timeSlot, row: row)
        } else {
            if self.diningReservation.SelectedTime == timeSlot {
                moveToMemberDetails(timeSlot: timeSlot, row: row)
            }
        }
    }
    
    func moveToMemberDetails(timeSlot: String, row: Int) {
        if diningReservation.PartySize == 0 {
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:"Please select Party Size", withDuration: Duration.kMediumDuration)
        } else {
            let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DinningDetailRestuarantVC") as? DinningDetailRestuarantVC
            vc!.showNavigationBar = false
            vc?.isFrom = self.enumForDinningMode
            self.diningReservation.SelectedTime = timeSlot
            self.diningReservation.RestaurantID = self.restaurantsList[row].RestaurantID
            vc?.diningReservation = self.diningReservation
            vc?.diningPolicyURL = self.diningPolicyURL
            vc?.restaurantName = self.restaurantsList[row].RestaurantName
            vc?.restaurantImage = self.restaurantsList[row].RestaurantImage
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    
    // MARK: - Table Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
        return self.restaurantsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblResturat.dequeueReusableCell(withIdentifier: "DiningResvTableCell", for: indexPath) as! DiningResvTableCell
        let day = getDateTableCell(givenDate: self.currentDate)
        cell.lblPartySize.text = "\(day) - Party Size:\(self.diningReservation.PartySize)"
        cell.timeSlotsDelegate = self
        cell.row = indexPath.row
        cell.timeSlots = self.restaurantsList[indexPath.row].TimeSlots
        cell.lblUpcomingEvent.text = self.restaurantsList[indexPath.row].RestaurantName
        cell.lblTime.text = self.getStartAndEndTimeString(timings: self.restaurantsList[indexPath.row].Timings)
        if self.enumForDinningMode != .create && self.diningReservation.RestaurantID == self.restaurantsList[indexPath.row].RestaurantID && self.diningReservation.SelectedDate == self.reservationDate {
            cell.selectedTimeSlot = self.reservationTime
        } else {
            cell.selectedTimeSlot = ""
        }
        cell.collectionTimeSlot.reloadData()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if enumForDinningMode == .view {
            return
        }
        let dict = restaurantsList[indexPath.row]
        if let impVC = UIStoryboard.init(name: "DiningStoryboard", bundle: .main).instantiateViewController(withIdentifier: "RestaurantSpecificDetailVC") as? RestaurantSpecificDetailVC {
            if self.diningReservation.RestaurantID == self.restaurantsList[indexPath.row].RestaurantID {
                impVC.isSelectedRestaurant = true
            } else {
                impVC.isSelectedRestaurant = false
            }
            self.diningReservation.RestaurantID = dict.RestaurantID
            impVC.diningReservation = self.diningReservation
            impVC.currentDate = self.currentDate
            impVC.dinningPolicy = self.diningPolicyURL
            impVC.restaurantImage = dict.RestaurantImage
            impVC.isFrom = self.enumForDinningMode
            impVC.reservationDate = self.reservationDate
            impVC.reservationTime = self.reservationTime
            self.navigationController?.pushViewController(impVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }

}


// MARK: - API CALLING
extension DiningReservationVC{
    func reservationList(){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            var paramaterDict:[String: Any] = [:]
            
             paramaterDict = [
                "Content-Type":"application/json",
                APIKeys.kPartySize : self.diningReservation.PartySize,
                APIKeys.kFilterDate: self.diningReservation.SelectedDate,
                APIKeys.kFilterTime: self.diningReservation.SelectedTime,
                APIKeys.kCompanyCode: "00"
             ]
            if enumForDinningMode == .view {
                paramaterDict["IsView"] = 1
            } else {
                paramaterDict["IsView"] = 0
            }
//            print(paramaterDict)
            APIHandler.sharedInstance.GetDinningReservation(paramater: paramaterDict, onSuccess: { reservationDinningListing in
                self.appDelegate.hideIndicator()
                if(reservationDinningListing.restaurants.count == 0)
                {
                    self.tblResturat.setEmptyMessage(InternetMessge.kNoRestaurant)
                }
                
                self.restaurantsList = reservationDinningListing.restaurants!
                self.diningSetting = reservationDinningListing.diningSettings!
                
                if self.enumForDinningMode == .create && self.isInitial {
                    self.diningReservation.PartySize = self.diningSetting.DefaultPartySize
                    self.currentDate = Calendar.current.date(byAdding: .day, value: self.diningSetting.MinDaysInAdvance, to: Date())!
                    let inputFormatter = DateFormatter()
                    inputFormatter.dateFormat = "YYYY-MM-dd"
                    let resultString = inputFormatter.string(from: self.currentDate)
                    self.combainDateTime(dateString: resultString, timeString: self.diningSetting.DefaultTime)
                    self.isInitial = false
                }

                self.updateUI()
                
            },onFailure: { error  in
                print(error)
                self.appDelegate.hideIndicator()
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }else{
            self.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
    
    
    func reservationListModifyView(){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            var paramaterDict:[String: Any]?
             paramaterDict = [
                "Content-Type":"application/json",
                APIKeys.kRequestID : self.requestedId ?? ""
             ]
           
            APIHandler.sharedInstance.ModifyMyDinningReservation(paramater: paramaterDict, onSuccess: { reservationDinningListing in
                self.appDelegate.hideIndicator()
                
                self.diningReservation = reservationDinningListing
                self.diningReservation.RequestID = self.requestedId
                self.reservationDate = reservationDinningListing.SelectedDate
                self.reservationTime = reservationDinningListing.SelectedTime
                self.combainDateTime(dateString: self.diningReservation.SelectedDate, timeString: self.diningReservation.SelectedTime)
                print(reservationDinningListing.SelectedTime)
                self.reservationList()
                
            },onFailure: { error  in
                print(error)
                self.appDelegate.hideIndicator()
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }else{
            self.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
}


