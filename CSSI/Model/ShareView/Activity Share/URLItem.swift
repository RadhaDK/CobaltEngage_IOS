//
//  URLItem.swift
//  CSSI
//
//  Created by Kiran on 18/05/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation

class URLItem : NSObject , UIActivityItemSource
{
    
    var url :  NSURL?
    
    init(url : NSURL?) {
        self.url = url
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return self.url ?? NSURL()
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType?) -> Any? {
        return self.url
    }
    
    
}
