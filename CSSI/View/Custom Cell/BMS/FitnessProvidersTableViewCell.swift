//
//  FitnessProvidersTableViewCell.swift
//  CSSI
//
//  Created by Kiran on 27/05/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class FitnessProvidersTableViewCell: UITableViewCell
{

    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var providerPicImgView: UIImageView!
    @IBOutlet weak var providerNameLbl: UILabel!
    
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
        
        self.providerPicImgView.layer.cornerRadius = self.providerPicImgView.bounds.width/2
        self.providerPicImgView.clipsToBounds = true
    }
    
}
