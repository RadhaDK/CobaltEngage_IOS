//
//  DinningReservationTimeSlotCollectionCell.swift
//  CSSI
//
//  Created by Aks on 03/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class DinningReservationTimeSlotCollectionCell: UICollectionViewCell {
    @IBOutlet weak var viewTimeSlotBack: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewTimeSlotBack.layer.cornerRadius = 4
    }

}
