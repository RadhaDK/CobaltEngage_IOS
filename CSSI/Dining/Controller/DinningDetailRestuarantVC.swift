//
//  DinningDetailRestuarantVC.swift
//  CSSI
//
//  Created by Aks on 03/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit



class DinningDetailRestuarantVC: UIViewController, UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, selectedSlotFor, MemberViewControllerDelegate, AddMemberDelegate {

    
    
    //MARK: - IBOutlets
    @IBOutlet weak var tblGuest: UITableView!
    @IBOutlet weak var imgRestuarant: UIImageView!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var collectionAddSpecialRequest: UICollectionView!
    @IBOutlet weak var heightSpecialRequestCollection: NSLayoutConstraint!
    @IBOutlet weak var txtReservationComment: UITextView!
    @IBOutlet weak var heightTblGuest: NSLayoutConstraint!
    @IBOutlet weak var heightViewBackSpecialRequest: NSLayoutConstraint!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPartySize: UILabel!
    @IBOutlet weak var btnAddMultiple: UIButton!
    @IBOutlet weak var imgRestaurantImage: UIImageView!
    
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var lblCaptainName: UILabel!
    
    
    //MARK: - variables
    var arrBookedSlotMember = ["Lia Little"]
    var arrSpecialRequest = ["Behind lounge area","Close to enterance","Outside","On the Perimeter"]
    var showNavigationBar = true
    var restaurantName = ""
    var diningReservation = DinningReservationFCFS()
    var MeberInfoModel = [ResrvationPartyDetail]()
    var restaurantImage  : String!
    var arrMembers = String()
    var diningRequestMode = ""
    var selectedIndex = -1
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var isFrom: typeComingFrom = .listing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setUpUi()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = !self.showNavigationBar
    }
    
    //MARK: - Initial Setup
    
    func initialSetup() {
        if isFrom == .listing {
            self.setupDefaultMemberValues()
        }
        
    }
    
    func setUpUi(){
//        imgRestuarant.layer.cornerRadius = 8
        txtReservationComment.layer.borderWidth = 1
        txtReservationComment.layer.borderColor = UIColor.lightGray.cgColor
        txtReservationComment.layer.cornerRadius = 8
        btnSubmit.layer.cornerRadius = btnSubmit.layer.frame.height/2
        btnAddMultiple.layer.cornerRadius = btnAddMultiple.layer.frame.height/2
        btnAddMultiple.layer.borderWidth = 1
        btnAddMultiple.layer.borderColor = UIColor(red: 59/255, green: 135/255, blue: 193/255, alpha: 1).cgColor
        btnHome.setTitle("", for: .normal)
        btnBack.setTitle("", for: .normal)
        lblPartySize.text = String(format: "%02d", self.diningReservation.PartySize)
        lblTime.text = self.diningReservation.SelectedTime
        lblRestaurantName.text = self.restaurantName
        let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: imgRestaurantImage.frame.size.width, height: imgRestaurantImage.frame.size.height))
        overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
        imgRestaurantImage.addSubview(overlay)
        
        self.imgRestuarant.image = convertBase64StringToImage(imageBase64String: restaurantImage)
        
        setUpUiInitialization()
    }
    func setUpUiInitialization(){
        collectionAddSpecialRequest.delegate = self
        collectionAddSpecialRequest.dataSource  = self
        tblGuest.delegate = self
        tblGuest.dataSource  = self
        configSlotMemberCollectionHeight()
        configSlotMemberTblHeight()
    }
    //MARK: - IBOutlets
    @IBAction func btnSubmit(_ sender: Any) {
        
    }
    
    @IBAction func btnAddMultiple(_ sender: Any) {
        let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DiningAddMemberGuestPopUpVC") as? DiningAddMemberGuestPopUpVC
        vc?.delegateSelectedMemberType = self
        vc?.checkPopupOpenFrom = .multiple
        self.navigationController?.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func btnHome(_ sender: Any) {
        let homeVC = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Functions
    
    func setupDefaultMemberValues() {
        if diningRequestMode == "" {
            if self.diningReservation.PartySize > 1 {
                for _ in 0...self.diningReservation.PartySize-1 {
                    self.diningReservation.PartyDetails.append(ResrvationPartyDetail.init())
                }
            } else {
                self.diningReservation.PartyDetails.append(ResrvationPartyDetail.init())
            }
            self.getLoggedInUserInfo()
        } else {
            
        }
    }

    func configSlotMemberTblHeight(){
        if self.diningReservation.PartySize == 0{
            heightTblGuest.constant = 0
        }
        else{
            let NumberOfSlot = self.diningReservation.PartySize
            let numberOfLines = NumberOfSlot ?? 0 + 1
            heightTblGuest.constant = CGFloat(60*numberOfLines)
        }
        tblGuest.reloadData()
    }

    func configSlotMemberCollectionHeight(){
        if arrSpecialRequest.count == 0{
            heightSpecialRequestCollection.constant = 0
            heightViewBackSpecialRequest.constant = 0
        }
        else{
            let numberOfLines = (arrSpecialRequest.count/2)+1
            heightSpecialRequestCollection.constant = CGFloat(35*numberOfLines)
            heightViewBackSpecialRequest.constant = 70 + CGFloat(35*numberOfLines)
        }
        collectionAddSpecialRequest.reloadData()
    }
    
    func diningMemberInfoToResrvationPartyDetail(memberInfo: DiningMemberInfo) -> ResrvationPartyDetail {
        let partyMemberInfo = ResrvationPartyDetail()
        partyMemberInfo.setPartyDetails(memberID: memberInfo.id ?? "", memberName: memberInfo.name ?? "", diet: memberInfo.dietaryRestrictions ?? "", anniversary: memberInfo.anniversary ?? 0, birthday: memberInfo.birthDay ?? 0, other: memberInfo.other ?? 0, otherText: memberInfo.otherText ?? "", highChair: memberInfo.highChairCount ?? 0, boosterChair: memberInfo.boosterChairCount ?? 0)
        return partyMemberInfo
    }

    func guestInfoToResrvationPartyDetail(memberInfo: GuestInfo) -> ResrvationPartyDetail {
        let partyMemberInfo = ResrvationPartyDetail()
        partyMemberInfo.setPartyDetails(memberID: "", memberName: memberInfo.guestName ?? "", diet: "", anniversary: memberInfo.anniversary ?? 0, birthday: memberInfo.birthDay ?? 0, other: memberInfo.other ?? 0, otherText: memberInfo.otherText ?? "", highChair: memberInfo.highChairCount ?? 0, boosterChair: memberInfo.boosterChairCount ?? 0)
        return partyMemberInfo
    }
    
    func setCaptainWithDefaultValues() {
        let partyMemberInfo = ResrvationPartyDetail()
        partyMemberInfo.setPartyDetails(memberID: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "", memberName: UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue) ?? "", diet: "", anniversary: 0, birthday: 0, other: 0, otherText: "", highChair: 0, boosterChair: 0)
        self.diningReservation.PartyDetails[0] = partyMemberInfo
    }
    
    
    //MARK: - Custom delegate methods
    func addingMemberType(value: String, type: poupOpenFrom) {
        if value == "Guest" {
            if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddGuestRegVC") as? AddGuestRegVC
            {
                regGuest.memberDelegate = self
                regGuest.screenType = .add
                regGuest.usedForModule = .dining
                regGuest.showExistingGuestsOption = true
                regGuest.isDOBHidden = false
                regGuest.isGenderHidden = false
                regGuest.enableGuestNameSuggestions = true
                regGuest.hideAddtoBuddy = false
                regGuest.hideExistingGuestAddToBuddy = false
//                regGuest.requestTime = self.txtReservationtime.text ?? ""
//                regGuest.requestDates = [self.reservationRequestDate ?? ""]
//                regGuest.preferedSpaceDetailId = self.preferedSpaceDetailID ?? ""
//                regGuest.requestID = self.requestID ?? ""
//                regGuest.arrAddedMembers = [self.arrTotalList]
                navigationController?.pushViewController(regGuest, animated: true)
            }
        } else {
            if let memberDirectory = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MemberDirectoryViewController") as? MemberDirectoryViewController
            {
                if value == "Member"{
                    memberDirectory.isFrom = "Registration"
                } else {
                    memberDirectory.isFrom = "BuddyList"
                }
                
                if type == .multiple {
                    memberDirectory.totalNumberofTickets = self.diningReservation.PartySize - 1
                    memberDirectory.shouldEnableMultiSelect = true
                    memberDirectory.shouldEnableSkipping = true
                    
                    memberDirectory.arrMultiSelectedMembers.append(self.diningReservation.PartyDetails)
                }
                memberDirectory.categoryForBuddy = "Dining"
                memberDirectory.isOnlyFor = "DiningRequest"
                memberDirectory.delegate = self
                navigationController?.pushViewController(memberDirectory, animated: true)
            }
        }
    }
    
    // MARK: - Table Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return self.diningReservation.PartySize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblGuest.dequeueReusableCell(withIdentifier: "AddGuestTableCell", for: indexPath) as! AddGuestTableCell
        
        
        if self.diningReservation.PartyDetails[indexPath.row].MemberName == "" {
            cell.lblSlotMember.text = "Reservation"
            cell.lblSlotMember.textColor = .gray
        } else {
            cell.lblSlotMember.text = self.diningReservation.PartyDetails[indexPath.row].MemberName
            cell.lblSlotMember.textColor = .systemBlue
        }
        
        if indexPath.row == 0{
            self.lblCaptainName.text = "Captain: " + (cell.lblSlotMember.text ?? "")
        }
        
        cell.addToSlotClosure = {
            let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DiningAddMemberGuestPopUpVC") as? DiningAddMemberGuestPopUpVC
            vc?.delegateSelectedMemberType = self
            vc?.checkPopupOpenFrom = .addSlot
            self.selectedIndex = indexPath.row
            self.navigationController?.present(vc!, animated: false, completion: nil)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    // MARK: - Collection Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSpecialRequest.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckboxCell", for: indexPath as IndexPath) as! CheckBoxCustomCell
        cell.btnCheckBox.setTitle("testing", for: .normal)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        return CGSize(width:widthPerItem, height:50)
    }
    
    // MARK: - Member selection delegates
    
    func requestMemberViewControllerResponse(selecteArray: [RequestData]) { // Selecting Existing Guest & New Guest "GuestInfo" Obj

        self.diningReservation.PartyDetails[self.selectedIndex] = self.guestInfoToResrvationPartyDetail(memberInfo: selecteArray[0] as! GuestInfo)
        self.tblGuest.reloadData()
    }
    
    func memberViewControllerResponse(selecteArray: [MemberInfo]) {
        print(selecteArray)
    }
    
    func buddiesViewControllerResponse(selectedBuddy: [MemberInfo]) {
        print(selectedBuddy)
    }
    
    func AddGuestChildren(selecteArray: [RequestData]) {
        print(selecteArray)
    }
    
    func multiSelectRequestMemberViewControllerResponse (selectedArray : [[RequestData]]) { // Multi select members & Buddy "DiningMemberInfo" Obj
        print(selectedArray)
    }
    
    func addMemberDelegate(selecteArray: [RequestData]) { // Selecting a Single member & Buddy "DiningMemberInfo" Obj
 
        self.diningReservation.PartyDetails[self.selectedIndex] = self.diningMemberInfoToResrvationPartyDetail(memberInfo: selecteArray[0] as! DiningMemberInfo)
        self.tblGuest.reloadData()
    }
    
    

    
    //MARK: - API Callings
    
    func getLoggedInUserInfo() {

        var paramaterDict = [
            "Content-Type":"application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.ksearchby : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kpagecount: 1,
            APIKeys.krecordperpage:25
        ] as [String : Any]
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        APIHandler.sharedInstance.getMemberSpouseList(paramaterDict: paramaterDict) { response in
            
            if(response.responseCode == InternetMessge.kSuccess)
            {
                if(response.memberList == nil){
                    self.setCaptainWithDefaultValues()
                } else {
                    if response.memberList?.count != 0 {
                        for i in response.memberList! {
                            if i.id == UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "" {
                                let captainInfo = ResrvationPartyDetail.init()
                                captainInfo.setPartyDetails(memberID: i.id ?? "", memberName: i.memberName ?? "", diet: "", anniversary: 0, birthday: 0, other: 0, otherText: "", highChair: 0, boosterChair: 0)
                                self.diningReservation.PartyDetails[0] = captainInfo
                            }
                        }
                    } else {
                        self.setCaptainWithDefaultValues()
                    }
                }
            }
            self.tblGuest.reloadData()
            self.appDelegate.hideIndicator()
        } onFailure: { error in
            self.appDelegate.hideIndicator()
            self.setCaptainWithDefaultValues()
        }

    }
    
    func saveDiningReservation() {
        
//        var ReqBodyJsonString = Mapper().toJSONString(self.diningReservation, prettyPrint: true)
        var paramaterDict = [
            "Content-Type":"application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.ksearchby : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kpagecount: 1,
            APIKeys.krecordperpage:25
        ] as [String : Any]
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        APIHandler.sharedInstance.saveDinningReservation(paramater: paramaterDict, parameterObj: self.diningReservation) { response in
            
            if(response.responseCode == InternetMessge.kSuccess)
            {
                if let confirmDinningRequest = UIStoryboard.init(name: "DiningStoryboard", bundle: .main).instantiateViewController(withIdentifier: "DiningRequestConfirmedVC") as? DiningRequestConfirmedVC {
                    self.navigationController?.present(confirmDinningRequest, animated: true)
                }
            } else {
//                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.responseMessage, withDuration: Duration.kMediumDuration)
            }
            self.appDelegate.hideIndicator()
        } onFailure: { error in
            self.appDelegate.hideIndicator()
//            SharedUtlity.sharedHelper().showToast(on:
//                self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
        }

    }
    
}

