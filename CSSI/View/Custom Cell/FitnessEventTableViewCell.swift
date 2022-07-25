//
//  FitnessEventTableViewCell.swift
//  CSSI
//
//  Created by Kiran on 18/03/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

protocol FitnessEventTableViewCellDelegate : NSObject  {
    
    func didClickViewOn(Cell : FitnessEventTableViewCell)
}


class FitnessEventTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var btnView: UIButton!
    
    let appdelegate = UIApplication.shared.delegate as? AppDelegate
    weak var delegate : FitnessEventTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.btnView.setTitle( self.appdelegate?.masterLabeling.VIEW , for: .normal)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        self.mainView.layer.cornerRadius = 8
        self.eventImageView.layer.cornerRadius = 8
        self.eventImageView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.mainView.applyShadow(color: hexStringToUIColor(hex: "#00000029"), radius: 2, offset: CGSize.init(width: 0, height: 3), opacity: 0.6)
        self.btnView.viewOnlyBtnViewSetup()
        self.btnView.setStyle(style: .outlined, type: .primary)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func viewClicked(_ sender: UIButton)
    {
        self.delegate?.didClickViewOn(Cell: self)
    }
}
