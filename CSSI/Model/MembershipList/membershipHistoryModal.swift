//
//  membershipHistoryModal.swift
//  CSSI
//
//  Created by Vishal Pandey on 09/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class MembershipHistoryList: NSObject, Mappable {
    var responseCode: String?
    var responseMessage: String?
    var MembershipTypeHistory: [MembershipHistoryData]?
    
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        MembershipTypeHistory <- map["MembershipTypeHistory"]
    }
}

class MembershipHistoryData: NSObject, Mappable  {
    
    var NewMembershipType: String?
    var OldMembershipType: String?
    var RequestedOn: String?
    var Status: String?
    var Comment : String?
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
      //  notificatonID <- map["NotificatonID"]
        NewMembershipType <- map["NewMembershipType"]  //changes on 27/07/2018
        OldMembershipType <- map["OldMembershipType"]
        RequestedOn <- map["RequestedOn"]
        Status <- map["Status"]
        Comment <- map["Comment"]

    }
}
