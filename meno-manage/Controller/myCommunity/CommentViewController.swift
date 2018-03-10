//
//  CommentTableViewController.swift
//  meno-manage
//
//  Created by Christopher Campbell on 08/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class CommentViewController: UITableViewController {
    var post: Post!
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getPost()
        getComments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        getComments()
        addView()
        print("ran")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toCommentPost"?:
            let destination = segue.destination as! CommentPostViewController
            destination.passedPostId = self.post.postKey
        default:
            return
        }
    }
    
    func getPost(){
        
    }
    
    func getComments() {
        Database.database().reference().child("postText").child(post.postKey).child("comments").observeSingleEvent(of: .value) { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            self.posts.removeAll()
            for data in snapshot.reversed() {
                guard let postDict = data.value as? Dictionary<String, AnyObject> else { return }
                let post = Post(postKey: data.key, postData: postDict)
                self.posts.append(post)
            }
            self.tableView.reloadData()
        }
    }
    
    func addView(){
//        Database.database().reference().child("postText").child(post.postKey).setValue(["views": +1])
        let postViews = Database.database().reference().child("postText").child(post.postKey).child("views")

        Database.database().reference().child("postText").child(post.postKey).updateChildValues(["views": +1    ])
    

        print(postViews)
        print("added")
    
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell else { return UITableViewCell() }
        cell.configCell(post: posts[indexPath.row])
        return cell
    }
    
    @IBAction func goToComment(_ sender: AnyObject) {
        performSegue(withIdentifier: "toCommentPost", sender: nil)
    }


}
