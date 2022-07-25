//
//  CustomMultipleSelectionCell.swift
//  CSSI
//
//  Created by Apple on 27/09/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class CustomMultipleSelectionCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lbldays: UILabel!
    @IBOutlet weak var lblDateRange: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
