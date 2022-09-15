//
//  MemberEditBillingFrequencyVC.swift
//  CSSI
//
//  Created by Vishal Pandey on 07/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit


class MemberEditBillingFrequencyVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var billingAmountView: UIView!
    @IBOutlet weak var billingAmountLbl: UILabel!
    @IBOutlet weak var savebtnbgView: UIView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var cancelbtnbgView: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnPicker: UIButton!
    @IBOutlet weak var lblSave: UILabel!
    @IBOutlet weak var lblCancel: UILabel!
    @IBOutlet weak var txtTypeBilling: UITextField!

    
    var arrBillingType = [MembershipTypeData]()
    fileprivate var durationPicker : UIPickerView? = nil;

    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var selectedBillingFrequency : String?
    var currentFrequency : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSave.setTitle("", for: .normal)
        btnCancel.setTitle("", for: .normal)

        self.navigationItem.title = self.appDelegate.masterLabeling.DUES_RENEWAL_UPDATE_BILLING_FREQUENCY_TITLE
        lblSave.text = self.appDelegate.masterLabeling.Save
        lblCancel.text = self.appDelegate.masterLabeling.cANCEL

        billingAmountView.layer.borderColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1).cgColor
        billingAmountView.layer.borderWidth = 1
        
        savebtnbgView.layer.borderColor = UIColor(red: 42/255, green: 78/255, blue: 127/255, alpha: 1).cgColor
        savebtnbgView.layer.borderWidth = 1.5
        savebtnbgView.layer.cornerRadius = 23
        
        cancelbtnbgView.layer.borderColor = UIColor(red: 42/255, green: 78/255, blue: 127/255, alpha: 1).cgColor
        cancelbtnbgView.layer.borderWidth = 1.5
        cancelbtnbgView.layer.cornerRadius = 20
        btnPicker.setTitle("", for: .normal)
        txtTypeBilling.delegate = self
        durationPicker = UIPickerView()
        durationPicker?.delegate = self
        durationPicker?.dataSource = self
        txtTypeBilling.inputView = durationPicker
        txtTypeBilling.text = currentFrequency
        // Do any additional setup after loading the view.
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
    
    @IBAction func saveBtnTapped(sender:UIButton){
        if selectedBillingFrequency != nil{
            SavebillingTypeList()
        }
        else{
            SharedUtlity.sharedHelper()?.showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.PLEASE_SELECT_TYPE_MESSAGE, withDuration: Duration.kMediumDuration)
        }
    }
    
    @IBAction func cancelBtnTapped(sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnChoosBilling(_ sender: UIButton) {
        
    }
    @IBAction func PickerBtnTapped(sender:UIButton){
    }
    
   
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtTypeBilling{
            if arrBillingType.count != 0{
            self.txtTypeBilling.text = arrBillingType[0].Text
            selectedBillingFrequency = arrBillingType[0].Text
            self.durationPicker?.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(durationPicker!, didSelectRow: 0, inComponent: 0)
        }
        }}
    

}


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
    
    func SavebillingTypeList(){
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
                APIKeys.kCategory: "BillingFrequncy",
                APIKeys.kBillingFrequency: selectedBillingFrequency ?? ""
                
            ] as [String : Any]

            APIHandler.sharedInstance.saveMembershipListing(paramater: paramaterDict, onSuccess: { membershipSavedData in
                self.appDelegate.hideIndicator()

                if membershipSavedData.IsBFAutoApproved == 0{
                    if let thankyouMembershipViewController = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ThankYouMemberShipVC") as? ThankYouMemberShipVC {
                        thankyouMembershipViewController.thankYouDesc = self.appDelegate.masterLabeling.DUES_RENEWAL_BILLING_FREQUENCY_UPDATE_REQUEST_MESSAGE
                            //thankyouMembershipViewController.modalPresentationStyle = .fullScreen
                            self.present(thankyouMembershipViewController, animated: true, completion: nil)
                        
                    }
                }
                else{
                    if let thankyouMembershipViewController = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ThankYouMemberShipVC") as? ThankYouMemberShipVC {
                        thankyouMembershipViewController.thankYouDesc = self.appDelegate.masterLabeling.AUTO_APPROVED_MESSAGE
                           // thankyouMembershipViewController.modalPresentationStyle = .fullScreen
                            self.present(thankyouMembershipViewController, animated: true, completion: nil)
                        
                    }
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
extension MemberEditBillingFrequencyVC : UIPickerViewDelegate {
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectedBillingFrequency = arrBillingType[row].Value
            txtTypeBilling.text = arrBillingType[row].Text
            
        }
    
}
extension MemberEditBillingFrequencyVC : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrBillingType.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(arrBillingType[row].Value ?? "")"
    }
}
