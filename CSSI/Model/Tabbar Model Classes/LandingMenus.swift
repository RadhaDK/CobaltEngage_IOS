//
//  LandingMenus.swift
//  CSSI
//
//  Created by apple on 10/30/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class LandingMenus :  NSObject, Mappable  {
    var menuID : Int?
    var displayName : String?
    var sequence : Int?
    var activity : String?
    var icon : String?
    //Added on 4th July 2020 V2.2
    ///Unique value for each menu dosent change
    var menuValue : String?
    
    //Added on 10th July 2020 V2.2
    var SACode : String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        menuID <- map["MenuID"]
        displayName <- map["DisplayName"]
        sequence <- map["Sequence"]
        activity <- map["Activity"]
        icon <- map["Icon2x"]
        //Added on 4th July 2020 V2.2
        self.menuValue <- map["MenuValue"]
        
        //Added on 10th July 2020 V2.2
        self.SACode <- map["SACODE"]
    }
    
}
