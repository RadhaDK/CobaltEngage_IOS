//
//  FitnessVideoTableViewCell.swift
//  CSSI
//
//  Created by Kiran on 12/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

protocol FitnessVideoTableViewCellDelegate : NSObject {
    func expandClicked(cell : FitnessVideoTableViewCell)
    func addToFavouriteClicked(cell : FitnessVideoTableViewCell)
}

class FitnessVideoTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var thumbnailImgView: UIImageView!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var groupLbl: UILabel!
    @IBOutlet weak var expandImgView: UIImageView!
    @IBOutlet weak var expandImgHolderView: UIView!
    @IBOutlet weak var expanBtn: UIButton!
    @IBOutlet weak var viewsLbl: UILabel!
    @IBOutlet weak var postedDateLbl: UILabel!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var lineView: UIView!
    
    weak var delegate : FitnessVideoTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.nameLbl.font = AppFonts.semibold10
        self.nameLbl.textColor = APPColor.textColor.primary
        self.groupLbl.font = AppFonts.semibold10
        self.groupLbl.textColor = APPColor.textColor.primary
        self.viewsLbl.font = AppFonts.italic8
        self.viewsLbl.textColor = APPColor.textColor.lightPrimary
        self.postedDateLbl.font = AppFonts.regular9
        self.postedDateLbl.textColor = APPColor.textColor.primary
        self.descriptionTxtView.font = AppFonts.regular9
        self.descriptionTxtView.textColor = APPColor.textColor.lightPrimary
        self.lineView.backgroundColor = APPColor.OtherColors.lineColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func expandClicked(_ sender: UIButton)
    {
        self.delegate?.expandClicked(cell: self)
        
    }
    
    @IBAction func favoutiteClicked(_ sender: UIButton)
    {
        self.delegate?.addToFavouriteClicked(cell: self)
    }
    
}
