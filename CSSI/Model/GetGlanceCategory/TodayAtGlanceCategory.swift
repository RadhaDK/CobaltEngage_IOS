//
//  TodayAtGlanceCategory.swift
//  CSSI
//
//  Created by apple on 11/6/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//



import UIKit
import Foundation
import ObjectMapper

class TodayAtGlanceCategoryList: NSObject, Mappable {
    
    
    var responseCode: String?
    var responseMessage: String?
    
    var glanceCategory: [GlanceCategory]?
    
    
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        glanceCategory <- map["GlanceCategory"]
        
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
    
    
    
    
    
}
