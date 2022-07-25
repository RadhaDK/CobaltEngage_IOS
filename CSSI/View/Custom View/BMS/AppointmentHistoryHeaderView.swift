//
//  AppointmentHistoryHeaderView.swift
//  CSSI
//
//  Created by Kiran on 30/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class AppointmentHistoryHeaderView: UITableViewCell {

    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lblConfirmationNunber: UILabel!
    @IBOutlet weak var lblService: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblDurationValue: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var lblCommentsValue: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblService.textColor = APPColor.MainColours.primary1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
