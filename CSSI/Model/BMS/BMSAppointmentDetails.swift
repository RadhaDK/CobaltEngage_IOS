//
//  BMSAppointmentDetails.swift
//  CSSI
//
//  Created by Kiran on 29/05/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper



class BMSAppointmentDetails : NSObject, Mappable
{
    ///Department selected.
    ///
    ///Contains settting,appointment Flow and other department details
    var department : DepartmentDetails?
    
    ///Provider whi is prividing the servide
    var provider : Provider?
    
    ///Type of service selected
    var service : Service?
    
    ///Product Class selected
    var serviceType : ProductionClass?
    
    ///Indicates if the appointment is in Requsest/Modify/View state
    var requestScreenType : RequestScreenType?
    
    //Following are used for modify/View Case
    
    var appointmentID : String?
    
    //Added on 18th August 2020 V2.3
    //Added these to remember the selection so that they can be replpulated if required.
    ///Members selected to make a request
    //BMS request uses this a source to store memer details to avoid maintianing multiple records of the same data.
    var members : [RequestData]?

    ///Defines if the request accepts single or multiple members
    var memberSelectionType : MemberSelectionType?
    
    ///Comments entered by user
    var comments : String?
    
    ///The gender preference of the provider
    //This value is only used when no provider is selected.
    var providerGender : FilterOption?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map) {
        
    }
    
}
