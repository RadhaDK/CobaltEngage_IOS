//
//  String.swift
//  CRIF
//
//  Created by Samadhan on 17/05/18.
//  Copyright © 2018 MACMINI11. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var localized: String {
      return NSLocalizedString(self, comment: "")
    }
}
