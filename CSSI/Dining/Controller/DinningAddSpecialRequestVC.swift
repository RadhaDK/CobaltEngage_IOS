//
//  DinningAddSpecialRequestVC.swift
//  CSSI
//
//  Created by Aks on 07/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class DinningAddSpecialRequestVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionAddSpecialRequest: UICollectionView!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var heightSpecialRequestCollection: NSLayoutConstraint!
    @IBOutlet weak var heightViewBackSpecialRequest: NSLayoutConstraint!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var txtComment: UITextView!
    @IBOutlet weak var collectionSpecialOccasion: UICollectionView!
    
    var arrSpecialRequest = ["Behind lounge area","Close to enterance","Outside","On the Perimeter"]

    override func viewDidLoad() {
        super.viewDidLoad()
        btnHome.setTitle("", for: .normal)
        btnBack.setTitle("", for: .normal)

        collectionAddSpecialRequest.delegate = self
        collectionAddSpecialRequest.dataSource  = self
        collectionSpecialOccasion.delegate = self
        collectionSpecialOccasion.dataSource  = self
        btnAdd.layer.cornerRadius = btnAdd.bounds.size.height / 2
        btnAdd.layer.borderWidth = 1.0
        btnAdd.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
        self.btnAdd.setStyle(style: .outlined, type: .primary)
        btnCancel.layer.cornerRadius = btnCancel.bounds.size.height / 2
        btnCancel.layer.borderWidth = 1.0
        btnCancel.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
        self.btnCancel.setStyle(style: .outlined, type: .primary)
        txtComment.layer.cornerRadius = 8
        txtComment.layer.borderColor = UIColor.lightGray.cgColor
        txtComment.layer.borderWidth = 1
        configSlotMemberCollectionHeight()

    }
    @IBAction func btnHome(_ sender: Any) {
        let homeVC = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   

    // MARK:- My order Table  Height
          func configSlotMemberCollectionHeight(){
              if arrSpecialRequest.count == 0{
                  heightSpecialRequestCollection.constant = 0
                  heightViewBackSpecialRequest.constant = 0
                  collectionAddSpecialRequest.reloadData()
              }
              else{
                  let numberOfLines = (arrSpecialRequest.count/2)+1
                  heightSpecialRequestCollection.constant = CGFloat(60*numberOfLines)
                  heightViewBackSpecialRequest.constant = 49 + CGFloat(60*numberOfLines)
                  collectionAddSpecialRequest.reloadData()
              }
          }
    
    // MARK: - Collection Methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSpecialRequest.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckboxCell", for: indexPath as IndexPath) as! CheckBoxCustomCell
        cell.btnCheckBox.setTitle("testing", for: .normal)
//        if  self.arrSpecialRequest[indexPath.row].isChecked == 1{
//          cell.btnMarketCheckBox.setImage(UIImage(named: "Group 2130"), for: UIControlState.normal)
//          }
//      else{
//          cell.btnMarketCheckBox.setImage(UIImage(named: "CheckBox_uncheck"), for: UIControlState.normal)
//
//
//      }
        
        return cell
    }
}
