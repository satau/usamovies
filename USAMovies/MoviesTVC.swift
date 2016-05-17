//
//  MoviesTVC.swift
//  USAMovies
//
//  Created by Sherrie Ann Auer on 16/05/16.
//  Copyright © 2016 Sherrie Ann Auer. All rights reserved.
//

import UIKit

class MoviesTVC: UITableViewController {

    var movies = [Movies] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // compile time swift version checking
        #if swift(>=2.2)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MoviesTVC.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        #else
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        #endif
        
        
        #if swift(>=2.2)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MoviesTVC.preferredFontChanged), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        #else
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        #endif
        
        self.tableView.rowHeight = 120.0
        reachabilityStatusChanged()
        
    }
    
    func didLoadData(movies: [Movies]) {
        self.movies = movies
        for item in movies{
            print("name = \(item.vName)")
        }
        for (index, item) in movies.enumerate() {
            print("\(index) name = \(item.vName)")
        }
        tableView.reloadData()
    }
    
    func preferredFontChanged(){
        print("preferred font is changed")
    }
    
    func reachabilityStatusChanged(){
        switch reachabilityStatus {
        case NOACCESS :
            //view.backgroundColor = UIColor.redColor()
            
            //move back to main queue
            dispatch_async(dispatch_get_main_queue()) {
                let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .Alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
                    action -> () in
                    print("Cancel")
                }
                let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) {
                    action -> () in
                    print("delete")
                }
                let okAction = UIAlertAction(title: "Ok", style: .Default) {
                    action -> Void in
                    print("OK")
                }
                alert.addAction(cancelAction)
                alert.addAction(okAction)
                alert.addAction(deleteAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
        default:
            //view.backgroundColor = UIColor.greenColor()
            print(movies.count)
            if movies.count > 0 {
                print("do not refresh API")
            }else{
                runAPI()
            }
        }
    }
    
    func runAPI(){
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmovies/limit=100/json", completion: didLoadData)
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
        return movies.count
    }
    
    private struct storyboard {
        static let cellReuseIndentifier = "cell"
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIndentifier, forIndexPath: indexPath) as! MoviesTableViewCell
        cell.movies = movies[indexPath.row]
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
