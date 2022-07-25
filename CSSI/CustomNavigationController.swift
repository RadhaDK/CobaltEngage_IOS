//
//  CustomNavigationController.swift
//  CSSI
//
//  Created by Kiran on 25/10/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.applyCustomizations()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    private func applyCustomizations()
    {
        if #available(iOS 15.0,*)
        {
            let navigationStyle = UINavigationBarAppearance.init()
            navigationStyle.configureWithDefaultBackground()
            navigationStyle.backgroundColor = APPColor.navigationColor.barbackgroundcolor
            navigationStyle.titleTextAttributes = [NSAttributedString.Key.foregroundColor : APPColor.navigationColor.navigationitemcolor]
            navigationStyle.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : APPColor.navigationColor.navigationitemcolor]
            self.navigationBar.tintColor = APPColor.viewBgColor.viewbg
            self.navigationBar.standardAppearance = navigationStyle
            self.navigationBar.scrollEdgeAppearance = navigationStyle
        }
        else
        {
            UINavigationBar.appearance().barStyle = UIBarStyle.black
            // Translucency; false == opaque
            UINavigationBar.appearance().isTranslucent = false
            // BACKGROUND color of nav bar
            UINavigationBar.appearance().barTintColor = APPColor.navigationColor.barbackgroundcolor
            // Foreground color of bar button item text, e.g. "< Back", "Done", and so on.
            //        UINavigationBar.appearance().tintColor = APPColor.tintColor.tint
            UINavigationBar.appearance().tintColor = APPColor.viewBgColor.viewbg
            
            self.navigationBar.backIndicatorImage = UIImage(named: "Path 117")
            self.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Path 117")
            self.navigationBar.tintColor = APPColor.viewNews.backButtonColor
        }
        
    }
    
    func setNavBarColorFor(MemberID : Bool)
    {
        if #available(iOS 15.0, *) {
            var color : UIColor = APPColor.navigationColor.barbackgroundcolor
            if MemberID
            {
                color = hexStringToUIColor(hex: "#949B9F")//APPColor.loginBackgroundButtonColor.loginBtnBGColor
            }
            let navigationStyle = UINavigationBarAppearance.init()
            navigationStyle.configureWithDefaultBackground()
            navigationStyle.backgroundColor = color
            navigationStyle.titleTextAttributes = [NSAttributedString.Key.foregroundColor : APPColor.navigationColor.navigationitemcolor]
            navigationStyle.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : APPColor.navigationColor.navigationitemcolor]
            self.navigationBar.tintColor = APPColor.viewBgColor.viewbg
            self.navigationBar.standardAppearance = navigationStyle
            self.navigationBar.scrollEdgeAppearance = navigationStyle
        } else {
            // Fallback on earlier versions
        }
    }
    
}
