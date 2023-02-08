//
//  AvailableCoursesGolfCell.swift
//  CSSI
//
//  Created by Aks on 08/02/23.
//  Copyright © 2023 yujdesigns. All rights reserved.
//

import UIKit

class AvailableCoursesGolfCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //MARK: - IBOutlets
    @IBOutlet weak var collectionSlot: UICollectionView!
    @IBOutlet weak var lblPlayerName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var viewBack: UIView!

    var row = 0
    var selectedTimeSlot = ""
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
//        return 1
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OpenSlotCollectionCell", for: indexPath) as! OpenSlotCollectionCell
        
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
}
