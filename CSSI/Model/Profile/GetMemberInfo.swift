//
//  GetMemberInfo.swift
//  CSSI
//
//  Created by MACMINI13 on 20/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper


class GetMemberInfo: NSObject, Mappable {
    
    var memberMasterID: String?
    var id: String?
    var parentId: String?

    
    var suffix: String?
    var prefix: String?

    var displayName: String?
    var firstName: String?
    var username: String?
    var lastName: String?
    var middleName: String?
    var passworddd: String?
    var status: String?
    var gender: String?
    var isVisibleInDirctory: String?
    var notificatonStatus: String?
    var isActiveEmailNotification: String?
    var profilePic: String?
    var dateOfBirth: String?
    var anniversaryDate: String?
    var joiningDate: String?
    var memberType: String?
    var guestName: String?
    var guestContact: String?
    var guestEmail: String?
    
    var primaryPhone: String?
    var secondaryPhone: String?
    var alternatePhone: String?

    var primaryEmail: String?
    var secondaryEmail: String?

    var village: String?
    var sendSatements: String?
    var sendmagazine: String?
    

    
    var responseCode: String?
    var responseMessage: String?
    
    
    var showMyProfile: Int?
    var showHomePhone: Int?
    var showCellPhone: Int?
    var showOtherPhone: Int?
    var addressOther: Int?
    var addressBussiness: Int?
    var showProfilePhoto: Int?
    
    var showPrimaryEmail: Int?
    var showSecondaryEmail: Int?
    var showprimaryPhone: Int?
    var showSecondaryPhone: Int?
    var showAlternatePhone: Int?
    var showLogin: Int?
    var showBocaAddress: Int?
    var showprimaryEmailNotification: Int?
    var showSecondaryEmailNotification: Int?
    var relatedMember: RelatedMember?
    var memberName: String?
    var showVillageName: Int?
    var showBirthday: Int?
    
    
    var addOnType: [AddOnType]?
   // var interest: [ProfileInterest]?
    var address: [Address]?
    var allInterests: [String]?
    var interest: [String]?
    var targetedMarketOption: [TargetedMarketingOption]?
    var addressText : String?
    var addressBackgroundColor: String?
    var buddyListAddressTextBackgroundColor: String?
    
    //Modified by kiran V2.7 -- ENGAGE0011559 -- international Number change
    //ENGAGE0011559 -- Start
    var isOutSideUSPhone : Int?
    //ENGAGE0011559 -- End
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        addressBackgroundColor <- map["AddressTextBackgroundColor"]
        buddyListAddressTextBackgroundColor <- map["BuddyListAddressTextBackgroundColor"]
        addressText <- map["AddressText"]
        guestName <- map["GuestName"]
        guestEmail <- map["GuestEmail"]
        guestContact <- map["GuestContact"]
        memberName <- map["MemberName"]
        showVillageName <- map["ShowVillageName"]
        suffix <- map["Suffix"]
        prefix <- map["Prefix"]
        memberMasterID <- map["MemberID"]
        displayName <- map["DisplayName"]
        firstName <- map["FirstName"]
        middleName <- map["MiddleName"]
        username <- map["UserName"]
        lastName <- map["LastName"]
        passworddd <- map["Password"]
        status <- map["Status"]
        gender <- map["Gender"]
        isVisibleInDirctory <- map["IsVisibleInDirctory"]
        notificatonStatus <- map["NotificatonStatus"]
        isActiveEmailNotification <- map["IsActiveEmailNotification"]
        profilePic <- map["ProfilePic"]
        dateOfBirth <- map["DateOfBirth"]
        anniversaryDate <- map["AnniversaryDate"]
        joiningDate <- map["JoiningDate"]
        memberType <- map["MemberType"]
        village <- map["Village"]
        sendSatements <- map["SendStatementTo"]
        sendmagazine <- map["SendMagazineTo"]
        showProfilePhoto <- map["ShowProfilePhoto"]
        
           primaryPhone <- map["PrimaryPhone"]
           secondaryPhone <- map["SecondaryPhone"]
           primaryEmail <- map["PrimaryEmail"]
           secondaryEmail <- map["SecondaryEmail"]
        
    
        
        addOnType <- map["AddOnType"]
        interest <- map["Interests"]
        address <- map["Address"]
        allInterests <- map["AllInterests"]
    
        relatedMember <- map["RelatedMember"]
        
        
        
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        id <- map["ID"]
        parentId <- map["ParentID"]

        alternatePhone <- map["AlternatePhone"]

        showPrimaryEmail <- map["ShowPrimaryEmail"]
        showSecondaryEmail <- map["ShowSecondaryEmail"]
        showprimaryEmailNotification <- map["PrimaryEmailNotification"]
        showSecondaryEmailNotification <- map["SecondaryEmailNotification"]
      showprimaryPhone <- map["ShowPrimaryPhone"]
        showSecondaryPhone <- map["ShowSecondaryPhone"]
       showAlternatePhone <- map["ShowAlternatePhone"]
        targetedMarketOption <- map["TargetedMarketingOption"]
        showLogin <- map["ShowLogin"]
        showBirthday <- map["ShowBirthday"]
         showMyProfile <- map["IsVisibleInDirectory"]
         showHomePhone <- map["ShowPrimaryPhone"]
         showCellPhone <- map["ShowSecondaryPhone"]
         showOtherPhone <- map["ShowAlternatePhone"]
         addressOther <- map["ShowOtherAddress"]
         addressBussiness <- map["ShowBusinessAddress"]
        showBocaAddress <- map["ShowBocaAddress"]
        
        //Modified by kiran V2.7 -- ENGAGE0011559 -- international Number change
        //ENGAGE0011559 -- Start
        self.isOutSideUSPhone <- map["IsOutSideUSPhone"]
        //ENGAGE0011559 -- End
        

    }
    
}
class TargetedMarketingOption: NSObject, Mappable  {

    var groupID: String?
    var groupName: String?
    var isChecked: Int?
   


    convenience required init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        groupID <- map["GroupID"]
        groupName <- map["GroupName"]
        isChecked <- map["IsChecked"]
        
    }

}
class RelatedMember: NSObject, Mappable  {
    
    var memberID: String?
    var id: String?
    var parentID: String?
    var linkedMemberNumber: String?
    var linkedMemberName: String?
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        memberID <- map["MemberID"]
        id <- map["ID"]
        parentID <- map["ParentID"]
        linkedMemberNumber <- map["LinkedMemberNumber"]
        linkedMemberName <- map["LinkedMemberName"]
    }
    
}

