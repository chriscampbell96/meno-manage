//
//  SignUpViewController.swift
//  meno-manage
//
//  Created by Christopher Campbell on 31/01/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import SwiftKeychainWrapper

class SignUpViewController: UIViewController {

    
    var ref = Database.database().reference()

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var signUp: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func storeUserData(userId: String) {
        self.ref.child("users").child(userId).setValue(["username": username.text])
        
    }

    @IBAction func signUpPressed(_ sender: Any) {
        if let eml = email.text, let pword = password.text {
            
            Auth.auth().createUser(withEmail: eml, password: pword) { (user, error) in
                if error != nil {
                    let alert = UIAlertController(title: "There was a problem", message: error?.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Fix the error", style: .default, handler: nil)
                    
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }else {
//                    go sign in error message
//                    for now just sign up user with new creds
                    self.storeUserData(userId: (user?.uid)!)
                    KeychainWrapper.standard.set((user?.uid)!, forKey: "KEY_UID")
                    self.performSegue(withIdentifier: "addProfile", sender: nil)
                     print("user created")
                }
            }
            
        }
    }
    
}
