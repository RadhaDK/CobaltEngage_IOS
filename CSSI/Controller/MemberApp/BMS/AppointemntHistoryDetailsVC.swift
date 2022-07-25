//
//  AppointemntHistoryDetailsVC.swift
//  CSSI
//
//  Created by Kiran on 30/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class AppointemntHistoryDetailsVC: UIViewController
{

    @IBOutlet weak var historyDetailView: UIView!
    @IBOutlet weak var detailTblView: UITableView!
    @IBOutlet weak var btnClose: UIButton!
    
    var appointmentHistory = AppointMentHistoryDetails()
    
    //Added by kiran V2.8 -- GATHER0001149
    //GATHER0001149 -- Start
    var BMSDepartment : BMSDepartment = .none
    var DepartmentName : String?
    //GATHER0001149 -- End
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initialSetup()
    }

    
    @IBAction func closeClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

//MARK:- Custom methods
extension AppointemntHistoryDetailsVC
{
    private func initialSetup()
    {
        self.detailTblView.delegate = self
        self.detailTblView.dataSource = self
        self.detailTblView.estimatedRowHeight = 20
        self.detailTblView.rowHeight = UITableViewAutomaticDimension
        
        self.detailTblView.estimatedSectionHeaderHeight = 30
        self.detailTblView.sectionHeaderHeight = UITableViewAutomaticDimension
        
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        footerView.backgroundColor = .clear
        self.detailTblView.tableFooterView = footerView
        
        self.detailTblView.separatorStyle = .none//separatorInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        self.detailTblView.register(UINib.init(nibName: "AppointmentHisotryDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "AppointmentHisotryDetailTableViewCell")
        
        self.historyDetailView.layer.cornerRadius = 10
        self.historyDetailView.clipsToBounds = true
    }
}


extension AppointemntHistoryDetailsVC : UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let view = Bundle.main.loadNibNamed("AppointmentHistoryHeaderView", owner: self, options: [:])?.first as! AppointmentHistoryHeaderView
        
        view.lbldate.text = self.appointmentHistory.appointmentDate
        view.lblConfirmationNunber.text = self.appointmentHistory.confirmationNumber
        view.lblService.text = self.appointmentHistory.serviceName
        view.lblDuration.text = self.appDelegate.masterLabeling.duration_colon
        view.lblDurationValue.text = (self.appointmentHistory.appointmentTime ?? "") + " - " + (self.appointmentHistory.appointmentEndTime ?? "")
        
        //Added by kiran V2.8 -- GATHER0001149
        //GATHER0001149 -- Start
        var commentsHeaderText : String = self.appDelegate.masterLabeling.cOMMENTS_COLON ?? ""
        
        switch self.BMSDepartment
        {
        case .fitnessAndSpa:
            if let departmentName = self.DepartmentName
            {
                if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Fitness!) == .orderedSame
                {
                    commentsHeaderText = self.appDelegate.masterLabeling.BMS_Fitness_Comments_Colon ?? ""
                }
                else if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Spa!) == .orderedSame
                {
                    commentsHeaderText = self.appDelegate.masterLabeling.BMS_Spa_Comments_Colon ?? ""
                }
                else if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Salon!) == .orderedSame
                {
                    commentsHeaderText = self.appDelegate.masterLabeling.BMS_Salon_Comments_Colon ?? ""
                }
                
            }
        case .tennisBookALesson:
            commentsHeaderText = self.appDelegate.masterLabeling.BMS_Tennis_Comments_Colon ?? ""
            //Added by kiran V2.9 -- GATHER0001167 -- Added Golf BAL text support
            //GATHER0001167 -- Start
        case .golfBookALesson:
            commentsHeaderText = self.appDelegate.masterLabeling.BMS_Golf_Comments_Colon ?? ""
            //GATHER0001167 -- End
        case .none:
            break
        }
        view.lblComments.text = commentsHeaderText + " " + (self.appointmentHistory.comments ?? "")
        //view.lblComments.text = self.appDelegate.masterLabeling.cOMMENTS_COLON
        //Stopped using this beacause of the layout issue with the change
        //view.lblCommentsValue.text = self.appointmentHistory.comments
        view.lblCommentsValue.isHidden = true
        //GATHER0001149 -- End
        
        view.clipsToBounds = true
        return view.contentView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appointmentHistory.details?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentHisotryDetailTableViewCell") as! AppointmentHisotryDetailTableViewCell
        
        let detail = self.appointmentHistory.details?[indexPath.row]
        
        //Modified on 7th August 2020 V2.3
        var name = ""
        if let tempName = detail?.name , tempName.count > 0
        {
            name = tempName
        }
        else
        {
            name = detail?.guestName ?? ""
        }
        
        cell.lblName.text = name//detail?.name ?? detail?.guestName
        cell.btnStatus.setTitle(self.appointmentHistory.appointmentStatus, for: .normal)
        cell.btnStatus.backgroundColor = hexStringToUIColor(hex: self.appointmentHistory.statusColor ?? "")
        cell.selectionStyle = .none
        return cell
    }
    
    
}
