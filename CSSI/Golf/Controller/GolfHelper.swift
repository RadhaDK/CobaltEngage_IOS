//
//  GolfHelper.swift
//  CSSI
//
//  Created by Aks on 08/02/23.
//  Copyright © 2023 yujdesigns. All rights reserved.
//

import Foundation

extension UIView{
    func shadowView(viewName : UIView){
        viewName.layer.shadowColor = UIColor.black.cgColor
        viewName.layer.shadowOpacity = 0.12
        viewName.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewName.layer.shadowRadius = 6
    }
}
