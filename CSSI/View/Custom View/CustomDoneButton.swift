
//
//  CustomDoneButton.swift
//  CSSI
//
//  Created by Samadhan Mali on 05/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class CustomDoneButton: UIButton {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //    self.titleLabel?.font = FontSanFrancisco.SFRegular16
        self.setTitleColor(UIColor.darkGray, for: .normal)
        self.contentHorizontalAlignment = .center
        self.layer.borderColor = APPColor.loginBackgroundButtonColor.loginBtnBGColor.cgColor
        self.layer.borderWidth = 2
        createBorder()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        //    self.titleLabel?.font = FontSanFrancisco.SFRegular16
        self.setTitleColor(UIColor.darkGray, for: .normal)
        self.contentHorizontalAlignment = .center
        self.layer.borderColor = APPColor.loginBackgroundButtonColor.loginBtnBGColor.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 12
        
//        createBorder()
    }
    
    func createBorder(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 55/255, green: 78/255, blue: 95/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height-width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
    }
    
}

