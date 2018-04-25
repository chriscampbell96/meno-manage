//
//  ChangeTagViewController.swift
//  meno-manage
//
//  Created by Chris Campbell on 16/04/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit

class ChangeTagViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate  {
    
    
    let titles: [String] = ["Health", "Food", "Diet", "Symptoms","Stress Relief"]
    let values: [String] = ["Health Posts","Food Posts","Diet Posts","Symptom Posts","Stress Posts"]
    
    @IBOutlet var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "changeTag", for: indexPath) as? ChangeTagTableViewCell else { return UITableViewCell() }
        cell.title.text = titles[indexPath.row]
        cell.desc.text = values[indexPath.row]
        return cell
    }

}
