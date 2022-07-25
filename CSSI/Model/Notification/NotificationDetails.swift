//
//  NotificationDetails.swift
//  CSSI
//
//  Created by MACMINI13 on 09/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation

import ObjectMapper

class NotificationDetails: NSObject, Mappable {
    var notifications: [Notifications]?
    var responseCode: String?
    var responseMessage: String?
    var data: [NotificationsData]?
    var unReadCount: Int?
    
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        notifications <- map["Notifications"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        data <- map["Data"]
        unReadCount <- map["UnReadCount"]
    }
}

class Notifications: NSObject, Mappable  {
    
    var notificatonID: String?
    var notificationText: String?
    var notificationDate: String?
    var memberMasterID: Int?
    var subject: String?
    var readstatus: Bool?

    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
      //  notificatonID <- map["NotificatonID"]
        notificatonID <- map["ID"]  //changes on 27/07/2018 

        notificationText <- map["NotificationText"]
        notificationDate <- map["NotificationDate"]
        memberMasterID <- map["LinkedMemberID"]
     
        subject <- map["Subject"]
        readstatus <- map["ReadStatus"]

    }
}

class NotificationsData: NSObject, Mappable  {
    
    var entityID: String?
    var entityType: String?
    var id: String?
    var isRead: Int?
    var isSent: String?
    var message: String?
    var messageHeader: String?
    var notificationDate: String?
    var notificationDetailID: String?
    var notificationID: String?
    var notificationType: String?
    var popupMessage: String?
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        //  notificatonID <- map["NotificatonID"]
        entityID <- map["ENTITYID"]  //changes on 27/07/2018
        
        entityType <- map["EntityType"]
        id <- map["ID"]
        isRead <- map["IsRead"]
        
        isSent <- map["IsSent"]
        message <- map["Message"]
        messageHeader <- map["MessageHeader"]  //changes on 27/07/2018
        
        notificationDate <- map["NotificationDate"]
        notificationDetailID <- map["NotificationDetailID"]
        notificationID <- map["NotificationID"]
        
        notificationType <- map["NotificationType"]
        popupMessage <- map["PopupMessage"]
        
    }
}
    
   
