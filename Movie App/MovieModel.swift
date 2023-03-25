//
//  MovieModel.swift
//  Movie App
//
//  Created by Muvi on 28/09/22.
//

import Foundation
import UIKit

struct ApiResponse : Codable {
    var sectionName : String?
    var results : [MovieData]?
    enum CodingKeys : String, CodingKey {
        case results
        case sectionName
    }
}

struct MovieData : Codable {
        var genreIds: [Int]?
        var resultId: Int?
        var originCountry: [String]?
        var popularity: Double
        var posterPath: String?
        var overview: String?
        var originalName: String?
        var originalLanguage: String?
        var voteCount: Int?
        var name: String?
        
        enum CodingKeys: String, CodingKey {
        case genreIds = "genre_ids"
        case resultId = "id"
        case originCountry = "origin_country"
        case popularity
        case posterPath = "poster_path"
        case overview
        case originalName = "original_name"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case name
    }
}

//MARK: Main Movie Model
struct MovieApiResponse : Codable {
    var movieArray : [Movie]?
    enum CodingKeys : String, CodingKey {
        case movieArray = "results"
    }
}

//MARK: Movie Model For Movie View Controller
struct Movie : Codable {
    var overview: String?
    var moviePoster : String?
    var movieName: String?
    
    enum CodingKeys: String, CodingKey {
    case overview = "overview"
    case moviePoster = "poster_path"
    case movieName = "title"
    }
}

//MARK: Onboardscreen Model
struct OnboardingSlide {
    var title: String
    var description: String
    var image : String
}
