//
//  FitnessVideo.swift
//  CSSI
//
//  Created by Kiran on 12/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper




class FitnessVideos : NSObject, Mappable
{
    var videoDetails : [FitnessVideo]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.videoDetails <- map["VideoDetails"]
    }
}



class FitnessVideo : NSObject , Mappable
{
    var author : String?
    var videoDescription : String?
    var publishOn : String?
    var thumbnail : String?
    var title : String?
    var videoID : String?
    var videoURL : String?
    var isFavourite : Int?
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.author <- map["Author"]
        self.videoDescription <- map["Description"]
        self.publishOn <- map["PublishOn"]
        self.thumbnail <- map["Thumbnail"]
        self.title <- map["Title"]
        self.videoID <- map["VideoID"]
        self.videoURL <- map["VideoURL"]
        self.isFavourite <- map["IsFavourite"]
    }
    
}
