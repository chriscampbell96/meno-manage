//
//  ProfileViewController.swift
//  meno-manage
//
//  Created by Christopher Campbell on 01/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import MWFeedParser
import DZNEmptyDataSet
import SafariServices

class HomeViewController: UITableViewController, MWFeedParserDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    var feedInfo: MWFeedInfo?
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor.red

        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40.0, height: 40.0)
        activityIndicator.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        activityIndicator.color = #colorLiteral(red: 0.9998200536, green: 0.8243951201, blue: 0.9795039296, alpha: 1)
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    override func viewDidAppear(_ animated: Bool) {
         print(DataManager.shared.feedsArray)
        print(DataManager.shared.feedsArray.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showAddFeedAlert() {
        let fieldAlert = MyUIAlertController(title: "New Feed", message: "Enter the url of the feed you want to add", preferredStyle: UIAlertControllerStyle.alert)
        
        fieldAlert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "URL"
            textField.isSecureTextEntry = false
        })
        
        fieldAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        fieldAlert.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler: {(action) in
            guard let field = fieldAlert.textFields?.first else { return }
            if let url = field.text {
                self.initParser(withFeed: url)
            }
        }))
        
        present(fieldAlert, animated: true, completion: nil)
    }
    
    
    func initParser(withFeed feed: String) {
        activityIndicator.startAnimating()
        let feedParser : MWFeedParser! = MWFeedParser(feedURL: URL(string: feed))
        feedParser.delegate = self
        feedParser.feedParseType = ParseTypeInfoOnly
        feedParser.connectionType = ConnectionTypeAsynchronously
        feedParser.parse()
    }
    
    func feedParserDidStart(_ parser: MWFeedParser!) {
        feedInfo = nil
    }
    
    func feedParserDidFinish(_ parser: MWFeedParser!) {
        if let currentFeed = feedInfo {
            if ProcessInfo.processInfo.isOperatingSystemAtLeast(OperatingSystemVersion(majorVersion: 10, minorVersion: 0, patchVersion: 0)) {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
            DataManager.shared.feedsArray.append(currentFeed)
            DataManager.shared.saveFeeds()
            activityIndicator.stopAnimating()
            tableView.reloadData()
        }
    }
    
    func feedParser(_ parser: MWFeedParser!, didParseFeedInfo info: MWFeedInfo!) {
        debugPrint(info.title+" "+info.summary+" "+info.link)
        feedInfo = info
    }
    
    func feedParser(_ parser: MWFeedParser!, didFailWithError error: Error!) {
        let simpleAlert = MyUIAlertController(title: "Error!", message: error.localizedDescription, preferredStyle: .alert)
        simpleAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        present(simpleAlert, animated: true, completion: nil)
        activityIndicator.stopAnimating()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(DataManager.shared.feedsArray)
        return DataManager.shared.feedsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        let feed = DataManager.shared.feedsArray[indexPath.row]
        
        cell.labelTitle.text = feed.title
        cell.labelDescription.text = feed.summary
        cell.labelLink.text = feed.link
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataManager.shared.deleteFeed(atIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadEmptyDataSet()
        }   
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFeed" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let feedController = segue.destination as! FeedViewController
                feedController.feed = DataManager.shared.feedsArray[indexPath.row]
            }
        } else if let cell = sender as? UITableViewCell, segue.identifier == "showFeedPeek" {
            if let indexPath = tableView.indexPath(for: cell) {
                let feedController = segue.destination as! FeedViewController
                feedController.feed = DataManager.shared.feedsArray[indexPath.row]
            }
        }
    }

    // MARK: - Actions
    
    @IBAction func addFeedAction(_ sender: UIBarButtonItem) {
        showAddFeedAlert()
    }
    
    
    private func image(forEmptyDataSet scrollView: UIScrollView!) -> String! {
        return  "Please enter..."
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Sorry Your Feed Is Empty!", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18.0), NSAttributedStringKey.foregroundColor: UIColor.darkGray])
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        return NSAttributedString(string: "Add your first feed", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16.0), NSAttributedStringKey.foregroundColor: UIColor.darkGray])
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.groupTableViewBackground
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        showAddFeedAlert()
    }

}
