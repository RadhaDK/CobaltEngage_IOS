//
//  AllGuestCardRequest.swift
//  CSSI
//
//  Created by MACMINI13 on 05/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class AllGuestCardRequest: NSObject, Mappable {
    var allguestcardList: [AllGuestCardRequestInfo]?
    
    
    var responseCode: String?
    var responseMessage: String?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        allguestcardList <- map["AllGuestCardRequests"]
  
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
}

class AllGuestCardRequestInfo: NSObject, Mappable  {
    
    var requestID: Int?
    var firstName: String?
    var lastName: String?
    var requestedDate: String?
    var fromDate: String?
    var toDate: String?
    var status: String?

    
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        requestID <- map["RequestID"]
        firstName <- map["FirstName"]
        lastName <- map["LastName"]
        requestedDate <- map["RequestedDate"]
        fromDate <- map["FromDate"]
        toDate <- map["ToDate"]
        status <- map["Status"]

        
    }
    
}

