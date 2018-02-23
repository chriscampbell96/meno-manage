//
//  MoodCell.swift
//  meno-manage
//
//  Created by Christopher Campbell on 13/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit

class MoodCell: UITableViewCell {

    @IBOutlet weak var dateLogged: UILabel!
    @IBOutlet weak var moodLogged: UILabel!
    @IBOutlet weak var timeLogged: UILabel!
    @IBOutlet weak var activitiesLogged: UILabel!
    @IBOutlet weak var commentLogged: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with myMood: Mood){
        moodLogged.text = myMood.mood
        activitiesLogged.text = myMood.activities
        commentLogged.text = myMood.comment
        dateLogged.text = myMood.date

    }
    

}
