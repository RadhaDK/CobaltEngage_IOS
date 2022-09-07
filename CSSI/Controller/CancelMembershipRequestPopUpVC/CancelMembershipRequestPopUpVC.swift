//
//  CancelMembershipRequestPopUpVC.swift
//  CSSI
//
//  Created by Vishal Pandey on 06/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class CancelMembershipRequestPopUpVC: UIViewController {
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var btnRemovePopUp: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        btnNo.layer.cornerRadius = 15
        btnYes.layer.cornerRadius = 15
        btnNo.layer.borderWidth = 1
        btnYes.layer.borderWidth = 1
        btnYes.layer.borderColor = UIColor.darkGray.cgColor
        btnNo.layer.borderColor = UIColor.darkGray.cgColor
     

        // Do any additional setup after loading the view.
    }
    
  
    
    @IBAction func removePopUpBtnTapped(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func yesBtnTapped(sender:UIButton){
        btnYes.layer.borderColor = UIColor(red: 27/255, green: 202/255, blue: 255/255, alpha: 1).cgColor
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func noBtnTapped(sender:UIButton){
        btnNo.layer.borderColor = UIColor(red: 27/255, green: 202/255, blue: 255/255, alpha: 1).cgColor
        self.dismiss(animated: true, completion: nil)
    }

}
