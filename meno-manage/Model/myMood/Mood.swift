//
//  Mood.swift
//  meno-manage
//
//  Created by Christopher Campbell on 13/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import Foundation
import RealmSwift


@objcMembers class Mood: Object {

    
    dynamic var mood: String = ""
    dynamic var comment: String = ""
    dynamic var activities: String = ""
    dynamic var time: String = ""
    dynamic var date: String = ""
    dynamic var symptom: String = ""
    
    convenience init(mood: String, comment: String, activities: String, date: String, time: String, symptom: String) {
        self.init()
        self.mood = mood
        self.comment = comment
        self.activities = activities
        self.date = date
        self.time = time
        self.symptom = symptom
    }
    
    //date time toString...
}
