//
//  PlayHistory.swift
//  CSSI
//
//  Created by apple on 4/18/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//
import UIKit
import ObjectMapper
import Foundation



class PlayHistory: NSObject, Mappable {
    var playHistory: [PlayHistoryList]?
    var responseCode: String?
    var responseMessage: String?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        playHistory <- map["History"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
}

class PlayHistoryList: NSObject, Mappable  {
    
    var eventID: String?
    var category: String?
    var coursename: String?
    var date: String?
    var time: String?
    var confirmNumber: String?
    var confirmedReservationID: String?
    
    //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
    //GATHER0000700 - Start
    ///Indicates if the history is of reservation or BMS,Etc..
    var historyType : String?
    ///Enum representation of history Type.
    var playHistoryType : HistoryType?
    //GATHER0000700 - End
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        eventID <- map["ID"]
        category <- map["Category"]
        coursename <- map["Name"]
        date <- map["DateTime"]
        confirmNumber <- map["ConfirmNumber"]
        confirmedReservationID <- map["ConfirmedReservationID"]
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
        //GATHER0000700 - Start
        self.historyType <- map["HistoryType"]
        self.playHistoryType <- (map["HistoryType"],EnumTransform<HistoryType>())
        //GATHER0000700 - End
    }
    
}
