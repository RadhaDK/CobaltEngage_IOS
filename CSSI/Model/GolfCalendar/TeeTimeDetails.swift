//
//  TeeTimeDetails.swift
//  CSSI
//
//  Created by apple on 5/1/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation



class TeeTimeDetails: NSObject, Mappable {
    
    var requestTeeTimeDetails: [RequestTeeTimeDetail]?
    var requestTennisDetails: [RequestTeeTimeDetail]?
    var requestDiningDetails: [RequestTeeTimeDetail]?

    var responseCode: String?
    var responseMessage: String?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        requestTeeTimeDetails <- map["RequestTeeTimeDetails"]
        requestTennisDetails <- map["RequestTennisDetails"]
        requestDiningDetails <- map["RequestDiningDetails"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        
    }
}

class RequestTeeTimeDetail: NSObject, Mappable  {
    
    var reservationRequestDate: String?
    var reservationRequestTime: String?
    var syncCalendarTitle: String?
    var preferredCourse: String?
    var excludedCourse: String?
    var gameType: Int?
    var linkGroup: String?
    var earliest: String?
    var latest: String?
    var status: String?
    var numberOfGroups: Int?
    var courseDetails: [CourseDetail]?
    var groupDetails: [GroupDetail]?
    var playType: String?
    var duration: String?
    var ballMachine: Int?
    var confirmationNumber: String?
    var tennisDetails: [GroupDetail]?
    var tennisDetailsOnly: [Detail]?
    var count: Int?
    var reservationRequestID: String?
    var partySize: Int?
    var tablePreference: String?
    var comments: String?
    var restaurantDetails: [RestaurantDetail]?
    var diningDetails: [GroupDetail]?
    var location : String?
    var guestName: String?
    var tablePreferenceName: String?
    var preferedSpaceDetailId: String?
    var durationText: String?
    var isModify: Int?
    var isCancel: Int?
    var buttonTextValue: String?
    var gameTypeTitle: String?
    var preferedDetailId: String?
    var notPreferedSpaceDetailId: String?
    var golfRequestType: String?
    var btnValue: Int?
    var preferredTimeSlots: [PreferredFCFSCoursesWithTime]?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        btnValue <- map["ButtonTextValue"]
        preferedDetailId <- map["PreferedSpaceDetailId"]
        notPreferedSpaceDetailId <- map["NotPreferedSpaceDetailId"]
        buttonTextValue <- map["ButtonTextValue"]
        isModify <- map["IsModify"]
        isCancel <- map["IsCancel"]
        preferedSpaceDetailId <- map["PreferedSpaceDetailId"]
        tablePreferenceName <- map["TablePreferenceName"]
        guestName <- map["GuestName"]
        location <- map["Location"]
        reservationRequestDate <- map["ReservationRequestDate"]
        reservationRequestTime <- map["ReservationRequestTime"]
        syncCalendarTitle <- map["SyncCalendarTitle"]
        preferredCourse <- map["PreferredCourse"]
        excludedCourse <- map["ExcludedCourse"]
        gameType <- map["GameType"]
        linkGroup <- map["LinkGroup"]
        earliest <- map["Earliest"]
        latest <- map["Latest"]
        status <- map["Status"]
        numberOfGroups <- map["#NumberOfGroups"]
        courseDetails <- map["CourseDetails"]
        groupDetails <- map["GroupDetails"]
        playType <- map["PlayType"]
        duration <- map["Duration"]
        ballMachine <- map["BallMachine"]
        confirmationNumber <- map["ConfirmationNumber"]
        tennisDetails <- map["TennisDetails"]
        tennisDetailsOnly <- map["TennisDetails"]
        count <- map["COUNT"]
        reservationRequestID <- map["ReservationRequestId"]
        partySize <- map["PartySize"]
        tablePreference <- map["TablePreference"]
        comments <- map["Comments"]
        restaurantDetails <- map["RestaurantDetails"]
        diningDetails <- map["DiningDetails"]
        durationText <- map["DurationText"]
        gameTypeTitle <- map["GameTypeTitle"]
        golfRequestType <- map["GolfRequestType"]
        preferredTimeSlots <- map["PreferredFCFSCoursesWithTime"]        
    }
    
}

class CourseDetail: NSObject, Mappable  {
    
    var id: String?
    var courseName: String?
    var courseImage1: String?
    var courseImage2: String?
    var courseImage3: String?

    var preferenceType: String?
    var playType: String?
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id <- map["ID"]
        courseName <- map["CourseName"]
        courseImage1 <- map["CourseImage"]
        courseImage2 <- map["CourseImage1"]
        courseImage3 <- map["CourseImage2"]

        preferenceType <- map["PreferenceType"]
        playType <- map["PlayType"]
        
        
    }
    
}
class GroupDetail: RequestData, Mappable  {
    
    var reservationRequestDetailId: String?
    var captainName: String?
    var group: String?
    var confirmationNumber: String?
    var details: [Detail]?
    var name: String?
    var memberID : String?
    var guestName: String?
    var guestType: String?
    var highchair: Int?
    var boosterCount: Int?
    var dietary: String?
    var id: String?
    var email: String?
    var cellPhone: String?
    var addBuddy: Int?
    var otherText: String?
    var other: Int?
    var birthDay: Int?
    var anniversary: Int?
    var allocatedCourse: String?
    var allocatedTime: String?
    var status: String?
    var color: String?
    var specialOccasion: [GroupDetail]?
    var guestMemberOf: String?
    var playerGroup: Int?
    var confirmedReservationID: String?
    var buttonTextValue : String?
    var teeBox: String?
    var gameTypeTitle: String?
    
    //Added by kiran V2.8 -- ENGAGE0011784 --
    //ENGAGE0011784 -- Start
    var guestDOB : String?
    var guestGender : String?
    var guestFirstName : String?
    var guestLastName : String?
    var guestLinkedMemberID : String?
    //ENGAGE0011784 -- End
    
    var memberTransType: String?
    var memberRequestHoles: String?

    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        status <- map["Status"]
        color <- map["ColorCode"]
        dietary <- map["DietaryRestrictions"]
        boosterCount <- map["BoosterChairCount"]
        highchair <- map["HighChairCount"]

        reservationRequestDetailId <- map["ReservationRequestDetailId"]
        captainName <- map["CaptainName"]
        group <- map["Group"]
        confirmationNumber <- map["ConfirmationNumber"]
        details <- map["Details"]
        name <- map["Name"]
        memberID <- map["MemberID"]
        guestName <- map["GuestName"]
        id <- map["LinkedMemberID"]
        guestType <- map["GuestType"]
        email <- map["GuestEmail"]
        cellPhone <- map["GuestContact"]
        addBuddy <- map["AddBuddy"]
        otherText <- map["OtherText"]
        other <- map["Other"]
        birthDay <- map["Birthday"]
        anniversary <- map["Anniversary"]
        specialOccasion <- map["SpecialOccasion"]
        allocatedCourse <- map["AllocatedCourse"]
        allocatedTime <- map["AllocatedTime"]
        guestMemberOf <- map["GuestMemberOf"]
        playerGroup <- map["PlayerGroup"]
        confirmedReservationID <- map["ConfirmedReservationID"]
        buttonTextValue <- map["ButtonTextValue"]
        
        
        //Added by kiran V2.8 -- ENGAGE0011784 --
        //ENGAGE0011784 -- Start
        self.guestDOB <- map["GuestDOB"]
        self.guestGender <- map["GuestGender"]
        self.guestFirstName <- map["GuestFirstName"]
        self.guestLastName <- map["GuestLastName"]
        self.guestLinkedMemberID <- map["GuestLinkedMemberID"]
        //ENGAGE0011784 -- End
        self.memberTransType <- map["MemberTransType"]
        self.memberRequestHoles <- map["MemberRequestHoles"]
        self.teeBox <- map["TeeBox"]
        self.gameTypeTitle <- map["GameTypeTitle"]
    }
    
}
class Detail: RequestData, Mappable  {
    
    var reservationRequestDetailID: String?
    var name: String?
    var playerOrder: Int?
    var specialRequest: String?
    var memberId: String?
    var id: String?
    var guestName: String?
    var guestType: String?
    var addBuddy: Int?
    var email: String?
    var cellPhone: String?
    var confirmationNumber: String?
    var playerGroup: Int?
    //Added on 16th June BMS
    var appointmentMemberID : String?
    var guestMemberNo : String?
    //Added on 4th September 2020 V2.3
    var guestDOB : String?
    var guestGender : String?
    
    //Added by kiran V2.8 -- ENGAGE0011784 -- Added First and Last name.
    //ENGAGE0011784 -- Start
    var guestFirstName : String?
    var guestLastName : String?
    var guestMemberOf : String?
    var guestLinkedMemberID : String?
    var guestIdentityID : String?
    //ENGAGE0011784 -- End
    
    var memberTransType: Int?
    var memberRequestHoles: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        confirmationNumber <- map["ConfirmationNumber"]
        reservationRequestDetailID <- map["ReservationRequestDetailId"]
        name <- map["Name"]
        playerOrder <- map["PlayerOrder"]
        specialRequest <- map["SpecialRequest"]
        memberId <- map["MemberID"]
        id <- map["LinkedMemberID"]
        guestName <- map["GuestName"]
        guestType <- map["GuestType"]
        addBuddy <- map["AddBuddy"]
        email <- map["GuestEmail"]
        cellPhone <- map["GuestContact"]
        playerGroup <- map["PlayerGroup"]
        
        appointmentMemberID <- map["AppointmentMemberID"]
        guestMemberNo <- map["GuestMemberNo"]
        
        //Added on 4th September 2020 V2.3
        self.guestDOB <- map["GuestDOB"]
        self.guestGender <- map["GuestGender"]
        
        //Added by kiran V2.8 -- ENGAGE0011784 -- Added First and Last name for guests
        //ENGAGE0011784 -- Start
        self.guestFirstName <- map["GuestFirstName"]
        self.guestLastName <- map["GuestLastName"]
        self.guestMemberOf <- map["GuestMemberOf"]
        self.guestLinkedMemberID <- map["GuestLinkedMemberID"]
        self.guestIdentityID <- map["GuestIdentityID"]
        //ENGAGE0011784 -- End
        self.memberTransType <- map["MemberTransType"]
        self.memberRequestHoles <- map["MemberRequestHoles"]
    }
    
}

class RestaurantDetail: RequestData, Mappable  {
    
    var id: String?
    var restaurantName: String?
    var time: Int?
    var restauranImage: String?
    var preferenceType: String?

    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id <- map["ID"]
        restaurantName <- map["RestaurantName"]
        time <- map["Time"]
        restauranImage <- map["RestauranImage"]
        preferenceType <- map["PreferenceType"]

    }
    
}

class WatlistTeeTime: Codable
{
    var ConfirmedReservationID,WaitlistEarliestTime,WaitlistLatestTime,GroupStatus : String
    var GroupNo : Int
    
    init(reservationID : String,earliestTime : String , latestTime : String , status : String , no: Int) {
        self.ConfirmedReservationID = reservationID
        self.WaitlistEarliestTime = earliestTime
        self.WaitlistLatestTime = latestTime
        self.GroupStatus = status
        self.GroupNo = no
    }
    
    enum codingKeys: String , CodingKey{
        case ConfirmedReservationID = "ConfirmedReservationID"
        case WaitlistEarliestTime = "WaitlistEarliestTime"
        case WaitlistLatestTime = "WaitlistLatestTime"
        case GroupStatus = "GroupStatus"
        case GroupNo = "GroupNo"
    }
}

class PreferredFCFSCoursesWithTime: RequestData, Mappable {
    var courseDetailId : String?
    var courseName : String?
    var startingHole : String?
    var teeBox : String?
    var time : String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        courseDetailId <- map["CourseDetailId"]
        courseName <- map["CourseName"]
        startingHole <- map["G_StartingHole"]
        teeBox <- map["TeeBox"]
        time <- map["Time"]
    }

}
