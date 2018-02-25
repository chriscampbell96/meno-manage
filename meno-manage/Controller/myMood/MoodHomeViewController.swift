//
//  MoodHomeViewController.swift
//  meno-manage
//
//  Created by Chris Campbell on 22/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import Charts
import ChartsRealm
import RealmSwift

class MoodHomeViewController: UIViewController {
    var months: [String]!
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    
    //global v's
    var moods: Results<Mood>!
    var realm = try! Realm()
    
    //init variables...

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let great = getGreatMood()
        let good = getGoodMood()
        let meh = getMehMood()
        let sad = getSadMood()
        let awful = getAwfulMood()
        
        months = ["Great", "Good", "Meh", "Sad", "Awful"]
        let unitsSold = [great, good, meh, sad, awful] as [Any]

        setChart(dataPoints: months, values: unitsSold as! [Double])
        pieChart(dataPoints: months, values: unitsSold as! [Double])
    // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let great = getGreatMood()
        let good = getGoodMood()
        let meh = getMehMood()
        let sad = getSadMood()
        let awful = getAwfulMood()
        
        months = ["Great", "Good", "Meh", "Sad", "Awful"]
        let unitsSold = [great, good, meh, sad, awful] as [Any]
        
        
        
        setChart(dataPoints: months, values: unitsSold as! [Double])
        pieChart(dataPoints: months, values: unitsSold as! [Double])
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    //get moods
    func getGreatMood() -> Double{
        let greatMood = realm.objects(Mood.self).filter("mood = 'test'")
        print(greatMood.count)
        return Double(greatMood.count)
    }
    func getGoodMood() -> Double{
        let goodMood = realm.objects(Mood.self).filter("mood = 'good'")
        print(goodMood.count)
        return Double(goodMood.count)
    }
    func getMehMood() -> Double{
        let mehMood = realm.objects(Mood.self).filter("mood = 'meh'")
        print(mehMood.count)
        return Double(mehMood.count)
    }
    func getSadMood() -> Double{
        let sadMood = realm.objects(Mood.self).filter("mood = 'sad'")
        print(sadMood.count)
        return Double(sadMood.count)
    }
    func getAwfulMood() -> Double{
        let awfulMood = realm.objects(Mood.self).filter("mood = 'awful'")
        print(awfulMood.count)
        return Double(awfulMood.count)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)

        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        
    }
    
    func pieChart(dataPoints: [String], values: [Double]) {

        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData

        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors

        
    }
    }

