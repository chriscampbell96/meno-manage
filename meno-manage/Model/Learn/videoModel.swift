//
//  videoModel.swift
//  meno-manage
//
//  Created by Christopher Campbell on 16/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit

class videoModel: NSObject {
    
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
