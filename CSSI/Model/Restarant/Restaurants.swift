//
//  Restaurants  .swift
//  CSSI
//
//  Created by MACMINI13 on 30/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation


import ObjectMapper

class Restaurants: NSObject, Mappable {
  

    var restaurentMenus : [RestaurentMenus]?
    var responseCode : String?
    var responseMessage : String?

    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        restaurentMenus <- map["RestaurentMenus"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
    
}
class RestaurentMenus: NSObject, Mappable {
    var restaurantMenuID : Int?
    var restaurentMenu : String?
    var pdf : String?
    var menuIcon : String?
    var menuImage : String?

    
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        restaurantMenuID <- map["RestaurantMenuID"]
        restaurentMenu <- map["RestaurentMenu"]
        pdf <- map["Pdf"]
        menuIcon <- map["MenuIcon"]
        menuImage <- map["MenuImage"]
        


    }
    
}

