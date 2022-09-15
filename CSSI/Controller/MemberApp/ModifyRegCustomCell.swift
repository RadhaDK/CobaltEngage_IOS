//
//  ModifyRegCustomCell.swift
//  CSSI
//
//  Created by apple on 2/27/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

protocol ModifyRegistration: AnyObject {
    func ModifyClicked(cell: ModifyRegCustomCell)
    func ModifyThreeDotsClicked(cell: ModifyRegCustomCell)

}
class ModifyRegCustomCell: UITableViewCell {

    @IBOutlet weak var btnThreeDots: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblID: UILabel!
    weak var delegate: ModifyRegistration?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func threeDotsClicked(_ sender: Any) {
        delegate?.ModifyThreeDotsClicked(cell: self)

        
    }
    @IBAction func closeClicked(_ sender: Any) {
        
        
        delegate?.ModifyClicked(cell: self)

    }
}
