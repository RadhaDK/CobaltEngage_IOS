//
//  CustomFunctions.swift
//  CSSI
//
//  Created by Kiran on 11/01/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

//Added by Kiran V2.7 -- GATHER0000700 - A Custom class which is intented to have the custom functions which are reused in the whole app.
//GATHER0000700 - Start
import Foundation
import MBProgressHUD
import PassKit
import CoreLocation
import CoreBluetooth
import AppTrackingTransparency
import Firebase

//Note:- Curretnly show/hide activity indicator is done from app delegate. Use this function instead of app delegate and replace the app deglate with this class in the App when possible.
class CustomFunctions: NSObject
{
    
    private override init() {
        super.init()
    }

    static let shared = CustomFunctions.init()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var activityIndicator = MBProgressHUD()
    
    
    ///Hides the activity indicator and shows a toast Message about error
    func handleRequestError(error : Error, ShowToastOn view : UIView?)
    {
        self.hideActivityIndicator()
        guard let view = view else {
            return
        }
        
        self.showToast(WithMessage: error.localizedDescription, on: view)
    }
    
    ///Shows activiry Indicator.
    func showActivityIndicator(withTitle: String , intoView: UIView)
    {
        self.activityIndicator.removeFromSuperview()
        self.activityIndicator = MBProgressHUD.init()
        intoView.addSubview(self.activityIndicator)
        self.activityIndicator.show(animated: true)
        self.activityIndicator.backgroundColor = UIColor.clear
        self.activityIndicator.label.text = withTitle
        self.activityIndicator.bezelView.color = UIColor.darkGray
        self.activityIndicator.tintColor = .white
        self.activityIndicator.contentColor = .white
    }
    
    ///Hides Activity Indicator
    ///
    ///Note:- Use this function only if show activity indicator is used for showing the activity indicator
    func hideActivityIndicator()
    {
        self.activityIndicator.show(animated: false)
        self.activityIndicator.removeFromSuperview()
    }
    
    ///Shows toast Message.
    func showToast(WithMessage message : String? , on view : UIView)
    {
        if let message = message
        {
            SharedUtlity.sharedHelper()?.showToast(on: view, withMeassge: message, withDuration: Duration.kMediumDuration)
        }
    }
    
    //Added by kiran V2.9 -- ENGAGE0011722 -- Apple wallet functionality
    //ENGAGE0011722 -- Start
    
    func showAlert(title: String, message : String,on VC : UIViewController,actions : [UIAlertAction])
    {
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        for action in actions
        {
            alertVC.addAction(action)
        }
        
        VC.present(alertVC, animated: true, completion: nil)
    }
    //ENGAGE0011722 -- End
    
    //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
    //ENGAGE0011898 -- Start
    ///Shows PDF
    func showPDFWith(url : String , title : String, navigationController : UINavigationController?)
    {
        let pdfVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDfViewController") as! PDfViewController
        pdfVC.pdfUrl = url
        pdfVC.restarantName = title
        navigationController?.pushViewController(pdfVC, animated: true)
    }
    //ENGAGE0011898 -- End

    ///Returns the BMS Department form department type string.
    func BMSDepartmentType(departmentType : String?) -> BMSDepartment
    {
       
        guard let departmentType = departmentType else{
            return .none
        }
        
        //Used if insetad of using enum init method as case insenstitve compare is required
        if departmentType.caseInsensitiveCompare(BMSDepartment.fitnessAndSpa.rawValue) == .orderedSame
        {
            return.fitnessAndSpa
        }
        else if departmentType.caseInsensitiveCompare(BMSDepartment.tennisBookALesson.rawValue) == .orderedSame
        {
            return .tennisBookALesson
        }
        //Added by kiran V2.9 -- GATHER0001167 -- Added support Golf BAL
        //GATHER0001167 -- Start
        else if departmentType.caseInsensitiveCompare(BMSDepartment.golfBookALesson.rawValue) == .orderedSame
        {
            return .golfBookALesson
        }
        //GATHER0001167 -- End
        return .none
    }
    
    
    //Added by kiran V2.8 -- ENGAGE0011784 --
    //ENGAGE0011784 -- Start
    
    //Add this function as with the recent chanegs adding of new BMS related module will cause comparision failures in amny places of code. To make changes or adding of another BMS related module easy. the comparision is done in this function.
    ///Indicates if the modules if of BMS or not
    func isBMSModule(_ module : AppModules) -> Bool
    {
        switch module
        {
        //Modified by kiran V2.9 -- GATHER0001167 -- Added golf book a lesson support
        //GATHER0001167 -- Start
        case .BMS,.bookALessonTennis,.fitnessSpa,.bookALessonGolf:
            //GATHER0001167 -- End
            return true
        case .events,.dining,.diningEvents,.golf,.tennis:
            return false
        }
    }
    
    ///Checks if the member is guest,existing guest or member.
    ///
    ///Only works for Detail, GuestInfo, GroupDetail Objects.
    func memberType(details : RequestData,For module : AppModules) -> MemberType
    {
        
        var memberType : MemberType!
        
        if let details = details as? Detail
        {
            if CustomFunctions.shared.isBMSModule(module)
            { //All the BMS modules logic comes here
                //If id is Nil or empty string then its a guest
                if (details.id ?? "").isEmpty
                {
                    memberType = .guest
                }
                //If id is not Nil or not an empty string and guestLinkedMemberID is not nil or not an empty string then its a Existing guest
                else if !(details.id ?? "").isEmpty && !(details.guestLinkedMemberID ?? "").isEmpty
                {
                    memberType = .existingGuest
                }
                //If id is not Nil or not an empty string then its a Member
                else if !(details.id ?? "").isEmpty
                {
                    memberType = .member
                }
            }
            else
            {//All the departments Apart from BMS comes here
                //If id is Nil or empty string and guestMemberOf is not nil or not an empty string then its a guest
                if (details.id ?? "").isEmpty && !(details.guestMemberOf ?? "").isEmpty
                {
                    memberType = .guest
                }
                //If id is not Nil or not an empty string and guestMemberOf is not nil or not an empty string then its a Existing guest
                else if !(details.id ?? "").isEmpty && !(details.guestMemberOf ?? "").isEmpty
                {
                    memberType = .existingGuest
                }
                //If id is not Nil or not an empty string and guestMemberOf is nil or an empty string then its a Member
                else if !(details.id ?? "").isEmpty && (details.guestMemberOf ?? "").isEmpty
                {
                    memberType = .member
                }
                
                /*Remove after V2.8 is released
                 if details.id == nil && details.guestMemberOf != nil
                 {
                     memberType = .guest
                 }
                 else if details.id != nil && details.guestMemberOf != nil
                 {
                     memberType = .existingGuest
                 }
                 else
                 {
                     memberType = .member
                 }
                 */
            }
            
        }
        else if let details = details as? GuestInfo
        {
            if CustomFunctions.shared.isBMSModule(module)
            { //All the BMS modules logic comes here
                
                //If linkedMemberID is Nil or empty string then its a guest
                if (details.linkedMemberID ?? "").isEmpty
                {
                    memberType = .guest
                }
                //If linkedMemberID is not Nil or not an empty string and guestLinkedMemberID is not nil or not an empty string then its a Existing guest
                else if !(details.linkedMemberID ?? "").isEmpty && !(details.guestLinkedMemberID ?? "").isEmpty
                {
                    memberType = .existingGuest
                }
                //If linkedMemberID is not Nil or not an empty string then its a Member
                else if !(details.linkedMemberID ?? "").isEmpty
                {
                    memberType = .member
                }
            }
            else
            {//All the departments Apart from BMS comes here
                
                //If linkedMemberID is Nil or empty string and guestMemberOf is not nil or not an empty string then its a guest
                if (details.linkedMemberID ?? "").isEmpty && !(details.guestMemberOf ?? "").isEmpty
                {
                    memberType = .guest
                }
                //If linkedMemberID is not Nil or not an empty string and guestMemberOf is not nil or not an empty string then its a Existing guest
                else if !(details.linkedMemberID ?? "").isEmpty && !(details.guestMemberOf ?? "").isEmpty
                {
                    memberType = .existingGuest
                }
                //If linkedMemberID is not Nil or not an empty string and guestMemberOf is nil or an empty string then its a Member
                else if !(details.linkedMemberID ?? "").isEmpty && (details.guestMemberOf ?? "").isEmpty
                {
                    memberType = .member
                }
                
                /* Remove after v2.8 release
                 if (details.linkedMemberID == nil && details.guestMemberOf != nil)
                 {
                     memberType = .guest
                 }
                 else if (details.linkedMemberID != nil && details.guestMemberOf != nil)
                 {
                     memberType = .existingGuest
                 }
                 else
                 {
                     memberType = .member
                 }
                 */
            }
        }
        else if let details = details as? GroupDetail
        {
            if CustomFunctions.shared.isBMSModule(module)
            { //All the BMS modules logic comes here
                //If id is Nil or empty string then its a guest
                if (details.id ?? "").isEmpty
                {
                    memberType = .guest
                }
                //If id is not Nil or not an empty string and guestLinkedMemberID is not nil or not an empty string then its a Existing guest
                else if !(details.id ?? "").isEmpty && !(details.guestLinkedMemberID ?? "").isEmpty
                {
                    memberType = .existingGuest
                }
                //If id is not Nil or not an empty string then its a Member
                else if !(details.id ?? "").isEmpty
                {
                    memberType = .member
                }
            }
            else
            {//All the departments Apart from BMS comes here
                
                //If id is Nil or empty string and guestMemberOf is not nil or not an empty string then its a guest
                if (details.id ?? "").isEmpty && !(details.guestMemberOf ?? "").isEmpty
                {
                    memberType = .guest
                }
                //If id is not Nil or not an empty string and guestMemberOf is not nil or not an empty string then its a Existing guest
                else if !(details.id ?? "").isEmpty && !(details.guestMemberOf ?? "").isEmpty
                {
                    memberType = .existingGuest
                }
                //If id is not Nil or not an empty string and guestMemberOf is nil or an empty string then its a Member
                else if !(details.id ?? "").isEmpty && (details.guestMemberOf ?? "").isEmpty
                {
                    memberType = .member
                }
                
                /* remove after v2.8 release
                 if ((details.id == nil || (details.id ?? "").isEmpty) && details.guestMemberOf != nil)
                 {
                     memberType = .guest
                 }
                 else if (details.id != nil && details.guestMemberOf != nil)
                 {
                     memberType = .existingGuest
                 }
                 else
                 {
                     memberType = .member
                 }
                 */
            }
        }
        
        return memberType
    }
    
    //ENGAGE0011784 -- End
    
    
    //Added by kiran V2.8 -- ENGAGE0011784 -- One function which can convert any member object into an array of members to be sent to member validation api's. need to check if this will work for save and modify api's as well
    //ENGAGE0011784 -- Start
    ///Returns an array of dictionary with the member details fromed from objects.
    ///
    ///Note:- In the nested array memberDetails. the first array indicated the groups(useful for Golf). in case of golf it will have 4 objects. for all other requests it should have only 1 object. the second array in the nested array conatins the members details. in case of golf each array includes the group members.
    func generateMembersDict(membersDetails : [[RequestData]],usedIn module : AppModules) -> [[String : Any]]
    {
        
        let tempAddedMembers = membersDetails
        
        var arrMembers = [[String : Any]]()
        
        //This is used to iterate through groups. except for golf this will always iterate once as only golf has 4 groups.The group number indecated the group which is being iterated. its starts with 0 so add 1 to the group number to get the actual group.
        for (groupNumber,group) in tempAddedMembers.enumerated()
        {
            let playerGroup = groupNumber + 1
            //This iterates through the members in each group. position indicates the order of members in the each group. as position starts from 0 so add with 1 to get the actual position of the member.
            for (position,member) in group.enumerated()
            {
                
                let playerOrder = position + 1
                
                if let member = member as? CaptaineInfo
                {
                    if let captainDict = self.generateCaptainInfoDict(groupNo: playerGroup, positionNo: playerOrder, details: member, module: module)
                    {
                        arrMembers.append(captainDict)
                    }
                    
                }
                else if let member = member as? Detail
                {
                    if let detailDict = self.generateDetailsDict(groupNo: playerGroup, positionNo: playerOrder, details: member, module: module)
                    {
                        arrMembers.append(detailDict)
                    }
                    
                }
                else if let member = member as? MemberInfo
                {
                    if let memberInfoDict = self.generateMemberInfoDict(groupNo: playerGroup, positionNo: playerOrder, details: member, module: module)
                    {
                        arrMembers.append(memberInfoDict)
                    }
                    
                }
                else if let member = member as? GuestInfo
                {
                    if let guestInfoDict = self.generateGuestInfoDict(groupNo: playerGroup, positionNo: playerOrder, details: member, module: module)
                    {
                        arrMembers.append(guestInfoDict)
                    }
                    
                }
                else if let member = member as? GuestChildren
                {
                    if let guestChildrenDict = self.generateGuestChildDict(groupNo: playerGroup, positionNo: playerOrder, details: member, module: module)
                    {
                        arrMembers.append(guestChildrenDict)
                    }
                }
                else if let member = member as? DiningMemberInfo
                {
                    if let diningMemberInfoDict = self.generateDiningMemberInfoDict(groupNo: playerGroup, positionNo: playerOrder, details: member, module: module)
                    {
                        arrMembers.append(diningMemberInfoDict)
                    }
                }
                else if let member = member as? GroupDetail
                {
                    if let groupDetailDict = self.generateGroupDetailsDict(groupNo: playerGroup, positionNo: playerOrder, details: member, module: module)
                    {
                        arrMembers.append(groupDetailDict)
                    }
                }
                
            }
            
        }
        
        return arrMembers
    }
    
    ///Returns a dictonary of member details for CaptainInfo object based on module.
    private func generateCaptainInfoDict(groupNo : Int, positionNo : Int, details : CaptaineInfo, module : AppModules) -> [String : Any]?
    {
        switch module
        {
        case .golf:
            
            let memberInfo:[String: Any] = [
                "PlayerLinkedMemberId": details.captainID ?? "",
                "ReservationRequestDetailId": "",
                "PlayerOrder": positionNo,
                "PlayerGroup": groupNo,
                "GuestMemberOf": "",
                "GuestType": "",
                "GuestName": "",
                "GuestEmail": "",
                "GuestContact": "",
                "AddBuddy": 0
                
            ]
            
            return memberInfo
            
        case .tennis:
            
            let memberInfo:[String: Any] = [
            "LinkedMemberID": details.captainID ?? "",
            "ReservationRequestDetailId": "",
            "PlayerOrder": positionNo,
            "GuestMemberOf": "",
            "GuestType": "",
            "GuestName": "",
            "GuestEmail": "",
            "GuestContact": "",
            "AddBuddy": 0
            
            ]
            
            return memberInfo

        case .dining,.diningEvents:
            
            let specialOccassionInfo:[String: Any] = [
                "Birthday":0,
                "Anniversary":0,
                "Other":0,
                "OtherText":""
            ]
            
            let memberInfo:[String: Any] = [
                "ReservationRequestDetailId": "",
                "LinkedMemberID": details.captainID ?? "",
                "GuestMemberOf": "",
                "GuestType": "",
                "GuestName": "",
                "GuestEmail": "",
                "GuestContact": "",
                "HighChairCount": 0,
                "BoosterChairCount": 0,
                "SpecialOccasion": [specialOccassionInfo],
                "DietaryRestrictions": "",
                "DisplayOrder": positionNo,
                "AddBuddy": 0
            ]
            
            return memberInfo
            
        case .events:
            
            let memberInfo:[String: Any] = [
                APIKeys.kMemberId : details.captainMemberID ?? "",
                APIKeys.kid : details.captainID ?? "",
                APIKeys.kParentId : details.captainParentID ?? "",
                "MemberName" : details.captainName ?? "",
                "Guest": 0,
                "Kids3Below": 0,
                "Kids3Above": 0,
                "IsInclude": 1,
                "IsPrimaryMember": 0,
                "DisplayOrder": positionNo
            ]
            
            return memberInfo

        //Modified by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
        //GATHER0001167 -- Start
        case .BMS,.bookALessonTennis,.fitnessSpa,.bookALessonGolf:
        //GATHER0001167 -- End
            let memberInfo:[String: Any] = [
                APIKeys.kAppointmentMemberID : "",
                APIKeys.kMemberLastName : "",
                APIKeys.kName : details.captainName ?? "",
                APIKeys.kLinkedMemberID : details.captainID ?? "",
                APIKeys.kGuestMemberOf : "",
                APIKeys.kGuestMemberNo : "",
                APIKeys.kGuestType : "",
                APIKeys.kGuestName : "",
                APIKeys.kGuestEmail : "",
                APIKeys.kGuestContact : "",
                APIKeys.kDisplayOrder : "\(positionNo)",
                APIKeys.kGuestGender : "",
                APIKeys.kGuestDOB : ""
            ]
            
            return memberInfo
        }

    }
    
    ///Returns a dictonary of member details for Detail object based on module.
    private func generateDetailsDict(groupNo : Int, positionNo : Int, details : Detail, module : AppModules) -> [String : Any]?
    {
        
        let memberType : MemberType = self.memberType(details: details, For: module)
        
        switch module
        {
        case .golf:
            
            switch memberType
            {
            case .member:
                
                let memberInfo:[String: Any] = [
                    "PlayerLinkedMemberId": details.id ?? "",
                    "ReservationRequestDetailId": details.reservationRequestDetailID ?? "",
                    "PlayerOrder": positionNo,
                    "PlayerGroup": groupNo,
                    "GuestMemberOf": "",
                    "GuestType": "",
                    "GuestName": "",
                    "GuestEmail": "",
                    "GuestContact": "",
                    "AddBuddy": details.addBuddy ?? 0
                    
                ]
                
                return memberInfo
                
            case .guest:
                
                let memberInfo:[String: Any] = [
                    "PlayerLinkedMemberId":  "",
                    "ReservationRequestDetailId": details.reservationRequestDetailID ?? "",
                    "PlayerOrder": positionNo,
                    "PlayerGroup": groupNo,
                    "GuestMemberOf": details.guestMemberOf ?? "",
                    "GuestType": details.guestType ?? "",
                    "GuestName": details.guestName ?? "",
                    "GuestEmail": details.email ?? "",
                    "GuestContact": details.cellPhone ?? "",
                    "AddBuddy": details.addBuddy ?? 0,
                    APIKeys.kGuestFirstName : details.guestFirstName ?? "",
                    APIKeys.kGuestLastName : details.guestLastName ?? "",
                    APIKeys.kGuestDOB : details.guestDOB ?? "",
                    APIKeys.kGuestGender : details.guestGender ?? ""
                    
                ]
                
                return memberInfo
                
            case .existingGuest:
                
                
                let memberInfo:[String: Any] = [
                    "PlayerLinkedMemberId": details.id ?? "",
                    "ReservationRequestDetailId": details.reservationRequestDetailID ?? "",
                    "PlayerOrder": positionNo,
                    "PlayerGroup": groupNo,
                    "GuestMemberOf": details.guestMemberOf ?? "",
                    "GuestType": "",
                    "GuestName": "",
                    "GuestEmail": "",
                    "GuestContact": "",
                    "AddBuddy": details.addBuddy ?? 0
                ]
                //TODO:- Remove after approval
                /*
                let memberInfo:[String: Any] = [
                    "PlayerLinkedMemberId":  details.id ?? "",
                    "ReservationRequestDetailId": details.reservationRequestDetailID ?? "",
                    "PlayerOrder": positionNo,
                    "PlayerGroup": groupNo,
                    "GuestMemberOf": details.guestMemberOf ?? "",
                    "GuestType": details.guestType ?? "",
                    "GuestName": details.guestName ?? "",
                    "GuestEmail": details.email ?? "",
                    "GuestContact": details.cellPhone ?? "",
                    "AddBuddy": details.addBuddy ?? 0,
                    APIKeys.kGuestFirstName : details.guestFirstName ?? "",
                    APIKeys.kGuestLastName : details.guestLastName ?? "",
                    APIKeys.kGuestDOB : details.guestDOB ?? "",
                    APIKeys.kGuestGender : details.guestGender ?? ""
                    
                ]
                 */
                
                return memberInfo
            }
            
        case .tennis:
            
            switch memberType
            {
            case .member:
                
                let memberInfo:[String: Any] = [
                "LinkedMemberID": details.id ?? "",
                "ReservationRequestDetailId": details.reservationRequestDetailID!,
                "PlayerOrder": positionNo,
                "GuestMemberOf": "",
                "GuestType": "",
                "GuestName": "",
                "GuestEmail": "",
                "GuestContact": "",
                "AddBuddy": 0
                
                ]
                
                return memberInfo

            case .guest:
                
                let memberInfo:[String: Any] = [
                    "LinkedMemberID": "",
                    "ReservationRequestDetailId": details.reservationRequestDetailID!,
                    "PlayerOrder": positionNo,
                    "GuestMemberOf": details.guestMemberOf ?? "",
                    "GuestType": details.guestType!,
                    "GuestName": details.guestName!,
                    "GuestEmail": details.email!,
                    "GuestContact": details.cellPhone!,
                    "AddBuddy": details.addBuddy!,
                    APIKeys.kGuestFirstName : details.guestFirstName ?? "",
                    APIKeys.kGuestLastName : details.guestLastName ?? "",
                    APIKeys.kGuestDOB : details.guestDOB ?? "",
                    APIKeys.kGuestGender : details.guestGender ?? ""
                ]
                
                return memberInfo
                
            case .existingGuest:
                
                let memberInfo:[String: Any] = [
                "LinkedMemberID": details.id ?? "",
                "ReservationRequestDetailId": details.reservationRequestDetailID!,
                "PlayerOrder": positionNo,
                "GuestMemberOf": details.guestMemberOf ?? "",
                "GuestType": "",
                "GuestName": "",
                "GuestEmail": "",
                "GuestContact": "",
                "AddBuddy": details.addBuddy ?? 0
                
                ]
                
                //TODO:- Remove after Approval
                /*
                let memberInfo:[String: Any] = [
                    "LinkedMemberID": details.id ?? "",
                    "ReservationRequestDetailId": details.reservationRequestDetailID!,
                    "PlayerOrder": positionNo,
                    "GuestMemberOf": details.guestMemberOf ?? "",
                    "GuestType": details.guestType!,
                    "GuestName": details.guestName!,
                    "GuestEmail": details.email!,
                    "GuestContact": details.cellPhone!,
                    "AddBuddy": details.addBuddy!,
                    APIKeys.kGuestFirstName : details.guestFirstName ?? "",
                    APIKeys.kGuestLastName : details.guestLastName ?? "",
                    APIKeys.kGuestDOB : details.guestDOB ?? "",
                    APIKeys.kGuestGender : details.guestGender ?? ""
                ]
                */
                return memberInfo
            }

        case .dining:
            break
        case .diningEvents:
            break
        case .events:
            break
        //Modified by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
        //GATHER0001167 -- Start
        case .BMS,.bookALessonTennis,.fitnessSpa,.bookALessonGolf:
            //GATHER0001167 -- End
            switch memberType
            {
            
            case .member:
                let memberInfo:[String: Any] = [
                    
                    APIKeys.kAppointmentMemberID : details.appointmentMemberID ?? "",
                    APIKeys.kMemberLastName : "",
                    APIKeys.kName : details.name ?? "",
                    APIKeys.kLinkedMemberID : details.id ?? "",
                    APIKeys.kGuestMemberOf : "",
                    APIKeys.kGuestMemberNo : "",
                    APIKeys.kGuestType : "",
                    APIKeys.kGuestName : "",
                    APIKeys.kGuestEmail : "",
                    APIKeys.kGuestContact : "",
                    APIKeys.kDisplayOrder : "\(positionNo)",
                    APIKeys.kGuestGender : "",
                    APIKeys.kGuestDOB : ""

                ]
                
                return memberInfo
                
            case .guest:
                
                let memberInfo:[String: Any] = [
        
                    APIKeys.kAppointmentMemberID : details.appointmentMemberID ?? "",
                    APIKeys.kMemberLastName : "",
                    APIKeys.kName : "",
                    APIKeys.kLinkedMemberID : "",
                    APIKeys.kGuestMemberOf : details.guestMemberOf ?? "",
                    APIKeys.kGuestMemberNo : "",
                    APIKeys.kGuestType : details.guestType ?? "",
                    APIKeys.kGuestName : details.guestName ?? "",
                    APIKeys.kGuestEmail : details.email ?? "",
                    APIKeys.kGuestContact : details.cellPhone ?? "",
                    APIKeys.kDisplayOrder : "\(positionNo)",
                    APIKeys.kGuestGender : details.guestGender ?? "",
                    APIKeys.kGuestDOB : details.guestDOB ?? "",
                    APIKeys.kGuestFirstName : details.guestFirstName ?? "",
                    APIKeys.kGuestLastName : details.guestLastName ?? "",
                    APIKeys.kGuestLinkedMemberID : details.guestLinkedMemberID ?? "",
                    APIKeys.kGuestIdentityID : details.guestIdentityID ?? ""
                    
                ]
                
                return memberInfo
                
            case .existingGuest:
                
                
                let memberInfo:[String: Any] = [
                    
                    APIKeys.kAppointmentMemberID : details.appointmentMemberID ?? "",
                    APIKeys.kMemberLastName : "",
                    APIKeys.kName : details.name ?? "",
                    APIKeys.kLinkedMemberID : details.id ?? "",
                    APIKeys.kGuestMemberOf : details.guestMemberOf ?? "",
                    APIKeys.kGuestMemberNo : "",
                    APIKeys.kGuestType : "",
                    APIKeys.kGuestName : "",
                    APIKeys.kGuestEmail : "",
                    APIKeys.kGuestContact : "",
                    APIKeys.kDisplayOrder : "\(positionNo)",
                    APIKeys.kGuestGender : "",
                    APIKeys.kGuestDOB : "",
                    APIKeys.kGuestLinkedMemberID : details.guestLinkedMemberID ?? "",
                    APIKeys.kGuestIdentityID : details.guestIdentityID ?? ""

                ]
                
                //TODO:- Remove after approval
                /*
                let memberInfo:[String: Any] = [
        
                    APIKeys.kAppointmentMemberID : details.appointmentMemberID ?? "",
                    APIKeys.kMemberLastName : "",
                    APIKeys.kName : "",
                    APIKeys.kLinkedMemberID : details.id ?? "",
                    APIKeys.kGuestMemberOf : details.guestMemberOf ?? "",
                    APIKeys.kGuestMemberNo : "",
                    APIKeys.kGuestType : details.guestType ?? "",
                    APIKeys.kGuestName : details.guestName ?? "",
                    APIKeys.kGuestEmail : details.email ?? "",
                    APIKeys.kGuestContact : details.cellPhone ?? "",
                    APIKeys.kDisplayOrder : "\(positionNo)",
                    APIKeys.kGuestGender : details.guestGender ?? "",
                    APIKeys.kGuestDOB : details.guestDOB ?? "",
                    APIKeys.kGuestFirstName : details.guestFirstName ?? "",
                    APIKeys.kGuestLastName : details.guestLastName ?? "",
                    APIKeys.kGuestLinkedMemberID : details.guestLinkedMemberID ?? ""
                ]
                */
                return memberInfo
                
            }
            
        }

        
        return nil
    }
    
    ///Returns a dictonary of member details for MemberInfo object based on module.
    private func generateMemberInfoDict(groupNo : Int, positionNo : Int, details : MemberInfo, module : AppModules) -> [String : Any]?
    {
        switch module
        {
        case .golf:
            let memberInfo:[String: Any] = [
                "PlayerLinkedMemberId": details.id ?? "",
                "ReservationRequestDetailId": "",
                "PlayerOrder": positionNo,
                "PlayerGroup": groupNo,
                "GuestMemberOf": "",
                "GuestType": "",
                "GuestName": "",
                "GuestEmail": "",
                "GuestContact": "",
                "AddBuddy": 0
            ]
            
            return memberInfo
            
        case .tennis:
            
            let memberInfo:[String: Any] = [
                "LinkedMemberID": details.id ?? "",
                "ReservationRequestDetailId": "",
                "PlayerOrder": positionNo,
                "GuestMemberOf": "",
                "GuestType": "",
                "GuestName": "",
                "GuestEmail": "",
                "GuestContact": "",
                "AddBuddy": 0
            ]
            
            return memberInfo

        case .dining:
            break
        case .diningEvents:
            break
        case .events:
            let memberInfo :[String: Any] = [
                APIKeys.kMemberId : details.memberID ?? "",
                APIKeys.kid : details.id ?? "",
                APIKeys.kParentId : details.parentid ?? "",
                "MemberName" : details.memberName ?? "",
                "Guest": details.guest ?? 0,
                "Kids3Below": details.kids3Below ?? 0,
                "Kids3Above": details.kids3Above ?? 0,
                "IsInclude": details.isInclude ?? 1,
                "IsPrimaryMember": 0,
                "DisplayOrder": positionNo
            ]
            
            return memberInfo
        //Modified by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
        //GATHER0001167 --Start
        case .BMS,.fitnessSpa,.bookALessonTennis,.bookALessonGolf:
            //GATHER0001167 -- End
            let memberInfo:[String: Any] = [
                
                APIKeys.kAppointmentMemberID : "",
                APIKeys.kMemberLastName : details.lastName ?? "",
                APIKeys.kName : details.memberName ?? "",
                APIKeys.kLinkedMemberID : details.id ?? "",
                APIKeys.kGuestMemberOf : "",
                APIKeys.kGuestMemberNo : "",
                APIKeys.kGuestType : "",
                APIKeys.kGuestName : "",
                APIKeys.kGuestEmail : "",
                APIKeys.kGuestContact : "",
                APIKeys.kDisplayOrder : "\(positionNo)",
                APIKeys.kGuestGender : "",
                APIKeys.kGuestDOB : ""

            ]
            
            return memberInfo
        }
        
        return nil
    }
    
    ///Returns a dictonary of member details for GuestInfo object based on module.
    private func generateGuestInfoDict(groupNo : Int, positionNo : Int, details : GuestInfo, module : AppModules) -> [String : Any]?
    {
        
        let memberType : MemberType = self.memberType(details: details, For: module)
        
        switch module
        {
        
        case .golf:
            
            switch memberType
            {
            case .guest:
                
                let memberInfo:[String: Any] = [
                    "PlayerLinkedMemberId": "",
                    "ReservationRequestDetailId": "",
                    "PlayerOrder": positionNo,
                    "PlayerGroup": groupNo,
                    "GuestMemberOf": details.guestMemberOf ?? "",
                    "GuestType": details.guestType!,
                    "GuestName": details.guestName!,
                    "GuestEmail": details.email!,
                    "GuestContact": details.cellPhone!,
                    "AddBuddy": details.addToMyBuddy!,
                    APIKeys.kGuestFirstName : details.guestFirstName ?? "",
                    APIKeys.kGuestLastName : details.guestLastName ?? "",
                    APIKeys.kGuestDOB : details.guestDOB ?? "",
                    APIKeys.kGuestGender : details.guestGender ?? ""
                ]
                
                return memberInfo
                
            case .existingGuest:
                
                let memberInfo:[String: Any] = [
                    "PlayerLinkedMemberId": details.linkedMemberID ?? "",
                    "ReservationRequestDetailId": "",
                    "PlayerOrder": positionNo,
                    "PlayerGroup": groupNo,
                    "GuestMemberOf": details.guestMemberOf ?? "",
                    "GuestType": "",
                    "GuestName": "",
                    "GuestEmail": "",
                    "GuestContact": "",
                    "AddBuddy": details.addToMyBuddy ?? 0
                    
                ]
                
                //TODO:- Remove after approval
                /*
                let memberInfo:[String: Any] = [
                    "PlayerLinkedMemberId": details.linkedMemberID ?? "",
                    "ReservationRequestDetailId": "",
                    "PlayerOrder": positionNo,
                    "PlayerGroup": groupNo,
                    "GuestMemberOf": details.guestMemberOf ?? "",
                    "GuestType": details.guestType!,
                    "GuestName": details.guestName!,
                    "GuestEmail": details.email!,
                    "GuestContact": details.cellPhone!,
                    "AddBuddy": details.addToMyBuddy!,
                    APIKeys.kGuestFirstName : details.guestFirstName ?? "",
                    APIKeys.kGuestLastName : details.guestLastName ?? "",
                    APIKeys.kGuestDOB : details.guestDOB ?? "",
                    APIKeys.kGuestGender : details.guestGender ?? ""
                ]
                 */
                
                return memberInfo
                
            case .member:
                break
            }
            
            
        case .tennis:
            
            switch memberType
            {
            case .guest:
                
                let memberInfo:[String: Any] = [
                    "LinkedMemberID": "",
                    "ReservationRequestDetailId": "",
                    "PlayerOrder": positionNo,
                    "GuestMemberOf": details.guestMemberOf ?? "",
                    "GuestType": details.guestType!,
                    "GuestName": details.guestName!,
                    "GuestEmail": details.email!,
                    "GuestContact": details.cellPhone!,
                    "AddBuddy": details.addToMyBuddy!,
                    APIKeys.kGuestFirstName : details.guestFirstName ?? "",
                    APIKeys.kGuestLastName : details.guestLastName ?? "",
                    APIKeys.kGuestDOB : details.guestDOB ?? "",
                    APIKeys.kGuestGender : details.guestGender ?? ""
                ]
                
                return memberInfo
                
            case .existingGuest:
                
                
                let memberInfo:[String: Any] = [
                "LinkedMemberID": details.linkedMemberID ?? "",
                "ReservationRequestDetailId": "",
                "PlayerOrder": positionNo,
                "GuestMemberOf": details.guestMemberOf ?? "",
                "GuestType": "",
                "GuestName": "",
                "GuestEmail": "",
                "GuestContact": "",
                "AddBuddy": details.addToMyBuddy ?? 0
                
                ]
                
                //TODO:- Remove after approval
                /*
                let memberInfo:[String: Any] = [
                    "LinkedMemberID": details.linkedMemberID ?? "",
                    "ReservationRequestDetailId": "",
                    "PlayerOrder": positionNo,
                    "GuestMemberOf": details.guestMemberOf ?? "",
                    "GuestType": details.guestType!,
                    "GuestName": details.guestName!,
                    "GuestEmail": details.email!,
                    "GuestContact": details.cellPhone!,
                    "AddBuddy": details.addToMyBuddy!,
                    APIKeys.kGuestFirstName : details.guestFirstName ?? "",
                    APIKeys.kGuestLastName : details.guestLastName ?? "",
                    APIKeys.kGuestDOB : details.guestDOB ?? "",
                    APIKeys.kGuestGender : details.guestGender ?? ""
                ]
                */
                return memberInfo
                
            case .member:
                break
            }
            
            
        case .dining,.diningEvents:
            
            
            switch memberType
            {
            case .guest:
                
                let specialOccassionInfo:[String: Any] = [
                    "Birthday": details.birthDay ?? 0,
                    "Anniversary": details.anniversary ?? 0,
                    "Other": details.other ?? 0,
                    "OtherText": details.otherText ?? ""
                ]
                
                let memberInfo:[String: Any] = [
                    "ReservationRequestDetailId": "",
                    "LinkedMemberID": "",
                    "GuestMemberOf": details.guestMemberOf ?? "",
                    "GuestType": details.guestType ?? "",
                    "GuestName": details.guestName ?? "",
                    "GuestEmail": details.email ?? "",
                    "GuestContact": details.cellPhone ?? "",
                    "HighChairCount": details.highChairCount ?? 0,
                    "BoosterChairCount": details.boosterChairCount ?? 0,
                    "SpecialOccasion": [specialOccassionInfo],
                    "DietaryRestrictions": details.dietaryRestrictions ?? 0,
                    "DisplayOrder": positionNo,
                    "AddBuddy": details.addToMyBuddy ?? 0,
                    APIKeys.kGuestFirstName : details.guestFirstName ?? "",
                    APIKeys.kGuestLastName : details.guestLastName ?? "",
                    APIKeys.kGuestDOB : details.guestDOB ?? "",
                    APIKeys.kGuestGender : details.guestGender ?? ""
                ]
                
               return memberInfo

            case .existingGuest:
                
                
                let specialOccassionInfo:[String: Any] = [
                    "Birthday": details.birthDay ?? 0,
                    "Anniversary": details.anniversary ?? 0,
                    "Other": details.other ?? 0,
                    "OtherText": details.otherText ?? ""
                ]
                
                
                let memberInfo:[String: Any] = [
                    "LinkedMemberID": details.linkedMemberID ?? "",
                    "ReservationRequestDetailId": "",
                    "GuestMemberOf": details.guestMemberOf ?? "",
                    "GuestType": "",
                    "GuestName": "",
                    "GuestEmail": "",
                    "GuestContact": "",
                    "HighChairCount": details.highChairCount ?? 0,
                    "BoosterChairCount": details.boosterChairCount ?? 0,
                    "SpecialOccasion": [specialOccassionInfo],
                    "DietaryRestrictions": details.dietaryRestrictions ?? 0,
                    "DisplayOrder": positionNo,
                    "AddBuddy": details.addToMyBuddy ?? 0
                ]
                //TODO:- Remove after approval
                /*
                let memberInfo:[String: Any] = [
                    "ReservationRequestDetailId": "",
                    "LinkedMemberID": details.linkedMemberID ?? "",
                    "GuestMemberOf": details.guestMemberOf ?? "",
                    "GuestType": details.guestType ?? "",
                    "GuestName": details.guestName ?? "",
                    "GuestEmail": details.email ?? "",
                    "GuestContact": details.cellPhone ?? "",
                    "HighChairCount": details.highChairCount ?? 0,
                    "BoosterChairCount": details.boosterChairCount ?? 0,
                    "SpecialOccasion": [specialOccassionInfo],
                    "DietaryRestrictions": details.dietaryRestrictions ?? 0,
                    "DisplayOrder": positionNo,
                    "AddBuddy": details.addToMyBuddy ?? 0,
                    APIKeys.kGuestFirstName : details.guestFirstName ?? "",
                    APIKeys.kGuestLastName : details.guestLastName ?? "",
                    APIKeys.kGuestDOB : details.guestDOB ?? "",
                    APIKeys.kGuestGender : details.guestGender ?? ""
                ]
                */
               return memberInfo
                
            case .member:
                break
            }
            
            
        case .events:
            break
            
        //Modified by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
        //GATHER0001167 -- Start
        case .BMS,.bookALessonTennis,.fitnessSpa,.bookALessonGolf:
            //GATHER0001167 -- End
            
            switch memberType
            {
            case .guest:
                
                let memberInfo:[String: Any] = [
                    
                    APIKeys.kAppointmentMemberID : "",
                    APIKeys.kMemberLastName : "",
                    APIKeys.kName : "",
                    APIKeys.kLinkedMemberID : "",
                    APIKeys.kGuestMemberOf : details.guestMemberOf ?? "",
                    APIKeys.kGuestMemberNo : "",
                    APIKeys.kGuestType : details.guestType ?? "",
                    APIKeys.kGuestName : details.guestName ?? "",
                    APIKeys.kGuestEmail : details.email ?? "",
                    APIKeys.kGuestContact : details.cellPhone ?? "",
                    APIKeys.kDisplayOrder : "\(positionNo)",
                    APIKeys.kGuestGender : details.guestGender ?? "",
                    APIKeys.kGuestDOB : details.guestDOB ?? "",
                    APIKeys.kGuestFirstName : details.guestFirstName ?? "",
                    APIKeys.kGuestLastName : details.guestLastName ?? "",
                    APIKeys.kGuestLinkedMemberID : details.guestLinkedMemberID ?? "",
                    APIKeys.kGuestIdentityID : details.guestIdentityID ?? ""

                ]
                
                return memberInfo
                
            case .existingGuest:
                
                
                let memberInfo:[String: Any] = [
                    
                    APIKeys.kAppointmentMemberID : details.appointmentMemberID ?? "",
                    APIKeys.kMemberLastName : "",
                    APIKeys.kName : details.guestName ?? "",
                    APIKeys.kLinkedMemberID : details.linkedMemberID ?? "",
                    APIKeys.kGuestMemberOf : details.guestMemberOf ?? "",
                    APIKeys.kGuestMemberNo : "",
                    APIKeys.kGuestType : "",
                    APIKeys.kGuestName : "",
                    APIKeys.kGuestEmail : "",
                    APIKeys.kGuestContact : "",
                    APIKeys.kDisplayOrder : "\(positionNo)",
                    APIKeys.kGuestGender : "",
                    APIKeys.kGuestDOB : "",
                    APIKeys.kGuestLinkedMemberID : details.guestLinkedMemberID ?? "",
                    APIKeys.kGuestIdentityID : details.guestIdentityID ?? ""

                ]
                
                //TODO:- Remove after approval
                /*
                let memberInfo:[String: Any] = [
                    
                    APIKeys.kAppointmentMemberID : "",
                    APIKeys.kMemberLastName : "",
                    APIKeys.kName : "",
                    APIKeys.kLinkedMemberID : details.linkedMemberID ?? "",
                    APIKeys.kGuestMemberOf : details.guestMemberOf ?? "",
                    APIKeys.kGuestMemberNo : "",
                    APIKeys.kGuestType : details.guestType ?? "",
                    APIKeys.kGuestName : details.guestName ?? "",
                    APIKeys.kGuestEmail : details.email ?? "",
                    APIKeys.kGuestContact : details.cellPhone ?? "",
                    APIKeys.kDisplayOrder : "\(positionNo)",
                    APIKeys.kGuestGender : details.guestGender ?? "",
                    APIKeys.kGuestDOB : details.guestDOB ?? "",
                    APIKeys.kGuestFirstName : details.guestFirstName ?? "",
                    APIKeys.kGuestLastName : details.guestLastName ?? "",
                    APIKeys.kGuestLinkedMemberID : details.guestLinkedMemberID ?? ""
                ]
                 */
                
                return memberInfo
                
            case .member:
                break
            }
            
        }
        
        return nil
    }
    
    ///Returns a dictonary of member details for GuestChildren object based on module.
    private func generateGuestChildDict(groupNo : Int, positionNo : Int, details : GuestChildren, module : AppModules) -> [String : Any]?
    {
        
        switch module
        {
        case .golf:
            break
        case .tennis:
            break
        case .dining:
            break
        case .diningEvents:
            break
        case .events:
            
            let memberInfo :[String: Any] = [
                APIKeys.kMemberId : details.memberId ?? "",
                APIKeys.kid : details.selectedID ?? "",
                APIKeys.kParentId : details.parentID ?? "",
                "MemberName" : details.name ?? "",
                "Guest": details.guestCount ?? 0,
                "Kids3Below": details.kids3Below ?? 0,
                "Kids3Above": details.kids3Above ?? 0,
                "IsInclude": details.isInclude ?? 1,
                "IsPrimaryMember": 0,
                "DisplayOrder": positionNo
            ]
            
            return memberInfo
        //Modified by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
        //GATHER0001167 -- Start
        case .BMS,.bookALessonTennis,.fitnessSpa,.bookALessonGolf:
            //GATHER0001167 -- End
            break
        }

        
        return nil
    }
    
    ///Returns a dictonary of member details for DiningMemberInfo object based on module.
    private func generateDiningMemberInfoDict(groupNo : Int, positionNo : Int, details : DiningMemberInfo, module : AppModules) -> [String : Any]?
    {
        
        switch module
        {
        case .golf:
            break
        case .tennis:
            break
        case .dining,.diningEvents:
            
            let specialOccassionInfo:[String: Any] = [
                "Birthday": details.birthDay ?? 0,
                "Anniversary": details.anniversary ?? 0,
                "Other": details.other ?? 0,
                "OtherText": details.otherText ?? ""
            ]
            
            let memberInfo:[String: Any] = [
                "ReservationRequestDetailId": "",
                "LinkedMemberID": details.linkedMemberID ?? "",
                "GuestMemberOf": "",
                "GuestType": "",
                "GuestName": "",
                "GuestEmail": "",
                "GuestContact": "",
                "HighChairCount": details.highChairCount ?? 0,
                "BoosterChairCount": details.boosterChairCount ?? 0,
                "SpecialOccasion": [specialOccassionInfo],
                "DietaryRestrictions": details.dietaryRestrictions ?? 0,
                "DisplayOrder": positionNo,
                "AddBuddy": 0
            ]
            
            return memberInfo
            
        case .events:
            break
        //Modified by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
        //GATHER0001167 -- Start
        case .BMS,.bookALessonTennis,.fitnessSpa,.bookALessonGolf:
            //GATHER0001167 -- End
            break
        }

        
        return nil
    }
    
    ///Returns a dictonary of member details for GroupDetail object based on module.
    private func generateGroupDetailsDict(groupNo : Int, positionNo : Int, details : GroupDetail, module : AppModules) -> [String : Any]?
    {
        
        let memberType : MemberType = self.memberType(details: details, For: module)
        
        switch module
        {
        case .golf:
            break
        case .tennis:
            break
        case .dining,.diningEvents:
            
            switch memberType
            {
            case .guest:
                
                let specialOcassionDetails = details.specialOccasion?.first
                
                let specialOccassionInfo:[String: Any] = [
                    "Birthday": specialOcassionDetails?.birthDay ?? 0,
                    "Anniversary": specialOcassionDetails?.anniversary ?? 0,
                    "Other": specialOcassionDetails?.other ?? 0,
                    "OtherText": specialOcassionDetails?.otherText ?? ""
                ]
                
                let memberInfo:[String: Any] = [
                    "LinkedMemberID": "",
                    "ReservationRequestDetailId": details.reservationRequestDetailId!,
                    "GuestMemberOf": details.guestMemberOf ?? "",
                    "GuestType": details.guestType ?? "",
                    "GuestName": details.guestName ?? "",
                    "GuestEmail": details.email ?? "",
                    "GuestContact": details.cellPhone ?? "",
                    "HighChairCount": details.highchair ?? 0,
                    "BoosterChairCount": details.boosterCount ?? 0,
                    "SpecialOccasion": [specialOccassionInfo],
                    "DietaryRestrictions": details.dietary ?? "",
                    "DisplayOrder": positionNo,
                    "AddBuddy": details.addBuddy ?? 0,
                    APIKeys.kGuestFirstName : details.guestFirstName ?? "",
                    APIKeys.kGuestLastName : details.guestLastName ?? "",
                    APIKeys.kGuestDOB : details.guestDOB ?? "",
                    APIKeys.kGuestGender : details.guestGender ?? ""
                ]
                
                return memberInfo
                
            case .existingGuest:

                let specialOcassionDetails = details.specialOccasion?.first
                
                let specialOccassionInfo:[String: Any] = [
                    "Birthday": specialOcassionDetails?.birthDay ?? 0,
                    "Anniversary": specialOcassionDetails?.anniversary ?? 0,
                    "Other": specialOcassionDetails?.other ?? 0,
                    "OtherText": specialOcassionDetails?.otherText ?? ""
                ]
                
                let memberInfo:[String: Any] = [
                    "LinkedMemberID": details.id ?? "",
                    "ReservationRequestDetailId": details.reservationRequestDetailId!,
                    "GuestMemberOf": details.guestMemberOf ?? "",
                    "GuestType": "",
                    "GuestName": "",
                    "GuestEmail": "",
                    "GuestContact": "",
                    "HighChairCount": details.highchair ?? 0,
                    "BoosterChairCount": details.boosterCount ?? 0,
                    "SpecialOccasion": [specialOccassionInfo],
                    "DietaryRestrictions": details.dietary ?? "",
                    "DisplayOrder": positionNo,
                    "AddBuddy": details.addBuddy ?? 0
                ]
                
                //TODO:- Remove after Approval
                /*
                let memberInfo:[String: Any] = [
                    "LinkedMemberID": details.id ?? "",
                    "ReservationRequestDetailId": details.reservationRequestDetailId!,
                    "GuestMemberOf": details.guestMemberOf ?? "",
                    "GuestType": details.guestType ?? "",
                    "GuestName": details.guestName ?? "",
                    "GuestEmail": details.email ?? "",
                    "GuestContact": details.cellPhone ?? "",
                    "HighChairCount": details.highchair ?? 0,
                    "BoosterChairCount": details.boosterCount ?? 0,
                    "SpecialOccasion": [specialOccassionInfo],
                    "DietaryRestrictions": details.dietary ?? "",
                    "DisplayOrder": positionNo,
                    "AddBuddy": details.addBuddy ?? 0,
                    APIKeys.kGuestFirstName : details.guestFirstName ?? "",
                    APIKeys.kGuestLastName : details.guestLastName ?? "",
                    APIKeys.kGuestDOB : details.guestDOB ?? "",
                    APIKeys.kGuestGender : details.guestGender ?? ""
                ]
                */
                return memberInfo
                
            case .member:
                
                let specialOcassionDetails = details.specialOccasion?.first
                
                let specialOccassionInfo:[String: Any] = [
                    "Birthday": specialOcassionDetails?.birthDay ?? 0,
                    "Anniversary": specialOcassionDetails?.anniversary ?? 0,
                    "Other": specialOcassionDetails?.other ?? 0,
                    "OtherText": specialOcassionDetails?.otherText ?? ""
                ]
                
                let memberInfo:[String: Any] = [
                    "LinkedMemberID": details.id ?? "",
                    "ReservationRequestDetailId": details.reservationRequestDetailId!,
                    "GuestMemberOf": "",
                    "GuestType": "",
                    "GuestName": "",
                    "GuestEmail": "",
                    "GuestContact": "",
                    "HighChairCount": details.highchair ?? 0,
                    "BoosterChairCount": details.boosterCount ?? 0,
                    "SpecialOccasion": [specialOccassionInfo],
                    "DietaryRestrictions": details.dietary ?? "",
                    "DisplayOrder": positionNo,
                    "AddBuddy": 0
                ]
               
                return memberInfo

            }
            
        case .events:
            break
        //Modified by kiran V2.9 -- GATHER0001167 -- Added support for Golf BAL
        //GATHER0001167 -- Start
        case .BMS,.bookALessonTennis,.fitnessSpa,.bookALessonGolf:
            //GATHER0001167 -- End
            break
        }
        
        return nil
    }
    //ENGAGE0011784 -- End
    
    //Added by kiran V2.9 -- ENGAGE0012323 -- Implementing App tracking Transperency changes
    //ENGAGE0012323 -- Start
    func gimbalHasAllPermissions() -> (status : Bool, permissionError : [BeaconPermissions])
    {
        var bluetoothAuthorised : Bool = false
        var locationAuthorised : Bool = false
        var trackingAuthorised : Bool = false
        
        var permissionNotGiven : [BeaconPermissions] = [BeaconPermissions]()
        
        if #available(iOS 13.0, *)
        {
            
            if self.appDelegate.bluetoothManager?.authorization == .allowedAlways
            {
                bluetoothAuthorised = true
            }
            else
            {
                permissionNotGiven.append(.bluetooth)
            }
        }
        else
        {
            bluetoothAuthorised = true
        }
       
        
        if #available(iOS 14.5, *)
        {
            if ATTrackingManager.trackingAuthorizationStatus == .authorized
            {
                trackingAuthorised = true
            }
            else
            {
                permissionNotGiven.append(.appTracking)
            }
        }
        else
        {
            trackingAuthorised = true
        }
        
        if #available(iOS 14.0, *)
        {
            if self.appDelegate.locationManager?.authorizationStatus == .authorizedAlways || self.appDelegate.locationManager?.authorizationStatus == .authorizedWhenInUse
            {
                locationAuthorised = true
            }
            else
            {
                permissionNotGiven.append(.location)
            }
        }
        else
        {
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||  CLLocationManager.authorizationStatus() == .authorizedAlways
            {
                locationAuthorised = true
            }
            else
            {
                permissionNotGiven.append(.location)
            }
        }
        
        return ((bluetoothAuthorised && locationAuthorised && trackingAuthorised),permissionNotGiven)
    }
    
    //Added by kiran V3.0 -- ENGAGE0011843
    //ENGAGE0011843 -- Start
    ///Returns the Guest Type/relation display name. This uses arrGuestType Array.
    func guestTypeDisplayName(id: String?) -> String
    {
        guard let id = id else{
            return ""
        }
        
        return self.appDelegate.arrGuestType.first(where: {$0.value == id})?.text ?? ""
    }
    //ENGAGE0011843 -- End
    
    //Added by kiran V3.0 -- ENGAGE0011722 -- Logs the error to firebase
    //ENGAGE0011722 -- Start
    ///Logs the error to firebase.
    func logError(error : NSError)
    {
        
        Crashlytics.crashlytics().record(error: error)
    }
    //ENGAGE0011722 -- End
    
}

//ENGAGE0012323 -- End

//GATHER0000700 - End

