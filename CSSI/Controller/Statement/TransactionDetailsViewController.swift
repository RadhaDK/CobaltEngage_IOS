

//
//  TransactionDetailsViewController.swift
//  CSSI
//
//  Created by MACMINI13 on 14/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Popover

class TransactionDetailsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var lblNoText: UILabel!
    @IBOutlet weak var lblItemText: UILabel!
    @IBOutlet weak var lblAmountText: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblRegNo: UILabel!
    @IBOutlet weak var lblRegNoValue: UILabel!
    @IBOutlet weak var lblRecNovalue: UILabel!
    @IBOutlet weak var lblRecNo: UILabel!
    @IBOutlet weak var lblEmployee: UILabel!
    @IBOutlet weak var lblEmployeeValue: UILabel!
    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var lblMemeberNameValue: UILabel!
    @IBOutlet weak var lblMemberNo: UILabel!
    @IBOutlet weak var lblMemberNoValue: UILabel!
    @IBOutlet weak var statementDetailTable: UITableView!
    @IBOutlet weak var heighttableView: NSLayoutConstraint!
    @IBOutlet weak var lblTitle: UILabel!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var transactionDetailsDict = StatementDetails()
    var arrItemList = [ListStatementDetails]()
    var receiptno = String()
    var strregno = String()
    var strreceiptno = String()
    var stremployee = String()
    var strmembername = String()
    var strmemberno = String()
    var strno = String()
    
    var category = String()
    var descriptions = String()
    var purchaseDate = String()
    var purchaseTime = String()
    var amount = String()
    var statementID = String()
    
    var stritems = String()
    var stramount = String()
    var stryousaved = String()
    var strtax = String()
    var strtotal = String()
    var strtip = String()
    
    var clubName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  self.extendedLayoutIncludesOpaqueBars = false
        //  self.definesPresentationContext = true
        
        self.commomColorCode()
        self.setLocalizedString()
        self.initController()
        
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
       // navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
        
     //   self.statementDetailTable.separatorColor = UIColor.clear
        self.statementDetailTable.rowHeight = UITableViewAutomaticDimension
        self.statementDetailTable.estimatedRowHeight = 101
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        heighttableView.constant = statementDetailTable.contentSize.height + 120
      //  diningReservationHeight.constant = 1006 + recentNewsTableview.contentSize.height
        
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    func initController()
    {
        if (Network.reachability?.isReachable) == true{
            let dictData:[String: Any] = [
                APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kreceiptNo: self.receiptno,
                APIKeys.kdeviceInfo:[APIHandler.devicedict],
                
                //Additionsl details being passed on 11/03/2020
                
                APIKeys.kStatementCategory : self.category,
                APIKeys.kDescriptions : self.descriptions,
                APIKeys.kPurchaseDate : self.purchaseDate,
                APIKeys.kPurchaseTime : self.purchaseTime,
                APIKeys.kAmount : self.amount,
                APIKeys.kStatementID : self.statementID
                
                ]
            
            // print(dictData)
            
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            
            APIHandler.sharedInstance.getStatementDetails(paramater: dictData, onSuccess: { stmtDetails in
                
                self.appDelegate.hideIndicator()
                if(stmtDetails.responseCode == InternetMessge.kSuccess){
                    
                    if(stmtDetails == nil){
                        
                        self.appDelegate.hideIndicator()
                    }
                    else{
                        self.transactionDetailsDict = stmtDetails
                       self.loadCompnents()
                        self.statementDetailTable.reloadData()
                    }
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((stmtDetails.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: stmtDetails.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    
                }
                
            },onFailure: { error  in
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        //        self.extendedLayoutIncludesOpaqueBars = true
        //        self.definesPresentationContext = true
        
        //  self.extendedLayoutIncludesOpaqueBars = true
    }
    
    
    //Mark- Common Color Code
    func commomColorCode()
    {
        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setLocalizedString()
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        self.extendedLayoutIncludesOpaqueBars = true
        //        self.definesPresentationContext = true
        
    }
    
    
    
    func loadCompnents(){
       
        self.arrItemList = self.transactionDetailsDict.listitem!
        self.lblTitle.text = (self.transactionDetailsDict.clubName ?? "" ) + " " +  (self.transactionDetailsDict.category ?? "")
        self.lblDate.text = self.transactionDetailsDict.purchaseDate ?? ""
        self.lblTime.text = self.transactionDetailsDict.purchaseTime ?? ""
        self.lblRegNo.text = strregno
        
        self.lblRegNoValue.text = self.transactionDetailsDict.registerNo ?? ""
        self.lblRecNo.text = strreceiptno
        self.lblRecNovalue.text = self.transactionDetailsDict.receiptNo ?? ""
        self.lblEmployee.text = stremployee
        self.lblEmployeeValue.text = self.transactionDetailsDict.employeeName ?? ""
        self.lblMemeberNameValue.text = self.transactionDetailsDict.memberName ?? ""
        self.lblMemberName.text = strmembername
        self.lblMemberNo.text = strmemberno
        self.lblMemberNoValue.text = self.transactionDetailsDict.memberId ?? ""
        

    }
    
    
    
    func setLocalizedString(){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backItem?.title = self.appDelegate.masterLabeling.bACK
        self.navigationController?.navigationBar.topItem?.title = self.appDelegate.masterLabeling.bACK
        navigationController!.interactivePopGestureRecognizer!.isEnabled = true
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = self.appDelegate.masterLabeling.tT_TRANSACTION_DETAILS
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        strregno = (self.appDelegate.masterLabeling.rEG_NO)!
        strreceiptno = (self.appDelegate.masterLabeling.rECEIPT_NO)!
        stremployee = (self.appDelegate.masterLabeling.eMPLOYEE)!
        strmembername = (self.appDelegate.masterLabeling.mEMBER_NAME)!
        strmemberno = (self.appDelegate.masterLabeling.mEMBER_NO)!
        lblNoText.text = (self.appDelegate.masterLabeling.nO)!
        lblItemText.text = (self.appDelegate.masterLabeling.iTEMS)!
        lblAmountText.text = (self.appDelegate.masterLabeling.aMOUNT)!
        stryousaved = (self.appDelegate.masterLabeling.yOU_SAVED)!
        strtax = (self.appDelegate.masterLabeling.tAX)!
        strtotal = (self.appDelegate.masterLabeling.tOTAL)!
        strtip = (self.appDelegate.masterLabeling.tIP)!
        
        
    }
    
    
    func hexStringToUIColortransaction (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    //Mark- Tableview Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:StatementDetailCell = self.statementDetailTable.dequeueReusableCell(withIdentifier: "StatementDetailCellID") as! StatementDetailCell
        let itemDict = self.arrItemList[indexPath.row]
        
        cell.lblNo.text = String(format: "%02d", indexPath.row + 1)

       // cell.lblNo.text = "\(indexPath.row + 1)"
        cell.lblQty.text = "\(String(describing: self.appDelegate.masterLabeling.qTY ?? "")) \(itemDict.quntity ?? 0)"
        cell.lblItemName.text = itemDict.name
        cell.lblSKUNo.text = itemDict.sku
//        cell.lblAmount.text =  self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",itemDict.price ?? 0.0)
        
//        if((itemDict.price ?? 0.00) < 0){
//            let temp = -(itemDict.price ?? 0.00)
//            let firstchar = String(format: "%.2f",itemDict.price ?? 0.00).prefix(1)
//            cell.lblAmount.text = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
//        }else{
        
            cell.lblAmount.text = itemDict.price ?? ""
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200
    }
    //44
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = Bundle.main.loadNibNamed("StatementDetailFooter", owner: self, options: nil)?.first as! StatementDetailFooter
        
        let screenSize = UIScreen.main.bounds
        
        //footerView.frame.size.height = 270
        footerView.frame.size.width = screenSize.width
        
        footerView.lblTaxValue.text = self.transactionDetailsDict.Tax ?? ""
        footerView.lblSubTotalValue.text = self.transactionDetailsDict.subTotal ?? ""
        footerView.lblTipValue.text = self.transactionDetailsDict.Tip ?? ""
        footerView.lblTotalValue.text = self.transactionDetailsDict.total ?? ""
        footerView.lblSavedValue.text = self.transactionDetailsDict.SavedAmount ?? ""
        
//        if((self.transactionDetailsDict.Tax ?? 0.00) < 0){
//            let temp = -(self.transactionDetailsDict.Tax ?? 0.00)
//            let firstchar = String(format: "%.2f",self.transactionDetailsDict.Tax ?? 0.00).prefix(1)
//            footerView.lblTaxValue.text = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
//        }else{
//
//            footerView.lblTaxValue.text = String(format: "$%.2f", self.transactionDetailsDict.Tax ?? "")
//        }
        
//        if((self.transactionDetailsDict.subTotal ?? 0.00) < 0){
//            let temp = -(self.transactionDetailsDict.subTotal ?? 0.00)
//            let firstchar = String(format: "%.2f",self.transactionDetailsDict.subTotal ?? 0.00).prefix(1)
//            footerView.lblSubTotalValue.text = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
//        }else{
//
//            footerView.lblSubTotalValue.text = String(format: "$%.2f", self.transactionDetailsDict.subTotal ?? "")
//        }
        
//        if((self.transactionDetailsDict.Tip ?? 0.00) < 0){
//            let temp = -(self.transactionDetailsDict.Tip ?? 0.00)
//            let firstchar = String(format: "%.2f",self.transactionDetailsDict.Tip ?? 0.00).prefix(1)
//            footerView.lblTipValue.text = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
//        }else{
//
//            footerView.lblTipValue.text = String(format: "$%.2f", self.transactionDetailsDict.Tip ?? "")
//        }
//
//        if((self.transactionDetailsDict.total ?? 0.00) < 0){
//            let temp = -(self.transactionDetailsDict.total ?? 0.00)
//            let firstchar = String(format: "%.2f",self.transactionDetailsDict.total ?? 0.00).prefix(1)
//            footerView.lblTotalValue.text = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
//        }else{
//
//            footerView.lblTotalValue.text = String(format: "$%.2f", self.transactionDetailsDict.total ?? "")
//        }
        
//        if((self.transactionDetailsDict.SavedAmount ?? 0.00) < 0){
//            let temp = -(self.transactionDetailsDict.SavedAmount ?? 0.00)
//            let firstchar = String(format: "%.2f",self.transactionDetailsDict.SavedAmount ?? 0.00).prefix(1)
//            footerView.lblSavedValue.text = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
//        }else{
//
//            footerView.lblSavedValue.text = String(format: "$%.2f", self.transactionDetailsDict.SavedAmount ?? "")
//        }
        
        footerView.lblTax.text = strtax
        footerView.lblSubTotal.text = self.appDelegate.masterLabeling.sUB_TOTAL
        footerView.lblTip.text = strtip
        footerView.lblTax.text = strtax
        footerView.lblTotal.text = strtotal
        footerView.lblYouSaved.text = stryousaved
        return footerView
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

