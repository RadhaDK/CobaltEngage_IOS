//
//  NotificationListTableViewCell.swift
//  CSSI
//
//  Created by Samadhan on 11/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class NotificationListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblNotificationdetails: UILabel!
    
    @IBOutlet weak var lblColor: UILabel!
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var lblNotificationDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
