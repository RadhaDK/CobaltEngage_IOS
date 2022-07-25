//
//  FitnessProfile.swift
//  CSSI
//
//  Created by Kiran on 22/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper


class FitnessProfile : NSObject,Mappable
{
    
    var getProfileDetails : [FitnessProfileDetails]?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.getProfileDetails <- map["GetProfileDetails"]
    }
    
}

class FitnessProfileDetails : NSObject,Mappable
{
    var fitnessProfileID : String?
    var linkedMemberID : String?
    var memberMasterID : String?
    var height : String?
    var weight : String?
    var groupDetails : [ProfileGroup]?
    var status : String?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.fitnessProfileID <- map["FitnessProfileID"]
        self.linkedMemberID <- map["LinkedMemberID"]
        self.memberMasterID <- map["MemberMasterID"]
        self.height <- map["Height"]
        self.weight <- map["Weight"]
        self.groupDetails <- map["GroupDetails"]
        self.status <- map["Status"]
    }
    
}


class ProfileGroup : NSObject, Mappable
{
    var groupID : String?
    var groupName : String?
    var isGroupOptIn : Int?
    var groupAudienceID : String?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.groupID <- map["GroupID"]
        self.groupName <- map["GroupName"]
        self.isGroupOptIn <- map["IsGroupOptIn"]
        self.groupAudienceID <- map["GroupAudienceID"]
    }
}
