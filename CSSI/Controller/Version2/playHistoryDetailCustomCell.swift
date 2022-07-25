//
//  playHistoryDetailCustomCell.swift
//  CSSI
//
//  Created by apple on 4/18/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class playHistoryDetailCustomCell: UITableViewCell {

   
    @IBOutlet weak var lblPlayer1Text: UILabel!
    @IBOutlet weak var btnPlayed: UIButton!
    @IBOutlet weak var lblGroupMemberName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
