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
    var showMinimumDesignator: Int?
    var minStatementLegend: String?
    var statementDesignator: String?
    var enableMinimumTemplate: Int?
    var IsCreditBookEnabled : Int?
    var CreditIndicate : String?
    var showCreditBookDesignator : Int?
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
        showMinimumDesignator <- map["ShowMinimumDesignatorInStatements"]
        minStatementLegend <- map["MinStatementLegend"]
        enableMinimumTemplate <- map["EnableMinimumTemplate"]
        statementDesignator <- map["StatementDesignator"]
        IsCreditBookEnabled <- map["IsCreditBookEnabled"]
        CreditIndicate <- map["CreditIndicate"]
        showCreditBookDesignator <- map["ShowCreditBookDesignator"]
    }

    
    
    
    
}
