//
//  MinimumViewController.swift
//  CSSI
//
//  Created by Admin on 8/16/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class MinimumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var minimumTableView: UITableView!
    @IBOutlet weak var noRecordsFoundLbl: UILabel!
    
    @IBOutlet weak var btnRules: UIButton!
    @IBOutlet weak var lblUserNameId: UILabel!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var minimumTamplateList: [MinimumTemplate] = []
    var pdfPath = ""
    
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
    
    @IBAction func btnRulesAction(_ sender: Any) {
        let rulesPdfDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
        rulesPdfDetailsVC.pdfUrl = self.pdfPath
        rulesPdfDetailsVC.restarantName = self.appDelegate.masterLabeling.mINIMUMS_RULES_DISPLAYTEXT!

        self.navigationController?.pushViewController(rulesPdfDetailsVC, animated: true)
    }
    
    // MARK: - Functions
    func initialSetup() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        self.navigationItem.rightBarButtonItem = homeBarButton
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = self.appDelegate.masterLabeling.mINIMUMS_TITLE ?? ""
        
        self.lblUserNameId.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)
        self.btnRules.setTitle(self.appDelegate.masterLabeling.mINIMUMS_RULES_DISPLAYTEXT ?? "", for: .normal)
        
        self.getMinimumDetails()
    }
    
    
    // MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.minimumTamplateList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 195.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.minimumTableView.dequeueReusableCell(withIdentifier: "MinimumTableViewCell", for: indexPath) as! MinimumTableViewCell
        cell.assignValues(minimumTamplate: self.minimumTamplateList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transactionHistoryVC = self.storyboard?.instantiateViewController(withIdentifier: "TransactionHistoryViewController") as! TransactionHistoryViewController
        transactionHistoryVC.minimumTamplateID = self.minimumTamplateList[indexPath.row].minimumTemplateID ?? ""
        transactionHistoryVC.parameter = self.minimumTamplateList[indexPath.row].parameter ?? ""
        transactionHistoryVC.templateName = self.minimumTamplateList[indexPath.row].templateName ?? ""
        transactionHistoryVC.typeOfStatement = .minimum
        self.navigationController?.pushViewController(transactionHistoryVC, animated: true)
        self.minimumTableView.reloadData()
    }
    
    
    // MARK: - API Calling
    
    func getMinimumDetails() {
        
        if (Network.reachability?.isReachable) == true{

            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kDeviceType: "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kIsAdmin: UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue)!,
                APIKeys.kRole: "Full Access"
            ]
            
            APIHandler.sharedInstance.getMinimumDetails(paramater: paramaterDict, onSuccess: { minimumDetails in
                self.appDelegate.hideIndicator()
                
                
                if(minimumDetails.responseCode == InternetMessge.kSuccess)
                {
                    self.minimumTamplateList = minimumDetails.minimumTemplateHistory
                    self.pdfPath = minimumDetails.PDFPathWeb
                    if self.minimumTamplateList.count != 0 {
                        self.minimumTableView.reloadData()
                    } else {
                        self.minimumTableView.setEmptyMessage(InternetMessge.kNoData)
                    }
                    
                } else {
                    self.minimumTableView.setEmptyMessage(InternetMessge.kNoData)
                }
                self.appDelegate.hideIndicator()
                
            },onFailure: { error  in
                
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
                self.minimumTableView.setEmptyMessage(InternetMessge.kNoData)
                
            })
            
            
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            //  self.tableViewHeroes.setEmptyMessage(InternetMessge.kInternet_not_available)
            
        }
        
    }

}
