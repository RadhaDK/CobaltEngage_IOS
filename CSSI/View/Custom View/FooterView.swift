//
//  FooterView.swift
//  CSSI
//
//  Created by MACMINI13 on 14/08/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
import UIKit

class FooterView: UIView {
    
  
    @IBOutlet weak var lblfootertext: UILabel!

    
    
    func updateText(_ text:String?) {
        guard let text = text else { return }
        lblfootertext.text = text
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        lblfootertext.translatesAutoresizingMaskIntoConstraints = false
        lblfootertext.text = Symbol.khash + UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!
        lblfootertext.numberOfLines = 1
        lblfootertext.font = SFont.SourceSansPro_Regular14
        lblfootertext.textColor = APPColor.textheaderColor.header
        lblfootertext.textAlignment = .center
        self.addSubview(lblfootertext)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lblfootertext.frame = bounds
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        //custom logic goes here
    }
}
