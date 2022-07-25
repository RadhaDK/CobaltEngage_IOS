//
//  ListCurrentStatement.swift
//  CSSI
//
//  Created by MACMINI13 on 22/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation

class ListCurrentStatement: NSObject,Mappable {
    var receiptNo: String?
    var chargeCode: String?
    var category: String?
    var descriptions: String?
    var purchaseDate: String?
    var purchaseTime: String?
    var amount: String?
    var id: String?


    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        receiptNo <- map["ReceiptNo"]
       // chargeCode <- map["chargeCode"]
        category <- map["Category"]
        descriptions <- map["Description"]
        purchaseDate <- map["PurchaseDate"]
        purchaseTime <- map["PurchaseTime"]
        amount <- map["Amount"]
        id <- map["ID"]
        
    }
    
}
