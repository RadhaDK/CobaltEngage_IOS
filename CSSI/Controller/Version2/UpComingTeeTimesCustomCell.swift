//
//  UpComingTeeTimesCustomCell.swift
//  CSSI
//
//  Created by apple on 4/18/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class UpComingTeeTimesCustomCell: UITableViewCell {

    @IBOutlet weak var lblGroupText: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblNoPlayers: UILabel!
    @IBOutlet weak var lblTennisType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblNoPlayers.textColor = APPColor.MainColours.primary1
        self.lblTennisType.textColor = APPColor.MainColours.primary1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
