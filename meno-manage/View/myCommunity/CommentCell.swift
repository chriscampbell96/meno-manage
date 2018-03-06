//
//  CommentCell.swift
//  meno-manage
//
//  Created by Christopher Campbell on 08/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper


class CommentCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var commentBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postText.text = ""

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    var post: Post!
    let currentUser = KeychainWrapper.standard.string(forKey: "uid")
    
    func configCell(post: Post) {
        self.post = post
        self.username.text = "@" + post.username
        self.postText.text = post.postText
        
    }
}
