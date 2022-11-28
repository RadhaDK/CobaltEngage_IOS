//
//  PartySizePopUpVC.swift
//  CSSI
//
//  Created by Aks on 05/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
protocol selectedPartySizeTime{
    func SelectedPartysizeTme(PartySize : Int, Time : Date)
}

class PartySizePopUpVC: UIViewController {
    
    
    //MARK: - IBActions
    @IBOutlet weak var roundedBgView: UIView!
    @IBOutlet weak var partySizeLbl: UILabel!
    @IBOutlet weak var partySizeCollectionView: UICollectionView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var DateTimeDinningResrvation: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
 
    //MARK: - variables
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let dateFormatter = DateFormatter()
    var delegateSelectedTimePatySize : selectedPartySizeTime?
    var selectedPartySize = -1
    var selectedDate = Date()
//    var arrPartySize = ["1","2","3","4","5","6"]
    var maxPartySize = 0
    var minimumDaysInAdvance = 0
    var maximumDaysInAdvance = 90
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
        if maxPartySize == 0 {
            maxPartySize = 6
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            let touch = touches.first
            if touch?.view != self.roundedBgView
            { self.dismiss(animated: true, completion: nil) }
        }
    //MARK: - setUpUI
    func setUpUi(){
        roundedBgView.clipsToBounds = true
        roundedBgView.layer.cornerRadius = 15
        roundedBgView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        btnDone.layer.cornerRadius = btnDone.frame.height/2
        self.btnDone.diningBtnViewSetup()
        self.btnDone.setTitle("Done", for: UIControlState.normal)
        self.btnDone.setStyle(style: .outlined, type: .primary)
        setUpUiInitialization()
    }
    func setUpUiInitialization(){
        dateFormatter.dateFormat = "EEE,MMM dd 'T'HH:mm a"
        datePicker.datePickerMode = .dateAndTime
//        datePicker.minuteInterval = 15
        
        if #available(iOS 15.0, *) {
            datePicker.roundsToMinuteInterval = true
//            if self.maximumDaysInAdvance != 0 {
//                self.maximumDaysInAdvance = self.maximumDaysInAdvance + 1
//            }
            var minimumDate = Calendar.current.date(byAdding: .day, value: self.minimumDaysInAdvance, to: Date())!
            var maximumDate = Calendar.current.date(byAdding: .day, value: self.maximumDaysInAdvance, to: Date())!
            if minimumDaysInAdvance > 0 {
                minimumDate = Calendar.current.date(bySettingHour: 5, minute: 0, second: 0, of: minimumDate)!
            }
//            if maximumDaysInAdvance == 0 {
                maximumDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 0, of: maximumDate)!
//            }
            datePicker.minimumDate = minimumDate
            datePicker.maximumDate = maximumDate
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        datePicker.date = selectedDate
    }
    
    @objc func dateSelected(){

    }

    
    //MARK: - IBActions
    @IBAction func doneBtnTapped(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
        
        delegateSelectedTimePatySize?.SelectedPartysizeTme(PartySize: selectedPartySize, Time: datePicker.date)
    }
}

//MARK: - Collectionview methods
extension PartySizePopUpVC : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maxPartySize
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = partySizeCollectionView.dequeueReusableCell(withReuseIdentifier: "PartySizeCollectionCell", for: indexPath) as! PartySizeCollectionCell
//        let dict = arrPartySize[indexPath.row]
        cell.partySizeCountLbl.text = "\(indexPath.row + 1)"
        if selectedPartySize == indexPath.row + 1 {
            cell.partySizeCountLbl.textColor = .white
            cell.partySizeCountLbl.layer.backgroundColor = UIColor(red: 1/255, green: 192/255, blue: 247/255, alpha: 1).cgColor
        } else {
            cell.partySizeCountLbl.textColor = .darkGray
            cell.partySizeCountLbl.layer.backgroundColor = UIColor.white.cgColor
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let dict = arrPartySize[indexPath.row]
        selectedPartySize = indexPath.row + 1
        collectionView.reloadData()
    }
}
