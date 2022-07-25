//
//  SwitchToLotteryCollectionViewCell.swift
//  CSSI
//
//  Created by Admin on 5/12/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class SwitchToLotteryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewSwitchToLotteryLabel: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewSwitchToLotteryLabel.backgroundColor = APPColor.navigationColor.barbackgroundcolor
        
    }

    func roundCoronors() {
        viewSwitchToLotteryLabel.layer.cornerRadius = CGFloat(viewSwitchToLotteryLabel.frame.height/2)
        viewSwitchToLotteryLabel.clipsToBounds = true
    }
    
}
