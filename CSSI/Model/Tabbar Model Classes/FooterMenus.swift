/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

class FooterMenus :  NSObject, Mappable  {
	var menuID : Int?
	var displayName : String?
	var sequence : Int?
	var activity : String?
	var iconLarge : String?
	var iconSmall : String?
	var selectedicon1x : String?
	var selectedicon2x : String?
	var selectedicon3x : String?

    var unselectedicon1x : String?
    var unselectedicon2x : String?
    var unselectedicon3x : String?

    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
	 func mapping(map: Map) {

		menuID <- map["MenuID"]
		displayName <- map["DisplayName"]
		sequence <- map["Sequence"]
		activity <- map["Activity"]
		iconLarge <- map["IconLarge"]
		iconSmall <- map["IconSmall"]
		selectedicon1x <- map["SelectedIcon1x"]
		selectedicon2x <- map["SelectedIcon2x"]
		selectedicon3x <- map["SelectedIcon3x"]
        
        unselectedicon1x <- map["UnselectedIcon1x"]
        unselectedicon2x <- map["UnselectedIcon2x"]
        unselectedicon3x <- map["UnselectedIcon3x"]

        
        
	}

}
