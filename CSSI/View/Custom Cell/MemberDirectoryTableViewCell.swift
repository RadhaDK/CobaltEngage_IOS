//
//  MemberDirectoryTableViewCell.swift
//  CSSI
//
//  Created by MACMINI13 on 28/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import FLAnimatedImage


class MemberDirectoryTableViewCell: UITableViewCell {
//    @IBOutlet weak var imgMemberprofilepic: UIImageView!
//    @IBOutlet weak var btnMemberName: UIButton!
//    @IBOutlet weak var imgRightarrow: UIImage!

    @IBOutlet weak var imgMemberprofilepic: FLAnimatedImageView!
    @IBOutlet weak var imgRightarrow: UIImageView!
    @IBOutlet weak var lblMemberID: UILabel!
    @IBOutlet weak var memberIDHeight: NSLayoutConstraint!
    @IBOutlet weak var lblMemberName: UILabel!
    var imageUrl : String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
