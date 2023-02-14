//
//  GolfSubmitRequestVCViewController.swift
//  CSSI
//
//  Created by Aks on 13/02/23.
//  Copyright © 2023 yujdesigns. All rights reserved.
//

import UIKit

class GolfSubmitRequestVCViewController: UIViewController {

    
    
    @IBOutlet weak var tblViewfirstComeFirstServce: SelfSizingTableView!
    @IBOutlet weak var tblViewfirstComeFirstServceConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnAddMultiple: UIButton!
    @IBOutlet weak var btnAddMultipleHeight: NSLayoutConstraint!
    @IBOutlet weak var btnDone: UIButton!

    
    var addNewPopoverTableView: UITableView? = nil
    private var isMultiSelectionClicked = false
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var isFrom = "View"
    override func viewDidLoad() {
        super.viewDidLoad()

setUpUiInitialization()

    }
    //MARK: - setUpUI
    func setUpUi(){
       // viewTime.shadowView(viewName: viewTime)
        btnBack.setTitle("", for: .normal)
        btnHome.setTitle("", for: .normal)
       // btnTime.setTitle("", for: .normal)
        btnAddMultiple.layer.cornerRadius = btnAddMultiple.layer.frame.height/2
        btnAddMultiple.layer.borderWidth = 1
        btnAddMultiple.layer.borderColor = UIColor(red: 59/255, green: 135/255, blue: 193/255, alpha: 1).cgColor
    }
    func setUpUiInitialization(){
                self.tblViewfirstComeFirstServce.delegate = self
                self.tblViewfirstComeFirstServce.dataSource = self
                self.tblViewfirstComeFirstServce.estimatedRowHeight = 50
                self.tblViewfirstComeFirstServce.estimatedSectionHeaderHeight = 50
                self.tblViewfirstComeFirstServce.register(UINib.init(nibName: "FirstComeFirstServeTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstComeFirstServeTableViewCell")
                self.tblViewfirstComeFirstServce.separatorStyle = .none
                let footerView = UIView()
                footerView.backgroundColor = .clear
                self.tblViewfirstComeFirstServce.tableFooterView = footerView
                if #available(iOS 15.0, *)
                {
                    self.tblViewfirstComeFirstServce.sectionHeaderTopPadding = 0
                }
                self.tblViewfirstComeFirstServceConstraint.constant = self.tblViewfirstComeFirstServce.contentSize.height
        setUpUi()
    }

    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tblViewfirstComeFirstServceConstraint.constant = self.tblViewfirstComeFirstServce.contentSize.height
    }
    
    //MARK: - IBActions
    @IBAction func doneBtnTapped(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
        
     //   delegateSelectedTimePatySize?.SelectedPartysizeTme(PartySize: selectedPartySize, Time: datePicker.date)
    }
    @IBAction func multiSelectionClicked(_ sender: UIButton)
    {
        
        self.isMultiSelectionClicked = true
    }

//    func numberOfSections(in tableView: UITableView) -> Int {
//
//            return 1
//
//    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        return 4
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstComeFirstServeTableViewCell") as! FirstComeFirstServeTableViewCell
//
////            let course = self.golfSettings?.courseDetails?[indexPath.row]
////
////            cell.lblCourseName.text = course?.courseName ?? ""
////            let placeHolderImage = UIImage(named: "Group 2124")
////            imageURLString = course?.courseImage1
////
////            if (self.imageURLString ?? "").isValidURL()
////            {
////                let url = URL.init(string:imageURLString ?? "")
////                cell.imageViewCourse.sd_setImage(with: url , placeholderImage: placeHolderImage)
////            }
//
////            if let coursesDetails = self.courseDetailsResponse.courseDetails {
////                cell.timeSlotsDetails = coursesDetails[indexPath.row]
////                cell.scheduleType = coursesDetails[indexPath.row].scheduleType ?? "FCFS"
////                if isFrom == "Modify" || isFrom == "View"{
////                    cell.slotType = self.getSlotType(courseId: coursesDetails[indexPath.row].id ?? "")
////                }
////            }
//
//            cell.arrAvailableTimes = ["10:00 AM","10:30 AM","11:00 AM", "11:30 AM", "12:00 PM", "12:30 PM", "01:00 PM","01:30 PM"]
//            cell.selectionStyle = .none
//            cell.btnCourseSelected.isHidden = true
//            cell.imgCheckBox.isHidden = true
//         //   cell.selectedSlots = self.selectedSlotsList
//
//           // cell.delegate = self
//          //  cell.collectionViewCourseTimes.reloadData()
//           //cell.initiateScroll()
//            return cell
//    }
    
    
}
extension GolfSubmitRequestVCViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AddPlayerTableCell", for: indexPath) as? AddPlayerTableCell {
            //cell.delegate = self
            if(isFrom == "Modify" || isFrom == "View"){
                //            if(indexPath.section == 0){
                //                if arrGroup1[indexPath.row] is Detail {
                //                    let playObj = arrGroup1[indexPath.row] as! Detail
                //
                //                    if playObj.name == "" {
                //                        cell.lblname.text = playObj.guestName
                //                        //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                //                        //ENGAGE0011843 -- Start
                //                        cell.lblID.text = CustomFunctions.shared.guestTypeDisplayName(id: playObj.guestType)
                //                        //cell.lblID.text = playObj.guestType
                //                        //ENGAGE0011843 -- End
                //
                //
                //                    }else{
                //                        cell.lblname.text = playObj.name
                //                        if playObj.memberId != nil {
                //                            cell.lblID.text = playObj.memberId
                //                        } else {
                //                            cell.lblID.text = playObj.guestType
                //                        }
                //
                //
                //                    }
                //
                //                    if playObj.memberRequestHoles?.lowercased() == "9 Holes".lowercased() {
                //                        cell.btnNineHoles.isSelected = true
                //                    } else {
                //                        cell.btnNineHoles.isSelected = false
                //                    }
                //
                //                    cell.textFieldTrans.text = self.getTransText(value: playObj.memberTransType ?? 0)
                //
                //
                //                }else if arrGroup1[indexPath.row] is MemberInfo {
                //                    let memberObj = arrGroup1[indexPath.row] as! MemberInfo
                //                    cell.lblname.text = String(format: "%@", memberObj.memberName!)
                //                    cell.lblID.text = memberObj.memberID
                //
                //                    if memberObj.memberRequestHoles?.lowercased() == "9 Holes".lowercased() {
                //                        cell.btnNineHoles.isSelected = true
                //                    } else {
                //                        cell.btnNineHoles.isSelected = false
                //                    }
                //
                //                    cell.textFieldTrans.text = self.getTransText(value: memberObj.memberTransType ?? 0)
                //
                //                }
                //                else if arrGroup1[indexPath.row] is GuestInfo {
                //                    let guestObj = arrGroup1[indexPath.row] as! GuestInfo
                //                    cell.lblname.text = guestObj.guestName
                //                    //Added by kiran V2.8 -- ENGAGE0011784 --
                //                    //ENGAGE0011784 -- Start
                //                    let memberType = CustomFunctions.shared.memberType(details: guestObj, For: .golf)
                //
                //                    if memberType == .existingGuest
                //                    {
                //                        cell.lblID.text = guestObj.guestMemberNo
                //                    }
                //                    else
                //                    {
                //                        //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                //                        //ENGAGE0011843 -- Start
                //                        cell.lblID.text = CustomFunctions.shared.guestTypeDisplayName(id: guestObj.guestType)
                //                        //cell.lblID.text = guestObj.guestType
                //                        //ENGAGE0011843 -- End
                //                    }
                //
                //                    if guestObj.memberRequestHoles?.lowercased() == "9 Holes".lowercased() {
                //                        cell.btnNineHoles.isSelected = true
                //                    } else {
                //                        cell.btnNineHoles.isSelected = false
                //                    }
                //                    cell.textFieldTrans.text = self.getTransText(value: guestObj.memberTransType ?? 0)
                //
                //
                //                    //ENGAGE0011784 -- End
                //                } else {
                //                    cell.lblname.text = ""
                //                    cell.lblID.text = ""
                //
                //                }
                //
                //            }else if(indexPath.section == 1){
                //                if arrGroup2[indexPath.row] is Detail {
                //                    let playObj = arrGroup2[indexPath.row] as! Detail
                //                    if playObj.name == "" {
                //                        cell.lblname.text = playObj.guestName
                //                        //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                //                        //ENGAGE0011843 -- Start
                //                        cell.lblID.text = CustomFunctions.shared.guestTypeDisplayName(id: playObj.guestType)
                //                        //cell.lblID.text = playObj.guestType
                //                        //ENGAGE0011843 -- End
                //
                //
                //                    }else{
                //                        cell.lblname.text = playObj.name
                //                        if playObj.memberId != nil {
                //                            cell.lblID.text = playObj.memberId
                //                        } else {
                //                            cell.lblID.text = playObj.guestType
                //                        }
                //
                //                    }
                //                    if playObj.memberRequestHoles?.lowercased() == "9 Holes".lowercased() {
                //                        cell.btnNineHoles.isSelected = true
                //                    } else {
                //                        cell.btnNineHoles.isSelected = false
                //                    }
                //
                //                    cell.textFieldTrans.text = self.getTransText(value: playObj.memberTransType ?? 0)
                //
                //                }else if arrGroup2[indexPath.row] is MemberInfo {
                //                    let memberObj = arrGroup2[indexPath.row] as! MemberInfo
                //                    cell.lblname.text = String(format: "%@", memberObj.memberName!)
                //                    cell.lblID.text = memberObj.memberID
                //                    if memberObj.memberRequestHoles?.lowercased() == "9 Holes".lowercased() {
                //                        cell.btnNineHoles.isSelected = true
                //                    } else {
                //                        cell.btnNineHoles.isSelected = false
                //                    }
                //
                //                    cell.textFieldTrans.text = self.getTransText(value: memberObj.memberTransType ?? 0)
                //
                //                }
                //                else if arrGroup2[indexPath.row] is GuestInfo {
                //                    let guestObj = arrGroup2[indexPath.row] as! GuestInfo
                //                    cell.lblname.text = guestObj.guestName
                //                    //Added by kiran V2.8 -- ENGAGE0011784 --
                //                    //ENGAGE0011784 -- Start
                //                    let memberType = CustomFunctions.shared.memberType(details: guestObj, For: .golf)
                //
                //                    if memberType == .existingGuest
                //                    {
                //                        cell.lblID.text = guestObj.guestMemberNo
                //                    }
                //                    else
                //                    {
                //                        //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                //                        //ENGAGE0011843 -- Start
                //                        cell.lblID.text = CustomFunctions.shared.guestTypeDisplayName(id: guestObj.guestType)
                //                        //cell.lblID.text = guestObj.guestType
                //                        //ENGAGE0011843 -- End
                //                    }
                //                    //ENGAGE0011784 -- End
                //                    if guestObj.memberRequestHoles?.lowercased() == "9 Holes".lowercased() {
                //                        cell.btnNineHoles.isSelected = true
                //                    } else {
                //                        cell.btnNineHoles.isSelected = false
                //                    }
                //
                //                    cell.textFieldTrans.text = self.getTransText(value: guestObj.memberTransType ?? 0)
                //
                //                } else {
                //                    cell.lblname.text = ""
                //                    cell.lblID.text = ""
                //
                //                }
                //
                //            }else if(indexPath.section == 2){
                //                if arrGroup3[indexPath.row] is Detail {
                //                    let playObj = arrGroup3[indexPath.row] as! Detail
                //                    if playObj.name == "" {
                //                        cell.lblname.text = playObj.guestName
                //                        //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                //                        //ENGAGE0011843 -- Start
                //                        cell.lblID.text = CustomFunctions.shared.guestTypeDisplayName(id: playObj.guestType)
                //                        //cell.lblID.text = playObj.guestType
                //                        //ENGAGE0011843 -- End
                //
                //
                //                    }else{
                //                        cell.lblname.text = playObj.name
                //                        if playObj.memberId != nil {
                //                            cell.lblID.text = playObj.memberId
                //                        } else {
                //                            cell.lblID.text = playObj.guestType
                //                        }
                //
                //                    }
                //                    if playObj.memberRequestHoles?.lowercased() == "9 Holes".lowercased() {
                //                        cell.btnNineHoles.isSelected = true
                //                    } else {
                //                        cell.btnNineHoles.isSelected = false
                //                    }
                //                    cell.textFieldTrans.text = self.getTransText(value: playObj.memberTransType ?? 0)
                //
                //
                //                }else if arrGroup3[indexPath.row] is MemberInfo {
                //                    let memberObj = arrGroup3[indexPath.row] as! MemberInfo
                //                    cell.lblname.text = String(format: "%@", memberObj.memberName!)
                //                    cell.lblID.text = memberObj.memberID
                //                    if memberObj.memberRequestHoles?.lowercased() == "9 Holes".lowercased() {
                //                        cell.btnNineHoles.isSelected = true
                //                    } else {
                //                        cell.btnNineHoles.isSelected = false
                //                    }
                //
                //                    cell.textFieldTrans.text = self.getTransText(value: memberObj.memberTransType ?? 0)
                //
                //                }
                //                else if arrGroup3[indexPath.row] is GuestInfo {
                //                    let guestObj = arrGroup3[indexPath.row] as! GuestInfo
                //                    cell.lblname.text = guestObj.guestName
                //                    //Added by kiran V2.8 -- ENGAGE0011784 --
                //                    //ENGAGE0011784 -- Start
                //                    let memberType = CustomFunctions.shared.memberType(details: guestObj, For: .golf)
                //
                //                    if memberType == .existingGuest
                //                    {
                //                        cell.lblID.text = guestObj.guestMemberNo
                //                    }
                //                    else
                //                    {
                //                        //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                //                        //ENGAGE0011843 -- Start
                //                        cell.lblID.text = CustomFunctions.shared.guestTypeDisplayName(id: guestObj.guestType)
                //                        //cell.lblID.text = guestObj.guestType
                //                        //ENGAGE0011843 -- End
                //                    }
                //                    //ENGAGE0011784 -- End
                //                    if guestObj.memberRequestHoles?.lowercased() == "9 Holes".lowercased() {
                //                        cell.btnNineHoles.isSelected = true
                //                    } else {
                //                        cell.btnNineHoles.isSelected = false
                //                    }
                //                    cell.textFieldTrans.text = self.getTransText(value: guestObj.memberTransType ?? 0)
                //
                //                } else {
                //                    cell.lblname.text = ""
                //                    cell.lblID.text = ""
                //
                //                }
                //
                //            }else if(indexPath.section == 3){
                //                if arrGroup4[indexPath.row] is Detail {
                //                    let playObj = arrGroup4[indexPath.row] as! Detail
                //                    if playObj.name == "" {
                //                        cell.lblname.text = playObj.guestName
                //                        //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                //                        //ENGAGE0011843 -- Start
                //                        cell.lblID.text = CustomFunctions.shared.guestTypeDisplayName(id: playObj.guestType)
                //                        //cell.lblID.text = playObj.guestType
                //                        //ENGAGE0011843 -- End
                //
                //
                //                    }else{
                //                        cell.lblname.text = playObj.name
                //                        if playObj.memberId != nil {
                //                            cell.lblID.text = playObj.memberId
                //                        } else {
                //                            cell.lblID.text = playObj.guestType
                //                        }
                //
                //                    }
                //                    if playObj.memberRequestHoles?.lowercased() == "9 Holes".lowercased() {
                //                        cell.btnNineHoles.isSelected = true
                //                    } else {
                //                        cell.btnNineHoles.isSelected = false
                //                    }
                //
                //                    cell.textFieldTrans.text = self.getTransText(value: playObj.memberTransType ?? 0)
                //
                //                }else if arrGroup4[indexPath.row] is MemberInfo {
                //                    let memberObj = arrGroup4[indexPath.row] as! MemberInfo
                //                    cell.lblname.text = String(format: "%@", memberObj.memberName!)
                //                    cell.lblID.text = memberObj.memberID
                //                    if memberObj.memberRequestHoles?.lowercased() == "9 Holes".lowercased() {
                //                        cell.btnNineHoles.isSelected = true
                //                    } else {
                //                        cell.btnNineHoles.isSelected = false
                //                    }
                //                    cell.textFieldTrans.text = self.getTransText(value: memberObj.memberTransType ?? 0)
                //
                //                }
                //                else if arrGroup4[indexPath.row] is GuestInfo {
                //                    let guestObj = arrGroup4[indexPath.row] as! GuestInfo
                //                    cell.lblname.text = guestObj.guestName
                //                    //Added by kiran V2.8 -- ENGAGE0011784 --
                //                    //ENGAGE0011784 -- Start
                //                    let memberType = CustomFunctions.shared.memberType(details: guestObj, For: .golf)
                //
                //                    if memberType == .existingGuest
                //                    {
                //                        cell.lblID.text = guestObj.guestMemberNo
                //                    }
                //                    else
                //                    {
                //                        //Added by kiran V3.0 -- ENGAGE0011843 -- Fetching the display name for the guest id.
                //                        //ENGAGE0011843 -- Start
                //                        cell.lblID.text = CustomFunctions.shared.guestTypeDisplayName(id: guestObj.guestType)
                //                        //cell.lblID.text = guestObj.guestType
                //                        //ENGAGE0011843 -- End
                //                    }
                //
                //                    //ENGAGE0011784 -- End
                //                    if guestObj.memberRequestHoles?.lowercased() == "9 Holes".lowercased() {
                //                        cell.btnNineHoles.isSelected = true
                //                    } else {
                //                        cell.btnNineHoles.isSelected = false
                //                    }
                //                    cell.textFieldTrans.text = self.getTransText(value: guestObj.memberTransType ?? 0)
                //                } else {
                //                    cell.lblname.text = ""
                //                    cell.lblID.text = ""
                //
                //                }
                //
                //            }
                //            else{
                //
                //            }
                //
                //            }else{
                //            }
                //            if self.lblGroupNumber.text == "01"{
                //                cell.btnThreeDots.isHidden = true
                //            }
                //            else{
                //                cell.btnThreeDots.isHidden = false
                //            }
                //            if self.isFrom == "View" {
                //                cell.btnThreeDots.isEnabled = false
                //                cell.btnClose.isEnabled = false
                ////                    self.btnRequest.isHidden = true
                //                self.btnCancelRequest.isHidden = true
                //                self.heightCancelRequest.constant = -20
                ////                    self.heightRules.constant = -20
                //
                //            }
                //
                //            //Added by kiran V2.5 -- GATHER0000606 -- Hiding clear button if options array is empty
                //            //GATHER0000606 -- Start
                //            let hideMemberOptions = self.shouldHideMemberAddOptions()
                //            cell.btnClose.isHidden = hideMemberOptions
                //            //GATHER0000606 -- End
                //
                //            if self.isFrom == "View" || self.isFrom == "Modify" {
                //                if self.isFirstComeFirstServe {
                //                    cell.viewTransDetailsWidth.constant = 110.0
                //                } else {
                //                    cell.viewTransDetailsWidth.constant = 0.0
                //                }
                //            }
                
                
                
                self.view.setNeedsLayout()
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("ModifyRequestHeaderView", owner: self, options: nil)?.first as! ModifyRequestHeaderView
        return headerView
    }
}
   
