//
//  FirstComeFirstServeTableViewCell.swift
//  CSSI
//
//  Created by Kiran on 10/11/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

import UIKit

//Created by kiran V1.5 -- PROD0000202 -- First come first serve change
class FirstComeFirstServeTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var viewCourseDetails: UIView!
    @IBOutlet weak var imageViewCourse: UIImageView!
    @IBOutlet weak var lblCourseName: UILabel!
    @IBOutlet weak var imgCheckBox: UIImageView!
    @IBOutlet weak var btnCourseSelected: UIButton!
    @IBOutlet weak var collectionViewCourseTimes: UICollectionView!
    
    var arrAvailableTimes = [String]()
    var timeSlotsDetails = CourseSettingsDetail()
    var delegate: FCFSCellDelegate?
    
    private var selectedTimeIndex : IndexPath?
    var scheduleType = ""
    var selectedSlots: [[String:Any]] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblCourseName.textColor = APPColor.textColor.whiteText
        self.lblCourseName.font = AppFonts.regular20
        self.btnCourseSelected.setTitle("", for: .normal)
        self.imgCheckBox.image = UIImage(named : "CheckBox_uncheck")
        
        self.collectionViewCourseTimes.delegate = self
        self.collectionViewCourseTimes.dataSource = self
        self.collectionViewCourseTimes.register(UINib.init(nibName: "TimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TimeCollectionViewCell")
        self.collectionViewCourseTimes.register(UINib.init(nibName: "SwitchToLotteryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SwitchToLotteryCollectionViewCell")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.collectionViewCourseTimes.reloadData()
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clouseSelected(_ sender: UIButton)
    {
        sender.isSelected = !sender.isSelected
        self.imgCheckBox.image = UIImage(named: sender.isSelected ? "Group 2130" : "CheckBox_uncheck")
    }

}

extension FirstComeFirstServeTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if scheduleType == "FCFS" {
            let timeString = self.timeSlotsDetails.timeIntervals?[indexPath.row].time ?? ""

            //This is the font given in Interface builder
            let font = UIFont.init(name: "SourceSansPro-Semibold", size: 29.0)
            //5 is the leading and trailing padding given in Interface Builder
            var width = CGFloat()
            if scheduleType == "FCFS" {
                width = 5 + timeString.width(withConstrainedHeight: collectionView.frame.height, font: font!) + 5
            } else {
                width  = 5 + timeString.width(withConstrainedHeight: collectionView.frame.height, font: font!) + 5
            }
            return CGSize.init(width: width, height: collectionView.frame.height)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if scheduleType == "FCFS" {
            if let count = self.timeSlotsDetails.timeIntervals?.count {
                return count
            } else {
                return 1
            }
            
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if scheduleType == "FCFS" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCollectionViewCell", for: indexPath) as! TimeCollectionViewCell
            
            let timeString = self.timeSlotsDetails.timeIntervals?[indexPath.row].time ?? ""
            var colorHex = UIColor.clear
            
            let foundCourse = self.selectedSlots.filter { $0["CourseDetailId"] as! String == self.timeSlotsDetails.id ?? ""}
//            print(foundCourse)
            if foundCourse.count > 0 {
                let foundSlotTime = foundCourse.filter { $0["Time"] as! String == timeString}
                
                if foundSlotTime.count > 0 {
                    for i in foundSlotTime {
                        if self.timeSlotsDetails.timeIntervals?[indexPath.row].teeBox ?? "" == "" {
                            colorHex = APPColor.MainColours.primary2
                        } else {
                            if i["TeeBox"] as! String == self.timeSlotsDetails.timeIntervals?[indexPath.row].teeBox ?? "" {
                                colorHex = APPColor.MainColours.primary2
                            } else {
                                colorHex = hexStringToUIColor(hex: "#818181")
                            }
                        }
                    }
                } else {
                    colorHex = hexStringToUIColor(hex: "#818181")
                }
            } else {
                colorHex = hexStringToUIColor(hex: "#818181")
            }
//            if self.selectedTimeIndex == indexPath
//            {
//                colorHex = APPColor.MainColours.primary2
//            }
//            else
//            {
//                colorHex = hexStringToUIColor(hex: "#818181")
//            }
            
            let time = timeString.date(format: "hh:mm a")
            cell.lblTime.text = time?.toString(format: "hh:mm")
            cell.lblPeriod.text = time?.toString(format: "a")
            cell.lblHoleType.text = self.timeSlotsDetails.timeIntervals?[indexPath.row].teeBox ?? "" 
            
            
            if self.timeSlotsDetails.timeIntervals?[indexPath.row].borderFlag == "1" {
                cell.borderSeperationView.isHidden = false
            } else {
                cell.borderSeperationView.isHidden = true
            }
            
            cell.lblTime.textColor = colorHex
            cell.lblPeriod.textColor = colorHex
            cell.lblHoleType.textColor = colorHex
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SwitchToLotteryCollectionViewCell", for: indexPath) as! SwitchToLotteryCollectionViewCell
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                cell.roundCoronors()
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if scheduleType == "FCFS" {
            let selectedDict = ["AdapterPositin": indexPath.row, "CourseDetailId": self.timeSlotsDetails.id ?? "", "CourseName": self.timeSlotsDetails.courseName!, "DisplayOrder": self.timeSlotsDetails.displayType ?? 0, "G_StartingHole": self.timeSlotsDetails.timeIntervals?[indexPath.row].startingHole ?? "1", "TeeBox": self.timeSlotsDetails.timeIntervals?[indexPath.row].teeBox ?? "","Time": self.timeSlotsDetails.timeIntervals?[indexPath.row].time! ?? ""] as [String : Any]
            
            if let slots = delegate?.timeSlotSelected(slotDetails: selectedDict) {
                self.selectedSlots = slots
                print(slots)
                collectionView.reloadData()
            }
            
        } else {
            delegate?.switchToLotteryClicked()
        }
    }
}

// Written by Zeeshan

protocol FCFSCellDelegate {
    func switchToLotteryClicked()
    func timeSlotSelected(slotDetails: [String:Any]) -> [[String:Any]]!
}
