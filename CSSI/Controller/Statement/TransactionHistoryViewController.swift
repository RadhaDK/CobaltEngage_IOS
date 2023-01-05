//
//  TransactionHistoryViewController.swift
//  CSSI
//
//  Created by Admin on 8/17/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class TransactionHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lblMinimumHeader: UILabel!
    @IBOutlet weak var lblReceiptHeader: UILabel!
    @IBOutlet weak var lblLocationHeader: UILabel!
    @IBOutlet weak var lblTotalHeader: UILabel!
    @IBOutlet weak var transactionDetailTableView: UITableView!
    @IBOutlet weak var noRecordsFoundLbl: UILabel!
    @IBOutlet weak var lblDateHeader: UILabel!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var minimumTamplateID = ""
    var parameter = ""
    var templateName = ""
    
    var transactionHistoryList: [TemplateHistory] = []
    var typeOfStatement : statementType?
    var creditBookId : String?
    var crediDetails : [CreditBookHistoryDetail] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initialSetup()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - IBActions
    @objc private func backBtnAction(sender: UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    // MARK: - Functions
    
    func initialSetup() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        self.navigationItem.rightBarButtonItem = homeBarButton
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = self.appDelegate.masterLabeling.mINIMUMS_TRANSACTION_HISTORY_TITLE ?? ""
        
        self.lblReceiptHeader.text = self.appDelegate.masterLabeling.tRANSACTION_HISTORY_RECEIPT ?? ""
        self.lblDateHeader.text = self.appDelegate.masterLabeling.tRANSACTION_HISTORY_DATE ?? ""
        self.lblLocationHeader.text = self.appDelegate.masterLabeling.tRANSACTION_HISTORY_LOCATION ?? ""
        self.lblTotalHeader.text = self.appDelegate.masterLabeling.tRANSACTION_HISTORY_TOTAL ?? ""
        self.lblMinimumHeader.text = templateName
        if typeOfStatement == .minimum{
            self.getTranascationDetails()
        }
        else if typeOfStatement == .credit{
            self.creditBookDetail()
        }
        
       
    }
    

    // MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if typeOfStatement == .minimum{
            return self.transactionHistoryList.count
        }
        else{
            return self.crediDetails.count
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.transactionDetailTableView.dequeueReusableCell(withIdentifier: "TransactionDetailTableViewCell", for: indexPath) as! TransactionDetailTableViewCell
        if typeOfStatement == .minimum{
            cell.lblDate.text = self.transactionHistoryList[indexPath.row].date ?? ""
            cell.lblLocation.text  = self.transactionHistoryList[indexPath.row].location ?? ""
            cell.lblReceiptID.text  = self.transactionHistoryList[indexPath.row].receiptNumber ?? ""
            cell.lblTotal.text  = self.transactionHistoryList[indexPath.row].amount ?? ""
        }
        else{
            
            cell.lblDate.text = self.crediDetails[indexPath.row].Date ?? ""
            cell.lblLocation.text  = self.crediDetails[indexPath.row].Location ?? ""
            cell.lblReceiptID.text  = self.crediDetails[indexPath.row].ReceiptNumber ?? ""
            cell.lblTotal.text  = "\(self.crediDetails[indexPath.row].Amount ?? 0)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transactionDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "TransactionDetailsViewController") as! TransactionDetailsViewController
        if typeOfStatement == .minimum{
            transactionDetailVC.statementID = self.transactionHistoryList[indexPath.row].ID
            transactionDetailVC.receiptno = self.transactionHistoryList[indexPath.row].receiptNumber
            transactionDetailVC.purchaseDate = self.transactionHistoryList[indexPath.row].date
            transactionDetailVC.amount = self.transactionHistoryList[indexPath.row].amount
            transactionDetailVC.isFromMinimums = true
            transactionDetailVC.category = self.transactionHistoryList[indexPath.row].category
        }
        else{
            transactionDetailVC.statementID = self.crediDetails[indexPath.row].CreditBookID
            transactionDetailVC.receiptno = self.crediDetails[indexPath.row].ReceiptNumber
            transactionDetailVC.purchaseDate = self.crediDetails[indexPath.row].Date
            transactionDetailVC.amount = "\(self.crediDetails[indexPath.row].Amount ?? 0)"
            transactionDetailVC.isFromMinimums = true
            transactionDetailVC.category = self.crediDetails[indexPath.row].Category
        }
        self.navigationController?.pushViewController(transactionDetailVC, animated: true)
        self.transactionDetailTableView.reloadData()
    }
    
    
    // MARK: - API Calling
    
    func getTranascationDetails() {
        
        if (Network.reachability?.isReachable) == true{

            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kDeviceType: "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kRole: "Full Access",
                "MinimumTemplateID": self.minimumTamplateID,
                "parameter": self.parameter
            ]
            
            APIHandler.sharedInstance.getMinimumTransactionHistory(paramater: paramaterDict, onSuccess: { TemplateHistoryDetails in
                self.appDelegate.hideIndicator()
                
                if(TemplateHistoryDetails.responseCode == InternetMessge.kSuccess)
                {
                    
                    self.transactionHistoryList = TemplateHistoryDetails.minimumTemplateHistoryDetails!
                    if self.transactionHistoryList.count != 0 {

                        self.transactionDetailTableView.reloadData()
                    } else {
                        self.transactionDetailTableView.setEmptyMessage(InternetMessge.kNoData)
                    }
                } else {
                    self.transactionDetailTableView.setEmptyMessage(InternetMessge.kNoData)
                }
                self.appDelegate.hideIndicator()
                
            },onFailure: { error  in
                
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
                self.transactionDetailTableView.setEmptyMessage(InternetMessge.kNoData)
            })
            
            
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            
        }
        
    }
}


// MARK: - API CALLING
extension TransactionHistoryViewController{
    func creditBookDetail(){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            var paramaterDict:[String: Any] = [:]
            
             paramaterDict = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kCreditBookID: creditBookId ?? "",
                APIKeys.kFilterDate : ""
             ]

//            print(paramaterDict)
            APIHandler.sharedInstance.creditBookDetail(paramater: paramaterDict, onSuccess: { creditDetail in
                self.appDelegate.hideIndicator()
                if(creditDetail.CredtiBookTranHistoryDetails.count == 0)
                {
                    self.transactionDetailTableView.setEmptyMessage(InternetMessge.kNoData)
                } else {
                    self.transactionDetailTableView.restore()
                }
                self.crediDetails = creditDetail.CredtiBookTranHistoryDetails!
                self.transactionDetailTableView.reloadData()
             
                
            },onFailure: { error  in
                print(error)
                self.appDelegate.hideIndicator()
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }else{
            self.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
}
