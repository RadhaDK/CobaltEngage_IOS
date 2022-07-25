//
//  EventDetail.swift
//  CSSI
//
//  Created by apple on 2/26/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import Foundation


import ObjectMapper


class EventDetail: NSObject, Mappable {
    var registeredDetails: [RegisteredDetail]?
    var eventDateTime: [EventDateTime]?
    var eventID: String?
    var eventName: String?
    var eventVenue: String?
    var eventDate: String?
    var eventTime: String?
    var additionalDetails: String?
    var registrationFor: String?
    var thumbnail: String?
    var imagePoster: String?
    var desktopImage: String?
    var registrationURL: String?
    var eventStatus: String?
    var colorCode: String?
    var eventStatusText: String?
    var eventCategory: String?
    var totalTickets: Int?
    var maxAllowedTickets: Int?
    var nextEvent: String?
    var previousEvent: String?
    var ticketPrice: Int?
    var orientation: String?
    var registrationOpen: String?
    var registrationClose: String?
    var cancelDate: String?
    var requestID: String?
    var preferedSpaceDetailId: String?
    var isMemberChangeTime: Int?
    var fromTime: String?
    var toTime: String?
    var minDaysInAdvance: Int?
    var requestDiningDetails: [RequestTeeTimeDetail]?
    var guest: Int?
    var imagePath: String?
    var responseCode: String?
    var responseMessage: String?
    var timeInterval: [TimeIntervalArray]?
    var kids3Above: Int?
    var kids3Below: Int?
    var isTgaEvent: Int?
    var isSpouse: Int?
    var isModify: Int?
    var isModifyText: String?
    var IsAllowEarliestLatestTime : Int?
    var IsCancelEventAllowed : Int?
    var isScheduleEvent : Int?
    var scheduleText : String?
    //Added by kiran V2.7 -- ENGAGE0011683 -- Added minimum ticket count for events
    //ENGAGE0011683 -- Start
    var minTicketsAllowed : Int?
    //ENGAGE0011683 -- End
    
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        kids3Below <- map["Kids3Below"]
        kids3Above <- map["Kids3Above"]
        isTgaEvent <- map["IsTgaEvent"]
        guest <- map["Guest"]
        minDaysInAdvance <- map["MinDaysAdvance"]
        imagePath <- map["ImagePath"]
        timeInterval <- map["TimeInterval"]
        requestID <- map["RequestID"]
        preferedSpaceDetailId <- map["PreferedSpaceDetailId"]
        isMemberChangeTime <- map["IsMemberChangeTime"]
        fromTime <- map["FromTime"]
        toTime <- map["ToTime"]

        registeredDetails <- map["RegisteredDetails"]
        eventDateTime <- map["EventDateTime"]
        eventID <- map["EventID"]
        eventName <- map["EventName"]
        eventVenue <- map["EventVenue"]
        eventDate <- map["EventDate"]
        eventTime <- map["EventTime"]
        additionalDetails <- map["AdditionalDetails"]
        registrationFor <- map["RegistrationFor"]
        thumbnail <- map["Thumbnail"]
        imagePoster <- map["ImagePoster"]
        desktopImage <- map["DesktopImage"]
        registrationURL <- map["RegistrationUrl"]
        eventStatus <- map["EventStatus"]
        colorCode <- map["ColorCode"]
        eventStatusText <- map["EventStatusText"]
        eventCategory <- map["EventCategory"]
        totalTickets <- map["TotalTickets"]
        maxAllowedTickets <- map["MaxAllowedTickets"]
        nextEvent <- map["NextEvent"]
        previousEvent <- map["PreviousEvent"]
        ticketPrice <- map["TicketPrice"]
        orientation <- map["Orientation"]
        registrationOpen <- map["RegistrationOpen"]
        registrationClose <- map["RegistrationClose"]
        cancelDate <- map["CancelDate"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        requestDiningDetails <- map["RequestDiningDetails"]
        isSpouse <- map["IsSpouse"]
        isModify <- map["IsModify"]
        isModifyText <- map["IsModifyText"]
        IsAllowEarliestLatestTime <- map["IsAllowEarliestLatestTime"]
        IsCancelEventAllowed <- map["IsCancelEventAllowed"]
        isScheduleEvent <- map["IsScheduleEvent"]
        scheduleText <- map["ScheduleText"]
        //Added by kiran V2.7 -- ENGAGE0011683 -- Added minimum ticket count for events
        //ENGAGE0011683 -- Start
        self.minTicketsAllowed <- map["MinTicketsAllowed"]
        //ENGAGE0011683 -- End
    }
}

class EventDateTime: NSObject, Mappable  {
    
    var eventFromDate: String?
    var eventToDate: String?
    var eventFromTime: String?
    var eventToTime: String?

    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        eventFromDate <- map["EventFromDate"]
        eventToDate <- map["EventToDate"]
        eventFromTime <- map["EventFromTime"]
        eventToTime <- map["EventToTime"]
       
        
    }
    
}

class RegisteredDetail: NSObject, Mappable  {
    
    var eventRegistrationID: String?
    var comments: String?
    var ticketStatus: String?
    var noofTickets: Int?
    var memberList: [MemberInfo]?
    var guestList: [GuestListName]?
    var buddyList: [MemberInfo]?
    var confirmedList: String?
    var waitListed: String?
    var memberName: String?
    var guestListModify: [MemberInfo]?
    var partySize: Int?
    var guestCount: Int?
    var kids3belowCount: Int?
    var memberCount: Int?
    var kidsaboveCount: Int?
    //Added on 15th July 2020 v2.2
    var requestedLinkedmemberID : String?
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        guestCount <- map["GuestCount"]
        kids3belowCount <- map["Kids3belowCount"]
        memberCount <- map["MemberCount"]
        kidsaboveCount <- map["kidsaboveCount"]
        eventRegistrationID <- map["EventRegistrationID"]
        comments <- map["Comments"]
        ticketStatus <- map["TicketStatus"]
        noofTickets <- map["NoofTickets"]
        memberList <- map["MemberList"]
        guestList <- map["GuestList"]
        confirmedList <- map["ConfirmedList"]
        waitListed <- map["WaitListed"]
        memberName <- map["MemberName"]
        buddyList <- map["BuddyList"]
        guestListModify <- map["GuestList"]
        partySize <- map["PartySize"]
        //Added on 15th July 2020 V2.2
        self.requestedLinkedmemberID <- map["RequestedLinkedmemberID"]
    }
    
}

class GuestListName: NSObject, Mappable  {
    
    var guestName: String?
  
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        guestName <- map["GuestName"]
      
        
    }
    
}
class TimeIntervalArray: NSObject, Mappable  {
    
    var value: String?
    
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        value <- map["Value"]
        
        
    }
    
}
