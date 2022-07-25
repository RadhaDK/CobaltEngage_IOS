
import Foundation
import ObjectMapper


class RequestSettings: NSObject, Mappable {
    
    var golfSettings: GolfSettings?
    var tennisSettings: TennisSettings?
    var dinningSettings: DinningSettings?
    var responseCode: String?
    var responseMessage: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        
        
        golfSettings <- map["GolfSettings"]
        tennisSettings <- map["TennisSettings"]
        dinningSettings <- map["DinningSettings"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
}

class DinningSettings: NSObject, Mappable  {
    
    var spaceID, spaceType: String?
    var minDaysInAdvance, maxDaysInAdvance: Int?
    var minDaysInAdvanceTime, maxDaysInAdvanceTime, fromTime, toTime: String?
    var timeIntervalHours, timeIntervalMinutes, maxPartySizePanache, maxPartySizeMyPi: Int?
    var maxPartySizePrimeCut: Int?
    var restaurantDetails: [RestaurantSettingsDetail]?
    var timeInterval, guest: Int?
    var diningURl: String?
    var gETDATETIME: String?

    //Added on 8th October 2020
    var isAllowGuest : Int?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        spaceID <- map["SpaceId"]
        spaceType <- map["SpaceType"]
        minDaysInAdvance <- map["MinDaysInAdvance"]
        maxDaysInAdvance <- map["MaxDaysInAdvance"]
        minDaysInAdvanceTime <- map["MinDaysInAdvanceTime"]
        maxDaysInAdvanceTime <- map["MaxDaysInAdvanceTime"]
        timeIntervalHours <- map["TimeIntervalHours"]
        timeIntervalMinutes <- map["TimeIntervalMinutes"]
        maxPartySizePanache <- map["MaxPartySize_Panache"]
        maxPartySizeMyPi <- map["MaxPartySize_MyPi"]
        maxPartySizePrimeCut <- map["MaxPartySize_PrimeCut"]
        restaurantDetails <- map["RestaurantDetails"]
        fromTime <- map["FromTime"]
        toTime <- map["ToTime"]
        timeInterval <- map["TimeIntervalMinutes"]
        diningURl <- map["DinningPolicy"]
        gETDATETIME <- map["GETDATETIME"]
        guest <- map["Guest"]
        
        self.isAllowGuest <- map["IsAllowGuest"]

    }
}
class RestaurantSettingsDetail: NSObject, Mappable  {
    
    
    var id, restaurantName, time: String?
    var restauranImage: String?
    var preferenceType: String?
    var maxPartysize, specialEvent, isEffectivityChanged, isRegistered : Int?
    var tablePreferences: [TablePreferencesType]?
    var openTime, closeTime, eventID, validationMessage: String?
    
    //Added on 7th October 2020
    var timeSetup : [DiningTimeSettings]?
    
    convenience required init?(map: Map) {
        self.init()
    }
 
    func mapping(map: Map) {
        validationMessage <- map["ValidationMessage"]
        eventID <- map["EventID"]
        specialEvent <- map["SpecialEvent"]
        isRegistered <- map["IsRegistered"]
        id <- map["ID"]
        restaurantName <- map["RestaurantName"]
        time <- map["Time"]
        restauranImage <- map["RestauranImage"]
        preferenceType <- map["PreferenceType"]
        tablePreferences <- map["TablePreferences"]
        maxPartysize <- map["MaxPartySize"]
        openTime <- map["OpenTime"]
        closeTime <- map["CloseTime"]
        isEffectivityChanged <- map["IsEffectivityChanged"]

        self.timeSetup <- map["TimeSetup"]
    }
    
}

class TablePreferencesType: NSObject, Mappable  {
    
    
    var preferenceName: String?
    var tablePreferenceID: String?
    convenience required init?(map: Map) {
        self.init()
    }
    
    
    
    
    func mapping(map: Map) {
        preferenceName <- map["PreferenceName"]
        tablePreferenceID <- map["TablePreferenceID"]
    }
    
}
class GolfSettings: NSObject, Mappable  {
    
    var spaceType: String?
    var minDaysInAdvance: Int?
    var minDaysInAdvanceTime: String?
    var minGroupReserv: Int?
    var minSingleGroupPlayers: Int?
    var maxSingleGroupPlayers: Int?
    var maxDaysInAdvance: Int?
    var maxDaysInAdvanceTime: String?
    var maxGroupReserv: Int?
    var minMultiGroupPlayers: Int?
    var maxMultiGroupPlayers: Int?
    var courseDetails: [CourseSettingsDetail]?
    var fromTime: String?
    var toTime: String?
    var timeInterval: Int?
    var golfPolicy: String?
    var memberFromTime: String?
    var timeIntervalHours: Int?
    var gETDATETIME: String?
    // Added by Zeeshan May 11 2022
    var isFCFSGolfRequestEnable: Bool?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        golfPolicy <- map["GolfPolicy"]
        spaceType <- map["SpaceType"]
        minDaysInAdvance <- map["MinDaysInAdvance"]
        minDaysInAdvanceTime <- map["MinDaysInAdvanceTime"]
        minGroupReserv <- map["MinGroupReserv"]
        minSingleGroupPlayers <- map["MinSingleGroupPlayers"]
        maxSingleGroupPlayers <- map["MaxSingleGroupPlayers"]
        maxDaysInAdvance <- map["MaxDaysInAdvance"]
        maxDaysInAdvanceTime <- map["MaxDaysInAdvanceTime"]
        maxGroupReserv <- map["MaxGroupReserv"]
        minMultiGroupPlayers <- map["MinMultiGroupPlayers"]
        maxMultiGroupPlayers <- map["MaxMultiGroupPlayers"]
        courseDetails <- map["CourseDetails"]
        fromTime <- map["FromTime"]
        toTime <- map["ToTime"]
        timeInterval <- map["TimeIntervalMinutes"]
        memberFromTime <- map["MemberFromTime"]
        timeIntervalHours <- map["TimeIntervalHours"]
        gETDATETIME <- map["GETDATETIME"]
        // Added by Zeeshan May 11 2022
        isFCFSGolfRequestEnable <- map["IsFCFSGolfRequestEnable"]
    }
    
}


class CourseSettingsDetail: NSObject, Mappable  {
    
    var id, courseName: String?
    var courseImage,courseImage1,courseImage2: String?
    var preferenceType: String?
    
    //Added by kiran V2.9 - Cobalt Pha0010644 - Preferred crouse soft and hard stop change
    //Cobalt Pha0010644 -- Start
    var golfCourseAlert: [CourseAlertDetail]?
    //Cobalt Pha0010644 -- End
    
    // Added by Zeeshan
    var scheduleType: String?
    var displayType: Int?
    var timeIntervals: [GolfTimeInterval]?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        id <- map["ID"]
        courseName <- map["CourseName"]
        courseImage <- map["CourseImage"]
        courseImage1 <- map["CourseImage1"]
        courseImage2 <- map["CourseImage2"]
        preferenceType <- map["PreferenceType"]
        //Added by kiran V2.9 - Cobalt Pha0010644 - Preferred crouse soft and hard stop change
        //Cobalt Pha0010644 -- Start
        self.golfCourseAlert <- map["GolfCourseAlert"]
        //Cobalt Pha0010644 -- End
        self.scheduleType <- map["ScheduleType"]
        self.displayType <- map["DisplayOrder"]
        self.timeIntervals <- map["TimeIntervals"]
    }
                
}

//Added by kiran V2.9 - Cobalt Pha0010644 - Preferred crouse soft and hard stop change
//Cobalt Pha0010644 -- Start
class CourseAlertDetail: NSObject, Mappable
{
    var startTime : String?
    var endTime : String?
    var alertTitle : String?
    var isShowHardRule : Int?
    
    convenience required init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.startTime <- map["StartTime"]
        self.endTime <- map["EndTime"]
        self.alertTitle <- map["AlertTitle"]
        self.isShowHardRule <- map["IsShowHardRule"]
    }
    
    
}
//Cobalt Pha0010644 -- End


        
class TennisSettings: NSObject, Mappable  {
    
    var spaceID, spaceType: String?
    var minDaysInAdvance, maxDaysInAdvance: Int?
    var minDaysInAdvanceTime, maxDaysInAdvanceTime, fromTime, toTime: String?
    var timeIntervalHours, timeIntervalMinutes: Int?
    var timeInterval: Int?
    var tennisPolicy: String?
    var memberFromTime: String?
    var memberToTime: String?
    var gETDATETIME: String?

    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        spaceID <- map["SpaceId"]
        spaceType <- map["SpaceType"]
        minDaysInAdvance <- map["MinDaysInAdvance"]
        maxDaysInAdvance <- map["MaxDaysInAdvance"]
        minDaysInAdvanceTime <- map["MinDaysInAdvanceTime"]
        maxDaysInAdvanceTime <- map["MaxDaysInAdvanceTime"]
        timeIntervalHours <- map["TimeIntervalHours"]
        timeIntervalMinutes <- map["TimeIntervalMinutes"]
        fromTime <- map["FromTime"]
        toTime <- map["ToTime"]
        timeInterval <- map["TimeIntervalMinutes"]
        tennisPolicy <- map["TennisPolicy"]
        memberFromTime <- map["MemberFromTime"]
        memberToTime <- map["MemberToTime"]
        gETDATETIME <- map["GETDATETIME"]

        }
        
    }

//Added on 4th June 2020 BMS
///Fitness and spa BMS settngs
class BMSSettings : NSObject , Mappable
{
    var timeIntervalMinutesApp,minimumDaysinAdvace,minimumTimeinAdvace,maximumDaysinAdvace,maximumTimeinAdvace,minMembersPerAppointment,maxMembersPerAppointment,allowMemberstoAddAppointment,allowMemberstoViewAppointment,allowMemberstoModifyAppointment,allowMemberstoModiyAppointmentHrsBefore,allowMemberstoCancelAppointment,allowMemberstoCancelAppointmentHrsBefore,maxMinutesRequestAppointment,timeIntervalMinutesBackOffice : String?
    
    var allowMemberstoCancelAppointmentDayBefore,allowMemberstoModiyAppointmentDayBefore,maxAppointmentByServiceClass,app_CaptureCacellationReason,app_MemberRestictonOnProvider,app_MemberRestictonOnService,app_MemberRestictonOnServiceClass,app_ShowProviderAfterSubmit : String?
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        timeIntervalMinutesApp <- map["TimeIntervalMinutesApp"]
        minimumDaysinAdvace <- map["MinimumDaysinAdvace"]
        minimumTimeinAdvace <- map["MinimumTimeinAdvace"]
        maximumDaysinAdvace <- map["MaximumDaysinAdvace"]
        maximumTimeinAdvace <- map["MaximumTimeinAdvace"]
        minMembersPerAppointment <- map["MinMembersPerAppointment"]
        maxMembersPerAppointment <- map["MaxMembersPerAppointment"]
        allowMemberstoAddAppointment <- map["AllowMemberstoAddAppointment"]
        allowMemberstoViewAppointment <- map["AllowMemberstoViewAppointment"]
        allowMemberstoModifyAppointment <- map["AllowMemberstoModifyAppointment"]
        allowMemberstoModiyAppointmentHrsBefore <- map["AllowMemberstoModiyAppointmentHrsBefore"]
        allowMemberstoCancelAppointment <- map["AllowMemberstoCancelAppointment"]
        allowMemberstoCancelAppointmentHrsBefore <- map["AllowMemberstoCancelAppointmentHrsBefore"]
        maxMinutesRequestAppointment <- map["MaxMinutesRequestAppointment"]
        timeIntervalMinutesBackOffice <- map["TimeIntervalMinutesBackOffice"]
        allowMemberstoCancelAppointmentDayBefore <- map["AllowMemberstoCancelAppointmentDayBefore"]
        allowMemberstoModiyAppointmentDayBefore <- map["AllowMemberstoModiyAppointmentDayBefore"]
        maxAppointmentByServiceClass <- map["MaxAppointmentByServiceClass"]
        app_CaptureCacellationReason <- map["App_CaptureCacellationReason"]
        app_MemberRestictonOnProvider <- map["App_MemberRestictonOnProvider"]
        app_MemberRestictonOnService <- map["App_MemberRestictonOnService"]
        app_MemberRestictonOnServiceClass <- map["App_MemberRestictonOnServiceClass"]
        app_ShowProviderAfterSubmit <- map["App_ShowProviderAfterSubmit"]
        
    }

}


//Added on 7th October 2020
class DiningTimeSettings : NSObject,Mappable
{
    var earliestTime : [DiningTime]?
    var latestTime : [DiningTime]?
    var tablePreference : [TablePreferencesType]?
    var time : String?
    var maxPartySize : Int?
    var isRegistered : Int?
    var allowEarliestTime : Int?
    var validationMessage : String?
    var specialEvent : Int?
    var allowRequestTime : Int?
    var eventID : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.earliestTime <- map["EarliestTime"]
        self.latestTime <- map["LatestTime"]
        self.time <- map["Time"]
        self.tablePreference <- map["TablePreference"]
        self.maxPartySize <- map["MaxPartySize"]
        self.isRegistered <- map["IsRegistered"]
        self.allowEarliestTime <- map["AllowEarliestTime"]
        self.validationMessage <- map["ValidationMessage"]
        self.specialEvent <- map["SpecialEvent"]
        self.allowRequestTime <- map["AllowRequestTime"]
        self.eventID <- map["EventID"]
    }
    
}
//Added on 7th October 2020
class DiningTime : NSObject,Mappable
{
    var time : String?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.time <- map["Time"]
    }
}

// Added by Zeeshan
class GolfTimeInterval: NSObject, Mappable
{
    var borderFlag : String?
    var startingHole : String?
    var time : String?
    var teeBox : String?
    
    convenience required init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.borderFlag <- map["BorderFlag"]
        self.startingHole <- map["STARTINGHOLES"]
        self.time <- map["TIME"]
        self.teeBox <- map["TeeBox"]
    }
    
    
}
