//
//  GlanceDetails.swift
//  CSSI
//
//  Created by MACMINI13 on 11/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class GlanceDetails: NSObject, Mappable {
    var importantNo: [ImportantNumbers]?
    
    
    var responseCode: String?
    var responseMessage: String?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        importantNo <- map["importantNumbers"]
        
        responseCode <- map["responseCode"]
        responseMessage <- map["responseMessage"]
    }
}

class ImportantNumbers: NSObject, Mappable  {
    
    var deptID: Int?
    var departmentName: String?
    var phoneNumber: String?
    var importantNumberIcon: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        deptID <- map["deptID"]
        departmentName <- map["departmentName"]
        phoneNumber <- map["phoneNumber"]
        importantNumberIcon <- map["importantNumberIcon"]
        
        
    }
    
}



