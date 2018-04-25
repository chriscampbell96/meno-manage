//
//  FilterTagsViewController.swift
//  meno-manage
//
//  Created by Chris Campbell on 25/04/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit

class FilterTagsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func switchView(_ sender: UISegmentedControl) {
        
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HealthResCell", for: indexPath) as? HealthTableViewCell else { return UITableViewCell() }
        return cell
    }
    
}
