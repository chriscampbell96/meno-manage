//
//  MyUIAlertController.swift
//  Reader
//
//  Created by Francesco Marisaldi on 15/04/17.
//  Copyright © 2017 Francesco Marisaldi. All rights reserved.
//

import UIKit

class MyUIAlertController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.tintColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
