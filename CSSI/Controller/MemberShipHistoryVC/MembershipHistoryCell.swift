//
//  MembershipHistoryCell.swift
//  CSSI
//
//  Created by Vishal Pandey on 06/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class MembershipHistoryCell: UITableViewCell {
    
    @IBOutlet weak var currentMemTypeHeadingLbl: UILabel!
    @IBOutlet weak var newMemTypeHeadingLbl: UILabel!
    @IBOutlet weak var requestedOnHeadingLbl: UILabel!
    @IBOutlet weak var statusHeadingLbl: UILabel!
    @IBOutlet weak var reasonHeadingLbl: UILabel!
    
    @IBOutlet weak var currentMemTypeLbl: UILabel!
    @IBOutlet weak var newMemTypeLbl: UILabel!
    @IBOutlet weak var requestedOnLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var reasonLbl: UILabel!
    @IBOutlet weak var viewReason: UIView!
    
    @IBOutlet weak var viewReasonBack: UIView!

    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
  
    override func awakeFromNib() {
        super.awakeFromNib()
        statusLbl.layer.cornerRadius = 4
        statusLbl.layer.masksToBounds = true
        
     
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
