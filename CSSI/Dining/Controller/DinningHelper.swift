//
//  Helper.swift
//  CSSI
//
//  Created by Aks on 10/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import Foundation
extension UIView{
    func animShow(){
        UIView.animate(withDuration: 1.4, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()

        },  completion: {(_ completed: Bool) -> Void in
        self.isHidden = true
            })
    }
}
//MARK: get parent controller...
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
extension UIButton{
    func buttonUI(button : UIButton){
        button.layer.cornerRadius = button.bounds.size.height / 2
        button.layer.borderWidth = 1.0
        button.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
//        self.btnAdd.setStyle(style: .outlined, type: .primary)
//        btnCancel.layer.cornerRadius = btnCancel.bounds.size.height / 2
//        btnCancel.layer.borderWidth = 1.0
//        btnCancel.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
//        self.btnCancel.setStyle(style: .outlined, type: .primary)
//        txtComment.layer.cornerRadius = 8
//        txtComment.layer.borderColor = UIColor.lightGray.cgColor
//        txtComment.layer.borderWidth = 1
    }
}
