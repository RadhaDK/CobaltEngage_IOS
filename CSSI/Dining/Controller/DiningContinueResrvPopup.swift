//
//  DiningContinueResrvPopup.swift
//  CSSI
//
//  Created by Aks on 30/01/23.
//  Copyright © 2023 yujdesigns. All rights reserved.
//

import UIKit

protocol dismissResvPopup{
    func dismmissResvPopup(value : Bool)
}


class DiningContinueResrvPopup: UIViewController {

    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var btnYes: UIButton!
    
    var desriptionText : String?
    var delegateDismissResv : dismissResvPopup?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblDescription.text = desriptionText
        lblDescription.textColor = .darkGray
        lblDescription.font = .systemFont(ofSize: 18.0, weight: .semibold)
        btnYes.layer.cornerRadius = btnYes.layer.frame.height/2
    }
    
    @IBAction func btnYes(_ sender: Any) {
        self.dismiss(animated: true)
        delegateDismissResv?.dismmissResvPopup(value: true)
    }
    
    @IBAction func btnCross(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
