//
//  BreatheHomeStatsViewController.swift
//  meno-manage
//
//  Created by Chris Campbell on 18/03/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class BreatheHomeStatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    

    
    
    var relaxs: Results<Relax>!
    var realm = try! Realm()
    
    var statlabels: [String]!
    var stats: [String]!
    var weekdays: [String]!
    
    var allSessions: String!
    var currentWeekThis: [String]!


    @IBOutlet weak var mainStats: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        relaxs = realm.objects(Relax.self)
        getRelax()
        let allTimeLogged = getAllTime()
        let totalSessions = getTotalSessions()
        let todayLogged = getToday()
        let dayAVG = getdailyAverage()
        let currentWeekThis = getCurrentWeek()

        
        statlabels = ["🗓 Today", "🗓 7 Days", "🗓 30 Days", "📊 All Time", "📈 Daily Average" , "📈 Total Sessions Logged"]
        stats = [todayLogged + "sec", "30 sec", allTimeLogged + "sec", allTimeLogged + "sec", dayAVG, totalSessions]
//        weekdays = [currentWeekThis]
        weekdays = currentWeekThis
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.mainStats.reloadData()
        let totalSessions = getTotalSessions()
        let todayLogged = getToday()
        let allTimeLogged = getAllTime()
        let dayAVG = getdailyAverage()

        
        let currentWeekThis = getCurrentWeek()

        print(currentWeekThis)

    
        statlabels = ["🗓 Today", "🗓 7 Days", "🗓 30 Days", "📊 All Time", "📈 Daily Average" , "📈 Total Sessions Logged"]
        stats = [todayLogged + "sec", "err", "err", allTimeLogged + " sec", dayAVG + " sec", totalSessions]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getRelax(){
//        let reading = realm.objects(Relax.self)

    }
    
    func getdailyAverage() -> String{
        let getAll: Double = realm.objects(Relax.self).sum(ofProperty: "duration")
        let getCount: Double = Double(realm.objects(Relax.self).count)
        
        let dailyAverage = getAll / getCount
        
        return String(dailyAverage)
    }

    
    func getToday() -> String{
        
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.short
        dateformatter.timeStyle = DateFormatter.Style.none
        let changed = dateformatter.string(from: Date() as Date)
        
        let todaysReadings: Double = realm.objects(Relax.self).filter("date == %@", changed).sum(ofProperty: "duration")
        return String(todaysReadings)
        
    }
    func get7Days(){
        
    }
    func get30Days(){
        


        
    }
    func getAllTime() -> String{
//        let goodMood = realm.objects(Mood.self).filter("mood = 'Good'")
        let allTime: Double = realm.objects(Relax.self).sum(ofProperty: "duration")
        return String(allTime)
    }
    func getBestStreak(){
        
    }
    func getTotalSessions() -> String{
        let allTime = realm.objects(Relax.self)
        let allSessions = allTime.count
        return String(allSessions)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statlabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "statsCell") as?
            ReadingsTableViewCell else {return UITableViewCell()}
        cell.statsTitle.text = statlabels[indexPath.row]
        cell.statsStat.text = stats[indexPath.row]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chartCell", for: indexPath) as! LineViewCollectionViewCell
            
            cell.chartTitle.text = "Weekly Session Overview"
            cell.chartDescription.text = "A count of the sessions logged for the past week."
            cell.configure(dataPoints: getCurrentWeek(), values: [0.0,1.0,0.0,0.0,0.0,3.0,2.0])
            
            cell.contentView.layer.cornerRadius = 4.0
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = false
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            cell.layer.shadowRadius = 4.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            
            return cell
        }
        return UICollectionViewCell()
        
    }
    func getCurrentWeek() -> [String]{
        let cal = Calendar.current
        var date = cal.startOfDay(for: Date())
        var days = [String]()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        for i in 1 ... 7 {
            let day = cal.component(.day, from: date)
            days.append(String(day))
            date = cal.date(byAdding: .day, value: -1, to: date)!
        }
        print(days)
        return days
    }
    


}


