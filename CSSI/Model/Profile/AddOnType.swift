//
//  AddOnType.swift
//  CSSI
//
//  Created by MACMINI13 on 20/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation

class AddOnType: NSObject, Mappable {
    var addOnID : String?
    var addOnKey : String?
    var addOnValue : String?

    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        addOnID <- map["AddOnID"]
        addOnKey <- map["AddOnKey"]
        addOnValue <- map["AddOnValue"]

     
    }
    
    
}

