//
//  HealthHomeViewController.swift
//  meno-manage
//
//  Created by Chris Campbell on 26/03/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import HealthKit
import DZNEmptyDataSet



class HealthHomeViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {

    
    
    let healthkitStore = HKHealthStore()
    
    
    @IBOutlet weak var tableList: UITableView!
    
    let titles: [String] = ["Step Count", "Active Energy"]
    let values: [String] = ["0", "0"]
    



    override func viewDidLoad() {
        super.viewDidLoad()
        

        tableList.delegate = self
        tableList.dataSource = self

        if HKHealthStore.isHealthDataAvailable() {
            // add code to use HealthKit here...
            
            let typestoRead = Set([
                HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!,
                HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.menstrualFlow)!,
                HKQuantityType.quantityType(forIdentifier: .stepCount)!,
                HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
                HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!,
                HKQuantityType.quantityType(forIdentifier: .bodyMass)!,
                HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!
                
                
                ])
            
            let typestoShare = Set([
                HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!,
                HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.menstrualFlow)!,
                HKQuantityType.quantityType(forIdentifier: .stepCount)!,
                HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
                HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!,
                HKQuantityType.quantityType(forIdentifier: .bodyMass)!,
                HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!
                
                ])
            
            self.healthkitStore.requestAuthorization(toShare: typestoShare as? Set<HKSampleType>, read: typestoRead) { (success, error) -> Void in
                if success == false {
                    NSLog(" Display not allowed")
                }
            }    
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HealthResCell", for: indexPath) as? HealthTableViewCell else { return UITableViewCell() }
        cell.title.text = titles[indexPath.row]
        cell.result.text = values[indexPath.row]
        return cell
    }
    
    




}

