//
//  AddGroupVC.swift
//  CSSI
//
//  Created by apple on 4/23/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit
import Photos
import FLAnimatedImage
import Alamofire
import AlamofireImage
import Popover
import PINRemoteImage
import IQKeyboardManagerSwift

class AddGroupVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var lblAddNewGroup: UILabel!
    @IBOutlet weak var lblImage: UILabel!
    @IBOutlet weak var txtGroupName: UITextField!
    @IBOutlet weak var viewUploadImage: UIView!
    @IBOutlet weak var btnSave: UIButton!


    fileprivate var grouopImagePicker: UIImagePickerController = UIImagePickerController()
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var imagePicker = UIImagePickerController()
    var myGroupID : String?
    var photoString : String?
    var isFlag: Int?
    var imageName: String?
    var groupName: String?
    var imgURL: String?
    @IBOutlet weak var groupPhoto: UIImageView!
    @IBOutlet weak var groupImage: UIImageView!

    //MARK:- Imagepicker controller delegate methods
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerEditedImage] as? UIImage
        self.groupImage.image = originalImage
        self.lblImage.text = "IMG_5122.PNG"
        if let imageURL = info[UIImagePickerControllerReferenceURL] as? URL {
            let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
            if let asset = info[UIImagePickerControllerPHAsset] as? PHAsset {
            let assetResources = PHAssetResource.assetResources(for: asset)
               self.groupImage.image = originalImage
            
            self.lblImage.text = assetResources.first!.originalFilename
            
            }
        }

        
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let groupPh = UITapGestureRecognizer(target: self, action: #selector(onTapGroupPhoto))
        viewUploadImage.addGestureRecognizer(groupPh)
        
        viewUploadImage.layer.cornerRadius = 6
        viewUploadImage.layer.borderWidth = 1
        viewUploadImage.layer.borderColor = hexStringToUIColor(hex: "dedede").cgColor
        viewUploadImage.layer.masksToBounds = true
        
        groupPhoto.setNeedsDisplay()
        
        btnSave.layer.cornerRadius = 18
        btnSave.layer.borderWidth = 1
        btnSave.layer.borderColor = hexStringToUIColor(hex: "F47D4C").cgColor
        btnSave.layer.masksToBounds = true
        
        txtGroupName.layer.cornerRadius = 6
        txtGroupName.layer.borderWidth = 1
        txtGroupName.layer.borderColor = hexStringToUIColor(hex: "dedede").cgColor
        txtGroupName.layer.masksToBounds = true
        isFlag = 0
        
        if(self.appDelegate.groupType == "Add"){
             lblAddNewGroup.text = "Add New Group"
        }
        else{
            lblAddNewGroup.text = self.appDelegate.masterLabeling.eDIT
            txtGroupName.text = self.groupName
            lblImage.text = imageName
        }
        
        self.btnSave.setStyle(style: .outlined, type: .primary)
        
    }
    

    func openGallary(type: PhotoTyoe )
    {
        grouopImagePicker.view.tag = type.rawValue
        grouopImagePicker.sourceType = .photoLibrary
        grouopImagePicker.allowsEditing = true
        grouopImagePicker.videoQuality = .typeLow
        self.present(grouopImagePicker, animated: true, completion: nil)
    }
    
    fileprivate func base64EncodedString(image: UIImage?) -> String {
        guard let image = image,
            let imageData = UIImagePNGRepresentation(image) else {
                return ""
        }
        let str = imageData.base64EncodedString(options: .endLineWithCarriageReturn)
        
        return "data:image/png;base64," + str
        
    }
    @IBAction func closeClicked(_ sender: Any) {
        self.appDelegate.groupType = ""
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveClicked(_ sender: Any) {
        
            if (Network.reachability?.isReachable) == true{
                
                self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
                let photoID = groupImage.image

                if self.appDelegate.groupType == "Add" {
                    photoString = base64EncodedString(image: photoID)
                }
                else if self.appDelegate.groupType == "Edit"{
                    photoString = base64EncodedString(image: photoID)
                    if photoString == "" {
                        photoString =  ""
                        isFlag = 0
                    }else{
                       isFlag = 1
                    }
                }
                
                let paramaterDict:[String: Any] = [
                    "Content-Type":"application/json",
                    APIKeys.kMemberId : UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) ?? "",
                    APIKeys.kid: UserDefaults.standard.string(forKey: UserDefaultsKeys.id.rawValue)!,
                    APIKeys.kParentId: UserDefaults.standard.string(forKey: UserDefaultsKeys.parentID.rawValue)!,
                    APIKeys.kdeviceInfo: [APIHandler.devicedict],
                    "MyGroupID": myGroupID ?? "",
                    "GroupName": self.txtGroupName.text ?? "",
                    "Image": photoString ?? "",
                    "UserName": UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue) ?? "",
                    "IsAdmin": UserDefaults.standard.string(forKey: UserDefaultsKeys.isAdmin.rawValue) ?? "",
                    "ImageFlag": isFlag ?? 0
                ]
                print(paramaterDict)
                self.appDelegate.showIndicator(withTitle: "", intoView: self.view)
                
                APIHandler.sharedInstance.saveMyGroup(paramater: paramaterDict , onSuccess: { response in
                    self.appDelegate.hideIndicator()
                    if(response.responseCode == InternetMessge.kSuccess){
                        self.appDelegate.hideIndicator()
                        
                       
                        NotificationCenter.default.post(name: NSNotification.Name("groupData"), object: nil, userInfo:nil )
                        self.dismiss(animated: true, completion: nil)

                    }
                },onFailure: { error  in
                    self.appDelegate.hideIndicator()
                    print(error)
                    SharedUtlity.sharedHelper().showToast(on:
                        self.view, withMeassge: error.localizedDescription, withDuration: Duration.kMediumDuration)
                })
                
            }else{
                
                SharedUtlity.sharedHelper().showToast(on:
                    self.view, withMeassge: InternetMessge.kInternet_not_available, withDuration: Duration.kMediumDuration)
            }
        }
    @objc func bextButtonPressedfromOtherViewController(notification: NSNotification){
        
        
        
    }
    
    @objc func onTapGroupPhoto(tapGestureRecognizer: UITapGestureRecognizer) {
        
        //changed by kiran V1.3 -- changed boca west name to Cobalt Engage
        let alertController = UIAlertController(title:
            "Cobalt Engage", message: "Wants to use your", preferredStyle: .actionSheet)
        let actionCamera = UIAlertAction(title: self.appDelegate.masterLabeling.cAMERA, style: .default, handler: { (action:UIAlertAction) in
            self.imagePicker = UIImagePickerController()
            self.imagePicker.allowsEditing  = true
            self.imagePicker.sourceType = .camera
            self.imagePicker.delegate = self

            self.imagePicker.modalPresentationStyle = .overCurrentContext
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        let actionPhoto = UIAlertAction(title: self.appDelegate.masterLabeling.gALLERY, style: .default) { (action:UIAlertAction) in
            self.imagePicker = UIImagePickerController()
            self.imagePicker.allowsEditing  = true
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            self.imagePicker.modalPresentationStyle = .overCurrentContext
            
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: self.appDelegate.masterLabeling.cANCEL, style: .cancel) { (action:UIAlertAction) in
            //            self.dismiss(animated: true, completion: nil)
            self.imagePicker.parent?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(actionCamera)
        alertController.addAction(actionPhoto)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
        //        imagePicker.parent?.dismiss(animated: true, completion: nil)
        
    }
}
