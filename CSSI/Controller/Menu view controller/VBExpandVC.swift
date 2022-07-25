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

    var actionSheetdatePicker: ActionSheetDatePicker!

    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var dictGuestCardDetails = GuestCard()

    var btnLoadPopview = UIButton()
    var dictguest = GuestList()

    
    @IBOutlet var myTableView: UITableView!
    var expandTableview:VBHeader = VBHeader()
    var rightCallButton = UIBarButtonItem()
    
    var btnFormDate = CustomUIButton()
    var btnToDate = CustomUIButton()
    
    
    
    var btnDoneDate = CustomDoneButton()
    var btnIgnoreDate = CustomDoneButton()
    var popover: Popover!
    
    
    var cell : VCExpandCell!
    var arrStatus:NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        
        self.btnLoadPopview = UIButton.init(frame:CGRect(x: 0, y: self.view.frame.height - 84, width: self.view.frame.size.width, height: 1))
        
        
        self.rightCallButton = UIBarButtonItem(image: UIImage(named: "Icon_Call"), style: .plain, target: self, action: #selector(searchBarButtonPressed))
        self.navigationItem.rightBarButtonItem = self.rightCallButton
        self.navigationItem.rightBarButtonItem?.tintColor = APPColor.loginBackgroundButtonColor.loginBtnBGColor
        
        
        
        
        
        
        
        
        
        let btnPlus = UIButton.init(frame: CGRect(x: (self.btnRequestGuestcard.frame.size.width / 2) - 110 , y: (self.btnRequestGuestcard.frame.size.height - 30) / 2 , width: 30, height: 30))
        let icon_Radio_Selected = UIImage(named: "ic_addguest")
        btnPlus .setImage(icon_Radio_Selected, for: .normal)
        
        self.btnRequestGuestcard.addSubview(btnPlus)
        self.btnRequestGuestcard.addTarget(self, action: #selector(btnRequestPressed(sender:)), for: .touchUpInside)

        
        initFontForViews()
        
        
        self.getGuestLists()
        
        
      
        self.myTableView.separatorInset = .zero
        self.myTableView.layoutMargins = .zero
        self.myTableView.rowHeight = 64
        self.myTableView.tableFooterView = UIView()
        
        
        //    self.myTableView?.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        self.myTableView?.reloadData()
        // Do any additional setup after loading the view.
    }
    
    

    
    
    func getGuestLists() -> Void {
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kdeviceInfo: APIHandler.devicedict
            ]
            
            
            
            APIHandler.sharedInstance.getGetGuestCardDetails(paramater: paramaterDict, onSuccess: { guestcardList in
                if(guestcardList.responseCode == InternetMessge.kSuccess)
                {
                    if(guestcardList.guestList == nil)
                    {
                        self.appDelegate.hideIndicator()

                    }else{
                    print(guestcardList.guestList!)
                    var arrGuestList = [GuestCard]()
                    arrGuestList = guestcardList.guestList!
                    self.dictGuestCardDetails = GuestCard()
                    for i in 0..<arrGuestList.count {
                        let dictGuest = arrGuestList[i]
                        if(dictGuest.guestID == self.guestID){
                            self.dictGuestCardDetails = dictGuest
                            print(dictGuest)
                            break;
                        }
                        
                    }
                    
                    if(self.dictGuestCardDetails.guestCardDetails == nil)
                    {
                        
                    }else{
//                    var arrGuestCardDetails
                    for j in 0..<(self.dictGuestCardDetails.guestCardDetails?.count)! {
                        print(j)
                        self.arrStatus.add("0")
                    }
//                    for j in 0..<self.dictGuestCardDetails.guestCardDetails?.count // pass your array count
//                    {
//                        self.arrStatus.add("0")
//                    }
                    
                        }
                    
                    self.myTableView.reloadData()
                    self.appDelegate.hideIndicator()
                    }
                }else{
                    self.appDelegate.hideIndicator()
                    CRIFutlity.sharedHelper().showToast(on:
                        self.view, withMeassge: guestcardList.responseMessage, withDuration: Duration.kMediumDuration)
                }
                
                self.appDelegate.hideIndicator()
                
            },onFailure: { error  in
                
                self.appDelegate.hideIndicator()
                print(error)
            })
            
            
        }else{
            
            CRIFutlity.sharedHelper().showToast(on:
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
        
        print(eventguest)
        
    }
    
    @objc func btnRequestPressed(sender:UIButton) -> Void {
       self.appDelegate.dictGuestCardDetails =  GuestCardDetail()
       self.appDelegate.guestID = ""
        
        self.appDelegate.guestID = guestID
        
     
        
    }
    
    
    
    
    @objc func cancelGuestOnClickIgnore(sender:UIButton) -> Void {
        
        
        print(sender.tag)
        
        var eventguest: GuestCardDetail
        eventguest = self.dictGuestCardDetails.guestCardDetails![sender.tag]
        
        
        if (Network.reachability?.isReachable) == true{
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kguestid: eventguest.guestCardId ,
                APIKeys.klinkedmemberid:eventguest.transactionDetailID,

                APIKeys.kdeviceInfo: APIHandler.devicedict
            ]
            
            if (Network.reachability?.isReachable) == true{
                self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
                
                APIHandler.sharedInstance.cancelGuestCardApi(paramaterDict:paramaterDict, onSuccess: { parentMemberinfo in
                    
                    if(parentMemberinfo.responseCode == "Success")
                    {
                        CRIFutlity.sharedHelper().showToast(on:
                            self.view, withMeassge: parentMemberinfo.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    
                    
                    
                    self.appDelegate.hideIndicator()

                   
                    
                  
                },onFailure: { error, responseCode  in
                    
                    print()
                    switch(responseCode.statusCode)
                    {
                    case 401:
                        CRIFutlity.sharedHelper().showToast(on:
                            self.view, withMeassge: ApiErrorMessages.kUnauthorized, withDuration: Duration.kMediumDuration)
                        break;
                    case 400:
                        CRIFutlity.sharedHelper().showToast(on:
                            self.view, withMeassge: ApiErrorMessages.kInvalidInput, withDuration: Duration.kMediumDuration)
                        break;
                    case 404:
                        CRIFutlity.sharedHelper().showToast(on:
                            self.view, withMeassge: ApiErrorMessages.kResourceNotFound, withDuration: Duration.kMediumDuration)
                        break;
                    case 408:
                        CRIFutlity.sharedHelper().showToast(on:
                            self.view, withMeassge: ApiErrorMessages.kRequestTimeout, withDuration: Duration.kMediumDuration)
                        break;
                    case 405:
                        CRIFutlity.sharedHelper().showToast(on:
                            self.view, withMeassge: ApiErrorMessages.kMethodNotAllowed, withDuration: Duration.kMediumDuration)
                        break;
                    case 500:
                        CRIFutlity.sharedHelper().showToast(on:
                            self.view, withMeassge: ApiErrorMessages.kInternalServerError, withDuration: Duration.kMediumDuration)
                        break;
                    case 505:
                        CRIFutlity.sharedHelper().showToast(on:
                            self.view, withMeassge: ApiErrorMessages.kHttpversionnotsupported, withDuration: Duration.kMediumDuration)
                        break;
                    default:
                        CRIFutlity.sharedHelper().showToast(on:
                            self.view, withMeassge: ApiErrorMessages.kInternalServerError, withDuration: Duration.kMediumDuration)
                        
                        
                    }
                    
                    
                    self.appDelegate.hideIndicator()
                    print(error)
                    
                })
            }else{
                
                CRIFutlity.sharedHelper().showToast(on:
                    self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            }
            
        
        }
    }
    
    
    
    
    func initFontForViews()
    {
        self.btnRequestGuestcard.titleLabel?.font = SFont.SourceSansPro_Semibold16
        self.btnRequestGuestcard.layer.cornerRadius = 20
        self.btnRequestGuestcard.layer.masksToBounds = true
        self.btnRequestGuestcard .setTitle("Request Guest Card", for: .normal)
        
        self.btnRequestGuestcard.layer.cornerRadius = 20
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        //navigation item labelcolor
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = guestName.trimmingCharacters(in: .whitespacesAndNewlines)
        self.navigationController?.navigationBar.backItem?.title = "Back"
        self.appDelegate.isMoveToParentViewController = false
        
        
        print("on view ")
        
    }
    
    
    @objc func searchBarButtonPressed() {
        //        let searchApplicationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ApplicationSearchViewController") as! ApplicationSearchViewController
        //        self.navigationController?.pushViewController(searchApplicationVC, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        expandTableview = Bundle.main.loadNibNamed("VBHeader", owner: self, options: nil)?[0] as! VBHeader
        
        let dictData = self.dictGuestCardDetails.guestCardDetails![section]
        print(dictData)
        expandTableview.lblDate.text = dictData.startDate! + " - " + dictData.endDate!
        expandTableview.lblStatus.text = dictData.guestCardStatus!
    //    expandTableview.lblStatus.text = dictData.guestCardStatus!

        
        expandTableview.btnExpand.tag = section
        expandTableview.btnExpand.addTarget(self, action: #selector(VBExpandVC.headerCellButtonTapped(_sender:)), for: UIControlEvents.touchUpInside)
        
        
        let str:String = arrStatus[section] as! String
        if str == "0"
        {
            UIView.animate(withDuration: 2) { () -> Void in
                self.expandTableview.imgArrow.image = UIImage(named :"ExpandDownArrow")
                let angle =  CGFloat(M_PI * 2)
                let tr = CGAffineTransform.identity.rotated(by: angle)
                self.expandTableview.imgArrow.transform = tr
            }
        }
        else
        {
            UIView.animate(withDuration: 2) { () -> Void in
                self.expandTableview.imgArrow.image = UIImage(named :"ExpandUpArrow")
                let angle =  CGFloat(M_PI * 2)
                let tr = CGAffineTransform.identity.rotated(by: angle)
                self.expandTableview.imgArrow.transform = tr
            }
        }
        
        return expandTableview
    }
    @objc func headerCellButtonTapped(_sender: UIButton)
    {
        let str:String = arrStatus[_sender.tag] as! String
        if str == "0"
        {
            arrStatus[_sender.tag] = "1"
            
        }
        else
        {
            arrStatus[_sender.tag] = "0"
        }
        myTableView.reloadData()
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
        
//        var eventguest: GuestCardDetail
//        eventguest = self.dictGuestCardDetails.guestCardDetails![indexPath.row]
//
//        print("eventguest: \(eventguest.endDate)")
//        print(eventguest.transactionDetailID)
//        print(eventguest.guestCardId)
//

        
        cell.btnModify.titleLabel?.font = SFont.SourceSansPro_Semibold16
        cell.btnModify.layer.cornerRadius = 20
        cell.btnModify.layer.masksToBounds = true
        
        cell.btnModify.setTitleColor(hexStringToUIColor(hex: "c8a773"), for: .normal)
        cell.btnModify.backgroundColor = hexStringToUIColor(hex: "ffffff")
        cell.btnModify.layer.borderColor = hexStringToUIColor(hex: "c8a773").cgColor
        cell.btnModify.layer.borderWidth = 2
        
        
        
        cell.btnignore.titleLabel?.font = SFont.SourceSansPro_Semibold16
        cell.btnignore.layer.cornerRadius = 20
        cell.btnignore.layer.masksToBounds = true
     
        
        cell.btnignore.setTitleColor(hexStringToUIColor(hex: "c8a773"), for: .normal)
        cell.btnignore.backgroundColor = hexStringToUIColor(hex: "ffffff")
        cell.btnignore.layer.borderColor = hexStringToUIColor(hex: "c8a773").cgColor
        cell.btnignore.layer.borderWidth = 2
        
        
        //  cell.btnModify.addTarget(self, action: #selector(btnModifyPressed(_:)), for: .touchUpInside)
        
        
        cell.btnignore.tag = indexPath.section;
        cell.btnignore.addTarget(self, action: #selector(cancelGuestOnClickIgnore(sender:)), for: .touchUpInside)
        
        cell.btnModify.tag = indexPath.section;
        cell.btnModify.addTarget(self, action: #selector(btnModifyPressedAtIndex(sender:)), for: .touchUpInside)
        
        

        
        
   //     cell.btnModify.addTarget(self, action: #selector(VBExpandVC.openPopoverOnClickModify(_sender:)), for: UIControlEvents.touchUpInside)
        
        
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
        return 111
    }
    

    @objc func btnModifyPressed(_ sender: UIButton) {
        //        let modelVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController
        //        self.navigationController?.pushViewController(modelVC, animated: true)
        
        //        self.present(modelVC, animated: true, completion: nil)
        let modalViewController = ModalViewController()
       
        modalViewController.modalPresentationStyle = .formSheet
        //        presentViewController(modalViewController, animated: true, completion: nil)
        self.present(modalViewController, animated: true, completion: nil)
        
        
        
        
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: self, presentingViewController: segue.destination)
        
        segue.destination.modalPresentationStyle = .custom
        segue.destination.transitioningDelegate = self.halfModalTransitioningDelegate
    }
    
    
    
    //MARK:- Open Popiver
    @objc func openPopoverOnClickModify(_sender: UIButton){
        
        //        let startPoint = CGPoint(x: self.view.frame.width - 0, y: self.view.frame.size.height - 100)
        //        let aView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 180))
        //        let popover = Popover()
        //        popover.show(aView, point: startPoint)
        //
        //
        
        let width = self.view.frame.width
        let aView = UIView(frame: CGRect(x: 2, y: 0, width: width-4, height: 250))
        
        self.btnFormDate = CustomUIButton.init(frame:CGRect(x: 10, y: 0, width: (width/2) - 20, height: 44) )
        self.btnFormDate.setTitle("Form Date", for: .normal)
        aView.addSubview(self.btnFormDate)
        let buttonArrowFormDate = UIButton.init()
        buttonArrowFormDate.frame = CGRect(x: self.btnFormDate.frame.size.width - 40, y: (self.btnFormDate.frame.size.height - 40)/2, width: 40, height: 40)
        let ic_forword = UIImage(named: "Icon_Logout")
        buttonArrowFormDate.setImage(ic_forword, for: .normal)
        self.btnFormDate .addSubview(buttonArrowFormDate)
        buttonArrowFormDate.addTarget(self, action: #selector(openToDatePicker), for: .touchUpInside)
        self.btnFormDate.addTarget(self, action: #selector(openToDatePicker), for: .touchUpInside)
        
        
        self.btnToDate = CustomUIButton.init(frame:CGRect(x: (width/2) + 10, y: 0, width: (width/2) - 20, height: 44) )
        self.btnToDate.setTitle("To Date", for: .normal)
        aView.addSubview(self.btnToDate)
        let buttonArrowToDate = UIButton.init()
        buttonArrowToDate.frame = CGRect(x: self.btnToDate.frame.size.width - 40, y: (self.btnToDate.frame.size.height - 40)/2, width: 40, height: 40)
        buttonArrowToDate.setImage(ic_forword, for: .normal)
        self.btnToDate .addSubview(buttonArrowToDate)
        buttonArrowToDate.addTarget(self, action: #selector(openToDatePicker), for: .touchUpInside)
        self.btnToDate.addTarget(self, action: #selector(openToDatePicker), for: .touchUpInside)
        
        
        self.btnDoneDate = CustomDoneButton.init(frame: CGRect(x: 20, y: aView.frame.size.height - 120, width: 150, height: 54))
        self.btnDoneDate.setTitle("DONE", for: .normal)
        self.btnDoneDate.setTitleColor(.white, for: .normal)
        self.btnDoneDate.backgroundColor = .brown
        self.btnDoneDate.addTarget(self, action: #selector(btnDonePressed), for: .touchUpInside)
        aView.addSubview(self.btnDoneDate)
        
        self.btnIgnoreDate = CustomDoneButton.init(frame: CGRect(x: aView.frame.size.width - 170, y: aView.frame.size.height - 120, width: 150, height: 54))
        self.btnIgnoreDate.setTitle("CANCEL", for: .normal)
        self.btnIgnoreDate.setTitleColor(.brown, for: .normal)
        self.btnIgnoreDate.backgroundColor = .white
        
        aView.addSubview(self.btnIgnoreDate)
        
        
        let options = [
            .type(.up),
            .cornerRadius(2),
            .animationIn(0.3),
            //            .blackOverlayColor(UIColor.lightGray),
            .arrowSize(CGSize.zero)
            ] as [PopoverOption]
         self.popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
        popover.show(aView, fromView: self.btnLoadPopview)
        
    }
    
    
    //MARK:- Open Date Picker
    @objc func openFormDatePicker(){
        
        self.actionSheetdatePicker = ActionSheetDatePicker()
        var localTimeZoneName: String { return TimeZone.current.identifier }
        
        let currentDate = Date()
        
        
        self.actionSheetdatePicker.timeZone = TimeZone.current
        self.actionSheetdatePicker.locale = Locale.init(identifier: "uk") //NSLocale.init(localeIdentifier: "it_IT") as Locale!
        self.actionSheetdatePicker.calendar = Calendar.current
        self.actionSheetdatePicker = ActionSheetDatePicker.show(withTitle: "", datePickerMode: .date, selectedDate: currentDate, minimumDate: nil, maximumDate: Date(), doneBlock: { (selectedDate, any, anydate ) in
            
        }, cancel: { (cancelPressed) in
            
            
            
        }, origin: self.view)
        
        let loc = Locale.init(identifier: "uk")
        var calendar = Calendar.current
        calendar.locale = loc
        self.actionSheetdatePicker.calendar = calendar
    }
    
    @objc func openToDatePicker(){
        
        self.actionSheetdatePicker = ActionSheetDatePicker()
        var localTimeZoneName: String { return TimeZone.current.identifier }
        
        let currentDate = Date()
        
        
        self.actionSheetdatePicker.timeZone = TimeZone.current
        self.actionSheetdatePicker.locale = Locale.init(identifier: "uk") //NSLocale.init(localeIdentifier: "it_IT") as Locale!
        self.actionSheetdatePicker.calendar = Calendar.current
        self.actionSheetdatePicker = ActionSheetDatePicker.show(withTitle: "", datePickerMode: .date, selectedDate: currentDate, minimumDate: nil, maximumDate: Date(), doneBlock: { (selectedDate, any, anydate ) in
            
        }, cancel: { (cancelPressed) in
            
            
            
        }, origin: self.view)
        
        let loc = Locale.init(identifier: "uk")
        var calendar = Calendar.current
        calendar.locale = loc
        self.actionSheetdatePicker.calendar = calendar
    }
    
    @objc func btnDonePressed(){
        self.popover .dismiss()
        
        let reqestVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RequestCardAccountSummaryViewController") as! RequestCardAccountSummaryViewController
        self.navigationController?.pushViewController(reqestVC, animated: true)
        
    }
    
}



extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

