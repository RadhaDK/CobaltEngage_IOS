//
//  MonthList.swift
//  CSSI
//
//  Created by apple on 11/30/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation

class ListOfMonths: NSObject,Mappable {
    var monthName: String?
    var monthYear: String?
    var year: String?
    var statementTotal: Double?
    var statemnetDate: String?
    


    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        monthName <- map["Month"]
        monthYear <- map["MonthYear"]
        year <- map["Year"]
        statementTotal <- map["StatementTotal"]
        statemnetDate <- map["StatemnetDate"]
       
    }
    
}
