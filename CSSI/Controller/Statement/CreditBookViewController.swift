//
//  CreditBookViewController.swift
//  CSSI
//
//  Created by Vishal Pandey on 06/12/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
import Popover

class CreditBookViewController: UIViewController, HorizontalFilterViewDelegate {
    
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var CreditBookDetailsTbl: UITableView!
    @IBOutlet weak var lblCreditBookName: UILabel!
    @IBOutlet weak var lblItemType: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblMemberNameID: UILabel!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrCreditList = [CreditBookTemplate]()
    var filterPopover: Popover? = nil
    private var selectedFilter : SelectedFilter?
    private var defaultFilter : SelectedFilter?
    private var popupView : Popover?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        // Do any additional setup after loading the view.
        self.lblMemberNameID  .text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
//        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
//        self.navigationItem.rightBarButtonItem = homeBarButton
        let filterBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Filter"), style: .plain, target: self, action: #selector(onTapFilter))
        navigationItem.rightBarButtonItem = filterBarButtonItem
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "Credit Book"
        
        self.defaultFilter = SelectedFilter.init(type: .Status, option: self.appDelegate.creditBookStatus.first(where: {$0.Id == "Active"}) ?? FilterOption.init())
        self.selectedFilter = self.defaultFilter
        
        creditBookList()
    }
    // MARK: - IBActions
    @objc private func backBtnAction(sender: UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    @objc func onTapFilter()
    {
        self.showFilterView()
    }
    
    private func showFilterView()
    {
        //Need to give padding as the arrow is created inside the bounds of the view,causing the arrow to be hidden by the content view as it overlaps the arrow.
        let arrowPadding : CGFloat = 20
        let width : CGFloat = self.view.frame.width - 8
        //FIXME:- Make this dynamic height
        let height : CGFloat = 230 + arrowPadding
        
        //Created this view to add padding above the filter view (padding in y).
        let adjustmentView = UIView.init(frame: CGRect.init(x: 4, y: 88, width: width, height: height))
        let filterView = HorizontalFilterView.init(frame: CGRect.init(x: 0, y: arrowPadding, width: adjustmentView.frame.width, height: adjustmentView.frame.height - arrowPadding))
        adjustmentView.addSubview(filterView)
        adjustmentView.backgroundColor = .clear
        
        filterView.show(filter: Filter.init(type: .Status, options: self.appDelegate.creditBookStatus, displayName: self.appDelegate.masterLabeling.EVENT_STATUSFILTER ?? ""))
        filterView.delegate = self
        filterView.selectedFiter = self.selectedFilter
        //Added on 14th October 2020 V2.3
        filterView.defaultFilter = self.defaultFilter
        
        //If not called here filter view is not calling layoutsubviews when collection view is reloaded.
        filterView.layoutSubviews()
        
        self.popupView = Popover()
        popupView?.popoverType = .down
        popupView?.arrowSize = CGSize(width: 28.0, height: 13.0)
        popupView?.sideEdge = 4.0
        let point = CGPoint(x: self.view.bounds.width - 28, y: 55)
        popupView?.show(adjustmentView, point: point)
    }
    
    func closeClicked() {
        self.popupView?.dismiss()
    }
    
    func doneClickedWith(filter: SelectedFilter?) {
        self.selectedFilter = filter
        self.popupView?.dismiss()
        self.creditBookList()
    }

}

// MARK: - TableView Methods
extension CreditBookViewController : UITableViewDelegate, UITableViewDataSource{
    //MARK:- Table delegate & datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCreditList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CreditBookDetailsTbl.dequeueReusableCell(withIdentifier: "CreditBookDetailCell", for: indexPath) as! CreditBookDetailCell
        let dict = arrCreditList[indexPath.row]
        cell.lblCreditBookName.text = dict.CreditBookName
        
      //  cell.lblCreditAmt.text = "$\(dict.CreditAmount ?? 0)"
        cell.lblCreditAmt.text = ""
        //cell.lblItemType.text = dict.ItemType
       // cell.lblItemType.text = ""
       // cell.lblAmtSpent.text = "$\(dict.SpentAmount ?? 0)"
        cell.lblAmtSpent.text = ""
       // cell.lblLocation.text = dict.Location
        cell.lblLocation.text = dict.EndDate
    //    cell.lblCreditBalance.text = "$\(dict.Balance ?? 0)"
        cell.lblCreditBalance.text = String(format: "$%.2f", dict.Balance ?? 0)
        return cell
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transactionHistoryVC = self.storyboard?.instantiateViewController(withIdentifier: "TransactionHistoryViewController") as! TransactionHistoryViewController
        let dict = arrCreditList[indexPath.row]
        transactionHistoryVC.creditBookId = dict.CreditBookID
        transactionHistoryVC.creditBookMemberId = dict.CreditBookMemberID
        transactionHistoryVC.typeOfStatement = .credit
        transactionHistoryVC.templateName = dict.CreditBookName ?? ""
        transactionHistoryVC.minimumTamplateID = dict.CreditBookID ?? ""
        self.navigationController?.pushViewController(transactionHistoryVC, animated: true)
    }
}

// MARK: - API CALLING
extension CreditBookViewController{
    func creditBookList(){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            var paramaterDict:[String: Any] = [:]
            
             paramaterDict = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                APIKeys.status : self.selectedFilter?.option.Id ?? "",
             ]

//            print(paramaterDict)
            APIHandler.sharedInstance.creditBookListingApi(paramater: paramaterDict, onSuccess: { creditListing in
                self.appDelegate.hideIndicator()
                if(creditListing.CreditBookList.count == 0)
                {
                    self.CreditBookDetailsTbl.setEmptyMessage(InternetMessge.kNoData)
                } else {
                    self.CreditBookDetailsTbl.restore()
                }
                self.arrCreditList = creditListing.CreditBookList!
                self.CreditBookDetailsTbl.reloadData()
            },onFailure: { error  in
                print(error)
                self.appDelegate.hideIndicator()
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }else{
            self.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
}
