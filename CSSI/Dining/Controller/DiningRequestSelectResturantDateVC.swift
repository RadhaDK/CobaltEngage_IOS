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


class DiningRequestSelectResturantDateVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    
    @IBOutlet weak var roundedBgView: UIView!

    @IBOutlet weak var btnDone: UIButton!
    var calendarRangeStartDate : NSString!
    var calendarRangeEndDate : NSString!
    @IBOutlet weak var myCalendar: FSCalendar!

//    @IBOutlet weak var eventDateRangeView: DTCalendarView!{
//        didSet {
//            eventDateRangeView.delegate = self
//
//            eventDateRangeView.displayEndDate = Date(timeIntervalSinceNow: 60 * 60 * 24 * 30 * 12 * 40)
//            eventDateRangeView.previewDaysInPreviousAndMonth = false
//
//            let lastYear = Calendar.current.date(byAdding: .year, value: -20, to: Date())
//
//            let currentTimeStamp = lastYear!.toMillis()
//                //  now = lastYear!
//
//            let intValue = NSNumber(value: currentTimeStamp!).intValue
//
//            eventDateRangeView.displayStartDate =  Date(timeIntervalSince1970: TimeInterval(intValue))
//        }
//    }
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
    
    fileprivate let now = Date()
    fileprivate let calendar = Calendar.current
    
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
        // Do any additional setup after loading the view.
    }
    ///Chanegs the color of today based on isAvailable


    
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

    @IBAction func btnDone(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @objc func calander(sender : UITapGestureRecognizer) {
    }
    
//    func minimumDate(for calendar: FSCalendar) -> Date {
//
//
////        if dateDiff.first == "+"{
////            return Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.minDaysInAdvance ?? 0) + 1, to: self.dateAndTimeDromServer)!
////
////        }else{
////            return Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.minDaysInAdvance ?? 0) , to: self.dateAndTimeDromServer)!
////        }
//    }
//    func maximumDate(for calendar: FSCalendar) -> Date {
//
////        let dateDiff = findDateDiff(time1Str: self.maxTime ?? "", time2Str: currentTime ?? "")
////        if dateDiff.first == "+"{
////            return Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.maxDaysInAdvance ?? 0) + 1, to: self.dateAndTimeDromServer)!
////
////        }else{
////            return Calendar.current.date(byAdding: .day, value: +(self.golfSettings?.maxDaysInAdvance ?? 0), to: self.dateAndTimeDromServer)!
////
////        }
//    }
}
extension DiningRequestSelectResturantDateVC: DTCalendarViewDelegate {
    
    func calendarView(_ calendarView: DTCalendarView, dragFromDate fromDate: Date, toDate: Date) {
        
        if let nowDayOfYear = calendar.ordinality(of: .day, in: .year, for: now),
            let selectDayOfYear = calendar.ordinality(of :.day, in: .year, for: toDate),
            selectDayOfYear > nowDayOfYear {
            return
        }
        
        if let startDate = calendarView.selectionStartDate,
            fromDate == startDate {
            
            if let endDate = calendarView.selectionEndDate {
                if toDate < endDate {
                    calendarView.selectionStartDate = toDate
                }
            } else {
                calendarView.selectionStartDate = toDate
            }
            
        } else if let endDate = calendarView.selectionEndDate,
            fromDate == endDate {
            
            if let startDate = calendarView.selectionStartDate {
                if toDate > startDate {
                    calendarView.selectionEndDate = toDate
                }
            } else {
                calendarView.selectionEndDate = toDate
            }
        }
    }
    
    func calendarView(_ calendarView: DTCalendarView, viewForMonth month: Date) -> UIView {
        
        
        
        let myview = UIView()
        let label = UILabel(frame: CGRect(x: 0, y: 40, width: 200, height: 28))
        
        label.text = monthYearFormatter.string(from: month)
        label.textColor = UIColor(red: 61.0/255.0, green: 61.0/255.0, blue: 61.0/255.0, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.backgroundColor = UIColor.white
        myview.addSubview(label)
        
        let label2 = UILabel(frame: CGRect(x: 0, y: 10, width: 200, height: 22))
        label2.text = YearFormatter.string(from: month)
        label2.textColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        label2.font = UIFont.boldSystemFont(ofSize: 28)
        label2.backgroundColor = UIColor.white
        myview.addSubview(label2)
        
        
        return myview
    }
    
    func calendarView(_ calendarView: DTCalendarView, disabledDaysInMonth month: Date) -> [Int]? {
        
        if currentDate(matchesMonthAndYearOf: month) {
            var disabledDays = [Int]()
            
            let nowDay = calendar.component(.day, from: now)
            
            for day in 1 ... nowDay {
                disabledDays.append(day)
            }
            
            return disabledDays
        }
        
        return nil
    }
    
    func calendarView(_ calendarView: DTCalendarView, didSelectDate date: Date) {
        
        if let nowDayOfYear = calendar.ordinality(of: .day, in: .year, for: now),
            let selectDayOfYear = calendar.ordinality(of :.day, in: .year, for: date),
            calendar.component(.year, from: now) == calendar.component(.year, from: date),
            selectDayOfYear > nowDayOfYear {
            return
        }
        
        if calendarView.selectionStartDate == nil {
            calendarView.selectionStartDate = date
            
        } else if calendarView.selectionEndDate == nil {
            if let startDateValue = calendarView.selectionStartDate {
                if date <= startDateValue {
                    calendarView.selectionStartDate = date
                } else {
                    calendarView.selectionEndDate = date
                    calendarRangeEndDate = SharedUtlity.sharedHelper().dateFormatter.string(from: calendarView.selectionEndDate!) as NSString
                }
            }
        } else {
            calendarView.selectionStartDate = date
            calendarView.selectionEndDate = nil
            
        }
        calendarRangeStartDate = SharedUtlity.sharedHelper().dateFormatter.string(from: calendarView.selectionStartDate!) as NSString
    }
    
    func calendarViewHeightForWeekRows(_ calendarView: DTCalendarView) -> CGFloat {
        return 60
    }
    
    func calendarViewHeightForWeekdayLabelRow(_ calendarView: DTCalendarView) -> CGFloat {
        return 50
    }
    
    func calendarViewHeightForMonthView(_ calendarView: DTCalendarView) -> CGFloat {
        return 80
    }
}
