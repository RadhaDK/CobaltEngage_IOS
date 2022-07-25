//
//  ModifyTableViewCell.swift
//  CSSI
//
//  Created by Kiran on 20/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit


protocol ModifyTableViewCellDelegate : NSObject {
    func removeClicked(cell : ModifyTableViewCell)
}


class ModifyTableViewCell: UITableViewCell
{

    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    weak var delegate : ModifyTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func removeClicked(_ sender: UIButton)
    {
        self.delegate?.removeClicked(cell: self)
    }
    
}
