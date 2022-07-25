//
//  EventCellTableViewCell.swift
//  CSSI
//
//  Created by MACMINI13 on 07/06/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit
//import MaterialCard

import FLAnimatedImage


class EventCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventImage: FLAnimatedImageView!
    //    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventdesc: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var lblEventTime: UILabel!
    @IBOutlet weak var lblEventVenue: UILabel!

    @IBOutlet weak var uiViewLine: UIView!

    //11th September 2020 v2.3 Removed material card POD as xcode no loner supports swift 3 and the liberary was not updated
    @IBOutlet weak var uiView: UIView!//MaterialCard!
//    @IBOutlet weak var uiView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnVisibleIcon: UIButton!
    @IBOutlet weak var btnVisibleIOrNot: UIButton!
    

}
