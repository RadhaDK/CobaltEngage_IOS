//
//  SaveMemberInfo.swift
//  CSSI
//
//  Created by MACMINI13 on 11/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class SaveMemberInfo: NSObject, Mappable {
    
    var responseCode: String?
    var responseMessage: String?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
       
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }



    
}


