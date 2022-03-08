//
//  MoviesHome.swift
//  MoviesApp
//
//  Created by Adinarayana-M on 8/3/2565 BE.
//

import SwiftUI

struct MoviesHome: View {
    #if os(iOS)
    @EnvironmentObject var orientationInfo: OrientationInfo
    #endif
    var title: String = ""
    
    var navigationItem: NavigationItem
    var viewModel = MoviesListViewModel()
    
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
        return ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(viewModel.allHomeMoviesCategories, id: \.self) { category in
                    if category == homeBanner
                        || category == tvBanner
                        || category == moviesBanner
                        || category == kidsBanner {
                        TopBannerView(selectedCategory: category, navigationItem: navigationItem)
                    } else if category == featureMovies {
                        LazyVStack {
                            displayCategoryView(category: category).padding([.leading,.trailing], 16)
//                            TopBannerView(selectedCategory: category, navigationItem: navigationItem)
                            PlayMovies(selectedCategory: category, navigationItem: navigationItem)
                        }
                    } else {
                        LazyVStack {
                            if isMacOS() {
                                displayCategoryView(category: category)
                                    .onTapGesture {
                                        //                                        self.selectedCategory = category
                                        //                                        self.settings.selectedNavigationItem.append(.home)
                                        //                                        self.settings.navigationItem = NavigationItem.seeMore
                                    }
                            } else {
                                NavigationLink(destination: SeeMoreView(selectedCategory:category)){
                                    displayCategoryView(category: category)
                                }
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(viewModel.getMovie(forCat: category)) { movie in
                                        if isMacOS() {
                                            displayMoviesWithHorizontal(movie: movie)
                                                .onTapGesture {
                                                    //                                                self.selectedMovie = movie
                                                    //                                                self.settings.selectedNavigationItem.append(.home)
                                                    //                                                self.settings.navigationItem = NavigationItem.moviesDetails
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
                            .padding([.leading,.trailing], 16)
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
            : orientationInfo.orientation == .portrait ? (getRect().width-92)/5 : (getRect().height-92)/6
            #endif
        }
        return 0
    }
    
    func getMovieItemWidth() -> CGFloat{
        if isMacOS(){
            return getRect().width/6
        } else {
           #if os(iOS)
            return orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? (getRect().width-92)/2 :  (getRect().height-92)/2
            : orientationInfo.orientation == .portrait ? (getRect().width-102)/3 :  (getRect().height-92)/3.5
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

struct MoviesHome_Previews: PreviewProvider {
    static var previews: some View {
        MoviesHome(navigationItem: .home)
    }
}
