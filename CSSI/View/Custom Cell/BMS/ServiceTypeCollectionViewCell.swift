//
//  ServiceTypeCollectionViewCell.swift
//  CSSI
//
//  Created by Kiran on 29/05/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class ServiceTypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var serviceTypeImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var viewSelectionIndicator: UIView!
    
    private var contentWidthConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.mainContentView.layer.cornerRadius = 7
        self.mainContentView.clipsToBounds = true
        
    }
    
}
