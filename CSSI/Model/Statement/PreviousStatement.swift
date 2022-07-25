//
//  PreviousStatement.swift
//  CSSI
//
//  Created by MACMINI13 on 11/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class PreviousStatement: NSObject, Mappable {
    var statement: [Statements]?
    
    
    var responseCode: String?
    var responseMessage: String?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        statement <- map["Statements"]
        
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
}

class Statements: NSObject, Mappable  {
    
    var statement: String?
    var statemnetDate: String?
    var statementTotal: Float?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        statement <- map["Statement"]
        statemnetDate <- map["StatemnetDate"]
        statementTotal <- map["StatementTotal"]
      
        
        
    }
    
}

