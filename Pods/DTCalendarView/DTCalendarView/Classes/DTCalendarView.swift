//
//  DTCalendarView.swift
//  Pods
//
//  Created by Tim Lemaster on 6/14/17.
//
//

import UIKit

/// An object that adopts the DTCalendarViewDelegate protocol is responsible for providing the data required by the DTCalendarView class and
/// responding to actions produced by interaction with the DTCalendarView by the user
public protocol DTCalendarViewDelegate: class {
    
    /**
     Asks your delegate for a view to use to display the month/year above the weeks of a month
     
     - parameter calendarView: The calendar view requesting the view
     
     - parameter month: A date representing the month/year the view should represent, other Date data should be ignored - like the particular day
     
     - returns: A view representing the month/year to be displayed above the calendar. It will be sized to fill the available space
     
     */
    func calendarView(_ calendarView: DTCalendarView, viewForMonth month: Date) -> UIView
    
    /**
     Asks your delegate for an array of days that should appear disabled to the user. The logic of selection of these dates is still up to your
     app to enforce, so you can decide what happens if someone attempts to select a range including a disabled date, etc
     
     - parameter calendarView: The calendar view requesting the disabled dates
     
     - parameter month: A date representing the month/year the array should represent, other Date data should be ignored - like the particular day
     
     - returns: An representing the days to be displayed as disabled by the calendar. This array should be a list of the days of the month to disable (1, 5, 7...)
     
     */
    func calendarView(_ calendarView: DTCalendarView, disabledDaysInMonth month: Date) -> [Int]?
    
    
    /**
     Notifies your delegate that a user dragged a selected date to another day on the calendar. The date could be the selected start day or end day,
     this can be determined by testing against those properties on teh calendar view returned. It is entirely up to your delegate to determine if this
     drag should select that day on the calendar - and if that is the new selection start or end date.
     
     - parameter calendarView: The calendar view notifying the delegate
     
     - parameter fromDate: A date representing the day/month/year the user dragged from, other Date data should be ignored - like hours/minutes/seconds
     
     - parameter toDate: A date representing the day/month/year the user dragged to,  other Date data should be ignored - like hours/minutes/seconds
     
     */
    func calendarView(_ calendarView: DTCalendarView, dragFromDate fromDate: Date, toDate: Date)
    
    /**
     Notifies your delegate that a user taps on a particular day on a calendar. It is entirely up to your delegate to determine if this tap should
     select that day on the calendar as a new selection start date or selection end date.
     
     - parameter calendarView: The calendar view notifying the delegate
     
     - parameter date: A date representing the day/month/year the user taps, othe Date data should be ignored - like hours/minutes/seconds
     
     */
    func calendarView(_ calendarView: DTCalendarView, didSelectDate date: Date)
    
    
    /**
     Asks your delegate for the height used to display the view representing the months/years above the weeks of a month
     
     - parameter calendarView: The calendar view requesting the view
     
     - returns the height used the diplay the view
     
     */
    func calendarViewHeightForMonthView(_ calendarView: DTCalendarView) -> CGFloat
    
    /**
     Asks your delegate for the height used to display the view containing the weekday labels
     
     - parameter calendarView: The calendar view requesting the view
     
     - returns the height used the diplay the view
     
     */
    func calendarViewHeightForWeekRows(_ calendarView: DTCalendarView) -> CGFloat
    
    /**
     Asks your delegate for the height used to display the view containing the weeks of the month
     
     - parameter calendarView: The calendar view requesting the view
     
     - returns the height used the diplay the view
     
     */
    func calendarViewHeightForWeekdayLabelRow(_ calendarView: DTCalendarView) -> CGFloat
}


/// A structure for holding the various stylable attributes for various calendar states
public struct DisplayAttributes {
    
    public init(font: UIFont, textColor: UIColor, backgroundColor: UIColor, textAlignment: NSTextAlignment) {
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.textAlignment = textAlignment
    }
    
    /// The font used to render the day or weekday label
    let font: UIFont
    
    /// The text color used to render the day or weekday label
    let textColor: UIColor
    
    /// The background color used to render the background of the day or weekday label, or the selected/highlighed indicator background
    let backgroundColor: UIColor
    
    /// The how to align the text - usually .center
    let textAlignment: NSTextAlignment
}

/// The day state of a particular day on the calendar
public enum DayState {
    
    /// The default
    case normal
    
    /// Selected as the start or end date
    case selected
    
    /// In between the current start and end dates
    case highlighted
    
    /// Non-selectable state
    case disabled
    
    /// A day from a previous or next month displayed in the current month view
    case preview
}

struct WeekDisplayAttributes {
    let normalDisplayAttributes: DisplayAttributes
    let selectedDisplayAttributes: DisplayAttributes
    let highlightedDisplayAttributes: DisplayAttributes
    let disabledDisplayAttributes: DisplayAttributes
    let previewDisplayAttributes: DisplayAttributes
}

private enum PanMode {
    case none
    case start
    case end
}


/// A class for displaying a vertical scrolling calendar view. Supports selecting a range of dates and dragging those days around
public class DTCalendarView: UIView {
    
    /// The month/year the calendar should start at - defaults to current month/year. Other Date attributes are ignored (day, hour, etc)
    public var displayStartDate: Date {
        get {
            return self._startDate
        }
        set {
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day], from: newValue)
            components.setValue(1, for: .day)
            if let firstDayOfMonth = calendar.date(from: components) {
                _startDate = firstDayOfMonth
            }
        }
    }
    
    /// The month/year the calendar should end at - defaults to current month/year. Other Date attributes are ignored (day, hour, etc)
    public var displayEndDate: Date {
        get {
            return self._endDate
        }
        set {
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day], from: newValue)
            components.setValue(1, for: .day)
            if let firstDayOfMonth = calendar.date(from: components) {
                _endDate = firstDayOfMonth
            }
        }
    }
    
    /// The day/month/year the calendar range selection starts at - also could be used for single selection - defaults to nil
    public var selectionStartDate: Date? {
        didSet {
            setNeedsUpdate()
        }
    }
    
    /// The day/month/year the calendar range selection end at - defaults to nil
    public var selectionEndDate: Date? {
        didSet {
            setNeedsUpdate()
        }
    }
    
    /// Should the calendar include days from the previous/next months in the current months to fill out complete weeks
    public var previewDaysInPreviousAndMonth = true {
        didSet {
            setNeedsUpdate()
        }
    }
    
    /// Should the calendar scroll be paginated and always lock to the top of a month
    // public var paginateMonths = false
    
    /// The first day of the week should be a Monday
    public var mondayShouldBeTheFirstDayOfTheWeek = false {
        didSet {
            weekdayLabels = mondayShouldBeTheFirstDayOfTheWeek ? DTCalendarView.mondayWeekdayLabels : DTCalendarView.defaultWeekdayLabels
            setNeedsUpdate()
        }
    }
    
    /// A delegate to provide required data to the calendar view and respond to user interaction with the calendar view
    public weak var delegate: DTCalendarViewDelegate?
    
    /// Predefined Weekday Labels
    private static var defaultWeekdayLabels = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private static var mondayWeekdayLabels  = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    fileprivate var weekdayLabels: [String] = DTCalendarView.defaultWeekdayLabels
    
    fileprivate var weekDisplayAttributes = WeekDisplayAttributes(normalDisplayAttributes: DisplayAttributes(font: UIFont.systemFont(ofSize: 15),
                                                                                                             textColor: .black,
                                                                                                             backgroundColor: .white,
                                                                                                             textAlignment: .center),
                                                                  selectedDisplayAttributes: DisplayAttributes(font: UIFont.boldSystemFont(ofSize: 15),
                                                                                                               textColor: .white,
                                                                                                               backgroundColor: UIColor(red: 244.0/255.0, green: 125.0/255.0, blue: 76.0/255.0, alpha: 1.0),
                                                                                                               textAlignment: .center),
                                                                  highlightedDisplayAttributes: DisplayAttributes(font: UIFont.systemFont(ofSize: 15),
                                                                                                                  textColor: .white,
                                                                                                                  backgroundColor: UIColor(red: 244.0/255.0, green: 125.0/255.0, blue: 76.0/255.0, alpha: 1.0),
                                                                                                                  textAlignment: .center),
                                                                  disabledDisplayAttributes: DisplayAttributes(font: UIFont.systemFont(ofSize: 15),
                                                                                                               textColor: UIColor.black.withAlphaComponent(0.5),
                                                                                                               backgroundColor: .white,
                                                                                                               textAlignment: .center),
                                                                  previewDisplayAttributes: DisplayAttributes(font: UIFont.systemFont(ofSize: 15),
                                                                                                              textColor: UIColor.black.withAlphaComponent(0.5),
                                                                                                              backgroundColor: .white,
                                                                                                              textAlignment: .center))
    
    /// This display attributes that will be applied to the weekday labels
    public var weekdayDisplayAttributes = DisplayAttributes(font: UIFont.systemFont(ofSize: 15),
                                                            textColor: .black,
                                                            backgroundColor: .white,
                                                            textAlignment: .center) {
        didSet {
            setNeedsUpdate()
        }
    }
    
    fileprivate var collectionViewFlowLayout: UICollectionViewFlowLayout
    fileprivate var collectionView: UICollectionView
    
    /// The pan gesture recogizer for dragging start/end date
    fileprivate var datePanGR: UIPanGestureRecognizer?
    
    /// The pan mode - dragging start or end date or none
    fileprivate var panMode = PanMode.none
    
    /// The section (month/year) the calendar was at when the user started scrolling
    fileprivate var sectionAtStartOfScrolling: Int?
    
    /// Internal representation of the calendar start date the user set - pins to first day of month for calculations
    private var _startDate: Date = {
        let calendar = Calendar.current
        let date = Date()
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        components.setValue(1, for: .day)
        if let firstDayOfMonth = calendar.date(from: components) {
            return firstDayOfMonth
        }
        return date
        }() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    /// Internal representation of the calendar end date the user set - pins to first day of month for calculations
    private var _endDate: Date = {
        let calendar = Calendar.current
        let date = Date()
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        components.setValue(1, for: .day)
        if let firstDayOfMonth = calendar.date(from: components) {
            return firstDayOfMonth
        }
        return date
        }() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    /**
     Create a new calendar view with the given start/end display dates
     
     - parameter startDate: The month/year to begin the calendar
     
     - parameter endDate: The month/year to end the calendar
     
     - returns: a new calendar view
     
     */
    public init(startDate: Date, endDate: Date) {
        
        collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        
        super.init(frame: .zero)
        
        self.displayStartDate = startDate
        self.displayEndDate = endDate
        
        
        setupCollectionView()
    }
    
    /**
     Create a new calendar view with the default start/end dates
     
     - returns: a new calendar view
     
     */
    required public init?(coder aDecoder: NSCoder) {
        
        collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        
        super.init(coder: aDecoder)
        
        setupCollectionView()
    }
    
    override public func layoutSubviews() {
        
        collectionView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        
        super.layoutSubviews()
    }
    
    /**
     Set the display attributes for the given date state
     
     - parameter displayAttributes: The attributes to apply
     
     - parameter state: The day state the attributes apply to
     */
    public func setDisplayAttributes(_ displayAttributes: DisplayAttributes, forState state: DayState) {
        
        var normalDisplayAttributes = weekDisplayAttributes.normalDisplayAttributes
        var selectedDisplayAttributes = weekDisplayAttributes.selectedDisplayAttributes
        var highlightedDisplayAttributes = weekDisplayAttributes.highlightedDisplayAttributes
        var disabledDisplayAttributes = weekDisplayAttributes.disabledDisplayAttributes
        var previewDisplayAttributes = weekDisplayAttributes.previewDisplayAttributes
        
        switch state {
        case .normal:
            collectionView.backgroundColor = displayAttributes.backgroundColor
            normalDisplayAttributes = displayAttributes
        case .selected:
            selectedDisplayAttributes = displayAttributes
        case .highlighted:
            highlightedDisplayAttributes = displayAttributes
        case .disabled:
            disabledDisplayAttributes = displayAttributes
        case .preview:
            previewDisplayAttributes = displayAttributes
        }
        
        weekDisplayAttributes = WeekDisplayAttributes(normalDisplayAttributes: normalDisplayAttributes,
                                                      selectedDisplayAttributes: selectedDisplayAttributes,
                                                      highlightedDisplayAttributes: highlightedDisplayAttributes,
                                                      disabledDisplayAttributes: disabledDisplayAttributes,
                                                      previewDisplayAttributes: previewDisplayAttributes)
        
        setNeedsUpdate()
    }
    
    /**
     Scrolls the calendar view such that the month represented by given date is at the top of the view
     
     - parameter month: The date to get the month/year from (day is ignored)
     */
    public func scrollTo(month: Date, animated: Bool) {
        
        //Can't scroll outside the represented range
        guard month >= displayStartDate, month <= displayEndDate else { return }
        
        let calendar = Calendar.current
        let months = calendar.dateComponents([.month], from: displayStartDate, to: month).month ?? 0
        
        let indexPath = IndexPath(item: 0, section: months)
        
        //If the user has set something that requires a dispatch update
        //Wait until after the dispatch update completes to scroll
        if needsUpdate {
            indexPathToScrollToAfterUpdate = indexPath
            animateScrollAfterUpdate = animated
        } else {
            collectionView.scrollToItem(at: indexPath, at: .top, animated: animated)
        }
    }
    
    /**
     The text to use for the weekday labels
     
     -parameters labels: An array with the text labels, this must be an array with 7 values in order Sun-Sat
     
     */
    public func setWeekdayLabels(_ labels: [String]) {
        if labels.count != 7 {
            fatalError("It is a programmer error to provide more or less than 7 weekday label values")
        }
        
        weekdayLabels = labels
    }
    
    fileprivate func reloadVisibleCells() {
        /// Disable implicit layer animations
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
        CATransaction.commit()
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        
        collectionViewFlowLayout.minimumLineSpacing = 0.0
        collectionViewFlowLayout.minimumInteritemSpacing = 0.0
        
        collectionView.backgroundColor = weekDisplayAttributes.normalDisplayAttributes.backgroundColor
        
        collectionView.register(DTMonthViewCell.self, forCellWithReuseIdentifier: "MonthViewCell")
        collectionView.register(DTWeekdayViewCell.self, forCellWithReuseIdentifier: "WeekDayViewCell")
        collectionView.register(DTCalendarWeekCell.self, forCellWithReuseIdentifier: "WeekViewCell")
        
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView.dataSource = self
        collectionView.delegate = self
        
        datePanGR = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        datePanGR!.delegate = self
        collectionView.addGestureRecognizer(datePanGR!)
    }
    
    @objc func viewPanned(_ panGR: UIPanGestureRecognizer) {
        
        let point = panGR.location(in: collectionView)
        
        /// Is the user over the day of a calendar?
        if let dayView = collectionView.hitTest(point, with: nil) as? DTCalendarDayView {
            
            /// Is that day outside of the current month and we aren't showing those
            /// Then ignore
            if dayView.isPreview && !previewDaysInPreviousAndMonth {
                return
            }
            
            if panGR.state == .began {
                switch dayView.rangeSelection {
                case .startSelectionNoEnd, .startSelection:
                    panMode = .start
                case .endSelectionNoStart, .endSelection:
                    panMode = .end
                default:
                    panMode = .none
                }
            } else if panGR.state == .changed {
                
                if panMode == .start {
                    
                    if let startDate = selectionStartDate {
                        if startDate != dayView.representedDate {
                            delegate?.calendarView(self, dragFromDate: startDate, toDate: dayView.representedDate)
                        }
                    }
                } else if panMode == .end {
                    
                    if let endDate = selectionEndDate {
                        if endDate != dayView.representedDate {
                            delegate?.calendarView(self, dragFromDate: endDate, toDate: dayView.representedDate)
                        }
                    }
                }
            }
        }
        
    }
    
    private var needsUpdate = false
    private var indexPathToScrollToAfterUpdate: IndexPath?
    private var animateScrollAfterUpdate = false
    
    /**
     Triggers a calendar view update during the next update cycle.
     */
    public func setNeedsUpdate() {
        if !needsUpdate {
            needsUpdate = true
            DispatchQueue.main.async { [weak self] in
                self?.needsUpdate = false
                self?.reloadVisibleCells()
                
                // If something changed that required an update dispatch we wait to scroll until after the update has been applied
                if let indexPath = self?.indexPathToScrollToAfterUpdate {
                    self?.collectionView.scrollToItem(at: indexPath, at: .top, animated: self?.animateScrollAfterUpdate ?? false)
                    self?.indexPathToScrollToAfterUpdate = nil
                }
            }
        }
    }
}

extension DTCalendarView: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        /// Each section of the collection view represents a month
        /// with rows representing the month/year view, the days of the week, and a full calendar week
        let calendar = Calendar.current
        let months = calendar.dateComponents([.month], from: displayStartDate, to: displayEndDate).month ?? 0
        
        return months + 1
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if previewDaysInPreviousAndMonth {
            /// If showing days outside the current month
            /// The month section always has 8 rows - 6 for the weeks, one for the month/year view, and one for the day of week labels
            return 8
        } else {
            var count = 8
            
            /// If not we need to determine if the month will fit in less than 6 displayed weeks
            /// If so determine if this falls at the end or beginning of the month (or both Feb 2015!)
            /// And subtract that week out of the total count
            let calendar = Calendar.current
            if let date = calendar.date(byAdding: .month, value: section, to: displayStartDate),
                let range = calendar.range(of: .day, in: .month, for: date),
                var weekday = calendar.dateComponents([.weekday], from: date).weekday {
                
                if mondayShouldBeTheFirstDayOfTheWeek {
                    weekday = ((weekday + 5) % 7) + 1
                }
                
                if weekday == 1 {
                    weekday = 8
                }
                
                let indexOfLastDayOfWeekInFirstWeek = 6
                let indexOfFirstDayOfWeekInLastWeek = 35
                
                if indexOfLastDayOfWeekInFirstWeek < weekday - 1 {
                    count -= 1
                }
                
                if indexOfFirstDayOfWeekInLastWeek >= (range.count + weekday - 1) {
                    count -= 1
                }
            }
            
            return count
        }
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            /// Cell for the month/year view
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthViewCell", for: indexPath)
            let calendar = Calendar.current
            if let date = calendar.date(byAdding: .month, value: indexPath.section, to: displayStartDate),
                let monthCell = cell as? DTMonthViewCell {
                let userMonthView = delegate?.calendarView(self, viewForMonth: date)
                monthCell.userContentView = userMonthView
            }
            return cell
        } else if indexPath.item == 1 {
            /// Cell for the week day labels
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekDayViewCell", for: indexPath)
            
            if let weekdayViewCell = cell as? DTWeekdayViewCell {
                weekdayViewCell.setDisplayAttributes(weekdayDisplayAttributes)
                weekdayViewCell.setWeekdayLabels(weekdayLabels)
            }
            
            return cell
        } else {
            /// Cell for a week
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "WeekViewCell", for: indexPath)
            
            let calendar = Calendar.current
            
            if let date = calendar.date(byAdding: .month, value: indexPath.section, to: displayStartDate),
                let weekViewCell = cell as? DTCalendarWeekCell,
                var weekday = calendar.dateComponents([.weekday], from: date).weekday {
                
                if mondayShouldBeTheFirstDayOfTheWeek {
                    weekday = ((weekday + 5) % 7) + 1
                }
                
                if weekday == 1 {
                    weekday = 8
                }
                
                let indexOfLastDayOfWeekInFirstWeek = 6
                
                var displayWeek = indexPath.item - 1
                
                /// If we aren't showing days outside the current month
                /// And the first week was drop we need to shift the display week up by 1
                if !previewDaysInPreviousAndMonth {
                    if indexOfLastDayOfWeekInFirstWeek < weekday - 1 {
                        displayWeek += 1
                    }
                }
                
                weekViewCell.delegate = self
                weekViewCell.selectionStartDate = selectionStartDate
                weekViewCell.selectionEndDate = selectionEndDate
                weekViewCell.displayMonth = date
                weekViewCell.displayWeek = displayWeek
                weekViewCell.previewDaysInPreviousAndMonth = previewDaysInPreviousAndMonth
                weekViewCell.mondayShouldBeTheFirstDayOfTheWeek = mondayShouldBeTheFirstDayOfTheWeek
                
                weekViewCell.disabledDays = delegate?.calendarView(self, disabledDaysInMonth: date)
                
                weekViewCell.updateCalendarLabels(weekDisplayAttributes: weekDisplayAttributes)
            }
            
            return cell
        }
    }
}

extension DTCalendarView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 0
        if indexPath.item == 0 {
            height = delegate?.calendarViewHeightForMonthView(self) ?? 60
        } else if indexPath.item == 1 {
            height = delegate?.calendarViewHeightForWeekdayLabelRow(self) ?? 50
        } else {
            height = delegate?.calendarViewHeightForWeekRows(self) ?? 40
        }
        
        return CGSize(width: collectionView.bounds.size.width, height: height)
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        //  if paginateMonths {
        
        /// If we are paginating months determine the starting sections when scrolling starts
        let targetDivided = CGRect(origin: scrollView.contentOffset, size: scrollView.bounds.size).divided(atDistance: scrollView.bounds.size.height, from: .minYEdge)
        
        if let layoutAttributes = collectionViewFlowLayout.layoutAttributesForElements(in: targetDivided.remainder) {
            if layoutAttributes.count > 0 {
                if let indexPath = collectionView.indexPathForItem(at: layoutAttributes[0].frame.origin) {
                    sectionAtStartOfScrolling = indexPath.section
                }
            }
        }
        // }
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //   if paginateMonths {
        
        var targetSection = sectionAtStartOfScrolling ?? 0
        
        if velocity.y > 0.25 {
            /// If there is significant forward velocity go to next month
            targetSection += 1
        } else if velocity.y < -0.25 {
            /// If there is significant backwards velocity go to previous month
            targetSection -= 1
        } else {
            
            /// If the velocity is low find a region in the center of the visible rect based on the target content offset
            /// And determine which section the cells in that area belong to and use that to determine which month to land on
            let targetRect = CGRect(x: targetContentOffset.pointee.x,
                                    y: targetContentOffset.pointee.y + (scrollView.bounds.size.height) - (scrollView.bounds.size.height),
                                    width: scrollView.bounds.size.width,
                                    height: scrollView.bounds.size.height / 10)
            
            if let layoutAttributes = collectionViewFlowLayout.layoutAttributesForElements(in: targetRect) {
                if layoutAttributes.count > 0 {
                    let layoutAttributeToUse = layoutAttributes[0]
                    
                    if let indexPath = collectionView.indexPathForItem(at: layoutAttributeToUse.frame.origin) {
                        targetSection = indexPath.section
                    }
                }
            }
        }
        
        if let currentSection = sectionAtStartOfScrolling {
            var section = currentSection
            
            /// If paginating only always to go one page at a time
            if currentSection < targetSection {
                section += 1
            } else if currentSection > targetSection {
                section -= 1
            }
            
            if section >= 0 && section < collectionView.numberOfSections {
                if let currentSectionAttributes = collectionView.layoutAttributesForItem(at: IndexPath(item: 0, section: section)) {
                    targetContentOffset.pointee = CGPoint(x: targetContentOffset.pointee.x, y: currentSectionAttributes.frame.origin.y)
                    sectionAtStartOfScrolling = nil
                }
            }
        }
    }
    //   }
}

extension DTCalendarView: UIGestureRecognizerDelegate {
    
    /// This ensures that a selected date (start or end) gets the pan if on it
    /// But the scrollview gets it other wise
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        guard let datePanGR = datePanGR else { return true }
        
        if gestureRecognizer != datePanGR { return true }
        
        let location = touch.location(in: collectionView)
        
        if let dayView = collectionView.hitTest(location, with: nil) as? DTCalendarDayView {
            
            switch dayView.rangeSelection {
            case .endSelection, .startSelection, .endSelectionNoStart, .startSelectionNoEnd:
                return true
            default:
                return false
            }
        }
        
        return false
    }
}

extension DTCalendarView: DTCalendarWeekCellDelegate {
    
    func calendarWeekCell(_ calendarWeekCell: DTCalendarWeekCell, didTapDate date: Date) {
        delegate?.calendarView(self, didSelectDate: date)
    }
}
