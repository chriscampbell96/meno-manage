//
//  ChangeTagTableViewCell.swift
//  meno-manage
//
//  Created by Chris Campbell on 16/04/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit

class ChangeTagTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var desc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
