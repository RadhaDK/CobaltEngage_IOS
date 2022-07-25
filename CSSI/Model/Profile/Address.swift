//
//  Address.swift
//  CSSI
//
//  Created by MACMINI13 on 20/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation

class Address: NSObject, Mappable {
    var adddresstype : String?
    var street1 : String?
    var street2 : String?
    var city : String?
    var zip : String?
    var country : String?
    var isvisible : String?
    var isMailing : String?
    var isPrimary : String?
    var state : String?
    var addressid : String?
    var addresstypeid : String?
    var showOutsideUS : Int?
    var stateCode: String?
    var fullBWAddress: String?

    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        fullBWAddress <- map["BocawestFullAddress"]
        adddresstype <- map["AddressType"]
        street1 <- map["AddressLine1"]
        street2 <- map["AddressLine2"]
        city <- map["City"]
        state <- map["State"]

        zip <- map["ZipCode"]
        country <- map["Country"]
        isvisible <- map["Isvisible"]
        isMailing <- map["IsMailing"]
        isPrimary <- map["IsPrimary"]
        addressid <- map["AddressID"]
        addresstypeid <- map["AddressTypeID"]
        showOutsideUS <- map["IsOutsideUnitedState"]
        stateCode <- map["StateCode"]
    }
    
    
}
