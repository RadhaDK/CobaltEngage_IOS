//
//  CreditBookViewController.swift
//  CSSI
//
//  Created by Vishal Pandey on 06/12/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class CreditBookViewController: UIViewController {
    
    @IBOutlet weak var CreditBookDetailsTbl: UITableView!
    @IBOutlet weak var lblCreditBookName: UILabel!
    @IBOutlet weak var lblItemType: UILabel!
    @IBOutlet weak var lblLocation: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        // Do any additional setup after loading the view.
        
//        lblCreditBookName.text = "Credit Name\nCredit Amt"
//        lblItemType.text = "Item Type\nAmt Spent"
//        lblLocation.text = "Location\nCredit Balance"

    }
    // MARK: - IBActions
    @objc private func backBtnAction(sender: UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }


}

// MARK: - TableView Methods
extension CreditBookViewController : UITableViewDelegate, UITableViewDataSource{
    //MARK:- Table delegate & datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CreditBookDetailsTbl.dequeueReusableCell(withIdentifier: "CreditBookDetailCell", for: indexPath) as! CreditBookDetailCell
return cell
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
