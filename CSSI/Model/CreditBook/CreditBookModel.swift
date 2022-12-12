//
//  CreditBookModel.swift
//  CSSI
//
//  Created by Vishal Pandey on 09/12/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class CreditBookListing: NSObject, Mappable {

    
    var responseCode            : String!
    var responseMessage         : String!
    var CreditBookList  : [CreditBookTemplate]!
    var MemberDetail              : CreditBookMemberDetail!
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        responseCode            = ""
        responseMessage         = ""
        CreditBookList  = []
        MemberDetail              = nil
    }
    
    func mapping(map: Map) {
        

        responseCode            <- map["ResponseCode"]
        responseMessage         <- map["ResponseMessage"]
        CreditBookList  <- map["CreditBookList"]
        MemberDetail              <- map["MemberDetail"]
    }
}

class CreditBookTemplate: NSObject, Mappable {
    
    var CreditBookID         : String!
    var CreditBookName       : String!
    var ItemType              : String!
    var Location         : String!
    var CreditAmount             : Int!
    var SpentAmount       : Int!
    var Balance   : Int!
    var StartDate           : String!
    var EndDate        : String!
    var Status : String!
    var CreditIndicate : String!
   
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        CreditBookID         = ""
        CreditBookName       = ""
        ItemType              = ""
        Location         = ""
        CreditAmount             = 0
        SpentAmount       = 0
        Balance   = 0
        StartDate           = ""
        EndDate        = ""
        Status = ""
        CreditIndicate = ""
        
    }
    
    func mapping(map: Map) {
        
        CreditBookID         <- map["CreditBookID"]
        CreditBookName       <- map["CreditBookName"]
        ItemType              <- map["ItemType"]
        Location         <- map["Location"]
        CreditAmount             <- map["CreditAmount"]
        SpentAmount       <- map["SpentAmount"]
        Balance   <- map["Balance"]
        StartDate           <- map["StartDate"]
        EndDate        <- map["EndDate"]
        Status <- map["Status"]
        CreditIndicate <- map["CreditIndicate"]
        SpentAmount <- map["SpentAmount"]
    }
}


class CreditBookMemberDetail: NSObject, Mappable {
    
    var MemberID         : String!
    var FirstName       : String!
    var LastName              : String!
    var Email         : String!
    var Address             : String!
   
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        MemberID         = ""
        FirstName       = ""
        LastName              = ""
        Email         = ""
        Address             = ""
        
    }
    
    func mapping(map: Map) {
        
        MemberID         <- map["MemberID"]
        FirstName       <- map["FirstName"]
        LastName              <- map["LastName"]
        Email         <- map["Email"]
        Address             <- map["Address"]
    
    }
}
