//
//  DataManager.swift
//  Reader
//
//  Created by Francesco Marisaldi on 03/03/17.
//  Copyright © 2017 Francesco Marisaldi. All rights reserved.
//

import UIKit
import MWFeedParser

class DataManager: NSObject {
    
    static let shared = DataManager()
    
    var feedsArray : [MWFeedInfo] = []
    var favoritesArray : [FavoriteItem] = []
    
    var feedsPath : String {
        return documentsPath() + "/../feeds.plist"
    }
    
    var favoritesPath : String {
        return documentsPath() + "/../favorites.plist"
    }
    
    func initDataManager() {
        if FileManager.default.fileExists(atPath: feedsPath) {
            print("true")
            feedsArray = NSKeyedUnarchiver.unarchiveObject(withFile: feedsPath) as! [MWFeedInfo]
        }
        if FileManager.default.fileExists(atPath: favoritesPath) {
            favoritesArray = NSKeyedUnarchiver.unarchiveObject(withFile: favoritesPath) as! [FavoriteItem]
        }
    }
    
    func saveFeeds() {
        NSKeyedArchiver.archiveRootObject(feedsArray, toFile: feedsPath)
    }
    
    func deleteFeed(atIndex index: Int) {
        if (feedsArray.count > index) {
            feedsArray.remove(at: index)
            saveFeeds()
        }
    }
    
    func saveFavorites() {
        NSKeyedArchiver.archiveRootObject(favoritesArray, toFile: favoritesPath)
    }
    
    func deleteFavorite(atIndex index: Int) {
        if (favoritesArray.count > index) {
            favoritesArray.remove(at: index)
            saveFavorites()
        }
    }
    
    func documentsPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print("the paths are", paths[0])
        return paths[0] as String
    }
    
}
