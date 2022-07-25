//
//  FormValidation.swift
//  CSSI
//
//  Created by MACMINI13 on 11/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation


class FormValidation {

static func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

static func isValidPassword(testStr:String?) -> Bool {
    guard testStr != nil else { return false }
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
    return passwordTest.evaluate(with: testStr)
}
   static func showAlertMessage(vc: UIViewController, titleStr:String, messageStr:String) -> Void {
    let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertControllerStyle.alert);
    vc.present(alert, animated: true, completion: nil)
}
    
    
   
    
    
}
