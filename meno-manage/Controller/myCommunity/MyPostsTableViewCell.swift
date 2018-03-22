//
//  MyPostsTableViewCell.swift
//  meno-manage
//
//  Created by Chris Campbell on 22/03/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class MyPostsTableViewCell: UITableViewCell {

    @IBOutlet weak var postsTitle: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postPost: UILabel!
    
    var post: Post!
    let currentUser = KeychainWrapper.standard.string(forKey: "uid")
    
    func configCell(post: Post) {
        self.post = post
        self.postsTitle.text = "@" + post.username
        self.postDate.text = post.postTitle
        self.postPost.text = post.postText
        
    }
}
