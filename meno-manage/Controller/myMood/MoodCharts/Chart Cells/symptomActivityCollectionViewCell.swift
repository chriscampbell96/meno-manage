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
    
    func configure(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry1 = PieChartDataEntry(value: Double(i), label: dataPoints[i], data:  dataPoints[i] as AnyObject)

            dataEntries.append(dataEntry1)
        }
        print(dataEntries[0].data)
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Symptoms")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        chartIMG.data = pieChartData
        chartIMG.drawEntryLabelsEnabled = false
        chartIMG.chartDescription?.text = ""
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.drawValuesEnabled = false

        pieChartDataSet.colors = colors
    }


    }


