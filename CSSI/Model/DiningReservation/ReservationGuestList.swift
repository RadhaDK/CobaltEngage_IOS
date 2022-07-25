//
//  ReservationGuestList.swift
//  CSSI
//
//  Created by apple on 6/2/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import Foundation



// MARK: - ReservationGuestList
struct ReservationGuestList: Codable {
    let reservationGuestList: [ReservationGuestListElement]
    let responseCode, responseMessage: String
    
    enum CodingKeys: String, CodingKey {
        case reservationGuestList = "ReservationGuestList"
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
    }
}

// MARK: - ReservationGuestListElement
struct ReservationGuestListElement: Codable
{
    //Added by kiran V2.8 -- ENGAGE0011784 -- Added first Name, Last Name , DOB and gender of Guests
    //ENGAGE0011784 -- Start
    let guestName, guestMail, guestPhone, guestType: String
    let dietaryRestriction: String
    let guestFirstName,guestLastName,guestDOB,guestGender : String

    enum CodingKeys: String, CodingKey
    {
        case guestName = "GuestName"
        case guestMail = "GuestEmail"
        case guestPhone = "GuestContact"
        case dietaryRestriction = "DietaryRestrictions"
        case guestType = "GuestType"
        case guestFirstName = "GuestFirstName"
        case guestLastName = "GuestLastName"
        case guestDOB = "GuestDOB"
        case guestGender = "GuestGender"
    }
    
    //ENGAGE0011784 -- End
}
 
