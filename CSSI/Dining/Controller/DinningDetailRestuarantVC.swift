//
//  DinningDetailRestuarantVC.swift
//  CSSI
//
//  Created by Aks on 03/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit



class DinningDetailRestuarantVC: UIViewController, UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, selectedSlotFor, MemberViewControllerDelegate, AddMemberDelegate, cancelDinningPopup {
    func cancelDinningReservation(value: Bool) {
    popBack(3)
    }
    

    
    
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
    
    @IBOutlet weak var btnSubmitHeight: NSLayoutConstraint!
    @IBOutlet weak var btnCancelReservationHeight: NSLayoutConstraint!
    @IBOutlet weak var btnCancelReservation: UIButton!
    @IBOutlet weak var lblLoggedInUser: UILabel!
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var lblCaptainName: UILabel!
    
    @IBOutlet weak var imageAddMemberWidth: NSLayoutConstraint!
    @IBOutlet weak var imageAddMember: UIImageView!
    @IBOutlet weak var lblModiftCaptainName: UILabel!
    
    @IBOutlet weak var viewModifyDetailsHeight: NSLayoutConstraint!
    @IBOutlet weak var lblConfirmationNumber: UILabel!
    //MARK: - variables
    
    var showNavigationBar = true
    var restaurantName = ""
    var diningReservation = DinningReservationFCFS.init()
    var MeberInfoModel = [ResrvationPartyDetail]()
    var restaurantImage  = ""
    var selectedIndex = -1
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var tablePreferances: [DiningTablePrefenceData] = []
    var isFrom: dinningMode = .create
    var diningPolicyURL = ""
    
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
        if isFrom == .create {
            self.setupDefaultMemberValues()
            self.viewModifyDetailsHeight.constant = 0
            self.imageAddMemberWidth.constant = 0
            
            self.imageAddMember.isHidden = true
        }
        if isFrom == .view {
            self.btnSubmitHeight.constant = 0
            self.btnCancelReservationHeight.constant = 0
        }
        self.lblConfirmationNumber.text = self.diningReservation.ConfirmationNumber
        self.getTablePreferances()
    }
    
    func setUpUi(){
//        imgRestuarant.layer.cornerRadius = 8
        txtReservationComment.layer.borderWidth = 1
        txtReservationComment.layer.borderColor = UIColor.lightGray.cgColor
        txtReservationComment.layer.cornerRadius = 8
        txtReservationComment.text = self.diningReservation.Comments
        btnSubmit.layer.cornerRadius = btnSubmit.layer.frame.height/2
        btnCancelReservation.layer.cornerRadius = btnCancelReservation.layer.frame.height/2
        btnAddMultiple.layer.cornerRadius = btnAddMultiple.layer.frame.height/2
        btnAddMultiple.layer.borderWidth = 1
        btnAddMultiple.layer.borderColor = UIColor(red: 59/255, green: 135/255, blue: 193/255, alpha: 1).cgColor
        btnHome.setTitle("", for: .normal)
        btnBack.setTitle("", for: .normal)
        lblPartySize.text = String(format: "%02d", self.diningReservation.PartySize)
        lblTime.text = self.diningReservation.SelectedTime
        lblRestaurantName.text = self.restaurantName
        
        self.imgRestuarant.image = convertBase64StringToImage(imageBase64String: restaurantImage)
        self.lblLoggedInUser.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)
        if isFrom == .create {
            self.btnCancelReservationHeight.constant = 0
            self.tblGuest.separatorStyle = .none
            self.btnSubmit.setTitle("Submit", for: .normal)
        } else {
            self.tblGuest.separatorStyle = .singleLine
            self.btnSubmit.setTitle("Save", for: .normal)
        }
        setUpUiInitialization()
    }
    func setUpUiInitialization(){
        collectionAddSpecialRequest.delegate = self
        collectionAddSpecialRequest.dataSource  = self
        tblGuest.delegate = self
        tblGuest.dataSource  = self
        configSlotMemberTblHeight()
    }
    //MARK: - IBOutlets
    @IBAction func btnSubmit(_ sender: Any) {
        self.diningReservation.Comments = self.txtReservationComment.text ?? ""
//        self.validateReservation()
        self.saveDiningReservation()
    }
    
    @IBAction func btnCancelReservationAction(_ sender: Any) {
        if let cancelViewController = UIStoryboard.init(name: "DiningStoryboard", bundle: .main).instantiateViewController(withIdentifier: "CancelDinningReservationPopupVC") as? CancelDinningReservationPopupVC {
            cancelViewController.eventID = self.diningReservation.RequestID
            cancelViewController.diningCancelPopupMode = .detail
            cancelViewController.delegateCancelReservation = self
            cancelViewController.cancelReservationClosure = {
                self.navigationController?.popToRootViewController(animated: true)
            }
            self.navigationController?.present(cancelViewController, animated: true)
        }
  
    }
    
    @IBAction func btnAddMemberAction(_ sender: Any) {
        if self.diningReservation.PartyDetails.count != self.diningReservation.PartySize {
            let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DiningAddMemberGuestPopUpVC") as? DiningAddMemberGuestPopUpVC
            vc?.delegateSelectedMemberType = self
            vc?.checkPopupOpenFrom = .addSlot
            self.selectedIndex = -1
            self.navigationController?.present(vc!, animated: false, completion: nil)
        }
    }
    
    @IBAction func btnAddMultiple(_ sender: Any) {
        let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DiningAddMemberGuestPopUpVC") as? DiningAddMemberGuestPopUpVC
        vc?.delegateSelectedMemberType = self
        vc?.checkPopupOpenFrom = .multiple
        self.navigationController?.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func btnHome(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDiningPolicyAction(_ sender: Any) {
        let restarantpdfDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
        restarantpdfDetailsVC.pdfUrl = self.diningPolicyURL
        restarantpdfDetailsVC.restarantName = self.appDelegate.masterLabeling.dining_policy!
        self.navigationController?.pushViewController(restarantpdfDetailsVC, animated: true)
    }
    // MARK: - Functions
    
    func setupDefaultMemberValues() {
        if isFrom == .create {
            self.diningReservation.PartyDetails.removeAll()
            if self.diningReservation.PartySize > 1 {
                for _ in 1...self.diningReservation.PartySize {
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
            let NumberOfSlot = self.diningReservation.PartyDetails.count
            let numberOfLines = NumberOfSlot + 1
            heightTblGuest.constant = CGFloat(60*numberOfLines)
        }
        tblGuest.reloadData()
    }

    func configSlotMemberCollectionHeight(){
        if self.tablePreferances.count == 0{
            heightSpecialRequestCollection.constant = 0
            heightViewBackSpecialRequest.constant = 0
        }
        else{
            let numberOfLines = (self.tablePreferances.count/2)+1
            heightSpecialRequestCollection.constant = CGFloat(50*numberOfLines)
            heightViewBackSpecialRequest.constant = 70 + CGFloat(50*numberOfLines)
        }
        collectionAddSpecialRequest.reloadData()
    }
    
    func diningMemberInfoToResrvationPartyDetail(memberInfo: DiningMemberInfo) -> ResrvationPartyDetail {
        let partyMemberInfo = ResrvationPartyDetail()
        partyMemberInfo.setPartyDetails(confirmationNumber: memberInfo.parentID ?? "", memberID: memberInfo.linkedMemberID ?? "", memberName: memberInfo.name ?? "", diet: memberInfo.dietaryRestrictions ?? "", anniversary: memberInfo.anniversary ?? 0, birthday: memberInfo.birthDay ?? 0, other: memberInfo.other ?? 0, otherText: memberInfo.otherText ?? "", highChair: memberInfo.highChairCount ?? 0, boosterChair: memberInfo.boosterChairCount ?? 0, memberNumber: memberInfo.memberId ?? "")
        return partyMemberInfo
    }

    func guestInfoToResrvationPartyDetail(memberInfo: GuestInfo) -> ResrvationPartyDetail {
        let partyMemberInfo = ResrvationPartyDetail()
        partyMemberInfo.setPartyGuestDetails(memberID: memberInfo.linkedMemberID ?? "", memberName: memberInfo.guestName ?? "", diet: memberInfo.dietaryRestrictions ?? "", anniversary: memberInfo.anniversary ?? 0, birthday: memberInfo.birthDay ?? 0, other: memberInfo.other ?? 0, otherText: memberInfo.otherText ?? "", highChair: memberInfo.highChairCount ?? 0, boosterChair: memberInfo.boosterChairCount ?? 0, guestOf: memberInfo.guestMemberOf ?? "", guestContact: memberInfo.cellPhone ?? "", guestType: memberInfo.guestType ?? "", guestDOB: memberInfo.guestDOB ?? "", guestEmail: memberInfo.email ?? "", guestGender: memberInfo.guestGender ?? "", guestLastName: memberInfo.guestLastName  ?? "", guestFirstName: memberInfo.guestFirstName ?? "")
        return partyMemberInfo
    }
    
    func setCaptainWithDefaultValues() {
        let partyMemberInfo = ResrvationPartyDetail()
        partyMemberInfo.setPartyDetails(confirmationNumber: "", memberID: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "", memberName: UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue) ?? "", diet: "", anniversary: 0, birthday: 0, other: 0, otherText: "", highChair: 0, boosterChair: 0, memberNumber: "")
        self.diningReservation.PartyDetails[0] = partyMemberInfo
    }
    
    func assignCaptainName(name: String) {
        if isFrom == .create {
            self.lblCaptainName.text = "Captain: " + name
        } else {
            self.lblCaptainName.text = "Click on the icon, to select Member, Guest or My Buddies"
            self.lblModiftCaptainName.text = "Captain: " + name
        }
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
                    memberDirectory.totalNumberofTickets = self.diningReservation.PartySize
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
    
        return self.diningReservation.PartyDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFrom == .create {
            let cell = tblGuest.dequeueReusableCell(withIdentifier: "AddGuestTableCell", for: indexPath) as! AddGuestTableCell
            cell.lblSlotMember.text = self.diningReservation.PartyDetails[indexPath.row].MemberName
            if indexPath.row == 0{
                self.assignCaptainName(name: cell.lblSlotMember.text ?? "")
            }
            cell.removeFromSlotClosure = {
                self.diningReservation.PartyDetails[indexPath.row] = ResrvationPartyDetail.init()
                self.tblGuest.reloadData()
            }
            cell.addToSlotClosure = {
                let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DiningAddMemberGuestPopUpVC") as? DiningAddMemberGuestPopUpVC
                vc?.delegateSelectedMemberType = self
                vc?.checkPopupOpenFrom = .addSlot
                self.selectedIndex = indexPath.row
                self.navigationController?.present(vc!, animated: false, completion: nil)
            }
            
            return cell
        } else {
            let cell = tblGuest.dequeueReusableCell(withIdentifier: "AddGuestModifyTableCell", for: indexPath) as! AddGuestModifyTableCell
            cell.lblMemberName.text = self.diningReservation.PartyDetails[indexPath.row].MemberName
            cell.lblConfirmationNumber.text = self.diningReservation.PartyDetails[indexPath.row].MemberNumber
            if indexPath.row == 0{
                self.assignCaptainName(name: cell.lblMemberName.text ?? "")
            }
            cell.removeFromSlotClosure = {
                self.diningReservation.PartyDetails.remove(at:indexPath.row)
                self.configSlotMemberTblHeight()
                self.tblGuest.reloadData()
            }
            
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.diningReservation.PartyDetails[indexPath.row].MemberName != ""{
            if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddMemberVC") as? AddMemberVC
            {
                regGuest.arrTotalList = [self.diningReservation.PartyDetails[indexPath.row]]

                if isFrom == .view {
                    regGuest.isFrom = "View"
                } else {
                    regGuest.isFrom = "Modify"
                }
                
                regGuest.delegateAddMember = self
                self.selectedIndex = indexPath.row
                navigationController?.pushViewController(regGuest, animated: true)
            }
        }
        tableView.reloadData()
    }
    
    // MARK: - Collection Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tablePreferances.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckboxCell", for: indexPath as IndexPath) as! CheckBoxCustomCell
        cell.btnCheckBox.setTitle(self.tablePreferances[indexPath.row].PreferenceName, for: .normal)
        if self.diningReservation.TablePreferenceID == self.tablePreferances[indexPath.row].TablePreferenceID {
            cell.btnCheckBox.setImage(UIImage(named: "CheckBox_check"), for: .normal)
        } else {
            cell.btnCheckBox.setImage(UIImage(named: "CheckBox_uncheck"), for: .normal)
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isFrom != .view {
            if self.diningReservation.TablePreferenceID == self.tablePreferances[indexPath.row].TablePreferenceID {
                self.diningReservation.TablePreferenceID = ""
            } else {
                self.diningReservation.TablePreferenceID = self.tablePreferances[indexPath.row].TablePreferenceID
            }
            collectionView.reloadData()
        }
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
        let memberInfo = selecteArray[0] as! DiningMemberInfo
        if self.selectedIndex == -1 {
            memberInfo.parentID = ""
            self.diningReservation.PartyDetails.append(self.diningMemberInfoToResrvationPartyDetail(memberInfo: memberInfo))
        } else {
            memberInfo.parentID = self.diningReservation.PartyDetails[self.selectedIndex].confirmationMemberID
            self.diningReservation.PartyDetails[self.selectedIndex] = self.diningMemberInfoToResrvationPartyDetail(memberInfo: memberInfo)
        }
        self.configSlotMemberTblHeight()
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
                                captainInfo.setPartyDetails(confirmationNumber: "", memberID: i.id ?? "", memberName: i.memberName ?? "", diet: "", anniversary: 0, birthday: 0, other: 0, otherText: "", highChair: 0, boosterChair: 0, memberNumber: "")
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
    
    func getSpecialRequestOfMember(member: ResrvationPartyDetail) -> String {
        var outputString = ""
        if member.Birthday == 1 {
            outputString = "Birthday"
        }
        if member.Anniversary == 1 {
            if outputString == "" {
                outputString = "Anniversary"
            } else {
                outputString = outputString + "^^Anniversary"
            }
        }
        if member.Other == 1 {
            if outputString == "" {
                outputString = "Other"
            } else {
                outputString = outputString + "^^Other"
            }
        }
        return outputString
    }
    
    func saveDiningReservation() {
        
        for i in 0...self.diningReservation.PartyDetails.count-1 {
            self.diningReservation.PartyDetails[i].specialOccation = self.getSpecialRequestOfMember(member: self.diningReservation.PartyDetails[i])
        }
        
        var ReqBodyJson = self.diningReservation.toJSON()
        var paramaterDict = [
            "Content-Type":"application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict]
        ] as [String : Any]
        
        paramaterDict = paramaterDict.merging(ReqBodyJson, uniquingKeysWith: { _, new in
            new
        })
        paramaterDict["Content-Type"] = "application/json"
        paramaterDict["RequestedLinkedMemberId"] = UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? ""
        paramaterDict["UserName"] = UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue) ?? ""
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)


        print(paramaterDict)
        APIHandler.sharedInstance.saveDinningReservation(paramater: paramaterDict) { response in
            
            if(response.Responsecode == InternetMessge.kSuccess)
            {
                if let confirmDinningRequest = UIStoryboard.init(name: "DiningStoryboard", bundle: .main).instantiateViewController(withIdentifier: "DiningRequestConfirmedVC") as?     DiningRequestConfirmedVC {
                    confirmDinningRequest.reservationDetails = response
                    self.navigationController?.pushViewController(confirmDinningRequest, animated: true)
                }
            } else {
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.responseMessage, withDuration: Duration.kMediumDuration)
            }
            self.appDelegate.hideIndicator()
        } onFailure: { error in
            self.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
        }

    }
    
    func getTablePreferances() {

        var paramaterDict = [
            "Content-Type":"application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            "CompanyCode": "00",
            "RestaurantID": self.diningReservation.RestaurantID,
            "FilterDate": self.diningReservation.SelectedDate,
            "FilterTime": self.diningReservation.SelectedTime
        ] as [String : Any]
//        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        APIHandler.sharedInstance.getTablePreferances(paramater: paramaterDict) { response in
            
            if(response.responseCode == InternetMessge.kSuccess)
            {
                self.tablePreferances = response.tablePreferanceDetails
                self.configSlotMemberCollectionHeight()
            }
            self.collectionAddSpecialRequest.reloadData()
//            self.appDelegate.hideIndicator()
        } onFailure: { error in
//            self.appDelegate.hideIndicator()
        }
    }
    
    func validateReservation() {
        
        var diningDetails = self.diningReservation.PartyDetails.toJSON()
        for i in 0...diningDetails.count - 1 {
            diningDetails[i]["LinkedMemberID"] = self.diningReservation.PartyDetails[i].MemberID
        }
        
       let paramaterDict = [
            "Content-Type":"application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kid : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
            APIKeys.kParentId : UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
            "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            "RequestId": self.diningReservation.RequestID ,
            "ReservationRequestDate": self.diningReservation.SelectedDate,
            "ReservationRequestTime": self.diningReservation.SelectedTime,
            "PartySize": self.diningReservation.PartySize,
            "Earliest": self.diningReservation.SelectedTime,
            "Latest": self.diningReservation.SelectedTime,
            "Comments": "",
            "PreferedSpaceDetailId": "" ,
            "TablePreference": "",
            "DiningDetails" : diningDetails,
            "IsReservation": "1",
            "IsEvent": "0",
            "ReservationType": "Dining",
            "RegistrationID": self.diningReservation.RequestID
       ] as [String : Any]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        APIHandler.sharedInstance.getMemberValidationDiningFCFS(paramater: paramaterDict) { response in
            
            if(response.responseCode == InternetMessge.kSuccess)
            {
                if response.ValidCheck == "False" {
                    if response.IsHardRuleEnabled == "False" {

                        let refreshAlert = UIAlertController(title: "Dining Reservation", message: response.ValidationMessage, preferredStyle: UIAlertController.Style.alert)
                        refreshAlert.view.tintColor = hexStringToUIColor(hex: "40B2E6")
                        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                            self.saveDiningReservation()
                        }))

                        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                              print("Cancel Clicked")
                        }))

                        self.present(refreshAlert, animated: true, completion: nil)
                    } else {
                        SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.ValidationMessage, withDuration: Duration.kMediumDuration)
                    }
                } else {
                    self.saveDiningReservation()
                }
                
                
            } else {
                SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:response.responseMessage, withDuration: Duration.kMediumDuration)
                print(response.brokenRules?.message)
            }
            self.appDelegate.hideIndicator()
            
        } onFailure: { error in
            self.appDelegate.hideIndicator()
        }
    }
    
}

extension DinningDetailRestuarantVC{
    /// pop back n viewcontroller
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
}
