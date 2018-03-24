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
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var chartDescription: UILabel!
    
    func configure (dataPoints: [String], values: [Double]) {
        chartView.noDataText = "Checking if working"
        
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        
        
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            
            dataEntries.append(dataEntry)
        }
        
        let formatter = BarChartFormatter(values: dataPoints)
        let xAxis = XAxis()
        xAxis.valueFormatter = formatter
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: nil)
        self.chartView.legend.enabled = false
        chartView.xAxis.valueFormatter = xAxis.valueFormatter

        let chartData = BarChartData(dataSet: chartDataSet)
        chartView.data = chartData
        
        
        
        

        

    }
    
    class BarChartFormatter: NSObject,IAxisValueFormatter,IValueFormatter {
        
        
        var values : [String]
        required init (values : [String]) {
            self.values = values
            super.init()
        }
        
        
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            return values[Int(value)]
            
        }
        
        func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
            return values[Int(entry.x)]
            
        }
}
}
