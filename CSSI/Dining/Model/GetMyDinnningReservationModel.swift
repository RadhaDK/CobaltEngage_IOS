//
//  GetMyDinnningReservationModel.swift
//  CSSI
//
//  Created by Aks on 02/11/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import ObjectMapper

class GetMyDinningList: NSObject, Mappable {
    var ResponseCode            : String!
    var responseMessage         : String!
    var DiningReservations             : [MyDiningData]!
 
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        ResponseCode            = ""
        responseMessage         = ""
        DiningReservations             = []
      
    }
    
    func mapping(map: Map) {
        ResponseCode            <- map["ResponseCode"]
        responseMessage         <- map["ResponseMessage"]
        DiningReservations          <- map["DiningReservations"]
      
    }
}



class MyDiningData: NSObject, Mappable {
    
    var RequestID            : String!
    var ReservationType    : String!
    var RestaurantName        : String!
    var ConfirmationNumber        : Int!
    var ReservationStatus    : String!
    var SelectedTime            : String!
    var SelectedDate : String!
    var PartySize : Int!
    var EventName : String!
    var UI : [MyDinningUI]!
    var ColorCode : String!
 
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        RequestID            = ""
        ReservationType    = ""
        RestaurantName        = ""
        ConfirmationNumber        = 0
        ReservationStatus    = ""
        SelectedTime            = ""
        SelectedDate = ""
        PartySize = 0
        UI = []
        EventName = ""
        ColorCode = ""
       
    }
    
    func mapping(map: Map) {
        
        RequestID            <- map["RequestID"]
        ReservationType    <- map["ReservationType"]
        RestaurantName        <- map["RestaurantName"]
        ConfirmationNumber        <- map["ConfirmationNumber"]
        ReservationStatus    <- map["ReservationStatus"]
        SelectedTime            <- map["SelectedTime"]
        SelectedDate <- map["SelectedDate"]
        PartySize <- map["PartySize"]
        UI <- map["UI"]
        EventName <- map["EventName"]
        ColorCode <- map["ColorCode"]
    }
}

class MyDinningUI: NSObject, Mappable {
    
    var Cancel      : Int!
    var Modify        : Int!
    var View       : Int!
   
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        Cancel      = 0
        Modify        = 0
        View       = 0
       
    }
    
    func mapping(map: Map) {
        
        Cancel      <- map["Cancel"]
        Modify        <- map["Modify"]
        View       <- map["View"]
      
    }
}


