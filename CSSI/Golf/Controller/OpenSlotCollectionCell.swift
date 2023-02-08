//
//  OpenSlotCollectionCell.swift
//  CSSI
//
//  Created by Aks on 08/02/23.
//  Copyright © 2023 yujdesigns. All rights reserved.
//

import UIKit

class OpenSlotCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var lblPlayerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblPlayerName.layer.cornerRadius = 5
        viewBack.shadowView(viewName: viewBack)
    }
    
}
