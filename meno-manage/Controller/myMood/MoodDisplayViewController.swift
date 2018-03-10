//
//  MoodDisplayViewController.swift
//  meno-manage
//
//  Created by Chris Campbell on 09/03/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import Charts
import ChartsRealm
import RealmSwift

class MoodDisplayViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    //global v's
    var moods: Results<Mood>!
    var realm = try! Realm()
    
    let chartName = ["Mood Overview", "Daily Mood"]
    
//    let chartView = [LineChartView(), BarChartView()]
    
    let chartDescription = ["this is just a test", "Does this work?"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartCell", for: indexPath) as! MoodCollectionViewCell
        
        cell.ChartName.text = chartName[indexPath.row]
        cell.ChartDescription.text = chartDescription[indexPath.row]
        return cell
    }
    
    


}
