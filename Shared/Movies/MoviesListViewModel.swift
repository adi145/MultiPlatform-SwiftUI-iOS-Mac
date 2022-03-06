//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Adinarayana on 15/02/22.
//

import Foundation
import OrderedCollections


enum TopBannerItems:String {
    case home = "topBannerListHome"
    case tvshows = "topBannerListTvShows"
    case movies = "topBannerListMovies"
    case kids = "topBannerListKids"
    case featuredMovies = "featuredMovies"

}

class MoviesListViewModel:ObservableObject {
   
    @Published var homeMoviesList: OrderedDictionary<String,[Movie]> = OrderedDictionary()
    @Published var tvShowsList: OrderedDictionary<String,[Movie]> = OrderedDictionary()
    @Published var kidsMoviesList: OrderedDictionary<String,[Movie]> = OrderedDictionary()
    @Published var topBannerList: OrderedDictionary<String,[Movie]> = OrderedDictionary()

    var navigationItem : NavigationItem!
    var topBannerSelectedItem : TopBannerItems = .home
    
    public var allHomeMoviesCategories:[String] {
        switch navigationItem {
        case .toolBarHome:
           return homeMoviesList.keys.map({ String($0) })
        case .toolBarTvShows:
           return tvShowsList.keys.map({ String($0) })
        case .toolBarMovies:
           return homeMoviesList.keys.map({ String($0) })
        case .toolBarKids:
           return kidsMoviesList.keys.map({ String($0) })
        default:
           return homeMoviesList.keys.map({ String($0) })
        }
    }
    
    public func getTopbannerList(topBannerItems: TopBannerItems) -> [Movie]{
        switch topBannerItems {
        case .tvshows:
            return homeMoviesList[TopBannerItems.home.rawValue] ?? []
        case .movies:
            return homeMoviesList[TopBannerItems.movies.rawValue] ?? []
        case .kids:
            return homeMoviesList[TopBannerItems.kids.rawValue] ?? []
        case .featuredMovies:
            return homeMoviesList[TopBannerItems.featuredMovies.rawValue] ?? []
        default:
            return homeMoviesList[TopBannerItems.home.rawValue] ?? []
        }
        
    }
   
    public func getMovie(forCat cat: String) -> [Movie] {
        switch navigationItem {
        case .toolBarHome:
            return homeMoviesList[cat] ?? []
        case .toolBarTvShows:
            return tvShowsList[cat] ?? []
        case .toolBarMovies:
            return homeMoviesList[cat] ?? []
        case .toolBarKids:
            return kidsMoviesList[cat] ?? []
        default:
            return homeMoviesList[cat] ?? []
        }
    }

    init() {
        self.setupMoviesHome()
        self.setupMoviesForTVShows()
        self.setupMoviesForKids()
    }

    func setupMoviesHome() {
        homeMoviesList[TopBannerItems.home.rawValue] = exampleMovies.shuffled()
        homeMoviesList[TopBannerItems.tvshows.rawValue] = exampleMovies.shuffled()
        homeMoviesList[TopBannerItems.movies.rawValue] = exampleMovies.shuffled()
        homeMoviesList[TopBannerItems.kids.rawValue] = exampleMovies.shuffled()
        homeMoviesList["Top movies"] = exampleMovies.shuffled()
        homeMoviesList["Continu watching"] = exampleMovies.shuffled()
        homeMoviesList["Recently added movies"] = exampleMovies
        homeMoviesList["Latest movies"] = exampleMovies.shuffled()
        homeMoviesList["Featured movies"] = exampleMovies.shuffled()
        homeMoviesList["Crime movies"] = exampleMovies.shuffled()
        homeMoviesList[TopBannerItems.featuredMovies.rawValue] = exampleMovies.shuffled()
        homeMoviesList["Web series"] = exampleMovies.shuffled()
        homeMoviesList["Bollywood movies"] = exampleMovies.shuffled()
        homeMoviesList["Tollywood movies"] = exampleMovies.shuffled()
        homeMoviesList["Kollywood movies"] = exampleMovies.shuffled()
    }
    
    func setupMoviesForTVShows() {
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
        kidsMoviesList["Watch next kids"] = exampleMovies.shuffled()
        kidsMoviesList["Kids and family movies"] = exampleMovies.shuffled()
        kidsMoviesList["Kids and family TV"] = exampleMovies.shuffled()
        kidsMoviesList["Preschool kids videos"] = exampleMovies.shuffled()
        kidsMoviesList["Amazon original kids series"] = exampleMovies.shuffled()
    }
    
}

struct Movie: Identifiable {
    var id: String?
    var title: String?
    var url: URL?
}

let movies = Movie(id: UUID().uuidString, title: "Mission Impossible", url: URL(string: "https://picsum.photos/200/300")!)
let movies1 = Movie(id: UUID().uuidString, title: "James Bond", url: URL(string: "https://picsum.photos/200/301")!)
let movies2 = Movie(id: UUID().uuidString, title: "Jason Bourne", url: URL(string: "https://picsum.photos/200/302")!)
let movies3 = Movie(id: UUID().uuidString, title: "Taken", url: URL(string: "https://picsum.photos/200/303")!)
let movies4 = Movie(id: UUID().uuidString, title: "Harry porter", url: URL(string: "https://picsum.photos/200/304")!)
let movies5 = Movie(id: UUID().uuidString, title: "Pokiri", url: URL(string: "https://picsum.photos/200/305")!)
let movies6 = Movie(id: UUID().uuidString, title: "Mirror", url: URL(string: "https://picsum.photos/200/306")!)
let movies7 = Movie(id: UUID().uuidString, title:"king's Men", url: URL(string: "https://picsum.photos/200/307")!)
let movies8 = Movie(id: UUID().uuidString, title: "Hunter", url: URL(string: "https://picsum.photos/200/308")!)
let movies9 = Movie(id: UUID().uuidString, title: "Shooter", url: URL(string: "https://picsum.photos/200/309")!)
let movies10 = Movie(id: UUID().uuidString, title: "Shooter", url: URL(string: "https://picsum.photos/200/309")!)
let movies11 = Movie(id: UUID().uuidString, title: "Shooter", url: URL(string: "https://picsum.photos/200/309")!)
let movies12 = Movie(id: UUID().uuidString, title: "Shooter", url: URL(string: "https://picsum.photos/200/309")!)
let movies13 = Movie(id: UUID().uuidString, title: "Shooter", url: URL(string: "https://picsum.photos/200/309")!)
let movies14 = Movie(id: UUID().uuidString, title: "Shooter", url: URL(string: "https://picsum.photos/200/309")!)

let exampleMovies = [movies,movies1,movies2,movies3,movies4,movies5,movies6,movies7,movies8,movies9,movies10,movies11,movies12,movies13,movies14]
