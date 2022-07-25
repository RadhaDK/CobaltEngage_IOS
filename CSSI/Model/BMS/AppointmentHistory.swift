//
//  AppointmentHistory.swift
//  CSSI
//
//  Created by Kiran on 30/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper


class AppointmentHistory : NSObject,Mappable
{
    var responseCode,responseMessage : String?
    var AppointmentHistoryDetails : [AppointMentHistoryDetails]?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.AppointmentHistoryDetails <- map["AppointmentHistoryDetails"]
        self.responseCode <- map["ResponseCode"]
        self.responseMessage <- map["ResponseMessage"]
    }
    
    
}


class AppointMentHistoryDetails : NSObject,Mappable
{
    var productClass,appointmentDate,appointmentTime,appointmentStatus,confirmationNumber,comments,duration,serviceName,departmentName,serviceText,appointmentEndTime,serviceDuration,appDateTime,appointmentDetailID,statusColor : String?
    var details : [Detail]?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.productClass <- map["ProductClass"]
        self.appointmentDate <- map["AppointmentDate"]
        self.appointmentTime <- map["AppointmentTime"]
        self.appointmentStatus <- map["AppointmentStatus"]
        self.confirmationNumber <- map["ConfirmationNumber"]
        self.comments <- map["Comments"]
        self.duration <- map["Duration"]
        self.serviceName <- map["ServiceName"]
        self.departmentName <- map["DepartmentName"]
        self.serviceText <- map["ServiceText"]
        self.details <- map["Details"]
        self.appointmentEndTime <- map["AppointmentEndTime"]
        self.serviceDuration <- map["ServiceDuration"]
        self.appDateTime <- map["AppDateTime"]
        self.appointmentDetailID <- map["AppointmentDetailID"]
        self.statusColor <- map["StatusColor"]
    }
    
    
}


