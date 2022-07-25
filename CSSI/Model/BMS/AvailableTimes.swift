//
//  AvailableTimes.swift
//  CSSI
//
//  Created by Kiran on 06/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper



class AvailableTimes : NSObject , Mappable
{
    var availableTimeList : [BTimes]?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        availableTimeList <- map["AvailableTimeList"]
    }
    
}

class BTimes : NSObject , Mappable
{
    var time : String?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        time <- map["Time"]
    }
    
}
