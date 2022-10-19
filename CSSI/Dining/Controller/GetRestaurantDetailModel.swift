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
    
    
    var responseCode            : String!
    var responseMessage         : String!
    var RestaurantName  : String!
    var RestaurantID              : String!
    var RestaurantImage : String!
    var IsAllowGuest : Int!
    var Timings : [DiningTimmingsData]!
    var RestaurantSettings : DiningSettingData!
    var SelectedDate : GetRestaurantSelectedDateDetail!
    var OtherAvailableDates : [GetRestaurantSelectedDateDetail]!
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        responseCode            = ""
        responseMessage         = ""
        RestaurantName  = ""
        RestaurantID         = ""
        RestaurantImage = ""
        IsAllowGuest = 0
        Timings = []
        RestaurantSettings = nil
        SelectedDate = nil
        OtherAvailableDates = []
    }
    
    func mapping(map: Map) {
        
        
        responseCode            <- map["ResponseCode"]
        responseMessage         <- map["ResponseMessage"]
        RestaurantName  <- map["RestaurantName"]
        RestaurantID              <- map["RestaurantID"]
        RestaurantImage <- map["RestaurantImage"]
        IsAllowGuest <- map["IsAllowGuest"]
        Timings <- map["Timings"]
        RestaurantSettings <- map["RestaurantSettings"]
        SelectedDate <- map["SelectedDate"]
        OtherAvailableDates <- map["OtherAvailableDates"]
    }
}

class GetRestaurantDetailData: NSObject, Mappable {
    
    var Text         : String!
    var Value       : String!
    var Description              : String!
    var ColorCode         : String!
    
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        Text         = ""
        Value       = ""
        Description              = ""
        ColorCode         = ""
        
    }
    
    func mapping(map: Map) {
        
        Text         <- map["Text"]
        Value       <- map["Value"]
        Description              <- map["Description"]
        ColorCode         <- map["ColorCode"]
        
    }
}


class GetRestaurantSelectedDateDetail: NSObject, Mappable {
    
    var Date         : String!
    var TimeSlots       : [String]!
    var TablePreferences              : [DiningTablePrefenceData]!
 
    
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        Date         = ""
        TimeSlots       = []
        TablePreferences              = []
     
        
    }
    
    func mapping(map: Map) {
        
        Date         <- map["Date"]
        TimeSlots       <- map["TimeSlots"]
        TablePreferences              <- map["TablePreferences"]
        
    }
}
