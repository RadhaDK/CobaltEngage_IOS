

import Foundation


struct APPColor {
    struct viewBackgroundColor {
        //Background color for all viewcontroller(Layout)
        static var viewbg = hexStringToUIColor(hex: "F5F5F5")
        //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
        //PROD0000202 -- Start
        static var preferenceTimeColor = hexStringToUIColor(hex: "77A1A4")
        //PROD0000202 -- End
    }
    
    struct tintColor {
        static var tint = hexStringToUIColor(hex: "c8a773")    //brown
        static var tintNew = hexStringToUIColor(hex: "F47D4C")    //brown
        static var tintNewLogin = hexStringToUIColor(hex: "695b5e")
        static var changePassword = hexStringToUIColor(hex: "40B2E6")    //brown


    }
    struct backGroundColor {
        static var tint = hexStringToUIColor(hex: "f06e44")

        //brown
    }
    
    struct placeHolderColor {
        static var tint = hexStringToUIColor(hex: "ffffff")    //white
    }
    struct solidbgColor {
        
        static var solidNewbg = hexStringToUIColor(hex: "f06c42")     //blue

        static var solidbg = hexStringToUIColor(hex: "67aac9")     //blue
    }
    struct viewBgColor {
        static var viewbg = hexStringToUIColor(hex: "ffffff")     //white
    }
    struct viewNews {
        static var viewbg = hexStringToUIColor(hex: "F47D4C")     //white
        static var backButtonColor = MainColours.primary2

    }
    struct selectedcellColor {
        static var selectedcell = hexStringToUIColor(hex: "faf6ef")     
    }
    
    
  
    
    struct tabBtnColor {
        static var selected = hexStringToUIColor(hex: "ffffff")     //black header
        static var unselected = hexStringToUIColor(hex: "aaaaaa")     //black
        
    }
    
    struct textheaderColor {
        static var header = hexStringToUIColor(hex: "4a4a4a")     //black
        
        
    }
    struct celldividercolor {
        // static var divider = hexStringToUIColor(hex: "9b9b9b").withAlphaComponent(0.3)     //black
        static var divider = hexStringToUIColor(hex: "E1E0E1")     //black
        
        
        
        
    }
    
    struct notificationstatuscolor {
        static var readstatus = hexStringToUIColor(hex: "F4F4F4")
    }
    
    
    
    struct statementcategories {
        static var category = hexStringToUIColor(hex: "ffffff").withAlphaComponent(0.4)     //black
    }
    
    //todat at glance
    
    struct todayatglancestatus {
        static var open = hexStringToUIColor(hex: "417505")    //green
        static var close = hexStringToUIColor(hex: "af192b")    //red
        static var red = hexStringToUIColor(hex: "FF0000")    //api red
        static var black = hexStringToUIColor(hex: "000000")    //api red
        static var green = hexStringToUIColor(hex: "008000")    //api red
        
        
        
    }
    
    //Dashboard
    struct dashboardwhite {
        static var bgwhite = hexStringToUIColor(hex: "ffffff").withAlphaComponent(0.9)     //black
    }
    
    
    
    struct maskViewBackgroundColor {
        static var maskViewBGColor = UIColor.white  //UIColor(hexString: "#0A192AFF").withAlphaComponent(0.4)
    }
    struct navigationColor {
        static var titleTextAttributesColor = UIColor.white
        static var barTintColor = MainColours.primary1
        static var barbackgroundcolor = MainColours.primary1//hexStringToUIColor(hex: "695B5E")
        static var backbarcolor = hexStringToUIColor(hex: "c9a873")
        static var navigationitemcolor = hexStringToUIColor(hex: "ffffff")
        
        static var filterBGColor = hexStringToUIColor(hex: "67aac9")
        static var solidNewbg = hexStringToUIColor(hex: "f06c42")     //blue

        static var tintBGColor = hexStringToUIColor(hex: "ffffff")
        
        
        
        
    }
    
    struct loginBackgroundButtonColor {
        static var loginBtnBGColor = MainColours.primary2
        static var loginusernameColor = hexStringToUIColor(hex: "bd9f68")
        static var loginpasswordColor = hexStringToUIColor(hex: "bd9f68")
        static var loginfgColor = hexStringToUIColor(hex: "bd9f68")
        static var loginBtnTextColor = hexStringToUIColor(hex: "bd9f68")
    }
    
    struct  profileColor {
        static var profileheadercolor = hexStringToUIColor(hex: "322f2f")
        static var profilebgcolor = hexStringToUIColor(hex: "e4e2de")
        static var profiletypetitlecolor = hexStringToUIColor(hex: "4a4a4a")
        static var profiletypenamecolor = hexStringToUIColor(hex: "000000")
        static var profileaddonnamecolor = hexStringToUIColor(hex: "4a4a4a")
        static var dividercolor = hexStringToUIColor(hex: "9b9b9b")
    }
    
    struct SegmentController {
        static var selectedSegmentBGColor = hexStringToUIColor(hex: "081F2A")
        static var nonSelectedSegmentBGColor = hexStringToUIColor(hex: "073B53")
    }
    
    
    
    struct GuestCardstatus
    {
        static var pending = hexStringToUIColor(hex: "af192b")
        static var approved = hexStringToUIColor(hex: "417505")

    }
    
    //MOdified on 20th October 2020 V2.4
    struct textColor
    {
        static var text = hexStringToUIColor(hex: "000000")     //black header
        static var textBlack = hexStringToUIColor(hex: "9b9b9b")     //black
        static var textNewColor = hexStringToUIColor(hex: "695B5E")     //black

        //used in fitness app for now
        ///Text color of all primary text fields in app.
        static let primary : UIColor = hexStringToUIColor(hex: "#695B5E")
        //Added by kiran V2.8 -- ENGAGE0011784 --
        //ENGAGE0011784 -- Start
        ///Light primary for text headers header.
        static let primaryHeader : UIColor = UIColor.init(red: 105/255.0, green: 91/255.0, blue: 94/255.0, alpha: 0.85)
        //ENGAGE0011784 -- End
        
        //Grayes out version of primary color
        static let lightPrimary : UIColor = hexStringToUIColor(hex: "#8F8F8F")
        
        //Selection Colour currently used for fitness category in golas and challenges screen
        static let secondary : UIColor = MainColours.primary2
        
        //Used in fitness App.
        ///text color for active status of activity status
        static let activeStatusText : UIColor = hexStringToUIColor(hex: "#1EA554")
        
        static let conatinedTextColor : UIColor = .white
        
        static let whiteText : UIColor = .white
        
        static let fitnessGroupActivity : UIColor = hexStringToUIColor(hex: "#676767")
        //Added by kiran V2.7 -- ENGAGE0011559 -- International number change
        //ENGAGE0011559 -- Start
        ///Color of the text lbl ex. Home Phone, cell phone,birthday, etc..
        static let profileScreenTextLbl : UIColor = hexStringToUIColor(hex: "484848")
        //ENGAGE0011559 -- End
        
        // Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
        //GATHER0000923 -- Start
        ///Pickle ball header label color
        static let pickleBallHeaderColor : UIColor = hexStringToUIColor(hex: "#695B5E")
        //GATHER0000923 -- End
    }
    
    //Added on 20th October 2020 V2.4
    ///The colours used in the app
    struct MainColours
    {
        //Brown
        static let primary1 : UIColor = hexStringToUIColor(hex: " #2A4E7D")
        //orange
        static let primary2 : UIColor = hexStringToUIColor(hex: "#00C6FF")
        
        static let primary3 : UIColor = hexStringToUIColor(hex: "#1D1DFF")
        
        //used in fitness App
        ///Indicates the active state
        static let active : UIColor = .green
    }
    
    struct NavigationControllerColors
    {
        static let barTintColor : UIColor = MainColours.primary1
        //Only used in FItness App videos Screen
        static let barWhite : UIColor = .white
        
        //Member iD bar tint color
        static let memberIDBarTintColor : UIColor = hexStringToUIColor(hex: "f06c42")
        
        //Added by kiran V2.5 11/30 -- ENGAGE0011297 --
        static let memberIDBackBtnColor : UIColor = .white
    }
    
    struct ButtonColors
    {
        static let primary : UIColor = MainColours.primary1
        static let primaryBorder : UIColor = MainColours.primary1
        static let secondary : UIColor = MainColours.primary2
        static let secondaryBorder : UIColor = MainColours.primary2
        
        static let alert : UIColor = hexStringToUIColor(hex: "#00AFFF")
        static let alertBorder : UIColor = .white
        
        ///Text color when the background of the button is non white.
        static let containedTextColor : UIColor = .white
        
    }
    
    struct Switch
    {
        static let onColor : UIColor = hexStringToUIColor(hex: "#40B2E6")
    }
    
    struct OtherColors
    {
        static let activeDot : UIColor = hexStringToUIColor(hex: "#1BCB61")
        
        static let shadowColor : UIColor = hexStringToUIColor(hex: "#00000029")
        
        static let groupBorderColor : UIColor = hexStringToUIColor(hex: "#707070")
        
        static let appWhite : UIColor = hexStringToUIColor(hex: "#F5F5F5")
        
        static let lineColor : UIColor = hexStringToUIColor(hex: "#CCCBCB")
        
        static let deviderColor : UIColor = hexStringToUIColor(hex: "#CCCBCB")
        
        //Added by kiran V2.8 -- ENGAGE0011784 -- Border Color.
        //ENGAGE0011784 -- Start
        static let borderColor : UIColor = hexStringToUIColor(hex: "#2D2D2D")
        //ENGAGE0011784 -- End
    }
    
    struct FitnessApp
    {
        //Goals and challenges category cells border color.
        static let categoryBorderColor : UIColor = hexStringToUIColor(hex: "#E2E2E2")
        
        static let videoCategoryViewBG : UIColor = hexStringToUIColor(hex: "#C1C1C1")
        
        static let categoryDeviderColor : UIColor = hexStringToUIColor(hex: "#CFCFCF")
    }
    
    struct imageTint
    {
        static let fitnessCategorySelect : UIColor = .white
        static let fitnessCategoryUnselect : UIColor = MainColours.primary1
        
        static let fitnessVideoCategorySelect : UIColor = MainColours.primary2
        static let fintnessVideoCategoryUnSelect : UIColor = MainColours.primary1
    }
    
    struct tableViewColors
    {
        static let cellSelected : UIColor = .gray
        static let cellUnselected : UIColor = .clear
    }
    
    //Added by kiran V2.8 -- ENGAGE0011784 -- Border Color.
    //ENGAGE0011784 -- Start
    struct searchbarColors
    {
        static let curserColor = APPColor.MainColours.primary1
    }
    //ENGAGE0011784 -- End
    
    // Added by kiran V2.7 -- GATHER0000923 -- Pickleball change
    //GATHER0000923 -- Start
    ///Colors of textfields used as dropdown
    struct DropDownColors
    {
        //Added by kiran V2.8 -- ENGAGE0011784 -- moved this color to other colors so that it can be used in other areas as well and took reference from there.
        //ENGAGE0011784 -- Start
        static let borderColor : UIColor = OtherColors.borderColor//hexStringToUIColor(hex: "#2D2D2D")
        //ENGAGE0011784 -- End
        static let textColor : UIColor = APPColor.textColor.primary
    }
    //GATHER0000923 -- End
    
}

//Added by kiran V2.9 -- ENGAGE0012268 -- Color codes for dark mode
//ENGAGE0012268 -- Start
//NOTE:- Added these here as dark/Light Modes are UIViewcontroller properties and colors should be referenced from here. Refer (ENGAGE0012268) changes in teetime view controller to get an ide of how this was intented to use
struct APPColorDarkMode
{
    struct viewBackgroundColor
    {
        static let viewbg = hexStringToUIColor(hex: "F5F5F5")
        //Added by kiran V1.5 -- PROD0000202 -- First come first serve change
        //PROD0000202 -- Start
        static var preferenceTimeColor = hexStringToUIColor(hex: "77A1A4")
        //PROD0000202 -- End
    }
    
    struct tintColor
    {
        static let tint = hexStringToUIColor(hex: "c8a773")    //brown
        static let tintNew = hexStringToUIColor(hex: "F47D4C")    //brown
        static let tintNewLogin = hexStringToUIColor(hex: "695b5e")
        static let changePassword = hexStringToUIColor(hex: "40B2E6")    //brown
    }
    
    struct backGroundColor
    {
        static let tint = hexStringToUIColor(hex: "f06e44")//brown
    }
    
    struct placeHolderColor
    {
        static let tint = hexStringToUIColor(hex: "ffffff")    //white
    }
    
    struct solidbgColor
    {
        static let solidNewbg = hexStringToUIColor(hex: "f06c42")     //blue
        static let solidbg = hexStringToUIColor(hex: "67aac9")     //blue
    }
    
    struct viewBgColor
    {
        static let viewbg = hexStringToUIColor(hex: "ffffff") //white
    }
    
    struct viewNews
    {
        static let viewbg = hexStringToUIColor(hex: "F47D4C") //white
        static let backButtonColor = MainColours.primary2
    }
    
    struct selectedcellColor
    {
        static let selectedcell = hexStringToUIColor(hex: "faf6ef")
    }

    struct tabBtnColor
    {
        static let selected = hexStringToUIColor(hex: "ffffff")     //black header
        static let unselected = hexStringToUIColor(hex: "aaaaaa")     //black
    }
    
    struct celldividercolor
    {
        static let divider = hexStringToUIColor(hex: "E1E0E1")     //black
    }
    
    struct notificationstatuscolor
    {
        static let readstatus = hexStringToUIColor(hex: "F4F4F4")
    }

    struct statementcategories
    {
        static let category = hexStringToUIColor(hex: "ffffff").withAlphaComponent(0.4)     //black
    }
    
    struct todayatglancestatus
    {
        static let open = hexStringToUIColor(hex: "417505")    //green
        static let close = hexStringToUIColor(hex: "af192b")    //red
        static let red = hexStringToUIColor(hex: "FF0000")    //api red
        static let black = hexStringToUIColor(hex: "000000")    //api red
        static let green = hexStringToUIColor(hex: "008000")    //api red

    }
    
    struct dashboardwhite
    {
        static let bgwhite = hexStringToUIColor(hex: "ffffff").withAlphaComponent(0.9)     //black
    }
    
    struct maskViewBackgroundColor
    {
        static let maskViewBGColor = UIColor.white
    }
    
    struct navigationColor
    {
        static let titleTextAttributesColor = UIColor.white
        static let barTintColor = MainColours.primary1
        static let barbackgroundcolor = hexStringToUIColor(hex: "695B5E")
        static let backbarcolor = hexStringToUIColor(hex: "c9a873")
        static let navigationitemcolor = hexStringToUIColor(hex: "ffffff")
        static let filterBGColor = hexStringToUIColor(hex: "67aac9")
        static let solidNewbg = hexStringToUIColor(hex: "f06c42")     //blue
        static let tintBGColor = hexStringToUIColor(hex: "ffffff")
    }
    
    struct loginBackgroundButtonColor
    {
        static let loginBtnBGColor = MainColours.primary2
        static let loginusernameColor = hexStringToUIColor(hex: "bd9f68")
        static let loginpasswordColor = hexStringToUIColor(hex: "bd9f68")
        static let loginfgColor = hexStringToUIColor(hex: "bd9f68")
        static let loginBtnTextColor = hexStringToUIColor(hex: "bd9f68")
    }
    
    struct  profileColor
    {
        static let profileheadercolor = hexStringToUIColor(hex: "322f2f")
        static let profilebgcolor = hexStringToUIColor(hex: "e4e2de")
        static let profiletypetitlecolor = hexStringToUIColor(hex: "4a4a4a")
        static let profiletypenamecolor = hexStringToUIColor(hex: "000000")
        static let profileaddonnamecolor = hexStringToUIColor(hex: "4a4a4a")
        static let dividercolor = hexStringToUIColor(hex: "9b9b9b")
    }
    
    struct SegmentController
    {
        static let selectedSegmentBGColor = hexStringToUIColor(hex: "081F2A")
        static let nonSelectedSegmentBGColor = hexStringToUIColor(hex: "073B53")
    }
    
    struct GuestCardstatus
    {
        static let pending = hexStringToUIColor(hex: "af192b")
        static let approved = hexStringToUIColor(hex: "417505")
    }
    
    //MOdified on 20th October 2020 V2.4
    struct textColor
    {
        static let text = hexStringToUIColor(hex: "000000")     //black header
        static let textBlack = hexStringToUIColor(hex: "9b9b9b")     //black
        static let textNewColor = hexStringToUIColor(hex: "695B5E")     //black
        
        //used in fitness app for now
        ///Text color of all primary text fields in app.
        static let primary : UIColor = hexStringToUIColor(hex: "#695B5E")
        
        ///Light primary for text headers header.
        static let primaryHeader : UIColor = UIColor.init(red: 105/255.0, green: 91/255.0, blue: 94/255.0, alpha: 0.85)
        
        //Grayes out version of primary color
        static let lightPrimary : UIColor = hexStringToUIColor(hex: "#8F8F8F")
        
        //Selection Colour currently used for fitness category in golas and challenges screen
        static let secondary : UIColor = MainColours.primary2
        
        //Used in fitness App.
        ///text color for active status of activity status
        static let activeStatusText : UIColor = hexStringToUIColor(hex: "#1EA554")
        
        static let conatinedTextColor : UIColor = .white
        
        static let whiteText : UIColor = .white
        
        static let fitnessGroupActivity : UIColor = hexStringToUIColor(hex: "#676767")
        
        ///Color of the text lbl ex. Home Phone, cell phone,birthday, etc..
        static let profileScreenTextLbl : UIColor = hexStringToUIColor(hex: "484848")
        
        ///Pickle ball header label color
        static let pickleBallHeaderColor : UIColor = hexStringToUIColor(hex: "#695B5E")
        
    }
    
    ///The colours used in the app
    struct MainColours
    {
        //Brown
        static let primary1 : UIColor = hexStringToUIColor(hex: " #2A4E7D")
        //orange
        static let primary2 : UIColor = hexStringToUIColor(hex: "#00C6FF")
        
        static let primary3 : UIColor = hexStringToUIColor(hex: "#1D1DFF")
    
        //used in fitness App
        ///Indicates the active state
        static let active : UIColor = .green
    }
    
    struct NavigationControllerColors
    {
        static let barTintColor : UIColor = MainColours.primary1
        //Only used in FItness App videos Screen
        static let barWhite : UIColor = .white
        
        //Member iD bar tint color
        static let memberIDBarTintColor : UIColor = hexStringToUIColor(hex: "f06c42")
        
        static let memberIDBackBtnColor : UIColor = .white
    }
    
    struct ButtonColors
    {
        static let primary : UIColor = MainColours.primary1
        static let primaryBorder : UIColor = MainColours.primary1
        static let secondary : UIColor = MainColours.primary2
        static let secondaryBorder : UIColor = MainColours.primary2
        
        static let alert : UIColor = hexStringToUIColor(hex: "#00AFFF")
        static let alertBorder : UIColor = .white
        
        ///Text color when the background of the button is non white.
        static let containedTextColor : UIColor = .white
        
    }
    
    struct Switch
    {
        static let onColor : UIColor = hexStringToUIColor(hex: "#40B2E6")
    }
    
    struct OtherColors
    {
        static let activeDot : UIColor = hexStringToUIColor(hex: "#1BCB61")
        
        static let shadowColor : UIColor = hexStringToUIColor(hex: "#00000029")
        
        static let groupBorderColor : UIColor = hexStringToUIColor(hex: "#707070")
        
        static let appWhite : UIColor = hexStringToUIColor(hex: "#F5F5F5")
        
        static let lineColor : UIColor = hexStringToUIColor(hex: "#CCCBCB")
        
        static let deviderColor : UIColor = hexStringToUIColor(hex: "#CCCBCB")
        
        static let borderColor : UIColor = hexStringToUIColor(hex: "#2D2D2D")
        
    }
    
    struct FitnessApp
    {
        //Goals and challenges category cells border color.
        static let categoryBorderColor : UIColor = hexStringToUIColor(hex: "#E2E2E2")
        
        static let videoCategoryViewBG : UIColor = hexStringToUIColor(hex: "#C1C1C1")
        
        static let categoryDeviderColor : UIColor = hexStringToUIColor(hex: "#CFCFCF")
    }
    
    struct imageTint
    {
        static let fitnessCategorySelect : UIColor = .white
        static let fitnessCategoryUnselect : UIColor = MainColours.primary1
        static let fitnessVideoCategorySelect : UIColor = MainColours.primary2
        static let fintnessVideoCategoryUnSelect : UIColor = MainColours.primary1
    }
    
    struct tableViewColors
    {
        static let cellSelected : UIColor = .gray
        static let cellUnselected : UIColor = .clear
    }
    
    struct searchbarColors
    {
        static let curserColor = APPColor.MainColours.primary1
    }
    
    ///Colors of textfields used as dropdown
    struct DropDownColors
    {
        
        static let borderColor : UIColor = OtherColors.borderColor
        
        static let textColor : UIColor = APPColor.textColor.primary
    }
    
}
//ENGAGE0012268 -- End


// Conver Hexadecimal color to RGB
func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
        
    )
}


