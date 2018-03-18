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

class BreatheHomeViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var sessionsView: UITableView!
    
    

    
    
    var timeLogged: String!
    
    var relaxs: Results<Relax>!
    var realm = try! Realm()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        relaxs = realm.objects(Relax.self)
        

        print("running")
        print(relaxs)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.sessionsView.reloadData()
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
    

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return relaxs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "relaxCell") as?
            RelaxTableViewCell else {return UITableViewCell()}
        let relax = relaxs[indexPath.row]
        cell.relaxDate.text = relax.date
        cell.relaxTime.text = relax.time
        cell.relaxDuration.text = String(relax.duration)
        

        return cell
    }
    

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            try! realm.write {
                realm.delete(relaxs[indexPath.row])
            }
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    

    
    
    

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
