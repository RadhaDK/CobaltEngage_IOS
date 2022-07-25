
import Foundation


struct NumberConstant {
    static let cornerRadious = 2.0
}

struct APIKeys
{
    static let kMemberId = "MemberID"
    static let kParentId = "ParentID"
    static let kid = "ID"
    static let kusername = "UserName"
    static let kpassword = "Password"
    
    static let kcurrentPassword = "CurrentPassword"
    static let knewPassword = "NewPassword"
    
    static let kconfirmpassword = "ConfirmPassword"
    static let kfilepath = "FilePath"
    static let kfromwhere = "FromWhere"
    static let kimage = "Image"
    static let keffectivedate = "EffectiveDate"
    static let ksearchby = "SearchBy"
    static let kdisplayName = "DisplayName"
    static let kmiddleName = "MiddleName"
    static let ksuffix = "Suffix"
    static let kprefix = "Prefix"
    static let kisVisibleInDirectory = "IsVisibleInDirectory"
    static let kshowProfilePhoto = "ShowProfilePhoto"

    static let ktargetedNarketingoptions = "TargetedMarketingOption"
    static let kalternatePhone = "AlternatePhone"
    static let kshowPrimaryPhone = "ShowPrimaryPhone"

    static let kshowSecondaryPhone = "ShowSecondaryPhone"
    static let kshowAlternatePhone = "ShowAlternatePhone"
    static let kshowPrimaryEmail = "ShowPrimaryEmail"
    static let kshowVillage = "ShowVillageName"
    static let kshowBirthday = "ShowBirthday"
    static let kshowSecondaryEmail = "ShowSecondaryEmail"
    static let kprimaryEmailNotification = "PrimaryEmailNotification"
    static let ksecondaryEmailNotification = "SecondaryEmailNotification"
    static let ksendStatementTo = "SendStatementTo"
    static let ksendMagazineTo = "SendMagazineTo"
    static let kshowBocaAddress = "ShowBocaAddress"
    static let kshowBusinessAddress = "ShowBusinessAddress"
    static let kshowOtherAddress = "ShowOtherAddress"
    static let kaddress = "Address"
    static let kaddressType = "AddressType"
    static let kaddressLine1 = "AddressLine1"
    static let kaddressLine2 = "AddressLine2"
    static let kcity = "City"
    static let kzipCode = "ZipCode"
    static let kcountry = "Country"
    static let kstate = "State"
    static let kisOutsideUnitedState = "IsOutsideUnitedState"
    static let kaddressID = "AddressID"
    static let kaddressTypeID = "AddressTypeID"

    //Added by kiran V2.7 -- ENGAGE0011559 -- international Number change
    //ENGAGE0011559 -- Start
    static let kIsOutSideUSPhone = "IsOutSideUSPhone"
    //ENGAGE0011559 -- End
    static let valuedateformat = "MM/dd/yyyy"

    
    
    static let kdepartmentName = "DepartmentName"
    static let kyear = "Year"
    static let kmonth = "Month"
    static let kreceiptNo = "ReceiptNo"
    static let kreceiptNumber = "ReceiptNumber"
    static let kemailid = "Email"
    static let kguestid = "GuestID"
    static let klinkedmemberid = "LinkedMemberIds"
    static let kfirstName = "FirstName"
    static let klastName = "LastName"
    static let krelation = "Relation"
    static let krestaurentID = "RestaurentID"
    
    static let kprimaryphone = "PrimaryPhone"
    static let kGuests = "Guests"
    static let kinterest = "Interests"
    static let kpagecount = "PageCount"
    static let krecordperpage = "RecordsPerPage"
    
    static let kID = "ID"
    static let kTransactionID = "TransactionID"
    static let kLinkedMemberID = "LinkedMemberID"
    static let kAccompanyWithMainMember = "AccompanyWithMainMember"
    static let kFromDate = "FromDate"
    static let kToDate = "ToDate"
    static let kSelectedNumbers = "SelectedNumbers"
    
    static let kdeviceID = "DeviceID"
    static let kdeviceInfo = "DeviceInfo"
    static let kDeviceType = "DeviceType"
    static let kOSVersion = "OSVersion"
    static let kOriginatingIP = "OriginatingIP"
    static let keventCategory = "EventCategory"
    static let kGlanceCategory = "GlanceCategory"
    static let kCategory = "Category"
    //Added on 17th October 2020 V2.3
    static let kAppVersion = "AppVersion"
    static let ksecondaryPhone = "SecondaryPhone"
    static let kprimaryEmail = "PrimaryEmail"
    static let ksecondaryEmail = "SecondaryEmail"
    
    
    static let kmonthCount = "MonthCount"
    
    static let kIsSortFilterApplied = "IsSortFilterApplied"
    
    //token
    static let kclient_id = "client_id"
    static let kclient_secret = "client_secret"
    static let kgrant_type = "grant_type"
    static let kscope = "scope"

    static let kPhone = "Phone"
    static let kDOB = "DateOfBirth"
    static let kDuration = "Duration"
    static let kExtendBy = "ExtendBy"
    
    
    static let kEventStatusSort = "EventStatusSort"
    
    //Statements
     static let kStatementCategory = "Category"
     static let kDescriptions = "Description"
     static let kPurchaseDate = "PurchaseDate"
     static let kPurchaseTime = "PurchaseTime"
     static let kAmount = "Amount"
     static let kStatementID = "StatementID"
    
    //Added on 4th June 2020 BMS
    
    //Fitness and spa BMS
    static let kLocationID = "LocationID"
    static let kServiceID = "ServiceID"
    static let kProductClassID = "ProductClassID"
    static let kProviderID = "ProviderID"
    static let kGender = "Gender"
    static let kStatus = "Status"
    static let kIsAdmin = "IsAdmin"
    static let kUserName = "UserName"
    static let kRole = "Role"
    static let kUserID = "UserId"
    static let kAppointmentType = "AppointmentType"
    static let kAppointmentDate = "AppointmentDate"
    static let kAppointmentTime = "AppointmentTime"
    static let kAppointmentID = "AppointmentID"
    static let kMemberCount = "MemberCount"
    static let kDetails = "Details"
    static let kProviderGender = "ProviderGender"
    static let kComments = "Comments"
    
    //Fintess member validation Member keys
    
    static let kAppointmentMemberID = "AppointmentMemberID"
    static let kMemberLastName = "MemberLastName"
    static let kName = "Name"
    static let kGuestMemberOf = "GuestMemberOf"
    static let kGuestMemberNo = "GuestMemberNo"
    static let kGuestType = "GuestType"
    static let kGuestName = "GuestName"
    static let kGuestEmail = "GuestEmail"
    static let kGuestContact = "GuestContact"
    static let kDisplayOrder = "DisplayOrder"
    //Added on 4th September 2020 V2.3
    static let kGuestGender = "GuestGender"
    static let kGuestDOB = "GuestDOB"

    //BMS cancel appointment cancel
    static let kAppointmentDetailID = "AppointmentDetailID"
    static let kCancelReason = "CancelReason"
    
    //Added on 12th October 2020 V2.3
    //GiftCard
    static let status = "Status"
    static let cardType = "CardType"
    
    //Added on 16th October 2020 V2.3
    //Fitness App
    static let videoSubCategoryID = "VideoSubCategoryID"
    static let videoCategoryID = "VideoCategoryID"
    static let preferenceType = "PreferenceType"
    static let fitnessProfileID = "FitnessProfileID"
    static let height = "Height"
    static let weight = "Weight"
    static let groupDetails = "GroupDetails"
    static let isFavourite = "IsFavourite"
    static let videoID = "VideoID"

    
    //Fitness App profile group details keys
    static let groupAdienceID = "GroupAdienceID"
    static let groupID = "GroupID"
    static let goalType = "GoalType"
    static let goalMasterID = "GoalMasterID"
    static let eventID = "EventID"
    static let goalID = "GoalID"
    static let achieved = "Achieved"
    static let goalParticipantDataID = "GoalParticipantDataID"
    
    
    //Added by kiran -- ENGAGE0011230
    static let smsNotifications = "AllowSmsNotifications"
    
    //Added by Kiran V2.7 -- GATHER0000700 -- Book a lesson changes
    //GATHER0000700 - Start
    static let kDepartment = "Department"
    //GATHER0000700 - End
    
    
    //Added by kiran V2.7 -- ENGAGE0011614 -- sending the bluetooth and location permission and service state to backend
    //ENGAGE0011614 -- Start
    static let kBluetoothServiceStatus = "BluetoothServiceStatus"
    static let kBluetoothPermissionType = "BluetoothPermissionType"
    static let kLocationServiceStatus = "LocationServiceStatus"
    static let kLocationPermissionType = "LocationPermissionType"
    static let kIsStoreInfo = "IsStoreInfo"
    
    //Added by kiran V2.9 -- ENGAGE0012323 -- Implementing App tracking Transperency changes
    //ENGAGE0012323 -- Start
    static let kAppTrackingPermission = "AppTrackingPermission"
    //ENGAGE0012323 -- End
    
    //ENGAGE0011614 -- End
    
    //Added by kiran V2.7 -- ENGAGE0011658 -- Get identifier for device modle
    //ENGAGE0011658 -- Start
    static let kDeviceIdentifier = "DeviceIdentifier"
    //ENGAGE0011658 -- End
    
    // Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
    //GATHER0000923 -- Start
    static let kServiceCategoryID = "ServiceCategoryID"
    //GATHER0000923 -- End
    
    //Added by kiran V2.8 -- ENGAGE0011784 --
    //ENGAGE0011784 -- Start
    
    static let kGuestFirstName = "GuestFirstName"
    static let kGuestLastName = "GuestLastName"
    static let kType = "Type"
    static let kReservationRequestDate = "ReservationRequestDate"
    static let kReservationRequestTime = "ReservationRequestTime"
    static let kRequestDate = "RequestDate"
    static let kAddBuddy = "AddBuddy"
    static let kGuestLinkedMemberID = "GuestLinkedMemberID"
    static let kGuestIdentityID = "GuestIdentityID"
    //ENGAGE0011784 -- End
    
    //Added by kiran V2.9 -- ENGAGE0011898 -- Added support for GuestCard PDF instead of fetching details from API
    //ENGAGE0011898 -- Start
    static let kSectionName = "SectionName"
    //ENGAGE0011898 -- End
    
    //Added by kiran V1.3 -- PROD0000019 -- Added 2 step verification
    //PROD0000019 -- Start
    static let kOTP = "OTP"
    //PROD0000019 -- End
}

struct APIHeader
{
    static let kusername = "username"
    static let kpassword = "password"
    static let kusernamevalue = "bocawest"
    static let kpasswordvalue = "bocawestpassword"
    static let kautherization = "Authorization"
    static let kculturecode = "CultureCode"
    static let kContentType = "Content-Type"
    //Added by kiran V2.8 -- ENGAGE0011784 --
    //ENGAGE0011784 -- Start
    static let kSearchChar = "SearchChar"
    //ENGAGE0011784 -- End
}

struct Symbol{
    static var kdollar = "$"
    static var kextmark = "!"
    static var khash = "#"
    static var mtd = " MTD"
    
    
}


struct Login{
    static let username_hint = "Member ID"
    static let password_hint = "Password"
    static let login_btntext = "Login"
    static let forgotpwd_text = "Forgot Password?"
}

struct LoginValidation {
    static let kEnterusername = "Enter Member ID"
    static let kEnterpassword = "Enter Password"
    static let kusernamepaswwordinvalid = "Username and Pasword are not matched"
    static let kEnteremail = "Enter Email ID"
    static let kInvalidEmail = "Enter Email ID is Invalid"
    static let kUsernamecharlenght = "Enter Valid Member ID"
    static let kPasswordcharlenght = "Password should be more than 4 character"
    
    static let kEnterfirstname = "Enter First Name"
    static let kEnterlastname = "Enter Last Name"
    static let kEnterphonenumber = "Enter Phonenumber"
    static let kChooseRelation = "Please Choose Relation"
    
}

struct LandingTabbar {
    static let lHome = "Home"
    static let lGuestcard = "Guest Card"
    static let lStatement = "Statemenr"
    static let lMore = "More"
}

struct InternetMessge {
    
    static var kInternet_not_available = "There is no internet connection."
    static let kSuccess = "Success"
    static let kFail = "Fail"
    static let kNoupcomingVisits = "No upcoming visits"
    static var kNoData = "No data found"
    
}

struct Duration {
    static let kShortDuration = Int(2)
    static let kMediumDuration = Int(4)
    static let kLonguration = Int(10)
    static let kveryShorturation = Int(1)
//        static let kShortDuration = Int(3)
//        static let kMediumDuration = Int(3)
//        static let kLonguration = Int(3)
//        static let kveryShorturation = Int(3)
}


struct ApiErrorMessages {
    static let kUnauthorized = "Unauthorized"
    static let kInvalidInput = "Invalid Input"
    static let kResourceNotFound = "Resource Not Found"
    static let kRequestTimeout = "Request Time-out"
    static let kMethodNotAllowed = "Method Not Allowed"
    static let kInternalServerError = "Internal Server Error"
    static let kHttpversionnotsupported = "Http version not supported"
//    static let kNoData = "No Data Found"
    
    
}

//Added on 23rd October 2020 V2.4 -- GATHER0000176
struct AppIdentifiers
{
    static let fitnessApp = "Fitness"
    static let fitnessProfileScreenID = "Profile"
    static let fitnessSettingsScreenID = "Settings"
    static let fitnessVideosScreenID = "Videos"
    static let namePlaceHolder = "{#Name}"
    
    //Added by kiran V2.7 -- ENGAGE0011652 -- Roles and privilages change for fitnessSpa departments. Added strings for comparision
    //ENGAGE0011652 -- Start
    ///Currently used in Access manager to indicate book a lesson department in BMS.
    static let tennis = "Tennis"
    
    ///BMS(Fitness & Spa)
    static let fitnessSpa = "FitnessSpa"
    //Added by kiran V2.9 -- GATHER0001167 -- Golf BAL roles and privilages Supprt
    //GATHER0001167 -- Start
    static let golf = "Golf"
    //GATHER0001167 -- End

}

//Added by kiran V2.5 -- GATHER0000590 -- Date format
//GATHER0000590 -- Start
struct DateFormats {
    ///Format:-  MM-dd-yyyy
    static let mm_dd_yyyy_WithDash = "MM-dd-yyyy"
    
    ///Format:- MMM dd, yyyy
    static let BMSSelectedDate = "MMM dd, yyyy"
    
    //Added by kiran V2.8 -- ENGAGE0011784 --
    //ENGAGE0011784 -- Start
    ///Format:- MM/dd/yyyy
    static let addGuestDatePickerFormat = "MM/dd/yyyy"
    //ENGAGE0011784 -- End
    
    //Added by kiran v2.9 -- Cobalt Pha0010644 -- Function to show Hard & Soft message details of courses when date is changed
    //Cobalt Pha0010644 -- Start
    ///Format:- hh:mm a
    static let timehma = "hh:mm a"
    //Cobalt Pha0010644 -- End
}
//GATHER0000590 -- Start

//Added by kiran V2.8 -- ENGAGE0011784 -- Existing guest API
//ENGAGE0011784 -- Start
struct AppModuleKeys
{
    static let golf = "Golf"
    static let tennis = "Tennis"
    static let dining = "Dining"
    static let fitnessAndSpa = "FitnessSpa"
    static let tennisBookALesson = "Tennis_BookALesson"
    static let reservation = "Reservations"
    static let events = "Events"
    static let BMS = "BMS"
    //Added by kiran V2.9 -- GATHER0001167 -- Added Golf BAL
    //GATHER0001167 -- Start
    static let golfBookALesson = "Golf_BookALesson"
    //GATHER0001167 -- End
}
//ENGAGE0011784 -- End


//Added by kiran V3.0 -- ENGAGE0011722 -- Pass error messages
//ENGAGE0011722 -- Start
struct PassErrorMessage
{
    static let unableToAdd = "An Error ocurred while add pass to the wallet."
    static let deviceNotCapable = "Device Cannot add pass."
    static let libNotAvailable = "Pass library not available."
}
//ENGAGE0011722 -- End
