//
//  ModifyRequestHeaderView.swift
//  CSSI
//
//  Created by apple on 5/13/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit
protocol ModifyDelegate: AnyObject {
    func addNewButtonClicked(cell: ModifyRequestHeaderView)
    func deleteButtonClicked(cell: ModifyRequestHeaderView)
    func waitListClicked(cell : ModifyRequestHeaderView)
}

extension ModifyDelegate{
    
    func waitListClicked(cell : ModifyRequestHeaderView)
    {
        
    }
}

class ModifyRequestHeaderView: UITableViewCell {

    @IBOutlet weak var btnAddNew: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblCaptainName: UILabel!
    @IBOutlet weak var lblGroupNumber: UILabel!
    @IBOutlet weak var heightBWGroup: NSLayoutConstraint!
    @IBOutlet weak var lblConfirmNumber: UILabel!
    @IBOutlet weak var lblCourseValue: UILabel!
    @IBOutlet weak var txtAddMemberOrGuest: UITextField!
    @IBOutlet weak var lblTimeValue: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblStatusValue: UIButton!
    
    @IBOutlet weak var viewWaitlist: UIView!
    @IBOutlet weak var btnWaitlist: UIButton!
    @IBOutlet weak var lblHolesHeader: UILabel!
    @IBOutlet weak var lblTransHeader: UILabel!
    @IBOutlet weak var lblRoundLength: UILabel!
    
    
    var delegate: ModifyDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func deleteClicked(_ sender: Any) {
        delegate?.deleteButtonClicked(cell: self)
    }
    @IBAction func addPopOverClicked(_ sender: Any) {
        delegate?.addNewButtonClicked(cell: self)
    }
    
    @IBAction func waitlistClicked(_ sender: UIButton) {
        self.delegate?.waitListClicked(cell: self)
    }
    
}
