//
//  EditDinningReservationModel.swift
//  CSSI
//
//  Created by Aks on 14/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import ObjectMapper

class EditDinningDetail: NSObject, Mappable {
    
    
    var ConfirmationNumber            : String!
    var EventName         : String!
    var PartySize  : Int!
    var RequestID              : String!
    var ReservationStatus : Int!
    var RestaurantName : String!
    var SelectedTime : String!
    var StatusColor : String!
    var UI : EditDinningDetailData!
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        ConfirmationNumber            = ""
        EventName         = ""
        PartySize  = 0
        RequestID         = ""
        ReservationStatus = 0
        RestaurantName = ""
        SelectedTime = ""
        StatusColor = ""
    }
    
    func mapping(map: Map) {
        
        
        ConfirmationNumber            <- map["ConfirmationNumber"]
        EventName         <- map["EventName"]
        PartySize  <- map["PartySize"]
        RequestID              <- map["RequestID"]
        ReservationStatus <- map["ReservationStatus"]
        RestaurantName <- map["RestaurantName"]
        SelectedTime <- map["SelectedTime"]
        StatusColor <- map["StatusColor"]
        UI <- map["UI"]
    }
}

class EditDinningDetailData: NSObject, Mappable {
    
    var View         : Int!
    var Modify       : Int!
    var Cancel              : Int!
 
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        View         = 0
        Modify       = 0
        Cancel              = 0
        
    }
    
    func mapping(map: Map) {
        
        View         <- map["View"]
        Modify       <- map["Modify"]
        Cancel              <- map["Cancel"]
     
        
    }
}
