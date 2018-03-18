//
//  relax.swift
//  meno-manage
//
//  Created by Chris Campbell on 17/03/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import Foundation
import RealmSwift


@objcMembers class Relax: Object {
    
    
    dynamic var relax: String = ""
    dynamic var duration: Double = 0.0
    dynamic var time: String = ""
    dynamic var date: String = ""
    
    convenience init(relax: String, duration: Double, time: String, date: String) {
        self.init()
        self.relax = relax
        self.duration = duration
        self.time = time
        self.date = date
    }

}

