//
//  UpComingTeeTimes.swift
//  CSSI
//
//  Created by apple on 4/19/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

//
import UIKit
import ObjectMapper
import Foundation



class UpComingTeeTimes: NSObject, Mappable {
    var upComingTeeTimes: [TeeTimes]?
    var responseCode: String?
    var responseMessage: String?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        upComingTeeTimes <- map["UpcomingDetails"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
}

class TeeTimes: NSObject, Mappable  {
    
    var ID: String?
    var golfName: String?
    var diningName: String?
    var tennisGameType: String?

    var date: String?
    var time: String?
    var playersCount: String?
    var confirmationNumber: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        ID <- map["ReservationRequestID"]
        golfName <- map["GolfName"]
        diningName <- map["DiningName"]
        tennisGameType <- map["TennisGameType"]
        date <- map["Date"]
        time <- map["Time"]
        playersCount <- map["GolfPlayerCount"]
        confirmationNumber <- map["ConfirmationNumber"]
    }
    
}
