//
//  ShareViewController.swift
//  CSSI
//
//  Created by apple on 2/22/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController{
    
    @IBOutlet weak var lblSharewithMember: UILabel!
    @IBOutlet weak var lblEnterURL: UILabel!
    @IBOutlet weak var lblUrl: UILabel!
    @IBOutlet weak var uiView: UIView!
    
    @IBOutlet weak var heightView: NSLayoutConstraint!
   // var imgURl : String?
    //var isFrom : String?
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Added on 19th May 2020 v2.1
    var contentDetails : ContentDetails?
    
    var contentType : ShareContentType = .none
    
    private var arrShareItems : [Any]?
    
    //Added by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
    //ENGAGE0012667 -- Start
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    //ENGAGE0012667 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        uiView.layer.cornerRadius = 6
        uiView.layer.borderWidth = 0.25
        uiView.layer.borderColor = hexStringToUIColor(hex: "2D2D2D").cgColor
        
        //Added on 19th May 2020 V2.1
        
        switch self.contentType
        {
        case .events:
            let eventsUrl = self.appDelegate.arrShareUrlList.filter({$0.name == "Events"}).first?.url
            
            lblUrl.text = String(format: "%@%@",eventsUrl ?? "" ,self.contentDetails?.id ?? "")
            lblEnterURL.text = self.appDelegate.masterLabeling.eventUrl
        case .clubNews:
            let clubNewsUrl = self.appDelegate.arrShareUrlList.filter({$0.name == "ClubNews"}).first?.url
            lblUrl.text = (clubNewsUrl ?? "") + (self.contentDetails?.id ?? "")
            lblEnterURL.text = self.appDelegate.masterLabeling.clubnewsUrl
        default:
            if self.appDelegate.arrShareUrlList.count != 0{
            lblUrl.text = appDelegate.arrShareUrlList[0].url
                }
            lblEnterURL.text = self.appDelegate.masterLabeling.clubnewsUrl
        }
        
        
        //oLd logic
        /*
        if(isFrom == "Events")
        {
            lblUrl.text = String(format: "%@%@", appDelegate.arrShareUrlList[3].url!,imgURl ?? "")
            lblEnterURL.text = self.appDelegate.masterLabeling.eventUrl
            
            
        }
        else if isFrom == "ClubNews"
        {
            let clubNewsUrl = self.appDelegate.arrShareUrlList.filter({$0.name == "ClubNews"}).first?.url
            lblUrl.text = (clubNewsUrl ?? "") + (imgURl ?? "")
            lblEnterURL.text = self.appDelegate.masterLabeling.clubnewsUrl
        }
        else{
            if self.appDelegate.arrShareUrlList.count != 0{
        lblUrl.text = appDelegate.arrShareUrlList[0].url
            }
        lblEnterURL.text = self.appDelegate.masterLabeling.clubnewsUrl

        }
        */
        
        //Added on 18th May 2020 v2.1
        //Generating Body and subject
        switch self.contentType {
        case .events:
            if let urlString = self.lblUrl.text , let url = NSURL.init(string: urlString)
            {
                self.arrShareItems = [URLItem.init(url: url)]
            }
            
        case .clubNews:
            
            if let clubNewsDetail = self.contentDetails
            {
                
                let strBody = BodyStringItem.init(body: "\(self.appDelegate.masterLabeling.clubNews_Title ?? "") \(clubNewsDetail.name ?? "")\n\n\(self.appDelegate.masterLabeling.clubNews_Date ?? "") \(clubNewsDetail.date ?? "")\n\n\(self.appDelegate.masterLabeling.clubNews_Link ?? "") \n\(self.lblUrl.text ?? "")",subject: clubNewsDetail.name)
                
                 self.arrShareItems = [strBody]
            }
            
        default:
            break
        }
        
        self.lblUrl.textColor = APPColor.textColor.secondary
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        heightView.constant = lblUrl.frame.height + 40
        
    }

    @IBAction func closeClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func sendClicked(_ sender: Any)
    {
        //Set the link to share.
        
        //Added on 18th May 2020 v2.1
        if let shareData = self.arrShareItems , shareData.count > 0
        {
            let activityVC = UIActivityViewController(activityItems: shareData, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
        }
        
        //Old logic
        /*
        if let link = NSURL(string: lblUrl.text! as String )
        {
            let objectsToShare = [link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
        }
        */

    }
}


