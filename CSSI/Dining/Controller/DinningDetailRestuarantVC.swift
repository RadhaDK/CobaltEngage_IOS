//
//  DinningDetailRestuarantVC.swift
//  CSSI
//
//  Created by Aks on 03/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class DinningDetailRestuarantVC: UIViewController, UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, selectedSlotFor{
    func addingMemberType(value: String) {
        if value == "Member"{
            if let memberDirectory = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MemberDirectoryViewController") as? MemberDirectoryViewController
            {
               
                memberDirectory.isFrom = "Registration"
//                memberDirectory.isOnlyFrom = "GolfCourt"
//                memberDirectory.categoryForBuddy = "Golf"
//                memberDirectory.isFor = "OnlyMembers"
//                memberDirectory.showSegmentController = true
//                memberDirectory.requestID = requestID
//                memberDirectory.selectedDate = self.reservationRequestDate
//                memberDirectory.selectedTime = self.txtPreferredTeeTime.text
                
               // memberDirectory.delegate = self

                navigationController?.pushViewController(memberDirectory, animated: true)
            }
        }
        else if value == "Guest"{
            if let regGuest = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AddGuestRegVC") as? AddGuestRegVC
            {
                //regGuest.memberDelegate = self
                regGuest.usedForModule = .golf
                regGuest.screenType = .add
                regGuest.showExistingGuestsOption = true
                regGuest.isDOBHidden = false
                regGuest.isGenderHidden = false
                regGuest.enableGuestNameSuggestions = false
                regGuest.hideAddtoBuddy = true
                regGuest.hideExistingGuestAddToBuddy = true
        
     
                navigationController?.pushViewController(regGuest, animated: true)
        }
        }
        else {
            if let memberDirectory = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MemberDirectoryViewController") as? MemberDirectoryViewController {
                memberDirectory.isFrom = "BuddyList"
                
               // memberDirectory.delegate = self

                navigationController?.pushViewController(memberDirectory, animated: true)
            }
        }
    }
    
    
    
    var showNavigationBar = true
    @IBOutlet weak var tblGuest: UITableView!
    @IBOutlet weak var imgRestuarant: UIImageView!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var collectionAddSpecialRequest: UICollectionView!
    @IBOutlet weak var heightSpecialRequestCollection: NSLayoutConstraint!
    @IBOutlet weak var txtReservationComment: UITextView!
    @IBOutlet weak var heightTblGuest: NSLayoutConstraint!
    @IBOutlet weak var heightViewBackSpecialRequest: NSLayoutConstraint!
    
    var arrBookedSlotMember = ["Lia Little"]
    var arrSpecialRequest = ["Behind lounge area","Close to enterance","Outside","On the Perimeter"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblGuest.delegate = self
        tblGuest.dataSource  = self
        collectionAddSpecialRequest.delegate = self
        collectionAddSpecialRequest.dataSource  = self
        imgRestuarant.layer.cornerRadius = 8
        txtReservationComment.layer.borderWidth = 1
        txtReservationComment.layer.borderColor = UIColor.lightGray.cgColor
        txtReservationComment.layer.cornerRadius = 8
        btnSubmit.layer.cornerRadius = btnSubmit.layer.frame.height/2
        btnHome.setTitle("", for: .normal)
        configSlotMemberCollectionHeight()
        configSlotMemberTblHeight()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = !self.showNavigationBar
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
            if let confirmDinningRequest = UIStoryboard.init(name: "DiningStoryboard", bundle: .main).instantiateViewController(withIdentifier: "DiningRequestConfirmedVC") as? DiningRequestConfirmedVC {
                self.navigationController?.present(confirmDinningRequest, animated: true)
        }
    }
    @IBAction func btnHome(_ sender: Any) {
        let homeVC = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
   
    
    // MARK:- My order Table  Height
          func configSlotMemberTblHeight(){
              if arrBookedSlotMember.count == 0{
                  heightTblGuest.constant = 0
                  tblGuest.reloadData()
              }
              else{
                  let numberOfLines = (arrBookedSlotMember.count)+1
                  heightTblGuest.constant = CGFloat(40*numberOfLines)
                  tblGuest.reloadData()
              }
          }
    // MARK:- My order Table  Height
          func configSlotMemberCollectionHeight(){
              if arrSpecialRequest.count == 0{
                  heightSpecialRequestCollection.constant = 0
                  heightViewBackSpecialRequest.constant = 0
                  collectionAddSpecialRequest.reloadData()
              }
              else{
                  let numberOfLines = (arrSpecialRequest.count/2)+1
                  heightSpecialRequestCollection.constant = CGFloat(60*numberOfLines)
                  heightViewBackSpecialRequest.constant = 49 + CGFloat(60*numberOfLines)
                  collectionAddSpecialRequest.reloadData()
              }
          }
    
    
    // MARK: - Table Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBookedSlotMember.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblGuest.dequeueReusableCell(withIdentifier: "AddGuestTableCell", for: indexPath) as! AddGuestTableCell
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DiningAddMemberGuestPopUpVC") as? DiningAddMemberGuestPopUpVC
        vc?.delegateSelectedMemberType = self
        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
    
    
    // MARK: - Collection Methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSpecialRequest.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckboxCell", for: indexPath as IndexPath) as! CheckBoxCustomCell
        cell.btnCheckBox.setTitle("testing", for: .normal)
//        if  self.arrSpecialRequest[indexPath.row].isChecked == 1{
//          cell.btnMarketCheckBox.setImage(UIImage(named: "Group 2130"), for: UIControlState.normal)
//          }
//      else{
//          cell.btnMarketCheckBox.setImage(UIImage(named: "CheckBox_uncheck"), for: UIControlState.normal)
//
//
//      }
        
        return cell
    }
    
}
 