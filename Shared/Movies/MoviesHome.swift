//
//  MoviesHome.swift
//  MoviesApp
//
//  Created by Adinarayana-M on 8/3/2565 BE.
//

import SwiftUI
import AVFoundation

struct MoviesHome: View {
    @EnvironmentObject var settings : NavigationSettings
    #if os(iOS)
    @EnvironmentObject var orientationInfo: OrientationInfo
    #endif
   
    var title: String = ""
    var navigationItem: NavigationItem
    var viewModel = MoviesListViewModel()
    @Binding var selectedMovie: Movie
    @Binding var selectedCategory: String
    
    func getCount() -> Int{
        if isMacOS(){
            return getRect().width > 1500 ? 7 : 5
        } else {
           #if os(iOS)
            print(getRect().width)
            return orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? 2 : 3 : orientationInfo.orientation == .portrait ? 3 : getRect().width > 1000 ? 5 : 4
           #endif
        }
        return 0
    }
    
    var body: some View {
        ZStack {
            ColorTheme.bgColor.color
                .edgesIgnoringSafeArea(.all)
            VStack {
                moviesList(navigationItem: navigationItem).foregroundColor(ColorTheme.bgColor.color)
            }.foregroundColor(ColorTheme.bgColor.color)
                .conditionalNavigationTitle(isMacOS() ? true : false, title: title)
        }
    }
    
    fileprivate func moviesList(navigationItem: NavigationItem) -> some View {
        viewModel.navigationItem = navigationItem
        return ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(viewModel.allHomeMoviesCategories, id: \.self) { category in
                    if category == homeBanner
                        || category == tvBanner
                        || category == moviesBanner
                        || category == kidsBanner {
                        TopBannerView(selectedCategory: category, navigationItem: navigationItem, selectedMovie: $selectedMovie).padding([.leading,.trailing], isMacOS() ? 30 : orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? 16 : 0 : 16)
                    } else if category == featureMovies {
                        LazyVStack {
                            displayCategoryView(category: category)
                                .padding([.leading,.trailing], isMacOS() ? 30 : 16)
                            PlayMovies(selectedCategory: category, navigationItem: navigationItem)
                                .padding([.leading,.trailing], isMacOS() ? 30 : orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? 16 : 0 : 16)
                        }
                    } else {
                        LazyVStack {
                            if isMacOS() {
                                displayCategoryView(category: category)
                                    .onTapGesture {
                                        self.selectedCategory = category
                                        self.settings.selectedNavigationItem.append(NavigationItem.main)
                                        self.settings.navigationItem = NavigationItem.seeMore
                                    }
                            } else {
                                NavigationLink(destination: SeeMoreView(selectedCategory:category, selectedMovie: .constant(Movie()))){
                                    displayCategoryView(category: category)
                                }
                            }
                            
                            ScrollView(.horizontal, showsIndicators: true) {
                                LazyHGrid(rows: Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .center), count: 1), spacing: 10) {
                                    ForEach(viewModel.getMovie(forCat: category), id: \.self) { movie in
                                        if isMacOS() {
                                            displayMoviesWithHorizontal(movie: movie)
                                                .onTapGesture {
                                                    self.selectedMovie = movie
                                                    self.settings.selectedNavigationItem.append(.main)
                                                    self.settings.navigationItem = NavigationItem.moviesDetails
                                                }
                                        } else {
                                            NavigationLink(destination: MovieDetailsView(selectedMovie: movie)){
                                                displayMoviesWithHorizontal(movie: movie)
                                            }
                                        }
                                    }
                                }
                            }
                        }.foregroundColor(ColorTheme.bgColor.color)
                            .padding([.leading,.trailing], isMacOS() ? 30 : orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? 16 : 0 : 16)
                    }
                }
            }.foregroundColor(ColorTheme.bgColor.color)
        }.foregroundColor(ColorTheme.bgColor.color)
    }
    
    func getMovieItemHeight() -> CGFloat{
        if isMacOS(){
            return getRect().width/12
        } else {
            #if os(iOS)
            return orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? (getRect().width-72)/3.5 : (getRect().height-92)/3.5
            : orientationInfo.orientation == .portrait ? (getRect().width-32)/5 : (getRect().height-32)/6
            #endif
        }
        return 0
    }
    
    func getMovieItemWidth() -> CGFloat{
        if isMacOS(){
            return getRect().width/5.8
        } else {
           #if os(iOS)
            return orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? (getRect().width-32)/2 :  (getRect().height-32)/2
            : orientationInfo.orientation == .portrait ? (getRect().width-32)/3 :  (getRect().height-32)/3.5
           #endif
        }
        return 0
    }
    
    @ViewBuilder
    func displayCategoryView(category: String) -> some View {
        HStack {
            Text(category)
                .font(.system(size: isMacOS() ? 20 : 16))
                .fontWeight(.bold)
                .bold().padding(.leading, 10)
            Image(systemName: "chevron.right")
            Spacer()
        }.foregroundColor(.white)
    }
    
    @ViewBuilder
    func displayMoviesWithHorizontal(movie: Movie) -> some View {
        StandardHomeMovie(movie: movie)
            .frame(width: getMovieItemWidth() , height: getMovieItemHeight())
            .cornerRadius(5)
            .padding(.horizontal, 5)
    }
}
