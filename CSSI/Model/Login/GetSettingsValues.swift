//
//  GetSettingsValues.swift
//  CSSI
//
//  Created by apple on 4/3/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//


import Foundation


import ObjectMapper

class GetSettingsValues: NSObject, Mappable {
    
    //Modified by kiran V2.5 -- ENGAGE0011395
    //ENGAGE0011395 -- Start
    var getSettings : [Settings]?
    //var getSettings : Settings?
    //ENGAGE0011395 -- End
    var responseCode : String?
    var responseMessage : String?
    //Added by kiran -- GATHER0000176
    var fitnessProfileSettings : FitnessProfileSettings?
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        getSettings <- map["Settings"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        //Added by kiran -- GATHER0000176
        self.fitnessProfileSettings <- map["FitnessProfileSettings"]
    }
    
}

//Modified by kiran V2.5 -- ENGAGE0011395 -- Settings screen setting
//ENGAGE0011395 -- Start
class Settings: NSObject, Mappable
{
//    var fingerPrintRecognition : Int?
//    var faceIDRecognition : Int?
//    var allowAppNotifications : Int?
//    var addContactstoPhone : Int?
//    var syncCalendar : Int?
//    var shareImage : Int?
    //Added by kiran -- ENGAGE0011230
    //var allowSmsNotifications : Int?
    
    var settingText : String?
    var optionCode : String?
    var settingValue : Int?
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
//        fingerPrintRecognition <- map["FingerPrintRecognition"]
//        faceIDRecognition <- map["FaceIDRecognition"]
//        allowAppNotifications <- map["AllowAppNotifications"]
//        addContactstoPhone <- map["AddContactstoPhone"]
//        syncCalendar <- map["SyncCalendar"]
//        shareImage <- map["ShareImage"]
        //Added by kiran -- ENGAGE0011230
        //self.allowSmsNotifications <- map["AllowSmsNotifications"]
        
        self.settingText <- map["SettingText"]
        self.optionCode <- map["OPTIONCODE"]
        self.settingValue <- map["SettingValue"]
    }
}
//ENGAGE0011395 -- End

//Added by kiran -- GATHER0000176

class FitnessProfileSettings: NSObject, Mappable
{
    var videoUploadNotification : Int?
    var goalRemainderNotification : Int?
    
    override init()
    {
        super.init()
    }
    
    convenience required init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.videoUploadNotification <- map["VideoUploadNotification"]
        self.goalRemainderNotification <- map["GoalRemainderNotification"]
    }
    
}
