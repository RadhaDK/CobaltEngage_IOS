//
//  FitnessActivity.swift
//  CSSI
//
//  Created by Kiran on 16/10/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class FitnessActivities : NSObject,Mappable
{
    
    var activities : [FitnessActivity]?
    
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.activities <- map["FitnessActivities"]
    }
    
}


class FitnessActivity : NSObject,Mappable
{
    
    var icon1x : String?
    var icon2x : String?
    var icon3x : String?
    ///Text is assigned
    var name : String?
    ///Value is assigned
    var id : String?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.icon1x <- map["Icon1x"]
        self.icon2x <- map["Icon2x"]
        self.icon3x <- map["Icon3x"]
        self.name <- map["Text"]
        self.id <- map["Value"]
    }
    
}

