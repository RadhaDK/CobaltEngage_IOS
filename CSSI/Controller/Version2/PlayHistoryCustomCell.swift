//
//  PlayHistoryCustomCell.swift
//  CSSI
//
//  Created by apple on 4/17/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class PlayHistoryCustomCell: UITableViewCell {
    @IBOutlet weak var lbldateAndtime: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblID: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
