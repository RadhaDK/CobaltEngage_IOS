//
//  HistoryDetails.swift
//  CSSI
//
//  Created by apple on 4/19/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation

class HistoryDetails: NSObject, Mappable {
    var historyList: [History]?
    var responseCode: String?
    var responseMessage: String?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        historyList <- map["HistoryDetails"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
}

class History: NSObject, Mappable  {
    
    var id: String?
    var group: String?
    var courseName: String?
    var time: String?
    var gameType: String?
    var confirmNumber: String?
    var playerDetails: [Player]?
    var captainName: String?
    var date: String?
    var specialRequest: String?
    var comments: String?
    var diningName: String?
    var partySize: Int?
    var duration: String?
    var match: String?
    var playDate: String?
    var confirmedTeeTime: String?
    var tablePreferenceName: String?


    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        tablePreferenceName <- map["TablePreferenceName"]
        id <- map["ReservationRequestDetailId"]
        group <- map["Group"]
        courseName <- map["CourseName"]
        time <- map["Time"]
        gameType <- map["GameType"]
        confirmNumber <- map["ConfirmationNumber"]
        playerDetails <- map["Details"]
        captainName <- map["CaptainName"]
        date <- map["Date"]
        specialRequest <- map["SpecialRequest"]
        comments <- map["Comments"]
        diningName <- map["DiningName"]
        partySize <- map["PartySize"]
        duration <- map["Duration"]
        match <- map["Match"]
        playDate <- map["PlayDate"]
        confirmedTeeTime <- map["ConfirmedTeeTime"]


        
    }
    
}

class Player: NSObject, Mappable  {
    
    
    var player1: String?
    var status: String?
    var statusColor: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        player1 <- map["Name"]
        status <- map["Status"]
        statusColor <- map["StatusColor"]
        
    }
    
}
