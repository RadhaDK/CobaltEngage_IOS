//
//  ProfileInterest.swift
//  CSSI
//
//  Created by MACMINI13 on 22/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation


class ProfileInterest: NSObject , Mappable {
    var interstID : String?
    var isSlected : String?
    var interest : String?

   
    
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        interstID <- map["interstID"]
        isSlected <- map["isSlected"]
        interest <- map["interest"]

    }
        
}
