//
//  Model.swift
//  Movie App
//
//  Created by Muvi on 28/09/22.
//

import Foundation

//MARK: Model for Movie Details
struct Movies : Decodable {
    let movieName : String?
    let movieDetails: String?
    let movieRelaeseYear : String?
    let movieImage : String?
}

//MARK: Section Model
struct sectionData: Decodable {
    var sectionName : String
    var movies : [Movies]
}
