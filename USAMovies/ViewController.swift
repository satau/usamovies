//
//  ViewController.swift
//  USAMovies
//
//  Created by Sherrie Ann Auer on 15/05/16.
//  Copyright © 2016 Sherrie Ann Auer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var videos = [Movies] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmovies/limit=10/json", completion: didLoadData)
    }
    
    func didLoadData(videos: [Movies]) {
        self.videos = videos
        for item in videos{
            print("name = \(item.vName)")
        }
        
        for (index, item) in videos.enumerate() {
            print("\(index) name = \(item.vName)")
        }
        
        print(reachabilityStatus)
        
    }
}

