//
//  ProviderDetailsHeaderView.swift
//  CSSI
//
//  Created by Kiran on 27/05/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class ProviderDetailsHeaderView: UIView
{

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typelbl: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadView()
        
    }
    
    private func loadView()
    {
        Bundle.main.loadNibNamed("ProviderDetailsHeaderView", owner: self, options: [:])
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
        
        self.initialSetups()
    }
}

//MARK:- Custom Methods
extension ProviderDetailsHeaderView
{
    private func initialSetups()
    {
        self.mainContentView.applyShadow(color: hexStringToUIColor(hex: "#00000029"), radius: 3, offset: CGSize.init(width: 0, height: 3), opacity: 0.8)
    }
}
