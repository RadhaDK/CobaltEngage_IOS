//
//  EventList.swift
//  CSSI
//
//  Created by MACMINI13 on 13/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class EventList: NSObject, Mappable {
    
  
    var responseCode: String?
    var responseMessage: String?
    
    var listevents: [ListEvents]?

    
    

    override init() {
        super.init()
    }

    convenience required init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        
        listevents <- map["listEvents"]

        responseCode <- map["responseCode"]
        responseMessage <- map["responseMessage"]
    }

}


