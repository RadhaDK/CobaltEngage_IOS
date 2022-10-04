//
//  AddGuestTableCell.swift
//  CSSI
//
//  Created by Aks on 04/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class AddGuestTableCell: UITableViewCell {

    @IBOutlet weak var viewBack: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBack.layer.cornerRadius = 5
        viewBack.layer.borderColor = UIColor.darkGray.cgColor
        viewBack.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
