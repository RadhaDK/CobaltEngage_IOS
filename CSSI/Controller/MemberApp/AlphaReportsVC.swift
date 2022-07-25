//
//  AlphaReportsVC.swift
//  CSSI
//
//  Created by apple on 11/7/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class AlphaReportsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var alphaReportsTable: UITableView!
    
    @IBOutlet weak var alphaSearch: UISearchBar!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//    var AlphaReportDetails: AlphaDetails? = nil
//    var golfAlphaList : [GolfAlphaData] = []
    var golfAlphaList = [GolfAlphaData]()
    var isDataLoading:Bool=false
    var pageNo:Int = 1
    var limit:Int = 100

    var date: String?
    override func viewDidLoad() {
        super.viewDidLoad()
       self.navigationItem.title = self.appDelegate.masterLabeling.aLPHA_REPORTS ?? "" as String

        // Do any additional setup after loading the view.
        alphaSearch.searchBarStyle = .default
        
        alphaSearch.layer.borderWidth = 1
        alphaSearch.layer.borderColor = hexStringToUIColor(hex: "F5F5F5").cgColor
        
        
        alphaSearch.placeholder = self.appDelegate.masterLabeling.sEARCH_MEMBER_LASTNAMECOURSE ?? ""

        self.loadAlphaReportDetails()
        
        
        let textFieldInsideUISearchBar = alphaSearch.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.textColor = hexStringToUIColor(hex: "695B5E")
        textFieldInsideUISearchBar?.font = textFieldInsideUISearchBar?.font?.withSize(16)
        
        let textFieldInsideUISearchBarLabel = textFieldInsideUISearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideUISearchBarLabel?.textColor = hexStringToUIColor(hex: "695B5E")
        
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton

        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
    //ENGAGE0011297 -- Start
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
    }
    //ENGAGE0011297 -- End
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    func loadAlphaReportDetails() {
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        let params: [String : Any] = [
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            "AlphaDate": date ?? "",
            "Searchby": alphaSearch.text ?? "",
            "PageCount": self.pageNo,
            "RecordsPerPage":self.limit,
            
            ]
        
        APIHandler.sharedInstance.alphaDetailsList(paramaterDict: params, onSuccess: { memberLists in
            self.appDelegate.hideIndicator()
           // self.golfAlphaList.removeAll()
            if(memberLists.responseCode == InternetMessge.kSuccess)
            {
                
                if memberLists.golfAlphaData?.count == 0{
                    self.alphaReportsTable.setEmptyMessage(InternetMessge.kNoData)

                }else{
                self.alphaReportsTable.setEmptyMessage("")
                self.golfAlphaList = self.golfAlphaList + memberLists.golfAlphaData! 
                }
                self.alphaReportsTable.reloadData()

            }else{
                self.appDelegate.hideIndicator()
                if(((memberLists.responseMessage?.count) ?? 0)>0){
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: memberLists.responseMessage, withDuration: Duration.kMediumDuration)
                }
            }
        },onFailure: { error  in
            self.appDelegate.hideIndicator()
            print(error)
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
        })
    }
    
    //Mark- Pagination Logic
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // print("scrollViewDidEndDecelerating")
    }
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        // print("scrollViewDidEndDragging")
        if !decelerate {
            //didEndDecelerating will be called for sure
            return
        }
        else {
        if ((alphaReportsTable.contentOffset.y + alphaReportsTable.frame.size.height) >= alphaReportsTable.contentSize.height)
        {
            
            if !isDataLoading{
                if golfAlphaList.count > 99{
                    isDataLoading = true
                    self.pageNo=self.pageNo+1
                    
                    loadAlphaReportDetails()
                }
               
                
            }
        }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isDataLoading = false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  golfAlphaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? GuestCardTableViewCell {

            let placeholder:UIImage = UIImage(named: "avtar")!
            
            //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
            //ENGAGE0011419 -- Start
            let imageURLString = golfAlphaList[indexPath.row].profilePic ?? ""
            
            if imageURLString.isValidURL()
            {
                let url = URL.init(string:imageURLString)
                cell.iconImageView.sd_setImage(with: url , placeholderImage: placeholder)
            }
            else
            {
                cell.iconImageView.image = UIImage(named: "avtar")!
            }
            /*
            if((imageURLString?.count)!>0){
                let validUrl = self.verifyUrl(urlString: imageURLString)
                if(validUrl == true){
                    let url = URL.init(string:imageURLString!)
                    cell.iconImageView.sd_setImage(with: url , placeholderImage: placeholder)
                }
            }
            else{
                cell.iconImageView.image = UIImage(named: "avtar")!
            }
            */
            //ENGAGE0011419 -- End
            
            cell.nameLabel.text = golfAlphaList[indexPath.row].playerName
            cell.relationLabel.text = String(format: "%@ %@", self.appDelegate.masterLabeling.tEE_COLON ?? "",golfAlphaList[indexPath.row].holes ?? "")
            cell.memberIDLabel.text = golfAlphaList[indexPath.row].time
            cell.validityLabel.text = golfAlphaList[indexPath.row].course
            
            
            cell.iconImageView.layer.cornerRadius = cell.iconImageView.frame.size.width / 2
            cell.iconImageView.layer.masksToBounds = true
         

            return cell

        }
        
        return UITableViewCell()
    }
    
    //Commented by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead
    //ENGAGE0011419 -- Start
//    func verifyUrl(urlString: String?) -> Bool {
//        if let urlString = urlString {
//            if let url = URL(string: urlString) {
//                return UIApplication.shared.canOpenURL(url)
//            }
//        }
//        return false
//    }
    //ENGAGE0011419 -- End
}

extension AlphaReportsVC : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.golfAlphaList.removeAll()
        self.pageNo = 1
       self.loadAlphaReportDetails()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.golfAlphaList.removeAll()
            self.pageNo = 1
            self.loadAlphaReportDetails()
            
        }
    }
    
}


