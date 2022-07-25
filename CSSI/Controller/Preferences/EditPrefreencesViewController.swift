
//
//  EditPrefreencesViewController.swift
//  CSSI
//
//  Created by Samadhan on 22/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
//import MaterialCard
import TweeTextField

class EditPrefreencesViewController: UIViewController {
//    @IBOutlet weak var txtMeddleName: TweeAttributedTextField!
    
//    @IBOutlet weak var btnFemaleCheckbox: UIButton!
//    @IBOutlet weak var txtSecondaryEmail: TweeAttributedTextField!
//    @IBOutlet weak var btnMaleCheckbox: UIButton!
//    @IBOutlet weak var txtmEmail: TweeAttributedTextField!
//    @IBOutlet weak var txtMobileNumber: TweeAttributedTextField!
//    @IBOutlet weak var txtNumberPrimary: TweeAttributedTextField!
//    @IBOutlet weak var txtDisplayName: TweeAttributedTextField!
//    @IBOutlet weak var txtLastName: TweeAttributedTextField!
//    @IBOutlet weak var txtFirstName: TweeAttributedTextField!
//
    var btnFemaleCheckbox: UIButton!
    var txtSecondaryEmail: TweeAttributedTextField!
    var btnMaleCheckbox: UIButton!
    var txtEmail: TweeAttributedTextField!
    var txtMobileNumber: TweeAttributedTextField!
    var txtNumberPrimary: TweeAttributedTextField!
    var txtDisplayName: TweeAttributedTextField!
    var txtLastName: TweeAttributedTextField!
    var txtFirstName: TweeAttributedTextField!
    var txtMiddleName: TweeAttributedTextField!
    var btnAddAnotherAddress: UIButton!
    var btnPlus: UIButton!
    let Icon_Radio_Unselected = UIImage(named: "Icon_Radio_Unselected")
    let Icon_Radio_Selected = UIImage(named: "Icon_Radio_Selected")
    let Icon_Down = UIImage(named: "Icon_Down")

    var dictMemberInfo = GetMemberInfo()

    var arraddress = [Address]()

    
    let textfiledHeight:CGFloat = 34;
    
//    @IBOutlet weak var uiScrollView: UIScrollView!
//    @IBOutlet weak var uiMainView: UIView!
//    @IBOutlet weak var uiViewEmail: UIView!
    var uiViewPrimaryAddress: UIView!
    
    var uiScrollView: UIScrollView!
    var uiMainView: UIView!
    //11th September 2020 v2.3 Removed material card POD as xcode no loner supports swift 3 and the liberary was not updated
    var uiViewEmail: UIView!//MaterialCard!
    var uiViewContactDetails: UIView!//MaterialCard!
    
    var uiViewPrsonalDetails: UIView!
    //11th September 2020 v2.3 Removed material card POD as xcode no loner supports swift 3 and the liberary was not updated
    var uiViewAddress: UIView!//MaterialCard!
    var uiViewMemberDetails: UIView!//MaterialCard!
    var uiViewPasswordDetails: UIView!//MaterialCard!
    

    var txtStreet: TweeAttributedTextField!
    var txtStreetSecond: TweeAttributedTextField!
    var txtCity: TweeAttributedTextField!
    var txtState: TweeAttributedTextField!
    var txtZip: TweeAttributedTextField!
    var txtCountry: TweeAttributedTextField!
    var btnDoNotShowOnlineChecBox: UIButton!
    var btnDoNotShowOnline: UIButton!
    var btnSubmit: UIButton!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    var actionSheetdatePicker: ActionSheetDatePicker!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.isHidden = false
        //navigation item labelcolor
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "Edit Preferences"
        self.navigationController?.navigationBar.backItem?.title =  CommonString.kNavigationBack
        

        // Do any additional setup after loading the view.
        self.loadCoponents()
        
        
        
//        self.txtFirstName.lineColor = .lightGray
//        self.txtFirstName.lineWidth = 1
//        self.txtFirstName.tweePlaceholder = "First Name"
//        self.txtFirstName.font = SFont.SourceSansPro_Regular16
//
//
//        self.txtMeddleName.lineColor = .lightGray
//        self.txtMeddleName.lineWidth = 1
//        self.txtMeddleName.tweePlaceholder = "Middle Name"
//        self.txtMeddleName.font = SFont.SourceSansPro_Regular16
//
//        self.txtLastName.lineColor = .lightGray
//        self.txtLastName.lineWidth = 1
//        self.txtLastName.tweePlaceholder = "Last Name"
//        self.txtLastName.font = SFont.SourceSansPro_Regular16
//
//
//        self.txtDisplayName.lineColor = .lightGray
//        self.txtDisplayName.lineWidth = 1
//        self.txtDisplayName.tweePlaceholder = "Display Name"
//        self.txtDisplayName.font = SFont.SourceSansPro_Regular16
//
//
//
//
//
//        self.txtNumberPrimary.lineColor = .lightGray
//        self.txtNumberPrimary.lineWidth = 1
//        self.txtNumberPrimary.tweePlaceholder = "primary Mobile"
//        self.txtNumberPrimary.font = SFont.SourceSansPro_Regular16
//
//
//
//        self.txtMobileNumber.lineColor = .lightGray
//        self.txtMobileNumber.lineWidth = 1
//        self.txtMobileNumber.tweePlaceholder = "Mobile"
//        self.txtMobileNumber.font = SFont.SourceSansPro_Regular16
//
//
//
//        self.txtmEmail.lineColor = .lightGray
//        self.txtmEmail.lineWidth = 1
//        self.txtmEmail.tweePlaceholder = "Email"
//        self.txtmEmail.font = SFont.SourceSansPro_Regular16
//
//        self.txtSecondaryEmail.lineColor = .lightGray
//        self.txtSecondaryEmail.lineWidth = 1
//        self.txtSecondaryEmail.tweePlaceholder = "Secondary Email"
//        self.txtSecondaryEmail.font = SFont.SourceSansPro_Regular16
//
//
//        self.txtStreet.lineColor = .lightGray
//        self.txtStreet.lineWidth = 1
//        self.txtSecondaryEmail.tweePlaceholder = "Secondary Email"
//        self.txtSecondaryEmail.font = SFont.SourceSansPro_Regular16
//
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func openToDatePicker(){
        
        let currentDate = Date()
        self.actionSheetdatePicker = ActionSheetDatePicker.show(withTitle: "Date", datePickerMode: .date, selectedDate: currentDate, doneBlock: { (selctedDate, atIndexDate,value) in
            
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date
            var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "UTC" }
            //print(localTimeZoneAbbreviation)
            formatter.locale = Locale.init(identifier: localTimeZoneAbbreviation)
            // convert your string to date
            formatter.dateFormat = "MMM - dd"
            let myString = formatter.string(from: atIndexDate as! Date) // string purpose I add here
           // print(myString)
            
            
            
        }, cancel: { (cancelPressed) in
            
        }, origin: self.view)
        
        
    }
    
        
//        self.actionSheetdatePicker = ActionSheetDatePicker()
//        var localTimeZoneName: String { return TimeZone.current.identifier }
//
//        let currentDate = Date()
//
//
//        self.actionSheetdatePicker.timeZone = TimeZone.current
//        self.actionSheetdatePicker.locale = Locale.init(identifier: "uk") //NSLocale.init(localeIdentifier: "it_IT") as Locale!
//        self.actionSheetdatePicker.calendar = Calendar.current
//        self.actionSheetdatePicker = ActionSheetDatePicker.show(withTitle: "", datePickerMode: .date, selectedDate: currentDate, minimumDate: nil, maximumDate: Date(), doneBlock: { (selectedDate, any, anydate ) in
//
//            print(anydate)
//
//        }, cancel: { (cancelPressed) in
//
//
//
//        }, origin: self.view)
//
//        let loc = Locale.init(identifier: "uk")
//        var calendar = Calendar.current
//        calendar.locale = loc
//        self.actionSheetdatePicker.calendar = calendar
//    }
//
    
    
   
    //MARK:- Load components
    func loadCoponents()  {
        let outerViewXaxis = self.view.frame.origin.x
        var outerViewYaxis = self.view.frame.origin.y //+ //self.uiViewEmail.frame.size.height + 8
        var outerViewHeight = 250
        
        
        
        self.uiScrollView = UIScrollView.init()
        self.uiScrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.addSubview(self.uiScrollView)
        
        
        self.uiMainView = UIView.init()
        self.uiMainView.frame = self.uiScrollView.bounds
        self.uiScrollView.addSubview(self.uiMainView)
        let outerViewWidth = self.uiMainView.frame.size.width //- (self.uiViewEmail.frame.origin.x + self.uiViewEmail.frame.origin.x)

        
        let spaceBetweenTextfiled:CGFloat = 20.0
        var outerViewYaxisUpdated = self.view.frame.origin.y

        var yAxix:CGFloat = spaceBetweenTextfiled //lblAddressHeader.frame.size.height + lblAddressHeader.frame.origin.y + 0

        let iconViewWidth:CGFloat = 50.0
        
        //11th September 2020 v2.3 Removed material card POD as xcode no loner supports swift 3 and the liberary was not updated
        self.uiViewPrsonalDetails =  UIView.init()//MaterialCard.init()
        self.uiViewPrsonalDetails.frame = CGRect(x: CGFloat(outerViewXaxis), y: outerViewYaxisUpdated, width: outerViewWidth, height: CGFloat(outerViewHeight))
        self.uiViewPrsonalDetails.backgroundColor = UIColor.white
        self.uiMainView.addSubview(self.uiViewPrsonalDetails)
        
        
        
        let iconWidth:CGFloat = 15
        let iconHeight:CGFloat = 15
        
        
        
        let imgPersonalDetails = UIImageView.init(frame:CGRect(x: (iconViewWidth - iconWidth) / 2 , y:( (self.textfiledHeight - iconHeight) / 2) + spaceBetweenTextfiled , width: iconWidth, height: iconHeight))
        let Icon_Anniversary =  UIImage(named: "Icon_Username")
        imgPersonalDetails.contentMode = .scaleAspectFit
        imgPersonalDetails.image = Icon_Anniversary
        self.uiViewPrsonalDetails.addSubview(imgPersonalDetails)
        
        
        
        let tralingSpace = (iconViewWidth + self.uiViewPrsonalDetails.frame.origin.x + 24)
       // print(tralingSpace)
       // print(dictMemberInfo.firstName)
        
        self.txtFirstName = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth -  tralingSpace , height: self.textfiledHeight))
        self.txtFirstName.lineColor = .lightGray
        self.txtFirstName.lineWidth = 1
        self.txtFirstName.tweePlaceholder = "First Name"

        self.txtFirstName.text = dictMemberInfo.firstName
        self.txtFirstName.font = SFont.SourceSansPro_Regular16
        self.txtFirstName.placeholderColor = UIColor.lightGray
        self.uiViewPrsonalDetails.addSubview(self.txtFirstName)
        
        yAxix = self.txtFirstName.frame.size.height + self.txtFirstName.frame.origin.y + spaceBetweenTextfiled
        
        self.txtMiddleName = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtMiddleName.lineColor = .lightGray
        self.txtMiddleName.lineWidth = 1
        self.txtMiddleName.tweePlaceholder = "Middle Name"
       //self.txtMiddleName.text = dictMemberInfo.middleName
        self.txtMiddleName.font = SFont.SourceSansPro_Regular16
        self.txtFirstName.placeholderColor = UIColor.lightGray

        self.uiViewPrsonalDetails.addSubview(self.txtMiddleName)
        
        yAxix = self.txtMiddleName.frame.size.height + self.txtMiddleName.frame.origin.y + spaceBetweenTextfiled
        
        self.txtLastName = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtLastName.lineColor = .lightGray
        self.txtLastName.lineWidth = 1
        self.txtLastName.tweePlaceholder = "Last Name"
        self.txtLastName.text = dictMemberInfo.lastName
        self.txtLastName.font = SFont.SourceSansPro_Regular16
        self.txtFirstName.placeholderColor = UIColor.lightGray

        self.uiViewPrsonalDetails.addSubview(self.txtLastName)
        
        yAxix = self.txtLastName.frame.size.height + self.txtLastName.frame.origin.y + spaceBetweenTextfiled
        
        self.txtDisplayName = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtDisplayName.lineColor = .lightGray
        self.txtDisplayName.lineWidth = 1
        self.txtDisplayName.tweePlaceholder = "Display Name"
        self.txtDisplayName.text = dictMemberInfo.displayName
        self.txtDisplayName.font = SFont.SourceSansPro_Regular16
        self.uiViewPrsonalDetails.addSubview(self.txtDisplayName)
        
        
        yAxix = self.txtDisplayName.frame.size.height + self.txtDisplayName.frame.origin.y + spaceBetweenTextfiled

        
       // print(dictMemberInfo.gender)
        let lblGenderHeader = UILabel.init()
        lblGenderHeader.frame = CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - (iconViewWidth + 10), height: 21)
        lblGenderHeader.text = "Gender"
        lblGenderHeader.font = SFont.SourceSansPro_Regular13
        lblGenderHeader.backgroundColor = UIColor.clear
        self.uiViewPrsonalDetails.addSubview(lblGenderHeader)
        
        yAxix = lblGenderHeader.frame.size.height + lblGenderHeader.frame.origin.y + 4
        
     
      
        
        
        self.btnMaleCheckbox = UIButton.init()
        self.btnMaleCheckbox.frame = CGRect(x: iconViewWidth, y: yAxix, width: 25, height: 25)
     
        self.btnMaleCheckbox.setImage(self.Icon_Radio_Selected, for: .normal)
        self.uiViewPrsonalDetails.addSubview(self.btnMaleCheckbox)
        
        
        
        
        
        
        let btnMale = UIButton.init()
        btnMale.frame = CGRect(x: iconViewWidth + (self.btnMaleCheckbox.frame.size.width + 8), y: yAxix, width: 70, height: 25)
        btnMale.setTitle("Male", for: .normal)
        btnMale.titleLabel?.font = SFont.SourceSansPro_Regular16
        btnMale.setTitleColor(hexStringToUIColor(hex: "000000"), for: UIControlState.normal)
        btnMale.contentHorizontalAlignment = .left
        self.uiViewPrsonalDetails.addSubview(btnMale)
        
        
        
        self.btnFemaleCheckbox = UIButton.init()
        self.btnFemaleCheckbox.frame = CGRect(x: btnMale.frame.origin.x + btnMale.frame.size.width + 20, y: yAxix, width: 25, height: 25)
        self.btnFemaleCheckbox.setImage(self.Icon_Radio_Unselected, for: .normal)
        self.uiViewPrsonalDetails.addSubview(self.btnFemaleCheckbox)
        
        
        if(dictMemberInfo.gender! == "Female")
        {
            self.btnFemaleCheckbox.setImage(self.Icon_Radio_Selected, for: .normal)
            self.btnMaleCheckbox.setImage(self.Icon_Radio_Unselected, for: .normal)


        }else{
            self.btnMaleCheckbox.setImage(self.Icon_Radio_Unselected, for: .normal)
            self.btnFemaleCheckbox.setImage(self.Icon_Radio_Selected, for: .normal)

        }
        
        
        let btnFemale = UIButton.init()
        btnFemale.frame = CGRect(x: self.btnFemaleCheckbox.frame.origin.x + self.btnFemaleCheckbox.frame.size.width + 8, y: yAxix, width: 100, height: 25)
        btnFemale.setTitle("Female", for: .normal)
        btnFemale.titleLabel?.font = SFont.SourceSansPro_Regular16
        btnFemale.setTitleColor(hexStringToUIColor(hex: "000000"), for: UIControlState.normal)

        btnFemale.contentHorizontalAlignment = .left
        self.uiViewPrsonalDetails.addSubview(btnFemale)
        
        
        
        yAxix = btnFemale.frame.size.height + btnFemale.frame.origin.y + spaceBetweenTextfiled
        
        
        let imgAniversarry = UIImageView.init(frame:CGRect(x: (iconViewWidth - iconWidth) / 2 , y: yAxix + spaceBetweenTextfiled , width: iconWidth, height: iconHeight))
        let icon_Anniversary =  UIImage(named: "Icon_Anniversary")
        imgAniversarry.image = icon_Anniversary
        imgAniversarry.contentMode = .scaleAspectFit

        self.uiViewPrsonalDetails.addSubview(imgAniversarry)
        
        
        let lblAnniversary = UILabel.init()
        lblAnniversary.frame = CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - (iconViewWidth + 10), height: 21)
        lblAnniversary.text = "Anniversary"
        lblAnniversary.font = SFont.SourceSansPro_Regular13

        lblAnniversary.backgroundColor = UIColor.clear
        self.uiViewPrsonalDetails.addSubview(lblAnniversary)
        
        yAxix = lblAnniversary.frame.size.height + lblAnniversary.frame.origin.y + 4
        
      //  let result = (dictMemberInfo.anniversaryDate)?.split(separator: " ")
       

      //  var straniversarymnt: String = result![0]
      //  var straniversarydate: String  = result![1]

        
       
        
        let btnMonth = UIButton.init()
        btnMonth.frame = CGRect(x: iconViewWidth, y: yAxix, width:(outerViewWidth - (iconViewWidth + 60))/2 , height: 34)
        btnMonth.addBottomBorderWithColor(color: .lightGray, width: 1)
        btnMonth.setTitle(dictMemberInfo.anniversaryDate, for: .normal)
        btnMonth.titleLabel?.font = SFont.SourceSansPro_Regular16

        btnMonth.setTitleColor(.black, for: .normal)
        
        let buttonArrowMonth = UIButton.init()
        buttonArrowMonth.frame = CGRect(x: btnMonth.frame.size.width - 30, y: (btnMonth.frame.size.height - 30)/2, width: 30, height: 30)
        buttonArrowMonth.setImage(Icon_Down, for: .normal)
        
        btnMonth .addSubview(buttonArrowMonth)
        
        buttonArrowMonth.addTarget(self, action: #selector(openToDatePicker), for: .touchUpInside)
        btnMonth.addTarget(self, action: #selector(openToDatePicker), for: .touchUpInside)

        
        
        
        self.uiViewPrsonalDetails.addSubview(btnMonth)

//        let btnDay = UIButton.init()
//        btnDay.frame = CGRect(x: btnMonth.frame.origin.x + btnMonth.frame.size.width + 20, y: yAxix, width:(outerViewWidth - (iconViewWidth + 60))/2 , height: 34)
//        btnDay.addBottomBorderWithColor(color: .lightGray, width: 1)
//     //   btnDay.setTitle(straniversarydate, for: .normal)
//        btnDay.titleLabel?.font = SFont.SourceSansPro_Regular16
//
//        btnDay.setTitleColor(.black, for: .normal)
//        let buttonArrowDay = UIButton.init()
//        buttonArrowDay.frame = CGRect(x: btnDay.frame.size.width - 30, y: (btnDay.frame.size.height - 30)/2, width: 30, height: 30)
//        buttonArrowDay.setImage(Icon_Down, for: .normal)
//        btnDay .addSubview(buttonArrowDay)
//
//        self.uiViewPrsonalDetails.addSubview(btnDay)
//
        
      //  btnDay.contentHorizontalAlignment = .left
        btnMonth.contentHorizontalAlignment = .left
        
        
        
        yAxix = btnMonth.frame.size.height + btnMonth.frame.origin.y + spaceBetweenTextfiled
        self.uiViewPrsonalDetails.frame = CGRect(x: CGFloat(outerViewXaxis), y: outerViewYaxisUpdated, width: outerViewWidth, height: yAxix)
        
        
        
        
        // --------------------------
        
        outerViewYaxisUpdated = self.uiViewPrsonalDetails.frame.size.height + self.uiViewPrsonalDetails.frame.origin.y + 8
        //11th September 2020 v2.3 Removed material card POD as xcode no loner supports swift 3 and the liberary was not updated
        self.uiViewContactDetails =  UIView.init()//MaterialCard.init()
        self.uiViewContactDetails.frame = CGRect(x: CGFloat(outerViewXaxis), y: outerViewYaxisUpdated, width: outerViewWidth, height: CGFloat(outerViewHeight))
        self.uiViewContactDetails.backgroundColor = .white
        self.uiMainView.addSubview(self.uiViewContactDetails)
        
        
        yAxix = spaceBetweenTextfiled
        
        let imgiconno = UIImageView.init(frame:CGRect(x: (iconViewWidth - iconWidth) / 2 , y: yAxix , width: iconWidth, height: iconHeight))
        let icon_no =  UIImage(named: "Icon_Anniversary")
        imgiconno.image = icon_no
        self.uiViewContactDetails.addSubview(imgiconno)
        
        
        self.txtNumberPrimary = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtNumberPrimary.lineColor = .lightGray
        self.txtNumberPrimary.lineWidth = 1
        //Added by kiran V1.3 -- changed boca west to Cobalt Engage
        self.txtNumberPrimary.tweePlaceholder = "Cobalt Engage"
        self.txtNumberPrimary.text = dictMemberInfo.primaryPhone

        self.txtNumberPrimary.font = SFont.SourceSansPro_Regular16
        self.uiViewContactDetails.addSubview(self.txtNumberPrimary)
        
        yAxix = self.txtNumberPrimary.frame.size.height + self.txtNumberPrimary.frame.origin.y + spaceBetweenTextfiled
        
        self.txtMobileNumber = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtMobileNumber.lineColor = .lightGray
        self.txtMobileNumber.lineWidth = 1
        self.txtMobileNumber.tweePlaceholder = "Mobile"
        self.txtMobileNumber.text = dictMemberInfo.secondaryPhone

        self.txtMobileNumber.font = SFont.SourceSansPro_Regular16
        self.uiViewContactDetails.addSubview(self.txtMobileNumber)
        
        yAxix = self.txtMobileNumber.frame.size.height + txtMobileNumber.frame.origin.y + spaceBetweenTextfiled
        self.uiViewContactDetails.frame = CGRect(x: CGFloat(outerViewXaxis), y: outerViewYaxisUpdated, width: outerViewWidth, height: yAxix)
        
        
        
        outerViewYaxisUpdated = self.uiViewContactDetails.frame.size.height + self.uiViewContactDetails.frame.origin.y + 8

        //11th September 2020 v2.3 Removed material card POD as xcode no loner supports swift 3 and the liberary was not updated
        self.uiViewEmail = UIView.init() //MaterialCard.init()
        self.uiViewEmail.frame = CGRect(x: CGFloat(outerViewXaxis), y: outerViewYaxisUpdated, width: outerViewWidth, height: CGFloat(outerViewHeight))
        self.uiViewEmail.backgroundColor = .white
        self.uiMainView.addSubview(self.uiViewEmail)
        yAxix = spaceBetweenTextfiled

        
        let imgEmailIcon = UIImageView.init(frame:CGRect(x: (iconViewWidth - iconWidth) / 2 , y: yAxix , width: iconWidth, height: iconHeight))
        let icon_Mail =  UIImage(named: "img_email")
        imgEmailIcon.image = icon_Mail
        imgEmailIcon.contentMode = .scaleAspectFit

        self.uiViewEmail.addSubview(imgEmailIcon)
        
        self.txtEmail = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtEmail.lineColor = .lightGray
        self.txtEmail.lineWidth = 1
        self.txtEmail.tweePlaceholder = "Primary Email"
        self.txtEmail.text = dictMemberInfo.primaryEmail

        self.txtEmail.font = SFont.SourceSansPro_Regular16
        self.uiViewEmail.addSubview(self.txtEmail)
        
        yAxix = self.txtEmail.frame.size.height + self.txtEmail.frame.origin.y + spaceBetweenTextfiled
        
        self.txtSecondaryEmail = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtSecondaryEmail.lineColor = .lightGray
        self.txtSecondaryEmail.lineWidth = 1
        self.txtSecondaryEmail.tweePlaceholder = "Secondary Email"
        self.txtSecondaryEmail.text = dictMemberInfo.secondaryEmail
        
        self.txtSecondaryEmail.font = SFont.SourceSansPro_Regular16
        self.uiViewEmail.addSubview(self.txtSecondaryEmail)

        yAxix = self.txtSecondaryEmail.frame.size.height + txtSecondaryEmail.frame.origin.y + spaceBetweenTextfiled
        self.uiViewEmail.frame = CGRect(x: CGFloat(outerViewXaxis), y: outerViewYaxisUpdated, width: outerViewWidth, height: yAxix)
        
        
        
        
        
        outerViewYaxisUpdated = self.uiViewEmail.frame.size.height + self.uiViewEmail.frame.origin.y + 8
        
        
       // print(dictMemberInfo.address![0])
    
        //11th September 2020 v2.3 Removed material card POD as xcode no loner supports swift 3 and the liberary was not updated
        self.uiViewAddress =  UIView.init()//MaterialCard.init()
        self.uiViewAddress.frame = CGRect(x: CGFloat(outerViewXaxis), y: outerViewYaxisUpdated, width: outerViewWidth, height: CGFloat(outerViewHeight))
        self.uiViewAddress.backgroundColor = .white
        self.uiMainView.addSubview(self.uiViewAddress)
        
        
        self.uiViewPrimaryAddress = UIView.init()
        self.uiViewPrimaryAddress.frame = CGRect(x: CGFloat(0), y: 0, width: outerViewWidth, height: 150)
        self.uiViewPrimaryAddress.backgroundColor = .clear
        self.uiViewAddress.addSubview(self.uiViewPrimaryAddress)
        
       // print(dictMemberInfo.address)
            self.arraddress = dictMemberInfo.address ?? []
        
        
        for name in self.arraddress
        {
          if(name.adddresstype == "Boca")
          {
        
        yAxix = spaceBetweenTextfiled
        let imgAddressIcon = UIImageView.init(frame:CGRect(x: (iconViewWidth - iconWidth) / 2 , y: yAxix , width: iconWidth, height: iconHeight))
        let icon_Address =  UIImage(named: "img_address")
        imgAddressIcon.contentMode = .scaleAspectFit

        imgAddressIcon.image = icon_Address
        self.uiViewPrimaryAddress.addSubview(imgAddressIcon)
        
        
            
        let lblAddressHeader = UILabel.init()
        lblAddressHeader.frame = CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - (iconViewWidth + 10), height: 21)
            lblAddressHeader.text = "Address" + "(" + name.adddresstype! + ")"
        lblAddressHeader.font = SFont.SourceSansPro_Regular13
        lblAddressHeader.backgroundColor = UIColor.clear
        self.uiViewPrimaryAddress.addSubview(lblAddressHeader)
        

        yAxix = lblAddressHeader.frame.size.height + lblAddressHeader.frame.origin.y + 4

        let lblAddress = UILabel.init()
        lblAddress.frame = CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - (iconViewWidth + 10), height: 0)

            lblAddress.text =  "\(name.street1!)" + "," + "\(name.street2!)" + "," + "\(name.city!)" + "," + "\(name.state!)" + "," + "\(name.zip!)" + "," + "\(name.country!)"
        lblAddress.lineBreakMode = .byWordWrapping
        lblAddress.numberOfLines = 0
        lblAddress .sizeToFit()
        lblAddress.backgroundColor = UIColor.clear
        lblAddress.font = SFont.SourceSansPro_Regular16
        self.uiViewPrimaryAddress.addSubview(lblAddress)
        
    
        
        yAxix = lblAddress.frame.size.height + lblAddress.frame.origin.y + 8
            }
        }
        
        let btnCheckMark = UIButton.init()
        btnCheckMark.frame = CGRect(x: iconViewWidth, y: yAxix, width: 25, height: 25)
        btnCheckMark.backgroundColor = UIColor.blue
        uiViewPrimaryAddress.addSubview(btnCheckMark)
        
        let btnMalingAddress = UIButton.init()
        btnMalingAddress.frame = CGRect(x: iconViewWidth + (btnCheckMark.frame.size.width + 10), y: yAxix, width: outerViewWidth - ( iconViewWidth + (btnCheckMark.frame.size.width + 10)), height: 25)
        btnMalingAddress.setTitle("Mailing Address", for: .normal)
        btnMalingAddress.contentHorizontalAlignment = .left
        btnMalingAddress .setTitleColor(hexStringToUIColor(hex: "c9a873"), for: .normal)
        btnMalingAddress.titleLabel?.font = SFont.SourceSansPro_Regular16

        uiViewPrimaryAddress.addSubview(btnMalingAddress)
        
        
        
        yAxix = btnMalingAddress.frame.size.height + btnMalingAddress.frame.origin.y + 20
        
//        uiViewPrimaryAddress.frame = CGRect(x: CGFloat(0), y: 0, width: outerViewWidth, height: yAxix)
        

        let lblAddressHeaderOther = UILabel.init()
        lblAddressHeaderOther.frame = CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - (iconViewWidth + 10), height: 21)
        lblAddressHeaderOther.text = "Address other"
        lblAddressHeaderOther.font = SFont.SourceSansPro_Regular13
        lblAddressHeaderOther.backgroundColor = UIColor.clear
        uiViewPrimaryAddress.addSubview(lblAddressHeaderOther)
        
        yAxix = lblAddressHeaderOther.frame.size.height + lblAddressHeaderOther.frame.origin.y + 8
        
        
        let btnCheckMarkOther = UIButton.init()
        btnCheckMarkOther.frame = CGRect(x: iconViewWidth, y: yAxix, width: 25, height: 25)
        btnCheckMarkOther.backgroundColor = UIColor.blue
        uiViewPrimaryAddress.addSubview(btnCheckMarkOther)
        
        
        let btnMalingAddressOther = UIButton.init()
        btnMalingAddressOther.frame = CGRect(x: iconViewWidth + (btnCheckMark.frame.size.width + 10), y: yAxix, width: outerViewWidth - ( iconViewWidth + (btnCheckMark.frame.size.width + 10)), height: 25)
        btnMalingAddressOther.setTitle("Mailing Address", for: .normal)
        btnMalingAddressOther.contentHorizontalAlignment = .left
        btnMalingAddressOther.titleLabel?.font = SFont.SourceSansPro_Regular16
        btnMalingAddressOther .setTitleColor(hexStringToUIColor(hex: "c9a873"), for: .normal)

        uiViewPrimaryAddress.addSubview(btnMalingAddressOther)
       
        
        
        
        yAxix = btnMalingAddressOther.frame.size.height + btnMalingAddressOther.frame.origin.y + spaceBetweenTextfiled

        self.txtStreet = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtStreet.lineColor = .lightGray
        self.txtStreet.lineWidth = 1
        self.txtStreet.tweePlaceholder = "Street"
        self.txtStreet.font = SFont.SourceSansPro_Regular16
        uiViewPrimaryAddress.addSubview(self.txtStreet)
        
      
        yAxix = self.txtStreet.frame.size.height + self.txtStreet.frame.origin.y + spaceBetweenTextfiled
        
        self.txtStreetSecond = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtStreetSecond.lineColor = .lightGray
        self.txtStreetSecond.lineWidth = 1
        self.txtStreetSecond.tweePlaceholder = "Street 2"
        self.txtStreetSecond.font = SFont.SourceSansPro_Regular16
        uiViewPrimaryAddress.addSubview(self.txtStreetSecond)
        

        
        yAxix = self.txtStreetSecond.frame.size.height + self.txtStreetSecond.frame.origin.y + spaceBetweenTextfiled
        
        self.txtCity = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtCity.lineColor = .lightGray
        self.txtCity.lineWidth = 1
        self.txtCity.tweePlaceholder = "City"
        self.txtCity.font = SFont.SourceSansPro_Regular16
        uiViewPrimaryAddress.addSubview(self.txtCity)
        
        
        yAxix = self.txtCity.frame.size.height + self.txtCity.frame.origin.y + spaceBetweenTextfiled
        
        self.txtState = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtState.lineColor = .lightGray
        self.txtState.lineWidth = 1
        self.txtState.tweePlaceholder = "State"
        self.txtState.font = SFont.SourceSansPro_Regular16
        uiViewPrimaryAddress.addSubview(self.txtState)
        
        yAxix = self.txtState.frame.size.height + self.txtState.frame.origin.y + spaceBetweenTextfiled
        
        
        self.txtZip = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtZip.lineColor = .lightGray
        self.txtZip.lineWidth = 1
        self.txtZip.tweePlaceholder = "Zip"
        self.txtZip.font = SFont.SourceSansPro_Regular16
        uiViewPrimaryAddress.addSubview(self.txtZip)
        
        yAxix = self.txtZip.frame.size.height + self.txtZip.frame.origin.y + spaceBetweenTextfiled
        
        
        self.txtCountry = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtCountry.lineColor = .lightGray
        self.txtCountry.lineWidth = 1
        self.txtCountry.tweePlaceholder = "Country"
        self.txtCountry.font = SFont.SourceSansPro_Regular16
        uiViewPrimaryAddress.addSubview(self.txtCountry)
        
        yAxix = self.txtCountry.frame.size.height + self.txtCountry.frame.origin.y + spaceBetweenTextfiled
        
        
        self.btnPlus = UIButton.init()
        self.btnPlus.frame = CGRect(x: iconViewWidth, y: yAxix, width: 25, height: 25)
        self.btnPlus.backgroundColor = UIColor.blue
        uiViewPrimaryAddress.addSubview(self.btnPlus)
        
        
        self.btnAddAnotherAddress = UIButton.init()
        self.btnAddAnotherAddress.frame = CGRect(x: iconViewWidth + (btnCheckMark.frame.size.width + 10), y: yAxix, width: outerViewWidth - ( iconViewWidth + (btnCheckMark.frame.size.width + 10)), height: 25)
        self.btnAddAnotherAddress.setTitle("Add Another Address", for: .normal)
        self.btnAddAnotherAddress .setTitleColor(UIColor.brown, for: .normal)
        self.btnAddAnotherAddress.titleLabel?.font = SFont.SourceSansPro_Regular16

        self.btnAddAnotherAddress.contentHorizontalAlignment = .left
        uiViewPrimaryAddress.addSubview(self.btnAddAnotherAddress)
        
        yAxix = self.btnAddAnotherAddress.frame.size.height + self.btnAddAnotherAddress.frame.origin.y + spaceBetweenTextfiled

        uiViewPrimaryAddress.frame = CGRect(x: CGFloat(0), y: 0, width: outerViewWidth, height: yAxix)
        self.uiViewAddress.frame = CGRect(x: CGFloat(outerViewXaxis), y: outerViewYaxisUpdated, width: outerViewWidth, height: uiViewPrimaryAddress.frame.size.height + 8)

        yAxix = self.uiViewAddress.frame.size.height + self.uiViewAddress.frame.origin.y + 8

//        outerViewYaxisUpdated = self.uiViewEmail.frame.size.height + self.uiViewEmail.frame.origin.y + 8

        //11th September 2020 v2.3 Removed material card POD as xcode no loner supports swift 3 and the liberary was not updated
        self.uiViewMemberDetails =  UIView.init()//MaterialCard.init()
        self.uiViewMemberDetails.frame = CGRect(x: CGFloat(outerViewXaxis), y: yAxix, width: outerViewWidth, height: 86)
        self.uiViewMemberDetails.backgroundColor = .white
        self.uiMainView.addSubview(self.uiViewMemberDetails)
        
        
        let imgMemberidIcon = UIImageView.init(frame:CGRect(x: (iconViewWidth - iconWidth) / 2 , y: yAxix + spaceBetweenTextfiled , width: iconWidth, height: iconHeight))
        let icon_MemberId =  UIImage(named: "img_address")
        imgMemberidIcon.image = icon_MemberId
        imgMemberidIcon.contentMode = .scaleAspectFit

        self.uiMainView.addSubview(imgMemberidIcon)
        
        
        
        let btnMemberId = UIButton.init()
        btnMemberId.frame = CGRect(x: iconViewWidth, y:0 , width: self.uiViewMemberDetails.frame.size.width - (iconViewWidth - 10), height: self.uiViewMemberDetails.frame.size.height / 2 )
        btnMemberId.setTitle("Member ID", for: .normal)
        btnMemberId .setTitleColor(UIColor.darkGray, for: .normal)
        btnMemberId.contentHorizontalAlignment = .left
        btnMemberId.titleLabel?.font = SFont.SourceSansPro_Regular13

        self.uiViewMemberDetails.addSubview(btnMemberId)
        
        
        let btnMemberName = UIButton.init()
        btnMemberName.frame = CGRect(x: iconViewWidth, y:self.uiViewMemberDetails.frame.size.height / 2 , width: self.uiViewMemberDetails.frame.size.width - (iconViewWidth - 10), height: self.uiViewMemberDetails.frame.size.height / 2 )
        btnMemberName.setTitle(dictMemberInfo.memberMasterID, for: .normal)
        btnMemberName .setTitleColor(UIColor.black, for: .normal)
        btnMemberName.contentHorizontalAlignment = .left
        btnMemberName.titleLabel?.font = SFont.SourceSansPro_Regular16

        self.uiViewMemberDetails.addSubview(btnMemberName)
        
        btnMemberId.contentEdgeInsets = .init(top: 20, left: 0, bottom: 0, right: 0)
        btnMemberName.contentEdgeInsets = .init(top: 0, left: 0, bottom: 20, right: 0)
        
        btnMemberName.contentHorizontalAlignment = .left
        btnMemberId.contentHorizontalAlignment = .left
        
        
        
        yAxix = self.uiViewMemberDetails.frame.size.height + self.uiViewMemberDetails.frame.origin.y + 8

        //11th September 2020 v2.3 Removed material card POD as xcode no loner supports swift 3 and the liberary was not updated
        self.uiViewPasswordDetails =  UIView.init()//MaterialCard.init()
        self.uiViewPasswordDetails.frame = CGRect(x: CGFloat(outerViewXaxis), y: yAxix, width: outerViewWidth, height: 80)
        self.uiViewPasswordDetails.backgroundColor = .white
        self.uiMainView.addSubview(self.uiViewPasswordDetails)
        
        let imgMPasswordIcon = UIImageView.init(frame:CGRect(x: (iconViewWidth - iconWidth) / 2 , y: yAxix , width: iconWidth, height: iconHeight))
        let icon_Password =  UIImage(named: "img_address")
        imgMPasswordIcon.image = icon_Password
        imgMPasswordIcon.contentMode = .scaleAspectFit

        self.uiMainView.addSubview(imgMPasswordIcon)
        
        
        let btnPassword = UIButton.init()
        btnPassword.frame = CGRect(x: iconViewWidth, y:0 , width: self.uiViewMemberDetails.frame.size.width - (iconViewWidth - 10), height: self.uiViewMemberDetails.frame.size.height / 2 )
        btnPassword.setTitle("Password", for: .normal)
        btnPassword .setTitleColor(UIColor.darkGray, for: .normal)
        btnPassword.contentHorizontalAlignment = .left
        btnPassword.titleLabel?.font = SFont.SourceSansPro_Regular13

        self.uiViewPasswordDetails.addSubview(btnPassword)
        
        
        let btnPasswordValue = UIButton.init()
        btnPasswordValue.frame = CGRect(x: iconViewWidth, y:self.uiViewMemberDetails.frame.size.height / 2 , width: self.uiViewMemberDetails.frame.size.width - (iconViewWidth - 10), height: self.uiViewMemberDetails.frame.size.height / 2 )
        btnPasswordValue.setTitle("*******", for: .normal)
        btnPasswordValue .setTitleColor(UIColor.black, for: .normal)
        btnPasswordValue.contentHorizontalAlignment = .left
        btnPasswordValue.titleLabel?.font = SFont.SourceSansPro_Regular16

        self.uiViewPasswordDetails.addSubview(btnPasswordValue)
        
        btnPassword.contentEdgeInsets = .init(top: 20, left: 0, bottom: 0, right: 0)
        btnPasswordValue.contentEdgeInsets = .init(top: 0, left: 0, bottom: 20, right: 0)
        
        btnPassword.contentHorizontalAlignment = .left
        btnPasswordValue.contentHorizontalAlignment = .left
        
        
    
        let btnResetPassword = UIButton.init()
        btnResetPassword.frame = CGRect(x: self.uiViewPasswordDetails.frame.size.width - 150, y: 0, width: 150, height: self.uiViewPasswordDetails.frame.size.height)
        btnResetPassword.setTitle("Reset Password", for: .normal)
        btnResetPassword .setTitleColor(UIColor.black, for: .normal)
        btnResetPassword.contentHorizontalAlignment = .center
        self.uiViewPasswordDetails.addSubview(btnResetPassword)
    
        
        yAxix = self.uiViewPasswordDetails.frame.size.height + self.uiViewPasswordDetails.frame.origin.y + 20

        
        self.btnDoNotShowOnlineChecBox = UIButton.init()
        self.btnDoNotShowOnlineChecBox.frame = CGRect(x: 16, y: yAxix, width: 20, height: 20)
        self.btnDoNotShowOnlineChecBox.backgroundColor = .blue
        
        self.uiMainView.addSubview(self.btnDoNotShowOnlineChecBox)
        
        
        
        
        self.btnDoNotShowOnline = UIButton.init()
        self.btnDoNotShowOnline.frame = CGRect(x: self.btnDoNotShowOnlineChecBox.frame.size.width + self.btnDoNotShowOnlineChecBox.frame.origin.x + 10, y: yAxix - 10, width: outerViewWidth - (self.btnDoNotShowOnlineChecBox.frame.size.width + self.btnDoNotShowOnlineChecBox.frame.origin.x + 0), height: 40)
        self.btnDoNotShowOnline.setTitle("Do not show me in the online Member Directory", for: .normal)
        self.btnDoNotShowOnline .setTitleColor(UIColor.black, for: .normal)
        self.btnDoNotShowOnline.titleLabel?.font = SFont.SourceSansPro_Regular14
        self.btnDoNotShowOnline.contentHorizontalAlignment = .left
        self.btnDoNotShowOnline.titleLabel?.lineBreakMode = .byWordWrapping
        self.btnDoNotShowOnline.titleLabel?.numberOfLines = 2
        self.uiMainView.addSubview(self.btnDoNotShowOnline)
        
        
        yAxix = self.btnDoNotShowOnline.frame.size.height + self.btnDoNotShowOnline.frame.origin.y + 40
        
        
        self.btnSubmit = UIButton.init()
        self.btnSubmit.frame = CGRect(x: (self.uiMainView.frame.size.width - 255) / 2, y: yAxix, width: 255, height: 45)
        self.btnSubmit.backgroundColor = .brown
        self.btnSubmit.setTitle("Save", for: .normal)
        self.btnSubmit .setTitleColor(UIColor.white, for: .normal)
        self.btnSubmit.layer.cornerRadius = 15
        self.btnSubmit.layer.masksToBounds = true
        
        
        
        
        self.uiMainView.addSubview(self.btnSubmit)
        
        yAxix = self.btnSubmit.frame.size.height + self.btnSubmit.frame.origin.y + 20

        
//        self.uiScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: yAxix )
//        self.uiMainView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: yAxix)
        
        self.uiScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: yAxix + 84)
        self.uiMainView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: yAxix + 64)
        
        self.btnAddAnotherAddress.addTarget(self, action: #selector(addNotheraddressButtonPressed), for: .touchUpInside)
        
        
        
        
        self.txtFirstName.placeholderColor = UIColor.lightGray
        self.txtFirstName.font = SFont.SourceSansPro_Regular16
        
        self.txtMiddleName.placeholderColor = UIColor.lightGray
        self.txtMiddleName.font = SFont.SourceSansPro_Regular16
        
        self.txtLastName.placeholderColor = UIColor.lightGray
        self.txtLastName.font = SFont.SourceSansPro_Regular16
        
        self.txtDisplayName.placeholderColor = UIColor.lightGray
        self.txtDisplayName.font = SFont.SourceSansPro_Regular16
        
        self.txtNumberPrimary.placeholderColor = UIColor.lightGray
        self.txtNumberPrimary.font = SFont.SourceSansPro_Regular16
        
        self.txtMobileNumber.placeholderColor = UIColor.lightGray
        self.txtMobileNumber.font = SFont.SourceSansPro_Regular16
        
        
        self.txtEmail.placeholderColor = UIColor.lightGray
        self.txtEmail.font = SFont.SourceSansPro_Regular16
        
        self.txtSecondaryEmail.placeholderColor = UIColor.lightGray
        self.txtSecondaryEmail.font = SFont.SourceSansPro_Regular16
        
        self.txtStreet.placeholderColor = UIColor.lightGray
        self.txtStreet.font = SFont.SourceSansPro_Regular16
        
        self.txtStreetSecond.placeholderColor = UIColor.lightGray
        self.txtStreetSecond.font = SFont.SourceSansPro_Regular16
        
        self.txtCity.placeholderColor = UIColor.lightGray
        self.txtCity.font = SFont.SourceSansPro_Regular16
        
        self.txtState.placeholderColor = UIColor.lightGray
        self.txtState.font = SFont.SourceSansPro_Regular16
        
        self.txtZip.placeholderColor = UIColor.lightGray
        self.txtZip.font = SFont.SourceSansPro_Regular16
      
        self.txtCountry.placeholderColor = UIColor.lightGray
        self.txtCountry.font = SFont.SourceSansPro_Regular16
        
      
        
    }

    func saveGuestMemberInfo(secondaryPhone: String,primaryEmail: String,secondaryEmail: String) -> Void {
        
        let parameter:[String:Any] = [
            APIKeys.kMemberId: UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.ksecondaryPhone: secondaryPhone,
            APIKeys.kprimaryEmail: primaryEmail,
            APIKeys.ksecondaryEmail: secondaryEmail,
           

            APIKeys.kdeviceInfo: [APIHandler.devicedict]
        ]
        
        
       // print(parameter)
        
        if (Network.reachability?.isReachable) == true{
            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
            
            APIHandler.sharedInstance.saveMemberInfo(paramaterDict:parameter, onSuccess: { parentMemberinfo in
                
                
                if(parentMemberinfo.responseCode == InternetMessge.kSuccess){
                    self.appDelegate.hideIndicator()
                }
                else{
                    self.appDelegate.hideIndicator()
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: parentMemberinfo.responseMessage, withDuration: Duration.kMediumDuration)
                }
                
                
                self.appDelegate.hideIndicator()
                
                
            },onFailure: { error  in
                
                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
                
            })
        }else{
            
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
        }
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        //navigation item labelcolor
        let textAttributes = [NSAttributedStringKey.foregroundColor:APPColor.navigationColor.navigationitemcolor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "Edit Preferences"
        self.navigationController?.navigationBar.backItem?.title =  CommonString.kNavigationBack
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
    }
    
    
    
    
    
    @objc func addNotheraddressButtonPressed(){
        
        var spaceBetweenTextfiled:CGFloat = 20
        let iconViewWidth:CGFloat = 50.0
        let tralingSpace = (iconViewWidth + self.uiViewPrsonalDetails.frame.origin.x + 40)

        self.btnAddAnotherAddress.removeFromSuperview()
        self.btnPlus.removeFromSuperview()
        
        var yAxix:CGFloat = self.txtCountry.frame.size.height + self.txtCountry.frame.origin.y + spaceBetweenTextfiled
        let outerViewWidth = self.uiMainView.frame.size.width

      
        let lblAddressHeaderOther = UILabel.init()
        lblAddressHeaderOther.frame = CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - (iconViewWidth + 10), height: 21)
        lblAddressHeaderOther.text = "Address other"
        lblAddressHeaderOther.font = SFont.SourceSansPro_Regular13
        lblAddressHeaderOther.backgroundColor = UIColor.clear
        uiViewPrimaryAddress.addSubview(lblAddressHeaderOther)
        
        yAxix = lblAddressHeaderOther.frame.size.height + lblAddressHeaderOther.frame.origin.y + 8
        
        
        let btnCheckMarkOther = UIButton.init()
        btnCheckMarkOther.frame = CGRect(x: iconViewWidth, y: yAxix, width: 25, height: 25)
        btnCheckMarkOther.backgroundColor = UIColor.blue
        uiViewPrimaryAddress.addSubview(btnCheckMarkOther)
        
        
        let btnMalingAddressOther = UIButton.init()
        btnMalingAddressOther.frame = CGRect(x: iconViewWidth + (btnCheckMarkOther.frame.size.width + 10), y: yAxix, width: outerViewWidth - ( iconViewWidth + (btnCheckMarkOther.frame.size.width + 10)), height: 25)
        btnMalingAddressOther.setTitle("Mailing Address", for: .normal)
        btnMalingAddressOther.contentHorizontalAlignment = .left
        btnMalingAddressOther.setTitleColor(hexStringToUIColor(hex: "c9a873"), for: .normal)
        btnMalingAddressOther.titleLabel?.font = SFont.SourceSansPro_Regular16

        
        uiViewPrimaryAddress.addSubview(btnMalingAddressOther)
        

        
        
        yAxix = btnMalingAddressOther.frame.size.height + btnMalingAddressOther.frame.origin.y + spaceBetweenTextfiled
        
        self.txtStreet = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtStreet.lineColor = .lightGray
        self.txtStreet.lineWidth = 1
        self.txtStreet.tweePlaceholder = "Street"
        self.txtStreet.font = SFont.SourceSansPro_Regular16
        uiViewPrimaryAddress.addSubview(self.txtStreet)
        
        
        yAxix = self.txtStreet.frame.size.height + self.txtStreet.frame.origin.y + spaceBetweenTextfiled
        
        self.txtStreetSecond = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtStreetSecond.lineColor = .lightGray
        self.txtStreetSecond.lineWidth = 1
        self.txtStreetSecond.tweePlaceholder = "Street 2"
        self.txtStreetSecond.font = SFont.SourceSansPro_Regular16
        uiViewPrimaryAddress.addSubview(self.txtStreetSecond)
        
        
        
        yAxix = self.txtStreetSecond.frame.size.height + self.txtStreetSecond.frame.origin.y + spaceBetweenTextfiled
        
        self.txtCity = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtCity.lineColor = .lightGray
        self.txtCity.lineWidth = 1
        self.txtCity.tweePlaceholder = "City"
        self.txtCity.font = SFont.SourceSansPro_Regular16
        uiViewPrimaryAddress.addSubview(self.txtCity)
        
        
        yAxix = self.txtCity.frame.size.height + self.txtCity.frame.origin.y + spaceBetweenTextfiled
        
        self.txtState = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtState.lineColor = .lightGray
        self.txtState.lineWidth = 1
        self.txtState.tweePlaceholder = "State"
        self.txtState.font = SFont.SourceSansPro_Regular16
        uiViewPrimaryAddress.addSubview(self.txtState)
        
        yAxix = self.txtState.frame.size.height + self.txtState.frame.origin.y + spaceBetweenTextfiled
        
        
        self.txtZip = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtZip.lineColor = .lightGray
        self.txtZip.lineWidth = 1
        self.txtZip.tweePlaceholder = "Zip"
        self.txtZip.font = SFont.SourceSansPro_Regular16
        uiViewPrimaryAddress.addSubview(self.txtZip)
        
        yAxix = self.txtZip.frame.size.height + self.txtZip.frame.origin.y + spaceBetweenTextfiled
        
        
        self.txtCountry = TweeAttributedTextField.init(frame:CGRect(x: iconViewWidth, y: yAxix, width: outerViewWidth - tralingSpace , height: self.textfiledHeight))
        self.txtCountry.lineColor = .lightGray
        self.txtCountry.lineWidth = 1
        self.txtCountry.tweePlaceholder = "Country"
        self.txtCountry.font = SFont.SourceSansPro_Regular16
        uiViewPrimaryAddress.addSubview(self.txtCountry)
        
        yAxix = self.txtCountry.frame.size.height + self.txtCountry.frame.origin.y + spaceBetweenTextfiled
        
      
        
        let outerViewXaxis = self.view.frame.origin.x

        yAxix = self.txtCountry.frame.size.height + self.txtCountry.frame.origin.y + spaceBetweenTextfiled
        
        uiViewPrimaryAddress.frame = CGRect(x: CGFloat(0), y: 0, width: outerViewWidth, height: yAxix)
        self.uiViewAddress.frame = CGRect(x: CGFloat(outerViewXaxis), y: self.uiViewPrsonalDetails.frame.size.height + self.uiViewPrsonalDetails.frame.origin.y + 20, width: outerViewWidth, height: uiViewPrimaryAddress.frame.size.height + 8)
        
        yAxix = self.uiViewAddress.frame.size.height + self.uiViewAddress.frame.origin.y + 8
        self.uiViewMemberDetails.frame = CGRect(x: CGFloat(outerViewXaxis), y: yAxix, width: outerViewWidth, height: 86)
        
        yAxix = self.uiViewMemberDetails.frame.size.height + self.uiViewMemberDetails.frame.origin.y + 8
        self.uiViewPasswordDetails.frame = CGRect(x: CGFloat(outerViewXaxis), y: yAxix, width: outerViewWidth, height: 80)
        

        
        
        yAxix = self.uiViewPasswordDetails.frame.size.height + self.uiViewPasswordDetails.frame.origin.y + 20
        
        self.btnDoNotShowOnlineChecBox.frame = CGRect(x: 16, y: yAxix, width: 20, height: 20)
        self.btnDoNotShowOnline.frame = CGRect(x: self.btnDoNotShowOnlineChecBox.frame.size.width + self.btnDoNotShowOnlineChecBox.frame.origin.x + 10, y: yAxix - 10, width: outerViewWidth - (self.btnDoNotShowOnlineChecBox.frame.size.width + self.btnDoNotShowOnlineChecBox.frame.origin.x + 0), height: 40)
        
        yAxix = self.btnDoNotShowOnline.frame.size.height + self.btnDoNotShowOnline.frame.origin.y + 20
        
        self.btnSubmit.frame = CGRect(x: (self.uiMainView.frame.size.width - 255) / 2, y: yAxix, width: 255, height: 45)
        
        yAxix = self.btnSubmit.frame.size.height + self.btnSubmit.frame.origin.y + 20
        
        
        self.uiScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: yAxix + 64)
        self.uiMainView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: yAxix + 64)
        
        
        
        self.txtStreet.placeholderColor = UIColor.lightGray
        self.txtStreet.font = SFont.SourceSansPro_Regular16
        
        self.txtStreetSecond.placeholderColor = UIColor.lightGray
        self.txtStreetSecond.font = SFont.SourceSansPro_Regular16
        
        self.txtCity.placeholderColor = UIColor.lightGray
        self.txtCity.font = SFont.SourceSansPro_Regular16
        
        self.txtState.placeholderColor = UIColor.lightGray
        self.txtState.font = SFont.SourceSansPro_Regular16
        
        self.txtZip.placeholderColor = UIColor.lightGray
        self.txtZip.font = SFont.SourceSansPro_Regular16
        
        self.txtCountry.placeholderColor = UIColor.lightGray
        self.txtCountry.font = SFont.SourceSansPro_Regular16
        
    }
}
