//
//  MyGroupsList.swift
//  CSSI
//
//  Created by apple on 5/6/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class MyGroupList: NSObject, Mappable {
    
    var getMyGroupList: [GetMyGroupListElement]?
    var responseCode: String?
    var responseMessage: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        
        getMyGroupList <- map["GetMyGroupList"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
}

class GetMyGroupListElement: NSObject, Mappable  {
    
    var myGroupID: String?
    var groupName: String?
    var image: String?
    var linkedMemberID: String?
    var imageName: String?

    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        myGroupID <- map["MyGroupID"]
        groupName <- map["GroupName"]
        image <- map["Image"]
        linkedMemberID <- map["LinkedMemberID"]
        imageName <- map["ImageName"]
    }
    
}
