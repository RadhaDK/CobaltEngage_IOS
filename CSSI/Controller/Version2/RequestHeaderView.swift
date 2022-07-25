
//
//  RequestHeaderView.swift
//  CSSI
//
//  Created by apple on 4/19/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit


class RequestHeaderView: UITableViewCell {

    @IBOutlet weak var lblCaptainName: UILabel!
    @IBOutlet weak var lblGroupNumber: UILabel!
    @IBOutlet weak var viewGroupNumber: UIView!
    
    //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
    //PROD0000202 -- Start
    @IBOutlet weak var viewOptionHeaders: UIView!
    @IBOutlet weak var lblTrance: UILabel!
    @IBOutlet weak var lblNineHoles: UILabel!
    //PROD0000202 -- End
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
        //PROD0000202 -- Start
        self.lblTrance.font = AppFonts.semibold18
        self.lblTrance.textColor = APPColor.textColor.primary
        self.lblNineHoles.font = AppFonts.semibold18
        self.lblNineHoles.textColor = APPColor.textColor.primary
        //PROD0000202 -- End
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
