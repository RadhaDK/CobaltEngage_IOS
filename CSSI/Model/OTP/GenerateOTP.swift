//
//  GenerateOTP.swift
//  CSSI
//
//  Created by Kiran on 08/07/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

//Added by kiran V1.3 -- PROD0000019 -- Added 2 step verification
//PROD0000019 -- Start
class GenerateOTP : NSObject,Mappable
{
    var responseMessage : String?
    var parentID: String?
    var ID : String?
    var sendLinkInEmail : Int?
    var loginText : String?
    var memberID : String?
    var account_Verification : String?
    var codeSent_Email : String?
    var verify : String?
    var resend_OTP : String?
    var OTPExpire_INFO : String?
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
        self.sendLinkInEmail <- map["SendLinkInEmail"]
        self.loginText <- map["LoginText"]
        self.memberID <- map["MemberID"]
        self.account_Verification <- map["ACCOUNT_VERIFICATION"]
        self.codeSent_Email <- map["CODESENT_EMAIL"]
        self.verify <- map["VERIFY"]
        self.resend_OTP <- map["RESEND_OTP"]
        self.OTPExpire_INFO <- map["OTPEXPIRE_INFO"]
        self.responseCode <- map["ResponseCode"]
    }
    
}
//PROD0000019 -- End
