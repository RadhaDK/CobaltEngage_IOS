//
//  TimerModel.swift
//  CSSI
//
//  Created by Aks on 20/01/23.
//  Copyright © 2023 yujdesigns. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import ObjectMapper

class GetTimerMdel: NSObject, Mappable {
    var ResponseCode            : String!
    var responseMessage         : String!
    var ActiveUser             : String!
    var DiningScheduleUserActivityID : String!
    var ReservationTimer : String!
    var TimerMinutes : Int!
    var IsHardRuleEnabled  : String!
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        ResponseCode            = ""
        responseMessage         = ""
        ActiveUser             = ""
        DiningScheduleUserActivityID = ""
        ReservationTimer = ""
        TimerMinutes = 0
        IsHardRuleEnabled = ""
    }
    
    func mapping(map: Map) {
        ResponseCode            <- map["ResponseCode"]
        responseMessage         <- map["ResponseMessage"]
        ActiveUser          <- map["ActiveUser"]
        DiningScheduleUserActivityID <- map["DiningScheduleUserActivityID"]
        ReservationTimer <- map["ReservationTimer"]
        TimerMinutes <- map["TimerMinutes"]
        IsHardRuleEnabled <- map["IsHardRuleEnabled"]
    }
}



