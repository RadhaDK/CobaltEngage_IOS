//
//  LeagueFiles.swift
//  CSSI
//
//  Created by apple on 11/20/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import Foundation

struct LeagueFiles: Codable {
    let filePath : String
    
    enum CodingKeys: String, CodingKey {
        case filePath = "FilePath"
    }
}
