//
//  MembershiphHistoryFilterPopUpView.swift
//  CSSI
//
//  Created by Aks on 15/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import Foundation
import UIKit


protocol selectedHistoryFilter{
    func selectedFilterHistory(type: String)
}

class MembershiphHistoryFilterPopUpView: UIView, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tblFilterHistory: UITableView!
    @IBOutlet weak var lblFilterHeading: UILabel!
    @IBOutlet weak var btnDismiss: UIButton!
    @IBOutlet weak var doneButton: UIButton!

    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var delegateHistoryFilter : selectedHistoryFilter?
    var arrForFilterOption : [statusListing]?
    weak var delegate: GuestListFilterViewDelegate? = nil
    var selectedRow = 0
    var selectedFilter : String?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doneButton.layer.cornerRadius = doneButton.bounds.size.height / 2
        doneButton.layer.borderWidth = 1.0
        doneButton.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
        self.doneButton.setStyle(style: .outlined, type: .primary)
        btnDismiss.setTitle("", for: .normal)
        tblFilterHistory.delegate = self
        tblFilterHistory.dataSource  = self
        
        registerNibs()
    }

    func registerNibs(){
            let homeNib = UINib(nibName: "FilterHistoryTableViewCell" , bundle: nil)
           self.tblFilterHistory.register(homeNib, forCellReuseIdentifier: "FilterHistoryTableViewCell")
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForFilterOption?.count ?? 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblFilterHistory.dequeueReusableCell(withIdentifier: "FilterHistoryTableViewCell", for: indexPath) as! FilterHistoryTableViewCell
        let dict = arrForFilterOption?[indexPath.row]
        cell.lblFilterType.text = dict?.Value
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
            for cell in tableView.visibleCells { //Why not using didDeselectRowAt? Because the default selected row(like row 0)'s checkmark will NOT be removed when clicking another row at very beginning.
                cell.accessoryType = .none
            }
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        let dict = arrForFilterOption?[indexPath.row]
        selectedFilter = dict?.Value
//        self.dismiss(animated: true)

    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.accessoryType = indexPath.row == selectedRow ? .checkmark : .none
    }
    @IBAction func btnDismiss(_ sender: Any) {
        delegate?.guestCardFilterClose()
    }
    @IBAction func onTapDone(_ sender: Any) {
        if selectedFilter != nil{
            delegateHistoryFilter?.selectedFilterHistory(type: selectedFilter ?? "")

        }
        else{
            delegateHistoryFilter?.selectedFilterHistory(type: arrForFilterOption?[0].Value ?? "")

        }
        delegate?.guestCardFilterClose()
    }
}
