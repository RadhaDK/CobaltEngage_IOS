//
//  DinningDetailRestuarantVC.swift
//  CSSI
//
//  Created by Aks on 03/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class DinningDetailRestuarantVC: UIViewController, UITableViewDelegate,UITableViewDataSource {

    
    var showNavigationBar = true
    @IBOutlet weak var tblGuest: UITableView!
    @IBOutlet weak var imgRestuarant: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblGuest.delegate = self
        tblGuest.dataSource  = self
        imgRestuarant.layer.cornerRadius = 8
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = !self.showNavigationBar
    }

    
    // MARK: - Table Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblGuest.dequeueReusableCell(withIdentifier: "AddGuestTableCell", for: indexPath) as! AddGuestTableCell
       
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
}
