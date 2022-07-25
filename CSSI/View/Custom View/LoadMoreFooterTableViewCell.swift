//
//  LoadMoreFooterTableViewCell.swift
//  CSSI
//
//  Created by Kiran on 16/04/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

import UIKit

class LoadMoreFooterTableViewCell: UITableViewCell
{

    @IBOutlet weak var btnLoadMore: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.btnLoadMore.translatesAutoresizingMaskIntoConstraints = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.btnLoadMore.setStyle(style: .outlined, type: .primary)
    }
}
