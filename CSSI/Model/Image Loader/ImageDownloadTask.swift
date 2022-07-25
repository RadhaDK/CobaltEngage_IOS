//
//  ImageDownloadTask.swift
//  CSSI
//
//  Created by Kiran on 06/03/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation

enum DownloadTaskState
{
    case stop
    case running
    case finished
}

class ImageDownloadTask
{
    var url : String?
    private(set) var downloadSession = URLSession.shared
    var data : Data?
    var state : DownloadTaskState = .stop
    var shouldCache : Bool = false
    //Added by kiran v2.7 -- GATHER0000855
    //GATHER0000855 -- Start
    private let imageCache = ImageCacheManager.shared.dataCache
    //GATHER0000855 -- End
    func startDownload(completionHandler : @escaping (Data?,URLResponse?,String?) -> Void)
    {
        
        if let urlString = url , let url = URL.init(string: urlString)
        {
            //Added by kiran v2.7 -- GATHER0000855 -- Replaced the cache with new image cache
            //GATHER0000855 -- Start
            if self.shouldCache, let data = self.imageCache.object(forKey: NSString.init(string: urlString)) as Data?//UserDefaults.standard.object(forKey: urlString) as? Data
            {
                self.state = .finished
                completionHandler(data,nil,urlString)
            }
            else
            {
                self.state = .running
                downloadSession.dataTask(with: url) { (data, response, error) in
                    self.data = data
                    self.state = .finished
                    completionHandler(data,response,self.url)
                    
                    if self.shouldCache, let data = data
                    {
                        self.imageCache.setObject(NSData.init(data: data), forKey: NSString.init(string: self.url ?? ""))
                        //UserDefaults.standard.setValue(data, forKey: self.url ?? "")
                    }
                    //GATHER0000855 -- End
                }.resume()
            }
            
        }
        else
        {
           completionHandler(nil,nil,self.url)
        }
    }
    
    
}
