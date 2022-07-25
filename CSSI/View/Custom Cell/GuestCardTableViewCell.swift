//
//  GuestCardTableViewCell.swift
//  CSSI
//
//  Created by Prashamsa on 25/09/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class GuestCardTableViewCell: UITableViewCell {

    @IBOutlet weak var imgThreeDots: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet var iconStatus: UILabel!
    @IBOutlet weak  var nameLabel: UILabel!
    @IBOutlet weak  var relationLabel: UILabel!
    @IBOutlet weak  var validityLabel: UILabel!
    @IBOutlet weak  var memberIDLabel: UILabel!
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var checkboxWidthConstraint: NSLayoutConstraint!
    
    var editMode = false {
        didSet {
            if editMode {
                checkboxButton.isHidden = false
                imgThreeDots.isHidden = true
                checkboxWidthConstraint.constant = 40.0
            } else {
                checkboxButton.isHidden = true
                imgThreeDots.isHidden = false
                checkboxWidthConstraint.constant = 20.0
            }
        }
    }
    
    var guest: Guest? {
        didSet {

            if let guest = guest {
                let placeholder:UIImage = UIImage(named: "avtar")!
                self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width / 2
                self.iconImageView.layer.masksToBounds = true
                
                let opacity:CGFloat =  0.4
                let borderColor = UIColor.white
                self.self.iconImageView.layer.borderColor = borderColor.withAlphaComponent(opacity).cgColor
                
                nameLabel.text = guest.memberName
                //Added by kiran V3.0 -- ENGAGE0011843 -- Changed the data type to string.
                //ENGAGE0011843 -- Start
                relationLabel.text = guest.relationName
                //relationLabel.text = guest.relationName.rawValue
                //ENGAGE0011843 -- End
                if guest.fromDate == "" && guest.toDate == "" {
                    validityLabel.text = ""
                }else if guest.fromDate == ""{
                    validityLabel.text = "\(guest.toDate)"
                }else if guest.toDate == ""{
                    validityLabel.text = "\(guest.fromDate)"
                }else{
                validityLabel.text = "\(guest.fromDate) - \(guest.toDate)"
                }
                memberIDLabel.text = guest.guestMemberID
                
                //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
                //ENGAGE0011419 -- Start
                let imageURLString = guest.guestPhoto
                if imageURLString.isValidURL()
                {
                    let url = URL.init(string:imageURLString)
                    self.iconImageView.sd_setImage(with: url , placeholderImage: placeholder)
                }
                else
                {
                    self.iconImageView.image = UIImage(named: "avtar")!
                }
                /*
                if(imageURLString.count>0){
                    let validUrl = self.verifyUrl(urlString: imageURLString)
                    if(validUrl == true){
                        let url = URL.init(string:imageURLString)
                        self.iconImageView.sd_setImage(with: url , placeholderImage: placeholder)
                    }
                }
                else{
                        self.iconImageView.image = UIImage(named: "avtar")!
                    }
                */
                //ENGAGE0011419 -- End
                
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "MM/dd/yyyy"
                    if let fromDate = dateFormater.date(from: guest.fromDate), fromDate <= Date(){
                        iconStatus.layer.cornerRadius = iconStatus.frame.width/2
                        iconStatus.layer.masksToBounds = true
                        iconStatus.backgroundColor = hexStringToUIColor(hex: "40B2E6")

                        iconStatus.isHidden = false
                    }
                    else{
                        validityLabel.textColor = hexStringToUIColor(hex: "3D3D3D")
                        iconStatus.isHidden = true

                    }

            }
            
        }
    }
    
    //Commented by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead
    //ENGAGE0011419 -- Start
//    func verifyUrl(urlString: String?) -> Bool {
//        if let urlString = urlString {
//            if let url = URL(string: urlString) {
//                return UIApplication.shared.canOpenURL(url)
//            }
//        }
//        return false
//    }
    //ENGAGE0011419 -- End
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func checkBoxSelected(_ sender: Any) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if checkboxButton == nil{
            
        }else{
        checkboxButton.isSelected = selected
        }
    }

}

