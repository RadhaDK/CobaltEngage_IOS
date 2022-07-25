//
//  GuestCardList.swift
//  CSSI
//
//  Created by MACMINI13 on 04/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class GuestCardList: NSObject, Mappable {
    var guestList: [GuestCard]?

    var responseCode: String?
    var responseMessage: String?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        guestList <- map["Guests"]
      
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
}

class GuestCard: NSObject, Mappable  {
    
    var guestID: String?
    var firstName: String?
    var lastName: String?
    var guestCardDetails: [GuestCardDetail]?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        guestCardDetails <- map["GuestCardDetails"]
        guestID <- map["GuestID"]
        firstName <- map["FirstName"]
        lastName <- map["LastName"]
    }
}

class GuestCardDetail: NSObject, Mappable  {
      var guestCardId: String?
    var receiptNumber: String?
    var accompanyWithMainMember: Int?
    var transactionID: String?
    var linkedMemberID: String?

  
    var startDate: String?
    var transactionDetailID: String?

    var endDate: String?
    var guestCardStatus: String?
    var modifyMessage: String?
    var cancelMessage: String?

    
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        guestCardId <- map["GuestCardID"]
        receiptNumber <- map["ReceiptNumber"]
        accompanyWithMainMember <- map["AccompanyWithMainMember"]
        transactionID <- map["TransactionID"]
        linkedMemberID <- map["LinkedMemberID"]
        startDate <- map["StartDate"]
        transactionDetailID <- map["TransactionDetailID"]
        endDate <- map["EndDate"]
        guestCardStatus <- map["Status"]
        modifyMessage <- map["ModifyMessage"]
        cancelMessage <- map["CancelMessage"]

        
        
        
    }
    
}


