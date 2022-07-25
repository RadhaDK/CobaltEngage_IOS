//
//  FitnessVideoFilterFooter.swift
//  CSSI
//
//  Created by Kiran on 13/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import Foundation


protocol FitnessVideoFilterFooterDelegate : NSObject  {
    func didSelectOption()
}

class FitnessVideoFilterFooter : UICollectionReusableView
{
    var button : UIButton?
    weak var delegate : FitnessVideoFilterFooterDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.button = UIButton.init(frame: self.bounds)
        self.button?.setImage(UIImage.init(named: "moreDots_darkGray"), for: .normal)
        self.button?.addTarget(self, action: #selector(self.moreOptionsClicked(sender:)), for: .touchUpInside)
        self.addSubview(self.button!)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    @objc func moreOptionsClicked(sender: UIButton)
    {
        self.delegate?.didSelectOption()
    }
    
    
}
