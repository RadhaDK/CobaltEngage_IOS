import UIKit
import Alamofire
import AlamofireImage


extension FilterViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        guard let toVC = toViewController else { return }
        isPresenting = !isPresenting
        
        if isPresenting == true {
            containerView.addSubview(toVC.view)
            
            ScrollView.frame.origin.y += menuHeight
            self.view.alpha = 0
            
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.ScrollView.frame.origin.y -= self.menuHeight
                  self.view.alpha = 1
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.ScrollView.frame.origin.y += self.menuHeight
                 self.view.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
    }
}
class FilterViewController: UIViewController {
 @IBOutlet weak var tagView: TagView!
   
    @IBOutlet weak var ScrollView: UIScrollView!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrmemInterest = [MemberDictInterest]()

    @IBOutlet weak var btnFilterByInterest: UIButton!
    
    @IBOutlet weak var btnClose: UIButton!
    @IBAction func btn_close(_ sender: UIButton) {
       // print("close icon click")
       // print(tagView.selectedTagTitles)
        
        
        self.appDelegate.arrSelectedTagg = tagView.selectedTagTitles
       // print(self.appDelegate.arrSelectedTagg)
       // print("arrSelectedTagg: \(self.appDelegate.arrSelectedTagg)")

         if(self.appDelegate.arrSelectedTagg.count == 0)
         {
           self.appDelegate.arrSelectedTagg.append("All")
            
        }
        var list = self.appDelegate.arrSelectedTagg.joined(separator: ", ")
       
        
        
//        let memberVC = MemberDirectoryViewController()
//       memberVC.viewwillappercustom()
        
        
//        weak var pvc = self.presentingViewController
//
//        self.dismiss(animated: true, completion: {
//            let vc = MemberDirectoryViewController()
//            pvc?.present(vc,animated: true,completion: nil)
//        })
//
        if((self.presentingViewController) != nil){
            
            let userInfo = [ "SelectedItems" : list ]
            NotificationCenter.default.post(name: NSNotification.Name("NotificationIdentifier"), object: nil, userInfo: userInfo)
            
            self.tabBarController?.tabBar.isHidden = false
            self.tabBarController?.tabBar.isTranslucent = false
            
            self.dismiss(animated: false, completion: nil)
            print("cancel")
          //  MemberDirectoryViewController().refresh()

            
            
            
        }
    }
    
    let menuHeight = UIScreen.main.bounds.height / 2
    var isPresenting = false
    
    //Added by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
    //ENGAGE0012667 -- Start
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    //ENGAGE0012667 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeberInterestApi()
        
        self.btnFilterByInterest.setTitle(self.appDelegate.masterLabeling.fILTER_BY_INTEREST, for: .normal)
        modalPresentationStyle = .currentContext
        transitioningDelegate = self
        let  bdView = UIView(frame: self.view.bounds)
        bdView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
 
        self.view.backgroundColor = .clear
        
        view.isOpaque = false
         self.view.addSubview(bdView)
         self.view.addSubview(ScrollView)
       //  ScrollView.backgroundColor = UIColor.wh
       // self.lblfiltertext.font = SFont.SourceSansPro_Semibold16
        // Do any additional setup after loading the view.
        
       // let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FilterViewController.handleTap(_:)))
      //  self.view.addGestureRecognizer(tapGesture)
        
    
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        let image = UIImage.init(named: "ic_cross")?.withRenderingMode(.alwaysTemplate)
                
        self.btnClose.setImage( image, for: .normal)
        self.btnClose.imageView?.tintColor = APPColor.MainColours.primary2
    }
   // @objc func handleTap(_ sender: UITapGestureRecognizer) {
   //     dismiss(animated: true, completion: nil)
  //  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
    }
    
    func initTagView() {
        false ? tagsWithAction() : tagsWithSelectAndEdit()
    }
    
  
    
    func memeberInterestApi()
    {
    if (Network.reachability?.isReachable) == true{
        
    self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        let paramaterDict:[String: Any] = [
            "Content-Type":"application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict]
        ]
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        APIHandler.sharedInstance.getMemebrDirectoryInterest(paramater: paramaterDict , onSuccess: { interestList in
            self.appDelegate.hideIndicator()
            if(interestList.responseCode == InternetMessge.kSuccess){
                if(interestList.memberInterest == nil){
                    self.appDelegate.hideIndicator()
                }
                else{
                    self.arrmemInterest = interestList.memberInterest!
                    self.initTagView()
                }
            }else{
                self.appDelegate.hideIndicator()
                
                if(((interestList.responseMessage?.count) ?? 0)>0){
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: interestList.responseMessage, withDuration: Duration.kMediumDuration)
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

    struct PersonInterest {
        var name: String
        var selection: String
    }
    
    
    @objc func actionButton(_ sender: UIButton) {
        print(sender.title(for: .normal) ?? "")
    }
    
    func tagsWithAction() {
//        let tags = ["Boca West Foundation","Card Play","Wine","Singles",
//                    "Pets","Cooking","Outdoor","Veterans",
//                    "Performing Arts","Golf League",
//                    ]
        
        var list = [String]()

        for name in  self.arrmemInterest
        {
            list.append(name.interest!)
        }
  //      var str:String = "Boca West Foundation,Card Play,Wine,Singles"
     
   //     var pointsArr = str.components(separatedBy: ",")
        
    //    let tags = pointsArr
        
        
      let tags = list
        
      
        
      //  tagView.createCloudTagsWithTitles(tags, target: self, action: #selector(actionButton))
    }
    
    
    
    @objc func actionEditButton(_ sender: UIButton) {
       // print(tagView.selectedTagTitles)
    }
    
    
    
    func tagsWithSelectAndEdit() {
        var myTupleArray: [(String, Bool)] = []
        
        var list = [String]()
       // print(self.appDelegate.arrSelectedTagg)
        for name in arrmemInterest
        {
            if(self.appDelegate.arrSelectedTagg.contains(name.interest!))
            {
                myTupleArray.append((name.interest!,true))

            }else{
                myTupleArray.append((name.interest!,false))

            }
        }
        

 
        
        let tags = myTupleArray
        tagView.createCloudTagsWithTitles(tags.sorted { $0.1 == $1.1 ? $0.0 < $1.0 : $0.1 && !$1.1 })
    }


}
