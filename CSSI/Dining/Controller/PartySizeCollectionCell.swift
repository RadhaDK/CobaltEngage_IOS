//
//  PartySizeCollectionCell.swift
//  CSSI
//
//  Created by Aks on 05/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class PartySizeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var partySizeCountLbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        partySizeCountLbl.layer.cornerRadius = partySizeCountLbl.frame.width/2
        partySizeCountLbl.layer.borderColor = hexStringToUIColor(hex: "5773A2").cgColor
        partySizeCountLbl.layer.borderWidth = 1.0

    
    }
    
}
