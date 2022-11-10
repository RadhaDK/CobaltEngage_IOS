//
//  GetRestaurantDetailmodel.swift
//  CSSI
//
//  Created by Aks on 14/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//
//
//import Foundation
//import UIKit
//import Foundation
//import ObjectMapper
//
//class GetRestaurantDetail: NSObject, Mappable {
//
//
//    var responseCode            : String!
//    var responseMessage         : String!
//    var MembershipType  : [MembershipTypeData]!
//    var BillingFrequncy              : [MembershipTypeData]!
//
//    override init() {
//        super.init()
//    }
//
//    convenience required init?(map: Map) {
//        self.init()
//        responseCode            = ""
//        responseMessage         = ""
//        MembershipType  = []
//        BillingFrequncy         = []
//    }
//
//    func mapping(map: Map) {
//
//
//        responseCode            <- map["ResponseCode"]
//        responseMessage         <- map["ResponseMessage"]
//        MembershipType  <- map["MembershipType"]
//        BillingFrequncy              <- map["BillingFrequncy"]
//    }
//}
//
//class GetRestaurantDetailData: NSObject, Mappable {
//
//    var Text         : String!
//    var Value       : String!
//    var Description              : String!
//    var ColorCode         : String!
//
//
//    override init() {
//        super.init()
//    }
//
//    convenience required init?(map: Map) {
//        self.init()
//        Text         = ""
//        Value       = ""
//        Description              = ""
//        ColorCode         = ""
//
//    }
//
//    func mapping(map: Map) {
//
//        Text         <- map["Text"]
//        Value       <- map["Value"]
//        Description              <- map["Description"]
//        ColorCode         <- map["ColorCode"]
//
//    }
//}


import Foundation
import UIKit
import Foundation
import ObjectMapper

class GetRestaurantDetail: NSObject, Mappable {
    
    
    var result            : String!
    var Restaurants : [GetRestaurantDetailData]!
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        result            = ""
        Restaurants = []
    }
    
    func mapping(map: Map) {
        result            <- map["result"]
        Restaurants <- map["Restaurants"]
    }
}

class GetRestaurantDetailData: NSObject, Mappable {
    
    var RestaurantID              : String!
    var RestaurantName  : String!
    var RestaurantImage = ""
    var TimeInterval : Int!
    var Timings : [DiningTimmingsData]!
    dynamic var SelectedDate : GetRestaurantSelectedDateDetail = GetRestaurantSelectedDateDetail.init()
    dynamic var OtherAvailableDates : [GetRestaurantSelectedDateDetail] = []
    var RestaurantSettings : DiningSettingData!
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        RestaurantID         = ""
        RestaurantName  = ""
        TimeInterval = 0
        Timings = []
        SelectedDate = GetRestaurantSelectedDateDetail()
        OtherAvailableDates = []
        RestaurantSettings = DiningSettingData()
        RestaurantImage = ""
    }
    
    func mapping(map: Map) {
        
        RestaurantID              <- map["RestaurantID"]
        RestaurantName  <- map["RestaurantName"]
        TimeInterval <- map["TimeInterval"]
        Timings <- map["Timings"]
        SelectedDate <- map["SelectedDate"]
        OtherAvailableDates <- map["OtherAvailableDates"]
        RestaurantSettings <- map["RestaurantSettings"]
        RestaurantImage <- map["RestaurantImage"]
    }
}


class GetRestaurantSelectedDateDetail: NSObject, Mappable {
    
    var Date         : String = ""
    var TimeSlot       : [DiningTimeSlots] = []
    var TablePreferences              : [DiningTablePrefenceData]!
 
    
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        Date         = ""
        TimeSlot      = []
        TablePreferences              = []
     
        
    }
    
    func mapping(map: Map) {
        
        Date         <- map["Date"]
        TimeSlot       <- map["TimeSlots"]
        TablePreferences              <- map["TablePreferences"]
        
    }
}

