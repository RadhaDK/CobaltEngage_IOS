//
//  MultiSelectionCollectionViewCell.swift
//  CSSI
//
//  Created by Kiran on 10/02/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

protocol MultiSelectionCollectionViewCellDelegate : NSObject {
    func didSelectCancel(cell : MultiSelectionCollectionViewCell)
}

extension MultiSelectionCollectionViewCellDelegate
{
    func didSelectCancel(cell : MultiSelectionCollectionViewCell)
    
    {
        
    }
}

class MultiSelectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var viewSkipIndicator: UIView!
    
    weak var delegate : MultiSelectionCollectionViewCellDelegate?
    
    var isSkipped = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageViewProfile.layer.cornerRadius = self.imageViewProfile.frame.height/2
        self.imageViewProfile.layer.masksToBounds = false
        self.imageViewProfile.clipsToBounds = true
        
    }
    
    
    @IBAction func cancelClicked(_ sender: UIButton) {
        self.delegate?.didSelectCancel(cell: self)
    }
}
