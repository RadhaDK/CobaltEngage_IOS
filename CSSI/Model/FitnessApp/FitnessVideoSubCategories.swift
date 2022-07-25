//
//  FitnessVideoSubCategories.swift
//  CSSI
//
//  Created by Kiran on 04/11/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

//Added by kiran V2.4 -- GATHER0000176
class FitnessVideoSubCategoriesResponse : NSObject,Mappable
{
    var videoCategoryDetails : [FitnessVideoSubCategories]?
    var responseMessage : String?
    var responseCode : String?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.videoCategoryDetails <- map["VideoCategoryDetails"]
        self.responseMessage <- map["ResponseMessage"]
        self.responseCode <- map["ResponseCode"]
        
    }
    
}

//Added by kiran V2.4 -- GATHER0000176
class FitnessVideoSubCategories : NSObject,Mappable
{
    
    var categoryName : String?
    var subCategoryDetails : [FitnessVideoSubCategory]?
    var videoID : String?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.categoryName <- map["CategoryName"]
        self.subCategoryDetails <- map["SubCategoryDetails"]
        self.videoID <- map["VideoID"]
    }
    
}

//Added by kiran V2.4 -- GATHER0000176
class FitnessVideoSubCategory : NSObject,Mappable
{
    var videoSubCategoryID : String?
    var videoCategoryID : String?
    var subCategoryName : String?
    var image : String?
    var videosCount : Int?

    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.videoSubCategoryID <- map["VideoSubCategoryID"]
        self.videoCategoryID <- map["VideoCategoryID"]
        self.subCategoryName <- map["SubCategoryName"]
        self.image <- map["Image"]
        self.videosCount <- map["VideosCount"]
    }
    
}
