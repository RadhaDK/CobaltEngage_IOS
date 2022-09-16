//
//  EditMembershipTypeTableViewCell.swift
//  CSSI
//
//  Created by Vishal Pandey on 05/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class EditMembershipTypeTableViewCell: UITableViewCell {
    @IBOutlet weak var ViewBack: UIView!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var imgExpand: UIImageView!
    @IBOutlet weak var stackData: UIStackView!

    @IBOutlet weak var lblMembershipType: UILabel!
    @IBOutlet weak var lblMembershipDescription: UILabel!

    var openClose:(()->())?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // btnPlus.setTitle("", for: .normal)
      //  lblMembershipDescription.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnOpenCell(_ sender: UIButton) {
        self.openClose?()
    }
    
    
}
