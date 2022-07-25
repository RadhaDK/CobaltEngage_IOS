
//
//  RequestCardAccountSummaryViewController.swift
//  CSSI
//
//  Created by MACMINI13 on 30/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class RequestCardAccountSummaryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var uiViewLine: UIView!
    @IBOutlet weak var tblViewAccount: UITableView!
    
    @IBOutlet weak var lblsubtotal: UILabel!
    var arrguestdetails = GuestDetailsModify()
    
    @IBOutlet weak var lbltax: UILabel!
    var guestname = String()
    
    
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var lblfooterview: UILabel!
    
    @IBOutlet weak var lblSubTotal: UILabel!
    
    @IBOutlet weak var lblTax: UILabel!
    
    @IBOutlet weak var lblTotal: UILabel!
    
    @IBOutlet weak var lblSubTotalValue: UILabel!
    
    @IBOutlet weak var lblTaxValue: UILabel!
    
    @IBOutlet weak var lblTotalValue: UILabel!
    
    @IBOutlet weak var lblChagestmt: UILabel!
    
    @IBOutlet weak var lblThanksstmt: UILabel!
    
    
//    @IBOutlet weak var btnIgnore: UIButton!
    
//    @IBOutlet weak var btnConfirm: UIButton!
    
    var rightSearchbarButton = UIBarButtonItem()
    
    
    
    
    func initViewFont()
    {
        
        self.lblSubTotal.font = SFont.SourceSansPro_Regular14
        self.lblTax.font = SFont.SourceSansPro_Regular14
        self.lblTotal.font = SFont.SourceSansPro_Regular14
        
        self.lblSubTotalValue.font = SFont.SourceSansPro_Semibold16
        self.lblTaxValue.font = SFont.SourceSansPro_Semibold16
        self.lblTotalValue.font = SFont.SourceSansPro_Semibold16
        
        self.lblChagestmt.font = SFont.SourceSansPro_Regular14
        self.lblChagestmt.isHidden = true
        
        self.footerView.backgroundColor = APPColor.viewBackgroundColor.viewbg
        self.lblfooterview.font = SFont.SourceSansPro_Regular14
        
        self.lblfooterview.text = UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)! + " | " + Symbol.khash + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!
        
        
        
        
    }
    
    //the method returning each cell of the list
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCardAccountTableViewCell", for: indexPath) as! RequestCardAccountTableViewCell
        cell.lblGuestName.font = SFont.SourceSansPro_Semibold16
        cell.lblTypeCharge.font = SFont.SourceSansPro_Regular14
        cell.lblAmount.font = SFont.SourceSansPro_Semibold16
        
        cell.lblGuestName.textColor = APPColor.textColor.text
        cell.lblTypeCharge.textColor = APPColor.textheaderColor.header
        cell.lblAmount.textColor = APPColor.textColor.text
        
        
        
        let eventobj: GuestCardModifyList
        eventobj = arrguestdetails.guests![indexPath.row]
        
        
        
        cell.lblGuestName.text =  eventobj.firstName! + " " + eventobj.lastName!
        if(eventobj.price == nil)
        {
            
        }else{
            var resultStringPrice = self.appDelegate.masterLabeling.cURRENCY! + String(format: "%.2f",eventobj.price ?? 0.00)
            if((eventobj.price ?? 0.00) < 0){
                let temp = -(eventobj.price ?? 0.00)
                let firstchar = String(format: "%.2f",eventobj.price ?? 0.00).prefix(1)
                resultStringPrice = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
            }
            
            cell.lblAmount.text = resultStringPrice
            
        }
        cell.lblTypeCharge.text = eventobj.chargeType!
        
        
        
        
        
        return cell
    }
    
    //the method returning size of the list
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (self.arrguestdetails.guests?.count)!
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.backItem?.title = self.appDelegate.masterLabeling.bACK
        self.navigationController?.navigationBar.topItem?.title = self.appDelegate.masterLabeling.bACK
        
        self.navigationController?.isNavigationBarHidden = false;
        self.navigationItem.title = self.appDelegate.masterLabeling.tT_GUEST_CARD
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : APPColor.navigationColor.titleTextAttributesColor]
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .white
        navigationController!.interactivePopGestureRecognizer!.isEnabled = true
        
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        lblsubtotal.text = self.appDelegate.masterLabeling.sUB_TOTAL
        lblTax.text = self.appDelegate.masterLabeling.tAX_7
        lblTotal.text = self.appDelegate.masterLabeling.tOTAL
        self.uiViewLine.backgroundColor = APPColor.celldividercolor.divider
        
    }
    
    func customButton()
    {
        
//        self.btnConfirm.setTitleColor(APPColor.viewBgColor.viewbg, for: .normal)
//        self.btnConfirm.backgroundColor = APPColor.tintColor.tint
//        self.btnConfirm.layer.borderColor = APPColor.tintColor.tint.cgColor
//        self.btnConfirm.layer.borderWidth = 2
        
        
//        self.btnIgnore.setTitleColor(APPColor.tintColor.tint, for: .normal)
//        self.btnIgnore.backgroundColor = APPColor.viewBgColor.viewbg
//        self.btnIgnore.layer.borderColor = APPColor.tintColor.tint.cgColor
//        self.btnIgnore.layer.borderWidth = 2
//
//        self.btnConfirm.isHidden = true
//        self.btnIgnore.isHidden = true
//
//
//        self.btnConfirm.layer.cornerRadius = 20
//        self.btnConfirm.layer.masksToBounds = true
//
//        self.btnIgnore.layer.cornerRadius = 20
//        self.btnIgnore.layer.masksToBounds = true
        
    }
    
    //Mark- Common Color Code
    func commomColorCode()
    {
        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg
        //        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshGuestDeatils"), object: nil)
        
        self.lblSubTotal.textColor = APPColor.textColor.text
        self.lblTotalValue.textColor = APPColor.textColor.text
        self.lblSubTotalValue.textColor = APPColor.textColor.text
        self.lblTotalValue.textColor = APPColor.textColor.text
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commomColorCode()
        initViewFont()
        customButton()
        loadData()
        
        
    }
    @objc func searchBarButtonPressed() {
        
    }
    
    func loadData()
    {
        if(arrguestdetails.tax == nil)
        {
            
        }else{
            if let tax = arrguestdetails.tax {
                var resultStringTax = self.appDelegate.masterLabeling.cURRENCY! +   String(format: "%.2f", tax)
                if((tax ) < 0){
                    let temp = -(tax )
                    let firstchar = String(format: "%.2f",tax ).prefix(1)
                    resultStringTax = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
                }
                
                lblTaxValue.text = resultStringTax //self.appDelegate.masterLabeling.cURRENCY! +   String(format: "%.2f",tax)
                
            }
        }
        
        if(arrguestdetails.total == nil)
        {
            
        }else
        {
            
            if let total = arrguestdetails.total {
                
                var resultStringTotal = self.appDelegate.masterLabeling.cURRENCY! +   String(format: "%.2f", total)
                if((total ) < 0){
                    let temp = -(total )
                    let firstchar = String(format: "%.2f",total ).prefix(1)
                    resultStringTotal = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
                }
                lblTotalValue.text = resultStringTotal //self.appDelegate.masterLabeling.cURRENCY! +   String(format: "%.2f",total)
                // print(String(totalvalue))
            }
        }
        
        
        if(arrguestdetails.subTotal == nil)
        {
            
        }else{
            
            
            
            if let subtotal = arrguestdetails.subTotal {

                var resultStringSubTotal = self.appDelegate.masterLabeling.cURRENCY!  +   String(format: "%.2f",subtotal)
                if((subtotal ) < 0){
                    let temp = -(subtotal )
                    let firstchar = String(format: "%.2f",subtotal ).prefix(1)
                    resultStringSubTotal = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
                }
                
                lblSubTotalValue.text = resultStringSubTotal
                // print(String(subtotalValue))
                
            }
            
        }
        
        
        if let chargestmt = arrguestdetails.confirmMessage {
            let chargestmtvalue = String(chargestmt)
            lblThanksstmt.text = String(chargestmtvalue)
        }
        
        
        self.appDelegate.isMoveToParentViewController = true
        
        self.tblViewAccount.separatorInset = .zero
        self.tblViewAccount.layoutMargins = .zero
        self.tblViewAccount.rowHeight = 68
        self.tblViewAccount.reloadData()
        
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.navigationBar.isExclusiveTouch = false
        self.navigationController?.navigationBar.isUserInteractionEnabled = false;
        self.view.window?.isUserInteractionEnabled = false;
        
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
