//
//  GuestSelectionTableViewCell.swift
//  CSSI
//
//  Created by Prashamsa on 30/10/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class GuestSelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        checkboxButton.isSelected = selected
    }
    
}
