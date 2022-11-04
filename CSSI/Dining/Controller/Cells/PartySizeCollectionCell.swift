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
    var selectedSize: Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        partySizeCountLbl.layer.cornerRadius = partySizeCountLbl.frame.width/2
        partySizeCountLbl.layer.borderColor = hexStringToUIColor(hex: "5773A2").cgColor
        partySizeCountLbl.layer.borderWidth = 1.0
        
        if selectedSize == true {
            
        } else {
            partySizeCountLbl.textColor = .white
            partySizeCountLbl.layer.backgroundColor = UIColor(red: 1/255, green: 192/255, blue: 247/255, alpha: 1).cgColor
        }
    }
    
}
