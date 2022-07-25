//
//  MyInterest.swift
//  CSSI
//
//  Created by apple on 2/20/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class MyInterest: NSObject, Mappable {
    var interest: [MyTotalInterest]?
    var responseCode: String?
    var responseMessage: String?
    convenience required init?(map: Map) {
        self.init()
}
    func mapping(map: Map) {
        interest <- map["Interest"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]

    }
    
}
class MyTotalInterest: NSObject, Mappable  {
    
    var interestID: Int?
    var interest: String?
    
    
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        interestID <- map["InterestID"]
        interest <- map["Interest"]
        
        
        
        
    }
    
}
