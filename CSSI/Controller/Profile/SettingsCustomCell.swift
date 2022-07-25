//
//  SettingsCustomCell.swift
//  CSSI
//
//  Created by apple on 2/21/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

protocol settingDelegate: AnyObject {
    func settingSwitchClicked(cell: SettingsCustomCell)
    
}
class SettingsCustomCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var switchToOnOff: UISwitch!
    weak var delegate: settingDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchClicked(_ sender: Any) {
        delegate?.settingSwitchClicked(cell: self)

    }
}
