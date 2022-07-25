
import UIKit

class GiftCardDetailsViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewGiftCard: UITableView!
    private let cellReuseIdentifier: String = "cell"
    
    @IBOutlet weak var uiViewFooterView: UIView!
    
    @IBOutlet weak var lblIssuedDate: UILabel!
    
    @IBOutlet weak var lblExpiryValue: UILabel!
    
    @IBOutlet weak var lblExpiryDate: UILabel!
    
    @IBOutlet weak var lblIssuedValue: UILabel!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var tableviewGiftCard: UITableView!
    var dictGiftCardInfo = GiftCardList()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  self.extendedLayoutIncludesOpaqueBars = true

        self.setColorCode()
        self.initController()
        
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
        
        
    }
    @objc func onTapHome() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    func initController()
    {
        self.navigationController?.navigationBar.isHidden = false
        //navigation item labelcolor
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = self.appDelegate.masterLabeling.tT_GIFT_CARD
        self.navigationController?.navigationBar.backItem?.title =  self.appDelegate.masterLabeling.bACK
        self.navigationController?.navigationBar.topItem?.title =  self.appDelegate.masterLabeling.bACK
        self.definesPresentationContext = true
        
        self.lblIssuedDate.font = SFont.SourceSansPro_Regular14
        self.lblExpiryDate.font = SFont.SourceSansPro_Regular14
        self.lblIssuedValue.font = SFont.SourceSansPro_Semibold14
        self.lblExpiryValue.font = SFont.SourceSansPro_Semibold14
        
        self.lblIssuedValue.text =  dictGiftCardInfo.issuedDate ?? ""
        self.lblExpiryValue.text =   dictGiftCardInfo.expireDate ?? ""
        self.lblIssuedDate.text = self.appDelegate.masterLabeling.iSSUED_DATE
        self.lblExpiryDate.text = self.appDelegate.masterLabeling.eXPIRY_DATE
        
        
        
        self.tableViewGiftCard.separatorInset = .zero
        self.tableViewGiftCard.tableFooterView = UIView()
        self.tableViewGiftCard.layoutMargins = .zero
        self.tableViewGiftCard.separatorStyle = .none;
        self.tableViewGiftCard.separatorColor = UIColor.clear
        self.tableViewGiftCard.delegate = self
        self.tableViewGiftCard.dataSource = self
        self.tableViewGiftCard.rowHeight = 54
        self.tableViewGiftCard.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.tableViewGiftCard.sectionHeaderHeight = 44
        // self.tableViewGiftCard.separatorStyle = .none
        
        
        let rowheight:Double = 54 //Double(self.tableViewStatement.rowHeight)
        let rowWidth:Double = Double(self.view.frame.size.width)   //Double(self.tableViewStatement.frame.size.width)
        let numberofColouns:Int = 3
        
        var xAxis: Double = 15
        let yAxis: Double = 0
        let uiViewHeaderView = UIView.init()
        
        
        
        
        
        uiViewHeaderView.frame = CGRect(x: 0, y: 0, width: rowWidth , height: rowheight-1)
        let uiViewLine = UIView.init()
        uiViewLine.frame = CGRect(x: xAxis, y: rowheight - 1, width: rowWidth , height: 1)
        uiViewLine.backgroundColor = APPColor.viewBgColor.viewbg
        uiViewHeaderView .addSubview(uiViewLine)
        uiViewHeaderView.backgroundColor = APPColor.viewBgColor.viewbg
        uiViewHeaderView.addBottomBorderWithColor(color:APPColor.tintColor.tint , width: 1)
        
        let viewWidth: Double = (rowWidth / Double(numberofColouns))-15
        
        for j in 0 ..< numberofColouns {
            
            let uiView = UIView.init()
            
            uiView.frame = CGRect(x: xAxis, y: yAxis, width: viewWidth , height: rowheight)
            xAxis = xAxis + Double(uiView.frame.size.width)  + Double(8)
            
            uiViewHeaderView .addSubview(uiView)
            
            
            
            let lableHeight = uiView.frame.size.height
            let btnTitle = UIButton.init()
            btnTitle.frame = CGRect(x: 0, y: 0, width: uiView.frame.size.width, height: lableHeight)
            
            
            
            //font
            btnTitle.titleLabel?.font = SFont.SourceSansPro_Semibold12
            
            btnTitle .setTitle(self.appDelegate.masterLabeling.cERTIFICATE_NCARD_TYPE, for: .normal)
            //   btnTitle.titleLabel?.numberOfLines = 2
            //    btnTitle.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
            
            uiView.addSubview(btnTitle)
            btnTitle.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0) // top // left // bottom // right
            btnTitle.contentHorizontalAlignment = .left
            btnTitle.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
            
            if(j == 1){
                btnTitle .setTitle(self.appDelegate.masterLabeling.oRIGINAL_NAMOUNT, for: .normal)
                btnTitle.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
                btnTitle.contentHorizontalAlignment = .right
            }
            
            if(j == 2){
                btnTitle .setTitle(self.appDelegate.masterLabeling.bALANCE_NAMOUNT, for: .normal)
                btnTitle.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
                btnTitle.contentHorizontalAlignment = .right
            }
            btnTitle.setTitleColor(APPColor.textheaderColor.header, for: .normal)
        }
        
        self.tableViewGiftCard.tableHeaderView = uiViewHeaderView
        self.tableViewGiftCard.tableFooterView = self.uiViewFooterView
        self.setCardView(view: self.tableViewGiftCard)
        
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        self.definesPresentationContext = true
        
        
    }
    
    
    func setCardView(view : UIView){
        
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = 1;
        view.layer.shadowRadius = 2;
        view.layer.shadowOpacity = 0.5;
        
    }
    
    
    //Mark- Common Color Code
    func setColorCode()
    {
        self.view.backgroundColor = APPColor.viewBackgroundColor.viewbg
        
        
    }
    
    //MARK:- Tableview Delegate & Datasource methods
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    
    
    //the method returning each cell of the list
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //            var cell:UITableViewCell? = tableView.dequeueReusobleCell(withIdentifier: cellReuseIdentifier)
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: String(format: "\(cellReuseIdentifier)%d", indexPath.row))
        if (cell == nil) {
            cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier: cellReuseIdentifier)
        }
        
        let rowheight:Double = Double(self.tableViewGiftCard.rowHeight)
        let rowWidth:Double = Double(self.view.frame.size.width) //Double(self.tableViewStatement.frame.size.width)
        let numberofColouns:Int = 3
        var xAxis: Double = 15
        let yAxis: Double = 0
        let viewWidth: Double = (rowWidth / Double(numberofColouns)) - 15
        for i in 0 ..< numberofColouns {
            let uiView = UIView.init()
            uiView.frame = CGRect(x: xAxis, y: yAxis, width: viewWidth , height: rowheight)
            cell?.contentView.addSubview(uiView)
            
            xAxis = xAxis + Double(uiView.frame.size.width)  + Double(8)
            
            let lableHeight = uiView.frame.size.height
            
            
            let btnTitle = UIButton.init()
            
            btnTitle.frame = CGRect(x: 0, y: 0, width: uiView.frame.size.width, height: lableHeight / 2)
            btnTitle .setTitle(String(describing: dictGiftCardInfo.certificateNo ?? 00), for: .normal)
            btnTitle.titleLabel?.font = SFont.SourceSansPro_Semibold14
            uiView.addSubview(btnTitle)
            
            
            
            let btnDescription = UIButton.init()
            btnDescription.frame = CGRect(x: 0, y: btnTitle.frame.size.height, width: uiView.frame.size.width, height: (lableHeight / 2) - 2)
            print("category\("Golf")")
            
            btnDescription .setTitle(dictGiftCardInfo.giftCardCategory, for: .normal)
            
            
            btnDescription.titleLabel?.font = SFont.SourceSansPro_Regular14
            //  btnDescription.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            uiView.addSubview(btnDescription)
            
            btnTitle.contentEdgeInsets = UIEdgeInsetsMake(8, 0, 0, 0) // top // left // bottom // right
            btnDescription.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0) // top // left // bottom // right
            
            btnTitle.setTitleColor(APPColor.textColor.text, for: .normal)
            btnDescription.setTitleColor(APPColor.textColor.text, for: .normal)
            btnTitle.contentHorizontalAlignment = .left
            btnDescription.contentHorizontalAlignment = .left
            btnDescription.titleLabel?.lineBreakMode = .byTruncatingTail
            
            if(i == 1){
                btnTitle .setTitle(self.appDelegate.masterLabeling.cURRENCY! + "0.0", for: .normal)
                btnTitle.removeFromSuperview()
                btnDescription.frame = CGRect(x: 0, y: 0, width: uiView.frame.size.width, height: lableHeight )
                var resultStringOriginalPrice = self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",dictGiftCardInfo.originalPrice ?? 0.00)
                if((dictGiftCardInfo.originalPrice ?? 0.00) < 0){
                    let temp = -(dictGiftCardInfo.originalPrice ?? 0.00)
                    let firstchar = String(format: "%.2f",dictGiftCardInfo.originalPrice ?? 0.00).prefix(1)
                    resultStringOriginalPrice = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
                }
                btnDescription .setTitle(resultStringOriginalPrice, for: .normal)

                btnDescription.setTitleColor(APPColor.textColor.text, for: .normal)
                btnDescription.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0) // top // left // bottom // right
                btnDescription.titleLabel?.font = SFont.SourceSansPro_Semibold14
                btnDescription.contentHorizontalAlignment = .right

            }
            
            if(i == 2){
                btnTitle.removeFromSuperview()
                btnDescription.frame = CGRect(x: 0, y: 0, width: uiView.frame.size.width, height: lableHeight )
                
                var resultString = self.appDelegate.masterLabeling.cURRENCY! +  String(format: "%.2f",dictGiftCardInfo.balanceAmount ?? 0.00)
                if((dictGiftCardInfo.balanceAmount ?? 0.00) < 0){
                    let temp = -(dictGiftCardInfo.balanceAmount ?? 0.00)
                    let firstchar = String(format: "%.2f",dictGiftCardInfo.balanceAmount ?? 0.00).prefix(1)
                    resultString = firstchar + self.appDelegate.masterLabeling.cURRENCY!  + String(format: "%.2f",temp)
                }
                btnDescription .setTitle(resultString, for: .normal)
                btnDescription.setTitleColor(APPColor.solidbgColor.solidbg, for: .normal)
                btnDescription.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0) // top // left // bottom // right
                btnDescription.titleLabel?.font = SFont.SourceSansPro_Semibold14
                btnDescription.contentHorizontalAlignment = .right
            }
            
            
            if(i == 0){
                btnDescription.setTitleColor(APPColor.solidbgColor.solidbg, for: .normal)
            }
            
            btnTitle.tag = indexPath.row
            btnDescription.tag = indexPath.row
        }
        return cell!
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = false
        //navigation item labelcolor
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.topItem?.title = self.appDelegate.masterLabeling.bACK
        self.navigationController?.navigationBar.backItem?.title =  self.appDelegate.masterLabeling.bACK
        self.navigationItem.title = self.appDelegate.masterLabeling.gIFT_CARD!
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
}


