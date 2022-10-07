//
//  DiningAddMemberGuestPopUpVC.swift
//  CSSI
//
//  Created by Aks on 05/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
protocol  selectedSlotFor{
    func addingMemberType(value : String)
}
class DiningAddMemberGuestPopUpVC: UIViewController {
    
    @IBOutlet weak var roundedBgView: UIView!
    @IBOutlet weak var btnMemberType: UIButton!
 

    var delegateSelectedMemberType : selectedSlotFor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundedBgView.clipsToBounds = true
        roundedBgView.layer.cornerRadius = 15
        roundedBgView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        btnMemberType.layer.cornerRadius = 6
    }
    
    @IBAction func MemberTypeSelectBtnTapped(sender:UIButton){
        if sender.tag == 1{
            delegateSelectedMemberType?.addingMemberType(value: "Member")
        }
        else if sender.tag == 2{
            delegateSelectedMemberType?.addingMemberType(value: "Guest")
        }
        else {
            delegateSelectedMemberType?.addingMemberType(value: "My Buddy")
        }
        self.dismiss(animated: true, completion: nil)
    }
}
