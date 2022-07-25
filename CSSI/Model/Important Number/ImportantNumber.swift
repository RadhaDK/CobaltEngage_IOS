//
//  ImportantNumber.swift
//  CSSI
//
//  Created by MACMINI13 on 05/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class ImportantNumber: NSObject, Mappable {
    var importantNo: [ImportantNumbers]?
    var clubnumber: [ClubNumbers]?

    
    var responseCode: String?
    var responseMessage: String?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        clubnumber <- map["ClubNumbers"]
        importantNo <- map["ImportantNumbers"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
}

class ImportantNumbers: NSObject, Mappable  {
    
    var deptID: Int?
    var departmentName: String?
    var phoneNumber: String?
    var importantNumberIcon1x: String?
    var importantNumberIcon2x: String?
    var importantNumberIcon3x: String?
    var email: String?

    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        deptID <- map["ID"]
        departmentName <- map["DepartmentName"]
        phoneNumber <- map["PhoneNumber"]
        importantNumberIcon1x <- map["Iconx"]
        importantNumberIcon2x <- map["Icon@2x"]
        importantNumberIcon3x <- map["Icon@3x"]
        email <- map["Email"]

        
    }
    
    
}
class ClubNumbers: NSObject, Mappable  {
    
    var deptID: Int?
    var departmentName: String?
    var phoneNumber: String?
    var importantNumberIcon1x: String?
    var importantNumberIcon2x: String?
    var importantNumberIcon3x: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        deptID <- map["ID"]
        departmentName <- map["DepartmentName"]
        phoneNumber <- map["PhoneNumber"]
        importantNumberIcon1x <- map["Icon"]
        importantNumberIcon2x <- map["Icon@2x"]
        importantNumberIcon3x <- map["Icon@3x"]
    }
}
