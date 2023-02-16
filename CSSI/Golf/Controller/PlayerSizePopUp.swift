//
//  PlayerSizePopUp.swift
//  CSSI
//
//  Created by Aks on 08/02/23.
//  Copyright © 2023 yujdesigns. All rights reserved.
//

import UIKit

class PlayerSizePopUp: UIViewController {
    
    //MARK: - IBActions
    @IBOutlet weak var roundedBgView: UIView!
    @IBOutlet weak var partySizeLbl: UILabel!
    @IBOutlet weak var playerCollectionView: UICollectionView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var DateTimeDinningResrvation: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var collectionCourse: UICollectionView!
    @IBOutlet weak var heightCollection: NSLayoutConstraint!

    
    //MARK: - variables
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let dateFormatter = DateFormatter()
    var delegateSelectedTimePatySize : selectedPartySizeTime?
    var selectedPartySize = -1
    var selectedDate = Date()
//    var arrPartySize = ["1","2","3","4","5","6"]
    var maxPartySize = 0
    var minimumDaysInAdvance = 0
    var maximumDaysInAdvance = 90
    var minimumTimeInAdvance = "05:00 AM"
    var maximumTimeInAdvance = "11:45 PM"
    var size:CGFloat!
    var sizeh:CGFloat!
    var arrCourses = ["test1","test2","test3","test4","test5"]
    var numberForCoursese = 0.0
    var teeTimeSetting : GetGolfSlots?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
        if maxPartySize == 0 {
            maxPartySize = 6
        }
        selectedPartySize = teeTimeSetting?.TeeTimeSettings.DefaultPlayersSize ?? 0
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            let touch = touches.first
            if touch?.view != self.roundedBgView
            { self.dismiss(animated: true, completion: nil) }
        }
    
    //MARK: - setUpUI
    func setUpUi(){
        roundedBgView.clipsToBounds = true
        roundedBgView.layer.cornerRadius = 15
        roundedBgView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        btnDone.layer.cornerRadius = btnDone.frame.height/2
        self.btnDone.diningBtnViewSetup()
        self.btnDone.setTitle("Done", for: UIControlState.normal)
        self.btnDone.setStyle(style: .outlined, type: .primary)
        //heightCollection.constant = 30
        configCourseCollectionHeight()
        setUpUiInitialization()
    }
    func setUpUiInitialization(){
        dateFormatter.dateFormat = "EEE,MMM dd 'T'HH:mm a"
        datePicker.datePickerMode = .dateAndTime
        datePicker.minuteInterval = 15
        
        if #available(iOS 15.0, *) {
            datePicker.roundsToMinuteInterval = true
            

            var minimumDate = Calendar.current.date(byAdding: .day, value: self.minimumDaysInAdvance, to: Date())!
            var maximumDate = Calendar.current.date(byAdding: .day, value: self.maximumDaysInAdvance, to: Date())!

            if minimumDaysInAdvance > 0 {
                minimumDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: minimumDate)!
            }
            maximumDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 0, of: maximumDate)!

            if minimumDate < Date() {
                minimumDate = Date()
            }
            datePicker.minimumDate = minimumDate
            datePicker.maximumDate = maximumDate
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        datePicker.date = selectedDate
    }
    
    @objc func dateSelected(){
    }

    
    //MARK: - IBActions
    @IBAction func doneBtnTapped(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
        
        delegateSelectedTimePatySize?.SelectedPartysizeTme(PartySize: selectedPartySize, Time: datePicker.date)
    }

    func configCourseCollectionHeight(){
        if teeTimeSetting?.TeeTimeSettings.Courses.count == 0{
            heightCollection.constant = 0
        }
        else{
            let NumberOfSlot = ((teeTimeSetting?.TeeTimeSettings.Courses.count ?? 0)/2)+1
            let numberOfLines = NumberOfSlot
            numberForCoursese = Double(numberOfLines)
            heightCollection.constant = CGFloat(25*numberOfLines)
        }
        collectionCourse.reloadData()
    }
}

//MARK: - Collectionview methods
extension PlayerSizePopUp : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionCourse{
            return teeTimeSetting?.TeeTimeSettings.Courses.count ?? 0
        }
        else{
            return teeTimeSetting?.TeeTimeSettings.MaxPlayersSize ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionCourse{
            let cell = collectionCourse.dequeueReusableCell(withReuseIdentifier: "CoursesSelectionCollectionCell", for: indexPath) as! CoursesSelectionCollectionCell
            let dict = teeTimeSetting?.TeeTimeSettings.Courses[indexPath.row]
            cell.lblCouseName.text = dict?.CourseName
            return cell
            
        }
        else{
            let cell = playerCollectionView.dequeueReusableCell(withReuseIdentifier: "PartySizeCollectionCell", for: indexPath) as! PartySizeCollectionCell
            cell.partySizeCountLbl.text = "\(indexPath.row + 1)"
            if selectedPartySize == indexPath.row + 1 {
                cell.partySizeCountLbl.textColor = .white
                cell.partySizeCountLbl.layer.backgroundColor = UIColor(red: 1/255, green: 192/255, blue: 247/255, alpha: 1).cgColor
            } else {
                cell.partySizeCountLbl.textColor = .darkGray
                cell.partySizeCountLbl.layer.backgroundColor = UIColor.white.cgColor
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let dict = arrPartySize[indexPath.row]
        selectedPartySize = indexPath.row + 1
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        if collectionView == collectionCourse{
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
             size = (collectionCourse.frame.size.width - space) / 2.0
             sizeh = (collectionCourse.frame.size.height - space) / numberForCoursese
            return CGSize(width: size, height: sizeh)

        }
        else{
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
             size = (playerCollectionView.frame.size.width - space) / 6.0
             sizeh = (playerCollectionView.frame.size.height)
            return CGSize(width: size, height: sizeh)
        }
    }
}
