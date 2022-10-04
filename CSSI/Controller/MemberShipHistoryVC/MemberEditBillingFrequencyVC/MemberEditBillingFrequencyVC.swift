//
//  MemberEditBillingFrequencyVC.swift
//  CSSI
//
//  Created by Vishal Pandey on 07/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
enum requestActionBilling{
    case save,cancel
}

class MemberEditBillingFrequencyVC: UIViewController {
    
    @IBOutlet weak var billingFrequencyTbl: UITableView!
    @IBOutlet weak var savebtnbgView: UIView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var cancelbtnbgView: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblSave: UILabel!
    @IBOutlet weak var lblCancel: UILabel!
    @IBOutlet weak var CancelPendingRequestbgView: UIView!
    @IBOutlet weak var CancelPendingRequestbgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnCancelPendingRequest: UIButton!
    @IBOutlet weak var lblCancelPendingRequest: UILabel!
    @IBOutlet weak var btnCancelPendingRequestTopConstraint: NSLayoutConstraint!

    
    var arrBillingType = [MembershipTypeData]()
    fileprivate var durationPicker : UIPickerView? = nil;
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var selectedBillingFrequency : String?
    var currentFrequency : String?
    var AllowToCancePendingRequest : Int?
    var expandedIndexSet : IndexSet = []
    var selectedMemberShip : String?
    var selectedIndexExpande : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        btnSave.setTitle("", for: .normal)
        btnCancel.setTitle("", for: .normal)
        btnCancelPendingRequest.setTitle("", for: .normal)
        self.navigationItem.title = self.appDelegate.masterLabeling.DUES_RENEWAL_UPDATE_BILLING_FREQUENCY_TITLE
        lblSave.text = self.appDelegate.masterLabeling.Save
        lblCancel.text = self.appDelegate.masterLabeling.cANCEL
        savebtnbgView.layer.borderColor = UIColor(red: 42/255, green: 78/255, blue: 127/255, alpha: 1).cgColor
        savebtnbgView.layer.borderWidth = 1.5
        savebtnbgView.layer.cornerRadius = savebtnbgView.frame.height/2
        cancelbtnbgView.layer.borderColor = UIColor(red: 42/255, green: 78/255, blue: 127/255, alpha: 1).cgColor
        cancelbtnbgView.layer.borderWidth = 1.5
        cancelbtnbgView.layer.cornerRadius = 20
        CancelPendingRequestbgView.layer.borderColor = UIColor(red: 42/255, green: 78/255, blue: 127/255, alpha: 1).cgColor
        CancelPendingRequestbgView.layer.borderWidth = 1.5
        CancelPendingRequestbgView.layer.cornerRadius = CancelPendingRequestbgView.frame.height/2
        // Do any additional setup after loading the view.
        registerNibs()
        if AllowToCancePendingRequest == 1{
            CancelPendingRequestbgView.isHidden = false
            CancelPendingRequestbgViewHeight.constant = 40
            btnCancelPendingRequestTopConstraint.constant = 25
        }else{
            CancelPendingRequestbgView.isHidden = true
            CancelPendingRequestbgViewHeight.constant = 0
            btnCancelPendingRequestTopConstraint.constant = 0
        }
    }
    func registerNibs(){
        let menuNib = UINib(nibName: "MemberBillingFrequencyCell" , bundle: nil)
        self.billingFrequencyTbl.register(menuNib, forCellReuseIdentifier: "MemberBillingFrequencyCell")
        self.billingFrequencyTbl.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        billingTypeList()
    }
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - IBActions
    @IBAction func saveBtnTapped(sender:UIButton){
        
        if selectedBillingFrequency != nil && selectedBillingFrequency != ""{
            SavebillingTypeList(typeFromBillingOrMember: "save")
        }
        else{
            SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.PLEASE_SELECT_TYPE_MESSAGE, withDuration: Duration.kMediumDuration)
        }
    }
    
    @IBAction func cancelBtnTapped(sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelPendingRequestBtnTapped(_ sender: UIButton) {
       
        SavebillingTypeList(typeFromBillingOrMember: "cancel")
        
    }
}

// MARK: - API Calling
extension MemberEditBillingFrequencyVC{
    //MARK:- Membershiptype Api
    func billingTypeList(){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kIsAdmin: "0",
                APIKeys.kUserID: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kusername: UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                APIKeys.kRole: "Full Access",
                APIKeys.kCategory: "BillingFrequncy"
            ]
            APIHandler.sharedInstance.getMembershipListing(paramater: paramaterDict, onSuccess: { BillingList in
                self.appDelegate.hideIndicator()
                
               
                if(BillingList.BillingFrequncy == nil){
                    self.appDelegate.hideIndicator()
                    
                }
                else{
                    self.arrBillingType = BillingList.BillingFrequncy!
                    
                }
                self.billingFrequencyTbl.reloadData()
            },onFailure: { error  in
                print(error)
                self.appDelegate.hideIndicator()
                SharedUtlity.sharedHelper().showToast(on:
                                                        self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }else{
            //    self.tableView.setEmptyMessage(InternetMessge.kInternet_not_available)
            
            SharedUtlity.sharedHelper().showToast(on:
                                                    self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
    
    func SavebillingTypeList(typeFromBillingOrMember:String){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            var paramaterDict:[String: Any]?
            paramaterDict = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kIsAdmin: "0",
                APIKeys.kUserID: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kusername: UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                APIKeys.kRole: "Full Access",
                APIKeys.kCategory: "BillingFrequncy"
                
            ] as [String : Any]
            if typeFromBillingOrMember == "save"{
                paramaterDict?["NewBillingFrequency"] = selectedBillingFrequency ?? ""
            }
            
            APIHandler.sharedInstance.saveMembershipListing(paramater: paramaterDict, onSuccess: { membershipSavedData in
                self.appDelegate.hideIndicator()
                if let thankyouMembershipViewController = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ThankYouMemberShipVC") as? ThankYouMemberShipVC {

                if membershipSavedData.IsBFAutoApproved == 0{
                        if typeFromBillingOrMember == "cancel"{
                            thankyouMembershipViewController.thankYouDesc = self.appDelegate.masterLabeling.DUES_RENEWAL_BILLING_FREQUENCY_CANCELLED_MESSAGE
                        }
                        else if typeFromBillingOrMember == "save"{
                            thankyouMembershipViewController.thankYouDesc = self.appDelegate.masterLabeling.DUES_RENEWAL_BILLING_FREQUENCY_UPDATE_REQUEST_MESSAGE
                        }
                    }
                
                else{
                        thankyouMembershipViewController.thankYouDesc = self.appDelegate.masterLabeling.AUTO_APPROVED_MESSAGE
                           // thankyouMembershipViewController.modalPresentationStyle = .fullScreen
                        
                    }
                    self.present(thankyouMembershipViewController, animated: true, completion: nil)

                }
                
            },onFailure: { error  in
                print(error)
                self.appDelegate.hideIndicator()
                SharedUtlity.sharedHelper().showToast(on:
                                                        self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }else{
            SharedUtlity.sharedHelper().showToast(on:
                                                    self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
}


// MARK: - TableView Methods
extension MemberEditBillingFrequencyVC : UITableViewDelegate, UITableViewDataSource{
    //MARK:- Table delegate & datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBillingType.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = billingFrequencyTbl.dequeueReusableCell(withIdentifier: "MemberBillingFrequencyCell", for: indexPath) as! MemberBillingFrequencyCell
        if arrBillingType.count != 0{
            let dict = arrBillingType[indexPath.row]
            cell.txtTypeBilling.text = dict.Text
            cell.billingAmountView.layer.borderColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1).cgColor
            cell.billingAmountView.layer.borderWidth = 1
        if selectedIndexExpande == indexPath.row{
            cell.billingAmountView.layer.borderColor = UIColor(red: 23/255, green: 70/255, blue: 76/255, alpha: 1).cgColor
        }
        else{
            cell.billingAmountView.layer.borderColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1).cgColor
        }
        }
        if expandedIndexSet.contains(indexPath.row) {
            cell.billingAmountView.layer.borderColor = UIColor(red: 23/255, green: 70/255, blue: 76/255, alpha: 1).cgColor
        }
        else{
            cell.billingAmountView.layer.borderColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1).cgColor
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let memberobj = arrBillingType[indexPath.row]
        if(expandedIndexSet.contains(indexPath.row)){
            expandedIndexSet.remove(indexPath.row)
            selectedBillingFrequency = ""
        } else {
            expandedIndexSet = []
            expandedIndexSet.insert(indexPath.row)
            selectedBillingFrequency = memberobj.Value
        }
        billingFrequencyTbl.reloadData()
    }
}
