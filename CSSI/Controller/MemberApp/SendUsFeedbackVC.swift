//
//  SendUsFeedbackVC.swift
//  CSSI
//
//  Created by apple on 11/26/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class SendUsFeedbackVC: UIViewController {
    
    var isFrom : NSString!
    @IBOutlet weak var sendUsFeedBackView: UIView!
    @IBOutlet weak var lblFeedbackTitleText: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblRedirectLogin: UILabel!
    @IBOutlet weak var btnSend: UIButton!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var sendUsFeed: SenUsFeedback? = nil
    var timer: Timer? = nil
    var count = 10
    var privateSiteURL : String?
    
    //Added by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
    //ENGAGE0012667 -- Start
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    //ENGAGE0012667 -- End

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.handleTimer), userInfo: nil, repeats: true)
        btnSend .setTitle(self.appDelegate.masterLabeling.skip, for: .normal)
        self.lblRedirectLogin.text = self.appDelegate.masterLabeling.rELOGINTO_PRIVATESITE
        self.lblFeedbackTitleText.text = self.appDelegate.masterLabeling.rEDIRECTTO_PRIVATESITE
        
        self.lblTime.layer.borderWidth = 1
        self.lblTime.layer.borderColor = hexStringToUIColor(hex: "#568A8E").cgColor
        
        let privateSite: NSMutableAttributedString = NSMutableAttributedString(string: self.lblFeedbackTitleText.text!)
        privateSite.setColor(color: APPColor.textColor.secondary, forText: self.appDelegate.masterLabeling.pRIVATESITE!)
        // or use direct value for text "red"
        self.lblFeedbackTitleText.attributedText = privateSite
        self.btnSend.setStyle(style: .contained, type: .primary)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        count = 10
    }
    
    
    @objc func handleTimer(_ timer: Timer) {
        if count == 0 {
            guard let url = URL(string: privateSiteURL ?? "") else { return }
          //  guard let url = URL(string: "https://devcobalt.bocawestcc.org/bw.dev") else { return }

            UIApplication.shared.open(url)
            self.timer?.invalidate()

            dismiss(animated: true, completion: nil)

        }else{
        
        self.lblTime.text = String(format: "00:0%@", String(count - 1))
        count = count - 1
        }
    }
    
    
   

    @IBAction func closeClicked(_ sender: Any) {
        self.timer?.invalidate()

        dismiss(animated: true, completion: nil)

    }
    @IBAction func sendClicked(_ sender: Any) {

        
        guard let url = URL(string: privateSiteURL ?? "") else { return }
      //  guard let url = URL(string: "https://devcobalt.bocawestcc.org/bw.dev") else { return }

        UIApplication.shared.open(url)
        self.timer?.invalidate()

        dismiss(animated: true, completion: nil)
        

//        if (txtFeedBack.text == "") {
//            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:self.appDelegate.masterLabeling.pLEASE_PROVIDE_FEEDBACK, withDuration: Duration.kMediumDuration)
//            return
//        }
//        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
//
//        let params: [String : Any] = [
//            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
//            APIKeys.kdeviceInfo: [APIHandler.devicedict],
//            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
//            APIKeys.kID : UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
//            "Comments" : txtFeedBack.text
//
//            ]
//
//        APIHandler.sharedInstance.sendUsFeedback(paramater: params, onSuccess: { (response) in
//
//           // self.dismiss(animated: true, completion: nil)
//
//            self.sendUsFeed = response
//
//
//
//
//            if let updateGuestViewController = UIStoryboard.init(name: "GuestCard", bundle: .main).instantiateViewController(withIdentifier: "ThanksApproveVC") as? ThanksApproveVC {
//                self.appDelegate.hideIndicator()
//                updateGuestViewController.isFrom = "Feedback"
//
//                self.present(updateGuestViewController, animated: true, completion: nil)
//                self.dismiss(animated: true, completion: nil)
//
//            }
//
//        }) { (error) in
//            SharedUtlity.sharedHelper().showToast(on:self.view, withMeassge:error.localizedDescription, withDuration: Duration.kMediumDuration)
//            self.appDelegate.hideIndicator()
//
//        }
//
//
//
//
    }
}
