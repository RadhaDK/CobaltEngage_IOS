//
//  MemberDirectoryInterest.swift
//  CSSI
//
//  Created by MACMINI13 on 03/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class MemberDirectoryInterest: NSObject, Mappable {
    var memberInterest: [MemberDictInterest]?
    var states: [States]?
    var relation: [GuestRelation]?
    var dateSort: [DateSort]?
    var calendarSort: [DateSort]?
    var relationFilter: [RelationFilter]?
    var eventStatusFilter : [EventStatusFilter]?
    var weeks : [Week]?
    var days : [Day]?
    var boardofGovernors : [BoardofGovernors]?
    var clubNewsRotation : [ClubNewsRotationValue]?
    var prefix : [Prefix]?
    var sufix : [Suffix]?
    var sendStatementsTo : [AddressTypes]?
    var allMarkettingOptions : [AllMarkettingOtions]?
    var remainderTime : [ReminderTime]?
    //Commented by kiran V2.5 -- ENGAGE0011395 -- Settings screen implementation change
    //ENGAGE0011395 -- Start
    //var settingsList : [SettingList]?
    //ENGAGE0011395 -- End
    var shareUrlList : [ShareURL]?
    var mbEventRegType : [RegisterType]?
    var eventRegMemberOnly : [RegisterType]?
    var selectionDayType: [SelectionDayType]?
    var duration : [DurationType]?
    var golfGameType: [GolfGameType]?
    var guestType: [GuestType]?
    var golfLeagues: [GolfLeagues]?
    var guestNumberOfDays: Int?
    var linkToWebSiteFontSize: Int?
    var responseCode: String?
    var responseMessage: String?
    var registerMultiMemberType: [RegisterType]?
    var CancelPopImageList : [CancelPopImage]?
    
    var EventKidInstruction : [Instruction]?
    var DirectoryMemberKidInstruction : [Instruction]?
    var DirectoryBuddyKidInstruction : [Instruction]?
    var EventGuestInstruction : [Instruction]?
    var DirectoryMemberGuestInstruction : [Instruction]?
    var DirectoryBuddyGuestInstruction : [Instruction]?
    var EventGuestKidInstruction : [Instruction]?
    var DirectoryMemberGuestKidInstruction : [Instruction]?
    var DirectoryBuddyGuestKidInstruction : [Instruction]?
    var ReservationsInstruction : [Instruction]?
    var DiningEventInstruction : [Instruction]?
    var MemberOnlyEventInstruction : [Instruction]?
    
    var PrivacyPolicy : String?
    var TermsofUse : String?
    
    //Added on 4th June 2020 BMS
    var genderOptions : [FilterOption]?
    //Added on 4th September 2020 V2.3
    var guestGender : [GuestGender]?
    
    //Added on 9th October 2020 V2.3
    var MB_Dining_RegisterMemberType_MemberOnly : [BWOption]?
    var MB_Dining_RegisterMemberType : [BWOption]?
    
    //Added on 12th October 2020 V2.3
    var giftCertificateCardType : [BWOption]?
    var giftCertificateStatus : [FilterOption]?
    var GiftCardPdf : String?
    
    //Added on 28th October 2020 V2.3 -- GATHER0000176
    var fitnessSettings : [FitnessSetting]?
    var appFitnessMenu : [HamburgerMenu]?
    
    //Added by kiran V2.5 --ENGAGE0011344 -- Gimbal Integration
    //ENGAGE0011344 -- start
    var beaconSettings : [BeaconDetails]?
    //ENGAGE0011344 -- End
    
    //Added by kiran V2.5 --ENGAGE0011341 -- Gimbal Geo fence implementation
    //NOTE:- this functionality is not implemneted yet as of V2.5. This is still in R&D.
    //ENGAGE0011341 -- Start
    //var geofences : [CSSIGeofence]?
    //ENGAGE0011341 -- End
    
    //Added by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
    //GATHER0000606 -- Start
    var MB_AddRequestOpt_BMS : [BWOption]?
    var MB_AddRequestOpt_Events : [BWOption]?
    var MB_AddRequestOpt_Dining : [BWOption]?
    var MB_AddRequestOpt_Dining_Member : [BWOption]?
    var MB_AddRequestOpt_Golf : [BWOption]?
    var MB_AddRequestOpt_Golf_Member : [BWOption]?
    var MB_AddRequestOpt_Tennis : [BWOption]?
    var MB_AddRequestOpt_Tennis_Member : [BWOption]?
    //GATHER0000606 -- End
    //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
    //GATHER0000700 - Start
    var MB_AddRequestOpt_TennisLesson : [BWOption]?
    //GATHER0000700 - End
    
    //Added by kiran V2.8 -- ENGAGE0011784 -- added special occasions for addGuestRegVC.
    //ENGAGE0011784 -- Start
    var specialOccasion : [SpecialOccasion]?
    //ENGAGE0011784 -- End
    
    //Added by kiran V2.9 -- GATHER0001167 -- Added Golf BAL add options
    //GATHER0001167 -- Start
    var MB_AddRequestOpt_GolfLesson : [BWOption]?
    //GATHER0001167 -- End
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        memberInterest <- map["Interest"]
        //Commented by kiran V2.5 -- ENGAGE0011395 -- Settings screen implementation change
        //ENGAGE0011395 -- Start
        //settingsList <- map["Settings"]
        //ENGAGE0011395 -- End
        shareUrlList <- map["ShareUrl"]
        mbEventRegType <- map["MB_Events_RegisterMemberType"]
        guestNumberOfDays <- map["GuestNumberOfDays"]
        states <- map["States"]
        relation <- map["GuestRelation"]
        dateSort <- map["DateSort"]
        relationFilter <- map["RelationFilter"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        weeks <- map["Week"]
        days <- map["Day"]
        calendarSort <- map["CalenderSortFilter"]
        boardofGovernors <- map["BoardofGovernors"]
        clubNewsRotation <- map["ClubNewsRotationValue"]
        prefix <- map["Prefix"]
        sufix <- map["Suffix"]
        allMarkettingOptions <- map["AllMarketingOption"]
        sendStatementsTo <- map["AddressType"]
        remainderTime <- map["ReminderTime"]
        eventRegMemberOnly <- map["MB_Events_RegisterMemberType_MemberOnly"]
        selectionDayType <- map["TennisRequestType"]
        duration <- map["Duration"]
        golfGameType <- map["GolfGameType"]
        guestType <- map["GuestType"]
        golfLeagues <- map["GolfLeagues"]
        linkToWebSiteFontSize <- map["LinkToWebSiteFontSize"]
        registerMultiMemberType <- map["RegisterMultiMemberType"]
        eventStatusFilter <- map["AppEventStatusFilter"]
        CancelPopImageList <- map["CancelPopImageLList"]
        
        EventKidInstruction <- map["EventKidInstruction"]
        DirectoryMemberKidInstruction <- map["DirectoryMemberKidInstruction"]
        DirectoryBuddyKidInstruction <- map["DirectoryBuddyKidIsntruction"]
        EventGuestInstruction <- map["EventGuestInstruction"]
        DirectoryMemberGuestInstruction <- map["irectoryMemberGuestInstruction "]
        DirectoryBuddyGuestInstruction <- map["DirectoryBuddyGuestInstruction"]
        EventGuestKidInstruction <- map["EventGuestKidInstruction"]
        DirectoryMemberGuestKidInstruction <- map["DirectoryMemberGuestKidInstruction"]
        DirectoryBuddyGuestKidInstruction <- map["DirectoryBuddyGuestKidInstruction"]
        ReservationsInstruction <- map["ReservationsInstruction"]
        DiningEventInstruction <- map["DiningEventInstruction"]
        MemberOnlyEventInstruction <- map["MemberOnlyEventInstruction"]
        
        PrivacyPolicy <- map["PrivacyPolicy"]
        TermsofUse <- map["TermsofUse"]
        
         genderOptions <- map["Gender"]
        //Added on 4th September 2020 V2.3
        self.guestGender <- map["GuestGender"]
        
        //added on 9th October 2020 V2.3
        self.MB_Dining_RegisterMemberType_MemberOnly <- map["MB_Dining_RegisterMemberType_MemberOnly"]
        self.MB_Dining_RegisterMemberType <- map["MB_Dining_RegisterMemberType"]
        
        //Added on 12th October 2020 V2.3
        self.giftCertificateCardType <- map["GiftCertificateCardType"]
        self.giftCertificateStatus <- map["GiftCertificateStatus"]
        self.GiftCardPdf <- map["GiftCardPdf"]
        
        //Added on 28th October 2020 V2.3 -- GATHER0000176
        self.fitnessSettings <- map["FitnessSettings"]
        self.appFitnessMenu <- map["AppFitnessMenu"]
        
        //Added by kiran V2.5 --ENGAGE0011344 -- Gimbal Integration
        //ENGAGE0011344 -- start
        self.beaconSettings <- map["BeaconSetting"]
        //ENGAGE0011344 -- End
        
        //Added by kiran V2.5 --ENGAGE0011341 -- Gimbal Geo fence implementation
        //NOTE:- this functionality is not implemneted yet as of V2.5. This is still in R&D.
        //ENGAGE0011341 -- Start
        //self.geofences <- map["GeofencingList"]
        //ENGAGE0011341 -- End
        
        //Added by kiran V2.5 -- GATHER0000606 -- Changing the add member popup options from one single array for all the reservations/Events to individual options array per department
        //GATHER0000606 -- Start
        self.MB_AddRequestOpt_BMS <- map["MB_AddRequestOpt_BMS"]
        self.MB_AddRequestOpt_Events <- map["MB_AddRequestOpt_Events"]
        self.MB_AddRequestOpt_Dining <- map["MB_AddRequestOpt_Dining"]
        self.MB_AddRequestOpt_Dining_Member <- map["MB_AddRequestOpt_Dining_Member"]
        self.MB_AddRequestOpt_Golf <- map["MB_AddRequestOpt_Golf"]
        self.MB_AddRequestOpt_Golf_Member <- map["MB_AddRequestOpt_Golf_Member"]
        self.MB_AddRequestOpt_Tennis <- map["MB_AddRequestOpt_Tennis"]
        self.MB_AddRequestOpt_Tennis_Member <- map["MB_AddRequestOpt_Tennis_Member"]
        //GATHER0000606 -- End
        
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
        //GATHER0000700 - Start
        self.MB_AddRequestOpt_TennisLesson <- map["MB_AddRequestOpt_TennisLesson"]
        //GATHER0000700 - End
        
        //Added by kiran V2.8 -- ENGAGE0011784 -- added special occasions for addGuestRegVC.
        //ENGAGE0011784 -- Start
        self.specialOccasion <- map["SpecialOccasion"]
        //ENGAGE0011784 -- End
        
        //Added by kiran V2.9 -- GATHER0001167 --
        //GATHER0001167 -- Start
        self.MB_AddRequestOpt_GolfLesson <- map["MB_AddRequestOpt_GolfLesson"]
        //GATHER0001167 -- End
    }
    
}

class Instruction : NSObject, Mappable
{
    var image : String?
    var instruction : String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        image <- map["File"]
        instruction <- map["Text"]
    }
}

class MemberDictInterest: NSObject, Mappable  {
    
    var interestID: Int?
    var interest: String?
  
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        interestID <- map["InterestID"]
        interest <- map["Interest"]
     
        
        
        
    }
    
}

class ReminderTime: NSObject, Mappable  {
    
    var reminderID: Int?
    var name: String?
    
    
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        reminderID <- map["ReminderId"]
        name <- map["Name"]
        
        
        
        
    }
    
}
class RegisterType: NSObject, Mappable  {
    
    var memberTypeID: Int?
    var name: String?
    
    
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        memberTypeID <- map["MemberTypeId"]
        name <- map["Name"]
        
        
        
        
    }
    
}

class SettingList: NSObject, Mappable
{
    
    var settingID: Int?
    var name: String?
    
    convenience required init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        settingID <- map["SettingId"]
        name <- map["Name"]
    }
    
}

class ShareURL: NSObject, Mappable  {
    
    var shareURLID: Int?
    var name: String?
    var url: String?

    
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        shareURLID <- map["ShareUrlId"]
        name <- map["Name"]
        url <- map["Url"]

        
        
        
    }
    
}
class States: NSObject, Mappable  {
    
    var stateId: String?
    var stateName: String?
    
    
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        stateId <- map["StateID"]
        stateName <- map["StateName"]
        
        
        
        
    }
    
}


class GuestRelation: NSObject, Mappable  {
    
    var relation: String?
    var relationname: String?
    
    
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        relation <- map["Relation"]
        relationname <- map["RelationName"]
        
        
        
        
    }
    
}
class RelationFilter: NSObject, Mappable  {
    
    var relationID: String?
    var relationName: String?
    
    
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        relationID <- map["RelationID"]
        relationName <- map["RelationName"]
        
        
        
        
    }
    
}
class DateSort: NSObject, Mappable  {
    
    var id: String?
    var name: String?
    
    
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["DateSortID"]
        name <- map["DateSortName"]
        
        
        
        
    }
    
}

class EventStatusFilter : NSObject , Mappable
{
    var id: String?
    var name: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["Value"]
        self.name <- map["Name"]
    }
}

class Week: NSObject, Mappable  {
    
    var weak: String?
    var weakID: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        weak <- map["Week"]
        weakID <- map["WeekID"]
        }
    
}
class Day: NSObject, Mappable  {
    
    var day: String?
    var dayID: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        day <- map["Day"]
        dayID <- map["DayID"]
    }
    
}

class BoardofGovernors: NSObject, Mappable  {
    
    var url: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        url <- map["BoardofGovenerPDF"]
    }
    
}
class ClubNewsRotationValue: NSObject, Mappable  {
    
    var value: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        value <- map["VALUE"]
    }
    
}

class Prefix: NSObject, Mappable  {
    
    var prefix: String?
    var prefixID: String?
    
    
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        prefix <- map["Prefix"]
        prefixID <- map["PrefixID"]
        
        
        
        
    }
    
}
class Suffix: NSObject, Mappable  {
    
    var sufix: String?
    var sufixID: String?
    
    
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        sufix <- map["Suffix"]
        sufixID <- map["SuffixID"]
        
        
        
        
    }
    
}

class AddressTypes: NSObject, Mappable  {
    
    var addressTypeID: String?
    var text: String?
    var value: String?

    
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        addressTypeID <- map["AddressTypeID"]
        text <- map["Text"]
        value <- map["Value"]

        
        
        
    }
    
}


class AllMarkettingOtions: NSObject, Mappable  {
    
    var emailGroupName: String?
    var ID: String?
    
    
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        emailGroupName <- map["EmailGroupName"]
        ID <- map["ID"]
        
        
        
        
    }
    
}
class SelectionDayType: NSObject, Mappable  {
    
    var name: String?
    var tennisRequestTypeId: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["Name"]
        tennisRequestTypeId <- map["TennisRequestTypeId"]
        
        
        
        
    }
    
}


class DurationType: NSObject, Mappable  {
    
    var name: String?
    var durationId: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["Name"]
        durationId <- map["DurationId"]
        
        
   
        
        
    }
    
}
class GolfGameType: NSObject, Mappable  {
    
    var name: String?
    var golfGameTypeId: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["Name"]
        golfGameTypeId <- map["GolfGameTypeId"]
        
    }
    
}
class GuestType: NSObject, Mappable  {
    
    var name: String?
    var guestTypeId: String?
    //Added by kiran V3.0 -- ENGAGE0011843 -- Gold card changes.
    //ENGAGE0011843 -- Start
    ///Display name of the type.
    var text : String?
    ///ID of the type
    var value : String?
    //ENGAGE0011843 -- End
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["Name"]
        guestTypeId <- map["GuestTypeId"]
        
        //Added by kiran V3.0 -- ENGAGE0011843 -- Gold card changes.
        //ENGAGE0011843 -- Start
        self.text <- map["TEXT"]
        self.value <- map["VALUE"]
        //ENGAGE0011843 -- End
        
    }
    
}

class GolfLeagues: NSObject, Mappable  {
    
    var text: String?
    var url: String?
    var value: String?

    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        text <- map["Text"]
        url <- map["URL"]
        value <- map["Value"]
    }
    
}

class CancelPopImage : NSObject, Mappable{
    
    var imageURL : String?
    var value : String?
    convenience required init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map: Map) {
        
        imageURL <- map["ImageUrl"]
        value <- map["Value"]
    }
}


//Added on 4th June 2020 BMS
///Each filter data. display name and ID
class FilterOption : NSObject , Mappable
{
    ///Display Name
    var name : String?
    ///Value
    var Id : String?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        name <- map["Text"]
        Id <- map["Value"]
    }
    
    
}

//Added on 4th September 2020 BMS
class GuestGender : NSObject , Mappable
{
    ///Display Name
    var name : String?
    ///Value
    var Id : String?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        name <- map["Text"]
        Id <- map["Value"]
    }
    
}

 
//Added on 12th October 2020 V2.3
///Options data. display name and ID
class BWOption : NSObject , Mappable
{
    ///Display Name
    var name : String?
    ///Value
    var Id : String?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        name <- map["Text"]
        Id <- map["Value"]
    }
    
    
}


//Added on 28th October 2020 V2.3 -- GATHER0000176
class HamburgerMenu :  NSObject , Mappable
{
    ///Display Name
    var name : String?
    ///Value
    var Id : String?
    
    var icon : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.name <- map["Text"]
        self.Id <- map["Value"]
        self.icon <- map["Icon3x"]
    }
    
}

//Added by kiran V2.8 -- ENGAGE0011784 -- added special occasions for addGuestRegVC.
//ENGAGE0011784 -- Start
class SpecialOccasion : NSObject, Mappable
{
    ///Display Name
    var name : String?
    ///Value
    var Id : Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.name <- map["Name"]
        self.Id <- map["SpecialOccasionId"]
    }
}
//ENGAGE0011784 -- End
