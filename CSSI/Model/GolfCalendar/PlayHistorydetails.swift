//
//  PlayHistorydetails.swift
//  CSSI
//
//  Created by apple on 4/19/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let playHistoryDetails = try? newJSONDecoder().decode(PlayHistoryDetails.self, from: jsonData)

import Foundation

struct PlayHistorydetails: Codable {
    let playHistoryDetails: [PlayHistoryDetail]
    let responseCode, responseMessage: String
    
    enum CodingKeys: String, CodingKey {
        case playHistoryDetails = "HistoryDetails"
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
    }
}

struct PlayHistoryDetail: Codable {
    let reservationRequestDetailID, captainName, group, courseName: String
    let time, gameType, confirmationNumber: String
    let date, specialRequest, comments: String
    let playerDetails: [PlayerDetail]
    
    enum CodingKeys: String, CodingKey {
        case reservationRequestDetailID = "ReservationRequestDetailId"
        case captainName = "CaptainName"
        case group = "Group"
        case courseName = "CourseName"
        case time = "Time"
        case gameType = "GameType"
        case confirmationNumber = "ConfirmationNumber"
        case date = "Date"
        case specialRequest = "SpecialRequest"
        case comments = "Comments"
        case playerDetails = "Details"
    }
}

struct PlayerDetail: Codable {
    
    let reservationRequestDetailID, name: String
    let status: Status
    
    enum CodingKeys: String, CodingKey {
        case reservationRequestDetailID = "ReservationRequestDetailId"
        case name = "Name"
        case status = "Status"
    }
}

enum Status: String, Codable {
    case noShow = "No Show"
    case played = "Played"
}
