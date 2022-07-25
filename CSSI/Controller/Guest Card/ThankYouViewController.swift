//
//  ThankYouViewController.swift
//  CSSI
//
//  Created by Apple on 28/09/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class ThankYouViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true

    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
        
    @IBAction func CloseIconClicked(_ sender: Any) {
        self.navigationController!.popToRootViewController(animated: true)

    }
    
  

}
