//
//  GuestCardPolicyVC.swift
//  CSSI
//
//  Created by apple on 02/10/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class GuestCardPolicyVC: UIViewController {
    @IBOutlet weak var lblGuestCardpolicytitle: UILabel!
    
    @IBOutlet weak var lblGuestCardPolicy: UILabel!
    @IBOutlet weak var lblGuest2: UILabel!
    @IBOutlet weak var lblguest4: UILabel!
    var isFrom : String?
    @IBOutlet weak var lblGuest3: UILabel!
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(isFrom == "DiningRequest"){
            lblGuestCardpolicytitle.text = self.appDelegate.masterLabeling.dining_policy ?? "" as String
            lblGuestCardPolicy.text = self.appDelegate.masterLabeling.dINING_POLICY_1 ?? "" as String
            lblGuest2.text = self.appDelegate.masterLabeling.dINING_POLICY_2 ?? "" as String
            lblGuest3.text = self.appDelegate.masterLabeling.dINING_POLICY_3 ?? "" as String
            lblguest4.text = self.appDelegate.masterLabeling.dINING_POLICY_4 ?? "" as String
            
        }else  if(isFrom == "TennisRequest"){
            lblGuestCardpolicytitle.text = self.appDelegate.masterLabeling.tennis_policy ?? "" as String
            lblGuestCardPolicy.text = self.appDelegate.masterLabeling.tENNIS_POLICY_1 ?? "" as String
            lblGuest2.text = self.appDelegate.masterLabeling.tENNIS_POLICY_2 ?? "" as String
            lblGuest3.text = self.appDelegate.masterLabeling.tENNIS_POLICY_3 ?? "" as String
            lblguest4.text = self.appDelegate.masterLabeling.tENNIS_POLICY_4 ?? "" as String
            
        }
        else  if(isFrom == "GolfRequest"){
            lblGuestCardpolicytitle.text = self.appDelegate.masterLabeling.golf_policy ?? "" as String
            lblGuestCardPolicy.text = self.appDelegate.masterLabeling.gOLF_POLICY_1 ?? "" as String
            lblGuest2.text = self.appDelegate.masterLabeling.gOLF_POLICY_2 ?? "" as String
            lblGuest3.text = self.appDelegate.masterLabeling.gOLF_POLICY_3 ?? "" as String
            lblguest4.text = self.appDelegate.masterLabeling.gOLF_POLICY_4 ?? "" as String
            
        }
        else{
        
        
        lblGuestCardpolicytitle.text = self.appDelegate.masterLabeling.guest_card_policy ?? "" as String
        lblGuestCardPolicy.text = self.appDelegate.masterLabeling.guestcard_policy_1 ?? "" as String
        lblGuest2.text = self.appDelegate.masterLabeling.guestcard_policy_2 ?? "" as String
        lblGuest3.text = self.appDelegate.masterLabeling.guestcard_policy_3 ?? "" as String
        lblguest4.text = self.appDelegate.masterLabeling.guestcard_policy_4 ?? "" as String
        }
        
        self.lblGuestCardpolicytitle.textColor = APPColor.textColor.secondary
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
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.navigationBar.isHidden = false
        
    }
    

    @IBAction func CloseClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
