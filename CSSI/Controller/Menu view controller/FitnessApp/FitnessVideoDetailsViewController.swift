//
//  FitnessVideoDetailsViewController.swift
//  CSSI
//
//  Created by Kiran on 14/09/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit
import WebKit

class FitnessVideoDetailsViewController: UIViewController
{
    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var navFavouriteBtn: UIButton!
    @IBOutlet weak var playlistBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var playerWebView: WKWebView!
    @IBOutlet weak var videoDetailsView: UIView!
    @IBOutlet weak var videoFavBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var groupLbl: UILabel!
    @IBOutlet weak var expandBtn: UIButton!
    @IBOutlet weak var viewsLbl: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var postedDateLbl: UILabel!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var videosTblView: UITableView!
    
    var selectedVideo : FitnessVideo?
    var videosArr = [FitnessVideo]()
    var showNavigationBar = true
    
    private var expandedDescriptionIndexArr = [ExpandedVideo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initialSetups()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = !self.showNavigationBar
    }
    
    @IBAction func backBtnAction(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func navFavoutiteClicked(_ sender: UIButton)
    {
        
    }
    
    @IBAction func navPlalystClicked(_ sender: UIButton)
    {
    }
    
    @IBAction func navShareClicked(_ sender: UIButton)
    {
    }
    
    @IBAction func favClicked(_ sender: UIButton)
    {
        
    }
    
    @IBAction func expandClicked(_ sender: UIButton)
    {
        //if isSelected is true then the view is shown and if its false the view is hidden
        if sender.isSelected
        {
            sender.isSelected = false
            sender.rotate(from: .pi, to: 0, duration: 0.25, onCompletion: CGAffineTransform.init(rotationAngle: 0))
            UIView.animate(withDuration: 0.25) {
                self.descriptionView.isHidden = true
            }
        }
        else
        {
            sender.isSelected = true
            sender.rotate(from: 0, to: .pi, duration: 0.25, onCompletion: CGAffineTransform.init(rotationAngle: .pi))
            UIView.animate(withDuration: 0.25) {
                self.descriptionView.isHidden = false
            }
        }
       
    }
    
}


//MARK:- Table View Delegates
extension FitnessVideoDetailsViewController : UITableViewDelegate , UITableViewDataSource , FitnessVideoTableViewCellDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        self.videosArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FitnessVideoTableViewCell") as! FitnessVideoTableViewCell
        cell.delegate = self
        let video = self.videosArr[indexPath.row]
        cell.thumbnailImgView.backgroundColor = .red
        cell.favouriteBtn.backgroundColor = .clear
        cell.expandImgView.image = UIImage.init(named: "upArrow_gray")
        cell.nameLbl.text = video.title
        cell.groupLbl.text = "Group:"
        cell.viewsLbl.text = ""
        cell.postedDateLbl.text = video.publishOn
        cell.descriptionTxtView.text = video.videoDescription
        if self.expandedDescriptionIndexArr.contains(where: {$0.position == indexPath})
        {
            let expandedVideoDetails = self.expandedDescriptionIndexArr.first(where: {$0.position == indexPath})!
            
            if expandedVideoDetails.shouldAnimate
            {
                cell.expandImgHolderView.rotate(from: 0, to: .pi, duration: 0.25, onCompletion: CGAffineTransform.init(rotationAngle: .pi))
                UIView.animate(withDuration: 0.25) {
                    cell.descriptionView.isHidden = false
                }
                self.expandedDescriptionIndexArr.first(where: {$0.position == indexPath})?.shouldAnimate = false
            }
            else
            {
                cell.expandImgHolderView.transform = CGAffineTransform.init(rotationAngle: .pi)
                cell.descriptionView.isHidden = false
            }
            
        }
        else
        {
            cell.descriptionView.isHidden = true
            cell.expandImgHolderView.transform = CGAffineTransform.init(rotationAngle: 0)
        }
        return cell
    }
    
    
    func expandClicked(cell: FitnessVideoTableViewCell)
    {
        guard let indexPath = self.videosTblView.indexPath(for: cell) else{
        return
        }
        
        if self.expandedDescriptionIndexArr.contains(where: {$0.position == indexPath})
        {
            self.expandedDescriptionIndexArr.removeAll(where: {$0.position == indexPath})
            self.videosTblView.beginUpdates()
            cell.expandImgHolderView.rotate(from: .pi, to: 0, duration: 0.25, onCompletion: CGAffineTransform.init(rotationAngle: 0))
            cell.descriptionView.isHidden = true
            self.videosTblView.endUpdates()
        }
        else
        {
            let selectedPosition = ExpandedVideo.init()
            selectedPosition.position = indexPath
            selectedPosition.shouldAnimate = true
            self.expandedDescriptionIndexArr.append(selectedPosition)
            self.videosTblView.reloadData()
        }
    }
    
    func addToFavouriteClicked(cell: FitnessVideoTableViewCell)
    {
        if let index = self.videosTblView.indexPath(for: cell)
        {
            
        }
    }
}

//MARK:- Custom Methods
extension FitnessVideoDetailsViewController
{
    private func initialSetups()
    {
        self.videosTblView.delegate = self
        self.videosTblView.dataSource = self
        self.videosTblView.estimatedRowHeight = 50
        self.videosTblView.rowHeight = UITableViewAutomaticDimension
        let footerView = UIView.init()
        footerView.backgroundColor = .clear
        self.videosTblView.tableFooterView = footerView
        self.videosTblView.separatorStyle = .none
        self.videosTblView.register(UINib.init(nibName: "FitnessVideoTableViewCell", bundle: nil), forCellReuseIdentifier: "FitnessVideoTableViewCell")
        self.loadVideo()
        
        self.descriptionView.isHidden = true
        
    }
    
    private func loadVideo()
    {
        if let selectedVideo = self.selectedVideo
        {
//            self.playerWebView.load(URLRequest.init(url: URL.init(string: selectedVideo.videoLink!)!))
//            self.videoFavBtn.backgroundColor = (selectedVideo.favourite ?? false) ? .red : .green
//            self.nameLbl.text = selectedVideo.videoName
//            self.groupLbl.text = "Group: \(selectedVideo.group ?? "")"
//            self.viewsLbl.text = selectedVideo.views
//            self.postedDateLbl.text = selectedVideo.postedDate
//            self.descriptionTxtView.text = selectedVideo.videoDescription
        }
        
    }
    
}
