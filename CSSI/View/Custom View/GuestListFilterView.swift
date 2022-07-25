//
//  GuestListFilterView.swift
//  CSSI
//
//  Created by Prashamsa on 30/09/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

enum DateFilter : Int{
    case None = -1
    case NewestToOldest = 0
    case OldestToNewest = 1
    case NotYetOpen = 2
    case RegistrationOpen = 3
    case RegistrationClosed = 4
    case NoRegistration = 5

    func displayName() -> String {
        switch self {
        case .None:
            return ""
        case .NewestToOldest:
            return "Newest to Oldest"
        case .OldestToNewest:
            return "Oldest to Newest"
        case .NotYetOpen:
            return "Not Yet Open"
        case .RegistrationOpen:
            return "Registration Open"
        case .RegistrationClosed:
            return "Registration Closed"
        case .NoRegistration:
            return "No Registration"
        }
    }
    
    func value() -> String {
        switch self {
        case .None:
            return ""
        case .NewestToOldest:
            return "NewToOld"
        case .OldestToNewest:
            return "OldToNew"
        case .NotYetOpen:
            return "NotYetOpen"
        case .RegistrationOpen:
            return "RegistrationOpen"
        case .RegistrationClosed:
            return "RegistrationClosed"
        case .NoRegistration:
            return "NoRegistration"
        }
    }
}

//Commented by kiran V3.0 -- ENGAGE0011843 -- Replacing hard coded value with arr received from masterlist
//ENGAGE0011843 -- Start
/*
enum RelationFiler : Int
{
    case None = -1
    case All = 0
    case OffSpring = 1
    case Guest = 2

    func displayName() -> String {
        switch self {
        case .None:
            return ""
        case .All:
            return "All"
        case .OffSpring:
            return "OffSpring"
        case .Guest:
            return "Guest"
        }
    }

    func value() -> String {
        switch self {
        case .None:
            return ""
        case .All:
            return "All"
        case .OffSpring:
            return "OF"
        case .Guest:
            return "GU"
        }
    }
}
*/
//ENGAGE0011843 -- End

enum EventsFilter : Int {
    case None = -1
    case All = 0
    case Social = 1
    case Golf = 2
    case Tennis = 3
    case Dining = 4
    case Fitness = 5
    case Shoppes = 6
    
    func displayName() -> String {
        switch self {
        case .None:
            return ""
        case .All:
            return "All"
        case .Social:
            return "Social"
        case .Golf:
            return "Golf"
        case .Tennis:
            return "Tennis"
        case .Dining:
            return "Dining"
        case .Fitness:
            return "Fitness & Spa"
        case .Shoppes:
            return "Shoppes"
        }
    }
    
    func value() -> Int {
        switch self {
        case .None:
            return -1
        case .All:
            return 0
        case .Social:
            return 1
        case .Golf:
            return 2
        case .Tennis:
            return 3
        case .Dining:
            return 4
        case .Fitness:
            return 5
        case .Shoppes:
            return 6
       
        }
    }
}


struct GuestCardFilter {
    var date: DateFilter = .None
    //Added by kiran V3.0 -- ENGAGE0011843 -- Replacing enum with empty relations array object
    //ENGAGE0011843 -- Start
    var relation: RelationFilter = RelationFilter.init()
    //var relation: RelationFiler = .None
    //ENGAGE0011843 -- End
    var department: EventsFilter = .None
    var status: EventStatusFilter = EventStatusFilter()
}



enum FilterOptions : Int{
    case Date = 0
    case Relation = 2
    case Department = 1
    case status = 3
}

protocol GuestListFilterViewDelegate : class {
    func guestCardFilterApply(filter : GuestCardFilter)
    func guestCardFilterClose()
}

class GuestListFilterView: UIView {
    var isFromGuest : NSInteger!
    var filterWith : String!
    var filterWithDate : String!
    var filterWithDepartment : String!
    
    var filterWithEventStatus : EventStatusFilter!{
        didSet{
            self.filter.status = self.filterWithEventStatus
        }
    }
    
    @IBOutlet weak var departmentView: UIView!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var optionsTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnRelation: UIButton!
    @IBOutlet weak var lblRelation: UILabel!
   // var intrinsicContentSize: CGSize

    weak var delegate: GuestListFilterViewDelegate? = nil
    //Commented by kiran V3.0 -- ENGAGE0011843 -- declaring the variable as Var instead of  filePrivate var to have access to the filter
    //ENGAGE0011843 -- Start
    var filter : GuestCardFilter = GuestCardFilter()
    //ENGAGE0011843 -- End
    
    fileprivate var selectedFilterOption : FilterOptions = .Date
    var eventsArrayFilter = [ListEventCategory]()
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var isFrom : NSString!
    var showStatusFilter = false
    override func awakeFromNib() {
        super.awakeFromNib()
        
        doneButton.layer.cornerRadius = doneButton.bounds.size.height / 2
        doneButton.layer.borderWidth = 1.0
        
        doneButton.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
        optionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        isFrom = "First"
        
        btnDate.titleLabel?.font = SFont.SourceSansPro_Semibold18
        btnRelation.titleLabel?.font = SFont.SourceSansPro_Semibold16
        doneButton.setTitle(self.appDelegate.masterLabeling.done ?? "" as String, for: .normal)
        btnReset.setTitle(self.appDelegate.masterLabeling.rESET ?? "" as String, for: .normal)
        
        self.lblDate.backgroundColor = APPColor.MainColours.primary2
        self.lblRelation.backgroundColor = APPColor.MainColours.primary2
        self.doneButton.setStyle(style: .outlined, type: .primary)
       
    }
    

    func viewDidLayoutSubviews() {
        //print(GuestListFilterView.self.si)
    }

    
    @IBAction func dateClicked(_ sender: Any) {
        self.lblRelation.isHidden = true
        self.lblDate.isHidden = false
        
        btnDate.titleLabel?.font = SFont.SourceSansPro_Semibold18
        btnRelation.titleLabel?.font = SFont.SourceSansPro_Semibold16
        
        selectedFilterOption = FilterOptions(rawValue: 0) ?? .Date
     //   frame.size.height = 290
        superview?.frame.size.height = 290

        optionsTableView.reloadData()
        
    }
    
    @IBAction func relationClicked(_ sender: Any) {
        
        self.lblRelation.isHidden = false
        self.lblDate.isHidden = true
        btnDate.titleLabel?.font = SFont.SourceSansPro_Semibold16
        btnRelation.titleLabel?.font = SFont.SourceSansPro_Semibold18

        
        if isFromGuest == 1 {
            selectedFilterOption = FilterOptions(rawValue: 2) ?? .Relation
           // frame.size.height = 290
            superview?.frame.size.height = 330


        }
        else{
//            selectedFilterOption = FilterOptions(rawValue: 1) ?? .Department
//         //   frame.size.height = 400
//            superview?.frame.size.height = 450

            
        }
        
        if showStatusFilter
        {
            selectedFilterOption = FilterOptions(rawValue: 3) ?? .status
            superview?.frame.size.height = 220 + (self.optionsTableView.rowHeight * CGFloat(self.appDelegate.arrEventStatusFilter.count))
            
        }

        
        optionsTableView.reloadData()
        
    }
    @IBAction func onTapDone(_ sender: Any) {
        delegate?.guestCardFilterApply(filter: filter)
    }
    
    @IBAction func onTapReset(_ sender: Any) {
        filter.date = .None
        
        //Added by kiran V3.0 -- ENGAGE0011843 -- Replacing enum with empty relations array object
        //ENGAGE0011843 -- Start
        filter.relation = self.appDelegate.arrRelationFilter.first ?? RelationFilter()
        //filter.relation = .None
        //filterWith = ""
        //ENGAGE0011843 -- End
        filter.department = .None
        filter.status = EventStatusFilter()
        isFrom = "First"
        filterWithDate = ""
        filterWithDepartment = ""
        filterWithEventStatus = EventStatusFilter()
        optionsTableView.reloadData()
        
    }
    
    @IBAction func onTapClose(_ sender: Any) {
        delegate?.guestCardFilterClose()
    }
}

extension GuestListFilterView : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch selectedFilterOption {
        case .Date:
            if self.appDelegate.filterFrom == "COE"{
                return self.appDelegate.arrCalenderSortFilter.count
            }else{
            return 2
            }
        case .Relation:
            //Added by kiran V3.0 -- ENGAGE0011843 -- Getting the count from array instead of hard coded value
            //ENGAGE0011843 -- Start
            return self.appDelegate.arrRelationFilter.count
            //return 3
            //ENGAGE0011843 -- End
        case .Department:
            return eventsArrayFilter.count
        case .status:
            return self.appDelegate.arrEventStatusFilter.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        btnDate.setTitle(self.appDelegate.masterLabeling.date ?? "" as String, for: .normal)

        if isFromGuest == 1 {
            btnRelation.setTitle(self.appDelegate.masterLabeling.relation ?? "" as String, for: .normal)
        }
            
        else{
            btnRelation.setTitle("", for: .normal)
            btnRelation.isEnabled = false

        }
        
        if self.showStatusFilter
        {
            //FIXME:- Add string form language api
            btnRelation.setTitle(self.appDelegate.masterLabeling.EVENT_STATUSFILTER ?? "", for: .normal)
            btnRelation.isEnabled = true
        }
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            var targetString = ""
            var cellDisplayName = ""
            switch selectedFilterOption {
            case .Date:
                if let type = DateFilter(rawValue: indexPath.row) {
                    targetString = type.displayName()
                    if (targetString == filterWithDate){
                        filter.date = DateFilter(rawValue: indexPath.row) ?? .None
                    }
                    if (isFrom == "First" && indexPath.row == 0 && (isFromGuest == 1 || isFromGuest == 2) && (filterWithDate == nil || filterWithDate == "")) || ((isFromGuest != 1 && isFromGuest != 2) && indexPath.row == 1 && isFrom == "First"  && (filterWithDate == nil || filterWithDate == "")){
                        
                    filter.date = DateFilter(rawValue: indexPath.row) ?? .None
                    }
                   if self.appDelegate.filterFrom == "COE"{
                    cellDisplayName = appDelegate.arrCalenderSortFilter[indexPath.row].name ?? ""

                   }else{
                    cellDisplayName = appDelegate.arrDateSort[indexPath.row].name ?? ""
                    }
                    cell.accessoryType = filter.date == type ? .checkmark : .none
                }
//                if self.appDelegate.filterFrom == "COE"{
//                    cellDisplayName = appDelegate.arrCalenderSortFilter[indexPath.row].name ?? ""
//                    
//                }
                
            case .Relation:
                
                //Added by kiran V3.0 -- ENGAGE0011843 -- Replacing enum with empty relations array object
                //ENGAGE0011843 -- Start
                let relation = self.appDelegate.arrRelationFilter[indexPath.row]
                cellDisplayName = relation.relationName ?? ""
                cell.accessoryType = (self.filter.relation.relationID == relation.relationID) ? .checkmark : .none
               
                //Old Logic
                /*
                if let type = RelationFiler(rawValue: indexPath.row)
                {
                    targetString = type.displayName()
                    if (targetString == filterWith){
                        filter.relation = RelationFiler(rawValue: indexPath.row) ?? .None
                    }
                    if (isFrom == "First" && indexPath.row == 0 && isFromGuest == 1 && (filterWith == nil || filterWith == "" )) || (isFromGuest != 1 && indexPath.row == 1 && isFrom == "First"  && (filterWith == nil || filterWith == "" )){
                        
                        filter.relation = RelationFiler(rawValue: indexPath.row) ?? .None
                        
                    }
                   
                    cellDisplayName = appDelegate.arrRelationFilter[indexPath.row].relationName ?? ""

                    cell.accessoryType = filter.relation == type ? .checkmark : .none
                    
                }
                */
            //ENGAGE0011843 -- End
            case .Department:
                if let type = EventsFilter(rawValue: indexPath.row) {
                    targetString = type.displayName()
                    
                    if (targetString == filterWithDepartment){
                        filter.department = EventsFilter(rawValue: indexPath.row) ?? .None
                    }
                    
                   if (isFrom == "First" && indexPath.row == 0 && (isFromGuest == 0 || isFromGuest == 2) && (filterWithDepartment == nil || filterWithDepartment == "" )){
                        
                        filter.department = EventsFilter(rawValue: indexPath.row) ?? .None
                    }
                    cell.accessoryType = filter.department == type ? .checkmark : .none
                    cellDisplayName = eventsArrayFilter[indexPath.row].categoryName!

                }
                
            case .status:
                
                let filter = self.appDelegate.arrEventStatusFilter[indexPath.row]
                
                cell.accessoryType = filter.id == self.filterWithEventStatus.id ? .checkmark : .none
                cellDisplayName = filter.name ?? ""
            }
            
            cell.textLabel?.text = cellDisplayName
            cell.textLabel?.textColor = hexStringToUIColor(hex: "695B5E")
            cell.textLabel?.font = SFont.SourceSansPro_Semibold16
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35.0;
    }
}

extension GuestListFilterView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isFrom = ""
        //Commented by kiran V3.0 -- ENGAGE0011843 -- Replacing the use of filterWith with filter.relation
        //ENGAGE0011843 -- Start
        //filterWith = ""
        //ENGAGE0011843 -- End
        filterWithDate = ""
        filterWithDepartment = ""
        switch selectedFilterOption {
        case .Date:
            filter.date = DateFilter(rawValue: indexPath.row) ?? .None
        case .Relation:
            
            //Added by kiran V3.0 -- ENGAGE0011843 -- Replacing enum with empty relations array object
            //ENGAGE0011843 -- Start
            self.filter.relation = self.appDelegate.arrRelationFilter[indexPath.row]
            //filter.relation = RelationFiler(rawValue: indexPath.row) ?? .None
            //ENGAGE0011843 -- End
            
        case .Department:
            filter.department = EventsFilter(rawValue: indexPath.row) ?? .None
        case .status:
            filter.status = self.appDelegate.arrEventStatusFilter[indexPath.row]
            filterWithEventStatus = self.appDelegate.arrEventStatusFilter[indexPath.row]
        }
        tableView.reloadData()
        
    }
}


