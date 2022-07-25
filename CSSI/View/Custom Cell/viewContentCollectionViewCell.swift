//
//  viewContentCollectionViewCell.swift
//  CSSI
//
//  Created by Kiran on 15/05/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class viewContentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var contentScrollView: UIScrollView!
    ///UIview which conatins of the scroll view
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var contentScrollViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentScrollViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentScrollVIewRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentScrollVIewLeftConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func applyPading(_ padding : CGFloat)
    {
        self.contentScrollViewTopConstraint.constant = padding
        self.contentScrollViewBottomConstraint.constant = padding
        self.contentScrollVIewLeftConstraint.constant = padding
        self.contentScrollVIewRightConstraint.constant = padding
        self.layoutIfNeeded()
    }
}
