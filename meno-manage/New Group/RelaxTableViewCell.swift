//
//  RelaxTableViewCell.swift
//  meno-manage
//
//  Created by Chris Campbell on 18/03/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit

class RelaxTableViewCell: UITableViewCell {

    @IBOutlet weak var relaxDuration: UILabel!
    @IBOutlet weak var relaxDate: UILabel!
    @IBOutlet weak var relaxTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
