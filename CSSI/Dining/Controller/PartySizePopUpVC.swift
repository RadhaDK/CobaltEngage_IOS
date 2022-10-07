//
//  PartySizePopUpVC.swift
//  CSSI
//
//  Created by Aks on 05/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class PartySizePopUpVC: UIViewController {
    
    @IBOutlet weak var roundedBgView: UIView!
    @IBOutlet weak var partySizeLbl: UILabel!
    @IBOutlet weak var partySizeCollectionView: UICollectionView!
    @IBOutlet weak var btnDone: UIButton!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var DateTimeDinningResrvation: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    let dateFormatter = DateFormatter()


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
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
      //  DateTimeDinningResrvation.inputView = datePicker
              datePicker.datePickerMode = .date
             //  inputTextField.text = dateFormatter.string(from: datePicker.date)
        
    }
    

    @IBAction func doneBtnTapped(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}


extension PartySizePopUpVC : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = partySizeCollectionView.dequeueReusableCell(withReuseIdentifier: "PartySizeCollectionCell", for: indexPath) as! PartySizeCollectionCell
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
