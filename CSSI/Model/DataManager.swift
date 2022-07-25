//
//  DataManager.swift
//  CSSI
//
//  Created by Kiran on 11/01/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

//Added by Kiran V2.7 -- GATHER0000700 - A Custom class which is intented to store the data in the app as a replacement of using app delegate
//GATHER0000700 - Start
import Foundation
import ObjectMapper

///Stores the data which is intented to store in a singleton for the use in entire application.
//Note:- Curretnly App delegate is used for this purpose. use this calss for new data and move the data from app delegate to this class when possible.
class DataManager : NSObject
{
    private override init() {
        super.init()
    }
    
    static let shared = DataManager.init()
    
    //Added by kiran V2.8 -- ENGAGE0011688 -- Load language file data
    //ENGAGE0011688 -- Start
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //ENGAGE0011688 -- End
    //Indiates in Book A lesson buttom should be show in tennis screen
    var enableTennisLesson : String?
    
    ///Tennis Book A Lession Add member options.
    var AddRequestOpt_TennisLesson = [BWOption]()
    
    //Added by kiran V2.8 -- ENGAGE0011784 -- added special occasions for addGuestRegVC.
    //ENGAGE0011784 -- Start
    var specialOccasion = [SpecialOccasion]()
    //ENGAGE0011784 -- End
    
    //Added by kiran V2.9 -- GATHER0001167 -- Added Golf BAL reuest button flag and options array
    //GATHER0001167 -- Start
    var enableGolfLession : String?
    var addRequestOpt_GolfLesson = [BWOption]()
    //GATHER0001167 -- End
    
    //Added by kiran V2.8 -- ENGAGE0011688 -- Load language file data
    //ENGAGE0011688 -- Start
    func loadMultiLangData()
    {
        let jsonString = UserDefaults.standard.string(forKey: UserDefaultsKeys.getMultiLingualData.rawValue) ?? ""
        let cultureCode = UserDefaults.standard.string(forKey: UserDefaultsKeys.culturecode.rawValue) ?? ""
        
        if let data = jsonString.data(using: String.Encoding.utf8)
        {
            do {
                let localizeinfoDict =  try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                for dictData in localizeinfoDict!
                {
                   
                    if(dictData.key == cultureCode)
                    {
                        
                        let masterData = Mapper<MainLangauage>().map(JSONObject: dictData.value)!
                        self.appDelegate.masterLabeling = masterData.label!
                        
                        
                        InternetMessge.kNoData = self.appDelegate.masterLabeling.nO_RECORD_FOUND ?? ""
                        InternetMessge.kInternet_not_available = self.appDelegate.masterLabeling.iNTERNET_CONNECTION_ERROR ?? ""
                        Symbol.khash = self.appDelegate.masterLabeling.hASH ?? ""
                        CommonString.kappname = self.appDelegate.masterLabeling.bOCA_WEST ?? ""
                        
                        break;
                    }
                }
                
            } catch _ as NSError
            {
                //print(error)
            }
        }
    }
    //ENGAGE0011688 -- End
    
    
}
//GATHER0000700 - End
