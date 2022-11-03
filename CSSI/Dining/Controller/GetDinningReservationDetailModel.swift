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
    var restaurants             : [DiningRestaurantsData]!
    var diningSettings          : DiningSettingData!
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        result            = ""
        responseMessage         = ""
        restaurants             = []
        diningSettings          = DiningSettingData()
    }
    
    func mapping(map: Map) {
        result            <- map["result"]
        responseMessage         <- map["ResponseMessage"]
        diningSettings          <- map["DiningSetting"]
        restaurants             <- map["Restaurants"]
    }
}



class DiningSettingData: NSObject, Mappable {
    
    var TimeInterval            : Int!
    var MaxDaysInAdvanceTime    : String!
    var MaxDaysInAdvance        : Int!
    var MinDaysInAdvance        : Int!
    var MinDaysInAdvanceTime    : String!
    var MaxPartySize            : Int!
    var DefaultPartySize : Int!
    var DefaultStartTime : String!
    var DefaultEndTime : String!
    var DefaultTimeInterval : Int!
    var DefaultTimeSlots : [DiningTimmingsData]!
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        TimeInterval            = 0
        MaxDaysInAdvanceTime    = ""
        MaxDaysInAdvance        = 0
        MinDaysInAdvance        = 0
        MinDaysInAdvanceTime    = ""
        MaxPartySize            = 0
        DefaultPartySize = 0
        DefaultStartTime = ""
        DefaultEndTime = ""
        DefaultTimeInterval = 0
        DefaultTimeSlots = []
    }
    
    func mapping(map: Map) {
        
        TimeInterval            <- map["TimeInterval"]
        MaxDaysInAdvanceTime    <- map["MaxDaysInAdvanceTime"]
        MaxDaysInAdvance        <- map["MaxDaysInAdvance"]
        MinDaysInAdvance        <- map["MinDaysInAdvance"]
        MinDaysInAdvanceTime    <- map["MinDaysInAdvanceTime"]
        MaxPartySize            <- map["MaxPartySize"]
        DefaultPartySize <- map["DefaultPartySize"]
        DefaultStartTime <- map["DefaultStartTime"]
        DefaultEndTime <- map["DefaultEndTime"]
        DefaultTimeInterval  <- map["DefaultTimeInterval"]
        DefaultTimeSlots <- map["DefaultTimeSlots"]
    }
}

class DiningRestaurantsData: NSObject, Mappable {
    
    var RestaurantName      : String!
    var RestaurantID        : String!
    var DinningPolicy       : String!
    var IsAllowGuest        : Int!
    var RestaurantImage     : String!
    var TablePreference     : [DiningTablePrefenceData]!
    var TimeSlots           : [DiningTimeSlots]!
    var Timings             : [DiningTimmingsData]!
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        RestaurantName      = ""
        RestaurantID        = ""
        DinningPolicy       = ""
        IsAllowGuest        = 0
        RestaurantImage     = ""
        TablePreference     = []
        TimeSlots           = []
        Timings             = []
    }
    
    func mapping(map: Map) {
        
        RestaurantName      <- map["RestaurantName"]
        RestaurantID        <- map["RestaurantID"]
        DinningPolicy       <- map["DinningPolicy"]
        IsAllowGuest        <- map["IsAllowGuest"]
        RestaurantImage     <- map["RestaurantImage"]
        TablePreference     <- map["TablePreference"]
        TimeSlots           <- map["TimeSlots"]
        Timings             <- map["Timings"]
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

class DiningTimeSlots: NSObject, Mappable {
    
    var timeSlot    : String!

   
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        timeSlot         = ""
    }
    
    func mapping(map: Map) {
        
        timeSlot         <- map["TimeSlot"]
   
    }
}

class GetTablePreferance: NSObject, Mappable {
    
    var responseCode         : String!
    var responseMessage       : String!
    var tablePreferanceDetails  : [DiningTablePrefenceData]!
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        responseCode         = ""
        responseMessage       = ""
        tablePreferanceDetails = []
    }
    
    func mapping(map: Map) {
        
        responseCode         <- map["ResponseCode"]
        responseMessage       <- map["ResponseMessage"]
        tablePreferanceDetails       <- map["TablePreferanceDetails"]
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
