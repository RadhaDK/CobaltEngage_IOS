//
//  AccessManager.swift
//  CSSI
//
//  Created by Kiran on 04/07/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation


class AccessManager : NSObject
{
    private override init() {
        super.init()
    }
    
    static let shared = AccessManager.init()
    
    var rolesAndPrivilages : [RoleAndPrivilage] = [RoleAndPrivilage]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    ///Returns the access permission of the module
    ///
    ///Note: Returns not allowed if the SACode is not hardcoded in app or when the object dosent exist in the permisstions array
    func accessPermision(for module : SAModule) -> AccessType
    {
        if let SACode = module.SACode()
        {
            if let privilage = self.rolesAndPrivilages.first(where: {$0.SACode == SACode})
            {
                return privilage.accessLevel!
            }
        }
        
        return .notAllowed
    }
    
    ///Returns the access permission of the module
    ///
    ///Note: Returns not allowed if the SACode  dosent exist in the permisstions array
    func accessPermission(SACode : String?) -> AccessType
    {
        
        if let SACode = SACode
        {
            if let privilate = self.rolesAndPrivilages.first(where: {$0.SACode == SACode})
            {
                return privilate.accessLevel!
            }
            
        }
        
        return .notAllowed
    }
    
    //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments. Added department name for BMS sub category(eg. fitness , spa ,salon, etc..) permissions.
    //ENGAGE0011652 -- Start
    ///Returns the acces permission of the modult with eventCategory. if cannot find the permission returns NotAllowed
    ///
    /// Used for calender of events and my calendar
    func accessPermission(eventCategory : String , type : CalendarRequestType,departmentName : String) -> AccessType
    {//ENGAGE0011652 -- End
        var module : SAModule!
        
        
        switch type {
        case .reservations:
            break
        case .events:
            //Access level for events other than dining. dining uses dining reservation access level
            if !(eventCategory.caseInsensitiveCompare("Dining") == .orderedSame)
            {
                return self.accessPermision(for: .calendarOfEvents)
            }
        case .BMS:
        //Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes
        //GATHER0000700 - Start
            if eventCategory.caseInsensitiveCompare(AppIdentifiers.tennis) == .orderedSame
            {
                return self.accessPermision(for: .tennisBookALesson)
            }//Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments.
            //ENGAGE0011652 -- Start
            else if eventCategory.caseInsensitiveCompare(AppIdentifiers.fitnessSpa) == .orderedSame
            {
                return self.accessPermissionFor(departmentName: departmentName)
            }
            //Added by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
            //GATHER0001167 -- Start
            else if eventCategory.caseInsensitiveCompare(AppIdentifiers.golf) == .orderedSame
            {
                return self.accessPermision(for: .golfBookALesson)
            }
            //GATHER0001167 -- End
            return self.accessPermision(for: module)
            //ENGAGE0011652 -- End
        //GATHER0000700 - End
        }
        
        //This is used for BMS and resevations as currently BMS has only fitnessa and spa. May need to change if other BMS types added in the future
        
        if eventCategory.caseInsensitiveCompare("Tennis") == .orderedSame
        {
            module = .tennisReservation
        }
        else if eventCategory.caseInsensitiveCompare("Golf") == .orderedSame
        {
             module = .golfReservation
        }
        else if eventCategory.caseInsensitiveCompare("Dining") == .orderedSame
        {
            module = .diningReservation
        }
        else if eventCategory.caseInsensitiveCompare("FitnessSpa") == .orderedSame
        {
            module = .fitnessSpaAppointment
        }
        else
        {
            return .notAllowed
        }
        
       return self.accessPermision(for: module!)
    }

    //TODO:- Remove in march 2021 release. this is a temp workaround. because we are short on time.
    //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments.
    //ENGAGE0011652 -- Start
    func accessPermissionFor(departmentName : String) -> AccessType
    {
        var module : SAModule!
        
        if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Fitness!) == .orderedSame
        {
            module = .fitnessAppointments
        }
        else if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Spa!) == .orderedSame
        {
            module = .spaAppointments
        }
        else if departmentName.caseInsensitiveCompare(self.appDelegate.masterLabeling.BMS_Salon!) == .orderedSame
        {
            module = .salonAppointments
        }
        else
        {
            return .allowed
        }
        
        return self.accessPermision(for: module!)
    }
    //ENGAGE0011652 -- End
    
}
