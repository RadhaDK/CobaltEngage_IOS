//
//  saveMembershipModel.swift
//  CSSI
//
//  Created by Vishal Pandey on 08/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class SaveMembership: NSObject, Mappable {
    var responseCode: String?
    var responseMessage: String?
    var IsMTAutoApproved: Int?
    var IsBFAutoApproved: Int?
    
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        IsMTAutoApproved <- map["IsMTAutoApproved"]
        IsBFAutoApproved <- map["IsBFAutoApproved"]
    }
}


    
   
