//
//  FooterTableViewCell.swift
//  Sample
//
//  Created by Apple on 29/09/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class FooterTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTotalDays: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
