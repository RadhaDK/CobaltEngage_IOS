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
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var minimumTamplateID = ""
    var parameter = ""
    var templateName = ""
    
    var transactionHistoryList: [TemplateHistory] = []
    
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
        
        self.lblReceiptHeader.text = "\(self.appDelegate.masterLabeling.tRANSACTION_HISTORY_RECEIPT ?? "")\n\(self.appDelegate.masterLabeling.tRANSACTION_HISTORY_DATE ?? "")"
        self.lblLocationHeader.text = self.appDelegate.masterLabeling.tRANSACTION_HISTORY_LOCATION ?? ""
        self.lblTotalHeader.text = self.appDelegate.masterLabeling.tRANSACTION_HISTORY_TOTAL ?? ""
        self.lblMinimumHeader.text = templateName
        
        self.getTranascationDetails()
    }
    

    // MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.transactionHistoryList.count
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.transactionDetailTableView.dequeueReusableCell(withIdentifier: "TransactionDetailTableViewCell", for: indexPath) as! TransactionDetailTableViewCell
        
        cell.lblDate.text = self.transactionHistoryList[indexPath.row].date ?? ""
        cell.lblLocation.text  = self.transactionHistoryList[indexPath.row].location ?? ""
        cell.lblReceiptID.text  = self.transactionHistoryList[indexPath.row].receiptNumber ?? ""
        cell.lblTotal.text  = self.transactionHistoryList[indexPath.row].amount ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transactionDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "TransactionDetailsViewController") as! TransactionDetailsViewController
        transactionDetailVC.statementID = self.transactionHistoryList[indexPath.row].ID
        transactionDetailVC.receiptno = self.transactionHistoryList[indexPath.row].receiptNumber ?? ""
        transactionDetailVC.purchaseDate = self.transactionHistoryList[indexPath.row].date ?? ""
        transactionDetailVC.amount = self.transactionHistoryList[indexPath.row].amount ?? ""
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
//                        self.noRecordsFoundLbl.isHidden = true
//                        self.transactionDetailTableView.isHidden = false
                        self.transactionDetailTableView.reloadData()
                    } else {
//                        self.noRecordsFoundLbl.isHidden = false
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
            //  self.tableViewHeroes.setEmptyMessage(InternetMessge.kInternet_not_available)
            
        }
        
    }
}
