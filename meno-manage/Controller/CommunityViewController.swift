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

class CommunityViewController: UITableViewController {
    
    var posts = [Post]()
    var selectedPost: Post!
    

//testing GIT
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        getUsersData()
        getPosts()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(logoutPress))
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;//Choose your custom row height
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        Database.database().reference().child("postText").observeSingleEvent(of: .value) { (snapshot) in
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
        let post = posts[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            cell.configCell(post: post)
            return cell
        }else{
            return PostCell()
        }
    }

    
    @IBAction func logoutPress(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: "uid")
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        dismiss(animated: true, completion: nil)
    }

}
