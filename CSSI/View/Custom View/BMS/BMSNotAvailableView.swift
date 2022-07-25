//
//  BMSNotAvailableView.swift
//  CSSI
//
//  Created by Kiran on 17/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class BMSNotAvailableView: UIView {

    @IBOutlet var contentView: UIView!
 
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var imgViewIcon: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.mainContentView.layer.cornerRadius = 15
        self.mainContentView.applyShadow(color: hexStringToUIColor(hex: "#00000045"), radius: 3, offset: CGSize.init(width: 0, height: 3), opacity: 0.6)
        self.mainContentView.layer.masksToBounds = false
    }
    
    
    @IBAction func TapAction(_ sender: UITapGestureRecognizer) {
        self.removeFromSuperview()
    }
}

extension BMSNotAvailableView
{
    private func setupView()
    {
        Bundle.main.loadNibNamed("BMSNotAvailableView", owner: self, options: [:])
         self.contentView.frame = self.bounds
        
         self.addSubview(self.contentView)
         
         //If not disabled auto resizing masks are messing with the layout of lables and not calculating the size properlly
         self.contentView.translatesAutoresizingMaskIntoConstraints = false
         
         //Auto resizing masks conflictiong with autolayouts so switched with auto layout
         NSLayoutConstraint.init(item: self.contentView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
         NSLayoutConstraint.init(item: self.contentView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
         NSLayoutConstraint.init(item: self.contentView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
         NSLayoutConstraint.init(item: self.contentView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
         self.layoutIfNeeded()
        
    }
}
