//
//  DiningResvTableCell.swift
//  CSSI
//
//  Created by Aks on 03/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class DiningResvTableCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var collectionTimeSlot: UICollectionView!
    @IBOutlet weak var lblPartySize: UILabel!
    @IBOutlet weak var lblUpcomingEvent: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var heightUpcoming: NSLayoutConstraint!
    
    var timeSlots: [DiningTimeSlots] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionTimeSlot.delegate = self
        collectionTimeSlot.dataSource = self
        registerNibs()
    }
    
    
    //MARK: - xib registration
    func registerNibs(){
        let menuNib = UINib(nibName: "DinningReservationTimeSlotCollectionCell" , bundle: nil)
        self.collectionTimeSlot.register(menuNib, forCellWithReuseIdentifier: "DinningReservationTimeSlotCollectionCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    //MARK: - Collectionview Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeSlots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DinningReservationTimeSlotCollectionCell", for: indexPath) as! DinningReservationTimeSlotCollectionCell
        
        cell.lblTime.text = self.timeSlots[indexPath.row].timeSlot
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 80, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DinningDetailRestuarantVC") as? DinningDetailRestuarantVC
        vc!.showNavigationBar = false
        vc?.selectedPartySize = 4
        self.parentViewController?.navigationController?.pushViewController(vc!, animated: true)
    }
}
