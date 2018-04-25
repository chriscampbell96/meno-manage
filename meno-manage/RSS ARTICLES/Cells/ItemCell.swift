//
//  ProfileViewController.swift
//  meno-manage
//
//  Created by Christopher Campbell on 01/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelSummary: UILabel!
    @IBOutlet var labelDate: UILabel!
    @IBOutlet var labelFeed: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
