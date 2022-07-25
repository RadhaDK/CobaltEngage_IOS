//
//  ListEvents.swift
//  CSSI
//
//  Created by MACMINI13 on 22/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation



class EventsLists: NSObject, Mappable {
    var eventsList: [ListEvents]?
    var golfEventsList: [ListEvents]?
    var tennisEventsList: [ListEvents]?
    var diningEventsList: [ListEvents]?
    var fitnessEventsList: [ListEvents]?
    var isLoadMore : Int?
    var monthCount : Int?
    
    var responseCode: String?
    var responseMessage: String?
    
    //Added by kiran V1.3 -- PROD0000071 -- Support to request events from club news on click of news
    //PROD0000071 -- Start
    var isRedirectToEventsDetail : Int?
    //PROD0000071 -- End
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        eventsList <- map["Events"]
        golfEventsList <- map["GetDetails"]
        tennisEventsList <- map["GetDetails"]
        diningEventsList <- map["GetDetails"]
        fitnessEventsList <- map["GetDetails"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        isLoadMore <- map["IsLoadMore"]
        monthCount <- map["MonthCount"]
        //Added by kiran V1.3 -- PROD0000071 -- Support to request events from club news on click of news
        //PROD0000071 -- Start
        self.isRedirectToEventsDetail <- map["IsRedirectToEventsDetail"]
        //PROD0000071 -- End
    }
}

class ListEvents: NSObject, Mappable  {
    
    var eventID: String?
    var eventName: String?
    var eventDescription: String?
    var eventDate: String?
    var eventTime: String?
    var eventVenue: String?
    var imageThumb: String?
    var imageLarge: String?
    var eventCategory: String?
    var eventenddate: String?
    var eventendtime: String?
    var eventstatus: String?
    var eventstartdate: String?
    var isMemberCalendar: Int?
    var eventstartdatetime: String?
    var externalURL: String?
    var memberEventStatus: String?
    var colorCode: String?
    var buttontextvalue: String?
    var type: String?
    var confirmationNumber: String?
    var eventEndDateTime: String?
    var confirmMessage: String?
    var partySize: String?
    var location: String?
    var requestID: String?
    var eventRegistrationDetailID: String?
    var isMemberTgaEventNotAllowed: Int?
    var eventFirstDay: String?
    var eventDayName: String?
    var eventDateList: [EventSyncData]?
    var isScheduleEvent : Int?
    var scheduleText : String?
    
    //Added on 18th June 2020
    var appointmentFlow : [FlowSequence]?
    var DepartmentName : String?
    var locationID : String?
    var productClassID : String?
    var providerID : String?
    var serviceID : String?
    var requestType : CalendarRequestType?
    var showViewButton : Bool?
    var showCancelButton : Bool?
    
    //Added on 11th August 2020
    var providerName : String?
    //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
    //GATHER0000700 - Start
    var departmentType : String?
    //GATHER0000700 - End
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        requestID <- map["RequestID"]
        partySize <- map["PartySize"]
        eventID <- map["ID"]
        eventName <- map["EventName"]
        eventDescription <- map["EventDesc"]
        eventDate <- map["EventDate"]
        eventTime <- map["EventTime"]
        eventVenue <- map["EventVenue"]
        imageThumb <- map["ImageThumb"]
        imageLarge <- map["ImageLarge"]
        eventCategory <- map["EventCategory"]
        eventstartdate <- map["EventStartDate"]
        eventenddate <- map["EventEndDate"]
        eventendtime <- map["EventEndTime"]
        eventstatus <- map["EventStatus"]
        isMemberCalendar <- map["IsMemberCalendar"]
        eventstartdatetime <- map["EventStartDateTime"]
        externalURL <- map["ExternalURL"]
        memberEventStatus <- map["MemberEventStatus"]
        colorCode <- map["ColorCode"]
        buttontextvalue <- map["ButtonTextValue"]
        type <- map["Type"]
        confirmationNumber <- map["ConfirmationNumber"]
        eventEndDateTime <- map["EventEndDateTime"]
        confirmMessage <- map["ConfirmMessage"]
        location <- map["Location"]
        eventRegistrationDetailID <- map["EventRegistrationDetailID"]
        isMemberTgaEventNotAllowed <- map["IsMemberTgaEventNotAllowed"]
        eventFirstDay <- map["EventFirstDay"]
        eventDayName <- map["EventDayName"]
        eventDateList <- map["EventDateList"]
        isScheduleEvent <- map["IsScheduleEvent"]
        scheduleText <- map["ScheduleText"]
        
        //Added on 18th June 2020
        self.appointmentFlow <- map["AppointmentFlow"]
        self.DepartmentName <- map["DepartmentName"]
        self.locationID <- map["LocationID"]
        self.productClassID <- map["ProductClassID"]
        self.providerID <- map["ProviderID"]
        self.serviceID <- map["ServiceID"]
        self.requestType <- (map["Type"],EnumTransform<CalendarRequestType>())
        self.showViewButton <- map["ShowViewButton"]
        self.showCancelButton <- map["ShowCancelButton"]
        
        //Added on 11th August 2020 V2.3
        self.providerName <- map["ProviderName"]
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
        //GATHER0000700 - Start
        self.departmentType <- map["Departmenttype"]
        //GATHER0000700 - End
    }
    
    
}

class EventSyncData : NSObject , Mappable
{
    var startDate : String?
    var endDate : String?
    var startTime : String?
    var endTime : String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
     func mapping(map: Map) {
        startDate <- map["EventFromDate"]
        endDate <- map["EventToDate"]
        startTime <- map["EventFromTime"]
        endTime <- map["EventToTime"]
    }
}
