//
//  AddBuddyCustomCell.swift
//  CSSI
//
//  Created by apple on 6/1/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//
protocol MemberCategoryDelegate: AnyObject {
    func CheckBoxClicked(cell: AddBuddyCustomCell)
    //func synchButtonClicked(cell: CustomDashBoardCell)
}
import UIKit

class AddBuddyCustomCell: UITableViewCell {

    @IBOutlet weak var btnCheckBox: UIButton!
    //@IBOutlet weak var lblName: UILabel!
    weak var delegate: MemberCategoryDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func checkBoxClicked(_ sender: Any) {
        delegate?.CheckBoxClicked(cell: self)

    }
    
}
