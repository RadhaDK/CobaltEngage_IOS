//
//  IndividualMemberDirectoryDetails.swift
//  CSSI
//
//  Created by MACMINI13 on 04/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class IndividualMemberDirectoryDetails: NSObject, Mappable {
    var memberAddress: [IndividualMemberAddress]?
    var memberInterest: [IndividualMemberInterest]?

    var responseCode: String?
    var responseMessage: String?
    var memberID: String?
    var firstName: String?
    var lastName: String?
    var profilePic: String?

    var village: String?
    var isBuddy: String?
    var primaryPhone: String?
    var secondaryPhone: String?
    var primaryEmail: String?


    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        memberAddress <- map["address"]
        memberInterest <- map["interests"]
        responseCode <- map["responseCode"]
        responseMessage <- map["responseMessage"]
           memberID <- map["memberID"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        profilePic <- map["profilePic"]
        village <- map["village"]
        isBuddy <- map["isBuddy"]
        primaryPhone <- map["primaryPhone"]
        secondaryPhone <- map["secondaryPhone"]
        primaryEmail <- map["primaryEmail"]

    }
}

class IndividualMemberAddress: NSObject, Mappable  {
    
    var adddressType: String?
    var street1: String?
    var street2: String?
    var city: Int?
    var zip: String?
    var country: String?
    var state: Int?
    var isVisible: Int?
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        adddressType <- map["adddressType"]
        street1 <- map["street1"]
        street2 <- map["street2"]
        city <- map["city"]
        zip <- map["zip"]
        country <- map["country"]
        state <- map["state"]
        isVisible <- map["isVisible"]
        
        
    }
    
}
class IndividualMemberInterest: NSObject, Mappable  {
    
    var interstID: Int?
    var isSlected: String?
    var interest: String?
 
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        interstID <- map["interstID"]
        isSlected <- map["isSlected"]
        interest <- map["interest"]
     
        
        
    }
    
}


