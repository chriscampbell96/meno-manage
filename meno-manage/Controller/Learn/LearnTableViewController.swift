//
//  LearnTableViewController.swift
//  meno-manage
//
//  Created by Christopher Campbell on 16/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit


class LearnTableViewController: UITableViewController {

    var videos: [Video] = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.videos = videoModel().getVideos()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.size.width / 320) * 180
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return videos.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell")!
        
        let videoTitle = videos[indexPath.row].videoTitle
        
        
        //thumbnail URL
        let videoThumbnailString = "https://i1.ytimg.com/vi/" + videos[indexPath.row].videoId + "/mqdefault.jpg"
        
        let videoThumbnailUrl = NSURL(string: videoThumbnailString)
        
        if videoThumbnailUrl != nil {
            let request = URLRequest(url: videoThumbnailUrl! as URL)
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request, completionHandler: {(URLResponse, Data, Error) -> Void in
                
                DispatchQueue.main.async {
                    let imageView = cell.viewWithTag(1) as! UIImageView
                    
                    imageView.image = UIImage(data: URLResponse!)
                }

            })
            
            dataTask.resume()
        }
        
        
        
        
        cell.textLabel?.text = videoTitle
        
        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
