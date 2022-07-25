//
//  FitnessSetting.swift
//  CSSI
//
//  Created by Kiran on 11/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class FitnessSetting: NSObject,Mappable
{
    
    var name : String?
    var id : String?
    var isEnabled : Bool?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.name <- map["Text"]
        self.id <- map["Value"]
    }
    

}
