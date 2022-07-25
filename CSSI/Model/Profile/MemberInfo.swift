//
//  MemberInfo.swift
//  CSSI
//
//  Created by MACMINI13 on 05/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class ParentMemberInfo: NSObject, Mappable {
    var memberID: String?
    var memberName: String?
    var prefix: String?
    var profilePic: String?
    var responseCode: String?
    var responseMessage: String?
    var brokenrules: String?
    var message: String?
    var fields: [Fields]?
    var parentId: String?
    var id: String?
    var culturecode: String?
    var status: String?
    var firstName: String?
    var lastName: String?
    var isAdminvalue: String?
    var userName: String?
    var displayName: String?
    var role: String?
    var fullName: String?
    var memberNameDisplay: String?
    var isFirstTime: String?
    var masterMemberID: String?
    var memberUserName: String?
    var isSpouse: Int?
    
    //Added by kiran V1.3 -- PROD0000019 -- Added 2 step verification
    //PROD0000019 -- Start
    var authenticationEnable : Int?
    var enter_WorkEmail : String?
    var enter_Email : String?
    var email_Note : String?
    var proceed : String?
    var Welcome : String?
    //PROD0000019 -- End
    
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        isSpouse <- map["IsSpouse"]
        memberUserName <- map["MemberUserName"]
        isFirstTime <- map["IsFirstTime"]
        memberNameDisplay <- map["MemberNameDisplay"]
        fullName <- map["FullName"]
        memberID <- map["MemberID"]
        memberName <- map["MemberName"]
        prefix <- map["Prefix"]
        profilePic <- map["ProfilePic"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        masterMemberID <- map["ID"]
        brokenrules <- map["BrokenRules"]
        message <- map["Message"]
        fields <- map["Fields"]
        parentId <- map["ParentID"]
        culturecode <- map["CultureCode"]
        status <- map["Status"]
        id <- map["ID"]
        firstName <- map["FirstName"]
        lastName <- map["LastName"]
        isAdminvalue <- map["IsAdmin"]
        role <- map["Role"]
        userName <- map["UserName"]
        displayName <- map["DisplayName"]
        
        //Added by kiran V1.3 -- PROD0000019 -- Added 2 step verification
        //PROD0000019 -- Start
        self.authenticationEnable <- map["AuthenticationEnable"]
        self.enter_WorkEmail <- map["ENTER_WORKEMAIL"]
        self.enter_Email <- map["ENTER_EMAIL"]
        self.email_Note <- map["EMAIL_NOTE"]
        self.proceed <- map["PROCEED"]
        self.Welcome <- map["WELCOME"]
        //PROD0000019 -- End

    }
    
}
class Fields: NSObject, Mappable  {
    
   // var memberID: Int?
    var password: String?
   
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
       // memberID <- map["Member ID"]
        password <- map["Password"]
      
        
    }
    
}



