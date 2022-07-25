//
//  RequestCardViewController.swift
//  CSSI
//
//  Created by MACMINI13 on 26/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Popover

class RequestCardViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    var halfModalTransitioningDelegate: HalfModalTransitioningDelegate?

    @IBOutlet weak var tblRequestcard: UITableView!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var arrGuestList = [Guest1]()
    var dictguest = GuestList()
    var dictRequestCard = Guest1()
    var indexNumber:NSInteger = -1
    var refreshControl = UIRefreshControl()

    let limit = 100
    @IBOutlet weak var btnRequestGuestcard: UIButton!

    
    var aView = UIView()
    
    var btnFormDate = CustomUIButton()
    var btnToDate = CustomUIButton()
    
    var actionSheetdatePicker =  ActionSheetDatePicker()

    var btnignore = CustomUIButton()
    var btnrequest = CustomUIButton()
    var minimumDateToDate = Date()
    var maximumDateToDate = String()

    var arrguestDetails = GuestDetailsModify()

    
    
    var popover = Popover()
    //    let popover = Popover()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.commomColorCode()
        self.refreshControls()
        self.initFontForViews()
        
       
        
        }

    
    override func viewWillAppear(_ animated: Bool) {
        
        self.getGuestList(strSearch: "")
        UIBarButtonItem.appearance().tintColor = UIColor.white
        self.btnRequestGuestcard.setTitle(self.appDelegate.masterLabeling.rEQUEST_GUEST_CARD, for: .normal)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        UIBarButtonItem.appearance().tintColor = UIColor.white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIBarButtonItem.appearance().tintColor = UIColor.white
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "newDataToLoad"), object: nil)
    }
    
    func initFontForViews(){
        
        self.btnRequestGuestcard.titleLabel?.font = SFont.SourceSansPro_Semibold16
        self.btnRequestGuestcard.layer.cornerRadius = 20
        self.btnRequestGuestcard.layer.masksToBounds = true
        self.btnRequestGuestcard .setTitle(self.appDelegate.masterLabeling.rEQUEST_GUEST_CARD, for: .normal)
        
        
        self.btnRequestGuestcard.addTarget(self, action: #selector(btnRequestGuestCard), for: .touchUpInside)
        
        if (Network.reachability?.isReachable) == true{
             self.btnRequestGuestcard.isHidden = false
        }else{
            self.btnRequestGuestcard.isHidden = true

        }

        
        
        let btnPlus = UIButton.init(frame: CGRect(x: (self.btnRequestGuestcard.frame.size.width / 2) - 110 , y: (self.btnRequestGuestcard.frame.size.height - 30) / 2 , width: 30, height: 30))
        let icon_Radio_Selected = UIImage(named: CommonImages.addguest_icon)
        btnPlus .setImage(icon_Radio_Selected, for: .normal)
        
        self.btnRequestGuestcard.addSubview(btnPlus)
        self.btnRequestGuestcard.layer.cornerRadius = 20
        self.btnRequestGuestcard.layer.masksToBounds = true
        self.tblRequestcard.separatorColor = APPColor.celldividercolor.divider

        self.tblRequestcard.separatorInset = .zero
        self.tblRequestcard.layoutMargins = .zero
        self.tblRequestcard.allowsMultipleSelection = true
        self.tblRequestcard.tableFooterView = UIView()
        self.tblRequestcard.rowHeight = 60
        self.tblRequestcard.reloadData()
    }
    
  
    
    
    
    
    @objc func btnRequestGuestCard(_ sender: Any) {
        self.appDelegate.strguestresource = CommonString.krequest
        
        self.appDelegate.arrRequest.removeAll()
        
        for i in 0..<self.arrGuestList.count{
            let eventobj: Guest1
            eventobj = arrGuestList[i]
            if(eventobj.isSelected == true){
                self.appDelegate.arrRequest.append(eventobj)
            }
        }
        
        print(self.appDelegate.arrRequest.count)
        
        if(self.appDelegate.arrRequest.count>0){
            self.openpopoverController()
        }
        else{
            SharedUtlity.sharedHelper().showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.gUEST_REQUEST_ERROR, withDuration: Duration.kMediumDuration)
        }
        

        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let eventobj: Guest1
        eventobj = arrGuestList[indexPath.row]
        if eventobj.isSelected == true {
            eventobj.isSelected = false
        }
        else{
            eventobj.isSelected = true
        }
        
        arrGuestList.remove(at: indexPath.row)
        arrGuestList.insert(eventobj, at: indexPath.row)
        
        self.tblRequestcard.reloadData()
        
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrGuestList.count
    }
    
    
    

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        self.appDelegate.arrRequest.removeAll()
        
        for i in 0..<self.arrGuestList.count{
            let eventobj: Guest1
            eventobj = arrGuestList[i]
            if(eventobj.isSelected == true){
                self.appDelegate.arrRequest.append(eventobj)
            }
        }
        
        print(self.appDelegate.arrRequest.count)
        if identifier == "ModalViewController" &&  self.appDelegate.arrRequest.count > 0 { // you define it in the storyboard (click on the segue, then Attributes' inspector > Identifier
            
            return true
        }
        SharedUtlity.sharedHelper().showToast(on:
            self.view, withMeassge: self.appDelegate.masterLabeling.gUEST_REQUEST_ERROR, withDuration: Duration.kMediumDuration)
        return false
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        var segueID = segue.identifier
        
        self.appDelegate.arrRequest.removeAll()
        self.appDelegate.strguestresource = "Request"
        
        for i in 0..<self.arrGuestList.count{
            let eventobj: Guest1
            eventobj = arrGuestList[i]
            if(eventobj.isSelected == true){
                self.appDelegate.arrRequest.append(eventobj)
            }
        }
        
        self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: self, presentingViewController: segue.destination)
        segue.destination.modalPresentationStyle = .custom
        segue.destination.transitioningDelegate = self.halfModalTransitioningDelegate
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        
//        self.appDelegate.arrRequest.removeAll()
//        self.appDelegate.strguestresource = "Request"
//
//        for i in 0..<self.arrGuestList.count{
//            let eventobj: Guest
//            eventobj = arrGuestList[i]
//            if(eventobj.isSelected == true){
//                self.appDelegate.arrRequest.append(eventobj)
//            }
//        }
//        
//        if (self.appDelegate.arrRequest.count>0) {
//            self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: self, presentingViewController: segue.destination)
//            segue.destination.modalPresentationStyle = .custom
//            segue.destination.transitioningDelegate = self.halfModalTransitioningDelegate
//        }
//        else{
//            SharedUtlity.sharedHelper().showToast(on: self.view, withMeassge: self.appDelegate.masterLabeling.gUEST_REQUEST_ERROR, withDuration: Duration.kMediumDuration)
//        }
//        
//        
//    }
    
    
    
    //Mark- Common Color Code
    func commomColorCode()
    {
        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg
        self.btnRequestGuestcard.backgroundColor = APPColor.tintColor.tint
        self.btnRequestGuestcard.titleLabel?.textColor = APPColor.viewBgColor.viewbg
        
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isTranslucent = false
        
    }
    
    
    
    func getGuestList(strSearch :String){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.ksearchby : strSearch,
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            print("request\(paramaterDict)")
            
            APIHandler.sharedInstance.getGuestList(paramater: paramaterDict , onSuccess: { guestLists in
                self.appDelegate.hideIndicator()
                if(guestLists.responseCode == InternetMessge.kSuccess)
                {
                    if(guestLists.guestList == nil){
                        self.appDelegate.hideIndicator()
                        self.arrGuestList.removeAll()
                        self.tblRequestcard.setEmptyMessage(InternetMessge.kNoData)
                        self.tblRequestcard.reloadData()

                    }
                    else{
                        if(guestLists.guestList?.count == 0)
                        {
                            self.appDelegate.hideIndicator()

                             self.arrGuestList.removeAll()
                            self.tblRequestcard.setEmptyMessage(InternetMessge.kNoData)
                               self.tblRequestcard.reloadData()
                            
                        }else{
                        self.dictguest = guestLists
                        self.arrGuestList.removeAll()
                        self.tblRequestcard.restore()

                        self.arrGuestList = guestLists.guestList ?? []
                        self.tblRequestcard.reloadData()
                        }
                    }
                    
                }else{
                    self.appDelegate.hideIndicator()
                    self.tblRequestcard.setEmptyMessage(guestLists.responseMessage ?? "")
                    self.refreshControl.endRefreshing()

                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: guestLists.responseMessage, withDuration: Duration.kMediumDuration)
                }
                self.appDelegate.hideIndicator()
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                //    self.appDelegate.hideIndicator()
                print(error)
            })
            
            
        }else{
        //    self.tblRequestcard.setEmptyMessage(InternetMessge.kInternet_not_available)
            self.refreshControl.endRefreshing()

            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
    }
    

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCardTableViewCell", for: indexPath) as! RequestCardTableViewCell
      //  cell.backgroundColor = APPColor.viewBgColor.viewbg
        
        cell.textLabel?.font = SFont.SourceSansPro_Regular16
        let eventobj: Guest1
        eventobj = arrGuestList[indexPath.row]
        cell.textLabel?.text = eventobj.firstName! + " " + eventobj.lastName!
        cell.textLabel?.textColor = APPColor.textColor.text
    
        
        if eventobj.isSelected == true {
            cell.contentView.backgroundColor = APPColor.selectedcellColor.selectedcell
            cell.backgroundColor = APPColor.selectedcellColor.selectedcell
            let image = UIImage(named: CommonImages.member_selected) as UIImage?
            cell.btnIsCheck.setImage(image, for: .normal)
            cell.contentView.backgroundColor = APPColor.selectedcellColor.selectedcell
            cell.uiView.backgroundColor = APPColor.selectedcellColor.selectedcell
            
         

        }
        else{
            cell.contentView.backgroundColor = APPColor.viewBgColor.viewbg
            
            cell.backgroundColor = APPColor.viewBgColor.viewbg
           // cell.contentView.backgroundColor = .red
            let image = UIImage(named: CommonImages.member_unseleceted) as UIImage?
            cell.btnIsCheck.setImage(image, for: .normal)
            cell.contentView.backgroundColor = APPColor.viewBgColor.viewbg
            cell.uiView.backgroundColor = APPColor.viewBgColor.viewbg
            
           

        }
        
        cell.btnIsCheck.tag = indexPath.row
        cell.btnIsCheck .addTarget(self, action: #selector(didSelectRowItemAtIndex(_:)), for: .touchUpInside)
        
        
        
        return cell
    }
    
    @objc func didSelectRowItemAtIndex(_ sender:UIButton){
        
        let eventobj: Guest1
        eventobj = arrGuestList[sender.tag]
        if eventobj.isSelected == true {
            eventobj.isSelected = false
        }
        else{
            eventobj.isSelected = true
        }
        
        arrGuestList.remove(at: sender.tag)
        arrGuestList.insert(eventobj, at: sender.tag)
        
        self.tblRequestcard.reloadData()
    }
    
    //Mark - Refresh controls
    func refreshControls()
    {
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        self.tblRequestcard.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        getGuestList(strSearch : "")
        refreshControl.endRefreshing()
        
    }
    
    //MARK:- Right bar button Clicked
    func openpopoverController() {
        self.maximumDateToDate = ""
        let viewwidth:Double = Double(self.view.frame.width)
        let height:Double = Double(self.view.frame.height)
        
        let centerVale:Double = 0
        let startPoint = CGPoint(x: centerVale , y: height)
         self.aView = UIView(frame: CGRect(x: 0, y: centerVale, width: viewwidth, height: 155))
        self.aView.backgroundColor = .white
        
        var yAxis:Double
        //        var viewWidth:Double
        yAxis = 0.0
        let xAxis = 8.0
        
        //        let popoverHeight = Double(aView.frame.size.height)
        
        
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
        
        
        self.btnToDate.titleLabel?.font = SFont.SourceSansPro_Regular16
        self.btnFormDate.titleLabel?.font = SFont.SourceSansPro_Regular16
        
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
    
    
    @IBAction func requestIgnorePressed(_ sender: Any) {
        self.popover .dismiss()
    }
    
    //MARK:- Request Button Tapped
    @IBAction func requestButtonTapped(_ sender: Any) {
        if ((self.btnFormDate.titleLabel?.text == self.appDelegate.masterLabeling.hINT_FROM_DATE) || (self.btnToDate.titleLabel?.text == self.appDelegate.masterLabeling.hINT_TO_DATE)){
            SharedUtlity.sharedHelper().showToast(on:self.aView, withMeassge:self.appDelegate.masterLabeling.dATE_CANT_BE_EMPTY , withDuration: Duration.kMediumDuration)
        }
        else{
            if(self.appDelegate.arrRequest.count > 0){
                self.popover.dismiss()
                self.guestActionsApiMultiple()                
            }
            
        }
    }
    
    
    
    func guestActionsApiMultiple() -> Void {
        let prodArray:NSMutableArray = NSMutableArray()
        for item in self.appDelegate.arrRequest{
            let prod: NSMutableDictionary = NSMutableDictionary()
            prod.setValue("", forKey: APIKeys.kID)
            prod.setValue("", forKey: APIKeys.kTransactionID)
            prod.setValue(item.guestID, forKey: APIKeys.kLinkedMemberID)
            prodArray.add(prod)
        }
        
        
        
        // print(prodArray)
        
        let parameter:[String:Any] = [
            APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kguestid:  "",
            APIKeys.kAccompanyWithMainMember: 1 ,//self.appDelegate.dictGuestCardDetails.accompanyWithMainMember ?? "",
            APIKeys.kFromDate:self.btnFormDate.accessibilityHint ?? "",
            APIKeys.kToDate: self.btnToDate.accessibilityHint ?? "",
            APIKeys.kSelectedNumbers: prodArray,
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict]
        ]
        
        
        
        print(parameter)
        
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
                        self.appDelegate.isMoveToParentViewController = true
                        let transactionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RequestCardAccountSummaryViewController") as! RequestCardAccountSummaryViewController
                        transactionVC.arrguestdetails = self.arrguestDetails
                        self.navigationController?.pushViewController(transactionVC, animated: true)
                        self.appDelegate.hideIndicator()
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
                print(error)
                
            })
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kShortDuration)
        }
        
        
        
    }
    
    
    func setCardView(view : UIView){
        
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = 1;
        view.layer.shadowRadius = 2;
        view.layer.shadowOpacity = 0.5;
        
    }
    
    
    @objc func openToDatePicker(){
        
        var currentDate = Date()
        currentDate = self.minimumDateToDate
        UIBarButtonItem.appearance().tintColor = APPColor.navigationColor.barbackgroundcolor
        
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
            self.maximumDateToDate = myString
            UIBarButtonItem.appearance().tintColor = UIColor.white
            self.btnToDate .setTitle(myString, for: .normal)
            self.btnToDate.accessibilityHint = myString
            
            
        }, cancel: { (cancelPressed) in
            
        }, origin: self.view)
        
        self.actionSheetdatePicker.minimumDate = currentDate
        
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
                UIBarButtonItem.appearance().tintColor = UIColor.white
                self.btnFormDate .setTitle(myString, for: .normal)
                self.btnFormDate.accessibilityHint = myString
                
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
                UIBarButtonItem.appearance().tintColor = UIColor.white
                self.btnFormDate .setTitle(myString, for: .normal)
                self.btnFormDate.accessibilityHint = myString
                
            }, cancel: { (cancelPressed) in
                
            }, origin: self.view)
        }
    }

    
    
    //MARK: - Add Border to View -
    func addTopBorderWithColor(_ objView : UIView, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: objView.frame.size.width, height: width)
        objView.layer.addSublayer(border)
    }
}

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer();
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x:0, y:self.frame.height - thickness, width:self.frame.width, height:thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x:0, y:0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x:self.frame.width - thickness, y: 0, width: thickness, height:self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
    
}
