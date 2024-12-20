//
//  APIHandler.swift
//  Movies
//
//  Created by Abdul Qadar on 20/12/2024.
//

import Foundation

class APIHandler: NSObject {

    class func fetchPopularMoviesList(completion: @escaping ([String: Any]?) -> Void) {
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer \(NetworkConstant.shared.access_token)"
        ]

        if let url = URL(string: NetworkConstant.shared.serverAddress + "movie/popular") {
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
          "Authorization": "Bearer \(NetworkConstant.shared.access_token)"
        ]

        if let url = URL(string: NetworkConstant.shared.serverAddress + "movie/\(id)") {
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
