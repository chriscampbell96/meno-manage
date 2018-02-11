//
//  Post.swift
//  meno-manage
//
//  Created by Christopher Campbell on 05/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import Foundation
import Firebase

class Post {
    private var _username: String!
    private var _postText: String!
    private var _postKey:  String!
    private var _postRef: DatabaseReference!
    
    var username: String {
        return _username
    }
    
    
    var postText: String {
        return _postText
    }
    
    var postKey: String {
        return _postKey
    }
    
    init(postText: String, username: String) {
        _postText = postText
        _username = username
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        _postKey = postKey
        
        if let username = postData["username"] as? String {
            _username = username
        }
        
        
        if let postText = postData["postText"] as? String {
            _postText = postText
        }
        
        _postRef = Database.database().reference().child("posts").child(_postKey)
    }
}
