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
        titleLabel.text = movies?.vName
        rankLabel.text = ("\(movies!.vRank)")
        movieImage.image = UIImage(named: "imageNotAvailable")
    }
}
