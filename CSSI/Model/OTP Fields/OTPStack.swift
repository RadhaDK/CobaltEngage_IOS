//
//  OTPStack.swift
//  CSSI
//
//  Created by Kiran on 07/07/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

import UIKit

class OTPStack: UIStackView
{
    var fieldsCount : Int = 4
    var fieldSpacing : CGFloat = 5
    var fieldBorderHeight : CGFloat = 1
    var fieldBorderColor : UIColor = .black
    var fieldBackgroundColor : UIColor = .white
    var fieldFont : UIFont? = UIFont.systemFont(ofSize: 14.0)
    var fieldTextColor : UIColor = .black
    var fieldTextTintColor : UIColor = .systemBlue
    
    private var arrFields = [OTPTextField]()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.initialSetup()
    }
    
    required init(coder: NSCoder)
    {
        super.init(coder: coder)
        self.initialSetup()
    }
    
    required init(noOfDigits : Int, frame : CGRect)
    {
        super.init(frame: frame)
        self.fieldsCount = noOfDigits
        self.initialSetup()
    }
    
}

extension OTPStack
{
    private func initialSetup()
    {
        self.backgroundColor = .clear
        self.configureStack()
    }
    
    private func configureStack()
    {
        self.spacing = self.fieldSpacing
        self.contentMode = .center
        self.distribution = .fillProportionally
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
    }
    
    private func addTextFields()
    {
        for i in 0..<self.fieldsCount
        {
            let field = OTPTextField.init()
            field.tag = i
            self.arrFields.append(field)
            self.addArrangedSubview(field)
            self.setupTextfield(field)
            
            //Assigning Previous text fields
            i == 0 ? (field.previousTextField = nil) : (field.previousTextField = self.arrFields[i - 1])
            
            //Assigning next textfields
            i == 0 ? () : (self.arrFields[i - 1].nextTextField = field)
        }
        
    }
    
    private func setupTextfield(_ field : UITextField)
    {
        field.translatesAutoresizingMaskIntoConstraints = false
        let Width : CGFloat = (self.frame.width - ((CGFloat(self.fieldsCount - 1) * self.fieldSpacing)))/CGFloat(self.fieldsCount)
        field.widthAnchor.constraint(greaterThanOrEqualToConstant: Width).isActive = true
        field.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0,constant: 0 - self.fieldBorderHeight).isActive = true
        field.delegate = self
        field.contentMode = .center
        field.textAlignment = .center
        field.keyboardType = .numberPad
        field.backgroundColor = self.fieldBackgroundColor
        field.textColor = self.fieldTextColor
        field.font = self.fieldFont
        field.tintColor = self.fieldTextTintColor
        if #available(iOS 12.0, *)
        {
            field.textContentType = .oneTimeCode
        }
        let border = CALayer()
        border.frame = CGRect(x:0, y: self.frame.height - self.fieldBorderHeight, width: Width, height: self.fieldBorderHeight)
        border.backgroundColor = self.fieldBorderColor.cgColor
        field.layer.addSublayer(border)
    }
    
    private func removeTextFields()
    {
        for field in self.arrangedSubviews
        {
            field.removeFromSuperview()
        }
    }
    
    private func refreshTextFieldsDesign()
    {
        self.removeTextFields()
        
        let tempFields = self.arrFields
        self.arrFields.removeAll()
        self.addTextFields()
        
        for (index,field) in self.arrFields.enumerated()
        {
            if index >= 0 && index < tempFields.count
            {
                field.text = tempFields[index].text
            }
        }
    }
    
    func updateUI()
    {
        if self.arrangedSubviews.count > 0
        {
            self.removeTextFields()
        }
        self.configureStack()
        self.refreshTextFieldsDesign()
    }
    
    func getOTP() -> String
    {
        var OTPString = ""
        for field in self.arrFields
        {
            OTPString += (field.text ?? "")
        }
        
        return OTPString
    }
    
    private func autoFillText(string : String)
    {
        for (index,char) in string.enumerated()
        {
            if index >= 0 && index < self.arrFields.count
            {
                let field = self.arrFields[index]
                field.text = "\(char)"
            }
            
        }
    }
}

extension OTPStack : UITextFieldDelegate
{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        guard let field = textField as? OTPTextField else {
            return true
        }
        
        if string.count > 1
        {
            field.resignFirstResponder()
            self.autoFillText(string: string)
            return false
        }
        else
        {
            if string.count > 0
            {
                field.text = string
                if field.nextTextField == nil
                {
                    field.resignFirstResponder()
                }
                else
                {
                    field.nextTextField?.becomeFirstResponder()
                }
                return false
            }
        }
        
        return true
    }
    
}
