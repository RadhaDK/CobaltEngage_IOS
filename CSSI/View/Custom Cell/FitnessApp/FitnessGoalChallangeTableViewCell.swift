//
//  FitnessGoalChallangeTableViewCell.swift
//  CSSI
//
//  Created by Kiran on 23/10/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

protocol  FitnessGoalChallangeTableViewCellDelegate : NSObject
{
    func knowMoreClicked(cell:FitnessGoalChallangeTableViewCell)
    func submitClicked(cell:FitnessGoalChallangeTableViewCell)
}

class FitnessGoalChallangeTableViewCell: UITableViewCell
{

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtViewShortDescription: UITextView!
    @IBOutlet weak var btnKnowMore: UIButton!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblGoal: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var dividerView: UIView!
    
    weak var delegate : FitnessGoalChallangeTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblTitle.font = AppFonts.bold20
        self.lblTitle.textColor = APPColor.textColor.secondary
        
        self.txtViewShortDescription.font = AppFonts.regular12
        self.txtViewShortDescription.textColor = APPColor.textColor.primary
        
        self.btnKnowMore.setTitleColor(APPColor.ButtonColors.secondary, for: .normal)
        self.btnKnowMore.titleLabel?.font = AppFonts.regular14
        
        self.lblGoal.font = AppFonts.semibold12
        self.lblGoal.textColor = APPColor.textColor.primary
        
        self.lblDuration.font = AppFonts.semibold12
        self.lblDuration.textColor = APPColor.textColor.primary
        
        self.btnSubmit.titleLabel?.font = AppFonts.semibold22
        
        self.lineView.backgroundColor = APPColor.OtherColors.lineColor
        self.dividerView.backgroundColor = APPColor.OtherColors.deviderColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.btnSubmit.setStyle(style: .outlined, type: .primary)
    }
    
    @IBAction func knowMoreClicked(_ sender: UIButton)
    {
        self.delegate?.knowMoreClicked(cell: self)
    }
    
    @IBAction func submitClicked(_ sender: UIButton)
    {
        self.delegate?.submitClicked(cell: self)
    }
    
}
