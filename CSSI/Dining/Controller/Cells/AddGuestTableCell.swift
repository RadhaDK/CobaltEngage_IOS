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
    @IBOutlet weak var lblSlotMember: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnRemoveMember: UIButton!
    var addToSlotClosure:(()->())?
    var removeFromSlotClosure:(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBack.layer.cornerRadius = 5
        viewBack.layer.borderColor = UIColor.lightGray.cgColor
        viewBack.layer.borderWidth = 1
        btnAdd.setTitle("", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func btnRemoveMemberAction(_ sender: Any) {
        removeFromSlotClosure?()
    }
    @IBAction func btnAdd(_ sender: Any) {
        addToSlotClosure?()
    }
}
