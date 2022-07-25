//
//  ServiceDetails.swift
//  CSSI
//
//  Created by Kiran on 01/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper


class ServiceDetails : NSObject,Mappable
{
    
    var serviceDetails : [Service]?
    var isSkip : Int?
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.serviceDetails <- map["ServiceDetails"]
        self.isSkip <- map["IsSkip"]
    }
    
    
}


class Service : NSObject , Mappable
{
    var serviceID,productClassID,serviceName : String?
    var duration : String?
    
    // Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
    //GATHER0000923 -- Start
    var showCategoryInApp : Int?
    var serviceCategoryList : [ServiceCategory]?
    //GATHER0000923 -- End
    
    //Added by kiran v2.9 -- GATHER0000623 -- Disclaimer set-up by service to prompt based on settings
    //GATHER0000623 -- Start
    var disclaimer : String?
    //GATHER0000623 -- End
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.serviceID <- map["ServiceID"]
        self.productClassID <- map["ProductClassID"]
        self.serviceName <- map["ServiceName"]
        self.duration <- map["Duration"]
        
        // Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
        //GATHER0000923 -- Start
        self.showCategoryInApp <- map["ShowCategoryInApp"]
        self.serviceCategoryList <- map["ServiceCategoryList"]
        //GATHER0000923 -- End
        
        //Added by kiran v2.9 -- GATHER0000623 -- Disclaimer set-up by service to prompt based on settings
        //GATHER0000623 -- Start
        self.disclaimer <- map["Disclaimer"]
        //GATHER0000623 -- End
    }
    
    
}


// Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
//GATHER0000923 -- Start
class ServiceCategory : NSObject , Mappable
{
    var serviceCategoryID : String?
    var categoryName : String?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.serviceCategoryID <- map["ServiceCategoryID"]
        self.categoryName <- map["CategoryName"]
    }
    
}
//GATHER0000923 -- End
