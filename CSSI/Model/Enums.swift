//
//  Enums.swift
//  CSSI
//
//  Created by Kiran on 14/01/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation

/**Used to show Instructions for calender of events*/
enum EventType
{
    /**Member Only Event*/
    case member_Only
    /**Member And Kid Only Event*/
    case member_Kid
    /**Member and Guest Only Event*/
    case member_Guest
    /**Member, Kid and guest Event*/
    case member_Kid_Guest
    
    case none
}

/**Used to identify from where cancel is clicked*/
enum CancelCategory : String
{
    //Note:- any change in this enum should also be done in CancelPopUpViewController and NewSuccessUpdateView also. other wise system wil behave wierdly
    case GolfReservation
    case TennisReservation
    case DiningReservation
    case DiningEvent
    case DiningSpecialEvent
    case Events
    case GuestCard
    case RemoveBuddy
    case RemoveGroup
    case fitnessSpa
    //Added by kiran V2.9 -- GATHER0001167 -- Added Golf BAL and tennis BAL keys. These are used in cancel and success popup of BMS
    //GATHER0001167 -- Start
    case tennisBookALesson = "Tennis_BookALesson"
    case golfBookALesson = "Golf_BookALesson"
    case BMS
    //GATHER0001167 -- End
}

/// Type of requests that can be made event/reservation
enum RequestType
{
    case event
    case reservation
}


enum FileType : String
{
    case file = "File"
    case videoURL = "video url"
    case businessURL = "BusinessUrl"
}

//Added on 14th May 2020 v2.1
///Indicates the type of file to be displayed
enum MediaType : String {
    case image = "Image"
    case video = "Video"
    case content = "Content"
}

///Indicates which content is being shared
enum ShareContentType
{
    case clubNews
    case events
    case none
}

///View news view controller is used to show news and images as well.This indicates which should be shown
enum ViewNewsType
{
    case clubNews
    case image
}

//Added on 22nd May 2020 BMS

enum BMSRequestScreen : String
{
    case departments = "Departments"
    case serviceType = "ServiceClass"
    case providers = "Provider"
    case services = "Service"
    case requestScreen = "PreferredTime"
    case none = ""
}

//Added on 4th June 2020
///Filter Types
enum FilterType
{
    case Gender
    //Added on 23rd September 2020 V2.3
    case Status
}

//Added on 15th June 2020
///Indicates the type of request screen i.e., Request or Modify
enum RequestScreenType {
    case request
    case modify
    case view
}

///Identifies if the member selection is for single or group request
enum MemberSelectionType : String
{
    case single = "Single"
    //Check if the group string is accepted by server
    case group = "Group"
}

//Added on 18th June 2020
///Identifies the the type of reqeust in my calender - my Tab
enum CalendarRequestType : String
{
    case events = "1"
    case reservations = "2"
    case BMS = "3"
}

//Added on 4th July 2020 V2.2
///Defines the Access level of user
enum AccessType : String
{
    ///Full Access
    case allowed = "Allowed"
    ///View only Access
    case view = "View Access"
    ///Access denied
    case notAllowed = "Not Allowed"
}

//Added on 4th July 2020 V2.2
///Modules available in Application
///
/// SACode function retuens the hardcoded SACode. each module enum is assigned the respective MenuValue returned from getIcons Api.
enum SAModule : String
{
    case login
    case profile
    case notifications
    case viewNews
    case calendarOfEvents = "MB_CALENDAREVENT"
    case diningReservation = "MB_DINNING"
    case golfReservation = "MB_GOLF"
    case tennisReservation = "MB_TENNIS"
    case fitnessSpaAppointment = "MB_FITNESSNSPA"
    case giftCard = "MB_GIFTCARD"
    case guestCard = "MB_GUESTCARD"
    case statements = "MB_STATMENT"
    case importantClubNumbers = "MB_CLUBNUMBER"
    case memberDirectory = "MB_MEMBERDIRECTORY"
    case todayAtGlance = "MB_TODAYGLANCE"
    case memberID = "MB_MEMBERID"
    //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
    //GATHER0000700 - Start
    case tennisBookALesson = "MBAPP_TENNISBOOKALESSON"
    //GATHER0000700 - End
    
    //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments.
    //ENGAGE0011652 -- Start
    case fitnessAppointments = "MBAPP_FITNESSAPPOINTMENTS"
    case spaAppointments = "MBAPP_SPAAPPOINTMENTS"
    case salonAppointments = "MBAPP_SALONAPPOINTMENTS"
    //ENGAGE0011652 -- End
    
    //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL roles and privilages key
    //GATHER0001167 -- Start
    case golfBookALesson = "MBAPP_GOLFBOOKALESSON"
    //GATHER0001167 -- End
    
    func SACode() -> String?
    {
        switch self {
        case .login:
            return "MBAPP_LOGIN"
        case .profile:
            return "MBAPP_PROFILE"
        case .notifications:
            return "MBAPP_NOTIFICATIONS"
        case .viewNews :
            return "MBAPP_VIEWNEWS"
        case .calendarOfEvents :
            return "MBAPP_CALENDAROFEVENTS"
        case .diningReservation:
            return "MBAPP_DININGRESERVATIONS"
        case .golfReservation:
            return "MBAPP_GOLFRESERVATIONS"
        case .tennisReservation:
            return "MBAPP_TENNISRESERVATIONS"
        case .fitnessSpaAppointment:
            return "MBAPP_FITNESSSPAAPPOINTMENTS"
        case .giftCard:
            return "MBAPP_GIFTCARD"
        case .guestCard:
            return "MBAPP_GUESTCARD"
        case .statements:
            return "MBAPP_STATEMENTS"
        case .importantClubNumbers:
            return "MBAPP_IMPORTANTNUMBERS"
        case .memberDirectory :
            return "MBAPP_MEMBERDIRECTORY"
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson SACode access level
        //GATHER0000700 - Start
        case .tennisBookALesson:
            return "MBAPP_TENNISBOOKALESSON"
        //GATHER0000700 - End
        
        //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments.
        //ENGAGE0011652 -- Start
        case .fitnessAppointments:
            return "MBAPP_FITNESSAPPOINTMENTS"
        case .spaAppointments:
            return "MBAPP_SPAAPPOINTMENTS"
        case .salonAppointments:
            return "MBAPP_SALONAPPOINTMENTS"
        //ENGAGE0011652 -- End
        
        //Added by kiran v2.9 -- GATHER0001167 -- Roles and privalages key for Golf BAL
        //GATHER0001167 -- Start
        case .golfBookALesson:
            return "MBAPP_GOLFBOOKALESSON"
        //GATHER0001167 -- End
        default :
            return nil
        }
        
    }

}

//Added on 8th July 2020 V2.2
///Reason why date is unavailable
enum UnavailableReason : Int
{
    case provider = 1
    case service = 2
}

//TODO:- Remove once geo fence is finilized
enum GeofenceID : String
{
    case enterance = "com.bocawest.enterance"
    case officeEnterance = "come.bocawest.officeEnterance"
}


//Added on 5th September 2020 V2.3
///Indicates add geust screen type
enum GuestScreenType
{
    case add
    case modify
    case view
}

//Added on 15th October 2020 V2.3
///Indicates the sync to calendar screen time
enum SyncScreenType
{
    case syncToCalendar
    case details
}

//Added on 20th October 2020 V2.4
///Indicates the style of the button
enum ButtonStyle
{
    case contained
    case outlined
}

//Added on 23rd October 2020 V2.4 -- GATHER0000176
enum FitnessScreenType : String
{
    case goals = "Goals"
    case challenges = "Challenges"
    case videos = "Videos"
}

//Added on 29rd October 2020 V2.4 --ENGAGE0011226
enum ButtonKind
{
    case primary
    case secondary
    case alert
}

//Added by Kiran V2.5 -- ENGAGE0011395 -- Settings screen IDs
enum SettingsKeys : String
{
    case fingerPrint = "FingerPrintRecognition"
    case faceID = "FaceIDRecognition"
    case appNotifications = "AllowAppNotifications"
    case contactsToPhone = "AddContactstoPhone"
    case syncCalendar = "SyncCalendar"
    case shareImage = "ShareImage"
    case gimbalService = "GimbalService"
}

//Modified by kiran V2.5 -- GATHER0000606 -- Ids to identify which option selected to add member/guest to a request. 
//GATHER0000606 -- Start
///Ids (value) for member add options in requests and events
enum AddRequestIDS : String
{
    case member = "Member"
    case guest = "Guest"
    case myBuddies = "MyBuddies"
}
//GATHER0000606 -- End

//Added by Kiran V2.7 -- GATHER0000700 -- Book a lesson changes
//GATHER0000700 - Start
///Indicates which department BMS request is made.
enum BMSDepartment : String
{
    case fitnessAndSpa = "FitnessAndSpa"
    case tennisBookALesson = "Tennis_BookALesson"
    //Added by kiran V2.9 -- GATHER0001167 -- Added Golf BAL key.
    //GATHER0001167 -- Start
    case golfBookALesson = "Golf_BookALesson"
    //GATHER0001167 -- End
    //This case will not occur. only happens if data is not passed correctly while development
    case none = ""
}

///Indicates they type of history. reservation history or Book A Lesson History or etc..
enum HistoryType : String
{
    case reservation = "1"
    case bookALesson = "2"
}
//GATHER0000700 - End


//Added by kiran V2.8 -- ENGAGE0011784 --
//ENGAGE0011784 -- Start
//Used to identify the screen is used form which module.
//Note:- when a new module is added search the project where appmodules is used. Adding a new BMS department will need change in logic in may areas of the code.
enum AppModules : String
{
    case events
    case diningEvents
    case golf
    case tennis
    case dining
    case fitnessSpa
    case bookALessonTennis
    //Added by kiran V2.9 -- GATHER0001167 -- Added Golf BAL
    //GATHER0001167 -- Start
    case bookALessonGolf
    //GATHER0001167 -- End
    //This is used where a commom functionality is implemented for fitnessSpa and bookALessonTennis or any more BMS modules we add in future.
    case BMS
}
//ENGAGE0011784 -- End

//Added by kiran V2.8 -- ENGAGE0011784 --
//ENGAGE0011784 -- Start
///Used to identify the member type i.e., Member, addGuest or existing guest
enum MemberType
{
    //This indicated both members/guddies.
    case member
    case guest
    //This is similar to member.
    case existingGuest
}
//ENGAGE0011784 -- End


//Added by kiran V2.9 -- ENGAGE0011722 -- Apple wallet functionality
//ENGAGE0011722 -- Start
enum PassFeatureError
{
    ///Indicated that liberary is not available
    case libraryNotAvailable
    ///Indicates that device cannot add pass
    case deviceCantAdd
}

enum PassManagerError
{
    case userDenied
    case errorGeneratingPass
    case errorReplacingFile
    case passDoesntExist
}
//ENGAGE0011722 -- End

//Added by kiran v2.9 -- Cobalt Pha0010644 -- Function to show Hard & Soft message details of courses when date is changed
//Cobalt Pha0010644 -- Start
///Every Course can be blocked for future requests and user is allowed to request that course or not based on the type of alert. These indicate th types of alert
enum GolfCourseAlertType
{
    ///Golf Court is restricted  and user is allowed to reqeust if they accept the alert
    case soft
    ///User  is not allowed to request
    case hard
    ///Golf Court is not restricted.
    case none
}
//Cobalt Pha0010644 -- End

//Added by kiran V2.9 -- ENGAGE0012323 -- Implementing App tracking Transperency changes
//ENGAGE0012323 -- Start
enum BeaconPermissions
{
    case bluetooth
    case location
    case appTracking
}
//ENGAGE0012323 -- End

//Added by kiran V3.0 -- ENGAGE0011722 -- Pass error codes
//ENGAGE0011722 -- Start
enum PassErrorCodes : Int
{
    case addingError = 100050
}
//ENGAGE0011722 -- End

//Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
//PROD0000069 -- Start
enum EventNavigatedFrom
{
    case clubNews
    case dashboard
    case fitnessSpa
    case golf
    case tennis
    case dining
}
//PROD0000069 -- End

// Added by Zeeshan
enum GolfRequestType : String
{
    case lottery = "Lottery request"
    case fcfs = "FCFS Request"
}

enum TransportType : Int
{
    case wlk = 10018
    case mct = 10019
    case ct = 10020
}

