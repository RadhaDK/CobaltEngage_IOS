//
//  File.swift
//  CSSI
//
//  Created by Apple on 27/09/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
extension UITextField {
    
    /// set icon of 20x20 with left padding of 8px
    func setRightIcon(imageName:String , width : CGFloat? = nil) {
        
        let imageWidth : CGFloat = 30.0
        var imageHeight : CGFloat = 30.0
        
        let view = UIView.init()
        view.frame = CGRect.init(x: 0, y: 0, width: width ?? 45, height: self.frame.height)
        view.backgroundColor = .clear
        
        let arrow = UIImageView(image: UIImage(named: imageName))
       
        if let size = arrow.image?.size {
            
            /**Causing issue with detecing tap as the height of the view (on which button is added) is equal to the image height(which is small)*/
            //view.frame = CGRect.init(x: 0, y: 0, width: 45, height: size.height)
           // arrow.frame = CGRect(x: 0, y: 0.0, width: 30.0, height: size.height)
            imageHeight = size.height
        }
        
        
        arrow.frame = CGRect.init(x: 0, y: (view.frame.height - imageHeight)/2, width: imageWidth, height: imageHeight)
        arrow.contentMode = UIViewContentMode.center
        view.addSubview(arrow)
        
        rightView = view

        rightViewMode = UITextFieldViewMode.always
        
        let bttnIcon = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        bttnIcon.setTitle("", for: .normal)
        bttnIcon.backgroundColor = .clear
        bttnIcon.tintColor = .clear
        
        bttnIcon.addTarget(self, action: #selector(rightIconAction(sender:)), for: .touchUpInside)
        view.addSubview(bttnIcon)
        view.bringSubview(toFront: bttnIcon)
    }
    
    
    @objc private func rightIconAction(sender: UIButton)
    {
        DispatchQueue.main.async {
              self.becomeFirstResponder()
        }
      
    }
    
}


extension UIViewController
{
    ///Returns the number of tickets available
    ///
    ///Takes the array of groups with each group itself being an array of RequestData and returns the count of members whose isEmpty variable is true
    func emptyTickets(arr : [[RequestData]]) -> Int
    {
        var count : Int = 0
        
        arr.forEach({$0.forEach({count += $0.isEmpty ? 1 : 0})})
        
        return count
    }
    
    func handleError(_ error : Error)
    {
        SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
    }
    
}


extension UIButton
{
    ///Calender screen refresh,sumbit and Cancel view setup
    ///
    /// Adds corner radius, border color , border width and clips to bounds
    func calendarBttnViewSetup()
    {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.init(red: 64/255.0, green: 178/255.0, blue: 230/255.0, alpha: 1).cgColor
        self.clipsToBounds = true
    }
    
    ///Dining screen dining request  and menus & hours  view setup
    ///
    /// Adds corner radius, border color , border width and clips to bounds
    func diningBtnViewSetup()
    {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = hexStringToUIColor(hex: "F06C42").cgColor
        self.clipsToBounds = true
    }
    
    ///Multi Select button view setup
    ///
    /// Adds  corner radius, border color , border width , background color and clips to bounds
    func multiSelectBtnViewSetup()
    {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.init(red: 64/255.0, green: 178/255.0, blue: 230/255.0, alpha: 1).cgColor
        self.clipsToBounds = true
        self.backgroundColor = .clear
    }
    
    ///View button view setup
    ///
    /// Adds  corner radius, border color , border width , background color and clips to bounds
    func viewOnlyBtnViewSetup()
    {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
    }

    
    //Added on 4th June 2020 BMS
    ///FIntess Request button view
    ///
    /// Adds corner radius , Background color and removes border
    func fitnessRequestBttnViewSetup()
    {
        self.backgroundColor = hexStringToUIColor(hex: "F37D4A")
        self.layer.cornerRadius = self.bounds.height/2
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
        self.clipsToBounds = true
    }
    
    
    func BMSCancelBthViewSetup()
    {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.bounds.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = hexStringToUIColor(hex: "#2CAEEB").cgColor
        self.clipsToBounds = true
        
    }
    
    ///Sets the backgound clear as clear and applies the border color with width 1. An dsets title color
    func transparentBtnSetup(color : UIColor)
    {
        self.backgroundColor = .clear
        self.layer.cornerRadius = self.bounds.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
        self.setTitleColor(color, for: .normal)
    }
    
    
    //Added on 16th September 2020 V2.3
    func set(bgColor : UIColor,textColor : UIColor,cornerRadius : CGFloat,borderWidth : CGFloat,borderColor : UIColor)
    {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        
        self.backgroundColor = bgColor
        self.setTitleColor(textColor, for: .normal)
        
    }
    
    //Added on 20th October 2020 V2.4
   
    //Added by kiran V2.9 -- ENGAGE0012268 -- Color codes for dark mode
    //ENGAGE0012268 -- Start
    /**
     Applies the button style , colors and corner radius for button.
     
    Use the following for the appropriate setup
    
    - Style:
        - Contained: Filled button
        - Outlined: button with border and text color. background is clear
     - parameters:
        - style: The style of the button. buttons design is based on this.
        - type: The type of the button. Assigns the colours based on this
        - cornerRadius: radius of corener of buttons. when nil applies height/2 as corner radius
     */
    func setStyle(style: ButtonStyle,type : ButtonKind ,cornerRadius : CGFloat? = nil)
    {//TODO:- Add dark mode support for color chanegs in this function. Refer(ENGAGE0012268) lightning warning button ticket in teeTimesview controller for reference of how to apply darkMode.
        
        var textColor : UIColor?
        var backgroundColor : UIColor?
        var borderColor : CGColor?
        var borderWidth : CGFloat = 0
        
        
        switch style
        {
        case .contained:
            
            borderWidth = 0.25
            
            switch type
            {
            case .primary:
                backgroundColor = APPColor.ButtonColors.primary
                textColor = APPColor.ButtonColors.containedTextColor
                borderColor = APPColor.ButtonColors.primaryBorder.cgColor
                
            case .secondary:
                backgroundColor = APPColor.ButtonColors.secondary
                textColor = APPColor.ButtonColors.containedTextColor
                borderColor = APPColor.ButtonColors.secondaryBorder.cgColor
                
            case .alert:
                borderWidth = 1
                backgroundColor = APPColor.ButtonColors.alert
                textColor = APPColor.ButtonColors.containedTextColor
                borderColor = APPColor.ButtonColors.alertBorder.cgColor
            }
            
        case .outlined:
            
            borderWidth = 1
            backgroundColor = .clear
            switch type
            {
            case .primary:
                
                textColor = APPColor.ButtonColors.primary
                borderColor = APPColor.ButtonColors.primary.cgColor
                
            case .secondary:
                
                textColor = APPColor.ButtonColors.secondary
                borderColor = APPColor.ButtonColors.secondary.cgColor
                
            case .alert:
                
                textColor = APPColor.ButtonColors.alert
                borderColor = APPColor.ButtonColors.alert.cgColor
                break
            }
            
        }
        
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius ?? self.bounds.height/2
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.clipsToBounds = true
        self.setTitleColor(textColor, for: .normal)
        
    }
    //ENGAGE0012268 -- End
   
    
}

extension UIView
{
    func applyShadow(color : UIColor , radius : CGFloat , offset : CGSize , opacity : Float)
    {
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
    }
}

extension Encodable
{
    func toDict() -> [String : Any]?
    {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
