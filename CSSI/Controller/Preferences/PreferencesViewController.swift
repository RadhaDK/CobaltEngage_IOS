//
//  PreferencesViewController.swift
//  CSSI
//
//  Created by MACMINI13 on 06/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import KUITagLabel
import Alamofire
import AlamofireImage
import Popover




class PreferencesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var dictMemberInfo = GetMemberInfo()
    
    var dictPrimaryAddress = Address()
    var dictSecondaryAddress = Address()
    
    //    var arrPrimaryAddress = [Address]()
    var arrinterest = [ProfileInterest]()
    
    var isVisibileNumber = false
    var isVisibileMobileno = false
    var isVisibileEmail = false
    var isVisibilePrimaryAddress = false
    var isVisibileSecondaryAddress = false
    
    
    @IBOutlet weak var uifooterView: UIView!
    @IBOutlet weak var uiScrollView: UIScrollView!
    let img_visible = UIImage(named: "icon_visible_blue")
    let img_notvisible = UIImage(named: "icon_unvisible_blue")
    
    @IBOutlet weak var btnMobileNumberVisible: UIButton!
    @IBOutlet weak var btnMobileNumberVisibleTitle: UIButton!
    
    @IBOutlet weak var btnNumberVisible: UIButton!
    @IBOutlet weak var btnNumberVisibleTitle: UIButton!
    
    //    @IBOutlet weak var btnBocawestVisible: UIButton!
    //    @IBOutlet weak var btnBocawestVisibleTitle: UIButton!
    
    @IBOutlet weak var btnOtherVisible: UIButton!
    @IBOutlet weak var btnOtherVisibleTitle: UIButton!
    
    
    @IBOutlet weak var btnEmailVisible: UIButton!
    @IBOutlet weak var btnEmailVisibleTitle: UIButton!
    
    @IBOutlet weak var lblEmail: UILabel!
    //    @IBOutlet weak var lblAddress: UILabel!
    //    @IBOutlet weak var lblAddress2: UILabel!
    
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblpassword: UILabel!
    @IBOutlet weak var lblmobno: UILabel!
    @IBOutlet weak var lblprimarymob: UILabel!
    
    
    @IBOutlet weak var uiView1: UIView!
    @IBOutlet weak var uiView2: UIView!
    //    @IBOutlet weak var uiView3: UIView!
    @IBOutlet weak var uiViewAddress: UIView!
    @IBOutlet weak var uiView4: UIView!
    @IBOutlet weak var uiView5: UIView!
    @IBOutlet weak var uiView6: UIView!
    
    @IBOutlet weak var uiMainView: UIView!
    @IBOutlet weak var consUIViewAddressHeight: NSLayoutConstraint!
    
    @IBOutlet weak var consTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tableViewAddress: UITableView!
    
    @IBOutlet weak var consUIviewNotificationTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.navigationController?.navigationBar.isHidden = false
        //navigation item labelcolor
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "Preferences"
        self.navigationController?.navigationBar.backItem?.title =  CommonString.kNavigationBack

        
        self.tableViewAddress.estimatedRowHeight = 64
        self.tableViewAddress.rowHeight = UITableViewAutomaticDimension
        
        
        
        
        uiView1.addBottomBorderWithColor(color: UIColor.lightGray, width: 1)
        uiView2.addBottomBorderWithColor(color: UIColor.lightGray, width: 1)
        self.uiViewAddress.addBottomBorderWithColor(color: UIColor.lightGray, width: 1)
        uiView4.addBottomBorderWithColor(color: UIColor.lightGray, width: 1)
        uiView5.addBottomBorderWithColor(color: UIColor.lightGray, width: 1)
        //       profileApi()
        
        
        //        self.arrPrimaryAddress = self.arrgetMemberInfo
        
               let editButton : UIBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action:#selector(navigateToEditprefrence))
        
                self.navigationItem.rightBarButtonItem = editButton
        
        // Do any additional setup after loading the view.
        
        
        
        //        self.dictPrimaryAddress = self.dictMemberInfo.address![0]
        //        self.dictSecondaryAddress = self.dictMemberInfo.address![1]
        
        
        
        
        //        print(self.dictSecondaryAddress.city ?? "")
        
        //        self.lblAddress.text = self.dictPrimaryAddress.street1! + self.dictPrimaryAddress.city!
        //
        //        self.lblAddress2.text = self.dictPrimaryAddress.street1! + self.dictPrimaryAddress.city!
        //
        //        self.lblmobno.text = self.dictMemberInfo.secondaryPhone!
        //
        //        self.lblEmail.text = self.dictMemberInfo.primaryEmail!
        //
        //        self.lblUsername.text = self.dictMemberInfo.displayName
        //
        //        self.lblprimarymob.text = self.dictMemberInfo.primaryPhone!
        //
        //
        //
        //
        self.lblmobno.text = self.dictMemberInfo.secondaryPhone ?? ""
        
        
        self.lblEmail.text = self.dictMemberInfo.primaryEmail ?? ""
        
        self.lblUsername.text = self.dictMemberInfo.displayName ?? ""
        
        
        self.lblprimarymob.text = self.dictMemberInfo.primaryPhone ?? ""
        
        self.tableViewAddress.reloadData()
        
        self.tableViewAddress.isScrollEnabled = false
        self.tableViewAddress.frame = CGRect(x: self.tableViewAddress.frame.origin.x, y: self.tableViewAddress.frame.origin.y, width: self.tableViewAddress.frame.size.width, height: self.tableViewAddress.contentSize.height)
//        self.consTableViewHeight.constant = self.tableViewAddress.contentSize.height
        self.consUIViewAddressHeight.constant = self.tableViewAddress.contentSize.height
        
        let scrollHeight = self.uiViewAddress.frame.size.height + self.uiViewAddress.frame.origin.y  + 800
        
        self.uiScrollView.isScrollEnabled = true
        
        self.uiViewAddress.layoutIfNeeded()
        self.tableViewAddress.layoutIfNeeded()
        self.uiScrollView.contentSize = CGSize(width: self.view.frame.size.width , height: scrollHeight)
        self.uiScrollView.layoutIfNeeded()

//
//        self.uiView4.layoutIfNeeded()
//        self.uiView5.layoutIfNeeded()
//        self.uiView6.layoutIfNeeded()
        self.uiMainView.layoutIfNeeded()
        
        self.view.layoutIfNeeded()
        
        if(dictMemberInfo.notificatonStatus == "true")
        {
            
        }
        
        self.tableViewAddress.tableFooterView = self.uifooterView
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    self.tableViewAddress.frame = CGRect(x: self.tableViewAddress.frame.origin.x, y: self.tableViewAddress.frame.origin.y, width: self.tableViewAddress.frame.size.width, height: self.tableViewAddress.contentSize.height)
//    self.consTableViewHeight.constant = self.tableViewAddress.contentSize.height
    self.consUIViewAddressHeight.constant = self.tableViewAddress.contentSize.height
        self.tableViewAddress.isScrollEnabled = false
        self.tableViewAddress.frame = CGRect(x: self.tableViewAddress.frame.origin.x, y: self.tableViewAddress.frame.origin.y, width: self.tableViewAddress.frame.size.width, height: self.tableViewAddress.contentSize.height)
        //        self.consTableViewHeight.constant = self.tableViewAddress.contentSize.height
        self.consUIViewAddressHeight.constant = self.tableViewAddress.contentSize.height
        
        let scrollHeight = self.uiViewAddress.frame.size.height + self.uiViewAddress.frame.origin.y  + 20
        
        self.uiScrollView.isScrollEnabled = true
        
        self.uiViewAddress.layoutIfNeeded()
        self.tableViewAddress.layoutIfNeeded()
        self.uiScrollView.contentSize = CGSize(width: self.view.frame.size.width , height: scrollHeight)
        self.uiScrollView.layoutIfNeeded()
        
        

        self.uiMainView.layoutIfNeeded()
        
        
        self.view.layoutIfNeeded()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func navigateToEditprefrence(){
        
        let editPref = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditPrefreencesViewController") as! EditPrefreencesViewController
        editPref.dictMemberInfo = self.dictMemberInfo

        self.navigationController?.pushViewController(editPref, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        //navigation item labelcolor
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "Preferences"
        self.navigationController?.navigationBar.backItem?.title =  CommonString.kNavigationBack
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
    }
    

    
    
    //the method returning size of the list
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.dictMemberInfo.address!.count
    }
    
    
    //the method returning each cell of the list
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCellTableViewCell", for: indexPath) as! EventCellTableViewCell
        
        let addressDict = self.dictMemberInfo.address![indexPath.row]
        cell.lblTitle.text = "Address" + "(" + (addressDict.adddresstype ?? "")  + ")"
        cell.lblDescription.text = addressDict.street1! + " ," + addressDict.street2! + " ," + addressDict.city! + " ," + addressDict.zip!
        // (addressDict.street1 ?? "") + "," + (addressDict.street2 ?? "") +  // + "," + (addressDict.city ?? "")  + "," + (addressDict.zip ?? "")
        
        
        print(addressDict)
        
     
        
        return cell
    }
    
    
    
    //MARK:- Open PickerView
    @IBAction func numberVisiblePressed(_ sender: UIButton) {
        if isVisibileNumber == false {
            isVisibileNumber = true
            self.btnNumberVisible .setImage(img_notvisible, for: .normal)
            self.btnNumberVisibleTitle .setTitle("Not Visible", for: .normal)
            
            
        }
        else{
            isVisibileNumber = false
            self.btnNumberVisible .setImage(img_visible, for: .normal)
            self.btnNumberVisibleTitle .setTitle("Visible", for: .normal)
            
        }
    }
    
    
    
    @IBAction func mobileNumberVisiblePressed(_ sender: UIButton) {
        if isVisibileMobileno == false {
            isVisibileMobileno = true
            self.btnMobileNumberVisible .setImage(img_notvisible, for: .normal)
            self.btnMobileNumberVisibleTitle .setTitle("Not Visible", for: .normal)
            
            
        }
        else{
            isVisibileMobileno = false
            self.btnMobileNumberVisible .setImage(img_visible, for: .normal)
            self.btnMobileNumberVisibleTitle .setTitle("Visible", for: .normal)
            
        }
        
        
    }
    
    
    
    @IBAction func EmailVisiblePressed(_ sender: UIButton) {
        if isVisibileEmail == false {
            isVisibileEmail = true
            self.btnEmailVisible .setImage(img_notvisible, for: .normal)
            self.btnEmailVisibleTitle .setTitle("Not Visible", for: .normal)
        }
        else{
            isVisibileEmail = false
            self.btnEmailVisible .setImage(img_visible, for: .normal)
            self.btnEmailVisibleTitle .setTitle("Visible", for: .normal)
            
            
        }
    }
    
    
    
    
}
