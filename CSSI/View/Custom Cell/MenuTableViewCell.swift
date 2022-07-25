//
//  MenuTableViewCell.swift
//  CSSI
//
//  Created by MACMINI13 on 08/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var uiViewLine: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var uiView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var imgIcon: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
