//
//  OnboardCollectionViewCell.swift
//  Movie App
//
//  Created by Muvi on 30/09/22.
//

import UIKit

class OnboardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sliderImage: UIImageView!
    
    @IBOutlet weak var headerName: UILabel!
    @IBOutlet weak var headerDetails: UILabel!
    
    func setupSlide(_ slide: OnboardingSlide){
        sliderImage.image = UIImage(named: slide.image)
        headerName.text = slide.title
        headerDetails.text = slide.description
    }
    
}
