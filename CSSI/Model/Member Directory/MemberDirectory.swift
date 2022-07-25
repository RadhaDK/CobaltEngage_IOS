//
//  MemberDirectory.swift
//  CSSI
//
//  Created by MACMINI13 on 03/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper


class MemberDirectory: NSObject, Mappable {
    var memberList: [Member]?
    var addressList: [MemberAddress]?
    var memberInterest: [MemberInterest]?

    var responseCode: String?
    var responseMessage: String?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        memberList <- map["members"]
        addressList <- map["address"]

        responseCode <- map["responseCode"]
        responseMessage <- map["responseMessage"]
    }
}

class Member: NSObject, Mappable  {
    
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
class MemberAddress: NSObject, Mappable  {
  
    
    var adddressType: String?
    var street1: String?
    var street2: String?
    var city: String?
    var zip: String?
    var country: String?
    var state: String?
    var isVisible: String?
   
    
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
class MemberInterest: NSObject, Mappable  {
    
    var interstID: String?
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
