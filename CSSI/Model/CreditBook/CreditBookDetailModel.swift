//
//  CreditBookDetailModel.swift
//  CSSI
//
//  Created by Vishal Pandey on 09/12/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class CreditBookDetails: NSObject, Mappable {

    
    var responseCode            : String!
    var responseMessage         : String!
    var DeviceInfo  : [CreditBookDeviceInfo]!
    var CredtiBookTranHistoryDetails              : [CreditBookHistoryDetail]!
    var MemberID : String!
    var ID : String!
    var ParentID : String!
    var IsAdmin : String!
    var UserName : String!
    var Role : String!
    var UserId : String!
    var CreditBookName : String!
    var CreditBookID : String!
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        responseCode            = ""
        responseMessage         = ""
        DeviceInfo  = []
        CredtiBookTranHistoryDetails              = []
        MemberID = ""
        ID = ""
        ParentID = ""
        IsAdmin = ""
        UserName = ""
        Role = ""
        UserId = ""
        CreditBookName = ""
        CreditBookID = ""
    }
    
    func mapping(map: Map) {
        

        responseCode            <- map["ResponseCode"]
        responseMessage         <- map["ResponseMessage"]
        DeviceInfo  <- map["DeviceInfo"]
        CredtiBookTranHistoryDetails              <- map["CredtiBookTranHistoryDetails"]
        MemberID <- map["MemberID"]
        ID <- map["ID"]
        ParentID <- map["ParentID"]
        IsAdmin <- map["IsAdmin"]
        UserName <- map["UserName"]
        Role <- map["Role"]
        UserId <- map["UserId"]
        CreditBookName <- map["CreditBookName"]
        CreditBookID <- map["CreditBookID"]
    }
}

class CreditBookDeviceInfo: NSObject, Mappable {
    
    var DeviceType         : String!
    var OSVersion       : String!
    var OriginatingIP              : String!
    var SessionID         : String!
    var Browser             : String!
    var HostName       : String!
    var SourcePortNo   : String!
    
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        DeviceType         = ""
        OSVersion       = ""
        OriginatingIP              = ""
        SessionID         = ""
        Browser             = ""
        HostName       = ""
        SourcePortNo   = ""
        
    }
    
    func mapping(map: Map) {
        
        DeviceType         <- map["DeviceType"]
        OSVersion       <- map["OSVersion"]
        OriginatingIP              <- map["OriginatingIP"]
        SessionID         <- map["SessionID"]
        Browser             <- map["Browser"]
        HostName       <- map["HostName"]
        SourcePortNo   <- map["SourcePortNo"]
       
    }
}


class CreditBookHistoryDetail: NSObject, Mappable {
    
    var TansactionID         : String!
    var Amount       : Double!
    var Date              : String!
    var ReceiptNumber         : String!
    var Location             : String!
    var Category : String!
    var Description : String!
    var Designator : String!
    var CreditBookID : String!
    var LocationID : String!
    var LocationName : String!
    var TransactionDate : String!
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        TansactionID         = ""
        Amount       = 0
        Date              = ""
        ReceiptNumber         = ""
        Location             = ""
        Category = ""
        Description = ""
        Designator = ""
        CreditBookID = ""
        LocationID = ""
        LocationName = ""
        TransactionDate = ""
    }
    
    func mapping(map: Map) {
        
        TansactionID         <- map["TansactionID"]
        Amount       <- map["Amount"]
        Date              <- map["Date"]
        ReceiptNumber         <- map["ReceiptNumber"]
        Location             <- map["Location"]
        Category <- map["Category"]
        Description <- map["Description"]
        Designator <- map["Designator"]
        CreditBookID <- map["CreditBookID"]
        LocationID <- map["LocationID"]
        LocationName <- map["LocationName"]
        TransactionDate <- map["TransactionDate"]
    }
}
