//
//  HeaderViewPlayHistory.swift
//  CSSI
//
//  Created by apple on 4/18/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class HeaderViewPlayHistory: UITableViewCell {
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblCaptainName: UILabel!
    @IBOutlet weak var lblCource: UILabel!
    @IBOutlet weak var lblTeeTimes: UILabel!
    @IBOutlet weak var lblLength: UILabel!
    @IBOutlet weak var lblGroupNo: UILabel!
    @IBOutlet weak var lblTopLine: UILabel!
    @IBOutlet weak var lblPlayDate: UILabel!
    
    @IBOutlet weak var lblConfirmedteeTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblGroupNo.textColor = APPColor.MainColours.primary1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
