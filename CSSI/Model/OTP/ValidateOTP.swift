//
//  ValidateOTP.swift
//  CSSI
//
//  Created by Kiran on 08/07/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

//Added by kiran V1.3 -- PROD0000019 -- Added 2 step verification
//PROD0000019 -- Start
class ValidateOTP : NSObject,Mappable
{
    var responseMessage : String?
    var parentID: String?
    var ID : String?
    var userName : Int?
    var memberID : String?
    var responseCode : String?

    convenience required init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.responseMessage <- map["ResponseMessage"]
        self.parentID <- map["ParentID"]
        self.ID <- map["ID"]
        self.userName <- map["UserName"]
        self.memberID <- map["MemberID"]
        self.responseCode <- map["ResponseCode"]
    }
}
//PROD0000019 -- End
