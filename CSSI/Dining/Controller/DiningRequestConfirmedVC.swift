//
//  DiningRequestConfirmedVC.swift
//  CSSI
//
//  Created by Aks on 06/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit

class DiningRequestConfirmedVC: UIViewController, UITableViewDelegate,UITableViewDataSource {

    
    //MARK: - IBOutlets
    @IBOutlet weak var roundedBgView: UIView!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var reservationConfirmedDateLbl: UILabel!
    @IBOutlet weak var preferredReservationTimeLbl: UILabel!
    @IBOutlet weak var partySizeCountLbl: UILabel!
    @IBOutlet weak var partyName: UILabel!
    @IBOutlet weak var tblReservedGuest: UITableView!
    @IBOutlet weak var heightTblGuest: NSLayoutConstraint!
    @IBOutlet weak var heightBackReservationpopup: NSLayoutConstraint!
    
    
    //MARK: - Variables
    var showNavigationBar = true
    var reservationDetails = DinningReservationFCFS.init()
    var arrBookedSlotMember = ["Lia Little"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundedBgView.clipsToBounds = true
        roundedBgView.layer.cornerRadius = 15
        tblReservedGuest.delegate = self
        tblReservedGuest.dataSource  = self
        btnHome.setTitle("", for: .normal)
        configSlotMemberTblHeight()
        self.initialSetup()
    }
    
    func initialSetup() {
        self.partySizeCountLbl.text = "Party Size (\(self.reservationDetails.PartySize))"
        self.preferredReservationTimeLbl.text = "Preferred Reservation: " + self.reservationDetails.SelectedTime
        self.reservationConfirmedDateLbl.text = self.reservationDetails.responseMessage
    }

    
    //MARK: - IBActions
    @IBAction func homeBtnTapped(sender:UIButton){
        self.navigationController?.popToRootViewController(animated: true)
        
//        for controller in self.navigationController!.viewControllers as Array {
//
//            if controller.isKind(of: DiningReservationViewController.self) {
//                self.navigationController!.popToViewController(controller, animated: true)
//                break
//            }
//
//        }
    }
    
    // MARK: - My order Table  Height
          func configSlotMemberTblHeight(){
              if arrBookedSlotMember.count == 0{
                  heightTblGuest.constant = 0
                  heightBackReservationpopup.constant = 386
              }
              else{
                  let numberOfLines = (arrBookedSlotMember.count)+1
                  heightTblGuest.constant = CGFloat(40*numberOfLines)
                  heightBackReservationpopup.constant = (386+heightTblGuest.constant)-40
              }
              tblReservedGuest.reloadData()

          }
    // MARK: - Table Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reservationDetails.PartyDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblReservedGuest.dequeueReusableCell(withIdentifier: "DinningReservedTableViewCell", for: indexPath) as! DinningReservedTableViewCell
        cell.lblName.text = self.reservationDetails.PartyDetails[indexPath.row].MemberName
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
