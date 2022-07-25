//
//  CurrentStatement.swift
//  CSSI
//
//  Created by MACMINI13 on 22/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

class CurrentStatement: NSObject, Mappable {
    var monthTotal: String?

    
    var responseCode: String?
    var responseMessage: String?
    
    var liststatement: [ListCurrentStatement]?
    var months : [ListOfMonths]?

    
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        liststatement <- map["Statements"]
        
        monthTotal <- map["MonthTotal"]
        
        months <- map["MonthList"]

        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
    
    
    
    
    
}
