//
//  AddMemberVC.swift
//  CSSI
//
//  Created by apple on 5/11/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//



import UIKit
protocol AddMemberDelegate
{
    func addMemberDelegate(selecteArray: [RequestData])
    
}
class AddMemberVC: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var heightBottom: NSLayoutConstraint!
    @IBOutlet weak var heightGuestView: NSLayoutConstraint!
    @IBOutlet weak var heightOnlyGuestView: NSLayoutConstraint!
    @IBOutlet weak var heightOtherText: NSLayoutConstraint!
    @IBOutlet weak var heightSpecialOccassionView: NSLayoutConstraint!
    @IBOutlet weak var btnDecreaseHighChair: UIButton!
    @IBOutlet weak var btnDecreaseBooster: UIButton!
    @IBOutlet weak var lblBooster: UILabel!
    @IBOutlet weak var lblHighChair: UILabel!
    @IBOutlet weak var searchBarAddmember: UISearchBar!
    @IBOutlet weak var lbladdASpecialRequest: UILabel!
    @IBOutlet weak var btnHighChair: UIButton!
    @IBOutlet weak var btnBooster: UIButton!
    @IBOutlet weak var lblAddASpecialOccassion: UILabel!
    @IBOutlet weak var btnAnniversary: UIButton!
    @IBOutlet weak var btnBirthday: UIButton!
    @IBOutlet weak var btnOther: UIButton!
    @IBOutlet weak var lblShouldWeBeaware: UILabel!
    @IBOutlet weak var txtSpecify: UITextView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var txtOther: UITextView!
    @IBOutlet weak var btnAddToMyBuddy: UIButton!
    @IBOutlet weak var viewAddMyBuddy: UIView!
    var memberName: String?
    var SelectedMemberInfo = [RequestData]()
    var arrSpecialOccasion = [RequestData]()
    var membersData =  [RequestData]()
    var arrTempPlayers = [RequestData]()
    var selectedDate: String?
    var partyList = [Dictionary<String, Any>]()
    var requestID : String?

    var isFrom: String?
    var forDiningEvent: String?
    var isAddToBuddy : Int?
    var memberID: String?
    var iD: String?
    var parentID: String?
    var memberFirstName: String?
    var memberProfilePic: String?
    
    var guestName: String?
    var guestEmail: String?
    var guestContact: String?
    var guetType: String?
    var guestBuddyListID: String?

    var other: Int?
    var birthDay: Int?
    var anniversary: Int?
    var type : String?
    
    var boosterValue: Int?
    var highChairValue: Int?
    var selectedData : String?
    var arrBooster = [String]()
    var arrHighChair = [String]()
    var delegateAddMember: AddMemberDelegate?
    var memberDelegate: MemberViewControllerDelegate?
    var arrDiningDetails = [RequestTeeTimeDetail]()
    var arrTotalList = [RequestData]()
    var diningInfo = DiningMemberInfo.init()
    var eventID : String?
    
    //Added on 15th October 2020 V2.3
    var preferedSpaceDetailId : String?
    var selectedTime : String?

    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    //Added by kiran V2.5 -- ENGAGE0011372 --
    //ENGAGE0011372 -- Start
    var guestFirstName : String?
    var guestLastName : String?
    var guestDOB: String?
    var gustGender : String?
    //ENGAGE0011372 -- ENd
   // let ids = array.map { $0.id }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnHighChair.setTitle(self.appDelegate.masterLabeling.hIGH_CHAIR, for: UIControlState.normal)
        self.btnBooster.setTitle(self.appDelegate.masterLabeling.bOOSTER_SEAT, for: UIControlState.normal)
        self.lblAddASpecialOccassion.text = self.appDelegate.masterLabeling.aDD_SPECIAL_OCCASSION_COLON
        self.btnBirthday.setTitle(self.appDelegate.masterLabeling.bIRTHDAY, for: UIControlState.normal)
        self.btnAnniversary.setTitle(self.appDelegate.masterLabeling.aNNIVERSARY, for: UIControlState.normal)
        self.btnOther.setTitle(self.appDelegate.masterLabeling.oTHER, for: UIControlState.normal)
        self.lbladdASpecialRequest.text = self.appDelegate.masterLabeling.special_request_add
        self.lblShouldWeBeaware.text = self.appDelegate.masterLabeling.dIETARY_RESTRICTIONS_INFO

        if isFrom == "Modify"{
            
         if arrTotalList[0] is GroupDetail {
            let guestObj = arrTotalList[0] as! GroupDetail
             searchBarAddmember.text = guestObj.name
            
           if  guestObj.highchair == 0 {
            highChairValue = 0
            arrHighChair.append("")
           }else{
            self.lblHighChair.text = String(format: "%02d", guestObj.highchair ?? 1)
            btnHighChair.isSelected = true
            btnHighChair.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
            for _ in 0 ..< guestObj.highchair! {
                self.arrHighChair.append("")
            }
            }
            if  guestObj.boosterCount == 0 {
                boosterValue = 0
                arrBooster.append("")
            }else{
            self.lblBooster.text = String(format: "%02d", guestObj.boosterCount ?? 1)
            btnBooster.isSelected = true
            btnBooster.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
            for _ in 0 ..< guestObj.boosterCount! {
                self.arrBooster.append("")
            }
            }
            if arrSpecialOccasion[0] is GroupDetail {
                let guestObj = arrSpecialOccasion[0] as! GroupDetail
                print(guestObj.birthDay!)
            
            if guestObj.birthDay == 0{
                birthDay = 0
                btnBirthday.isSelected = false
                btnBirthday.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                
            }else if guestObj.birthDay == 1{
                btnBirthday.isSelected = true
                btnBirthday.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                 birthDay = 1
            }
            if guestObj.anniversary == 0{
                btnAnniversary.isSelected = false
                btnAnniversary.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                anniversary = 0
            }else if guestObj.anniversary == 1{
                btnAnniversary.isSelected = true
                btnAnniversary.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                 anniversary = 1
            }
            if guestObj.other == 0{
                btnOther.isSelected = false
                btnOther.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                other = 0
                self.heightOtherText.constant = -117
                self.heightSpecialOccassionView.constant = 173
                self.txtOther.isHidden = true
            }else if guestObj.other == 1{
                btnOther.isSelected = true
                btnOther.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                other = 1
                self.heightOtherText.constant = 97
                self.txtOther.isHidden = false
                self.heightSpecialOccassionView.constant = 290
                txtOther.layer.cornerRadius = 6
                txtOther.layer.borderWidth = 1
                txtOther.layer.borderWidth = 0.25
                txtOther.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
            }
            txtOther.text = guestObj.otherText ?? ""
            }
            self.txtSpecify.text = guestObj.dietary ?? ""
            memberID = guestObj.memberID
            iD = guestObj.id
            memberName = guestObj.name
            
        }else if arrTotalList[0] is DiningMemberInfo {
            let memberObj = arrTotalList[0] as! DiningMemberInfo
            searchBarAddmember.text = memberObj.name
            
            if  memberObj.highChairCount == 0 {
                arrHighChair.append("")
                highChairValue = 0
            }else{
                self.lblHighChair.text = String(format: "%02d", memberObj.highChairCount ?? 1)
                btnHighChair.isSelected = true
                btnHighChair.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                for _ in 0 ..< memberObj.highChairCount! {
                    self.arrHighChair.append("")
                }
            }
            
            if  memberObj.boosterChairCount == 0 {
                arrBooster.append("")
                boosterValue = 0

            }else{
                self.lblBooster.text = String(format: "%02d", memberObj.boosterChairCount ?? 1)
                btnBooster.isSelected = true
                btnBooster.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                for _ in 0 ..< memberObj.boosterChairCount! {
                    self.arrBooster.append("")
                }
            }
            
            if memberObj.birthDay == 0{
                birthDay = 0
                btnBirthday.isSelected = false
                btnBirthday.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                
            }else if memberObj.birthDay == 1{
                btnBirthday.isSelected = true
                btnBirthday.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                birthDay = 1
            }
            if memberObj.anniversary == 0{
                btnAnniversary.isSelected = false
                btnAnniversary.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                anniversary = 0
            }else if memberObj.anniversary == 1{
                btnAnniversary.isSelected = true
                btnAnniversary.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                anniversary = 1
            }
            if memberObj.other == 0{
                btnOther.isSelected = false
                btnOther.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                other = 0
                self.heightOtherText.constant = -117
                self.heightSpecialOccassionView.constant = 173
                self.txtOther.isHidden = true
            }else if memberObj.other == 1{
                btnOther.isSelected = true
                btnOther.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                other = 1
                txtOther.layer.cornerRadius = 6
                txtOther.layer.borderWidth = 1
                txtOther.layer.borderWidth = 0.25
                txtOther.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
            }
            txtOther.text = memberObj.otherText ?? ""
                
            self.txtSpecify.text = memberObj.dietaryRestrictions ?? ""
            memberID = memberObj.memberId
            iD = memberObj.linkedMemberID
            memberName = memberObj.name
        
        }else {
            searchBarAddmember.text = ""
        }
        }else if isFrom == "View"{
            if arrTotalList[0] is GroupDetail {
                let guestObj = arrTotalList[0] as! GroupDetail
                searchBarAddmember.text = guestObj.name
                
                if  guestObj.highchair == 0 {
                    highChairValue = 0
                    arrHighChair.append("")
                }else{
                    self.lblHighChair.text = String(format: "%02d", guestObj.highchair ?? 1)
                    btnHighChair.isSelected = true
                    btnHighChair.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    for _ in 0 ..< guestObj.highchair! {
                        self.arrHighChair.append("")
                    }
                }
                if  guestObj.boosterCount == 0 {
                    boosterValue = 0
                }else{
                    self.lblBooster.text = String(format: "%02d", guestObj.boosterCount ?? 1)
                    btnBooster.isSelected = true
                    btnBooster.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    for _ in 0 ..< guestObj.boosterCount! {
                        self.arrBooster.append("")
                    }
                }
                if arrSpecialOccasion[0] is GroupDetail {
                    let guestObj = arrSpecialOccasion[0] as! GroupDetail
                    print(guestObj.birthDay!)
                    
                    if guestObj.birthDay == 0{
                        birthDay = 0
                        btnBirthday.isSelected = false
                        btnBirthday.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                        
                    }else if guestObj.birthDay == 1{
                        btnBirthday.isSelected = true
                        btnBirthday.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                        birthDay = 1
                    }
                    if guestObj.anniversary == 0{
                        btnAnniversary.isSelected = false
                        btnAnniversary.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                        anniversary = 0
                    }else if guestObj.anniversary == 1{
                        btnAnniversary.isSelected = true
                        btnAnniversary.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                        anniversary = 1
                    }
                    if guestObj.other == 0{
                        btnOther.isSelected = false
                        btnOther.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                        other = 0
                        self.heightOtherText.constant = -117
                        self.heightSpecialOccassionView.constant = 173
                        self.txtOther.isHidden = true
                    }else if guestObj.other == 1{
                        btnOther.isSelected = true
                        btnOther.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                        other = 1
                        self.heightOtherText.constant = 97
                        self.txtOther.isHidden = false
                        self.heightSpecialOccassionView.constant = 290
                        txtOther.layer.cornerRadius = 6
                        txtOther.layer.borderWidth = 1
                        txtOther.layer.borderWidth = 0.25
                        txtOther.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
                    }
                    txtOther.text = guestObj.otherText ?? ""
                }
                self.txtSpecify.text = guestObj.dietary ?? ""
                memberID = guestObj.memberID
                iD = guestObj.id
                memberName = guestObj.name
                
            }else if arrTotalList[0] is DiningMemberInfo {
                let memberObj = arrTotalList[0] as! DiningMemberInfo
                searchBarAddmember.text = memberObj.name
                
                if  memberObj.highChairCount == 0 {
                    arrBooster.append("")
                }else{
                    self.lblHighChair.text = String(format: "%02d", memberObj.highChairCount ?? 1)
                    btnHighChair.isSelected = true
                    btnHighChair.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    for _ in 0 ..< memberObj.highChairCount! {
                        self.arrHighChair.append("")
                    }
                }
                
                if  memberObj.boosterChairCount == 0 {
                    
                }else{
                    self.lblBooster.text = String(format: "%02d", memberObj.boosterChairCount ?? 1)
                    btnBooster.isSelected = true
                    btnBooster.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                    for _ in 0 ..< memberObj.boosterChairCount! {
                        self.arrBooster.append("")
                    }
                }
                    if memberObj.birthDay == 0{
                        birthDay = 0
                        btnBirthday.isSelected = false
                        btnBirthday.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                        
                    }else if memberObj.birthDay == 1{
                        btnBirthday.isSelected = true
                        btnBirthday.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                        birthDay = 1
                    }
                    if memberObj.anniversary == 0{
                        btnAnniversary.isSelected = false
                        btnAnniversary.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                        anniversary = 0
                    }else if memberObj.anniversary == 1{
                        btnAnniversary.isSelected = true
                        btnAnniversary.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                        anniversary = 1
                    }
                    if memberObj.other == 0{
                        btnOther.isSelected = false
                        btnOther.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
                        other = 0
                        self.heightOtherText.constant = -117
                        self.heightSpecialOccassionView.constant = 173
                        self.txtOther.isHidden = true
                    }else if memberObj.other == 1{
                        btnOther.isSelected = true
                        btnOther.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
                        other = 1
                        txtOther.layer.cornerRadius = 6
                        txtOther.layer.borderWidth = 1
                        txtOther.layer.borderWidth = 0.25
                        txtOther.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
                    }
                    txtOther.text = memberObj.otherText ?? ""
                
                self.txtSpecify.text = memberObj.dietaryRestrictions ?? ""
                
            }else {
                searchBarAddmember.text = ""
            }
            
            
            self.viewMain.isUserInteractionEnabled = false
           self.bottomView.isHidden = true
            self.heightBottom.constant = 0
        }
        else{
           
            highChairValue = 0
            boosterValue = 0
            other = 0
            birthDay = 0
            anniversary = 0
            searchBarAddmember.text = self.selectedData ?? ""
            btnDecreaseHighChair.isEnabled = false
            btnDecreaseBooster.isEnabled = false
            arrBooster.append("")
            arrHighChair.append("")
            
            self.heightOtherText.constant = -117
            self.heightSpecialOccassionView.constant = 173
            self.txtOther.isHidden = true
        }
       
        
       
        
        searchBarAddmember.setImage(UIImage(), for: .clear, state: .normal)
        searchBarAddmember.isUserInteractionEnabled = false
        self.navigationItem.title = self.appDelegate.masterLabeling.add_member
        searchBarAddmember.searchBarStyle = .default
        
        searchBarAddmember.layer.borderWidth = 1
        searchBarAddmember.layer.borderColor = hexStringToUIColor(hex: "F5F5F5").cgColor
        
        txtSpecify.layer.cornerRadius = 6
        txtSpecify.layer.borderWidth = 1
        txtSpecify.layer.borderWidth = 0.25
        txtSpecify.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
        
        btnAdd.backgroundColor = .clear
        btnAdd.layer.cornerRadius = 18
        btnAdd.layer.borderWidth = 1
        btnAdd.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        
        
        
        btnCancel.backgroundColor = .clear
        btnCancel.layer.cornerRadius = 18
        btnCancel.layer.borderWidth = 1
        btnCancel.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        
        self.btnAdd.setStyle(style: .outlined, type: .primary)
        self.btnCancel.setStyle(style: .outlined, type: .primary)
        
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
        
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        
            self.heightGuestView?.constant = heightSpecialOccassionView.constant + 460
           self.heightOnlyGuestView?.constant = heightSpecialOccassionView.constant + 460
        
       
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func boosterClicked(_ sender: Any) {
        if btnBooster.isSelected == false {
            btnBooster.isSelected = true
            boosterValue = 1
            btnBooster.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
        }else {
            btnBooster.isSelected = false
            btnBooster.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
            boosterValue = 0
        }
    }
    @IBAction func highChair(_ sender: Any) {
        if btnHighChair.isSelected == false {
            btnHighChair.isSelected = true
            highChairValue = 1
             btnHighChair.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
        }else {
            btnHighChair.isSelected = false
            highChairValue = 0
            btnHighChair.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
        }
        
    }
    @IBAction func highDecreased(_ sender: Any) {
        if arrHighChair.count == 1 {
            btnDecreaseHighChair.isEnabled = false
        }
        else{
            arrHighChair.remove(at: 0)
            if arrHighChair.count == 1 {
                btnDecreaseHighChair.isEnabled = false
            }
        }
        self.lblHighChair.text = String(format: "%02d", arrHighChair.count)
        
    }
    @IBAction func highCharIncreased(_ sender: Any) {
        btnDecreaseHighChair.isEnabled = true
        
        arrHighChair.append("")
        
        self.lblHighChair.text = String(format: "%02d", arrHighChair.count)
        

    }
    
    @IBAction func boosterIncreased(_ sender: Any) {
        btnDecreaseBooster.isEnabled = true
        
        arrBooster.append("")

        self.lblBooster.text = String(format: "%02d", arrBooster.count)

    }
    @IBAction func boosterDecreased(_ sender: Any) {
        if arrBooster.count == 1 {
            btnDecreaseBooster.isEnabled = false
        }
        else{
            arrBooster.remove(at: 0)
            if arrBooster.count == 1 {
                btnDecreaseBooster.isEnabled = false
            }
        }
        self.lblBooster.text = String(format: "%02d", arrBooster.count)
        
    }
 
    @IBAction func birthDayClicked(_ sender: Any) {
        
        if btnBirthday.isSelected == false {
            btnBirthday.isSelected = true
            btnBirthday.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
            birthDay = 1
            
        }else {
            btnBirthday.isSelected = false
            btnBirthday.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
            birthDay = 0
        }
        
    }
    @IBAction func anniversaryClicked(_ sender: Any) {
        if btnAnniversary.isSelected == false {
            btnAnniversary.isSelected = true
            btnAnniversary.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
            anniversary = 1
        }else {
            btnAnniversary.isSelected = false
            btnAnniversary.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
            anniversary = 0
        }
    }
    @IBAction func otherClicked(_ sender: Any) {
        if btnOther.isSelected == false {
            btnOther.isSelected = true
            btnOther.setImage(UIImage(named : "Group 2130"), for: UIControlState.normal)
            self.heightOtherText.constant = 97
            self.txtOther.isHidden = false
            self.heightSpecialOccassionView.constant = 290
            txtOther.layer.cornerRadius = 6
            txtOther.layer.borderWidth = 1
            txtOther.layer.borderWidth = 0.25
            txtOther.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
            other = 1
            

        }else {
            btnOther.isSelected = false
            btnOther.setImage(UIImage(named : "CheckBox_uncheck"), for: UIControlState.normal)
            self.heightOtherText.constant = -117
            self.txtOther.isHidden = true
            self.heightSpecialOccassionView.constant = 173
            other = 0

        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
   
    
    func AddtoBuddyList(){
        if (Network.reachability?.isReachable) == true{
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
           
            let buddyInfo:[String: Any] = [
                APIKeys.kMemberId : memberID ?? "",
                APIKeys.kid :  iD ?? "",
                APIKeys.kParentId : parentID ?? "",
                "Category": self.appDelegate.categoryForBuddy
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
                    
                    
//                    SharedUtlity.sharedHelper().showToast(on:
//                        self.view, withMeassge: memberLists.responseCode, withDuration: Duration.kMediumDuration)
//                    
                    
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
    
    @IBAction func addClicked(_ sender: Any) {
        if boosterValue == 0 {
            self.arrBooster.removeAll()
        }
        if highChairValue == 0 {
            self.arrHighChair.removeAll()
        }
        
        
        if type == "Guest"{
       
            let guestInfo = GuestInfo.init()
            //Added by kiran V2.8 -- ENGAGE0011784 -- modified to include first and last names, linkedMemberID and guestMemberNo
            //ENGAGE0011784 -- Start
            guestInfo.setGuestDetails(name: self.guestName ?? "", firstName: self.guestFirstName ?? "", lastName: self.guestLastName ?? "",linkedMemberID: "", guestMemberOf: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",guestMemberNo: "", gender : self.gustGender ?? "", DOB: self.guestDOB ?? "", buddyID: self.guestBuddyListID ?? "" , type: self.guetType ?? "", phone: self.guestContact ?? "", primaryemail: self.guestEmail ?? "", guestLinkedMemberID: "", highChair: self.arrHighChair.count, booster: self.arrBooster.count, dietary: self.txtSpecify.text, addGuestAsBuddy: isAddToBuddy ?? 0, otherNo: other ?? 0 , otherTextInformation: txtOther.text, birthdayNo: birthDay ?? 0, anniversaryNo: anniversary ?? 0)
            //ENGAGE0011784 -- End
            
            for controller in self.navigationController!.viewControllers as Array {
                if forDiningEvent == "DiningEvent"{
                    if controller.isKind(of: DiningEventRegistrationVC.self) {
                        delegateAddMember?.addMemberDelegate(selecteArray: [guestInfo])
                        
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }else{
                if controller.isKind(of: DiningRequestVC.self) {
                    delegateAddMember?.addMemberDelegate(selecteArray: [guestInfo])
                    
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
                }
            }
        }else{
            diningInfo.setDiningMemberDetails(MemberId:memberID ?? "", firstName: self.memberFirstName ?? "", Name: memberName ?? "", profilePic: self.memberProfilePic ?? "", id: iD ?? "", parentID: parentID ?? "", highChair: self.arrHighChair.count, booster: self.arrBooster.count, dietary: self.txtSpecify.text, otherNo: other ?? 0 , otherTextInformation: txtOther.text, birthdayNo: birthDay ?? 0, anniversaryNo: anniversary ?? 0)
            
             if forDiningEvent == "DiningEvent"{
                self.membersData.append(diningInfo)

                self.DiningEventDuplicate()
             }else{
                self.membersData.append(diningInfo)
                self.DiningReservationDuplicate()
            }
           
        }
        
       
       
       
        
        
    }
    func DiningEventDuplicate(){
        arrTempPlayers.removeAll()
        partyList.removeAll()
        
        arrTempPlayers = membersData
        membersData.removeLast()
        if (Network.reachability?.isReachable) == true{
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            for i in 0 ..< arrTempPlayers.count {
                
                if arrTempPlayers[i] is CaptaineInfo {
                    let specialOccassionInfo:[String: Any] = [
                        "Birthday":0,
                        "Anniversary":0,
                        "Other":0,
                        "OtherText":""
                    ]
                    
                    let memberInfo:[String: Any] = [
                        "ReservationRequestDetailId": "",
                        "LinkedMemberID": UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "HighChairCount": 0,
                        "BoosterChairCount": 0,
                        "SpecialOccasion": [specialOccassionInfo],
                        "DietaryRestrictions": "",
                        "DisplayOrder": 1,
                        "AddBuddy": 0
                    ]
                    partyList.append(memberInfo)
                }
                else if arrTempPlayers[i] is DiningMemberInfo {
                    let playObj = arrTempPlayers[i] as! DiningMemberInfo
                    let specialOccassionInfo:[String: Any] = [
                        "Birthday": playObj.birthDay ?? 0,
                        "Anniversary": playObj.anniversary ?? 0,
                        "Other": playObj.other ?? 0,
                        "OtherText": playObj.otherText ?? ""
                    ]
                    
                    let memberInfo:[String: Any] = [
                        "ReservationRequestDetailId": "",
                        "LinkedMemberID": playObj.linkedMemberID ?? "",
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "HighChairCount": playObj.highChairCount ?? 0,
                        "BoosterChairCount": playObj.boosterChairCount ?? 0,
                        "SpecialOccasion": [specialOccassionInfo],
                        "DietaryRestrictions": playObj.dietaryRestrictions ?? 0,
                        "DisplayOrder": i + 1,
                        "AddBuddy": 0
                    ]
                    partyList.append(memberInfo)
                }
                else if arrTempPlayers[i] is GuestInfo
                {
                    let playObj = arrTempPlayers[i] as! GuestInfo
                    
                    let specialOccassionInfo:[String: Any] = [
                        "Birthday": playObj.birthDay ?? 0,
                        "Anniversary": playObj.anniversary ?? 0,
                        "Other": playObj.other ?? 0,
                        "OtherText": playObj.otherText ?? ""
                    ]
                    //For existing guest only details sent for member are required.Used same object for guest and existing guest as other details a not considered in backend
                    let memberInfo:[String: Any] = [
                        "ReservationRequestDetailId": "",
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        "LinkedMemberID": playObj.linkedMemberID ?? "",
                        //ENGAGE0011784 -- End
                        "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                        "GuestType": playObj.guestType ?? "",
                        "GuestName": playObj.guestName ?? "",
                        "GuestEmail": playObj.email ?? "",
                        "GuestContact": playObj.cellPhone ?? "",
                        "HighChairCount": playObj.highChairCount ?? 0,
                        "BoosterChairCount": playObj.boosterChairCount ?? 0,
                        "SpecialOccasion": [specialOccassionInfo],
                        "DietaryRestrictions": playObj.dietaryRestrictions ?? 0,
                        "DisplayOrder": i + 1,
                        "AddBuddy": playObj.addToMyBuddy ?? 0,
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                        APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                        APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                        APIKeys.kGuestGender : playObj.guestGender ?? ""
                        //ENGAGE0011784 -- End
                        
                    ]
                    partyList.append(memberInfo)
                }
                else if arrTempPlayers[i] is GroupDetail
                {
                    let playObj = arrTempPlayers[i] as! GroupDetail
                    
                    //Added by kiran V2.8 -- ENGAGE0011784 -- Added support for existing guest.
                    //ENGAGE0011784 -- Start
                    let memberType = CustomFunctions.shared.memberType(details: playObj, For: .diningEvents)
                    
                    if memberType == .guest//playObj.id == nil
                    {
                        arrSpecialOccasion = playObj.specialOccasion!
                        let playObj2 = arrSpecialOccasion[0] as! GroupDetail
                        let specialOccassionInfo:[String: Any] = [
                            "Birthday": playObj2.birthDay ?? 0,
                            "Anniversary": playObj2.anniversary ?? 0,
                            "Other": playObj2.other ?? 0,
                            "OtherText": playObj2.otherText ?? ""
                        ]
                        let memberInfo:[String: Any] = [
                            "LinkedMemberID": "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailId!,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                            "GuestType": playObj.guestType ?? "",
                            "GuestName": playObj.guestName ?? "",
                            "GuestEmail": playObj.email ?? "",
                            "GuestContact": playObj.cellPhone ?? "",
                            "HighChairCount": playObj.highchair ?? 0,
                            "BoosterChairCount": playObj.boosterCount ?? 0,
                            "SpecialOccasion": [specialOccassionInfo],
                            "DietaryRestrictions": playObj.dietary ?? "",
                            "DisplayOrder": i + 1,
                            "AddBuddy": playObj.addBuddy ?? 0,
                            //Added by kiran V2.8 -- ENGAGE0011784 --
                            //ENGAGE0011784 -- Start
                            APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                            APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                            APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                            APIKeys.kGuestGender : playObj.guestGender ?? ""
                            //ENGAGE0011784 -- End
                        ]
                        partyList.append(memberInfo)
                        
                    }
                    else if memberType == .existingGuest
                    {
                        arrSpecialOccasion = playObj.specialOccasion!
                        let playObj2 = arrSpecialOccasion[0] as! GroupDetail
                        let specialOccassionInfo:[String: Any] = [
                            "Birthday": playObj2.birthDay ?? 0,
                            "Anniversary": playObj2.anniversary ?? 0,
                            "Other": playObj2.other ?? 0,
                            "OtherText": playObj2.otherText ?? ""
                        ]
                        
                        let memberInfo:[String: Any] = [
                            "LinkedMemberID": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailId!,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "HighChairCount": playObj.highchair ?? 0,
                            "BoosterChairCount": playObj.boosterCount ?? 0,
                            "SpecialOccasion": [specialOccassionInfo],
                            "DietaryRestrictions": playObj.dietary ?? "",
                            "DisplayOrder": i + 1,
                            "AddBuddy": playObj.addBuddy ?? 0
                        ]
                        //TODO:- Remove after approval
                        /*
                        let memberInfo:[String: Any] = [
                            "LinkedMemberID": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailId!,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                            "GuestType": playObj.guestType ?? "",
                            "GuestName": playObj.guestName ?? "",
                            "GuestEmail": playObj.email ?? "",
                            "GuestContact": playObj.cellPhone ?? "",
                            "HighChairCount": playObj.highchair ?? 0,
                            "BoosterChairCount": playObj.boosterCount ?? 0,
                            "SpecialOccasion": [specialOccassionInfo],
                            "DietaryRestrictions": playObj.dietary ?? "",
                            "DisplayOrder": i + 1,
                            "AddBuddy": playObj.addBuddy ?? 0,
                            APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                            APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                            APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                            APIKeys.kGuestGender : playObj.guestGender ?? ""
                        ]*/
                        partyList.append(memberInfo)
                    }
                    else if memberType == .member
                    {
                        arrSpecialOccasion = playObj.specialOccasion!
                        let playObj2 = arrSpecialOccasion[0] as! GroupDetail
                        let specialOccassionInfo:[String: Any] = [
                            "Birthday": playObj2.birthDay ?? 0,
                            "Anniversary": playObj2.anniversary ?? 0,
                            "Other": playObj2.other ?? 0,
                            "OtherText": playObj2.otherText ?? ""
                        ]
                        let memberInfo:[String: Any] = [
                            "LinkedMemberID": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailId!,
                            "GuestMemberOf": "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "HighChairCount": playObj.highchair ?? 0,
                            "BoosterChairCount": playObj.boosterCount ?? 0,
                            "SpecialOccasion": [specialOccassionInfo],
                            "DietaryRestrictions": playObj.dietary ?? "",
                            "DisplayOrder": i + 1,
                            "AddBuddy": 0
                        ]
                        partyList.append(memberInfo)
                    }
                    
                    //ENGAGE0011784 -- End
                }
                
            }
           
       let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "RequestId": requestID ?? "",
                "ReservationRequestDate": selectedDate ?? "",
                "ReservationRequestTime": "",
                "PartySize": "",
                "Comments": "",
                "DiningDetails" : partyList,
                "EventID":eventID ?? "",
                //Modified on 15th october 2020 V2.3
                "PreferedSpaceDetailId": self.preferedSpaceDetailId ?? "",
                "IsReservation": "0",
                "IsEvent": "1",
                "ReservationType": "",
                "RegistrationID": requestID ?? ""
                
            ]
         
            print("memberdict \(paramaterDict)")
            APIHandler.sharedInstance.getMemberValidation(paramater: paramaterDict, onSuccess: { (response) in
                
                self.appDelegate.hideIndicator()
                
                if response.responseCode == InternetMessge.kFail {
                    SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                }else{
                    
                    if(self.isAddToBuddy == 1){
                        self.AddtoBuddyList()
                    }
                for controller in self.navigationController!.viewControllers as Array {
                    
                        if controller.isKind(of: DiningEventRegistrationVC.self) {
                            self.delegateAddMember?.addMemberDelegate(selecteArray: [self.diningInfo])
                            self.navigationController!.popToViewController(controller, animated: true)
                            break
                        }
                    
                    
                }
                }
                
            }) { (error) in
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
                self.appDelegate.hideIndicator()
            }
            
        }
    }
    
    
    
    func DiningReservationDuplicate(){
        arrTempPlayers.removeAll()
        partyList.removeAll()
        
        arrTempPlayers = membersData
        membersData.removeLast()
        if (Network.reachability?.isReachable) == true{
            
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            for i in 0 ..< arrTempPlayers.count {
                if  arrTempPlayers[i] is CaptaineInfo {
                    let playObj = arrTempPlayers[i] as! CaptaineInfo
                    
                    let memberInfo:[String: Any] = [
                        "ReservationRequestDetailId": "",
                        "LinkedMemberID": playObj.captainID ?? "",
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "HighChairCount": 0,
                        "BoosterChairCount": 0,
                        "SpecialOccasion": [],
                        "DietaryRestrictions": "",
                        "DisplayOrder": i + 1,
                        "AddBuddy": 0
                    ]
                    partyList.append(memberInfo)
                    
                }
                    
                else if arrTempPlayers[i] is DiningMemberInfo {
                    let playObj = arrTempPlayers[i] as! DiningMemberInfo
                    
                    let memberInfo:[String: Any] = [
                        "ReservationRequestDetailId": "",
                        "LinkedMemberID": playObj.linkedMemberID ?? "",
                        "GuestMemberOf": "",
                        "GuestType": "",
                        "GuestName": "",
                        "GuestEmail": "",
                        "GuestContact": "",
                        "HighChairCount": playObj.highChairCount ?? 0,
                        "BoosterChairCount": playObj.boosterChairCount ?? 0,
                        "SpecialOccasion": [],
                        "DietaryRestrictions": playObj.dietaryRestrictions ?? 0,
                        "DisplayOrder": i + 1,
                        "AddBuddy": 0
                    ]
                    partyList.append(memberInfo)
                }
                else if arrTempPlayers[i] is GuestInfo
                {
                    let playObj = arrTempPlayers[i] as! GuestInfo
                    //For existing guest only details sent for member are required.Used same object for guest and existing guest as other details a not considered in backend
                    let memberInfo:[String: Any] = [
                        "ReservationRequestDetailId": "",
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        "LinkedMemberID": playObj.linkedMemberID ?? "",
                        //ENGAGE0011784 -- End
                        "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                        "GuestType": playObj.guestType ?? "",
                        "GuestName": playObj.guestName ?? "",
                        "GuestEmail": playObj.email ?? "",
                        "GuestContact": playObj.cellPhone ?? "",
                        "HighChairCount": playObj.highChairCount ?? 0,
                        "BoosterChairCount": playObj.boosterChairCount ?? 0,
                        "SpecialOccasion": [],
                        "DietaryRestrictions": playObj.dietaryRestrictions ?? 0,
                        "DisplayOrder": i + 1,
                        "AddBuddy": playObj.addToMyBuddy ?? 0,
                        //Added by kiran V2.8 -- ENGAGE0011784 --
                        //ENGAGE0011784 -- Start
                        APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                        APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                        APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                        APIKeys.kGuestGender : playObj.guestGender ?? ""
                        //ENGAGE0011784 -- End
                        
                    ]
                    partyList.append(memberInfo)
                }
                else if arrTempPlayers[i] is GroupDetail
                {
                    let playObj = arrTempPlayers[i] as! GroupDetail
                    
                    //Added by kiran V2.8 -- ENGAGE0011784 -- Added support for existing guest.
                    //ENGAGE0011784 -- Start
                    let memberType = CustomFunctions.shared.memberType(details: playObj, For: .dining)
                    
                    if memberType == .guest//playObj.id == nil
                    {
                        
                        let memberInfo:[String: Any] = [
                            "LinkedMemberID": "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailId!,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                            "GuestType": playObj.guestType ?? "",
                            "GuestName": playObj.guestName ?? "",
                            "GuestEmail": playObj.email ?? "",
                            "GuestContact": playObj.cellPhone ?? "",
                            "HighChairCount": playObj.highchair ?? 0,
                            "BoosterChairCount": playObj.boosterCount ?? 0,
                            "SpecialOccasion": [],
                            "DietaryRestrictions": playObj.dietary ?? "",
                            "DisplayOrder": i + 1,
                            "AddBuddy": playObj.addBuddy ?? 0,
                            //Added by kiran V2.8 -- ENGAGE0011784 --
                            //ENGAGE0011784 -- Start
                            APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                            APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                            APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                            APIKeys.kGuestGender : playObj.guestGender ?? ""
                            //ENGAGE0011784 -- End
                        ]
                        
                        partyList.append(memberInfo)
                    }
                    else if memberType == .existingGuest
                    {
                        
                        let memberInfo:[String: Any] = [
                            "LinkedMemberID": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailId!,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "HighChairCount": playObj.highchair ?? 0,
                            "BoosterChairCount": playObj.boosterCount ?? 0,
                            "SpecialOccasion": [],
                            "DietaryRestrictions": playObj.dietary ?? "",
                            "DisplayOrder": i + 1,
                            "AddBuddy": playObj.addBuddy ?? 0
                        ]
                        
                        //TODO:- Remove after approval
                        /*
                        let memberInfo:[String: Any] = [
                            "LinkedMemberID": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailId!,
                            "GuestMemberOf": playObj.guestMemberOf ?? "",//UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                            "GuestType": playObj.guestType ?? "",
                            "GuestName": playObj.guestName ?? "",
                            "GuestEmail": playObj.email ?? "",
                            "GuestContact": playObj.cellPhone ?? "",
                            "HighChairCount": playObj.highchair ?? 0,
                            "BoosterChairCount": playObj.boosterCount ?? 0,
                            "SpecialOccasion": [],
                            "DietaryRestrictions": playObj.dietary ?? "",
                            "DisplayOrder": i + 1,
                            "AddBuddy": playObj.addBuddy ?? 0,
                            APIKeys.kGuestFirstName : playObj.guestFirstName ?? "",
                            APIKeys.kGuestLastName : playObj.guestLastName ?? "",
                            APIKeys.kGuestDOB : playObj.guestDOB ?? "",
                            APIKeys.kGuestGender : playObj.guestGender ?? ""
                        ]*/
                        
                        partyList.append(memberInfo)
                    }
                    else if memberType == .member
                    {
                        
                        let memberInfo:[String: Any] = [
                            "LinkedMemberID": playObj.id ?? "",
                            "ReservationRequestDetailId": playObj.reservationRequestDetailId!,
                            "GuestMemberOf": "",
                            "GuestType": "",
                            "GuestName": "",
                            "GuestEmail": "",
                            "GuestContact": "",
                            "HighChairCount": playObj.highchair ?? 0,
                            "BoosterChairCount": playObj.boosterCount ?? 0,
                            "SpecialOccasion": [],
                            "DietaryRestrictions": playObj.dietary ?? "",
                            "DisplayOrder": i + 1,
                            "AddBuddy": 0
                        ]
                        partyList.append(memberInfo)
                    }
                    
                    //ENGAGE0011784 -- End
                }
            }
            
            
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                "RequestId": requestID ?? "",
                "ReservationRequestDate": selectedDate ?? "",
                //Added by kiran V2.8 -- ENGAGE0011784 --
                //ENGAGE0011784 -- Start
                "ReservationRequestTime": self.selectedTime ?? "",
                //ENGAGE0011784 -- End
                "PartySize": "",
                "Earliest": "",
                "Latest": "",
                "Comments": "",
                //Modified on 15th october 2020 V2.3
                "PreferedSpaceDetailId": self.preferedSpaceDetailId ?? "" ,
                "TablePreference": "",
                "DiningDetails" : partyList,
                "IsReservation": "1",
                "IsEvent": "0",
                "ReservationType": "Dining",
                "RegistrationID": requestID ?? ""
            ]
            
            print("memberdict \(paramaterDict)")
            APIHandler.sharedInstance.getMemberValidation(paramater: paramaterDict, onSuccess: { (response) in
                
                self.appDelegate.hideIndicator()
               
                if response.responseCode == InternetMessge.kFail {
                    SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.brokenRules?.fields?[0], withDuration: Duration.kMediumDuration)
                }else{
                    
                    if(self.isAddToBuddy == 1){
                        self.AddtoBuddyList()
                    }
                for controller in self.navigationController!.viewControllers as Array {
                    
                  
                        if controller.isKind(of: DiningRequestVC.self) {
                            self.delegateAddMember?.addMemberDelegate(selecteArray: [self.diningInfo])
                            self.navigationController!.popToViewController(controller, animated: true)
                            break
                        }
                    
                    
                }
                }
                
            }) { (error) in
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
                self.appDelegate.hideIndicator()
            }
            
        }
    }
    
}
