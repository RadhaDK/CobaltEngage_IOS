//
//  MinimumDetails.swift
//  CSSI
//
//  Created by Admin on 8/26/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

class MinimumDetails: NSObject, Mappable {

    
    var responseCode            : String!
    var responseMessage         : String!
    var minimumTemplateHistory  : [MinimumTemplate]!
    var PDFPathWeb              : String!
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        responseCode            = ""
        responseMessage         = ""
        minimumTemplateHistory  = []
        PDFPathWeb              = ""
    }
    
    func mapping(map: Map) {
        

        responseCode            <- map["ResponseCode"]
        responseMessage         <- map["ResponseMessage"]
        minimumTemplateHistory  <- map["MinimumTemplateHistory"]
        PDFPathWeb              <- map["PDFPathWeb"]
    }
}

class MinimumTemplate: NSObject, Mappable {
    
    var amountSpent         : String!
    var balanceAmount       : String!
    var credit              : String!
    var displayText         : String!
    var endDate             : String!
    var minimumAmount       : String!
    var minimumTemplateID   : String!
    var parameter           : String!
    var templateName        : String!
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        amountSpent         = ""
        balanceAmount       = ""
        credit              = ""
        displayText         = ""
        endDate             = ""
        minimumAmount       = ""
        minimumTemplateID   = ""
        parameter           = ""
        templateName        = ""
    }
    
    func mapping(map: Map) {
        
        amountSpent         <- map["AmountSpent"]
        balanceAmount       <- map["BalanceAmount"]
        credit              <- map["Credit"]
        displayText         <- map["DisplayText"]
        endDate             <- map["EndDate"]
        minimumAmount       <- map["MinimumAmount"]
        minimumTemplateID   <- map["MinimumTemplateID"]
        parameter           <- map["Parameters"]
        templateName        <- map["TemplateName"]
    }
}
