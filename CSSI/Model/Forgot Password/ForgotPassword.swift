//
//  ForgotPassword.swift
//  CSSI
//
//  Created by MACMINI13 on 11/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class ForgotPassword: NSObject, Mappable {
    var memberID: String?
    var ID: String?
    var parentID: String?
    var userName: String?
    var loginText: String?
    var sendLinkInEmail : Int?
    var responseCode: String?
    var responseMessage: String?
    //Added on 26th June 2020 V2.2
    var sendLinkInEmailText : String?
    //Added on 14th October 2020 V2.3
    var poweredByText : String?
    
    //Added by kiran V1.4 -- PROD0000118 -- Added login note in login screen
    //PROD0000118 -- Start
    var loginNote : String?
    //PROD0000118 -- End
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        memberID <- map["MemberID"]
        ID <- map["ID"]
        parentID <- map["ParentID"]
        userName <- map["UserName"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        loginText <- map["LoginText"]
        sendLinkInEmail <- map["SendLinkInEmail"]
        sendLinkInEmailText <- map["SendLinkInEmailText"]
        self.poweredByText <- map["PoweredByText"]
        //Added by kiran V1.4 -- PROD0000118 -- Added login note in login screen
        //PROD0000118 -- Start
        self.loginNote <- map["LoginNote"]
        //PROD0000118 -- End
    }
    
}
