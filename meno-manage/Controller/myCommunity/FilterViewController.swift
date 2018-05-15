//
//  CommunityViewController.swift
//  meno-manage
//
//  Created by Christopher Campbell on 05/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FilterViewController: UITableViewController {
    
    var posts = [Post]()
    var selectedPost: Post!
    let uid = KeychainWrapper.standard.string(forKey: "uid")

    
    //testing GIT
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        getUsersData()
        getPosts()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
        getPosts()
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0;//Choose your custom row height
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toComments"?:
            let destination = segue.destination as! CommentViewController
            destination.post = self.selectedPost
        default:
            return
        }
    }
    
    func getUsersData(){
        let uid = KeychainWrapper.standard.string(forKey: "uid")
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value) { (snapshot) in
            if (snapshot.value as? [String : AnyObject]) != nil {
                self.tableView.reloadData()
            }
        }
    }
    
    func getPosts() {
        Database.database().reference().child("postText").queryOrdered(byChild: "postCat").queryEqual(toValue : "Medication").observeSingleEvent(of: .value) { (snapshot) in
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
    
    
    func getPostsHealth() {
        Database.database().reference().child("postText").queryOrdered(byChild: "postCat").queryEqual(toValue : "Health").observeSingleEvent(of: .value) { (snapshot) in
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
    
    func getPostsMood() {
        Database.database().reference().child("postText").queryOrdered(byChild: "postCat").queryEqual(toValue : "Mood").observeSingleEvent(of: .value) { (snapshot) in
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
    
    func getPostsChat() {
        Database.database().reference().child("postText").queryOrdered(byChild: "postCat").queryEqual(toValue : "Chat").observeSingleEvent(of: .value) { (snapshot) in
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
    
    func getPostsExercise() {
        Database.database().reference().child("postText").queryOrdered(byChild: "postCat").queryEqual(toValue : "Exercise").observeSingleEvent(of: .value) { (snapshot) in
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
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        let post = posts[indexPath.row - 1]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            cell.configCell(post: posts[indexPath.row])
            refreshControl?.endRefreshing()
            cell.commentBtn.addTarget(self, action: #selector(toComments(_:)), for: .touchUpInside)
            return cell
        }else{
            return PostCell()
        }
    }
    
    
    
    
    @objc func toComments(_ sender: AnyObject) {
        
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        let indexPath: IndexPath? =  tableView.indexPathForRow(at: buttonPosition)
        
        selectedPost = posts[(indexPath?.row)!]
        performSegue(withIdentifier: "toComments", sender: nil)
        
    }
    
    
}