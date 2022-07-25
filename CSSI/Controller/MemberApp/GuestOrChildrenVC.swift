//
//  GuestOrChildrenVC.swift
//  CSSI
//
//  Created by apple on 10/22/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit
protocol AddGuestChildren
{
    func AddGuestChildren(selecteArray: [RequestData])
    
}
class GuestOrChildrenVC: UIViewController {

    @IBOutlet weak var guestView: UIView!
    @IBOutlet weak var kid3BewloVIew: UIView!
    @IBOutlet weak var kids3Above: UIView!
    @IBOutlet weak var guestCountHeight: NSLayoutConstraint!
    @IBOutlet weak var guestTextHeight: NSLayoutConstraint!
    @IBOutlet weak var lblTopLabel: UILabel!
    @IBOutlet weak var viewMember: UIView!
    @IBOutlet weak var lblMeberName: UILabel!
    @IBOutlet weak var lblMemberID: UILabel!
    @IBOutlet weak var imgCheckBox: UIImageView!
    @IBOutlet weak var lblGuest: UILabel!
    @IBOutlet weak var lblKIds3below: UILabel!
    @IBOutlet weak var lblKids3above: UILabel!
    @IBOutlet weak var btnDecGuest: UIButton!
    @IBOutlet weak var btnIncGuest: UIButton!
    @IBOutlet weak var btnDecKids3Below: UIButton!
    @IBOutlet weak var btnIncKid3below: UIButton!
    @IBOutlet weak var btnDecKids3Above: UIButton!
    @IBOutlet weak var btnIncKid3Above: UIButton!
    @IBOutlet weak var lblGuestCount: UILabel!
    @IBOutlet weak var lblKid3BelowCount: UILabel!
    @IBOutlet weak var lblKid3AboveCount: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnCheckbox: UIButton!
    var memberArrayList = [Dictionary<String, Any>]()
    var arrEventPlayers = [RequestData]()
    var arrTempPlayers = [RequestData]()

    var eventID : String?
    var requestID : String?

    var eventRegId: String?
    var arrGuestCount = [String]()
    var arrKid3BelowCount = [String]()
    var arrKids3AboveCount = [String]()
    var isInclude: Int?
    var delegateGuestChildren: AddGuestChildren?
    var memberID: String?
    var iD: String?
    var parentID: String?
    var categoryForBuddy: String?
    var isAddToBuddy : Int?
    var isFrom: String?
    var memberName: String?
    var arrModifyData = [RequestData]()
    var totalNumberofTickets: Int?
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var showGuest: Int?
    var showKids: Int?
    var isSpousePresent: Int?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if showKids == 0{
            kid3BewloVIew.isHidden = true
            kids3Above.isHidden = true
            lblKIds3below.isHidden = true
            lblKids3above.isHidden = true
            
        }else{
            kid3BewloVIew.isHidden = false
            kids3Above.isHidden = false
            lblKIds3below.isHidden = false
            lblKids3above.isHidden = false
        }
        if showGuest == 0{
            guestView.isHidden = true
            guestCountHeight.constant = 0
            guestTextHeight.constant = 0
            lblGuest.isHidden = true
            
            if isSpousePresent == 0 {
                guestView.isHidden = false
                guestCountHeight.constant = 44
                guestTextHeight.constant = 44
                lblGuest.isHidden = false
            }else{
                guestView.isHidden = true
                guestCountHeight.constant = 0
                guestTextHeight.constant = 0
                lblGuest.isHidden = true
            }
        }else{
            guestView.isHidden = false
            guestCountHeight.constant = 44
            guestTextHeight.constant = 44
            lblGuest.isHidden = false
        }
       
        
        // Do any additional setup after loading the view.
        btnCheckbox.isUserInteractionEnabled = false
        btnAdd.backgroundColor = .clear
        btnAdd.layer.cornerRadius = 18
        btnAdd.layer.borderWidth = 1
        btnAdd.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        self.btnAdd.setStyle(style: .outlined, type: .primary)
        
        btnCancel.backgroundColor = .clear
        btnCancel.layer.cornerRadius = 18
        btnCancel.layer.borderWidth = 1
        btnCancel.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        self.btnCancel.setStyle(style: .outlined, type: .primary)
        isInclude = 1
        self.lblMeberName.text = memberName ?? ""
        self.lblMemberID.text = memberID ?? ""
        
        lblTopLabel.text = self.appDelegate.masterLabeling.mEMBERINCLUDETEXT
        lblGuest.text = self.appDelegate.masterLabeling.gUEST
        lblKids3above.text = self.appDelegate.masterLabeling.kIDS3ABOVE
        lblKIds3below.text = self.appDelegate.masterLabeling.kIDS3BELOW
        
        totalNumberofTickets = totalNumberofTickets! - 1
        
        let memberGesture = UITapGestureRecognizer(target: self, action:  #selector(self.memberClicked(sender:)))
        self.viewMember.addGestureRecognizer(memberGesture)
        if arrModifyData.count == 0 {}
        else{
            if arrModifyData[0] is MemberInfo {
                
                let guestObj = arrModifyData[0] as! MemberInfo
                self.memberName = guestObj.memberName
                self.iD = guestObj.id
                self.parentID = guestObj.parentid
                self.memberID = guestObj.memberID
                self.lblGuestCount.text = String(format: "%02d", guestObj.guest ?? 0)
                self.lblKid3BelowCount.text = String(format: "%02d", guestObj.kids3Below ?? 0)
                self.lblKid3AboveCount.text = String(format: "%02d", guestObj.kids3Above ?? 0)
                for _ in 0 ..< guestObj.guest! {
                    self.arrGuestCount.append("")
                    
                    if showGuest == 0{
                        if isSpousePresent == 0 {
                            if arrGuestCount.count == 1{
                                self.btnIncGuest.isEnabled = false
                            }
                        }
                    }
                }
                for _ in 0 ..< guestObj.kids3Below! {
                    self.arrKid3BelowCount.append("")
                }
                for _ in 0 ..< guestObj.kids3Above! {
                    self.arrKids3AboveCount.append("")
                }
                isInclude = guestObj.isInclude
                if guestObj.isInclude == 1 {
                    btnCheckbox.isSelected = true
                    btnCheckbox.setBackgroundImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                }else{
                    btnCheckbox.isSelected = false
                    btnCheckbox.setBackgroundImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                }
                self.lblMeberName.text = guestObj.memberName ?? ""
                self.lblMemberID.text = guestObj.memberID ?? ""
            }else if arrModifyData[0] is GuestChildren {
            
            let guestObj = arrModifyData[0] as! GuestChildren
            self.memberName = guestObj.name
            self.iD = guestObj.selectedID
            self.parentID = guestObj.parentID
            self.memberID = guestObj.memberId
            self.lblGuestCount.text = String(format: "%02d", guestObj.guestCount ?? 0)
            self.lblKid3BelowCount.text = String(format: "%02d", guestObj.kids3Below ?? 0)
            self.lblKid3AboveCount.text = String(format: "%02d", guestObj.kids3Above ?? 0)
            for _ in 0 ..< guestObj.guestCount! {
                self.arrGuestCount.append("")
                
                if showGuest == 0{
                    if isSpousePresent == 0 {
                        if arrGuestCount.count == 1{
                            self.btnIncGuest.isEnabled = false
                        }
                    }
                }
            }
            for _ in 0 ..< guestObj.kids3Below! {
                self.arrKid3BelowCount.append("")
            }
            for _ in 0 ..< guestObj.kids3Above! {
                self.arrKids3AboveCount.append("")
            }
            isInclude = guestObj.isInclude
            if guestObj.isInclude == 1 {
                btnCheckbox.isSelected = true
                btnCheckbox.setBackgroundImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
            }else{
                btnCheckbox.isSelected = false
                btnCheckbox.setBackgroundImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
            }
            self.lblMeberName.text = guestObj.name ?? ""
            self.lblMemberID.text = guestObj.memberId ?? ""
        }else if arrModifyData[0] is CaptaineInfo {
            
            let guestObj = arrModifyData[0] as! CaptaineInfo
            self.memberName = guestObj.captainName
            self.iD = UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? ""
            self.parentID = UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? ""
            self.memberID = UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? ""
            
            btnCheckbox.isSelected = true
            btnCheckbox.setBackgroundImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
           
            self.lblMeberName.text = guestObj.captainName ?? ""
            self.lblMemberID.text = "#" + guestObj.captainMemberID!
            }
        }
        if self.arrGuestCount.count == 0{
        btnDecGuest.isEnabled = false
        }
        if self.arrKids3AboveCount.count == 0{
        btnDecKids3Above.isEnabled = false
        }
        if self.arrKid3BelowCount.count == 0{
        btnDecKids3Below.isEnabled = false
        }
        if self.totalNumberofTickets == 0 || self.totalNumberofTickets == arrGuestCount.count + arrKids3AboveCount.count + arrKid3BelowCount.count {
            btnIncGuest.isEnabled = false
            btnIncKid3Above.isEnabled = false
            btnIncKid3below.isEnabled = false
        }
//        if self.totalNumberofTickets == self.arrGuestCount.count && self.isInclude == 0{
//            btnIncGuest.isEnabled = true
//        }
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        self.navigationItem.title = self.appDelegate.masterLabeling.gUESTORCHILD
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    @objc func memberClicked(sender : UITapGestureRecognizer) {
        
        if btnCheckbox.isSelected == false {
            
            guard (self.arrKids3AboveCount.count + self.arrKid3BelowCount.count + self.arrGuestCount.count) < self.totalNumberofTickets! else{
                return
            }
            
            btnCheckbox.isSelected = true
            btnCheckbox.setBackgroundImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
            isInclude = 1
            
            totalNumberofTickets = totalNumberofTickets! - 1

            if arrGuestCount.count + arrKids3AboveCount.count + arrKid3BelowCount.count == totalNumberofTickets{
                btnIncGuest.isEnabled = false
                btnIncKid3Above.isEnabled = false
                btnIncKid3below.isEnabled = false
            }
        }else{
            
            btnCheckbox.isSelected = false
            btnCheckbox.setBackgroundImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
            isInclude = 0
            totalNumberofTickets = totalNumberofTickets! + 1
            if arrGuestCount.count + arrKids3AboveCount.count + arrKid3BelowCount.count == totalNumberofTickets{
                btnIncGuest.isEnabled = false
                btnIncKid3Above.isEnabled = false
                btnIncKid3below.isEnabled = false
            }else{
                btnIncGuest.isEnabled = true
                btnIncKid3Above.isEnabled = true
                btnIncKid3below.isEnabled = true
                
            }
            if self.totalNumberofTickets == 0{
                btnIncGuest.isEnabled = true
                btnIncKid3Above.isEnabled = true
                btnIncKid3below.isEnabled = true
            }
            
              if showGuest == 0{
                if isSpousePresent == 0 {
                   if arrGuestCount.count == 1{
                        self.btnIncGuest.isEnabled = false
                    }
                }
            }
        }
    }
    
    @IBAction func GuestIncreaseClicked(_ sender: Any)
    {
        
        if isSpousePresent == 0 && showGuest == 0
        {
            //Added by kiran V2.8 -- ENGAGE0011878 -- fixed Member is able to add more than one guest to a single member in the below scenario.
            //ENGAGE0011878 -- Start
            
            if Int(self.lblGuestCount.text ?? "0") ?? 0 < 1
            {
                //ENGAGE0011878-- This is old logic just added the contdition to this logic
                btnDecGuest.isEnabled = true
                arrGuestCount.append("")
                btnIncGuest.isEnabled = false
                self.lblGuestCount.text = String(format: "%02d", arrGuestCount.count)
            }
            else
            {
                btnIncGuest.isEnabled = false
            }
            
            //ENGAGE0011878 -- End
           
        }
        else
        {
            if arrKids3AboveCount.count + arrKid3BelowCount.count + arrGuestCount.count == totalNumberofTickets! {
                btnIncKid3Above.isEnabled = false
                btnIncKid3below.isEnabled = false
                btnIncGuest.isEnabled = false

            }else{
        btnDecGuest.isEnabled = true
        
        arrGuestCount.append("")
            if arrGuestCount.count + arrKid3BelowCount.count + arrKids3AboveCount.count == totalNumberofTickets! {
                btnIncKid3Above.isEnabled = false
                btnIncKid3below.isEnabled = false
                btnIncGuest.isEnabled = false
                
            }
        
        self.lblGuestCount.text = String(format: "%02d", arrGuestCount.count)
            }
        }
    }
    
    @IBAction func kid3BelowClicked(_ sender: Any) {
        if arrKids3AboveCount.count + arrKid3BelowCount.count + arrGuestCount.count == totalNumberofTickets! {
            btnIncKid3Above.isEnabled = false
            btnIncKid3below.isEnabled = false
            btnIncGuest.isEnabled = false        }else{
        btnDecKids3Below.isEnabled = true
        
        arrKid3BelowCount.append("")
        if arrKid3BelowCount.count + arrGuestCount.count + arrKids3AboveCount.count  == totalNumberofTickets!{
            btnIncKid3Above.isEnabled = false
            btnIncKid3below.isEnabled = false
            btnIncGuest.isEnabled = false
            
            }
        self.lblKid3BelowCount.text = String(format: "%02d", arrKid3BelowCount.count)
        }
    }
    @IBAction func Kids3AboveClicked(_ sender: Any) {
        if arrKids3AboveCount.count + arrKid3BelowCount.count + arrGuestCount.count == totalNumberofTickets! {
            btnIncKid3Above.isEnabled = false
            btnIncKid3below.isEnabled = false
            btnIncGuest.isEnabled = false
            
        }else{
        btnDecKids3Above.isEnabled = true
        
        arrKids3AboveCount.append("")
        if arrKids3AboveCount.count + arrKid3BelowCount.count + arrGuestCount.count == totalNumberofTickets! {
            btnIncKid3Above.isEnabled = false
            btnIncKid3below.isEnabled = false
            btnIncGuest.isEnabled = false
            
            }
        self.lblKid3AboveCount.text = String(format: "%02d", arrKids3AboveCount.count)
        }}
    @IBAction func decreaseKids3BelowClicked(_ sender: Any) {
       
        
        arrKid3BelowCount.remove(at: 0)
        if arrKid3BelowCount.count == 0 {
            btnDecKids3Below.isEnabled = false
        }
        self.lblKid3BelowCount.text = String(format: "%02d", arrKid3BelowCount.count)
        
        if arrKids3AboveCount.count + arrKid3BelowCount.count + arrGuestCount.count == totalNumberofTickets! {
            btnIncKid3Above.isEnabled = false
            btnIncKid3below.isEnabled = false
            btnIncGuest.isEnabled = false
            
        }else{
            
            btnIncKid3Above.isEnabled = true
            btnIncKid3below.isEnabled = true
            btnIncGuest.isEnabled = true
        }
    }
    @IBAction func decreaseKids3Above(_ sender: Any) {
        
        arrKids3AboveCount.remove(at: 0)
        if arrKids3AboveCount.count == 0 {
            btnDecKids3Above.isEnabled = false
        }
        self.lblKid3AboveCount.text = String(format: "%02d", arrKids3AboveCount.count)
        if arrKids3AboveCount.count + arrKid3BelowCount.count + arrGuestCount.count == totalNumberofTickets! {
            btnIncKid3Above.isEnabled = false
            btnIncKid3below.isEnabled = false
            btnIncGuest.isEnabled = false
            
        }else{
        
        btnIncKid3Above.isEnabled = true
        btnIncKid3below.isEnabled = true
        btnIncGuest.isEnabled = true
        }
        
    }
    @IBAction func decreaseGuestClicked(_ sender: Any) {
        if isSpousePresent == 0 && showGuest == 0{
            btnIncGuest.isEnabled = true
            arrGuestCount.remove(at: 0)
            btnDecGuest.isEnabled = false
            
            
            self.lblGuestCount.text = String(format: "%02d", arrGuestCount.count)
        }else{
            btnIncGuest.isEnabled = true
            arrGuestCount.remove(at: 0)
            if arrGuestCount.count == 0 {
                btnDecGuest.isEnabled = false
            }
        if arrGuestCount.count == totalNumberofTickets{
            btnIncGuest.isEnabled = false
        }
        self.lblGuestCount.text = String(format: "%02d", arrGuestCount.count)
            
            if arrKids3AboveCount.count + arrKid3BelowCount.count + arrGuestCount.count == totalNumberofTickets! {
                btnIncKid3Above.isEnabled = false
                btnIncKid3below.isEnabled = false
                btnIncGuest.isEnabled = false
                
            }else{
                
                btnIncKid3Above.isEnabled = true
                btnIncKid3below.isEnabled = true
                btnIncGuest.isEnabled = true
            }
        }
    }
    @IBAction func addClicked(_ sender: Any) {
        
        self.memberValidation()
       // self.addGuestChildrens()
    }
    func addGuestChildrens(){
        if(isAddToBuddy == 1){
            if(isFrom == "BuddyList"){
                
            }
            else{
                self.AddtoBuddyList()
            }
        }
        let guestChildrenInfo = GuestChildren.init()
        guestChildrenInfo.setGuestChildrenInfo(MemberId: self.memberID ?? "", Name: self.memberName ?? "", id: self.iD ?? "", parentId: self.parentID ?? "", guest: self.arrGuestCount.count, kid3Above: self.arrKids3AboveCount.count, kids3Below: self.arrKid3BelowCount.count, isInclude: self.isInclude ?? 1, isSpouse:  isSpousePresent ?? 0)
        delegateGuestChildren?.AddGuestChildren(selecteArray: [guestChildrenInfo])
        
        for controller in self.navigationController!.viewControllers as Array {
            
            if controller.isKind(of: RegisterEventVC.self) {
                // delegateGuestChildren?.AddGuestChildren(selecteArray: [guestChildrenInfo])
                
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
            
            
        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    //MARK:- MemberValidations API
    func memberValidation(){
        self.arrTempPlayers.removeAll()
        self.memberArrayList.removeAll()
        self.arrTempPlayers = self.arrEventPlayers

        if (Network.reachability?.isReachable) == true{
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            for i in 0 ..< arrTempPlayers.count {
                if  arrTempPlayers[i] is CaptaineInfo {
                    let playObj = arrTempPlayers[i] as! CaptaineInfo
                    let memberInfo:[String: Any] = [
                        APIKeys.kMemberId : playObj.captainMemberID ?? "",
                        APIKeys.kid : playObj.captainID ?? "",
                        APIKeys.kParentId : playObj.captainParentID ?? "",
                        "MemberName" : playObj.captainName ?? "",
                        "Guest": 0,
                        "Kids3Below": 0,
                        "Kids3Above": 0,
                        "IsInclude": 1,
                        "IsPrimaryMember": 0,
                        "DisplayOrder": i + 1
                    ]
                    memberArrayList.append(memberInfo)
                    
                }else if arrTempPlayers[i] is GuestChildren {
                    let playObj = arrTempPlayers[i] as! GuestChildren
                    
                    let memberInfo :[String: Any] = [
                        APIKeys.kMemberId : playObj.memberId ?? "",
                        APIKeys.kid : playObj.selectedID ?? "",
                        APIKeys.kParentId : playObj.parentID ?? "",
                        "MemberName" : playObj.name ?? "",
                        "Guest": playObj.guestCount ?? 0,
                        "Kids3Below": playObj.kids3Below ?? 0,
                        "Kids3Above": playObj.kids3Above ?? 0,
                        "IsInclude": playObj.isInclude ?? 1,
                        "IsPrimaryMember": 0,
                        "DisplayOrder": i + 1
                    ]
                    memberArrayList.append(memberInfo)
                }
                else if arrTempPlayers[i] is MemberInfo {
                    let playObj = arrTempPlayers[i] as! MemberInfo
                    let memberInfo :[String: Any] = [
                        APIKeys.kMemberId : playObj.memberID ?? "",
                        APIKeys.kid : playObj.id ?? "",
                        APIKeys.kParentId : playObj.parentid ?? "",
                        "MemberName" : playObj.memberName ?? "",
                        "Guest": playObj.guest ?? 0,
                        "Kids3Below": playObj.kids3Below ?? 0,
                        "Kids3Above": playObj.kids3Above ?? 0,
                        "IsInclude": playObj.isInclude ?? 1,
                        "IsPrimaryMember": 0,
                        "DisplayOrder": i + 1
                    ]
                    memberArrayList.append(memberInfo)
                    
                }
            }
            let memberInfo:[String: Any] = [
                APIKeys.kMemberId : self.memberID ?? "",
                APIKeys.kid : self.iD ?? "",
                APIKeys.kParentId : self.parentID ?? "",
                "IsPrimaryMember": "0",
                "Kids3Below": self.arrKid3BelowCount.count,
                "Kids3Above": self.arrKids3AboveCount.count,
                "IsInclude": self.isInclude ?? 1,
                "Guest": self.arrGuestCount.count,
                "IsReservation": "0",
                
                ]
            memberArrayList.append(memberInfo)
            
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                "Role": UserDefaults.standard.string(forKey: UserDefaultsKeys.role.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "IsEvent": "1",
                "EventRegistrationID": self.eventRegId!,
                "EventID": eventID ?? "",
                "MemberList": memberArrayList,
                "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue) ?? "",
                "IsReservation": "0",
                "ReservationType": "",
                "RegistrationID": requestID ?? ""

            ]
            
            
            
            print("memberdict \(paramaterDict)")
                APIHandler.sharedInstance.getMemberValidation(paramater: paramaterDict, onSuccess: { (response) in
                    self.appDelegate.hideIndicator()

                    
                    if response.responseCode == InternetMessge.kFail {
                        SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                    }else{
                        self.addGuestChildrens()

                    }
                    
                }) { (error) in
                    SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
                    self.appDelegate.hideIndicator()
                }
    }
        else{
            
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            
        }
    }

    //MARK:- AddToBuddy List Api
    func AddtoBuddyList(){
        if (Network.reachability?.isReachable) == true{
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            let buddyInfo:[String: Any] = [
                APIKeys.kMemberId : self.memberID ?? "",
                APIKeys.kid :  self.iD ?? "",
                APIKeys.kParentId : self.parentID ?? "",
                "Category": self.categoryForBuddy ?? ""
            ]
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "AddBuddy" : buddyInfo,
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            
            print("memberdict \(paramaterDict)")
            APIHandler.sharedInstance.addToBuddyList(paramaterDict: paramaterDict, onSuccess: { memberLists in
                self.appDelegate.hideIndicator()
                
                
                if(memberLists.responseCode == InternetMessge.kSuccess)
                {
                    self.appDelegate.hideIndicator()
                    
                    
                }else{
                    self.appDelegate.hideIndicator()
                    if(((memberLists.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: memberLists.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                }
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
            
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            
        }
    }
    

}
