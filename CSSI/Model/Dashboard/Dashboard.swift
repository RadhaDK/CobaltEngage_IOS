//
//  Dashboard.swift
//  CSSI
//
//  Created by MACMINI13 on 19/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper
import UIKit


class Dashboard: NSObject, Mappable {
    
   // var todayGlance: [TodayAtGlance]?
    var clubnews: [ClubNews]?
    var upcomingEvent: [ListEvents]?
    var responseCode: String?
    var responseMessage: String?
    var fullName: String?
    var memberNameDisplay: String?
    var facebookUrl: String?
    var instaUrl: String?
    var twitterUrl: String?
    var pinterestUrl: String?
    var appPrivateSiteUrl: String?
    var profilePic: String?
    var appVersion : String?
    var captainName: String?
    
    //Added on 4th July 2020 V2.2
    var userRolesandPrivilages : [RoleAndPrivilage]?
   
    //Added by Kiran -- ENGAGE0011226 -- Added for covid rules
    //Start
    var alertRulesText : String?
    var isShowAlertRules : Int?
    //END
    
    //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
    //GATHER0000700 - Start
    var enableTennisLesson : String?
    //GATHER0000700 - End
    
    //Added by kiran V2.7 -- ENGAGE0011628 -- add the logic to start/Stop the gimbal service based on the setting.
    //ENGAGE0011628 -- Start
    var gimbalService : Int?
    //ENGAGE0011628 -- End
    
    //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL Button Show/Hide Flag
    //GATHER0001167 -- Start
    var enableGolfLesson : String?
    //GATHER0001167 -- End
    
    var linkedIn : String?
    
    //Added by kiran V1.3 -- PROD0000019 -- Added 2 step verification changes
    //PROD0000019 -- Start
    var hideLinkToMemberSite : Int?
    var hasAccountExpired : Int?
    //PROD0000019 -- End
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        captainName <- map["CaptainName"]
        appVersion <- map["AppVersion"]
        memberNameDisplay <- map["MemberNameDisplay"]
        fullName <- map["FullName"]
     //   todayGlance <- map["TodayAtGlance"]
        clubnews <- map["ClubNews"]
        upcomingEvent <- map["UpComingEvent"]
        facebookUrl <- map["Facebook"]
        instaUrl <- map["Instagram"]
        twitterUrl <- map["Twitter"]
        pinterestUrl <- map["Pinterest"]
        appPrivateSiteUrl <- map["AppToPrivateSite"]
        profilePic <- map["ProfilePic"]
        responseCode <- map["ResponseCode"]

        responseMessage <- map["ResponseMessage"]
        
        //Added on 4th July 2020 V2.2
        self.userRolesandPrivilages <- map["UserRolesandPrivilages"]
        
        //Added by Kiran -- ENGAGE0011226 -- Added for covid rules
        //Start
        self.alertRulesText <- map["CovidRulesText"]
        self.isShowAlertRules <- map["IsShowCovidRules"]
        //End
        
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
        //GATHER0000700 - Start
        self.enableTennisLesson <- map["EnableTennisLesson"]
        //GATHER0000700 - End
        
        //Added by kiran V2.7 -- ENGAGE0011628 -- add the logic to start/Stop the gimbal service based on the setting.
        //ENGAGE0011628 -- Start
        self.gimbalService <- map["GimbalService"]
        //ENGAGE0011628 -- End
        
        //Added by kiran V2.9 -- GATHER0001167 --
        //GATHER0001167 -- Start
        self.enableGolfLesson <- map["EnableGolfLesson"]
        //GATHER0001167 -- End
        
        self.linkedIn <- map["LinkedIn"]
        
        //Added by kiran V1.3 -- PROD0000019 -- Added 2 step verification changes
        //PROD0000019 -- Start
        self.hideLinkToMemberSite <- map["HideLinkToMemberSite"]
        self.hasAccountExpired <- map["HasAccountExpired"]
        //PROD0000019 -- End
    }
    
}

//Added on 4th July 2020 V2.2
class RoleAndPrivilage : NSObject , Mappable
{
    
    var accessValue : Int?
    var displayText : String?
    var SACode : String?
    var accessText : String?
    ///Access level the user is allowed. This is the enum transformed accessText.
    ///
    ///Note: Not part of actual response
    var accessLevel : AccessType?
    
    override init() {
        super.init()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.accessValue <- map["ACCESSVALUE"]
        self.displayText <- map["DISPLAYTEXT"]
        self.SACode <- map["SACODE"]
        self.accessText <- map["ACCESSTEXT"]
        self.accessLevel <- (map["ACCESSTEXT"],EnumTransform<AccessType>())
    }
    
}

