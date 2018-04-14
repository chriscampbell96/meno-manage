//
//  ProfileViewController.swift
//  meno-manage
//
//  Created by Christopher Campbell on 01/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SafariServices

class FavoritesViewController: UITableViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, UIViewControllerPreviewingDelegate {

    var formatter: DateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = UIColor.red
        navigationItem.rightBarButtonItem = editButtonItem

        tableView.estimatedRowHeight = 92.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.favoritesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let item = DataManager.shared.favoritesArray[indexPath.row]
        
        cell.labelTitle.text = item.title
        cell.labelSummary.text = item.summary
        cell.labelFeed.text = item.feedName
        cell.labelDate.text = formatter.string(from: item.date)

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataManager.shared.deleteFavorite(atIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadEmptyDataSet()
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let temp = DataManager.shared.favoritesArray[fromIndexPath.row]
        DataManager.shared.favoritesArray.remove(at: fromIndexPath.row)
        DataManager.shared.favoritesArray.insert(temp, at: to.row)
        DataManager.shared.saveFavorites()
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = DataManager.shared.favoritesArray[indexPath.row]
        let detailController = SFSafariViewController(url: URL(string: item.link)!, entersReaderIfAvailable: true)
        detailController.preferredControlTintColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        navigationController?.present(detailController, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func closeAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - DZNEmptyDataSet Source
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> String! {
        return  "Test"
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "None favorite here!", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18.0), NSAttributedStringKey.foregroundColor: UIColor.darkGray])
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.groupTableViewBackground
    }
    
    // MARK: - DZNEmptyDataSet Delegate
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return false
    }
    
    // MARK: - 3DTouch delegate
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if presentedViewController is SFSafariViewController {
            return nil
        }
        
        let cellPosition = tableView.convert(location, from: view)
        if let path = tableView.indexPathForRow(at: cellPosition) {
            guard let cell = tableView.cellForRow(at: path) else { return nil }
            let item = DataManager.shared.favoritesArray[path.row]
            let detailController = SFSafariViewController(url: URL(string: item.link)!, entersReaderIfAvailable: true)
            detailController.preferredControlTintColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            previewingContext.sourceRect = view.convert(cell.frame, from: view)
            return detailController
        }
        
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        present(viewControllerToCommit, animated: true, completion: nil)
    }
    
}
