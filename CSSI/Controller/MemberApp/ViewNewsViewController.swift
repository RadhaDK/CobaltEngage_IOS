//
//  ViewNewsViewController.swift
//  CSSI
//
//  Created by apple on 12/24/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class ViewNewsViewController: UIViewController{
    
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var collectionViewImages: UICollectionView!
    @IBOutlet weak var pageControlImages: UIPageControl!
    
    
    var isFrom: String?
    
    //Note : Renamed to arrMediaDetails from arrImgURl on 14th May 2020 v2.1
    ///Media to be displayed
    ///
    /// Note :   Images/Videos/Content
    var arrMediaDetails : [MediaDetails]?
    
    private var currentIndex : Int = 0
    private var leftGestureRecognizer : UISwipeGestureRecognizer?
    private var rightGestureRecognizer : UISwipeGestureRecognizer?
    
   // private var lastOffest : CGFloat = 0
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    ///Defines the content mode for the image view
    ///
    /// Note : scale to fill is the default mode if not specified. Only appcable for images
    var imageContentMode : UIViewContentMode = .scaleToFill
    
    var shouldClearBackgroundImgColor = false
    
    ///Applies padding to images/Videos/Content on all sides.
    var padding : CGFloat = 0
    
    ///Enables/Disables zooming
    ///
    /// Note: Only appicable for images
    var enableZooming : Bool = true
    
    //Added on 18th May 2020 v2.1
    
    ///Details of news/image which should be  shared
    var contentDetails : ContentDetails?
    
    ///Indicates if the content being shown is clubnews or image
    var contentType : ViewNewsType = .clubNews
    
    //Added by kiran V3.2 -- ENGAGE0012667 -- Custom nav change in xcode 13
    //ENGAGE0012667 -- Start
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    //ENGAGE0012667 -- End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionViewImages.delegate = self
        self.collectionViewImages.dataSource = self
        self.collectionViewImages.isPrefetchingEnabled = false
        self.collectionViewImages.layer.cornerRadius = 10
        self.collectionViewImages.clipsToBounds = true
        
        self.collectionViewImages.register(UINib.init(nibName: "ViewVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ViewVideoCollectionViewCell")
        self.collectionViewImages.register(UINib.init(nibName: "viewContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "viewContentCollectionViewCell")
        
        if self.arrMediaDetails?.count ?? 0 > 1
        {
            self.pageControlImages.isHidden = false
            self.pageControlImages.currentPage = 0
        }
        else
        {
            self.pageControlImages.isHidden = true
        }
       
        
        for i in 0 ..< appDelegate.arrShareUrlList.count {
            if(appDelegate.arrShareUrlList[i].name == "ClubNews"){
                self.btnShare.isHidden = false
                if(isFrom == "Events" || isFrom == "MemberDirectoryDetails"){
                    self.btnShare.isHidden = true
                }
                else{
                    self.btnShare.isHidden = false
                    
                    if (UserDefaults.standard.string(forKey: UserDefaultsKeys.shareUrl.rawValue) == "1"){
                        self.btnShare.isHidden = false
                        
                    }
                    else{
                        self.btnShare.isHidden = true
                        
                    }
                }
                return
            }
            else{
                self.btnShare.isHidden = true
                //return
                
            }
        }
        
    }
    
    @IBAction func shareClicked(_ sender: Any)
    {
        //Modified on 19th May 2020 v2.1
        if let share = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ShareViewController") as? ShareViewController , let index = self.collectionViewImages.indexPathsForVisibleItems.first?.row
        {
            share.modalTransitionStyle   = .crossDissolve;
            share.modalPresentationStyle = .overCurrentContext

            switch self.contentType {
            case .clubNews:
                share.contentDetails = self.contentDetails
                share.contentType = .clubNews
            case .image:
                share.contentDetails = ContentDetails.init(id: self.arrMediaDetails?[index].newsImage, date: nil, name: nil, link: self.arrMediaDetails?[index].newsImage)
            }
            self.present(share, animated: true, completion: nil)
        }
        
        //Old logic
        /*
        if let share = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "ShareViewController") as? ShareViewController , let index = self.collectionViewImages.indexPathsForVisibleItems.first?.row
               {
                   share.modalTransitionStyle   = .crossDissolve;
                   share.modalPresentationStyle = .overCurrentContext
                   share.imgURl = self.arrMediaDetails?[index].newsImage //imgURl
                   self.present(share, animated: true, completion: nil)
               }
        
        */
    }
    
    @IBAction func closeClicked(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func pageControlValueDidChange(_ sender: UIPageControl)
    {
        //Un commnet to enable image/video changes when click on page nation control dots
        //self.collectionViewImages.scrollToItem(at: IndexPath.init(row: sender.currentPage, section: 0), at: UICollectionViewScrollPosition.left, animated: true)
    }

}

//MARK:- Custom Methods
extension ViewNewsViewController
{
    //Commented by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead
    //ENGAGE0011419 -- Start
//    func verifyUrl(urlString: String?) -> Bool {
//        if let urlString = urlString {
//            if let url = URL(string: urlString) {
//                return UIApplication.shared.canOpenURL(url)
//            }
//        }
//        return false
//    }
    //ENGAGE0011419 -- End
}


//MARK:- Collection View delegates
extension ViewNewsViewController : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.collectionViewImages.frame.size.width, height: self.collectionViewImages.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let numberOfItems = self.arrMediaDetails?.count ?? 0
         
        self.pageControlImages.numberOfPages = numberOfItems
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let media = self.arrMediaDetails?[indexPath.row]
        //Modified to include video support on 14th May 2020 v2.1
        switch media?.type {
        case .image?:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewImageCollectionViewCell", for: indexPath) as! ViewImageCollectionViewCell
            if self.enableZooming
            {
                cell.scrollView.zoomScale = 1.0
                cell.scrollView.minimumZoomScale = 1.0
                cell.scrollView.maximumZoomScale = 10.0
                
            }
            cell.imageViewNews.image = nil
            cell.imageViewNews.contentMode = self.imageContentMode
            cell.imageViewNews.loadImageFrom((self.arrMediaDetails?[indexPath.row].newsImage) ?? "")
            
            cell.setAllSidePaddig(padding: self.padding)
            if self.shouldClearBackgroundImgColor
            {
                cell.viewImgContent.backgroundColor = .clear
            }
            return cell
            
        case .video?:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewVideoCollectionViewCell", for: indexPath) as! ViewVideoCollectionViewCell
            
            if self.shouldClearBackgroundImgColor
            {
                cell.viewContent.backgroundColor = .clear
            }
            
            let urlString = "https://player.vimeo.com/video/" + (media?.newsImage?.videoID ?? "")
            let requestObj = URLRequest(url: URL.init(string: urlString)!)
            cell.videoWebView.load(requestObj)
            return cell
            
        case .content?:
            
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewContentCollectionViewCell", for: indexPath) as! viewContentCollectionViewCell
            
             if self.shouldClearBackgroundImgColor
             {
                cell.viewContent.backgroundColor = .clear
             }
             
             cell.applyPading(self.padding == 0 ? 16 : self.padding)
             cell.contentTextView.text = nil
             
             cell.contentTextView.attributedText = media?.newsImage?.htmlToAttributedString
             
            return cell
            
        default:
            self.collectionViewImages.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "emptyCell")
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let cell = cell as? ViewImageCollectionViewCell
        {
            cell.imageViewNews.cancelDownload()
        }
        
    }
    
}

extension ViewNewsViewController : UIScrollViewDelegate
{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageWidth = self.collectionViewImages.frame.width

        let fractionalPageWidth = scrollView.contentOffset.x / pageWidth

        let pageIndex = lround(Double(fractionalPageWidth))

        self.pageControlImages.currentPage = pageIndex
        
    }
    
}
