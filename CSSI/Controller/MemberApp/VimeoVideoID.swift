//
//  VimeoVideoID.swift
//  CSSI
//
//  Created by apple on 11/22/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
extension String {
    var videoID: String? {
        let regex = try? NSRegularExpression(pattern: "([0-9]+)", options: [.caseInsensitive])
        
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
}
