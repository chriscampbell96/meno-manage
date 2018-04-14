//
//  ShareSomethingCell.swift
//  meno-manage
//
//  Created by Christopher Campbell on 05/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import Firebase


class ShareSomethingCell: UITableViewCell {
    
    @IBOutlet weak var postCat: UILabel!
    @IBOutlet weak var catDesc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(){
        self.postCat.text = "Change Category"
        self.catDesc.text = "Click to change the category of posts!"

        
    }

}
