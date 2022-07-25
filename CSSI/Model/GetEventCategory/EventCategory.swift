//
//  EventCategory.swift
//  CSSI
//
//  Created by apple on 11/2/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//


import UIKit
import ObjectMapper
import Foundation

class ListEventCategory: NSObject, Mappable  {
    
    var id: String?
    var categoryName: String?
    var categoryIcon: String?
    var categoryIconHover: String?
    var categoryText: String?
    var categoryValue: String?

    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        //categoryid <- map["CategoryID"]
        id <- map["ID"] //updated on 27/07/2018 by api
        categoryName <- map["CategoryName"]
        categoryIcon <- map["CategoryIcon"]
        categoryIconHover <- map["CategoryIconHover"]
        categoryText <- map["AppCategoryText"]
        categoryValue <- map["CategoryValue"]
        
    }
    
}
