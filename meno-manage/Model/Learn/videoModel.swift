//
//  videoModel.swift
//  meno-manage
//
//  Created by Christopher Campbell on 16/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit
import Alamofire

class videoModel: NSObject {
    
    let API_KEY = "AIzaSyBIa0q2McdseZ08mAWY5i8H9--3Vc5eKKA"
    let PLAYLIST_ID = "PLPS5nXWnJacv_gVQKoNBX9MLRLKR7PLlS"
    let YOUTUBE_URL = "https://www.googleapis.com/youtube/v3/playlistItems"

    func getFeedVideos(){
        
//        Alamofire.request(url: "https://www.googleapis.com/youtube/v3/playlistItems", method:, parameters: ["part":"snippet","playlistID":PLAYLIST_ID,"key":API_KEY], encoding: JSONEncoding.default, headers: nil)
//
    }
    
    func getVideos() -> [Video] {
        
        var videos = [Video]()
        
        let video1 = Video()
        
        video1.videoId = "l49i60tFbkU"
        video1.videoTitle = "Menopause"
        video1.videoDescription = "test desciption"
        
        videos.append(video1)
        return videos
        
    }

}
