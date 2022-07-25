//
//  AlphaDetails.swift
//  CSSI
//
//  Created by apple on 11/7/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//


import Foundation
import ObjectMapper

class AlphaDetails: NSObject, Mappable {
    
    var golfAlphaData: [GolfAlphaData]?
    var pageCount: Int?
    var recordsPerpage: Int?
    var totalRecords: Int?
    
    var responseCode: String?
    var responseMessage: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        
        golfAlphaData <- map["GolfAlphaData"]
        pageCount <- map["PageCount"]
        recordsPerpage <- map["RecordsPerPage"]
        totalRecords <- map["TotalRecords"]
        
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
}


class GolfAlphaData: RequestData, Mappable  {
    
    
    var iD: String?
    var playerName: String?
    var time: String?
    var holes: String?
    var course: String?
    var profilePic: String?
    var memberID : String?
   
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
       
        iD <- map["ID"]
        playerName <- map["PlayerName"]
        time <- map["Time"]
        holes <- map["Holes"]
        course <- map["Course"]
        profilePic <- map["ProfilePic"]
        memberID <- map["MemberID"]
    }
    
}

