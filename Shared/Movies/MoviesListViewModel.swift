//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Adinarayana on 15/02/22.
//

import Foundation
import OrderedCollections
//import UIKit
import SwiftUI

let homeBanner = "Home Banner"
let moviesBanner = "Movies Banner"
let tvBanner = "TV Banner"
let kidsBanner = "Kids Banner"
let featureMovies = "Feature Movies"

class MoviesListViewModel:ObservableObject {
    @Published var homeMoviesList: OrderedDictionary<String,[Movie]> = OrderedDictionary()
    @Published var moviesList: OrderedDictionary<String,[Movie]> = OrderedDictionary()
    @Published var tvShowsList: OrderedDictionary<String,[Movie]> = OrderedDictionary()
    @Published var kidsMoviesList: OrderedDictionary<String,[Movie]> = OrderedDictionary()
    @Published var topBannerList: OrderedDictionary<String,[Movie]> = OrderedDictionary()
    @Published var searchMoviesList: OrderedDictionary<String,[Movie]> = OrderedDictionary()
    
    var navigationItem : NavigationItem!
    var allHomeMoviesCategories:[String] {
        switch navigationItem {
        case .home:
            return homeMoviesList.keys.map({ String($0) })
        case .TV:
            print(tvShowsList.keys.map({ String($0) }))
            return tvShowsList.keys.map({ String($0) })
        case .movies:
            return moviesList.keys.map({ String($0) })
        case .kids:
            return kidsMoviesList.keys.map({ String($0) })
        case .find:
            return searchMoviesList.keys.map({ String($0) })
        default:
            return homeMoviesList.keys.map({ String($0) })
        }
    }
    
    public func getMovie(forCat cat: String) -> [Movie] {
        switch navigationItem {
        case .home:
            return homeMoviesList[cat] ?? []
        case .TV:
            return tvShowsList[cat] ?? []
        case .movies:
            return moviesList[cat] ?? []
        case .kids:
            return kidsMoviesList[cat] ?? []
        case .find:
            return searchMoviesList[cat] ?? []
        default:
            return homeMoviesList[cat] ?? []
        }
    }
    
    init() {
        self.setupMoviesHome()
        self.setupMoviesForTVShows()
        self.setupMoviesForKids()
        self.setupSearchMoviesList()
        self.setupMovies()
    }
    
    func setupSearchMoviesList() {
        searchMoviesList["Movies"] = exampleMovies.shuffled()
        searchMoviesList["Webseries"] = exampleMovies.shuffled()
        searchMoviesList["TV"] = exampleMovies.shuffled()
        searchMoviesList["Kids"] = exampleMovies.shuffled()
        searchMoviesList["Drama"] = exampleMovies.shuffled()
        searchMoviesList["Action"] = exampleMovies.shuffled()
        searchMoviesList["Romance"] = exampleMovies
        searchMoviesList["Comdey"] = exampleMovies.shuffled()
        searchMoviesList["Thriller"] = exampleMovies.shuffled()
        searchMoviesList["Horror"] = exampleMovies.shuffled()
    }
    
    func setupMoviesHome() {
        homeMoviesList[homeBanner] = exampleMovies.shuffled()
        homeMoviesList["Top movies"] = exampleMovies.shuffled()
        homeMoviesList["Continu watching"] = exampleMovies.shuffled()
        homeMoviesList["Recently added movies"] = exampleMovies
        homeMoviesList["Latest movies"] = exampleMovies.shuffled()
        homeMoviesList["Crime movies"] = exampleMovies.shuffled()
        homeMoviesList[featureMovies] = exampleMovies.shuffled()
        homeMoviesList["Web series"] = exampleMovies.shuffled()
        homeMoviesList["Bollywood movies"] = exampleMovies.shuffled()
        homeMoviesList["Tollywood movies"] = exampleMovies.shuffled()
        homeMoviesList["Kollywood movies"] = exampleMovies.shuffled()
    }
    
    func setupMovies() {
        moviesList[moviesBanner] = exampleMovies.shuffled()
        moviesList["Top movies"] = exampleMovies.shuffled()
        moviesList["Continu watching"] = exampleMovies.shuffled()
        moviesList["Recently added movies"] = exampleMovies
        moviesList["Latest movies"] = exampleMovies.shuffled()
        moviesList["Crime movies"] = exampleMovies.shuffled()
        moviesList["Web series"] = exampleMovies.shuffled()
        moviesList["Bollywood movies"] = exampleMovies.shuffled()
        moviesList["Tollywood movies"] = exampleMovies.shuffled()
        moviesList["Kollywood movies"] = exampleMovies.shuffled()
    }
    
    func setupMoviesForTVShows() {
        tvShowsList[tvBanner] = exampleMovies.shuffled()
        tvShowsList["Continu watching"] = exampleMovies.shuffled()
        tvShowsList["Amazon Original series"] = exampleMovies.shuffled()
        tvShowsList["Amazon Original Kids series"] = exampleMovies.shuffled()
        tvShowsList["Recently Added TV"] = exampleMovies.shuffled()
        tvShowsList["Latest TV"] = exampleMovies.shuffled()
        tvShowsList["Action And Advanture TV"] = exampleMovies.shuffled()
        tvShowsList["Top TV"] = exampleMovies.shuffled()
        tvShowsList["Thriller TV"] = exampleMovies.shuffled()
        tvShowsList["Comdey TV"] = exampleMovies.shuffled()
        tvShowsList["Drama TV"] = exampleMovies.shuffled()
    }
    
    func setupMoviesForKids() {
        kidsMoviesList["Kids Banner"] = exampleMovies.shuffled()
        kidsMoviesList["Watch next kids"] = exampleMovies.shuffled()
        kidsMoviesList["Kids and family movies"] = exampleMovies.shuffled()
        kidsMoviesList["Kids and family TV"] = exampleMovies.shuffled()
        kidsMoviesList["Preschool kids videos"] = exampleMovies.shuffled()
        kidsMoviesList["Amazon original kids series"] = exampleMovies.shuffled()
    }
    
}

struct Movie: Identifiable, Hashable {
    var id: String?
    var title: String?
    var url: URL?
    var description : String?
}

let movies = Movie(id: UUID().uuidString, title: "Mission Impossible", url: URL(string: "https://picsum.photos/200/300")!, description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
let movies1 = Movie(id: UUID().uuidString, title: "James Bond", url: URL(string: "https://picsum.photos/200/301")!, description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
let movies2 = Movie(id: UUID().uuidString, title: "Jason Bourne", url: URL(string: "https://picsum.photos/200/302")!)
let movies3 = Movie(id: UUID().uuidString, title: "Taken", url: URL(string: "https://picsum.photos/200/303")!, description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
let movies4 = Movie(id: UUID().uuidString, title: "Harry porter", url: URL(string: "https://picsum.photos/200/304")!, description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
let movies5 = Movie(id: UUID().uuidString, title: "Pokiri", url: URL(string: "https://picsum.photos/200/305")!, description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
let movies6 = Movie(id: UUID().uuidString, title: "Mirror", url: URL(string: "https://picsum.photos/200/306")!, description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
let movies7 = Movie(id: UUID().uuidString, title:"king's Men", url: URL(string: "https://picsum.photos/200/307")!, description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
let movies8 = Movie(id: UUID().uuidString, title: "Hunter", url: URL(string: "https://picsum.photos/200/308")!, description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
let movies9 = Movie(id: UUID().uuidString, title: "Shooter", url: URL(string: "https://picsum.photos/200/309")!, description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
let movies10 = Movie(id: UUID().uuidString, title: "Run", url: URL(string: "https://picsum.photos/200/309")!, description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
let movies11 = Movie(id: UUID().uuidString, title: "Snipper", url: URL(string: "https://picsum.photos/200/309")!, description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
let movies12 = Movie(id: UUID().uuidString, title: "Black widow", url: URL(string: "https://picsum.photos/200/309")!, description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
let movies13 = Movie(id: UUID().uuidString, title: "Taken2", url: URL(string: "https://picsum.photos/200/309")!, description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
let movies14 = Movie(id: UUID().uuidString, title: "Top gun", url: URL(string: "https://picsum.photos/200/309")!, description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")

var exampleMovies = [movies,movies1,movies2,movies3,movies4,movies5,movies6,movies7,movies8,movies9,movies10,movies11,movies12,movies13,movies14]
