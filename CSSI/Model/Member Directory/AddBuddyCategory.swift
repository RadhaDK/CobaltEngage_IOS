//
//  AddBuddyCategory.swift
//  CSSI
//
//  Created by apple on 6/1/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import Foundation

// MARK: - AddBuddyCategory
struct AddBuddyCategory: Codable {
    let getMyGroup: [GetMyGroup]
    let getCategory: [GetCategory]
    let responseCode, responseMessage: String
    
    enum CodingKeys: String, CodingKey {
        case getMyGroup = "GetMyGroup"
        case getCategory = "GetCategory"
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
    }
}

// MARK: - GetCategory
struct GetCategory: Codable {
    let value, text: String
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case text = "Text"
    }
}

// MARK: - GetMyGroup
struct GetMyGroup: Codable {
    let myGroupID, groupName: String
    
    enum CodingKeys: String, CodingKey {
        case myGroupID = "MyGroupId"
        case groupName = "GroupName"
    }
}
