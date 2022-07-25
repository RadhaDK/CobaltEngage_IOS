//
//  GolfCourseTimeSlots.swift
//  CSSI
//
//  Created by Admin on 5/18/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
import ObjectMapper

class GolfCourseTimeSlots: NSObject, Mappable {

    var courseDetails: [CourseSettingsDetail]?
    var responseCode: String?
    var responseMessage: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        
        
        courseDetails <- map["CourseDetails"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
}
