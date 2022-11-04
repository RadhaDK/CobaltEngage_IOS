//
//  AddGuestModifyTableCell.swift
//  CSSI
//
//  Created by Admin on 11/4/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class AddGuestModifyTableCell: UITableViewCell {

    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var lblConfirmationNumber: UILabel!
    @IBOutlet weak var btnRemoveMember: UIButton!
    
    var removeFromSlotClosure:(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnRemoveMemberAction(_ sender: Any) {
        removeFromSlotClosure?()
    }
}
