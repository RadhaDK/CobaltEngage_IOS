//
//  GolfAvailableSlotModel.swift
//  CSSI
//
//  Created by EBS Admin on 14/02/23.
//  Copyright © 2023 yujdesigns. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import ObjectMapper

class GetGolfSlots:  Mappable {
    var responseMessage         : String!
    var ResponseCode : Int!
    var TeeTimeSettings             : TeeTimeSettingsData!
    var AvailableTimeSlots : [GolfAvailableTimeSlotData]!

    init() {
        responseMessage         = ""
        ResponseCode = 0
        TeeTimeSettings             = nil
        AvailableTimeSlots = []

    }
    
    required init?(map: Map) {
        responseMessage         = ""
        ResponseCode = 0
        TeeTimeSettings             = nil
        AvailableTimeSlots = []

    }
    
    func mapping(map: Map) {
        responseMessage         <- map["ResponseMessage"]
        TeeTimeSettings          <- map["TeeTimeSettings"]
        ResponseCode <- map["ResponseCode"]
        AvailableTimeSlots <- map["AvailableTimeSlots"]

    }
}



class TeeTimeSettingsData: Mappable {
    var TimeInterval            : Int!
    var MaxDaysInAdvanceTime    = ""
    dynamic var MaxDaysInAdvance        = 90
    dynamic var MinDaysInAdvance        = 0
    dynamic var MinDaysInAdvanceTime    = ""
    var MaxPlayersSize            = 6
    dynamic var DefaultPlayersSize        = 1
    var DefaultStartTime : String!
    var DefaultEndTime : String!
    var DefaultTime : String!
    var ShowAll : Int!
    var Courses : [GolfCourseData]!
    var TimeIntervals : [GolfEnhancementTimeInterval]!
    var AvailableDates : [GetAvailableDate]!
    dynamic var DiningPolicy    = ""
    init() {
        TimeInterval            = 0
        MaxDaysInAdvanceTime    = ""
        MaxDaysInAdvance        = 90
        MinDaysInAdvance        = 0
        MinDaysInAdvanceTime    = ""
        MaxPlayersSize            = 6
        DefaultPlayersSize = 1
        DefaultStartTime = ""
        DefaultEndTime = ""
        DefaultTime = ""
        Courses = []
        DefaultTime = ""
        DiningPolicy = ""
        ShowAll = 0
        TimeIntervals = []
        AvailableDates = []
    }
    
    required init?(map: Map) {
        TimeInterval            = 0
        MaxDaysInAdvanceTime    = ""
        MaxDaysInAdvance        = 90
        MinDaysInAdvance        = 0
        MinDaysInAdvanceTime    = ""
        MaxPlayersSize            = 6
        DefaultPlayersSize = 1
        DefaultStartTime = ""
        DefaultEndTime = ""
        DefaultTime = ""
        Courses = []
        DefaultTime = ""
        DiningPolicy = ""
        ShowAll = 0
        TimeIntervals = []
        AvailableDates = []
    }
    
    func mapping(map: Map) {
        TimeInterval            <- map["TimeInterval"]
        MaxDaysInAdvanceTime    <- map["MaxDaysInAdvanceTime"]
        MaxDaysInAdvance        <- map["MaxDaysInAdvance"]
        MinDaysInAdvance        <- map["MinDaysInAdvance"]
        MinDaysInAdvanceTime    <- map["MinDaysInAdvanceTime"]
        MaxPlayersSize            <- map["MaxPlayersSize"]
        DefaultPlayersSize        <- map["DefaultPlayersSize"]
        DefaultStartTime        <- map["DefaultStartTime"]
        DefaultEndTime          <- map["DefaultEndTime"]
        DefaultTime             <- map["DefaultTime"]
        Courses        <- map["Courses"]
        DefaultTime             <- map["DefaultTime"]
        DiningPolicy            <- map["DiningPolicy"]
        ShowAll <- map["ShowAll"]
        TimeIntervals <- map["TimeIntervals"]
        AvailableDates <- map["AvailableDates"]
    }
}


class GolfCourseData: NSObject, Mappable {
    var CourseID         : String!
    var CourseName       : String!
   
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        CourseID         = ""
        CourseName       = ""
    }
    
    func mapping(map: Map) {
        CourseID         <- map["CourseID"]
        CourseName       <- map["CourseName"]
    }
}

class GolfEnhancementTimeInterval: NSObject, Mappable {
    var time    : String!

    override init() {
        super.init()
    }

    convenience required init?(map: Map) {
        self.init()
        time        = ""
    }

    func mapping(map: Map) {
        time        <- map["Time"]
    }
}

class GetAvailableDate: NSObject, Mappable {
    
    var Date         : String!

    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        Date         = ""
    }
    
    func mapping(map: Map) {
        Date         <- map["Date"]
    }
}

class GolfAvailableTimeSlotData: NSObject, Mappable {
    
    var TimeSlot         : String!
    var TypeGolf       : String!
    var CourseID : String!
    var CourseName : String!
    var IsEnable : Int!
    var PlayersList : [PlayersListData]!

    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        TimeSlot         = ""
        TypeGolf       = ""
        CourseID = ""
        CourseName = ""
        IsEnable = 0
        PlayersList = []

    }
    
    func mapping(map: Map) {
        
        TimeSlot         <- map["TimeSlot"]
        TypeGolf       <- map["Type"]
        CourseID <- map["CourseID"]
        CourseName <- map["CourseName"]
        IsEnable <- map["IsEnable"]
        PlayersList <- map["PlayersList"]

    }
}


class PlayersListData: NSObject, Mappable {

    var PlayerName         : String!
    var ConfirmationID : String!
    var TransType : String!
    var IsEnable : Int!
    var NineHoles : Int!
    
    override init() {
        super.init()
    }

    convenience required init?(map: Map) {
        self.init()
        PlayerName         = ""
        ConfirmationID = ""
        TransType = ""
        IsEnable = 0
        NineHoles = 0
    }
    func mapping(map: Map) {

        PlayerName         <- map["PlayerName"]
        ConfirmationID <- map["ConfirmationID"]
        TransType <- map["TransType"]
        IsEnable <- map["IsEnable"]
        NineHoles <- map["NineHoles"]
    }
}
