//
//  GuestCard.swift
//  CSSI
//
//  Created by MACMINI13 on 17/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class GuestCardModify: NSObject, Mappable {
    var guestsdetails: GuestDetailsModify?
    var responseCode: String?
    var responseMessage: String?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        guestsdetails <- map["GuestCardDetails"]
        
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
}


class GuestDetailsModify: NSObject, Mappable  {
    var guests: [GuestCardModifyList]?
    
    var subTotal: Double?
    var tax: Double?
    var total: Double?
    var confirmMessage: String?
    var responseCode: String?
    var responseMessage: String?
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        guests <- map["Guests"]
        subTotal <- map["SubTotal"]
        tax <- map["Tax"]
        total <- map["Total"]
        confirmMessage <- map["ConfirmMessage"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        
        
        
        
        
    }
    
}
class GuestCardModifyList: NSObject, Mappable  {
    var guestID: String?
    var firstName: String?
    var lastName: String?
    var chargeType: String?
    var price: Double?
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        guestID <- map["GuestID"]
        firstName <- map["FirstName"]
        lastName <- map["LastName"]
        chargeType <- map["ChargeType"]
        price <- map["Price"]
        
        
        
        
        
    }
    
}

