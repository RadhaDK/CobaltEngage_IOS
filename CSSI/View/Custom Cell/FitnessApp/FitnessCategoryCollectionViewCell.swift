//
//  FitnessCategoryCollectionViewCell.swift
//  CSSI
//
//  Created by Kiran on 23/10/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class FitnessCategoryCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var categoryImageView: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.nameLbl.font = AppFonts.regular12
        self.nameLbl.textColor = APPColor.textColor.secondary
    }

}
