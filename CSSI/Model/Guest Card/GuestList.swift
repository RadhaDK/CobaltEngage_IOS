//
//  GuestList.swift
//  CSSI
//
//  Created by MACMINI13 on 03/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class GuestList: NSObject, Mappable {
    var guestList: [Guest1]?
    var responseCode: String?
    var responseMessage: String?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        guestList <- map["Guests"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
}

class Guest1: NSObject, Mappable  {
    
    var guestID: String?
    var firstName: String?
    var lastName: String?
    var phone: String?
    var isSelected: Bool!
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        guestID <- map["GuestID"]
        firstName <- map["FirstName"]
        lastName <- map["LastName"]
        phone <- map["PrimaryPhone"]
        isSelected <- map["isSelected"]
    
    }
    
}


