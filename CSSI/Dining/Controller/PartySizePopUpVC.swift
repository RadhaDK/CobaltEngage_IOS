//
//  PartySizePopUpVC.swift
//  CSSI
//
//  Created by Aks on 05/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
protocol selectedPartySizeTime{
    func SelectedPartysizeTme(PartySize : String, Time : String)
}

class PartySizePopUpVC: UIViewController {
    
    @IBOutlet weak var roundedBgView: UIView!
    @IBOutlet weak var partySizeLbl: UILabel!
    @IBOutlet weak var partySizeCollectionView: UICollectionView!
    @IBOutlet weak var btnDone: UIButton!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var DateTimeDinningResrvation: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    let dateFormatter = DateFormatter()
    var delegateSelectedTimePatySize : selectedPartySizeTime?
    var selectedPartySize : String?
    var selectedDate : String?
    var arrPartySize = ["1","2","3","4","5","6"]
    override func viewDidLoad() {
        super.viewDidLoad()
        roundedBgView.clipsToBounds = true
        roundedBgView.layer.cornerRadius = 15
        roundedBgView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        btnDone.layer.cornerRadius = btnDone.frame.height/2
        self.btnDone.diningBtnViewSetup()
        self.btnDone.setTitle("Done", for: UIControlState.normal)
        self.btnDone.setStyle(style: .outlined, type: .primary)
        // Do any additional setup after loading the view.
        
        dateFormatter.dateFormat = "EEE,MMM dd 'T'HH:mm a"
              datePicker.datePickerMode = .dateAndTime
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)

    }
    @objc func dateSelected(){
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "dd/MM/yyyy"
            selectedDate = dateformatter.string(from: datePicker.date)
            datePicker.isHidden = true
        }

    @IBAction func doneBtnTapped(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
        delegateSelectedTimePatySize?.SelectedPartysizeTme(PartySize: selectedPartySize ?? "", Time: selectedDate ?? "")
    }
}


extension PartySizePopUpVC : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPartySize.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = partySizeCollectionView.dequeueReusableCell(withReuseIdentifier: "PartySizeCollectionCell", for: indexPath) as! PartySizeCollectionCell
        let dict = arrPartySize[indexPath.row]
        cell.partySizeCountLbl.text = dict
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dict = arrPartySize[indexPath.row]
        selectedPartySize = dict
        
    }
    
}
