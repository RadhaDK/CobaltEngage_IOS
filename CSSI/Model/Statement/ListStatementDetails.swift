//
//  listStatementDetails.swift
//  CSSI
//
//  Created by MACMINI13 on 22/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation

class ListStatementDetails: NSObject,Mappable {
    var name: String?
    var sku: String?
    var quntity: String?
    var price: String?
    var designator: String?
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["Name"]
        sku <- map["SkuCode"]
        quntity <- map["Qty"]
        price <- map["Price"]
        designator <- map["Designator"]
        
        
    }
    
}
