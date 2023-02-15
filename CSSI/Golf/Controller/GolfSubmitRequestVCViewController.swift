//
//  GolfSubmitRequestVCViewController.swift
//  CSSI
//
//  Created by Aks on 13/02/23.
//  Copyright © 2023 yujdesigns. All rights reserved.
//

import UIKit

class GolfSubmitRequestVCViewController: UIViewController {

    
    
    @IBOutlet weak var tblViewfirstComeFirstServce: UITableView!
    @IBOutlet weak var tblViewfirstComeFirstServceConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnAddMultiple: UIButton!
    @IBOutlet weak var btnAddMultipleHeight: NSLayoutConstraint!
    @IBOutlet weak var btnDone: UIButton!

    
    var addNewPopoverTableView: UITableView? = nil
    private var isMultiSelectionClicked = false
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var isFrom = "View"
    override func viewDidLoad() {
        super.viewDidLoad()

setUpUiInitialization()

        registerNibs()
       
        // Do any additional setup after loading the view.
    }
    
    func registerNibs(){
        let nib = UINib(nibName: "AddPlayerTableCell" , bundle: nil)
        self.tblViewfirstComeFirstServce.register(nib, forCellReuseIdentifier: "AddPlayerTableCell")
    }
    
    //MARK: - setUpUI
    func setUpUi(){
       // viewTime.shadowView(viewName: viewTime)
        btnBack.setTitle("", for: .normal)
        btnHome.setTitle("", for: .normal)
       // btnTime.setTitle("", for: .normal)
        btnAddMultiple.layer.cornerRadius = btnAddMultiple.layer.frame.height/2
        btnAddMultiple.layer.borderWidth = 1
        btnAddMultiple.layer.borderColor = UIColor(red: 59/255, green: 135/255, blue: 193/255, alpha: 1).cgColor
    }
    func setUpUiInitialization(){
                self.tblViewfirstComeFirstServce.delegate = self
                self.tblViewfirstComeFirstServce.dataSource = self
                self.tblViewfirstComeFirstServce.estimatedRowHeight = 50
                self.tblViewfirstComeFirstServce.estimatedSectionHeaderHeight = 50
                self.tblViewfirstComeFirstServce.register(UINib.init(nibName: "FirstComeFirstServeTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstComeFirstServeTableViewCell")
                self.tblViewfirstComeFirstServce.separatorStyle = .none
                let footerView = UIView()
                footerView.backgroundColor = .clear
                self.tblViewfirstComeFirstServce.tableFooterView = footerView
                if #available(iOS 15.0, *)
                {
                    self.tblViewfirstComeFirstServce.sectionHeaderTopPadding = 0
                }
                self.tblViewfirstComeFirstServceConstraint.constant = self.tblViewfirstComeFirstServce.contentSize.height
        setUpUi()
    }

    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tblViewfirstComeFirstServceConstraint.constant = self.tblViewfirstComeFirstServce.contentSize.height
    }
    
    //MARK: - IBActions
    @IBAction func doneBtnTapped(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
        
     //   delegateSelectedTimePatySize?.SelectedPartysizeTme(PartySize: selectedPartySize, Time: datePicker.date)
    }
    @IBAction func multiSelectionClicked(_ sender: UIButton)
    {
        
        self.isMultiSelectionClicked = true
    }


    
}
extension GolfSubmitRequestVCViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tblViewfirstComeFirstServce.dequeueReusableCell(withIdentifier: "AddPlayerTableCell", for: indexPath) as? AddPlayerTableCell {
            //cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = Bundle.main.loadNibNamed("ModifyRequestHeaderView", owner: self, options: nil)?.first as! ModifyRequestHeaderView
//        return headerView
//    }
}
   
