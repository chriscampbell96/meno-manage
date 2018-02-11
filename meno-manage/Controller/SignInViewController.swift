//
//  SignInViewController.swift
//  meno-manage
//
//  Created by Christopher Campbell on 31/01/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper


class SignInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signIn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        if let _ = KeychainWrapper.standard.string(forKey: "uid"){
//            self.performSegue(withIdentifier: "toHome", sender: nil)
//        }
//
//    }

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
 

    @IBAction func signInPress(_ sender: Any) {

        if let eml = email.text, let pword = password.text {
            Auth.auth().signIn(withEmail: eml, password: pword) { (user, error) in
                if error != nil {
                    let alert = UIAlertController(title: "There was a problem", message: error?.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Fix the error", style: .default, handler: nil)
                    
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                    
                    }else {

                    if (user?.uid) != nil {
                    KeychainWrapper.standard.set((user?.uid)!, forKey: "uid")
                    self.performSegue(withIdentifier: "toHome", sender: nil)
                    //PRINT IN CONSOLE
                    print("user signedin")
                    }
                }
            }
            
        }
    }
}


