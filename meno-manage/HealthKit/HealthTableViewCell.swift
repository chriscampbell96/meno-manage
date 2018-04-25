//
//  HealthTableViewCell.swift
//  meno-manage
//
//  Created by Chris Campbell on 07/04/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit

class HealthTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var result: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
