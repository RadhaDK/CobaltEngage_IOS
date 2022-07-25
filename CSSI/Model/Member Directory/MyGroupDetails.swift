
//
//  MyGroupDetils.swift
//  CSSI
//
//  Created by apple on 5/6/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class MyGroupDetails: NSObject, Mappable {
    
    var getMyGroupDetailsList: [GetMyGroupDetailsList]?
    var groupName: String?
    var responseCode: String?
    var responseMessage: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        
        getMyGroupDetailsList <- map["GetMyGroupDetails"]
        groupName <- map["GroupName"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
}

class GetMyGroupDetailsList: NSObject, Mappable  {
    
    var myGroupListID: String?
    @objc var name: String?
    var image: String?
    var linkedMemberID: String?
    var memberId: String?
    var id: String?
    var parentId: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        myGroupListID <- map["MyGroupListID"]
        name <- map["Name"]
        image <- map["ProfilePic"]
        linkedMemberID <- map["LinkedMemberID"]
        memberId <- map["MemberID"]
        id <- map["ID"]
        parentId <- map["ParentID"]
    }
    
}
