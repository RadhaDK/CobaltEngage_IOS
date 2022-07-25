//
//  EventNavDetails.swift
//  CSSI
//
//  Created by Kiran on 01/09/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

import Foundation

//Added by kiran V1.4 --PROD0000069-- Club News - bring member to event details on click of news. Added support for email to, external registerations, golf genious, No regterations and confirmes state.
//PROD0000069 -- Start
class EventNavDetails : NSObject
{
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
}
//PROD0000069 -- End
