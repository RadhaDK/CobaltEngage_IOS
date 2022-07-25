//
//  VBExpandVC.swift
//  VBExpand_Tableview
//
//  Created by Vimal on 8/16/17.
//  Copyright © 2017 Crypton. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Popover


class VBExpandVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var halfModalTransitioningDelegate: HalfModalTransitioningDelegate?
    @IBOutlet weak var btnRequestGuestcard: UIButton!
    var guestID:String!
    var guestName:String!
    var guestPhno:String!
    
    @IBOutlet weak var lblUpcomingVisits: UILabel!
    var actionSheetdatePicker =  ActionSheetDatePicker()
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var dictGuestCardDetails = GuestCard()
    
    var btnLoadPopview = UIButton()
    var dictguest = GuestList()
    var strnoupcomingvisits = String()
    var strmodify = String()
    
    var aView = UIView()
    
    
    @IBOutlet var myTableView: UITableView!
    var expandTableview:VBHeader = VBHeader()
    var rightCallButton = UIBarButtonItem()
    
    var btnFormDate = CustomUIButton()
    var btnToDate = CustomUIButton()
    
    var minimumDateToDate = Date()
    var maximumDateToDate = String()
    
    
    var guestSelectionType = String()
    
    var btnignore = CustomUIButton()
    var btnrequest = CustomUIButton()
    
    var popover = Popover()
    
    var arrguestDetails = GuestDetailsModify()
    
    
    var cell : VCExpandCell!
    var arrStatus:NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commomColorCode()
        self.appDelegate.isMoveToParentViewController = false
        
        
        
        
        self.btnLoadPopview = UIButton.init(frame:CGRect(x: 0, y: self.view.frame.height - 84, width: self.view.frame.size.width, height: 1))
        
        
        //        self.rightCallButton = UIBarButtonItem(image: UIImage(named: "Icon_Call"), style: .plain, target: self, action: #selector(callGuest))
        //        self.navigationItem.rightBarButtonItem = self.rightCallButton
        //        self.navigationItem.rightBarButtonItem?.tintColor = APPColor.loginBackgroundButtonColor.loginBtnBGColor
        
        
        let btnPlus = UIButton.init(frame: CGRect(x: (self.btnRequestGuestcard.frame.size.width / 2) - 110 , y: (self.btnRequestGuestcard.frame.size.height - 30) / 2 , width: 30, height: 30))
        let icon_Radio_Selected = UIImage(named: CommonImages.addguest_icon)
        btnPlus .setImage(icon_Radio_Selected, for: .normal)
        
        self.btnRequestGuestcard.addSubview(btnPlus)
        //        self.btnRequestGuestcard.addTarget(self, action: #selector(btnRequestPressed(sender:)), for: .touchUpInside)
        //
        //
        initFontForViews()
        self.getGuestCardDetails()
        
        self.myTableView.separatorInset = .zero
        self.myTableView.layoutMargins = .zero
        self.myTableView.rowHeight = 64
        self.myTableView.separatorColor = APPColor.celldividercolor.divider

        self.myTableView.tableFooterView = UIView()
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.refreshGuestDeatils(notification:)) , name:Notification.Name("refreshGuestDeatils") , object: nil)
        
    }
    
    @objc func refreshGuestDeatils(notification: Notification) {
        let searchedText = notification.userInfo?["refreshGuestDeatils"] ?? ""
        self.getGuestCardDetails()
    }
    
    
    func getGuestCardDetails() -> Void {
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            
            
            
            APIHandler.sharedInstance.getGetGuestCardDetails(paramater: paramaterDict, onSuccess: { guestcardList in
                if(guestcardList.responseCode == InternetMessge.kSuccess)
                {
                    if(guestcardList.guestList == nil){
                        self.appDelegate.hideIndicator()
                    }else{
                        var arrGuestList = [GuestCard]()
                        arrGuestList = guestcardList.guestList!
                        self.dictGuestCardDetails = GuestCard()
                        for i in 0..<arrGuestList.count {
                            let dictGuest = arrGuestList[i]
                            if(dictGuest.guestID == self.guestID){
                                self.myTableView.restore()
                                self.dictGuestCardDetails = dictGuest
                                print(dictGuest)
                                break;
                            }
                        }
                        
                        if(self.dictGuestCardDetails.guestCardDetails == nil){
                        }
                        else{
                            for j in 0..<(self.dictGuestCardDetails.guestCardDetails?.count)! {
                                print(j)
                                self.arrStatus.add("0")
                            }
                        }
                        
                        if(self.arrStatus.count<=0){
                            self.myTableView.setEmptyMessage(self.strnoupcomingvisits)
                        }
                        
                        
                        
                        self.myTableView.reloadData()
                        self.appDelegate.hideIndicator()
                    }
                }else{
                    self.appDelegate.hideIndicator()
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: guestcardList.responseMessage, withDuration: Duration.kMediumDuration)
                }
                
                self.appDelegate.hideIndicator()
                
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                if(self.arrStatus.count<=0){
                    self.myTableView.setEmptyMessage(InternetMessge.kNoupcomingVisits)
                }
            })
            
            
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
        
        
    }
    
    
    @objc func btnModifyPressedAtIndex(sender:UIButton) -> Void {
        self.appDelegate.dictGuestCardDetails = GuestCardDetail()
        self.appDelegate.guestID = ""
        
        var eventguest: GuestCardDetail
        eventguest = self.dictGuestCardDetails.guestCardDetails![sender.tag]
        self.appDelegate.dictGuestCardDetails = eventguest
        self.appDelegate.guestID = guestID
        self.appDelegate.strguestresource = CommonString.kmodify
        
        self.openpopoverController()
        
    }
    
    @objc func btnRequestPressed(sender:UIButton) -> Void {
        self.appDelegate.dictGuestCardDetails =  GuestCardDetail()
        self.appDelegate.guestID = ""
        self.appDelegate.guestID = guestID
        self.appDelegate.strguestresource = CommonString.krequest
        
        
    }
    
    @IBAction func btnRequestcardPressed(_ sender: UIButton) {
        self.appDelegate.strguestresource = "Request"
        self.openpopoverController()
    }
    
    
    
    @objc func cancelGuestOnClickIgnore(sender:UIButton) -> Void {
        var eventguest: GuestCardDetail
        eventguest = self.dictGuestCardDetails.guestCardDetails![sender.tag]
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kguestid: eventguest.guestCardId ?? "" ,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.klinkedmemberid:eventguest.transactionDetailID ?? "",
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            
            if (Network.reachability?.isReachable) == true{
                self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
                APIHandler.sharedInstance.cancelGuestCardApi(paramaterDict:paramaterDict, onSuccess: { parentMemberinfo in
                    if(parentMemberinfo.responseCode == InternetMessge.kSuccess){
                        //                        SharedUtlity.sharedHelper().showToast(on:
                        //                            self.view, withMeassge: parentMemberinfo.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.navigationController?.popViewController(animated: true)
                    self.appDelegate.hideIndicator()
                    
                },onFailure: { error, responseCode  in
                    
                    switch(responseCode.statusCode)
                    {
                    case 401:
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: ApiErrorMessages.kUnauthorized, withDuration: Duration.kMediumDuration)
                        break;
                    case 400:
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: ApiErrorMessages.kInvalidInput, withDuration: Duration.kMediumDuration)
                        break;
                    case 404:
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: ApiErrorMessages.kResourceNotFound, withDuration: Duration.kMediumDuration)
                        break;
                    case 408:
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: ApiErrorMessages.kRequestTimeout, withDuration: Duration.kMediumDuration)
                        break;
                    case 405:
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: ApiErrorMessages.kMethodNotAllowed, withDuration: Duration.kMediumDuration)
                        break;
                    case 500:
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: ApiErrorMessages.kInternalServerError, withDuration: Duration.kMediumDuration)
                        break;
                    case 505:
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: ApiErrorMessages.kHttpversionnotsupported, withDuration: Duration.kMediumDuration)
                        break;
                    default:
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: ApiErrorMessages.kInternalServerError, withDuration: Duration.kMediumDuration)
                    }
                    self.appDelegate.hideIndicator()
                    print(error)
                    
                })
            }else{
                
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            }
            
            
        }
    }
    
    
    
    
    func initFontForViews()
    {
        self.btnRequestGuestcard.titleLabel?.font = SFont.SourceSansPro_Semibold16
        self.btnRequestGuestcard.layer.cornerRadius = 20
        self.btnRequestGuestcard.layer.masksToBounds = true
        //self.btnRequestGuestcard .setTitle(CommonString.krequestguestCard, for: .normal)
        
        self.btnRequestGuestcard.layer.cornerRadius = 20
        
    }
    
    @objc func nameOfFunction() {
        
        self.getGuestCardDetails()
        
        
        
    }
    
    
    func setLocalizedString()
    {
        //        let jsonString = DataBaseHandlar.sharedInstance.getLocalizationValues()
        //        if ((jsonString == nil) || (jsonString.count<1)) {
        //
        //        }
        //        else{
        //            let labelling = Labelling(JSONString: jsonString)!
        //            print("getLocalizationValues:\(jsonString)")
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        self.navigationController?.navigationBar.isHidden = false
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.backItem?.title =  self.appDelegate.masterLabeling.bACK
        self.navigationController!.navigationBar.topItem!.title = self.appDelegate.masterLabeling.bACK
        navigationController!.interactivePopGestureRecognizer!.isEnabled = true
        
        self.navigationItem.title = guestName.trimmingCharacters(in: .whitespacesAndNewlines)
        self.appDelegate.isMoveToParentViewController = false
        self.btnRequestGuestcard.setTitle(self.appDelegate.masterLabeling.rEQUEST_GUEST_CARD, for: .normal)
        self.lblUpcomingVisits.text = self.appDelegate.masterLabeling.uPCOMING_VISITS
        self.strnoupcomingvisits = (self.appDelegate.masterLabeling.nO_UPCOMING_VISITS)!
        self.strmodify =  (self.appDelegate.masterLabeling.mODIFY)!
        
        //        }
    }
    
    
    
    //Mark- Common Color Code
    func commomColorCode()
    {
        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg
        self.btnRequestGuestcard.backgroundColor = APPColor.tintColor.tint
        self.btnRequestGuestcard.titleLabel?.textColor = APPColor.viewBgColor.viewbg
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        UIBarButtonItem.appearance().tintColor = UIColor.white
    }
    override func viewDidAppear(_ animated: Bool) {
        UIBarButtonItem.appearance().tintColor = UIColor.white
    }
    override func viewWillAppear(_ animated: Bool) {
        UIBarButtonItem.appearance().tintColor = UIColor.white
        self.setLocalizedString()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        expandTableview = Bundle.main.loadNibNamed("VBHeader", owner: self, options: nil)?[0] as! VBHeader
        
        
        let dictData = self.dictGuestCardDetails.guestCardDetails![section]
        
        expandTableview.lblDate.text = dictData.startDate! + " - " + dictData.endDate!
        expandTableview.lblStatus.text = dictData.guestCardStatus!
        if(dictData.guestCardStatus == CommonString.kpending)
        {
            expandTableview.lblStatus.textColor = APPColor.GuestCardstatus.pending
        }else{
            if(dictData.guestCardStatus == CommonString.kapproved)
            {
                expandTableview.lblStatus.textColor = APPColor.GuestCardstatus.approved
                
            }
        }
        
        expandTableview.imgArrow.isHidden = true
        
        
        
        if(dictData.guestCardStatus == CommonString.kpending){
            expandTableview.imgArrow.isHidden = false
            expandTableview.btnExpand.tag = section
            expandTableview.btnExpand.addTarget(self, action: #selector(VBExpandVC.headerCellButtonTapped(_sender:)), for: UIControlEvents.touchUpInside)
        }
        
        
        
        self.expandTableview.imgArrow.tintColor = APPColor.tintColor.tint
        
        let str:String = arrStatus[section] as! String
        if str == "0"{
            UIView.animate(withDuration: 2) { () -> Void in
                self.expandTableview.imgArrow.image = UIImage(named : CommonImages.exp_down)
                self.expandTableview.imgArrow.tintColor = APPColor.tintColor.tint
                let angle =  CGFloat(M_PI * 2)
                let tr = CGAffineTransform.identity.rotated(by: angle)
                self.expandTableview.imgArrow.transform = tr
            }
        }
        else{
            UIView.animate(withDuration: 2) { () -> Void in
                self.expandTableview.imgArrow.image = UIImage(named : CommonImages.exp_up)
                self.expandTableview.imgArrow.tintColor = APPColor.tintColor.tint
                
                let angle =  CGFloat(M_PI * 2)
                let tr = CGAffineTransform.identity.rotated(by: angle)
                self.expandTableview.imgArrow.transform = tr
            }
        }
        
        expandTableview.lblStatus.isHidden = true
        
        
        //        expandTableview.viewLine .isHidden = false
        //        if(section == 0){
        //            expandTableview.viewLine .isHidden = true
        //        }
        
//        self.expandTableview.uiViewLine.isHidden = false
//        if(section == 0){
//            self.expandTableview.uiViewLine.isHidden = true
//        }
//
        return expandTableview
    }
    @objc func headerCellButtonTapped(_sender: UIButton)
    {
        
        for i in 0..<arrStatus.count {
            
            if(i == _sender.tag){
                let str:String = arrStatus[_sender.tag] as! String
                
                if str == "0"
                {
                    arrStatus[_sender.tag] = "1"
                    
                }
                else
                {
                    arrStatus[_sender.tag] = "0"
                }
            }
            else{
                arrStatus[i] = "0"
            }
            
            
        }
            
            
        
//        let str:String = arrStatus[_sender.tag] as! String
//
//        if str == "0"
//        {
//            arrStatus[_sender.tag] = "1"
//
//        }
//        else
//        {
//            arrStatus[_sender.tag] = "0"
//        }
        myTableView.reloadData()
        
        
//        let str:String = arrStatus[_sender.tag] as! String
//        if str == "0"
//        {
//            arrStatus[_sender.tag] = "1"
//
//        }
//        else
//        {
//            arrStatus[_sender.tag] = "0"
//        }
//        myTableView.reloadData()
//
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        //Return header height as per your header hieght of xib
        return 54
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        let str:String = arrStatus[section] as! String
        
        if str == "0"
        {
            return 0
        }
        return   1 //(self.dictGuestCardDetails.guestCardDetails?.count)!
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! VCExpandCell
        cell.backgroundColor = APPColor.viewBgColor.viewbg
        
        
        
        cell.btnModify.titleLabel?.font = SFont.SourceSansPro_Semibold16
        cell.btnModify.layer.cornerRadius = 20
        cell.btnModify.layer.masksToBounds = true
        
        cell.btnModify.setTitleColor(APPColor.tintColor.tint, for: .normal)
        cell.btnModify.backgroundColor = APPColor.viewBgColor.viewbg
        cell.btnModify.layer.borderColor = APPColor.tintColor.tint.cgColor
        cell.btnModify.layer.borderWidth = 2
        
        
        
        cell.btnignore.titleLabel?.font = SFont.SourceSansPro_Semibold16
        cell.btnignore.layer.cornerRadius = 20
        cell.btnignore.layer.masksToBounds = true
        
        
        cell.btnignore.setTitleColor(APPColor.tintColor.tint, for: .normal)
        cell.btnignore.backgroundColor = APPColor.viewBgColor.viewbg
        cell.btnignore.layer.borderColor = APPColor.tintColor.tint.cgColor
        cell.btnignore.layer.borderWidth = 2
        
        
        cell.btnModify.setTitle(self.strmodify, for: .normal)
        
        
        cell.btnignore.tag = indexPath.section;
        cell.btnignore.addTarget(self, action: #selector(cancelGuestOnClickIgnore(sender:)), for: .touchUpInside)
        
        cell.btnModify.tag = indexPath.section;
        cell.btnModify.addTarget(self, action: #selector(btnModifyPressedAtIndex(sender:)), for: .touchUpInside)
        
        
        return cell;
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if self.dictGuestCardDetails.guestCardDetails == nil {
            return 0
        }
        else
        {
            return (self.dictGuestCardDetails.guestCardDetails?.count)!
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        //Return row height as per your cell in tableview
        return 90
    }
    
//
//    @objc func btnModifyPressed(_ sender: UIButton) {
//        let modalViewController = ModalViewController()
//        modalViewController.modalPresentationStyle = .formSheet
//        self.present(modalViewController, animated: true, completion: nil)
//    }
//
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //        let backItem = UIBarButtonItem()
        //        backItem.title = CommonString.kNavigationBack
        //        navigationItem.backBarButtonItem = backItem
        //
        
        self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: self, presentingViewController: segue.destination)
        
        segue.destination.modalPresentationStyle = .custom
        segue.destination.transitioningDelegate = self.halfModalTransitioningDelegate
    }
    
   
    @objc func btnDonePressed(){
        self.popover .dismiss()
        
        //        let reqestVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RequestCardAccountSummaryViewController") as! RequestCardAccountSummaryViewController
        //        self.navigationController?.pushViewController(reqestVC, animated: true)
        
    }
    
    @objc func openToDatePicker(){
        
        var currentDate = Date()
        currentDate = self.minimumDateToDate
        UIBarButtonItem.appearance().tintColor = APPColor.navigationColor.barbackgroundcolor

        self.actionSheetdatePicker = ActionSheetDatePicker.show(withTitle: "Date", datePickerMode: .date, selectedDate: currentDate, minimumDate: currentDate, maximumDate: nil, doneBlock: { (selectedDate, atIndexDate, anydate ) in
            

            UIBarButtonItem.appearance().tintColor = UIColor.white

            let formatter = DateFormatter()
            // initially set the format based on your datepicker date
            var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "UTC" }
            //print(localTimeZoneAbbreviation)
            formatter.locale = Locale.init(identifier: localTimeZoneAbbreviation)
            // convert your string to date
            formatter.dateFormat = "MM/dd/yyyy"
            let myString = formatter.string(from: atIndexDate as! Date) // string purpose I add here
            // print(myString)
            
            self.maximumDateToDate = myString

            self.btnToDate .setTitle(myString, for: .normal)
            self.btnToDate.accessibilityHint = myString
            
            
        }, cancel: { (cancelPressed) in
            
        }, origin: self.view)
        
        self.actionSheetdatePicker.minimumDate = currentDate
        
    }
    
    
    
    //MARK:- Open Popover view
    //MARK:- Right bar button Clicked
    func openpopoverController() {
        
        

        
        self.maximumDateToDate = ""
        
        let viewwidth:Double = Double(self.view.frame.width)
        let height:Double = Double(self.view.frame.height-85)
        
        let centerVale:Double = 0
        let startPoint = CGPoint(x: centerVale , y: height)
        self.aView = UIView(frame: CGRect(x: 0, y: centerVale, width: viewwidth, height: 155))
        self.aView.backgroundColor = .red
        
        var yAxis:Double
        yAxis = 0.0
        let xAxis = 8.0
        let buttonWidth = ((viewwidth / 2) - 20) - xAxis
        
        
        self.btnFormDate = CustomUIButton.init(frame: CGRect(x: xAxis, y: 0, width:buttonWidth , height: 44))
        self.btnFormDate.setTitle(self.appDelegate.masterLabeling.hINT_FROM_DATE, for: .normal)
        self.btnFormDate .setTitleColor(APPColor.textColor.text, for: .normal)
        
        self.btnFormDate.contentHorizontalAlignment = .left
        
        self.btnFormDate.addTarget(self, action: #selector(openFromDatePicker), for: .touchUpInside)
        
        let border = CALayer()
        border.borderColor = APPColor.tintColor.tint.cgColor
        border.frame = CGRect(x: 0, y: self.btnFormDate.frame.size.height-2, width: self.btnFormDate.frame.size.width, height: self.btnFormDate.frame.size.height-2)
        border.borderWidth = 2
        self.btnFormDate.layer.addSublayer(border)
        self.btnFormDate.layer.masksToBounds = true
        
        
        
        
        
        self.btnToDate = CustomUIButton.init(frame: CGRect(x: (viewwidth / 2) + 28, y: 0, width: buttonWidth - 8, height: 44))
        self.btnToDate.setTitle(self.appDelegate.masterLabeling.hINT_TO_DATE, for: .normal)
        self.btnToDate .setTitleColor(APPColor.textColor.text, for: .normal)
        self.btnToDate.contentHorizontalAlignment = .left
        self.btnToDate.addTarget(self, action: #selector(openToDatePicker), for: .touchUpInside)
        
        let borderTodate = CALayer()
        borderTodate.borderColor = APPColor.tintColor.tint.cgColor
        borderTodate.frame = CGRect(x: 0, y: self.btnToDate.frame.size.height-2, width: self.btnToDate.frame.size.width, height: self.btnToDate.frame.size.height-2)
        borderTodate.borderWidth = 2
        self.btnToDate.layer.addSublayer(borderTodate)
        self.btnToDate.layer.masksToBounds = true
        
        self.aView.addSubview(self.btnFormDate)
        self.aView.addSubview(self.btnToDate)
        
        
        let btnFromDateCal = UIButton.init()
        btnFromDateCal.frame = CGRect(x: self.btnFormDate.frame.size.width - 40, y: (self.btnFormDate.frame.size.height - 40)/2, width: 40, height: 40)
        let ic_forword = UIImage(named: "Icon_Calendar")
        btnFromDateCal.setImage(ic_forword, for: .normal)
        self.btnFormDate .addSubview(btnFromDateCal)
        btnFromDateCal.addTarget(self, action: #selector(openFromDatePicker), for: .touchUpInside)
        
        
        
        let btnToDateCal = UIButton.init()
        btnToDateCal.frame = CGRect(x: self.btnToDate.frame.size.width - 40, y: (self.btnToDate.frame.size.height - 40)/2, width: 40, height: 40)
        btnToDateCal.setImage(ic_forword, for: .normal)
        self.btnToDate .addSubview(btnToDateCal)
        btnToDateCal.addTarget(self, action: #selector(openToDatePicker), for: .touchUpInside)
        
        
        
        self.btnToDate.titleLabel?.font = SFont.SourceSansPro_Regular14
        self.btnFormDate.titleLabel?.font = SFont.SourceSansPro_Regular14
        
        yAxis = (Double(self.btnToDate.frame.size.height))   +  29.0
        
        self.btnignore = CustomUIButton.init(frame: CGRect(x: (viewwidth / 2) - 110, y: yAxis, width: 100, height: 44))
        
        self.btnignore.setTitleColor(APPColor.tintColor.tint, for: .normal)
        self.btnignore.backgroundColor = APPColor.viewBgColor.viewbg
        self.btnignore.layer.borderColor = APPColor.tintColor.tint.cgColor
        self.btnignore.layer.borderWidth = 2
        self.btnignore.layer.cornerRadius = 20
        
        
        self.btnrequest = CustomUIButton.init(frame: CGRect(x: (viewwidth / 2) + 10, y: yAxis, width: 100, height: 44))
        self.btnrequest.setTitleColor(APPColor.viewBgColor.viewbg, for: .normal)
        self.btnrequest.backgroundColor = APPColor.tintColor.tint
        self.btnrequest.layer.borderColor = APPColor.tintColor.tint.cgColor
        self.btnrequest.layer.borderWidth = 2
        self.btnrequest.layer.cornerRadius = 20
        
        
        
        self.btnrequest.contentHorizontalAlignment = .center
        self.btnignore.contentHorizontalAlignment = .center
        
        self.btnignore.setTitle(self.appDelegate.masterLabeling.iGNORE, for: .normal)
        self.btnrequest.setTitle(self.appDelegate.masterLabeling.rEQUEST, for: .normal)
        self.aView.addSubview(self.btnignore)
        self.aView.addSubview(self.btnrequest)
        
        
        self.btnignore.addTarget(self, action: #selector(requestIgnorePressed(_:)), for: .touchUpInside)
        self.btnrequest.addTarget(self, action: #selector(requestButtonTapped(_:)), for: .touchUpInside)
        
        if(self.appDelegate.strguestresource == "Request")
        {
            self.btnrequest.setTitle(self.appDelegate.masterLabeling.rEQUEST, for: .normal)
        }else
        {
            self.btnrequest.setTitle(self.appDelegate.masterLabeling.mODIFY, for: .normal)
        }
        
        
        self.btnignore.titleLabel?.font = SFont.SourceSansPro_Semibold16
        self.btnrequest.titleLabel?.font = SFont.SourceSansPro_Semibold16
        self.btnToDate.contentEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        self.btnFormDate.contentEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        self.addTopBorderWithColor(self.aView, color: APPColor.tintColor.tint, width: 1)
        
        
        self.popover = Popover()
        self.popover.arrowSize = CGSize.zero
        
        self.popover.layer.borderWidth = 0
        self.popover.layer.borderColor = UIColor.lightGray.cgColor
        self.popover.layer.masksToBounds = true
        self.popover.show(self.aView, point: startPoint)
    }
    //MARK: - Add Border to View -
    func addTopBorderWithColor(_ objView : UIView, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: objView.frame.size.width, height: width)
        objView.layer.addSublayer(border)
    }
    @IBAction func requestIgnorePressed(_ sender: Any) {
        self.popover .dismiss()
    }
    //MARK:- Request Button Tapped
    @IBAction func requestButtonTapped(_ sender: Any) {
        if ((self.btnFormDate.titleLabel?.text == self.appDelegate.masterLabeling.hINT_FROM_DATE) || (self.btnToDate.titleLabel?.text == self.appDelegate.masterLabeling.hINT_TO_DATE)){
            SharedUtlity.sharedHelper().showToast(on:self.aView, withMeassge:self.appDelegate.masterLabeling.dATE_CANT_BE_EMPTY , withDuration: Duration.kMediumDuration)
        }
        else{
            self.guestActionsApi()
            self.popover.dismiss()
        }
    }
    
    
    
    func guestActionsApi() -> Void {
        if(self.appDelegate.strguestresource == "Request"){
            self.appDelegate.guestID = ""
            self.appDelegate.guestID = guestID
            self.appDelegate.strguestresource = CommonString.krequest
            
            self.requestNewGuestcard()
        }
        else{
            self.modifyGuest()
        }
    }
    
    func requestNewGuestcard(){
        //        var kguestId = String()
        //        if(self.appDelegate.strguestresource == "Request"){
        //            kguestId = ""
        //        }
        
        let selectedNumber:[String:Any] = [
            APIKeys.kLinkedMemberID: self.appDelegate.dictGuestCardDetails.linkedMemberID ??  self.appDelegate.guestID ,
            ]
        let parameter:[String:Any] = [
            APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kAccompanyWithMainMember: 1 ,
            APIKeys.kFromDate: self.btnFormDate.accessibilityHint ?? "",
            APIKeys.kToDate: self.btnToDate.accessibilityHint ?? "",
            APIKeys.kSelectedNumbers: selectedNumber,
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict]
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: parameter, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        print(decoded)
        
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
                        self.appDelegate.isMoveToParentViewController = true
                        let transactionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RequestCardAccountSummaryViewController") as! RequestCardAccountSummaryViewController
                        transactionVC.arrguestdetails = self.arrguestDetails
                        self.navigationController?.pushViewController(transactionVC, animated: true)
                    }
                }
                else{
                    self.appDelegate.hideIndicator()
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: parentMemberinfo.responseMessage, withDuration: Duration.kMediumDuration)
                }
                self.appDelegate.hideIndicator()
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
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
            APIKeys.kFromDate:self.btnFormDate.accessibilityHint ?? "",
            APIKeys.kToDate: self.btnToDate.accessibilityHint ?? "",
            APIKeys.kSelectedNumbers: selectedNumber,
            APIKeys.kdeviceInfo: [APIHandler.devicedict]
        ]
        
        print("parameter:\(parameter)")
        
        
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            APIHandler.sharedInstance.modifyGuestApi(paramaterDict:parameter, onSuccess: { parentMemberinfo in
                self.appDelegate.hideIndicator()
                if(parentMemberinfo.responseCode == InternetMessge.kSuccess){
                    
                    
                    
                    self.navigationController?.popViewController(animated: true)
                    
                    //                    if(parentMemberinfo.guests == nil){
                    //                        if let delegate = self.navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
                    //                            delegate.interactiveDismiss = false
                    //                        }
                    //                        self.dismiss(animated: true, completion: nil)
                    //
                    //                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshGuestDeatils"), object: nil)
                    //                        self.navigationController?.popViewController(animated: true)
                    //                    }
                    //                    else{
                    //
                    //
                    //                        if let delegate = self.navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
                    //                            delegate.interactiveDismiss = false
                    //                        }
                    //                        self.dismiss(animated: true, completion: nil)
                    //                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshGuestDeatils"), object: nil)
                    //                        self.navigationController?.popViewController(animated: true)
                    //
                    //                    }
                    
                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: parentMemberinfo.responseMessage, withDuration: Duration.kMediumDuration)
                }
            },onFailure: { error  in
                
                self.appDelegate.hideIndicator()
                print(error)
                
            })
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
    @objc func openFromDatePicker(){
        self.view.endEditing(false)
        
        let currentDate = Date()
    
        UIBarButtonItem.appearance().tintColor = APPColor.navigationColor.barbackgroundcolor

        
        if(self.maximumDateToDate.count>0){
        
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date
            var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "UTC" }
            //print(localTimeZoneAbbreviation)
            formatter.locale = Locale.init(identifier: localTimeZoneAbbreviation)
            // convert your string to date
            formatter.dateFormat = "MM/dd/yyyy"
            //        let myString = formatter.string(from: atIndexDate as! Date) // string purpose I add here
            // print(myString)
            let maxmimumDate = formatter.date(from: self.maximumDateToDate)
            
            
            
            self.actionSheetdatePicker = ActionSheetDatePicker.show(withTitle: "Date", datePickerMode: .date, selectedDate: currentDate, minimumDate: currentDate, maximumDate: maxmimumDate, doneBlock: { (selectedDate, atIndexDate, anydate ) in
                
                self.minimumDateToDate = atIndexDate as! Date
                let formatter = DateFormatter()
                // initially set the format based on your datepicker date
                var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "UTC" }
                //print(localTimeZoneAbbreviation)
                formatter.locale = Locale.init(identifier: localTimeZoneAbbreviation)
                // convert your string to date
                formatter.dateFormat = "MM/dd/yyyy"
                let myString = formatter.string(from: atIndexDate as! Date) // string purpose I add here
                // print(myString)
                
                self.btnFormDate .setTitle(myString, for: .normal)
                self.btnFormDate.accessibilityHint = myString
                UIBarButtonItem.appearance().tintColor = UIColor.white

                
            }, cancel: { (cancelPressed) in
                
            }, origin: self.view)
        }
        else{
            
            self.actionSheetdatePicker = ActionSheetDatePicker.show(withTitle: "Date", datePickerMode: .date, selectedDate: currentDate, minimumDate: currentDate, maximumDate: nil, doneBlock: { (selectedDate, atIndexDate, anydate ) in
                
                self.minimumDateToDate = atIndexDate as! Date
                let formatter = DateFormatter()
                // initially set the format based on your datepicker date
                var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "UTC" }
                //print(localTimeZoneAbbreviation)
                formatter.locale = Locale.init(identifier: localTimeZoneAbbreviation)
                // convert your string to date
                formatter.dateFormat = "MM/dd/yyyy"
                let myString = formatter.string(from: atIndexDate as! Date) // string purpose I add here
                // print(myString)
                
                self.btnFormDate .setTitle(myString, for: .normal)
                self.btnFormDate.accessibilityHint = myString
                UIBarButtonItem.appearance().tintColor = UIColor.white
                
            }, cancel: { (cancelPressed) in
                
            }, origin: self.view)
        }
        
    }
    
}

extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

