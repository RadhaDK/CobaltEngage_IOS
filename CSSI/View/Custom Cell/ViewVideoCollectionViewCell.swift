//
//  ViewVideoCollectionViewCell.swift
//  CSSI
//
//  Created by Kiran on 14/05/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit
import WebKit

class ViewVideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var videoWebView: WKWebView!
    @IBOutlet weak var viewContent: UIView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.videoWebView.navigationDelegate = self
    }
}

extension ViewVideoCollectionViewCell : WKNavigationDelegate
{
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.appDelegate.showIndicator(withTitle: "", intoView: self.viewContent)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        if !webView.isLoading
        {
            self.appDelegate.hideIndicator()
        }
    }
}
