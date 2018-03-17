//
//  ArticleListTableViewController.swift
//  meno-manage
//
//  Created by Chris Campbell on 17/03/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit

class ArticleListTableViewController: UITableViewController {
    
    let webTitles = ["www.menopausepro.com", "sample 2", "sample 3", "sample 4"]
    let goTo = ["menoPro", "sample 2", "sample 3", "sample 4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return webTitles.count
    }
    



    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let webTits = webTitles[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "publisherView") as? PublisherTableViewCell {
            cell.websiteTitle.text = webTitles[indexPath.row]
            cell.toFeed.addTarget(self, action: #selector(toFeed(_:)), for: .touchUpInside)
        
            return cell
        }else{
            return PublisherTableViewCell()
        }
    }
    
    @objc func toFeed(_ sender: AnyObject) {
        
//        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
//        let indexPath: IndexPath? =  tableView.indexPathForRow(at: buttonPosition)
        
//        selectedFeed = goTo[(indexPath?.row)!]
        performSegue(withIdentifier: "toFeed", sender: nil)
        
    }
    
        
//        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let post = posts[indexPath.row]
//            if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
//                cell.configCell(post: post)
//                refreshControl?.endRefreshing()
//                cell.commentBtn.addTarget(self, action: #selector(toComments(_:)), for: .touchUpInside)
//                return cell
//            }else{
//                return PostCell()
//            }
//        }

}
