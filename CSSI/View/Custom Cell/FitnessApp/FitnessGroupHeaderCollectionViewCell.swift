//
//  FitnessGroupHeaderCollectionViewCell.swift
//  CSSI
//
//  Created by Kiran on 14/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit
//Modified by kiran V2.4 -- GATHER0000176
class FitnessGroupHeaderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var activityLbl: UILabel!
    @IBOutlet weak var groupLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //Note:- If fonts are changed here, the change the fonts in collectionview section header size calculation. otherwise view will not adjust peroperly with text. in -- FitnessGroupsViewController
        self.activityLbl.font = AppFonts.regular16
        self.activityLbl.textColor = APPColor.textColor.fitnessGroupActivity
        
        self.groupLbl.font = AppFonts.bold24
        self.groupLbl.textColor = APPColor.textColor.secondary
        
    }

}
