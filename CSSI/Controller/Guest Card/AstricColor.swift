//
//  AstricColor.swift
//  CSSI
//
//  Created by apple on 7/10/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

extension NSMutableAttributedString {
    
    func setColor(color: UIColor, forText stringValue: String) {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
    }
    
}
