//
//  MenusAndHoursTableViewCell.swift
//  CSSI
//
//  Created by apple on 1/27/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class MenusAndHoursTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var imgMenuIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
