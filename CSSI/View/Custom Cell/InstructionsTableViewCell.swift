//
//  InstructionsTableViewCell.swift
//  CSSI
//
//  Created by Kiran on 19/02/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class InstructionsTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewInstruction: UIImageView!
    @IBOutlet weak var lblInstruction: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
