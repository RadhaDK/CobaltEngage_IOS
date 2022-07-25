//
//  FitnessVideoCategory.swift
//  CSSI
//
//  Created by Kiran on 12/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

//Added by kiran V2.4 -- GATHER0000176
class FitnessVideoCategories : NSObject,Mappable
{
    var fitnessCategory : [FitnessVideoCategory]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.fitnessCategory <- map["FitnessCategory"]
    }
}

//Added by kiran V2.4 -- GATHER0000176
class FitnessVideoCategory : NSObject,Mappable
{
    var name : String?
    var icon : String?
    var id : Int?
    var sequence : Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.name <- map["CategoryName"]
        self.icon <- map["Icon"]
        self.id <- map["ID"]
        self.sequence <- map["Sequence"]
    }
    
}
