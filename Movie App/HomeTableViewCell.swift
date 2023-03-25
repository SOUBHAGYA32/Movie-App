//
//  HomeTableViewCell.swift
//  Movie App
//
//  Created by Muvi on 26/09/22.
//

import UIKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {
    
    var movieData : [MovieData] = []
    var vc: HomeViewController?

    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.homeCollectionView.delegate = self
        self.homeCollectionView.dataSource = self
//        self.homeCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData( data : [MovieData]){
        self.movieData = data
        self.homeCollectionView.reloadData()
    }
    
}
extension HomeTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    //MARK: Movie Count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // MARK: Homecollection Cell
        let homeCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! HomeCollectionViewCell
        // MARK: Load images from URL String //https://image.tmdb.org/t/p/original\(self.movieData[indexPath.item].posterPath ?? "")
        if let url = URL(string: "https://image.tmdb.org/t/p/original\(self.movieData[indexPath.item].posterPath ?? "")") {
            homeCollectionCell.movieImage.sd_setImage(with: url)
        }
        return homeCollectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc?.present(nextViewController, animated: true)
        nextViewController.movieNameLabel.text = movieData[indexPath.row].name
        nextViewController.overview.text = movieData[indexPath.row].overview
        if let url = URL(string: "https://image.tmdb.org/t/p/original\(movieData[indexPath.row].posterPath ?? "")"){
            nextViewController.posterImage.sd_setImage(with: url)
        }
    }
}
