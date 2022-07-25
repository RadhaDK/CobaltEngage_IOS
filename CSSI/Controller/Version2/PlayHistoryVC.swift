
//
//  PlayHistoryVC.swift
//  CSSI
//
//  Created by apple on 4/17/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit

class PlayHistoryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tablePlayHistory: UITableView!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrPlayHistory = [PlayHistoryList]()
    
    //Added on 30th June 2020 BMS
    var arrAppointmentHistory = [AppointMentHistoryDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Modified on 30th June 2020 BMS
        if self.appDelegate.typeOfCalendar == "FitnessSpa"
        {
            self.getFitnessHistory(strSearch : self.appDelegate.golfEventsSearchText)
        }
        else
        {
            self.playHistoryapi(strSearch: self.appDelegate.golfEventsSearchText)
        }
        
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.notificationRecevied(notification:)) , name:Notification.Name("eventsData") , object: nil)


    }
//    override func viewWillAppear(_ animated: Bool) {
//        self.tablePlayHistory.reloadData()
//    }
    
    @objc func notificationRecevied(notification: Notification) {
        let strSearchText = notification.userInfo?["searchText"] ?? ""
        
        
        //Modified on 30th June 2020 BMS
        if self.appDelegate.typeOfCalendar == "FitnessSpa"
        {
            self.getFitnessHistory(strSearch : strSearchText as? String)
            
        }
        else
        {
            self.playHistoryapi(strSearch: strSearchText as? String)
            
        }

    }
    
    //Mark- Get Play History Api

    func playHistoryapi(strSearch :String?, filter: GuestCardFilter? = nil) {



        if (Network.reachability?.isReachable) == true{
            
            

            self.appDelegate.showIndicator(withTitle: "", intoView: self.view)

            let paramaterDict:[String: Any] = [
                "Content-Type":"application/json",
                APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
                APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                APIKeys.ksearchby: strSearch ?? "",
                APIKeys.kCategory: self.appDelegate.typeOfCalendar,
                "IsAdmin": "1",

                APIKeys.kdeviceInfo: [APIHandler.devicedict]

            ]
            print(paramaterDict)
            APIHandler.sharedInstance.getGolfPlayHistory(paramaterDict: paramaterDict, onSuccess: { playHistoryList in
                self.appDelegate.hideIndicator()

                if(playHistoryList.responseCode == InternetMessge.kSuccess)
                {
                    if(playHistoryList.playHistory == nil){
                        self.arrPlayHistory.removeAll()
//                        self.tablePlayHistory.setEmptyMessage(InternetMessge.kNoData)
                        self.tablePlayHistory.reloadData()
                        self.appDelegate.hideIndicator()
                    }
                    else{

                        if(playHistoryList.playHistory?.count == 0)
                        {
                            self.arrPlayHistory.removeAll()
                            self.tablePlayHistory.setEmptyMessage(InternetMessge.kNoData)
                            self.tablePlayHistory.reloadData()


                            self.appDelegate.hideIndicator()

                        }else{
                            self.arrPlayHistory = playHistoryList.playHistory!  //playHistoryList.listevents!
                            self.tablePlayHistory.reloadData()
                        }

                    }

                    if(!(self.arrPlayHistory.count == 0)){
                      //  let indexPath = IndexPath(row: 0, section: 0)
                       // self.tablePlayHistory.scrollToRow(at: indexPath, at: .top, animated: true)
                    }

                }
                else{
                    self.appDelegate.hideIndicator()
                    if(((playHistoryList.responseMessage?.count) ?? 0)>0){
                        SharedUtlity.sharedHelper().showToast(on:
                            self.view, withMeassge: playHistoryList.responseMessage, withDuration: Duration.kMediumDuration)
                    }
//                    self.tablePlayHistory.setEmptyMessage(playHistoryList.responseMessage ?? "")

                }

                self.appDelegate.hideIndicator()

            },onFailure: { error  in

                self.appDelegate.hideIndicator()
                print(error)
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
            })


        }else{

            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            //  self.tableViewHeroes.setEmptyMessage(InternetMessge.kInternet_not_available)

        }

    }
    
    
    //Added on 30th June 2020 BMS
       private func getFitnessHistory(strSearch : String?)
       {
           guard (Network.reachability?.isReachable) == true else{
               SharedUtlity.sharedHelper().showToast(on:
               self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
               return
           }
           
           self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
           let paramaterDict:[String: Any] = [
               "Content-Type":"application/json",
               APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
               APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
               APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
               APIKeys.ksearchby: strSearch ?? "",
               APIKeys.kdeviceInfo: [APIHandler.devicedict]
           ]
           
           APIHandler.sharedInstance.getAppointmentHistory(paramaterDict: paramaterDict, onSuccess: { playHistoryList in
               self.appDelegate.hideIndicator()

               if(playHistoryList.responseCode == InternetMessge.kSuccess)
               {
                   if(playHistoryList.AppointmentHistoryDetails == nil){
                       self.arrAppointmentHistory.removeAll()
                       self.tablePlayHistory.reloadData()
                       self.appDelegate.hideIndicator()
                   }
                   else{

                       if(playHistoryList.AppointmentHistoryDetails?.count == 0)
                       {
                           self.arrAppointmentHistory.removeAll()
                           self.tablePlayHistory.setEmptyMessage(InternetMessge.kNoData)
                           self.tablePlayHistory.reloadData()


                           self.appDelegate.hideIndicator()

                       }else{
                           self.arrAppointmentHistory = playHistoryList.AppointmentHistoryDetails!
                           self.tablePlayHistory.reloadData()
                       }

                   }


               }
               else{
                   self.appDelegate.hideIndicator()
                   if(((playHistoryList.responseMessage?.count) ?? 0)>0){
                       SharedUtlity.sharedHelper().showToast(on:
                           self.view, withMeassge: playHistoryList.responseMessage, withDuration: Duration.kMediumDuration)
                   }

               }

               self.appDelegate.hideIndicator()

           },onFailure: { error  in

               self.appDelegate.hideIndicator()
               SharedUtlity.sharedHelper().showToast(on:
                   self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
           })

       }
    
    
    //Modified in 30th June 2020 BMS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.appDelegate.typeOfCalendar == "FitnessSpa" ? self.arrAppointmentHistory.count : self.arrPlayHistory.count
    }
    
    //Modified in 30th June 2020 BMS
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:PlayHistoryCustomCell = self.tablePlayHistory.dequeueReusableCell(withIdentifier: "PlayHistoryCell") as! PlayHistoryCustomCell
        
        
        let title = self.appDelegate.typeOfCalendar == "FitnessSpa" ? self.arrAppointmentHistory[indexPath.row].serviceDuration : self.arrPlayHistory[indexPath.row].coursename!
        cell.lblTitle.text = String(format: "%@",title!)
        
        let date = self.appDelegate.typeOfCalendar == "FitnessSpa" ? self.arrAppointmentHistory[indexPath.row].appDateTime : self.arrPlayHistory[indexPath.row].date
        cell.lbldateAndtime.text = date
        
        let confirmationNumber = self.appDelegate.typeOfCalendar == "FitnessSpa" ? self.arrAppointmentHistory[indexPath.row].confirmationNumber : self.arrPlayHistory[indexPath.row].confirmNumber
        cell.lblID.text = confirmationNumber


        cell.viewBackground.layer.shadowColor = UIColor.black.cgColor
        cell.viewBackground.layer.shadowOpacity = 0.16
        cell.viewBackground.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.viewBackground.layer.shadowRadius = 4
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(self.appDelegate.typeOfCalendar == "Tennis")
        {
            //Modified by Kiran V2.7 -- GATHER0000700 - Book a lesson changes. Added support for tennis book a lesson history details.
            //GATHER0000700 - Start
            let selectedRecord = self.arrPlayHistory[indexPath.row]
            
            switch selectedRecord.playHistoryType
            {
            case .reservation:
                if let historyDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "TennisHistoryDetailsVC") as? TennisHistoryDetailsVC
                {
                    historyDetails.modalTransitionStyle   = .crossDissolve;
                    historyDetails.modalPresentationStyle = .overCurrentContext
                    historyDetails.confirmedReservationID = self.arrPlayHistory[indexPath.row].confirmedReservationID
                    historyDetails.confirmationNumber = self.arrPlayHistory[indexPath.row].confirmNumber
                    self.present(historyDetails, animated: true, completion: nil)
                }
            case .bookALesson:
                self.getBookALessonDetails(department: BMSDepartment.tennisBookALesson.rawValue, appointmentID: selectedRecord.confirmedReservationID) { [weak self] (lessonDetails) in
                    
                    if let lessonDetails = lessonDetails
                    {
                        let historyDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AppointemntHistoryDetailsVC") as! AppointemntHistoryDetailsVC
                        historyDetails.appointmentHistory = lessonDetails
                        //Added by kiran V2.8 -- GATHER0001149
                        //GATHER0001149 -- Start
                        historyDetails.BMSDepartment = .tennisBookALesson
                        //GATHER0001149 -- ENd
                        historyDetails.modalTransitionStyle = .crossDissolve
                        historyDetails.modalPresentationStyle = .overCurrentContext
                        self?.present(historyDetails, animated: true, completion: nil)
                    }
                }
            default:
                break
            }
            //GATHER0000700 - End
        }
        else if(self.appDelegate.typeOfCalendar == "Dining"){
            
            if let historyDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "DiningPlayHistoryDetailVC") as? DiningPlayHistoryDetailVC {
                historyDetails.modalTransitionStyle   = .crossDissolve;
                historyDetails.modalPresentationStyle = .overCurrentContext
                historyDetails.confirmedReservationID = self.arrPlayHistory[indexPath.row].confirmedReservationID
                historyDetails.confirmationNumber = self.arrPlayHistory[indexPath.row].confirmNumber

                self.present(historyDetails, animated: true, completion: nil)
            }
        
        }//Added on 30th June 2020 BMS
        else if self.appDelegate.typeOfCalendar == "FitnessSpa"
        {
            let historyDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AppointemntHistoryDetailsVC") as! AppointemntHistoryDetailsVC
            historyDetails.appointmentHistory = self.arrAppointmentHistory[indexPath.row]
            //Added by kiran V2.8 -- GATHER0001149
            //GATHER0001149 -- Start
            historyDetails.BMSDepartment = .fitnessAndSpa
            historyDetails.DepartmentName = self.arrAppointmentHistory[indexPath.row].departmentName
            //GATHER0001149 -- End
            historyDetails.modalTransitionStyle = .crossDissolve
            historyDetails.modalPresentationStyle = .overCurrentContext
            self.present(historyDetails, animated: true, completion: nil)
        }
        else
        {
            //Added by kiran V2.9 -- GATHER0001167 -- Added support Golf BAL
            //GATHER0001167 -- Start
            
            let selectedDetails = self.arrPlayHistory[indexPath.row]
            
            switch selectedDetails.playHistoryType
            {
            case .reservation:
                if let historyDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "PlayHistoryDetailVC") as? PlayHistoryDetailVC
                {
                    historyDetails.modalTransitionStyle   = .crossDissolve;
                    historyDetails.modalPresentationStyle = .overCurrentContext
                    historyDetails.confirmedReservationID = selectedDetails.confirmedReservationID
                    self.present(historyDetails, animated: true, completion: nil)
                }
            case .bookALesson:
                self.getBookALessonDetails(department: BMSDepartment.golfBookALesson.rawValue, appointmentID: selectedDetails.confirmedReservationID) { [weak self] (lessonDetails) in
                    
                    if let lessonDetails = lessonDetails
                    {
                        let historyDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "AppointemntHistoryDetailsVC") as! AppointemntHistoryDetailsVC
                        historyDetails.appointmentHistory = lessonDetails
                        //Added by kiran V2.8 -- GATHER0001149
                        //GATHER0001149 -- Start
                        historyDetails.BMSDepartment = .golfBookALesson
                        //GATHER0001149 -- ENd
                        historyDetails.modalTransitionStyle = .crossDissolve
                        historyDetails.modalPresentationStyle = .overCurrentContext
                        self?.present(historyDetails, animated: true, completion: nil)
                    }
                }
            default:
                break
            }
            //Old Logic
            /*
            if let historyDetails = UIStoryboard.init(name: "MemberApp", bundle: .main).instantiateViewController(withIdentifier: "PlayHistoryDetailVC") as? PlayHistoryDetailVC {
                historyDetails.modalTransitionStyle   = .crossDissolve;
                historyDetails.modalPresentationStyle = .overCurrentContext
                historyDetails.confirmedReservationID = self.arrPlayHistory[indexPath.row].confirmedReservationID
                self.present(historyDetails, animated: true, completion: nil)
            }
             */
            //GATHER0001167 -- End
        }

    }
}

//Added by Kiran V2.7 -- GATHER0000700 - Book a lesson changes.
//GATHER0000700 - Start
//MARK:- APi's
extension PlayHistoryVC
{
    //Note:- If department is not provided then its assumed as fitness and spa as the same api is used for fitness and spa history listing.
    private func getBookALessonDetails(department : String,appointmentID : String?, completionHandler : @escaping((AppointMentHistoryDetails?) -> ()))
    {
        guard (Network.reachability?.isReachable) == true else{
            SharedUtlity.sharedHelper().showToast(on:
            self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            return
        }
        
        self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
        
        let paramaterDict:[String: Any] = [
            "Content-Type":"application/json",
            APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue)!,
            APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
            APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
            APIKeys.ksearchby: "",
            APIKeys.kdeviceInfo: [APIHandler.devicedict],
            APIKeys.kDepartment : department,
            APIKeys.kAppointmentDetailID : appointmentID ?? ""
        ]
        
        APIHandler.sharedInstance.getAppointmentHistory(paramaterDict: paramaterDict, onSuccess: { playHistoryList in

            if(playHistoryList.responseCode == InternetMessge.kSuccess)
            {
                self.appDelegate.hideIndicator()
                completionHandler(playHistoryList.AppointmentHistoryDetails?.first)
            }
            else
            {
                self.appDelegate.hideIndicator()
                if(((playHistoryList.responseMessage?.count) ?? 0)>0)
                {
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: playHistoryList.responseMessage, withDuration: Duration.kMediumDuration)
                }

            }

        },onFailure: { error  in

            self.appDelegate.hideIndicator()
            SharedUtlity.sharedHelper().showToast(on:
                self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
        })

    }
}
//GATHER0000700 - End
