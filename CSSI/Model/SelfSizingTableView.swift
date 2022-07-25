//
//  SelfSizingTableView.swift
//  CSSI
//
//  Created by Kiran on 19/02/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class SelfSizingTableView: UITableView {
    
    override var contentSize: CGSize{
        didSet{
            self.invalidateIntrinsicContentSize()
            self.layoutIfNeeded()
        }
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize{
        let size = CGSize(width: self.contentSize.width, height: self.contentSize.height)
        return size
    }

}
