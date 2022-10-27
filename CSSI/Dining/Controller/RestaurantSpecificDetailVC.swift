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
            lblSelectedSizeTime.text = "\(PartySize) * \(selectedTime)"
            selectedPartySize = Int(PartySize) ?? 6
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
            selectedPartySize = Int(PartySize) ?? 6
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

    

    //MARK: - variables
    var currentDate = Date()
    var selectedPartySize = 3
    var dropDownIsOpen = false
    var selectedTime = "0:00 PM Wed"
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var selectedRestaurentId : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSelectedDate.setTitle("", for: UIControlState.normal)
        btnBack.setTitle("", for: .normal)
        btnHome.setTitle("", for: .normal)
        btnDropdown.setTitle("", for: .normal)
        btnPartySize.setTitle("", for: .normal)
        let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: imgRestaurent.frame.size.width, height: imgRestaurent.frame.size.height))
        overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
        imgRestaurent.addSubview(overlay)
        // Do any additional setup after loading the view.
        collectionTimeSlot.delegate = self
        collectionTimeSlot.dataSource = self
        tblAvailability.delegate = self
        tblAvailability.dataSource  = self
        tblAvailability.isHidden = true
        heightTblAvailability.constant = 0
        imgDrop.image = UIImage(named: "Icon_Down")
        shadowView(viewName: viewTime)
        shadowView(viewName: viewPrevious)
        shadowView(viewName: viewDate)
        shadowView(viewName: viewNext)
        registerNibs()
        restaurentDetail()
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
    // MARK:- Slot Table  Height
          func configSlotMemberTblHeight(){
              if selectedPartySize == 0{
                  heightTblAvailability.constant = 0
                  tblAvailability.reloadData()
              }
              else{
             
                  heightTblAvailability.constant = CGFloat(100*selectedPartySize)
                  tblAvailability.reloadData()
              }
          }
    
    //MARK:- Collectioniew Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DinningReservationTimeSlotCollectionCell", for: indexPath) as! DinningReservationTimeSlotCollectionCell
        
        cell.addToSlotClosure = {
            let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DinningDetailRestuarantVC") as? DinningDetailRestuarantVC
            vc!.showNavigationBar = false
            vc?.selectedPartySize = 4
            self.navigationController?.pushViewController(vc!, animated: true)

        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 80, height: 40)
       }
    
    // MARK: - Table Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblAvailability.dequeueReusableCell(withIdentifier: "DiningResvTableCell", for: indexPath) as! DiningResvTableCell
        cell.lblUpcomingEvent.isHidden = true
        cell.heightUpcoming.constant = 0
    //    cell.lblPartySize.text = "Fri, Aug - Party Size:\(selectedPartySize ?? "")"
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
                APIKeys.kPartySize : "5",
                APIKeys.kFilterDate: "2022-10-14",
                APIKeys.kFilterTime: "10:00 PM",
                APIKeys.krestaurentID: selectedRestaurentId ?? ""
             ]
            
            APIHandler.sharedInstance.GetRestaurentDetail(paramater: paramaterDict, onSuccess: { reservationDinningListing in
                self.appDelegate.hideIndicator()
                print(reservationDinningListing.Restaurants[0].RestaurantName)
                self.lblRestaurentName.text = reservationDinningListing.Restaurants[0].RestaurantName
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
