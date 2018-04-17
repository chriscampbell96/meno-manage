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
    
    @IBOutlet weak var chartIMG: PieChartView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    func configure (dataPoints: [String], values: [Double]) {
        chartIMG.noDataText = "Please Insert Some Data!"
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
            

        }
        
//        let dataSet = PieChartDataSet(values: dataEntries, label: nil)

        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Symptoms")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        chartIMG.data = pieChartData
        
        let noZeroFormatter = NumberFormatter()
        noZeroFormatter.zeroSymbol = ""
        pieChartDataSet.valueFormatter = DefaultValueFormatter(formatter: noZeroFormatter)
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        
        chartIMG.highlightPerTapEnabled = false
        chartIMG.usePercentValuesEnabled = false
        chartIMG.drawEntryLabelsEnabled = true
        chartIMG.centerText = "%"
        
        
        let legend = chartIMG.legend
        legend.font = UIFont(name: "Arial", size: 11)!
        legend.textColor = UIColor.black
        legend.form = .circle

        chartIMG.animate(xAxisDuration: 2, yAxisDuration: 2)

        pieChartDataSet.colors = colors
        pieChartDataSet.selectionShift = 0
        pieChartDataSet.sliceSpace = 2.5
        

    }

    }

