//
//  TemplateHistoryDetail.swift
//  CSSI
//
//  Created by Admin on 8/29/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

class TemplateHistoryDetails: NSObject, Mappable {

    var responseCode: String!
    var responseMessage: String!
    
    var minimumTemplateHistoryDetails: [TemplateHistory]?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        responseCode = ""
        responseMessage = ""
        minimumTemplateHistoryDetails = []
    }
    
    func mapping(map: Map) {
        

        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        minimumTemplateHistoryDetails <- map["MinimumTemplateHistoryDetails"]
    }
}


class TemplateHistory: NSObject, Mappable {
    
    var amount: String!
    var date: String!
    var ID: String!
    var location: String!
    var receiptNumber: String!
    var category: String!
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        
        amount = ""
        date = ""
        ID = ""
        location = ""
        receiptNumber = ""
        category = ""
    }
    
    func mapping(map: Map) {
        
        amount <- map["Amount"]
        date <- map["Date"]
        ID <- map["ID"]
        location <- map["Location"]
        receiptNumber <- map["ReceiptNumber"]
        category <- map["Category"]
    }
}
