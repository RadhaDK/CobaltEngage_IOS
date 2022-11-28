//
//  DiningRequestSelectResturantDateVC.swift
//  CSSI
//
//  Created by Aks on 07/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import UIKit
import DTCalendarView
import FSCalendar

protocol dateSelection{
    func dateSelection(date : String)
}

class DiningRequestSelectResturantDateVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    
    @IBOutlet weak var roundedBgView: UIView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var myCalendar: FSCalendar!
    @IBOutlet weak var datePicker: UIDatePicker!

    
    var minDaysInAdvance = 0
    var maxDaysInAdvance = 90
    var calendarRangeStartDate : NSString!
    var calendarRangeEndDate : NSString!
    
    
    fileprivate let monthYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        
        formatter.dateFormat = "MMMM"
        
        return formatter
    }()
    fileprivate let YearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        
        formatter.dateFormat = "YYYY"
        
        return formatter
    }()
    fileprivate func currentDate(matchesMonthAndYearOf date: Date) -> Bool {
        let nowMonth = calendar.component(.month, from: now)
        let nowYear = calendar.component(.year, from: now)
        
        let askMonth = calendar.component(.month, from: date)
        let askYear = calendar.component(.year, from: date)
        
        if nowMonth == askMonth && nowYear == askYear {
            return true
        }
        
        return false
    }
    fileprivate let now = Date()
    fileprivate let calendar = Calendar.current
    var selectedDate = Date()
    var delegateSelectedDateCalendar : dateSelection?
    var selectedDateString = ""
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundedBgView.clipsToBounds = true
        roundedBgView.layer.cornerRadius = 15
        roundedBgView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        btnDone.layer.cornerRadius = btnDone.layer.frame.height/2
        self.btnDone.setStyle(style: .outlined, type: .primary)
        self.myCalendar.allowsMultipleSelection = false
        self.myCalendar.weekdayHeight = 50
        self.myCalendar.delegate = self
        self.myCalendar.placeholderType = .none
        self.myCalendar.dataSource = self
        self.myCalendar.appearance.selectionColor = APPColor.MainColours.primary2
        self.myCalendar.appearance.headerTitleColor = .white
        self.myCalendar.appearance.titleDefaultColor = .white
        self.myCalendar.appearance.titleWeekendColor = .white
        self.myCalendar.appearance.subtitleTodayColor = .yellow
        setUpUiInitialization()
//        self.myCalendar.
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            let touch = touches.first
            if touch?.view != self.roundedBgView
            { self.dismiss(animated: true, completion: nil) }
        }
    ///Chanegs the color of today based on isAvailable

    //MARK: - IBActions
    @IBAction func btnDone(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        selectedDateString = dateFormatter.string(from: self.datePicker.date)
        delegateSelectedDateCalendar?.dateSelection(date: selectedDateString)
        self.dismiss(animated: true)
    }
    @objc func calander(sender : UITapGestureRecognizer) {
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

            selectedDate = date
    }
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        
        let curDate = Date().addingTimeInterval(-24*60*60)
        
        if date < curDate {
            return false
        } else {
            return true
        }
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
         
          //Remove timeStamp from date
          if date.removeTimeStamp!.compare(Date().removeTimeStamp!) == .orderedAscending {
         
             return .lightGray
         
          }else if date.removeTimeStamp!.compare(Date().removeTimeStamp!) == .orderedDescending{
         
             return .white
         
          }
        else {
         
             return .white

          }
                 
       }
// MARK:- picker setup
    func setUpUiInitialization(){
        dateFormatter.dateFormat = "MMM dd-yyyy"
        datePicker.datePickerMode = .date
        datePicker.textColor = .white
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")

//        datePicker.minuteInterval = 15
        
        if #available(iOS 15.0, *) {
//            datePicker.minimumDate = minimumDate
//            datePicker.maximumDate = maximumDate
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
          
            // Fallback on earlier versions
        }
        //datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        datePicker.date = selectedDate
        let minimumDate = Calendar.current.date(byAdding: .day, value: self.minDaysInAdvance, to: Date())!
        let maximumDate = Calendar.current.date(byAdding: .day, value: self.maxDaysInAdvance, to: Date())!
        
        datePicker.maximumDate = maximumDate
        datePicker.minimumDate = minimumDate
    }
}

extension Date {

    public var removeTimeStamp : Date? {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
         return nil
        }
        return date
    }
}
