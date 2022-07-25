import UIKit
import Alamofire

class RestaurantsViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var restaurantCollectionView: UICollectionView!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    private var minItemSpacing: CGFloat = 4
    private var itemWidth: CGFloat      = 150
    private let itemHeight: CGFloat      = 150
    private let headerHeight: CGFloat   = 0
    var arrRestaurtentList = [Restaurents]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setColorCode()
        self.initController()
    }
    
    
    func initController()
    {
        self.restaurantCollectionView.delegate = self
        self.restaurantCollectionView.dataSource = self
        
        if(self.view.frame.size.width <= 320){
            minItemSpacing = 4
            itemWidth = 154
            itemWidth = (self.view.frame.size.width - 16) / 2
        }
        itemWidth = (self.view.frame.size.width - 32) / 2
        
        
        
        
        // Create our custom flow layout that evenly space out the items, and have them in the center
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = minItemSpacing
        layout.minimumLineSpacing = minItemSpacing
        layout.headerReferenceSize = CGSize(width: 0, height: headerHeight)
        
        // Find n, where n is the number of item that can fit into the collection view
        var n: CGFloat = 1
        let containerWidth = self.restaurantCollectionView.bounds.width
        while true {
            let nextN = n + 1
            let totalWidth = (nextN*itemWidth) + (nextN-1)*minItemSpacing
            if totalWidth > containerWidth {
                break
            } else {
                n = nextN
            }
        }
        
        // Calculate the section inset for left and right.
        // Setting this section inset will manipulate the items such that they will all be aligned horizontally center.
        let inset = max(minItemSpacing, floor( (containerWidth - (n*itemWidth) - (n-1)*minItemSpacing) / 2 ) )
        layout.sectionInset = UIEdgeInsets(top: minItemSpacing, left: minItemSpacing, bottom: minItemSpacing, right: minItemSpacing)
        
        self.restaurantCollectionView.collectionViewLayout = layout
        
        self.getRestaurentDetails()
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
       // self.getAuthToken()
        
        self.navigationController?.navigationBar.isHidden = false
        //navigation item labelcolor
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = self.appDelegate.masterLabeling.menus_hours
        
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:- Token Api
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
    
    //MARK:- Restaurant List Api
    func getRestaurentDetails(){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            
            
            APIHandler.sharedInstance.getRestaurentDetails(paramater: paramaterDict , onSuccess: { restaurentList in
                self.appDelegate.hideIndicator()
                if(restaurentList.responseCode == InternetMessge.kSuccess){
                    if(restaurentList.restaurentMenus == nil){
                        
                        self.appDelegate.hideIndicator()
                    }
                    else{
                        if(restaurentList.restaurentMenus?.count == 0)
                        {
                            self.appDelegate.hideIndicator()
                            
                            
                        }else{
                            self.arrRestaurtentList.removeAll()
                            self.arrRestaurtentList = restaurentList.restaurentMenus ?? []
                            self.restaurantCollectionView.reloadData()
                            self.appDelegate.hideIndicator()
                            
                        }
                    }
                }
                else{
                    self.appDelegate.hideIndicator()
                    //                    self.refreshControl.endRefreshing()
                    if(((restaurentList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: restaurentList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
                    
                }
                self.appDelegate.hideIndicator()
            },onFailure: { error  in
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })
            
            
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            
            
        }
        
    }
    
    //MARK:- UICollection View Delegate & Datasource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrRestaurtentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCollectionViewCell", for: indexPath) as! RestaurantCollectionViewCell
        var restobj = Restaurents ()
        restobj = arrRestaurtentList[indexPath.row]
      //  cell.btnRestaurantName.setTitle(restobj.restaurentName, for: .normal)
        cell.imgRestaurantImage.contentMode = .scaleAspectFit
        
     //   cell.btnRestaurantName.titleLabel?.numberOfLines = 3
     //   cell.btnRestaurantName.titleLabel?.lineBreakMode = .byWordWrapping
     //   cell.btnRestaurantName.contentHorizontalAlignment = .left
      //  cell.btnRestaurantName.titleLabel?.font = SFont.SourceSansPro_Semibold14
     //   cell.btnRestaurantName.contentEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
        self.setCardView(view: cell.uiView)
        //displaying image
        let placeholder:UIImage = UIImage(named: "Icon-App-40x40")!
        
        //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
        //ENGAGE0011419 -- Start
        let imageURLString = restobj.restaurentthumb ?? ""
        
        if imageURLString.isValidURL()
        {
            let url = URL.init(string:imageURLString)
            cell.imgRestaurantImage.sd_setImage(with: url , placeholderImage: placeholder)
        }
        else
        {
            cell.imgRestaurantImage.image = UIImage(named: "Icon-App-40x40")!
        }
        /*
        if((imageURLString.count)>0){
            let validUrl = self.verifyUrl(urlString: imageURLString)
            if(validUrl == true){
                let url = URL.init(string:imageURLString)
                cell.imgRestaurantImage.sd_setImage(with: url , placeholderImage: placeholder)
            }
        }
        else{
            //   let url = URL.init(string:imageURLString)
            cell.imgRestaurantImage.image = UIImage(named: "Icon-App-40x40")!
        }
        */
        //ENGAGE0011419 -- End

        

       // cell.btnRestaurantName.tag = indexPath.row
      //  cell.btnRestaurantName .addTarget(self, action: #selector(didiselectItemAtIndex(_:)), for: .touchUpInside)
        
        return cell
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
    //Mark- Common Color Code
    func setColorCode(){
        self.view.backgroundColor = APPColor.placeHolderColor.tint
        self.restaurantCollectionView.backgroundColor = APPColor.placeHolderColor.tint
    }
    
    //MARK:- Set Card View
    func setCardView(view : UIView){
        
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = 1;
        view.layer.shadowRadius = 1;
        view.layer.shadowOpacity = 0.5;
        
        //        let shadowSize : CGFloat = 5.0
        //        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
        //                                                   y: -shadowSize / 2,
        //                                                   width: self.avatarImageView.frame.size.width + shadowSize,
        //                                                   height: self.avatarImageView.frame.size.height + shadowSize))
        //        self.avatarImageView.layer.masksToBounds = false
        //        self.avatarImageView.layer.shadowColor = UIColor.black.cgColor
        //        self.avatarImageView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        //        self.avatarImageView.layer.shadowOpacity = 0.5
        //        self.avatarImageView.layer.shadowPath = shadowPath.cgPath
        //
        
        
    }
    
    
    
    @IBAction func didiselectItemAtIndex(_ sender: UIButton){
        
        
        let restobj = self.arrRestaurtentList[sender.tag]
        self.restaurantCollectionView.reloadData()
        let restarantDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RestaurentMenuDetailViewController") as! RestaurentMenuDetailViewController
        restarantDetailsVC.restarantmenus = restobj
        self.navigationController?.pushViewController(restarantDetailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let restobj = self.arrRestaurtentList[indexPath.row]

        if restobj.type == "File" {
            let restobj = self.arrRestaurtentList[indexPath.row]
            let restarantpdfDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
          //  restarantpdfDetailsVC.isFrom = "First"
            restarantpdfDetailsVC.pdfUrl = restobj.filepath!
           // restarantpdfDetailsVC.restarantmenus = restobj
            restarantpdfDetailsVC.restarantName = restobj.restaurentName!

            self.navigationController?.pushViewController(restarantpdfDetailsVC, animated: true)
            
        }
        else{
        let restobj = self.arrRestaurtentList[indexPath.row]
        self.restaurantCollectionView.reloadData()
        let restarantDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RestaurentMenuDetailViewController") as! RestaurentMenuDetailViewController
        restarantDetailsVC.restarantmenus = restobj
        self.navigationController?.pushViewController(restarantDetailsVC, animated: true)
        }
        
        
    }
    
    
}
