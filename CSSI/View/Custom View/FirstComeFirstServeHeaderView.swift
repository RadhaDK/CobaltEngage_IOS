//
//  FirstComeFirstServeHeaderView.swift
//  CSSI
//
//  Created by Kiran on 10/11/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

import UIKit

//Created by kiran V1.5 -- PROD0000202 -- First come first serve change
class FirstComeFirstServeHeaderView: UIView
{
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var viewCourses: UIView!
    @IBOutlet weak var lblCourses: UILabel!
    
    @IBOutlet weak var viewAvailableTimes: UIView!
    @IBOutlet weak var lblAvailableTimes: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUpView()
    }

    private func setUpView()
    {
        Bundle.main.loadNibNamed("FirstComeFirstServeHeaderView", owner: self, options: [:])
        self.contentView.frame = self.bounds
        
        self.contentView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        self.addSubview(self.contentView)
        self.initialSetup()
    }
}

extension FirstComeFirstServeHeaderView
{
    private func initialSetup()
    {
        self.lblCourses.font = AppFonts.regular18
        self.lblCourses.textColor = APPColor.textColor.whiteText
        self.lblAvailableTimes.font = AppFonts.regular18
        self.lblAvailableTimes.textColor = APPColor.textColor.whiteText
        
        self.contentView.backgroundColor = APPColor.viewBackgroundColor.preferenceTimeColor
    }
}
