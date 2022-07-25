//
//  Event.swift
//  CSSI
//
//  Created by MACMINI13 on 07/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
class Event {
    
    var name: String?
    var team: String?
    var imageUrl: String?
    var bio: String?
    
    init(name: String?, team: String?, bio: String?, imageUrl: String?) {
        self.name = name
        self.team = team
        self.bio = bio
        self.imageUrl = imageUrl
    }
}
