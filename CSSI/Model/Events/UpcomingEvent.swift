//
//  UpcomingEvent.swift
//  CSSI
//
//  Created by MACMINI13 on 19/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation


class UpcomingEvent: NSObject, Mappable  {
    
    var eventID : String?
    var eventName : String?
    var eventShortDesc : String?
    var eventDate : String?
    var eventTime : String?
    var eventVenue : String?
    var imageThumb : String?
    var imageLarge : String?

    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        eventID <- map["ID"]
        eventName <- map["EventName"]
        eventShortDesc <- map["EventDesc"]
        eventDate <- map["EventDate"]
        eventTime <- map["EventTime"]
        eventVenue <- map["EventVenue"]
        imageThumb <- map["ImageThumb"]
        imageLarge <- map["ImageLarge"]

        
        
        
    }

}
