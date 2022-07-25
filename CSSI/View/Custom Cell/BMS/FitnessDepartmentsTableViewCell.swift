//
//  FitnessDepartmentsTableViewCell.swift
//  CSSI
//
//  Created by Kiran on 27/05/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class FitnessDepartmentsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var departmentImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
