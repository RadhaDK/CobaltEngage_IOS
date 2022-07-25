//
//  MembersList.swift
//  CSSI
//
//  Created by MACMINI13 on 03/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class MembersList: NSObject, Mappable
{
    var memberList: [MemberInfo]?
    var pageCount: String?
//    var guestInfo: [GuestInfo]?
    var recordsPerpage: String?
    var totalRecords: String?
    var isLoadMore: Int?
    
    var responseCode: String?
    var responseMessage: String?
    var imagePath: String?
    var brokenRules : BrokenRules?
    var specialEvent: Int?
    var details: [DetailDuplicate]?

    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        memberList <- map["Members"]
        isLoadMore <- map["IsLoadMore"]
        pageCount <- map["PageCount"]
        recordsPerpage <- map["RecordsPerPage"]
        totalRecords <- map["TotalRecords"]
        //guestInfo <- map["GuestInfo"]
        brokenRules <- map["BrokenRules"]

        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        specialEvent <- map["SpecialEvent"]
        imagePath <- map["ImagePath"]
        details <- map["Details"]
    }
    
}


class RequestData: NSObject {
    var location: Int = -1
    var isEmpty = true
    var isBuddy = false
}

class GuestInfo: RequestData, Mappable
{
    var guestType: String?
    var guestName: String?
    var cellPhone: String?
    var email: String?
    var highChairCount: Int?
    var boosterChairCount: Int?
    var dietaryRestrictions: String?
    var addToMyBuddy: Int?
    var otherText: String?
    var other: Int?
    var birthDay: Int?
    var anniversary: Int?
    var buddyID: String?
    //Added on 4th Septmeber 2020 V2.3
    var guestGender : String?
    var guestDOB : String?
    
    //Added on 5th Septmeber 2020 V2.3
    //TODO:- Once the modify scenario of AddGuestRegVC is changed remove this.
    var appointmentMemberID : String?
    //TODO:- Once the modify scenario of AddGuestRegVC is changed remove this.
    var linkedMemberID: String?
    //TODO:- Once the modify scenario of AddGuestRegVC is changed remove this.
    var guestMemberNo: String?
    
    //Added by kiran V2.8 -- ENGAGE0011784 --
    //ENGAGE0011784 -- Start
    var guestLastName : String?
    var guestFirstName : String?
    var guestMemberOf : String?
    var guestLinkedMemberID : String?
    var guestIdentityID : String?
    //ENGAGE0011784 -- End
    var memberTransType: Int?
    var memberRequestHoles: String?
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        guestType <- map["guestType"]
        guestName <- map["guestName"]
        cellPhone <- map["guestPhone"]
        email <- map["guestEmail"]
        highChairCount <- map["HighChairCount"]
        boosterChairCount <- map["BoosterChairCount"]
        dietaryRestrictions <- map["DietaryRestrictions"]
        addToMyBuddy <- map["addToMyBuddy"]
        otherText <- map["OtherText"]
        other <- map["Other"]
        birthDay <- map["Birthday"]
        anniversary <- map["Anniversary"]
        buddyID <- map[""]
        //Added on 4th Septmeber 2020 V2.3
        self.guestGender <- map["GuestGender"]
        self.guestDOB <- map["GuestDOB"]
        
        //Added by kiran V2.8 -- ENGAGE0011784 --
        //ENGAGE0011784 -- Start
        self.guestLastName <- map["GuestLastName"]
        self.guestFirstName <- map["GuestFirstName"]
        self.guestMemberOf <- map["GuestMemberOf"]
        self.linkedMemberID <- map["LinkedMemberID"]
        self.guestMemberNo <- map["GuestMemberNo"]
        self.appointmentMemberID <- map["AppointmentMemberID"]
        self.guestLinkedMemberID <- map["GuestLinkedMemberID"]
        self.guestIdentityID <- map["GuestIdentityID"]
        //ENGAGE0011784 -- End
        
        self.memberTransType <- map["MemberTransType"]
        self.memberRequestHoles <- map["MemberRequestHoles"]
    }
    
    //Modified on 4th September 2020 V2.3
    
    //Added by kiran V2.8 -- ENGAGE0011784 -- added last name
    //ENGAGE0011784 -- Start
    func setGuestDetails(name: String,firstName : String ,lastName : String,linkedMemberID : String,guestMemberOf : String, guestMemberNo : String, gender : String,DOB : String, buddyID : String ,type: String, phone: String, primaryemail : String, guestLinkedMemberID : String,highChair : Int, booster : Int, dietary : String, addGuestAsBuddy : Int, otherNo : Int, otherTextInformation : String, birthdayNo : Int, anniversaryNo : Int)
    {//ENGAGE0011784 -- End
        self.guestName = name
        self.guestType = type
        self.cellPhone = phone
        self.email = primaryemail
        self.highChairCount = highChair
        self.boosterChairCount = booster
        self.dietaryRestrictions = dietary
        self.addToMyBuddy = addGuestAsBuddy
        self.otherText = otherTextInformation
        self.other = otherNo
        self.birthDay = birthdayNo
        self.anniversary = anniversaryNo
        self.buddyID = buddyID
        //Added on 4th Septmeber 2020 V2.3
        self.guestGender = gender
        self.guestDOB = DOB
        
        //Added by kiran V2.8 -- ENGAGE0011784 -- added last name
        //ENGAGE0011784 -- Start
        self.guestLastName = lastName
        self.guestFirstName = firstName
        self.linkedMemberID = linkedMemberID
        self.guestMemberNo = guestMemberNo
        self.guestMemberOf = guestMemberOf
        self.guestLinkedMemberID = guestLinkedMemberID
        //ENGAGE0011784 -- End
    }
}

class DiningMemberInfo: RequestData, Mappable{
    var linkedMemberID : String?
    var memberId : String?
    var name : String?
    var parentID : String?
    var highChairCount: Int?
    var boosterChairCount: Int?
    var dietaryRestrictions: String?
    var otherText: String?
    var other: Int?
    var birthDay: Int?
    var anniversary: Int?
    var id: String?
    var firstName: String?
    var profilePic: String?
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        memberId <- map["MemberId"]
        name <- map["MemberName"]

        linkedMemberID <- map["LinkedMemberID"]
        highChairCount <- map["HighChairCount"]
        boosterChairCount <- map["BoosterChairCount"]
        dietaryRestrictions <- map["DietaryRestrictions"]
        otherText <- map["OtherText"]
        other <- map["Other"]
        birthDay <- map["birthDay"]
        anniversary <- map["Anniversary"]
        id <- map["ID"]
        
        firstName <- map[""]
        profilePic <- map[""]
        parentID <- map[""]
    }
    
    func setDiningMemberDetails(MemberId: String,firstName:String, Name: String,profilePic: String, id: String , parentID : String, highChair: Int, booster: Int, dietary: String, otherNo: Int, otherTextInformation: String, birthdayNo: Int, anniversaryNo: Int) {
        self.memberId = MemberId
        self.name = Name
        self.linkedMemberID = id
        self.highChairCount = highChair
        self.boosterChairCount = booster
        self.dietaryRestrictions = dietary
        self.otherText = otherTextInformation
        self.other = otherNo
        self.birthDay = birthdayNo
        self.anniversary = anniversaryNo
        self.firstName = firstName
        self.profilePic = profilePic
        self.parentID = parentID
    }
}



class CaptaineInfo: RequestData, Mappable{
    var captainID: String?
    var captainName: String?
    var captainOrder: Int?
    var captainMemberID: String?
    var captainParentID: String?
    var captainProfilePic:String?
    var captainFirstName: String?
    var memberTransType: Int?
    var memberRequestHoles: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        captainID <- map["captainID"]
        captainName <- map["captainName"]
        captainOrder <- map["captainOrder"]
        captainMemberID <- map["captainMemberID"]
        captainParentID <- map["captainParentID"]
        captainFirstName <- map[""]
        captainProfilePic <- map[""]
        self.memberTransType <- map["MemberTransType"]
        self.memberRequestHoles <- map["MemberRequestHoles"]
    }
    
    func setCaptainDetails(id: String, name: String,firstName: String, order: Int, memberID: String, parentID: String , profilePic: String) {
        self.captainID = id
        self.captainName = name
        self.captainOrder = order
        self.captainMemberID = memberID
        self.captainParentID = parentID
        self.captainFirstName = firstName
        self.captainProfilePic = profilePic
        
    }
}

class GuestChildren: RequestData, Mappable{
    var guestCount: Int?
    var kids3Below: Int?
    var kids3Above: Int?
    var isInclude: Int?
    var selectedID : String?
    var memberId : String?
    var name : String?
    var parentID: String?
    var isSpouse: Int?
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        guestCount <- map["guestCount"]
        kids3Below <- map["kids3Below"]
        kids3Above <- map["kids3Above"]
        isInclude <- map["isInclude"]
        memberId <- map["memberId"]
        name <- map["name"]
        selectedID <- map["selectedID"]
        parentID <- map["parentID"]
        isSpouse <- map["IsSpouse"]
    }
    
    func setGuestChildrenInfo(MemberId: String, Name: String, id: String, parentId: String, guest: Int, kid3Above: Int, kids3Below: Int, isInclude: Int, isSpouse: Int) {
        self.guestCount = guest
        self.kids3Above = kid3Above
        self.kids3Below = kids3Below
        self.isInclude = isInclude
        self.memberId = MemberId
        self.selectedID = id
        self.name = Name
        self.parentID = parentId
        self.isSpouse = isSpouse
    }
}

class MemberInfo: RequestData, Mappable  {
    var isPrimaryMember : Int?
    var kids3Above: Int?
    var kids3Below: Int?
    var guest: Int?
    var isInclude: Int?
    var memberID: String?
    var id: String?
    var villageName: String?
    var parentid: String?
    var memberName: String?
    @objc var firstName: String?
   @objc var lastName: String?
    var profilePic: String?
    var guestName : String?
    var captainName: String?
    var buddyListID: String?
    var buddyType: String?
    var guestEmail : String?
    var guestContact : String?
    var guestType : String?
    var categories: [GetCategoryList]?
    var isSpouse: Int?
    var isMemberNotAllowed: Int?
    var requestedBy: String?
    
    //Added by kiran V2.8 -- ENGAGE0011784 -- added Guest First Name and last name
    //ENGAGE0011784 -- Start
    
    var guestFirstName : String?
    var guestLastName : String?
    var guestGender : String?
    var guestDOB : String?
    //ENGAGE0011784 -- End
    
    var memberTransType: Int?
    var memberRequestHoles: String?
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        isSpouse <- map["IsSpouse"]
        isPrimaryMember <- map["IsPrimaryMember"]
        kids3Above <- map["Kids3Above"]
        kids3Below <- map["Kids3Below"]
        guest <- map["Guest"]
        isInclude <- map["IsInclude"]

        categories <- map["GetCategories"]
        memberID <- map["MemberID"]
        id <- map["ID"]
        villageName <- map["VillageName"]
        firstName <- map["FirstName"]
        lastName <- map["LastName"]
        profilePic <- map["ProfilePic"]
        memberName <- map["MemberName"]
        parentid <- map["ParentID"]
        guestName <- map["GuestName"]
        captainName <- map["captainName"]
        buddyListID <- map["BuddyListID"]
        buddyType <- map["BuddyType"]
        guestEmail <- map["GuestEmail"]
        guestContact <- map["GuestContact"]
        guestType <- map["GuestType"]
        isMemberNotAllowed <- map["IsMemberNotAllowed"]
        requestedBy <- map["RequestedBy"]
        
        //Added by kiran V2.8 -- ENGAGE0011784 -- Added guest First and Last name
        //ENGAGE0011784 -- Start
        self.guestFirstName <- map["GuestFirstName"]
        self.guestLastName <- map["GuestLastName"]
        self.guestGender <- map["GuestGender"]
        self.guestDOB <- map["GuestDOB"]
        //ENGAGE0011784 -- End
        
        self.memberTransType <- map["MemberTransType"]
        self.memberRequestHoles <- map["MemberRequestHoles"]
    }
    
}
class GetCategoryList: NSObject , Mappable {
    var category : String?
    
    
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        category <- map["Category"]
        
    }
    
}
