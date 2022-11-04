//
//  DiningResvTableCell.swift
//  CSSI
//
//  Created by Aks on 03/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit


protocol DiningTimeSlotsDelegate {
    func SelectedDiningTimeSlot(timeSlot : String, row: Int)
}

class DiningResvTableCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var collectionTimeSlot: UICollectionView!
    @IBOutlet weak var lblPartySize: UILabel!
    @IBOutlet weak var lblUpcomingEvent: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var heightUpcoming: NSLayoutConstraint!
    
    var timeSlots: [DiningTimeSlots] = []
    var timeSlotsDelegate: DiningTimeSlotsDelegate?
    var row = 0
    var selectedTimeSlot = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionTimeSlot.delegate = self
        collectionTimeSlot.dataSource = self
        print(timeSlots)
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
//        return 1
        return timeSlots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DinningReservationTimeSlotCollectionCell", for: indexPath) as! DinningReservationTimeSlotCollectionCell
        
        cell.lblTime.text = self.timeSlots[indexPath.row].timeSlot
        if selectedTimeSlot != self.timeSlots[indexPath.row].timeSlot {
            cell.viewTimeSlotBack.backgroundColor = UIColor(hexString: "#5773A2")
        } else {
            cell.viewTimeSlotBack.backgroundColor = .systemBlue
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 80, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.timeSlotsDelegate?.SelectedDiningTimeSlot(timeSlot: self.timeSlots[indexPath.row].timeSlot, row: self.row)
        
    }
}
