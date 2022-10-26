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
    var result            : String!
    var responseMessage         : String!
    var Response  : GetDinningDetailData!
    var Restaurants       : [DiningRestaurantsData]!
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        result            = ""
        responseMessage         = ""
        Response = nil
        Restaurants       = []
    }
    
    func mapping(map: Map) {
        result            <- map["result"]
        responseMessage         <- map["ResponseMessage"]
        Response  <- map["Response"]
        Restaurants       <- map["Restaurants"]
    }
}

class GetDinningDetailData: NSObject, Mappable {
    var DiningSettings         : DiningSettingData!
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        DiningSettings = nil
    }
    
    func mapping(map: Map) {
        
        DiningSettings         <- map["DiningSettings"]
       
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
    var TimeSlots : [DiningTimmingsTimeSlotData]!
    var Timings : [DiningTimmingsData]!
    var MaxPartySize : Int!
    
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
        MaxPartySize = 0
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
        MaxPartySize <- map["MaxPartySize"]
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

class DiningTimmingsTimeSlotData: NSObject, Mappable {
    
    var TimeSlot         : String!
    
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        TimeSlot         = ""
        
    }
    func mapping(map: Map) {
        
        TimeSlot         <- map["TimeSlot"]
    }
}
