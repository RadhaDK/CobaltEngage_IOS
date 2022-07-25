//
//  InstructionVideoCollectionViewCell.swift
//  CSSI
//
//  Created by Kiran on 24/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit
import WebKit

class InstructionVideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgViewBG: UIImageView!
    @IBOutlet weak var webViewVideo: WKWebView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
