//
//  DatabaseHandler.swift
//  CSSI
//
//  Created by MACMINI13 on 07/08/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

import Foundation
//
//  DataBaseHandlar.swift
//  CRIF
//
//  Created by Samadhan on 23/07/18.
//  Copyright © 2018 MACMINI11. All rights reserved.
//

import UIKit
import ObjectMapper
import SQLite

infix operator <-


class DataBaseHandlar {
    let tblLocalization = Table("tblLocalization")
    
    static let sharedInstance = DataBaseHandlar()
    private let db: Connection?
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        do {
            db = try Connection("\(path)/LocalizationDB.sqlite3")
            print("path:\(path)")
            createTableLocalization()
            
        } catch {
            db = nil
            print ("Unable to open database")
        }
        print("path:\(path)")
    }
    
    
    
    
    let id = Expression<Int64>("id")
    let jsonString = Expression<String?>("jsonString")
    let version = Expression<String>("version")

    
    
    //MARK:- Create Tables
    // --------------------------- Create Tasbels --------------------------//
    
    
    
    func createTableLocalization() {
        do {
            try db!.run(self.tblLocalization.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(jsonString)
                table.column(version)
            })
        } catch {
            print("Unable to create table")
        }
    }
    
    
    
    
    //MARK:- Inserted & retrived Product Dashbaord data
    // --------------------------- Product Dashbaord --------------------------//
    func addLocalizationValues(dJsonString: String, dVersion: String) -> Int64? {
        do {
            let insert = self.tblLocalization.insert(self.jsonString <- dJsonString, self.version <- dVersion)
            let id = try db!.run(insert)
            return id
        } catch {
            print("Insert failed")
            return nil
        }
    }
    
    func getLocalizationValues() -> String {
        var jsonString = String()
        do {
            for contact in try db!.prepare(self.tblLocalization) {
                jsonString = try contact.get(self.jsonString)!
                break;
            }
        }
        catch {
            print("Select failed")
        }
        return jsonString
    }
    
}


