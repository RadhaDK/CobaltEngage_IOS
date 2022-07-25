//
//  GuestNameSuggestionTableViewCell.swift
//  CSSI
//
//  Created by Kiran on 16/04/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

import UIKit

class GuestNameSuggestionTableViewCell: UITableViewCell
{
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblName.font = AppFonts.semibold16
        self.lblName.textColor = APPColor.textColor.primary
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
