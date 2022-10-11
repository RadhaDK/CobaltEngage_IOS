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
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPartySize: UILabel!
    @IBOutlet weak var btnAddMultiple: UIButton!
    @IBOutlet weak var imgRestaurantImage: UIImageView!
    
    
    
    var arrBookedSlotMember = ["Lia Little"]
    var arrSpecialRequest = ["Behind lounge area","Close to enterance","Outside","On the Perimeter"]
    var selectedTime : String?
    var selectedPartySize : String?
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
      print(selectedPartySize)
        collectionAddSpecialRequest.delegate = self
        collectionAddSpecialRequest.dataSource  = self
        imgRestuarant.layer.cornerRadius = 8
        txtReservationComment.layer.borderWidth = 1
        txtReservationComment.layer.borderColor = UIColor.lightGray.cgColor
        txtReservationComment.layer.cornerRadius = 8
        btnSubmit.layer.cornerRadius = btnSubmit.layer.frame.height/2
        btnAddMultiple.layer.cornerRadius = btnAddMultiple.layer.frame.height/2
        btnAddMultiple.layer.borderWidth = 1
        btnAddMultiple.layer.borderColor = UIColor(red: 59/255, green: 135/255, blue: 193/255, alpha: 1).cgColor
        btnHome.setTitle("", for: .normal)
        btnBack.setTitle("", for: .normal)
        lblPartySize.text = selectedPartySize
        lblTime.text = selectedTime
        tblGuest.delegate = self
        tblGuest.dataSource  = self
        let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: imgRestaurantImage.frame.size.width, height: imgRestaurantImage.frame.size.height))
        overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
        imgRestaurantImage.addSubview(overlay)
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
    
    
    // MARK:- Slot Table  Height
          func configSlotMemberTblHeight(){
              if selectedPartySize?.count == 0{
                  heightTblGuest.constant = 0
                  tblGuest.reloadData()
              }
              else{
                  let NumberOfSlot = Int(selectedPartySize ?? "0")
                  let numberOfLines = NumberOfSlot ?? 0 + 1
                  heightTblGuest.constant = CGFloat(60*numberOfLines)
                  print(heightTblGuest.constant)
                  tblGuest.reloadData()
              }
          }
    // MARK:- Special Request Collection  Height
          func configSlotMemberCollectionHeight(){
              if arrSpecialRequest.count == 0{
                  heightSpecialRequestCollection.constant = 0
                  heightViewBackSpecialRequest.constant = 0
                  collectionAddSpecialRequest.reloadData()
              }
              else{
                  let numberOfLines = (arrSpecialRequest.count/2)+1
                  heightSpecialRequestCollection.constant = CGFloat(35*numberOfLines)
                  heightViewBackSpecialRequest.constant = 70 + CGFloat(35*numberOfLines)
                  collectionAddSpecialRequest.reloadData()
              }
          }
    
    
    // MARK: - Table Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let NumberOfSlot = Int(selectedPartySize ?? "0")
        return NumberOfSlot ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblGuest.dequeueReusableCell(withIdentifier: "AddGuestTableCell", for: indexPath) as! AddGuestTableCell
        if indexPath.row == 0{
            cell.lblSlotMember.text = UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue)!
        }
        cell.addToSlotClosure = {
            let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DiningAddMemberGuestPopUpVC") as? DiningAddMemberGuestPopUpVC
            vc?.delegateSelectedMemberType = self
            vc?.checkPopupOpenFrom = .addSlot
            self.navigationController?.present(vc!, animated: false, completion: nil)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DiningAddMemberGuestPopUpVC") as? DiningAddMemberGuestPopUpVC
//        vc?.delegateSelectedMemberType = self
//        self.navigationController?.present(vc!, animated: false, completion: nil)
//    }
    
    
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem, height:50)
    }
}
 
