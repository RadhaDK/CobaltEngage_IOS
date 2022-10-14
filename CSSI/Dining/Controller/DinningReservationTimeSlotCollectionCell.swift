//
//  DinningReservationTimeSlotCollectionCell.swift
//  CSSI
//
//  Created by Aks on 03/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class DinningReservationTimeSlotCollectionCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewTimeSlotBack: UIView!
    @IBOutlet weak var btnTime: UIButton!
    var addToSlotClosure:(()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        viewTimeSlotBack.layer.cornerRadius = 4
        btnTime.setTitle("", for: .normal)
    }
    @IBAction func btnTime(_ sender: Any) {
        addToSlotClosure?()
    }
}
