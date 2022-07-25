//
//  ViewImageCollectionViewCell.swift
//  CSSI
//
//  Created by Kiran on 13/01/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

class ViewImageCollectionViewCell: UICollectionViewCell , UIScrollViewDelegate {
    
    @IBOutlet weak var imageViewNews: CobaltImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewImgContent: UIView!
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var scrollViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollViewTopConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.scrollView.delegate = self
        
        self.imageViewNews.delegate = self
//        self.imageViewNews.layer.cornerRadius = 10
//        self.imageViewNews.clipsToBounds = true
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageViewNews
    }
    
    func setAllSidePaddig(padding : CGFloat)
    {
        self.scrollViewTopConstraint.constant = padding
        self.scrollViewBottomConstraint.constant = padding
        self.scrollViewLeadingConstraint.constant = padding
        self.scrollViewTrailingConstraint.constant = padding
        self.scrollView.layoutIfNeeded()
    }
}

extension ViewImageCollectionViewCell : CobaltImageViewDelegate
{
    func startedDownload(_ status: Bool) {
        DispatchQueue.main.async {
            self.appDelegate.showIndicator(withTitle: "", intoView: self.imageViewNews)
        }
    }
    
    func finishedDownloading(_ status: Bool) {
        
        DispatchQueue.main.async {
            self.appDelegate.hideIndicator()
            
        }
        
    }
    
    
}
