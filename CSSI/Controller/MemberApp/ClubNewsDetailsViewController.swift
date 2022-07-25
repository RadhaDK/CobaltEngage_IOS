//
//  ClubNewsDetailsViewController.swift
//  CSSI
//
//  Created by apple on 10/31/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import UIKit

class ClubNewsDetailsViewController: UIViewController {

    @IBOutlet weak var imgClubImage: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    var arrClubNewsDetails: ClubNewsDetail? = nil
    var arrRecentNewsDetails: RecentNews? = nil
    var arrRecentNewsCourtDetails: RecentNewsCourt? = nil
    var arrRecentNewsDiningDetails: RecentNewsDining? = nil
    var arrClubDetails = [ClubNews]()
    var isFrom : String?
    var newsDescription : String?
    var imgURl : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        
        if isFrom == "DashBoard"{
            lblDescription.text = arrClubDetails[0].newsDescription
            let placeholder:UIImage = UIImage(named: "avtar")!
            
            //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
            //ENGAGE0011419 -- Start
            let imageURLString = arrClubDetails[0].newsImage ?? ""
            
            if imageURLString.isValidURL()
            {
                let url = URL.init(string:imageURLString)
                self.imgClubImage.sd_setImage(with: url , placeholderImage: placeholder)
            }
            else
            {
                self.imgClubImage.image = UIImage(named: "avtar")!
            }
            /*
            if(imageURLString!.count>0){
                let validUrl = self.verifyUrl(urlString: imageURLString)
                if(validUrl == true){
                    let url = URL.init(string:imageURLString!)
                    self.imgClubImage.sd_setImage(with: url , placeholderImage: placeholder)
                }
            }
            else{
                //   let url = URL.init(string:imageURLString)
                self.imgClubImage.image = UIImage(named: "avtar")!
            }
            */
            //ENGAGE0011419 -- End
        
        }
        else
        {
            lblDescription.text = newsDescription as String?
        
            let placeholder:UIImage = UIImage(named: "avtar")!

            //Modified by kiran V2.5 -- ENGAGE0011419 -- Using string extension instead to verify the url
            //ENGAGE0011419 -- Start
            let imageURLString = imgURl ?? ""
            
            if imageURLString.isValidURL()
            {
                let url = URL.init(string:(imageURLString as String?)!)
                self.imgClubImage.sd_setImage(with: url , placeholderImage: placeholder)
            }
            else
            {
                self.imgClubImage.image = UIImage(named: "avtar")!
            }
            
            /*
            if((imageURLString != nil)){
            let validUrl = self.verifyUrl(urlString: imageURLString as String?)
            if(validUrl == true){
                let url = URL.init(string:(imageURLString as String?)!)
                self.imgClubImage.sd_setImage(with: url , placeholderImage: placeholder)
            }
            }
            else{
                //   let url = URL.init(string:imageURLString)
                self.imgClubImage.image = UIImage(named: "avtar")!
            }
            */
            //ENGAGE0011419 -- End
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

}
