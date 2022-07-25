//
//  CSSIGeoFence.swift
//  CSSI
//
//  Created by Kiran on 18/11/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

//Added by kiran V2.5 --ENGAGE0011341 -- Gimbal Geo fence implementation Integration
class CSSIGeofence : NSObject,Mappable
{
    var latitude : Double?
    var longitude : Double?
    var radius : Double?
    var id : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.latitude <- map["Latitude"]
        self.longitude <- map["Longitude"]
        self.radius <- map["Radius"]
        self.id <- map["Identifier"]
    }
}
