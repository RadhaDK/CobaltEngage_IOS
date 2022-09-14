//
//  MembershipListModel.swift
//  CSSI
//
//  Created by Vishal Pandey on 08/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class MembershipList: NSObject, Mappable {
    var responseCode: String?
    var responseMessage: String?
    var MembershipType: [MembershipTypeData]?
    var BillingFrequncy : [MembershipTypeData]?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        MembershipType <- map["MembershipType"]
        BillingFrequncy <- map["BillingFrequncy"]
    }
}

class MembershipTypeData: NSObject, Mappable  {
    
    var Text: String?
    var Value: String?
    var Description: String?
    var ColorCode: String?
   
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
      //  notificatonID <- map["NotificatonID"]
        Text <- map["Text"]  //changes on 27/07/2018
        Value <- map["Value"]
        Description <- map["Description"]
        ColorCode <- map["ColorCode"]


    }
}

