//
//  AlertDetails.swift
//  CSSI
//
//  Created by Kiran on 30/10/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper
//Created by Kiran -- ENGAGE0011226 -- Added for covid rules
//Start
class AlertDetails : NSObject,Mappable
{
    
    var covidRules : [AlertRules]?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.covidRules <- map["CovidRules"]
    }
    
}

class AlertRules : NSObject , Mappable
{
    
    var categoryName : String?
    var fileID : String?
    var filePath : String?
    var imagePath : String?
    var sectionName : String?
    
    override init() {
        super.init()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.categoryName <- map["CategoryName"]
        self.fileID <- map["FileID"]
        self.filePath <- map["FilePath"]
        self.imagePath <- map["ImagePath"]
        self.sectionName <- map["SectionName"]
    }
    
}
//END
