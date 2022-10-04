//
//  DiningReservationVC.swift
//  CSSI
//
//  Created by Aks on 03/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class DiningReservationVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var tblResturat: UITableView!
    @IBOutlet weak var lblSelectedDate: UILabel!
    @IBOutlet weak var viewPrevious: UIView!
    @IBOutlet weak var viewNext: UIView!
    @IBOutlet weak var viewDate: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblResturat.delegate = self
        tblResturat.dataSource  = self
        shadowView(viewName: viewTime)
        shadowView(viewName: viewPrevious)
        shadowView(viewName: viewDate)
        shadowView(viewName: viewNext)

      
        registerNibs()
    }
    func registerNibs(){
        let homeNib = UINib(nibName: "DiningResvTableCell" , bundle: nil)
        self.tblResturat.register(homeNib, forCellReuseIdentifier: "DiningResvTableCell")
    }
    
    func shadowView(viewName : UIView){
        viewName.layer.shadowColor = UIColor.black.cgColor
        viewName.layer.shadowOpacity = 0.12
        viewName.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewName.layer.shadowRadius = 6
    }
    // MARK: - Table Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblResturat.dequeueReusableCell(withIdentifier: "DiningResvTableCell", for: indexPath) as! DiningResvTableCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let impVC = UIStoryboard.init(name: "DiningStoryboard", bundle: .main).instantiateViewController(withIdentifier: "DinningDetailRestuarantVC") as? DinningDetailRestuarantVC {
            impVC.showNavigationBar = false

            self.navigationController?.pushViewController(impVC, animated: true)
        }
    }
}
