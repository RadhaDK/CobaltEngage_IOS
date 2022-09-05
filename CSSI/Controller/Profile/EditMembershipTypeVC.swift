//
//  EditMembershipTypeVC.swift
//  CSSI
//
//  Created by Vishal Pandey on 05/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class EditMembershipTypeVC: UIViewController {
    
    @IBOutlet weak var tblMembershipType: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tblMembershipType.delegate = self
        tblMembershipType.dataSource = self
       // self.navigationItem.title = self.appDelegate.masterLabeling.tT_PREFERENCES
        self.navigationItem.title = "Update Membership Type"
registerNibs()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        
    }
    
    func registerNibs(){
        let menuNib = UINib(nibName: "EditMembershipTypeTableViewCell" , bundle: nil)
        self.tblMembershipType.register(menuNib, forCellReuseIdentifier: "EditMembershipTypeTableViewCell")
        self.tblMembershipType.rowHeight = UITableViewAutomaticDimension
    }
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
}

extension EditMembershipTypeVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblMembershipType.dequeueReusableCell(withIdentifier: "EditMembershipTypeTableViewCell", for: indexPath) as! EditMembershipTypeTableViewCell
return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
}
