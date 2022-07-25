//
//  DTMonthViewCell.swift
//  Pods
//
//  Created by Tim Lemaster on 6/16/17.
//
//

import UIKit

class DTMonthViewCell: UICollectionViewCell {
    
    var userContentView: UIView? {
        didSet {
            
            if let oldValue = oldValue {
                oldValue.removeFromSuperview()
            }
            
            guard let userContentView = userContentView else { return }
            contentView.addSubview(userContentView)
            setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let userContentView = userContentView {
            userContentView.frame = CGRect(x: 35, y: 0, width: contentView.bounds.width, height: contentView.bounds.height)
        }
    }
}
