//
//  CreditBookViewController.swift
//  CSSI
//
//  Created by Vishal Pandey on 06/12/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class CreditBookViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var CreditBookDetailsTbl: UITableView!
    @IBOutlet weak var lblCreditBookName: UILabel!
    @IBOutlet weak var lblItemType: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblMemberNameID: UILabel!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrCreditList = [CreditBookTemplate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        // Do any additional setup after loading the view.
        self.lblMemberNameID  .text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        self.navigationItem.rightBarButtonItem = homeBarButton
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "Credit Book"
        creditBookList()
    }
    // MARK: - IBActions
    @objc private func backBtnAction(sender: UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }

}

// MARK: - TableView Methods
extension CreditBookViewController : UITableViewDelegate, UITableViewDataSource{
    //MARK:- Table delegate & datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCreditList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CreditBookDetailsTbl.dequeueReusableCell(withIdentifier: "CreditBookDetailCell", for: indexPath) as! CreditBookDetailCell
        let dict = arrCreditList[indexPath.row]
        cell.lblCreditBookName.text = dict.CreditBookName
        cell.lblCreditAmt.text = "$\(dict.CreditAmount ?? 0)"
        cell.lblItemType.text = dict.ItemType
        cell.lblAmtSpent.text = "$\(dict.SpentAmount ?? 0)"
        cell.lblLocation.text = dict.Location
        cell.lblCreditBalance.text = "$\(dict.Balance ?? 0)"
        return cell
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transactionHistoryVC = self.storyboard?.instantiateViewController(withIdentifier: "TransactionHistoryViewController") as! TransactionHistoryViewController
        let dict = arrCreditList[indexPath.row]
        transactionHistoryVC.creditBookId = dict.CreditBookID
        transactionHistoryVC.typeOfStatement = .credit
        transactionHistoryVC.templateName = dict.CreditBookName ?? ""
        transactionHistoryVC.minimumTamplateID = dict.CreditBookID ?? ""
        self.navigationController?.pushViewController(transactionHistoryVC, animated: true)
    }
}

// MARK: - API CALLING
extension CreditBookViewController{
    func creditBookList(){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            var paramaterDict:[String: Any] = [:]
            
             paramaterDict = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!
             ]

//            print(paramaterDict)
            APIHandler.sharedInstance.creditBookListingApi(paramater: paramaterDict, onSuccess: { creditListing in
                self.appDelegate.hideIndicator()
                if(creditListing.CreditBookList.count == 0)
                {
                    self.CreditBookDetailsTbl.setEmptyMessage(InternetMessge.kNoData)
                }
                self.arrCreditList = creditListing.CreditBookList!
                self.CreditBookDetailsTbl.reloadData()
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
