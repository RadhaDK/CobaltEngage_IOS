//
//  File.swift
//  CSSI
//
//  Created by Kiran on 12/04/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper


//Added by kiran V2.8 -- ENGAGE0011784 -- Existing guest object
//ENGAGE0011784 -- Start
class ExistingGuestList: NSObject, Mappable
{
    var existingGuests : [ExistingGuest]?
    var isLoadMore: Int?

    convenience required init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.existingGuests <- map["Members"]
        self.isLoadMore <- map["IsLoadMore"]
    }
    
}



class ExistingGuest: RequestData, Mappable
{
    var firstName : String?
    var ID : String?
    var lastName : String?
    var memberID : String?
    var memberName : String?
    var parentID : String?
    var profilePic : String?
    var isMemberNotAllowed : Int?
    var requestedBy : String?
    var guestVisitData : String?
    var isActive : Int?
    var guestDOB : String?
    var guestEmail : String?
    var guestFirstName : String?
    var guestGender : String?
    var guestLastName : String?
    var guestPhone : String?
    var guestType : String?
    var guestIdentityID : String?

    convenience required init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.firstName <- map["FirstName"]
        self.ID <- map["ID"]
        self.lastName <- map["LastName"]
        self.memberID <- map["MemberID"]
        self.memberName <- map["MemberName"]
        self.parentID <- map["ParentID"]
        self.profilePic <- map["ProfilePic"]
        self.isMemberNotAllowed <- map["IsMemberNotAllowed"]
        self.requestedBy <- map["RequestedBy"]
        self.guestVisitData <- map["GuestVisitData"]
        self.isActive <- map["IsActive"]
        self.guestDOB <- map["GuestDOB"]
        self.guestEmail <- map["GuestEmail"]
        self.guestFirstName <- map["GuestFirstName"]
        self.guestGender <- map["GuestGender"]
        self.guestLastName <- map["GuestLastName"]
        self.guestPhone <- map["GuestPhone"]
        self.guestType <- map["GuestType"]
        self.guestIdentityID <- map["GuestIdentityID"]
    }
    
}
//ENGAGE0011784 -- End
