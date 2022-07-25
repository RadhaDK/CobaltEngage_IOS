//
//  Extensions.swift
//  CSSI
//
//  Created by Kiran on 06/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import UIKit
import SideMenu

extension Date{
    
    ///Retunens the month from date with format MMMM
    func getMonth() -> String?
    {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "MMMM"
        //formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter.string(from: self)
    }
    
    ///Retunens the year from date with format YYYY
    func getYear() -> String?
    {
       let formatter = DateFormatter.init()
        formatter.dateFormat = "YYYY"
        //formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter.string(from: self)
    }
    
    /// Returns Date with specified format.
    /// Paramaters
    /// Format
    /// Description
    /// String , WHich is a format of date to be returned
    /// Note : Default is MMMM, dd YYYY
    func getDate(format : String = "MMM, dd YYYY") -> String?
    {
        let formatter = DateFormatter.init()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
}


extension String
{
    
    ///Returns Date with the format and locale specified
    func date(format : String , locale : Locale? = nil) -> Date?
    {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let locale = locale
        {
            formatter.locale = locale
        }
        
        return formatter.date(from: self)
    }
    
//    func verifyUrl() -> Bool
//    {
//        if self.count > 0
//        {
//            if let url = URL(string: self)
//            {
//                return UIApplication.shared.canOpenURL(url)
//                
//            }
//            
//        }
//        return false
//        
//    }
    
    //Added on 7th August 2020 V2.3
    ///Coverts string/ Html string to Attributed string
    ///
    ///IsHtml bool when true converts the string to attributed string treating it as HTML string.When false will check for <html> tag and if exists will treat the string as html
    func generateAttributedString(isHtml : Bool) -> NSAttributedString?
    {
        var strMessage : NSAttributedString?
        
        if isHtml || self.contains("<html>")
        {
            strMessage = self.htmlToAttributedString
        }
        else
        {
            strMessage = NSAttributedString.init(string: self)
        }
        
        return strMessage
    }
    
    
    func heightFor(width: CGFloat,font : UIFont) -> CGFloat
    {
        let containerSize = CGSize.init(width: width, height: .greatestFiniteMagnitude)
        
        let boundingRect = self.boundingRect(with: containerSize, options: .usesLineFragmentOrigin , attributes: [.font : font],context: nil)
        
        return ceil(boundingRect.height)
    }
    
    //Added by kiran V2.5 -- ENGAGE0011419 -- Images not loading when default browser changed as UIApplication.shared.canOpenURL() is returning false every time. so instead of that verifying is the URL is valid.
    //ENGAGE0011419 -- Start
    func isValidURL() -> Bool
    {
        if self.count > 0, let _ = URL.init(string: self)
        {
            return true
            //return UIApplication.shared.canOpenURL(url)
        }
        
        return false
    }
    //ENGAGE0011419 -- End
    
//    var isValidURL: Bool {
//        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
//        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.endIndex.encodedOffset)) {
//            // it is a link, if the match covers the whole string
//            return match.range.length == self.endIndex.encodedOffset
//        } else {
//            return false
//        }
//    }
}

extension UIViewController
{
    ///Compares date with hours and minutes .Used for reservation max date only
    func findTimeDiff(time1: Date, time2: Date) -> String
    {
        let interval = time2.timeIntervalSince(time1)
        let hour = interval / 3600;
        let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
        let intervalInt = Int(interval)
        return "\(intervalInt < 0 ? "-" : "+") \(Int(hour)) Hours \(Int(minute)) Minutes"
    }
    
    //Added on by kiran V2.4 -- GATHER0000176
    func navStackView(with : [UIView]) -> UIStackView
    {
        let stackview = UIStackView.init(arrangedSubviews: with)
        stackview.spacing = 10
        stackview.alignment = .fill
        stackview.distribution = .fillProportionally
        stackview.axis = .horizontal
        
        return stackview
    }
    
    //Added by kiran V2.4 -- GATHER0000176
    ///Returns Bar button Item with backbutton setup.
    ///
    ///if image is not set appropriate image is assigned .Format (target: , action:  ,image : )
    func navBackBtnItem(target: Any?, action: Selector,image : UIImage? = nil) -> UIBarButtonItem
    {
        let backImage = UIImage.init(named: "back_btn")
        
        return BackBarButtonItem.init(image: image ?? backImage , style: .plain, target: target, action: action)
    }
    
    //Added by kiran V2.4 -- GATHER0000176
    ///Returns Bar button Item with backbutton setup.
    ///
    ///if image is not set appropriate image is assigned.Format (target: , action:  ,image : )
    func navHomeBtnItem(target: Any?, action: Selector,image : UIImage? = nil) -> UIBarButtonItem
    {
        let homeImage = UIImage.init(named: "Path 398")
        
        return BackBarButtonItem.init(image: image ?? homeImage, style: .plain, target: target, action: action)
    }
    
    
    //Added by kiran V2.4 -- GATHER0000176
    ///Returns UIButton with backbutton setup
    ///
    /// if image is not set appropriate image is assigned.Format (target: , action: , for ,image : )
    func getBackButton(target: Any?, action: Selector, for event: UIControlEvents,image : UIImage? = nil) -> UIButton
    {
        let backButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        backButton.addTarget(target, action: action, for: event)
        backButton.setImage(image ?? UIImage.init(named: "back_btn"), for: .normal)
        backButton.setTitle(nil, for: .normal)
        
        return backButton
    }
    
    //Added by kiran V2.4 -- GATHER0000176
    ///Returns UIButton with home Button setup.
    ///
    /// if image is not set appropriate image is assigned.Format (target: , action: , for ,image : )
    func getHomeButton(target: Any?, action: Selector, for event: UIControlEvents,image : UIImage? = nil) -> UIButton
    {
        let homeBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        homeBtn.addTarget(target, action: action, for: event)
        homeBtn.setImage(image ?? UIImage.init(named: "Path 398"), for: .normal)
        homeBtn.setTitle(nil, for: .normal)
        
        return homeBtn
    }
    
    //Added by kiran V2.4 -- GATHER0000176
    ///Returns UIButton with menu Button setup.
    ///
    /// if image is not set appropriate image is assigned. Format (target: , action: , for ,image : )
    func getMenuBtn(target: Any?, action: Selector, for event: UIControlEvents,image : UIImage? = nil) -> UIButton
    {
        let menuBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        menuBtn.setImage(image ?? UIImage.init(named: "hamburgerMenu"), for: .normal)
        menuBtn.setTitle(nil, for: .normal)
        menuBtn.addTarget(target, action: action, for: event)
        
        return menuBtn
    }
    
    //Added by kiran V2.4 -- GATHER0000176
    ///Used for fitness App notifications.
    func getNotificationBtn(newNotifications : Bool,target: Any?,action : Selector, for event: UIControlEvents) -> UIButton
    {
        let image = newNotifications ? UIImage.init(named: "notificationOrange_New") : UIImage.init(named: "notificationOrange")
        let notificationBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        notificationBtn.setImage(image, for: .normal)
        notificationBtn.setTitle(nil, for: .normal)
        notificationBtn.addTarget(target, action: action, for: event)
        return notificationBtn
    }
    
    ///Shows Hamnurger Menu
    func showFitnessAppMenu(delegate : FitnessHamburgerMenuViewControllerDelegate?,view : UIViewController, selectedMenuID : String? = nil)
    {
        let menuVC = UIStoryboard.init(name: "FitnessApp", bundle: nil).instantiateViewController(withIdentifier: "FitnessHamburgerMenuViewController") as! FitnessHamburgerMenuViewController
        menuVC.delegate = delegate
        menuVC.selectedMenuID = selectedMenuID
        let menu = SideMenuNavigationController.init(rootViewController: menuVC)
        menu.presentationStyle = .menuSlideIn
        menu.leftSide = true
        menu.menuWidth = self.view.frame.width * 0.90
        menu.presentationStyle.presentingEndAlpha = 0.2
        menu.presentingViewControllerUserInteractionEnabled = false
        view.present(menu, animated: true, completion: nil)
    }
    
    //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
    //ENGAGE0011372 -- Start
    //Note:- using custom nav back button disbales navigation controller left swipe dismiss functionality. Chose this approach instead of navigation controller subclassing/Extension as when using subclassing/Extension might cause bugs with transitions and pop animation is not shown correctly. Hence choose this approach to implement left swipe dismiss action.
    ///Enables Left edge swipe to dismiss view controller.
    func addLeftEdgeSwipeDismissAction()
    {
        let leftEdgeGestureRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(self.leftEdgeAction(sender:)))
        leftEdgeGestureRecognizer.edges = .left
        self.view.addGestureRecognizer(leftEdgeGestureRecognizer)
    }
    
    ///Pops the current view controller from the navigation controller
    @objc private func leftEdgeAction(sender : UIScreenEdgePanGestureRecognizer)
    {
        self.navigationController?.popViewController(animated: true)
    }
    //ENGAGE0011372 -- End
    
}

extension UIView
{
    func rotate(from: Double,to : Float,duration : Double,onCompletion transform : CGAffineTransform?)
    {
        let basicAnimation = CABasicAnimation.init(keyPath: "transform.rotation")
        basicAnimation.fromValue = from
        basicAnimation.toValue = to
        basicAnimation.duration = duration
        
        self.layer.add(basicAnimation, forKey: nil)
        if let transform = transform
        {
            self.transform = transform
        }
    }
}

//Added by kiran v2.7 -- GATHER0000855
//GATHER0000855 -- Start
extension UIImageView
{
    ///Loads the image in the URL. while doawnloading place holer image is user.
    ///
    /// By default cahce is off. use Should cache to cache the image. Plcae holder is nil by default use placeHolder paramater to assign place holder image
    func setImage(imageURL : String?,shouldCache : Bool = false,placeHolder : UIImage? = nil)
    {
        self.image = placeHolder
        let imageDownloader = ImageDownloadTask()
        imageDownloader.url = imageURL
        imageDownloader.shouldCache = shouldCache
        imageDownloader.startDownload { (data, response, url) in

            if url == imageURL , let data = data
            {
                DispatchQueue.main.async {
                    self.image = UIImage.init(data: data)
                }
            }
        }
    }
    
}

//GATHER0000855 -- End


//Added by kiran V2.7 -- ENGAGE0011658 -- Get identifier for device modle
//ENGAGE0011658 -- Start
extension UIDevice
{
    static let modelIdentifier : String = {
        var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
              guard let value = element.value as? Int8, value != 0 else { return identifier }
              return identifier + String(UnicodeScalar(UInt8(value)))
            }
        return identifier
    }()
}

//ENGAGE0011658 -- End
