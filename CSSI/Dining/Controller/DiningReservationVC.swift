//
//  DiningReservationVC.swift
//  CSSI
//
//  Created by Aks on 03/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
import DTCalendarView
import FSCalendar

class DiningReservationVC: UIViewController, UITableViewDelegate,UITableViewDataSource, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, selectedPartySizeTime {
    func SelectedPartysizeTme(PartySize: String, Time: String) {
        if PartySize != ""{
            lblSelectedSizeTime.text = "\(PartySize) * "
            selectedPartySize = PartySize
        }
        if Time != ""{
            lblSelectedSizeTime.text = "\(Time)"

        }
        tblResturat.reloadData()
    }
    
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var tblResturat: UITableView!
    @IBOutlet weak var lblSelectedDate: UILabel!
    @IBOutlet weak var btnSelectedDate: UIButton!
    @IBOutlet weak var viewPrevious: UIView!
    @IBOutlet weak var viewNext: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnPartySize: UIButton!
    @IBOutlet weak var lblSelectedSizeTime: UILabel!
    
    
    var showNavigationBar = true
    var nameOfMonth : String?
    var currentMonth : Date?
    var isDateChanged : String?
    var isDateSelected : Bool?
    var myCalendar: FSCalendar!
    var currentDate = Date()
    var selectedPartySize : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblResturat.delegate = self
        tblResturat.dataSource  = self
        self.btnSelectedDate.setTitle("", for: UIControlState.normal)
        shadowView(viewName: viewTime)
        shadowView(viewName: viewPrevious)
        shadowView(viewName: viewDate)
        shadowView(viewName: viewNext)
        btnBack.setTitle("", for: .normal)
        btnHome.setTitle("", for: .normal)
        
        let date = Date()
        currentDate = date
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        lblSelectedDate.text = formattedDate
        btnPartySize.setTitle("", for: .normal)
        registerNibs()
    }
    func registerNibs(){
        let homeNib = UINib(nibName: "DiningResvTableCell" , bundle: nil)
        self.tblResturat.register(homeNib, forCellReuseIdentifier: "DiningResvTableCell")
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = !self.showNavigationBar
        
       // self.myCalendar.reloadData()
    }
    
    func shadowView(viewName : UIView){
        viewName.layer.shadowColor = UIColor.black.cgColor
        viewName.layer.shadowOpacity = 0.12
        viewName.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewName.layer.shadowRadius = 6
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSelectPartySize(_ sender: Any) {
        let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "PartySizePopUpVC") as? PartySizePopUpVC
        vc?.delegateSelectedTimePatySize = self
        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func btnHome(_ sender: Any) {
        let homeVC = UIStoryboard.init(name: "MemberApp", bundle: nil).instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    @IBAction func selectDateBtnTapped(sender:UIButton){
        let vc = UIStoryboard(name: "DiningStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DiningRequestSelectResturantDateVC") as? DiningRequestSelectResturantDateVC
        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func btnNextPrevious(_ sender: UIButton) {
        if sender.tag == 1{
            let previousMonth = Calendar.current.date(byAdding: .weekday , value: -1, to: currentDate)
            currentDate = previousMonth!
            let format = DateFormatter()
            format.dateFormat = "MM/dd/yyyy"
            let formattedDate = format.string(from: previousMonth!)
            print(formattedDate)
            lblSelectedDate.text = formattedDate
        }
        else{
            let nextMonth = Calendar.current.date(byAdding: .weekday, value: 1, to: currentDate)
            currentDate = nextMonth!
            let format = DateFormatter()
            format.dateFormat = "MM/dd/yyyy"
            let formattedDate = format.string(from: nextMonth!)
            print(formattedDate)
            lblSelectedDate.text = formattedDate
        }
    }
    
    // MARK: - Table Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblResturat.dequeueReusableCell(withIdentifier: "DiningResvTableCell", for: indexPath) as! DiningResvTableCell
        cell.lblPartySize.text = "Fri, Aug - Party Size:\(selectedPartySize ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let impVC = UIStoryboard.init(name: "DiningStoryboard", bundle: .main).instantiateViewController(withIdentifier: "DinningDetailRestuarantVC") as? DinningDetailRestuarantVC {
            impVC.showNavigationBar = false

            self.navigationController?.pushViewController(impVC, animated: true)
        }
    }
}
