//
//  ImportantNumberTableViewCell.swift
//  CSSI
//
//  Created by MACMINI13 on 26/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import FLAnimatedImage

class ImportantNumberTableViewCell: UITableViewCell {

//    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberName: UIButton!
    @IBOutlet weak var memberphono: UIButton!
    @IBOutlet weak var memberCall: UIButton!
    @IBOutlet weak var widthEmail: NSLayoutConstraint!
    @IBOutlet weak var emailIcon: UIButton!
    
    
    @IBOutlet weak var memberImage: FLAnimatedImageView!
    
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }


}
