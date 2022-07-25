//
//  BMSCancelView.swift
//  CSSI
//
//  Created by Kiran on 22/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class BMSCancelView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var scrollView: UIView!
    @IBOutlet private weak var scrollContentView: UIView!
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var cancelImgView: UIImageView!
    @IBOutlet weak var lblCancelMessage: UILabel!
    @IBOutlet weak var lblReason: UILabel!
    @IBOutlet weak var txtFieldReason: UITextField!
    @IBOutlet weak var lblOtherReason: UILabel!
    @IBOutlet weak var txtViewOtherReason: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var btnClose: UIButton!
    
    //Added on 12th August 2020 V2.3
    @IBOutlet weak var viewReason: UIView!
    
    private var pickerView = UIPickerView()
    
    private var arrCancelReasons = [CancelReason]()
    private var selectedCancelReason : CancelReason?{
        didSet{
            self.txtFieldReason.text = self.selectedCancelReason?.reason
        }
    }
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var appointmentDetailID : String?
    var success : ((_ imgPath : String?) -> ())?
    
    //Added by kiran V2.3
    private var showReasonDropDown = false
    
    private let otherReasonColor = hexStringToUIColor(hex: "#695B5E")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.txtViewOtherReason.layer.cornerRadius = 6.0
        self.txtViewOtherReason.layer.borderWidth = 0.25
        self.txtViewOtherReason.layer.borderColor = hexStringToUIColor(hex: "#2D2D2D").cgColor
        self.txtViewOtherReason.clipsToBounds = true
        
        self.txtFieldReason.layer.cornerRadius = 6.0
        self.txtFieldReason.layer.borderWidth = 0.25
        self.txtFieldReason.layer.borderColor = hexStringToUIColor(hex: "#2D2D2D").cgColor
        self.txtFieldReason.clipsToBounds = true
        self.cancelView.layer.cornerRadius = 10
        self.cancelView.clipsToBounds = true
        
        //Added by kiran V2.3
        self.viewReason.isHidden = !self.showReasonDropDown
    }
    
    @IBAction func submitClicked(_ sender: UIButton) {
        
        self.cancelRequest()
    }
    
    @IBAction func closeClicked(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    @objc private func tapAction()
    {
        self.removeFromSuperview()
    }
    
}


extension BMSCancelView
{
    private func setupView()
    {
        Bundle.main.loadNibNamed("BMSCancelView", owner: self, options: [:])
         self.contentView.frame = self.bounds
        
         self.addSubview(self.contentView)
         
         //If not disabled auto resizing masks are messing with the layout of lables and not calculating the size properlly
         self.contentView.translatesAutoresizingMaskIntoConstraints = false
         
         //Auto resizing masks conflictiong with autolayouts so switched with auto layout
         NSLayoutConstraint.init(item: self.contentView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
         NSLayoutConstraint.init(item: self.contentView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
         NSLayoutConstraint.init(item: self.contentView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
         NSLayoutConstraint.init(item: self.contentView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
         self.layoutIfNeeded()
        self.initialSetup()
    }
    
    private func initialSetup()
    {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.txtFieldReason.inputView = self.pickerView
        self.txtFieldReason.delegate = self
        self.txtFieldReason.setRightIcon(imageName: "Path 1847")
        
        //Addign paddign at the start of textfield
        let paddingView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 4, height: 10))
        paddingView.backgroundColor = .clear
        self.txtFieldReason.leftView = paddingView
        
        self.arrCancelReasons = self.appDelegate.BMS_cancelReasons
        //Added by kiran V2.4 -- Ticket GATHER0000164
        self.showReasonDropDown = self.arrCancelReasons.count > 0
        
        self.btnSubmit.fitnessRequestBttnViewSetup()
        self.btnSubmit.setTitle(self.appDelegate.masterLabeling.rEQUEST, for: .normal)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        tapGesture.delegate = self
        //self.scrollContentView.addGestureRecognizer(tapGesture)
        self.contentView.addGestureRecognizer(tapGesture)
        self.lblCancelMessage.text = self.appDelegate.masterLabeling.BMS_REASONTEXT
        self.lblReason.text = self.appDelegate.masterLabeling.BMS_REASON
        self.txtFieldReason.placeholder = self.appDelegate.masterLabeling.BMS_SELECT
        self.lblOtherReason.text = self.appDelegate.masterLabeling.BMS_OTHERREASON
        self.txtViewOtherReason.text = self.appDelegate.masterLabeling.BMS_CANCELREASON
        self.txtViewOtherReason.textColor = .lightGray
        self.txtViewOtherReason.delegate = self
        
        self.btnSubmit.setStyle(style: .contained, type: .primary)
        
    }
    
    
    private func cancelRequest()
    {
        guard Network.reachability?.isReachable == true else {
            SharedUtlity.sharedHelper().showToast(on:
            self.contentView, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            return
        }
        
        if let appointmentDetailID = self.appointmentDetailID
        {
            let comments = self.appDelegate.masterLabeling.BMS_CANCELREASON == self.txtViewOtherReason.text ? "" : (self.txtViewOtherReason.text ?? "")
            let paramaterDict : [String : Any] = [
            APIHeader.kContentType : "application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kAppointmentDetailID : appointmentDetailID,
            APIKeys.kCancelReason : self.selectedCancelReason?.reason ?? "",
            APIKeys.kComments : comments
            ]
            self.appDelegate.showIndicator(withTitle: "", intoView: self.contentView)
            APIHandler.sharedInstance.cancelAppointment(paramater: paramaterDict, onSuccess: { (imgpath) in
                self.appDelegate.hideIndicator()
                self.success?(imgpath)
                self.removeFromSuperview()
            }) { (error) in
                self.appDelegate.hideIndicator()
                 SharedUtlity.sharedHelper()?.showToast(on: self.contentView, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            }
        }
    }
}

//MARK:- TextField Delegates
extension BMSCancelView : UITextFieldDelegate
{
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField == self.txtFieldReason
        {
            let index = self.arrCancelReasons.firstIndex(where: {$0.reason == self.selectedCancelReason?.reason})

            if let index = index
            {
                self.pickerView.selectRow(index, inComponent: 0, animated: true)
            }
            else
            {
                self.pickerView.selectRow(0, inComponent: 0, animated: true)
                self.selectedCancelReason = self.arrCancelReasons[0]
            }
            
        }
        
    }
    
}

//MARK:- Text View Delegates
extension BMSCancelView : UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if textView == self.txtViewOtherReason
        {
            let string = textView.text.replacingOccurrences(of: self.appDelegate.masterLabeling.BMS_CANCELREASON ?? "" , with: "")
            
            if string.isEmpty
            {
                textView.text = ""
                textView.textColor = self.otherReasonColor
            }
            
        }
        
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if textView == self.txtViewOtherReason
        {
            if textView.text.isEmpty
            {
                textView.text = self.appDelegate.masterLabeling.BMS_CANCELREASON
                textView.textColor = .lightGray
            }
        }
    }
}

extension BMSCancelView : UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.arrCancelReasons.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.arrCancelReasons[row].reason
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //KVO Assigns value to the textfield
        self.selectedCancelReason = self.arrCancelReasons[row]
    }
    
}

extension BMSCancelView : UIGestureRecognizerDelegate
{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view == self.cancelView || touch.view?.isDescendant(of: self.cancelView) ?? false) && !(touch.view?.isKind(of: UIPickerView.self) ?? true)
        {
            return false
        }
        return true
    }
}
