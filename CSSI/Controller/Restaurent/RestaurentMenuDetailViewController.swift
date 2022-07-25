import UIKit
import Alamofire

class RestaurentMenuDetailViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblrestaurantdetails: UITableView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var mainImage: UIImageView!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrRestarantDetails = [RestaurentMenus]()
    var refreshControl = UIRefreshControl()
    var restarantmenus =  Restaurents()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setColorCode()
        self.initController()
        
        let placeholder:UIImage = UIImage(named: "Icon-App-40x40")!
        
        
        //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
        //ENGAGE0011419 -- Start
        let imageURLString = restarantmenus.restaurentthumb ?? ""
        
        if imageURLString.isValidURL()
        {
            let url = URL.init(string:imageURLString)
            self.mainImage.sd_setImage(with: url , placeholderImage: placeholder)
        }
        else
        {
            self.mainImage.image = UIImage(named: "Icon-App-40x40")!
        }
        /*
        if((imageURLString.count)>0){
            let validUrl = self.verifyUrl(urlString: imageURLString)
            if(validUrl == true){
                let url = URL.init(string:imageURLString)
                self.mainImage.sd_setImage(with: url , placeholderImage: placeholder)
            }
        }
        else{
            //   let url = URL.init(string:imageURLString)
            self.mainImage.image = UIImage(named: "Icon-App-40x40")!
        }
        */
        //ENGAGE0011419 -- End
        
//
//        Alamofire.request(restarantmenus.restaurentthumb!).responseImage { response in
//            debugPrint(response)
//
//            if let image = response.result.value {
//                //self.mainImage.contentMode = UIViewContentMode;
//
//                self.mainImage.contentMode = .scaleAspectFit
//
//                self.mainImage.image = image
//            }
//        }
        
        viewTop.layer.shadowColor = UIColor.lightGray.cgColor
        viewTop.layer.shadowOpacity = 1.0
        viewTop.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewTop.layer.shadowRadius = 4

        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
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
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    func initController()
    {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backItem?.title = self.appDelegate.masterLabeling.bACK
        self.navigationController?.navigationBar.topItem?.title = self.appDelegate.masterLabeling.bACK
        
//        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
//        navigationController?.navigationBar.titleTextAttributes = textAttributes
//        self.navigationItem.title = restarantmenus.restaurentName
//        self.tabBarController?.tabBar.isHidden = true
//        self.tabBarController?.tabBar.isTranslucent = true
//
//        self.refreshControl.attributedTitle = NSAttributedString(string: "")
//        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
//        self.tblrestaurantdetails.addSubview(refreshControl) // not required when using UITableViewController
        
//        self.tblrestaurantdetails.separatorInset = .zero
//        self.tblrestaurantdetails.separatorColor = APPColor.celldividercolor.divider
//
//        self.tblrestaurantdetails.layoutMargins = .zero
//        self.tblrestaurantdetails.rowHeight = 60
//        self.tblrestaurantdetails.reloadData()
//
//        self.tblrestaurantdetails.tableFooterView = UIView()
//
        self.getRestaurentMenus()
        
    }
    @objc func refresh(sender:AnyObject) {
        getRestaurentMenus()
        self.refreshControl.endRefreshing()
        
    }
    
    
    //MARK:- Set Card View
//    func setCardView(view : UIView){
//
//        view.layer.masksToBounds = false
//        view.layer.shadowOffset = CGSize(width: 0, height: 0)
//        view.layer.cornerRadius = 1;
//        view.layer.shadowRadius = 2;
//        view.layer.shadowOpacity = 0.5;
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
     
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = restarantmenus.restaurentName
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = true
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Commented by kiran V2.5 11/30 -- ENGAGE0011297 --
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Restaurant Details Api
    func getRestaurentMenus(){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId :UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: restarantmenus.restaurantID!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            
            APIHandler.sharedInstance.getRestaurentMenus(paramater: paramaterDict , onSuccess: { restaurentList in
                self.appDelegate.hideIndicator()
                if(restaurentList.responseCode == InternetMessge.kSuccess){
                    if(restaurentList.restaurentMenus == nil){
                        self.tblrestaurantdetails.setEmptyMessage(InternetMessge.kNoData)
                        self.appDelegate.hideIndicator()
                    }
                    else{
                        if(restaurentList.restaurentMenus?.count == 0)
                        {
                            self.tblrestaurantdetails.setEmptyMessage(InternetMessge.kNoData)
                            self.appDelegate.hideIndicator()
                        }else{
                            
                            self.arrRestarantDetails.removeAll()
                          //  self.setCardView(view: self.tblrestaurantdetails)
                            
                            self.arrRestarantDetails = restaurentList.restaurentMenus ?? []
                            self.tblrestaurantdetails.reloadData()
                            self.appDelegate.hideIndicator()
                        }
                    }
                }
                else{
                    self.appDelegate.hideIndicator()
                    self.refreshControl.endRefreshing()
                    if(((restaurentList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: restaurentList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    self.tblrestaurantdetails.setEmptyMessage(restaurentList.responseMessage ?? "")
                    
                }
                self.appDelegate.hideIndicator()
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
            
        }else{
            self.refreshControl.endRefreshing()
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            
            
        }
        
    }
    
    
    //the method returning size of the list
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrRestarantDetails.count
    }

    //the method returning each cell of the list
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenusCellID", for: indexPath) as! MenusAndHoursTableViewCell
        
//        cell.lblRestaurentTitle.font = SFont.SourceSansPro_Regular16
        var restobj = RestaurentMenus ()
       restobj = arrRestarantDetails[indexPath.row]
//        cell.lblRestaurentTitle.text = restobj.restaurentMenu
        cell.lblTitle.text = restobj.restaurentMenu
        let placeHolderImage = UIImage(named: "Icon-App-40x40")
        cell.imgImage.image = placeHolderImage
        cell.imgMenuIcon.image = placeHolderImage
        
        //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
        //ENGAGE0011419 -- Start
        let imageURLString = restobj.menuImage ?? ""
        
        if imageURLString.isValidURL()
        {
            let url = URL.init(string:imageURLString)
            cell.imgImage.sd_setImage(with: url , placeholderImage: placeHolderImage)
        }
        /*
        if(imageURLString.count>0){
            let validUrl = self.verifyUrl(urlString: imageURLString)
            if(validUrl == true){
                
                let url = URL.init(string:imageURLString)
                cell.imgImage.sd_setImage(with: url , placeholderImage: placeHolderImage)
                
            }
        }
        */
        let imageURLString2 = restobj.menuIcon ?? ""
        
        if imageURLString2.isValidURL()
        {
            let url = URL.init(string:imageURLString2)
            cell.imgMenuIcon.sd_setImage(with: url , placeholderImage: placeHolderImage)
        }
        /*
        if(imageURLString2.count>0){
            let validUrl = self.verifyUrl(urlString: imageURLString2)
            if(validUrl == true){
                
                let url = URL.init(string:imageURLString2)
                cell.imgMenuIcon.sd_setImage(with: url , placeholderImage: placeHolderImage)
                
            }
        }
        */
        //ENGAGE0011419 -- End
        
        
        return cell
    }
//    func verifyUrl(urlString: String?) -> Bool {
//        if let urlString = urlString {
//            if let url = URL(string: urlString) {
//                return UIApplication.shared.canOpenURL(url)
//            }
//        }
//        return false
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark- Common Color Code
    func setColorCode()
    {
        self.view.backgroundColor = APPColor.placeHolderColor.tint
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let restobj = self.arrRestarantDetails[indexPath.row]
      //  self.tblrestaurantdetails.reloadData()
        let restarantpdfDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
        restarantpdfDetailsVC.pdfUrl = restobj.pdf!
        restarantpdfDetailsVC.restarantName = restobj.restaurentMenu!
        self.navigationController?.pushViewController(restarantpdfDetailsVC, animated: true)
        
        
    }
    
    
}


