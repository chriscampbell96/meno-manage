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
        ChartIMG.noDataText = "Please Insert Some Data!"
//        ChartIMG.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
//        ChartIMG.xAxis.granularityEnabled = true
//        ChartIMG.xAxis.granularity = 1
        


        ChartIMG.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)


        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(values: dataEntries, label: nil)
        ChartIMG.chartDescription?.enabled = false
        self.ChartIMG.legend.enabled = false
        
        let formatter = BarChartFormatter(values: dataPoints)
        let xAxis = XAxis()
        xAxis.valueFormatter = formatter
        
        ChartIMG.xAxis.valueFormatter = xAxis.valueFormatter
        let chartData = BarChartData(dataSet: chartDataSet)
        ChartIMG.data = chartData
        
        
    }
    
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
