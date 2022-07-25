//
//  AlertDetailCollectionViewCell.swift
//  CSSI
//
//  Created by Kiran on 30/10/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit


//Added by kiran -- ENGAGE0011226 -- added for Covid rules
class AlertDetailCollectionViewCell: UICollectionViewCell
{

    @IBOutlet weak var sectionImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainContentView: UIView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        self.nameLbl.font = AppFonts.semibold18
        self.nameLbl.textColor = APPColor.textColor.secondary
    }

}
