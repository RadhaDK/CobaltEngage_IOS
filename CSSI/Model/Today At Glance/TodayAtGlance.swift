//
//  TodayAtGlance.swift
//  CSSI
//
//  Created by MACMINI13 on 19/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation

class TodayAtGlance: NSObject, Mappable {
   // var main_title : String?
   //// var details : [TodayGlanceDetails]?
    var id : String?
    var department : String?
    var location : String?
    var comment : String?
    var status : String?
    var statusColor : String?
    var type : String?
    var sequence : String?
    var glanceImage : String?
    var responseCode: String?
    var responseMessage: String?
    var time: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
       // main_title <- map["Category"]
        id <- map["ID"]

        department <- map["Department"]
        location <- map["Location"]
        comment <-  map["Comment"]
        status <- map["Status"]
        statusColor <- map["StatusColor"]
        type <- map["Type"]
        sequence <- map["Sequence"]
        glanceImage <- map["GlanceImage"]
        responseCode <- map["ResponseCode"]
        time <- map["Time"]
        
        responseMessage <- map["ResponseMessage"]
    }
    

}
