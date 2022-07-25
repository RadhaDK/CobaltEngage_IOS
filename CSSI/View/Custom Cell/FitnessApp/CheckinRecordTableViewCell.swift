//
//  CheckinRecordTableViewCell.swift
//  CSSI
//
//  Created by Kiran on 28/10/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class CheckinRecordTableViewCell: UITableViewCell
{
    @IBOutlet weak var radioBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var goalimgView: UIImageView!
    @IBOutlet weak var progressLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.dateLbl.font = AppFonts.semibold16
        self.dateLbl.textColor = APPColor.textColor.primary
        
        self.progressLbl.font = AppFonts.regular16
        self.progressLbl.textColor = APPColor.textColor.primary
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
