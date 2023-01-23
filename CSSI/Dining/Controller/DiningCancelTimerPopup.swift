//
//  DiningCancelTimerPopup.swift
//  CSSI
//
//  Created by Aks on 20/01/23.
//  Copyright © 2023 yujdesigns. All rights reserved.
//

import UIKit

class DiningCancelTimerPopup: UIViewController {

    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var viewBack: UIView!
    var descriptionText : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDescription.text = descriptionText
        viewBack.layer.cornerRadius = 8
        btnOk.layer.cornerRadius = btnOk.layer.frame.height/2
        
    }
    
    @IBAction func btnOk(_ sender: Any) {
        for controller in self.navigationController!.viewControllers as Array {
            
            if controller.isKind(of: DiningReservationVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
            
        }
    }
    
   

}
