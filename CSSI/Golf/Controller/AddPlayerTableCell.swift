//
//  AddPlayerTableCell.swift
//  CSSI
//
//  Created by EBS Admin on 14/02/23.
//  Copyright © 2023 yujdesigns. All rights reserved.
//

import UIKit
//protocol ModifyRegistrationGolf: AnyObject {
//    func ModifyClicked(cell: ModifyRegCustomGolfCell)
//    func ModifyThreeDotsClicked(cell: ModifyRegCustomGolfCell)
//    func transTextFieldSelected(textField : UITextField , cell : ModifyRegCustomGolfCell)
//    func selectedNineHoles(status : Bool , cell : ModifyRegCustomGolfCell) -> Bool
//}
//extension ModifyRegistrationGolf {
//    func transTextFieldSelected(textField : UITextField , cell : ModifyRegCustomGolfCell) {
//
//    }
//    func selectedNineHoles(status : Bool , cell : ModifyRegCustomGolfCell) -> Bool {
//
//        return false
//    }
//}
class AddPlayerTableCell: UITableViewCell {

    @IBOutlet weak var btnThreeDots: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var btnNineHoles: UIButton!
    @IBOutlet weak var textFieldTrans: UITextField!
    @IBOutlet weak var viewTransDetailsWidth: NSLayoutConstraint!
    @IBOutlet weak var lblIDWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btnNineHoles.setTitle("", for: .normal)
        self.btnNineHoles.setImage(UIImage.init(named: "CheckBox_check"), for: .selected)
        self.btnNineHoles.setImage(UIImage.init(named: "CheckBox_uncheck"), for: .normal)
        self.textFieldTrans.setRightIcon(imageName: "Path 1847",width: 30)
        self.textFieldTrans.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func threeDotsClicked(_ sender: Any) {
      //  delegate?.ModifyThreeDotsClicked(cell: self)
    }
    
    @IBAction func closeClicked(_ sender: Any) {
       // delegate?.ModifyClicked(cell: self)
    }
    
    @IBAction func nineHolesClicked(_ sender: UIButton) {
        
//        if self.delegate?.selectedNineHoles(status: !sender.isSelected, cell: self) == true {
//            sender.isSelected = !sender.isSelected
//        }
    }

}
extension AddPlayerTableCell : UITextFieldDelegate
{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == self.textFieldTrans
        {
         //   self.delegate?.transTextFieldSelected(textField: textField, cell: self)
            return false
        }
        return true
    }
}
