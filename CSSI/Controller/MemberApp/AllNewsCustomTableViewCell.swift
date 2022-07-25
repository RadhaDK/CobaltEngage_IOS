//
//  AllNewsCustomTableViewCell.swift
//  CSSI
//
//  Created by apple on 10/31/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class AllNewsCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNewsTitle: UILabel!
    @IBOutlet weak var lblNewsBy: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblGuestName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
