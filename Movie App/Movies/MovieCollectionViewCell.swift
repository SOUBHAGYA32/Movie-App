//
//  MovieCollectionViewCell.swift
//  Movie App
//
//  Created by Muvi on 29/09/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieImage.contentMode = .scaleToFill
    }
}
