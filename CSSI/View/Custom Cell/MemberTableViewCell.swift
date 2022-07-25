//
//  MemberTableViewCell.swift
//  CSSI
//
//  Created by Kiran on 01/04/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {

    @IBOutlet weak var viewMainContent: UIView!
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMemberID: UILabel!
    @IBOutlet weak var lblVisit: UILabel!
    @IBOutlet weak var viewLine: UIView!
    
    var imageUrl : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblName.font = AppFonts.semibold17
        self.lblName.textColor = APPColor.textColor.primary
        
        self.lblMemberID.font = AppFonts.regular14
        self.lblMemberID.textColor = APPColor.textColor.primary
        
        self.lblVisit.font = AppFonts.regular14
        self.lblVisit.textColor = APPColor.textColor.primary
        
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        self.imgProfilePic.layer.cornerRadius = self.imgProfilePic.frame.height/2
        self.imgProfilePic.clipsToBounds = true
    }
}
