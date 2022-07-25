# DTCalendarView

DTCalendarView is a library to present a vertical scrolling calendar. It supports single value and range selection and dragging of selected dates. The font and color of most items can be styled.

![alt text](calendar.gif "Calendar View in Action")

DTCalendarView is designed to be simple to use yet still powerful by putting your code in charge of what happens when a date is selected.

To use simply add it to a view either in code or in storyboard. The Calendar will fill the view the best it can.

```swift
@IBOutlet private var calendarView: DTCalendarView! {
        didSet {
            calendarView.delegate = self

            calendarView.displayEndDate = Date(timeIntervalSinceNow: 60 * 60 * 24 * 30 * 12 * 2)
            calendarView.previewDaysInPreviousAndMonth = true
            calendarView.paginateMonths = true
        }
    }
```

Implement the delegate to control how the calendar view works for date selection, dragging, etc. The calendar view makes no assumptions on what should happen when a date is tapped. That is it does not automatically select it. This allows you full control over the selection behavior.

```swift
extension ViewController: DTCalendarViewDelegate {

    func calendarView(_ calendarView: DTCalendarView, dragFromDate fromDate: Date, toDate: Date) {

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

        let label = UILabel()
        label.text = monthYearFormatter.string(from: month)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.backgroundColor = UIColor.white

        return label
    }

    func calendarView(_ calendarView: DTCalendarView, didSelectDate date: Date) {
    }

    ...
```

The calendar view UI is also highly customizable. The delegate provides a view for the month header at the top allow that to look however you like. Other parts of the UI are controlled by display attributes. Which is a struct that instruction the view to look a particular way for a given state (similar to UIButton.setTitle(String? for: UIControlState).

```swift
if let font = R.font.textaBold(size: 15) {
  calendarView.weekdayDisplayAttributes = DisplayAttributes(font: font,
                                                            textColor: .white,
                                                            backgroundColor: .clear,
                                                            textAlignment: .center)

  calendarView.setDisplayAttributes(DisplayAttributes(font: font,
                                                      textColor: .white,
                                                      backgroundColor: .clear,
                                                      textAlignment: .center), forState: .normal)

  calendarView.setDisplayAttributes(DisplayAttributes(font: font,
                                                      textColor: UIColor.white.withAlphaComponent(0.5),
                                                      backgroundColor: .clear,
                                                      textAlignment: .center), forState: .preview)

  calendarView.setDisplayAttributes(DisplayAttributes(font: font,
                                                      textColor: R.color.app.primaryAction(),
                                                      backgroundColor: .white,
                                                      textAlignment: .center), forState: .selected)

  calendarView.setDisplayAttributes(DisplayAttributes(font: font,
                                                      textColor: .white,
                                                      backgroundColor: UIColor.white.withAlphaComponent(0.5),
                                                      textAlignment: .center), forState: .highlighted)
  }

```
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* Swift 3
* Xcode 8

## Installation

DTCalendarView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby

pod "DTCalendarView"
```

## Contributions

We welcome pull requests.

## Author

tim@dynamit.com

## License

DTCalendarView is available under the MIT license. See the LICENSE file for more info.
