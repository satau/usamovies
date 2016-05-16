//
//  MoviesTVC.swift
//  USAMovies
//
//  Created by Sherrie Ann Auer on 16/05/16.
//  Copyright © 2016 Sherrie Ann Auer. All rights reserved.
//

import UIKit

class MoviesTVC: UITableViewController {

    var videos = [Movies] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        case WIFI : view.backgroundColor = UIColor.greenColor()
        case WWAN : view.backgroundColor = UIColor.yellowColor()
        default:return
        }
        
    }
    
    // Is called just as the object is about to be deallocated
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let video = videos[indexPath.row]
        cell.textLabel?.text = ("\(indexPath.row + 1)")
        cell.detailTextLabel?.text = video.vName
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
