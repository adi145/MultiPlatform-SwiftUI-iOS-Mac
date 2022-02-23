//
//  NavigationSettings.swift
//  MoviesApp
//
//  Created by Adinarayana on 20/02/22.
//

import Foundation

protocol NavigationslectedItem {
    var slectedNavigation:NavigationItem { get}
}
enum NavigationItem: NavigationslectedItem {
    case home
    case search
    case downloads
    case mystuff
    case moviesDetails
    case seeMore
    case find
    case myStuff
    case toolBarHome
    case toolBarTvShows
    case toolBarMovies
    case toolBarKids
    
    var slectedNavigation: NavigationItem {
        return self
    }
    
}

class NavigationSettings: ObservableObject {
    @Published var ishideNavigationBar : Bool = false
    @Published var isNavigateToSignupScreen: Bool = false
    @Published var isNavigateToHomeScreen: Bool = true
//    @Published var isNavigateMovieDetailsScreen: Bool = false
    @Published var showActivityIndicator:Bool = false
    @Published var isNavigateMovieDetailsScreen: Bool = false
    @Published var isNavigateSeeMorePage: Bool = false
    @Published var selectedNavigationItem: NavigationItem = .home
    @Published var navigationItem: NavigationItem = .home
}
