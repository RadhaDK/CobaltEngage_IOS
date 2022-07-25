//
//  ProductionClassDetails.swift
//  CSSI
//
//  Created by Kiran on 01/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper


class ProductionClassDetails : NSObject,Mappable
{
    var productClassDetails : [ProductionClass]?
    var isSkip : Int?
    var offerDetails : [OfferDetail]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.productClassDetails <- map["ProductClassDetails"]
        self.isSkip <- map["IsSkip"]
        self.offerDetails <- map["OfferDetails"]
    }
    
}


class ProductionClass : NSObject,Mappable
{
    var productClassID,locationID,productClass,imagePath : String?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
    
        self.productClassID <- map["ProductClassID"]
        self.locationID <- map["LocationID"]
        self.productClass <- map["ProductClass"]
        self.imagePath <- map["ImagePath"]
    }
    
}

class OfferDetail : NSObject , Mappable {
    
    var id,name,image,path,businessUrl,categoryName,fileType,videoURL,sectionName : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.id <- map["FileID"]
        self.name <- map["FileName"]
        self.image <- map["FileImage"]
        self.path <- map["FileExtension"]
        self.businessUrl <- map["BusinessUrl"]
        self.categoryName <- map["CategoryName"]
        self.fileType <- map["FileType"]
        self.videoURL <- map["VideoURL"]
        self.sectionName <- map["SectionName"]
    }
    
}
