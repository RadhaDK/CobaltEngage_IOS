//
//  FitnessActivityCollectionViewCell.swift
//  CSSI
//
//  Created by Kiran on 16/10/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class FitnessActivityCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.nameLbl.font = AppFonts.semibold22
        self.nameLbl.textColor = APPColor.textColor.primary
        
    }

}
