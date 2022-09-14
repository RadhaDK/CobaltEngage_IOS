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
    var BillingFrequncyHistory : [MembershipHistoryData]?
    var BillingStatusList : [statusListing]?
    var MembershipStatusList : [statusListing]?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        MembershipTypeHistory <- map["MembershipTypeHistory"]
        BillingFrequncyHistory <- map["BillingFrequncyHistory"]
        BillingStatusList <- map["BillingStatusList"]
        MembershipStatusList <- map["MembershipStatusList"]
    }
}

class MembershipHistoryData: NSObject, Mappable  {
    
    var NewMembershipType: String?
    var OldMembershipType: String?
    var RequestedOn: String?
    var Status: String?
    var Comment : String?
    var NewBilingFrequency : String?
    var OldBilingFrequency : String?
    
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
        NewBilingFrequency <- map["NewBilingFrequency"]
        OldBilingFrequency <- map["OldBilingFrequency"]
    }
}

class statusListing: NSObject, Mappable  {
    
    var Text: String?
    var Value: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
      //  notificatonID <- map["NotificatonID"]
        Text <- map["Text"]  //changes on 27/07/2018
        Value <- map["Value"]
        
    }
}
