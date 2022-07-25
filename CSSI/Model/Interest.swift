//
//  Interest.swift
//  CSSI
//
//  Created by MACMINI13 on 20/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation

class Interest: NSObject , Mappable {
    var triFee : String?
    var lockerFee : String?
    
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        triFee <- map["Tri Fee"]
        lockerFee <- map["Locker Fee"]
        
        
    }
    
    
}
