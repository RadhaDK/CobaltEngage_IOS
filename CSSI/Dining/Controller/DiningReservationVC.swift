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

class DiningReservationVC: UIViewController, UITableViewDelegate,UITableViewDataSource, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, selectedPartySizeTime {

    
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
    
    
    //MARK:- variables
    var showNavigationBar = true
    var nameOfMonth : String?
    var currentMonth : Date?
    var isDateChanged : String?
    var isDateSelected : Bool?
    var myCalendar: FSCalendar!
    var currentDate = Date()
    var selectedPartySize = 0
    var selectedTime = ""
    var selectedDateString = ""
    var diningReservation = DinningReservationFCFS()
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var restaurantsList: [DiningRestaurantsData] = []
    var diningSetting = DiningSettingData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        currentDate = date
        let dateString = self.getDateString(givenDate: date)
        lblSelectedDate.text = dateString
        setUpUiInitialization()
        reservationList()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = !self.showNavigationBar
       // self.myCalendar.reloadData()
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
    }
    
    func setUpUiInitialization(){
        tblResturat.delegate = self
        tblResturat.dataSource  = self
        registerNibs()
        setUpUi()
    }
    
    func updateUI() {
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
        vc?.maxPartySize = self.diningSetting.MaxPartySize ?? 5
        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func btnHome(_ sender: Any) {
        let homeVC = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    @IBAction func selectDateBtnTapped(sender:UIButton){
        let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DiningRequestSelectResturantDateVC") as? DiningRequestSelectResturantDateVC
        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func btnNextPrevious(_ sender: UIButton) {
        if sender.tag == 1{
            currentDate = Calendar.current.date(byAdding: .weekday , value: -1, to: currentDate)!
        }
        else{
            currentDate = Calendar.current.date(byAdding: .weekday, value: 1, to: currentDate)!
        }
        let dateString = self.getDateString(givenDate: currentDate)
        lblSelectedDate.text = dateString
    }
    
    //MARK: - Functions
    func shadowView(viewName : UIView){
        viewName.layer.shadowColor = UIColor.black.cgColor
        viewName.layer.shadowOpacity = 0.12
        viewName.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewName.layer.shadowRadius = 6
    }
    
    
    //MARK: - Date Formatter
    func getDateString(givenDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: givenDate)
    }
    
    func getDayOfWeek(givenDate: Date) -> String {
        
        return ""
    }
    
    func getmonthOfYear(givenDate: Date) -> String {
        
        return ""
    }
    

    //MARK: - Custom Delgates Functions
    func SelectedPartysizeTme(PartySize: Int, Time: String) {
        if PartySize != 0 {
            lblSelectedSizeTime.text = "\(PartySize) * \(selectedTime)"
            selectedPartySize = PartySize
            lblDatePartySize.text = "Selected Date, \(selectedTime)|  Party size \(PartySize) | Any Resturant"
        }
       else if Time != ""{
            lblSelectedSizeTime.text = "\(selectedPartySize) * \(Time)"
           lblDatePartySize.text = "Selected Date, \(Time)|  Party size \(selectedPartySize) | Any Resturant"
           selectedTime = Time
        }
        else if PartySize != 0 && Time != ""{
            lblSelectedSizeTime.text = "\(PartySize) * \(Time)"
            lblDatePartySize.text = "Selected Date, \(Time)|  Party size \(PartySize) | Any Resturant"
            selectedPartySize = PartySize
            selectedTime = Time
        }
        tblResturat.reloadData()
    }
    // MARK: - Table Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurantsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblResturat.dequeueReusableCell(withIdentifier: "DiningResvTableCell", for: indexPath) as! DiningResvTableCell
        cell.lblPartySize.text = "Fri, Aug - Party Size:\(selectedPartySize)"
        cell.timeSlots = self.restaurantsList[indexPath.row].TimeSlots
        cell.lblUpcomingEvent.text = self.restaurantsList[indexPath.row].RestaurantName
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = restaurantsList[indexPath.row]
        if let impVC = UIStoryboard.init(name: "DiningStoryboard", bundle: .main).instantiateViewController(withIdentifier: "RestaurantSpecificDetailVC") as? RestaurantSpecificDetailVC {
            impVC.selectedRestaurentId = dict.RestaurantID
            print(dict.RestaurantID)
            self.navigationController?.pushViewController(impVC, animated: true)
        }
    }
}


// MARK: - API CALLING
extension DiningReservationVC{
    func reservationList(){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            var paramaterDict:[String: Any]?
            
             paramaterDict = [
                "Content-Type":"application/json",
                APIKeys.kPartySize : self.diningReservation.PartySize,
                APIKeys.kFilterDate: self.diningReservation.SelectedDate,
                APIKeys.kFilterTime: self.diningReservation.SelectedTime,
                APIKeys.kCompanyCode: "00"
             ]
            print(paramaterDict)
            APIHandler.sharedInstance.GetDinningReservation(paramater: paramaterDict, onSuccess: { reservationDinningListing in
                self.appDelegate.hideIndicator()
                self.restaurantsList = reservationDinningListing.restaurants!
                self.diningSetting = reservationDinningListing.diningSettings!
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
}
