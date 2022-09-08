//
//  MemberEditBillingFrequencyVC.swift
//  CSSI
//
//  Created by Vishal Pandey on 07/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class MemberEditBillingFrequencyVC: UIViewController {
    
    @IBOutlet weak var billingAmountView: UIView!
    @IBOutlet weak var billingAmountLbl: UILabel!
    @IBOutlet weak var savebtnbgView: UIView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var cancelbtnbgView: UIView!
    @IBOutlet weak var btnCancel: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        btnSave.setTitle("", for: .normal)
        btnCancel.setTitle("", for: .normal)
        self.navigationItem.title = "Update Billing Frequency"
        
        billingAmountView.layer.borderColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1).cgColor
        billingAmountView.layer.borderWidth = 1
        
        savebtnbgView.layer.borderColor = UIColor(red: 42/255, green: 78/255, blue: 127/255, alpha: 1).cgColor
        savebtnbgView.layer.borderWidth = 1.5
        savebtnbgView.layer.cornerRadius = 23
        
        cancelbtnbgView.layer.borderColor = UIColor(red: 42/255, green: 78/255, blue: 127/255, alpha: 1).cgColor
        cancelbtnbgView.layer.borderWidth = 1.5
        cancelbtnbgView.layer.cornerRadius = 20
      
      
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        
    }
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnTapped(sender:UIButton){
        
    }
    
    @IBAction func cancelBtnTapped(sender:UIButton){
        
    }
    

}


