//
//  CobaltImageView.swift
//  CSSI
//
//  Created by Kiran on 07/01/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import UIKit

protocol CobaltImageViewDelegate : AnyObject {
    func startedDownload(_ status : Bool)
    func finishedDownloading(_ status : Bool)
}

extension CobaltImageViewDelegate
{
    
//    func startedDownload(_ status : Bool)
//    {
//
//    }
//
//    func finishedDownloading(_ status : Bool)
//    {
//
//    }
}

class CobaltImageView: UIImageView {

    weak var delegate : CobaltImageViewDelegate?
    private var imageUrl : String?
    private let prefs = ImageCacheManager.shared.imageCache
    private var downloadTask : URLSessionTask?
    
    func loadImageFrom(_ urlString : String, shouldCache : Bool = false)
    {
        self.imageUrl = urlString
        self.image = UIImage.gifImageWithName("Icon-App-40x40")
        self.delegate?.startedDownload(true)
        if let image = prefs.object(forKey: NSString.init(string : urlString)) , shouldCache
        {
            self.image = image
            self.delegate?.finishedDownloading(true)
            return
        }
        
        if let url = URL.init(string: urlString.replacingOccurrences(of: " ", with: ""))
        {
            
           self.downloadTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error
                {
                    print(error)
                    self.delegate?.finishedDownloading(false)
                    return
                }
                
                DispatchQueue.main.async {
                    if let data = data,let cachedImage = UIImage.init(data: data)
                    {
                        if self.imageUrl == urlString
                        {
                            self.image = cachedImage
                            self.delegate?.finishedDownloading(true)
                        }
                        else
                        {
                            self.delegate?.finishedDownloading(false)
                        }
                        
                        if shouldCache
                        {
                            self.prefs.setObject(cachedImage, forKey: NSString.init(string : urlString))
                        }
                       
                    }
                    else
                    {
                        self.delegate?.finishedDownloading(false)
                    }
                    
                }
                
                
            }
            self.downloadTask?.resume()
        }
        else
        {
            self.delegate?.finishedDownloading(false)
            //print("invalid url string custom imageview")
        }
        
    }
    
    func cancelDownload()
    {
        self.downloadTask?.cancel()
        if downloadTask?.state == URLSessionTask.State.running
        {
            self.delegate?.finishedDownloading(false)
        }
    }
    
    deinit {
        self.downloadTask?.cancel()
        self.image = nil
        self.imageUrl = nil
        //print("removed Downloading image view")
    }


}
