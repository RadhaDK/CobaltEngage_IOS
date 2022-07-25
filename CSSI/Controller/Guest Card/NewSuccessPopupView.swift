//
//  NewSuccessPopupView.swift
//  CSSI
//
//  Created by apple on 8/22/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit
protocol closeSuccesPopup
{
    func closeSuccessView()
    
}

class NewSuccessPopupView: UIViewController {
    
    var isSwitch : NSInteger!
    var isFrom :NSString!

    @IBOutlet weak var lblThankYou: UILabel!
    @IBOutlet weak var lblUpdateMessage: UILabel!
    @IBOutlet weak var lblVisitMembership: UILabel!
    var delegate: closeSuccesPopup?
    

    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate

    //Added by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
    //ENGAGE0012667 -- Start
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    //ENGAGE0012667 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblThankYou.text = self.appDelegate.masterLabeling.thank_You ?? "" as String
        lblUpdateMessage.text = self.appDelegate.masterLabeling.guest_modify_validation ?? "" as String
        lblVisitMembership.text = self.appDelegate.masterLabeling.guest_save_validation3 ?? "" as String
        
        
        if isFrom == "Feedback"{
            self.lblVisitMembership.isHidden = true
            lblUpdateMessage.text = self.appDelegate.masterLabeling.appreciate_feedback ?? "" as String
            
            
        }
        else{
            self.lblVisitMembership.isHidden = false
            lblUpdateMessage.text = self.appDelegate.masterLabeling.guest_modify_validation ?? "" as String
            self.lblThankYou.textColor = APPColor.textColor.secondary
        }
        
        
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        if isSwitch == 1{
            self.lblVisitMembership.isHidden = false
        }
        else{
            self.lblVisitMembership.isHidden = true
        }

        // Do any additional setup after loading the view.
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func closeClicked(_ sender: Any) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        self.delegate?.closeSuccessView()

        
    }
    
    
}
