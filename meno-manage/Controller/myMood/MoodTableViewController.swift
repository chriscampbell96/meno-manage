//
//  MoodTableViewController.swift
//  meno-manage
//
//  Created by Christopher Campbell on 13/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import RealmSwift

//global v's
var moods: Results<Mood>!
var realm = try! Realm()

class MoodTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        moods = realm.objects(Mood.self)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moods.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoodCell") as?
            MoodCell else {return UITableViewCell()}
        let mood = moods[indexPath.row]
        cell.moodLogged.text = mood.mood
        cell.activitiesLogged.text = mood.activities
        cell.commentLogged.text = mood.comment
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editMood"{
            let destination = segue.destination as! PostMoodViewController
            //todo
//            let mood = moods[MoodTableViewController.indexPath.row]
//            destination.incomingMood = mood
            
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
        try! realm.write {
            realm.delete(moods[indexPath.row])
            }
            self.tableView.reloadData()
        }
    }
    
    
}
