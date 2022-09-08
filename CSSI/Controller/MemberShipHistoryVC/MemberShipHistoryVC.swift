//
//  MemberShipHistoryVC.swift
//  CSSI
//
//  Created by Vishal Pandey on 06/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class MemberShipHistoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    
    @IBOutlet weak var tblMemHistory:UITableView!
    @IBOutlet weak var btnClose:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        tblMemHistory.delegate = self
        tblMemHistory.dataSource  = self
        btnClose.layer.cornerRadius = 15
        btnClose.layer.borderWidth = 1
        btnClose.layer.borderColor = UIColor(red: 27/255, green: 202/255, blue: 255/255, alpha: 1).cgColor
        registerNibs()
        // Do any additional setup after loading the view.
    }
    
    func registerNibs(){
            let homeNib = UINib(nibName: "MembershipHistoryCell" , bundle: nil)
           self.tblMemHistory.register(homeNib, forCellReuseIdentifier: "MembershipHistoryCell")
       }
    
    @IBAction func closeBtnTapped(sender:UIButton){
//        btnClose.layer.borderColor = UIColor(red: 27/255, green: 202/255, blue: 255/255, alpha: 1).cgColor
        self.dismiss(animated: true, completion: nil)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblMemHistory.dequeueReusableCell(withIdentifier: "MembershipHistoryCell", for: indexPath) as! MembershipHistoryCell
        return cell
    }
    
  
    
}
