//
//  TodayGlanceDetails.swift
//  CSSI
//
//  Created by MACMINI13 on 19/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation



class TodayGlanceDetails: NSObject , Mappable {
    var title : String?
    var status : String?
    var statusreason : String?
    var sequence : String?
    var statuscolor : String?
    var comment : String?
    var id : String?

    var short_desc : String?
    var duration : String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["ID"]

        title <- map["Title"]
        status <- map["Status"]
        statusreason <- map["StatusReason"]
        short_desc <- map["Description"]
        duration <- map["Description"]
        statuscolor <- map["StatusColor"]
    }
    
}
