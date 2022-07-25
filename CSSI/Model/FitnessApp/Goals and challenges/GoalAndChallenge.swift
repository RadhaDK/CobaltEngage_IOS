//
//  GoalAndChallenge.swift
//  CSSI
//
//  Created by Kiran on 11/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper


class GoalAndChallenge : NSObject,Mappable
{
    var goalID : String?
    var goalName : String?
    var goalTitle : String?
    var goalType : String?
    var parameter : String?
    var tips : String?
    var startDate : String?
    var endDate : String?
    var frequency : String?
    var startTime : String?
    var endTime : String?
    var weekDay : String?
    var displayText : String?
    var goalDescription : String?
    var duration : String?
    var isStarted : Int?
   
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.goalID <- map["GoalID"]
        self.goalName <- map["GoalName"]
        self.goalTitle <- map["GoalTitle"]
        self.goalType <- map["GoalType"]
        self.parameter <- map["Parameter"]
        self.tips <- map["Tips"]
        self.startDate <- map["StartDate"]
        self.endDate <- map["EndDate"]
        self.frequency <- map["Frequency"]
        self.startTime <- map["StartTime"]
        self.endTime <- map["EndTime"]
        self.weekDay <- map["WeekDay"]
        self.displayText <- map["DisplayText"]
        self.goalDescription <- map["Description"]
        self.duration <- map["Duration"]
        self.isStarted <- map["IsStarted"]
    }
    
}

