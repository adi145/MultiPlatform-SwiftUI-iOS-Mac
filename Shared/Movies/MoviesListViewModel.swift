//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Adinarayana on 15/02/22.
//

import Foundation
import OrderedCollections

class MoviesListViewModel:ObservableObject {
//    var movie1 : OrderedDictionary<String,[Movie]> = OrderedDictionary()
    @Published var movies: OrderedDictionary<String,[Movie]> = OrderedDictionary()
//    @Published var movies: [String: [Movie]] = [:]

    public var allCategories:[String] {
        movies.keys.map({ String($0) })
    }
    
    public func getMovie(forCat cat: String) -> [Movie] {
        return movies[cat] ?? []
    }
    
    init() {
        setupMovies()
    }
    
    func setupMovies() {
        movies["Top movies"] = exampleMovies.shuffled()
        movies["Continu watching"] = exampleMovies.shuffled()
        movies["Recently added movies"] = exampleMovies
        movies["Latest movies"] = exampleMovies.shuffled()
        movies["Crime movies"] = exampleMovies.shuffled()
        movies["Feature previews"] = exampleMovies.shuffled()
        movies["Web series"] = exampleMovies.shuffled()
        movies["Bollywood movies"] = exampleMovies.shuffled()
        movies["Tollywood movies"] = exampleMovies.shuffled()
        movies["Kollywood movies"] = exampleMovies.shuffled()
    }
    
}

struct Movie: Identifiable {
    var id: String?
    var name: String?
    var url: URL?
}

let movies = Movie(id: UUID().uuidString, name: "Mission Impossible", url: URL(string: "https://picsum.photos/200/300")!)
let movies1 = Movie(id: UUID().uuidString, name: "James Bond", url: URL(string: "https://picsum.photos/200/301")!)
let movies2 = Movie(id: UUID().uuidString, name: "Jason Bourne", url: URL(string: "https://picsum.photos/200/302")!)
let movies3 = Movie(id: UUID().uuidString, name: "Taken", url: URL(string: "https://picsum.photos/200/303")!)
let movies4 = Movie(id: UUID().uuidString, name: "Harry porter", url: URL(string: "https://picsum.photos/200/304")!)
let movies5 = Movie(id: UUID().uuidString, name: "Pokiri", url: URL(string: "https://picsum.photos/200/305")!)
let movies6 = Movie(id: UUID().uuidString, name: "Mirror", url: URL(string: "https://picsum.photos/200/306")!)
let movies7 = Movie(id: UUID().uuidString, name:"king's Men", url: URL(string: "https://picsum.photos/200/307")!)
let movies8 = Movie(id: UUID().uuidString, name: "Hunter", url: URL(string: "https://picsum.photos/200/308")!)
let movies9 = Movie(id: UUID().uuidString, name: "Shooter", url: URL(string: "https://picsum.photos/200/309")!)

let exampleMovies = [movies,movies1,movies2,movies3,movies4,movies5,movies6,movies7,movies8,movies9]
