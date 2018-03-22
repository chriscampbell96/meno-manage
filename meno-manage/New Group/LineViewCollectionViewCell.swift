//
//  LineViewCollectionViewCell.swift
//  meno-manage
//
//  Created by Chris Campbell on 22/03/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import Charts

class LineViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var chartTitle: UILabel!
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var chartDescription: UILabel!
}
