//
//  PickerDateFormate.swift
//  CSSI
//
//  Created by apple on 7/12/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

extension UIDatePicker {
    
    func setDate(from string: String, format: String, animated: Bool = true) {
        
        let formater = DateFormatter()
        
        formater.dateFormat = format
        
        let date = formater.date(from: string) ?? Date()
        
        setDate(date, animated: animated)
    }
}
