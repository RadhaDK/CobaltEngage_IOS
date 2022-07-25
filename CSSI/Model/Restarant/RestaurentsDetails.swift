//
//  RestaurentsDetails.swift
//  CSSI
//
//  Created by MACMINI13 on 30/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class RestaurentsDetails: NSObject, Mappable {
    
    
    var restaurentMenus : [Restaurents]?
    var responseCode : String?
    var responseMessage : String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        restaurentMenus <- map["Restaurents"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
    
}
class Restaurents: NSObject, Mappable {
    var restaurantID : String?
    var restaurentName : String?
    var restaurentDesc : String?
    var restaurentthumb : String?
    var filepath : String?
    var type : String?

    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        restaurantID <- map["ID"]
        restaurentName <- map["RestaurentName"]
        restaurentDesc <- map["RestaurentDesc"]
        restaurentthumb <- map["IconThumbnail"]
        filepath <- map["FilePath"]
        type <- map["Type"]
    }
    
}

