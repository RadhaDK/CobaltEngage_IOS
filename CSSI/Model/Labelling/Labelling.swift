

import Foundation
import Foundation
import ObjectMapper

class Labelling: NSObject, Mappable {
    
    var responseCode : String?
    var responseMessage : String?
    
    var langUK : LangUK?
    var langUS : LangUS?
    var langGE : LangGE?

    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
      
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        langUS <- map["en-US"]
        langUK <- map["en-UK"]
        langGE <- map["en-GE"]

        
    }
    
}


class LangGE: NSObject, Mappable  {
    
    var label : Label?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        label <- map["labels"]
    }
}



class LangUS: NSObject, Mappable  {
    var label : Label?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
         label <- map["labels"]
    }
}
class LangUK: NSObject, Mappable  {
    var label : Label?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        label <- map["labels"]
    }
}

class MainLangauage: NSObject, Mappable  {
    var label : Label?
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        label <- map["labels"]
    }
}




class Label: NSObject, Mappable  {
    
    var cURRENCY : String?
    var iNTERNET_CONNECTION_ERROR : String?
    var rEQUEST_FAILED : String?
    var tT_STATEMENTS : String?
    var tT_NOTIFICATIONS : String?
    var tT_PROFILE : String?
    var tT_ADD_GUEST : String?
    var tT_ALL_EVENTS : String?
    var tT_PREFERENCES : String?
    var tT_GUEST_CARD : String?
    var tT_MEMBER_ID : String?
    var tT_RESTAURANTS : String?
    var tT_MEMBER_DIRECTORY : String?
    var tT_GIFT_CARD : String?
    var tT_IMPORTANT_NUMBERS : String?
    var tT_GIFT_CARD_DETAIL : String?
    var tT_TRANSACTION_DETAILS : String?
    var tAB_CURRENT : String?
    var tAB_PREVIOUS : String?
    var tITLE_HOME : String?
    var tITLE_GUEST_CARD : String?
    var tITLE_STATEMENTS : String?
    var tITLE_MORE : String?
    var mEMBER_DIRECTORE : String?
    var iMPORTANT_NUMBER : String?
    var rESTAURTENT_MENU : String?
    var gIFT_CARD : String?
    var mEMBER_ID : String?
    var lOGOUT : String?
    var lOADING : String?
    var rES_ERR : String?
    var tAB_GUEST_LIST : String?
    var tAB_REQUEST_CARD : String?
    var tAB_ALL_REQUEST : String?
    var aRRIVED : String?
    var dEPARTED : String?
    var hINT_MEMBER_ID : String?
    var hINT_USERNAME : String?
    var hINT_PASSWORD : String?
    var tITLE_LOGIN : String?
    var tITLE_FORGOT_PWD : String?
    var eRR_MSG_ID : String?
    var eRR_MSG_PASSWORD : String?
    var fORGOT_PAGE_TV : String?
    var hINT_ENTER_EMAIL : String?
    var sEND : String?
    var eRR_MSG_EMAIL : String?
    var gO_BACK_TO_LOGIN : String?
    var rESET_EMAIL_TEXT : String?
    var hI : String?
    var eXCLAMATORY : String?
    var mORE : String?
    var vIEW_ALL : String?
    var lATEST_NOTIFICATION : String?
    var uPCOMING_EVENTS : String?
    var tODAY_AT_A_GLANCE : String?
    var cLOSE : String?
    var nOTES : String?
    var uPCOMING_VISITS : String?
    var rEQUEST_GUEST_CARD : String?
    var aDD_GUEST : String?
    var nO_UPCOMING_VISITS : String?
    var gUEST_REQUEST_CANCELLED : String?
    var gUEST_REQUEST_MODIFIED : String?
    var fIRST_NAME : String?
    var lAST_NAME : String?
    var pHONE_NUMBER : String?
    var pRIMARY_EMAIL : String?
    var aGE : String?
    var gENDER : String?
    var mALE : String?
    var fEMALE : String?
    var aDD : String?
    var cANCEL : String?
    var sUB_TOTAL : String?
    var tAX_7 : String?
    var tOTAL : String?
    var gIFT_CHARGES_ARRIVAL : String?
    var iGNORE : String?
    var rEQUEST : String?
    var mODIFY : String?
    var aDD_TO_BUDDY_LIST : String?
    var aDD_TO_PHONE : String?
    var pROFILE : String?
    var hASH : String?
    var bIRTHDAY : String?
    var aNNIVERSARY : String?
    var mEMBERSHIP_TYPE : String?
    var pREFERENCES : String?
    var aDD_ONS : String?
    var iNTERESTS : String?
    var bOCA_WEST : String?
    var mOBILE : String?
    var aDDRESS_BOCA_WEST : String?
    var vISIBLE : String?
    var nOTIFICATIONS : String?
    var uSER_NAME : String?
    var pASSWORD : String?
    var passwordRulsTitle : String?
    var passwordRuls1 : String?
    var passwordRuls2 : String?
    var passwordRuls3 : String?
    var passwordRuls4: String?
    var rESET : String?
    var sAVE : String?
    var dISPLAY_NAME : String?
    var eMAIL : String?
    var sECONDARY_EMAIL : String?
    var mAILING_ADDRESS : String?
    var aDDRESS_OTHER : String?
    var sTREET_1 : String?
    var sTREET_2 : String?
    var cITY : String?
    var sTATE : String?
    var zIP : String?
    var cOUNTY : String?
    var aDD_ANOTHER_ADDRESS : String?
    var rESET_PASSWORD : String?
    var nEW_PASSWORD : String?
    var cONFIRM_PASSWORD : String?
    var dO_NOT_SHOW_ME_IN_THE_ONLINE_MEMBER_DIRECTORY : String?
    var dATE : String?
    var cODE : String?
    var aMOUNT : String?
    var dESCRIPTION : String?
    var rEG_NO : String?
    var rECEIPT_NO : String?
    var eMPLOYEE : String?
    var mEMBER_NAME : String?
    var mEMBER_NO : String?
    var nO : String?
    var iTEMS : String?
    var yOU_SAVED : String?
    var tAX : String?
    var tIP : String?
    var cERTIFICATE_NCARD_TYPE : String?
    var oRIGINAL_NAMOUNT : String?
    var bALANCE_NAMOUNT : String?
    var iSSUED_DATE : String?
    var eXPIRY_DATE : String?
    var mONTH : String?
    var fILTER_BY_INTEREST : String?
    var hOME_PHONE : String?
    var cELL_PHONE : String?
    var oTHER : String?
    var bACK : String?
    var hINT_FROM_DATE : String?
    var hINT_TO_DATE : String?
    var mTD : String?
    var cHOOSE_RELATION : String?
    var eRR_VALID_FNAME : String?
    var eRR_VALID_LNAME : String?
    var eRR_VALID_RELATION : String?
    var eRROR_UNAME : String?
    var eRROR_NEW_PWD : String?
    var eRROR_CONFIRM_PWD : String?
    var eRROR_PWD_MATCH : String?
    var eRROR : String?
    var rESET_SUCCESSFUL : String?
    var aUTHENTICATION_FAILED : String?
    var eRROR_OCCURRED : String?
    var pROFILE_UPDATED_SUCCESSFULLY : String?
    var nOTIFICATION_DISABLED : String?
    var nO_FURTHER_NOTIFICATIONS : String?
    var nOTIFICATION_ENABLED : String?
    var sTART_RECEIVE_NOTIFICATION : String?
    var nO_EMPTY_DATE : String?
    var gUEST_ADDED : String?
    var sELECT_RELAION : String?
    var eXCEPTION : String?
    var cONTACT_ADDED : String?
    var cONACT_ALREADY_ADDED : String?
    var vALID_LAST_NAME : String?
    var nO_RECORD_FOUND : String?
    var gUEST_REQUEST_ERROR : String?
    var eDIT : String?
    var gALLERY : String?
    var cAMERA : String?
    var nO_NEW_NOTIFICATION : String?
    var hIDDEN : String?
    var qTY : String?
    var dATE_CANT_BE_EMPTY : String?
    var fROM_DATE_LESS : String?
    var nO_UPDATE_GLANCE : String?
    var register_your_device : String?
    var search_Guest : String?
    var new_Guest_Card: String?
    var New_Visit: String?
    var modify_Visit: String?
    var modify: String?
    var add_Visit: String?
    var history: String?
    var cancel_Card: String?
    var guest_Card_History: String?
    var no_Record_Found: String?
    var date: String?
    var relation: String?
    var deparment: String?
    var done: String?
    var first_Name: String?
    var last_Name: String?
    var date_Of_Birth: String?
    var Phone: String?
    var email: String?
    var visit: String?
    var duration: String?
    var accompanying_Guest_During_Check_in: String?
    var Yes: String?
    var No: String?
    var add_Photo_ID: String?
    var Add_Guest_Photo: String?
    var Save: String?
    var guest_Card_Policy_Title: String?
    var select_Guest: String?
    var upcoming_Visit: String?
    var extended_By: String?
    var charges_Will_Not_Appear: String?
    var First_Name_is_required: String?
    var Last_Name_is_required: String?
    var Relation_is_required: String?
    var Date_Of_Birth_is_required: String?
    var phone_Is_Required: String?
    var email_Is_Required: String?
    var visit_Is_Required: String?
    var duration_Is_Required: String?
    var photo_ID_Is_Required: String?
    var guest_Photo_Is_Required: String?
    var select_Guest_Is_Required: String?
    var upcoming_Visit_Is_Required: String?
    var Extend_Is_Required: String?
    var email_Validation: String?
    var dob_min: String?
    var thank_You: String?
    var guest_save_validation1: String?
    var guest_save_validation2: String?
    var guest_save_validation3: String?
    var guest_modify_validation: String?
    var YOUR_EVENT_UPDATE: String?
    var YOUR_EVENT_REQUEST: String?
    var guest_suspended_validation1: String?
    var guestcard_policy_title: String?
    var guestcard_policy_1: String?
    var guestcard_policy_2: String?
    var guestcard_policy_3: String?
    var guestcard_policy_4: String?
    var cancel_guest_card: String?
    var guest_card_has_been_cancelled: String?
    var last_Visited: String?
    var days_visited: String?
    var total_days: String?
    var day: String?
    var days: String?
    var send_us_feedback: String?
    var provide_feedback: String?
    var appreciate_feedback: String?
    var calendar_of_events: String?
    var calendar_title: String?
    var search: String?
    var menus_hours: String?
    var tee_times: String?
    var recent_news: String?
    var tournament_forms: String?
    var instructional_videos: String?
    var instructional_videos_dining: String?
    var rules_etiquettes: String?
    var court_times: String?
    var court_time: String?
    var dining_reservations: String?
    var dress_code: String?
    var download_statement: String?
    var important_club_numbers: String?
    var board_of_governers: String?
    var forgot_your_password: String?
    var enter_your_email: String?
    var send: String?
    var please_chek_your_email: String?
    var enter_your_security_code: String?
    var OK: String?
    var resend_security_code: String?
    var new_password: String?
    var confirm_password: String?
    var enter_new_password: String?
    var password_being_created: String?
    var didYouKnow: String?
    var didYouKnowClubNews: String?
    var didYouKnowEvents: String?
    var didYouKnowGlance: String?
    var didYouKnowMemberDire1: String?
    var didYouKnowMemberDire2: String?
    var didYouKnowMemberDire3: String?
    var didYouKnowStatement: String?
    var ableToViewByCategory: String?
    var dlOrPassport: String?
    var guest_card_policy: String?
    
    var show_or_hide_myprofile: String?
    var suffix: String?
    var middle_name: String?
    var other_phone: String?
    var turn_email_notification: String?
    var send_statements_to: String?
    var send_statements_to_colon: String?
    var send_magazine_to_colon: String?
    
    var send_magazines_to: String?
    var address_other: String?
    var street_address_1: String?
    var street_address_2: String?
    var state_or_Province: String?
    var postal_code: String?
    var outside_us: String?
    var address_bussiness: String?
    var address_bocawest: String?
    var targetting_market_option: String?
    var prefix: String?
    var my_Interest: String?
    var username: String?
    var register: String?
    var status: String?
    var comments: String?
    var additionalEventDetails: String?
    var captain: String?
    var tickets: String?
    var cancel_reservation: String?
    var YOUR_EVENT_CANCEL: String?
    var DO_YOU_WANT_CANCEL: String?
    var alert: String?
    var external_reg: String?
    var add_to_buddylist: String?
    var add_member: String?
    var add_mybuddy: String?
    var current_password: String?
    var event_registration: String?
    var event_details: String?
    var calendar_synch_success: String?
    var person: String?
    var add_member_or_guest: String?
    var memberProfile_succss: String?
    var please_select_Member: String?
    var please_addGuest: String?
    var search_events: String?
    var search_buddyname_Id: String?
    var search_guest_Name: String?
    var search_imp_clubNumbers: String?
    var search_memberName_id: String?
    var search_News: String?
    var search_Notifications: String?
    var search_Statement: String?
    var eventUrl: String?
    var clubnewsUrl: String?
    var type_guest_name: String?
    var usa: String?
    var moreInfo: String?
    var event_request: String?
    var event_modify: String?
    var event_cancel: String?
    
    
    
    var reservation_comments: String?
    var special_request_add: String?
    var party_size: String?
    var reservation_time: String?
    var select_restaurant: String?
    var dining_request: String?
    var tennis_policy: String?
    var request_ball_machine: String?
    var players: String?
    var player: String?
    var not_later_than: String?
    var not_earlier_than: String?
    var tennis_request_date: String?
    var request_court_time: String?
    var exclude_course: String?
    var preffered_course: String?
    var golf_policy: String?
    var groups_link: String?
    var group_count: String?
    var earliest_tee_time: String?
    var preferred_tee_time: String?
    var select_request_date: String?
    var request_tee_time: String?
    var dining_calendar: String?
    var upcoming_dining_times: String?
    var upcoming_court_times: String?
    var tennis_calendar: String?
    var upcoming_tennis_events: String?
    var remove_from_mybuddylist: String?
    var upcoming_teetimes: String?
    var up_coming_golf_events: String?
    var golf_calendar: String?
    
    var share: String?
    var round_length: String?
    var notpreferred_course: String?
    var preferred_course_colon: String?
    var tee_time_colon: String?
    var course_time_colon: String?
    var duration_colon: String?
    var match_colon: String?
    var confirmed_court_time: String?
    var upcoming_reservations: String?
    var removeBuddy_confirmation: String?
    var removeBuddy_succes: String?
    var removeGroup_confirmation: String?
    var removeGroup_succes: String?
    var link_groups: String?
    
    var tee_time_details: String?
    var court_time_details: String?
    var dining_reservation_details: String?
    var rEQUEST_COURT: String?
    var sINGLES: String?
    var dOUBLES: String?
    var view_groups: String?
    var dining_policy: String?
    
    var gOLF_POLICY_1: String?
    var gOLF_POLICY_2: String?
    var gOLF_POLICY_3: String?
    var gOLF_POLICY_4: String?
    var tENNIS_POLICY_1: String?
    var tENNIS_POLICY_2: String?
    var tENNIS_POLICY_3: String?
    var tENNIS_POLICY_4: String?
    var dINING_POLICY_1: String?
    var dINING_POLICY_2: String?
    var dINING_POLICY_3: String?
    var dINING_POLICY_4: String?
    var rESTAURANT_COLON: String?
    var special_request: String?
    var cOMMENTS_COLON: String?
    var time_colon: String?
    var additional_details: String?
    
    var cOURT_REQUEST_SUCCESS_MESSAGE1: String?
    var cOURT_REQUEST_SUCCESS_MESSAGE2: String?
    var dINING_REQUEST_SUCCESS_MESSAGE1: String?
    var dINING_REQUEST_SUCCESS_MESSAGE2: String?
    var dIETARY_RESTRICTIONS_INFO: String?
    var pOLICY_TEXT_COLON: String?
    var eXCLUDE_COURSE_COLON: String?
    var rESTAURTENT_NAME_COLON: String?
    var gOLF_REQUEST_SUCCESS_MESSAGE1: String?
    var gOLF_REQUEST_SUCCESS_MESSAGE2: String?
    var gOLF_REQUEST_SUCCESS_MESSAGE_FCFS: String?
    var link_groups_colon: String?
    var select_restaurant_colon: String?
    var cOURT_REQUEST_MULTIDAY_SUCCESS_MESSAGE1: String?
    var cOURT_REQUEST_MULTIDAY_SUCCESS_MESSAGE2: String?
    var rESTAURANT_NAME_COLON: String?
    var mYGROUP_CREATED_SUCCESS_MESSAGE: String?
    var mYGROUP_UPDATED_SUCCESS_MESSAGE: String?
    var gUEST: String?
    var add_TO_DEVICE_CALENDAR: String?
    var uPDATE_SUCCESS_MESSAGE: String?
    var rESERVATION_CANCEL_CONFIRMATION_MESSAGE: String?
    var gOLF_CANCEL_SUCCESS_MESSAGE: String?
    var cOURT_CANCEL_SUCCESS_MESSAGE: String?
    var dINING_CANCEL_SUCCESS_MESSAGE: String?
    var uPCOMING_DINING_RESERVATION: String?
    var aDDITIONAL_DETAILS_COLON: String?
    var rEQUESTED_TEETIME: String?
    var VIEW: String?
    var party_size_colon: String?
    var rEMOVE: String?
    var rELATED_MEMBERS_COLON: String?
    var gROUPS_LINK_COLON: String?
    var gUEST_TYPE_REQUIRED: String?
    var gUEST_NAME_REQUIRED: String?
    var nO_CONTACT_DETAILS_TOADD: String?
    var bUDDY_ADDED_SUCCESS_MESSAGE: String?
    var bUDDY_REMOVED_SUCCESS_MESSAGE: String?
    var hIGH_CHAIR: String?
    var bOOSTER_SEAT: String?
    var pLEASE_PROVIDE_FEEDBACK: String?
    var pRIMARY_EMAIL_ASTERISK: String?
    var rEQUIREDFIELD_COLOR: String?
    var change_password: String?
    var nOTIFICATION_READ_COLOR: String?
    var rELATION_ASTERISK: String?
    var tYPE_GUEST_NAME_ASTERISK: String?
    var gUESTNAME_FORMAT: String?
    var sELECT_GUEST_ASTERISK: String?
    var rEDIRECTTO_PRIVATESITE: String?
    var skip: String?
    var rELOGINTO_PRIVATESITE : String?
    var vILLAGENAME: String?
    var pRIVATESITE: String?
    var lINKTOPRIVATESITE: String?
    var dINING_EVENT_REQUEST_SUCCESS_MESSAGE2: String?
    var dINING_EVENT_REQUEST_SUCCESS_MESSAGE1: String?
    var aDD_SPECIAL_OCCASSION_COLON: String?
    var uSER_NAME_ASTERISK: String?
    var kIDS3ABOVE: String?
    var kIDS3ABOVECOUNT: String?
    var kIDS3BELOW: String?
    var kIDS3BELOWCOUNT: String?
    var mEMBERINCLUDETEXT: String?
    var gUESTORCHILD: String?
    var gUESTCOUNT: String?
    var mEMBERCOUNT: String?
    var rESERVATION: String?
    var sHOWHIDE_PROFILEPHOTO: String?
    var aLPHA_REPORTS: String?
    var tEE_COLON: String?
    var nEW_VERSION_AVAILABLE: String?
    var newVersion_Message: String?
    var uPDATE: String?
    var sEARCH_MEMBER_LASTNAMECOURSE: String?
    var if_you_donot_remember_your_email: String?
    var gOLF_LEAGUES: String?
    var aREYOUSURE_YOUWANTTO_REMOVE_GROUPFROM_REQUEST: String?
    var yOUWILL_NEED_THIS_POPUP: String?
    var group: String?
    var dEACTIVATED_LOGOUT: String?
    var mEMBER_DEACTIVATED: String?
    var TGAMEMBERVALIDATION: String?
    
    var EVENT_KID_INSTRUCTION : String?
    
    var DIRECTORY_MEMBER_KID_INSTRUCTION : String?
    
    var DIRECTORY_BUDDY_KID_ISNTRUCTION : String?
    
    var EVENT_GUEST_INSTRUCTION : String?
    
    var DIRECTORY_MEMBER_GUEST_INSTRUCTION : String?
    
    var DIRECTORY_BUDDY_GUEST_INSTRUCTION : String?
    
    var EVENT_GUEST_KID_INSTRUCTION : String?
    
    var DIRECTORY_MEMBER_GUEST_KID_INSTRUCTION : String?
    
    var DIRECTORY_BUDDY_GUEST_KID_INSTRUCTION : String?
    
    var SELECTED_COLON : String?
    
    var EVENT_STATUSFILTER : String?
    
    var SHOW_MORE : String?
    
    var CALENDER_FILTER : String?
    
    var CALENDER_CLEAR : String?
    
    var COMMING_SOON : String?
    
    var MULTI_SELECT : String?
    
    var MULTI_SELECT_DINING : String?
    
    var CALENDER_CLOSE : String?
    
    var FITNESS_SPA : String?
    
    var HTML_TEXT : String?
    
    var IsDiningDateValidate : Int?
    
    var IsDiningDateValidationMessage : String?
    
    var IsMemberExistsValidation_Golf_1 : String?
    
    var IsMemberExistsValidation_Tennis_1 : String?
    
    var IsMemberExistsValidation_Dining_1 : String?
    
    var IsMemberExistsValidation_Golf_2 : String?
    
    var IsMemberExistsValidation_Tennis_2 : String?
    
    var PRIVACY_POLICY : String?
    
    var TERMS_of_Use : String?
    
    var DINING_CANCEL_MESSAGE : String?
    
    var DININGEVENT_CANCEL_MESSAGE : String?
    
    var GOLFTENNIS_CANCEL_MESSAGE : String?
    
    var EVENT_CANCEL_MESSAGE : String?
    
    var uPCOMING_FITNESSEVENTS : String?
    
    var fITNESSSPA_POLICY : String?
    
    var fITNESSANDSPA_CALENDAR : String?
    
    var add_To_Waitlist : String?
    
    var waitlist : String?
    
    var earlest_Tee_Time : String?
    
    var latest_Tee_Time : String?
    
    var waitlist_Colorcode : String?
    
    var waitlist_Value : String?
    
    //Added on 18th May 2020 v2.1
    var clubNews_Title : String?
    
    var clubNews_Date : String?
    
    var clubNews_Link : String?
    
    //Added on 17th June 2020 BMS
    
    var BMS_RequestAppointment : String?
    var BMS_Providers : String?
    var BMS_Gender : String?
    var BMS_Request : String?
    var BMS_SubmitNew : String?
    var BMS_Duration : String?
    var BMS_ProviderValidation : String?
    var BMS_Time : String?
    var BMS_Date : String?
    var BMS_SubmitMessage : String?
    var BMS_Member : String?
    var BMS_AvailableTime : String?
    var BMS_GenderMale : String?
    var BMS_GenderFemale : String?
    var BMS_GenderAny : String?
    var BMS_DressCode : String?
    var BMS_REASONTEXT : String?
    var BMS_REASON : String?
    var BMS_OTHERREASON : String?
    var BMS_SELECT : String?
    
    //Added on 3rd July 2020 BMS
    var BMS_CANCELREASON : String?
    var BMS_CALENDAR : String?
    var BMS_REQUESTDETAILS : String?
    var BMS_PROVIDERNOT : String?
    
    //Added on 4th July 2020 V2.2
    var role_Validation1 : String?
    var role_Validation2 : String?
    
    //Added on 9th July 2020 V2.2
    var BMS_ServiceValidation : String?
    var BMS_Modify : String?
    var BMS_CancelledMessage : String?
    var BMS_Cancel_Message_IOS : String?
    
    //Added on 10th August 2020 V2.3
    var notification_Font_Size : String?
    
    //Added on 23rd Septmeber 2020 V2.3
    var BMS_GuestDOB : String?
    
    //Added on 24th September 2020 V2.3
    var BMS_AppText_Header : String?
    
    //Added on 13th October 2020 V2.3
    var MB_GiftCard : String?
    
    //Added by kiran V2.4 -- GATHER0000176
    var Fit_FitnessActivities: String?
    var Fit_Height : String?
    var Fit_Weight : String?
    var Fit_Groups : String?
    var Fit_Checkin : String?
    var Fit_KnowMore : String?
    var Fit_Duration : String?
    var Fit_Goal : String?
    var Fit_StartChallenge : String?
    var Fit_Group : String?
    var Fit_BackToVideos : String?
    var Fit_InputText : String?
    var Fit_InputTextHere : String?
    var Fit_Records : String?
    var Fit_Hello : String?
    var Fit_FitnessApp : String?
    var Fit_PostedOn : String?
    var Fit_Exercises : String?
    
    //Added by kiran V2.5 -- GATHER0000586 -- Added representative message
    var BMS_SubmitMessageRep : String?
    
    //Added by Kiran V2.7 -- GATHER0000700 - Text for Tennis Book a lesson button
    //GATHER0000700 - Start
    var TL_ButtonText : String?
    var TL_Providers : String?
    var TL_ProfessionalNot_Preferred : String?
    var TL_ProviderValidation : String?
    var TL_SubmitMessageRep : String?
    var TL_Modify : String?
    var TL_SubmitMessage : String?
    var TL_TennisLesson : String?
    var BMSDuration_Text : String?
    //GATHER0000700 - End
    
    //Added by kiran V2.7 -- ENGAGE0011559 -- international Number change
    //ENGAGE0011559 -- Start
    var outside_US_Contact : String?
    var outside_US_Contact_Text : String?
    var outside_US_Contact_Limit : Int?
    //ENGAGE0011559 -- End
    
    //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments. Added department name for BMS sub category(eg. fitness , spa ,salon, etc..) permissions.
    //ENGAGE0011652 -- Start
    
    ///BMS(Fitness & Spa) Salon departrment name
    var BMS_Salon : String?
    ///BMS(Fitness & Spa) SPA departrment name
    var BMS_Spa : String?
    ///BMS(Fitness & Spa) Fitness departrment name
    var BMS_Fitness : String?
    //ENGAGE0011652 -- End

    //Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
    //GATHER0000923 -- Start
    var BMS_Select_Category : String?
    //GATHER0000923 -- End
    
    //Added by kiran V2.8 -- ENGAGE0011784 -- Adding optional text for add guest reg vc..
    //ENGAGE0011784 -- Start
    var BMS_Optional : String?
    var go_Existing_Guest : String?
    var go_New_Guest : String?
    var go_Please_Select_Guest : String?
    var go_Search_Guest_Name : String?
    var go_Guest : String?
    var go_First_Name : String?
    var go_Last_Name : String?
    //ENGAGE0011784 -- End
    
    //Added by kiran v2.8 -- GATHER0001149
    //GATHER0001149 -- Start
    var BMS_Fitness_Comments : String?
    var BMS_Spa_Comments : String?
    var BMS_Salon_Comments : String?
    var BMS_Tennis_Comments : String?
    
    var BMS_Fitness_Comments_Colon : String?
    var BMS_Spa_Comments_Colon : String?
    var BMS_Salon_Comments_Colon : String?
    var BMS_Tennis_Comments_Colon : String?
    
    var golfReservation_GuestAdd : String?
    var tennisReservation_GuestAdd : String?
    var diningReservation_GuestAdd : String?
    
    var BMS_Fitness_GuestAdd : String?
    var BMS_Spa_GuestAdd : String?
    var BMS_Salon_GuestAdd : String?
    var BMS_Tennis_GuestAdd : String?

    var confirm_Yes : String?
    var confirm_No : String?
    //GATHER0001149 -- End
    
    //Added by kiran V2.9 -- GATHER0001167 -- Added Golf BAL related labels and added other labels to make the BMS labels flexible
    //GATHER0001167 -- Start
    var BMS_Golf_ButtonText : String?
    var BMS_Golf_Comments : String?
    var BMS_Golf_Comments_Colon : String?
    var BMS_Golf_Professionals : String?
    var BMS_GolfLesson : String?
    var BMS_Golf_Request : String?
    var BMS_Golf_ProviderNotAvailable : String?
    var BMS_Golf_ProviderNotPreferred : String?
    var BMS_Golf_GuestAdd : String?
    var BMS_CancelledMessage_Fitness : String?
    var BMS_Cancel_Message_IOS_Fitness : String?
    var BMS_CancelledMessage_Spa : String?
    var BMS_Cancel_Message_IOS_Spa : String?
    var BMS_CancelledMessage_Salon : String?
    var BMS_Cancel_Message_IOS_Salon : String?
    var BMS_CancelledMessage_TennisLesson : String?
    var BMS_Cancel_Message_IOS_TennisLesson : String?
    var BMS_CancelledMessage_GolfLesson : String?
    var BMS_Cancel_Message_IOS_GolfLesson : String?
    //GATHER0001167 -- End
    
    //Added by kiran V2.9 -- ENGAGE0011722 -- Apple wallet functionality
    //ENGAGE0011722 -- Start
    var wallet_Cancel : String?
    var wallet_Remove : String?
    var wallet_Alert : String?
    var wallet_Replace_Text : String?
    var wallet_Remove_Text : String?
    var wallet_LibraryNot : String?
    var wallet_Device_Wallet : String?
    var wallet_Ok : String?
    var wallet_Replace : String?
    var wallet_ErrorMessage : String?
    //ENGAGE0011722 -- End
    
    //Commented by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
    //ENGAGE0011898 -- Start
    var guestCardPolicy_Category : String?
    var guestCardPolicy_Section : String?
    var guestCardPolicy_Name : String?
    //ENGAGE0011898 -- End
    
    //Added by kiran V2.9 -- ENGAGE0011597 -- Adding 2 fields for description and count.
    //ENGAGE0011597 -- Start
    var giftCard_Description : String?
    var giftCard_RemainingCount : String?
    var giftCard_IssuedDate : String?
    var giftCard_ExpirationDate : String?
    var giftCard_Description_NoColon : String?
    var giftCard_RemainingCount_NoColon : String?
    //ENGAGE0011597 -- End
    
    //Added by kiran v2.9 -- GATHER0000623 -- Disclaimer set-up by service to prompt based on settings
    //GATHER0000623 -- Start
    var BMS_Ok : String?
    var BMS_Disclaimer : String?
    //GATHER0000623 -- End
    
    //Added by kiran v2.9 -- Cobalt Pha0010644 -- Function to show Hard & Soft message details of courses when date is changed
    //Cobalt Pha0010644 -- Start
    var golfAdvance_Yes : String?
    var golfAdvance_No : String?
    var golfAdvanceTitle : String?
    var golfAdvance_Ok : String?
    //Cobalt Pha0010644 -- End
    
    //Added by kiran V2.9 -- ENGAGE0012268 -- Lightning Warning button title
    //ENGAGE0012268 -- Start
    var Golf_LWS : String?
    //ENGAGE0012268 -- End
    
    //Added by kiran V1.2
    var authentication_AccountExpired : String?
    var authentication_ExpiredText : String?
    var authentication_Logout : String?
   
    //Added by kiran V3.0 -- ENGAGE0011843 -- Guest card Offspring comparision key.
    //ENGAGE0011843 -- Start
    ///Offspring key for comparisions
    var guestCard_OF : String?
    //ENGAGE0011843 -- End
    
    //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
    //PROD0000069 -- Start
    var clubNewsToEvents_OK : String?
    //PROD0000069 -- End
    
    //Added by kiran V1.4 -- PROD0000121 -- changed the request key to individual departents keys.
    //PROD0000121 -- Start
    var BMS_Fitness_Request : String?
    var BMS_Tennis_Request : String?
    var BMS_Spa_Request : String?
    var BMS_Salon_Request : String?
    //PROD0000121 -- End

    //Added by kiran V1.4 -- PROD0000148 -- Success mesage popup message change
    //PROD0000148 -- Start
    var your_Dining_Event_Cancel: String?
    //PROD0000148 -- End
    
    // Added by Zeeshan May 11 2022
    var legendInfoTitle : String?
    var legendInfoValue : String?
    var legendInfoTransValue : String?
    var cONTACT_UPDATE_SUCCESS : String?
    var cONTACT_NAME_ALREADY_EXISTS : String?
    var cONTACT_NAME_ALREADY_EXISTS_UPDATE : String?
    var cONTACT_NUMBER_ALREADY_EXISTS : String?
    var cONTACT_NUMBER_ALREADY_EXISTS_UPDATE : String?
    var fCFS_SELECTTIMEVALIDATION : String?

    
    convenience required init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        
        mEMBER_DEACTIVATED <- map["MEMBER_DEACTIVATED"]
        dEACTIVATED_LOGOUT <- map["DEACTIVATED_LOGOUT"]
        group <- map["GROUP"]
        yOUWILL_NEED_THIS_POPUP <- map["YOUWILL_NEED_THIS_POPUP"]
        aREYOUSURE_YOUWANTTO_REMOVE_GROUPFROM_REQUEST <- map["AREYOUSURE_YOUWANTTO_REMOVE_GROUPFROM_REQUEST"]
        gOLF_LEAGUES <- map["GOLF_LEAGUES"]
        if_you_donot_remember_your_email <- map["DONOT_REMEMBER_EMAIL"]
        sEARCH_MEMBER_LASTNAMECOURSE <- map["SEARCH_MEMBER_LASTNAMECOURSE"]
        uPDATE <- map["UPDATE"]
        newVersion_Message <- map["ANEW_VERSION_OFTHEAPPIS_AVAILABLE"]
        nEW_VERSION_AVAILABLE <- map["NEW_VERSION_AVAILABLE"]
        tEE_COLON <- map["TEE_COLON"]
        aLPHA_REPORTS <- map["ALPHA_REPORTS"]
        sHOWHIDE_PROFILEPHOTO <- map["SHOWHIDE_PROFILEPHOTO"]
        rESERVATION <- map["RESERVATION"]
        mEMBERCOUNT <- map["MEMBERCOUNT"]
        gUESTORCHILD <- map["GUESTORCHILD"]
        kIDS3BELOW <- map["KIDS3BELOW"]
        kIDS3ABOVECOUNT <- map["KIDS3ABOVECOUNT"]
        kIDS3BELOWCOUNT <- map["KIDS3BELOWCOUNT"]
        mEMBERINCLUDETEXT <- map["MEMBERINCLUDETEXT"]
        gUESTCOUNT <- map["GUESTCOUNT"]
        
        kIDS3ABOVE <- map["KIDS3ABOVE"]
        uSER_NAME_ASTERISK <- map["USER_NAME_ASTERISK"]
        aDD_SPECIAL_OCCASSION_COLON <- map["ADD_SPECIAL_OCCASSION_COLON"]
        dINING_EVENT_REQUEST_SUCCESS_MESSAGE1 <- map["DINING_EVENT_REQUEST_SUCCESS_MESSAGE1"]
        dINING_EVENT_REQUEST_SUCCESS_MESSAGE2 <- map["DINING_EVENT_REQUEST_SUCCESS_MESSAGE2"]
        lINKTOPRIVATESITE <- map["LINKTOPRIVATESITE"]
        pRIVATESITE <- map["PRIVATESITE"]
        vILLAGENAME <- map["VILLAGENAME"]
        rELOGINTO_PRIVATESITE <- map["RELOGINTO_PRIVATESITE"]
        skip <- map["SKIP"]
        rEDIRECTTO_PRIVATESITE <- map["REDIRECTTO_PRIVATESITE"]
        sELECT_GUEST_ASTERISK <- map["SELECT_GUEST_ASTERISK"]
        gUESTNAME_FORMAT <- map["GUESTNAME_FORMAT"]
        rELATION_ASTERISK <- map["RELATION_ASTERISK"]
        nOTIFICATION_READ_COLOR <- map["NOTIFICATION_READ_COLOR"]
        change_password <- map["CHANGE_PASSWORD"]
        rEQUIREDFIELD_COLOR <- map["REQUIREDFIELD_COLOR"]
        tYPE_GUEST_NAME_ASTERISK <- map["TYPE_GUEST_NAME_ASTERISK"]
        pRIMARY_EMAIL_ASTERISK <- map["PRIMARY_EMAIL_ASTERISK"]
        pLEASE_PROVIDE_FEEDBACK <- map["PLEASE_PROVIDE_FEEDBACK"]
        hIGH_CHAIR <- map["HIGH_CHAIR"]
        bOOSTER_SEAT <- map["BOOSTER_SEAT"]
        bUDDY_REMOVED_SUCCESS_MESSAGE <- map["BUDDY_REMOVED_SUCCESS_MESSAGE"]

        bUDDY_ADDED_SUCCESS_MESSAGE <- map["BUDDY_ADDED_SUCCESS_MESSAGE"]
        nO_CONTACT_DETAILS_TOADD <- map["NO_CONTACT_DETAILS_TOADD"]
        gUEST_NAME_REQUIRED <- map["GUEST_NAME_REQUIRED"]
        gUEST_TYPE_REQUIRED <- map["GUEST_TYPE_REQUIRED"]
        gROUPS_LINK_COLON <- map["GROUPS_LINK_COLON"]
        rELATED_MEMBERS_COLON <- map["RELATED_MEMBERS_COLON"]
        rEMOVE <- map["REMOVE"]
        party_size_colon <- map["PARTY_SIZE_COLON"]
        VIEW <- map["VIEW"]
        rEQUESTED_TEETIME <- map["REQUEST_TEE_TIME"]
        uPCOMING_DINING_RESERVATION <- map["UPCOMING_DINING_RESERVATION"]
        aDDITIONAL_DETAILS_COLON <- map["ADDITIONAL_DETAILS_COLON"]
        rESERVATION_CANCEL_CONFIRMATION_MESSAGE <- map["RESERVATION_CANCEL_CONFIRMATION_MESSAGE"]
        gOLF_CANCEL_SUCCESS_MESSAGE <- map["GOLF_CANCEL_SUCCESS_MESSAGE"]
        cOURT_CANCEL_SUCCESS_MESSAGE <- map["COURT_CANCEL_SUCCESS_MESSAGE"]
        dINING_CANCEL_SUCCESS_MESSAGE <- map["DINING_CANCEL_SUCCESS_MESSAGE"]

        
        uPDATE_SUCCESS_MESSAGE <- map["GOLF_UPDATE_SUCCESS_MESSAGE"]
        mYGROUP_CREATED_SUCCESS_MESSAGE <- map["MYGROUP_CREATED_SUCCESS_MESSAGE"]
        mYGROUP_UPDATED_SUCCESS_MESSAGE <- map["MYGROUP_UPDATED_SUCCESS_MESSAGE"]
        gUEST <- map["GUEST"]
        rESTAURANT_NAME_COLON <- map["RESTAURANT_NAME_COLON"]
        cOURT_REQUEST_MULTIDAY_SUCCESS_MESSAGE1 <- map["COURT_REQUEST_MULTIDAY_SUCCESS_MESSAGE1"]
        cOURT_REQUEST_MULTIDAY_SUCCESS_MESSAGE2 <- map["COURT_REQUEST_MULTIDAY_SUCCESS_MESSAGE2"]
        select_restaurant_colon <- map["SELECT_RESTAURANT_COLON"]
        cOURT_REQUEST_SUCCESS_MESSAGE1 <- map["COURT_REQUEST_SUCCESS_MESSAGE1"]
        cOURT_REQUEST_SUCCESS_MESSAGE2 <- map["COURT_REQUEST_SUCCESS_MESSAGE2"]
        dINING_REQUEST_SUCCESS_MESSAGE1 <- map["DINING_REQUEST_SUCCESS_MESSAGE1"]
        dINING_REQUEST_SUCCESS_MESSAGE2 <- map["DINING_REQUEST_SUCCESS_MESSAGE2"]
        dIETARY_RESTRICTIONS_INFO <- map["DIETARY_RESTRICTIONS_INFO"]
        eXCLUDE_COURSE_COLON <- map["EXCLUDE_COURSE_COLON"]
        pOLICY_TEXT_COLON <- map["POLICY_TEXT_COLON"]
        rESTAURTENT_NAME_COLON <- map["RESTAURTENT_NAME_COLON"]
        gOLF_REQUEST_SUCCESS_MESSAGE1 <- map["GOLF_REQUEST_SUCCESS_MESSAGE1"]
        gOLF_REQUEST_SUCCESS_MESSAGE2 <- map["GOLF_REQUEST_SUCCESS_MESSAGE2"]
        link_groups_colon <- map["LINK_GROUPS_COLON"]
        
        additional_details <- map["ADDITIONAL_DETAILS"]
        time_colon <- map["TIME_COLON"]
        cOMMENTS_COLON <- map["COMMENTS_COLON"]
        special_request <- map["SPECIAL_REQUESTS_COLON"]
        rESTAURANT_COLON <- map["RESTAURANT_COLON"]
        gOLF_POLICY_1 <- map["GOLF_POLICY_1"]
        gOLF_POLICY_2 <- map["GOLF_POLICY_2"]
        gOLF_POLICY_3 <- map["GOLF_POLICY_3"]
        gOLF_POLICY_4 <- map["GOLF_POLICY_4"]
        tENNIS_POLICY_1 <- map["TENNIS_POLICY_1"]
        tENNIS_POLICY_2 <- map["TENNIS_POLICY_2"]
        tENNIS_POLICY_3 <- map["TENNIS_POLICY_3"]
        tENNIS_POLICY_4 <- map["TENNIS_POLICY_4"]
        dINING_POLICY_1 <- map["DINING_POLICY_4"]
        dINING_POLICY_2 <- map["DINING_POLICY_1"]
        dINING_POLICY_3 <- map["DINING_POLICY_2"]
        dINING_POLICY_4 <- map["DINING_POLICY_3"]
        sINGLES <- map["SINGLES"]
        dOUBLES <- map["DOUBLES"]

        rEQUEST_COURT <- map["REQUEST_COURT"]
        dining_policy <- map["DINING_POLICY"]
        court_time <- map["COURT_TIME"]
        view_groups <- map["VIEW_GROUP"]
        removeGroup_confirmation <- map["GROUPDELETE_CONFIRMATION"]
        removeGroup_succes <- map["GROUPDELETE_SUCCESS_MESSAGE"]
        tee_time_details <- map["TEETIME_DETAILS"]
        court_time_details <- map["COURT_TIME_DETAILS"]
        dining_reservation_details <- map["DINING_RESERVATION_DETAILS"]

        link_groups <- map["LINK_GROUPS"]
        share <- map["SHARE"]
        round_length <- map["ROUND_LENGTH_COLON"]
        notpreferred_course <- map["NOT_PREFERRED_COURSE_COLON"]
        preferred_course_colon <- map["PREFERRED_COURSE_COLON"]
        tee_time_colon <- map["TEE_TIME_COLON"]
        course_time_colon <- map["COURSE_COLON"]
        duration_colon <- map["DURATION_COLON"]
        match_colon <- map["MATCH_COLON"]
        confirmed_court_time <- map["CONFIRMED_COURT_TIME_COLON"]
        upcoming_reservations <- map["UPCOMING_RESERVATIONS"]
        removeBuddy_confirmation <- map["REMOVEBUDDY_CONFIRMATION"]
        removeBuddy_succes <- map["REMOVEBUDDY_SUCCESS_MESSAGE"]
        golf_calendar <- map["GOLF_CALENDAR"]
        up_coming_golf_events <- map["UPCOMING_GOLF_EVENTS"]
        upcoming_teetimes <- map["UPCOMING_TEE_TIMES"]
        remove_from_mybuddylist <- map["REMOVE_FROM_MY_BUDDYLIST"]
        upcoming_tennis_events <- map["UPCOMING_TENNIS_EVENTS"]
        tennis_calendar <- map["TENNIS_CALENDAR"]
        upcoming_court_times <- map["UPCOMING_COURT_TIMES"]
        upcoming_dining_times <- map["UPCOMING_DINING_EVENTS"]
        dining_calendar <- map["DINING_CALENDAR"]
        request_tee_time <- map["REQUEST_TEE_TIME"]
        select_request_date <- map["SELECT_REQUEST_DATE"]
        preferred_tee_time <- map["PREFERRED_TEE_TIME"]
        earliest_tee_time <- map["EARLIEST_TEE_TIME"]
        group_count <- map["GROUPS_COUNT"]
        groups_link <- map["GROUPS_LINK"]
        golf_policy <- map["GOLF_POLICY"]
        preffered_course <- map["PREFERRED_COURSE"]
        exclude_course <- map["EXCLUDE_COURSE"]
        request_court_time <- map["REQUEST_COURT_TIME"]
        tennis_request_date <- map["TENNIS_REQUEST_DATE"]
        not_earlier_than <- map["NOT_EARLIER_THAN"]
        not_later_than <- map["NOT_LATER_THAN"]
        players <- map["PLAYERS"]
        player <- map["PLAYER"]
        request_ball_machine <- map["REQUEST_BALL_MACHINE"]
        tennis_policy <- map["TENNIS_POLICY"]
        dining_request <- map["DINING_REQUEST"]
        select_restaurant <- map["SELECT_RESTAURANT"]
        reservation_time <- map["RESERVATION_TIME"]
        party_size <- map["PARTY_SIZE"]
        special_request_add <- map["SPECIAL_REQUEST_ADD"]
        reservation_comments <- map["RESERVATION_COMMENTS"]

        
        moreInfo <- map["MOREINFO"]
        event_request <- map["EVENTREGISTRATION_REQUEST"]
        event_modify <- map["EVENTREGISTRATION_MODIFY"]
        event_cancel <- map["EVENTREGISTRATION_CANCEL"]
        usa <- map["USA"]
        eventUrl <- map["EVENT_URL"]
        clubnewsUrl <- map["CLUBNEWS_URL"]
        type_guest_name <- map["Type_Guest_Name"]
        search_events <- map["SEARCH_EVENTNAME"]
        search_buddyname_Id <- map["SEARCH_BUDDYNAMEORID"]
        search_guest_Name <- map["SEARCH_GUESTNAME"]
        search_imp_clubNumbers <- map["SEARCH_IMPORTANTCLUBNUMBERS"]
        search_memberName_id <- map["SEARCH_MEMBERNAMEORID"]
        search_News <- map["SEARCH_NEWS"]
        search_Notifications <- map["SEARCH_NOTIFICATION"]
        search_Statement <- map["SEARCH_STATEMENT"]
        please_select_Member <- map["PLEASESELECT_MEMBER"]
        please_addGuest <- map["PLEASEADD_GUEST"]
        memberProfile_succss <- map["MEMBERPROFILE_SUCCESS"]
        add_member_or_guest <- map["ADD_MEMBERORGUEST"]
        person <- map["PERSON"]
        event_details <- map["EVENT_DETAILS"]
        event_registration <- map["EVENT_REGISTRATION"]
        add_to_buddylist <- map["ADDTOMYBUDDYLIST"]
        add_member <- map["ADD_MEMBER"]
        add_mybuddy <- map["ADD_MYBUDDY"]
        current_password <- map["CURRENT_PASSWORD"]
        cURRENCY <- map["CURRENCY"]
        iNTERNET_CONNECTION_ERROR <- map["INTERNET_CONNECTION_ERROR"]
        rEQUEST_FAILED <- map["REQUEST_FAILED"]
        tT_STATEMENTS <- map["TT_STATEMENTS"]
        tT_NOTIFICATIONS <- map["TT_NOTIFICATIONS"]
        tT_PROFILE <- map["TT_PROFILE"]
        tT_ADD_GUEST <- map["TT_ADD_GUEST"]
        tT_ALL_EVENTS <- map["TT_ALL_EVENTS"]
        tT_PREFERENCES <- map["TT_PREFERENCES"]
        tT_GUEST_CARD <- map["TT_GUEST_CARD"]
        tT_MEMBER_ID <- map["TT_MEMBER_ID"]
        tT_RESTAURANTS <- map["TT_RESTAURANTS"]
        tT_MEMBER_DIRECTORY <- map["TT_MEMBER_DIRECTORY"]
        tT_GIFT_CARD <- map["TT_GIFT_CARD"]
        tT_IMPORTANT_NUMBERS <- map["TT_IMPORTANT_NUMBERS"]
        tT_GIFT_CARD_DETAIL <- map["TT_GIFT_CARD_DETAIL"]
        tT_TRANSACTION_DETAILS <- map["TT_TRANSACTION_DETAILS"]
        tAB_CURRENT <- map["TAB_CURRENT"]
        tAB_PREVIOUS <- map["TAB_PREVIOUS"]
        tITLE_HOME <- map["TITLE_HOME"]
        tITLE_GUEST_CARD <- map["TITLE_GUEST_CARD"]
        tITLE_STATEMENTS <- map["TITLE_STATEMENTS"]
        tITLE_MORE <- map["TITLE_MORE"]
        mEMBER_DIRECTORE <- map["MEMBER_DIRECTORE"]
        iMPORTANT_NUMBER <- map["IMPORTANT_NUMBER"]
        rESTAURTENT_MENU <- map["RESTAURTENT_MENU"]
        gIFT_CARD <- map["GIFT_CARD"]
        mEMBER_ID <- map["MEMBER_ID"]
        lOGOUT <- map["LOGOUT"]
        lOADING <- map["LOADING"]
        rES_ERR <- map["RES_ERR"]
        tAB_GUEST_LIST <- map["TAB_GUEST_LIST"]
        tAB_REQUEST_CARD <- map["TAB_REQUEST_CARD"]
        tAB_ALL_REQUEST <- map["TAB_ALL_REQUEST"]
        aRRIVED <- map["ARRIVED"]
        dEPARTED <- map["DEPARTED"]
        hINT_MEMBER_ID <- map["HINT_MEMBER_ID"]
        hINT_USERNAME <- map["HINT_USERNAME"]
        hINT_PASSWORD <- map["HINT_PASSWORD"]
        tITLE_LOGIN <- map["TITLE_LOGIN"]
        tITLE_FORGOT_PWD <- map["TITLE_FORGOT_PWD"]
        eRR_MSG_ID <- map["ERR_MSG_ID"]
        eRR_MSG_PASSWORD <- map["ERR_MSG_PASSWORD"]
        fORGOT_PAGE_TV <- map["FORGOT_PAGE_TV"]
        hINT_ENTER_EMAIL <- map["HINT_ENTER_EMAIL"]
        sEND <- map["SEND"]
        eRR_MSG_EMAIL <- map["ERR_MSG_EMAIL"]
        gO_BACK_TO_LOGIN <- map["GO_BACK_TO_LOGIN"]
        rESET_EMAIL_TEXT <- map["RESET_EMAIL_TEXT"]
        hI <- map["HI"]
        eXCLAMATORY <- map["EXCLAMATORY"]
        mORE <- map["MORE"]
        vIEW_ALL <- map["VIEW_ALL"]
        lATEST_NOTIFICATION <- map["LATEST_NOTIFICATION"]
        instructional_videos_dining <- map["INSTRUCTIONAL_VIDEOS_DINING"]
        uPCOMING_EVENTS <- map["UPCOMING_EVENTS"]
        tODAY_AT_A_GLANCE <- map["TODAY_AT_A_GLANCE"]
        cLOSE <- map["CLOSE"]
        nOTES <- map["NOTES"]
        uPCOMING_VISITS <- map["UPCOMING_VISITS"]
        rEQUEST_GUEST_CARD <- map["REQUEST_GUEST_CARD"]
        aDD_GUEST <- map["ADD_GUEST"]
        nO_UPCOMING_VISITS <- map["NO_UPCOMING_VISITS"]
        gUEST_REQUEST_CANCELLED <- map["GUEST_REQUEST_CANCELLED"]
        gUEST_REQUEST_MODIFIED <- map["GUEST_REQUEST_MODIFIED"]
        fIRST_NAME <- map["FIRST_NAME"]
        lAST_NAME <- map["LAST_NAME"]
        pHONE_NUMBER <- map["PHONE_NUMBER"]
        pRIMARY_EMAIL <- map["PRIMARY_EMAIL"]
        aGE <- map["AGE"]
        gENDER <- map["GENDER"]
        mALE <- map["MALE"]
        fEMALE <- map["FEMALE"]
        aDD <- map["ADD"]
        cANCEL <- map["CANCEL"]
        sUB_TOTAL <- map["SUB_TOTAL"]
        tAX_7 <- map["TAX_7"]
        tOTAL <- map["TOTAL"]
        gIFT_CHARGES_ARRIVAL <- map["GIFT_CHARGES_ARRIVAL"]
        iGNORE <- map["IGNORE"]
        rEQUEST <- map["REQUEST"]
        mODIFY <- map["MODIFY"]
        aDD_TO_BUDDY_LIST <- map["ADD_TO_BUDDY_LIST"]
        aDD_TO_PHONE <- map["ADD_TO_PHONE"]
        pROFILE <- map["PROFILE"]
        hASH <- map["HASH"]
        bIRTHDAY <- map["BIRTHDAY"]
        aNNIVERSARY <- map["ANNIVERSARY"]
        mEMBERSHIP_TYPE <- map["MEMBERSHIP_TYPE"]
        pREFERENCES <- map["PREFERENCES"]
        aDD_ONS <- map["ADD_ONS"]
        iNTERESTS <- map["INTERESTS"]
        bOCA_WEST <- map["BOCA_WEST"]
        mOBILE <- map["MOBILE"]
        aDDRESS_BOCA_WEST <- map["ADDRESS_BOCA_WEST"]
        vISIBLE <- map["VISIBLE"]
        nOTIFICATIONS <- map["NOTIFICATIONS"]
        uSER_NAME <- map["USER_NAME"]
        pASSWORD <- map["PASSWORD"]
        rESET <- map["RESET"]
        sAVE <- map["SAVE"]
        dISPLAY_NAME <- map["DISPLAY_NAME"]
        eMAIL <- map["EMAIL"]
        sECONDARY_EMAIL <- map["SECONDARY_EMAIL"]
        mAILING_ADDRESS <- map["MAILING_ADDRESS"]
        aDDRESS_OTHER <- map["ADDRESS_OTHER"]
        sTREET_1 <- map["STREET_1"]
        sTREET_2 <- map["STREET_2"]
        cITY <- map["CITY"]
        sTATE <- map["STATE"]
        zIP <- map["ZIP"]
        cOUNTY <- map["COUNTRY"]
        aDD_ANOTHER_ADDRESS <- map["ADD_ANOTHER_ADDRESS"]
        rESET_PASSWORD <- map["RESET_PASSWORD"]
        nEW_PASSWORD <- map["NEW_PASSWORD"]
        cONFIRM_PASSWORD <- map["CONFIRM_PASSWORD"]
        dO_NOT_SHOW_ME_IN_THE_ONLINE_MEMBER_DIRECTORY <- map["DO_NOT_SHOW_ME_IN_THE_ONLINE_MEMBER_DIRECTORY"]
        dATE <- map["DATE"]
        cODE <- map["CODE"]
        aMOUNT <- map["AMOUNT"]
        dESCRIPTION <- map["DESCRIPTION"]
        rEG_NO <- map["REG_NO"]
        rECEIPT_NO <- map["RECEIPT_NO"]
        eMPLOYEE <- map["EMPLOYEE"]
        mEMBER_NAME <- map["MEMBER_NAME"]
        mEMBER_NO <- map["MEMBER_NO"]
        nO <- map["NO"]
        iTEMS <- map["ITEMS"]
        yOU_SAVED <- map["YOU_SAVED"]
        tAX <- map["TAX"]
        tIP <- map["TIP"]
        deparment <- map["DEPARTMENT"]
        cERTIFICATE_NCARD_TYPE <- map["CERTIFICATE_NCARD_TYPE"]
        oRIGINAL_NAMOUNT <- map["ORIGINAL_NAMOUNT"]
        bALANCE_NAMOUNT <- map["BALANCE_NAMOUNT"]
        iSSUED_DATE <- map["ISSUED_DATE"]
        eXPIRY_DATE <- map["EXPIRY_DATE"]
        mONTH <- map["MONTH"]
        fILTER_BY_INTEREST <- map["FILTER_BY_INTEREST"]
        hOME_PHONE <- map["HOME_PHONE"]
        cELL_PHONE <- map["CELL_PHONE"]
        oTHER <- map["OTHER"]
        bACK <- map["BACK"]
        hINT_FROM_DATE <- map["HINT_FROM_DATE"]
        hINT_TO_DATE <- map["HINT_TO_DATE"]
        mTD <- map["MTD"]
        cHOOSE_RELATION <- map["CHOOSE_RELATION"]
        eRR_VALID_FNAME <- map["ERR_VALID_FNAME"]
        eRR_VALID_LNAME <- map["ERR_VALID_LNAME"]
        eRR_VALID_RELATION <- map["ERR_VALID_RELATION"]
        eRROR_UNAME <- map["ERROR_UNAME"]
        eRROR_NEW_PWD <- map["ERROR_NEW_PWD"]
        eRROR_CONFIRM_PWD <- map["ERROR_CONFIRM_PWD"]
        eRROR_PWD_MATCH <- map["ERROR_PWD_MATCH"]
        eRROR <- map["ERROR"]
        rESET_SUCCESSFUL <- map["RESET_SUCCESSFUL"]
        aUTHENTICATION_FAILED <- map["AUTHENTICATION_FAILED"]
        eRROR_OCCURRED <- map["ERROR_OCCURRED"]
        pROFILE_UPDATED_SUCCESSFULLY <- map["PROFILE_UPDATED_SUCCESSFULLY"]
        nOTIFICATION_DISABLED <- map["NOTIFICATION_DISABLED"]
        nO_FURTHER_NOTIFICATIONS <- map["NO_FURTHER_NOTIFICATIONS"]
        nOTIFICATION_ENABLED <- map["NOTIFICATION_ENABLED"]
        sTART_RECEIVE_NOTIFICATION <- map["START_RECEIVE_NOTIFICATION"]
        nO_EMPTY_DATE <- map["NO_EMPTY_DATE"]
        gUEST_ADDED <- map["GUEST_ADDED"]
        sELECT_RELAION <- map["SELECT_RELAION"]
        eXCEPTION <- map["EXCEPTION"]
        cONTACT_ADDED <- map["CONTACT_ADDED"]
        cONACT_ALREADY_ADDED <- map["CONACT_ALREADY_ADDED"]
        vALID_LAST_NAME <- map["VALID_LAST_NAME"]
        nO_RECORD_FOUND <- map["NO_RECORD_FOUND"]
        gUEST_REQUEST_ERROR <- map["GUEST_REQUEST_ERROR"]
        eDIT <- map["EDIT"]
        gALLERY <- map["GALLERY"]
        cAMERA <- map["CAMERA"]
        nO_NEW_NOTIFICATION <- map["NO_NEW_NOTIFICATION"]
        hIDDEN <- map["HIDDEN"]
        qTY <- map["QTY"]
        dATE_CANT_BE_EMPTY <- map["DATE_CANT_BE_EMPTY"]
        fROM_DATE_LESS <- map["FROM_DATE_LESS"]
        nO_UPDATE_GLANCE <- map["NO_UPDATE_GLANCE"]
        register_your_device <- map["Register Your Device"]
        search_Guest <- map["SEARCH_GUEST"]
        new_Guest_Card <- map["NEW_GUESTCARD"]
        New_Visit <- map["NEW_VISIT"]
        modify_Visit <- map["MODIFY_VISIT"]
        modify <- map["MODIFY"]
        add_Visit <- map["ADD_VISIT"]
        history <- map["HISTORY"]
        cancel_Card <- map["CANCEL_CARD"]
        guest_Card_History <- map["GUESTCARD_HISTORY"]
        no_Record_Found <- map["NO_RECORD_FOUND"]
        date <- map["DATE"]
        relation <- map["RELATION"]
        done <- map["DONE"]
        first_Name <- map["FIRST_NAME"]
        last_Name <- map["LAST_NAME"]
        date_Of_Birth <- map["DATEOFBIRTH"]
        Phone <- map["PHONE"]
        email <- map["EMAIL"]
        visit <- map["VISIT"]
        duration <- map["DURATION"]
        accompanying_Guest_During_Check_in <- map["ACCOMPANYING_GUEST_DURING_CHECKIN"]
        Yes <- map["ACCOMPANYING_YES"]
        No <- map["ACCOMPANYING_NO"]
        add_Photo_ID <- map["ADD_PHOTOID"]
        Add_Guest_Photo <- map["ADD_GUESTPHOTO"]
        Save <- map["SAVE"]
        guest_Card_Policy_Title <- map["GUESTCARD_POLICY_TITLE"]
        select_Guest <- map["SELECT_GUEST"]
        upcoming_Visit <- map["UPCOMING_VISIT"]
        extended_By <- map["EXTENDED_BY"]
        charges_Will_Not_Appear <- map["CHARGES_WILL_NOT_APPEAR"]
        First_Name_is_required <- map["ADDGUEST_FIRSTNAME_REQUIRED"]
        Last_Name_is_required <- map["ADDGUEST_LASTNAME_REQUIRED"]
        Relation_is_required <- map["ADDGUEST_RELATION_REQUIRED"]
        Date_Of_Birth_is_required <- map["ADDGUEST_DOB_REQUIRED"]
        phone_Is_Required <- map["ADDGUEST_PHONE_REQUIRED"]
        email_Is_Required <- map["ADDGUEST_EMAIL_REQUIRED"]
        visit_Is_Required <- map["ADDGUEST_VISIT_REQUIRED"]
        duration_Is_Required <- map["ADDGUEST_DURATION_REQUIRED"]
        photo_ID_Is_Required <- map["ADDGUEST_PHOTOID_REQUIRED"]
        guest_Photo_Is_Required <- map["ADDGUEST_GUESTPHOTO_REQUIRED"]
        select_Guest_Is_Required <- map["NEWVISIT_SELECTGUEST_REQUIRED"]
        upcoming_Visit_Is_Required <- map["NEWVISIT_UPCOMINGVISIT_REQUIRED"]
        Extend_Is_Required <- map["MODIFYVISIT_EXTENDBY_REQUIRED"]
        email_Validation <- map["ADDGUEST_EMAIL_INVALIDEMAIL"]
        dob_min <- map["ADDGUEST_DOB_CANNOTCREATEGUEST"]
        thank_You <- map["THANKYOU"]
        guest_save_validation1 <- map["GUEST_SAVE_VALIDATION_1"]
        guest_save_validation2 <- map["GUEST_SAVE_VALIDATION_2"]
        guest_save_validation3 <- map["GUEST_SAVE_VALIDATION_3"]
        guest_modify_validation <- map["GUEST_MODIFY_VALIDATION"]
        guest_suspended_validation1 <- map["GUEST_SUSPENDED_VALIDATION"]
        guestcard_policy_title <- map["GUESTCARD_POLICY_TITLE"]
        guestcard_policy_1 <- map["GUESTCARD_POLICY_1"]
        guestcard_policy_2 <- map["GUESTCARD_POLICY_2"]
        guestcard_policy_3 <- map["GUESTCARD_POLICY_3"]
        guestcard_policy_4 <- map["GUESTCARD_POLICY_4"]
        cancel_guest_card <- map["GUESTCARD_CANCEL_CONFIRMATION"]
        guest_card_has_been_cancelled <- map["GUESTCARD_CANCEL_SUCCESS"]
        last_Visited <- map["GUESTCARD_LASTVISITED"]
        days_visited <- map["GUESTCARD_DAYSVISITED"]
        total_days <- map["GUESTCARD_TOTALDAYS"]
        days <- map["GUESTCARD_DAYS"]
        day <- map["GUESTCARD_DAY"]
        send_us_feedback <- map["SEND_US_FEEDBACK"]
        provide_feedback <- map["PLEASE_PROVIDE_YOUR_FEEDBACK"]
        appreciate_feedback <- map["WE_APPRECIATE_YOUR_FEEDBACK"]
        calendar_of_events <- map["CALENDAR_OF_EVENTS"]
        search <- map["SEARCH"]
        menus_hours <- map["MENUS_HOURS"]
        tee_times <- map["TEE_TIMES"]
        recent_news <- map["RECENT_NEWS"]
        tournament_forms <- map["TOURNAMENT_FORMS"]
        instructional_videos <- map["INSTRUCTIONAL_VIDEOS"]
        rules_etiquettes <- map["RULES_ETIQUETTE"]
        court_times <- map["COURT_TIMES"]
        dining_reservations <- map["DINING_RESERVATIONS"]
        dress_code <- map["DRESS_CODE"]
        download_statement <- map["DOWNLOAD_STATEMENT"]
        important_club_numbers <- map["IMPORTANT_CLUB_NUMBERS"]
        board_of_governers <- map["BOARD_OF_GOVERNORS"]
       
        forgot_your_password <- map["FORGOT_YOURPASSWORD"]
        enter_your_email <- map["ENTER_YOUREMAIL"]
        send <- map["SEND"]
        please_chek_your_email <- map["PLEASECHECK_YOUREMAIL"]
        enter_your_security_code <- map["ENTER_YOUR_SECURITYCODE"]
        OK <- map["OK"]
        resend_security_code <- map["RESEND_SECURITYCODE"]
        new_password <- map["NEW_PASSWORD"]
        confirm_password <- map["CONFIRM_PASSWORD"]
        enter_new_password <- map["ENTER_NEWPASSWORD"]
        password_being_created <- map["PASSWORD_RULES"]
        calendar_title <- map["CALENDAR_TITLE"]
        passwordRulsTitle <- map["PASSWORD_RULES"]
        passwordRuls1 <- map["PASSWORD_RULES_1"]
        passwordRuls2 <- map["PASSWORD_RULES_2"]
        passwordRuls3 <- map["PASSWORD_RULES_3"]
        passwordRuls4 <- map["PASSWORD_RULES_4"]

        guest_card_policy <- map["GUESTCARD_POLICY"]
        
        didYouKnow <- map["DIDYOUKNOW"]
        didYouKnowClubNews <- map["DIDYOUKNOW_CLUBNEWS"]
        didYouKnowEvents <- map["DIDYOUKNOW_EVENTS"]
        didYouKnowGlance <- map["DIDYOUKNOW_GLANCE"]
        didYouKnowMemberDire1 <- map["DIDYOUKNOW_MEMBERDIRECTORY_1"]
        didYouKnowMemberDire2 <- map["DIDYOUKNOW_MEMBERDIRECTORY_2"]
        didYouKnowMemberDire3 <- map["DIDYOUKNOW_MEMBERDIRECTORY_3"]
        didYouKnowStatement <- map["DIDYOUKNOW_STATEMENTS"]
        ableToViewByCategory <- map["ABLETOVIEWBYCATEGORY"]
        dlOrPassport <- map["DL_PASSPORT"]
        
        prefix <- map["PREFIX"]
        show_or_hide_myprofile <- map["SHOW_OR_HIDE_MY_PROFILE"]
        suffix <- map["SUFFIX"]
        middle_name <- map["MIDDLE_NAME"]
        other_phone <- map["OTHER_PHONE"]
        turn_email_notification <- map["TURN_EMAIL_NOTIFICATIONS"]
        send_statements_to <- map["SEND_STATEMENTS_TO"]
        send_magazines_to <- map["SEND_MAGAZINES_TO"]
        address_other <- map["ADDRESSOTHER"]
        street_address_1 <- map["STREET_ADDRESS_1"]
        street_address_2 <- map["STREET_ADDRESS_2"]
        state_or_Province <- map["STATEORPROVINCE"]
        postal_code <- map["POSTAL_CODE"]
        outside_us <- map["OUTSIDE_US"]
        address_bussiness <- map["ADDRESS_BUSINESS"]
        address_bocawest <- map["ADDRESS_BOCAWEST"]
        targetting_market_option <- map["TARGETED_MARKETING_OPT_IN_EMAIL_GROUPS"]
        my_Interest <- map["MY_INTERESTS"]
        username <- map["USERNAME"]
        status <- map["STATUS"]
        comments <- map["COMMENTS"]
        additionalEventDetails <- map["ADDITIONAL_EVENT_DETAILS"]
        captain <- map["CAPTAIN"]
        tickets <- map["#_OF_TICKETS"]
        register <- map["REGISTER"]
        cancel_reservation <- map["CANCEL_RESERVATION"]
        send_statements_to_colon <- map["SEND_STATEMENTS_TO_COLON"]
        send_magazine_to_colon <- map["SEND_MAGAZINES_TO_COLON"]
        YOUR_EVENT_UPDATE <- map["YOUREVENTUPDATE"]
        YOUR_EVENT_REQUEST <- map["YOUREVENTREQUEST"]
        YOUR_EVENT_CANCEL <- map["YOUREVENTCANCEL"]
        DO_YOU_WANT_CANCEL <- map["DOYOUWANTCANCEL"]
        alert <- map["ALERT"]
        external_reg <- map["EXTERNAL_REGISTRATION"]
        calendar_synch_success <- map["EVENTDETAILS_SYNCEDTOCALENDAR"]
        add_TO_DEVICE_CALENDAR <- map["ADDTO_DEVICE_CALENDAR"]
        TGAMEMBERVALIDATION <- map["TGAMEMBERVALIDATION"]
        EVENT_KID_INSTRUCTION <- map["EVENT_KID_INSTRUCTION"]
        DIRECTORY_MEMBER_KID_INSTRUCTION <- map["DIRECTORY_MEMBER_KID_INSTRUCTION"]
        DIRECTORY_BUDDY_KID_ISNTRUCTION <- map["DIRECTORY_BUDDY_KID_ISNTRUCTION"]
        EVENT_GUEST_INSTRUCTION <- map["EVENT_GUEST_INSTRUCTION"]
        DIRECTORY_MEMBER_GUEST_INSTRUCTION <- map["DIRECTORY_MEMBER_GUEST_INSTRUCTION"]
        DIRECTORY_BUDDY_GUEST_INSTRUCTION <- map["DIRECTORY_BUDDY_GUEST_INSTRUCTION"]
        EVENT_GUEST_KID_INSTRUCTION <- map["EVENT_GUEST_KID_INSTRUCTION"]
        DIRECTORY_MEMBER_GUEST_KID_INSTRUCTION <- map["DIRECTORY_MEMBER_GUEST_KID_INSTRUCTION"]
        DIRECTORY_BUDDY_GUEST_KID_INSTRUCTION <- map["DIRECTORY_BUDDY_GUEST_KID_INSTRUCTION"]
        SELECTED_COLON <- map["SELECTED_COLON"]
        EVENT_STATUSFILTER <- map["EVENT_STATUSFILTER"]
        SHOW_MORE <- map["SHOW_MORE"]
        CALENDER_FILTER <- map["CALENDER_FILTER"]
        CALENDER_CLEAR <- map["CALENDER_CLEAR"]
        COMMING_SOON <- map["COMMING_SOON"]
        MULTI_SELECT <- map["MULTI_SELECT"]
        MULTI_SELECT_DINING <- map["MULTI_SELECT_DINING"]
        CALENDER_CLOSE <- map["CALENDER_CLOSE"]
        FITNESS_SPA <- map["FITNESS_SPA"]
        HTML_TEXT <- map["HTML_TEXT"]
        
        IsDiningDateValidate <- map["IsDiningDateValidate"]
        IsDiningDateValidationMessage <- map["IsDiningDateValidationMessage"]
        IsMemberExistsValidation_Golf_1 <- map["IsMemberExistsValidation_Golf_1"]
        IsMemberExistsValidation_Tennis_1 <- map["IsMemberExistsValidation_Tennis_1"]
        IsMemberExistsValidation_Dining_1 <- map["IsMemberExistsValidation_Dining_1"]
        IsMemberExistsValidation_Golf_2 <- map["IsMemberExistsValidation_Golf_2"]
        IsMemberExistsValidation_Tennis_2 <- map["IsMemberExistsValidation_Tennis_2"]
        PRIVACY_POLICY <- map["PRIVACY_POLICY"]
        TERMS_of_Use <- map["TERMSOFUSE"]
        
        DINING_CANCEL_MESSAGE <- map["DINING_CANCEL_MESSAGE"]
        
        DININGEVENT_CANCEL_MESSAGE <- map["DININGEVENT_CANCEL_MESSAGE"]
        
        GOLFTENNIS_CANCEL_MESSAGE <- map["GOLFTENNIS_CANCEL_MESSAGE"]
        
        EVENT_CANCEL_MESSAGE <- map["EVENT_CANCEL_MESSAGE"]
        
        uPCOMING_FITNESSEVENTS <- map["UPCOMING_FITNESSEVENTS"]
           
        fITNESSSPA_POLICY <- map["FITNESSSPA_POLICY"]
        
        fITNESSANDSPA_CALENDAR <- map["FITNESSANDSPA_CALENDAR"]
        
        add_To_Waitlist <- map["ADD_TO_WAITLIST"]
           
        waitlist <- map["WAITLIST"]
           
        earlest_Tee_Time <- map["EARLIST_TEE_TIME"]
           
        latest_Tee_Time <- map["LATEST_TEE_TIME"]
        
        waitlist_Colorcode <- map["WAITLIST_COLORCODE"]
        
        waitlist_Value <- map["WAITLIST_VALUE"]
        
        //Added on 18th May 2020 v2.1
        
        clubNews_Title <- map["CLUBNEWS_TITLE"]
        clubNews_Date <- map["CLUBNEWS_DATE"]
        clubNews_Link <- map["CLUBNEWS_LINK"]
        
        
        //Added on 17th June 2020 BMS
        
        self.BMS_RequestAppointment <- map["BMS_REQUESTAPPOINTMENT"]
        self.BMS_Providers <- map["BMS_PROVIDERS"]
        self.BMS_Gender <- map["BMS_GENDER"]
        self.BMS_Request <- map["BMS_REQUEST"]
        self.BMS_SubmitNew <- map["BMS_SUBMITNEW"]
        self.BMS_Duration <- map["BMS_DURATION"]
        self.BMS_ProviderValidation <- map["BMS_PROVIDERVALIDATION"]
        self.BMS_Time <- map["BMS_TIME"]
        self.BMS_Date <- map["BMS_DATE"]
        self.BMS_SubmitMessage <- map["BMS_SUBMITMESSAGE"]
        self.BMS_Member <- map["BMS_MEMBER"]
        self.BMS_AvailableTime <- map["BMS_AVAILABLETIME"]
        self.BMS_GenderMale <- map["BMS_GENDERMALE"]
        self.BMS_GenderFemale <- map["BMS_GENDERFEMALE"]
        self.BMS_GenderAny <- map["BMS_GENDERANY"]
        self.BMS_DressCode <- map["BMS_DRESSCODE"]
        self.BMS_REASONTEXT  <- map["BMS_REASONTEXT"]
        self.BMS_REASON  <- map["BMS_REASON"]
        self.BMS_OTHERREASON  <- map["BMS_OTHERREASON"]
        self.BMS_SELECT <- map["BMS_SELECT"]
        
        //Added on 3rd July 2020 BMS
        self.BMS_CANCELREASON <- map["BMS_CANCELREASON"]
        self.BMS_CALENDAR <- map["BMS_CALENDAR"]
        self.BMS_REQUESTDETAILS <- map["BMS_REQUESTDETAILS"]
        self.BMS_PROVIDERNOT <- map["BMS_PROVIDERNOT"]
        
        //Added on 4th July 2020 V2.2
        self.role_Validation1 <- map["ROLE_VALIDATION1"]
        self.role_Validation2 <- map["ROLE_VALIDATION2"]

        //Added on 9th July 2020 V2.2
        self.BMS_ServiceValidation <- map["BMS_SERVICEVALIDATION"]
        self.BMS_Modify <- map["BMS_MODIFY"]
        self.BMS_CancelledMessage <- map["BMS_CANCELLEDMESSAGE"]
        self.BMS_Cancel_Message_IOS <- map["BMS_CANCEL_MESSAGE_IOS"]
        
        //Added on 10th July 2020 v2.3
        self.notification_Font_Size <- map["NOTIFICATION_FONT_SIZE"]
        
        //Added on 23rd Septmeber 2020 V2.3
        self.BMS_GuestDOB <- map["BMS_GUESTDOB"]
        
        //added on 24th September 2020 V2.3
        self.BMS_AppText_Header <- map["BMS_APPTEXT_HEADER"]
        
        //Added on 13th October 2020 V2.3
        self.MB_GiftCard <- map["MB_GIFTCARD"]
        
        //Added on 27th OCtober 2020 V2.4 -- GATHER0000176
        self.Fit_FitnessActivities <- map["FIT_FITNESSACTIVITIES"]
        self.Fit_Height <- map["FIT_HEIGHT"]
        self.Fit_Weight <- map["FIT_WEIGHT"]
        self.Fit_Groups <- map["FIT_GROUPS"]
        self.Fit_Checkin <- map["FIT_CHECKIN"]
        self.Fit_KnowMore <- map["FIT_KNOWMORE"]
        self.Fit_Duration <- map["FIT_DURATION"]
        self.Fit_Goal <- map["FIT_GOAL"]
        self.Fit_StartChallenge <- map["FIT_STARTCHALLENGE"]
        self.Fit_Group <- map["FIT_GROUP"]
        self.Fit_BackToVideos <- map["FIT_BACKTOVIDEOS"]
        self.Fit_InputText <- map["FIT_INPUTTEXT"]
        self.Fit_InputTextHere <- map["FIT_INPUTTEXTHERE"]
        self.Fit_Records <- map["FIT_RECORDS"]
        self.Fit_Hello <- map["FIT_HELLO"]
        self.Fit_FitnessApp <- map["FIT_FITNESSAPP"]
        self.Fit_PostedOn <- map["FIT_POSTEDON"]
        self.Fit_Exercises <- map["FIT_EXERCISES"]
        
        //Added by kiran V2.5 -- GATHER0000586 -- Added representative message
        self.BMS_SubmitMessageRep <- map["BMS_SUBMITMESSAGEREP"]
        
        //Added by Kiran V2.7 -- GATHER0000700 - Text for Tennis Book a lesson button
        //GATHER0000700 - Start
        self.TL_ButtonText <- map["TL_BUTTONTEXT"]
        self.TL_Providers <- map["TL_PROVIDERS"]
        self.TL_ProfessionalNot_Preferred <- map["TL_PROFESSIONALNOT_PREFERRED"]
        self.TL_ProviderValidation <- map["TL_PROVIDERVALIDATION"]
        
        self.TL_SubmitMessageRep <- map["TL_SUBMITMESSAGEREP"]
        self.TL_Modify <- map["TL_MODIFY"]
        self.TL_SubmitMessage <- map["TL_SUBMITMESSAGE"]
        self.TL_TennisLesson <- map["TL_TENNISLESSON"]
        self.BMSDuration_Text <- map["BMSDURATION_TEXT"]
        //GATHER0000700 - End
        
        //Added by kiran V2.7 -- ENGAGE0011559 -- international Number change
        //ENGAGE0011559 -- Start
        self.outside_US_Contact <- map["OUTSIDE_US_CONTACT"]
        self.outside_US_Contact_Text <- map["OUTSIDE_US_CONTACT_TEXT"]
        self.outside_US_Contact_Limit <- map["OUTSIDE_US_CONTACT_LIMIT"]
        //ENGAGE0011559 -- End
        
        //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments. Added department name for BMS sub category(eg. fitness , spa ,salon, etc..) permissions.
        //ENGAGE0011652 -- Start
        self.BMS_Fitness <- map["BMS_FITNESS"]
        self.BMS_Spa <- map["BMS_SPA"]
        self.BMS_Salon <- map["BMS_SALON"]
        //ENGAGE0011652 -- End
        
        //Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
        //GATHER0000923 -- Start
        self.BMS_Select_Category <- map["BMS_SELECT_CATEGORY"]
        //GATHER0000923 -- End
        
        //Added by kiran V2.8 -- ENGAGE0011784 -- Adding optional text for add guest reg vc..
        //ENGAGE0011784 -- Start
        self.BMS_Optional <- map["BMS_OPTIONAL"]
        
        self.go_Existing_Guest <- map["GO_EXISTING_GUEST"]
        self.go_New_Guest <- map["GO_NEW_GUEST"]
        self.go_Please_Select_Guest <- map["GO_PLEASE_SELECT_GUEST"]
        self.go_Search_Guest_Name <- map["GO_SEARCH_GUEST_NAME"]
        self.go_Guest <- map["GO_GUEST"]
        self.go_First_Name <- map["GO_FIRST_NAME"]
        self.go_Last_Name <- map["GO_LAST_NAME"]
        //ENGAGE0011784 -- End
        
        //Added by kiran v2.8 -- GATHER0001149
        //GATHER0001149 -- Start
        self.BMS_Fitness_Comments <- map["BMS_FITNESS_COMMENTS"]
        self.BMS_Spa_Comments <- map["BMS_SPA_COMMENTS"]
        self.BMS_Salon_Comments <- map["BMS_SALON_COMMENTS"]
        self.BMS_Tennis_Comments <- map["BMS_TENNIS_COMMENTS"]
        
        self.BMS_Fitness_Comments_Colon <- map["BMS_FITNESS_COMMENTS_COLON"]
        self.BMS_Spa_Comments_Colon <- map["BMS_SPA_COMMENTS_COLON"]
        self.BMS_Salon_Comments_Colon <- map["BMS_SALON_COMMENTS_COLON"]
        self.BMS_Tennis_Comments_Colon <- map["BMS_TENNIS_COMMENTS_COLON"]
        
        self.golfReservation_GuestAdd <- map["GOLFRESERVATION_GUESTADD"]
        self.tennisReservation_GuestAdd <- map["TENNISRESERVATION_GUESTADD"]
        self.diningReservation_GuestAdd <- map["DININGRESERVATION_GUESTADD"]
        
        self.BMS_Fitness_GuestAdd <- map["BMS_FITNESS_GUESTADD"]
        self.BMS_Spa_GuestAdd <- map["BMS_SPA_GUESTADD"]
        self.BMS_Salon_GuestAdd <- map["BMS_SALON_GUESTADD"]
        self.BMS_Tennis_GuestAdd <- map["BMS_TENNIS_GUESTADD"]

        
        self.confirm_Yes <- map["CONFIRM_YES"]
        self.confirm_No <- map["CONFIRM_NO"]
        //GATHER0001149 -- End
        
        //Added by kiran V2.9 -- GATHER0001167 --
        //GATHER0001167 -- Start
        self.BMS_Golf_ButtonText <- map["BMS_GOLF_BUTTONTEXT"]
        self.BMS_Golf_Comments <- map["BMS_GOLF_COMMENTS"]
        self.BMS_Golf_Comments_Colon <- map["BMS_GOLF_COMMENTS_COLON"]
        self.BMS_Golf_Professionals <- map["BMS_GOLF_PROFESSIONALS"]
        self.BMS_GolfLesson <- map["BMS_GOLFLESSON"]
        self.BMS_Golf_Request <- map["BMS_GOLF_REQUEST"]
        self.BMS_Golf_ProviderNotAvailable <- map["BMS_GOLF_PROVIDERNOTAVAILBLE"]
        self.BMS_Golf_ProviderNotPreferred <- map["BMS_GOLF_PROVIDERNOTPREFERED"]
        self.BMS_Golf_GuestAdd <- map["BMS_GOLF_GUESTADD"]
        
        
        self.BMS_CancelledMessage_Fitness <- map["BMS_CANCELLEDMESSAGE_FITNESS"]
        self.BMS_Cancel_Message_IOS_Fitness <- map["BMS_CANCEL_MESSAGE_IOS_FITNESS"]
        self.BMS_CancelledMessage_Spa <- map["BMS_CANCELLEDMESSAGE_SPA"]
        self.BMS_Cancel_Message_IOS_Spa <- map["BMS_CANCEL_MESSAGE_IOS_SPA"]
        self.BMS_CancelledMessage_Salon <- map["BMS_CANCELLEDMESSAGE_SALON"]
        self.BMS_Cancel_Message_IOS_Salon <- map["BMS_CANCEL_MESSAGE_IOS_SALON"]
        self.BMS_CancelledMessage_TennisLesson <- map["BMS_CANCELLEDMESSAGE_TENNISLESSON"]
        self.BMS_Cancel_Message_IOS_TennisLesson <- map["BMS_CANCEL_MESSAGE_IOS_TENNISLESSON"]
        self.BMS_CancelledMessage_GolfLesson <- map["BMS_CANCELLEDMESSAGE_GOLFLESSON"]
        self.BMS_Cancel_Message_IOS_GolfLesson <- map["BMS_CANCEL_MESSAGE_IOS_GOLFLESSON"]

        //GATHER0001167 -- End
        
        //Added by kiran V2.9 -- ENGAGE0011722 -- Apple wallet functionality
        //ENGAGE0011722 -- Start
        self.wallet_Cancel <- map["WALLET_CANCEL"]
        self.wallet_Remove <- map["WALLET_REMOVE"]
        self.wallet_Alert <- map["WALLET_ALERT"]
        self.wallet_Replace_Text <- map["WALLET_REPLACE_TEXT"]
        self.wallet_Remove_Text <- map["WALLET_REMOVE_TEXT"]
        self.wallet_LibraryNot <- map["WALLET_LIBRARYNOT"]
        self.wallet_Device_Wallet <- map["WALLET_DEVICE_WALLET"]
        self.wallet_Ok <- map["WALLET_OK"]
        self.wallet_Replace <- map["WALLET_REPLACE"]
        self.wallet_ErrorMessage <- map["WALLET_ERRORMESSAGE"]
        //ENGAGE0011722 -- End
        
        //Commented by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
        //ENGAGE0011898 -- Start
        self.guestCardPolicy_Category <- map["GUESTCARDPOLICY_CATEGORY"]
        self.guestCardPolicy_Section <- map["GUESTCARDPOLICY_SECTION"]
        self.guestCardPolicy_Name <- map["GUESTCARDPOLICY_NAME"]
        //ENGAGE0011898 -- End
        
        //Added by kiran V2.9 -- ENGAGE0011597 -- Text for header.
        //ENGAGE0011597 -- Start
        self.giftCard_Description <- map["GIFTCARD_DESCRIPTION"]
        self.giftCard_RemainingCount <- map["GIFTCARD_RENAININGCOUNT"]
        self.giftCard_IssuedDate <- map["GIFTCARD_ISSUEDDATE"]
        self.giftCard_ExpirationDate <- map["GIFTCARD_EXPIRATIONDATE"]
        self.giftCard_Description_NoColon <- map["GIFTCARD_DESCRIPTION_NOCOLON"]
        self.giftCard_RemainingCount_NoColon <- map["GIFTCARD_RENAININGCOUNT_NOCOLON"]
        //ENGAGE0011597 -- End
        
        //Added by kiran v2.9 -- GATHER0000623 -- Disclaimer set-up by service to prompt based on settings
        //GATHER0000623 -- Start
        self.BMS_Ok <- map["BMS_OK"]
        self.BMS_Disclaimer <- map["BMS_DISCLAIMER"]
        //GATHER0000623 -- End
        
        //Added by kiran v2.9 -- Cobalt Pha0010644 -- Function to show Hard & Soft message details of courses when date is changed
        //Cobalt Pha0010644 -- Start
        self.golfAdvance_Yes <- map["GOLFADVANCE_YES"]
        self.golfAdvance_No <- map["GOLFADVANCE_NO"]
        self.golfAdvanceTitle <- map["GOLFADVANCETITLE"]
        self.golfAdvance_Ok <- map["GOLFADVANCE_OK"]
        //Cobalt Pha0010644 -- End
        
        //Added by kiran V2.9 -- ENGAGE0012268 -- Lightning Warning button title
        //ENGAGE0012268 -- Start
        self.Golf_LWS <- map["GOLF_LWS"]
        //ENGAGE0012268 -- End
        
        
        //Added by kiran V1.2
        self.authentication_AccountExpired <- map["AUTHENTICATION_ACCOUNTEXPIRED"]
        self.authentication_ExpiredText <- map["AUTHENTICATION_EXPIREDTEXT"]
        self.authentication_Logout <- map["AUTHENTICATION_LOGOUT"]
        
        //Added by kiran V3.0 -- ENGAGE0011843 -- Guest card Offspring comparision key.
        //ENGAGE0011843 -- Start
        self.guestCard_OF <- map["GUESTCARD_OF"]
        //ENGAGE0011843 -- End
        
        //Added by kiran V1.3 -- PROD0000069 -- Support to request events from club news on click of news
        //PROD0000069 -- Start
        self.clubNewsToEvents_OK <- map["CLUBNEWSTOEVENTS_OK"]
        //PROD0000069 -- End
        
        //Added by kiran V1.4 -- PROD0000121 -- changed the request key to individual departents keys.
        //PROD0000121 -- Start
        self.BMS_Fitness_Request <- map["BMS_FITNESS_REQUEST"]
        self.BMS_Tennis_Request <- map["BMS_TENNIS_REQUEST"]
        self.BMS_Spa_Request <- map["BMS_SPA_REQUEST"]
        self.BMS_Salon_Request <- map["BMS_SALON_REQUEST"]
        //PROD0000121 -- End
        
        //Added by kiran V1.4 -- PROD0000148 -- Success mesage popup message change
        //PROD0000148 -- Start
        self.your_Dining_Event_Cancel <- map["YOURDININGEVENTCANCEL"]
        //PROD0000148 -- End
        
        // Added by Zeeshan May 11 2022
        self.legendInfoTitle <- map["LEGENDS_INFO_TITLE"]
        self.legendInfoValue <- map["LEGENDS_INFO_VALUE"]
        self.legendInfoTransValue <- map["LEGENDS_INFO_TRANS_VALUE"]
        self.cONTACT_UPDATE_SUCCESS <- map["CONTACT_UPDATE_SUCCESS"]
        self.cONTACT_NAME_ALREADY_EXISTS <- map["CONTACT_NAME_ALREADY_EXISTS"]
        self.cONTACT_NUMBER_ALREADY_EXISTS <- map["CONTACT_NUMBER_ALREADY_EXISTS"]
        self.cONTACT_NAME_ALREADY_EXISTS_UPDATE <- map["CONTACT_NAME_ALREADY_EXISTS_UPDATE"]
        self.cONTACT_NUMBER_ALREADY_EXISTS_UPDATE <- map["CONTACT_NUMBER_ALREADY_EXISTS_UPDATE"]
        self.fCFS_SELECTTIMEVALIDATION <- map["FCFS_SELECTTIMEVALIDATION"]
        self.gOLF_REQUEST_SUCCESS_MESSAGE_FCFS <- map["GOLF_REQUEST_SUCCESS_MESSAGE_FCFS"]
    }
    
    
}

