//
//  AddGuest.swift
//  CSSI
//
//  Created by MACMINI13 on 06/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class AddGuest: NSObject, Mappable {
    var guestList: [AddGuestList]?
    
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

class AddGuestList: NSObject, Mappable  {
    
    var guestID: Int?
    var firstName: String?
    var lastName: String?
    var phone: String?

    
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        guestID <- map["GuestID"]
        firstName <- map["FirstName"]
        lastName <- map["LastName"]
        phone <- map["PrimaryPhone"]

        
    }
    
}




