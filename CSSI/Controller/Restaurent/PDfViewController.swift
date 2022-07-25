import UIKit

class PDfViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var pdfView: UIWebView!
    var pdfUrl = String()
    var restarantName = String()
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var restarantmenus =  Restaurents()
    var arrRestarantDetails = [RestaurentMenus]()
    var isFrom : NSString!
    var year : String!
    var month : String!
    var downloadStatementURL: URL?
    //var filter : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setColorCode()
        self.initController()
        
        if (isFrom == "downloadStatements"){
            let printer = UIButton(type: .custom)
            printer.setImage(UIImage(named: "Print-Icon"), for: .normal)
            printer.frame = CGRect(x: 0, y: 0, width: 25, height: 30)
            // btn1.addTarget(self, action: Selector(("didTapEditButton:")), for: .touchUpInside)
            printer.addTarget(self, action:#selector(self.didTapOnPrinter), for: .touchUpInside)
            let itemprinter = UIBarButtonItem(customView: printer)

            let share = UIButton(type: .custom)
            share.setImage(UIImage(named: "Share_Icon"), for: .normal)
            share.frame = CGRect(x: 0, y: 0, width: 25, height: 30)
            // btn1.addTarget(self, action: Selector(("didTapEditButton:")), for: .touchUpInside)
            share.addTarget(self, action:#selector(self.didTapOnShare), for: .touchUpInside)

            let itemshare = UIBarButtonItem(customView: share)

            let home = UIButton(type: .custom)
            home.setImage(UIImage(named: "Path 398"), for: .normal)
            home.frame = CGRect(x: 0, y: 0, width: 25, height: 30)
            //btn2.addTarget(self, action: Selector(("didTapSearchButton:")), for: .touchUpInside)
            home.addTarget(self, action:#selector(self.didTapOnHome), for: .touchUpInside)

            let itemHome = UIBarButtonItem(customView: home)
            self.navigationItem.setRightBarButtonItems([itemHome,itemshare, itemprinter], animated: true)
        }else{
            let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
            navigationItem.rightBarButtonItem = homeBarButton
        }
       
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    @objc func didTapOnPrinter(sender: UIButton){
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        let printController = UIPrintInteractionController.shared
        
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = UIPrintInfoOutputType.general
        printInfo.jobName = (downloadStatementURL?.absoluteString ?? "")
        printInfo.duplex = UIPrintInfoDuplex.none
        printInfo.orientation = UIPrintInfoOrientation.portrait
        
        //New stuff
        printController.printPageRenderer = nil
        printController.printingItems = nil
        
        //New stuff
        
        printController.printInfo = printInfo
        printController.showsPageRange = true
        printController.showsNumberOfCopies = true
        
        /**Directly assigning url to the printing item is causing lag in the print screen.(Downloading and showing the print screen on main thread which is causing lag/screen freeze)*/
        //printController.printingItem = downloadStatementURL
        //printController.present(animated: true, completionHandler: nil)
        
        
        DispatchQueue.global(qos: .userInteractive).async {
            if let url = self.downloadStatementURL , let data = try? Data.init(contentsOf: url)
            {
                DispatchQueue.main.async {
                    self.appDelegate.hideIndicator()
                    printController.printingItem = data
                    printController.present(animated: true, completionHandler: nil)
                }

            }

        }
        
       // printController.presentFromBarButtonItem(filter, animated: true, completionHandler: nil)
    }
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    @objc func didTapOnHome(sender: UIButton){
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    //Added on 23rd June 2020 BMS
    @objc private func backBtnAction(sender: UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapOnShare(sender: UIButton){

        if let link = downloadStatementURL
        {
            let objectsToShare = [link] as [Any]
//            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
//            self.present(activityVC, animated: true, completion: nil)
            
            let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = sender
            activityViewController.excludedActivityTypes = [UIActivityType.print, UIActivityType.addToReadingList]
            self.present(activityViewController, animated: true, completion: nil)

        }
    }
    
    func initController()
    {
        pdfView.delegate = self ;
        pdfView.scalesPageToFit = true;
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backItem?.title = self.appDelegate.masterLabeling.bACK
        //Commented by kiran V2.9 -- ENGAGE0011898 -- Commented as this is setting navigation bar title as back for a few seconds before nagivating to the PDF screen.
        //ENGAGE0011898 -- Start
        //self.navigationController?.navigationBar.topItem?.title = self.appDelegate.masterLabeling.bACK
        //ENGAGE0011898 -- End
        
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = restarantName
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        
        if isFrom == "First"{
        
            self.getRestaurentMenus()
            

        }
        else if (isFrom == "downloadStatements"){
            self.getDownloadStatementDetails()

        }
        else{
            if (Network.reachability?.isReachable) == true
            {
                let url = URL(string: pdfUrl)
                let nsurl = NSURL(string: "")
                pdfView.loadRequest(URLRequest(url: url ?? nsurl! as URL))
                
            }
            else
            {
                self.appDelegate.hideIndicator()
            }
        }
        
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
                        self.appDelegate.hideIndicator()
                    }
                    else{
                        if(restaurentList.restaurentMenus?.count == 0)
                        {
                            self.appDelegate.hideIndicator()
                        }else{
                            
                            self.arrRestarantDetails.removeAll()
                            //  self.setCardView(view: self.tblrestaurantdetails)
                            
                            self.arrRestarantDetails = restaurentList.restaurentMenus ?? []
                            
                            if (Network.reachability?.isReachable) == true{
                                
                                
                                let url = URL(string: self.arrRestarantDetails[0].pdf!)
                                self.pdfView.loadRequest(URLRequest(url: url!))
                                self.navigationItem.title = self.arrRestarantDetails[0].restaurentMenu

                                
                            }else
                            {
                                self.appDelegate.hideIndicator()
                                
                            }
                            
                            self.appDelegate.hideIndicator()
                        }
                    }
                }
                else{
                    self.appDelegate.hideIndicator()
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
    
    //MARK:- DownLoadStatement Details Api
    func getDownloadStatementDetails(){
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId :UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)  ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)  ?? "",
                "ARType": "NORMAL A/R",
                "Year": year,
                "Month": month,
                APIKeys.kdeviceInfo: [APIHandler.devicedict]
            ]
            
            APIHandler.sharedInstance.getDownloadStatements(paramater: paramaterDict , onSuccess: { downloadStatementDetails in
                self.appDelegate.hideIndicator()
                if(downloadStatementDetails.responseCode == InternetMessge.kSuccess){
                    if(downloadStatementDetails.downloadStatement == nil){
                        self.appDelegate.hideIndicator()
                    }
                    else{
                        if(downloadStatementDetails.downloadStatement?.count == 0)
                        {
                            self.appDelegate.hideIndicator()
                        }else{
                            
//                            self.arrRestarantDetails.removeAll()
//                            //  self.setCardView(view: self.tblrestaurantdetails)
//
//                            self.arrRestarantDetails = restaurentList.restaurentMenus ?? []
//
                            if (Network.reachability?.isReachable) == true{
                                
                                
                                self.downloadStatementURL = URL(string: downloadStatementDetails.downloadStatement![0].filePath ?? "")
                                self.pdfView.loadRequest(URLRequest(url: self.downloadStatementURL!))
                                self.navigationItem.title = self.appDelegate.masterLabeling.download_statement
                                
                                
                            }else
                            {
                                self.appDelegate.hideIndicator()
                                
                            }
                            
                            self.appDelegate.hideIndicator()
                        }
                    }
                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((downloadStatementDetails.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: downloadStatementDetails.responseMessage, withDuration: Duration.kMediumDuration)
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
    
    
    //Mark- Common Color Code
    func setColorCode()
    {
        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg
        self.pdfView.backgroundColor = APPColor.viewBackgroundColor.viewbg
        
        
    }
    
    //Mark- Webview Method
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
    }
    
    
    
    //Mark- Webview Method
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        self.appDelegate.hideIndicator()
        
    }
    
    
    //Mark- Webview Method
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.appDelegate.hideIndicator()
        
        if(!pdfView.isLoading){
            self.appDelegate.hideIndicator()
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        //Added on 23rd June 2020 BMS
//        let barbutton = UIBarButtonItem.init(image : UIImage.init(named: "back_btn"), style: .plain, target: self , action: #selector(self.backBtnAction(sender:)))
//        barbutton.imageInsets = UIEdgeInsets.init(top: 0, left: -6.5, bottom: 0, right: 0)
//        self.navigationItem.leftBarButtonItem = barbutton
        
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backItem?.title = self.appDelegate.masterLabeling.bACK
        //Commented by kiran V2.9 -- ENGAGE0011898 -- Commented as this is setting navigation bar title as back for a few seconds before nagivating to the PDF screen.
        //ENGAGE0011898 -- Start
        //self.navigationController?.navigationBar.topItem?.title = self.appDelegate.masterLabeling.bACK
        //ENGAGE0011898 -- End
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = restarantName
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = true
        
    }
   
}
