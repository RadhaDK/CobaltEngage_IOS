//
//  DiningFCFSEventCell.swift
//  CSSI
//
//  Created by Admin on 1/30/23.
//  Copyright © 2023 yujdesigns. All rights reserved.
//

import UIKit

class DiningFCFSEventCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPartySize: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblStatusColor: UILabel!
    @IBOutlet weak var lblStatusValue: UILabel!
    @IBOutlet weak var lblConfirmationID: UILabel!
    @IBOutlet weak var viewSynch: UIView!
    @IBOutlet weak var viewShare: UIView!
    @IBOutlet weak var btnModify: UIButton!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblWeekDay: UILabel!
    @IBOutlet weak var btnCancel: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        baseView.layer.shadowColor = UIColor.black.cgColor
        baseView.layer.shadowOpacity = 0.25
        baseView.layer.shadowOffset = CGSize(width: 2, height: 2)
        baseView.layer.shadowRadius = 2
        
        self.lblStatusColor.layer.cornerRadius = self.lblStatusColor.frame.size.width/2
        self.lblStatusColor.clipsToBounds = true
        self.lblStatusColor.layer.borderWidth = 0.5
        self.lblStatusColor.layer.borderColor = hexStringToUIColor(hex: "3D3D3D").cgColor
        
        btnRegister.backgroundColor = .clear
        btnRegister.layer.cornerRadius = 15
        btnRegister.layer.borderWidth = 1
        btnRegister.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        self.btnRegister.setStyle(style: .outlined, type: .primary)
    
        btnViewOnly.backgroundColor = .clear
        btnViewOnly.layer.cornerRadius = 15
        btnViewOnly.layer.borderWidth = 1
        btnViewOnly.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        self.btnViewOnly.setStyle(style: .outlined, type: .primary)

        self.viewSynch.isHidden = (UserDefaults.standard.string(forKey: UserDefaultsKeys.synchCalendar.rawValue) == "0")
        self.viewShare.isHidden = (UserDefaults.standard.string(forKey: UserDefaultsKeys.shareUrl.rawValue) == "0")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnModifyAction(_ sender: Any) {
    }
    
    @IBAction func btnCancelAction(_ sender: Any) {
    }
    
    @IBAction func btnShareAction(_ sender: Any) {
    }
    
    @IBAction func btnSyncAction(_ sender: Any) {
    }
    
}
