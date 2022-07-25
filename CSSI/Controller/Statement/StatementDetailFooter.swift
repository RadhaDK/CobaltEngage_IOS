//
//  StatementDetailFooter.swift
//  CSSI
//
//  Created by apple on 1/26/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class StatementDetailFooter: UITableViewCell {
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblYouSaved: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblSavedValue: UILabel!
    
    @IBOutlet weak var lblTip: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblTotalValue: UILabel!
    @IBOutlet weak var lblTipValue: UILabel!
    @IBOutlet weak var lblSubTotalValue: UILabel!
    @IBOutlet weak var lblTaxValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
