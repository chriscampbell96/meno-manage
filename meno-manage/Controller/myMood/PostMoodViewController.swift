//
//  PostMoodViewController.swift
//  meno-manage
//
//  Created by Christopher Campbell on 13/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import RealmSwift


class PostMoodViewController: UIViewController {
    
    let realm = try! Realm()
    var incomingMood: Mood? = nil


    
    
    @IBOutlet weak var moodLoggedText: UITextField!
    
    @IBOutlet weak var activitiesLoggedText: UITextView!
    
    @IBOutlet weak var commentLoggedText: UITextView!
    
    @IBOutlet weak var dateLoggedLBL: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let goodMood = incomingMood {
            moodLoggedText.text = goodMood.mood
            activitiesLoggedText.text = goodMood.activities
            commentLoggedText.text = goodMood.comment
//            dateLoggedLBL.text = goodMood.date
            print(goodMood.date)

        }

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postMood(_ sender: AnyObject) {
        //Date time to string...
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.short
        dateformatter.timeStyle = DateFormatter.Style.short
        let now = dateformatter.string(from: NSDate() as Date)
        
        if let goodMood = incomingMood {
            try! realm.write{
                goodMood.mood = moodLoggedText.text!
                goodMood.comment = commentLoggedText.text!
                goodMood.activities = activitiesLoggedText.text!
            }
        }else{
            let mood = Mood()
            mood.mood = moodLoggedText.text!
            mood.activities = activitiesLoggedText.text!
            mood.comment = commentLoggedText.text!
            mood.date = now

            
            try! realm.write {
                realm.add(mood)
            }
            
        }

        
        navigationController?.popViewController(animated: true)
    }
    

}
