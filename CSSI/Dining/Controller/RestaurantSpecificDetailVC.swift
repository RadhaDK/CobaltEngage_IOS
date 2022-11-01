//
//  RestaurantSpecificDetailVC.swift
//  CSSI
//
//  Created by Aks on 11/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class RestaurantSpecificDetailVC: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UITableViewDelegate,UITableViewDataSource, selectedPartySizeTime {
    func SelectedPartysizeTme(PartySize: Int, Time: String) {
        if PartySize != 0 {
            lblSelectedSizeTime.text = "\(PartySize) * \(selectedTime ?? "")"
            selectedPartySize = Int(PartySize)
            lblDatePartySize.text = "Selected Date, \(selectedTime ?? "")|  Party size \(PartySize) | Any Resturant"
        }
       else if Time != ""{
           lblSelectedSizeTime.text = "\(selectedPartySize ?? 0) * \(Time)"
           lblDatePartySize.text = "Selected Date, \(Time)|  Party size \(selectedPartySize ?? 0) | Any Resturant"
           selectedTime = Time
        }
        else if PartySize != 0 && Time != ""{
            lblSelectedSizeTime.text = "\(PartySize) * \(Time)"
            lblDatePartySize.text = "Selected Date, \(Time)|  Party size \(PartySize) | Any Resturant"
            selectedPartySize = Int(PartySize)
            selectedTime = Time
        }
 
        tblAvailability.reloadData()
    }
    
    
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


    //MARK: - variables
    var currentDate = Date()
    var selectedPartySize : Int?
    var dropDownIsOpen = false
    var selectedTime : String?
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var selectedRestaurentId : String?
    var selectedDate : String?
    var currentTime : String?
    var restaurantDefaultSlots : [DiningTimeSlots]!
    var selectedTimeSlots : [DiningTimeSlots]!
    var arrSelectedSlotsAre = [String]()
    var arrOtherDates = [GetRestaurantSelectedDateDetail]()
    var availableTime : String?
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
        let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: imgRestaurent.frame.size.width, height: imgRestaurent.frame.size.height))
        overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        imgRestaurent.addSubview(overlay)
        // Do any additional setup after loading the view.
      
        tblAvailability.isHidden = true
        heightTblAvailability.constant = 0
        imgDrop.image = UIImage(named: "Icon_Down")
        shadowView(viewName: viewTime)
        shadowView(viewName: viewPrevious)
        shadowView(viewName: viewDate)
        shadowView(viewName: viewNext)
        lblSelectedSizeTime.text = selectedTime
        lblSelectedDate.text = selectedDate
        lblDatePartySize.text = "Selected Date, \(currentTime ?? "")|  Party size \(selectedPartySize ?? 0) | Any Resturant"
        lblAvailablePartySize.text = "Available Party Size : \(selectedPartySize ?? 0)"
        lblAvailableTime.text = availableTime
        restaurentDetail()
    }
    
    func setUpUiInitialization(){
       
        tblAvailability.delegate = self
        tblAvailability.dataSource  = self
        registerNibs()
        setUpUi()
    }
    
    func registerNibs(){
        let menuNib = UINib(nibName: "DinningReservationTimeSlotCollectionCell" , bundle: nil)
        self.collectionTimeSlot.register(menuNib, forCellWithReuseIdentifier: "DinningReservationTimeSlotCollectionCell")
        let homeNib = UINib(nibName: "DiningResvTableCell" , bundle: nil)
        self.tblAvailability.register(homeNib, forCellReuseIdentifier: "DiningResvTableCell")
    }
    
    func shadowView(viewName : UIView){
        viewName.layer.shadowColor = UIColor.black.cgColor
        viewName.layer.shadowOpacity = 0.12
        viewName.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewName.layer.shadowRadius = 6
    }
    @IBAction func btnSelectPartySize(_ sender: Any) {
        let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "PartySizePopUpVC") as? PartySizePopUpVC
        vc?.delegateSelectedTimePatySize = self
        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
    @IBAction func selectDateBtnTapped(sender:UIButton){
        let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DiningRequestSelectResturantDateVC") as? DiningRequestSelectResturantDateVC
        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnHome(_ sender: Any) {
        let homeVC = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    @IBAction func btnNextPrevious(_ sender: UIButton) {
        if sender.tag == 1{
            let previousMonth = Calendar.current.date(byAdding: .weekday , value: -1, to: currentDate)
            currentDate = previousMonth!
            let format = DateFormatter()
            format.dateFormat = "MM/dd/yyyy"
            let formattedDate = format.string(from: previousMonth!)
            print(formattedDate)
            lblSelectedDate.text = formattedDate
        }
        else{
            let nextMonth = Calendar.current.date(byAdding: .weekday, value: 1, to: currentDate)
            currentDate = nextMonth!
            let format = DateFormatter()
            format.dateFormat = "MM/dd/yyyy"
            let formattedDate = format.string(from: nextMonth!)
            print(formattedDate)
            lblSelectedDate.text = formattedDate
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
            imgDrop.image = UIImage(named: "Icon_Down")
            heightTblAvailability.constant = 0
            
        }
    }
    @IBAction func dinningClicked(_ sender: Any) {
        
        let restarantpdfDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
        restarantpdfDetailsVC.pdfUrl = self.dinningPolicy.dinningSettings?.diningURl ?? ""
        restarantpdfDetailsVC.restarantName = self.appDelegate.masterLabeling.dining_policy!

        self.navigationController?.pushViewController(restarantpdfDetailsVC, animated: true)
    }
    // MARK: - MARK:- Slot Table  Height
          func configSlotMemberTblHeight(){
              if arrOtherDates.count == 0{
                  heightTblAvailability.constant = 0
                  
              }
              else{
                  let numberOfLines = (arrOtherDates.count)+1
                  heightTblAvailability.constant = CGFloat(100*(numberOfLines))
                 
              }
              tblAvailability.reloadData()

          }

    
    //MARK:- Collectioniew Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return restaurantDefaultSlots.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DinningReservationTimeSlotCollectionCell", for: indexPath) as! DinningReservationTimeSlotCollectionCell
        let dict = restaurantDefaultSlots[indexPath.row]
        cell.lblTime.text = dict.timeSlot
        
//        if arrSelectedSlotsAre.contains(dict.StartTime){
//            cell.viewTimeSlotBack.backgroundColor = UIColor(red: 59/255, green: 135/255, blue: 193/255, alpha: 1)
//        }
//        else{
//            cell.viewTimeSlotBack.backgroundColor = UIColor(red: 29/255, green: 66/255, blue: 122/255, alpha: 1)
//        }
            
        cell.addToSlotClosure = {
            let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DinningDetailRestuarantVC") as? DinningDetailRestuarantVC
            vc!.showNavigationBar = false
//            vc?.selectedPartySize = 4
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 80, height: 40)
       }
    
    // MARK: - Table Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOtherDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblAvailability.dequeueReusableCell(withIdentifier: "DiningResvTableCell", for: indexPath) as! DiningResvTableCell
        let dict = arrOtherDates[indexPath.row]
        cell.lblPartySize.isHidden = true
        cell.lblUpcomingEvent.isHidden = true
        cell.heightUpcoming.constant = 0
        cell.timeSlots = dict.TimeSlot
        cell.lblTime.text = getDateFromDetailAvailability(givenDate: dict.Date)
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
                APIKeys.kPartySize : "2",
                APIKeys.kFilterDate: "2022-10-28",
                APIKeys.kFilterTime: "07:00 AM",
                APIKeys.krestaurentID: selectedRestaurentId ?? "18A98F91-44AA-4777-9BE6-24F4D517FEC4",
                APIKeys.kOtherAvailableDate : "5"
             ]
            
            APIHandler.sharedInstance.GetRestaurentDetail(paramater: paramaterDict, onSuccess: { restaurntDetails in
                self.appDelegate.hideIndicator()
                if restaurntDetails.Restaurants.count != 0{
                    print(restaurntDetails.Restaurants[0].RestaurantName)
                    self.lblRestaurentName.text = restaurntDetails.Restaurants[0].RestaurantName
                    self.imgRestaurent.image = self.convertBase64StringToImage(imageBase64String: restaurntDetails.Restaurants[0].RestaurantImage)
                    self.lblDefaultTime.text = "\(restaurntDetails.Restaurants[0].RestaurantSettings[0].DefaultStartTime ?? "") \(restaurntDetails.Restaurants[0].RestaurantSettings[0].DefaultEndTime ?? "")"
                    if let defaultSlots = restaurntDetails.Restaurants[0].SelectedDate[0].TimeSlot{
                    
                        print(restaurntDetails)
                      
                        print(self.arrSelectedSlotsAre)
                        self.collectionTimeSlot.delegate = self
                        self.collectionTimeSlot.dataSource = self
                        self.restaurantDefaultSlots = defaultSlots
                        self.collectionTimeSlot.reloadData()
                    }
                    if let otherAvailableDates = restaurntDetails.Restaurants[0].OtherAvailableDates{
                        self.arrOtherDates = otherAvailableDates
                        print(self.arrOtherDates.count)
                        self.tblAvailability.reloadData()
                    }
                    
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

extension RestaurantSpecificDetailVC{
    func convertBase64StringToImage (imageBase64String:String) -> UIImage? {
        if let url = URL(string: imageBase64String), let data = try? Data(contentsOf: url) {
            return UIImage(data: data)!
        }
        return nil
    }
}
