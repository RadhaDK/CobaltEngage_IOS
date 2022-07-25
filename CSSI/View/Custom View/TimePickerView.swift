//
//  WishlistView.swift
//  CSSI
//
//  Created by Kiran on 07/04/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

typealias pickerStyle = UIDatePickerMode

protocol TimePickerViewDelegate : NSObject {
    /// Called when ok is clicked.
    ///
    /// First time is the top picker picked valueand second time is second pikcer picked value. string is riturned as per dateFormat.
    func didSelectTime(firstTime : String? , secondTime : String?)
    
    func didCancel()
}

class TimePickerView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var TimeView: UIView!
    @IBOutlet weak var viewTopPicker: UIView!
    @IBOutlet weak var viewBottomPicker: UIView!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var bttnOk: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
 
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTopPickerTitle: UILabel!
    @IBOutlet weak var textFieldTopPicker: UITextField!
    @IBOutlet weak var lblBottomPIckerTitle: UILabel!
    
    @IBOutlet weak var textFieldBottomPicker: UITextField!
    
    
    weak var delegate : TimePickerViewDelegate?
    
    var pickerType : pickerStyle = .time {
        didSet{
            self.picker.datePickerMode = self.pickerType
        }
    }
    
    private var picker : UIDatePicker = {
        let datePicker = UIDatePicker.init()
        //Added on 14th October 2020 V2.3
        //Added for iOS 14 date picker change
        if #available(iOS 14.0,*)
        {
            datePicker.preferredDatePickerStyle = .wheels
        }
        return datePicker
    }()
    
    var minLimit : Date? {
        didSet{
            self.picker.minimumDate = self.minLimit
        }
    }
    
    var maxLimit : Date? {
        didSet{
            self.picker.maximumDate = self.maxLimit
        }
    }
    
    var timeInterval : Int = 0 {
        didSet{
            self.picker.minuteInterval = self.timeInterval
        }
    }
    

    var dateFormat = ""
    
    ///Enables later than and earliar han comparision logic
    ///
    ///When true maks sure that the first picker value is not greatee than second picker value  if greater then the second picker value is put in first picker and vice versa for the other case
    ///Note: comparision is done in minutes
    var runLatestEarliestComparision = false
    
    private var selectedTextField : UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUpView()
    }
    
    @IBAction func okClicked(_ sender: UIButton) {
        
        self.delegate?.didSelectTime(firstTime: self.textFieldTopPicker.text, secondTime: self.textFieldBottomPicker.text)
        self.removeFromSuperview()
    }
    
    @IBAction func cancelClicked(_ sender: UIButton) {
        self.delegate?.didCancel()
        self.removeFromSuperview()
    }
    
    
    private func setUpView()
    {
        Bundle.main.loadNibNamed("TimePickerView", owner: self, options: [:])
        self.contentView.frame = self.bounds
        
        self.contentView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        self.addSubview(self.contentView)
        self.initialSetup()
    }
}


extension TimePickerView
{
    private func initialSetup()
    {
        self.TimeView.layer.cornerRadius = 20
        self.TimeView.clipsToBounds = true
        
        self.textFieldTopPicker.delegate = self
        self.textFieldBottomPicker.delegate = self
        self.contentView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.picker.addTarget(self, action: #selector(didPickValue(sender:)), for: .valueChanged)
        
    }
}


extension TimePickerView : UITextFieldDelegate
{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        
        self.selectedTextField = textField
        
        if let pickerText = textField.text
        {
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = self.dateFormat
            
            if let date = dateFormatter.date(from: pickerText)
            {
                self.picker.setDate(date, animated: false)
            }
        }
        
        if textField == self.textFieldTopPicker
        {
            self.picker.minimumDate = self.minLimit
        }
        else if textField == self.textFieldBottomPicker
        {
            if let topPickerValue = self.textFieldTopPicker.text
            {
                let dateFormatter = DateFormatter.init()
                dateFormatter.dateFormat = self.dateFormat
                           
                self.picker.minimumDate = dateFormatter.date(from: topPickerValue)
            }
           
        }
        
        textField.inputView = self.picker
        
        return true
    }
}

extension TimePickerView
{
    
    @objc private func didPickValue(sender : UIDatePicker)
    {
        if let textField = self.selectedTextField
        {
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "hh:mm a"
            
            if self.runLatestEarliestComparision
            {
                
                if textField == self.textFieldTopPicker
                {
                    if let secondDateString = self.textFieldBottomPicker.text , secondDateString != "" , let bottomDate = dateFormatter.date(from: secondDateString)
                    {
                        if Calendar.current.compare(sender.date, to: bottomDate, toGranularity: .minute) == .orderedDescending
                        {
                            self.textFieldBottomPicker.text = dateFormatter.string(from: sender.date)
                        }
                        
                        textField.text = dateFormatter.string(from: sender.date)
                    }
                }
                else if textField == self.textFieldBottomPicker
                {
                    if let firstDateString = self.textFieldTopPicker.text , firstDateString != "" , let topDate = dateFormatter.date(from: firstDateString)
                    {
                        if Calendar.current.compare(sender.date, to: topDate, toGranularity: .minute) == .orderedAscending
                        {
                            textField.text = dateFormatter.string(from: topDate)
                        }
                        else
                        {
                            textField.text = dateFormatter.string(from: sender.date)
                        }
                    }
                }
                
                
            }
            else
            {
                textField.text = dateFormatter.string(from: sender.date)
            }
            
        }
    }
    
}
