//
//  DTCalendarDayView.swift
//  Pods
//
//  Created by Tim Lemaster on 6/16/17.
//
//

import UIKit

enum CalendarRangeSelection {
    case startSelection
    case startSelectionNoEnd
    case endSelection
    case endSelectionNoStart
    case inSelection
    case outSelection
}

class DTCalendarDayView: UIView {
    
    var rangeSelection: CalendarRangeSelection = .outSelection
    var dayOfMonth: Int = 1
    var isPreview = false
    var isDisabled = false
    var previewDaysInPreviousAndMonth = true
    
    var representedDate = Date()
    
    var dayAlpha: CGFloat {
        get {
            return dayLabel.alpha
        }
        set {
            dayLabel.alpha = newValue
        }
    }
    
    private let dayLabel = UILabel()
    
    private var selectedLayer = CAShapeLayer()
    
    private var highLightLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    private func setupView() {
        
        layer.addSublayer(highLightLayer)
        layer.addSublayer(selectedLayer)
        
        addSubview(dayLabel)
    }
    
    override func layoutSubviews() {
        
        let width = bounds.width 
        let height = bounds.height
        
        dayLabel.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        selectedLayer.frame = CGRect(x: 0, y:0, width:width, height: height)
        
        let insetFrame = selectedLayer.frame.insetBy(dx: width > height ? (width - height) / 2 : 0, dy: height > width ? (height - width) / 2 : 0)
        selectedLayer.path = CGPath(ellipseIn: insetFrame, transform: nil)
        
        let hightLightFrame = dayLabel.frame.insetBy(dx: 0, dy: height > width ? (height - width) / 2 : 0)
        highLightLayer.frame = hightLightFrame
        
        switch rangeSelection {
        case .startSelection:
            highLightLayer.path = CGPath(rect: CGRect(x: highLightLayer.bounds.midX, y: 0,
                                                      width: highLightLayer.bounds.width / 2, height: highLightLayer.bounds.height), transform: nil)
        case .endSelection:
            highLightLayer.path = CGPath(rect: CGRect(x: 0, y: 0,
                                                      width: highLightLayer.bounds.width / 2, height: highLightLayer.bounds.height), transform: nil)
            
        case .inSelection:
            highLightLayer.path = CGPath(rect: CGRect(x: 0, y: 0,
                                                      width: highLightLayer.bounds.width, height: highLightLayer.bounds.height), transform: nil)
            
        default:
            break
        }
        
        super.layoutSubviews()
    }
    
    func updateView(weekDisplayAttributes: WeekDisplayAttributes) {
        
        backgroundColor = weekDisplayAttributes.normalDisplayAttributes.backgroundColor
        
        if isPreview && !previewDaysInPreviousAndMonth {
            dayLabel.isHidden = true
            selectedLayer.isHidden = true
            highLightLayer.isHidden = true
            return
        }
        
        dayLabel.text = "\(dayOfMonth)"
        dayLabel.isHidden = false
        
        switch rangeSelection {
        case .startSelection:
            selectedLayer.isHidden = false
            highLightLayer.isHidden = false
            dayLabel.font = weekDisplayAttributes.selectedDisplayAttributes.font
            dayLabel.textColor = weekDisplayAttributes.selectedDisplayAttributes.textColor
            dayLabel.textAlignment = weekDisplayAttributes.selectedDisplayAttributes.textAlignment
            selectedLayer.fillColor = weekDisplayAttributes.selectedDisplayAttributes.backgroundColor.cgColor
            highLightLayer.fillColor = weekDisplayAttributes.highlightedDisplayAttributes.backgroundColor.cgColor
            highLightLayer.path =  CGPath(rect: CGRect(x: highLightLayer.bounds.midX, y: 0, width: highLightLayer.bounds.width / 2, height: highLightLayer.bounds.height), transform: nil)
            
        case .startSelectionNoEnd, .endSelectionNoStart:
            selectedLayer.isHidden = false
            highLightLayer.isHidden = true
            dayLabel.font = weekDisplayAttributes.selectedDisplayAttributes.font
            dayLabel.textColor = weekDisplayAttributes.selectedDisplayAttributes.textColor
            dayLabel.textAlignment = weekDisplayAttributes.selectedDisplayAttributes.textAlignment
            selectedLayer.fillColor = weekDisplayAttributes.selectedDisplayAttributes.backgroundColor.cgColor
            highLightLayer.fillColor = weekDisplayAttributes.highlightedDisplayAttributes.backgroundColor.cgColor
            
        case .endSelection:
            selectedLayer.isHidden = false
            highLightLayer.isHidden = false
            dayLabel.font = weekDisplayAttributes.selectedDisplayAttributes.font
            dayLabel.textColor = weekDisplayAttributes.selectedDisplayAttributes.textColor
            dayLabel.textAlignment = weekDisplayAttributes.selectedDisplayAttributes.textAlignment
            selectedLayer.fillColor = weekDisplayAttributes.selectedDisplayAttributes.backgroundColor.cgColor
            highLightLayer.fillColor = weekDisplayAttributes.highlightedDisplayAttributes.backgroundColor.cgColor
            highLightLayer.path =  CGPath(rect: CGRect(x: 0, y: 0, width: highLightLayer.bounds.width / 2, height: highLightLayer.bounds.height), transform: nil)
            
        case .inSelection:
            selectedLayer.isHidden = true
            highLightLayer.isHidden = false
            dayLabel.font = weekDisplayAttributes.highlightedDisplayAttributes.font
            dayLabel.textColor = weekDisplayAttributes.highlightedDisplayAttributes.textColor
            dayLabel.textAlignment = weekDisplayAttributes.highlightedDisplayAttributes.textAlignment
            highLightLayer.fillColor = weekDisplayAttributes.highlightedDisplayAttributes.backgroundColor.cgColor
            highLightLayer.path =  CGPath(rect: CGRect(x: 0, y: 0, width: highLightLayer.bounds.width, height: highLightLayer.bounds.height), transform: nil)
            
        case .outSelection:
            selectedLayer.isHidden = true
            highLightLayer.isHidden = true
            dayLabel.font = weekDisplayAttributes.normalDisplayAttributes.font
            dayLabel.textColor = weekDisplayAttributes.normalDisplayAttributes.textColor
            dayLabel.textAlignment = weekDisplayAttributes.normalDisplayAttributes.textAlignment
        }
        
        if rangeSelection == .outSelection && isDisabled {
            dayLabel.font = weekDisplayAttributes.disabledDisplayAttributes.font
            dayLabel.textColor = weekDisplayAttributes.disabledDisplayAttributes.textColor
            dayLabel.textAlignment = weekDisplayAttributes.disabledDisplayAttributes.textAlignment
            backgroundColor = weekDisplayAttributes.disabledDisplayAttributes.backgroundColor
        }
        
        if rangeSelection == .outSelection && isPreview {
            dayLabel.font = weekDisplayAttributes.previewDisplayAttributes.font
            dayLabel.textColor = weekDisplayAttributes.previewDisplayAttributes.textColor
            dayLabel.textAlignment = weekDisplayAttributes.previewDisplayAttributes.textAlignment
            backgroundColor = weekDisplayAttributes.previewDisplayAttributes.backgroundColor
        }
    }
}
