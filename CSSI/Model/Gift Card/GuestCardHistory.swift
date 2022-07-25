//
//  GuestCardHistory.swift
//  CSSI
//
//  Created by Prashamsa on 29/09/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

struct GuestCardsHistoryResponse: Codable {
    let guests: [GuestBasicDetails]
    let responseCode, responseMessage: String
    
    enum CodingKeys: String, CodingKey {
        case guests = "Guests"
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
    }
}

struct GuestBasicDetails: Codable {
    let guestID, firstName, lastName, guestMemberID: String
    let guestPhoto: String
    let guestCardDetails: [GuestCardHistoryDetail]
    let relation, relationName: String
    let memberName: String

    
    enum CodingKeys: String, CodingKey {
        case guestID = "GuestID"
        case firstName = "FirstName"
        case lastName = "LastName"
        case guestMemberID = "GuestMemberID"
        case guestPhoto = "GuestPhoto"
        case guestCardDetails = "GuestCardDetails"
        case relation = "Relation"
        case relationName = "RelationName"
        case memberName = "MemberName"
    }
}

struct GuestCardHistoryDetail: Codable {
    let guestCardID, fromDate, toDate: String
    let days: Int
    
    enum CodingKeys: String, CodingKey {
        case guestCardID = "GuestCardID"
        case fromDate = "FromDate"
        case toDate = "ToDate"
        case days = "Days"
    }
}
