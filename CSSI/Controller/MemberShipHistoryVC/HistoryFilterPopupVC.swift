//
//  HistoryFilterPopupVC.swift
//  CSSI
//
//  Created by Aks on 14/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
//protocol selectedHistoryFilter{
//    func selectedFilterHistory(type: String)
//}
//
//class HistoryFilterPopupVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    @IBOutlet weak var tblFilterHistory: UITableView!
//    @IBOutlet weak var lblFilterHeading: UILabel!
//    @IBOutlet weak var btnDismiss: UIButton!
//    
//    
//    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//    var delegateHistoryFilter : selectedHistoryFilter?
//    var arrForFilterOption : [statusListing]?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        
//        
//        btnDismiss.setTitle("", for: .normal)
//        tblFilterHistory.delegate = self
//        tblFilterHistory.dataSource  = self
//        registerNibs()
//        // Do any additional setup after loading the view.
//        
//
//    }
//    func registerNibs(){
//            let homeNib = UINib(nibName: "FilterHistoryTableViewCell" , bundle: nil)
//           self.tblFilterHistory.register(homeNib, forCellReuseIdentifier: "FilterHistoryTableViewCell")
//       }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arrForFilterOption?.count ?? 0
//
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tblFilterHistory.dequeueReusableCell(withIdentifier: "FilterHistoryTableViewCell", for: indexPath) as! FilterHistoryTableViewCell
//        let dict = arrForFilterOption?[indexPath.row]
//        cell.lblFilterType.text = dict?.Value
//        return cell
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let dict = arrForFilterOption?[indexPath.row]
//        self.dismiss(animated: true)
//        delegateHistoryFilter?.selectedFilterHistory(type: dict?.Value ?? "")
//
//    }
//    @IBAction func btnDismiss(_ sender: Any) {
//        self.dismiss(animated: true)
//    }
//}
