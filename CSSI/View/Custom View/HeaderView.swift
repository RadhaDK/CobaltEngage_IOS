//
//  TableViewHeader.swift
//  CSSI
//
//  Created by Kiran on 17/03/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet weak var contentView : UIView!
    @IBOutlet weak var lblTitle: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func setUpView()
    {
        Bundle.main.loadNibNamed("HeaderView", owner: self, options: [:])
        contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        self.addSubview(self.contentView)
    }
}
