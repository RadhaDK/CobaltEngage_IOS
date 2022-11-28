//
//  RestaurantSpecificDetailVC.swift
//  CSSI
//
//  Created by Aks on 11/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class RestaurantSpecificDetailVC: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UITableViewDelegate,UITableViewDataSource, selectedPartySizeTime, DiningTimeSlotsDelegate, dateSelection {
    
    
//MARK: - IButlets
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var lblSelectedDate: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnPartySize: UIButton!
    @IBOutlet weak var btnSelectedDate: UIButton!
    @IBOutlet weak var lblDatePartySize: UILabel!
    @IBOutlet weak var lblSelectedSizeTime: UILabel!
    @IBOutlet weak var imgRestaurent: UIImageView!
    @IBOutlet weak var collectionTimeSlot: UICollectionView!
    @IBOutlet weak var heightTblAvailability: NSLayoutConstraint!
    @IBOutlet weak var tblAvailability: UITableView!
    @IBOutlet weak var imgDrop: UIImageView!
    @IBOutlet weak var btnDropdown: UIButton!
    @IBOutlet weak var viewPrevious: UIView!
    @IBOutlet weak var viewNext: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var lblRestaurentName: UILabel!
    @IBOutlet weak var lblDefaultTime: UILabel!
    @IBOutlet weak var lblAvailablePartySize: UILabel!
    @IBOutlet weak var lblAvailableTime: UILabel!
    @IBOutlet weak var lblRestaurantHeading: UILabel!
    @IBOutlet weak var lblSelectedDateRestaurent: UILabel!
    @IBOutlet weak var lblOtherDates: UILabel!
    @IBOutlet weak var lblNext: UILabel!
    @IBOutlet weak var lblPrevious: UILabel!
    @IBOutlet weak var lblToREquestRestaurent: UILabel!
    @IBOutlet weak var btnDiningPolicy: UIButton!
    
    //MARK: - variables
    var currentDate = Date()
    var dropDownIsOpen = false
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var restaurantImage  = ""
    var diningSetting = DiningSettingData.init()
    var dinningPolicy = ""
    var diningReservation = DinningReservationFCFS.init()
    var isFrom: dinningMode = .create
    var restaurantDetails = GetRestaurantDetailData.init()
    var isSelectedRestaurant = false
    var reservationDate = ""
    var reservationTime = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUiInitialization()
    }
    //MARK: - setUpUI
    func setUpUi(){
        self.btnSelectedDate.setTitle("", for: UIControlState.normal)
        btnBack.setTitle("", for: .normal)
        btnHome.setTitle("", for: .normal)
        btnDropdown.setTitle("", for: .normal)
        btnPartySize.setTitle("", for: .normal)
        
        self.imgRestaurent.image = convertBase64StringToImage(imageBase64String: restaurantImage)
        // Do any additional setup after loading the view.
      
        tblAvailability.isHidden = true
        heightTblAvailability.constant = 0
        imgDrop.image = UIImage(named: "Down Arrow_Icon")
        shadowView(viewName: viewTime)
        shadowView(viewName: viewPrevious)
        shadowView(viewName: viewDate)
        shadowView(viewName: viewNext)
        updateUI()
        restaurentDetail()
        lblRestaurantHeading.text = self.appDelegate.masterLabeling.DINING_FCFS_TITLE ?? ""
        lblSelectedDateRestaurent.text = self.appDelegate.masterLabeling.DINING_FCFS_DININGINFOTWO ?? ""
        lblOtherDates.text = self.appDelegate.masterLabeling.DINING_FCFS_DINING_OTHERDATE ?? ""
        lblNext.text = self.appDelegate.masterLabeling.DINING_FCFS_NEXT_DATE ?? ""
        lblPrevious.text = self.appDelegate.masterLabeling.tAB_PREVIOUS ?? ""
        lblToREquestRestaurent.text = self.appDelegate.masterLabeling.DINING_FCFS_DININGINFOONE ?? ""
        btnDiningPolicy.setTitle("\(self.appDelegate.masterLabeling.dining_policy ?? "")", for: .normal)
    }
    
    func setUpUiInitialization(){
       
        tblAvailability.delegate = self
        tblAvailability.dataSource  = self
        self.collectionTimeSlot.delegate = self
        self.collectionTimeSlot.dataSource = self
        registerNibs()
        setUpUi()
    }
    
    func registerNibs(){
        let menuNib = UINib(nibName: "DinningReservationTimeSlotCollectionCell" , bundle: nil)
        self.collectionTimeSlot.register(menuNib, forCellWithReuseIdentifier: "DinningReservationTimeSlotCollectionCell")
        let homeNib = UINib(nibName: "DiningResvTableCell" , bundle: nil)
        self.tblAvailability.register(homeNib, forCellReuseIdentifier: "DiningResvTableCell")
    }
    
    func updateUI() {

        self.diningReservation.SelectedTime = getTimeString(givenDate: currentDate)
        self.assigenSelectdSizeTimeDetails(dayOfWeek: getDayOfWeek(givenDate: currentDate))
        self.assigenDatePartySizeDetails(yearOfMonth: getDateDinning(givenDate: currentDate))
        self.assigenSelectedDate()
        self.assignAvailablePartySize()
        self.diningReservation.SelectedDate = getDateStringFromDate(givenDate: currentDate)
        self.tblAvailability.reloadData()
    }
    
    func shadowView(viewName : UIView){
        viewName.layer.shadowColor = UIColor.black.cgColor
        viewName.layer.shadowOpacity = 0.12
        viewName.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewName.layer.shadowRadius = 6
    }
    
    // MARK: - IB Actions
    
    @IBAction func btnSelectPartySize(_ sender: Any) {
        if self.self.restaurantDetails.RestaurantSettings != nil {
            let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "PartySizePopUpVC") as? PartySizePopUpVC
            vc?.delegateSelectedTimePatySize = self
            vc?.maxPartySize = self.restaurantDetails.RestaurantSettings.MaxPartySize
            vc?.minimumDaysInAdvance = self.restaurantDetails.RestaurantSettings.MinDaysInAdvance
            vc?.maximumDaysInAdvance = self.restaurantDetails.RestaurantSettings.MaxDaysInAdvance
            vc?.selectedPartySize = self.diningReservation.PartySize
            vc?.selectedDate = currentDate
            self.navigationController?.present(vc!, animated: true, completion: nil)
        }
    }
    @IBAction func selectDateBtnTapped(sender:UIButton){
        let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DiningRequestSelectResturantDateVC") as? DiningRequestSelectResturantDateVC
        vc?.delegateSelectedDateCalendar = self
        vc?.minDaysInAdvance = self.restaurantDetails.RestaurantSettings.MinDaysInAdvance
        vc?.maxDaysInAdvance = self.restaurantDetails.RestaurantSettings.MaxDaysInAdvance
        vc?.selectedDate = currentDate
        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnHome(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func btnNextPrevious(_ sender: UIButton) {
        if sender.tag == 1{
            if getDateDinning(givenDate: currentDate) == getDateDinning(givenDate: Date()) {
                return
            }
            let daysDifference = Calendar.current.dateComponents([.day], from: Date(), to: currentDate).day ?? 0
            if daysDifference >= self.restaurantDetails.RestaurantSettings.MinDaysInAdvance {
                currentDate = Calendar.current.date(byAdding: .weekday , value: -1, to: currentDate)!
                updateUI()
                restaurentDetail()
            }
        }
        else{
            if getDateDinning(givenDate: currentDate) == getDateDinning(givenDate: Calendar.current.date(byAdding: .weekday, value: self.restaurantDetails.RestaurantSettings.MaxDaysInAdvance, to: Date())!) {
                return
            }
            let daysDifference = Calendar.current.dateComponents([.day], from: Date(), to: currentDate).day ?? 0
            if daysDifference < self.restaurantDetails.RestaurantSettings.MaxDaysInAdvance {
                currentDate = Calendar.current.date(byAdding: .weekday, value: 1, to: currentDate)!
                updateUI()
                restaurentDetail()
            }
        }
    }
    
    
    @IBAction func btnDropDown(_ sender: Any) {
        if dropDownIsOpen == false{
            dropDownIsOpen = true
            tblAvailability.isHidden = false
            imgDrop.image = UIImage(named: "upArrow_gray")
            configSlotMemberTblHeight()
        }
        else{
            dropDownIsOpen = false
            tblAvailability.isHidden = true
            imgDrop.image = UIImage(named: "Down Arrow_Icon")
            heightTblAvailability.constant = 0
            
        }
    }
    @IBAction func dinningClicked(_ sender: Any) {
        
        let restarantpdfDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
        restarantpdfDetailsVC.pdfUrl = self.dinningPolicy
        restarantpdfDetailsVC.restarantName = self.appDelegate.masterLabeling.dining_policy!

        self.navigationController?.pushViewController(restarantpdfDetailsVC, animated: true)
    }
    
    // MARK: - Functions
    
    func assigenSelectdSizeTimeDetails(dayOfWeek: String) {
        lblSelectedSizeTime.text = "\(self.diningReservation.PartySize)  *  \(self.diningReservation.SelectedTime)  \(dayOfWeek)"
    }
    
    func assigenDatePartySizeDetails(yearOfMonth: String) {
        lblDatePartySize.text = "\(self.appDelegate.masterLabeling.DINING_FCFS_SELECTED_DATE ?? ""), \(yearOfMonth) | \(self.appDelegate.masterLabeling.party_size ?? "") \(self.diningReservation.PartySize)"
    }
    
    func assigenSelectedDate() {
        let dateString = self.getDateString(givenDate: currentDate)
        lblSelectedDate.text = dateString
    }
    
    func assignAvailablePartySize() {
        lblAvailablePartySize.text = "Available Party Size : \(self.diningReservation.PartySize)"
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
    
    func moveToMemberDetailsScreen() {
        if diningReservation.PartySize == 0 {
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:"Please select Party Size", withDuration: Duration.kMediumDuration)
        } else {
            let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DinningDetailRestuarantVC") as? DinningDetailRestuarantVC
            vc!.showNavigationBar = false
            vc?.isFrom = self.isFrom
            vc?.diningReservation = self.diningReservation
            vc?.diningPolicyURL = self.dinningPolicy
            vc?.restaurantName = self.restaurantDetails.RestaurantName
            vc?.restaurantImage = self.restaurantDetails.RestaurantImage
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func combainDateTime(dateString: String, timeString: String) {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "YYYY-MM-dd hh:mm a"
        currentDate = inputFormatter.date(from: dateString + " " + timeString)!
    }
    
    // MARK: - Curstom Delegates
    
    func SelectedPartysizeTme(PartySize: Int, Time: Date) {
        self.diningReservation.PartySize = PartySize
        self.currentDate = Time
        updateUI()
        
        restaurentDetail()
    }
    
    func SelectedDiningTimeSlot(timeSlot: String, row: Int) {
        self.diningReservation.SelectedTime = timeSlot
        self.diningReservation.SelectedDate = self.restaurantDetails.OtherAvailableDates[row].Date
        self.moveToMemberDetailsScreen()
    }
    
    // MARK: - Slot Table  Height
          func configSlotMemberTblHeight(){
              if self.restaurantDetails.OtherAvailableDates.count == 0{
                  heightTblAvailability.constant = 0
                  
              }
              else{
                  let numberOfLines = (self.restaurantDetails.OtherAvailableDates.count)+1
                  heightTblAvailability.constant = CGFloat(100*(numberOfLines))
                 
              }
              tblAvailability.reloadData()

          }

    func dateSelection(date: String) {
        let timeString = getTimeString(givenDate: currentDate)
        combainDateTime(dateString: date, timeString: timeString)
        updateUI()
        restaurentDetail()
    }
    
    // MARK: - Collectioniew Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.restaurantDetails.SelectedDate != nil {
            return self.restaurantDetails.SelectedDate.TimeSlot.count
        } else {
            return 0
        }
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DinningReservationTimeSlotCollectionCell", for: indexPath) as! DinningReservationTimeSlotCollectionCell
        let dict = self.restaurantDetails.SelectedDate.TimeSlot[indexPath.row]
        if self.reservationDate == self.restaurantDetails.SelectedDate.Date && self.reservationTime == dict.timeSlot && self.isFrom == .modify {
            cell.viewTimeSlotBack.backgroundColor = .systemBlue
        } else {
            cell.viewTimeSlotBack.backgroundColor = UIColor(hexString: "#5773A2")
        }
        cell.lblTime.text = dict.timeSlot
            
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 80, height: 40)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.diningReservation.SelectedTime = self.restaurantDetails.SelectedDate.TimeSlot[indexPath.row].timeSlot
        self.moveToMemberDetailsScreen()
    }
    
    // MARK: - Table Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurantDetails.OtherAvailableDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblAvailability.dequeueReusableCell(withIdentifier: "DiningResvTableCell", for: indexPath) as! DiningResvTableCell
        let dict = self.restaurantDetails.OtherAvailableDates[indexPath.row]
        cell.timeSlotsDelegate = self
        cell.lblPartySize.isHidden = true
        cell.lblUpcomingEvent.isHidden = true
        cell.heightUpcoming.constant = 0
        cell.timeSlots = dict.TimeSlot
        cell.row = indexPath.row
        cell.lblTime.text = getDateFromDetailAvailability(givenDate: dict.Date)

        if self.isFrom != .create && self.isSelectedRestaurant && dict.Date == self.reservationDate {
            cell.selectedTimeSlot = self.reservationTime
        } else {
            cell.selectedTimeSlot = ""
        }
        cell.collectionTimeSlot.reloadData()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
}


// MARK: - API CALLING
extension RestaurantSpecificDetailVC{
    func restaurentDetail(){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            var paramaterDict:[String: Any]?
            
             paramaterDict = [
                "Content-Type":"application/json",
                APIKeys.kCompanyCode: "00",
                APIKeys.kPartySize : self.diningReservation.PartySize,
                APIKeys.kFilterDate: self.diningReservation.SelectedDate,
                APIKeys.kFilterTime: self.diningReservation.SelectedTime,
                APIKeys.krestaurentID: self.diningReservation.RestaurantID,
                APIKeys.kOtherAvailableDate : "5"
             ]
            
            APIHandler.sharedInstance.GetRestaurentDetail(paramater: paramaterDict, onSuccess: { restaurntDetails in
                self.appDelegate.hideIndicator()
                if restaurntDetails.Restaurants.count != 0{
                    self.restaurantDetails = restaurntDetails.Restaurants[0]
                    self.lblRestaurentName.text = restaurntDetails.Restaurants[0].RestaurantName
                    self.diningSetting = restaurntDetails.Restaurants[0].RestaurantSettings
                    self.lblDefaultTime.text = self.getStartAndEndTimeString(timings: self.restaurantDetails.Timings)
                    
                    if(self.restaurantDetails.SelectedDate.TimeSlot.count == 0)
                    {
                        self.collectionTimeSlot.setEmptyMessage(InternetMessge.kNoTimeSlot)
                    } else {
                        self.collectionTimeSlot.restore()
                    }
                    
                    self.collectionTimeSlot.reloadData()
                    self.tblAvailability.reloadData()
                }

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


