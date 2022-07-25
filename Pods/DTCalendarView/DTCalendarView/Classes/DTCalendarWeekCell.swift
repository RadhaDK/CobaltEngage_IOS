//
//  DTCalendarWeekCell.swift
//  Pods
//
//  Created by Tim Lemaster on 6/16/17.
//
//

import UIKit

protocol DTCalendarWeekCellDelegate: class {
    
    func calendarWeekCell(_ calendarWeekCell: DTCalendarWeekCell, didTapDate date: Date)
}

class DTCalendarWeekCell: UICollectionViewCell {
    
    var displayMonth = Date()
    
    var displayWeek = 1
    
    var selectionStartDate: Date?
    var selectionEndDate: Date?
    
    var disabledDays: [Int]?
    
    var previewDaysInPreviousAndMonth = true
    
    var mondayShouldBeTheFirstDayOfTheWeek = false
    
    weak var delegate: DTCalendarWeekCellDelegate?
    
    private var dayViews: [DTCalendarDayView] = [DTCalendarDayView(frame: .zero),
                                                 DTCalendarDayView(frame: .zero),
                                                 DTCalendarDayView(frame: .zero),
                                                 DTCalendarDayView(frame: .zero),
                                                 DTCalendarDayView(frame: .zero),
                                                 DTCalendarDayView(frame: .zero),
                                                 DTCalendarDayView(frame: .zero)]
    
    private var leadInSelectionView = UIView(frame: .zero)
    private var leadOutSelectionView = UIView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    override func prepareForReuse() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        leadInSelectionView.isHidden = true
        leadOutSelectionView.isHidden = true
        
        for dayView in dayViews {
            dayView.rangeSelection = .outSelection
            dayView.isPreview = false
            dayView.isHidden = false
        }
        
        CATransaction.commit()
    }
    
    override func layoutSubviews() {
        
        let width = contentView.bounds.width
        let height = contentView.bounds.height
        
        let widthAvailablePerDay = floor((width - 40) / CGFloat(dayViews.count))
        let leftOverWidth = width - 40 - (widthAvailablePerDay * CGFloat(dayViews.count))
        let leadingExtra = floor(leftOverWidth / 2)
        let trailingExtra = leftOverWidth - leadingExtra
        
        let leadInFrame = CGRect(x: 0, y: 0, width: 20 + leadingExtra, height: height).insetBy(dx: 0, dy: height > widthAvailablePerDay ? (height - widthAvailablePerDay) / 2 : 0)
        leadInSelectionView.frame = leadInFrame
        
        let leadOutFrame = CGRect(x:width-20-trailingExtra, y:0, width: 20+trailingExtra, height: height).insetBy(dx: 0, dy: height > widthAvailablePerDay ? (height - widthAvailablePerDay) / 2 : 0)
        leadOutSelectionView.frame = leadOutFrame
        
        for (index, dayView) in dayViews.enumerated() {
            
            dayView.frame = CGRect(x: 20 + leadingExtra + (CGFloat(index) * widthAvailablePerDay), y: 0, width: widthAvailablePerDay, height: height)
        }
        
        super.layoutSubviews()
    }
    
    private func setupView() {
        
        leadInSelectionView.isHidden = true
        leadOutSelectionView.isHidden = true
        
        contentView.addSubview(leadInSelectionView)
        contentView.addSubview(leadOutSelectionView)
        
        for dayView in dayViews {
            contentView.addSubview(dayView)
            
            dayView.isUserInteractionEnabled = true
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(dayViewTapped(_:)))
            dayView.addGestureRecognizer(tapGR)
        }
    }
    
    @objc func dayViewTapped(_ tapGR: UITapGestureRecognizer) {
        
        if let dayLabel = tapGR.view as? DTCalendarDayView,
            tapGR.state == .recognized {
            
            if (dayLabel.isPreview && previewDaysInPreviousAndMonth) || (!dayLabel.isPreview) {
                delegate?.calendarWeekCell(self, didTapDate: dayLabel.representedDate)
            }
        }
    }
    
    func updateCalendarLabels(weekDisplayAttributes: WeekDisplayAttributes) {
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        backgroundColor = weekDisplayAttributes.normalDisplayAttributes.backgroundColor
        leadInSelectionView.backgroundColor = weekDisplayAttributes.highlightedDisplayAttributes.backgroundColor
        leadOutSelectionView.backgroundColor = weekDisplayAttributes.highlightedDisplayAttributes.backgroundColor
        
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: displayMonth)
        components.setValue(1, for: .day)
        
        var selectionStartDateMidnight: Date?
        if let selectionStartDate = selectionStartDate {
            selectionStartDateMidnight = calendar.startOfDay(for: selectionStartDate)
        }
        
        var selectionEndDateMidnight: Date?
        if let selectionEndDate = selectionEndDate {
            selectionEndDateMidnight = calendar.startOfDay(for: selectionEndDate)
        }
        
        if let firstDayOfMonth = calendar.date(from: components),
            let previousMonth = calendar.date(byAdding: .month, value: -1, to: firstDayOfMonth),
            let nextMonth = calendar.date(byAdding: .month, value: 1, to: firstDayOfMonth) {
            
            let previousMonthRange = calendar.range(of: .day, in: .month, for: previousMonth)
            
            let wdComponents = calendar.dateComponents([.weekday], from: firstDayOfMonth)
            let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth)
            
            if var weekday = wdComponents.weekday,
                let range = range,
                let previousMonthRange = previousMonthRange {
                
                if mondayShouldBeTheFirstDayOfTheWeek {
                    weekday = ((weekday + 5) % 7) + 1
                }
                
                if weekday == 1 {
                    weekday = 8
                }
                
                for (index, dayView) in dayViews.enumerated() {
                    
                    let indexWithOffset = index + ((displayWeek-1) * 7)
                    
                    dayView.previewDaysInPreviousAndMonth = previewDaysInPreviousAndMonth
                    
                    if (indexWithOffset >= (weekday - 1)) && (indexWithOffset < (range.count + weekday - 1)) {
                        
                        let currentDay = indexWithOffset - weekday + 2
                        dayView.dayOfMonth = currentDay
                        
                        if let disabledDays = disabledDays {
                            dayView.isDisabled = disabledDays.contains(currentDay)
                        } else {
                            dayView.isDisabled = false
                        }
                        
                        if let currentDate = calendar.date(bySetting: .day, value: currentDay, of: firstDayOfMonth) {
                            let startCurrentDate = calendar.startOfDay(for: currentDate)
                            
                            configure(calendarDayView: dayView,
                                      forIndex: index,
                                      withStartOfDay: startCurrentDate,
                                      forSelectionStartDateMidnight: selectionStartDateMidnight,
                                      andSelectionEndDateMidnight: selectionEndDateMidnight)
                        }
                        
                    } else if indexWithOffset >= (range.count + weekday - 1) {
                        
                        let currentDay = indexWithOffset - range.count - weekday + 2
                        dayView.isPreview = true
                        dayView.dayOfMonth = currentDay
                        
                        if let currentDate = calendar.date(bySetting: .day, value: currentDay, of: nextMonth) {
                            let startCurrentDate = calendar.startOfDay(for: currentDate)
                            
                            configure(calendarDayView: dayView,
                                      forIndex: index,
                                      withStartOfDay: startCurrentDate,
                                      forSelectionStartDateMidnight: selectionStartDateMidnight,
                                      andSelectionEndDateMidnight: selectionEndDateMidnight)
                        }
                    } else {
                        
                        let currentDay = previousMonthRange.count - weekday + indexWithOffset + 2
                        dayView.isPreview = true
                        dayView.dayOfMonth = currentDay
                        
                        if let currentDate = calendar.date(bySetting: .day, value: currentDay, of: previousMonth) {
                            let startCurrentDate = calendar.startOfDay(for: currentDate)
                            
                            
                            configure(calendarDayView: dayView,
                                      forIndex: index,
                                      withStartOfDay: startCurrentDate,
                                      forSelectionStartDateMidnight: selectionStartDateMidnight,
                                      andSelectionEndDateMidnight: selectionEndDateMidnight)
                        }
                    }
                    dayView.updateView(weekDisplayAttributes: weekDisplayAttributes)
                }
            }
        }
        
        CATransaction.commit()
    }
    
    private func configure(calendarDayView: DTCalendarDayView,
                           forIndex index: Int,
                           withStartOfDay startOfDay: Date,
                           forSelectionStartDateMidnight selectionStartDateMidnight: Date?,
                           andSelectionEndDateMidnight selectionEndDateMidnight: Date?) {
        
        var clearRangeSelection = true
        
        if let selectionStartDateMidnight = selectionStartDateMidnight {
            if selectionStartDateMidnight == startOfDay {
                clearRangeSelection = false
                if selectionEndDateMidnight == nil {
                    calendarDayView.rangeSelection = .startSelectionNoEnd
                } else {
                    if index == 6 {
                        if (calendarDayView.isPreview && previewDaysInPreviousAndMonth) || (!calendarDayView.isPreview) {
                            leadOutSelectionView.isHidden = false
                        }
                    }
                    calendarDayView.rangeSelection = .startSelection
                }
            }
        }
        
        if let selectionEndDateMidnight = selectionEndDateMidnight {
            if selectionEndDateMidnight == startOfDay {
                clearRangeSelection = false
                if selectionStartDateMidnight == nil {
                    calendarDayView.rangeSelection = .endSelectionNoStart
                } else {
                    if index == 0 {
                        if (calendarDayView.isPreview && previewDaysInPreviousAndMonth) || (!calendarDayView.isPreview) {
                            leadInSelectionView.isHidden = false
                        }
                    }
                    calendarDayView.rangeSelection = .endSelection
                }
            }
        }
        
        if let selectionStartDateMidnight = selectionStartDateMidnight,
            let selectionEndDateMidnight = selectionEndDateMidnight {
            
            if selectionStartDateMidnight < startOfDay && startOfDay < selectionEndDateMidnight {
                clearRangeSelection = false
                if index == 0 {
                    if (calendarDayView.isPreview && previewDaysInPreviousAndMonth) || (!calendarDayView.isPreview) {
                        leadInSelectionView.isHidden = false
                    }
                }
                if index == 6 {
                    if (calendarDayView.isPreview && previewDaysInPreviousAndMonth) || (!calendarDayView.isPreview) {
                        leadOutSelectionView.isHidden = false
                    }
                }
                calendarDayView.rangeSelection = .inSelection
            }
        }
        
        if clearRangeSelection {
            calendarDayView.rangeSelection = .outSelection
        }
        calendarDayView.representedDate = startOfDay
    }
}
