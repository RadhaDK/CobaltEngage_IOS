//
//  FitnessHamburgerMenuViewController.swift
//  CSSI
//
//  Created by Kiran on 11/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

//23rd October 2020 V2.4 -- GATHER0000176
//Modified according to new specs
protocol FitnessHamburgerMenuViewControllerDelegate : NSObject {
    func didSelectMenu(menu:HamburgerMenu,index : Int)
}

class FitnessHamburgerMenuViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var profilePicImgView: UIImageView!
    @IBOutlet weak var menuTblView: UITableView!
    
    private var menuOptionsArr = [HamburgerMenu]()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    weak var delegate : FitnessHamburgerMenuViewControllerDelegate?
    var selectedMenuID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initialSetups()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.profilePicImgView.layer.cornerRadius = self.profilePicImgView.frame.width/2
        self.profilePicImgView.clipsToBounds = true
    }

    
}

//MARK:- Custom Methods
extension FitnessHamburgerMenuViewController
{
    private func initialSetups()
    {
        self.applyDesignSpecs()
        
        self.menuOptionsArr = self.appDelegate.appFitnessMenu
        
        self.menuTblView.delegate = self
        self.menuTblView.dataSource = self
        self.menuTblView.register(UINib.init(nibName: "HamburgerMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "HamburgerMenuTableViewCell")
        self.menuTblView.estimatedRowHeight = 50
        self.menuTblView.rowHeight = UITableViewAutomaticDimension
        self.menuTblView.separatorStyle = .none
        
        let view = UIView.init()
        view.backgroundColor = .clear
        self.menuTblView.tableFooterView = view
        
        self.profilePicImgView.image = UIImage(named: "avtar")
        
        self.nameLbl.text = (self.appDelegate.masterLabeling.Fit_Hello ?? "").replacingOccurrences(of: AppIdentifiers.namePlaceHolder, with: UserDefaults.standard.string(forKey: UserDefaultsKeys.lastName.rawValue) ?? "")
    }
    
    private func applyDesignSpecs()
    {
        self.nameLbl.font = AppFonts.italic16
        self.nameLbl.textColor = APPColor.textColor.whiteText
    }
    
}

//MARK:- Table view delegates
extension FitnessHamburgerMenuViewController : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.menuOptionsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HamburgerMenuTableViewCell") as! HamburgerMenuTableViewCell
        
        let menu = self.menuOptionsArr[indexPath.row]
        cell.menuNameLbl.text = menu.name
        
        let downloadTask = ImageDownloadTask()
        downloadTask.url = menu.icon
        
        downloadTask.startDownload { (data, response, url) in
            
            if let data = data , url == menu.icon
            {
                DispatchQueue.main.async {
                    cell.menuImageView.image = UIImage.init(data: data)
                }
               
            }
            
        }
        
        cell.contentView.backgroundColor = (self.selectedMenuID == menu.Id) ? APPColor.tableViewColors.cellSelected : APPColor.tableViewColors.cellUnselected
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selectedMenu = self.menuOptionsArr[indexPath.row]
        self.selectedMenuID = selectedMenu.Id ?? ""
        self.delegate?.didSelectMenu(menu: selectedMenu, index: indexPath.row)
        self.menuTblView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
}
