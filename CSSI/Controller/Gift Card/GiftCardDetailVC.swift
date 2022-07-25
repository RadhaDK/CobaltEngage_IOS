//
//  GiftCardDetailVC.swift
//  CSSI
//
//  Created by apple on 1/27/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class GiftCardDetailVC: UIViewController {
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var lblCertificateCardTypeNumber: UILabel!
    @IBOutlet weak var lblCertificateCardType: UILabel!
    @IBOutlet weak var lblOriginalAmount: UILabel!
    @IBOutlet weak var lblbalanceAmount: UILabel!
    @IBOutlet weak var lblIssuedate: UILabel!
    @IBOutlet weak var lblExpDate: UILabel!
    @IBOutlet weak var lblCerificatecardtype: UILabel!
    @IBOutlet weak var lblOriginalAmounttitle: UILabel!
    @IBOutlet weak var lblBalanceAmountText: UILabel!
    //Added by kiran V2.9 -- ENGAGE0011597 -- Adding 2 fields for description and count.
    //ENGAGE0011597 -- Start
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    //ENGAGE0011597 -- End
    
    var dictGiftCardInfo = GiftCardList()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblCerificatecardtype.text = self.appDelegate.masterLabeling.cERTIFICATE_NCARD_TYPE
        self.lblOriginalAmounttitle.text = self.appDelegate.masterLabeling.oRIGINAL_NAMOUNT
        self.lblBalanceAmountText.text = self.appDelegate.masterLabeling.bALANCE_NAMOUNT

        lblCertificateCardTypeNumber.text = String(describing: dictGiftCardInfo.certificateNo ?? 00)
        lblCertificateCardType.text = dictGiftCardInfo.giftCardCategory
        lblOriginalAmount.text = self.appDelegate.masterLabeling.cURRENCY! + String(format: "%.2f",dictGiftCardInfo.originalPrice ?? 0.00)
        lblbalanceAmount.text = self.appDelegate.masterLabeling.cURRENCY! + String(format: "%.2f",dictGiftCardInfo.balanceAmount ?? 0.00)
        
        //Added by kiran V2.9 -- ENGAGE0011597 -- commented a replaced with lang file below
        //ENGAGE0011597 -- Start
//        lblIssuedate.text = String(format: "Issued Date: %@",dictGiftCardInfo.issuedDate!)
//        lblExpDate.text = String(format: "Expiration Date: %@",dictGiftCardInfo.expireDate!)
        //ENGAGE0011597 -- End
        self.navigationItem.title = self.appDelegate.masterLabeling.tT_GIFT_CARD

        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Path 398"), style: .plain, target: self, action: #selector(onTapHome))
        navigationItem.rightBarButtonItem = homeBarButton
        
        //Added by kiran V2.9 -- ENGAGE0011597 -- Adding 2 fields for description and count.
        //ENGAGE0011597 -- Start
        self.setFontColor()
        self.setLanguageFileData()
        self.lblIssuedate.text = "\(self.appDelegate.masterLabeling.giftCard_IssuedDate ?? "")\(self.dictGiftCardInfo.issuedDate ?? "")"
        self.lblExpDate.text = "\(self.appDelegate.masterLabeling.giftCard_ExpirationDate ?? "")\(self.dictGiftCardInfo.expireDate ?? "")"
        self.lblCount.text = "\(self.appDelegate.masterLabeling.giftCard_RemainingCount ?? "")\(self.dictGiftCardInfo.seriesCount ?? "")"
        self.lblDescription.text = "\(self.appDelegate.masterLabeling.giftCard_Description ?? "")\(self.dictGiftCardInfo.seriesDescription ?? "")"
        //ENGAGE0011597 -- End
        
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
    
    @objc private func backBtnAction(sender : UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    //ENGAGE0011297 -- End
    
    @objc func onTapHome()
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

//Added by kiran V2.9 -- ENGAGE0011597 -- Adding 2 fields for description and count.
//ENGAGE0011597 -- Start
extension GiftCardDetailVC
{
    private func setFontColor()
    {
        self.lblDescription.font = AppFonts.regular17
        self.lblCount.font = AppFonts.regular17
        
        self.lblDescription.textColor = APPColor.textColor.primary
        self.lblCount.textColor = APPColor.textColor.primary
    }
    
    private func setLanguageFileData()
    {
        
    }
}
//ENGAGE0011597 -- End
