//
//  AddPlayerTableCell.swift
//  CobaltUI
//
//  Created by Megha  on 15/02/23.
//

import UIKit

class AddPlayerTableCell: UITableViewCell {
    
    @IBOutlet weak var playerBackgroundView:UIView!
    @IBOutlet weak var txtPlayer:UITextField!
    @IBOutlet weak var btnDelete:UIButton!
    @IBOutlet weak var transBackgroundView:UIView!
    @IBOutlet weak var txtTrans:UITextField!
    @IBOutlet weak var imgCheckbox:UIImageView!
    @IBOutlet weak var btnCheckbox:UIButton!
    @IBOutlet weak var btnAdd:UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        playerBackgroundView.layer.cornerRadius = 6
        transBackgroundView.layer.cornerRadius = 6
        playerBackgroundView.layer.borderColor = UIColor.darkGray.cgColor
        transBackgroundView.layer.borderColor = UIColor.darkGray.cgColor
        playerBackgroundView.layer.borderWidth = 1
        transBackgroundView.layer.borderWidth = 1
        btnCheckbox.setTitle("", for: .normal)
        btnDelete.setTitle("", for: .normal)
        btnAdd.setTitle("", for: .normal)

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnAddMember(_ sender: Any) {
        
    }
    
    @IBAction func btnRemoveMember(_ sender: Any) {
        
    }
    
    @IBAction func btnTrans(_ sender: Any) {
        
    }
    
    @IBAction func btnNineHole(_ sender: Any) {
        
    }
    
    
    
    
    
    
}
