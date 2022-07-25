//
//  RRTagController.swift
//  RRTagController
//
//  Created by Remi Robert on 20/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

struct Tag {
    var isSelected: Bool
    var isLocked: Bool
    var textContent: String
}

let colorUnselectedTag = UIColor.white
let colorSelectedTag = UIColor(red:0.22, green:0.7, blue:0.99, alpha:1)

let colorTextUnSelectedTag = UIColor(red:0.33, green:0.33, blue:0.35, alpha:1)
let colorTextSelectedTag = UIColor.white

class RRTagController: UIViewController {


    
    class func displayTagController(parentController: UIViewController, tagsString: [String]?,
                                                                         blockFinish: @escaping (_ selectedTags: Array<Tag>, _ unSelectedTags: Array<Tag>)->(), blockCancel: @escaping ()->()) {
        let tagController = RRTagController()
            tagController.tags = Array()
            if tagsString != nil {
                for currentTag in tagsString! {
                    tagController.tags.append(Tag(isSelected: false, isLocked: false, textContent: currentTag))
                }
            }
            tagController.blockCancel = blockCancel
            tagController.blockFinih = blockFinish
        tagController.present(tagController, animated: true, completion: nil)
    }

    class func displayTagController(parentController: UIViewController, tags: [Tag]?,
                                                                         blockFinish: @escaping (_ selectedTags: Array<Tag>, _ unSelectedTags: Array<Tag>)->(), blockCancel: @escaping ()->()) {
            let tagController = RRTagController()
            tagController.tags = tags
            tagController.blockCancel = blockCancel
            tagController.blockFinih = blockFinish
        tagController.present(tagController, animated: true, completion: nil)
    }
    
}
