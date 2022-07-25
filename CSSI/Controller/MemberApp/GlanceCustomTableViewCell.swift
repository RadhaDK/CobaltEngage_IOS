//
//  GlanceCustomTableViewCell.swift
//  CSSI
//
//  Created by apple on 11/6/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//
protocol DiningRequestDelegate: AnyObject {
    func checkBoxClicked(cell: GlanceCustomTableViewCell)
    //func synchButtonClicked(cell: CustomDashBoardCell)
}
import UIKit

class GlanceCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imgGlanceImage: UIImageView!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var diningCheckBox: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    weak var delegate: DiningRequestDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.lblTime.layer.shadowColor = UIColor.blue.cgColor
//        self.lblTime.layer.shadowOffset = CGSize.init(width: 0, height: 0)
//        self.lblTime.layer.shadowRadius = 4.0
//        self.lblTime.layer.shadowOpacity = 1.0
//        self.lblTime.layer.masksToBounds = false
        
        if imgGlanceImage == nil{
            
        }else{
            let mainView = UITapGestureRecognizer(target: self, action:  #selector(self.mainViewClicked(sender:)))
            self.imgGlanceImage.addGestureRecognizer(mainView)
        }
        
    }
    
    @objc func mainViewClicked(sender : UITapGestureRecognizer) {
        delegate?.checkBoxClicked(cell: self)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func checkBoxClicked(_ sender: Any) {
        delegate?.checkBoxClicked(cell: self)

    }
}
