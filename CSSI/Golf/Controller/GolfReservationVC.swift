//
//  GolfReservationVC.swift
//  CSSI
//
//  Created by Aks on 08/02/23.
//  Copyright © 2023 yujdesigns. All rights reserved.
//

import UIKit

class GolfReservationVC: UIViewController,  GolfSlotsDelegate {
    func SelectedGolfSlotSlot(timeSlot: String, row: Int) {
        let vc = UIStoryboard(name: "GolfStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "GolfSubmitRequestVCViewController") as? GolfSubmitRequestVCViewController

        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    
    //MARK: - Iboutlet
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var collectionDaySlot: UICollectionView!
    @IBOutlet weak var tblAvailableSlot: UITableView!
    @IBOutlet weak var lblSelectedSizeTime: UILabel!

    
    //MARK:- variables
    var showNavigationBar = true
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    private var transPopupTableView : UITableView?
    var teeTimeSetting : GetGolfSlots?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUiInitialization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPathForFirstRow = IndexPath(row: 0, section: 0)
        self.collectionDaySlot?.selectItem(at: indexPathForFirstRow, animated: true, scrollPosition: .top)
    }
    
    //MARK: - setUpUI
    func setUpUi(){
        viewTime.shadowView(viewName: viewTime)
        btnBack.setTitle("", for: .normal)
        btnHome.setTitle("", for: .normal)
        btnTime.setTitle("", for: .normal)
    }
    
    func setUpUiInitialization(){
        setUpUi()
        collectionDaySlot.delegate = self
        collectionDaySlot.dataSource = self
        tblAvailableSlot.delegate = self
        tblAvailableSlot.dataSource  = self
        sample()
    }
    func updateUI() {

      //  self.diningReservation.SelectedTime = getTimeString(givenDate: currentDate)
    //    self.assigenSelectdSizeTimeDetails(dayOfWeek: getDayOfWeek(givenDate: teeTimeSetting?.TeeTimeSettings.DefaultTime ?? ""))
//        self.assigenDatePartySizeDetails(yearOfMonth: getDateDinning(givenDate: currentDate))
//        self.assigenSelectedDate()
//        self.diningReservation.SelectedDate = getDateStringFromDate(givenDate: currentDate)
        lblSelectedSizeTime.text = "\(teeTimeSetting?.TeeTimeSettings.MaxPlayersSize ?? 0) * \(teeTimeSetting?.TeeTimeSettings.DefaultTime ?? "")"

        self.tblAvailableSlot.reloadData()
        self.collectionDaySlot.reloadData()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = !self.showNavigationBar
    }
    
    //MARK: - IBActions
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnPlayerPopup(_ sender: Any) {
        let vc = UIStoryboard(name: "GolfStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "PlayerSizePopUp") as? PlayerSizePopUp
        vc?.teeTimeSetting = teeTimeSetting
        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
    
//MARK: - Functions
    func assigenSelectdSizeTimeDetails(dayOfWeek: String) {
    }
}


//MARK: - Collectionview Methods
extension GolfReservationVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return teeTimeSetting?.TeeTimeSettings?.AvailableDates.count ?? 0
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DaySlotCollectioncell", for: indexPath) as! DaySlotCollectioncell
    let dict = teeTimeSetting?.TeeTimeSettings?.AvailableDates[indexPath.row]
    cell.lblDay.text = getDayWeek(givenDate: dict?.Date ?? "")
    cell.lblMonth.text = getDateGolf(givenDate: dict?.Date ?? "")

//    if indexPath.row == 0{
//        cell.viewBack.backgroundColor = UIColor(red: 2/255, green: 198/255, blue: 254/255, alpha: 1)
//    }
//    cell.lblTime.text = self.timeSlots[indexPath.row].timeSlot
//    if selectedTimeSlot != self.timeSlots[indexPath.row].timeSlot {
//        cell.viewTimeSlotBack.backgroundColor = UIColor(hexString: "#5773A2")
//    } else {
//        cell.viewTimeSlotBack.backgroundColor = .systemBlue
//    }
    
    return cell
}
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
{
    return CGSize(width: 80, height: 60)
}

//func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DaySlotCollectioncell", for: indexPath) as! DaySlotCollectioncell
//    cell.viewBack.backgroundColor = UIColor(red: 2/255, green: 198/255, blue: 254/255, alpha: 1)
//
////    self.timeSlotsDelegate?.SelectedDiningTimeSlot(timeSlot: self.timeSlots[indexPath.row].timeSlot, row: self.row)
//
//}
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DaySlotCollectioncell", for: indexPath) as! DaySlotCollectioncell
//        cell.viewBack.backgroundColor = UIColor.white
//    }
}
// MARK: - Table Methods
extension GolfReservationVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
        return teeTimeSetting?.AvailableTimeSlots.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblAvailableSlot.dequeueReusableCell(withIdentifier: "AvailableCoursesGolfCell", for: indexPath) as! AvailableCoursesGolfCell
        let dict = teeTimeSetting?.AvailableTimeSlots[indexPath.row]
        cell.golfSlotsDelegate = self
        cell.lblTime.text = "\(dict?.TimeSlot ?? "") \(dict?.TypeGolf ?? "")"
        cell.arrAvailableSlot = teeTimeSetting?.AvailableTimeSlots ?? []
        cell.collectionSlot.reloadData()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
//MARK: - Load json Data
extension GolfReservationVC{
    
    
    
    func sample() {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let text = try String(contentsOfFile: path, encoding: .utf8)
                if let dict = try JSONSerialization.jsonObject(with: text.data(using: .utf8)!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
                    if let data = GetGolfSlots(JSON: dict) {
                       teeTimeSetting = data
                        // class: Cat, class: Fish, class: Animal
                        print("===============\n\(data)")
                        updateUI()
                       // collectionDaySlot.reloadData()
                    }
                }
            }catch {
                print("\(error.localizedDescription)")
            }
        }
    }
}
