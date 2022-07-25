//
//  DiningRS.swift
//  CSSI
//
//  Created by apple on 11/22/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation

struct DiningRS: Codable {
    let upComingEvent: [UpComingDining]
    let clubNews: [RecentNewsDining]
    let importantContacts: [ImportantContactDining]
    let hostAnEvent: [HostEventDining]
    let instructionalVideos: [InstructionalVideoDining]
    let dressCode: [DressCodeDining]
    let responseCode, responseMessage: String
    
    enum CodingKeys: String, CodingKey {
        case upComingEvent = "UpComingEvent"
        case clubNews = "ClubNews"
        case importantContacts = "ImportantContacts"
        case hostAnEvent = "HostanEvent"
        case instructionalVideos = "InstructionalVideos"
        case dressCode = "DressCode"
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
    }
}

struct UpComingDining: Codable
{
    let image: String
    let imgthumb: String

    //Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for email to, external registerations, golf genious, No regterations and confirmes state.
    //PROD0000069 -- Start
    var eventCategory : String?
    var isMemberTgaEventNotAllowed: Int?
    var eventID: String?
    var isMemberCalendar: Int?
    var requestID: String?
    var eventRegistrationDetailID: String?
    var enableRedirectClubNewsToEvents : Int?
    var eventValidationMessage : String?
    var eventName: String?
    var eventstatus: String?
    var externalURL: String?
    var colorCode: String?
    var buttontextvalue: String?
    //PROD0000069 -- End
    
    enum CodingKeys: String, CodingKey
    {
        case image = "ImageLarge"
        case imgthumb = "ImageThumb"
        //Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for email to, external registerations, golf genious, No regterations and confirmes state.
        //PROD0000069 -- Start
        case eventCategory = "EventCategory"
        case isMemberTgaEventNotAllowed = "IsMemberTgaEventNotAllowed"
        case eventID = "EventID"
        case isMemberCalendar = "IsMemberCalendar"
        case requestID = "RequestID"
        case eventRegistrationDetailID = "EventRegistrationDetailID"
        case enableRedirectClubNewsToEvents = "EnableRedirectClubNewsToEvents"
        case eventValidationMessage = "EventValidationMessage"
        case eventName = "EventName"
        case eventstatus = "EventStatus"
        case externalURL = "ExternalURL"
        case colorCode = "ColorCode"
        case buttontextvalue = "ButtonTextValue"
        //PROD0000069 -- End
    }
}

struct RecentNewsDining: Codable {
    let id, newsTitle, date, description: String
    let newsImage: String
    let newsVideoURL, departmentName, author: String
    let newsImageList : [ImageData]
    //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
    //PROD0000069 -- Start
    var eventCategory : String?
    var isMemberTgaEventNotAllowed: Int?
    var eventID: String?
    var isMemberCalendar: Int?
    var requestID: String?
    var eventRegistrationDetailID: String?
    var enableRedirectClubNewsToEvents : Int?
    var eventValidationMessage : String?
    //PROD0000069 -- End
    //Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for email to, external registerations, golf genious, No regterations and confirmes state.
    //PROD0000069 -- Start
    var eventName: String?
    var eventstatus: String?
    var externalURL: String?
    var colorCode: String?
    var buttontextvalue: String?
    //PROD0000069 -- End
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case newsTitle = "NewsTitle"
        case date = "Date"
        case description = "Description"
        case newsImage = "NewsImage"
        case newsVideoURL = "NewsVideoUrl"
        case departmentName = "DepartmentName"
        case author = "Author"
        case newsImageList = "NewsImageList"
        //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
        //PROD0000069 -- Start
        case eventCategory = "EventCategory"
        case isMemberTgaEventNotAllowed = "IsMemberTgaEventNotAllowed"
        case eventID = "EventID"
        case isMemberCalendar = "IsMemberCalendar"
        case requestID = "RequestID"
        case eventRegistrationDetailID = "EventRegistrationDetailID"
        case enableRedirectClubNewsToEvents = "EnableRedirectClubNewsToEvents"
        case eventValidationMessage = "EventValidationMessage"
        //PROD0000069 -- End
        //Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for email to, external registerations, golf genious, No regterations and confirmes state.
        //PROD0000069 -- Start
        case eventName = "EventName"
        case eventstatus = "EventStatus"
        case externalURL = "ExternalURL"
        case colorCode = "ColorCode"
        case buttontextvalue = "ButtonTextValue"
        //PROD0000069 -- End
    }
}

struct ImportantContactDining: Codable {
    let displayName, activity: String
    let icon, icon2X, icon3X: String
    
    enum CodingKeys: String, CodingKey {
        case displayName = "DisplayName"
        case activity = "Activity"
        case icon = "Icon"
        case icon2X = "Icon2x"
        case icon3X = "Icon3x"
    }
}
struct HostEventDining: Codable {
    let displayName, activity, email, phone: String
    let icon, icon2X, icon3X: String
    
    enum CodingKeys: String, CodingKey {
        case displayName = "DisplayName"
        case activity = "Activity"
        case email = "EmailID"
        case phone = "PhoneNumber"
        case icon = "Icon"
        case icon2X = "Icon2x"
        case icon3X = "Icon3x"
    }
}

struct InstructionalVideoDining: Codable {
    let title: String
    let imageThumbnail: String
    let videoURL: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case imageThumbnail = "ImageThumbnail"
        case videoURL = "VideoUrl"
    }
}
struct DressCodeDining: Codable {
    let title: String
    let dressCodeID: String
    let URL: String
    
    enum CodingKeys: String, CodingKey {
        case dressCodeID = "DressCodeID"
        case title = "Title"
        case URL = "FilePath"
    }
}
