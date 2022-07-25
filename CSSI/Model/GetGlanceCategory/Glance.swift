//
//  TodayAtGlance.swift
//  CSSI
//
//  Created by apple on 11/6/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper
import UIKit


class Glance: NSObject, Mappable {
    
    var todayGlance: [TodayAtGlance]?
    var responseCode: String?
    var responseMessage: String?
    
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        todayGlance <- map["TodayAtGlance"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        
    }
    
}
