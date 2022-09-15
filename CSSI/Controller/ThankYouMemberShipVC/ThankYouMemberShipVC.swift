//
//  ThankYouMemberShipVC.swift
//  CSSI
//
//  Created by Vishal Pandey on 06/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
protocol segueFromController : class {
func segueFromController()
}
class ThankYouMemberShipVC: UIViewController {
    
    @IBOutlet weak var thankYouLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var btnRemovePopUp: UIButton!


    var thankYouDesc : String?
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    weak var segueDelegate: segueFromController?
    var segmentIndex: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if thankYouDesc != nil{
        descriptionLbl.text = thankYouDesc
        }
        
        thankYouLbl.text = self.appDelegate.masterLabeling.thank_You

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
       
        
    }
    
    @IBAction func removePopUpBtnTapped(sender:UIButton){
        let presentingController = self.presentingViewController
        self.dismiss(animated: true) {
            if let navigationController = presentingController as? UINavigationController,
               let myDownloadsViewController = navigationController.viewControllers.first(
                   where: { viewController in
                       viewController is ProfileViewOnlyVC
                   }
               ) {
               navigationController.popToViewController(myDownloadsViewController, animated: true)
            }
        }
    }
    
}
