//
//  loaderHelper.swift
//  CSSI
//
//  Created by Aks on 16/09/22.
//  Copyright © 2022 yujdesigns. All rights reserved.
//

import Foundation
import Foundation
import UIKit

public class Indicator {

    public static let sharedInstance = Indicator()
    var blurImg = UIImageView()
    var indicator = UIActivityIndicatorView()

    private init()
    {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = UIColor.clear
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.5
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.center = blurImg.center
        indicator.startAnimating()
        indicator.color = .darkGray
    }

    func showIndicator(){
        DispatchQueue.main.async( execute: {

            UIApplication.shared.keyWindow?.addSubview(self.blurImg)
            UIApplication.shared.keyWindow?.addSubview(self.indicator)
        })
    }
    func hideIndicator(){

        DispatchQueue.main.async( execute:
            {
                self.blurImg.removeFromSuperview()
                self.indicator.removeFromSuperview()
        })
    }
}
