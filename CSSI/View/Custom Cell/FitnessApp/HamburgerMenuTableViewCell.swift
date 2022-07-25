//
//  HamburgerMenuTableViewCell.swift
//  CSSI
//
//  Created by Kiran on 11/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class HamburgerMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.menuNameLbl.font = AppFonts.regular20
        self.menuNameLbl.textColor = APPColor.textColor.primary
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
