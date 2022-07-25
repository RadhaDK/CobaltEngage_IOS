//
//  FitnessAppSettingsTVC.swift
//  CSSI
//
//  Created by Kiran on 11/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

protocol FitnessAppSettingsTVCDelegate : NSObject {
    func didtoggleSwitch(isEnabled: Bool , cell : FitnessAppSettingsTVC)
}

class FitnessAppSettingsTVC: UITableViewCell {

    @IBOutlet weak var settingLbl: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    
    weak var delegate : FitnessAppSettingsTVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.settingLbl.font = AppFonts.semibold16
        self.settingLbl.textColor = APPColor.textColor.primary
        
        self.settingSwitch.onTintColor = APPColor.Switch.onColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func toggledSwitch(_ sender: UISwitch)
    {
        self.delegate?.didtoggleSwitch(isEnabled: sender.isOn, cell: self)
    }
    
}
