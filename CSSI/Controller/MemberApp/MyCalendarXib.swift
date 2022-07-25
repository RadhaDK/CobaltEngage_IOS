//
//  MyCalendarXib.swift
//  CSSI
//
//  Created by apple on 11/18/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

protocol MyCalendarCellDelegate: AnyObject {
    func shareButtonClicked(cell: MyCalendarXib)
    func synchButtonClicked(cell: MyCalendarXib)
    func registrationButtonClicked(cell: MyCalendarXib)
    func viewOnlyClicked(cell : MyCalendarXib)
    //Added on 1st July 2020 BMS
    func cancelClicked(cell: MyCalendarXib)
    //Added on 15th OCtober 2020 V2.3
    func nameClicked(cell: MyCalendarXib)
}

class MyCalendarXib: UITableViewCell {

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
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblWeekDay: UILabel!
    
    @IBOutlet weak var btnViewOnly: UIButton!
    
    //Added on 1st July 2020 BMS
    @IBOutlet weak var btnCancel: UIButton!
    
    //Added on 15th October 2020 V2.3
    @IBOutlet weak var btnName: UIButton!
    
    weak var delegate: MyCalendarCellDelegate?
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

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
        
        //Added by kiran V2.5 -- ENGAGE0011395 -- observation fix sync and share buttons are not hidden/shown as per setting.
        //ENGAGE0011395 -- Start
        self.viewSynch.isHidden = (UserDefaults.standard.string(forKey: UserDefaultsKeys.synchCalendar.rawValue) == "0")
        self.viewShare.isHidden = (UserDefaults.standard.string(forKey: UserDefaultsKeys.shareUrl.rawValue) == "0")
        //ENGAGE0011395 -- End
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func requestClicked(_ sender: Any) {
        delegate?.registrationButtonClicked(cell: self)

    }
    @IBAction func synchClicked(_ sender: Any) {
        delegate?.synchButtonClicked(cell: self)

    }
    @IBAction func shareClicked(_ sender: Any) {
        delegate?.shareButtonClicked(cell: self)

    }
    
    
    @IBAction func viewOnlyClicked(_ sender: UIButton) {
        
        self.delegate?.viewOnlyClicked(cell: self)
    }
    
    //Added on 1st July 2020 BMS
    @IBAction func cancelClicked(_ sender: UIButton) {
        self.delegate?.cancelClicked(cell: self)
    }
    
    //Added on 15th October 2020 V2.3
    @IBAction func nameClicked(_ sender: UIButton)
    {
        self.delegate?.nameClicked(cell: self)
    }
    
    
}
