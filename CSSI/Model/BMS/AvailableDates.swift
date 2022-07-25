//
//  AvailableDates.swift
//  CSSI
//
//  Created by Kiran on 15/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class AvailableDates: NSObject, Mappable
{
    var unAvailableDates : [BDates]?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.unAvailableDates <- map["NotAvailableDateList"]
    }
    
}

class BDates: NSObject, Mappable
{
    
    var date : String?
    var isProviderOrService : UnavailableReason?
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.date <- map["Date"]
        self.isProviderOrService <- (map["IsProviderOrService"],EnumTransform<UnavailableReason>())
    }
    
}
