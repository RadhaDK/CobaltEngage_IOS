//
//  HeaderViewEventDetails.swift
//  CSSI
//
//  Created by apple on 4/29/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class HeaderViewEventDetails: UITableViewCell {

    @IBOutlet weak var lblCourse: UILabel!
    @IBOutlet weak var lblStatusText: UILabel!
    @IBOutlet weak var lblTeeTime: UILabel!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var lblCaptainName: UILabel!
    @IBOutlet weak var lblGroup: UILabel!
    @IBOutlet weak var lblConfirmationNumber: UILabel!
    @IBOutlet weak var lblCaptainNameText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
