//
//  AppVersion.swift
//  CSSI
//
//  Created by apple on 11/11/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import Foundation

struct AppVersion: Codable {
    let responseCode, responseMessage, currentAppVersion : String
    let memberStatus : Int
    //Added by kiran V1.3 -- PROD0000019 -- Added 2 step verification
    //PROD0000019 -- Start
    let hasAccountExpired : Int?
    //PROD0000019 -- End
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
        case currentAppVersion = "CurrentAppVersion"
        case memberStatus = "MemberStatus"
        //Added by kiran V1.3 -- PROD0000019 -- Added 2 step verification
        //PROD0000019 -- Start
        case hasAccountExpired = "HasAccountExpired"
        //PROD0000019 -- End
    }
    
}
