//
//  BrokenRules.swift
//  CSSI
//
//  Created by MACMINI13 on 26/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class BrokenRulesModel: NSObject, Mappable {
    
    var brokenRules : BrokenRules?
    var responseCode : String?
    var responseMessage : String?
 
    

    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        brokenRules <- map["BrokenRules"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]

    }
    
}

class BrokenRules: NSObject, Mappable  {
    
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





