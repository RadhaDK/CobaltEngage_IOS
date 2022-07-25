//
//  RequestTableViewCell.swift
//  CSSI
//
//  Created by Kiran on 15/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

protocol RequestTableViewCellDelegate : NSObject {
    func didClickClear(cell : RequestTableViewCell)
    func didClickAdd(cell : RequestTableViewCell)
    func didClickEdit(cell : RequestTableViewCell)
}



class RequestTableViewCell: UITableViewCell
{
    @IBOutlet weak var viewMember: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    
    weak var delegate : RequestTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.viewMember.layer.cornerRadius = 6.0
        self.viewMember.clipsToBounds = true
        self.viewMember.layer.borderColor = hexStringToUIColor(hex: "#2D2D2D").cgColor
        self.viewMember.layer.borderWidth = 0.25
        
        self.btnClear.layer.borderWidth = 0.25
        self.btnClear.layer.borderColor = hexStringToUIColor(hex: "#2D2D2D").cgColor
        self.btnClear.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clearClicked(_ sender: UIButton)
    {
        self.delegate?.didClickClear(cell: self)
    }
    
    @IBAction func addClicked(_ sender: UIButton)
    {
        self.delegate?.didClickAdd(cell: self)
    }
    
    @IBAction func editClicked(_ sender: UIButton)
    {
        self.delegate?.didClickEdit(cell: self)
    }
    
}
