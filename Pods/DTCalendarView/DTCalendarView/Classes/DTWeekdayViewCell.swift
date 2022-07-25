//
//  DTWeekdayViewCell.swift
//  Pods
//
//  Created by Tim Lemaster on 6/16/17.
//
//

import UIKit

class DTWeekdayViewCell: UICollectionViewCell {
    
    private var dayLabels: [UILabel] = [UILabel(frame: .zero),
                                        UILabel(frame: .zero),
                                        UILabel(frame: .zero),
                                        UILabel(frame: .zero),
                                        UILabel(frame: .zero),
                                        UILabel(frame: .zero),
                                        UILabel(frame: .zero)]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    override func layoutSubviews() {
        
        let width = contentView.bounds.width
        let height = contentView.bounds.height
        
        let widthAvailablePerDay = floor((width - 40) / CGFloat(dayLabels.count))
        let leftOverWidth = width - 40 - (widthAvailablePerDay * CGFloat(dayLabels.count))
        let leadingExtra = floor(leftOverWidth / 2)
        
        for (index, dayLabel) in dayLabels.enumerated() {
            
            dayLabel.frame = CGRect(x: 20 + leadingExtra + (CGFloat(index) * widthAvailablePerDay), y: 0, width: widthAvailablePerDay, height: height)
        }
        
        super.layoutSubviews()
    }
    
    private func setupView() {
        
        for dayLabel in dayLabels {
            contentView.addSubview(dayLabel)
        }
    }
    
    func setWeekdayLabels(_ labels: [String]) {
        
        dayLabels[0].text = labels[0]
        dayLabels[1].text = labels[1]
        dayLabels[2].text = labels[2]
        dayLabels[3].text = labels[3]
        dayLabels[4].text = labels[4]
        dayLabels[5].text = labels[5]
        dayLabels[6].text = labels[6]
    }
    
    func setDisplayAttributes(_ displayAttributes: DisplayAttributes) {
        backgroundColor = displayAttributes.backgroundColor
        
        for (index,dayLabel) in dayLabels.enumerated() {
            if index == 0 || index == 6
            {
                dayLabel.textColor = UIColor(red: 0/255.0, green: 198/255.0, blue: 255/255.0, alpha: 1.0)
                
            }
            else{
                dayLabel.textColor = UIColor.black
            }
            dayLabel.textAlignment = displayAttributes.textAlignment
            dayLabel.font = displayAttributes.font
        }
    }
}
