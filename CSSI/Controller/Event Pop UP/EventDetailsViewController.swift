
import UIKit
import Alamofire
import AlamofireImage


class EventDetailsViewController: UIViewController,UIScrollViewDelegate {
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    var scrollView = UIScrollView()
    var scrollViewImage = UIScrollView()
    var uimainView = UIView()
    var btnclose = UIButton()
    var imageView = UIImageView()
    var lblTitle = UILabel()
    var lblDescription = UILabel()
    var upcomingEvent =  ListEvents()
    var isHideTabbar : Bool!
    var strclose = String()
    var strnotes = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLocalizedString()
        self.setColorCode()
        self.initController()
        
    }
    
    
    
    
    
    func initController()
    {
        self.view.alpha = 0.8
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        let xAxis:CGFloat = 12.0
        var yAxis:CGFloat = 60.0
        
        if(self.view.frame.size.height > 500){
            yAxis = 120.0
        }
        
        let viewWidth = self.view.frame.size.width - (xAxis + xAxis)
        let viewHeight = self.view.frame.size.height - (yAxis + yAxis)
        
        
        self.uimainView = UIView.init(frame: CGRect(x: xAxis, y: (viewHeight - yAxis) / 2, width: viewWidth, height: viewHeight))
        self.uimainView.backgroundColor = APPColor.viewBgColor.viewbg
        self.uimainView.layer.cornerRadius = 4;
        self.uimainView.layer.masksToBounds = true;
        
        self.view.addSubview(self.uimainView)
        self.uimainView.layer.cornerRadius = 4
        
        self.scrollView = UIScrollView.init(frame: self.uimainView.bounds)
        self.uimainView.addSubview(self.scrollView)
        
        
        
        self.scrollViewImage = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: viewWidth, height: 270))
        self.scrollView.addSubview(self.scrollViewImage)
        
        self.imageView = UIImageView.init(frame: self.scrollViewImage.bounds)
        
        self.scrollViewImage.addSubview(self.imageView)
        
        self.imageView.contentMode = .scaleToFill
        
        
        self.scrollViewImage.minimumZoomScale = 1.0
        self.scrollViewImage.maximumZoomScale = 6.0
        self.scrollViewImage.delegate = self;
        
        
        self.imageView.pin_updateWithProgress = true
        
        //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
        //ENGAGE0011419 -- Start
        let imageURLString = self.upcomingEvent.imageLarge  ?? ""
        
        if imageURLString.isValidURL()
        {
            let imageurl:URL = URL(string: imageURLString)!
            self.imageView.pin_setImage(from: imageurl)
        }
//        if(imageURLString.count>0){
//            let validUrl = self.verifyUrl(urlString: imageURLString)
//            if(validUrl == true){
//                let imageurl:URL = URL(string: imageURLString)!
//                self.imageView.pin_setImage(from: imageurl)
//            }
//        }
        //ENGAGE0011419 -- End
        
        var yAxixIn = self.imageView.frame.size.height + 8
        var xAxixIn:CGFloat = 20.0
        
        self.lblTitle = UILabel.init()
        self.lblTitle.frame = CGRect(x: xAxixIn, y: yAxixIn, width:viewWidth - (xAxixIn + xAxixIn) , height: 0)
        self.lblTitle.text = self.upcomingEvent.eventName
        self.lblTitle.font = SFont.SourceSansPro_Semibold16
        self.lblTitle.textColor = APPColor.textColor.text
        self.lblTitle.lineBreakMode = .byWordWrapping
        self.lblTitle.numberOfLines = 0
        self.lblTitle .sizeToFit()
        self.scrollView.addSubview(self.lblTitle)
        
        yAxixIn = self.lblTitle.frame.size.height + self.lblTitle.frame.origin.y + 8
        
        let imgIconLocation = UIImageView.init(frame: CGRect(x: xAxixIn, y: yAxixIn, width: 20, height: 20))
        imgIconLocation.image =  UIImage(named:"icon_location")
        imgIconLocation.contentMode = .scaleAspectFit;
        
        self.scrollView.addSubview(imgIconLocation)
        
        
        xAxixIn = imgIconLocation.frame.size.width + imgIconLocation.frame.origin.x + 8
        
        let lbltype = UILabel.init()
        lbltype.frame = CGRect(x: xAxixIn, y: yAxixIn, width:viewWidth-xAxixIn , height: 0)
        lbltype.text = upcomingEvent.eventVenue!.trimmingCharacters(in: .whitespacesAndNewlines)
        lbltype.font = SFont.SourceSansPro_Semibold14
        lbltype.textColor = APPColor.textheaderColor.header
        lbltype.lineBreakMode = .byWordWrapping
        lbltype.numberOfLines = 0
        lbltype .sizeToFit()
        self.scrollView.addSubview(lbltype)
        
        xAxixIn = 20
        yAxixIn = imgIconLocation.frame.size.height + imgIconLocation.frame.origin.y + 8
        
        let imgIconDate = UIImageView.init(frame: CGRect(x: xAxixIn, y: yAxixIn, width: 20, height: 20))
        imgIconDate.image =  UIImage(named:"Icon_Calendar")
        imgIconDate.contentMode = .scaleAspectFit;
        
        self.scrollView.addSubview(imgIconDate)
        
        xAxixIn = imgIconDate.frame.size.width + imgIconDate.frame.origin.x + 8
        
        let lblDate = UILabel.init()
        lblDate.frame = CGRect(x: xAxixIn, y: yAxixIn, width:viewWidth-xAxixIn , height: 0)
        lblDate.text = upcomingEvent.eventDate!.trimmingCharacters(in: .whitespacesAndNewlines)
        lblDate.font = SFont.SourceSansPro_Semibold14
        lblDate.textColor = APPColor.textheaderColor.header
        lblDate.lineBreakMode = .byWordWrapping
        lblDate.numberOfLines = 0
        lblDate .sizeToFit()
        self.scrollView.addSubview(lblDate)
        
        xAxixIn = 20
        yAxixIn = imgIconDate.frame.size.height + imgIconDate.frame.origin.y + 8
        
        let imgIconTime = UIImageView.init(frame: CGRect(x: xAxixIn, y: yAxixIn, width: 20, height: 20))
        imgIconTime.contentMode = .scaleAspectFit;
        imgIconTime.image = UIImage(named:"icon_clock")
        self.scrollView.addSubview(imgIconTime)
        
        xAxixIn = imgIconDate.frame.size.width + imgIconDate.frame.origin.x + 8
        
        let lblTime = UILabel.init()
        lblTime.frame = CGRect(x: xAxixIn, y: yAxixIn, width:viewWidth-xAxixIn , height: 0)
        lblTime.text = String(format: "%@ - %@", upcomingEvent.eventTime!, upcomingEvent.eventendtime!) 
        lblTime.font = SFont.SourceSansPro_Semibold14
        lblTime.textColor = APPColor.textheaderColor.header
        lblTime.lineBreakMode = .byWordWrapping
        lblTime.numberOfLines = 0
        lblTime .sizeToFit()
        self.scrollView.addSubview(lblTime)
        
        
        yAxixIn = imgIconTime.frame.size.height + imgIconTime.frame.origin.y + 10
        xAxixIn = 20
        
        let lbldesc = UILabel.init()
        lbldesc.frame = CGRect(x: xAxixIn, y: yAxixIn, width:viewWidth - (xAxixIn + xAxixIn ) , height: 0)
        lbldesc.text = strnotes + "\n" + self.upcomingEvent.eventDescription!.trimmingCharacters(in: .whitespacesAndNewlines)
        lbldesc.font = SFont.SourceSansPro_Regular12
        lbldesc.lineBreakMode = .byWordWrapping
        lbldesc.textColor = APPColor.textheaderColor.header
        lbldesc.numberOfLines = 0
        lbldesc .sizeToFit()
        self.scrollView.addSubview(lbldesc)
        
        yAxixIn = lbldesc.frame.size.height + lbldesc.frame.origin.y + 18
        
        self.scrollView.contentSize = CGSize(width: viewWidth, height: yAxixIn )
        
        if(viewHeight>yAxixIn){
            self.uimainView.frame = CGRect(x: xAxis, y: (viewHeight - yAxis) / 2, width: viewWidth, height: yAxixIn)
        }
        
        self.uimainView.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        
        self.btnclose = UIButton.init(frame: CGRect(x: (self.uimainView.frame.size.width + self.uimainView.frame.origin.x) - 120, y: self.uimainView.frame.origin.y - 54, width: 100, height: 54))
        self.btnclose .setTitle(strclose, for: .normal)
        self.btnclose .setTitleColor(APPColor.tintColor.tint, for: .normal)
        self.btnclose.contentHorizontalAlignment = .right
        self.view.addSubview(self.btnclose)
        self.btnclose .addTarget(self, action: #selector(btnClosePressed(sender:)), for: .touchUpInside)
        
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
    }
    
    //Commented by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead
    //ENGAGE0011419 -- Start
    //Mark- Verify url exist
//    func verifyUrl(urlString: String?) -> Bool {
//        if let urlString = urlString {
//            if let url = URL(string: urlString) {
//                return UIApplication.shared.canOpenURL(url)
//            }
//        }
//        return false
//    }
    //ENGAGE0011419 -- End
    
    
    
    //MARK:- Language Localization
    func setLocalizedString()
    {
        strclose = (self.appDelegate.masterLabeling.cLOSE)!
        strnotes = (self.appDelegate.masterLabeling.nOTES)!
        
    }
    
    //MARK:- Common Color Code
    func setColorCode()
    {
        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg
        
    }
    
    //MARK:- Zoom effect for EventImage
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isTranslucent = false
    }
    
    //MARK:- Close button listener
    @objc func btnClosePressed(sender:UIButton){
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isTranslucent = false
        
        if(self.isHideTabbar == true){
           // let userInfo = [ "isHideTabbar" : "YES" ]
         //   NotificationCenter.default.post(name: NSNotification.Name("HomeViewController"), object: nil, userInfo: userInfo)
        }
        
        self.dismiss(animated: true) {
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
