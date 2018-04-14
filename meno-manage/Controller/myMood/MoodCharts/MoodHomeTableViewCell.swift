//
//  MoodHomeTableViewCell.swift
//  meno-manage
//
//  Created by Chris Campbell on 14/04/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit

class MoodHomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var statsStats: UILabel!
    @IBOutlet weak var statsTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
