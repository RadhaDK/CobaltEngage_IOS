//
//  ListStatementCategories.swift
//  CSSI
//
//  Created by MACMINI13 on 22/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation

class ListStatementCategories: NSObject, Mappable  {
    
    var categoryid: String?
    var categoryname: String?
    var categoryiconurl: String?
    var categoryiconhoverurl: String?
    
  
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        //categoryid <- map["CategoryID"]
        categoryid <- map["ID"] //updated on 27/07/2018 by api
        categoryname <- map["CategoryName"]
        categoryiconurl <- map["CategoryIcon"]
        categoryiconhoverurl <- map["CategoryIconHover"]
        
        
    }
    
}
