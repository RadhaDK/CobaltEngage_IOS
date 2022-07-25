//
//  HorizontalFilterView.swift
//  CSSI
//
//  Created by Kiran on 03/06/20.
//  Copyright © 2020 yujdesigns. All rights reserved.
//

import UIKit

protocol HorizontalFilterViewDelegate : NSObject {
    func closeClicked()
    func doneClickedWith(filter : SelectedFilter?)
}

///SHows filter options in collection view (grid style)
///
///Note : call show(filter : Filter) method and pass filter to populate the options and filter heading
class HorizontalFilterView: UIView
{
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var optionsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var optionsCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var lblFilterName: UILabel!
    
    @IBOutlet weak var viewFilterUnderline: UIView!
    private var filter : Filter!
    
    var selectedFiter : SelectedFilter?
    
    //Added on 14th October 2020 V2.3
    ///When reset is clicked this filter is shown as default
    var defaultFilter : SelectedFilter?
    
    weak var delegate : HorizontalFilterViewDelegate?
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupContentView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupContentView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.optionsCollectionViewHeight.constant = self.optionsCollectionView.contentSize.height
    }

    @IBAction func closeClicked(_ sender: UIButton)
    {
        self.delegate?.closeClicked()
    }
    
    @IBAction func resetClicked(_ sender: UIButton)
    {
        //Modified on 14th October 2020 V2.3
        self.selectedFiter = self.defaultFilter
        //self.selectedFiter = nil
        self.optionsCollectionView.reloadData()
    }
    
    @IBAction func doneClicked(_ sender: UIButton)
    {
        self.delegate?.doneClickedWith(filter: self.selectedFiter)
    }
    
}

//MARK:- Custom Methods
extension HorizontalFilterView
{
    private func setupContentView()
    {
        Bundle.main.loadNibNamed("HorizontalFilterView", owner: self, options: nil)
        self.contentView.frame = self.bounds
        self.addSubview(self.contentView)
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let topLayout = NSLayoutConstraint.init(item: self.contentView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        let rightLayout = NSLayoutConstraint.init(item: self.contentView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        let bottomLayout = NSLayoutConstraint.init(item: self.contentView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        let leftLayout = NSLayoutConstraint.init(item: self.contentView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([topLayout,rightLayout,bottomLayout,leftLayout])
        self.layoutIfNeeded()
        
        self.initialSetup()
    }
    
    private func initialSetup()
    {
        self.optionsCollectionView.delegate = self
        self.optionsCollectionView.dataSource = self
        self.optionsCollectionView.register(UINib.init(nibName: "OptiosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OptiosCollectionViewCell")
        self.btnDone.diningBtnViewSetup()
        
        self.btnDone.setTitle(self.appDelegate.masterLabeling.done ?? "", for: .normal)
        self.btnReset.setTitle(self.appDelegate.masterLabeling.rESET ?? "", for: .normal)
        self.lblFilterName.text = ""
        self.viewFilterUnderline.backgroundColor = APPColor.MainColours.primary2
        self.btnDone.setStyle(style: .outlined, type: .primary)
        self.layoutIfNeeded()
    }
    
    //Call this method if the filter options should be shown
    func show(filter : Filter)
    {
        self.filter = filter
        self.lblFilterName.text = filter.displayName
        self.optionsCollectionView.reloadData()
        self.layoutIfNeeded()
    }
}


extension HorizontalFilterView : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let filter = self.filter
        {
             return filter.options.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height : CGFloat = 23
        
        let font = UIFont.init(name: "SourceSansPro-Semibold", size: 18.0)
        
        //Remore this if the logic is still commented by v2.3
        /*
        //Indicates if the option at the current index path is selected index
        var isSelectedOption = false
        
        if let filter = self.filter, self.selectedFiter?.option.Id == filter.options[indexPath.row].Id
        {
            isSelectedOption = true
        */
        
        
        //Note : remember to change image padding adn imgViewWidth when those  are changed in interface builder for OptiosCollectionViewCell
        
        //The distance between optin name and selection indicator imageview
        let imagePadding : CGFloat = 10
        
        //Width of the selection indicator image view
        let imgViewWidth : CGFloat = 10
        
        let width = (self.filter.options[indexPath.row].name ?? "").width(withConstrainedHeight: height, font: font!) + imagePadding + imgViewWidth//(isSelectedOption ? imgViewWidth : 0)
        
        return CGSize.init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptiosCollectionViewCell", for: indexPath) as! OptiosCollectionViewCell
        let option = self.filter.options[indexPath.row]
        cell.lblName.text = option.name
        
        if self.selectedFiter?.option.Id == option.Id
        {
           // cell.selectionImageView.isHidden = false
            cell.selectionImageView.image = UIImage.init(named: "blue_Tick")
        }
        else
        {
            //cell.selectionImageView.isHidden = true
            cell.selectionImageView.image = nil
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let option = self.filter.options[indexPath.row]
        if self.selectedFiter?.option.Id == option.Id
        {
            self.selectedFiter = nil
        }
        else
        {
            self.selectedFiter = SelectedFilter.init(type : self.filter.type , option : option)
        }
        
        self.optionsCollectionView.reloadData()
        self.filterView.layoutIfNeeded()
    }
}


extension String
{
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
