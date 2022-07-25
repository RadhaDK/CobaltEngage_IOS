//
//  GiftCardTableViewCell.swift
//  CSSI
//
//  Created by apple on 1/25/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class GiftCardTableViewCell: UITableViewCell
{
    @IBOutlet weak var lblCertifiedCardTypeNumber: UILabel!
    @IBOutlet weak var lblCertifiedTypeName: UILabel!
    @IBOutlet weak var lblOriginalAmount: UILabel!
    @IBOutlet weak var lblBalanceAmount: UILabel!
    //Added by kiran V2.9 -- ENGAGE0011597 -- Adding 2 fields for description and count.
    //ENGAGE0011597 -- Start
    @IBOutlet weak var stackViewDetails: UIStackView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    //ENGAGE0011597 -- End
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //Added by kiran V2.9 -- ENGAGE0011597 -- Adding 2 fields for description and count.
        //ENGAGE0011597 -- Start
        self.setFontColor()
        //ENGAGE0011597 -- End
    }
    
    //Added by kiran V2.9 -- ENGAGE0011597 -- Adding 2 fields for description and count.
    //ENGAGE0011597 -- Start
    private func setFontColor()
    {
        self.lblDescription.font = AppFonts.regular17
        self.lblCount.font = AppFonts.regular17
        
        self.lblDescription.textColor = APPColor.textColor.primary
        self.lblCount.textColor = APPColor.textColor.primary
    }
    //ENGAGE0011597 -- End
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
