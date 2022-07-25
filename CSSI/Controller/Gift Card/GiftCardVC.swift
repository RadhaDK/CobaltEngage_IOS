//
//  GiftCardVC.swift
//  CSSI
//
//  Created by apple on 1/27/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit
import ScrollableSegmentedControl
import Popover

class GiftCardVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableViewGiftCard: UITableView!
    @IBOutlet weak var lblCertificateType: UILabel!
    @IBOutlet weak var lblOriginalType: UILabel!
    @IBOutlet weak var lblBalanceType: UILabel!
    
    //Added on 23rd September 2020 V2.3
    @IBOutlet weak var viewSegmentHolder: UIView!
    @IBOutlet weak var btnPreviousSegment: UIButton!
    @IBOutlet weak var btnNextSegment: UIButton!
    @IBOutlet weak var viewSegment: UIView!
    
    @IBOutlet weak var viewRules: UIView!
    @IBOutlet weak var btnRules: UIButton!
    @IBOutlet weak var lblMember: UILabel!
    
    //Added by kiran V2.9 -- ENGAGE0011597 -- Adding 2 fields for description and count.
    //ENGAGE0011597 -- Start
    @IBOutlet weak var scrollViewGiftCard: UIScrollView!
    @IBOutlet weak var viewScrollContent: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var stackViewHeader: UIStackView!
    @IBOutlet weak var viewHeaders: UIView!
    //ENGAGE0011597 -- End
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrgiftcard = [GiftCard]()
    var arrGiftCardList = [GiftCardList]()
    var dictgiftcardInfo = GiftCard()
    
    //Added on 23rd September 2020 V2.3
    private var scrollSegmentedController : ScrollableSegmentedControl?
    private var popupView : Popover?
    private var selectedFilter : SelectedFilter?
    private var giftCardPDFLink : String?
    //Added on 14th October 2020 V2.3
    private var defaultFilter : SelectedFilter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Modified on 23rd September 2020 V2.3
        //getGiftCard(strSearch: "")
        self.initialSetups()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        //navigation item labelcolor
//        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
       // navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = self.appDelegate.masterLabeling.tT_GIFT_CARD
        self.lblCertificateType.text = self.appDelegate.masterLabeling.cERTIFICATE_NCARD_TYPE
        self.lblOriginalType.text = self.appDelegate.masterLabeling.oRIGINAL_NAMOUNT
        self.lblBalanceType.text = self.appDelegate.masterLabeling.bALANCE_NAMOUNT
     //   self.navigationController?.navigationBar.backItem?.title =  self.appDelegate.masterLabeling.bACK
    //    self.navigationController!.interactivePopGestureRecognizer!.isEnabled = false
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
//        self.getAuthToken()
        //Added on 23rd September 2020 V2.3
        if self.appDelegate.giftCertificateStatus.count > 0
        {
            let filterBtn = UIBarButtonItem.init(image: #imageLiteral(resourceName: "Filter"), style: .plain, target: self, action: #selector(self.didSelectFilter(sender:)))
            self.navigationItem.rightBarButtonItem = filterBtn
        }
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 -- Removing back button menus
        //ENGAGE0011297 -- Start
        self.navigationItem.leftBarButtonItem = self.navBackBtnItem(target: self, action: #selector(self.backBtnAction(sender:)))
        //ENGAGE0011297 -- End
        
        
         
    }
    
    //Added on 23rd September 2020 V2.3
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        if self.appDelegate.giftCertificateStatus.count > 0
        {
            self.loadSegmentController()
        }
        //Added by kiran V2.9 -- ENGAGE0011597 -- Adding 2 fields for description and count.
        //ENGAGE0011597 -- Start
        //Note:- We hid the labels Description and Count as this requirement changed and we are not showing them anymore so scroll is not needed. Uncomment this if these are to be shown in future
        //self.scrollViewGiftCard.flashScrollIndicators()
        //ENGAGE0011597 -- End
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
    
    //Added on 23rd September 2020 V2.3
    //MARK:- IB Action
    @IBAction func previousSegmentClicked(_ sender: UIButton)
    {
        if let currentIndex = self.scrollSegmentedController?.selectedSegmentIndex
        {
            let nextIndex = currentIndex - 1
            
            if nextIndex >= 0
            {
                self.scrollSegmentedController?.selectedSegmentIndex = nextIndex
            }
        }
    }
    
    @IBAction func nextSegmentClicked(_ sender: UIButton)
    {
        if let currentIndex = self.scrollSegmentedController?.selectedSegmentIndex
        {
            let nextIndex = currentIndex + 1
            
            if nextIndex < self.appDelegate.giftCertificateCardType.count
            {
                self.scrollSegmentedController?.selectedSegmentIndex = nextIndex
            }
           
        }
        
    }
    
    @IBAction func rulesClicked(_ sender: UIButton)
    {
        let restarantpdfDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
        restarantpdfDetailsVC.pdfUrl = self.giftCardPDFLink!
        restarantpdfDetailsVC.restarantName = self.appDelegate.masterLabeling.MB_GiftCard!

        self.navigationController?.pushViewController(restarantpdfDetailsVC, animated: true)
    }
    
    
    @objc func didSelectSegment(controller:ScrollableSegmentedControl)
    {
        self.getGiftCard(strSearch: "")
    }
    
    
    @objc func didSelectFilter(sender : UIBarButtonItem)
    {
        self.showFilter()
    }
    
    //Mark- Token Api
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
    
    //Mark- Giftcard Api
    func getGiftCard(strSearch :String) -> Void {
        if (Network.reachability?.isReachable) == true{
            
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            //Added on 12th October 2020 V2.3
            var selectedCardType = ""
            
            if let segmentController = self.scrollSegmentedController
            {
                selectedCardType = self.appDelegate.giftCertificateCardType[segmentController.selectedSegmentIndex].name ?? ""
            }
            
            // print(UserDefaultsKeys.userID.rawValue)
            let strUserID = UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)! as String
            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : strUserID ,//UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,  //UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue) ?? "",
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue) ?? "",
                APIKeys.ksearchby: strSearch,
                
                APIKeys.kdeviceInfo: [APIHandler.devicedict],
                //Added on 12th October 2020 V2.3
                APIKeys.status : self.selectedFilter?.option.Id ?? "",
                APIKeys.cardType : selectedCardType
            ]
            
            APIHandler.sharedInstance.getGiftCard(paramaterDict: paramaterDict, onSuccess: { arrGiftCard in
                if(arrGiftCard.responseCode == InternetMessge.kSuccess)
                {
                    if(arrGiftCard.giftcardList == nil)
                    {
                        self.arrGiftCardList.removeAll()

                        self.tableViewGiftCard.setEmptyMessage(InternetMessge.kNoData)
                        //Added by kiran V2.9 -- ENGAGE0011597 -- Adding 2 fields for description and count.
                        //ENGAGE0011597 -- Start
                        //Note:- We hid the labels Description and Count as this requirement changed and we are not showing them anymore so scroll is not needed. Uncomment this if these are to be shown in future
                        //let widthOffset = (self.tableViewGiftCard.frame.width/2) - (self.view.frame.width/2)
                        //self.scrollViewGiftCard.setContentOffset(CGPoint.init(x: widthOffset, y: 0), animated: true)
                        //ENGAGE0011597 -- End
                        self.tableViewGiftCard.reloadData()

                        self.appDelegate.hideIndicator()
                    }
                    else
                    {
                        //Added by kiran V2.9 -- ENGAGE0011597 -- Commented and moved this to else part of the below if Else operator.
                        //ENGAGE0011597 -- Start
                        // Added on 13 th October 2020 V2.3
                        //self.tableViewGiftCard.setEmptyMessage("")
                        //ENGAGE0011597 -- End
                        
                        if(arrGiftCard.giftcardList?.count == 0)
                        {
                            
                            self.arrGiftCardList.removeAll()
                            
                            self.tableViewGiftCard.setEmptyMessage(InternetMessge.kNoData)
                            //Added by kiran V2.9 -- ENGAGE0011597 -- Adding 2 fields for description and count.
                            //ENGAGE0011597 -- Start
                            //Note:- We hid the labels Description and Count as this requirement changed and we are not showing them anymore so scroll is not needed. Uncomment this if these are to be shown in future
                            //let widthOffset = (self.tableViewGiftCard.frame.width/2) - (self.view.frame.width/2)
                            //self.scrollViewGiftCard.setContentOffset(CGPoint.init(x: widthOffset, y: 0), animated: true)
                            //ENGAGE0011597 -- End
                            self.tableViewGiftCard.reloadData()
                            
                        }
                        else
                        {
                            //self.setCardView(view: self.tableViewGiftCard)
                            //self.tableViewGiftCard.restore()
                            self.arrGiftCardList = arrGiftCard.giftcardList!
                            
                            self.tableViewGiftCard.reloadData()
                            self.appDelegate.hideIndicator()
                            //Added by kiran V2.9 -- ENGAGE0011597 -- Adding 2 fields for description and count.
                            //ENGAGE0011597 -- Start
                            self.tableViewGiftCard.setEmptyMessage("")
                            //Note:- We hid the labels Description and Count as this requirement changed and we are not showing them anymore so scroll is not needed. Uncomment this if these are to be shown in future
                            //self.scrollViewGiftCard.flashScrollIndicators()
                            //self.scrollViewGiftCard.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
                            //ENGAGE0011597 -- End
                        }

                    }
                    //Added on 15th October 2020 V2.3
                    self.giftCardPDFLink = arrGiftCard.giftCardPdf
                    
                }else{
                    self.appDelegate.hideIndicator()
                    
                    if(((arrGiftCard.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: arrGiftCard.responseMessage, withDuration: Duration.kMediumDuration)
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
            // self.tableViewGiftCard.setEmptyMessage(InternetMessge.kInternet_not_available)
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
    
    }
    
  
    //Mark- Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return  self.arrGiftCardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:GiftCardTableViewCell = self.tableViewGiftCard.dequeueReusableCell(withIdentifier: "GiftCell") as! GiftCardTableViewCell
        let giftCardDict = self.arrGiftCardList[indexPath.row]
        cell.lblCertifiedTypeName.text = giftCardDict.giftCardCategory
        //Modified on 14th October 2020 V2.3
        cell.lblOriginalAmount.text = self.appDelegate.masterLabeling.cURRENCY! + String(format: "%.2f", giftCardDict.originalPrice ?? 00.00)
        //cell.lblOriginalAmount.text = self.appDelegate.masterLabeling.cURRENCY! + String(giftCardDict.originalPrice ?? 00.00)
        cell.lblBalanceAmount.text = self.appDelegate.masterLabeling.cURRENCY! + String(format: "%.2f",giftCardDict.balanceAmount ?? 0.00)
        cell.lblCertifiedCardTypeNumber.text = String(describing: giftCardDict.certificateNo ?? 0000) 
        
        //Added by kiran V2.9 -- ENGAGE0011597 -- Adding 2 fields for description and count.
        //ENGAGE0011597 -- Start
        //Note:- We hid the Description and Count labels as this requirement changed and we are not showing them anymore so scroll is not needed. make them visible if needed.
        //If showing the views remeber to uncomment and show the views in setLanguageFileData/setFontColor functions, and uncomment scrolling and scroll indicator flashing code in viewDIdAppear, and getGiftCard api call.
        //cell.lblDescription.text = (giftCardDict.seriesDescription ?? "")
        //cell.lblCount.text = (giftCardDict.seriesCount ?? "")
        //ENGAGE0011597 -- End
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.tableViewGiftCard.reloadData()
      
        let transactionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GiftCardDetailVC") as! GiftCardDetailVC
        transactionVC.dictGiftCardInfo = self.arrGiftCardList[indexPath.row]
        self.navigationController?.pushViewController(transactionVC, animated: true)
      
    }

}

//Added on 23rd September 2020 V2.3
extension GiftCardVC : HorizontalFilterViewDelegate
{
    func closeClicked()
    {
        self.popupView?.dismiss()
    }
    
    func doneClickedWith(filter: SelectedFilter?)
    {
        self.selectedFilter = filter
        self.popupView?.dismiss()
        self.getGiftCard(strSearch: "")
    }
    
}

//MARK:- Custom Methods
//Added on 23rd September 2020 V2.3
extension GiftCardVC
{
    //Added on 23rd September 2020 V2.3
    private func initialSetups()
    {
        let emptyView = UIView.init()
        emptyView.backgroundColor = .clear
        
        self.tableViewGiftCard.tableFooterView = emptyView
        
        if self.appDelegate.giftCertificateStatus.count > 0
        {
            self.viewSegmentHolder.isHidden = false
            self.viewRules.isHidden = false
            self.lblMember.text = String(format: "%@ | %@", UserDefaults.standard.string(forKey: UserDefaultsKeys.fullName.rawValue)!, self.appDelegate.masterLabeling.hASH! + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!)
            
            self.btnRules.setTitle(self.appDelegate.masterLabeling.MB_GiftCard ?? "", for: .normal)
            
            //Setting Default Selected Filter to Active
            self.defaultFilter = SelectedFilter.init(type: .Status, option: self.appDelegate.giftCertificateStatus.first(where: {$0.Id == "Active"}) ?? FilterOption.init())

            self.selectedFilter = self.defaultFilter
        }
        else
        {
            self.viewSegmentHolder.isHidden = true
            self.viewRules.isHidden = true
            self.getGiftCard(strSearch: "")
        }
        
        //Added by kiran V2.9 -- ENGAGE0011597 -- Adding 2 fields for description and count.
        //ENGAGE0011597 -- Start
        self.setFontColor()
        self.setLanguageFileData()
        //ENGAGE0011597 -- End
        //self.getGiftCard(strSearch: "")
        
        //Added by kiran V2.5 -- ENGAGE0011372 -- Custom method to dismiss screen when left edge swipe.
        //ENGAGE0011372 -- Start
        self.addLeftEdgeSwipeDismissAction()
        //ENGAGE0011372 -- Start
        
    }
    
    //Added by kiran V2.9 -- ENGAGE0011597 -- Adding 2 fields for description and count.
    //ENGAGE0011597 -- Start
    private func setFontColor()
    {
        //Note:- We hid the Description and Count labels as this requirement changed and we are not showing them anymore so scroll is not needed. make them visible if needed.
//        self.lblDescription.font = AppFonts.regular17
//        self.lblCount.font = AppFonts.regular17
//
//        self.lblDescription.textColor = APPColor.textColor.primary
//        self.lblCount.textColor = APPColor.textColor.primary
    }
    
    private func setLanguageFileData()
    {
        //Note:- We hid the Description and Count labels as this requirement changed and we are not showing them anymore so scroll is not needed. make them visible if needed.
        //self.lblDescription.text = self.appDelegate.masterLabeling.giftCard_Description_NoColon ?? ""
        //self.lblCount.text = self.appDelegate.masterLabeling.giftCard_RemainingCount_NoColon ?? ""
    }
    
    //ENGAGE0011597 -- End
    
    private func loadSegmentController()
    {
        if let _ = self.scrollSegmentedController
        {
            return
        }
        
        self.scrollSegmentedController = ScrollableSegmentedControl.init(frame: self.viewSegment.bounds)
        self.viewSegment.addSubview(self.scrollSegmentedController!)
        self.scrollSegmentedController!.segmentStyle = .textOnly
        self.scrollSegmentedController!.underlineSelected = true
        //self.scrollSegmentedController.backgroundColor = hexStringToUIColor(hex: "F5F5F5")
        self.scrollSegmentedController!.tintColor = APPColor.loginBackgroundButtonColor.loginBtnBGColor
        self.scrollSegmentedController!.addTarget(self, action: #selector(self.didSelectSegment(controller:)), for: .valueChanged)
        
        
        for (index,segment) in self.appDelegate.giftCertificateCardType.enumerated()
        {
            self.scrollSegmentedController!.insertSegment(withTitle: segment.name ?? "", at: index)
        }
        
        self.scrollSegmentedController!.selectedSegmentIndex = 0
        
        self.viewSegmentHolder.layoutIfNeeded()
        
    }
    
    
    private func showFilter()
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
        
        filterView.show(filter: Filter.init(type: .Status, options: self.appDelegate.giftCertificateStatus, displayName: self.appDelegate.masterLabeling.EVENT_STATUSFILTER ?? ""))
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
    
}
