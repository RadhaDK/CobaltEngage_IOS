//
//  TabbarViewController.swift
//  CSSI
//
//  Created by Samadhan on 15/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Popover

class TabbarViewController: UITabBarController {
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrfooterTabbar = [LandingMenus]()
    let defaults = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let memberid = UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)
        
        if memberid == nil {
            let prefs = UserDefaults.standard
            prefs.removeObject(forKey:"userID")
            prefs.removeObject(forKey:"getTabbar")
            UserDefaults.standard.synchronize()
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let initialLoginVC = mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            //Modified by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
            //ENGAGE0012667 -- Start
            let navigationController = CustomNavigationController(rootViewController: initialLoginVC)//UINavigationController(rootViewController: initialLoginVC)
            //ENGAGE0012667 -- End
            UIApplication.shared.keyWindow?.rootViewController = navigationController
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
            
//            let viewControllers = self.navigationController!.viewControllers as [UIViewController];
//            print("viewControllers:",viewControllers)
        }
        else{
            let defaults = UserDefaults.standard
            let responseString = String(describing: defaults.object(forKey: "getTabbar") ?? "")
            if((responseString.count <= 0)){
                let prefs = UserDefaults.standard
                prefs.removeObject(forKey:"userID")
                prefs.removeObject(forKey:"getTabbar")
                UserDefaults.standard.synchronize()
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                let initialLoginVC = mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                //Modified by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
                //ENGAGE0012667 -- Start
                let navigationController = CustomNavigationController(rootViewController: initialLoginVC)//UINavigationController(rootViewController: initialLoginVC)
                //ENGAGE0012667 -- End
                UIApplication.shared.keyWindow?.rootViewController = navigationController
                UIApplication.shared.keyWindow?.makeKeyAndVisible()
                
            }
            else{
                let tabbarmodelinfo = TabbarModel(JSONString: responseString)!
                self.appDelegate.tabbarControllerInit = tabbarmodelinfo
                if (self.appDelegate.tabbarControllerInit.memberApp?.footerMenus?.count)!>0 {
                    self.arrfooterTabbar = (self.appDelegate.tabbarControllerInit.memberApp?.landingMenus) ?? []
                    
                    //Modified by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
                    //ENGAGE0012667 -- Start
                    var navigationControllerTodayatGlance = CustomNavigationController()//UINavigationController()
                    
                    var viewController = [CustomNavigationController]()//[UINavigationController]()
                    //ENGAGE0012667 -- End
                    
                    for i in 0..<self.arrfooterTabbar.count{
                        var dictdata = LandingMenus()
                        dictdata = self.arrfooterTabbar[i]
                        print("View Controller : \(dictdata.displayName!)")
                        
                            if UserDefaults.standard.string(forKey: UserDefaultsKeys.isFirstTime.rawValue)  == "1" {
                            let homeVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePWViewController") as! ChangePWViewController
                                //Modified by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
                                //ENGAGE0012667 -- Start
                            navigationControllerTodayatGlance = CustomNavigationController(rootViewController: homeVC)//UINavigationController(rootViewController: homeVC)
                                //ENGAGE0012667 -- End
                            homeVC.memberID =  UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? ""
                            homeVC.displayName =  UserDefaults.standard.string(forKey: UserDefaultsKeys.displayName.rawValue) ?? ""
                            homeVC.profilePic =  UserDefaults.standard.string(forKey: UserDefaultsKeys.userProfilepic.rawValue) ?? ""
                            homeVC.UserID =  UserDefaults.standard.string(forKey: UserDefaultsKeys.memberUserName.rawValue) ?? ""
                            viewController.append(navigationControllerTodayatGlance)
                            
                            }else{
                            let homeVC = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
                                //Modified by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
                                //ENGAGE0012667 -- Start
                            navigationControllerTodayatGlance = CustomNavigationController(rootViewController: homeVC)//UINavigationController(rootViewController: homeVC)
                                //ENGAGE0012667 -- End
                            navigationControllerTodayatGlance.title = dictdata.displayName
                            homeVC.arrfooterTabbar = arrfooterTabbar

                            viewController.append(navigationControllerTodayatGlance)
                        }
                        
                    }
                    viewControllers = viewController
                    
                }
                else{
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
        
   
        
    }

    // UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        print(item)
    }
    
    //MARK:- getMultiLingual Api
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
