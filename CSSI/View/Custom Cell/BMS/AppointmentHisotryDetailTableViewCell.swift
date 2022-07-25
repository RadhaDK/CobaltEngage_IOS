//
//  AppointmentHisotryDetailTableViewCell.swift
//  CSSI
//
//  Created by Kiran on 30/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class AppointmentHisotryDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var ViewLine: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnStatus: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.btnStatus.layer.cornerRadius = self.btnStatus.frame.height/2
        self.btnStatus.clipsToBounds = true
    }
    
}
