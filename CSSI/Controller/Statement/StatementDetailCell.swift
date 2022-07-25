//
//  StatementDetailCell.swift
//  CSSI
//
//  Created by apple on 1/26/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class StatementDetailCell: UITableViewCell {

    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblSKUNo: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
