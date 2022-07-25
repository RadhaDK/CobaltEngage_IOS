//
//  FitnessGroupCollectionViewCell.swift
//  CSSI
//
//  Created by Kiran on 14/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class FitnessGroupCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var groupImgView: UIImageView!
    @IBOutlet weak var groupNameLbl: UILabel!
    @IBOutlet weak var exercisesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.groupNameLbl.font = AppFonts.bold18
        self.groupNameLbl.textColor = APPColor.textColor.whiteText
        
        self.exercisesLbl.font = AppFonts.regular14
        self.exercisesLbl.textColor = APPColor.textColor.whiteText
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.layer.cornerRadius = 16
        self.contentView.clipsToBounds = true
    }
}
