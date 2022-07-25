//
//  RecentNewsCustomCell.swift
//  CSSI
//
//  Created by apple on 11/15/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class RecentNewsCustomCell: UITableViewCell {

    @IBOutlet weak var lblNewsDate: UILabel!
    @IBOutlet weak var lblNews: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
