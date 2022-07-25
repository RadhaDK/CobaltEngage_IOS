//
//  ContentDetails.swift
//  CSSI
//
//  Created by Kiran on 19/05/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation


///Details of the news/event/image which needs to be shared
class ContentDetails : NSObject
{
    var id,date,name,link : String?
    
     init(id : String?,date: String?,name: String?,link: String?)
     {
        self.id = id
        self.date = date
        self.name = name
        self.link = link
    }
    
    
}
