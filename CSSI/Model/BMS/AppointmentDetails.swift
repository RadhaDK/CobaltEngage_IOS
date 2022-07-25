//
//  AppointmentDetails.swift
//  CSSI
//
//  Created by Kiran on 18/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper


class AppointmentDetails : NSObject,Mappable
{
    
    var appointmentDetails : [Appointment]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        self.appointmentDetails <- map["AppointmentDetais"]
    }
    
    
}



class Appointment : NSObject,Mappable
{
    var appointmentDate : String?
    var appointmentDetailID : String?
    var appointmentID : String?
    var appointmentStatus : String?
    var appointmentTime : String?
    var comments : String?
    var confirmationNumber : String?
    var departmentName : String?
    var details : [Detail]?
    var duration : String?
    var isAllowMemberstoView : String?
    var isCancel : Int?
    var isModify : String?
    var locationID : String?
    var name : String?
    var productClass : String?
    var productClassID : String?
    var productClassImage : String?
    var providerName : String?
    var serviceID : String?
    var serviceName : String?
    var settings : [BMSSettings]?
    var subName : String?
    var syncCalendarTitle : String?
    var cancelReasonList : [CancelReason]?
    var providerGender : String?
    var providerID : String?
    //Added on  25th June 2020 BMS
    var syncText : String?
    // Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
    //GATHER0000923 -- Start
    var serviceCategoryID : String?
    var categoryName : String?
    //GATHER0000923 -- End
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.appointmentDate <- map["AppointmentDate"]
        self.appointmentDetailID <- map["AppointmentDetailID"]
        self.appointmentID <- map["AppointmentID"]
        self.appointmentStatus <- map["AppointmentStatus"]
        self.appointmentTime <- map["AppointmentTime"]
        self.comments <- map["Comments"]
        self.confirmationNumber <- map["ConfirmationNumber"]
        self.departmentName <- map["DepartmentName"]
        self.details <- map["Details"]
        self.duration <- map["Duration"]
        self.isAllowMemberstoView <- map["IsAllowMemberstoView"]
        self.isCancel <- map["IsCancel"]
        self.isModify <- map["IsModify"]
        self.locationID <- map["LocationID"]
        self.name <- map["Name"]
        self.productClass <- map["ProductClass"]
        self.productClassID <- map["ProductClassID"]
        self.productClassImage <- map["ProductClassImage"]
        self.providerName <- map["ProviderName"]
        self.serviceID <- map["ServiceID"]
        self.serviceName <- map["ServiceName"]
        self.settings <- map["Settings"]
        self.subName <- map["SubName"]
        self.syncCalendarTitle <- map["SyncCalendarTitle"]
        self.cancelReasonList <- map["CancelReasonList"]
        self.providerGender <- map["ProviderGender"]
        self.syncText <- map["SyncText"]
        
        self.providerID <- map["ProviderID"]
        
        // Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
        //GATHER0000923 -- Start
        self.serviceCategoryID <- map["ServiceCategoryID"]
        self.categoryName <- map["CategoryName"]
        //GATHER0000923 -- End
    }
    
}


class CancelReason : NSObject, Mappable
{
    var reason : String?
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.reason <- map["CancelReason"]
    }
}



