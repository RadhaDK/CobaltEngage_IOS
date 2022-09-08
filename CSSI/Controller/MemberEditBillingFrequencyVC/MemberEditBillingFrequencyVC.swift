//
//  MemberEditBillingFrequencyVC.swift
//  CSSI
//
//  Created by Vishal Pandey on 07/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class MemberEditBillingFrequencyVC: UIViewController {
    
    @IBOutlet weak var billingAmountLbl: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCancel: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Update Billing Frequency"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveBtnTapped(sender:UIButton){
        
    }
    
    @IBAction func cancelBtnTapped(sender:UIButton){
        
    }
    

}
