//
//  todayActivityCollectionViewCell.swift
//  meno-manage
//
//  Created by Chris Campbell on 14/04/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import HealthKit

class todayActivityCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var cals: UILabel!
    @IBOutlet weak var stepCountlbl: UILabel!
    
   
    
    
    
    
}

extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
}
