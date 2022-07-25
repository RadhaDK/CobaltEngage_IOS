//
//  ImpotantContactsVC.swift
//  CSSI
//
//  Created by apple on 11/16/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ImpotantContactsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var refreshControl = UIRefreshControl()
    var category: NSString!
    var isFrom : NSString!
    var importantContactsDisplayName: String?

    @IBOutlet weak var ImpPopUp: NSLayoutConstraint!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblImportantContacts: UILabel!
    @IBOutlet weak var tblImpContacts: UITableView!
    
    var arrImpNo = [ImportantNumbers]()
    var arrList = [DetailDuplicate]()
    
    //Added by kiran v2.9 -- Cobalt Pha0010644 -- To show Hard & Soft message details there is an over lap with member validation and aelrt prompt. added called back to solbe the overlap.
    //Cobalt Pha0010644 -- Start
    var closeClicked : (()->())?
    //Cobalt Pha0010644 -- End
    
//    var arr
    
    //Added by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
    //ENGAGE0012667 -- Start
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    //ENGAGE0012667 -- End

    override func viewDidLoad() {
        super.viewDidLoad()

        lblImportantContacts.text = importantContactsDisplayName as String?
        self.refreshControls()
        if isFrom == "CourtTimes" {
            category = "Tennis"
        }
        else if isFrom == "DiningReservation" {
            category = "Dining"

        }
        else if isFrom == "FitnessSpa"
        {
            category = "FitnessSpa"
        }
        else{
            category = "Golf"
            
        }
        
        if isFrom == "Reservations"{
            if self.arrList.count > 8{
                self.ImpPopUp.constant = UIScreen.main.bounds.size.height - 100
            }
            else if self.arrList.count == 0{
                self.ImpPopUp.constant = 150
            }
            else{
                self.ImpPopUp.constant = self.lblImportantContacts.frame.height + 60 + CGFloat(self.arrList.count * 60)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    //MARK: Lifecycle method
    override func viewWillAppear(_ animated: Bool) {
//        self.getAuthToken()
        
        getImportantNumbers(strSearch: "")
        
        
        self.navigationController?.navigationBar.isHidden = false
        //navigation item labelcolor
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.backItem?.title = self.appDelegate.masterLabeling.bACK
        self.ImpPopUp.constant = 0
    }
    
    //Mark- Token api
//    func getAuthToken(){
//
//        if (Network.reachability?.isReachable) == true{
//            APIHandler.sharedInstance.getTokenApi(paramater: nil , onSuccess: { tokenList in
//                let access_token = tokenList.access_token
//                let expires_in = tokenList.expires_in
//                let token_type = tokenList.token_type
//                let jointToken = (token_type ?? "") + " " + (access_token ?? "")
//
//                print(jointToken)
//
//                UserDefaults.standard.set(access_token, forKey: UserDefaultsKeys.access_token.rawValue)
//                UserDefaults.standard.set(expires_in, forKey: UserDefaultsKeys.expires_in.rawValue)
//                UserDefaults.standard.set(token_type, forKey: UserDefaultsKeys.token_type.rawValue)
//                UserDefaults.standard.set(jointToken, forKey: UserDefaultsKeys.apiauthtoken.rawValue)
//                UserDefaults.standard.synchronize()
//                print(UserDefaults.standard.string(forKey: UserDefaultsKeys.apiauthtoken.rawValue) ?? "")
//
//
//
//            },onFailure: { error  in
//
//                print(error)
//                SharedUtlity.sharedHelper().showToast(on:
//                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
//            })
//        }
//    }
    //MARK:- Call button tapped
    @objc func btnCallButtonTapped(_ sender: UIButton) {
        var dictData =  ImportantNumbers()
        dictData = self.arrImpNo[sender.tag]
        let strPhoneNumber = dictData.phoneNumber ?? ""
        if let phoneCallURL:URL = URL(string: "tel:\(strPhoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)){
                //   application.openURL(phoneCallURL)
                UIApplication.shared.open(URL(string: "\(phoneCallURL)")!)
                
            }
        }
        
    }
    //Mark- Scroll to First Row
    func scrollToFirstRow() {
        if(self.arrImpNo.count > 0){
            let indexPath = IndexPath(row: 0, section: 0)
            self.tblImpContacts.scrollToRow(at: indexPath, at: .top, animated: true)
            
            
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFrom == "Reservations"{
            return arrList.count
        }else{
        return arrImpNo.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ImpContactsCustomCell = tableView.dequeueReusableCell(withIdentifier: "ImpContactsID") as! ImpContactsCustomCell
        
        if isFrom == "Reservations"{
            
            cell.lblNumber.text = arrList[indexPath.row].memberID ?? ""
            
            cell.lblName.text =  arrList[indexPath.row].memberName ?? ""
            cell.btnPhone.isHidden = true
            
        }else{
        var dictData =  ImportantNumbers()
        dictData = self.arrImpNo[indexPath.row]
        
        cell.lblNumber.text = dictData.phoneNumber
        
        cell.lblName.text =  dictData.departmentName
        
        cell.btnPhone.tag = indexPath.row
        cell.btnPhone.addTarget(self, action: #selector(btnCallButtonTapped(_:)), for: .touchUpInside)

        }
        
        return cell
    }
    //Mark- Refresh logic for tableview
    @objc func refresh(sender:AnyObject) {
        getImportantNumbers(strSearch: "")
        self.refreshControl.endRefreshing()
        
    }
    
    //Mark- Refresh logic for tableview
    func refreshControls()
    {
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        self.tblImpContacts.addSubview(refreshControl) // not required when using UITableViewController
    }
    //MARK: Get Important numbers from server
    func getImportantNumbers(strSearch :String)
    {
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)  ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)  ?? "",
                APIKeys.ksearchby: strSearch ,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kCategory: category
            ]
            
            print(paramaterDict)
            APIHandler.sharedInstance.getImportantNumbers(paramater: paramaterDict , onSuccess: { impnoList in
                self.appDelegate.hideIndicator()
                if(impnoList.responseCode == InternetMessge.kSuccess)
                {
                    
                    if((impnoList.importantNo == nil) && (impnoList.clubnumber == nil ) ){
                        
                        self.arrImpNo.removeAll()
                        self.tblImpContacts.setEmptyMessage(InternetMessge.kNoData)
                        self.tblImpContacts.reloadData()
                        
                        self.appDelegate.hideIndicator()
                    }
                    else{
                        
                        if((impnoList.importantNo?.count == 0) && (impnoList.clubnumber?.count == 0))
                        {
                            self.arrImpNo.removeAll()
                            self.tblImpContacts.setEmptyMessage(InternetMessge.kNoData)
                            self.tblImpContacts.reloadData()
                            
                            self.appDelegate.hideIndicator()
                        }else{
                            
                            self.arrImpNo.removeAll()
                            if(impnoList.clubnumber?.count == nil)
                            {
                                self.tblImpContacts.reloadData()
                                
                                
                            }else{
                                for i in 0..<(impnoList.clubnumber?.count)! {
                                    self.tblImpContacts.restore()
                                    //  self.setCardView(view:  self.tblImpContacts)
                                    
                                    var dictImpNo = ClubNumbers()
                                    dictImpNo = impnoList.clubnumber![i]
                                    let JSONString = dictImpNo.toJSONString(prettyPrint: true)
                                    let impNo = ImportantNumbers(JSONString: JSONString!)
                                    self.arrImpNo.append(impNo!)
                                }
                            }
                            if(impnoList.importantNo?.count == nil)
                            {
                                self.tblImpContacts.reloadData()
                            }else{
                                for i in 0..<(impnoList.importantNo?.count)! {
                                    self.tblImpContacts.restore()
                                    
                                    var dictImpNo = ImportantNumbers()
                                    dictImpNo = impnoList.importantNo![i]
                                    self.arrImpNo.append(dictImpNo)
                                }
                            }
                        }
                        // print(self.arrImpNo.count)
                        self.tblImpContacts.reloadData()
                    }
                   
                    self.view.setNeedsLayout()
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((impnoList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: impnoList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.tblImpContacts.setEmptyMessage(impnoList.responseMessage ?? "")
                    
                }
                self.appDelegate.hideIndicator()
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }else{
            // self.tblImpContacts.setEmptyMessage(InternetMessge.kInternet_not_available)
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
    
    
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        
        if self.isFrom == "Reservations"{
            if self.arrList.count > 8{
                self.ImpPopUp.constant = UIScreen.main.bounds.size.height - 100
            }
            else if self.arrList.count == 0{
                self.ImpPopUp.constant = 150
            }
            else{
                self.ImpPopUp.constant = CGFloat(self.arrList.count * 60) + 70 + self.lblImportantContacts.frame.height
            }
            
        }else{
            if self.arrImpNo.count > 8{
                self.ImpPopUp.constant = UIScreen.main.bounds.size.height - 100
            }
            else if self.arrImpNo.count == 0{
                self.ImpPopUp.constant = 150
            }
            else{
                self.ImpPopUp.constant = CGFloat((self.arrImpNo.count * 60) + 90)
            }
        }
    }
    @IBAction func closeClicked(_ sender: Any)
    {
        //Added by kiran v2.9 -- Cobalt Pha0010644 -- To show Hard & Soft message details there is an over lap with member validation and aelrt prompt. added called back to solbe the overlap.
        //Cobalt Pha0010644 -- Start
        self.closeClicked?()
        //Cobalt Pha0010644 -- End
        dismiss(animated: true, completion: nil)
    }
    
}
