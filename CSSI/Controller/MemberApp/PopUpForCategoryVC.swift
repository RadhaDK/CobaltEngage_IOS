//
//  PopUpForCategoryVC.swift
//  CSSI
//
//  Created by apple on 1/18/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class PopUpForCategoryVC: UIViewController {
    @IBOutlet weak var lblDidYouKnow: UILabel!
    @IBOutlet weak var lblViewByCategory: UILabel!
    @IBOutlet weak var lblCategoryNames: UILabel!
    @IBOutlet weak var lblMemberInterest: UILabel!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var imgFilterIcon: UIImageView!
    var isFrom : NSString!
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

        // Do any additional setup after loading the view.
        if isFrom == "MemberDir" {
            self.lblDidYouKnow.text = self.appDelegate.masterLabeling.didYouKnow ?? "" as String
            self.lblViewByCategory.text = self.appDelegate.masterLabeling.didYouKnowMemberDire1 ?? "" as String
            self.lblMemberInterest.text = self.appDelegate.masterLabeling.didYouKnowMemberDire2 ?? "" as String
            self.lblCategoryNames.text = self.appDelegate.masterLabeling.didYouKnowMemberDire3 ?? "" as String
            self.imgFilterIcon.isHidden = false
            self.height.constant = 28
            self.lblMemberInterest.isHidden = false


        }
        else if isFrom == "TodayAtGlance"{
            
            self.lblDidYouKnow.text = self.appDelegate.masterLabeling.didYouKnow ?? "" as String
            self.lblViewByCategory.text = self.appDelegate.masterLabeling.ableToViewByCategory ?? "" as String
            self.lblCategoryNames.text = self.appDelegate.masterLabeling.didYouKnowGlance ?? "" as String
            self.imgFilterIcon.isHidden = true
            self.height.constant = 2
            self.lblMemberInterest.isHidden = true
        }
        else if  isFrom == "Events" {
            self.lblDidYouKnow.text = self.appDelegate.masterLabeling.didYouKnow ?? "" as String
            self.lblViewByCategory.text = self.appDelegate.masterLabeling.ableToViewByCategory ?? "" as String
            self.lblCategoryNames.text = self.appDelegate.masterLabeling.didYouKnowEvents ?? "" as String
            self.imgFilterIcon.isHidden = true
            self.height.constant = 2
            self.lblMemberInterest.isHidden = true


        }
        else if isFrom == "Statements"{
            self.lblDidYouKnow.text = self.appDelegate.masterLabeling.didYouKnow ?? "" as String
            self.lblViewByCategory.text = self.appDelegate.masterLabeling.ableToViewByCategory ?? "" as String
            self.lblCategoryNames.text = self.appDelegate.masterLabeling.didYouKnowStatement ?? "" as String
            self.imgFilterIcon.isHidden = true
            self.height.constant = 2
            self.lblMemberInterest.isHidden = true


        }
        else if isFrom == "ViewNews"{
            self.lblDidYouKnow.text = self.appDelegate.masterLabeling.didYouKnow ?? "" as String
            self.lblViewByCategory.text = self.appDelegate.masterLabeling.ableToViewByCategory ?? "" as String
            self.lblCategoryNames.text = self.appDelegate.masterLabeling.didYouKnowClubNews ?? "" as String
            self.imgFilterIcon.isHidden = true
            self.height.constant = 2
            self.lblMemberInterest.isHidden = true



            
        
       
        }
        
        
    }
    

    
    @IBAction func closeClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
}
