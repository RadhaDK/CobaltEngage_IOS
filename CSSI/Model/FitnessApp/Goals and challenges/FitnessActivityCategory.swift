//
//  FitnessActivityCategory.swift
//  CSSI
//
//  Created by Kiran on 26/10/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class FitnessActivityCategory : NSObject,Mappable
{
    var goalMasterName : String?
    var goalMasterID : String?
    var icon1x : String?
    var icon2x : String?
    var icon3x : String?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.goalMasterID <- map["GoalMasterID"]
        self.goalMasterName <- map["GoalMasterName"]
        self.icon1x <- map["Icon1x"]
        self.icon2x <- map["Icon2x"]
        self.icon3x <- map["Icon3x"]
        
    }
    
}
