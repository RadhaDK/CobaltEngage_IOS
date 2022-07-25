//
//  RegisterYourDeviceResponse.swift
//  CSSI
//
//  Created by apple on 30/09/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
struct RegisterYourDeviceResponse: Codable {
    let registerDeviceInfo: [RegisterDeviceInfo]
    let responseCode, responseMessage: String
    
    enum CodingKeys: String, CodingKey {
        case registerDeviceInfo = "RegisterDeviceInfo"
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
    }
}

struct RegisterDeviceInfo: Codable {
    let linkedMemberID, uniqueDeviceID, status, statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case linkedMemberID = "LinkedMemberID"
        case uniqueDeviceID = "UniqueDeviceID"
        case status = "Status"
        case statusMessage = "StatusMessage"
    }
}
