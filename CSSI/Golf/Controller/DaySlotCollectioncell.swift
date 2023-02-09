//
//  DaySlotCollectioncell.swift
//  CSSI
//
//  Created by Aks on 08/02/23.
//  Copyright © 2023 yujdesigns. All rights reserved.
//

import UIKit

class DaySlotCollectioncell: UICollectionViewCell {
    
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var viewBack: UIView!
    
    override var isSelected: Bool {
        didSet {
            viewBack.layer.backgroundColor = isSelected ? UIColor(red: 2/255, green: 198/255, blue: 254/255, alpha: 1).cgColor : UIColor.white.cgColor
            lblMonth.textColor = isSelected ? .white : .black
            lblDay.textColor = isSelected ? .white : UIColor(red: 184/255, green: 183/255, blue: 183/255, alpha: 1)

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 8
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1
    }
    
}
