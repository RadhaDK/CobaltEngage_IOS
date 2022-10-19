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
        Response = nil
    }
    
    func mapping(map: Map) {
        responseCode            <- map["ResponseCode"]
        responseMessage         <- map["ResponseMessage"]
        Response  <- map["Response"]
    }
}

class GetDinningDetailData: NSObject, Mappable {
    
    var DiningSettings         : DiningSettingData!
    var Restaurants       : [DiningRestaurantsData]!

    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        DiningSettings = nil
        Restaurants       = []
    }
    
    func mapping(map: Map) {
        
        DiningSettings         <- map["DiningSettings"]
        Restaurants       <- map["Restaurants"]
    }
}



class DiningSettingData: NSObject, Mappable {
    
    var TimeInterval         : Int!
    var MaxDaysInAdvanceTime       : String!
    var MaxDaysInAdvance : Int!
    var MinDaysInAdvance : Int!
    var MinDaysInAdvanceTime : String!
    var MaxPartySize : Int!
 
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        TimeInterval         = 0
        MaxDaysInAdvanceTime  = ""
        MaxDaysInAdvance = 0
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
    var TablePreference : [DiningTablePrefenceData]!
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


class DiningTablePrefenceData: NSObject, Mappable {
    
    var PreferenceName         : String!
    var TablePreferenceID       : String!
   
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        PreferenceName         = ""
        TablePreferenceID       = ""
    }
    
    func mapping(map: Map) {
        
        PreferenceName         <- map["PreferenceName"]
        TablePreferenceID       <- map["TablePreferenceID"]
    }
}
