//
//  GolfReservationVC.swift
//  CSSI
//
//  Created by Aks on 08/02/23.
//  Copyright © 2023 yujdesigns. All rights reserved.
//

import UIKit

class GolfReservationVC: UIViewController {
    
    //MARK: - Iboutlet
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var collectionDaySlot: UICollectionView!
    @IBOutlet weak var tblAvailableSlot: UITableView!

    
    //MARK:- variables
    var showNavigationBar = true
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate


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
        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
}

extension GolfReservationVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
//MARK: - Collectionview Methods
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 9
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DaySlotCollectioncell", for: indexPath) as! DaySlotCollectioncell
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
extension GolfReservationVC : UITableViewDelegate, UITableViewDataSource{
    // MARK: - Table Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblAvailableSlot.dequeueReusableCell(withIdentifier: "AvailableCoursesGolfCell", for: indexPath) as! AvailableCoursesGolfCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
        
    }
}
