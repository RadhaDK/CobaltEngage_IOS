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
    var selectedDate : String?
    var delegateSelectedDateCalendar : dateSelection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundedBgView.clipsToBounds = true
        roundedBgView.layer.cornerRadius = 15
        roundedBgView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        btnDone.layer.cornerRadius = btnDone.layer.frame.height/2
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
        // Do any additional setup after loading the view.
    }
    ///Chanegs the color of today based on isAvailable

    //MARK: - IBActions
    @IBAction func btnDone(_ sender: Any) {
        delegateSelectedDateCalendar?.dateSelection(date: selectedDate ?? "")
        self.dismiss(animated: true)
    }
    @objc func calander(sender : UITapGestureRecognizer) {
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
             print(date)
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd"
        selectedDate = dateFormatter.string(from: date)
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
}

extension Date {

    public var removeTimeStamp : Date? {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
         return nil
        }
        return date
    }
}
