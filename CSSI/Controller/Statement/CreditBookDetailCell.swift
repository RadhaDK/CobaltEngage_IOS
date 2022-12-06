//
//  CreditBookDetailCell.swift
//  CSSI
//
//  Created by Vishal Pandey on 06/12/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class CreditBookDetailCell: UITableViewCell {
    
    @IBOutlet weak var lblCreditBookName: UILabel!
    @IBOutlet weak var lblCreditAmt: UILabel!
    @IBOutlet weak var lblItemType: UILabel!
    @IBOutlet weak var lblAmtSpent: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblCreditBalance: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
