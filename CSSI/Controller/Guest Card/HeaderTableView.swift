//
//  CustomMultipleSelectionCell.swift
//  Sample
//
//  Created by Apple on 29/09/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class HeaderTableView: UITableViewCell {

    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblLastVisited: UILabel!
    @IBOutlet weak var guestID: UILabel!
    @IBOutlet weak var lblDaterange: UILabel!
    @IBOutlet weak var lblGuestName: UILabel!
    @IBOutlet weak var daysVisited: UILabel!
    @IBOutlet weak var lblTotalDays: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgImage.layer.cornerRadius = imgImage.frame.size.width/2
        
        imgImage.clipsToBounds = true
    }

  
    
}
