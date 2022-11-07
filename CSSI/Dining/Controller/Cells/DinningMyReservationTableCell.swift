//
//  DinningMyReservationTableCell.swift
//  CSSI
//
//  Created by Aks on 02/11/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
protocol EventsCellDelegateDinning: AnyObject {
    func shareButtonClicked(cell: DinningMyReservationTableCell)
    func synchButtonClicked(cell: DinningMyReservationTableCell)
    func registrationButtonClicked(cell: DinningMyReservationTableCell)
    func externalLinkClicked(cell: DinningMyReservationTableCell)
    func imgDetailViewClicked(cell: DinningMyReservationTableCell)
    func viewOnlyClickedClicked(cell: DinningMyReservationTableCell)
    func cancelClicked(cell: DinningMyReservationTableCell)
    //Added on 15th October 2020 V2.3
    func nameClicked(cell : DinningMyReservationTableCell)
}



class DinningMyReservationTableCell: UITableViewCell {
    
    @IBOutlet weak var lblPartySize: UILabel!
    @IBOutlet weak var lblStatusColor: UILabel!
    @IBOutlet weak var lblEventID: UILabel!
    @IBOutlet weak var lblMyConfirmationNo: UILabel!
    @IBOutlet weak var eventIDWidth: NSLayoutConstraint!
    @IBOutlet weak var sectionContentView: UIView!
    @IBOutlet weak var imgEventImage: UIImageView!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblEventPlace: UILabel!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventTime: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var viewShare: UIView!
    @IBOutlet weak var viewSynch: UIView!
    @IBOutlet weak var btnSynch: UIButton!
    @IBOutlet weak var btnEventStatus: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnModify: UIButton!

    @IBOutlet weak var lblExternalLink: UILabel!
    @IBOutlet weak var btnExternallink: UIButton!
    @IBOutlet weak var lblExternalRegText: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var heightTopView: NSLayoutConstraint!
   // @IBOutlet weak var statusWidth: NSLayoutConstraint!
    @IBOutlet weak var statusHeight: NSLayoutConstraint!
    @IBOutlet weak var heightPartySize: NSLayoutConstraint!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var regStatus: UILabel!
    @IBOutlet weak var lblWeekDay: UILabel!
    
    @IBOutlet weak var btnViewOnly: UIButton!
    ///View that holds register and  view only button
    ///
    /// Warning : Dont use in calendar of events My tab and golf calendar My Tab vc . if used app will crash
    @IBOutlet weak var viewBttns: UIView!
    
    //Added on 18th June 2020
   // @IBOutlet weak var btnCancel: UIButton!
    
    //Added on 15th OCtober 2020 V2.3
    @IBOutlet weak var eventNameBtn: UIButton!
    @IBOutlet weak var eventId: UILabel!
    
   // weak var delegate: buttonActionDinning?
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    var clickedDinningModifyClosure:(()->())?
    var clickedDinningancelClosure:(()->())?
    var clickedDinningShareClosure:(()->())?
    var clickedDinningSyncClosure:(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        sectionContentView.layer.shadowColor = UIColor.black.cgColor
        sectionContentView.layer.shadowOpacity = 0.25
        sectionContentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        sectionContentView.layer.shadowRadius = 2
        
        //Modified by kiran V1.4 -- PROD0000113 -- commented selected Segment comparision as its causing an issue where image click is not working
        //PROD0000113 -- Start
        if /*self.appDelegate.selectedSegment == "0" ||*/self.imgEventImage == nil
        {//PROD0000113 -- End
            
        }
        else
        {
            let imgView = UITapGestureRecognizer(target: self, action:  #selector(self.imgClicked(sender:)))
            self.imgEventImage.isUserInteractionEnabled = true
            self.imgEventImage.addGestureRecognizer(imgView)
        }
        
        self.lblStatusColor.layer.cornerRadius = self.lblStatusColor.frame.size.width/2
        self.lblStatusColor.clipsToBounds = true
        self.lblStatusColor.layer.borderWidth = 0.5
        self.lblStatusColor.layer.borderColor = hexStringToUIColor(hex: "3D3D3D").cgColor
        
        btnCancel.backgroundColor = .clear
        btnCancel.layer.cornerRadius = 15
        btnCancel.layer.borderWidth = 1
        btnCancel.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        self.btnCancel.setStyle(style: .outlined, type: .primary)
        
        
        
        btnModify.backgroundColor = .clear
        btnModify.layer.cornerRadius = 15
        btnModify.layer.borderWidth = 1
        btnModify.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        self.btnModify.setStyle(style: .outlined, type: .primary)
        
        
        
        btnViewOnly.backgroundColor = .clear
        btnViewOnly.layer.cornerRadius = 15
        btnViewOnly.layer.borderWidth = 1
        btnViewOnly.layer.borderColor = hexStringToUIColor(hex: "F37D4A").cgColor
        self.btnViewOnly.setStyle(style: .outlined, type: .primary)
//        let sharegesture = UITapGestureRecognizer(target: self, action:  #selector(self.share(sender:)))
//        self.viewShare.addGestureRecognizer(sharegesture)
//
//        let synchgesture = UITapGestureRecognizer(target: self, action:  #selector(self.synch(sender:)))
//        self.viewSynch.addGestureRecognizer(synchgesture)
        
        if (UserDefaults.standard.string(forKey: UserDefaultsKeys.synchCalendar.rawValue) == "1"){
            self.btnSynch.isHidden = false
        }
        else{
            self.btnSynch.isHidden = true
            
        }
        
        for i in 0 ..< appDelegate.arrShareUrlList.count {
            if(appDelegate.arrShareUrlList[i].name == "Events"){
                self.btnShare.isHidden = false
                if (UserDefaults.standard.string(forKey: UserDefaultsKeys.shareUrl.rawValue) == "1"){
                    self.btnShare.isHidden = false
                }
                else{
                    self.btnShare.isHidden = true

                }
                return
            }
            else{
                self.btnShare.isHidden = true

                
                
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @objc func imgClicked(sender : UITapGestureRecognizer) {
    //    delegate?.imgDetailViewClicked(cell: self)

    }

    
    @IBAction func btnCancelClicked(_ sender: Any) {
        clickedDinningancelClosure?()
    }
    @IBAction func btnModifyClicked(_ sender: Any) {
        clickedDinningModifyClosure?()
    }
    
    @IBAction func externalLinkClicked(_ sender: Any) {
        //delegate?.externalLinkClicked(cell: self)
        
    }
    @IBAction func shareButtonClicked(_ sender: Any) {
        clickedDinningShareClosure?()
      //  delegate?.shareButtonClicked(cell: self)

    }
    @IBAction func synchClicked(_ sender: Any) {
        clickedDinningSyncClosure?()
       // delegate?.synchButtonClicked(cell: self)

    }
    @IBAction func registrationClicked(_ sender: Any) {
        
        //delegate?.registrationButtonClicked(cell: self)

    }
    
    //Added on 15th October 2020 V2.3
    @IBAction func eventNameClicked(_ sender: UIButton)
    {
///self.delegate?.nameClicked(cell: self)
    }
    
    
    @IBAction func viewOnlyClicked(_ sender: UIButton)
    {
       // self.delegate?.viewOnlyClickedClicked(cell: self)
    }
    
    

    @IBAction func cancelClicked(_ sender: UIButton) {
       // self.delegate?.cancelClicked(cell: self)
    }

}
