//
//  ViewController.swift
//  USAMovies
//
//  Created by Sherrie Ann Auer on 15/05/16.
//  Copyright © 2016 Sherrie Ann Auer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var videos = [Movies] ()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var displayLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    
        // compile time swift version checking
        #if swift(>=2.2)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        #else
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        #endif
        
        
        reachabilityStatusChanged()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmovies/limit=50/json", completion: didLoadData)
    }
    
    func didLoadData(videos: [Movies]) {
        self.videos = videos
        for item in videos{
            print("name = \(item.vName)")
        }
        for (index, item) in videos.enumerate() {
            print("\(index) name = \(item.vName)")
        }
        tableView.reloadData()
    }
    
    func reachabilityStatusChanged(){
        switch reachabilityStatus {
        case NOACCESS : view.backgroundColor = UIColor.redColor()
            displayLabel.text = "No Internet"
        case WIFI : view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "Reachable with WIFI"
        case WWAN : view.backgroundColor = UIColor.yellowColor()
            displayLabel.text = "Reachable with Cellular"
        default:return
        }
        
    }
    
    // Is called just as the object is about to be deallocated
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let video = videos[indexPath.row]
        cell.textLabel?.text = ("\(indexPath.row + 1)")
        cell.detailTextLabel?.text = video.vName
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

}

