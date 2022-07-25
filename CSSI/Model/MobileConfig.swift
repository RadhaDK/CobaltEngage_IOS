//
//  MobileConfig.swift
//  CSSI
//
//  Created by Kiran on 12/05/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

//Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
//ENGAGE0011898 -- Start
class MobileConfig : NSObject,Mappable
{
    var responseMessage : String?
    var filePath : String?
    var responseCode : String?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.responseMessage <- map["ResponseMessage"]
        self.filePath <- map["FilePath"]
        self.responseCode <- map["ResponseCode"]
    }
    
}
//ENGAGE0011898 -- End
