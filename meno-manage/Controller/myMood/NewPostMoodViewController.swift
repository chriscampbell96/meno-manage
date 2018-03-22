//
//  NewPostMoodViewController.swift
//  meno-manage
//
//  Created by Chris Campbell on 16/03/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import SwiftyPickerPopover
import Realm
import RealmSwift

class NewPostMoodViewController: UIViewController {
    
    let realm = try! Realm()
    var incomingMood: Mood? = nil
    
    @IBOutlet weak var moodLoggedText: UITextField!
    @IBOutlet weak var activityLoggedText: UITextField!
    @IBOutlet weak var commentLoggedText: UITextField!
    @IBOutlet weak var dateLoggedText: UITextField!
    @IBOutlet weak var timeLoggedText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTime()
        setDate()
    

        if let goodMood = incomingMood {
            moodLoggedText.text = goodMood.mood
            activityLoggedText.text = goodMood.activities
            commentLoggedText.text = goodMood.comment
            dateLoggedText.text = goodMood.date
            print(goodMood.date)
        }
        
    }
    
    func setTime(){
        
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.none
        dateformatter.timeStyle = DateFormatter.Style.short
        let time = dateformatter.string(from: NSDate() as Date)
        timeLoggedText.text = time

    }
    
    func setDate(){
        
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.short
        dateformatter.timeStyle = DateFormatter.Style.none
        let now = dateformatter.string(from: NSDate() as Date)
        
        dateLoggedText.text = now
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func postMood(_ sender: AnyObject) {
        //Date time to string...

        
        if let goodMood = incomingMood {
            try! realm.write{
                goodMood.mood = moodLoggedText.text!
                goodMood.comment = commentLoggedText.text!
                goodMood.activities = activityLoggedText.text!
                goodMood.date = dateLoggedText.text!
            }
        }else{
            let mood = Mood()
            mood.mood = moodLoggedText.text!
            mood.activities = activityLoggedText.text!
            mood.comment = commentLoggedText.text!
            mood.date = dateLoggedText.text!
            
            
            try! realm.write {
                realm.add(mood)
            }
            
        }
        
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func setTime(_ sender: UITextField) {
        
        // DatePickerPopover appears:
        DatePickerPopover(title: "DatePicker .time 5minInt.")
            .setDateMode(.time)
            .setMinuteInterval(5)
            .setPermittedArrowDirections(.up)
            .setDoneButton(action: { popover, selectedDate in print("selectedDate \(selectedDate)")
                
                let dateformatter = DateFormatter()
                dateformatter.dateStyle = DateFormatter.Style.none
                dateformatter.timeStyle = DateFormatter.Style.short
                let newTime = dateformatter.string(from: selectedDate as Date)
                
                sender.text = newTime
            } )
            .setCancelButton(action: { _, _ in print("cancel")})
            .appear(originView: sender, baseViewController: self)
    }
    @IBAction func setDate(_ sender: UITextField) {
                /// DatePickerPopover appears:
                let p = DatePickerPopover(title: "Clearable DatePicker")
                    .setLocale(identifier: "en_GB") //en_GB is dd-MM-YYYY. en_US is MM-dd-YYYY. They are both in English.
                    .setDoneButton(action: { popover, selectedDate in print("selectedDate \(selectedDate)")
                        
                        let dateformatter = DateFormatter()
                        dateformatter.dateStyle = DateFormatter.Style.short
                        dateformatter.timeStyle = DateFormatter.Style.none
                        let changed = dateformatter.string(from: selectedDate as Date)
                        sender.text = changed
                    } )
        
                    .setCancelButton(action: { _, _ in print("cancel")})
                    .setClearButton(action: { popover, selectedDate in
                        print("clear")
                        //Rewind
                        popover.setSelectedDate(Date()).reload()
                        //Instead, hide it.
                        //                popover.disappear()
                    })
        
                p.appear(originView: sender, baseViewController: self)
                p.disappearAutomatically(after: 3.0)
    }
    
    
    @IBAction func addMood(_ sender: UITextField) {
        StringPickerPopover(title: "Add Mood", choices: ["Great","Good", "Meh", "Sad", "Awful"])
            .setDoneButton(action: { popover, selectedRow, selectedString in
                sender.text = selectedString
            })
            .appear(originView: sender, baseViewController: self)
    }
    
    
    @IBAction func addActivity(_ sender: UITextField) {
        StringPickerPopover(title: "Add Activity", choices: ["Work","Friends", "Relax", "Date", "Sports", "Shopping", "Gaming", "Reading", "Relaxing", "Travelling", "Cleaning", "Cooking", "Other"])
            .setDoneButton(action: { popover, selectedRow, selectedString in
                sender.text = selectedString
            })
            .appear(originView: sender, baseViewController: self)
    }



}
