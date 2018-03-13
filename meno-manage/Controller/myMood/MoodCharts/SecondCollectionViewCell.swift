//
//  SecondCollectionViewCell.swift
//  meno-manage
//
//  Created by Chris Campbell on 13/03/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import ChartsRealm
import Charts

class SecondCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ChartView2: BarChartView!
    @IBOutlet weak var NewLabel: UILabel!
    @IBOutlet weak var NewDesc: UILabel!
    
    func configure (dataPoints: [String], values: [Double]) {
        ChartView2.noDataText = "Checking if working"
        
         ChartView2.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: nil)
        self.ChartView2.legend.enabled = false
        let chartData = BarChartData(dataSet: chartDataSet)
         ChartView2.data = chartData
    }
}
