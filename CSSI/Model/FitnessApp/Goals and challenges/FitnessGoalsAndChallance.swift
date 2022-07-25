//
//  FitnessGoalsAndChallance.swift
//  CSSI
//
//  Created by Kiran on 26/10/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper


class FitnessGoalsAndChallance : NSObject,Mappable
{
    var masterData : [FitnessActivityCategory]?
    var details : [GoalAndChallenge]?
    
   
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.masterData <- map["MasterData"]
        self.details <- map["Details"]
    }
    
}

