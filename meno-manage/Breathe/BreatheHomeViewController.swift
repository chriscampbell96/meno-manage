//
//  BreatheHomeViewController.swift
//  meno-manage
//
//  Created by Chris Campbell on 14/03/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class BreatheHomeViewController: UIViewController{
    
    var timeLogged: String!
    
    var relax: Results<Relax>!
    var realm = try! Realm()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        print("running")
        print(relax)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
                print(relax)
        print("running")
        getRelax()
        getCurrentWeek()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getRelax(){
       let reading = realm.objects(Relax.self)
        print(reading)

    }
    
    func getCurrentWeek(){
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let dayOfWeek = calendar.component(.weekday, from: today)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none


        
        let days = (weekdays.lowerBound ..< weekdays.upperBound)
            .flatMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: today) }  // use `compactMap` in Xcode 9.3 and later
            .filter { !calendar.isDateInWeekend($0) }
        
        let startOfWeek = Date().startOfWeek
        let endOfWeek = Date().endOfWeek
        print(startOfWeek as Any)
        print(endOfWeek as Any)
        print(days)
    }
    
    
//    func getGreatMood() -> Double{
//        let greatMood = realm.objects(Mood.self).filter("mood = 'test'")
//        print(greatMood.count)
//        return Double(greatMood.count)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
}
