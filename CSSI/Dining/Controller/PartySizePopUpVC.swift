//
//  PartySizePopUpVC.swift
//  CSSI
//
//  Created by Aks on 05/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
protocol selectedPartySizeTime{
    func SelectedPartysizeTme(PartySize : Int, Time : String)
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
    var selectedPartySize : Int?
    var selectedDate : String?
//    var arrPartySize = ["1","2","3","4","5","6"]
    var maxPartySize = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
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
        datePicker.minuteInterval = 15
        
        if #available(iOS 15.0, *) {
            datePicker.roundsToMinuteInterval = true
            datePicker.minimumDate = .now
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
    }
    
    @objc func dateSelected(){
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd"
            selectedDate = dateformatter.string(from: datePicker.date)
        }

    
    //MARK: - IBActions
    @IBAction func doneBtnTapped(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
        delegateSelectedTimePatySize?.SelectedPartysizeTme(PartySize: selectedPartySize ?? 0, Time: selectedDate ?? "")
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
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let dict = arrPartySize[indexPath.row]
        selectedPartySize = indexPath.row + 1
    }
}
