//
//  OTPTextField.swift
//  CSSI
//
//  Created by Kiran on 07/07/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

import UIKit

class OTPTextField: UITextField
{
    var nextTextField : OTPTextField?
    var previousTextField : OTPTextField?
    
    override func deleteBackward()
    {
        self.text = ""
        self.previousTextField?.becomeFirstResponder()
    }
    
}
