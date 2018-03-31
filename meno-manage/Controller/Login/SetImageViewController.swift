//
//  SetImageViewController.swift
//  meno-manage
//
//  Created by Christopher Campbell on 05/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import ResearchKit

class SetImageViewController: UIViewController, ORKTaskViewControllerDelegate  {
    


    
    var selectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = KeychainWrapper.standard.string(forKey: "uid") {
            self.performSegue(withIdentifier: "toFeed", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func consentClicked(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        taskViewController.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "toHome", sender: nil)

    }
    
    
}
