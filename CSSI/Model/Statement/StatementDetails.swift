//
//  StatementDetails.swift
//  CSSI
//
//  Created by MACMINI13 on 22/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

class StatementDetails: NSObject, Mappable {
    var monthTotal: String?
    
    
    var registerNo: String?
    var receiptNo: String?
    var purchaseDate: String?
    var purchaseTime: String?
    var chargeCode: String?
    var employeeName: String?
    var memberName: String?
    var memberId: String?
    var category: String?
    var clubName: String?
    var shopName: String?
    var SavedAmount: String?
    var Tax: String?
    var subTotal: String?
    var Tip: String?
    var total: String?


    
    var responseCode: String?
    var responseMessage: String?
    
    var listitem: [ListStatementDetails]?
    
    
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        listitem <- map["Items"]
        
        registerNo <- map["RegisterNo"]
        receiptNo <- map["ReceiptNo"]
        purchaseDate <- map["PurchaseDate"]
        purchaseTime <- map["PurchaseTime"]
        chargeCode <- map["chargeCode"]
        employeeName <- map["EmployeeName"]
        memberName <- map["MemberName"]
        memberId <- map["MemberID"]
        category <- map["CategoryName"]
        clubName <- map["ClubName"]
        shopName <- map["ShopName"]
        
        
        SavedAmount <- map["SavedAmount"]
        Tax <- map["Tax"]
        subTotal <- map["SubTotal"]
        Tip <- map["Tip"]
        total <- map["Total"]


    
        
        
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
    
    
    
    
    
}
