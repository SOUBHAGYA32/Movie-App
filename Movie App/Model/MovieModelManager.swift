//
//  MovieModelManager.swift
//  Movie App
//
//  Created by Muvi on 28/09/22.
//

import Foundation

struct MovieManager {
    let baseUrl = "https://api.themoviedb.org/3/movie"
    let apiKey = "babf838380288ebe26ed74b72d96a9f9" //https://api.themoviedb.org/3/movie/top_rated?api_key=babf838380288ebe26ed74b72d96a9f9
    
    func getTopRatedMovies(genre: String){
        
        let urlString = "\(baseUrl)/\(genre)?api_key=\(apiKey)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                            
                if let safeData = data {
                    let movieData = self.
                }
                            
            }
        task.resume()
        }
    }
    
   
