//
//  DownloadStatement.swift
//  CSSI
//
//  Created by apple on 4/3/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import Foundation


import ObjectMapper

class DownloadStatement: NSObject, Mappable {
    
    
    var downloadStatement : [DownloadStatementsDetails]?
    var responseCode : String?
    var responseMessage : String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        downloadStatement <- map["DownloadStatement"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
    }
    
}
class DownloadStatementsDetails: NSObject, Mappable {
    var dSID : Int?
    var month : String?
    var year : String?
    var filePath : String?
    
    
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        dSID <- map["DownloadStatementID"]
        month <- map["Month"]
        year <- map["Year"]
        filePath <- map["FilePath"]
        
        
        
    }
    
}
