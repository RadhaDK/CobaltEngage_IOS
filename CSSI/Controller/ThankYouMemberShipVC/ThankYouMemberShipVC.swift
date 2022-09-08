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


    var thankYouDesc : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if thankYouDesc != nil{
        descriptionLbl.text = thankYouDesc
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
       
        
    }
    
    @IBAction func removePopUpBtnTapped(sender:UIButton){
        if((self.presentingViewController) != nil){
            
            self.dismiss(animated: false, completion: nil)
          
          //  MemberDirectoryViewController().refresh()

            
            
            
        }
       // self.navigationController?.dismiss(animated: true, completion: nil)
    }

}
