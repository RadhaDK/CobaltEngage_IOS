//
//  FilterNavigationController.swift
//  VBExpand_Tableview
//
//  Created by MACMINI13 on 29/06/18.
//  Copyright © 2018 Crypton. All rights reserved.
//

import UIKit

class FilterNavigationController: UINavigationController , HalfModalPresentable {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isHalfModalMaximized() ? .default : .lightContent
    }
}

