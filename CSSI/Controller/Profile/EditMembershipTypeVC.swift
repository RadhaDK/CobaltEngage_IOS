//
//  EditMembershipTypeVC.swift
//  CSSI
//
//  Created by Vishal Pandey on 05/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class EditMembershipTypeVC: UIViewController {
    
    //MARK:- outlets
    @IBOutlet weak var tblMembershipType: UITableView!
    @IBOutlet weak var btnCancelPendingrequest: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    var thereIsCellTapped = false
       var expanded:[IndexPath] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMembershipType.delegate = self
        tblMembershipType.dataSource = self
        // self.navigationItem.title = self.appDelegate.masterLabeling.tT_PREFERENCES
        self.navigationItem.title = "Update Membership Type"
        btnCancelPendingrequest.layer.cornerRadius = btnCancelPendingrequest.frame.height/2
        btnCancelPendingrequest.layer.borderWidth = 1
        btnCancelPendingrequest.layer.borderColor = UIColor(red: 52/255, green: 210/255, blue: 255/255, alpha: 1).cgColor
        
        btnSave.layer.cornerRadius = btnCancelPendingrequest.frame.height/2
        btnSave.layer.borderWidth = 1
        btnSave.layer.borderColor = UIColor(red: 52/255, green: 210/255, blue: 255/255, alpha: 1).cgColor
        btnCancel.layer.cornerRadius = btnCancelPendingrequest.frame.height/2
        btnCancel.layer.borderWidth = 1
        btnCancel.layer.borderColor = UIColor(red: 52/255, green: 210/255, blue: 255/255, alpha: 1).cgColor

        registerNibs()
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        
    }
    
    //MARK:- register Nib
    func registerNibs(){
        let menuNib = UINib(nibName: "EditMembershipTypeTableViewCell" , bundle: nil)
        self.tblMembershipType.register(menuNib, forCellReuseIdentifier: "EditMembershipTypeTableViewCell")
        self.tblMembershipType.rowHeight = UITableViewAutomaticDimension
    }
    
    
    
    
    
    //Button actions
    @IBAction func btnCancelPendingRequest(_ sender: Any) {
        
    }
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSave(_ sender: Any) {
        if let vc = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ThankYouMemberShipVC") as? ThankYouMemberShipVC{
            self.present(vc, animated: true, completion: nil)
        }
        
           
    }
    @IBAction func btnCancel(_ sender: Any) {
    }
      
}

extension EditMembershipTypeVC : UITableViewDelegate, UITableViewDataSource{
    //MARK:- Table delegate & datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblMembershipType.dequeueReusableCell(withIdentifier: "EditMembershipTypeTableViewCell", for: indexPath) as! EditMembershipTypeTableViewCell
      
        self.expanded.append(IndexPath(row:indexPath.row, section:1))
        cell.openClose = {
                
                  let checkPath = IndexPath(row:indexPath.row, section:1)

                  if (self.expanded.contains(checkPath)) {
                      print ("is expanded")
                      if cell.lblMembershipDescription.isHidden == true{
                         
                        //  cell?.imgExpandCollapse.image = UIImage(named: "ic_MinusBlack")
                        //  cell?.bottomView.isHidden = true
                          cell.lblMembershipDescription.isHidden = false
                         // cell?.bottomView.isHidden = false
                          self.tblMembershipType.beginUpdates()
                          self.tblMembershipType.endUpdates()
                          
                      }
                      else{
                        //  cell?.imgExpandCollapse.image = UIImage(named: "ic_plusBlack")
                        //  cell?.bottomView.isHidden = false
                          cell.lblMembershipDescription.isHidden = true
                        //  cell?.bottomView.isHidden = true
                          self.tblMembershipType.beginUpdates()
                          self.tblMembershipType.endUpdates()
                          print("kjhgsDhjk")
                      }
                  }
              }
              
        
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
    
    
}
