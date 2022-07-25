//
//  RequestCardTableViewCell.swift
//  CSSI
//
//  Created by MACMINI13 on 30/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class RequestCardTableViewCell: UITableViewCell {
    @IBOutlet weak var lblGuestName: UILabel!
    @IBOutlet weak var btnIsCheck: UIButton!

    @IBOutlet weak var uiView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
