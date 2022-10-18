//
//  GetDinningReservationDetailModel.swift
//  CSSI
//
//  Created by Aks on 14/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import ObjectMapper

class GetDinningDetail: NSObject, Mappable {
    
    var responseCode            : String!
    var responseMessage         : String!
    var Response  : GetDinningDetailData!
   
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        responseCode            = ""
        responseMessage         = ""
        
    }
    
    func mapping(map: Map) {
        responseCode            <- map["ResponseCode"]
        responseMessage         <- map["ResponseMessage"]
        Response  <- map["Response"]
    }
}

class GetDinningDetailData: NSObject, Mappable {
    
    var DiningSettings         : DiningSettingsData!
    var Restaurants       : [DiningRestaurantsData]!

    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
       
        Restaurants       = []
    }
    
    func mapping(map: Map) {
        
        DiningSettings         <- map["DiningSettings"]
        Restaurants       <- map["Restaurants"]
    }
}


class DiningSettingsData: NSObject, Mappable {
    
    var DiningSettings         : String!
    var Restaurants       : String!

    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        DiningSettings         = ""
        Restaurants       = ""
    }
    
    func mapping(map: Map) {
        
        DiningSettings         <- map["DiningSettings"]
        Restaurants       <- map["Restaurants"]
    }
}

class DiningSettingData: NSObject, Mappable {
    
    var TimeInterval         : Int!
    var MaxDaysInAdvanceTime       : Int!
    var MaxDaysInAdvance : String!
    var MinDaysInAdvance : Int!
    var MinDaysInAdvanceTime : String!
    var MaxPartySize : Int!
 
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        TimeInterval         = 0
        MaxDaysInAdvanceTime  = 0
        MaxDaysInAdvance = ""
        MinDaysInAdvance = 0
        MinDaysInAdvanceTime = ""
        MaxPartySize = 0
       
    }
    
    func mapping(map: Map) {
        
        TimeInterval         <- map["TimeInterval"]
        MaxDaysInAdvanceTime       <- map["MaxDaysInAdvanceTime"]
        MaxDaysInAdvance <- map["MaxDaysInAdvance"]
        MinDaysInAdvance <- map["MinDaysInAdvance"]
        MinDaysInAdvanceTime <- map["MinDaysInAdvanceTime"]
        MaxPartySize <- map["MaxPartySize"]
    }
}

class DiningRestaurantsData: NSObject, Mappable {
    
    var RestaurantName         : String!
    var RestaurantID       : String!
    var DinningPolicy : String!
    var IsAllowGuest : Int!
    var RestaurantImage : String!
    var TablePreference : [String]!
    var TimeSlots : [String]!
    var Timings : [DiningTimmingsData]!
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        RestaurantName         = ""
        RestaurantID       = ""
        DinningPolicy = ""
        IsAllowGuest = 0
        RestaurantImage = ""
        TablePreference = []
        TimeSlots = []
        Timings = []
    }
    
    func mapping(map: Map) {
        
        RestaurantName         <- map["RestaurantName"]
        RestaurantID       <- map["RestaurantID"]
        DinningPolicy <- map["DinningPolicy"]
        IsAllowGuest <- map["IsAllowGuest"]
        RestaurantImage <- map["RestaurantImage"]
        TablePreference <- map["TablePreference"]
        TimeSlots <- map["TimeSlots"]
        Timings <- map["Timings"]
    }
}


class DiningTimmingsData: NSObject, Mappable {
    
    var EndTime         : String!
    var StartTime       : String!
   
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        EndTime         = ""
        StartTime       = ""
     
    }
    
    func mapping(map: Map) {
        
        EndTime         <- map["EndTime"]
        StartTime       <- map["StartTime"]
   
    }
}
