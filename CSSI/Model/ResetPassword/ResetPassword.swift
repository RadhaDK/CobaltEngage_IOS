//
//  ResetPassword.swift
//  CSSI
//
//  Created by MACMINI13 on 02/08/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import ObjectMapper

class ResetPassword: NSObject, Mappable {
    var id: String?
    var parentid: String?
    var memberid: String?
    var username: String?
    var responseCode: String?
    var responseMessage: String?
    var broken: [BrokenR]?

    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id <- map["ID"]
        parentid <- map["ParentID"]
        memberid <- map["MemberID"]
        username <- map["UserName"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        broken <- map["BrokenRules"]

        
        
        
    }
    
    
}

class BrokenR: NSObject, Mappable  {
    
    var message : String?
    var fields : [String]?
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        message <- map["Message"]
        fields <- map["Fields"]
        
        
        
    }
    
}



//import Foundation
//struct RegisterYourDeviceResponse: Codable {
//    let registerDeviceInfo: [RegisterDeviceInfo]
//    let responseCode, responseMessage: String
//    
//    enum CodingKeys: String, CodingKey {
//        case registerDeviceInfo = "RegisterDeviceInfo"
//        case responseCode = "ResponseCode"
//        case responseMessage = "ResponseMessage"
//    }
//}
//
//struct RegisterDeviceInfo: Codable {
//    let linkedMemberID, uniqueDeviceID, status, statusMessage: String
//    
//    enum CodingKeys: String, CodingKey {
//        case linkedMemberID = "LinkedMemberID"
//        case uniqueDeviceID = "UniqueDeviceID"
//        case status = "Status"
//        case statusMessage = "StatusMessage"
//}
