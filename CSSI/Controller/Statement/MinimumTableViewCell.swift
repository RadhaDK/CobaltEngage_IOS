//
//  MinumumTableViewCell.swift
//  CSSI
//
//  Created by Admin on 8/16/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class MinimumTableViewCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var templateName: UILabel!
    @IBOutlet weak var minimumKey: UILabel!
    @IBOutlet weak var minimumValue: UILabel!
    @IBOutlet weak var creditKey: UILabel!
    @IBOutlet weak var creditValue: UILabel!
    @IBOutlet weak var spentKey: UILabel!
    @IBOutlet weak var spentValue: UILabel!
    @IBOutlet weak var balanceKey: UILabel!
    @IBOutlet weak var balanceValue: UILabel!
    @IBOutlet weak var endDateKey: UILabel!
    @IBOutlet weak var endDateValue: UILabel!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        baseView.layer.shadowOffset = CGSize(width: 2,
                                          height: 2)
        baseView.layer.shadowRadius = 3
        baseView.layer.shadowOpacity = 0.3
        self.minimumKey.text = self.appDelegate.masterLabeling.mINIMUMS_AMOUNT_TITLE ?? ""
        self.creditKey.text = self.appDelegate.masterLabeling.mINIMUM_CREDIT ?? ""
        self.spentKey.text = self.appDelegate.masterLabeling.mINIMUM_AMOUNT_SPENT ?? ""
        self.balanceKey.text = self.appDelegate.masterLabeling.mINIMUM_BALANCE_AMOUNT ?? ""
        self.endDateKey.text = self.appDelegate.masterLabeling.mINIMUMS_END_DATE_TITLE ?? ""
        self.spentValue.textColor = APPColor.MainColours.primary2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func assignValues(minimumTamplate: MinimumTemplate) {
        templateName.text = minimumTamplate.templateName
        minimumValue.text = minimumTamplate.minimumAmount
        creditValue.text = minimumTamplate.credit
        spentValue.text = minimumTamplate.amountSpent
        balanceValue.text = minimumTamplate.balanceAmount
        endDateValue.text = minimumTamplate.endDate
        
        if minimumTamplate.credit == "" {
            creditValue.isHidden = true
            creditKey.isHidden = true
        } else {
            creditValue.isHidden = false
            creditKey.isHidden = false
        }
    }

}
