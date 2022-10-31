//
//  DiningAddMemberGuestPopUpVC.swift
//  CSSI
//
//  Created by Aks on 05/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
enum poupOpenFrom {
    case addSlot,multiple
}
protocol  selectedSlotFor{
    func addingMemberType(value : String, type: poupOpenFrom)
}
class DiningAddMemberGuestPopUpVC: UIViewController {
    
    
    //MARK: - IBActions
    @IBOutlet weak var roundedBgView: UIView!
    @IBOutlet weak var btnMemberType: UIButton!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var btnMember: UIButton!
    @IBOutlet weak var bottomCont: NSLayoutConstraint!
    @IBOutlet weak var btnGuest: UIButton!
    @IBOutlet weak var btnMyBuddy: UIButton!
    @IBOutlet weak var heightBottomPopup: NSLayoutConstraint!
    
    //MARK: - Variables
    var delegateSelectedMemberType : selectedSlotFor?
    var checkPopupOpenFrom : poupOpenFrom?

    override func viewDidLoad() {
        super.viewDidLoad()
setUpUi()
    }
    
    //MARK: - setUpUI
    func setUpUi(){
        roundedBgView.clipsToBounds = true
        roundedBgView.layer.cornerRadius = 15
        roundedBgView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        btnMember.layer.cornerRadius = 6
        btnGuest.layer.cornerRadius = 6
        btnMyBuddy.layer.cornerRadius = 6
        viewBackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        showToastViewWithAnimation(viewController: self)
        if checkPopupOpenFrom == .multiple{
            btnGuest.isHidden = true
            heightBottomPopup.constant = 170
        }
    }

    
    @objc func showToastViewWithAnimation(viewController: Any) {
             if let vc = viewController as? ViewController {
                 self.bottomCont.constant = -20
                 UIView.animate(withDuration: 3) {
                 }
             }
         }
    @objc func dismissOnTapOutside(){
       self.dismiss(animated: false, completion: nil)
    }
    
    //MARK: - IBActions
    @IBAction func MemberTypeSelectBtnTapped(sender:UIButton){
        if sender.tag == 1{
            delegateSelectedMemberType?.addingMemberType(value: "Member", type: checkPopupOpenFrom ?? .addSlot)
        }
        else if sender.tag == 2{
            delegateSelectedMemberType?.addingMemberType(value: "Guest", type: checkPopupOpenFrom ?? .addSlot)
        }
        else {
            delegateSelectedMemberType?.addingMemberType(value: "My Buddy", type: checkPopupOpenFrom ?? .addSlot)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
