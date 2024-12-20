//
//  NetworkConstant.swift
//  Movies
//
//  Created by Abdul Qadar on 20/12/2024.
//

import Foundation

class NetworkConstant {

    public static var shared: NetworkConstant = NetworkConstant()

    //Singletone
    private init() {}

    public var apiKey: String {
        get {
            return "89e51abb33b88067a0421f9de6d4f437"
        }
    }

    public var access_token: String {
        get {
            return "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4OWU1MWFiYjMzYjg4MDY3YTA0MjFmOWRlNmQ0ZjQzNyIsIm5iZiI6MTYxMzIyNjI1My43MjQsInN1YiI6IjYwMjdlMTBkYzE2MDZhMDA0MDExMzU4YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Wy2p0e100HW1qEWtXus-9C_XRL4VuvZQUttvBTVuDAw"
        }
    }

    public var serverAddress: String {
        get {
            return "https://api.themoviedb.org/3/"
        }
    }

    public var imageBaseUrl: String {
        get {
            return "https://image.tmdb.org/t/p/original/"
        }
    }
}
