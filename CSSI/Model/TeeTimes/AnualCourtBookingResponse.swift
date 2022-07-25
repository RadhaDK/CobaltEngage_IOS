//
//  AnualCourtBookingResponse.swift
//  CSSI
//
//  Created by apple on 5/13/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import Foundation

struct AnualCourtBookingsResponse: Codable {
    let countBooking: [CountBooking]
    let responseCode, responseMessage: String
    
    enum CodingKeys: String, CodingKey {
        case countBooking = "GetAnnualPlayHistory"
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
    }
}

struct CountBooking: Codable {
    let year: Int
    let monthName, monthYear: String
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case year = "Year"
        case monthName = "MonthName"
        case monthYear = "MonthYear"
        case count = "Count"
    }
}
