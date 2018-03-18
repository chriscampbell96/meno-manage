//
//  ReadingsTableViewCell.swift
//  meno-manage
//
//  Created by Chris Campbell on 18/03/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit

class ReadingsTableViewCell: UITableViewCell {

    @IBOutlet weak var statsTitle: UILabel!
    @IBOutlet weak var statsStat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
