//
//  BeaconDetails.swift
//  CSSI
//
//  Created by Kiran on 18/11/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation
import ObjectMapper

//Added by kiran V2.5 --ENGAGE0011344 -- Gimbal Integration
class BeaconDetails : NSObject , Mappable
{
    
    var place : String?
    var beaconID : String?
    var SDK : String?
    var beaconSettingID : String?
    var distance : Double?
    
    var fromRSSI : NSInteger?
    var toRSSI : NSInteger?
    var placeDistance : Double?
    var beaconDistance : Double?
               
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        self.place <- map["BeaconPlaceName"]
        self.beaconID <- map["BeaconID"]
        self.SDK <- map["SDKName"]
        self.beaconSettingID <- map["BeaconSettingID"]
        self.distance <- map["Distance"]
        self.fromRSSI <- map["RSSIFrom"]
        self.toRSSI <- map["RSSITo"]
        self.placeDistance <- map["PlaceDistance"]
        self.beaconDistance <- map["BeaconDistance"]
    }
}
