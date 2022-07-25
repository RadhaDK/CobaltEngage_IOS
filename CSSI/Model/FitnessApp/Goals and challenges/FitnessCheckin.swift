//
//  FitnessCheckin.swift
//  CSSI
//
//  Created by Kiran on 28/10/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class FitnessCheckin : NSObject,Mappable
{
    var responseCode : String?
    var responseMessage : String?
    var checkInDetails : [Checkin]?
    
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.responseCode <- map["ResponseCode"]
        self.responseMessage <- map["ResponseMessage"]
        self.checkInDetails <- map["CheckInDetails"]
    }
}

class Checkin : NSObject,Mappable
{
    
    var submittedDate : String?
    var achieved : String?
    var goalParticipantDataID : String?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.submittedDate <- map["SubmittedDate"]
        self.achieved <- map["Achieved"]
        self.goalParticipantDataID <- map["GoalParticipantDataID"]
    }
    
}

