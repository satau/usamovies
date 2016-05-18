//
//  MoviesDetailsTVC.swift
//  USAMovies
//
//  Created by Sherrie Ann Auer on 18/05/16.
//  Copyright © 2016 Sherrie Ann Auer. All rights reserved.
//

import UIKit

class MoviesDetailsTVC: UIViewController {
    
    @IBOutlet weak var vName: UILabel!
    @IBOutlet weak var vRights: UILabel!
    @IBOutlet weak var vGenre: UILabel!
    @IBOutlet weak var vMovieImage: UIImageView!
    @IBOutlet weak var vPrice: UILabel!
    
    var movie : Movies!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = movie.vArtist
        vName.text = movie.vName
        vRights.text = movie.vRights
        vGenre.text = movie.vGenre
        vPrice.text = movie.vPrice
        
        if movie.vImageData != nil {
            vMovieImage.image = UIImage(data: movie.vImageData!)
        }else{
            vMovieImage.image = UIImage(named: "imageNotAvailable")
        }
        
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
