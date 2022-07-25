//
//  ProfileUpdate.swift
//  CSSI
//
//  Created by MACMINI13 on 02/08/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import ObjectMapper

class ProfileUpdate: NSObject {
    var id: String?
    var memberid: String?
    var filepath: String?
    var fromwhere: String?
    var image: String?
    
    var responseCode: String?
    var responseMessage: String?
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id <- map["ID"]
        memberid <- map["MemberID"]
        filepath <- map["FilePath"]
        fromwhere <- map["FromWhere"]
        image <- map["Image"]
        
        
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        
        
        
    }
}
