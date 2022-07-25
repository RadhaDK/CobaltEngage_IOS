//
//  WalletPassData.swift
//  CSSI
//
//  Created by Kiran on 13/05/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

//Added by kiran V2.9 -- ENGAGE0011722 -- Apple wallet functionality
//ENGAGE0011722 -- Start
class WalletPassData : NSObject,Mappable
{
    var responseMessage : String?
    var passData : String?
    var responseCode : String?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.responseMessage <- map["ResponseMessage"]
        self.passData <- map["WalletPass"]
        self.responseCode <- map["ResponseCode"]
    }
    
}
//ENGAGE0011722 -- End
