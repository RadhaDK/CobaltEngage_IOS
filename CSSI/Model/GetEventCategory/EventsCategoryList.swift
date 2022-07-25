//
//  EventsCategoryList.swift
//  CSSI
//
//  Created by apple on 11/2/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

class EventsCategoryList: NSObject, Mappable {
    
    
    var responseCode: String?
    var responseMessage: String?
    
    var listcategories: [ListEventCategory]?
    var clubNewsCategories: [ListEventCategory]?
    var golfCalendarCategory: [ListEventCategory]?
    var golfCategories: [ListEventCategory]?
    var tennisCategories: [ListEventCategory]?
    var diningCategory: [ListEventCategory]?
    var myBuddiesCategory: [ListEventCategory]?
    var fitnessSpaCategory : [ListEventCategory]?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        listcategories <- map["EventCategory"]
        clubNewsCategories <- map["ClubNewsCategory"]
        golfCalendarCategory <- map["GolfCalendarCategory"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        golfCategories <- map["GolfCategory"]
        tennisCategories <- map["TennisCategory"]
        diningCategory <- map["DiningCategory"]
        myBuddiesCategory <- map["MyBuddiesCategory"]
        fitnessSpaCategory <- map["FitnessSpaCategory"]
    }
    
    
    
    
    
}


