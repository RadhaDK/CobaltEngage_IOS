//
//  TokenDetails.swift
//  CSSI
//
//  Created by MACMINI13 on 16/08/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import Foundation
import ObjectMapper

class TokenDetails: NSObject, Mappable {
    
    var access_token : String?
    var expires_in : Int?
    var token_type : String?
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        access_token <- map["access_token"]
        expires_in <- map["expires_in"]
        token_type <- map["token_type"]
        
    }
    
}



