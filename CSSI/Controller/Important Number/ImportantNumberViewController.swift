

import UIKit
import Alamofire
import AlamofireImage
import MessageUI



class ImportantNumberViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchControllerDelegate, UIGestureRecognizerDelegate,MFMailComposeViewControllerDelegate {
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var searchController : UISearchController!
    
    var refreshControl = UIRefreshControl()
    lazy var searchBar:UISearchBar = UISearchBar()
    private var impnoSearchbar: UISearchBar!
    
    @IBOutlet weak var impSearchBar: UISearchBar!
    
    //Tableview declaration
    @IBOutlet weak var tblViewMemberNumber: UITableView!
    var rightSearchbarButton = UIBarButtonItem()
    var arrImpNo = [ImportantNumbers]()
    var dictguest = GuestList()
    
    var arrfilteredImpNo = [ImportantNumbers]()
    var arrselectedEmails = [String]()

    
    
    //Mark - Main method for Viewcontroller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControls()
        self.setColorCode()
        self.initController()
        impSearchBar.placeholder = self.appDelegate.masterLabeling.search_imp_clubNumbers ?? "" as String

        impSearchBar.searchBarStyle = .default
        
        impSearchBar.layer.borderWidth = 1
        impSearchBar.layer.borderColor = hexStringToUIColor(hex: "F5F5F5").cgColor

        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    
    //Mark- Common Color Code
    func setColorCode()
    {
        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg
        
    }
    
    //Mark- Search logic for Giftviewcontroller
//    @objc func searchBarButtonPressed() {
//
//        self.impnoSearchbar.delegate = self
//        self.impnoSearchbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44)     // CGRect(0, 0, 300, 80)
//        if #available(iOS 11.0, *) {
//            self.impnoSearchbar.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
//        }
//        //  eventSearchbar.layer.position = CGPoint(x: self.view.bounds.width/2, y: 100)
//
//        // add shadow
//        //   eventSearchbar.layer.shadowColor = UIColor.red.cgColor
//        //        self.impnoSearchbar.layer.shadowOpacity = 0.5
//        self.impnoSearchbar.layer.masksToBounds = false
//
//        // hide cancel button
//        self.impnoSearchbar.showsCancelButton = true;
//
//        // hide bookmark button
//        self.impnoSearchbar.showsBookmarkButton = false
//
//        // set Default bar status.
//        self.impnoSearchbar.searchBarStyle = .default
//
//        self.impnoSearchbar.barTintColor = UIColor.gray
//        self.impnoSearchbar.tintColor = UIColor.gray
//        UIBarButtonItem.appearance().tintColor = UIColor.white
//
//        self.impnoSearchbar.showsSearchResultsButton = false
//
//        self.navigationItem.titleView = impnoSearchbar
//        self.navigationItem.rightBarButtonItem = nil ;
//        self.impnoSearchbar.becomeFirstResponder()
//        self.definesPresentationContext = true
//
//    }
    
    
    
    
    //Mark- CardView for tableview
    func setCardView(view : UIView){
        
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = 1;
        view.layer.shadowRadius = 2;
        view.layer.shadowOpacity = 0.5;
        
    }
    
    //Mark- Token api
//    func getAuthToken(){
//
//        if (Network.reachability?.isReachable) == true{
//            APIHandler.sharedInstance.getTokenApi(paramater: nil , onSuccess: { tokenList in
//                let access_token = tokenList.access_token
//                let expires_in = tokenList.expires_in
//                let token_type = tokenList.token_type
//                let jointToken = (token_type ?? "") + " " + (access_token ?? "")
//
//                print(jointToken)
//
//                UserDefaults.standard.set(access_token, forKey: UserDefaultsKeys.access_token.rawValue)
//                UserDefaults.standard.set(expires_in, forKey: UserDefaultsKeys.expires_in.rawValue)
//                UserDefaults.standard.set(token_type, forKey: UserDefaultsKeys.token_type.rawValue)
//                UserDefaults.standard.set(jointToken, forKey: UserDefaultsKeys.apiauthtoken.rawValue)
//                UserDefaults.standard.synchronize()
//                print(UserDefaults.standard.string(forKey: UserDefaultsKeys.apiauthtoken.rawValue) ?? "")
//
//
//
//            },onFailure: { error  in
//
//                print(error)
//                SharedUtlity.sharedHelper().showToast(on:
//                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
//            })
//        }
//    }
//
//
    
    
    //Mark- Scroll to First Row
    func scrollToFirstRow() {
        if(self.arrImpNo.count > 0){
            let indexPath = IndexPath(row: 0, section: 0)
            self.tblViewMemberNumber.scrollToRow(at: indexPath, at: .top, animated: true)
            
            
        }
        
    }
    
//    //Mark- Search bar Cancel Button
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//
//        self.navigationItem.rightBarButtonItem = rightSearchbarButton;
//        self.navigationItem.titleView = nil
//        self.impnoSearchbar.text = ""
//
//        self.getImportantNumbers(strSearch: "")
//
//    }
    
  
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            self.tblViewMemberNumber.reloadData()
            
            self.getImportantNumbers(strSearch: impSearchBar.text ?? "")
            
            self.scrollToFirstRow()
            self.tblViewMemberNumber.reloadData()
        
        impSearchBar.resignFirstResponder()

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            
            self.getImportantNumbers(strSearch: impSearchBar.text ?? "")

        }
        
    }
    
    
    
    //Mark- Search bar Search Button
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        if let searchText = impnoSearchbar.text, !searchText.isEmpty {
//            self.tblViewMemberNumber.reloadData()
//
//            self.getImportantNumbers(strSearch: impnoSearchbar.text ?? "")
//
//            self.scrollToFirstRow()
//            self.tblViewMemberNumber.reloadData()
//        }
//        self.impnoSearchbar.resignFirstResponder()
//        if let cancelButton : UIButton = searchBar.value(forKey: "_cancelButton") as? UIButton{
//            cancelButton.isEnabled = true
//        }
//        self.tblViewMemberNumber.reloadData()
//
//    }
    
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }

    
    //MARK:- Call button tapped
    @objc func btnCallButtonTapped(_ sender: UIButton) {
        var dictData =  ImportantNumbers()
        dictData = self.arrImpNo[sender.tag]
        let strPhoneNumber = dictData.phoneNumber ?? ""
        if let phoneCallURL:URL = URL(string: "tel:\(strPhoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)){
                //   application.openURL(phoneCallURL)
                UIApplication.shared.open(URL(string: "\(phoneCallURL)")!)
                
            }
        }
        
    }
    
    
  //  MARK:- Email button tapped
    @objc func btnEmailButtonTapped(_ sender: UIButton) {

        var dictData =  ImportantNumbers()
        dictData = self.arrImpNo[sender.tag]
        let stremail = dictData.email ?? ""

        if(stremail == "")
        {

        }else{
            self.arrselectedEmails.removeAll()
            self.arrselectedEmails.append(stremail)

            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        }

    }



    func configuredMailComposeViewController() -> MFMailComposeViewController {

        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property

        mailComposerVC.setToRecipients(arrselectedEmails)
        mailComposerVC.setSubject("")
        mailComposerVC.setMessageBody("", isHTML: false)

        return mailComposerVC
    }

    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }

    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    
    //MARK:- UItableview Delegate & dataSource methods
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return arrImpNo.count
    }
    
    
    //the method returning each cell of the list
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImportantNumberTableViewCell", for: indexPath) as! ImportantNumberTableViewCell
        cell.memberName.titleLabel?.font = SFont.SourceSansPro_Semibold16
        cell.memberphono.titleLabel?.font = SFont.SourceSansPro_Regular14
        
        cell.memberName.setTitleColor(APPColor.textColor.textNewColor, for: .normal)
        cell.memberphono.setTitleColor(APPColor.textColor.textNewColor, for: .normal)
        
        cell.backgroundColor = APPColor.viewBgColor.viewbg
        
        var dictData =  ImportantNumbers()
        dictData = self.arrImpNo[indexPath.row]
        
        cell.memberphono .setTitle(dictData.phoneNumber, for: .normal)
        
        cell.memberName .setTitle(dictData.departmentName, for: .normal)
        
        if dictData.email == "" {
          cell.widthEmail.constant = 0
          cell.emailIcon.isHidden = true
        }else{
            cell.widthEmail.constant = 30
            cell.emailIcon.isHidden = false

        }
        
        cell.emailIcon.tag = indexPath.row
        cell.emailIcon.addTarget(self, action: #selector(btnEmailButtonTapped(_:)), for: .touchUpInside)

        
        cell.memberCall.tag = indexPath.row
        cell.memberCall.addTarget(self, action: #selector(btnCallButtonTapped(_:)), for: .touchUpInside)
        
        let placeholder:UIImage = UIImage(named: "avtar")!
        cell.memberImage.image = placeholder
        
        //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
        //ENGAGE0011419 -- Start
        let imageURLString = dictData.importantNumberIcon2x ?? ""
        
        if imageURLString.isValidURL()
        {
            let url = URL.init(string:imageURLString)
            cell.memberImage.sd_setImage(with: url , placeholderImage: placeholder)
        }
        /*
        print("imageURLString:\(imageURLString)")
        if(imageURLString.count>0){
            let validUrl = self.verifyUrl(urlString: imageURLString)
            if(validUrl == true){
                let url = URL.init(string:imageURLString)
                cell.memberImage.sd_setImage(with: url , placeholderImage: placeholder)
            }
        }
        */
        //ENGAGE0011419 -- End
        return cell
    }
    
    
    //Commented by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead
    //ENGAGE0011419 -- Start
    //MARK:- Verify Url exist or Not
//    func verifyUrl(urlString: String?) -> Bool {
//        if let urlString = urlString {
//            if let url = URL(string: urlString) {
//                return UIApplication.shared.canOpenURL(url)
//            }
//        }
//        return false
//    }
    //ENGAGE0011419 -- End
    
    //Mark- Refresh logic for tableview
    @objc func refresh(sender:AnyObject) {
        self.impnoSearchbar.text = ""
        getImportantNumbers(strSearch: "")
        self.refreshControl.endRefreshing()
        
    }
    
    //Mark- Refresh logic for tableview
    func refreshControls()
    {
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        self.tblViewMemberNumber.addSubview(refreshControl) // not required when using UITableViewController
    }

    //MARK: Initialization of Controller
    func initController()
    {
        self.impnoSearchbar = UISearchBar()
        
        tblViewMemberNumber.separatorInset = .zero
        tblViewMemberNumber.layoutMargins = .zero
        self.tblViewMemberNumber.separatorColor = APPColor.celldividercolor.divider
        self.tblViewMemberNumber.rowHeight = 68
        
        tblViewMemberNumber.reloadData()
        self.tblViewMemberNumber.allowsSelection = false
        self.tblViewMemberNumber.tableFooterView = UIView()
        
//        self.rightSearchbarButton = UIBarButtonItem(image: UIImage(named: "Icon_SearchNavBar"), style: .plain, target: self, action: #selector(searchBarButtonPressed))
//        self.navigationItem.rightBarButtonItem = self.rightSearchbarButton
//        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
        getImportantNumbers(strSearch: "")
        self.definesPresentationContext = true
    }
    
    
    
    //MARK: Lifecycle method
    override func viewWillAppear(_ animated: Bool) {
       // self.getAuthToken()
        self.navigationController?.navigationBar.isHidden = false
        //navigation item labelcolor
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = self.appDelegate.masterLabeling.important_club_numbers
        self.navigationController?.navigationBar.backItem?.title = self.appDelegate.masterLabeling.bACK
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
    }
    
    
    
    
    
    //MARK: Get Important numbers from server
    func getImportantNumbers(strSearch :String)
    {
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)  ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)  ?? "",
                APIKeys.ksearchby: strSearch ,
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
                
            ]
            
            print(paramaterDict)
            APIHandler.sharedInstance.getImportantNumbers(paramater: paramaterDict , onSuccess: { impnoList in
                self.appDelegate.hideIndicator()
                if(impnoList.responseCode == InternetMessge.kSuccess)
                {
                    
                    if((impnoList.importantNo == nil) && (impnoList.clubnumber == nil ) ){
                        
                        self.arrImpNo.removeAll()
                        self.tblViewMemberNumber.setEmptyMessage(InternetMessge.kNoData)
                        self.tblViewMemberNumber.reloadData()
                        
                        self.appDelegate.hideIndicator()
                    }
                    else{
                        
                        if((impnoList.importantNo?.count == 0) && (impnoList.clubnumber?.count == 0))
                        {
                            self.arrImpNo.removeAll()
                            self.tblViewMemberNumber.setEmptyMessage(InternetMessge.kNoData)
                            self.tblViewMemberNumber.reloadData()
                            
                            self.appDelegate.hideIndicator()
                        }else{
                            
                            self.arrImpNo.removeAll()
                            if(impnoList.clubnumber?.count == nil)
                            {
                                self.tblViewMemberNumber.reloadData()
                                
                                
                            }else{
                                for i in 0..<(impnoList.clubnumber?.count)! {
                                    self.tblViewMemberNumber.restore()
                                    //  self.setCardView(view:  self.tblViewMemberNumber)
                                    
                                    var dictImpNo = ClubNumbers()
                                    dictImpNo = impnoList.clubnumber![i]
                                    let JSONString = dictImpNo.toJSONString(prettyPrint: true)
                                    let impNo = ImportantNumbers(JSONString: JSONString!)
                                    self.arrImpNo.append(impNo!)
                                }
                            }
                            if(impnoList.importantNo?.count == nil)
                            {
                                self.tblViewMemberNumber.reloadData()
                            }else{
                                for i in 0..<(impnoList.importantNo?.count)! {
                                    self.tblViewMemberNumber.restore()
                                    
                                    var dictImpNo = ImportantNumbers()
                                    dictImpNo = impnoList.importantNo![i]
                                    self.arrImpNo.append(dictImpNo)
                                }
                            }
                        }
                        // print(self.arrImpNo.count)
                        self.tblViewMemberNumber.reloadData()
                    }
                    
                    
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((impnoList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: impnoList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.tblViewMemberNumber.setEmptyMessage(impnoList.responseMessage ?? "")
                    
                }
                self.appDelegate.hideIndicator()
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
        }else{
            // self.tblViewMemberNumber.setEmptyMessage(InternetMessge.kInternet_not_available)
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

