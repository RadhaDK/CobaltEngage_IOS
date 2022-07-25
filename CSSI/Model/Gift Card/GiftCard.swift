//
//  GiftCard.swift
//  CSSI
//
//  Created by MACMINI13 on 03/07/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

class GiftCard: NSObject, Mappable {
    var giftcardList: [GiftCardList]?
    var responseCode: String?
    var responseMessage: String?
    //Added 15th October 2020 V2.3
    var giftCardPdf: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        giftcardList <- map["GiftCards"]
        responseCode <- map["ResponseCode"]
        responseMessage <- map["ResponseMessage"]
        
        self.giftCardPdf <- map["GiftCardPdf"]
    }
}

class GiftCardList: NSObject, Mappable  {
    
    var giftCertificateID: String?
    var parentID: String?

    var giftCardID: Int?
    var giftCardCategory: String?
    var giftCardCategoryIcon: String?
    var certificateNo: Int?
     var issuedDate: String?
    var expireDate: String?
    var originalPrice: Double?
    var balanceAmount: Float?
    
    //Added by kiran V2.9 -- ENGAGE0011597 -- Adding 2 fields for description and count.
    //ENGAGE0011597 -- Start
    var seriesDescription : String?
    var seriesCount : String?
    var status : String?
    //ENGAGE0011597 -- End

    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        giftCertificateID <- map["GiftCertificateID"]
        parentID <- map["ParentID"]

        giftCardID <- map["GiftCardID"]
        giftCardCategory <- map["GiftCardCategory"]
        giftCardCategoryIcon <- map["GiftCardCategoryIcon"]
        certificateNo <- map["CertificateNo"]
        issuedDate <- map["IssuedDate"]
        expireDate <- map["ExpireDate"]
        originalPrice <- map["OriginalPrice"]
        balanceAmount <- map["BalanceAmount"]

        //Added by kiran V2.9 -- ENGAGE0011597 -- Adding 2 fields for description and count.
        //ENGAGE0011597 -- Start
        self.seriesDescription <- map["SeriesDescription"]
        self.seriesCount <- map["SeriesCount"]
        self.status <- map["Status"]
        //ENGAGE0011597 -- End
        
    }
    
}


