//
//  PassManager.swift
//  CSSI
//
//  Created by Kiran on 11/05/21.
//  Copyright © 2021 yujdesigns. All rights reserved.
//

import Foundation
import PassKit

//Added by kiran V2.9 -- ENGAGE0011722 -- Apple wallet functionality
//ENGAGE0011722 -- Start

class PassManager : NSObject
{
    
    static let shared = PassManager.init()
    
    private let passLibrary = PKPassLibrary.init()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private override init()
    {
        super.init()
    }
    
    ///Indicates if a pass can be added to the valled. If not returns the error with value as false
    func canAddPass() -> (value : Bool,error: PassFeatureError?)
    {
        if PKPassLibrary.isPassLibraryAvailable() && PKAddPassesViewController.canAddPasses()
        {
            return (true,nil)
        }
        else
        {
            var error : PassFeatureError!
            
            if !PKPassLibrary.isPassLibraryAvailable()
            {
                error = .libraryNotAvailable
            }
            else if !PKAddPassesViewController.canAddPasses()
            {
                error = .deviceCantAdd
            }
            
            return (false,error)
        }
    }
    
    func containsPass(passTypeIdentifier: String, serialNumber: String) -> Bool
    {
        let pass = self.passLibrary.pass(withPassTypeIdentifier: passTypeIdentifier, serialNumber: serialNumber)
        
        return (pass != nil)
    }
    
    func containsPass(data : Data?) -> Bool
    {
        var error : NSError?
        if let data = data
        {
            let pass = PKPass.init(data: data, error: &error)
            
            //Added by kiran V3.0 -- ENGAGE0011722 -- Logs the pass error to firebase
            //ENGAGE0011722 -- Start
            if let error = error
            {
                CustomFunctions.shared.logError(error: error)
            }
            //ENGAGE0011722 -- End
            
            return self.passLibrary.containsPass(pass)
        }
        
        return false
    }
    
    
    func addPass(data : Data,parentView : UIViewController, failure: @escaping((PassManagerError)->()))
    {
        var error : NSError?
        let pass = PKPass.init(data: data, error: &error)
        if let error = error
        {
            //Added by kiran V3.0 -- ENGAGE0011722 -- Logs the pass error to firebase
            //ENGAGE0011722 -- Start
            CustomFunctions.shared.logError(error: error)
            //ENGAGE0011722 -- End
            print(error)
            failure(.errorGeneratingPass)
        }
        else
        {
            let passViewController = PKAddPassesViewController.init(pass: pass)
            parentView.present(passViewController, animated: true, completion: nil)
        }
       
    }
    
    ///Removes a pass.
    ///
    /// Returns a bool in completin handler indicating if the pass has been removed
    func removePass(data : Data, alertMessage : String, parentView : UIViewController,completion: @escaping ((Bool,PassManagerError?) -> ()))
    {
        var error : NSError?
        let pass = PKPass.init(data: data, error: &error)
        
        if let error = error
        {
            //Added by kiran V3.0 -- ENGAGE0011722 -- Logs the pass error to firebase
            //ENGAGE0011722 -- Start
            CustomFunctions.shared.logError(error: error)
            //ENGAGE0011722 -- End
            completion(false,.errorGeneratingPass)
        }
        else
        {
            self.deletePass(pass: pass, alertMessage: alertMessage, parentView: parentView, completion: completion)
        }
    }
    
    ///Removes a pass.
    ///
    /// Returns a bool in completin handler indicating if the pass has been removed
    func removePass(passTypeIdentifier: String, serialNumber: String, alertMessage : String, parentView : UIViewController,completion: @escaping ((Bool,PassManagerError?) -> ()))
    {
        if let pass = self.passLibrary.pass(withPassTypeIdentifier: passTypeIdentifier, serialNumber: serialNumber)
        {
            self.deletePass(pass: pass, alertMessage: alertMessage, parentView: parentView, completion: completion)
        }
        else
        {
            completion(false,.passDoesntExist)
        }
       
    }
    
    ///Removes a pass.
    ///
    /// Returns a bool in completin handler indicating if the pass has been removed
    private func deletePass(pass : PKPass,alertMessage : String, parentView : UIViewController,completion: @escaping ((Bool,PassManagerError?) -> ()))
    {
        //Note:- Never remove a pass without explicit user action. Its against apple guidelines.
        let okAction = UIAlertAction.init(title: self.appDelegate.masterLabeling.wallet_Remove ?? "", style: .destructive) { _ in
            self.passLibrary.removePass(pass)
            completion(true,nil)
        }
        
        let cancelAction = UIAlertAction.init(title: self.appDelegate.masterLabeling.wallet_Cancel ?? "", style: .cancel) { _ in
            completion(false,.userDenied)
        }
        
        CustomFunctions.shared.showAlert(title: self.appDelegate.masterLabeling.wallet_Alert ?? "", message: alertMessage, on: parentView, actions: [okAction,cancelAction])
    }
    
    ///Replaces passe with new pass by comparing the passTypeIdentifier and serial Number.
    func replacePassWith(pass: Data,alertMessage : String, parentView : UIViewController,completion: @escaping ((Bool,PassManagerError?) -> ()))
    {
        let okAction = UIAlertAction.init(title: self.appDelegate.masterLabeling.wallet_Replace ?? "", style: .destructive) { _ in
            
            var error : NSError?
            let pass = PKPass.init(data: pass, error: &error)
            if let error = error
            {
                //Added by kiran V3.0 -- ENGAGE0011722 -- Logs the pass error to firebase
                //ENGAGE0011722 -- Start
                CustomFunctions.shared.logError(error: error)
                //ENGAGE0011722 -- End
                completion(false, .errorGeneratingPass)
            }
            else
            {
                if self.passLibrary.replacePass(with: pass)
                {
                    completion(true, nil)
                }
                else
                {
                    //Added by kiran V3.0 -- ENGAGE0011722 -- Logs the pass error to firebase
                    //ENGAGE0011722 -- Start
                    let error = NSError.init(domain: "PassManager", code: PassErrorCodes.addingError.rawValue, userInfo: [NSLocalizedDescriptionKey : PassErrorMessage.unableToAdd])
                    CustomFunctions.shared.logError(error: error)
                    //ENGAGE0011722 -- End
                    completion(false, .errorReplacingFile)
                }
                
            }
            
        }
        
        let cancelAction = UIAlertAction.init(title: self.appDelegate.masterLabeling.wallet_Cancel ?? "", style: .cancel) { _ in
            completion(false,.userDenied)
        }
        
        CustomFunctions.shared.showAlert(title: self.appDelegate.masterLabeling.wallet_Alert ?? "", message: alertMessage, on: parentView, actions: [okAction,cancelAction])
    }
    
}
//ENGAGE0011722 -- End
