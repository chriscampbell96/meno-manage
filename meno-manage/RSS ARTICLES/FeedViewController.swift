//
//  ProfileViewController.swift
//  meno-manage
//
//  Created by Christopher Campbell on 01/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import MWFeedParser
import SafariServices

class FeedViewController: UITableViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, MWFeedParserDelegate, UIViewControllerPreviewingDelegate {
    
    var feed: MWFeedInfo?
    var feedParser: MWFeedParser!
    var feedItems: [MWFeedItem] = []
    var formatter: DateFormatter = DateFormatter()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var longPress : UILongPressGestureRecognizer!
    var showEmptyData = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 92.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = #colorLiteral(red: 0.7501883494, green: 0.1651857008, blue: 0.7452709142, alpha: 1)
        refreshControl?.addTarget(self, action: #selector(initParser), for: .valueChanged)
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40.0, height: 40.0)
        activityIndicator.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        activityIndicator.color = #colorLiteral(red: 0.7501883494, green: 0.1651857008, blue: 0.7452709142, alpha: 1)
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
        
        longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPress.minimumPressDuration = 0.8
        tableView.addGestureRecognizer(longPress)
        
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        initParser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh() {
        feedItems = []
        feedParser.stopParsing()
        initParser()
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        let point = gestureRecognizer.location(in: tableView)
        if let indexPath = tableView.indexPathForRow(at: point), gestureRecognizer.state == .began {
            if ProcessInfo.processInfo.isOperatingSystemAtLeast(OperatingSystemVersion(majorVersion: 10, minorVersion: 0, patchVersion: 0)) {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
            let item = FavoriteItem(from: feedItems[indexPath.row], feedName: feed?.title)
            DataManager.shared.favoritesArray.insert(item, at: 0)
            DataManager.shared.saveFavorites()
            let simpleAlert = MyUIAlertController(title: "New favorite", message: "Item successfully added to your favorites", preferredStyle: .alert)
            simpleAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            present(simpleAlert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Feed parser delegate
    
    @objc func initParser() {
        if let currentFeed = feed {
            refreshControl?.isRefreshing == false ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
            let feedParser : MWFeedParser! = MWFeedParser(feedURL: currentFeed.url)
            feedParser.delegate = self
            feedParser.feedParseType = ParseTypeItemsOnly
            feedParser.connectionType = ConnectionTypeAsynchronously
            feedParser.parse()
        }
    }
    
    func feedParserDidStart(_ parser: MWFeedParser!) {
        feedItems = []
    }
    
    func feedParser(_ parser: MWFeedParser!, didParseFeedItem item: MWFeedItem!) {
        if let currentItem = item {
            feedItems.append(currentItem)
        }
    }
    
    func feedParserDidFinish(_ parser: MWFeedParser!) {
        showEmptyData = true
        activityIndicator.stopAnimating()
        refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    func feedParser(_ parser: MWFeedParser!, didFailWithError error: Error!) {
        let simpleAlert = MyUIAlertController(title: "Error!", message: error.localizedDescription, preferredStyle: .alert)
        simpleAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        present(simpleAlert, animated: true, completion: nil)
        showEmptyData = true
        activityIndicator.stopAnimating()
        refreshControl?.endRefreshing()
        tableView.reloadEmptyDataSet()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let item = feedItems[indexPath.row]
        
        cell.labelTitle.text = item.title
        cell.labelSummary.text = item.summary
        cell.labelDate.text = formatter.string(from: item.date)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = feedItems[indexPath.row]
        let detailController = SFSafariViewController(url: URL(string: item.link)!, entersReaderIfAvailable: true)
        detailController.preferredControlTintColor = #colorLiteral(red: 0.7501883494, green: 0.1651857008, blue: 0.7452709142, alpha: 1)
        navigationController?.present(detailController, animated: true, completion: nil)
    }
        
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return  #imageLiteral(resourceName: "EmptyItemsIcon")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "It seems that feed hasn't any item...", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18.0), NSAttributedStringKey.foregroundColor: UIColor.darkGray])
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        return NSAttributedString(string:"Try again", attributes:[NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize:16.0), NSAttributedStringKey.foregroundColor:UIColor.red])
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.groupTableViewBackground
    }
    
    // MARK: - DZNEmptyDataSet delegate
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return showEmptyData
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        refresh()
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if presentedViewController is SFSafariViewController {
            return nil
        }
        
        let cellPosition = tableView.convert(location, from: view)
        if let path = tableView.indexPathForRow(at: cellPosition) {
            guard let cell = tableView.cellForRow(at: path) else { return nil }
            let item = feedItems[path.row]
            let detailController = SFSafariViewController(url: URL(string: item.link)!, entersReaderIfAvailable: true)
            detailController.preferredControlTintColor = #colorLiteral(red: 0.7501883494, green: 0.1651857008, blue: 0.7452709142, alpha: 1)
            previewingContext.sourceRect = view.convert(cell.frame, from: view)
            return detailController
        }
        
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        present(viewControllerToCommit, animated: true, completion: nil)
    }
    
}
