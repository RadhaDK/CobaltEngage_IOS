//
//  StatementCategories.swift
//  CSSI
//
//  Created by MACMINI13 on 20/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

class StatementCategories: NSObject, Mappable {
   

    var responseCode: String?
    var responseMessage: String?
    
    var listcategories: [ListStatementCategories]?
    var months : [ListOfMonths]?


    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        listcategories <- map["StatementCategory"]
        months <- map["MonthList"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }

    
    
    
    
}
