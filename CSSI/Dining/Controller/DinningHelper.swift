//
//  Helper.swift
//  CSSI
//
//  Created by Aks on 10/10/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import Foundation
extension UIView{
    func animShow(){
        UIView.animate(withDuration: 1.4, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()

        },  completion: {(_ completed: Bool) -> Void in
        self.isHidden = true
            })
    }
}
//MARK: get parent controller...
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
extension UIButton{
    func buttonUI(button : UIButton){
        button.layer.cornerRadius = button.bounds.size.height / 2
        button.layer.borderWidth = 1.0
        button.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
//        self.btnAdd.setStyle(style: .outlined, type: .primary)
//        btnCancel.layer.cornerRadius = btnCancel.bounds.size.height / 2
//        btnCancel.layer.borderWidth = 1.0
//        btnCancel.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
//        self.btnCancel.setStyle(style: .outlined, type: .primary)
//        txtComment.layer.cornerRadius = 8
//        txtComment.layer.borderColor = UIColor.lightGray.cgColor
//        txtComment.layer.borderWidth = 1
    }
}

extension UIViewController{
    //MARK: - Date Formatter
   
        func getDateString(givenDate: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            return dateFormatter.string(from: givenDate)
        }
        func getTimeString(givenDate: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            return dateFormatter.string(from: givenDate)
        }
        func getTimeStringTable(givenDate: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
            return dateFormatter.string(from: givenDate)
        }
    func getDateFromCustomDelegate(givenDate: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        let showDate = inputFormatter.date(from: givenDate)
        inputFormatter.dateFormat = "MM/dd/yyyy"
        let resultString = inputFormatter.string(from: showDate!)
        print(resultString)
        return resultString
    }
        
        func getDateTableCell(givenDate: Date) -> String {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "E, MMM"
            let resultString = inputFormatter.string(from: givenDate)
            print(resultString)
            return resultString
        }
        
        func getDayOfWeek(givenDate: String) -> String {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd"
            let showDate = inputFormatter.date(from: givenDate)
            inputFormatter.dateFormat = "MMM"
            let resultString = inputFormatter.string(from: showDate!)
            print(resultString)
            return resultString
            
        }
    
    
    
    func getDayWeek(givenDate: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let showDate = inputFormatter.date(from: givenDate)
        inputFormatter.dateFormat = "E"
        let resultString = inputFormatter.string(from: showDate!)
        print(resultString)
        return resultString
        
    }
    
    
    func getDayOfWeek(givenDate: Date) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "E"
        let resultString = inputFormatter.string(from: givenDate)
        print(resultString)
        return resultString
        
    }
    func getDateDinning(givenDate: Date) -> String {
        let inputFormatter = DateFormatter()

        inputFormatter.dateFormat = "MMM dd"
        let resultString = inputFormatter.string(from: givenDate)
        print(resultString)
        return resultString
        
    }
    
    func getDateDinning(givenDate: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let showDate = inputFormatter.date(from: givenDate)
        inputFormatter.dateFormat = "dd"
        let resultString = inputFormatter.string(from: showDate!)
        print(resultString)
        return resultString
        
    }
    
        
        func getmonthOfYear(givenDate: Date) -> String {
            
            return ""
        }
        func changeDateFormate(dateString : String)-> String{
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
            let showDate = inputFormatter.date(from: dateString)
            inputFormatter.dateFormat = "yyyy-MM-dd"
            let resultString = inputFormatter.string(from: showDate!)
            print(resultString)
            return resultString
        }
        func changeTimeFormate(dateString : String)-> String{
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
            let showDate = inputFormatter.date(from: dateString)
            inputFormatter.dateFormat = "hh:mm a E"
            let resultString = inputFormatter.string(from: showDate!)
            print(resultString)
            return resultString
        }
        func getMonthDate(selectedDate : Date)-> String{
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "MMM dd"
            let resultString = inputFormatter.string(from: selectedDate)
            print(resultString)
            return resultString
            
    //        let date = Date()
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "MMM dd"
    //        var dateString = dateFormatter.string(from: dateString)
    //        return dateString
        }
        func getMonthDateFromDate(dateString : Date)-> String{
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd"
            var dateString = dateFormatter.string(from: dateString)
            return dateString
        }
        func changeDateFormateFromDate(dateIs : Date)-> Date{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd hh:mm:ss Z"
            let strDate = dateFormatter.string(from: dateIs)
           // let date = dateFormatter.date(from: strDate)
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "MM/dd/yyyy"
            let showDate = inputFormatter.date(from: "07/21/2016")
            inputFormatter.dateFormat = "yyyy-MM-dd"
            let resultString = inputFormatter.string(from: showDate!)
            print(resultString)
            
            dateFormatter.dateFormat = "DD-MMM-YYYY"
            let goodDate = dateFormatter.date(from: strDate)
            return goodDate!
        }
    func getDateFromDetailAvailability(givenDate: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let showDate = inputFormatter.date(from: givenDate)
        inputFormatter.dateFormat = "EEEE MMM, dd"
        let resultString = inputFormatter.string(from: showDate!)
        print(resultString)
        return resultString
    }
    
    func getDateStringFromDate(givenDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: givenDate)
    }
    
        func convertBase64StringToImage (imageBase64String:String) -> UIImage? {
            if let url = URL(string: imageBase64String), let data = try? Data(contentsOf: url) {
                return UIImage(data: data)!
            }
            return nil
        }
    
    
}
extension Date {

 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss Z"

        return dateFormatter.string(from: Date())

    }
}
extension UIDatePicker {

var textColor: UIColor? {
    set {
        setValue(newValue, forKeyPath: "textColor")
    }
    get {
        return value(forKeyPath: "textColor") as? UIColor
    }
  }
}
