//
//  ThankYouMemberShipVC.swift
//  CSSI
//
//  Created by Vishal Pandey on 06/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class ThankYouMemberShipVC: UIViewController {
    
    @IBOutlet weak var thankYouLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var btnRemovePopUp: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
       
        
    }
    
    @IBAction func removePopUpBtnTapped(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }

}
