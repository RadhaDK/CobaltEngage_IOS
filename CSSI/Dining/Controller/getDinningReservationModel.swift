//
//  getDinningReservationModel.swift
//  CSSI
//
//  Created by Aks on 19/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import ObjectMapper

class DinningReservationFCFS : NSObject, Mappable {
    
    
    var responseCode            : String!
    var responseMessage         : String!
    var RequestID               : String!
    var RestaurantID            : String!
    var ConfirmationNumber      : String!
    var ReservationStatus       : Int!
    dynamic var SelectedTime    = ""
    dynamic var PartySize       = 0
    dynamic var SelectedDate    = ""
    var Comments                : String!
    var TablePreferenceID       : String!
    var PartyDetails            : [ResrvationPartyDetail]! = []
    var UI                      : GetResrvationUI!
   
    override init() {
        super.init()
    }
    
    required convenience init?(map: Map) {
        self.init()
        responseCode        = ""
        responseMessage     = ""
        RequestID           = ""
        RestaurantID        = ""
        ConfirmationNumber  = ""
        ReservationStatus   = 0
        SelectedTime        = ""
        PartySize           = 0
        SelectedDate        = ""
        Comments            = ""
        TablePreferenceID   = ""
        PartyDetails        = []
        UI                  = GetResrvationUI()
    }
    
    func mapping(map: Map) {
        
        
        responseCode            <- map["Response"]
        responseMessage         <- map["Message"]
        RequestID               <- map["RequestID"]
        RestaurantID            <- map["RestaurantID"]
        ConfirmationNumber      <- map["ConfirmationNumber"]
        ReservationStatus       <- map["ReservationStatus"]
        SelectedTime            <- map["SelectedTime"]
        PartySize               <- map["PartySize"]
        SelectedDate            <- map["SelectedDate"]
        Comments                <- map["Comments"]
        TablePreferenceID       <- map["TablePreferenceID"]
        PartyDetails            <- map["PartyDetails"]
        UI                      <- map["UI"]
    }
}




class ResrvationPartyDetail: RequestData, Mappable {
    
    var MemberID            : String!
    var MemberType          : Int!
    var MemberName          : String!
    var DietartRestriction  : String!
    var Anniversary         : Int!
    var Birthday            : Int!
    var Other               : Int!
    var OtherText           : String!
    var HighChair           : Int!
    var BoosterChair        : Int!
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        MemberID            = ""
        MemberType          = 0
        MemberName          = ""
        DietartRestriction  = ""
        Anniversary         = 0
        Birthday            = 0
        Other               = 0
        OtherText           = ""
        HighChair           = 0
        BoosterChair        = 0
    }
    
    func mapping(map: Map) {
        
        MemberID            <- map["MemberID"]
        MemberType          <- map["MemberType"]
        MemberName          <- map["MemberName"]
        DietartRestriction  <- map["DietartRestriction"]
        Anniversary         <- map["Anniversary"]
        Birthday            <- map["Birthday"]
        Other               <- map["Other"]
        OtherText           <- map["OtherText"]
        HighChair           <- map["HighChair"]
        BoosterChair        <- map["BoosterChair"]
    }
    
    func setPartyDetails(memberID: String, memberName: String, diet: String, anniversary: Int, birthday: Int, other: Int, otherText: String, highChair: Int, boosterChair: Int) {
        self.MemberID = memberID
        self.MemberName = memberName
        self.DietartRestriction = diet
        self.Anniversary = anniversary
        self.Birthday = birthday
        self.Other = other
        self.OtherText = otherText
        self.HighChair = highChair
        self.BoosterChair = boosterChair
    }
}


class GetResrvationUI: NSObject, Mappable {
    
    var Submit                          : Int!
    var CancelRequest                   : Int!
    var PatrySizeEditable               : Int!
    var DateEditable                    : Int!
    var PartyInfoEditable               : Int!
    var ReservationCommentsEditable     : Int!
    var TablePreferenceEditable         : Int!
    var TimeSlotEditable                : Int!
    
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
        Submit                          = 0
        CancelRequest                   = 0
        PatrySizeEditable               = 0
        DateEditable                    = 0
        PartyInfoEditable               = 0
        ReservationCommentsEditable     = 0
        TablePreferenceEditable         = 0
        TimeSlotEditable                = 0
       
    }
    
    func mapping(map: Map) {
        
        Submit                      <- map["Submit"]
        CancelRequest               <- map["CancelRequest"]
        PatrySizeEditable           <- map["PatrySizeEditable"]
        DateEditable                <- map["DateEditable"]
        PartyInfoEditable           <- map["PartyInfoEditable"]
        ReservationCommentsEditable <- map["ReservationCommentsEditable"]
        TablePreferenceEditable     <- map["TablePreferenceEditable"]
        TimeSlotEditable            <- map["TimeSlotEditable"]
      
    }
}
