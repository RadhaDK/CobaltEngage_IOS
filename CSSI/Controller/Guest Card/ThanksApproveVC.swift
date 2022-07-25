//
//  ThanksApproveVC.swift
//  CSSI
//
//  Created by apple on 06/10/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class ThanksApproveVC: UIViewController {
    var isSwitch : NSInteger!
    var isFrom :NSString!
    
    @IBOutlet weak var lblSwitchmessage: UILabel!
    @IBOutlet weak var lblThanksTitle: UILabel!
    @IBOutlet weak var lblUpdatedSuccessfully: UILabel!
    
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblThanksTitle.text = self.appDelegate.masterLabeling.thank_You ?? "" as String
        lblUpdatedSuccessfully.text = self.appDelegate.masterLabeling.guest_modify_validation ?? "" as String
        lblSwitchmessage.text = self.appDelegate.masterLabeling.guest_save_validation3 ?? "" as String
        
        if isFrom == "Feedback"{
            self.lblSwitchmessage.isHidden = true
            lblUpdatedSuccessfully.text = self.appDelegate.masterLabeling.appreciate_feedback ?? "" as String

        }
        else{
            self.lblSwitchmessage.isHidden = false
            lblUpdatedSuccessfully.text = self.appDelegate.masterLabeling.guest_modify_validation ?? "" as String

        }
   
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        if isSwitch == 1{
            self.lblSwitchmessage.isHidden = false
        }
        else{
            self.lblSwitchmessage.isHidden = true
        }
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        
    }


    @IBAction func closeClicked(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
        
        if isFrom == "Feedback"{

                self.view.window!.rootViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
            
        }
        else{

        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for popToViewController in viewControllers {
            if popToViewController is GuestCardsViewController {
                self.navigationController?.navigationBar.isHidden = false
                
                self.navigationController!.popToViewController(popToViewController, animated: true)
                
            }
        }
        }
    }

}
