//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Abdul Qadar on 20/12/2024.
//

import Foundation

class MovieDetailViewModel: NSObject {

    var movieDetails: MovieDetails?

    override init() {
        super.init()
    }

    var posterImageURL: String {
        return "https://image.tmdb.org/t/p/original/" + (movieDetails?.poster_path ?? "")
    }

    var backdropImageURL: String {
        return "https://image.tmdb.org/t/p/original/" + (movieDetails?.backdrop_path ?? "")
    }

    var title:String {
        return movieDetails?.original_title ?? ""
    }

    var tagline:String {
        return movieDetails?.tagline ?? ""
    }

    var overview: String {
        return movieDetails?.overview ?? ""
    }

    // This function is used to fetch the movie detail in term of its nature
    func getGenres() -> [String] {
        var temp:[String] = []
        if let movieDetails = movieDetails, let genres = movieDetails.genres {
            for genre in genres {
                temp.append(genre.name ?? "")
            }
        }
        return temp
    }

    func getProductionCompanies() -> [String] {
        var temp:[String] = []
        if let movieDetails = movieDetails, let companies = movieDetails.production_companies {
            for company in companies {
                temp.append(company.name ?? "")
            }
        }
        return temp
    }
}
