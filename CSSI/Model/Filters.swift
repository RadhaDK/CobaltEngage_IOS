//
//  Filters.swift
//  CSSI
//
//  Created by Kiran on 05/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation


///FIlter Data
///
/// Contains the type of filter ,its dislay nae adn options for that filter type
class Filter : NSObject
{
    var type : FilterType
    var displayName : String
    var options : [FilterOption]
    
    init(type : FilterType , options : [FilterOption],displayName : String)
    {
        self.type = type
        self.options = options
        self.displayName = displayName
    }
}

///Has the filter details which was selected
class SelectedFilter : NSObject
{
    var type : FilterType
    var option : FilterOption
    
    init(type : FilterType , option : FilterOption) {
        self.type = type
        self.option = option
    }
}
