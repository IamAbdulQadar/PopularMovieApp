//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by Abdul Qadar on 20/12/2024.
//

import Foundation

class MoviesListViewModel: NSObject {

    var popularMovies: PopularMovies?
    var movieDetails: MovieDetails?

    override init() {
        super.init()
    }

    var numberOfRows: Int {
        popularMovies?.results?.count ?? 0
    }

    func getResult(ind:Int) -> Movie {
        return popularMovies?.results?[ind] ?? Movie()
    }

    func parseDataIntoModel(movies:[String:Any]) {
        guard let dataModel = CustomJSONParser().convertToModel(type: PopularMovies.self, object: movies) else { return }
        popularMovies = dataModel
    }

    func parseMovieDetailsDataIntoModel(movies:[String:Any]) {
        guard let dataModel = CustomJSONParser().convertToModel(type: MovieDetails.self, object: movies) else { return }
        movieDetails = dataModel
    }

    func fetchPopularMovies(completion: @escaping () -> Void) {
        TmdbAPI.fetchPopularMoviesList() { data in
            if let data = data {
                self.parseDataIntoModel(movies: data)
                completion()
            } else {
                print("Error")
            }
        }
    }

    func fetchMovieDetail(id:Int, completion: @escaping () -> Void) {
        TmdbAPI.fetchMovieDetails(id: id) { data in
            if let data = data {
                self.parseMovieDetailsDataIntoModel(movies: data)
                completion()
            } else {
                print("Error")
            }
        }
    }
}
