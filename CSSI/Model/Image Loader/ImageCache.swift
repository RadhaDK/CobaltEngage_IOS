//
//  ImageCache.swift
//  CSSI
//
//  Created by Kiran on 07/01/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    private init()
    {
        
    }
    
    let imageCache : NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 15
        return cache
    }()
    
    //Added by kiran v2.7 -- GATHER0000855
    //GATHER0000855 -- Start
    let dataCache : NSCache<NSString,NSData> = {
        let cache = NSCache<NSString,NSData>()
        cache.countLimit = 20
        return cache
    }()
    //GATHER0000855 -- End
}

