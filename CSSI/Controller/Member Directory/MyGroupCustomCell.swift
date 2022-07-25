//
//  MyGroupCustomCell.swift
//  CSSI
//
//  Created by apple on 4/22/19.
//  Copyright © 2019 yujdesigns. All rights reserved.

import UIKit
protocol MyGroupCellDelegate: AnyObject {

func editButtonClicked(cell: MyGroupCustomCell)
func removeButtonClicked(cell: MyGroupCustomCell)

}
class MyGroupCustomCell: UITableViewCell {

    @IBOutlet weak var viewDelete: UIView!
    @IBOutlet weak var lblgroupName: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var imgGroup: UIImageView!
    @IBOutlet weak var mainView: UIView!
    weak var delegate: MyGroupCellDelegate?
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewEdit: UIView!
    @IBOutlet weak var imgHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let delete = UITapGestureRecognizer(target: self, action:  #selector(self.deleteClicked(sender:)))
        self.viewDelete.addGestureRecognizer(delete)
        
        let edit = UITapGestureRecognizer(target: self, action:  #selector(self.editViewClicked(sender:)))
        self.viewEdit.addGestureRecognizer(edit)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func removeClicked(_ sender: Any) {
        
       // delegate?.removeButtonClicked(cell: self)

        
    }
    @IBAction func editClicked(_ sender: Any) {
        
       // delegate?.editButtonClicked(cell: self)

        
    }
    
    @objc func deleteClicked(sender : UITapGestureRecognizer) {
        delegate?.removeButtonClicked(cell: self)
    }
    @objc func editViewClicked(sender : UITapGestureRecognizer) {
        delegate?.editButtonClicked(cell: self)
    }
    
    
    
}
