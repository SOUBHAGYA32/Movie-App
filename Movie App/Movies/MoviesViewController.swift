//
//  MoviesViewController.swift
//  Movie App
//
//  Created by Muvi on 29/09/22.
//

import UIKit
import SDWebImage
class MoviesViewController: UIViewController {
    
    
    //MARK: Movie Array Empty Initialize
    var movieData : [Movie] = []
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var movieLoader: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //MARK: Activity Indicator Hidden
        self.movieLoader.isHidden = true
        self.movieLoader.hidesWhenStopped = true
        
        self.movieCollectionView.delegate = self
        self.movieCollectionView.dataSource = self
        getAllMovies()
    }
    
    
    //MARK: Movie API Call
    func getAllMovies() {
        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=babf838380288ebe26ed74b72d96a9f9&with_genres=28&api_key=babf838380288ebe26ed74b72d96a9f9"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        self.movieLoader.isHidden = false
        
        //MARK: Show the Activity Indicator Before API Call
        self.movieLoader.startAnimating()
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: data)
                guard let apiResults = apiResponse.movieArray else { return }
                self.movieData = apiResults
                DispatchQueue.main.async {
                    self.movieCollectionView.reloadData()
                    //MARK: Stop The Loader
                    self.movieLoader.stopAnimating()
                }
            } catch {
                print("Error In API fetch")
            }
        }
        task.resume()
    }
}
extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        
        //MARK: Load Banner image from URL
        if let url = URL(string: "https://image.tmdb.org/t/p/original\(self.movieData[indexPath.item].moviePoster ?? "")"){
            cell.movieImage.sd_setImage(with: url)
            cell.movieImage.contentMode = .scaleToFill
            cell.movieImage.clipsToBounds = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 40) / 2, height: (collectionView.bounds.width - 40) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.openDetailsVC(indexPath)
    }
    
    func openDetailsVC(_ indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        navigationController?.present(nextViewController, animated: true)
        if let movieName = movieData[indexPath.item].movieName {
            nextViewController.movieNameLabel.text = movieName
        }
        if let movieDetails = movieData[indexPath.item].overview {
            nextViewController.overview.text = movieDetails
        }
        if let url = URL(string: "https://image.tmdb.org/t/p/original\(self.movieData[indexPath.item].moviePoster ?? "")"){
            nextViewController.posterImage.sd_setImage(with: url)
            nextViewController.posterImage.contentMode = .scaleToFill
            nextViewController.posterImage.clipsToBounds = true
        }
    }
}
