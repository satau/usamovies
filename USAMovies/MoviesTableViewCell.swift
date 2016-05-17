//
//  MoviesTableViewCell.swift
//  USAMovies
//
//  Created by Sherrie Ann Auer on 16/05/16.
//  Copyright © 2016 Sherrie Ann Auer. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    var movies: Movies? {
        didSet {
            updateCell()
        }
    }
 
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    func updateCell(){
        
        //preferred font
        rankLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        titleLabel.text = movies?.vName
        rankLabel.text = ("\(movies!.vRank)")
        //movieImage.image = UIImage(named: "imageNotAvailable")
        
        if movies!.vImageData != nil{
            print("get data from the array")
            movieImage.image = UIImage(data: movies!.vImageData!)
        }else{
            print("print images in the background thread")
            GetVideoImage(movies!, imageView: movieImage)
        }
        
        
    }
    
    
    func GetVideoImage(movie: Movies, imageView : UIImageView){
        
        // Background thread
        //  DISPATCH_QUEUE_PRIORITY_HIGH Items dispatched to the queue will run at high priority, i.e. the queue will be scheduled for execution before any default priority or low priority queue.
        //
        //  DISPATCH_QUEUE_PRIORITY_DEFAULT Items dispatched to the queue will run at the default priority, i.e. the queue will be scheduled for execution after all high priority queues have been scheduled, but before any low priority queues have been scheduled.
        //
        //  DISPATCH_QUEUE_PRIORITY_LOW Items dispatched to the queue will run at low priority, i.e. the queue will be scheduled for execution after all default priority and high priority queues have been scheduled.
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let data = NSData(contentsOfURL: NSURL(string: self.movies!.vImageUrl)!)
            
            var image : UIImage?
            if data != nil {
                self.movies!.vImageData = data
                image = UIImage(data: data!)
            }
            
            // move back to Main Queue
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
        }
    }
}
