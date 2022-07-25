//
//  CustomDashBoardCell.swift
//  CSSI
//
//  Created by apple on 10/30/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//


protocol RequestCellDelegate: AnyObject {
    func checkBoxClicked(cell: CustomDashBoardCell)
    func diningSpecialRequestCheckBoxClicked(cell: CustomDashBoardCell)
    //func synchButtonClicked(cell: CustomDashBoardCell)
  //  func imgViewClicked(cell: CustomDashBoardCell)

}
import UIKit
import WebKit
class CustomDashBoardCell: UICollectionViewCell {
    
    @IBOutlet weak var lblDisplayname: UILabel!
    @IBOutlet weak var imgImageView: UIImageView!
    @IBOutlet weak var instructionalVideoView: UIView!
    @IBOutlet weak var imgInstructionalVideos: UIImageView!
    @IBOutlet weak var videoWkWebview: WKWebView!
    @IBOutlet weak var lblCourse: UIButton!
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var lblPreferredCourseName: UILabel!
    
    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var instructionalVideo: UIWebView!
    @IBOutlet weak var btnDiningRequest: UIButton!
    @IBOutlet weak var preferImage: UIImageView!
    weak var delegate: RequestCellDelegate?
    @IBOutlet weak var lblMonthName: UILabel!

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viewMain: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        let profilegesture = UITapGestureRecognizer(target: self, action:  #selector(self.profile(sender:)))
//        self.profileView.addGestureRecognizer(profilegesture)
        
        if viewMain == nil{
           
        }else{
            let mainView = UITapGestureRecognizer(target: self, action:  #selector(self.mainViewClicked(sender:)))
            self.viewMain.addGestureRecognizer(mainView)
        }
//        if imgInstructionalVideos == nil{
//            
//        }else{
//        let imgView = UITapGestureRecognizer(target: self, action:  #selector(self.imgggClicked(sender:)))
//        self.imgInstructionalVideos.isUserInteractionEnabled = true
//        self.imgInstructionalVideos.addGestureRecognizer(imgView)
//        }
    }
//    @objc func imgggClicked(sender : UITapGestureRecognizer) {
//        delegate?.imgViewClicked(cell: self)
//
//    }
    @objc func mainViewClicked(sender : UITapGestureRecognizer) {
        delegate?.checkBoxClicked(cell: self)

    }
    
    @IBAction func checkBoxclicked(_ sender: Any) {
        
        delegate?.checkBoxClicked(cell: self)

    }
    @IBAction func diningSpecialRequestClicked(_ sender: Any) {
        delegate?.diningSpecialRequestCheckBoxClicked(cell: self)

    }
    
    
}
