//
//  BMSThankYouVC.swift
//  CSSI
//
//  Created by Kiran on 16/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class BMSThankYouVC: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lblDepartment: UILabel!
    @IBOutlet weak var lblService: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblThankYou: UILabel!
    @IBOutlet weak var lblSuccessMessage: UILabel!
    @IBOutlet weak var imgViewLogo: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var imgViewBG: UIImageView!
    
    var strDepartment = ""
    var strService = ""
    var strDate = ""
    var strTime = ""
    var strThankyou = ""
    var strSuccessMessage = ""
    var imagePath = ""
    
    var closeClicked : (() -> ())!
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Added by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
    //ENGAGE0012667 -- Start
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    //ENGAGE0012667 -- End
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.lblDepartment.text = self.strDepartment
        self.lblService.text = self.strService
        self.lblDate.text = "\(self.appDelegate.masterLabeling.BMS_Date ?? "") \(self.strDate)"
        self.lblTime.text = "\(self.appDelegate.masterLabeling.BMS_Time ?? "") \(self.strTime)"
        self.lblThankYou.text = strThankyou
        self.lblSuccessMessage.text = self.strSuccessMessage
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        let downloadManager = ImageDownloadTask.init()
        downloadManager.url = self.imagePath
        DispatchQueue.global(qos: .userInteractive).async {
            downloadManager.startDownload { (data, response, url) in
                DispatchQueue.main.async {
                    self.appDelegate.hideIndicator()
                }
                
                if let data = data
                {
                    DispatchQueue.main.async {
                        self.imgViewBG.image = UIImage.init(data: data)
                    }
                }
                
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.contentView.layer.cornerRadius = 19
        self.contentView.clipsToBounds = true
    }
    
    @IBAction func closeClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        self.closeClicked()
    }
    

}
