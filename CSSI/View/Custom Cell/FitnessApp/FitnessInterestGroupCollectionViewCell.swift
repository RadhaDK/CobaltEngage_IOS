//
//  FitnessInterestGroupCollectionViewCell.swift
//  CSSI
//
//  Created by Kiran on 16/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class FitnessInterestGroupCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.nameLbl.font = AppFonts.regular17
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.layer.cornerRadius = 9
        self.contentView.layer.borderColor = APPColor.OtherColors.groupBorderColor.cgColor
        self.contentView.layer.borderWidth = 1
        
        self.contentView.clipsToBounds = true
        
    }
}
