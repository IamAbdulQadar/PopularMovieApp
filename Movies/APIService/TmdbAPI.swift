//
//  TmdbAPI.swift
//  Movies
//
//  Created by Abdul Qadar on 20/12/2024.
//

import Foundation

class TmdbAPI: NSObject {

    class func fetchPopularMoviesList(completion: @escaping ([String: Any]?) -> Void) {
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4OWU1MWFiYjMzYjg4MDY3YTA0MjFmOWRlNmQ0ZjQzNyIsIm5iZiI6MTYxMzIyNjI1My43MjQsInN1YiI6IjYwMjdlMTBkYzE2MDZhMDA0MDExMzU4YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Wy2p0e100HW1qEWtXus-9C_XRL4VuvZQUttvBTVuDAw"
        ]
//        'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1'
        if let url = URL(string:"https://api.themoviedb.org/3/movie/popular"){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error)
                    completion(nil)
                    return
                }
                if let data = data {
                    do {
                        if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print (dict)
                            completion(dict)
                        } else {
                            print("Error: Could not decode JSON")
                            completion(nil)
                        }
                    } catch let error {
                        print("Error decoding JSON: \(error)")
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }

    class func fetchMovieDetails(id:Int, completion: @escaping ([String: Any]?) -> Void) {
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4OWU1MWFiYjMzYjg4MDY3YTA0MjFmOWRlNmQ0ZjQzNyIsIm5iZiI6MTYxMzIyNjI1My43MjQsInN1YiI6IjYwMjdlMTBkYzE2MDZhMDA0MDExMzU4YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Wy2p0e100HW1qEWtXus-9C_XRL4VuvZQUttvBTVuDAw"
        ]
        //'https://api.themoviedb.org/3/movie/movie_id?language=en-US' \
        if let url = URL(string:"https://api.themoviedb.org/3/movie/\(id)"){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error)
                    completion(nil)
                    return
                }
                if let data = data {
                    do {
                        if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print(dict)
                            completion(dict)
                        } else {
                            print("Error: Could not decode JSON")
                            completion(nil)
                        }
                    } catch let error {
                        print("Error decoding JSON: \(error)")
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }
}
