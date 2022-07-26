//
//  MembershipListModel.swift
//  CSSI
//
//  Created by Vishal Pandey on 08/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//
//

import UIKit
import Foundation
import ObjectMapper

class MembershipList: NSObject, Mappable {
    
    
    var responseCode            : String!
    var responseMessage         : String!
    var MembershipType  : [MembershipTypeData]!
    var BillingFrequncy              : [MembershipTypeData]!
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        responseCode            = ""
        responseMessage         = ""
        MembershipType  = []
        BillingFrequncy         = []
    }
    
    func mapping(map: Map) {
        
        
        responseCode            <- map["ResponseCode"]
        responseMessage         <- map["ResponseMessage"]
        MembershipType  <- map["MembershipType"]
        BillingFrequncy              <- map["BillingFrequncy"]
    }
}

class MembershipTypeData: NSObject, Mappable {
    
    var Text         : String!
    var Value       : String!
    var Description              : String!
    var ColorCode         : String!
    
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        Text         = ""
        Value       = ""
        Description              = ""
        ColorCode         = ""
        
    }
    
    func mapping(map: Map) {
        
        Text         <- map["Text"]
        Value       <- map["Value"]
        Description              <- map["Description"]
        ColorCode         <- map["ColorCode"]
        
    }
}
