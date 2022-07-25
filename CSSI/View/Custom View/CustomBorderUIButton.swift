
//
//  CustomBorderUIButton.swift
//  CRIF
//
//  Created by Samadhan Mali on 21/06/18.
//  Copyright © 2018 MACMINI11. All rights reserved.
//

import UIKit

class CustomBorderUIButton: UIButton {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
      //  self.titleLabel?.font = FontSanFrancisco.SFRegular16
        self.setTitleColor(UIColor.darkGray, for: .normal)
        self.contentHorizontalAlignment = .left
        createBorder()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
      //  self.titleLabel?.font = FontSanFrancisco.SFRegular16
        self.setTitleColor(UIColor.darkGray, for: .normal)
        self.contentHorizontalAlignment = .left
        self.layer.cornerRadius = 4
     //   self.layer.borderColor = UIColor.pastelBlue.cgColor
        self.layer.borderWidth = 1
        
        
//        createBorder()
    }
    
    func createBorder(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 55/255, green: 78/255, blue: 95/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height-width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        
//        self.layer.addSublayer(border)
//        self.layer.masksToBounds = true
        
    }
    
}

