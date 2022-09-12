//
//  MemberEditBillingFrequencyVC.swift
//  CSSI
//
//  Created by Vishal Pandey on 07/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit


class MemberEditBillingFrequencyVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var billingAmountView: UIView!
    @IBOutlet weak var billingAmountLbl: UILabel!
    @IBOutlet weak var savebtnbgView: UIView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var cancelbtnbgView: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnPicker: UIButton!

    
    let arrBillingType = ["Approved", "Pending", "Rejected"]
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSave.setTitle("", for: .normal)
        btnCancel.setTitle("", for: .normal)
        self.navigationItem.title = "Update Billing Frequency"
        
        billingAmountView.layer.borderColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1).cgColor
        billingAmountView.layer.borderWidth = 1
        
        savebtnbgView.layer.borderColor = UIColor(red: 42/255, green: 78/255, blue: 127/255, alpha: 1).cgColor
        savebtnbgView.layer.borderWidth = 1.5
        savebtnbgView.layer.cornerRadius = 23
        
        cancelbtnbgView.layer.borderColor = UIColor(red: 42/255, green: 78/255, blue: 127/255, alpha: 1).cgColor
        cancelbtnbgView.layer.borderWidth = 1.5
        cancelbtnbgView.layer.cornerRadius = 20
        btnPicker.setTitle("", for: .normal)
      
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        
    }
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnTapped(sender:UIButton){
        
    }
    
    @IBAction func cancelBtnTapped(sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnChoosBilling(_ sender: UIButton) {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
                
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    @IBAction func PickerBtnTapped(sender:UIButton){
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
                
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrBillingType.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrBillingType[row]
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(arrBillingType[row])
        billingAmountLbl.text = arrBillingType[row]
    }
    

}


