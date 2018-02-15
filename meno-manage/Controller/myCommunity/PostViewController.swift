//
//  PostViewController.swift
//  meno-manage
//
//  Created by Christopher Campbell on 08/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController {
    
    @IBOutlet weak var postText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    @IBAction func post(_ sender: AnyObject) {
        let userID = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let data = snapshot.value as? Dictionary<String, AnyObject>
            let username = data?["username"]
            let likes = 0
            let views = 0
            
            let post: Dictionary<String, AnyObject> = [
                "likes": likes as AnyObject,
                "views": views as AnyObject,
                "uid": userID as AnyObject,
                "username": username as AnyObject,
                "postText": self.postText.text as AnyObject
            ]
            
            let firebasePost = Database.database().reference().child("postText").childByAutoId()
            firebasePost.setValue(post)
            _ = self.navigationController?.popViewController(animated: true)
        }) { (error) in
            print(error.localizedDescription)
        }
    }

}

//postSuccess
