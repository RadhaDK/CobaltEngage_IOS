//
//  ImpContactsCustomCell.swift
//  CSSI
//
//  Created by apple on 11/16/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class ImpContactsCustomCell: UITableViewCell {

    @IBOutlet weak var btnPhone: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
