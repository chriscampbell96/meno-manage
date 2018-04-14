//
//  symptomActivityCollectionViewCell.swift
//  meno-manage
//
//  Created by Chris Campbell on 14/04/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import Charts
import ChartsRealm

class symptomActivityCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var chartIMG: BarChartView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    func configure (dataPoints: [String], values: [Double]) {
        chartIMG.noDataText = "Please Insert Some Data!"
        
        
        
        chartIMG.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: nil)
        chartIMG.chartDescription?.enabled = false
        self.chartIMG.legend.enabled = false
        
        let formatter = BarChartFormatter(values: dataPoints)
        let xAxis = XAxis()
        xAxis.valueFormatter = formatter
        
        chartIMG.fitBars = true
        
        chartIMG.xAxis.valueFormatter = xAxis.valueFormatter
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = Double(0.90)
        chartDataSet.colors = [UIColor(red: 169/255, green: 197/255, blue: 177/255, alpha: 1.0)]
        chartIMG.data = chartData
        
        
    }
}
