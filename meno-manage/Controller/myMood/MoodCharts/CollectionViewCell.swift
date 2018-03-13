//
//  CollectionViewCell.swift
//  cardLayout
//
//  Created by Riley Norris on 11/4/17.
//  Copyright © 2017 Riley Norris. All rights reserved.
//

import UIKit
import Charts
import ChartsRealm

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ChartIMG: BarChartView!
    @IBOutlet weak var ChartName: UILabel!
    @IBOutlet weak var ChartDescription: UILabel!
    
    func configure (dataPoints: [String], values: [Double]) {
        ChartIMG.noDataText = "Checking if working"

        ChartIMG.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: nil)
        self.ChartIMG.legend.enabled = false
        let chartData = BarChartData(dataSet: chartDataSet)
        ChartIMG.data = chartData
    }
    
}
