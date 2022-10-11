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
