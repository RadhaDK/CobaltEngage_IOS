//
//  DepartmentDetails.swift
//  CSSI
//
//  Created by Kiran on 27/05/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper



class Departments : NSObject, Mappable
{
    var departmentsDetails : [DepartmentDetails]?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        departmentsDetails <- map["Departments"]
    }
    
}


class DepartmentDetails : NSObject, Mappable
{
    var locationID,departmentName,icon1x,icon2x,icon3x,systemDateTime,dressCode : String?
    var settings : [BMSSettings]?
    var appointmentFlow : [FlowSequence]?
    
    //Added on 24th September 2020 V2.3
    var isShowAppointmentText : Int?
    var appointmentText : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.locationID <- map["LocationID"]
        self.departmentName <- map["DepartmentName"]
        self.icon1x <- map["Icon1x"]
        self.icon2x <- map["Icon2x"]
        self.icon3x <- map["Icon3x"]
        self.settings <- map["Settings"]
        self.appointmentFlow <- map["AppointmentFlow"]
        self.systemDateTime <- map["SystemDateTime"]
        self.dressCode <- map["DressCode"]
        
        //Added on 24th September 2020 V2.3
        self.isShowAppointmentText <- map["IsShowAppointmentText"]
        self.appointmentText <- map["AppointmentText"]
    }
    
}


class FlowSequence : NSObject, Mappable
{
    var name : String?
    var sequenceNo : Int?
    var contentType : BMSRequestScreen?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["Name"]
        sequenceNo <- map["SequenceNo"]
        contentType <- (map["Name"],EnumTransform<BMSRequestScreen>())
    }
    
}
