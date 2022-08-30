//
//  TransactionDetailTableViewCell.swift
//  CSSI
//
//  Created by Admin on 8/17/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class TransactionDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lblReceiptID: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblTotal.textColor = APPColor.MainColours.primary2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
