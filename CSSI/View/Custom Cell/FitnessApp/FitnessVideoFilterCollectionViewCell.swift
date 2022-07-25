//
//  FitnessVideoFilterCollectionViewCell.swift
//  CSSI
//
//  Created by Kiran on 12/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class FitnessVideoFilterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var optionsImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        self.nameLbl.font = AppFonts.regular12
        self.lineView.backgroundColor = APPColor.FitnessApp.categoryDeviderColor
    }

}
