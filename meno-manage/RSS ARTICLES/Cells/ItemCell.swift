//
//  ItemCell.swift
//  Reader
//
//  Created by Francesco Marisaldi on 05/04/17.
//  Copyright © 2017 Francesco Marisaldi. All rights reserved.
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
