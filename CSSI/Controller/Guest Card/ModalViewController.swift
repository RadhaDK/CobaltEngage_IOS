

import UIKit
import TweeTextField


class ModalViewController: UIViewController, HalfModalPresentable, UITextFieldDelegate  {
    @IBOutlet weak var txtFromDate: TweeBorderedTextField!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    
     @IBOutlet weak var txtTodate: TweeBorderedTextField!
    var guestID = String()
    var receiptNumber = String()
    var accompanyWithMainMember = Int()
    var guestCardID = String()
    var transactionID = String()
    var linkedMemberID = String()
    var ID = String()
    var mimimumDateToDate = Date()
    var guestSelectionType = String()

    
    
    @IBOutlet weak var btnignore: UIButton!
    @IBOutlet weak var btnrequest: UIButton!
    var arrguestDetails = GuestDetailsModify()

    var actionSheetdatePicker: ActionSheetDatePicker!

    
    @IBOutlet weak var btnFormDate: UIButton!
    
    @IBOutlet weak var btnTodate: UIButton!
    

    let picker = UIDatePicker()

    func createDatePicker() {
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
    }
    
    @objc func donePressed() {
        // format date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: picker.date)
        txtFromDate.text = dateString
       
        self.view.endEditing(true)
    }
    @IBAction func maximizeButtonTapped(sender: AnyObject) {
     //   maximizeToFullScreen()
    }
    @IBAction func ignoreButtonTapped(_ sender: Any) {
        
        if let delegate = navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
            delegate.interactiveDismiss = false
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
  
    @IBOutlet weak var fromDateCalender: UIButton!
    @IBOutlet weak var toDateCalender: UIButton!

   
    
    
    //MARK:- Request Button Tapped
    @IBAction func RequestButtonTapped(_ sender: Any) {
        
        
        if ((self.btnFormDate.titleLabel?.text == CommonString.kfromdate) || (self.btnTodate.titleLabel?.text == CommonString.ktodate)){
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: CommonString.kselectdate, withDuration: Duration.kMediumDuration)
        }
        else{
            if(self.appDelegate.arrRequest.count > 0){
                guestActionsApiMultiple()
            }
            else{
                guestActionsApi()
            }
        }
    }
    
    @IBAction func editingChanged(_ sender: TweeAttributedTextField) {
        self.txtFromDate.resignFirstResponder();
    }
    
    @IBAction func didValuesChanged(_ sender: TweeAttributedTextField) {
        self.txtFromDate.resignFirstResponder();

    }
    
    
    
    func setLocalizedString()
    {
//        let jsonString = DataBaseHandlar.sharedInstance.getLocalizationValues()
//        if ((jsonString == nil) || (jsonString.count<1)) {
//
//        }
//        else{
        
            self.btnignore.setTitle(self.appDelegate.masterLabeling.iGNORE, for: .normal)
            self.btnrequest.setTitle(self.appDelegate.masterLabeling.rEQUEST, for: .normal)
            self.btnFormDate.setTitle(self.appDelegate.masterLabeling.hINT_FROM_DATE, for: .normal)
            self.btnTodate.setTitle(self.appDelegate.masterLabeling.hINT_TO_DATE, for: .normal)

            
            
            
//        }
    }
    
    
    
    
    @IBAction func didBegingEditing(_ sender: TweeAttributedTextField) {
        
        self.txtFromDate.resignFirstResponder();

    }
    
    func guestActionsApi() -> Void {
        if(self.appDelegate.strguestresource == "Request"){
            self.requestNewGuestcard()
        }
        else{
        self.modifyGuest()
        }
    }
    
    func requestNewGuestcard(){
        var kguestId = String()
        if(self.appDelegate.strguestresource == "Request"){
            kguestId = ""
        }
        
        let selectedNumber:[String:Any] = [
//            APIKeys.kID: self.appDelegate.dictGuestCardDetails.guestCardId ?? "" ,
//            APIKeys.kTransactionID: self.appDelegate.dictGuestCardDetails.transactionID ?? "",
            APIKeys.kLinkedMemberID: self.appDelegate.dictGuestCardDetails.linkedMemberID ??  self.appDelegate.guestID ,
            ]
        
        let parameter:[String:Any] = [
            APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            
            APIKeys.kAccompanyWithMainMember: 1 ,//self.appDelegate.dictGuestCardDetails.accompanyWithMainMember ?? "",
            APIKeys.kFromDate: self.txtFromDate.text!,
            APIKeys.kToDate: self.txtTodate.text!,
            APIKeys.kSelectedNumbers: selectedNumber,
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict]
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: parameter, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
       // print(decoded)
        
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.requestNewGuestCard(paramaterDict:parameter, onSuccess: { parentMemberinfo in                
                
                if(parentMemberinfo.responseCode == InternetMessge.kSuccess){
                    if(parentMemberinfo.guestsdetails == nil){
                        if let delegate = self.navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
                            delegate.interactiveDismiss = false
                        }
                        self.dismiss(animated: true, completion: nil)
                    }
                    else{
                        self.appDelegate.strguestresource = ""
                        self.arrguestDetails = parentMemberinfo.guestsdetails!
                        self.maximizeToFullScreen()
                        self.appDelegate.isMoveToParentViewController = true
                        let transactionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RequestCardAccountSummaryViewController") as! RequestCardAccountSummaryViewController
                        transactionVC.arrguestdetails = self.arrguestDetails
                        self.navigationController?.pushViewController(transactionVC, animated: true)
                    }
                }
                else{
                    self.appDelegate.hideIndicator()
                 
                    
                    if(((parentMemberinfo.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: parentMemberinfo.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    
                    
                    
                }
                self.appDelegate.hideIndicator()
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }
        else{
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
    }
    func modifyGuest(){
        let selectedNumber:[String:Any] = [
            APIKeys.kID: self.appDelegate.dictGuestCardDetails.guestCardId ?? "" ,
            APIKeys.kTransactionID: self.appDelegate.dictGuestCardDetails.transactionID ?? "",
            APIKeys.kLinkedMemberID: self.appDelegate.selectedGuest.guestID ?? ""//self.appDelegate.dictGuestCardDetails.linkedMemberID ??  self.appDelegate.guestID ,
            ]
        let parameter:[String:Any] = [
            APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
//            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
//            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            
            APIKeys.kguestid: self.appDelegate.selectedGuest.guestID ?? "",
            APIKeys.kreceiptNumber: self.appDelegate.dictGuestCardDetails.receiptNumber ?? "",
            
            APIKeys.kAccompanyWithMainMember: 1 ,//self.appDelegate.dictGuestCardDetails.accompanyWithMainMember ?? "",
            APIKeys.kFromDate: self.txtFromDate.text!,
            APIKeys.kToDate: self.txtTodate.text!,
            APIKeys.kSelectedNumbers: selectedNumber,
            APIKeys.kdeviceInfo: [APIHandler.devicedict]
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: parameter, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        print(decoded)
        
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.modifyGuestApi(paramaterDict:parameter, onSuccess: { parentMemberinfo in
                
                self.appDelegate.hideIndicator()

                if(parentMemberinfo.responseCode == InternetMessge.kSuccess){
                    if(parentMemberinfo.guests == nil){
                        if let delegate = self.navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
                            delegate.interactiveDismiss = false
                        }
                        self.dismiss(animated: true, completion: nil)
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshGuestDeatils"), object: nil)
                        self.navigationController?.popViewController(animated: true)
                    }
                    else{
                        
                        
                        if let delegate = self.navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
                            delegate.interactiveDismiss = false
                        }
                        self.dismiss(animated: true, completion: nil)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshGuestDeatils"), object: nil)
                        self.navigationController?.popViewController(animated: true)

                    }
                    
                    
                    let viewControllers: [UIViewController] = self.navigationController!.viewControllers
                    for aViewController in viewControllers {
                        
                        print(aViewController)
                        
//                        if aViewController is YourViewController {
//                            self.navigationController!.popToViewController(aViewController, animated: true)
//                        }
                    }
                    
                    
                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    
                    if(((parentMemberinfo.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: parentMemberinfo.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    
                }
                
                
                
                
            },onFailure: { error  in
                
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
                
            })
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        // Additional code here
        return false
    }
 
    
    func guestActionsApiMultiple() -> Void {
        var  selectedNumber = [String:Any]()
        let prodArray:NSMutableArray = NSMutableArray()
        
        for item in self.appDelegate.arrRequest{
            
            let prod: NSMutableDictionary = NSMutableDictionary()
            
            prod.setValue("", forKey: APIKeys.kID)
            prod.setValue("", forKey: APIKeys.kTransactionID)
            prod.setValue(item.guestID, forKey: APIKeys.kLinkedMemberID)
            prodArray.add(prod)
            
           // print(item.guestID)
            
        }
        
        
        
       // print(prodArray)
        
        let parameter:[String:Any] = [
            APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kguestid:  "",
            APIKeys.kAccompanyWithMainMember: 1 ,//self.appDelegate.dictGuestCardDetails.accompanyWithMainMember ?? "",
            APIKeys.kFromDate: self.txtFromDate.text!,
            APIKeys.kToDate: self.txtTodate.text!,
            APIKeys.kSelectedNumbers: prodArray,
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict]
        ]
        
        
        
       // print(parameter)
        
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.requestNewGuestCard(paramaterDict:parameter, onSuccess: { parentMemberinfo in
                
                if(parentMemberinfo.responseCode == InternetMessge.kSuccess){
                    if(parentMemberinfo.guestsdetails == nil){
                        if let delegate = self.navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
                            delegate.interactiveDismiss = false
                        }
                        self.dismiss(animated: true, completion: nil)

                    }
                    else{

                    
                        self.appDelegate.strguestresource = ""
                        self.appDelegate.arrRequest = []
                        self.arrguestDetails = parentMemberinfo.guestsdetails!
                        
                        self.maximizeToFullScreen()
                        self.appDelegate.isMoveToParentViewController = true
                        let transactionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RequestCardAccountSummaryViewController") as! RequestCardAccountSummaryViewController
                        transactionVC.arrguestdetails = self.arrguestDetails
                        self.navigationController?.pushViewController(transactionVC, animated: true)
                        self.appDelegate.hideIndicator()
                        
                        
                    }
//
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((parentMemberinfo.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: parentMemberinfo.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                }
                
                
                self.appDelegate.hideIndicator()
                
                
            },onFailure: { error  in
                
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
                
            })
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
        
        
    }
    
    
    
    
    
    
    
    @objc func openFromDatePicker(){
        self.view.endEditing(false)
        self.txtFromDate.resignFirstResponder();

        let currentDate = Date()
      
       // self.actionSheetdatePicker.minimumDate = currentDate
        
    //    self.actionSheetdatePicker.minimumDate = currentDate
     
        self.actionSheetdatePicker = ActionSheetDatePicker.show(withTitle: "Date", datePickerMode: .date, selectedDate: currentDate, minimumDate: currentDate, maximumDate: nil, doneBlock: { (selectedDate, atIndexDate, anydate ) in
            
            self.mimimumDateToDate = atIndexDate as! Date
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date
            var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "UTC" }
            //print(localTimeZoneAbbreviation)
            formatter.locale = Locale.init(identifier: localTimeZoneAbbreviation)
            // convert your string to date
            formatter.dateFormat = "MM/dd/yyyy"
            let myString = formatter.string(from: atIndexDate as! Date) // string purpose I add here
           // print(myString)
            self.txtFromDate.text = myString
            
            self.btnFormDate .setTitle(myString, for: .normal)
            self.btnFormDate.accessibilityHint = myString
            
        }, cancel: { (cancelPressed) in
            
        }, origin: self.view)

        

        
    }
    @objc func openToDatePicker(){
        
        var currentDate = Date()
        currentDate = self.mimimumDateToDate
        
        self.actionSheetdatePicker = ActionSheetDatePicker.show(withTitle: "Date", datePickerMode: .date, selectedDate: currentDate, minimumDate: currentDate, maximumDate: nil, doneBlock: { (selectedDate, atIndexDate, anydate ) in
            
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date
            var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "UTC" }
            //print(localTimeZoneAbbreviation)
            formatter.locale = Locale.init(identifier: localTimeZoneAbbreviation)
            // convert your string to date
            formatter.dateFormat = "MM/dd/yyyy"
            let myString = formatter.string(from: atIndexDate as! Date) // string purpose I add here
           // print(myString)
             self.txtTodate.text = myString

            self.btnTodate .setTitle(myString, for: .normal)
            self.btnTodate.accessibilityHint = myString
            
            
        }, cancel: { (cancelPressed) in
            
        }, origin: self.view)
        
        self.actionSheetdatePicker.minimumDate = currentDate
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if self.appDelegate.isMoveToParentViewController == true {
            if let delegate = navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
                delegate.interactiveDismiss = false
            }
            dismiss(animated: false, completion: nil)
            self.appDelegate.isMoveToParentViewController = false
        }
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
    }
    
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        if let delegate = navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
            delegate.interactiveDismiss = false
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func textDidBeginEditing(sender:UITextField) -> Void
    {
        // handle begin editing event
    }
    
    override func viewDidLoad() {

        //Added on 14th October 2020 V2.3
        //Added for iOS 14 date picker change
        if #available(iOS 14.0,*)
        {
            picker.preferredDatePickerStyle = .wheels
        }


        if(self.appDelegate.strguestresource == "Request")
        {
            self.btnrequest.setTitle(self.appDelegate.masterLabeling.rEQUEST, for: .normal)
        }
        else
        {
            self.btnrequest.setTitle(self.appDelegate.masterLabeling.mODIFY, for: .normal)
        }
        
        self.setLocalizedString()

        
        
        
        self.txtFromDate.lineColor = APPColor.tintColor.tint
        self.txtFromDate.lineWidth = 1
        self.txtFromDate.tweePlaceholder = CommonString.kfromdate
        self.txtFromDate.font = SFont.SourceSansPro_Regular16
        
        self.txtTodate.lineColor = APPColor.tintColor.tint
        self.txtTodate.lineWidth = 1
        self.txtTodate.tweePlaceholder = CommonString.ktodate
        self.txtTodate.font = SFont.SourceSansPro_Regular16
        
        
        self.txtFromDate.delegate = self
        self.txtTodate.delegate = self
        
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = APPColor.tintColor.tint.cgColor
        border.frame = CGRect(x: 0, y: self.btnFormDate.frame.size.height-2, width: self.btnFormDate.frame.size.width, height: self.btnFormDate.frame.size.height-2)
        border.borderWidth = 2
        self.btnFormDate.layer.addSublayer(border)
        self.btnFormDate.layer.masksToBounds = true
        
        
        let borderTodate = CALayer()
        borderTodate.borderColor = APPColor.tintColor.tint.cgColor
        borderTodate.frame = CGRect(x: 0, y: self.btnFormDate.frame.size.height-2, width: self.btnFormDate.frame.size.width, height: self.btnFormDate.frame.size.height-2)
        borderTodate.borderWidth = 2
        self.btnTodate.layer.addSublayer(borderTodate)
        self.btnTodate.layer.masksToBounds = true
        
        
       
        
        
        self.btnTodate .setTitle(self.appDelegate.masterLabeling.hINT_TO_DATE, for: .normal)
        self.btnFormDate .setTitle(self.appDelegate.masterLabeling.hINT_FROM_DATE, for: .normal)
        
        self.btnFormDate .setTitleColor(APPColor.textColor.text, for: .normal)
        self.btnTodate .setTitleColor(APPColor.textColor.text, for: .normal)
        
        
        
        self.btnrequest.setTitleColor(APPColor.viewBgColor.viewbg, for: .normal)
        self.btnrequest.backgroundColor = APPColor.tintColor.tint
        self.btnrequest.layer.borderColor = APPColor.tintColor.tint.cgColor
        self.btnrequest.layer.borderWidth = 2
        self.btnrequest.layer.cornerRadius = 20
        
        
        self.btnignore.setTitleColor(APPColor.tintColor.tint, for: .normal)
        self.btnignore.backgroundColor = APPColor.viewBgColor.viewbg
        self.btnignore.layer.borderColor = APPColor.tintColor.tint.cgColor
        self.btnignore.layer.borderWidth = 2
        self.btnignore.layer.cornerRadius = 20
        
        
        self.btnFormDate.contentHorizontalAlignment = .left
        self.btnTodate.contentHorizontalAlignment = .left
        
        self.navigationController?.navigationBar.isHidden = true

        self.btnTodate.addTarget(self, action: #selector(openToDatePicker), for: .touchUpInside)
        self.btnFormDate.addTarget(self, action: #selector(openFromDatePicker), for: .touchUpInside)
        self.fromDateCalender.addTarget(self, action: #selector(openFromDatePicker), for: .touchUpInside)
        self.toDateCalender.addTarget(self, action: #selector(openToDatePicker), for: .touchUpInside)
        
        
    }
    
    @objc func fromDate() {
        openFromDatePicker()
       
    }
    @objc func todate() {
      openToDatePicker()
    }
    
}

