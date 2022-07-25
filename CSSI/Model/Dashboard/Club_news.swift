/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper
import UIKit

class ClubNews :NSObject, Mappable {
	var newsImage : String?
	var title : String?
    var date : String?
    var id : String?
    var newsDescription : String?
    var newsVideoURL : String?
    //Modified to media details type from dictionary on 14th May 2020 v2.1
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
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        newsImage <- map["NewsImage"]
        title <- map["NewsTitle"]
        date <- map["Date"]
        newsDescription <- map["Description"]
        newsVideoURL <- map["NewsVideoUrl"]
        newsImageList <- map["NewsImageList"]
        id <- map["ID"]
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
