

import Foundation
import ObjectMapper

class ProfileUplodSuccessfull :NSObject, Mappable {
	var filePath : String?
	var fromWhere : String?
	var iD : String?
	var image : String?
	var parentID : String?
	var deviceInfo : [DeviceInfo]?
	var memberID : String?

	
    convenience required init?(map: Map) {
        self.init()
    }
    
    func  mapping(map: Map) {

		filePath <- map["FilePath"]
		fromWhere <- map["FromWhere"]
		iD <- map["ID"]
		image <- map["Image"]
		parentID <- map["ParentID"]
		deviceInfo <- map["DeviceInfo"]
		memberID <- map["MemberID"]
	}

}
