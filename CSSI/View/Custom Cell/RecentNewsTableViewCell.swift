//
//  RecentNewsTableViewCell.swift
//  CSSI
//
//  Created by Kiran on 18/03/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class RecentNewsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viewSeparator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
