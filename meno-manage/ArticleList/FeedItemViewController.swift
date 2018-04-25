//
//  HealthTableViewCell.swift
//  meno-manage
//
//  Created by Chris Campbell on 07/04/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit

class FeedItemViewController: UIViewController {

    var selectedFeedURL: String?
    @IBOutlet var myWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedFeedURL =  selectedFeedURL?.replacingOccurrences(of: " ", with:"")
        selectedFeedURL =  selectedFeedURL?.replacingOccurrences(of: "\n", with:"")
        myWebView.loadRequest(URLRequest(url: URL(string: selectedFeedURL! as String)!))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
