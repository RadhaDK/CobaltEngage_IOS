//
//  NotificationDetailsVC.swift
//  CSSI
//
//  Created by apple on 3/7/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit


class NotificationDetailsVC: UIViewController {

    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var uiView: UIView!
    
    var notificationText: String!
    var notificationSubject: String!
    
    var details: Any!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var htmlText : String!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {

       

        self.navigationItem.title = self.appDelegate.masterLabeling.tT_NOTIFICATIONS
        
        
        if(self.appDelegate.masterLabeling.tT_NOTIFICATIONS  == nil ){
            self.navigationItem.title = "Notifications"
        }
        self.navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "695B5E")
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = hexStringToUIColor(hex: "695B5E")
        
        
        lblText.text = notificationText
        lblSubject.text = notificationSubject
//        lblText.attributedText = htmlText.htmlToAttributedString

        
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
    }
    @objc func onTapHome() {
        

        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
            self.navigationController?.navigationBar.isHidden = true
       
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    
}
