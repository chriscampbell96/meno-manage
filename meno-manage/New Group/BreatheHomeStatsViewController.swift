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
    
    var allSessions: String!
    


    @IBOutlet weak var mainStats: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        relaxs = realm.objects(Relax.self)
        getRelax()
        let allTimeLogged = getAllTime()
        let totalSessions = getTotalSessions()
        let todayLogged = getToday()
        
        statlabels = [todayLogged, "🗓 7 Days", "🗓 30 Days", "📊 All Time", "🔥 Best Streak" , "📈 Total Sessions Logged"]
        stats = [todayLogged + "sec", "coming soon", "coming soon", allTimeLogged + "sec", "coming soon", totalSessions]
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.mainStats.reloadData()
        getAllTime()
        let totalSessions = getTotalSessions()
        let todayLogged = getToday()
        let allTimeLogged = getAllTime()

        
        statlabels = ["🗓 Today", "🗓 7 Days", "🗓 30 Days", "📊 All Time", "🔥 Best Streak" , "📈 Total Sessions Logged"]
        stats = [todayLogged + "sec", "coming soon", "coming soon", allTimeLogged + "sec", "coming soon", totalSessions]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getRelax(){
//        let reading = realm.objects(Relax.self)

    }
    
//    func getCurrentWeek(){
//        let calendar = Calendar.current
//        let today = calendar.startOfDay(for: Date())
//        let dayOfWeek = calendar.component(.weekday, from: today)
//        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
//        
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        formatter.timeStyle = .none
//        
//        
//        
//        let days = (weekdays.lowerBound ..< weekdays.upperBound)
//            .flatMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: today) }  // use `compactMap` in Xcode 9.3 and later
//            .filter { !calendar.isDateInWeekend($0) }
//        
//        let startOfWeek = Date().startOfWeek
//        let endOfWeek = Date().endOfWeek
//        print(startOfWeek as Any)
//        print(endOfWeek as Any)
//        print(days)
//    }
    
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
        
//        let predicate = NSPredicate(format: "%@ >= start AND %@ <= end", time, time)

        
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
            
            cell.chartDescription.text = "This is a test"
            cell.chartTitle.text = "Testing the chart implementation"
            
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
    
    


}
//extension Date {
//    var startOfWeek: Date? {
//        let gregorian = Calendar(identifier: .gregorian)
//        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
//        return gregorian.date(byAdding: .day, value: 1, to: sunday)
//    }
//
//    var endOfWeek: Date? {
//        let gregorian = Calendar(identifier: .gregorian)
//        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
//        return gregorian.date(byAdding: .day, value: 7, to: sunday)
//    }
//}

