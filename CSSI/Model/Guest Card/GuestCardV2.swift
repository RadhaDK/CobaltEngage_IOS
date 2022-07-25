// To parse the JSON, add this file to your project and do:
//
//   let empty = try? newJSONDecoder().decode(Empty.self, from: jsonData)

import Foundation

struct GuestListResponse: Codable {
    let guests: [Guest]
    let responseCode, responseMessage: String
    let guestDropDown: [GuestDropDown]
    
    
    enum CodingKeys: String, CodingKey {
        case guests = "Guests"
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
        case guestDropDown = "GuestDropdown"
        
    }
}

struct Guest: Codable {
    let guestID, firstName, lastName, guestMemberID: String
    let memberName: String
    //Added by kiran V3.0 -- ENGAGE0011843 -- Changed the data type to string.
    //ENGAGE0011843 -- Start
    let relation: String
    let relationName: String
    //let relation: Relation
    //let relationName: RelationName
    //ENGAGE0011843 -- End
    let fromDate, toDate, receiptNumber: String
    let accompanyWithMainMember: Int
    let guestCardID, transactionID, transactionDetailID, linkedMemberID, guestPhoto, durationPeriod, previousToDate, extendedBy: String
    
    enum CodingKeys: String, CodingKey {
        case guestID = "GuestID"
        case firstName = "FirstName"
        case lastName = "LastName"
        case guestMemberID = "GuestMemberID"
        case relation = "Relation"
        case relationName = "RelationName"
        case fromDate = "FromDate"
        case toDate = "ToDate"
        case receiptNumber = "ReceiptNumber"
        case accompanyWithMainMember = "AccompanyWithMainMember"
        case guestCardID = "GuestCardID"
        case transactionID = "TransactionID"
        case transactionDetailID = "TransactionDetailID"
        case linkedMemberID = "LinkedMemberID"
        case guestPhoto = "GuestPhoto"
        case durationPeriod = "DurationPeriod"
        case previousToDate = "PreviousToDate"
        case extendedBy = "ExtendedBy"
        case memberName = "MemberName"

    }
}

struct GuestDropDown: Codable {
    let guestID, guestName, relationDrop, relationTypeDrop: String
    
    
    enum CodingKeys: String, CodingKey {
        case guestID = "GuestID"
        case guestName = "GuestName"
        case relationDrop = "Relation"
        case relationTypeDrop = "RelationType"
    }
}

//Added by kiran V3.0 -- ENGAGE0011843 -- Commented no longer using.
//ENGAGE0011843 -- Start
/*
enum Relation: String, Codable {
    case gu = "GU"
    case of = "OF"
}

enum RelationName: String, Codable {
    case guest = "Guest"
    case offspring = "Offspring"
}
 */
//ENGAGE0011843 -- End
