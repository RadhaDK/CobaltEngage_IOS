//
//  GolfLeaguesTableViewCell.swift
//  CSSI
//
//  Created by apple on 11/20/19.
//  Copyright © 2019 yujdesigns. All rights reserved.
//

import UIKit
protocol leagues: AnyObject {
    func leaguesButtonClicked(cell: GolfLeaguesTableViewCell)
    
}

class GolfLeaguesTableViewCell: UITableViewCell {
    weak var delegate: leagues?

    @IBOutlet weak var btnLeague: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func leagueClicked(_ sender: Any) {
        delegate?.leaguesButtonClicked(cell: self)

    }
}
