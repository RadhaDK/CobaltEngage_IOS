//
//  AuthenticateUser.swift
//  CSSI
//
//  Created by MACMINI13 on 14/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//




import Foundation
import ObjectMapper

class AuthenticateUser: NSObject, Mappable {
    
    var memberID: String?
    var responseCode: String?
    var responseMessage: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        memberID <- map["memberID"]
        responseCode <- map["responseCode"]
        responseMessage <- map["responseMessage"]
    }
    
}
