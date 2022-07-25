//
//  APIResponse.swift
//  CSSI
//
//  Created by Kiran on 03/11/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper
//Added by kiran -- GATHER0000176
class APIResponse : NSObject , Mappable
{
    var responseCode : String?
    var responseMessage : String?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.responseCode <- map["ResponseCode"]
        self.responseMessage <- map["ResponseMessage"]
    }
}
