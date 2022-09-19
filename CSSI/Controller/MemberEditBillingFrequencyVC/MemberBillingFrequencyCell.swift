//
//  MemberBillingFrequencyCell.swift
//  CSSI
//
//  Created by Aks on 18/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class MemberBillingFrequencyCell: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var billingAmountView: UIView!
    @IBOutlet weak var txtTypeBilling: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        txtTypeBilling.tintColor = UIColor.clear
        
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
