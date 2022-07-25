//
//  MessageAndBodyItemShare.swift
//  CSSI
//
//  Created by Kiran on 18/05/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation

//Shares string body content with subject
class BodyStringItem: NSObject,UIActivityItemSource
{
    var strMessage : String?
    
    var subject :  String?
    
    init(body:String, subject : String?) {
        self.strMessage = body
        self.subject = subject
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return self.strMessage ?? ""
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType?) -> Any? {
        return strMessage
    }
        
    ///Note:- Subject may not be set for some mail clients same as gmail because they are not taking the subject from the activity view controller
    /// Reference :- https://stackoverflow.com/questions/34264751/uiactivityviewcontroller-gmail-share-subject-and-body-going-same
    ///  https://stackoverflow.com/questions/17020288/how-to-set-a-mail-subject-in-uiactivityviewcontroller
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivityType?) -> String {
           return self.subject ?? ""
       }
    
}
