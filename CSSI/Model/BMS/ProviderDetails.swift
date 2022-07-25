//
//  ProviderDetails.swift
//  CSSI
//
//  Created by Kiran on 01/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper



class ProviderDetails : NSObject,Mappable
{
    var providerDetails : [Provider]?
    var isSkip : Int?
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.providerDetails <- map["ProviderDetails"]
        self.isSkip <- map["IsSkip"]
    }
    
}


class Provider : NSObject,Mappable
{
    var name,providerID,profileImage : String?
    var gender : String?
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.name <- map["Name"]
        self.providerID <- map["ProviderID"]
        self.profileImage <- map["ProfileImage"]
        self.gender <- map["Gender"]
    }
    
}
