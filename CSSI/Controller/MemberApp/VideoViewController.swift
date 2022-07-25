//
//  VideoViewController.swift
//  CSSI
//
//  Created by apple on 2/22/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit
import WebKit

class VideoViewController: UIViewController {
    
    var videoURL : String!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate


    @IBOutlet weak var video: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)

                video.scrollView.isScrollEnabled = false
            if videoURL != nil || videoURL == ""{
                let url = URL (string: ("https://player.vimeo.com/video/") + (videoURL))
                let requestObj = URLRequest(url: url!)
                video.load(requestObj)
            }else{
                let url = URL (string: ("https://player.vimeo.com/video/"))
                let requestObj = URLRequest(url: url!)
                video.load(requestObj)
        }
                self.appDelegate.hideIndicator()

    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func closeClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
}
