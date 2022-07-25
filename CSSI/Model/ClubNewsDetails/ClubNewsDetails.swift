//
//  ClubNewsDetails.swift
//  CSSI
//
//  Created by apple on 10/31/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let clubNewsDetails = try? newJSONDecoder().decode(ClubNewsDetails.self, from: jsonData)

import UIKit
import Foundation
import ObjectMapper

class ClubNewsDetails : NSObject , Mappable{

    var clubNews: [AllClubNew]!
    var responseCode, responseMessage : String!

    override init() {
        super.init()
    }

    required convenience init(map : Map) {
        self.init()
    }

    func mapping(map: Map) {
        clubNews <- map["ClubNews"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }

}

class AllClubNew: NSObject , Mappable {

    var date: String!
    var clubNewsDetails: [ClubNewsDetail]!

    override init() {
        super.init()
    }

    required convenience init(map : Map) {
        self.init()
    }

     func mapping(map: Map) {
        date <- map["Date"]
        clubNewsDetails <- map["ClubNewsDetails"]
    }
}

class ClubNewsDetail : NSObject , Mappable{
    var id, newsTitle, date, descrption : String!
    var newsImage: String!
    var newsVideoURL: String!
    var departmentName, authorPretest,author: String!
    //Modified mediaDetails type from Dictionary on 14th May 2020 v2.1
    var newsImageList : [MediaDetails]?

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
    
    override init() {
        super.init()
    }

    required convenience init(map : Map) {
        self.init()
    }


     func mapping(map: Map) {
        id <- map["ID"]
        newsTitle <- map["NewsTitle"]
        date <- map["Date"]
        descrption <- map["Description"]
        newsImage <- map["NewsImage"]
        newsVideoURL <- map["NewsVideoUrl"]
        departmentName <- map["DepartmentName"]
        authorPretest <- map["AuthorPretext"]
        author <- map["Author"]
        newsImageList <- map["NewsImageList"]
        
        //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
        //PROD0000069 -- Start
        self.eventCategory <- map["EventCategory"]
       // self.requestType <- (map["Type"],EnumTransform<CalendarRequestType>())
       // self.DepartmentName <- map["DepartmentName"]
        //self.type <- map["Type"]
        self.isMemberTgaEventNotAllowed <- map["IsMemberTgaEventNotAllowed"]
        //self.buttontextvalue <- map["ButtonTextValue"]
        //self.externalURL <- map["ExternalURL"]
        //self.eventName <- map["EventName"]
        self.eventID <- map["EventID"]
        self.isMemberCalendar <- map["IsMemberCalendar"]
        self.requestID <- map["RequestID"]
        self.eventRegistrationDetailID <- map["EventRegistrationDetailID"]
        self.enableRedirectClubNewsToEvents <- map["EnableRedirectClubNewsToEvents"]
        self.eventValidationMessage <- map["EventValidationMessage"]
        //PROD0000069 -- End
        
        //Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for email to, external registerations, golf genious, No regterations and confirmes state.
        //PROD0000069 -- Start
        self.eventName <- map["EventName"]
        self.eventstatus <- map["EventStatus"]
        self.externalURL <- map["ExternalURL"]
        self.colorCode <- map["ColorCode"]
        self.buttontextvalue <- map["ButtonTextValue"]
        //PROD0000069 -- End
    }
}

//Added on 14th May 2020 v2.1

///Details of the file
class MediaDetails : NSObject , Mappable
{
    var newsImagePath,ID,newsImage : String?
    var type : MediaType?
    var sequence : Int?
    override init() {
        super.init()
    }
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        newsImagePath <- map["NewsImagePath"]
        ID <- map["ImageID"]
        newsImage <- map["NewsImage"]
        type <- (map["Type"],EnumTransform<MediaType>())
        sequence <- map["Sequence"]
    }
    
    
}


//MARK:- Codable
/*
struct ClubNewsDetails: Codable {
    let clubNews: [AllClubNew]
    let responseCode, responseMessage: String
    
    enum CodingKeys: String, CodingKey {
        case clubNews = "ClubNews"
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
    }
}

struct AllClubNew: Codable {
    let date: String
    let clubNewsDetails: [ClubNewsDetail]
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case clubNewsDetails = "ClubNewsDetails"
    }
}

struct ClubNewsDetail : Codable {
    let id, newsTitle, date, description: String
    let newsImage: String
    let newsVideoURL: String
    let departmentName, authorPretest,author: String
    let newsImages: [[String : Any]]
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case newsTitle = "NewsTitle"
        case date = "Date"
        case description = "Description"
        case newsImage = "NewsImage"
        case newsVideoURL = "NewsVideoUrl"
        case departmentName = "DepartmentName"
        case author = "Author"
        case authorPretest = "AuthorPretext"
        case newsImages = "NewsImageList"
    }
}
*/
