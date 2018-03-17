//
//  PublisherTableViewCell.swift
//  meno-manage
//
//  Created by Chris Campbell on 17/03/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit

class PublisherTableViewCell: UITableViewCell {

    @IBOutlet weak var websiteTitle: UILabel!
    @IBOutlet weak var toFeed: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
