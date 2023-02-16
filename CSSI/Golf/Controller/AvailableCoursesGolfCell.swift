//
//  AvailableCoursesGolfCell.swift
//  CSSI
//
//  Created by Aks on 08/02/23.
//  Copyright © 2023 yujdesigns. All rights reserved.
//

import UIKit
protocol GolfSlotsDelegate {
    func SelectedGolfSlotSlot(timeSlot : String, row: Int)
}

class AvailableCoursesGolfCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //MARK: - IBOutlets
    @IBOutlet weak var collectionSlot: UICollectionView!
    @IBOutlet weak var lblPlayerName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var viewBack: UIView!

    var row = 0
    var selectedTimeSlot = ""
    var golfSlotsDelegate : GolfSlotsDelegate?
    var arrAvailableSlot = [GolfAvailableTimeSlotData]()

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionSlot.delegate = self
        collectionSlot.dataSource = self
        lblTime.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    
    //MARK: - Collectionview Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrAvailableSlot[section].PlayersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OpenSlotCollectionCell", for: indexPath) as! OpenSlotCollectionCell
        let dict = arrAvailableSlot[indexPath.section].PlayersList[indexPath.row]
        if dict.IsEnable == 0{
            cell.lblPlayerName.text = dict.PlayerName
            cell.viewBack.backgroundColor = UIColor.white
            cell.lblPlayerName.textColor = UIColor.darkGray
            cell.isUserInteractionEnabled = false
        }
        else{
            cell.lblPlayerName.text = "Open"
            cell.viewBack.backgroundColor = UIColor(red: 2/255, green: 198/255, blue: 254/255, alpha: 1)
            cell.lblPlayerName.textColor = UIColor.white
            cell.isUserInteractionEnabled = true
        }
//        if selectedTimeSlot != self.timeSlots[indexPath.row].timeSlot {
//            cell.viewBack.backgroundColor = UIColor(hexString: "#5773A2")
//        } else {
//            cell.viewBack.backgroundColor = .systemBlue
//        }
      
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionSlot.frame.size.width - space) / 2.0
        let sizeh:CGFloat = (collectionSlot.frame.size.height - space) / 2.0
        return CGSize(width: size, height: sizeh)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.golfSlotsDelegate?.SelectedGolfSlotSlot(timeSlot: "test", row: 1)
    }
}
