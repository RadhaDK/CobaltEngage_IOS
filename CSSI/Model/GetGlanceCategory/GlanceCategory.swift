//
//  GlanceCategory.swift
//  CSSI
//
//  Created by apple on 11/6/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation

class GlanceCategory: NSObject, Mappable  {
    
    var categoryName: String?
    var categorySequence: Int?
    var id: String?

    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        //categoryid <- map["CategoryID"]
        categoryName <- map["CategoryName"]
        categorySequence <- map["CategorySequence"]
        id <- map["ID"] //updated on 27/07/2018 by api

        
    }
    
}

