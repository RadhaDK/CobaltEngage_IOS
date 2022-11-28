//
//  getDinningReservationModel.swift
//  CSSI
//
//  Created by Aks on 19/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import ObjectMapper

class DinningReservationFCFS : NSObject, Mappable {
    
    
    var Responsecode            : String!
    var responseMessage         : String!
    var RequestID               : String!
    var RestaurantID            : String!
    var ConfirmationNumber      : String!
    var ReservationStatus       : Int!
    dynamic var SelectedTime    = ""
    dynamic var PartySize       = 0
    dynamic var SelectedDate    = ""
    var Comments                : String!
    var TablePreferenceID       : String!
    var TablePreferenceName : String!
    var PartyDetails            : [ResrvationPartyDetail]! = []
    var UI                      : GetResrvationUI!
    var ResponsecodeCancel : String!
    var Title : String!
    var Name : String!
    var SyncCalendarTitle : String!
    var Location : String!
    var RequestedLinkedMember : String!
    var UserName : String!
    var History : [GetHistoryResrvation]! = []
    
    override init() {
        super.init()
    }
    
    required convenience init?(map: Map) {
        self.init()
        Responsecode = ""
        responseMessage     = ""
        RequestID           = ""
        RestaurantID        = ""
        ConfirmationNumber  = ""
        ReservationStatus   = 0
        SelectedTime        = ""
        PartySize           = 0
        SelectedDate        = ""
        Comments            = ""
        TablePreferenceID   = ""
        TablePreferenceName = ""
        PartyDetails        = []
        UI                  = GetResrvationUI()
        ResponsecodeCancel = ""
        Title = ""
        Name = ""
        SyncCalendarTitle = ""
        Location = ""
        RequestedLinkedMember = ""
        UserName = ""
        History = []
    }
    
    func mapping(map: Map) {
        
        
        Responsecode             <- map["ResponseCode"]
        responseMessage         <- map["ResponseMessage"]
        RequestID               <- map["RequestID"]
        RestaurantID            <- map["RestaurantID"]
        ConfirmationNumber      <- map["ConfirmationNumber"]
        ReservationStatus       <- map["ReservationStatus"]
        SelectedTime            <- map["SelectedTime"]
        PartySize               <- map["PartySize"]
        SelectedDate            <- map["SelectedDate"]
        Comments                <- map["Comments"]
        TablePreferenceID       <- map["TablePreferenceID"]
        TablePreferenceName <- map["TablePreferenceName"]
        PartyDetails            <- map["PartyDetails"]
        UI                      <- map["UI"]
        ResponsecodeCancel            <- map["Responsecode"]
        Title <- map["Title"]
        Name  <- map["Name"]
        SyncCalendarTitle <- map["SyncCalendarTitle"]
        Location <- map["Location"]
        RequestedLinkedMember <- map["RequestedLinkedMember"]
        UserName <- map["UserName"]
        History <- map["History"]
    }
}




class ResrvationPartyDetail: RequestData, Mappable {
    
    dynamic var confirmationMemberID        = ""
    dynamic var MemberID            = ""
    dynamic var MemberNumber        = ""
    dynamic var MemberName          = ""
    dynamic var DietartRestriction  = ""
    dynamic var Anniversary         = 0
    dynamic var Birthday            = 0
    dynamic var Other               = 0
    dynamic var OtherText           = ""
    dynamic var HighChair           = 0
    dynamic var BoosterChair        = 0
    dynamic var guestOf             = ""
    dynamic var guestEmail          = ""
    dynamic var guestType           = ""
    dynamic var guestFirstName      = ""
    dynamic var guestLastName       = ""
    dynamic var guestDOB            = ""
    dynamic var guestGender         = ""
    dynamic var guestContact        = ""
    dynamic var specialOccation     = ""
    
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        confirmationMemberID = ""
        MemberID            = ""
        MemberName          = ""
        MemberName          = ""
        DietartRestriction  = ""
        Anniversary         = 0
        Birthday            = 0
        Other               = 0
        OtherText           = ""
        HighChair           = 0
        BoosterChair        = 0
        guestOf             = ""
        guestContact        = ""
        guestType           = ""
        guestDOB            = ""
        guestEmail          = ""
        guestGender         = ""
        guestLastName       = ""
        guestFirstName      = ""
        specialOccation     = ""
    }
    
    func mapping(map: Map) {
        
        confirmationMemberID <- map["ConfirmedReservationDetailID"]
        MemberID            <- map["LinkedMemberID"]
        MemberNumber        <- map["MemberID"]
        MemberName          <- map["MemberName"]
        DietartRestriction  <- map["DietaryRestriction"]
        Anniversary         <- map["Anniversary"]
        Birthday            <- map["Birthday"]
        Other               <- map["Other"]
        OtherText           <- map["OtherText"]
        HighChair           <- map["HighChair"]
        BoosterChair        <- map["BoosterChair"]
        guestOf             <- map["GuestMemberOf"]
        guestContact        <- map["GuestContact"]
        guestType           <- map["GuestType"]
        guestDOB            <- map["GuestDOB"]
        guestEmail          <- map["GuestEmail"]
        guestGender         <- map["GuestGender"]
        guestLastName       <- map["GuestLastName"]
        guestFirstName      <- map["GuestFirstName"]
        specialOccation     <- map["D_SpecialOccasion"]
    }
    
    func setPartyDetails(confirmationNumber: String, memberID: String, memberName: String, diet: String, anniversary: Int, birthday: Int, other: Int, otherText: String, highChair: Int, boosterChair: Int, memberNumber: String) {
        self.confirmationMemberID = confirmationNumber
        self.MemberID = memberID
        self.MemberName = memberName
        self.DietartRestriction = diet
        self.Anniversary = anniversary
        self.Birthday = birthday
        self.Other = other
        self.OtherText = otherText
        self.HighChair = highChair
        self.BoosterChair = boosterChair
        self.MemberNumber = memberNumber
        self.isEmpty = false
    }
    
    func setPartyGuestDetails(memberID: String, memberName: String, diet: String, anniversary: Int, birthday: Int, other: Int, otherText: String, highChair: Int, boosterChair: Int, guestOf: String, guestContact: String, guestType: String, guestDOB: String, guestEmail: String, guestGender: String, guestLastName: String, guestFirstName: String, memberNumber: String) {
        self.MemberID = memberID
        self.MemberName = memberName
        self.DietartRestriction = diet
        self.Anniversary = anniversary
        self.Birthday = birthday
        self.Other = other
        self.OtherText = otherText
        self.HighChair = highChair
        self.BoosterChair = boosterChair
        self.guestFirstName = guestFirstName
        self.guestLastName = guestLastName
        self.guestGender = guestGender
        self.guestOf = guestOf
        self.guestDOB = guestDOB
        self.guestEmail = guestEmail
        self.guestContact = guestContact
        self.guestType = guestType
        self.isEmpty = false
        self.MemberNumber = memberNumber
    }
}


class GetResrvationUI: NSObject, Mappable {
    
    var Submit                          : Int!
    var CancelRequest                   : Int!
    var PatrySizeEditable               : Int!
    var DateEditable                    : Int!
    var PartyInfoEditable               : Int!
    var ReservationCommentsEditable     : Int!
    var TablePreferenceEditable         : Int!
    var TimeSlotEditable                : Int!
    
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        Submit                          = 0
        CancelRequest                   = 0
        PatrySizeEditable               = 0
        DateEditable                    = 0
        PartyInfoEditable               = 0
        ReservationCommentsEditable     = 0
        TablePreferenceEditable         = 0
        TimeSlotEditable                = 0
       
    }
    
    func mapping(map: Map) {
        
        Submit                      <- map["Submit"]
        CancelRequest               <- map["CancelRequest"]
        PatrySizeEditable           <- map["PatrySizeEditable"]
        DateEditable                <- map["DateEditable"]
        PartyInfoEditable           <- map["PartyInfoEditable"]
        ReservationCommentsEditable <- map["ReservationCommentsEditable"]
        TablePreferenceEditable     <- map["TablePreferenceEditable"]
        TimeSlotEditable            <- map["TimeSlotEditable"]
      
    }
}


class GetHistoryResrvation: NSObject, Mappable {
    
    var ConfirmedReservationID                          : String!
    var ReservationDate                   : String!
    var ReservationTiming               : String!
    var ReservationTime                    : String!
    var DateTime               : String!
    var Name     : String!
    var ConfirmNumber         : String!
    
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        ConfirmedReservationID                          = ""
        ReservationDate                   = ""
        ReservationTiming               = ""
        ReservationTime                    = ""
        DateTime               = ""
        Name     = ""
        ConfirmNumber         = ""
       
    }
    
    func mapping(map: Map) {
        
        ConfirmedReservationID                      <- map["ConfirmedReservationID"]
        ReservationDate               <- map["ReservationDate"]
        ReservationTiming           <- map["ReservationTiming"]
        ReservationTime                <- map["ReservationTime"]
        DateTime           <- map["DateTime"]
        Name <- map["Name"]
        ConfirmNumber     <- map["ConfirmNumber"]
      
    }
}
